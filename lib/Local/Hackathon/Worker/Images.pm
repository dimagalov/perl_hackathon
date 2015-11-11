package Local::Hackathon::Worker::Images;
use Mojo::DOM;
use Data::Dumper;

use Mouse::Role;
use DDP;
has '+source',       default => 'images';
has '+destination',  default => 'comments';

sub process {
	my ($self, $task)=@_;
	my $dom = Mojo::DOM->new($task->{'HTML'});
	my @t;
	$dom->find('img')->map(attr => 'src')->each(sub {
		push @t,$_[0] if length $_[0];
	});
	$task->{'images'}= \@t;
	return $task;
}

1;
