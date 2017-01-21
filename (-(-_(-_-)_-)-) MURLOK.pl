#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
#######################################
# MURLOCKS - irc croak & listen 
# (-(-_(-_-)_-)-)      ---skrp of MKRX
# SETUP ###############################
my $target = 'MURLOCK_QUE'; my $dump = 'MURLOCK_dump';
my $pool = 'MURLOCK_pool'; my $g = 'MURLOCK_g';
my $init = 'MURLOCK_INIT'; my $shutdown = 'MURLOCK_SHUTDOWN';
# DAEMONIZE ##########################
my $daemon = Proc::Daemon->new(
    work_dir     => 'MINION/MURLOCK',
    child_STDOUT => 'MURLOCK_LOG',
    child_STDERR => '+>>MURLOCK_DEBUG',
    pid_file     => 'MURLOCK_PID',
);
$daemon->Init();
# START #############################
open(my $tfh, '<', $target) {
my @chan = readline $tfh; chomp @chan; 
close $tfh; unlink $target;
foreach $chan (@chan) 
  { join_ch($chan); }
 while (1)
  { sleep $listen; croak(); }
# SUB #################################
sub join_ch {
    my $ch = shift;
    my ($sec,$min,$hour,$mday) = localtime(time);
    my $m_n = $sec.$min.$hour.$mday; # murlokonian_name
    my $cg_path = $dump.'/'.$ch.'_'.$m_n;
    open(my $chfh, '>>', $ch_path);
   # CONNECT
   # print $chfh,
}
sub croak {

}
