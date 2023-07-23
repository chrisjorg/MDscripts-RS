resetpsf
package require psfgen
topology top_all27_prot_lipid.inp
alias residue HIS HSD
alias atom ILE CD1 CD

segment U4 {pdb AKG.pdb
            first none
            last none
            }
coordpdb AKG.pdb U4

guesscoord

writepdb system.pdb
writepsf system.psf
exit

