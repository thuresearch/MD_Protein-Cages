package require psfgen	 
topology ./toppar/top_all36_prot.rtf
pdbalias residue HIS HSE	 
pdbalias atom ILE CD1 CD	
pdbalias atom HOH O OH2
pdbalias residue HOH TIP3

mol new 1dat_24mer.pdb waitfor all
set protein [atomselect top protein]
set chains [lsort -unique [$protein get chain]]

foreach chain $chains {
  set sel [atomselect top "chain $chain"]
  $sel writepdb 1dat_${chain}.pdb
  segment $chain {
    auto none
    pdb 1dat_${chain}.pdb
  }
  coordpdb 1dat_${chain}.pdb $chain
  patch GLUP $chain:130
  patch GLUP $chain:137
  regenerate angles dihedrals
}

guesscoord
writepdb 1dat_24mer_psfgen.pdb	 
writepsf 1dat_24mer_psfgen.psf