package Local::Hackathon::Worker::Links;
use Mojo::DOM;
use Data::Dumper;
use json::xs;

use Mouse::Role;

has '+source',       default => 'links';
has '+destination',  default => 'images';


sub process { 

my %input=take(source);

my $dom = Mojo::DOM->new($input->HTML);

my @t = $dom->find('a')->map(attr => 'href');

$input{'links'}= @t; 
put(destination, \%input);

}

1;
