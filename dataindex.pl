use strict;
use 5.10.0;

while (<>){
	next if /index.html/;
	s|data/([^\s:]*)|[$1]($1)|;
	print;
}
