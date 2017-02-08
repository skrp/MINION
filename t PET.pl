#!/usr/local/bin/perl
use strict; use warnings;
use MKRX;
#############################
# PET - pause active minions
#
my @active = PING_PID();
foreach my $minion (@active)
