require 5.010;
use ExtUtils::MakeMaker;

WriteMakefile (
	NAME		=> 'WWW::Shorten::KrzzDe',
	AUTHOR		=> 'Andreas Krennmair <ak@synflood.at>',
	ABSTRACT	=> 'shorten and lenghten URLs with http://krzz.de/',
	VERSION		=> '0.1',
	DISTNAME	=> 'WWW-Shorten-KrzzDe',
	LICENSE		=> 'perl',
	PREREQ_PM	=> {
			'Carp' => '0',
			'Exporter' => '0',
			'WWW:Shorten::generic' => '0',
	},
);
