#############################################################
## JOB DESCRIPTION                                         ##
#############################################################

# Min. and Eq. of KcsA
# embedded in POPC membrane, ions and water.
# Melting lipid tails. PME, Constant Volume.

#############################################################
## ADJUSTABLE PARAMETERS                                   ##
#############################################################

structure          1dat_24mer_psfgen.psf
coordinates        1dat_24mer_psfgen.pdb
outputName         1dat_24mer_eq.pdb

set temperature    300

# Continuing a job from the restart files
if {0} {
set inputname      kcsa-popcwi
binCoordinates     $inputname.restart.coor
binVelocities      $inputname.restart.vel  ;# remove the "temperature" entry if you use this!
extendedSystem	   $inputname.restart.xsc
} 

firsttimestep      0


#############################################################
## SIMULATION PARAMETERS                                   ##
#############################################################

# Input
paraTypeCharmm	    on
parameters          ./toppar/par_all36_prot.prm

# NOTE: Do not set the initial velocity temperature if you 
# have also specified a .vel restart file!
temperature         $temperature
 

# Periodic Boundary Conditions
# NOTE: Do not set the periodic cell basis if you have also 
# specified an .xsc restart file!
if {1} { 
cellBasisVector1    144.    0.   0.
cellBasisVector2     0.   144.   0.
cellBasisVector3     0.    0.  144.
cellOrigin          72 72 72
}
wrapWater           on
wrapAll             on


# Force-Field Parameters
exclude             scaled1-4
1-4scaling          1.0
cutoff              12.
switching           on
switchdist          10.
pairlistdist        13.5


# Integrator Parameters
timestep            2.0  ;# 2fs/step
rigidBonds          all  ;# needed for 2fs steps
nonbondedFreq       1
fullElectFrequency  2  
stepspercycle       20


#PME (for full-system periodic electrostatics)
if {1} {
PME                 yes
PMEGridSizeX       150
PMEGridSizeY       150
PMEGridSizeZ       150
}


# Constant Temperature Control
langevin            on    ;# do langevin dynamics
langevinDamping     1     ;# damping coefficient (gamma) of 5/ps
langevinTemp        $temperature

# Constant Pressure Control (variable volume)
if {0} {
useGroupPressure      yes ;# needed for 2fs steps
useFlexibleCell       yes  ;# no for water box, yes for membrane
useConstantArea       no  ;# no for water box, yes for membrane

langevinPiston        on
langevinPistonTarget  1.01325 ;#  in bar -> 1 atm
langevinPistonPeriod  200.
langevinPistonDecay   50.
langevinPistonTemp    $temperature
}


restartfreq        1000     ;# 1000steps = every 2ps
dcdfreq            1000
xstFreq            1000
outputEnergies      50
outputPressure      50


# Fixed Atoms Constraint (set PDB beta-column to 1)
#if {1} {
#fixedAtoms          on
#fixedAtomsFile      1dat_24mer_fix.pdb
#fixedAtomsCol       B
#fixedAtomsForces    on
#}

#############################################################
## EXTRA PARAMETERS                                        ##
#############################################################

# Put here any custom parameters that are specific to 
# this job (e.g., SMD, TclForces, etc...)

#############################################################
## EXECUTION SCRIPT                                        ##
#############################################################

# Minimization
if {1} {
minimize            1000
reinitvels          $temperature
}

run 250000 ;# 0.5 ns
