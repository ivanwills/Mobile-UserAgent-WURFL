#!/sur/bin/perl

use strict;
use warnings;
use Test::More;
use Path::Class;

my $test_dir = file($0)->parent;
my $db_file  = $test_dir->file('wurfl.db');
my $wurfl_file  = $test_dir->file('wurfl-2.3.1.xml.gz');
my ($zcat)   = grep { -e "$_/zcat" } split /:/, $ENV{PATH};
$zcat &&= "$zcat/zcat";

plan skip_all => "Can't write to test DB"                     if !-w $test_dir;
plan skip_all => "Can't find zcat to extract test WURFL file" if !$zcat || !-e $zcat;

require Mobile::UserAgent::WURFL::Schema;

my $schema = Mobile::UserAgent::WURFL::Schema->connect(
   'dbi:SQLite:dbname=' . $db_file, '', ''
);
$schema->deploy({add_drop_table => 1});

ok $schema, 'Can connect to test db';

my $xml = `$zcat $wurfl_file`;

eval { $schema->update_db($xml) };
ok !$@, "No errors in updating the WURFL DB";
diag $@ if $@;

done_testing();

