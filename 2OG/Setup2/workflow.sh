set sel [atomselect top "backbone and resid FE2 ZN2 AKG"]
$sel set beta 1
set sel [atomselect top all]
$sel writepdb fix_ionized.pdb 

set sel [atomselect top "backbone and resid FE2 ZN2 AKG"]
$sel set beta 5 
set sel [atomselect top all]
$sel writepdb fix_ionized_k.pdb 



