package WWW::Shorten::KrzzDe;

use 5.006;
use strict;
use warnings;

use base qw( WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink );
our $VERSION = "0.1";

use Carp;

sub makeashorterlink ($)
{
	my $url = shift or croak 'No URL passed to makeashorterlink';
	my $ua = __PACKAGE__->ua();
	my $tinyurl = 'http://krzz.de/_api/save?url=' . $url;
	my $resp = $ua->get($tinyurl, [
	source => "PerlAPI-$VERSION",
	]);
	return undef unless $resp->is_success;
	my $content = $resp->content;
	if ($resp->content =~ m!(\Qhttp://krzz.de/\E\w+)!x) {
		return $1;
	}
	return;
}

sub makealongerlink ($)
{   
    my $krzz_url = shift
        or croak 'No krzz.de key / URL passed to makealongerlink';
    my $ua = __PACKAGE__->ua();

    $krzz_url = "http://krzz.de/$krzz_url"
    unless $krzz_url =~ m!^http://!i;

    my $resp = $ua->get($krzz_url);

    return undef unless $resp->is_redirect;
    my $url = $resp->header('Location');
    return $url;
}

1;

__END__

=head1 NAME

WWW::Shorten::KrzzDe - Perl interface to krzz.de

=head1 SYNOPSIS

  use WWW::Shorten::KrzzDe;
  use WWW::Shorten 'KrzzDe';

  $short_url = makeashorterlink($long_url);

  $long_url  = makealongerlink($short_url);

=head1 DESCRIPTION

A Perl interface to the web site krzz.de. krzz.de simply maintains
a database of long URLs, each of which has a unique identifier.

The function C<makeashorterlink> will call the krzz.de API passing
it your long URL and will return the shorter krzz.de version.

The function C<makealongerlink> does the reverse. C<makealongerlink>
will accept as an argument either the full krzz.de URL or just the
krzz.de identifier.

If anything goes wrong, then either function will return C<undef>.

=head2 EXPORT

makeashorterlink, makealongerlink

=head1 SUPPORT, LICENCE, THANKS and SUCH

See the main L<WWW::Shorten> docs.

=head1 AUTHOR

Andreas Krennmair <ak@synflood.at>

Based almost entirely on WWW::Shorten::TinyURL by Iain Truskett <spoon@cpan.org>

=head1 SEE ALSO

L<WWW::Shorten>, L<perl>, L<http://krzz.de/>

=cut
