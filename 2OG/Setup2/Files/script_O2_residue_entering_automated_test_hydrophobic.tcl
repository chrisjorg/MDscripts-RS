proc residue_O2 {name cutoff first last } {
foreach oxygen {5 29 37 45 137 156 168 171 185 199} {
	set output [open residue_o2_$name\_$cutoff\_$oxygen w]
	set output_occupancy [open residue_o2_occupancy_$name\_$cutoff\_$oxygen w]
	set output_perct [open residue_o2_perct_$name\_$cutoff\_$oxygen w]
	set output_perct_weighted [open residue_o2_perct_weighted_$name\_$cutoff\_$oxygen w]
	set output_time [open residue_o2_time_$name\_$cutoff\_$oxygen w]
        set sel2 [atomselect top "(name HN HA HB HG HG1 HG2 HD3 HZ3 HB2 HD13 HD12 HD23 HD12 HD21 HD22 HH HE1 HH12 HH11 HH22 HH21) and (within $cutoff of (segname O2 and resid $oxygen))"]
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
	foreach res $L_unique_final {

		foreach atom {HN HA HB HG HG1 HG2 HD3 HZ3 HB2 HD13 HD12 HD23 HD12 HD21 HD22 HH HE1 HH12 HH11 HH22 HH21} {
			set sel [atomselect top "segname O2 and resid $oxygen"]
                	set sel3 [atomselect top "name $atom and resid $res"]
			set condition [$sel3 get resid]
	                if {$condition !=""} {

			#if {[string length $condition] != 0} {} #
			set histogram($res,$atom) 0
			for {set i $first} {$i<$last} {incr i} { 
				$sel frame $i
				$sel3 frame $i
	
				set COM1 [measure center $sel]
				set COM2 [measure center $sel3]
	

				set Vector [vecsub $COM1 $COM2]
				set LengthVector [veclength $Vector]
	
				if { $LengthVector < $cutoff } { 
				set histogram($res,$atom) [expr $histogram($res,$atom) + 1]
				} 
				}
			set identity [lsort -unique [[atomselect top "protein and resid $res"] get resname]]
        		set occupancy($res,$atom) [format %.3f [expr $histogram($res,$atom)*1.0/$last]]
		        set tim($res,$atom) [format %.3f [expr $histogram($res,$atom)*2.0/100]]
		        set perct($res,$atom) [format %.3f [expr $occupancy($res,$atom)*100]]
		        set time [expr $last*2/100]
			puts $output_occupancy "$res $occupancy($res,$atom)"
			if {$histogram($res,$atom) >=20} {puts $output_perct_weighted "$res $atom $perct($res,$atom)"}
			puts $output_perct "$res $perct($res,$atom)"
			if {$histogram($res,$atom) >=20} {puts $output_time "$res $atom $tim($res,$atom)"}

        		if {$histogram($res,$atom) >=20} {
			puts $output "Residue $identity $res $atom occupancy $occupancy($res,$atom) percent $perct($res,$atom) % of trajectory
        		Histogram of visit for Residue $res $atom is $histogram($res,$atom)
        		Trajectory has $last frames
       	          	Cutoff is $cutoff A" }	
			}}
		}
	close $output
	close $output_occupancy
	close $output_time
	close $output_perct
	close $output_perct_weighted
}
}

residue_O2 set1 4.5 0 15000
