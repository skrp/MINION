#!/usr/local/bin/perl
use strict; use warnings;
##############################
# PING_PID - test minion state
#  ( C c >'_'  ---skrp of MKRX
# default list minnion | test
# if argv test those only
my $return = ping();
# SUB ########################
sub ping {
  my ($minion) = @_;
  my $minon_path = "MINION/$minion/$minion".'_PID';
  open($mfp, '<', $minion_path);
  my $pid = readline $mfp; chomp $pid;
  my $response = system(`ps $pid`);
  return $response;
}
