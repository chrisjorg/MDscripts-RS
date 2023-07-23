resetpsf
package require psfgen
topology top_all27_prot_lipid.inp
alias residue HIS HSD
alias atom ILE CD1 CD

segment U1 {pdb prot.pdb 
            first ACE
            last  CT2
            }
coordpdb prot.pdb U1

segment U2 {pdb codd.pdb 
            first ACE
            last  CT2
            }
coordpdb codd.pdb U2

segment U3 {pdb FE.pdb
            }
coordpdb FE.pdb U3

segment U4 {pdb AKG.pdb
            first none
            last none
            }
coordpdb AKG.pdb U4

pdbalias residue HOH TIP3
segment SOLV {
auto none
pdb water.pdb
}
pdbalias atom HOH O OH2
coordpdb water.pdb SOLV

guesscoord

writepdb system.pdb
writepsf system.psf
exit

