#samples an ROC curve file to reduce its size and make it more easily plotted
# ALL files in the results directory are sampled, so the directory should contain
# only non-sampled roc curves
use strict;
use warnings;

#user input
my $resultsDir = '../../results/';
my $reduction = 10000;
&_sampleAllResults($resultsDir, $reduction);


####################################################
#       Begin Code
####################################################

#method to sample all files in a directory
sub _sampleAllResults {
    my $resultsDir = shift;
    my $reduction = shift;

    #grab all files from the directory
    opendir my $dir, $resultsDir or die "Cannot open directory: $resultsDir\n";
    my @files = readdir $dir;
    closedir $dir;

    #sample each of the files from the directory
    foreach my $file (@files) {
	#skip the . and .. files
	if ($file ne '.' && $file ne '..' && !(-d $file)) {
       	    my $outFile = $resultsDir.$file.'_reduced';
	    &_sampleFile($resultsDir.$file, $outFile, $reduction);
	}
    }

    print "Done!\n";
}


#Samples an ROC file every reduction amount. This makes the files
# more manageable and easier to plot (less memory intensive)
sub _sampleFile {
    my $inFile = shift;
    my $outFile = shift;
    my $reduction = shift;

    #open in and out files
    open IN, $inFile or die ("ERROR: unable to open inFile: $inFile\n");
    open OUT, ">$outFile" or die("ERROR: unable to open outFile: $outFile\n");
    
    #print the header lines
    my $line = <IN>;
    print OUT $line;
    $line = <IN>;
    print OUT $line;
    
    #copy lines to OUT at intervals of reduction
    my $count = $reduction;
    while (my $line = <IN>) {
	if ($count == $reduction) {
	    print OUT $line;
	    $count = 0;
	}
	$count++;
    }
    close IN;
    close OUT;
}



