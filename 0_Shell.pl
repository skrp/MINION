#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use IO::Socket;
###############
# SUMMON SCROLL
###############
# NAME - purpose
# EMBRYO ##############################
my $name = ''; my $DONE = 'DONE';
my $FACE = 'FACE'; open($Ffh, '>', $FACE) or die "FACE FAIL\n"
my $home = '/home/hive/$name'; my $HOLE = 'HOLE';
my $BUG = 'BUG'; my $LOG = 'LOG';
my $PID = 'PID'; my $QUE = 'QUE';
my $POST = 'POST'; my $WORD = 'WORD';
my $SLEEP  = 'SLEEP'; my $SUICIDE = 'SUICIDE';
mkdir $home or die "HOME FAIL\n";
# BIRTH ###############################
my $embryo = Proc::Daemon->new(
  work_dir => $home,
  child_STDOUT = "+>>$LOG",
  child_STDERR = "+>>$BUG",
  child_STDIN = $HOLE,
  pid_file = $PID
);
$embryo->Init() or die "STILLBORN\n";
# INHERIT ############################

my $t = localtime; my $bday = 
# LIVE ###############################
while (1)
{
  if (-e $SUICIDE)
    { unlink $SUICIDE; print "FKTHEWORLD\n"; exit; }
  if (-e $SLEEP)
    { SLEEP(); }
  if (-ne $QUE)
    { sleep 3600; }
  open($qfh, '<', $QUE);
  my @QUE = readline $qfh; chomp @QUE;
  close $qfh; unlink $QUE;
  my $variable = shift; print "variable $variable\n";
  my $count = @QUE; print "count $count\n";
  foreach my $i (@QUE)
  {
    print "started $i\n";
 # CODE #############################
 # CLEAN ############################
    shift @QUE; $count--;
    print "ended $i\n"; print "count $count\n";
  }
  open($Wfh, '>', $DONE);
}
# SUB ##############################
sub SLEEP()
{
  open(my $Sfh, '<', $SLEEP);
  my $timeout = readline $pfh; chomp $timeout;
  print "timeout $timeout\n"; sleep $timeout;
  close $Sfh; unlink $SLEEP;
}
sub time(){
  my $t = localtime; 
  my $m = split(/\s+/, $t)[1]; my $d = split(/\s+/, $t)[2]; 
  my $H = split(/\s+/, $t)[3]; my $h = split(/\:/, $H)[0];
  my $time = $m . '_' . $d . '_' . $h;
  return $time;
}
