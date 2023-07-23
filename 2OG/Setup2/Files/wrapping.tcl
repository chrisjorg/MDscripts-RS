set n [molinfo top get numframes]

pbc wrap -centersel "resname FE2" -center com -compound res -first 0 -last $n


#source ../pbc.tcl

source ../center.tcl

center protein
