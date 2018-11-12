#Script to grab AUROC scores from each file and display
use strict;
use warnings;

#file to output the summarized results to 
my $outFile = 'AUROC_Scores';

#the folder and start of file names of results
my $baseFileName = '../../results/roc_';

#the interval part of the filename
my @intervals = ('all','common','mid','uncommon');

#the datasets part of the filename
my @datasets = ('all','T047','T121','T184','T200');

#the ranking methods part of the filename
my @methods = ('random',
'explicitCosine',
'ltc',
'lta',
'mwa',
'sbc',
'lsa',
'word2vecCosine',
'cooccurrenceCount',
'cooccurrenceCount_sortAscending',
'cooccurringTermCount',
'cooccurringTermCount_sortAscending'
    );

############################################################
#                     Begin Code
###########################################################
open OUT, ">$outFile" or die ("ERROR: unable to open outFile: $outFile\n");

#Gran AUROC from each file and output
foreach my $dataset (@datasets) {
    print OUT "$dataset \t";

    foreach my $interval (@intervals) {
	print OUT "$interval:\n";

	foreach my $method (@methods) {
	    #grab the AUROC from the file
	    my $fileName = $baseFileName.$interval.'_'.$dataset.'_'.$method;
	    open IN, $fileName or die ("ERROR: unable to open file: $fileName\n");
	    
	    #AUROC is on the first line
	    my $line = <IN>;
	    $line =~ /AUROC:\s+(\d+\.?\d+)/;
	    my $AUROC = $1;
	    close IN;

	    #output the method and AUROC
	    print OUT "$method\t";
	    print OUT "$AUROC\n";
	}
    }
}
close OUT;
print "Done!\n";

