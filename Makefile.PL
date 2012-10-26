use strict;
use warnings;
use ExtUtils::MakeMaker 6.30;
use File::Spec;


 
my %WriteMakefileArgs = (
  "ABSTRACT" => "make an educated guess about the shell in use",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Shell-Guess",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Shell::Guess",
  "PREREQ_PM" => {
    "File::Spec" => 0
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);
 
    
if($^O ne 'dos' && $^O ne 'VMS' && $^O ne 'MSWin32' && eval { getppid; 1 })
{
  unless(-e File::Spec->catfile('', 'proc', getppid, 'cmdline'))
  {
    $WriteMakefileArgs{PREREQ_PM}->{'Unix::Process'} = 0;
  }
}

if($^O eq 'MSWin32')
{
  $WriteMakefileArgs{PREREQ_PM}->{'Win32::Process::Info'} = 0;
  $WriteMakefileArgs{PREREQ_PM}->{'Win32::Process::List'} = 0;
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}
 
delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };
 
WriteMakefile(%WriteMakefileArgs);
 


