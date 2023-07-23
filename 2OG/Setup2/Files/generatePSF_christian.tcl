resetpsf
package require psfgen
topology top_all27_prot_lipid.inp
topology top.top
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

segment AKG {pdb akg.pdb
            first NONE
            last NONE
            }
coordpdb akg.pdb AKG

pdbalias residue HOH TIP3
segment SOLV {
auto none
pdb water.pdb
}
pdbalias atom HOH O OH2
coordpdb water.pdb SOLV

segment O2 {pdb o2_single.pdb
            first none
            last none
            }
coordpdb o2_single.pdb O2


guesscoord

writepdb system.pdb
writepsf system.psf
exit

