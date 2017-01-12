#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
##########################################
# IGOR - minion slavemaster
my @cmds = qw(pause stat errchk dive countoff);
# DAEMONIZE ##############################
$daemon = Proc::Daemon->new(
    work_dir     => '/MINION/IGOR',
    child_STDOUT => 'IGOR_log',
    child_STDERR => '+>>IGOR_debug',
    pid_file     => 'IGOR_pid',
    exec_command => 'perl IGOR.pl',
);
# SUB ####################################
sub pause {
  my ($minion) = @_;
  my ($duration) = @_; # HOURS
  
  my $minion_path = "/MINION/$minion/$minion'_PAUSE'";
  open(my $mfh, '>', $minion_path) or print "cant open $minion_path\n";
  $duration = $duartion*3600;
  print $mfh "$duration";
  close $mfh;
  print "$minion_path successful\n";
}
