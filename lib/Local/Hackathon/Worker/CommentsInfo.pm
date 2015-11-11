package Local::Hackathon::Worker::Commentsinfo;
 
use strict;
use Mouse::Role;
use Mojo::DOM;
use DDP;

has '+source', is => 'rw', default => 'commentsinfo';
has '+destination', is => 'rw', default => 'title';

sub process {
        my $self = shift;
        my $task = shift;
        my $data = $task->{HTML};
         
         
        my $dom = Mojo::DOM->new($data);
        my $my_span = $dom->find('span');
        my $comments_count = 0;
         
        for (@$my_span) {
                my $text = $_->text;
                if ($text =~ m/(\d*) comments|(\d*) комментариев/gs) {
                        $comments_count = "$1$2 комментариев";
                        last;
                }
         
        }
         
        unless ($comments_count) {
                my $my_span = $dom->find('li');
                for (@$my_span) {
                        my $text = $_->text;
                        if ($text =~ m/(\d*) comments|(\d*) комментариев/gs) {
                                $comments_count = "$1 $2 комментариев";
                                last;
                        }
                }
        }
         
        #p $comments_count;
        $task->{comments_info}->{count} = "$comments_count";
         
         
        my $i=0;
        my @j;
        $my_span = $dom->find('a');
        for (@$my_span) {
                my $text = $_->attr('href');
                if ( $text && $text =~ m/page=(\d+)/gs ) {
                        $j[$i] = $1;   
                        $i++;
                }
               
        }
         
        my $max = 0;
         
        for (@j) {
                if ($_>$max) {$max = $_}
        }
         
        #p $max;
        $task->{comments_info}->{max} = "$max";
        return $task;
}

1;
