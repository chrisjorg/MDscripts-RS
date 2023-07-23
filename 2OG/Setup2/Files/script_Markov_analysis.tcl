proc markov { } {
	set first 0
	set last [molinfo top get numframes]
	set cutoff 4
        set output [open Markov_o2_$cutoff w]
        set population [open Markov_population w]
	for {set j 1} {$j<200} {incr j} {
	set histogram($j,E) 0
	set N_E_ij 0 
	set N_E_ji 0
	}
	for {set j 1} {$j<200} {incr j} {
	set E [atomselect top "protein and resid 239 252 256 258 299 301 564 565 566"]
        set E_cluster_O2 [atomselect top "segname O2 and (within $cutoff of protein and resid 239 252 256 258 299 301 564 565 566)"]
	set oxygen [atomselect top "segname O2 and resid $j"]
        for {set i $first} {$i<$last} {incr i} {
		$oxygen frame $i
		$oxygen update
		set oxygen_center [measure center $oxygen]
		set E_cluster [measure center $E weight mass]
		set vectorE [vecsub $oxygen_center $E_cluster]
		set length [veclength $vectorE]
		if {$length < $cutoff} { 
			set histogram($j,E) [expr $histogram($j,E) +1]
			puts "O2 $j within [veclength $vectorE] in frame $i of cluster E --- count $N_E_ij"
			}}
			unset E_cluster
			unset oxygen_center
			unset vectorE
			unset length 
			if {$histogram($j,E) >0} { 
			 set N_E_ij [expr $N_E_ij +1 ]
                         set N_E_ji [expr $N_E_ji +1 ]
			} 
			}
	set T_sum 0
	set T_ij  0
	set count 0
	set N_ij_sym [expr $N_E_ij + $N_E_ji]
	for {set j 1} {$j<200} {incr j} {
		puts "entering analysis section for O2 $j"
		if {$histogram($j,E) >=20} {
		puts "analysing O2 $j $histogram($j,E)"
		incr count
		set T_sum [expr $T_sum + $histogram($j,E)]}}
		if {$count > 0} {set T_ij [expr 0.1*($T_sum/$count)]}
		set k_ij [expr $N_ij_sym/($T_ij*$N_ij_sym)]
		set k_jj [expr -1/$T_ij]


# For transition j-->i: Calculate population of cluster i, Pi(t) as a function of time.
	set pop 0
	for {set i $first} {$i<$last} {incr i} { 
		set Pi($i) [expr exp($i*$k_ij)*200 + exp($i*$k_ig)*0] 
		set pop [expr $pop + Pi($i)]
		puts $population "frame $i population $pop"
		}	
        puts $output "K_ij $k_ij K_jj $k_jj T_ij $T_ij N_ij_sym $N_ij_sym"
        close $output
        }
markov
