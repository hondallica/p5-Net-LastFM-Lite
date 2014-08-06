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


$Net::DNS::Lite::CACHE = Cache::LRU->new( size => 512 );

has 'api_key' => (
    is => 'rw',
    isa => sub { die "Invalid api_key" unless $_[0] =~ /^[0-9a-z]{32}$/},
    required => 1,
    default => $ENV{LASTFM_API_KEY},
);

has 'api_secret' => (
    is => 'rw',
    isa => sub { die "Invalid api_secret" unless $_[0] =~ /^[0-9a-z]{32}$/},
    required => 1,
    default => $ENV{LASTFM_API_SECRET},
);

has 'http' => (
    is => 'rw',
    required => 1,
    default  => sub {
        my $http = Furl::HTTP->new(
            inet_aton => \&Net::DNS::Lite::inet_aton,
            agent => 'Net::LastFM::Lite' . $VERSION,
            headers => [ 'Accept-Encoding' => 'gzip',],
        );
        $http->env_proxy;
        return $http;
    },
);


sub request {
    my ($self, %query_param) = @_;
    return $self->_make_request(\%query_param);
}

sub _make_request {
    my ( $self, $query_param ) = @_;

    my $query_string = URI->new;
    $query_string->query_param( 'format', 'json' );
    $query_string->query_param( 'api_key', $self->api_key );
    map {
        $query_string->query_param( $_, $query_param->{$_} )
    } keys %$query_param;

    my ($minor_version, $code, $message, $headers, $content) = 
    $self->http->request(
        scheme => 'http',
        host => 'ws.audioscrobbler.com',
        path_query => "2.0/$query_string",
        method => 'GET',
    );
    my $data = decode_json( $content );

    if ( defined $data->{error} ) {
        my $code = $data->{error};
        my $message = $data->{message};
        confess "$code: $message";
    } else {
        return $data;
    }
}



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

