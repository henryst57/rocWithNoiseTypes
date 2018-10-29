# Assigns scores to the term pairs in the true and false files
# Scores are grabbed from the provided vector file
use strict;
use warnings;
my $rootDir = '../../';

#User Input
# Run for all
my $semanticType = 'all';
my $pairsDir = $rootDir.'data/trueFalse/';
my $label = 'cooccurrenceCount';
my $vectorFile = $rootDir.'data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'cooccurringTermCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'explicitCosine';
$vectorFile = $rootDir.'data/vectors/vectors_explicitCosine_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ltc';
$vectorFile = $rootDir.'data/vectors/vectors_freq_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'random';
$vectorFile = $rootDir.'data/vectors/vectors_random_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'word2vecCosine';
$vectorFile = $rootDir.'data/vectors/vectors_word2vecCosine_1975_1999_window8_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lsa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lsa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lta';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'mwa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_mwa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'sbc';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_sbc';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ideal';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_2015_window8_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);


# Run for T047
$semanticType = 'T047';
$pairsDir = $rootDir.'data/trueFalse/';
$label = 'cooccurrenceCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'cooccurringTermCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'explicitCosine';
$vectorFile = $rootDir.'data/vectors/vectors_explicitCosine_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);


$label = 'ltc';
$vectorFile = $rootDir.'data/vectors/vectors_freq_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'random';
$vectorFile = $rootDir.'data/vectors/vectors_random_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'word2vecCosine';
$vectorFile = $rootDir.'data/vectors/vectors_word2vecCosine_1975_1999_window8_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lsa';
$vectorFile = $rootDir.'/data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lsa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lta';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'mwa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_mwa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'sbc';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_sbc';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ideal';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_2015_window8_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);



# Run for T121
$semanticType = 'T121';
$pairsDir = $rootDir.'data/trueFalse/';
$label = 'cooccurrenceCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'cooccurringTermCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'explicitCosine';
$vectorFile = $rootDir.'data/vectors/vectors_explicitCosine_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ltc';
$vectorFile = $rootDir.'data/vectors/vectors_freq_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'random';
$vectorFile = $rootDir.'data/vectors/vectors_random_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'word2vecCosine';
$vectorFile = $rootDir.'data/vectors/vectors_word2vecCosine_1975_1999_window8_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lsa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lsa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lta';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'mwa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_mwa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'sbc';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_sbc';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ideal';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_2015_window8_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);



# Run for T184
$semanticType = 'T184';
$pairsDir = $rootDir.'data/trueFalse/';
$label = 'cooccurrenceCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'cooccurringTermCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'explicitCosine';
$vectorFile = $rootDir.'data/vectors/vectors_explicitCosine_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ltc';
$vectorFile = $rootDir.'data/vectors/vectors_freq_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'random';
$vectorFile = $rootDir.'data/vectors/vectors_random_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'word2vecCosine';
$vectorFile = $rootDir.'data/vectors/vectors_word2vecCosine_1975_1999_window8_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lsa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lsa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lta';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'mwa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_mwa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'sbc';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_sbc';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ideal';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_2015_window8_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);


# Run for T200
$semanticType = 'T200';
$pairsDir = $rootDir.'data/trueFalse/';
$label = 'cooccurrenceCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurrenceCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'cooccurringTermCount';
$vectorFile = $rootDir.'data/vectors/vectors_cooccurringTermCount_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'explicitCosine';
$vectorFile = $rootDir.'data/vectors/vectors_explicitCosine_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ltc';
$vectorFile = $rootDir.'data/vectors/vectors_freq_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'random';
$vectorFile = $rootDir.'data/vectors/vectors_random_1975_1999_window8_ordered_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'word2vecCosine';
$vectorFile = $rootDir.'data/vectors/vectors_word2vecCosine_1975_1999_window8_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lsa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lsa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'lta';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_lta';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'mwa';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_mwa';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'sbc';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_1999_window8_ordered_threshold1_randomCuis_all_sbc';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);

$label = 'ideal';
$vectorFile = $rootDir.'data/vectors/vectors_x2_1975_2015_window8_threshold1_randomCuis_all';
&_assignScoresForAll($rootDir, $pairsDir, $label, $vectorFile, $semanticType);




#########################################################
#                   Begin Code
########################################################

#Assigns scores to all pair files for all bucket numbers
# true_1,2,3,4,5,all false 1,2,3,4,5,all
sub _assignScoresForAll {
    my $rootDir = shift;
    my $pairsDir = shift;
    my $label = shift;
    my $vectorfile = shift;
    my $semanticType = shift;
    
    #read the vectors of scores
    my $vectorsRef = &_readVectorFile($vectorFile);

    #assign scores for all true samples
    for (my $bucketNumber = 1; $bucketNumber <= 5; $bucketNumber++) {
	my $outFile = $rootDir.'data/scoredPairs/true_'.$bucketNumber.'_'.$semanticType.'_'.$label;
	my $pairsFile = $pairsDir.'true_'.$bucketNumber.'_'.$semanticType;
	&_assignScores($vectorfile, $pairsFile, $outFile, $vectorsRef);
    }

    #assign scores for all false samples
    for (my $bucketNumber = 1; $bucketNumber <= 5; $bucketNumber++) {
	my $outFile = $rootDir.'data/scoredPairs/false_'.$bucketNumber.'_'.$semanticType.'_'.$label;
	my $pairsFile = $pairsDir.'false_'.$bucketNumber.'_'.$semanticType;
	&_assignScores($vectorfile, $pairsFile, $outFile, $vectorsRef);
    }

    #assign scores for the all files
    my $outFile = $rootDir.'data/scoredPairs/true_all_'.$semanticType.'_'.$label;
    my $pairsFile = $pairsDir.'true_all_'.$semanticType;
    &_assignScores($vectorfile, $pairsFile, $outFile, $vectorsRef);
    $outFile = $rootDir.'data/scoredPairs/false_all_'.$semanticType.'_'.$label;
    $pairsFile = $pairsDir.'false_all_'.$semanticType;
    &_assignScores($vectorfile, $pairsFile, $outFile, $vectorsRef);

    print "Done with $label\n";
}

#assigns scores from the vector file to each term pair
sub _assignScores {
    my $vectorFile = shift;
    my $pairsFile = shift;
    my $outFile = shift;
    my $vectorsRef = shift;

    #output scores assigned to each pair while reading the pairs in
    open IN, $pairsFile or die ("ERROR: unable to open pairsFile: $pairsFile\n");
    open OUT, ">$outFile" or die ("ERROR: unable to open outFile: $outFile\n");
    while (my $line = <IN>) {
	#grab the cui pair
	chomp $line;
	my @vals = split (/ /, $line);
	my $cui1 = $vals[0];
	my $cui2 = $vals[1];

	#output the score if no formatting error
	if (defined $cui1 && defined $cui2) {
	    #grab the score if defined
	    my $score = -1;
	    if (defined ${${$vectorsRef}{$cui1}}{$cui2}) {
		$score = ${${$vectorsRef}{$cui1}}{$cui2};
	    }

	    #output the scored pair
	    print OUT "$cui1 $cui2 $score\n";

	} else {
	    die ("ERROR: cui1 and cui2 are not defined: $line\n");
	}
    }
}


#reads vectors from a vector file
sub _readVectorFile {
    my $vectorFile = shift;

    #read each vector
    open IN, $vectorFile or die ("ERROR: unable to open vectorFile: $vectorFile\n");
    my %vectors = ();
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
        }
    }

    #return the vectors hash
    return \%vectors;
}

