#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon; use POSIX qw(mkfifo);
#####################################
# SUMMON SCROLL
# INIT ##############################
my ($name) = @ARGV; 
# DIR 
my $home = "hive/$name"; 
my $dump = "$home/dump"; my $que = "$home/que";
# FILES
my $BUG = "BUG"; my $LOG = "LOG"; my $mPID = 'PID'; 
# ATTR
my @FACE; my $REP = "REP"; my $RATE = '100';
# FIFO
my $POST = "POST"; 
my $WORD = "WORD";
# SIG-FILE
my $SLEEP  = "SLEEP"; my $SUICIDE = "SUICIDE";
my $DONE = "DONE";
# PREP ################################
mkdir $home or die "home FAIL\n"; 
mkdir $que or die "que FAIL\n";
mkdir $dump or die "dump FAIL\n";
# BIRTH ###############################
my $embryo = Proc::Daemon->new(
  work_dir => $home,
  child_STDOUT => "+>>$LOG",
  child_STDERR => "+>>$BUG",
  pid_file => "$mPID",
);
$embryo->Init() or die "STILLBORN\n";
# INHERIT ############################
my $born = gmtime();
my $btime = TIME(); print "HELLOWORLD $btime\n";
# WORK ###############################
while (1)
{
  my @ls = `ls que`; my $QUE = $ls[0];
  if (not defined $QUE)
    { sleep 3600; next; }
  open(my $qfh, '<', "que/$QUE") or die "cant open que/$QUE\n";
  my @QUE = readline $qfh; chomp @QUE;
  close $qfh; unlink $QUE;
  my $stime = TIME(); print "start $stime\n";
  my $set_name = shift; print "set $set_name\n";
  my $count = @QUE; print "count $count\n"; my $ttl = $count;
  foreach my $i (@QUE)
  {
    if (-e $SUICIDE)
      { SUICIDE(); }
    if (-e $SLEEP)
      { SLEEP(); }
    print "started $i\n";
#####################################
## CODE #############################

#####################################
## CLEAN ############################
    shift @QUE; $count--;
    print "ended $i\n";
# RATE ##############################
    if ($count % $RATE == 0)
    {
      my $current = gmtime();
      # FACE (age, name, rep, status)
      $FACE[0] = $name;
      $FACE[1] = (($current - $born) / 60);
      open(my $Rfh, '<', $REP); $FACE[2] = readline $Rfh;
      $FACE[3] = $set_name . '_' . $count . '/' . $ttl;
    }
  }
  my $dtime = TIME(); print "done $dtime\n";
  open(my $Wfh, '>', $DONE);
}
# SUB ##############################
sub SUICIDE
{
  unlink $SUICIDE;
  my $xtime = TIME(); print "FKTHEWORLD $xtime\n";
  exit;
}
sub SLEEP
{
  open(my $Sfh, '<', $SLEEP);
  my $timeout = readline $Sfh; chomp $timeout;
  my $ztime = TIME(); print "sleep $ztime $timeout\n";
  close $Sfh; unlink $SLEEP;
  sleep $timeout;
}
sub TIME
{
  my $t = localtime;
  my $mon = (split(/\s+/, $t))[1];
  my $day = (split(/\s+/, $t))[2];
  my $hour = (split(/\s+/, $t))[3];
  my $time = $mon.'_'.$day.'_'.$hour;
  return $time;
}
