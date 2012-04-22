use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Mobile::UserAgent::WURFL',
    license           => 'perl',
    dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
    dist_version_from => 'lib/Mobile/UserAgent/WURFL.pm',
    requires          => {
        'perl'             => 5.008,
        'Moose'            => 0,
        'Path::Class'      => 0,
        'version'          => 0,
        'XML::Parser'      => 0,

    },
    build_requires => {
        'Test::More'       => 0,
        'Test::NoWarnings' => 0,
    },
    add_to_cleanup     => [ 'Mobile-UserAgent-WURFL-*' ],
    create_makefile_pl => 'traditional',
    create_license     => 1,
    meta_merge => {
        resources => {
            repository => 'git://github.com/ivanwills/Mobile-UserAgent-WURFL.git',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Mobile::UserAgent::WURFL',
        },
    },
);

$builder->create_build_script();
