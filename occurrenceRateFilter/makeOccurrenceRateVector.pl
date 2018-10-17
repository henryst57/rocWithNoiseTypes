# Makes a vector of occurrence rates so that it can be used with an ROC curve
#

#T047
my $occurrenceCountsFile = '../../data/occurrenceStats/occurrenceStats_1975_1999';
my $startTermsFile = '../../data/startCuis/randomCuis_T047';
my $outFile = '../../data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_T047';
my $useCooccurrenceCount = 1; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

$outFile = '../../data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_T047';
$useCooccurrenceCount = 0; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

#T121
$startTermsFile = '../../data/startCuis/randomCuis_T121';
$outFile = '../../data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_T121';
$useCooccurrenceCount = 1; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

$outFile = '../../data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_T121';
$useCooccurrenceCount = 0; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

#T184
$startTermsFile = '../../data/startCuis/randomCuis_T184';
$outFile = '../../data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_T184';
$useCooccurrenceCount = 1; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

$outFile = '../../data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_T184';
$useCooccurrenceCount = 0; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

#T200
$startTermsFile = '../../data/startCuis/randomCuis_T200';
$outFile = '../../data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_T200';
$useCooccurrenceCount = 1; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);

$outFile = '../../data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_T200';
$useCooccurrenceCount = 0; #if 0, then the count of co-occurring terms is used
&makeOccurrenceRateVector($occurrenceCountsFile, $startTermsFile, $outFile, $useCooccurrenceCount);



#################################################################
#     BEGIN CODE
#################################################################

#Makes a vector of occurrence counts
sub makeOccurrenceRateVector {
    my $occurrenceCountsFile = shift; 
    my $startTermsFile = shift;
    my $outFile = shift;
    my $useCooccurrenceCount = shift;

    #Read the occurrence count information
    my $occurrenceCountsRef = &readOccurrenceCountsFile($occurrenceCountsFile, $useCooccurrenceCount);

    #Read the start term information
    my $startTermsRef = &readStartTermsFile($startTermsFile);

    #create a vector file containing a line for each start
    # term, and its occurrence rate with every term in the 
    # occurrenceCounts file
    open OUT, ">$outFile" or die ("ERROR:unable to open outFile: $outFile\n");
    foreach my $startTerm (@{$startTermsRef}) {
	print OUT "$startTerm";
	foreach my $term (keys %{$occurrenceCountsRef}) {
	    print OUT "<>$term,".(${$occurrenceCountsRef}{$term});
	}
	print OUT "\n";
    }
     
    

}

#read stats for all the cuis in the occurrence counts file
# returns a hash of counts{$cui}=$countOfCooccurringTerms
sub readOccurrenceCountsFile {
    my $occurrenceCountsFile = shift;
    my $useCooccurrenceCount = shift;

    #read the counts of oc-occurring Terms
    open IN, $occurrenceCountsFile
        or die ("ERROR: unable to open occurrenceCountsFile: $occurrenceCountsFile\n");
    my %counts = ();
    while (my $line = <IN>) {
	chomp $line;
	my @vals = split (/ - /, $line);
        #line is cui - numCooccurrences - numCooccurringTerms\n

	#record either the co-occurrence count or the count of cooccurring terms
	if ($useCooccurrenceCount > 0) {
	    $counts{$vals[0]} = $vals[1];
	}
	else {
	    $counts{$vals[0]} = $vals[2];
	}
    }
    close IN;


    return \%counts;
}


#Reads a file of start terms, which contains a single cui
# on each line: cui\n
sub readStartTermsFile {
    my $cuiFile = shift;

    #read each line
    my @cuis = ();
    open IN, $cuiFile or die ("ERROR: unable to open cuiFile: $cuiFile");
    while (my $line = <IN>) {
        chomp $line;
        push @cuis, $line;
    }

    return \@cuis
}

