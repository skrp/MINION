#!/usr/local/bin/perl
use strict; use warnings;
use WWW::Mechanize;
####################### SUMMONS #
# BART - deviantart acquisitioner
#   :P <===       ---skrp of MKRX
## SETUP ###############################
my $work = 'MINION/';
my $limbo = 'limbo'; my $dump = 'dump';
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

my $master = 'DART_MASTER';
open(my $mfh, '<', $master);
my @master = readline $mfh; chomp @master; close $mfh; 
my $mech = WWW::Mechanize->new( from => 'www.wikiark.org' );
foreach my $pic (@master) {
  $mech->get($pic);
  my $name = $pic; $name =~ s|.*/||; $name = "dump/$name";
  $mech->save_content($name);
  print "$pic done\n";
}
