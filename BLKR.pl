#!/usr/local/bin/perl
use strict; use warnings;
use Archive::Tar;
use File::Path; use File::Copy;
use Digest::SHA qw(sha256_hex); use File::Find::Rule;
use File::stat; use List::Util qw(any);
######################################################
# DEMON - daemon summoning scroll

# INIT ###############################################
my ($que, $path) = @ARGV;
if (not defined $que) { die ('NO ARGV1 que'); }
if (not defined $path) { die ('NO ARGV2 dir'); }
if (substr($path, -1) eq "/")
	{ $path .= '/'; }

# DIRS ###############################################
# sea/ : blkr()
# key/ : key()
# graveyard/ : tombstone()
# g/ : XS()
# pool/ : XS()
print "$$\n";
# PREP ###############################################
my $name = name();
chdir('/tmp/');
my $RATE = '100'; 
my $size = 9968;
my $count = 0;

my $dump = "$name"."_dump/";
my $log = "$name"."_log";
my $SLEEP = "$name"."_SLEEP"; 
my $SUICIDE = "$name"."_SUICIDE";

mkdir $dump or die "dump FAIL\n";
open(my $Lfh, '>>', $log);
my $born = gmtime();
my $btime = TIME(); 
print $Lfh "HELLOWORLD $btime\n";

# WORK ################################################
open(my $qfh, '<', $que) or die "cant open que\n";
my @QUE = readline $qfh; chomp @QUE;

my $ttl = @QUE; 
print $Lfh "ttl $ttl\n"; 

foreach my $i (@QUE)
{
	if (-e $SUICIDE)
    		{ SUICIDE(); }
	if (-e $SLEEP)
    		{ SLEEP(); }
	print $Lfh "started $i\n";
	blkr($i);
	$count++;
	if ($count % 100 == 0)
		{ print $Lfh "$count : $ttl\n"; }
}
my $dtime = TIME(); print $Lfh "FKTHEWRLD $dtime\n";
#tombstone();
# dumpr();

# SUB ###########################################################
sub dumpr
{
	my ($i) = @_;
	XS($i, "$path".'pool/');
	remove_tree($dump);
}
sub rep
{
	my $rep = "$name"."_rep";
	my @files = File::Find::Rule->file->in($dump);
	open(my $rfp, '>', $rep);
	print $rfp @files;
	return $rep;
}
sub tombstone
{
	my $xxtime = TIME(); print $Lfh "farewell $xxtime\n";
	my $tombstone = 'graveyard/'."$name".'.tar';
	my $tar = Archive::Tar->new;
	$tar->write($tombstone);
	my $rep = rep();
	$tar->add_files($log, $rep);
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
sub XS
{
	my ($i) = @_;
	my $rule = File::Find::Rule->file()->start($i);
	my $magic = File::LibMagic->new();
	while (defined( my $file = $rule->match))
	{
		my ($sha) = file_digest($file) or die "couldn't sha $file";
		File::Copy::copy($file, "$dump/pool/$sha");
		my $cur = "$path/g/g$sha";
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
	my $magic = File::Libmagic->new();
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
sub uagent
{
	my $s_ua = LWP::UserAgent->new(
		agent => "Mozilla/50.0.2",
		from => 'punxnotdead',
		timeout => 45,
	);
	return $s_ua;
}
# API ###########################################################
sub blkr
{
	my ($i) = @_;
	my $block = 0;

	open(my $ifh, '<', "/otto/pool/$i") || die "Cant open $i: $!\n";
	binmode($ifh);

	while (read($ifh, $block, $size))
	{
		my $bsha = sha256_hex($block);

		my $bname = $path.'sea/'.$bsha;
		open(my $fh, '>', "$bname");
		binmode($fh);

		print $fh $block;
		key($i, $bsha);
	}
	print $Lfh "YAY $i\n";
}
sub key
{
	my ($i, $bsha) = @_;
	my $kpath = $path.'key/'.$i;
	open(my $kfh, '>>', "$kpath");
	print $kfh "$bsha\n";
}
sub build
{
	my ($i) = @_;

	my $kpath = $path.'key/'.$i;
	open(my $kfh, '<', $kpath);

	my @set = readline $kfh; chomp @set;
	foreach my $part (@set)
	{

		my $tpath = $dump.$i;
		print "$path\n";
		my $ipath = $path.'sea/'.$part;

		open(my $tfh, '>>', "$tpath") or die"bad $tpath";
		open(my $ifh, '<', "$ipath");

		my $block;
		read($ifh, $block, $size);
		print $tfh $block;

# DEBUG
#	my $bsha = sha256_hex($block);
#	if ($i ne $bsha)
#		{ print $Lfh "SHAERR $i ne $bsha"; } 
	}
}
sub vsha
{
	my ($i) = @_;
	my ($sha) = file_digest($i);
	if ($sha ne $i)
		{ print $Lfh "ERK! $i ne $sha\n"; }
	print $Lfh "YAY $i\n";
}
sub xtrac
{
	my ($i) = @_;
	my $archive = Archive::Any->new($i);
	if ($archive->is_naughty)
		{ print $Lfh "ALERT xtrac naughty $i"; next; }
	my @files = $archive->files; print $Lfh @files;
	$archive->extract($dump);
	XS($dump, $path);
	print $Lfh "YAY $i\n";
}
sub get
{
	my ($i) = @_;
	my $ua = uagent();
	my $response = $ua->get($i, ':content_file'=>"$dump/$i");
	print $Lfh "YAY $i\n";
}
