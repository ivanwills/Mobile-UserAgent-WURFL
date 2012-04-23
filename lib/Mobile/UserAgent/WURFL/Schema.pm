use utf8;
package Mobile::UserAgent::WURFL::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-22 05:12:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ALBHqRsC/wX4W1TuNyyYqg

use XML::Parser;
use Data::Dumper qw/Dumper/;

sub update_db {
    my ($self, $wurfl) = @_;

    my ( $device_id, $group_id );
    my $device     = $self->resultset('Device');
    my $capability = $self->resultset('Capability');
    my (@devices, @capabilities);

    my $xp = XML::Parser->new(
        Style => "Object",
        Handlers => {
            Start => sub {
                my ( $expat, $element, %attrs ) = @_;
                if ( $element eq 'group' ) {
                    my %group = %attrs;
                    $group_id = $group{id};
                }
                if ( $element eq 'device' ) {
                    my %device = %attrs;
                    $device{created_by} = "WURFL";
                    $device{device_id}  = $device{id};
                    delete $device{id};
                    #$device->new(\%device)->insert;
                    push @devices, \%device;

                    $device_id = $device{device_id};
                }
                if ( $element eq 'capability' ) {
                    my %capability = %attrs;
                    $capability{created_by} = "WURFL";
                    $capability{device_id}  = $device_id;
                    $capability{group_id}   = $group_id;
                    #$capability->new(\%capability)->insert;
                    push @capabilities, \%capability;
                }
            },
        }
    );

    $self->txn_do(
        sub {
            $xp->parse($wurfl);
            $device->populate(\@devices);
            $capability->populate(\@capabilities);
        }
    );

    return;
}

1;
