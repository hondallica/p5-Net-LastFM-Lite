use strict;
use Test::More 0.98;
use Net::LastFM::Lite;
use Data::Dumper;

my $lastfm = new Net::LastFM::Lite;
ok $lastfm->http;
isa_ok $lastfm->http, 'Furl::HTTP';
is $lastfm->http->{timeout}, 10;
is ref $lastfm->http->{inet_aton}, 'CODE';


done_testing;

