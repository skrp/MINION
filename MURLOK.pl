#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use Bot::BasicBot;
###################### SUMMONS #
# MURLOCKS - irc croak & listen 
# (-(-_(-_-)_-)-)      ---skrp of MKRX
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
# START #############################
my $nick = ''; my $server = '';
open(my $tfh, '<', $target) {
my @chan = readline $tfh; chomp @chan; 
close $tfh; unlink $target;
foreach my $chan (@chan) { 
    my $bot = Bot::BasicBot->new(
        server => "irc.$server.com",
        port   => "6667",
        channels => ['#'.$chan],
        nick      => $nick,
        alt_nicks => ["$nick_", "_$nick_"],
        username  => $nick,
        name      => $nick,
  );
  $bot->run();
}
while (1) { 
    sleep $listen; croak();     
    $ch_path = murlokonian_name();
    foreach 
        close $chfh; open(my $chfh, '>>', $ch_path);  
}
# SUB #################################
sub join_ch {
    my $ch = shift;
    my $m_n = murlokonian_name();
    open(my $chfh, '>>', $ch_path);
   # CONNECT
   # print $chfh "$ts $user $msg\n";
}
sub croak {

}
sub mulokonian_name {
    my ($sec,$min,$hour,$mday) = localtime(time);
    my $m_n = $sec.$min.$hour.$mday; # murlokonian_name
    $m_n =~ $dump.'/'.$chan.'_'.$m_n;
    return $m_n;
}
