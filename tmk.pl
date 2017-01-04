use strict;
use 5.10.0;

print "make";
while (<>){
	next unless /html\)/;
	next if /http/;
	chomp;
	s/.*\(//;
	s/\.html.*//;
	print " $_.new";
}
