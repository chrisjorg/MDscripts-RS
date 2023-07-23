proc analyse_O2 {cutoff first last} {
	set output [open analysis_fe2_o2_$cutoff w]
	set sel2 [atomselect top "segname O2 and (within $cutoff of resname FE2)"]
	for {set i $first} {$i<$last} {incr i} { 
		$sel2 frame $i
		$sel2 update
		set L [lsort -unique [$sel2 get resid]]
		lappend list $L
		#puts $output "$i $L"
	}
	set L_tot [lsort -unique -increasing $list]
	#puts $output "list of unique residues is $L_final"
	
	set L_unique [join $L_tot]
	set L_unique_final [lsort -unique -real $L_unique]
	puts $output "$L_unique_final"
	close $output
	}
