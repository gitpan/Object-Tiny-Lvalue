use strict;
use vars qw{$VERSION};
BEGIN {
	require 5.003_96;
	$VERSION = '1.06';
}
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME      => 'Object::Tiny::Lvalue',
	ABSTRACT  => 'Minimal class builder with lvalue accessors',
	VERSION   => $VERSION,
	PREREQ_PM => {
		# Skip on Windows to avoid breaking ActivePerl PPMs
		# 0.47 means 5.6.2 or newer, which everyone on Win32 has.
		($^O eq 'MSWin32' ? () : ('Test::More' => '0.47')),
	},
	($] >= 5.005 ? (
		AUTHOR  => 'Aristotle Pagaltzis <pagaltzis@gmx.de>',
	) : ()),
	($ExtUtils::MakeMaker::VERSION ge '6.30_00' ? (
		LICENSE => 'perl',
	) : ()),
	($ExtUtils::MakeMaker::VERSION ge '6.45_01' ? (
		META_MERGE => {
			resources => {
				license    => 'http://dev.perl.org/licenses/',
				homepage   => 'http://github.com/ap/Object-Tiny-Lvalue',
				bugtracker => 'http://github.com/ap/Object-Tiny-Lvalue/issues',
				repository => 'git://github.com/ap/Object-Tiny-Lvalue.git',
			}
		},
	) : ()),
);
