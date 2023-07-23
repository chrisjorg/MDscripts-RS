proc concentration_O2 {name first last } {
        set output [open concentration_o2_inside_protein_$name w]

        for {set i $first} {$i<$last} {incr i} {
	set histogram($i) 0
        for {set j 1} {$j<200} {incr j} {
                        set sel [atomselect top "protein and within 3 of segname O2 and resid $j"]
	                $sel frame $i
	                $sel update
			set L [lsort -unique -increasing [$sel get index]]
			if {$L !=""} {
                        set histogram($i) [expr $histogram($i) +1]
			}}
        set perct($i) [format %.3f [expr $histogram($i)*100/200]]
        puts $output "$i $histogram($i)"
        }
        close $output
}
