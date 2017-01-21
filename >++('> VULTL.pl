#!/usr/local/bin/perl
use strict; use warnings;
use File::Find::Rule;
use MKRX;
#######################################
# VULTL - vulture to archive data bones
#       >++('>        -----skrp of MKRX
# SETUP ########################
my $target = 'VULTL_QUE'; 
my $dump = 'VULTL_dump';
my $pool = 'VULTL_pool';
my $shutdown = 'VULTL_SHUTDOWN';
my $g = 'VULTL_g';
my $init = 'VULTL_INIT';
my $path_to_minion = '/Minion/';
# DAEMONIZE #####################
my $daemon = Proc::Daemon->new(
    work_dir     => 'MINION/VULTL',
    child_STDOUT => 'VULTL_LOG',
    child_STDERR => '+>>VULTL_DEBUG',
    pid_file     => 'VULTL_PID',
);
$daemon->Init();
# my $minions = minion_ls($path_to_minion);
open(my $mfh, '<', $target);
my @minions =  readline $mfh; 
clsoe $mfh; chomp @minions; 
my $minions = \@minions;
pause_em($minions);
my @final_el = \$minions;
foreach $elem (@final_el) { 
	my $elem =~ $elem.'_dump'; 
	XS($elem $pool $g); 
	pause_em(); 
}

# SUB #########################
sub pause_em {
	my $min = shift;
	my @minions = \$min;
	foreach my $p_em (@minions) {
		my $path = $p_em.'_PAUSE';
		open(my $ifh, '>', $path);
		print $ifh "10000"; close $ifh;
	}
}
sub transfer {
	my $item = shift;
	my @items = \$item;
	foreach (@items)
		{ move 
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
