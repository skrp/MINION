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
}
