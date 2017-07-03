#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon; use LWP::UserAgent;
use File::Path; use Archive::Any ();
use Digest::SHA (); use File::Copy;
use File::LibMagic; use File::Find::Rule;
use Archive::Tar;
######################################################
# DEMON - daemon summoning scroll
# INIT ###############################################
my ($que) = @ARGV;
# BIRTH ##############################################
my $embryo = Proc::Daemon->new(work_dir => "/tmp/");
my $pid = $embryo->Init() or die "STILLBORN\n";
my $born = gmtime();
my $btime = TIME(); print $Lfh "HELLOWORLD $btime\n";
# PREP ###############################################
my $name = name($pid);
my $dump = "$name"."_dump";
my $code = "$name"."_code";
my $tar = "$name"."_tar";
my $log = "$name"."_log";
my $SLEEP = "$name"."_SLEEP";
my $SUICIDE = "$name"."_SUICIDE";
my $wfifo = "/tmp/HOST";
my $RATE = '100';
mkdir $dump or die "dump FAIL\n";
open(my $Lfh, '>>', $log);
# WORK ################################################
while (1)
{
	open(my $qfh, '<', $que) or die "cant open que\n";
	my @QUE = readline $qfh; chomp @QUE;
	close $qfh;
	my $stime = TIME(); print $Lfh "start $stime\n";
	my $api = shift @QUE; print $Lfh "set $set_name\n";
	my @apis = { "sha", "blkr", "xtrac", "get" };
	die "bad api $api" unless grep(/$api/, @apis);
	my $count = @QUE; print $Lfh "count $count\n"; my $ttl = $count;
	foreach my $i (@QUE)
	{
		if (-e $SUICIDE)
    			{ SUICIDE($Lfh); }
      		if (-e $SLEEP)
    			{ SLEEP($Lfh); }
     		print $Lfh "started $i\n";
		switch ($api)
		{
			case "sha" { sha($i) }
			case "blkr" { blkr($i, $path) }
			case "slicr" { slicr($i, $path) }
			case "xtrac" { xtrac($i, $path) }
			case "vkey" { vkey($i, $path) }
			case "regx" { regx($i, $path) }
			case "get" { eval{ get($i) } }
	}
## CLEAN #############################################
	shift @QUE; $count--;
	# print $Lfh "ended $i\n"; #### DEBUG
# RATE ###############################################
	if ($count % $RATE == 0)
		{ face($wfifo); }
	}
	my $dtime = TIME(); print $Lfh "done $dtime\n";
	dumpr($name, $dump);
	tombstone($name, $Lfh, $log, $code, $rep);
}
# API ##################################################
sub sha
{
	my $i = shift;
	my ($sha) = file_digest($i);
	if ($sha ne $i)
		{ print $Lfh "ERK! $file ne $sha\n"; }
	print $Lfh "YAY $i\n";
}
sub blkr
{
	my ($i, $path) = shift;
	my $size = 10000;
	my $st = stat($i);
	my $total = $st->size;
	my $count = $total / $size;
	open(my $ifh, '<', "$i") || die "Cant open $i: $!\n";
	binmode($ifh);
	my $block = 0;
	while (read ($ifh, $block, $size) <= $count)
	{
		my $fh = new_block($path, $block);
		print $fh $block;
		close $fh;
		$count += $size; 
	}
	print $Lfh "YAY $i\n";
}
sub slicr
{
	my ($i, $path) = shift;
	my $st = stat($i);
	my $total = $st->size;
	open(my $ifh, '<', "$i") || die "Cant open $i: $!\n";
	binmode($ifh);
	my $sha = file_digest($i);
	my $block = 0; my $position = 0;
	while ($position < $total)
	{
		my $size = int(rand(99999));
		if ($position + $size >= $total)
			{ $size = $total - $position; }
		read($ifh, $block, $size);
		my $fh = new_block($i, $sha, $path, $block);
		print $fh $block;
		close $fh;
		$count += $size; 
	}
	print $Lfh "YAY $i\n";
}
sub xtrac
{
	my ($i, $path) = shift;
	my $archive = Archive::Tar->new($i);
	if ($archive->is_naughty)
		{ print $Lfh "ALERT xtrac naughty $i"; next; }
	my @files = $archive->files; print $Lfh @files;
	$archive->extract($dump);
	XS($dump, $path);
	print $Lfh "YAY $i\n";
}
sub get
{
	my $i = shift;
	my $ua = uagent();
	my $response = $ua->get($i, ':content_file'=>"$dump/$i");
	print $Lfh "YAY $i\n";
}
sub vkey
{
	my ($i, $path) = shift;
	my $ipath = $path.$i;
	my $tmp = "$dump/tmp"; unlink $tmp;
	open($ifh, '<', $ipath);
	open($tfh, '>>', $tmp);
	my @keys = readline $ifh; chomp @keys;
	my $data = 0;
	foreach my $key (@keys)
	{
		open(my $bfh, '<', "$path/sea/$key");
		read($bfh, $data);
		print $tfh $data;
	}
	my $tsha = file_digest($tmp);
	if ($tsha ne $i)
		{ print "FKFK $i ne $tsha\n"; }
}
sub regx
{ # 2 files $i = list $path = master
	my ($i, $path) = shift;
	open(my $fh, '<', $i); open(my $mfh, '<', $path);
	my @i = readline $fh; chomp @i;
	my @master = readline $mfh; chomp @master;
	foreach (@i)
		{ print $Lfh "no $_\n" unless /$_/ @master; }
}
# SUB ####################################
sub dumpr
{
	my $name = shift; my $dump = shift;
	my $rep = "$name"."_rep";
	XS($dump, /);
	my @files = File::Find::Rule->file->in($dump);
	open($rfp, '>', $rep);
	print $rfp @files;
	remove_tree($dump);
}
sub tombstone
{
	my ($name, $Lfh, $log, $api, $rep) = shift;
	my $xxtime = TIME(); print $Lfh "farewell $xxtime\n";
	close $Lfh;
	my $tombstone = "/tombstone/$name."."tar";
	my $tar = Archive::Tar->new($tombstone);
	$tar->add_files($log, $code, $rep);
}
sub SUICIDE
{
	my $Lfh = shift;
	unlink $SUICIDE;
	my $xtime = TIME(); print $Lfh "FKTHEWORLD $xtime\n";
	exit;
}
sub SLEEP
{
	my $Lfh = shift;
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
	my ($pid) = shift;
	my @set = ("A".."Z", "a".."z", "1".."9");
	my $id = $chars[rand @chars] for 1..8;
	my $name = $name.$id;
	return $name;
}
sub face
{ # FACE (age, name, rep, status)
	my @FACE; 
	my $wfifo = shift;
	my $current = gmtime();
	$FACE[0] = $name;
	$FACE[1] = (($current - $born) / 60);
	$FACE[3] = $set_name . '_' . $count . '/' . $ttl;
	print $wfifo "@FACE";
}
sub XS
{
	my ($target, $dump) = shift;
	if (not defined $target) { die "usage: TARGET ARGV[0] & dump argv[1]"; }
	if (not defined $dump) { die "usage: target argv[0] & DUMP ARGV[1]"; }
	my $rule = File::Find::Rule->file()->start($target);
	my $magic = File::LibMagic->new();
	while (defined( my $file = $rule->match))
	{
		my ($sha) = file_digest($file) or die "couldn't sha $file";
		File::Copy::copy($file, "$dump/pool/$sha");
		my $cur = "$dump/g/g$sha";
		open(my $fh, '>>', $cur) or die "Meta File Creation FAIL $file";
		printf $fh "%s\n%s\n%s\n%s\n", 
			xsname($file),
			xspath($file),
			xssize($file),
			file_mime_encoding($file);
	}
}
sub file_digest {
	my ($filename) = @_;
	my $digester = Digest::SHA->new('sha256');
	$digester->addfile( $filename, 'b' );
	return $digester->hexdigest;
}
sub xsname {
	my ($filename) = @_;
	$filename =~ s#^.*/##;
	return $filename;
}
sub xspath {
	my ($filename) = @_;
	$filename =~ s#/#_#g;
	return $filename; 
}
sub file_mime_encoding {
	my ($filename) = @_;
	my $info = $magic->info_from_filename($filename);
	my $des = $info->{description};
	$des =~ s#[/ ]#.#g;
	$des =~ s/,/_/g;
	my $md = $info->{mime_type};
	$md =~ s#[/ ]#.#g;
	my $enc = sprintf("%s %s %s", $des, $md, $info->{encoding}); 
	return $enc;
}
sub xssize {
	my $size = [ stat $_[0] ]->[7];
	return $size;
}
sub new_block
{
	my ($i, $sha, $path, $block) = shift;
	my $bsha = sha256_hex($block);
	my $nbname = $path . $bsha;
	key($i, $sha, $path, $bsha);
	open(my $fh, '>', "$nbname") or die "Cant open $name: $!\n";
	binmode($fh);
	return *$fh;
}
sub uagent 
{
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2", 
		from => 'punxnotdead',
		timeout => 45,
	);
	return $s_ua;
}
sub key
{
	my ($i, $sha, $path, $bsha) = shift;
	my $kpath = $path."key\"; $kpath = $kpath.$sha;
	open($kfh, '>>', "$kpath");
	print $kfh "$bsha\n";
}
