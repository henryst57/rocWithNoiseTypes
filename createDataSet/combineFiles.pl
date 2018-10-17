#script to combine multiple files into a single one 

#user input
my @inputFiles = ();
my $fileDir = '../../data/vectors/';
push @inputFiles, $fileDir.'vectors_x2_1975_2015_window8_threshold1_randomCuis_T047';
push @inputFiles, $fileDir.'vectors_x2_1975_2015_window8_threshold1_randomCuis_T121';
push @inputFiles, $fileDir.'vectors_x2_1975_2015_window8_threshold1_randomCuis_T184';
push @inputFiles, $fileDir.'vectors_x2_1975_2015_window8_threshold1_randomCuis_T200';
my $outFile = $fileDir.'vectors_x2_1975_2015_window8_threshold1_randomCuis_all';


#############################################################
#                 Begin Code
#############################################################
#create an empty out file
open OUT, ">$outFile" or die ("ERROR: unable to open out file\n");

#concatenate each of the files to the out file
foreach my $file (@inputFiles) {
    #add each line of this file
    open IN, $file or die ("ERROR: cannot open $file\n");
    my $line = '';
    while ($line = <IN>) {
	#skip empty lines
	if ($line eq "\n") {
	    next;
	}

	#copy the line to the output file
	print OUT "$line";
    }
}
close OUT;

print "DONE!\n";


