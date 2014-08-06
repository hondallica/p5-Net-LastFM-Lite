use strict;
use Test::More 0.98;
use Net::LastFM::Lite;


my $lastfm = new Net::LastFM::Lite;
is $lastfm->format, 'json';


done_testing;

