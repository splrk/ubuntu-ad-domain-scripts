#!/bin/awk -f
# kerberos.awk ---- Reads the krb configuruation file

BEGIN {
	RS="\[";
	FS="\n";
}	

/^libdefaults\]\n/ {
	# Remove the Section Name
	sectionname=gsub(/^\[+/, "", $1)
	sectionname=gsub(/\]+/, "", $sectionname);

	sub($1, "", $0);
	gsub(/#[^\n]*/, "", $0);
	gsub(/\n\n+/, "\n", $0);

	for( i = 1; i <= NF; i++) {
		if (match($i, /^[\t ]*default_realm[\t ]*=/)) {
			sub(/^[\t ]*default_realm[\t ]*=[\t ]*/, "", $i);
			gsub(/[\t ]*/, "", $i);
			print $i;
			exit 0;
		}	
	}
}


END { exit 1 }
