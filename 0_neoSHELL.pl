#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon; use POSIX qw(mkfifo);
#####################################
# SUMMON SCROLL
# INIT ##############################
# ATTR
my @FACE; my $REP = "REP"; my $RATE = '100';
# BIRTH ###############################
my $embryo = Proc::Daemon->new(
  work_dir => "/tmp/",
);
my $pid = $embryo->Init() or die "STILLBORN\n";
# LOCATION
my $name = "/tmp/$pid";
my $dump = "$name"."_dump";
my $que = "$name"."_que";
my $code = "$name"."_code";
my $tar = "$name"."_tar";
my $log = "$name"."_log"
my $rep = "$name"."_rep";
my $sleep = "$name"."_SLEEP";
my $suicide = "$name". "_SUICIDE";
my $wfifo = "/tmp/HOST";
mkdir $dump or die "dump FAIL\n";
open(my $Lfh, '>>', $log);
# INHERIT ############################
my $born = gmtime();
my $btime = TIME(); print $Lfh "HELLOWORLD $btime\n";
# WORK ###############################
while (1)
{
  open(my $qfh, '<', $que) or die "cant open que\n";
  my @QUE = readline $qfh; chomp @QUE;
  close $qfh; unlink $QUE;
  my $stime = TIME(); print $Lfh "start $stime\n";
  my $set_name = shift; print $Lfh "set $set_name\n";
  my $count = @QUE; print $Lfh "count $count\n"; my $ttl = $count;
  foreach my $i (@QUE)
  {
    if (-e $SUICIDE)
      { SUICIDE(); }
    if (-e $SLEEP)
      { SLEEP(); }
    print $Lfh "started $i\n";
#####################################
## CODE #############################
    `SB $i /otto/sea`; # MKRX STANDARD BLOCK
#####################################
## CLEAN ############################
    shift @QUE; $count--;
    print $Lfh "ended $i\n";
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
  my $dtime = TIME(); print $Lfh "done $dtime\n";
  `ls $dump > $rep`;
  `XS $dump /otto/pool`;
  `tar -cf $tar $name`;
  my $xxtime = TIME(); print $Lfh "farewell $xxtime\n";
}
# SUB ##############################
sub SUICIDE
{
  unlink $SUICIDE;
  my $xtime = TIME(); print $Lfh "FKTHEWORLD $xtime\n";
  exit;
}
sub SLEEP
{
  open(my $Sfh, '<', $SLEEP);
  my $timeout = readline $Sfh; chomp $timeout;
  my $ztime = TIME(); print $Lfh "sleep $ztime $timeout\n";
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
