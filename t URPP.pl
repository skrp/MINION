#!/usr/local/bin/perl
use strict; use warnings;
use MINION;
use Term::ANSIColor;
####################
# URPP - print init
#
my (@active) = @ARGV;
foreach $minion (@active) {
  my $minpath = "$minion/$minion".'_INIT';
  my @list = readdir($minpath);
  foreach (@list) { 
    print color('magenta');
    print "$minion "; 
    print color('bold yellow');
    print "$_\n"; }
}
