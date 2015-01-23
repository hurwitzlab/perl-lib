use inc::Module::Install;

name           'Hurwitz-Utils';
abstract       'Perl utilities';
author         'Ken Youens-Clark <kyclark@email.arizona.edu>';
version        '0.01';
license        'GPL';

requires       'List::Util'      => '1.38';
requires       'List::MoreUtils' => '0.33';
requires       'Time::HiRes'     => '1.9725';
requires       'Time::Interval'  => '1.233';
requires       'IO::Prompt';
requires       'Perl6::Slurp';
requires       'Pod::Usage';

test_requires  'Test::Exception' => '0.32';
test_requires  'Test::Exports'   => '1';
test_requires  'Test::More'      => '1.001009';

install_script 'scripts/new-pl';

WriteAll;
