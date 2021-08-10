set sel [atomselect top "all"]
set vec0 [lindex [measure minmax $sel] 0]
set vec1 [lindex [measure minmax $sel] 1]
set size [vecsub $vec0 $vec1]
set center [measure center $sel]

puts "-------------------------------------------------------"
puts " Copy/paste for NAMD: "
puts "cellBasisVector1 [ lindex $size 0 ] 0 0 "
puts "cellBasisVector2 0 [ lindex $size 1 ] 0 "
puts "cellBasisVector3 0 0 [ lindex $size 2 ] "
puts "cellOrigin [ lindex $center 0 ] [ lindex $center 1 ] [ lindex $center 2 ]"