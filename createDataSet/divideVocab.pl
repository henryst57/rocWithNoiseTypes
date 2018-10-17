# Divide the vocabulary into buckets based on the number of terms 
# they co-occur with (based on 1, 2, 3, 4, 5, >5 STD)
#
# 
#
use strict;
use warnings;


#user input
my $countsFile = '../../data/occurrenceStats/occurrenceStats_all_wholeVocab';
my $outputBase = '../../data/vocabBuckets/vocab_bucket';
my $std = 5317;
&_bucketBySTD($countsFile, $outputBase, $std);


############################################
#                 BEGIN CODE
############################################

#Procedure to bucket terms based on the number of 
# terms they occur with
sub _bucketBySTD {
    #grab user input
    my $countsFile = shift;
    my $outputBase = shift;
    my $std = shift;

    #read the file and perform and output bucketing
    my $countsRef = &_readCountsFile($countsFile);
    &_outputByGroup($countsRef, $outputBase, $std);
}



#groups and outputs the cuis by their STD's
sub _outputByGroup {
    #grab the user input
    my $countsRef = shift;
    my $outputBase = shift;
    my $std = shift;

    #manually define the buckets based on STDs
    #low is 0-1 STD (bucket1)
    my $lowStart = 0;
    my $lowEnd = $std;
    #mid is 1-3 std (bucket2)
    my $midStart = $std;
    my $midEnd = $midStart+(2*$std);
    #high is 3-4 std (bucket3)
    my $highStart = $midEnd;
    my $highEnd = $midEnd+$std;
    #very high is 4-5 std (bucket4)
    my $veryHighStart = $highEnd;
    my $veryHighEnd = $veryHighStart+(2*$std); 
    #anythis above gets output as bucket5

    #open each of the bucket output files
    open OUT1, ">$outputBase".'1' or die ("ERROR: unable to open bucket 1 output\n");
    open OUT2, ">$outputBase".'2' or die ("ERROR: unable to open bucket 2 output\n");
    open OUT3, ">$outputBase".'3' or die ("ERROR: unable to open bucket 3 output\n");
    open OUT4, ">$outputBase".'4' or die ("ERROR: unable to open bucket 4 output\n");
    open OUT5, ">$outputBase".'5' or die ("ERROR: unable to open bucket 5 output\n");
    
    #bucket and output
    foreach my $cui (keys %{$countsRef}) {
	my $count = ${$countsRef}{$cui};

	#find which bucket
	if ($count <= $lowEnd) {
	    print OUT1 "$cui\n";
	}
	elsif ($count > $midStart && $count <= $midEnd) {
	    print OUT2 "$cui\n";
	}
	elsif ($count > $highStart && $count <= $highEnd) {
	    print OUT3 "$cui\n";
	}
	elsif ($count > $veryHighStart && $count <= $veryHighEnd) {
	    print OUT4 "$cui\n";
	}
	else {
	    print OUT5 "$cui\n";
	}
    }
    
    #close all output files
    close OUT1;
    close OUT2;
    close OUT3;
    close OUT4;
    close OUT5;
}


#reads the counts file into a hash counts{cui}=val
# This reads in the number of cooccurring terms
# as the value (since that is what we are using)
sub _readCountsFile {
    my $countsFile = shift;

    #read the number of co-occurrences per cui into a hash
    open IN, $countsFile or die ("ERROR: unable to open countsFile: $countsFile\n");
    my %counts = ();
    while (my $line = <IN>) {
	chomp $line;
	my @vals = split (/ - /, $line);
	#line is cui - numCooccurrences - numCooccurringTerms\n
	$counts{$vals[0]} = $vals[2];
    }
    close IN;
    return \%counts;
}
