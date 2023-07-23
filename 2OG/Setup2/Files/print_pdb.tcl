proc printpdb { first last } {
        set sel2 [atomselect top "protein"]
	
        for {set i $first} {$i<$last} {incr i} {
                $sel2 frame $i
                $sel2 update
		$sel2 writepdb pdb_$i\.pdb
        }}
