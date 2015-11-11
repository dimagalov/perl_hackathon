#!/usr/bin/env perl

use strict;
use XML::Atom::Stream ();
use DDP;
use Data::Dumper;
use POSIX 'strftime';
use Getopt::Long;

use Local::Hackathon::Client;



my $client = XML::Atom::Stream->new(
	callback  => \&callback,
	reconnect => 1,
	# debug     => 1,
	timeout   => 30,
);

my $host = 'localhost';
my $port = 3456;

GetOptions("host=s" => \$host,
			"port=i" => \$port);

my $promoter_client = Local::Hackathon::Client->new(
	host => $host,
	port => $port
);


$client->connect('http://atom.services.livejournal.com/atom-stream.xml');

sub callback {
	my %h;
	my ($atom) = @_;
	eval {
		for my $ent ($atom->entries) {
			printf "%s %s # %s\n",strftime("%Y-%m-%dT%H:%M:%S",localtime()), $ent->link->href, $ent->title;
			$h{URL} = $ent->link->href;
			$promoter_client->put('fetch',\%h);
		}
	1} or do {
		warn "$@";
	};
}

