use inc::Module::Install;

name           'Hurwitz-Utils';
abstract       'Perl utilities';
author         'Ken Youens-Clark <kyclark@email.arizona.edu>';
version        '0.01';
license        'GPL';

requires 'List::Util'      => '';
requires 'List::MoreUtils' => '';
requires 'Time::HiRes'     => '';
requires 'Time::Interval'  => '';

test_requires 'Test::Exception' => '';
test_requires 'Test::Exports'   => '';
test_requires 'Test::More'      => '';

WriteAll;
