#!/usr/local/bin/perl
use strict; use warnings;
use Term::ANSIColor;
##################
# KICK - print pid
my (@active) = @ARGV;
foreach $minion (@active) {
  my $file = "$minion/$minion".'_PID';
  open(my $pfh, '<', $file);
  my $content = readline $pfh; chomp $content; close $pfh;
  print color('magenta'); print "$minion "; print color('bold yellow'); print "$_\n";
}
