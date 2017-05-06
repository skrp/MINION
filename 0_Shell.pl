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
my $RATE = '100';
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
my $btime = TIME(); print "HELLOWORLD $btime\n";
# LIVE ###############################
while (1)
{
  unless (-e $QUE)
    { sleep 3600; }
  open($qfh, '<', $QUE);
  my @QUE = readline $qfh; chomp @QUE;
  close $qfh; unlink $QUE;
  my $stime = TIME(); print "start $stime\n";
  my $variable = shift; print "variable $variable\n";
  my $count = @QUE; print "count $count\n";
  foreach my $i (@QUE)
  {
    if (-e $SUICIDE)
      { unlink $SUICIDE; my $xtime = TIME(); print "FKTHEWORLD $xtime\n"; exit; }
    if (-e $SLEEP)
      { my $ztime = TIME(); print "sleep $ztime\n"; SLEEP(); }
    print "started $i\n";
#######################################################################
## CODE #############################

#######################################################################
## CLEAN ############################
    shift @QUE; $count--;
    print "ended $i\n"; print "count $count\n";
    if ($count % $RATE == 0)
    {
# RATE ##############################
      POST(); WORD();
    }
  }
  my $dtime = TIME(); print "done $dtime\n";
  open($Wfh, '>', $DONE);
  POST();
  WORD();
}
# SUB ##############################
sub SLEEP()
{
  open(my $Sfh, '<', $SLEEP);
  my $timeout = readline $pfh; chomp $timeout;
  print "timeout $timeout\n"; sleep $timeout;
  close $Sfh; unlink $SLEEP;
}
sub TIME(){
  my $t = localtime;
  my $m = split(/\s+/, $t)[1]; my $d = split(/\s+/, $t)[2];
  my $H = split(/\s+/, $t)[3]; my $h = split(/\:/, $H)[0];
  my $time = $m . '_' . $d . '_' . $h;
  return $time;
}
sub POST()
{
  
}
sub WORD()
{
  if ($a_q == '1')
    { append_que(); }
  if ($s_q == '1')
    { open($Sfh, '>', $SLEEP); print "$Sfh" "$cmd{s_q}"); }  # hash{$cmd} = $value
}
sub append_que()
{
  my @newQUE = shift;
  foreach (@newQUE)
    { push @QUE, $_; }
}
