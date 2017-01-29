#!/usr/local/bin/perl
use strict; use warnings;
use WWW::Mechanize;
#################################
# BART - deviantart acquisitioner
#   :P <===       ---skrp of MKRX
# SETUP #########################
my $master = 'DART_MASTER';
open(my $mfh, '<', $master);
my @master = readline $mfh; chomp @master; close $mfh; 
