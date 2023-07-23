proc distance_O2 { } {
	 set n [molinfo top get numframes]
		set list {5 29 37 45 137 156 168 171 185 199}	
		foreach resid $list { 
		set outfile [open distance_FE2_O2_$resid w]
		set sel [atomselect top "resname FE2"]
		set sel2 [atomselect top "segname O2 and resid $resid"]
		for { set frame 0 } { $frame < $n } { incr frame } {
		$sel frame $frame
		$sel2 frame $frame
		$sel  update
		$sel2 update
		set COM1 [measure center $sel]
		set COM2 [measure center $sel2]


		set Vector [vecsub $COM1 $COM2]


		set LengthVector [veclength [vecsub $COM1 $COM2]]

		puts $outfile "$frame $LengthVector"
		
		}
		close $outfile
}
		$sel delete
                $sel2 delete
}
