#!/sur/bin/perl

use strict;
use warnings;
use Test::More;
use Path::Class;

use Mobile::UserAgent::WURFL;
use Mobile::UserAgent::WURFL::Schema;

my $test_dir = file($0)->parent;
my $db_file  = $test_dir->file('wurfl.db');
my $wurfl = Mobile::UserAgent::WURFL->new(
    dsn     => 'dbi:SQLite:dbname=' . $db_file,
    db_user => '',
    db_pass => '',
);

my @ua = ua();

for my $ua (@ua) {
    $ua = $wurfl->ua($ua);
    ok $ua, "Got User-Agent object for '$ua'";
    diag Dumper { $ua->device };
}

done_testing;

sub ua {
    return (
        'Mozilla/5.0 (Linux; U; Android 2.3.5; en-au; GT-S5830 Build/GINGERBREAD) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1',
        'Dalvik/1.1.0 (Linux; U; Android 2.1-update1; MB525 Build/JRDNEM_U3_2.59.0)',
        'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)',
    );
}

