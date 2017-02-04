use strict;
use 5.10.0;

while (<>){
	next if /^</;
	chomp;
	s|Introduction_to_R/|intro_|g;
	s|Visualization/|Visualization_|g;
	s|Permutations/|Permutations_|g;
	s/ "wikilink"/.html/g;
	say;
}
