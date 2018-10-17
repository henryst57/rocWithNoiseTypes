#Grabs the top X points from an ROC file. This makes graphs that emphasize
# a method's performance on the top X terms.
# Grabs the top X from all files in a directory, so the directory should 
# contain only ROC curves
use strict;
use warnings;

#user inpout
my $X = 300;
my $resultsDir = '../../results/';
&_grabTopXFromAllFiles($resultsDir, $X);




##########################################################
#                 Begin Code
#########################################################

#method to grab top X from all files in a directory
sub _grabTopXFromAllFiles {
    my $resultsDir = shift;
    my $X = shift;

    #grab all files from the directorY
    opendir my $dir, $resultsDir or die "Cannot open directory: $resultsDir\n";
    my @files = readdir $dir;
    closedir $dir;

    #sample each of the files from the directory
    foreach my $file (@files) {
        my $outFile = $resultsDir.$file.'_top'.$X;
        &_grabTopX($resultsDir.$file, $outFile, $X);
    }

    print "Done!\n";
}


#Grabs the top 300 points from an ROC file. This emphasizes a method's impact
# on the top ranked 300 terms 
sub _grabTopX {
    my $inFile = shift;
    my $outFile = shift;
    my $topX = shift;

    #open in and out files
    open IN, $inFile or die ("ERROR: unable to open inFile: $inFile\n");
    open OUT, ">$outFile" or die("ERROR: unable to open outFile: $outFile\n");
    
    #skip the header line
    my $line = <IN>;
    
    #copy the first $x lines to out
    my $count = 0;
    while (my $line = <IN>) {
	print OUT $line;
	$count++;

	#exit when count reaches the Xth position
	if ($count >= $topX) {
	    last;
	}
    }
    close IN;
    close OUT;
}



