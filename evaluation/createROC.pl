#Program to take output and turn it into data for an ROC plot
use strict;
use warnings;
my $baseDir = '../../';

#user input
my $dataDir = $baseDir.'data/scoredPairs/';
my $resultsDir = $baseDir.'results/';

#all
my $semanticType = 'all';
&_createROCCurveForSemanticType($semanticType, $dataDir, $resultsDir);

#T047
$semanticType = 'T047';
&_createROCCurveForSemanticType($semanticType, $dataDir, $resultsDir);

#T121
$semanticType = 'T121';
&_createROCCurveForSemanticType($semanticType, $dataDir, $resultsDir);

#T184
$semanticType = 'T184';
&_createROCCurveForSemanticType($semanticType, $dataDir, $resultsDir);

#T200
$semanticType = 'T200';
&_createROCCurveForSemanticType($semanticType, $dataDir, $resultsDir);



##################################################################
#      Runners for All ranking methods and semantic types
###################################################################
#creates ROC curves for this semantic type for all ranking methods
sub _createROCCurveForSemanticType {
    my $semanticType = shift;
    my $dataDir = shift;
    my $resultsDir = shift;

    #Random
    my $method = 'random';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #Explicit Cosine
    $method = 'explicitCosine';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #word2vec Cosine
    $method = 'word2vecCosine';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #LTC 
    $method = 'ltc';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #LTA
    $method = 'lta';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #MWA
    $method = 'mwa';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #SBC
    $method = 'sbc';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #LSA
    $method = 'lsa';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #The default (so sort in descending order is a minCooccurrence threshold)
    #CooccurrenceCount
    $method = 'cooccurrenceCount';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #CooccurringTermCount
    $method = 'cooccurringTermCount';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir);

    #The default (so sort in descending order is a minCooccurrence threshold)
    #CooccurrenceCount
    my $sortAscending = 1;
    $method = 'cooccurrenceCount';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir, $sortAscending);

    #CooccurringTermsCount
    $sortAscending = 1;
    $method = 'cooccurringTermCount';
    &_createROCDataForNoiseTypes($method, $semanticType, $dataDir, $resultsDir, $sortAscending);
}

# creates ROC curves
sub _createROCDataForNoiseTypes {
    my $method = shift;
    my $semanticType = shift;
    my $dataDir = shift;
    my $resultsDir = shift;
    my $sortAscending = shift;

    #Create ROC for each noise type
    #ROC for common
    my $trueIn = $dataDir.'true_common_'.$semanticType.'_'.$method;
    my $falseIn = $dataDir.'false_common_'.$semanticType.'_'.$method;
    my $rocOut = $resultsDir.'roc_common_'.$semanticType.'_'.$method;
    &_createROCData($trueIn, $falseIn, $rocOut, $sortAscending);

    #ROC for mid
    $trueIn = $dataDir.'true_mid_'.$semanticType.'_'.$method;
    $falseIn = $dataDir.'false_mid_'.$semanticType.'_'.$method;
    $rocOut = $resultsDir.'roc_mid_'.$semanticType.'_'.$method;
    &_createROCData($trueIn, $falseIn, $rocOut, $sortAscending);
    
    #ROC for uncommon
    $trueIn = $dataDir.'true_uncommon_'.$semanticType.'_'.$method;
    $falseIn = $dataDir.'false_uncommon_'.$semanticType.'_'.$method;
    $rocOut = $resultsDir.'roc_uncommon_'.$semanticType.'_'.$method;
    &_createROCData($trueIn, $falseIn, $rocOut, $sortAscending);

    #ROC for all
    $trueIn = $dataDir.'true_all_'.$semanticType.'_'.$method;
    $falseIn = $dataDir.'false_all_'.$semanticType.'_'.$method;
    $rocOut = $resultsDir.'roc_all_'.$semanticType.'_'.$method;
    &_createROCData($trueIn, $falseIn, $rocOut, $sortAscending);
}


############################################
#       Begin Code
############################################
sub _createROCData {
    #grab the input
    my $trueIn = shift;
    my $falseIn = shift;
    my $rocOut = shift;
    my $sortAscending = shift;

    #add a sort ascedning label to output (descending is default)
    if (defined $sortAscending && $sortAscending > 0) {
	$rocOut .= '_sortAscending';
    }

    #read true data in (score<>cui<>cui on each line)
    my @trueScores = ();
    open IN, $trueIn or die ("ERROR: cannot open trueIn: $trueIn\n");
    while (my $line = <IN>) {
	my @vals = split (/ /,$line);
	my $score = $vals[2];
	push @trueScores, $score;
    }
    close IN;
    
    #read false data in (score<>cui<>cui on each line)
    my @falseScores = ();
    open IN, $falseIn or die ("ERROR: cannot open falseIn: $falseIn\n");
    while (my $line = <IN>) {
	my @vals = split (/ /,$line);
	my $score = $vals[2];
	push @falseScores, $score;
    }
    close IN;

    if (defined $sortAscending && $sortAscending > 0) {
        #sort the lists in ascending order - not default, must be specified 
	@trueScores =  sort { $a <=> $b } @trueScores;
	@falseScores = sort { $a <=> $b } @falseScores;
    }
    else {
	#Sorting in descending order is the default
        #sort the lists in descending order 
	@trueScores =  sort { $b <=> $a } @trueScores;
	@falseScores = sort { $b <=> $a } @falseScores;
    }

    #combine the false and true into a single ordered array
    my @scores = ();
    my @classes = ();
    my $trueIndex = 0;
    my $falseIndex = 0;
    my $scoresIndex = 0;
    while ($falseIndex < scalar @falseScores || $trueIndex < scalar @trueScores) {	
	#build the joined sorted list
	if ($trueIndex >= scalar @trueScores) {
	    #no more trues left, so add the false
	    $scores[$scoresIndex] = $falseScores[$falseIndex];
	    $classes[$scoresIndex] = 0;
	    $falseIndex++;
	}
	elsif ($falseIndex >= scalar @falseScores) {
	    #no more falses left, so add the true
	    $scores[$scoresIndex] = $trueScores[$trueIndex];
	    $classes[$scoresIndex] = 1;
	    $trueIndex++;
	}
	#Check the ordereing, if ascending then check for less than, 
	#   if descending check for greater than
	elsif (defined $sortAscending && $sortAscending > 0) {
	    #sorting in ascending order, find the less of the two
	    if ($trueScores[$trueIndex] < $falseScores[$falseIndex]) {
		#true is greater than false, so add the true
		$scores[$scoresIndex] = $trueScores[$trueIndex];
		$classes[$scoresIndex] = 1;
		$trueIndex++;
	    } 
	    else {
		#false is greater than true, so add the false
		$scores[$scoresIndex] = $falseScores[$falseIndex];
		$classes[$scoresIndex] = 0;
		$falseIndex++;
	    }
	}
	else {
	    #Sorting in descending order, find the greater of the two
	    if ($trueScores[$trueIndex] > $falseScores[$falseIndex]) {
		#true is greater than false, so add the true
		$scores[$scoresIndex] = $trueScores[$trueIndex];
		$classes[$scoresIndex] = 1;
		$trueIndex++;
	    } 
	    else {
		#false is greater than true, so add the false
		$scores[$scoresIndex] = $falseScores[$falseIndex];
		$classes[$scoresIndex] = 0;
		$falseIndex++;
	    }
	}
	$scoresIndex++;
    }

    #find the true positive and false posititve rates/fractions
    my $tpr = 0;
    my $fpr = 0;
    my @tpf = ();
    my @fpf = ();
    my $numPositive = scalar @trueScores;
    my $numNegative = scalar @falseScores;
    #also calculate auroc as the sum of rectangles under the
    # curve, that is sum of lenght*width at each datapoint
    my $auroc = 0;
    for (my $i = 0; $i < scalar @scores; $i++) {
	#increment true/false positive rates
	if ($classes[$i] == 0) {
	    $fpr++;
	}
	else {
	    $tpr++;
	}
	
	#calculate true/false positive fraction at this index
        $tpf[$i] = $tpr/$numPositive;
	$fpf[$i] = $fpr/$numNegative;
	
	#auroc += length*height
	# length is the x-axis width, the previouss fpf to current fpf
	# height is the y-axis height = tpf
	if ($i > 0) { #no width for first datapoint
	    $auroc += ($fpf[$i]-$fpf[$i-1])*$tpf[$i]
	}
    }

    #output the true/false positive rate in tab seperated columns
    open OUT, ">$rocOut" or die ("ERROR: unable to open rocOut: $rocOut\n");
    print OUT "$rocOut\tAUROC:\t$auroc\n";
    print OUT "False Positive Fraction\tTrue Positive Fraction\n";
    for (my $i = 0; $i < scalar @scores; $i++) {
	print OUT "$fpf[$i]\t$tpf[$i]\n";
    }
    close OUT;

    print "Done!\n";
}

