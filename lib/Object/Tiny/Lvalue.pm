package Object::Tiny::Lvalue;

use strict; no strict 'refs';

BEGIN {
	require 5.003_96;
	$Object::Tiny::Lvalue::VERSION = '1.06';
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

__END__

=head1 NAME

Object::Tiny::Lvalue - Minimal class builder with lvalue accessors

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

=head1 SUPPORT

Please report any bugs or feature requests at L<http://github.com/ap/Object-Tiny-Lvalue/issues>. For other issues, contact the author.

=head1 AUTHOR

=over 4

=item *

Adam Kennedy L<mailto:adamk@cpan.org> for original Object::Tiny.

=item *

Aristotle Pagaltzis L<mailto:pagaltzis@gmx.de> for the Object::Tiny::Lvalue variant.

=back

=head1 COPYRIGHT

Copyright (c) 2007--2008 Adam Kennedy.

Copyright (c) 2009 Aristotle Pagaltzis.

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
