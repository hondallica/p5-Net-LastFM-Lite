package Net::LastFM::Lite;
use Digest::MD5 qw/md5_hex/;
use JSON::XS;
use Cache::LRU;
use Net::DNS::Lite;
use Furl;
use URI;
use URI::QueryParam;
use Carp;
use Data::Dumper;
use Moo;
use namespace::clean;
our $VERSION = "0.01";


1;
__END__

=encoding utf-8

=head1 NAME

Net::LastFM::Lite - A simple and fast interface to the Last.fm API

=head1 SYNOPSIS

    use Net::LastFM::Lite;

    my $lastfm = Net::LastFM->new(
        api_key    => 'YOUR_API_KEY',
        api_secret => 'YOUR_API_SECRET',
    );
    
    # or default values $ENV{'LASTFM_API_KEY'} and $ENV{'LASTFM_API_SECRET'}
    my $lastfm = Net::LastFM->new();

    my $data = $lastfm->request(
        method => 'artist.getInfo',
        user   => 'Metallica',
    );



=head1 DESCRIPTION

The module provides a simple interface to the Last.fm API. To use this module, you must first sign up at http://www.last.fm/api to receive an API key and secret.

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut

