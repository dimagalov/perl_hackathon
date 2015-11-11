package Local::Hackathon::Worker::Links;
use Mojo::DOM;
use Data::Dumper;

use Mouse::Role;

has '+source',       default => 'images';
has '+destination',  default => 'comments';


sub process {


my ($self, $task)=@_;

my $dom = Mojo::DOM->new($task->{'HTML'});

my @t = $dom->find('img')->map(attr => 'src');

$task->{'images'}= @t; 
return $task;
}

1;
