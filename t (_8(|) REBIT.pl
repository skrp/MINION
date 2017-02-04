#!/usr/local/bin/perl
################### TOOL #
# REBIT - iteration parser
#   (_8(|) ---skrp of MKRX
# - cur_iter - init_length - update_MASTER - cat_init
my $dir = 'MINIONS/';
my @list = readdir($dir);
my @active;
foreach my $minion (@list) {
  if (defined REBIT) 
    { push @active $minion; }
}
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
