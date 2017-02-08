#!/usr/local/bin/perl
use strict; use warnings;
################################
# SHUT - shutdown active minions
#   <*^*>    ---skrp of MKRX
my ($active) = @ARGV;
foreach my $minion (@active) {
  my $file = "$minion/$minion".'_SHUTDOWN';
  open(my $sfh, '>', $file);
  close $sfh;
}
