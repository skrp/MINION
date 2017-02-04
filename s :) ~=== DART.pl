#!/usr/local/bin/perl
use strict; use warnings;
use WWW::Mechanize;
################### SUMMONS #
# DART - deviantart locations
#    :) ~===  ---skrp of MKRX 
# SETUP #####################
my @category = ( # max req is 40k per 
    'digitalart',
    'traditional',
    'photography',
    'artisan',
    'literature',
    'film',
    'motionbooks',
    'flash',
    'designs',
    'customization',
    'cartoons',
    'manga',
    'anthro',
    'fanart',
    'resources',
    'projects',
    'contests',
    'journals',
    'darelated',
    'scraps'
);
my $dump = 'DART_MASTER'; my $log = 'DART_LOG';
open(my $payfh, '>>', $dump);
my $base = 'data-super-full-img="';
my $i_batch = 0; my $tmp = 'tmp';
my $mech = WWW::Mechanize->new( from => 'wikiark.org', timeout => 45 );
foreach my $cat (@category) {
        print "##### $cat #####\n";
        for my $i (0 .. 39_999) {
                if ($i > 23 and $i % 25 == 0)
                        { $i_batch += 25; print "@@@@ $i_batch @@@@\n"; }
                my $i_base = 'http://www.deviantart.com/browse/all/'.$cat.'/?offset='.$i_batch;
                print "%%%% $i_base %%%%\n";
                if (eval {$mech->get($i_base)}) {
                        $mech->save_content($tmp);
                        open(my $iterfh, '<', $tmp);
                        my @tmp = readline $iterfh; chomp @tmp; close $iterfh; #unlink $tmp;
                        foreach (@tmp) {
                                if (/$base/) {
                                        $_ =~ s/.*$base//;
                                        $_ =~ s/\".*//;
                                        print $payfh "$_\n";
                                }
                        }
                }
                else { die "failed on $i_base\n"; }
        }
}
