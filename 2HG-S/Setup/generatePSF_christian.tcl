resetpsf
package require psfgen
topology top_all36_cgenff.rtf
topology top_all36_prot.rtf
topology toppar_water_ions.str
topology 2HG-R.top
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



segment 2HGS {pdb 2HG-S.pdb
            first NONE
            last NONE
            }
coordpdb 2HG-S.pdb 2HGS




guesscoord

writepdb system.pdb
writepsf system.psf
exit

