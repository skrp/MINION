#!/usr/local/bin/perl
use MKRX;
###################### TOOL #
# REBIT - update master lists
#   (_8(|) ---skrp of MKRX
# - update_MASTER
my $old = "$minion".'_MASTER';
my @up = PING_PID(); chomp @up;
foreach my $minion (@active) {
  my @response = up_MASTER($minion);
  my $old = "$minion".'_MASTER';
  open($mfp, '<', $old);
  my @old = readline $mfp; chomp @old;
  my $countold = @old; my $countresponse = @response;
  my @new_master;
  my %tmp = map{$_ => undef} @response;
  foreach my $p (@old) {
  	if (exists $tmp{$p}) 
		{ next; }
	else 
      		{ push @new_master, $p; }
  }
  open(my $newfp, '>', $old);
  foreach (@new_master)
  	{ print $newfp "$_\n"; }
}
# SUB ############################
sub counter { # list $minion_dump 
  my ($mininon) = @_;
  my $minion_dump = "$minion".'_dump';
  my @count = readdir($minion_dump);
  my $count = @counter;
  print "$count\n";
}
sub up_MASTER { # list $minion_dump 
  my ($mininon) = @_;
  my $minion_dump = "$minion".'_dump';
  my @count = readdir($minion_dump);
  my $counter = \@count;
  return $counter;
}
