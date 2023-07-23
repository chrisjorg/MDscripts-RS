proc analyse_O2 {name first last } {
foreach cutoff {8 9 10} {
	set output [open analysis_o2_$name\_$cutoff w]
	set output_occupancy [open analysis_o2_occupancy_$name\_$cutoff w]
	set output_perct [open analysis_o2_perct_$name\_$cutoff w]
	set output_perct_weighted [open analysis_o2_perct_weighted_$name\_$cutoff w]
	set output_time [open analysis_o2_time_$name\_$cutoff w]

        set sel2 [atomselect top "segname O2 and (within $cutoff of resname FE2)"]
        for {set i $first} {$i<$last} {incr i} {
                $sel2 frame $i
                $sel2 update
                set L [lsort -unique [$sel2 get resid]]
                lappend list $L
        }
        set L_tot [lsort -unique -increasing $list]
        set L_unique [join $L_tot]
        set L_unique_final [lsort -unique -real $L_unique]

	puts $output "Residue list $L_unique_final"
	foreach resid $L_unique_final {
		set sel [atomselect top "resname FE2"]
		set sel3 [atomselect top "segname O2 and resid $resid"]
		set histogram($resid) 0
		for {set i $first} {$i<$last} {incr i} { 
			$sel frame $i
			$sel3 frame $i
	
			set COM1 [measure center $sel]
			set COM2 [measure center $sel3]
	

			set Vector [vecsub $COM1 $COM2]
			set LengthVector [veclength [vecsub $COM1 $COM2]]
	
			if { $LengthVector < $cutoff } { 
			set histogram($resid) [expr $histogram($resid) + 1]
			} 
		}
        set occupancy($resid) [format %.3f [expr $histogram($resid)*1.0/$last]]
        set tim($resid) [format %.3f [expr $histogram($resid)*2.0/100]]
        set perct($resid) [format %.3f [expr $occupancy($resid)*100]]
        set time [expr $last*2/100]
	puts $output_occupancy "$resid $occupancy($resid)"
	if {$histogram($resid) >=50} {puts $output_perct_weighted "$resid $perct($resid)"}
	puts $output_perct "$resid $perct($resid)"
	if {$histogram($resid) >=50} {puts $output_time "$resid $tim($resid)"}

        if {$histogram($resid) >=50} {
	puts $output "Oxygen $resid occupancy $occupancy($resid) percent $perct($resid) % of trajectory
        Histogram of visit for Oxygen $resid is $histogram($resid)
        Trajectory has $last frames
        Cutoff is $cutoff A" }	
	
	}
	close $output
	close $output_occupancy
	close $output_time
	close $output_perct
	close $output_perct_weighted
}
}
