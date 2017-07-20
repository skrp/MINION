#!/usr/local/bin/perl
use strict; use warnings;
use File::Path; use File::Copy;
use Digest::SHA qw(sha256_hex); use File::Find::Rule;
use File::stat; use List::Util qw(any);
use LWP::UserAgent;
######################################################
# DEMON - daemon summoning scroll

# INIT ###############################################
my ($que, $path) = @ARGV;
if (not defined $que) { die ('NO ARGV1 que'); }
if (not defined $path) { die ('NO ARGV2 dir'); }
if (substr($path, -1) ne "/")
	{ $path .= '/'; }

# DIRS ###############################################
# graveyard/ : tombstone()
# g/ : XS()
# pool/ : XS()

# PREP ###############################################
my $base = 'http://archive.org/download';
my $name = name();
chdir('/tmp/');
my $RATE = 100; 
my $count = 0;

my $dump = '/tmp/'."$name"."_dump/";
my $log = "$name"."_log";
my $SLEEP = "$name"."_SLEEP"; 
my $SUICIDE = "$name"."_SUICIDE";

mkdir $dump or die "dump FAIL\n";
open(my $Lfh, '>>', $log);
$Lfh->autoflush(1);
my $born = gmtime();
my $btime = TIME(); 
print $Lfh "HELLOWORLD $btime\n";

# WORK ################################################
open(my $qfh, '<', $que) or die "cant open que\n";
my @QUE = readline $qfh; chomp @QUE;
print "$$ $dump $path\n";

my $ttl = @QUE; 
print $Lfh "ttl $ttl\n"; 

foreach my $i (@QUE)
{
	if (-e $SUICIDE)
    		{ SUICIDE(); }
	if (-e $SLEEP)
    		{ SLEEP(); }
	sleep 5;
	print $Lfh "started $i\n";
	arki($i);
	$count++;
	if ($count % 100 == 0)
	{ 
		print $Lfh "$$ $count : $ttl\n"; 
#		`XS $dump $path` or die "Fail XS";
#		rmtree($dump);
#		mkdir $dump;
	}
}
my $dtime = TIME(); print $Lfh "FKTHEWRLD $dtime\n";
tombstone();
`XS $dump $path`;
# SUB ###########################################################
sub tombstone
{
	my $xxtime = TIME(); print $Lfh "farewell $xxtime\n";
	my $tombstone = $path.'graveyard/'."$name";
	close $Lfh; 
	copy($log, $tombstone);
}
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
sub name
{
	my $id = int(rand(999));
	my $name = $$.'_'.$id;
	return $name;
}
sub uagent
{
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.1",
		from => 'punxnotdead',
		timeout => 45,
	);
	return $s_ua;
}
# API ###########################################################
sub arki
{
	my ($i) = @_;
	sleep 1;
	my $ua = uagent();
	my $url = "$base/$i/$i.pdf";
	my $murl = "$base/$i/$i".'_meta.xml';	
	my $resp = $ua->get($url, ':content_file'=>"$dump/$i.pdf"); 
	my $mresp = $ua->get($murl, ':content_file'=>"$dump/$i".'_meta_xml');
	if (-f "$dump/$i.pdf") 
		{ print $Lfh "YAY $i\n"; }
	else
	{ 
		my $eresp = $ua->get("$base/$i", ':content_file'=>"$dump/tmp");
		my $redo = `grep pdf $dump/tmp | sed 's?</a>.*??' | sed 's/.*>//'`;
		my $rresp = $ua->get("$base/$i/$redo", ':content_file'=>"$dump/$i.pdf");
		if (-f "$dump/$i.pdf") 
			{ print $Lfh "YAY $i\n"; }
		else 
			{ print $Lfh "FAIL $i\n"; }
	}
}
