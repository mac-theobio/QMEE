use strict;
use 5.10.0;

my $echo = 1;

while(<>){
	next if /<project-file/;
	next if /<\/*bullet/;
	chomp;

	if (/<source-file/) {
		s/.*filename=[" ]*([^" ]*).*/$1/;
		if (/\.R$/){
			say '``` {r ' . $_ . ', echo=FALSE}'
		} else {$echo=0};
	} elsif (/\/\s*source-file/){
		say "```" if $echo;
		$echo = 1;
	}
	elsif ($echo) {
		s|</*code>|`|g;
		s/^===/###/;
		s/^==/##/;
		s/^=/#/;
		s/[=\s]*$//;
		say;
	}
}
