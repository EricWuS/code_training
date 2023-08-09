 proc bubble_sort {list} {
        set n [llength $list]
        for {set i 0} {$i < [expr {$n - 1}]} {incr i} {
                for {set j 0} {$j < [expr {$n - 1 - $i}]} {incr j} {
                        set num1 [lindex $list $j]
                        set num2 [lindex $list [expr {$j + 1}]]
                        if {$num1 > $num2} {
                                set list [lreplace $list $j $j $num2]
                                set list [lreplace $list [expr {$j + 1}] [expr {$j + 1}] $num1]
                        }
                }
        }
        return $list
}

set my_list {2 9 0 4 1}
set sorted_list [bubble_sort $my_list]
puts $sorted_list