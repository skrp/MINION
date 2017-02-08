#!/usr/local/bin/perl
use strict; use warnings;
use MINION;
use Term::ANSIColor;
########################
# BURP - print dump size
#
my (@active) = @ARGV;
foreach $minion (@active) {
  my $minpath = "$minion/$minion".'_dump';
  my @list = readdir($minpath);
  foreach (@list) { 
    print color('magenta');
    print "$minion "; 
    print color('bold yellow');
    print "$_\n"; }
}
