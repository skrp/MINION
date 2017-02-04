#!/usr/local/bin/perl
use strict; use warnings;
use WWW::Mechanize;
####################### SUMMONS #
# BART - deviantart acquisitioner
#   :P <===       ---skrp of MKRX
# SETUP #########################
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
