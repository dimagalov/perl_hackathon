package Local::Hackathon::Worker::Links;
use Mojo::DOM;
use Data::Dumper;
use json::xs;

use Mouse::Role;

has '+source',       default => 'images';
has '+destination',  default => 'comments';


sub process {

	my %input=take(source);

	my $dom = Mojo::DOM->new($input->HTML);

	my @t = $dom->find('img')->map(attr => 'src');

	$input{'images'}= @t; 

	put(destination, \%input);

}

1;
