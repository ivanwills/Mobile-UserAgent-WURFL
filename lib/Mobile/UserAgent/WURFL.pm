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
use DateTime;
use Mobile::UserAgent::WURFL::UA;

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();
#our @EXPORT      = qw//;

has schema => (
    is  => 'ro',
    isa => 'Mobile::UserAgent::WURFL::Schema',
);

around BUILDARGS => sub {
    my ($orig, $class, @params) = @_;
    my %param =
          @params == 1 && ref $params[0] eq 'HASH' ? %{ $params[0] }
        : @params == 1 && ref $params[0] ne 'HASH' ? ( schema => $params[0] )
        :                                            @params;

    $param{schema} ||= Mobile::UserAgent::WURFL::Schema->connect(
        $param{dsn}, $param{db_user}, $param{db_pass},
    );

    return $class->$orig(%param);
};

sub ua {
    my ($self, $ua_string) = @_;

    return Mobile::UserAgent::WURFL::UA->new(
        ua    => $ua_string,
        wurfl => $self,
    );
}

sub device {
    my ($self, $ua, $falling) = @_;

    my $rs     = $self->schema->resultset('Device');
    my $device = $rs->search(
        {
            user_agent => $ua,
        }
    );

    if ( !$device->count ) {
        my $short = $ua;
        chop $short;
        chop $short while $short && $short =~ /\W$/;
        my $fallback = $self->device($short, 1);


        if ( !$falling ) {
            $rs->new({
                $fallback->get_columns,
                user_agent => $ua,
                ts         => DateTime->now,
            })->insert;
        }

        return wantarray ? $fallback->get_columns : $fallback;
    }

    return wantarray ? $device->first->get_columns : $device->first;
}

sub capability {
    my ($self, $device_id, $group_id) = @_;

    my $rs     = $self->schema->resultset('Capability');
    my $capability = $rs->search(
        {
            device_id => $device_id,
        }
    );

    if ( $capability->count() == 0 ) {
        my $rs     = $self->schema->resultset('Device');
        my $device = $rs->search(
            {
                device_id => $device_id,
            }
        );
        return $self->capability($device->first->fall_back, $group_id);
    }

    return wantarray ? $capability->first->get_columns : $capability->first;
}

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

   my $wurfl = Mobile::UserAgent::WURFL->new(
        dsn => 'dbi:Pg:name=wurfl',
        db_user => 'wurfl',
        db_pass => 'wurfl',
   );

   my $ua = $wurfl->ua('Mozilla/5.0');

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
