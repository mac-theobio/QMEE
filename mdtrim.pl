use strict;
use 5.10.0;

while (<>){
	next if /^</;
	chomp;
	s|Introduction_to_R/|intro_|;
	s|Visualization/|Visualization_|;
	s/ "wikilink"/.html/;
	say;
}
