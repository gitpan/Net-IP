use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# RIPE NCC common configuration
my %PARAM = (
    'INSTALLDIRS'	=> 'vendor',
    'INSTALLSCRIPT'	=> '$(INSTALLVENDORBIN)', # Hack for Perl prior 5.8.1
    'macro'		=> { 'INSTALLPREFIX' => '$(VENDORPREFIX)' },
    'dist'		=> {
        'COMPRESS'	=> 'gzip', 
            'SUFFIX'	=> '.gz',
            'CI'	=> 'cvs ci',
            'RCS_LABEL'	=> 'cvs tag -c -F $(NAME_SYM)-$(VERSION_SYM)',
    },
    'ABSTRACT_FROM'	=> 'IP.pm',
    'AUTHOR'		=> 'Manuel Valente <manuel@ripe.net>',
);

WriteMakefile(
    'NAME'		=> 'Net::IP',
    'VERSION_FROM'	=> 'IP.pm',
    'PREREQ_PM'		=> {},
    %PARAM
);

