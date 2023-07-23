resetpsf
package require psfgen
topology top_all36_cgenff.rtf
topology top_all36_prot.rtf
topology toppar_water_ions.str
topology top.top
alias residue HIS HSD
alias atom ILE CD1 CD

segment U1 {pdb prot.pdb
            first ACE
            last  CT2
            }
coordpdb prot.pdb U1


segment U2 {pdb FE.pdb
            }
coordpdb FE.pdb U2

segment U4 {pdb ZN.pdb
            }
coordpdb ZN.pdb U4



segment AKG {pdb akg.pdb
            first NONE
            last NONE
            }
coordpdb akg.pdb AKG



guesscoord

writepdb system.pdb
writepsf system.psf
exit

