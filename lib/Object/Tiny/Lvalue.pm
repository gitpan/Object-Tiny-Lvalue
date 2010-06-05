package Object::Tiny::Lvalue;
BEGIN {
  $Object::Tiny::Lvalue::VERSION = '1.07';
}

# ABSTRACT: minimal class builder with lvalue accessors

use strict 'vars';

BEGIN {
	require 5.003_96;
}

sub import {
	return unless shift eq __PACKAGE__;
	my $pkg = caller;
	my $child = 0+@{"${pkg}::ISA"};
	eval join "\n",
		"package $pkg;",
		($child ? () : "\@${pkg}::ISA = 'Object::Tiny::Lvalue';"),
		map {
			defined and ! ref and /^[^\W\d]\w*$/s
				or die "Invalid accessor name '$_'";
			"sub $_ : lvalue { \$_[0]->{$_} }"
		} @_;
	die "Failed to generate $pkg" if $@;
	return 1;
}

sub new {
	my $class = shift;
	bless { @_ }, $class;
}

1;



=pod

=head1 NAME

Object::Tiny::Lvalue - minimal class builder with lvalue accessors

=head1 VERSION

version 1.07

=head1 SYNOPSIS

Define a class:

  package Foo;
  use Object::Tiny::Lvalue qw( bar baz );
  1;

Use the class:

  my $object = Foo->new( bar => 1 );
  printf "bar is %s\n", $object->bar;
  $object->bar = 2;
  printf "bar is now %s\n", $object->bar;

=head1 DESCRIPTION

This is a clone of L<Object::Tiny|Object::Tiny>, but adjusted to create accessors that return lvalues.

=head1 AUTHOR

  Aristotle Pagaltzis <pagaltzis@gmx.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Aristotle Pagaltzis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

