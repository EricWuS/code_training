%hash = ();
$hash{Li} = "Fei";
$hash{Wu} = "FeiWan";
$hash{Liu} = "Hu";
$hash{Fan} = "Wei";

my $a;
while(1) {
    print "Enter Xing:";
    $a = <STDIN>;
    chomp $a;
    if($a ~~ "Exit") {
        die "Exit System\n";
    }else{
        print $hash{$a};
        print "\n";
    }

}