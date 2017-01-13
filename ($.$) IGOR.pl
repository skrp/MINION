#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use File::Find::Rule;
##########################
# IGOR - minion taskmaster
#   ($.$)  ---skrp of MKRX
my @cmds = qw(pause stat errchk dive countoff);
# DAEMONIZE ##############
$daemon = Proc::Daemon->new(
    work_dir     => '/MINION/IGOR',
    child_STDOUT => 'IGOR_log',
    child_STDERR => '+>>IGOR_debug',
    pid_file     => 'IGOR_pid',
    exec_command => 'perl IGOR.pl',
);
# SUB ####################
sub countoff {
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
  print "$minion_path successful\n";
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
