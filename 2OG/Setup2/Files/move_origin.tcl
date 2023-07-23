proc moveorigin {text} {
   set sel [atomselect top $text]
   set outfile   stdout
   set out 	 stdout	
   set nf [molinfo [$sel molid] get numframes]
   puts "number of frames : $nf"
   #set sel2 [atomselect top "all"]
   set frame 0
   for {set i 0 } { $i < $nf } {incr i } {
      $sel frame $i
      $sel update
      set shift [measure center $sel]
      set c1 [lindex $shift 0]
      set c2 [lindex $shift 1]
      set c3 [lindex $shift 2]

      set c1 [expr -$c1]
      set c2 [expr -$c2]
      set c3 [expr -$c3]

      set shiftnew "$c1 $c2 $c3"
      $sel moveby $shiftnew 

   }
   
}
