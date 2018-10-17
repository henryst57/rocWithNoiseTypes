#Combines a bucket file with a vector file to create True/False files
# which can be used to generate ROC curves
use strict;
use warnings;
my $rootDir = '../../';

#User Input
my $postCutoffFile = $rootDir.'data/matrices/1975_2015_window8_threshold1';
my $preCutoffFile = $rootDir.'data/matrices/1975_1999_window8_ordered_threshold1';
my $bucketDir = $rootDir.'data//vocabBuckets/';
my $outputDir = $rootDir.'data/trueFalse/';

#true false for all
my $semanticType = 'all';
my $startCuisFile = $rootDir.'data/startCuis/randomCuis_all';
&_generateTrueFalse($postCutoffFile, $preCutoffFile, $startCuisFile, $bucketDir, $outputDir, $semanticType);


#true false for semantic types
$semanticType = 'T047';
$startCuisFile = $rootDir.'data/startCuis/randomCuis_'.$semanticType;
&_generateTrueFalse($postCutoffFile, $preCutoffFile, $startCuisFile, $bucketDir, $outputDir, $semanticType);
$semanticType = 'T121';
$startCuisFile = $rootDir.'data/startCuis/randomCuis_'.$semanticType;
&_generateTrueFalse($postCutoffFile, $preCutoffFile, $startCuisFile, $bucketDir, $outputDir, $semanticType);
$semanticType = 'T184';
$startCuisFile = $rootDir.'data/startCuis/randomCuis_'.$semanticType;
&_generateTrueFalse($postCutoffFile, $preCutoffFile, $startCuisFile, $bucketDir, $outputDir, $semanticType);
$semanticType = 'T200';
$startCuisFile = $rootDir.'data/startCuis/randomCuis_'.$semanticType;
&_generateTrueFalse($postCutoffFile, $preCutoffFile, $startCuisFile, $bucketDir, $outputDir, $semanticType);



#####################################################
#                  BEGIN CODE
#####################################################

#Runs all buckets for a method
sub _generateTrueFalse {
    my $postCutoffFile = shift;
    my $preCutoffFile = shift;
    my $startCuisFile = shift;
    my $bucketDir = shift;
    my $outputDir = shift;
    my $semanticType = shift;

    #read input, the start cuis, pre and post cutoff matrices
    # for the start terms, and vocabulary
    my $startCuis = &_readStartCuisFile($startCuisFile);
    my ($postCutoffPairs, $futureVocabulary) = &_readMatrixFile($postCutoffFile, $startCuis);
    my ($preCutoffPairs, $vocabulary) = &_readMatrixFile($preCutoffFile, $startCuis);

    #construct the gold standard of start terms to target terms
    # such that target terms are in the pre-cutoff vocab and
    # are not already known (so in the pre-cutoff matrix)
    my %truePairs = ();
    foreach my $pair (keys %{$postCutoffPairs}) {
	#grab the cuis from the pair
	my  ($cui1, $cui2) = split(/,/, $pair);
	if (!defined $cui1 || !defined $cui2) {
	    die ("ERROR: cui1 and/or cui2 is not defined in postCutoffPairs, pair = $pair\n");
	}

	#ensure cui2 is in the past vocab
	if (defined ${$vocabulary}{$cui2}) {
	    #ensure cui1,cui2 pair is a new discovery (not known
	    # in the pre-cutoff dataset)
	    if (!defined ${$preCutoffPairs}{$pair}) {
		$truePairs{$pair} = 1;
	    }
	}
    }
    
    #generate false pairs, which are all possible start-term
    # pairs that are not in the pre-cutoff (so already known)
    # and not in the gold (so a true sample)
    my %falsePairs = ();
    foreach my $startCui (keys %{$startCuis}) {
	foreach my $term (keys %{$vocabulary}) {	    
	    #skip already known pairs
	    if (defined ${$preCutoffPairs}{"$startCui,$term"}) {
		next;
	    }
	    #skip true pairs
	    if (defined $truePairs{"$startCui,$term"}) {
		next;
	    }
	    #not known and not gold, so a false sample
	    $falsePairs{"$startCui,$term"} = 1;
	}
    }

    #So, at this point we have a list of all true pairs and
    # all false pairs for the start cuis, now we will output 
    # them by bucket (all, 1, 2, 3, 4, 5)
    my $bucketNumber = 'all';
    my $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    my $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    my $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);
    
    $bucketNumber = '1';
    $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);
    
    $bucketNumber = '2';
    $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);
    
    $bucketNumber = '3';
    $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);
    
    $bucketNumber = '4';
    $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);
    
    $bucketNumber = '5';
    $bucketFile = $bucketDir.'vocab_bucket'.$bucketNumber;
    $trueOut = $outputDir.'true_'.$bucketNumber.'_'.$semanticType;
    $falseOut = $outputDir.'false_'.$bucketNumber.'_'.$semanticType;
    &_outputBucketPairs(\%truePairs, \%falsePairs, $bucketFile, $trueOut, $falseOut);

    print "Done!\n";
}

# Reads pairs for each bucket and output the pairs that
# are true or false for each bucket and relevant to 
# these start cuis
sub _outputBucketPairs {
    my $truePairs = shift;
    my $falsePairs = shift;
    my $bucketFile = shift;
    my $trueOut = shift;
    my $falseOut = shift;
 
    #read the cuis in this bucket
    my $bucketCuis = &_readBucketFile($bucketFile);

    #output each true in this bucket
    open OUT, ">$trueOut" or die ("ERROR: unable to open trueOut: $trueOut\n");
    foreach my $pair (keys %{$truePairs}) {
	my ($start, $target) = split(/,/, $pair);
	if (defined ${$bucketCuis}{$target}) {
	    print OUT "$start $target\n";
	}
    }
    close OUT;
    
    #output each false in this bucket
    open OUT, ">$falseOut" or die ("ERROR: unable to open falseOut\n");
    foreach my $pair (keys %{$falsePairs}) {
	my ($start, $target) = split(/,/, $pair);
	if (defined ${$bucketCuis}{$target}) {
	    print OUT "$start $target\n";
	}
    }
    close OUT;
}



#reads a bucket file, which contains a single cui per line
# and indicates that cui is in this bucket
sub _readBucketFile {
    my $fileName = shift;
    open IN, $fileName or die ("ERROR: cannot open bucketFile: $fileName\n");
    my %cuis = ();
    while (my $line = <IN>) {
	chomp $line;
	$cuis{$line} = 1;
    }
    return \%cuis;
}

#reads cuis pairs from a matrix file. Only cui pairs starting 
# with one of the defined start terms are read. Return matrix is
# hash{cui1,cui2}=1
sub _readMatrixFile {
    my $matrixFile = shift;
    my $startCuis = shift;

    #read in pairs containing the start cuis
    open IN, $matrixFile or die ("ERROR: unable to open matrixFile: $matrixFile\n");
    my %matrix = ();
    my %vocab = ();
    while (my $line = <IN>) {
	#grab the values
	my @vals = split (/\t/,$line);
	my $cui1 = $vals[0];
	my $cui2 = $vals[1];
	if (!defined $cui1 || !defined $cui2) {
	    die ("ERROR: cui1 and/or cui2 not defined, line = $line");
	}

	#save the values if cui1 is a start cui
	if (defined ${$startCuis}{$cui1}) {
	    $matrix{"$cui1,$cui2"}=1;
	}

	#update the vocabulary
	$vocab{$cui1} = 1;
	$vocab{$cui2} = 1;
    }
    close IN;

    return \%matrix, \%vocab;
}

#reads a start terms file where each line contains just a single cui
sub _readStartCuisFile {
    my $cuiFile = shift;

    #read each line 
    open IN, $cuiFile or die ("ERROR: unable to open cuiFile: $cuiFile");
    my %cuis = ();
    while (my $line = <IN>) {
	chomp $line;
	$cuis{$line} = 1;
    }

    return \%cuis
}
