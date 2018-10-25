#Gets occurrence statistics for cuis in the vector file
use strict;
use warnings;

#User Input
my $matrixFile = '../../data/matrices/1975_2015_window8_threshold1';
my $outFile = '../../data/occurrenceStats/occurrenceStats_1975_2015_TAKE2';
&_getVectorStats($matrixFile, $outFile);





###########################################
#      Get Vector Stats
############################################

#Gets and outputs stats for all terms in the vocabulary
sub _getVectorStats {
    my $matrixfile = shift;
    my $outFile = shift;

    my $allVocabRef = &_readVocabulary($matrixFile);
    my $targetVectorsRef = &readMatrixFile($matrixFile, $allVocabRef);
    &_outputStats($targetVectorsRef, $outFile);
}


#Outputs the stats
sub _outputStats {
    #grab the input
    my $vectorsRef = shift;
    my $outFile = shift;

    #get stats for each vector
    my %cooccurrences = ();
    my %cooccurringTerms = ();
    foreach my $vectorCui (keys %{$vectorsRef}) {
	my $vectorRef = ${$vectorsRef}{$vectorCui};
	
	my $numCooccurrences = 0;
	my $numCooccurringTerms = scalar keys %{$vectorRef};
	foreach my $cui (keys %{$vectorRef}) {
	    $numCooccurrences += ${$vectorRef}{$cui}
	}
       
	$cooccurrences{$vectorCui} = $numCooccurrences;
	$cooccurringTerms{$vectorCui} = $numCooccurringTerms;
    }
    
    #compute mean and counts
    my $meanCooccurrences = 0;
    my $meanCooccurringTerms = 0;
    my $meanNonZeroCooccurrences = 0;
    my $meanNonZeroCooccurringTerms = 0;
    my $numTerms = scalar keys %{$vectorsRef};
    my $numNonZeroTerms = 0;
    open OUT, ">$outFile" or die ("ERROR: unable to open outFile: $outFile\n");
    foreach my $cui (keys %cooccurringTerms) {
	#calculate all means and counts
	print OUT "$cui - $cooccurrences{$cui} - $cooccurringTerms{$cui}\n";
	$meanCooccurrences += $cooccurrences{$cui};
	$meanCooccurringTerms += $cooccurringTerms{$cui};
	
	#calculate nonZero means and counts
	if ($cooccurrences{$cui} > 0) {
	    $numNonZeroTerms++;
	    $meanNonZeroCooccurrences += $cooccurrences{$cui};
	    $meanNonZeroCooccurringTerms += $cooccurringTerms{$cui};
	}
    }
    close OUT;
    #take the means
    $meanCooccurringTerms /= $numTerms;
    $meanCooccurrences /= $numTerms;
    $meanNonZeroCooccurrences /= $numNonZeroTerms;
    $meanNonZeroCooccurringTerms /= $numNonZeroTerms;

    #compute standard deviation
    my $cooccurrencesSTD = 0;
    my $cooccurringTermsSTD = 0;
    my $nonZeroCooccurrencesSTD = 0;
    my $nonZeroCooccurringTermsSTD = 0;
    foreach my $cui (keys %cooccurringTerms) {
	#calculate all STD
        my $diff = $cooccurrences{$cui} - $meanCooccurrences;
        $cooccurrencesSTD += ($diff * $diff);

	$diff = $cooccurringTerms{$cui} - $meanCooccurringTerms;
	$cooccurringTermsSTD += ($diff * $diff);

	#calculate nonzero STD
	if ($cooccurrences{$cui} > 0) {
	    my $diff = $cooccurrences{$cui} - $meanCooccurrences;
	    $nonZeroCooccurrencesSTD += ($diff * $diff);
	    
	    $diff = $cooccurringTerms{$cui} - $meanCooccurringTerms;
	    $nonZeroCooccurringTermsSTD += ($diff * $diff);
	}
    }
    #compute STD from sums
    $cooccurrencesSTD = sqrt($cooccurrencesSTD/$numTerms);
    $cooccurringTermsSTD = sqrt($cooccurringTermsSTD/$numTerms);
    $nonZeroCooccurrencesSTD = sqrt($nonZeroCooccurrencesSTD/$numNonZeroTerms);
    $nonZeroCooccurringTermsSTD = sqrt($nonZeroCooccurringTermsSTD/$numNonZeroTerms);
   

    #output Results
    print "All Stats:\n";
    print "   numTerms = $numTerms\n\n";
    print "   mean Cooccurring Terms = $meanCooccurringTerms\n";
    print "   Cooccuring Terms STD = $cooccurringTermsSTD\n\n";
    print "   mean Cooccurrences = $meanCooccurrences\n";
    print "   Cooccurrences STD = $cooccurrencesSTD\n";
    print "\n";
    print "NonZero Stats:\n";
    print "   num nonZero terms = $numNonZeroTerms\n\n";
    print "   mean nonZero Cooccuring Terms = $meanNonZeroCooccurringTerms\n";
    print "   nonZero Cooccurring Terms STD = $nonZeroCooccurringTermsSTD\n\n";
    print "   mean nonZero Cooccurrences = $meanNonZeroCooccurrences\n";
    print "   nonZero Cooccurrences STD = $nonZeroCooccurrencesSTD\n";
}



#Reads vectors from a vector file
sub readVectorFile {
    my $vectorFile = shift;

    #read each vector
    open IN, $vectorFile or die ("ERROR: unable to open vectorFile: $vectorFile\n");
    my %vectors = ();
    my %vocabulary = ();
    while (my $line = <IN>) {
        #seperate the line into value pairs
	chomp $line;
	if ($line eq '') {
	    next;
	}
        my @vals = split('<>',$line);

        #the first value of the line the cui that the vector is for
        # create that vector and add to the vectorsHash
	my $vectorCui = shift @vals;
        my %vector = ();
        $vectors{$vectorCui} = \%vector;

        #populate the vector with the cui,value pairs
	foreach my $valPair (@vals) {
            (my $cui, my $val) = split(',',$valPair);
            $vector{$cui} = $val;
	    $vocabulary{$cui} = 1;
        }
    }
    
    #return the vectors hash
    return \%vectors, \%vocabulary;;
}



#reads the cuis from the matrix file
sub readMatrixFile {
    my $fileName = shift;
    my $vocabularyRef = shift;

    #read the matrix
    my %vectors = ();
    open IN, $fileName or die ("ERROR: unable to open matrix file: $fileName\n");
    while (my $line = <IN>) {
	chomp $line;
	my ($cui1, $cui2, $score) = split(/\t/, $line);

	#grab the vector if needed
	if (defined ${$vocabularyRef}{$cui1}) {
	    if (!defined $vectors{$cui1}) {
		my %emptyHash = ();
		$vectors{$cui1} = \%emptyHash;
	    }
	    ${$vectors{$cui1}}{$cui2} = $score;
	}
    }
    close IN;

    return \%vectors;
}



#reads the vocabulary from the matrix file
sub _readVocabulary {
    my $fileName = shift;
    
    #read the vocab from the matrix
    my %vocabulary = ();
    open IN, $fileName or die ("ERROR: unable to open matrix file: $fileName\n");
    while (my $line = <IN>) {
	chomp $line;
	my ($cui1, $cui2, $score) = split(/\t/, $line);

	$vocabulary{$cui1} = 1;
	$vocabulary{$cui2} = 1;
    }
    close IN;

    return \%vocabulary;
}
