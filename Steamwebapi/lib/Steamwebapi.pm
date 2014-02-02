package Steamwebapi;

use strict;
use warnings;
use Carp;
use Exporter;
use Data::Dumper;
our $VERSION     = 1.00;
our $ABSTRACT    = "Module for Valve Steam Web API ";
our @ISA = qw(Exporter);
our %EXPORT_TAGS = (
          'encode' => [ qw(
                          vdf_encode
                  ) ],
          'decode' => [ qw(
                          vdf_decode
                  ) ],
          'both' => [ qw(
                          vdf_encode
                          vdf_decode
                  ) ],
);
our @EXPORT_OK   = qw(vdf_encode vdf_decode);
our @EXPORT = ();

use constant {
        QUOTE => '"',
        CURLY_BRACE_START => "{",
        CURLY_BRACE_END => "}",
        NEW_LINE => "\n",
        CARRIAGE_RETURN => "\r",
        TAB => "\t",
};

our %switch_trigger = (
        '"' => \&case_quote,
        "{" => \&case_brace_start,
        "}" => \&case_brace_end,
);

1;

__END__

=head1 NAME

Steamwebapi

=head1 VERSION

Version 1.00

=head1 SYNOPSIS

This module provides an interface to Valve steam web api.

=head1 METHODS
	
=head1 AUTHOR

Usman Raza, B<C<usman.r123 at gmail.com>>

=head1 SUPPORT

You can find documentation for this module with the perldoc command. Also check the example provided.

    perldoc Vdfparser

Github repo https://github.com/killerfish/perlsteamapi

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Usman Raza.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
