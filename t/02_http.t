use strict;
use Test::More 0.98;
use Net::LastFM::Lite;
use Data::Dumper;

my $lastfm = new Net::LastFM::Lite;
ok $lastfm->http;
isa_ok $lastfm->http, 'Furl::HTTP';
is $lastfm->http->{timeout}, 10;
is ref $lastfm->http->{inet_aton}, 'CODE';

my $data = $lastfm->request(
    method => 'artist.getInfo',
    artist => 'Metallica',
);
ok $data;
is $data->{artist}{name}, 'Metallica';
is $data->{artist}{mbid}, '65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab';
is $data->{artist}{url}, 'http://www.last.fm/music/Metallica';

done_testing;

