package Local::Hackathon::Worker::Links;
use Mojo::DOM;
use Data::Dumper;

use Mouse::Role;

has '+source',       default => 'links';
has '+destination',  default => 'images';


sub process { 

my ($self, $task)=@_;

my $dom = Mojo::DOM->new($task->{'HTML'});

my @t = $dom->find('a')->map(attr => 'href');

$task->{'links'}= @t; 
return $task;
}

1;
