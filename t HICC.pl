#!/usr/local/bin/perl
use strict; use warnings;
use Term::ANSIColor;
#####################
# HICC - print STDERR
my (@active) = @ARGV;
foreach $minion (@active) {
  my $file = "$minion/$minion".'_DEBUG';
  open(my $dfh, '<', $file);
  my @contents = readline $dfh; chomp @contents; close $dfh;
  foreach (@contents)
    { print color('magenta'); print "$minion "; print color('bold yellow'); print "$_\n"; }
}
