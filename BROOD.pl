#!/usr/local/bin/perl
use strict; use warnings;
use Proc::Daemon;
#####################################
# SUMMON SCROLL
# INIT ##############################
my ($name) = @ARGV; 
# DIR 
my $home = "hive/$name"; 
my $dump = "$home/dump"; my $que = "$home/que";
# FILES
my $BUG = "BUG"; my $LOG = "LOG"; my $mPID = 'PID'; 
# PREP ################################
mkdir $home or die "home FAIL\n"; 
mkdir $que or die "que FAIL\n";
mkdir $dump or die "dump FAIL\n";
# BIRTH ###############################
  my $embryo = Proc::Daemon->new(
    work_dir => $home,
    child_STDOUT => "+>>$LOG",
    child_STDERR => "+>>$BUG",
    pid_file => "$mPID",
  );
  $embryo->Init() or die "STILLBORN\n";
  my $btime = TIME(); print "$name $btime\n";
}
# FN ################################
sub TIME
{
  my $t = localtime;
  my $mon = (split(/\s+/, $t))[1];
  my $day = (split(/\s+/, $t))[2];
  my $hour = (split(/\s+/, $t))[3];
  my $time = $mon.'_'.$day.'_'.$hour;
  return $time;
}
