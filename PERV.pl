#!/usr/local/bin/perl
use strict; use warnings;
################################
# PERV - scan & extract archives
#    (0)!(0)     ---skrp of MKRX
# SETUP ###############################
my $work = 'MINION/' my $dump = 'dump';
my $state = 'STATE'; my $debug = 'DEBUG';
my $log = 'LOG'; my $pid = 'PID';
my $que = 'QUE'; my $clean = 'CLEAN'
my $pause = 'PAUSE'; my $shutdown = 'SHUT';
# DAEMONIZE ##########################
my $daemon = Proc::Daemon->new(
    work_dir     => $work,
    child_STDOUT => $log,
    child_STDERR => +>>$debug,
    pid_file     => $pid,
);
$daemon->Init();
