package Hurwitz::Utils;

use strict;
use List::Util qw( max );
use List::MoreUtils qw( uniq );
use Time::HiRes qw( gettimeofday tv_interval );
use Time::Interval qw( parseInterval );

require Exporter;

use vars qw( @EXPORT @EXPORT_OK );

use base 'Exporter';

my @subs = qw[ commify take timer_calc ];

@EXPORT_OK = @subs;
@EXPORT    = @subs;

# ----------------------------------------------------
sub commify {
    my $number = shift;
    1 while $number =~ s/^(-?\d+)(\d{3})/$1,$2/;
    return $number;
}

# ----------------------------------------------------
sub take {
    my ($n, $fh) = @_;
    my @return;
    for (my $i = 0; $i < $n; $i++) {
        my $line = <$fh>;
        push @return, $line;
    }
    @return;
}

# ----------------------------------------------------
sub timer_calc {
    my $start = shift || [ gettimeofday() ];

    return sub {
        my %args    = ( scalar @_ > 1 ) ? @_ : ( end => shift(@_) );
        my $end     = $args{'end'}    || [ gettimeofday() ];
        my $format  = $args{'format'} || 'pretty';
        my $seconds = tv_interval( $start, $end );

        if ( $format eq 'seconds' ) {
            return $seconds;
        }
        else {
            return $seconds > 60
                ? parseInterval(
                    seconds => int($seconds),
                    Small   => 1,
                )
                : sprintf("%s second%s", $seconds, $seconds == 1 ? '' : 's')
            ;
        }
    }
}

1;
