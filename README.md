# NAME

Net::LastFM::Lite - A simple and fast interface to the Last.fm API

# SYNOPSIS

    use Net::LastFM::Lite;

    my $lastfm = Net::LastFM::Lite->new(
        api_key    => 'YOUR_API_KEY',
        api_secret => 'YOUR_API_SECRET',
    );
    
    # or default values $ENV{'LASTFM_API_KEY'} and $ENV{'LASTFM_API_SECRET'}
    my $lastfm = Net::LastFM::Lite->new();

    my $data = $lastfm->request(
        method => 'artist.getInfo',
        user   => 'Metallica',
    );

# DESCRIPTION

The module provides a simple interface to the Last.fm API. To use this module, you must first sign up at http://www.last.fm/api to receive an API key and secret.

# LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Hondallica <hondallica@gmail.com>
