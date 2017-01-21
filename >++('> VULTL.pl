#!/usr/local/bin/perl
use strict; use warnings;
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
my @minions;

# SUB #########################
sub minion_ls {
  opendir(DIR, $path_to_minion);
  while (my $minion = readdir(DIR)) {
    if ($minion eq 'VULTL') || $minion eq 'IGOR')
      { next; }
    else
    { push @minions $minion; }
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
