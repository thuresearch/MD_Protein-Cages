set protein [atomselect top "protein"]
set center [measure center $protein]
set center_x [lindex $center 0]
set center_y [lindex $center 1]
set center_z [lindex $center 2]
set sel [atomselect top "water and ((x-$center_x)^2+(y-$center_y)^2+(z-$center_z)^2)<50^2"]
set result [open water_num.txt w]
for {set i 1} {$i<=2002} {incr i 1} {
$protein frame $i
$protein update
$sel frame $i
$sel update
set num [expr [$sel num]/3]
puts $result "$i $num"
}
close $result

