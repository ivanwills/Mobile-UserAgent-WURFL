use utf8;
package Mobile::UserAgent::WURFL::Schema::Result::Capability;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Mobile::UserAgent::WURFL::Schema::Result::Capability

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<capability>

=cut

__PACKAGE__->table("capability");

=head1 ACCESSORS

=head2 device_id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 value

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 255

=head2 group_id

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 ts

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "device_id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "value",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
  "group_id",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "ts",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "created_by",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07022 @ 2012-04-22 05:12:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iQBXH4r88t4jOAZqTFR4+A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
