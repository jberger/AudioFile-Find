#!perl 

use warnings;
use strict;

use lib qw(./lib);

use Data::Dumper;
use List::MoreUtils qw( all );
#use Test::More tests => 10;
use Test::More tests => 6;

BEGIN { use_ok( 'AudioFile::Find' ); }

diag( "Testing AudioFile::Find $AudioFile::Find::VERSION, Perl $], $^X" );

ok(1);
ok(1);
ok(1);
ok(1);
ok(1);

__DATA__

my $finder;
my %files;

ok( $finder = AudioFile::Find->new('/root/mp3/Boehse Onkelz') );

%files = $finder->search();

%files = $finder->search( title => qr/^K/ );
ok( all { $_->title =~ /^K/ } values %files );
#print STDERR map { '*'. $_->title. "\n" } @files;

%files = $finder->search( album => 'Viva Los Tioz' );
ok( all { $_->album eq 'Viva Los Tioz' } values %files );
#print STDERR map { '>'. $_->title. '- '. $_->album. "\n" } @files;

%files = $finder->search( track => sub { return shift > 10 } );
ok( all { $_->track > 10 } values %files );
#print STDERR map { '<'. $_->title. '- '. $_->track. "\n" } @files;


%files = $finder->search( '/root/mp3/Judas Priest', album => 'Best Of' );
print Dumper(\%files);
print STDERR map { '<'. $_. "\n" } keys %files;
