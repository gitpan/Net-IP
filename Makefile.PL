use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Net::IP',
	'AUTHOR'	=>	'Manuel Valente <manuel@ripe.net>',
	'ABSTRACT_FROM'	=>	'IP.pm',
    'VERSION_FROM' => 'IP.pm', # finds $VERSION
	'PL_FILES'	=>	{ 'Net-IP.spec.PL'	=>	'Net-IP.spec' },
    'EXE_FILES'         => [qw(ipcount iptab)],
    'INSTALLSCRIPT'     => '/usr/local/ncc/bin',
);
