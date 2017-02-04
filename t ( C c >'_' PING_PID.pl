#!/usr/local/bin/perl
use strict; use warnings;
####################### TOOL #
# PING_PID - test minion state
#  ( C c >'_'  ---skrp of MKRX
# default list minnion | test
# if argv test those only
my $return = ping();
print "$return\n";
# SUB ########################
sub ping {
  my ($minion) = @_;
  my $minon_path = "MINION/$minion/$minion".'_PID';
  open($mfp, '<', $minion_path);
  my $pid = readline $mfp; chomp $pid;
  my @all = system(`ps $pid`);
  my $response = $all[1]; 
  return $response;
}
