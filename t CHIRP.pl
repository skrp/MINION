#!/usr/local/bin/perl
use strict; use warnings;
use Term::ANSIColor;
######################
# CHIRP - print STDOUT
my (@active) = @ARGV;
foreach $minion (@active) {
  my $file = "$minion/$minion".'_LOG';
  open(my $lfh, '<', $file);
  my @contents = readline $lfh; chomp @contents; close $lfh;
  foreach (@contents)
    { print color('magenta'); print "$minion "; print color('bold yellow'); print "$_\n"; }
}
