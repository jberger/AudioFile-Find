use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'AudioFile::Find',
    AUTHOR              => 'Markus <holli.holzer@googlemail.com>',
    VERSION_FROM        => 'lib/AudioFile/Find.pm',
    ABSTRACT_FROM       => 'lib/AudioFile/Find.pm',
	EXE_FILES           => ['bin/findaudio'],
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'                                     => 0,
		'AudioFile::Info'                                => 1.09,
		'AudioFile::Info::MP3::Info'                     => 1.04,
		'AudioFile::Info::Audio::WMA'                    => 0.1,
		'AudioFile::Info::Ogg::Vorbis::Header::PurePerl' => 1.05,
    },	
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'AudioFile-Find-*' },
);
