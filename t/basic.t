use warnings;
use strict;

use Test::More;
use File::Temp;
use File::Spec;
use Scalar::Util 'blessed';

use AudioFile::Find;

sub create_test_file {
  my ($dir, $file) = @_;
  my $path = File::Spec->catfile("$dir", $file);
  {
    open my $fh, '>', $path or die "Could not open $path: $!";
    print $fh 'contents';
  }
  return $path;
}

subtest 'mock usage' => sub {
  my $dir  = File::Temp->newdir;
  my $file = create_test_file($dir, 'song.mp3');

  no warnings 'redefine';
  local *AudioFile::Find::extensions = sub { my @ext = ('mp3'); return @ext };
  local *AudioFile::Info::new = sub { return 1 };

  subtest 'dir attribute' => sub {
    my $finder = AudioFile::Find->new("$dir");
    isa_ok $finder, 'AudioFile::Find';
    my ($found, undef) = $finder->search;
    is $found, $file, 'found test file';
  };

  subtest 'dir argument' => sub {
    my $finder = AudioFile::Find->new;
    isa_ok $finder, 'AudioFile::Find';
    my ($found, undef) = $finder->search("$dir");
    is $found, $file, 'found test file';
  };
};

subtest 'plugins' => sub {
  my $dir  = File::Temp->newdir;
  my $finder = AudioFile::Find->new("$dir");
  my @ext = $finder->extensions;
  unless (@ext) {
    ok 1, 'no extensions are available, dummy test';
    return;
  }
  my @paths = map { create_test_file($dir, "song.$_") } @ext;

  no warnings 'redefine';
  local *AudioFile::Info::new = sub { return 1 };
  my %found = $finder->search;
  is_deeply [sort keys %found], [sort @paths], 'found all test files';
};

done_testing;

