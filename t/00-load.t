#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1 + 1;
use Test::NoWarnings;

BEGIN {
	use_ok( 'Mobile::UserAgent::WURFL' );
}

diag( "Testing Mobile::UserAgent::WURFL $Mobile::UserAgent::WURFL::VERSION, Perl $], $^X" );
