#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use FindBin '$Bin';
use File::Spec::Functions 'catfile';
use Test::Exports;
use Test::Exception;
use Test::More tests => 12;

my @subs = qw(timer_calc take);

my $class = 'Hurwitz::Utils';

require_ok $class or BAIL_OUT "Can't load module";

import_ok $class, \@subs, 'Default import';

is_import @subs, $class, 'Imported subs';

use_ok $class;

#
# commify
#
is( commify('1234567890'), '1,234,567,890', 'commify OK' );

#
# timer_calc
#

my $t0 = timer_calc( [1350330619, 481395] );
my $r0 = $t0->( [1350330619, 481395] );
is(
    $r0,
    '0 seconds',
    "timer_calc: $r0"
);

my $t1 = timer_calc( [1350330619, 481395] );
my $r1 = $t1->( [1350330620, 481395] );
is(
    $r1,
    '1 second',
    "timer_calc: $r1"
);

my $t2 = timer_calc( [1350330619, 481395] );
my $r2 = $t2->( [1350330621, 481395] );
is(
    $r2,
    '2 seconds',
    "timer_calc: $r2"
);

my $t3 = timer_calc( [1350330619, 481395] );
my $r3 = $t3->( [1350390621, 481395] );
is(
    $r3,
    '16h 40m 2s',
    "timer_calc: $r3"
);

#
# take
#
open my $fh, '<', catfile($Bin, qw[data words]);
is(
    join(', ', take(5, $fh)),
    join(', ', qw[A a aa aal aalii]),
    'take 5 OK'
);

is(
    join(':', take(3, $fh)),
    join(':', qw[aam Aani aardvark]),
    'take 3 OK'
);

open my $single, '<', catfile($Bin, qw[data single]);
is(
    join('', take(2, $single)),
    'this is just one line',
    'take too many OK',
);
