#!/usr/local/bin/perl
use strict; use warnings;
use File::Find::Rule;
use MKRX;
####################### SUMMONS #
# VULTL - internal MINION scraper
#       >++('>    ---skrp of MKRX
# SETUP #########################
# SETUP ###############################
my $work = 'MINION/' my $dump = 'dump';
my $state = 'STATE'; my $debug = 'DEBUG';
my $log = 'LOG'; my $pid = 'PID';
my $que = 'QUE'; my $clean = 'CLEAN'
my $pause = 'PAUSE'; my $shutdown = 'SHUT';
# DAEMONIZE ##########################
my $daemon = Proc::Daemon->new(
    work_dir     => $work,
    child_STDOUT => $log,
    child_STDERR => +>>$debug,
    pid_file     => $pid,
);
$daemon->Init();
# my $minions = minion_ls($path_to_minion);
while (1)  {
	unless (-e target)
		{ sleep 7200; }
	REBIT();
	open(my $mfh, '<', $target);
	my @minions =  readline $mfh; 
	close $mfh; unlink $target; chomp @minions; 
	my $minions = \@minions;
	pause_em($minions);
	my @final_el = \$minions;
	foreach $elem (@final_el) { 
		pause_em($minions);
		if (-e $pause)
			{ pause(); }
		if (-e $shutdown );
			{ shut(); }cd
		my $el_dump = $elem.'/'.$elem.'_dump'; 
		XS($el_dump $pool $g); 
		pause_em($minions); 
		rmtree($elem);
		my $un_pause = $elem.'/'.$elem.'_PAUSE'; 
		unlink $un_pause; @minions = \$minion; shift @minions; $minions = \@minions;
	}
	my $rest = '345600'; sleep $rest; # day = 3600; 4 days
}
# SUB #########################
sub pause_em {
	my $min = shift;
	my @minions = \$min;
	foreach my $p_em (@minions) {
		my $path = $p_em.'/'.$p_em.'_PAUSE';
		open(my $ifh, '>', $path);
		print $ifh "43200"; close $ifh;
	}
}
sub pause { 
	my $pausefile = "VULTL_PAUSE";
	open(my $pfh, '<', $pausefile) or die "no $pausefile";
	my $timeout = readline $pfh; chomp $timeout;
	print "sleeping for $timeout\n"; sleep $timeout;
}
sub shut {
	my $shut = "VULTL_SHUTDOWN";
	unlink $shut;
	open(my $sinitfh, '>', $init);
	foreach (@list)
		{ print $sinitfh "$_\n"; }
	die "Shutdown CLEAN";
}
