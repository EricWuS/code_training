set sum 0
set INFILE [open addfile.txt r]
while {[gets $INFILE line] >= 0} {
    if {[regexp {^num\s+=\s(\d+\.\d+?)} $line total num]} {
        set sum [expr {$sum + $num}]
        puts "num = $num"
    }
}
close $INFILE 
puts "sum = $sum"