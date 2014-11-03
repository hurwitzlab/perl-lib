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
        chomp(my $line = <$fh>);
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

# ----------------------------------------------------
=pod

=head1 NAME

Hurwitz::Utils - utilities

=head1 SYNOPSIS

  use Hurwitz::Utils qw'commify ...';

=head1 DESCRIPTION

This module contains general-purpose routines, all of which are
exported by default.

=head1 EXPORTED SUBROUTINES

=head2 commify 

Puts a comma every three positions starting from the right.

  print commify('1234567890'; # prints "1,234,567,890"

=head2 take

Takes a given number of lines from a filehandle, e.g., for reading in 
chunks.

  open my $fh, '<', 'file';
  my @chunk1 = take(100, $fh);
  my @chunk2 = take(35, $fh);

=head2 timer_calc

  my $timer = timer_calc();                 # use "now" for start
  my $timer = timer_calc([gettimeofday()]); # set the start time
  my $time  = $timer->();                   # uses "now" for end
  my $time  = $timer->($end);               # pass in an end time

Returns a closure to calculate the interveing time between start and
execution.

=head1 AUTHOR

Ken Youens-Clark E<lt>kyclark@email.arizona.eduE<gt>

=head1 COPYRIGHT

Copyright (c) 2014 Hurwitz Lab

This library is free software;  you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut
