#!/usr/local/bin/perl
use strict; use warnings;
use MINION;
############################
# PET - pause active minions
#   <*^*>    ---skrp of MKRX
my ($timeout) = @ARGV;
my @active = PING_PID();
foreach my $minion (@active) {
  my $file = "$minion/$minion".'_PAUSE';
  open(my $pfh, '>', $file);
  print $pfh "$timeout\n";
  close $pfh;
}
