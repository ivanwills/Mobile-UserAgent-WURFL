package Mobile::UserAgent::WURFL;

# Created on: 2012-04-22 04:31:16
# Create by:  Ivan Wills
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use Moose;
use version;
use Carp;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;


our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();
#our @EXPORT      = qw//;

has ua => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has name => (
    is       => 'ro',
    isa      => 'Mobile::UserAgent::WURFL::Name',
    lazy     => 1,
    builder  => '_name',
);

has version => (
    is       => 'ro',
    isa      => 'Mobile::UserAgent::WURFL::Version',
    lazy     => 1,
    builder  => '_version',
);

has os => (
    is       => 'ro',
    isa      => 'Mobile::UserAgent::WURFL::OS',
    lazy     => 1,
    builder  => '_os',
);

1;

__END__

=head1 NAME

Mobile::UserAgent::WURFL - <One-line description of module's purpose>

=head1 VERSION

This documentation refers to Mobile::UserAgent::WURFL version 0.1.


=head1 SYNOPSIS

   use Mobile::UserAgent::WURFL;

   # Brief but working code example(s) here showing the most common usage(s)
   # This section will be as far as many users bother reading, so make it as
   # educational and exemplary as possible.


=head1 DESCRIPTION

Inspired in part by http://neilb.org/reviews/user-agent.html

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2012 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
