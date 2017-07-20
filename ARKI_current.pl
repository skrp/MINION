#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
use File::Path; use File::Copy;
use Digest::SHA qw(sha256_hex); use File::Find::Rule;
use File::stat; use List::Util qw(any);
use File::LibMagic; use LWP::UserAgent;
######################################################
# DEMON - daemon summoning scroll

# INIT ###############################################
my ($path) = @ARGV;
if (not defined $path) { die ('NO ARGV1 dir'); }
if (substr($path, -1) ne "/")
	{ $path .= '/'; }

# DIRS ###############################################
# graveyard/ : tombstone()
# g/ : XS()
# pool/ : XS()

# BIRTH ##############################################
my $embryo = Proc::Daemon->new(work_dir => "/tmp/");
my $pid = $embryo->Init() or die "STILLBORN\n";
chdir('/tmp/');

# PREP ###############################################
my $que = $$.'/tmp/que_';
my $base = 'http://archive.org/download';
my $name = name();
my $RATE = 100; 
my $count = 0;

my $dump = '/tmp/'."$name"."_dump/";
my $log = $path.$name;
my $SLEEP = "$name"."_SLEEP"; 
my $SUICIDE = "$name"."_SUICIDE";

mkdir $dump or die "dump FAIL\n";
open(my $Lfh, '>>', $log);
$Lfh->autoflush(1);
print $Lfh "$$\n";

my $fail = $path.'ARKI_FAIL';
open(my $Ffh, '>>', $fail);
$Ffh->autoflush(1);

my $born = gmtime();
my $btime = TIME(); print $Lfh "HELLOWORLD $btime\n";
# WORK ################################################
while (1)
{
	unless (-e $que)
	{
		sleep 3600; next;
	}
	open(my $qfh, '<', $que);
	my @QUE = readline $qfh; chomp @QUE;

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
		}
	}
}
my $dtime = TIME(); print $Lfh "FKTHEWRLD $dtime\n";
# API ###########################################################
sub arki
{
	my ($i) = @_;
	sleep 1;
	my $ua = uagent();
	my $file = "$dump"."$i.pdf";
	my $mfile = "$dump"."$i".'_meta.xml';
	my $url = "$base/$i/$i.pdf";
	my $murl = "$base/$i/$i".'_meta.xml';	
	my $resp = $ua->get($url, ':content_file'=>$file); 
	my $mresp = $ua->get($murl, ':content_file'=>$mfile);
	if (-f $file) 
		{ print $Lfh "YAY $i\n"; }
	else
	{ 
		my $eresp = $ua->get("$base/$i", ':content_file'=>"$dump/tmp");
		my $redo = `grep pdf $dump/tmp | sed 's?</a>.*??' | sed 's/.*>//'`;
		my $rresp = $ua->get("$base/$i/$redo", ':content_file'=>$file);
		if (-f $file) 
			{ print $Lfh "YAY $i\n"; }
		else 
		{ 
			unlink($mfile);
			print $Lfh "FAIL $i\n";  
			print $Ffh "$i\n";
			next;
		}
	}
	XS($file) && unlink($file);
	XS($mfile) && unlink($mfile);
}
# SUB ###########################################################
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
sub XS
{
	my ($file) = shift;
	my ($sha) = file_digest($file) or die "couldn't sha $file";
	File::Copy::copy($file, "$path"."pool/$sha");
	my $cur = "$path"."g/g$sha";
	open(my $fh, '>>', $cur) or die "Meta File Creation FAIL $file";
	printf $fh "%s\n%s\n%s\n%s\n", 
		xsname($file),
		xspath($file),
		xssize($file),
		file_mime_encoding($file);
}
sub file_digest {
	my ($file) = @_;
	my $digester = Digest::SHA->new('sha256');
	$digester->addfile( $file, 'b' );
	return $digester->hexdigest;
}
sub xsname {
	my ($file) = @_;
	$file =~ s?^.*/??;
	return $file;
}
sub xspath {
	my ($file) = @_;
	$file =~ s?/?_?g;
	return $file; 
}
sub file_mime_encoding {
	my ($file) = @_;
	my $magic = File::LibMagic->new();
	my $info = $magic->info_from_filename($file);
	my $des = $info->{description};
	$des =~ s?[/ ]?.?g;
	$des =~ s/,/_/g;
	my $md = $info->{mime_type};
	$md =~ s?[/ ]?.?g;
	my $enc = sprintf("%s %s %s", $des, $md, $info->{encoding}); 
	return $enc;
}
sub xssize {
	my ($file) = @_;
	my $size = -s $file;
	return $size;
}
