proc area {x1 y1 x2 y2} {
    set width [expr abs($x1 - $x2)]
    set longth [expr abs($y1 - $y2)]
    set area [expr $width * $longth]
    return $area
}

set a 6
set b 6
set c 0
set d 0
set area [area $a $b $c $d]
puts "area = $area"