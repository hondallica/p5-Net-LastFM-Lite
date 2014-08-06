use strict;
use Test::More 0.98;
use Net::LastFM::Lite;


SKIP: {
    skip q|Not exists $ENV{'LASTFM_API_KEY'}|, 6 unless exists $ENV{LASTFM_API_KEY};

    my $lastfm = new Net::LastFM::Lite;

    ok $lastfm->api_key, '$ENV{LASTFM_API_KEY}';
    is length $lastfm->api_key, 32;
    is $lastfm->api_key, $ENV{'LASTFM_API_KEY'};

    ok $lastfm->api_secret, '$ENV{LASTFM_API_SECRET}';
    is length $lastfm->api_secret, 32;
    is $lastfm->api_secret, $ENV{'LASTFM_API_SECRET'};
}

my $lastfm = new Net::LastFM::Lite(
    'api_key'    => 'dummyapikey32characterheavymetal',
    'api_secret' => 'dummyapisecret32characternumetal',
);
is $lastfm->api_key, 'dummyapikey32characterheavymetal';
is length $lastfm->api_key, 32;
is $lastfm->api_secret, 'dummyapisecret32characternumetal';
is length $lastfm->api_secret, 32;


done_testing;

