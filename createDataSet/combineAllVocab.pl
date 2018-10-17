#combines bucketed vocab files into a single, all vocab file

my $rootDir = '../../data/vocabBuckets/';
my %vocab = ();
&_readFile($rootDir.'vocab_bucket1', \%vocab);
&_readFile($rootDir.'vocab_bucket2', \%vocab);
&_readFile($rootDir.'vocab_bucket3', \%vocab);
&_readFile($rootDir.'vocab_bucket4', \%vocab);
&_readFile($rootDir.'vocab_bucket5', \%vocab);



open OUT, ">allVocab_allBuckets" or die ("ERROR: cannot open output\n");
foreach my $term (keys %vocab) {
    print OUT "$term\n";
}
close OUT;
print "Done!\n";


sub _readFile {
    my $fileName = shift;
    my $vocabRef = shift;

    open IN, $fileName or die ("ERROR: cannot open fileName: $fileName\n");
    while (my $line = <IN>) {
	chomp $line;
	${$vocabRef}{$line}=1;
    }
    close IN;
}
