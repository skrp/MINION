#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use File::Find::Rule;
################ SUMMONS #
# IGOR - minion taskmaster
#   ($.$)  ---skrp of MKRX
# start - stop - pause - ping_pid
my @cmds = qw(pause stat errchk dive countoff);
# SETUP ###############################
my $work = 'MINION/';
my $limbo = 'limbo'; my $dump = 'dump';
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
# SUB ####################
sub ping_pid { 
  my $target = '/MINION/';
  my @workn;
  my @minions = File::Find::Rule->new
    ->directory($target)
    ->in($root)
    ->maxdepth(1)
  foreach $minion (@minions) {
    if (-e $target$minion/$minion'_DOWN') 
        { next; }
    else 
        { push @workn $minion; }
  return @workn;
}
sub pause {
  my ($minion) = @_;
  my ($duration) = @_; # HOURS
  
  my $minion_path = "/MINION/$minion/$minion'_PAUSE'";
  open(my $mfh, '>', $minion_path) or print "cant open $minion_path\n";
  $duration = $duartion*3600;
  print $mfh "$duration";
  close $mfh;
  print "$minion_path PAUSED\n";
}
sub shutdwn {
  my ($minion) = @_;
  my $minion_path = "/MINION/$minion/$minion'_SHUTDOWN'";
  open(my $mfh, '>', $minion_path) or print "cant open $minion_path\n";
  close $mfh;
  print "$minion_path SHUTDOWN\n";
}
sub dive {
  my ($m_target) = @_;
  my $target = "/MINION/$m_target/$m_target'_pool'";
  my $count = 0;
  my $rule = File::Find::Rule->file()->start($target);
  while (defined(my $file = $rule->match)) 
    { $count++; }
  return $count;
}
# if (ps $pid > 0) {  foreach (@log_line) { print "$_\n"; } }
# main addr string in green. iteration in yellow. err in red.
# MINION_MASTER
