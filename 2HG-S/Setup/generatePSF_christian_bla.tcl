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



pdbalias residue HOH TIP3
segment WT1 {
auto none
pdb WT1.pdb
}
pdbalias atom HOH O OH2
coordpdb WT1.pdb WT1

pdbalias residue HOH TIP3
segment WT2 {
auto none
pdb WT2.pdb
}
pdbalias atom HOH O OH2
coordpdb WT2.pdb WT2


pdbalias residue HOH TIP3
segment WT3 {
auto none
pdb WT3.pdb
}
pdbalias atom HOH O OH2
coordpdb WT3.pdb WT3


pdbalias residue HOH TIP3
segment WT4 {
auto none
pdb WT4.pdb
}
pdbalias atom HOH O OH2
coordpdb WT4.pdb WT4


pdbalias residue HOH TIP3
segment WT5 {
auto none
pdb WT5.pdb
}
pdbalias atom HOH O OH2
coordpdb WT5.pdb WT5


pdbalias residue HOH TIP3
segment WT6 {
auto none
pdb WT6.pdb
}
pdbalias atom HOH O OH2
coordpdb WT6.pdb WT6


pdbalias residue HOH TIP3
segment WT7 {
auto none
pdb WT7.pdb
}
pdbalias atom HOH O OH2
coordpdb WT7.pdb WT7


pdbalias residue HOH TIP3
segment WT8 {
auto none
pdb WT8.pdb
}
pdbalias atom HOH O OH2
coordpdb WT8.pdb WT8




guesscoord

writepdb system.pdb
writepsf system.psf
exit

