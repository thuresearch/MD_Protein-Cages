set sol_infile 1dat_24mer_psfgen
set kcsa_inbase kcsav
set outbase 1dat_24mer_wb
package require psfgen
resetpsf
topology ./toppar/top_all36_prot.rtf
segment SOLV {
auto none
first NONE
last NONE
pdb $sol_infile
}
coordpdb $sol_infile SOLV
readpsf ${kcsa_inbase}.psf
coordpdb ${kcsa_inbase}.pdb
writepdb ${outbase}.pdb
writepsf ${outbase}.psf
exit

