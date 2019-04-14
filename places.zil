"PLACES for TRINITY: (C)1986 Infocom, Inc. All rights reserved."
 			
"*** GARDENS ***"

<OBJECT PAL-GATE
	(LOC ROOMS)
	(DESC "Palace Gate")
	(FLAGS LIGHTED LOCATION WINDY)
	(GLOBAL EWIND WWIND GPRAM GARDENS IFENCE PIGEONS NANNIES
	 	CHILDREN TOURISTS BABIES GTREES LONDON LCITY)
	(SEE-N BWALK)
	(SEE-S PGATE)
	(SEE-E FLWALK)
	(SEE-W IFENCE)
	(SEE-NE GTREES)
	(SEE-ALL IFENCE)
	(NORTH TO BROAD-WALK)
	(NE TO WABE)
	(EAST TO FLOWER-WALK)
	(SE PER IFENCE-BLOCKS)
	(SOUTH PER EXIT-GARDEN)
	(SW PER IFENCE-BLOCKS)
	(WEST PER IFENCE-BLOCKS)
	(NW PER IFENCE-BLOCKS)
	(OUT PER EXIT-GARDEN)
	(IN PER WHICH-WAY-IN)
	(ACTION PAL-GATE-F)>

<ROUTINE PAL-GATE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A tide of " D ,GPRAM " surges ">
		<COND (<ZERO? ,RAID?>
		       <TELL "north along the crowded " 
			     D ,BROAD-WALK ". Shad">)
		      (T
		       <TELL "through the mob around the Gate. " D ,D0>)>
		<TELL "ed glades stretch away" ,TON 
"east, and a hint of color marks the western edge of the " D ,FLWALK ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<NOT <IS? ,EWIND ,TOUCHED>>
		       <MAKE ,EWIND ,TOUCHED>
		       <TELL CTHE ,EWIND 
" makes it difficult to walk straight" ,PCR>)>
		<COND (<MISSED-MEEP?>
		       <CRLF>)>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE EXIT-GARDEN ()
	 <COND (<T? ,IN-PRAM?>
		<PERFORM ,V?EXIT ,PRAM>
		<RFALSE>)>
	 <TELL "A surge of ">
	 <SAY-TOURISTS>
	 <BLOCKS-YOUR-PATH>
	 <RFALSE>>

<ROUTINE SAY-TOURISTS ()
	 <COND (<T? ,RAID?>
		<COND (<PROB 50>
		       <TELL "frightened ">)
		      (T
		       <TELL "panic-stricken ">)>)>
	 <COND (<PROB 50>
		<COND (<ZERO? ,RAID?>
		       <TELL <PICK-NEXT <GET ,P-TYPES 0>>>)>
		<TELL D ,NANNIES>
		<RTRUE>)>
	 <COND (<ZERO? ,RAID?>
		<TELL <PICK-NEXT <GET ,P-TYPES 1>>>)>
	 <TELL D ,TOURISTS>
	 <RTRUE>>

<GLOBAL P-TYPES:TABLE
	<PTABLE
	 <LTABLE 2 "offended " "haughty " "starched ">
	 <LTABLE 2 "gawking " "babbling " "fat ">>>

<OBJECT FLOWER-WALK
	(LOC ROOMS)
	(DESC "Flower Walk")
	(FLAGS LIGHTED LOCATION WINDY)
	(ODOR BEDS)
	(SEE-N GTREES)
	(SEE-S MEMORIAL)
	(SEE-E TOURISTS)
	(SEE-W GTREES)
	(SEE-NW GTREES)
	(SEE-ALL BEDS)	
	(GLOBAL EWIND WWIND GPRAM PIGEONS GARDENS LONDON LCITY
	        NANNIES CHILDREN TOURISTS BABIES GTREES FLOWERS)
	(NORTH TO LAN-WALK)
	(NE SORRY "There's no need to trample on the flowers.")
	(EAST PER EXIT-GARDEN)
	(SE SORRY "There's no need to trample on the flowers.")
	(SOUTH SORRY 
"You're already as close as anyone wants to get to the Albert Memorial.")
	(SW SORRY "There's no need to trample on the flowers.")
	(WEST TO PAL-GATE)
	(NW TO WABE)
	(OUT PER GARDEN-OUT)
	(ACTION FLOWER-WALK-F)>

<ROUTINE FLOWER-WALK-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Gaily colored " D ,BEDS 
" line the walks bending north and west, filling the air with a gentle fragrance. A little path leads northwest, between the trees." CR>
		<COND (<SEE-ANYTHING-IN? ,BEDS>
		       <CRLF>
		       <LOOK-IN-BEDS>)>
		<TELL CR "The spires of the " D ,MEMORIAL 
		      " are all too visible" ,TOS ". ">
		<COND (<ZERO? ,RAID?>
		       <TELL "Passing " D ,TOURISTS 
			     " hoot with laughter at the dreadful sight; "
			     D ,NANNIES 
			     " hide their faces and roll quickly away." CR>
		       <RTRUE>)>
		<TELL "Frightened " D ,TOURISTS 
		      " are scattering in every " D ,INTDIR ,PERIOD>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GARDEN-OUT ()
	 <COND (<T? ,IN-PRAM?>
		<PERFORM ,V?EXIT ,PRAM>
		<RFALSE>)>
	 <WHICH-WAY-OUT>
	 <RFALSE>>

<OBJECT BROAD-WALK
	(LOC ROOMS)
	(DESC "Broad Walk")
	(FLAGS LIGHTED LOCATION WINDY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(SEE-N BWALK)
	(SEE-S BWALK)
	(SEE-E GRPOND)
	(SEE-W VICTORIA)
	(SEE-NW IFENCE)
	(SEE-SW IFENCE)
	(SEE-ALL GTREES)
	(GLOBAL GBAG WWIND EWIND GPRAM PIGEONS GARDENS LONDON LCITY
	        NANNIES TOURISTS BABIES GTREES CHILDREN)
	(NORTH TO LION-GATE)
        (NE TO AT-TERRACE)
	(EAST TO ROUND-POND)
	(SE TO WABE)
	(SOUTH TO PAL-GATE)
	(SW PER IFENCE-BLOCKS)
	(WEST PER VICTORIA-BLOCKS)
	(NW PER IFENCE-BLOCKS)
	(OUT PER GARDEN-OUT)
	(ACTION BROAD-WALK-F)>

<ROUTINE BROAD-WALK-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
	        <TELL
"A brooding " D ,VICTORIA " faces east, where the waters of the " D ,RPOND 
" sparkle in the afternoon sun. Your eyes follow the crowded " D ,BROAD-WALK
" north and south until its borders are lost amid the ">
		<COND (<T? ,RAID?>
		       <TELL "fleeing ">)
		      (T
		       <TELL "bustle of ">)>
		<TELL D ,GPRAM
". Small paths curve northeast and southeast,">
		<TWEEN-TREES>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<COND (<MISSED-MEEP?>
		       <CRLF>)>
		<COND (<OR <IN? ,SCOIN ,BWOMAN>
			   <IN? ,BAG ,BWOMAN>>
		       <SETG LAYAWAY 1>)>
		<BWOMAN-CRY>
		<CRLF>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<SETG P-HER-OBJECT ,BWOMAN>
		<MAKE ,BWOMAN ,SEEN>
		<COND (<IS? ,BWOMAN ,NODESC>
		       <UNMAKE ,BWOMAN ,NODESC>
		       <TELL CR "A cloud of " D ,PIGEONS
" fills the air! They circle overhead and congregate around a nearby bench, where an aged woman is selling bags of crumbs.|
|
\"Feed the birds! Thirty p!\" Her voice quavers with heartbreak." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT ROUND-POND
	(LOC ROOMS)
	(DESC "Round Pond")
	(FLAGS LIGHTED LOCATION WINDY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(SEE-ALL GTREES)
	(GLOBAL EWIND WWIND GPRAM PIGEONS GARDENS LONDON LNWALK NANNIES
	 	CHILDREN TOURISTS BABIES GTREES LCITY)
	(NORTH TO AT-TERRACE)
	(NE TO LAN-GATE)
	(EAST TO LAN-WALK)
	(SE PER EXIT-GARDEN)
	(SOUTH TO WABE)
	(SW PER EXIT-GARDEN)
	(WEST TO BROAD-WALK)
	(NW TO LION-GATE)
	(OUT PER GARDEN-OUT)
	(IN SORRY "Swimming in the Round Pond is strictly forbidden.")
	(ACTION ROUND-POND-F)>

<ROUTINE ROUND-POND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Ducks and swans bob on the sparkling "
D ,CSURFACE " of the " D ,RPOND ". They share the water with a">
		<COND (<T? ,RAID?>
		       <TELL " deserted">)
		      (T
		       <TELL "n impressive">)>
		<TELL " fleet of " D ,BOAT>
		<COND (<ZERO? ,RAID?>
		       <TELL 
", directed by the excited shouts of " D ,CHILDREN>)>
		<COND (<FIRST? ,RPOND>
		       <TELL ". You also see ">
		       <PRINT-CONTENTS ,RPOND>
		       <TELL " floating within reach">)>
		<TELL 
".|
|
Crowded paths radiate from the Pond in many " D ,INTDIR "s." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WABE
	(LOC ROOMS)
	(DESC "The Wabe")
	(FLAGS LIGHTED LOCATION WINDY)
      ; (ODOR 0)
	(OVERHEAD GTREES)
      ; (HEAR 0)
	(NORTH PER WABE-N)
	(NE PER WABE-NE)
	(EAST PER THICKET-BLOCKS)
	(SE PER WABE-SE)
	(SOUTH PER THICKET-BLOCKS)
	(SW PER WABE-SW)
	(WEST PER THICKET-BLOCKS)
	(NW PER WABE-NW)
	(OUT PER WABE-OUT)
	(IN PER WHICH-WAY-IN)
	(ACTION WABE-F)
	(SEE-S THICKET)
	(SEE-E THICKET)
	(SEE-W THICKET)
	(SEE-ALL GTREES)
	(GLOBAL EWIND WWIND PIGEONS GARDENS LONDON LCITY 
	        ROSE SYMBOLS GTREES)>

<ROUTINE WABE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "This grassy " D ,CLEARING
" is only twenty feet across, and perfectly circular. Paths wander off in many " D ,INTDIR "s through the surrounding " D ,THICKET ,PERIOD>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WABE-OUT ()
	 <COND (<T? ,IN-PRAM?>
		<PERFORM ,V?EXIT ,PRAM>
		<RFALSE>)>
	 <WHICH-WAY-OUT>
	 <RFALSE>>

<ROUTINE WABE-N ()
	 <COND (<IS? ,GNOMON ,BORING>
		<RETURN ,ROUND-POND>)>
	 <WOBBLE>
	 <RFALSE>>

<ROUTINE WABE-NE ()
	 <COND (<IS? ,GNOMON ,BORING>
		<RETURN ,LAN-WALK>)>
	 <WOBBLE>
	 <RFALSE>>
		
<ROUTINE WABE-SE ()
	 <COND (<IS? ,GNOMON ,BORING>
		<RETURN ,FLOWER-WALK>)>
	 <WOBBLE>
	 <RFALSE>>

<ROUTINE WABE-SW ()
	 <COND (<IS? ,GNOMON ,BORING>
		<RETURN ,PAL-GATE>)>
	 <WOBBLE>
	 <RFALSE>>

<ROUTINE WABE-NW ()
	 <COND (<IS? ,GNOMON ,BORING>
		<RETURN ,BROAD-WALK>)>
	 <WOBBLE>
	 <RFALSE>>

<ROUTINE WOBBLE ()
	 <MAKE ,GNOMON ,BORING>
	 <TELL "A noise makes you hesitate.|
|
For a moment, nothing happens. Then the ">
	 <SAY-WIND>
	 <TELL " puffs through the " D ,CLEARING ", and the "
	       D ,GNOMON " on the " D ,DIAL 
	       " wobbles with a faint scrape." CR>
	 <RTRUE>>

<OBJECT LION-GATE
	(LOC ROOMS)
	(DESC "Black Lion Gate")
	(FLAGS LIGHTED LOCATION WINDY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(SEE-N BLGATE)
	(SEE-S BWALK)
	(SEE-E GTREES)
	(SEE-SE GTREES)
	(SEE-ALL IFENCE)
	(GLOBAL EWIND WWIND GPRAM PIGEONS GARDENS IFENCE NANNIES 
	 	TOURISTS BABIES GTREES CHILDREN LONDON LCITY)
	(NORTH PER EXIT-GARDEN)
	(NE PER IFENCE-BLOCKS)
	(EAST TO AT-TERRACE)
	(SE TO ROUND-POND)
	(SOUTH TO BROAD-WALK)
	(SW PER IFENCE-BLOCKS)
	(WEST PER IFENCE-BLOCKS)
	(NW PER IFENCE-BLOCKS)
	(IN PER WHICH-WAY-IN)
	(OUT PER EXIT-GARDEN)
	(ACTION LION-GATE-F)>

<ROUTINE LION-GATE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Nannies and " D ,TOURISTS " hurry through the "
		      D ,LGATE>
		<COND (<ZERO? ,RAID?>
		       <TELL 
" to join the " D ,GPRAM " rolling south down the " D ,BWALK>)>
		<TELL ". Less crowded paths wind east along an "
D ,IFENCE ", and southeast">
		<TWEEN-TREES>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LAN-GATE
	(LOC ROOMS)
	(DESC "Lancaster Gate")
	(FLAGS LIGHTED LOCATION WINDY)
	(SEE-N LGATE)
	(SEE-S LNWALK)
	(SEE-E TOURISTS)
	(SEE-NE IFENCE)
	(SEE-NW IFENCE)
	(SEE-SW TOURISTS)
	(SEE-ALL GTREES)
	(GLOBAL EWIND WWIND GPRAM PIGEONS GARDENS IFENCE 
	 	NANNIES CHILDREN TOURISTS BABIES GTREES 
		LONDON LCITY)
      ; (ODOR 0)
      ; (HEAR 0)
	(OVERHEAD TREE)
	(NORTH PER EXIT-GARDEN) 
	(NE PER IFENCE-BLOCKS)
	(EAST PER EXIT-GARDEN)
	(SE PER EXIT-GARDEN)
	(SOUTH PER S-LAN-GATE)
	(SW PER SW-LAN-GATE)
	(WEST PER W-LAN-GATE)
	(NW PER IFENCE-BLOCKS)
	(IN PER WHICH-WAY-IN)
	(UP PER NO-FOOTHOLDS)
	(OUT PER EXIT-GARDEN)
	(ACTION LAN-GATE-F)>

<ROUTINE NO-FOOTHOLDS ()
	 <TELL ,CANT "find any good footholds." CR>
	 <RFALSE>>

<ROUTINE LAN-GATE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A crooked old tree shades the " D ,GPRAM
		      " as they ">
		<COND (<ZERO? ,RAID?>
		       <TELL "roll south down the " D ,LNWALK>)
		      (T
		       <TELL "flee">)>
		<TELL ". Shady paths lead west along an " D ,IFENCE
		      ", and southwest">
		<TWEEN-TREES>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,JWOMAN ,SEEN>>>
		<MAKE ,JWOMAN ,SEEN>
		<UNMAKE ,JWOMAN ,NODESC>
		<QUEUE I-BLOW 2>
		<SETG P-HER-OBJECT ,JWOMAN>
		<SETG P-IT-OBJECT ,PARASOL>
		<TELL CR "There's an " D ,JWOMAN 
" under the tree, struggling to open an " D ,PARASOL ,PTHE "stiff ">
		<SAY-WIND>
		<TELL " isn't making it easy for her." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TWEEN-TREES ("OPTIONAL" (CR T))
	 <TELL " between the " D ,GTREES>
	 <COND (<T? .CR>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<ROUTINE S-LAN-GATE ()
	 <COND (<SEE-JWOMAN?>
		<RFALSE>)>
	 <RETURN ,LAN-WALK>>

<ROUTINE W-LAN-GATE ()
	 <COND (<SEE-JWOMAN?>
		<RFALSE>)>
	 <RETURN ,AT-TERRACE>>

<ROUTINE SW-LAN-GATE ()
	 <COND (<SEE-JWOMAN?>
		<RFALSE>)>
	 <RETURN ,ROUND-POND>>

<ROUTINE SEE-JWOMAN? ()
	 <COND (<IS? ,JWOMAN ,CHILLY>
		<RFALSE>)>
	 <TELL "You begin to walk past the " D ,JWOMAN ", but ">
	 <COND (<NOT <IS? ,JWOMAN ,TOUCHED>>
	        <TELL "stop in your tracks" ,PCR>
		<PERFORM ,V?EXAMINE ,JWOMAN>
		<RTRUE>)>
	 <TELL "pause for a moment." CR>
	 <RTRUE>>

<OBJECT LAN-WALK
	(LOC ROOMS)
	(DESC "Lancaster Walk")
	(FLAGS LIGHTED LOCATION WINDY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(HEAR GRASS)
	(NORTH TO LAN-GATE)
	(NE PER WALK-ON-GRASS)
	(EAST PER WALK-ON-GRASS)
	(SE PER WALK-ON-GRASS)
	(SOUTH TO FLOWER-WALK)
	(SW TO WABE)
	(WEST TO ROUND-POND)
	(NW TO AT-TERRACE)
	(OUT PER GARDEN-OUT)
        (ACTION LAN-WALK-F)
	(SEE-N LNWALK)
	(SEE-S LNWALK)
	(SEE-E LWATER)
	(SEE-ALL GTREES)
	(GLOBAL GRASS EWIND WWIND GPRAM PIGEONS GARDENS 
	        NANNIES CHILDREN TOURISTS BABIES GTREES)>

<ROUTINE LAN-WALK-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
	        <TELL "An impressive " D ,ENERGY 
" of a horse and rider dominates this ">
		<COND (<ZERO? ,RAID?>
		       <TELL "bustling ">)>
		<TELL 
"intersection. The Walk continues north and south; lesser paths curve off in many " D ,INTDIR "s.|
|
A broad field of " D ,GRASS 
", meticulously manicured, extends" ,TOE ". Beyond it you can see the " 
D ,LWATER " glittering">
		<TWEEN-TREES>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WALK-ON-GRASS ()
	 <COND (<IS? ,NOTICE ,TOUCHED>
		<GRASS-STOPS-YOU "As your feet touch the grass">
		<RFALSE>)>
	 <READ-NOTICE-FIRST>
	 <RFALSE>>

<ROUTINE READ-NOTICE-FIRST ()
	 <MAKE ,NOTICE ,TOUCHED>
	 <SETG P-IT-OBJECT ,NOTICE>
	 <TAKE-A-MOMENT-TO ,NOTICE>
	 <RTRUE>>

<OBJECT AT-TERRACE
	(LOC ROOMS)
	(DESC "Inverness Terrace")
	(FLAGS LIGHTED LOCATION WINDY NOALL VOWEL)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER IFENCE-BLOCKS)
	(NE PER IFENCE-BLOCKS)
	(NW PER IFENCE-BLOCKS)
	(OUT PER EXIT-GARDEN)
	(EAST TO LAN-GATE)
	(IN PER WHICH-WAY-IN)
	(SE TO LAN-WALK)
	(SOUTH TO ROUND-POND)
	(SW TO BROAD-WALK)
	(WEST TO LION-GATE)
	(ACTION AT-TERRACE-F)
	(SEE-N IFENCE)
	(SEE-NE IFENCE)
	(SEE-NW IFENCE)
	(SEE-ALL GTREES)
	(GLOBAL EWIND WWIND GPRAM PIGEONS GARDENS LONDON LCITY NANNIES
	      ; SBUBBLE CHILDREN TOURISTS BABIES GTREES IFENCE)>

"NOALL = can't see a bubble."

<ROUTINE AT-TERRACE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Crowded walkways lead east and west along an "
D ,IFENCE ". Narrow paths wander south into the Gardens." CR> 
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <MISSED-MEEP?>>
		<CRLF>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LONG-WATER
	(LOC ROOMS)
	(DESC "Long Water")
	(FLAGS LIGHTED LOCATION)
      ; (ODOR 0)
        (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER DONT-MISS-MISSILE)
	(NE PER DONT-MISS-MISSILE)
	(EAST PER SWIM-IN-LWATER)
	(SE PER DONT-MISS-MISSILE)
	(SOUTH PER DONT-MISS-MISSILE)
	(SW PER DONT-MISS-MISSILE)
	(WEST PER DONT-MISS-MISSILE)
	(NW PER DONT-MISS-MISSILE)
	(OUT PER WHICH-WAY-OUT)
	(IN PER SWIM-IN-LWATER)
	(ACTION LONG-WATER-F)
	(SEE-ALL GTREES)
	(SEE-E LWATER)
	(SEE-NE LWATER)
	(SEE-SE LWATER)
	(GLOBAL EWIND WWIND ; PIGEONS GARDENS LONDON LCITY BEACH OPSHORE
	        MISSILE
	 	LWDOOR MALLARDS GTREES)>

<ROUTINE LONG-WATER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're on a shady path that winds along the western shore of the " 
D ,LWATER ". Looking south, you can see the graceful arch of a bridge, and beyond it the cool expanse of the river Serpentine." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SWIM-IN-LWATER ()
         <TELL "You ">
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP ,W?DIVE>
		<PRINTB ,P-PRSA-WORD>)
	       (T
		<TELL "wade">)>
	 <TELL " into the cool, dark water" ,PCR>
	 <RETURN ,IN-WATER>>

<ROUTINE DONT-MISS-MISSILE ()
	 <COND (<L? ,HCNT 6>
		<TELL "The spectacle on the " D ,LWATER 
		      " has you frozen ">)
	       (T
		<SETG HCNT 6>
		<TELL "You begin to move away, but stop dead ">)>
	 <TELL "in your tracks." CR>
	 <I-LONDON-HOLE>
	 <RFALSE>>

<ROUTINE MISSED-MEEP? ()
	 <COND (<AND <VISIBLE? ,RUBY>
		     <NOT <IS? ,RUBY ,TOUCHED>>>
		<UNMAKE ,RUBY ,CHILLY>
		<I-RUBY <>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-WATER
	(LOC ROOMS)
	(DESC "Wading")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (ODOR 0)
        (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER BEACH-TOO-FAR)
	(NE PER BEACH-TOO-FAR)
	(EAST PER ENTER-HOLE)
	(SE PER BEACH-TOO-FAR)
	(SOUTH PER BEACH-TOO-FAR)
	(SW PER BEACH-TOO-FAR)
	(WEST PER EXIT-WATER)
	(NW PER BEACH-TOO-FAR)
	(OUT PER EXIT-WATER)
	(DOWN SORRY "The water isn't deep enough here.")
	(IN PER ENTER-HOLE)
	(SEE-ALL LWATER)
	(SEE-E LWATER)
	(SEE-W GTREES)
	(GLOBAL EWIND WWIND MISSILE LWDOOR GARDENS LONDON LCITY BEACH
	 	MALLARDS OPSHORE)
	(ACTION IN-WATER-F)>

<ROUTINE IN-WATER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're standing knee-deep in the " D ,LWATER
		      ", not far from the western shore">
		<COND (<IS? ,LWDOOR ,TOUCHED>
		       <TELL
". Looking east, you can see a " D ,LWDOOR
" hovering just above the " D ,CSURFACE>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-HOLE ()
	 <COND (<IS? ,LWDOOR ,TOUCHED>
		<GO-INTO-LWDOOR>
		<RFALSE>)>
	 <BEACH-TOO-FAR>
	 <RFALSE>>

<ROUTINE BEACH-TOO-FAR ()
	 <TELL CTHE ,BEACH " is too far away in that " D ,INTDIR ,PERIOD>
	 <RFALSE>>

<ROUTINE EXIT-WATER ()
	 <TELL "You wade back to the " D ,BEACH ,PCR>
	 <RETURN ,LONG-WATER>>

"*** FANTASY WORLD ***"

<OBJECT OSSUARY
	(LOC ROOMS)
	(DESC "Ossuary")
	(FLAGS LIGHTED LOCATION NOGRASS SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER HOLLOW-TOO-STEEP)
	(NE PER HOLLOW-TOO-STEEP)
	(EAST PER HOLLOW-TOO-STEEP)
	(SE PER HOLLOW-TOO-STEEP)
	(SOUTH PER OSSUARY-S)
	(SW PER HOLLOW-TOO-STEEP)
	(WEST PER HOLLOW-TOO-STEEP)
	(NW PER HOLLOW-TOO-STEEP)
	(IN PER OSSUARY-IN)
        (UP PER HOLLOW-TOO-STEEP)
	(ACTION OSSUARY-F)
	(SEE-S TUNNEL)
	(SEE-ALL HOLLOW)
	(GLOBAL BARROW TUNNEL TS2-DOOR DSTRUCT)>

<ROUTINE OSSUARY-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Naked slopes veer upward on every side, forming a natural "
D ,HOLLOW " that is filled to a depth of several inches with human " D ,BONES
,PTHE "only exit is a dark " D ,HOPENING ,TOS ,PCR 
"A giant " D ,TS2 " is flourishing in the rich fertilizer">
		<MENTION-DOOR ,TS2-DOOR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MENTION-DOOR (X)
	 <COND (<NOT <IS? .X ,NOALL>>
		<TELL ,PTHE D .X " in its stem is ">
		<COND (<IS? .X ,OPENED>
		       <TELL "wide open">)
		      (T
		       <TELL "closed">)>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE OSSUARY-S ()
         <SETG WIGHTER 1>
       ; <TELL "You duck into the " D ,HOPENING ,PCR>
	 <RETURN ,IN-BARROW>>

<ROUTINE HOLLOW-TOO-STEEP ()
	 <TELL "The slopes around you are too steep to climb">
	 <COND (<NOT <IS? ,HOLLOW ,TOUCHED>>
		<MAKE ,HOLLOW ,TOUCHED>
		<TELL "; the " D ,BONES 
" suggest that you're not the first to discover this">)>
	 <PRINT ,PERIOD>
	 <RFALSE>>
		
<ROUTINE OSSUARY-IN ()
	 <COND (<IS? ,TS2-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS2-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<TELL "You explore the door's edge with a timid foot.">
		<CARRIAGE-RETURNS>
		<SETG SECONDS 0>
		<SETG MINUTES 50>
		<SETG HOURS 17>
		<QUEUE I-TUNNEL -1>
		<RETURN ,TUN1>)
	       (T
		<ITS-CLOSED ,TS2-DOOR>
		<RFALSE>)>>		

<OBJECT PROM
	(LOC ROOMS)
	(DESC "Promontory")
	(FLAGS LIGHTED LOCATION SHADOWY NOALL NOGRASS)
      ; (OVERHEAD 0)
	(HEAR GIANT)
	(ODOR GIANT)
	(NORTH PER YOUD-FALL)
	(NE PER YOUD-FALL)
	(EAST PER YOUD-FALL)
	(SE TO AT-CHASM)
	(SOUTH TO NBOG)
	(SW PER YOUD-FALL)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(SEE-ALL CHASM)
	(SEE-S PATH)
	(SEE-SE PATH)
	(OUT PER PROM-OUT)
	(IN PER PROM-IN)
	(ACTION PROM-F)
	(GLOBAL ; SBUBBLE DSTRUCT CHASM TREETOPS)>

<ROUTINE PROM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"This crag of rock juts out over the surrounding " D ,CHASM 
", ending at an abrupt drop several hundred feet deep. Rugged trails wind south and south">
		<SAY-EAST>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PROM-IN ()
	 <COND (<ZERO? ,IN-DISH?>
		<ENTER-DISH>
		<RFALSE>)>
	 <ALREADY-IN ,DISH>
	 <RFALSE>>

<ROUTINE PROM-OUT ()
	 <COND (<T? ,IN-DISH?>
		<EXIT-DISH>
		<RFALSE>)>
	 <WHICH-WAY-OUT>
	 <RFALSE>>

<OBJECT ON-MESA
	(LOC ROOMS)
	(DESC "Mesa")
	(FLAGS LIGHTED LOCATION NOGRASS SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER YOUD-FALL)
	(NE PER YOUD-FALL)
	(EAST PER YOUD-FALL)
	(SE PER YOUD-FALL)
	(SOUTH PER CROSS-CHASM)
	(SW PER YOUD-FALL)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(IN PER ON-MESA-IN)
        (OUT PER WHICH-WAY-OUT)
	(SEE-ALL CHASM)
	(SEE-S OAK)
	(ACTION ON-MESA-F)
	(GLOBAL OAK MESA CHASM STOOLS TS3-DOOR TREETOPS DSTRUCT)>

<ROUTINE ON-MESA-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,MESA "'s summit is a flat " D ,PLATFORM 
" of stone, surrounded on every side by a deep " D ,CHASM
,PA "fallen oak bridges the gulf" ,TOS ,PCR 
"A giant " D ,TS3 " has somehow taken root in the solid rock">
		<MENTION-DOOR ,TS3-DOOR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CROSS-CHASM ()
	 <OAK-STEP>
	 <TELL ,PCR>
	 <RETURN ,AT-CHASM>>

<ROUTINE ON-MESA-IN ()
	 <COND (<IS? ,TS3-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS3-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<SETG SECONDS 0>
		<SETG HOURS 4>
		<SETG MINUTES 52>
		<QUEUE I-FLIPPER -1>
		<QUEUE I-TIDE -1>
		<TELL "You ">
		<COND (<T? ,SUITED?>
		       <TELL "squeeze the " D ,FILM " through ">)
		      (T
		       <TELL "cross the brink of ">)>
		<TELL THE ,TS3-DOOR ".">
		<CARRIAGE-RETURNS>
		<RETURN ,ON-SCAFFOLD>)
	       (T
		<ITS-CLOSED ,TS3-DOOR>
		<RFALSE>)>>

<OBJECT ON-BLUFF
	(LOC ROOMS)
	(DESC "Bluff")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER YOUD-FALL)
	(NE PER YOUD-FALL)
	(EAST TO IN-COTTAGE IF COTTAGE-DOOR IS OPEN)
	(IN TO IN-COTTAGE IF COTTAGE-DOOR IS OPEN)
	(SE TO AT-CRATER)
	(SOUTH SORRY "A sudden cliff blocks your path.")
	(SW TO AT-CHASM)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(ACTION ON-BLUFF-F)
	(SEE-ALL VALLEY)
	(SEE-E COTTAGE)
	(SEE-SE PATH)
        (SEE-S CLIFF)
	(SEE-SW PATH)
	(GLOBAL CLIFF STOOLS COTTAGE COTTAGE-DOOR DSTRUCT)>

<ROUTINE ON-BLUFF-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<LOOK-AT-VALLEY>
		<TELL " Narrow trails curve southeast and southwest, away from the edge of the bluff.|
|
To the ">
		<SAY-EAST>
		<TELL 
" stands a little " D ,COTTAGE ", nestled in a shady " D ,COPSE 
,PTHE D ,COTTAGE-DOOR " is ">
		<COND (<IS? ,COTTAGE-DOOR ,OPENED>
		       <TELL "open." CR>
		       <RTRUE>)>
		<TELL "closed." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-AT-VALLEY ()
	 <TELL "A spectacular crop of " D ,STOOLS 
" extends far and wide across the " D ,VALLEY " below.">
	 <RTRUE>>

<OBJECT IN-COTTAGE
	(LOC ROOMS)
	(DESC "Cottage")
	(FLAGS LIGHTED LOCATION	INDOORS SHADOWY)
	(ODOR CAULDRON)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(EAST TO IN-GARDEN IF GARDEN-DOOR IS OPEN)
	(WEST TO ON-BLUFF IF COTTAGE-DOOR IS OPEN)
	(OUT PER WHICH-WAY-OUT)
	(ACTION	IN-COTTAGE-F)
	(SEE-ALL WALLS)
	(SEE-E GARDEN-DOOR)
	(SEE-W COTTAGE-DOOR)
	(GLOBAL COTTAGE COTTAGE-DOOR GARDEN-DOOR GARDEN DSTRUCT)>

<ROUTINE IN-COTTAGE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "An iron " D ,CAULDRON>
		<COND (<IS? ,EMERALD ,NODESC>
		       <TELL 
", brown with the crust of years, squats in the middle">)
		      (T
		       <TELL " stands amid the scorched remains">)>
		<TELL " of this tiny chamber. ">
		<COND (<IS? ,EMERALD ,NODESC>
		       <TELL 
"Coils of steam writhe from its depths, filling the air">)
		      (T
		       <TELL "The air is filled">)>
		<TELL 
" with a greasy stench that makes your nose wrinkle. ">
		<COND (<IS? ,COTTAGE-DOOR ,OPENED>
		       <TELL "Luckily, the ">
		       <COND (<IS? ,GARDEN-DOOR ,OPENED>
			      <TELL
"front and " D ,GARDEN-DOOR "s are both wide open." CR>
			      <RTRUE>)>
		       <DOOR-LEADING ,COTTAGE-DOOR>
		       <RTRUE>)
		      (<IS? ,GARDEN-DOOR ,OPENED>
		       <TELL "Luckily, the ">
		       <DOOR-LEADING ,GARDEN-DOOR>
		       <RTRUE>)>
		<TELL 
"Unfortunately, the front and " D ,GARDEN-DOOR "s are both closed." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		        
<ROUTINE DOOR-LEADING (OBJ)
	 <TELL D .OBJ " is wide open. Another door leading ">
	 <COND (<EQUAL? .OBJ ,COTTAGE-DOOR>
		<SAY-EAST>)
	       (T
		<SAY-WEST>)>
	 <TELL " is closed." CR>
	 <RTRUE>>

<OBJECT IN-GARDEN
	(LOC ROOMS)
	(DESC "Herb Garden")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR HERBS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(WEST TO IN-COTTAGE IF GARDEN-DOOR IS OPEN)
	(IN PER IN-GARDEN-IN)
	(NORTH PER GFENCE-BLOCKS)
	(NE PER GFENCE-BLOCKS)
	(EAST PER GFENCE-BLOCKS)
	(SE PER GFENCE-BLOCKS)
	(SOUTH PER GFENCE-BLOCKS)
	(SW PER GFENCE-BLOCKS)
	(NW PER GFENCE-BLOCKS)
        (ACTION IN-GARDEN-F)
	(SEE-ALL GFENCE)
	(SEE-W GARDEN-DOOR)
	(GLOBAL GARDEN COTTAGE GARDEN-DOOR TS4-DOOR DSTRUCT)>

<ROUTINE IN-GARDEN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A " D ,GFENCE 
" protects the neat rows of herbs from predators. The only exit is the">
		<OPEN-CLOSED ,GARDEN-DOOR>
		<TELL " of the " D ,COTTAGE ", leading west.|
|
Another giant " D ,TS4 " has taken root in a " D ,PATCH>
		<MENTION-DOOR ,TS4-DOOR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-GARDEN-IN ()
	 <COND (<IS? ,TS4-DOOR ,NOALL>
		<COND (<IS? ,GARDEN-DOOR ,OPENED>
		       <RETURN ,IN-COTTAGE>)
		      (T
		       <ITS-CLOSED ,GARDEN-DOOR>
		       <RFALSE>)>)
	       (<IS? ,TS4-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<QUEUE I-RODENTS -1>
		<QUEUE I-RCOUNT -1>
		<SETG HOURS 14>
		<SETG MINUTES 41>
		<SETG SECONDS 0>
		<TELL CTHE ,TS4-DOOR
" opens wider at your touch, drawing you over the threshold.">
		<CARRIAGE-RETURNS>
		<RETURN ,ON-PLATFORM>)>
	 <WHICH-WAY-IN>
	 <RFALSE>>

<OBJECT BONEYARD
	(LOC ROOMS)
	(DESC "Cemetery")
	(FLAGS LIGHTED LOCATION SHADOWY)
        (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(DOWN PER DOWN-SSTEPS)
	(NORTH TO IN-BARROW IF BARROW-DOOR IS OPEN)
	(NE PER YOUD-FALL)
	(EAST PER YOUD-FALL)
	(SE PER YOUD-FALL)
	(SOUTH PER DOWN-SSTEPS)
	(IN TO IN-BARROW IF BARROW-DOOR IS OPEN)
	(SW PER YOUD-FALL)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(ACTION BONEYARD-F)
	(SEE-ALL CLIFF)
	(SEE-N BARROW)
	(SEE-S SSTEPS)
	(GLOBAL SSTEPS BARROW BARROW-DOOR TUNNEL CLIFF DSTRUCT)>

<ROUTINE BONEYARD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Gloomy " D ,STATUES 
" lie toppled among the " D ,TOMBS ", their " D ,LIMBS 
" and heads scattered like the carnage of a ghastly battle.|
|
A granite " D ,CRYPT 
" lies" ,AGROUND ". Beyond it rises the mound of an ancient " D ,BARROW>
		<COND (<IS? ,BARROW-DOOR ,OPENED>
		       <TELL ,PA "black " D ,TUNNEL
			     " leads north, into the " D ,BARROW>)
		      (T
		       <TELL ", sealed with an iron door">)>
		<TELL ".|
|
Sudden drops fall away on every side but south, where a flight of "
D ,SSTEPS " descends the cliff." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UP-SSTEPS ()
       	 <SCEND "a">
	 <RETURN ,BONEYARD>>

<ROUTINE DOWN-SSTEPS ()
         <SCEND "de">
	 <RETURN ,AT-FALLS>>

<ROUTINE SCEND (STR)
	 <TELL "You carefully " .STR "scend the " D ,SSTEPS ,PCR>
	 <RTRUE>>

<OBJECT IN-BARROW
	(LOC ROOMS)
	(DESC "Barrow")
	(FLAGS LIGHTED LOCATION INDOORS SHADOWY)
      ; (ODOR WIGHT)
      ; (OVERHEAD 0)
      ; (HEAR WIGHT)
	(NORTH PER IN-BARROW-N)
	(SOUTH PER BARROW-EXIT)
	(OUT PER WHICH-WAY-OUT)
	(IN PER WHICH-WAY-IN)
	(DOWN PER DOWN-SLOPE)
	(GLOBAL BARROW TUNNEL BARROW-DOOR SLOPE DSTRUCT)
	(SEE-ALL WALLS)
	(SEE-N WIGHT)
	(SEE-S BARROW-DOOR)
	(ACTION IN-BARROW-F)>

<ROUTINE IN-BARROW-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The ">
		<COND (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL D ,LAMP "'s faltering beam">)
		      (<VISIBLE? ,SHARD>
		       <TELL D ,SHARD "'s ghostly flicker">)
		      (T
		       <TELL "dim light from outside">)>
		<TELL 
" does little to dispel the gloom of this subterranean passage. Craggy walls bend away" ,TON " and south">
		<COND (<IS? ,SLOPE ,OPENED>
		       <TELL 
"; chill vapors rise from a slope that descends into darkness">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<IS? ,BARROW-DOOR ,OPENED>
		       <UNMAKE ,BARROW-DOOR ,OPENED>
		       <UNMAKE ,IN-BARROW ,LIGHTED>
		       <SETG P-IT-OBJECT ,BARROW-DOOR>
		       <UNMAKE ,WIGHT ,SEEN>
		       <SETG WIGHTER 4>
		       <QUEUE I-WIGHT -1>
		       <TELL CR
"A clatter breaks the silence! You turn, and watch helplessly as a " 
D ,BARROW-DOOR " crashes down across the south exit." CR>
		       <SAY-IF-HERE-LIT>)>
		<COND (<AND <T? ,LIT?>
			    <IS? ,WIGHT ,NODESC>>
		       <UNMAKE ,WIGHT ,NODESC>
	 	       <TELL CR "Something just moved.|
|
You peer uneasily beyond the pool of light around the ">
	 	       <COND (<AND <IS? ,LAMP ,LIGHTED>
		     		   <VISIBLE? ,LAMP>>
			      <TELL D ,LAMP>)
	       		     (T
			      <TELL D ,SHARD>)>
	 	       <TELL 
". Nothing. Then, as your eyes adjust, you descry a vaguely human outline crouched against the " D ,TUNNEL " wall">
		       <WIGHT-HAS>
		       <PRINT ,PERIOD>
		       <WIGHT-ID>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WIGHT-ID ()
	 <COND (<IS? ,WIGHT ,BORING>
		<RFALSE>)>
	 <MAKE ,WIGHT ,BORING>
	 <CRLF>
	 <COND (<VISIBLE? ,MAGPIE>
		<TELL "\"Awk! Barrow wight!\"" CR>
		<RTRUE>)>
	 <VOICE-MUTTERS "Barrow wight" <>>
	 <RTRUE>>

<ROUTINE IN-BARROW-N ()
	 <COND (<IN? ,SHARD ,PLAYER>
		<UNMAKE ,WIGHT ,SEEN>
		<COND (<IS? ,WIGHT ,CHILLY>
		       <WIGHT-STUMBLES>)
		      (T
		       <MAKE ,WIGHT ,CHILLY>
		       <WIGHT-COVERS>
		       <TELL "bellows something awful as you pass" ,PCR>)>
		<RETURN ,OSSUARY>)
	       (<AND <IN? ,LAMP ,PLAYER>
		     <IS? ,LAMP ,LIGHTED>>
		<UNMAKE ,WIGHT ,SEEN>
		<WIGHT-STUMBLES>
		<RETURN ,OSSUARY>)
	       (<AND <IN? ,LAMP ,HERE>
		     <IS? ,LAMP ,LIGHTED>>
		<WIGHT-BLOCKS-DESPITE ,LAMP>
		<RFALSE>)
	       (<IN? ,SHARD ,HERE>
		<WIGHT-BLOCKS-DESPITE ,SHARD>
		<RFALSE>)>
	 <TELL "You stumble into the lightless " D ,TUNNEL ,PCR>
	 <WIGHT-KILLS-YOU>
	 <RFALSE>>
	 
<ROUTINE WIGHT-BLOCKS-DESPITE (OBJ)
	 <MAKE ,WIGHT ,SEEN>
	 <TELL CTHE ,WIGHT
"'s eye grows wide and bold as your " D ,DSHADOW " blocks the " D .OBJ
". You hesitate, then slowly retreat until the "  D .OBJ
" is well within reach." CR>
	 <RTRUE>>	 

<ROUTINE WIGHT-COVERS ()
	 <TELL CTHE ,WIGHT " covers its eye with its claws and ">
	 <RTRUE>>

<ROUTINE WIGHT-STUMBLES ()
	 <TELL CTHE ,WIGHT>
	 <COND (<PROB 50>
		<TELL " stumble">)
	       (T
		<TELL " slink">)>
	 <TELL "s out of your way." CR>
	 <RTRUE>>

<ROUTINE BARROW-EXIT ()
	 <COND (<ZERO? ,LIT?>
		<TELL "Something hard">
		<BLOCKS-YOUR-PATH>
		<RFALSE>)>
	 <BLOCKS-YOUR-PATH ,BARROW-DOOR>
	 <RFALSE>>

<ROUTINE DOWN-SLOPE ()
	 <COND (<IS? ,SLOPE ,OPENED>
		<MAKE ,CAVE-HOLE ,SEEN>
		<UNMAKE ,IN-BARROW ,TOUCHED>
	 	<MAKE ,BARROW-DOOR ,OPENED>
		<MAKE ,IN-BARROW ,LIGHTED>
		<UNMAKE ,WIGHT ,SEEN>
		<QUEUE I-SLOPE 1>
		<TELL 
"You slide down into gloom that grows colder and colder...|
|
">
	 	<RETURN ,ICE-CAVE>)>
	 <TELL ,DONT "see any exit that way." CR>
	 <RFALSE>>

<OBJECT NBOG
	(LOC ROOMS)
	(DESC "North Bog")
	(FLAGS LIGHTED LOCATION SHADOWY)
        (ODOR MIASMA)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH TO PROM)
	(NE SORRY "Black trees block your path.")
	(EAST TO AT-CHASM)
	(SE TO GBASE)
	(SOUTH TO SBOG)
	(SW TO AT-FALLS)
	(WEST PER CLIFF-BLOCKS)
	(NW PER CLIFF-BLOCKS)
	(ACTION NBOG-F)
	(SEE-ALL FOREST)
	(SEE-W CLIFF)
	(SEE-NW CLIFF)
	(GLOBAL FOREST ; SBUBBLE DSTRUCT BOG MIASMA CLIFF)>

<ROUTINE NBOG-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A thick, suffocating miasma lingers among the trees; the black earth is squishy with corruption. ">
		<HEAR-DRIPPING>
		<TELL CR "Paths wander off in many " D ,INTDIR 
"s. High " D ,RWALLS " curve away" ,TON " and south">
		<SAY-WEST>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-CHASM
	(LOC ROOMS)
	(DESC "Chasm's Brink")
	(FLAGS LIGHTED LOCATION SHADOWY NOALL NOGRASS)
      ; (ODOR 0)
	(OVERHEAD OAK)
      ; (HEAR 0)
	(NORTH PER CROSS-TO-MESA)
	(DOWN PER CHASM-FALL)
	(NE TO ON-BLUFF)
	(EAST TO UNDER-CLIFF)
	(SE TO AT-BEND)
	(SOUTH SORRY "The forest is too dense that way.")
	(SW TO SBOG)
	(WEST TO NBOG)
	(NW TO PROM)
        (UP PER CLIMB-OAK)
	(ACTION AT-CHASM-F)
	(SEE-ALL FOREST)
	(SEE-N MESA)
	(GLOBAL OAK MESA FOREST CHASM TREETOPS DSTRUCT)>

<ROUTINE AT-CHASM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,CHASM
" at your feet is striped with colorful layers of rock. Narrow paths twist northeast and northwest, uneasily close to the edge. Other trails lead off into the forest.|
|
To the north, a rocky " D ,MESA " towers like a golf tee from the depths of the " D ,CHASM ". Only thirty feet separate you from its flattened summit." CR>
		<COND (<IS? ,OAK ,NOALL>
		       <TELL CR 
"An oak tree stands at the chasm's brink." CR>
		       <RTRUE>)
		      (<IS? ,OAK ,TOUCHED>
		       <TELL CR "An oak tree lies fallen across the ">
		       <COND (<IS? ,OAK ,WINDY>
			      <TELL D ,CHASM>)
			     (T
			      <TELL D ,GROUND>)>
		       <PRINT ,PERIOD>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CROSS-TO-MESA ()
	 <COND (<IS? ,OAK ,WINDY>
		<OAK-STEP>
		<TELL ", and leap onto the " D ,MESA ,PCR>
		<RETURN ,ON-MESA>)>
	 <CHASM-FALL>
	 <RFALSE>>

<ROUTINE OAK-STEP ()
	 <TELL "You step gingerly across the fallen oak">
	 <RTRUE>>

<ROUTINE CHASM-FALL ("AUX" (P <>) X)
	 <COND (<HERE? ON-BLUFF>
		<SET X ,VALLEY>)
	       (T
		<SET X ,CHASM>)>
	 <COND (<IS? ,HERE ,TRYTAKE>
		<COND (<AND <IN? ,PARASOL ,PLAYER>
			    <IS? ,PARASOL ,OPENED>>
		       <SET P T>)>
		<TELL "You step boldly over the " D .X "'s brink">
		<COND (<OR <T? ,SUITED?> <T? .P>>
		       <TELL " and float down, buoyed by the ">
		       <COND (<ZERO? ,SUITED?>
			      <TELL "open " D ,PARASOL 
				    ". But its cloth panels get tangled">)
			     (T
			      <TELL D ,FILM ". But its flabby " D ,CSURFACE
				    " tears and pops">)>
		       <TELL " in the " D ,TREETOPS " below">
		       <COND (<AND <T? .P> <T? ,SUITED?>>
			      <TELL "; the " D ,PARASOL " tangles">)>
		       <TELL ", and you ">)
		      (T
		       <TELL ", and ">)>
		<TELL "plummet to a painful end.">
		<JIGS-UP>
		<RFALSE>)>
	 <MAKE ,HERE ,TRYTAKE>
	 <TAKE-A-MOMENT-TO .X>
	 <RFALSE>>

<ROUTINE CLIMB-OAK ()
	 <COND (<IS? ,OAK ,NOALL>
		<PERFORM ,V?CLIMB-UP ,OAK>
		<RFALSE>)>
	 <CANT-GO>
	 <RFALSE>>

<OBJECT UNDER-CLIFF
	(LOC ROOMS)
	(DESC "Under Cliff")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(HEAR HIVE)
	(ODOR HIVE)
	(OVERHEAD CLIFF)
	(NORTH PER CLIFF-BLOCKS)
	(NE PER CLIFF-BLOCKS)
	(EAST TO AT-CRATER)
	(SE TO ON-MOOR)
	(SOUTH TO AT-BEND)
	(SW TO GBASE)
	(WEST TO AT-CHASM)
        (NW PER CLIFF-BLOCKS)
	(UP SORRY "The cliff is much too steep to climb.")
	(ACTION UNDER-CLIFF-F)
	(SEE-ALL FOREST)
	(SEE-N CLIFF)
	(SEE-NE CLIFF)
	(SEE-NW CLIFF)
	(GLOBAL FOREST CLIFF DSTRUCT)>

<ROUTINE UNDER-CLIFF-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Smooth walls of rock vault straight up and then lean inward, forming a natural roof that partially hides the sky. Trails lead out from under the cliff in many " D ,INTDIR "s.|
|
A swarm of bees has staked out this formation for itself by " D ,SCHOOL 
" an enormous hive under the arch. ">
		<HEAR-HIVE> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HEAR-HIVE ()
	 <TELL
"The faint buzzing " D ,SOUND
" from the hive is magnified by the cliff's acoustics into a loud, frightening drone." CR>>

<OBJECT AT-CRATER
	(LOC ROOMS)
	(DESC "Crater's Edge")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR SMOKE)
	(OVERHEAD SMOKE)
      ; (HEAR 0)
	(NORTH SORRY "Blasted trees block your path.")
	(NE SORRY "Blasted trees block your path.")
	(EAST PER ENTER-CRATER)
	(SE SORRY "Blasted trees block your path.")
	(SOUTH TO ON-MOOR)
	(SW TO AT-BEND)
	(WEST TO UNDER-CLIFF)
	(NW TO ON-BLUFF)
        (DOWN PER ENTER-CRATER)
	(IN PER ENTER-CRATER)
	(OUT PER WHICH-WAY-OUT)
	(ACTION AT-CRATER-F)
	(SEE-ALL FOREST)
	(SEE-E CRATER)
	(GLOBAL FOREST CRATER SMOKE RUBBLE DSTRUCT)>

<ROUTINE AT-CRATER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SETG P-IT-OBJECT ,CRATER>
		<TELL CTHE ,FOREST
" around you is bent and splintered, as if a mighty fist had smashed through the branches. Sooty fumes hang in the air; the earth is dark with ashes and " 
D ,RUBBLE ".|
|
The ">
		<SAY-EAST>
		<TELL "ern path ends at the lip of a deep " D ,CRATER
", forty or fifty feet across." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-CRATER ()
	 <TELL "You climb down into the " D ,CRATER ,PCR>
	 <RETURN ,IN-CRATER>>

<OBJECT IN-CRATER
	(LOC ROOMS)
	(DESC "Crater")
	(FLAGS LIGHTED LOCATION SHADOWY NOGRASS)
	(ODOR SMOKE)
	(OVERHEAD SMOKE)
      ; (HEAR 0)
	(NORTH PER IN-CRATER-UP)
	(NE PER IN-CRATER-UP)
	(EAST PER IN-CRATER-UP)
	(SE PER IN-CRATER-UP)
	(SOUTH PER IN-CRATER-UP)
	(SW PER IN-CRATER-UP)
	(NW PER IN-CRATER-UP)
	(WEST PER EXIT-CRATER)
	(UP PER EXIT-CRATER)
	(OUT PER EXIT-CRATER)
	(ACTION IN-CRATER-F)
	(SEE-ALL SMOKE)
	(GLOBAL CRATER SMOKE RUBBLE DSTRUCT)>

<ROUTINE IN-CRATER-UP ()
	 <TELL "The only way up is to the ">
	 <SAY-WEST>
	 <PRINT ,PERIOD>
	 <RFALSE>>

<ROUTINE IN-CRATER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A dark cloud of " D ,SMOKE
" fills the air with an acrid, smoldering stench. Blackened " D ,RUBBLE 
" covers the sides and bottom of the " D ,CRATER ,PERIOD>
	        <RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,LUMP ,TOUCHED>>>
		<I-LUMP T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-CRATER ()
	 <TELL "You scramble out of the " D ,CRATER ,PCR>
	 <RETURN ,AT-CRATER>>

<OBJECT AT-FALLS
	(LOC ROOMS)
	(DESC "Waterfall")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
	(OVERHEAD CLIFF)
	(HEAR WATERFALL)
	(NORTH PER UP-SSTEPS)
	(UP PER UP-SSTEPS)
	(NE TO NBOG)
	(EAST TO SBOG)
	(SE TO FCLEARING)
	(SOUTH SORRY "Sheer cliff walls block your path.")
	(SW SORRY "Sheer cliff walls block your path.")
	(WEST PER AT-FALLS-W)
	(NW SORRY "Sheer cliff walls block your path.")
	(IN PER AT-FALLS-IN)
        (ACTION AT-FALLS-F)
	(SEE-ALL CLIFF)
	(SEE-NE FOREST)
	(SEE-E FOREST)
	(SEE-SE FOREST)
	(SEE-N SSTEPS)
	(SEE-W WATERFALL)
	(GLOBAL STREAM SSTEPS CLIFF WATERFALL CAVE-HOLE TS1-DOOR DSTRUCT
	 	FOREST)>

<ROUTINE AT-FALLS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A curtain of water tumbles off the ">
		<SAY-WEST>
		<TELL 
"ern cliffs into a deep, rocky pool. From there, a mountain stream wanders off into the "
D ,FOREST ". Footpaths follow the stream ">
		<SAY-EAST>
		<TELL ", past a giant " D ,TS1>
		<MENTION-DOOR ,TS1-DOOR>
		<TELL CR "A flight of " D ,SSTEPS 
" has been hewn into the face of the north cliff." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE AT-FALLS-W ()
	 <COND (<NOT <IS? ,CAVE-HOLE ,SEEN>>
		<BLOCKS-YOUR-PATH ,WATERFALL>
		<RFALSE>)>
	 <TELL "You edge around the curtain of water" ,PCR>
	 <RETURN ,ICE-CAVE>>

<ROUTINE AT-FALLS-IN ()
	 <COND (<IS? ,TS1-DOOR ,NOALL>
		<WHICH-WAY-IN>
		<RFALSE>)
	       (<IS? ,TS1-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<SETG QUIET? T>
		<TELL "You ">
		<COND (<T? ,SUITED?>
		       <TELL "squeeze the " D ,FILM>)
		      (T
		       <TELL "slowly edge " D ,ME>)>
		<TELL " through " THE ,TS1-DOOR ".">
		<CARRIAGE-RETURNS>
	 	<QUEUE I-VACUUM -1>
	 	<QUEUE I-ORBIT -1>
	 	<GOTO ,IN-ORBIT>
	 	<I-ORBIT>
	 	<I-VACUUM>
		<RFALSE>)
	       (T
		<ITS-CLOSED ,TS1-DOOR>)>
	 <RFALSE>>
		
<ROUTINE BROLLY-OPEN? ()
	 <COND (<AND <IN? ,PARASOL ,PLAYER>
		     <IS? ,PARASOL ,OPENED>>
		<SETG P-IT-OBJECT ,PARASOL>
		<TELL "You'll never fit through the door with that open "
		      D ,PARASOL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ICE-CAVE
	(LOC ROOMS)
	(DESC "Ice Cavern")
	(FLAGS LIGHTED LOCATION INDOORS SHADOWY CHILLY)
      ; (ODOR 0)
	(HEAR WATERFALL)
	(OVERHEAD ICICLES)
	(EAST PER THROUGH-FALLS)
	(OUT PER THROUGH-FALLS)
	(UP PER SLOPE-GONE)
	(SEE-ALL WALLS)
	(SEE-E CAVE-HOLE)
	(GLOBAL WATERFALL CAVE-HOLE SLOPE DSTRUCT ICAVE)
	(ACTION ICE-CAVE-F)>

<ROUTINE ICE-CAVE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're in a vast underground " D ,CAVE ", cold enough to see " D ,BREATH
". Icicles on the " D ,CEILING
" glitter in the light shining in through an " D ,CAVE-HOLE
" in the ">
		<SAY-EAST>
		<TELL 
" wall. Beyond it, a curtain of water fills the "
D ,CAVE " with its splashing roar." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE THROUGH-FALLS ()
	 <TELL "You edge your way around the " D ,WATERFALL ,PCR>
	 <RETURN ,AT-FALLS>>

<ROUTINE SLOPE-GONE ()
	 <COND (<IS? ,SLOPE ,SEEN>
		<GONE-NOW ,SLOPE>
		<RFALSE>)>
	 <TELL ,CANT "see any way up." CR>
	 <RFALSE>>

<OBJECT SBOG
	(LOC ROOMS)
	(DESC "South Bog")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR TRAP)
      ; (OVERHEAD 0)
        (HEAR STREAM)
	(NORTH TO NBOG)
	(NE TO AT-CHASM)
	(EAST TO GBASE)
	(SE TO AT-TRELS)
	(SOUTH TO FCLEARING)
	(SW PER UP-HILL)
	(UP PER UP-HILL)
	(WEST TO AT-FALLS)
        (NW SORRY "Black trees block your path.")
	(ACTION SBOG-F)
       	(SEE-ALL FOREST)
	(GLOBAL BOG FOREST STREAM SUMMIT DSTRUCT MIASMA)>

<ROUTINE SBOG-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,GROUND 
" is damp and squishy underfoot, especially along the " D ,STREAM 
" that wanders ">
		<SAY-WEST>
		<TELL " and south">
		<SAY-EAST>
		<TELL " between the black trees." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GBASE
	(LOC ROOMS)
	(DESC "Bottom of Stairs")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
	(OVERHEAD STAIR)
      ; (HEAR 0)
	(NORTH PER WALK-UP-STAIRS)
	(NE TO UNDER-CLIFF)
	(EAST TO AT-BEND)
	(SE TO DOCKSIDE)
	(SOUTH TO AT-TRELS)
	(SW TO FCLEARING)
	(WEST TO SBOG)
	(NW TO NBOG)
	(UP PER WALK-UP-STAIRS)
        (DOWN SORRY "You're already at the bottom of the stairs.")
	(ACTION GBASE-F)
	(SEE-ALL FOREST)
	(SEE-N STAIR)
	(GLOBAL STRUCTURE STAIR FOREST DSHADOW VERTEX)>


<ROUTINE GBASE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The triangular " D ,STRUCTURE 
" before you must be thousands of feet high. It" ,RAZOR
", casting a stern, precise " D ,DSHADOW " over the surrounding landscape.|
|
A narrow " D ,STAIR
" climbs north, up the hypotenuse of the triangle. Footpaths converge on the stair from every " D ,INTDIR ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WALK-UP-STAIRS ()
       	 <SETG STAIR-DIR " Up">
	 <TELL "With a fearful gulp, you ascend the narrow " D ,STAIR ,PCR>
	 <RETURN ,HALFWAY>>

<OBJECT HALFWAY
	(LOC ROOMS)
	(DESC "Halfway")
	(FLAGS LIGHTED LOCATION SHADOWY NOGRASS)
      ; (ODOR 0)
	(OVERHEAD STAIR)
      ; (HEAR 0)
	(UP PER HALFWAY-UP)
	(NORTH PER HALFWAY-UP)
	(DOWN PER HALFWAY-DOWN)
	(SOUTH PER HALFWAY-DOWN)
	(NE PER YOUD-FALL)
	(EAST PER YOUD-FALL)
	(SE PER YOUD-FALL)
	(SW PER YOUD-FALL)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(GLOBAL STAIR STRUCTURE DSHADOW VERTEX)
	(SEE-N STAIR)
	(SEE-S STAIR)
	(SEE-ALL HORIZON)
	(ACTION HALFWAY-F)>

<ROUTINE HALFWAY-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The breeze feels noticeably ">
		<COND (<EQUAL? ,STAIR-DIR " Up">
		       <TELL "cooler">)
		      (T
		       <TELL "warmer">)>
		<TELL " here, about halfway to the ">
		<COND (<EQUAL? ,STAIR-DIR " Up">
		       <TELL D ,VERTEX>)
		      (T
		       <TELL D ,GROUND>)>
		<TELL ,PTHE "landscape below is gray in the " D ,DSHADOW 
			    " of the triangle." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL STAIR-DIR:STRING " Up">

<ROUTINE HALFWAY-UP ()
	 <COND (<MOVE-HALFWAY? T>
		<RETURN ,ON-GNOMON>)>
	 <RFALSE>>

<ROUTINE HALFWAY-DOWN ()
	 <COND (<MOVE-HALFWAY?>
		<RETURN ,GBASE>)>
	 <RFALSE>>

<ROUTINE MOVE-HALFWAY? ("OPTIONAL" (UP? <>))
       	 <TELL "The air grows ">
	 <COND (<ZERO? .UP?>
		<TELL "warm">)
	       (T
		<TELL "cold">)>
	 <TELL "er as you continue your ">
	 <COND (<ZERO? .UP?>
		<TELL "de">)
	       (T
		<TELL "a">)>
	 <TELL "scent" ,PCR>
	 <RTRUE>>

<OBJECT ON-GNOMON
	(LOC ROOMS)
	(DESC "Vertex")
	(FLAGS LIGHTED LOCATION SHADOWY NOGRASS CHILLY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH PER YOUD-FALL)
	(UP SORRY "You're already at the top of the stairs.")
	(NE PER YOUD-FALL)
	(EAST PER YOUD-FALL)
	(SE PER YOUD-FALL)
	(SOUTH PER WALK-DOWN-STAIRS)
	(SW PER YOUD-FALL)
	(WEST PER YOUD-FALL)
	(NW PER YOUD-FALL)
	(OUT PER WHICH-WAY-OUT)
	(IN PER WHICH-WAY-IN)
	(DOWN PER WALK-DOWN-STAIRS)
	(GLOBAL STAIR STRUCTURE ROSE SYMBOLS DSHADOW VERTEX)
	(SEE-S STAIR)
	(SEE-ALL HORIZON)
	(ACTION ON-GNOMON-F)>

<ROUTINE ON-GNOMON-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The temperature on this tiny " D ,PLATFORM
" is well below freezing. But it isn't just the cold that makes your teeth chatter when you look down that narrow " D ,STAIR ", thousands of feet high.|
|
Far below, the " D ,DSHADOW " of the " D ,STRUCTURE
" stretches across the landscape. From this great altitude it looks like a dark finger, accusing a point on the " <GET ,SHDIRS 3> " " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (T
	        <RFALSE>)>>

<ROUTINE WALK-DOWN-STAIRS ()
       	 <SETG STAIR-DIR " Down">
	 <TELL "Fighting back fear, you descend the " D ,STAIR ,PCR>
	 <RETURN ,HALFWAY>>

<OBJECT ON-MOOR
	(LOC ROOMS)
	(DESC "Moor")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
        (HEAR CATS)
	(NORTH TO AT-CRATER)
	(NE SORRY "Tall cattails block your path.")
	(EAST SORRY "Tall cattails block your path.")
	(SE SORRY "The misty waters block your path.")
	(SOUTH SORRY "The misty waters block your path.")
	(SW SORRY "The misty waters block your path.")
	(WEST TO AT-BEND)
	(NW TO UNDER-CLIFF)
	(IN PER ON-MOOR-IN)
        (ACTION ON-MOOR-F)
	(SEE-ALL FOREST)
	(SEE-NE CATS)
	(SEE-E CATS)
	(SEE-SE STYX)
	(SEE-S STYX)
	(SEE-SW STYX)
	(GLOBAL STYX BEACH OPSHORE FOG TS5-DOOR DSTRUCT)>

<ROUTINE ON-MOOR-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Tall, solemn " D ,CATS
" line the banks of a great river that flows ">
		<SAY-EAST>
		<TELL 
"ward across the silent moor. A dense fog on the water obscures your view of the " D ,OPSHORE ".|
|
A pair of giant " D ,TS0 "s is growing among the " D ,CATS>
		<COND (<NOT <IS? ,TS5-DOOR ,NOALL>>
		       <TELL ,PTHE "larger one has a">
		       <OPEN-CLOSED ,TS5-DOOR T>
		       <TELL " set into the stem">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ON-MOOR-IN ()
	 <COND (<IS? ,TS5-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS5-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<SETG HOURS 10>
		<SETG MINUTES 54>
		<SETG SECONDS 0>
		<TELL "You ">
		<COND (<T? ,SUITED?>
		       <TELL "squeeze the " D ,FILM " through ">)
		      (T
		       <TELL "pass the threshold of ">)>
		<TELL THE ,TS5-DOOR "...">
		<CARRIAGE-RETURNS>
		<TELL "... and step into empty air" ,PCR>
		<RETURN ,IN-SKY>)
	       (T
		<ITS-CLOSED ,TS5-DOOR>
		<RFALSE>)>>

<OBJECT ON-HILL
	(LOC ROOMS)
	(DESC "Summit")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH SORRY "You'd tumble down the hill if you went that way.")
	(NE TO SBOG)
	(EAST TO FCLEARING)
	(SE SORRY "You'd tumble down the hill if you went that way.")
	(SOUTH TO IN-MEADOW)
	(SW SORRY "You'd tumble down the hill if you went that way.")
	(WEST SORRY "You'd tumble down the hill if you went that way.")
	(NW SORRY "You'd tumble down the hill if you went that way.")
        (DOWN PER WHICH-WAY-DOWN)
	(ACTION ON-HILL-F)
	(SEE-ALL FOREST)
	(SEE-E DSTRUCT)
	(GLOBAL STOOLS DSTRUCT SUMMIT FOREST DSHADOW)>

<ROUTINE ON-HILL-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,SUMMIT " you've climbed lies at the south">
		<SAY-WEST>
		<TELL " edge of a vast wilderness. Towering " D ,FOREST
"s are broken by long tracts of wasteland, rugged plateaus and marshes shrouded in perpetual mist. A brooding sun fills the distant " D ,VALLEY
"s with a sad, dusty light the color of antique brass.|
|
A " D ,DSTRUCT
", thousands of feet high, rises above the ">
		<SAY-EAST>
		<TELL "ern " D ,TREETOPS 
". Its vertex casts a long " D ,DSHADOW " across the wood.|
|
As your eyes sweep the landscape, you notice more of the giant " D ,STOOLS 
". ">
		<HUNDREDS-OF-THEM>
		<TELL 
" Some sprout in clusters, others grow in solitude among the trees. Their "
D ,INTNUM "s increase dramatically as your gaze moves ">
		<SAY-WEST>
		<TELL "ward, until the " D ,FOREST 
		      " is choked with pale domes." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HUNDREDS-OF-THEM ()
	 <TELL "There must be hundreds of them.">
	 <RTRUE>>

<OBJECT FCLEARING
	(LOC ROOMS)
	(DESC "Forest Clearing")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(OVER-HEDGE SWPATH)
	(NORTH TO SBOG)
	(NE TO GBASE)
	(EAST TO AT-TRELS)
	(SE PER HEDGE-BLOCKS)
	(SOUTH PER HEDGE-BLOCKS)
	(SW PER HEDGE-BLOCKS)
	(WEST PER UP-HILL)
	(UP PER UP-HILL)
	(NW TO AT-FALLS)
        (ACTION FCLEARING-F)
	(SEE-ALL FOREST)
	(SEE-SE HEDGE)
	(SEE-S HEDGE)
	(SEE-SW HEDGE)
	(GLOBAL FOREST HEDGE ARBS SUMMIT DSTRUCT)>

<ROUTINE FCLEARING-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"It must have taken centuries to cultivate the magnificent " D ,HEDGE 
" rising before you. The tightly woven " D ,ARBS " stretch ">
		<SAY-EAST>
		<TELL "ward through the " D ,FOREST
		      " like a green wall, thirty feet high.|
|
A barren hilltop is visible to the ">
		<SAY-WEST>
		<TELL ". Many footpaths wander off"> 
		<TWEEN-TREES>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-TRELS
	(LOC ROOMS)
	(DESC "Trellises")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR HEDGE)
      ; (OVERHEAD 0)
        (HEAR STREAM)
	(OVER-HEDGE ARBORETUM)
	(NORTH TO GBASE)
	(NE TO AT-BEND)
	(EAST TO DOCKSIDE)
	(SE TO SEPATH)
        (SOUTH PER HEDGE-BLOCKS)
	(SW TO SWPATH)
	(WEST TO FCLEARING)
	(NW TO SBOG)
        (IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(ACTION AT-TRELS-F)
	(SEE-ALL FOREST)
	(SEE-SE LTREL)
	(SEE-SW RTREL)
	(SEE-S HEDGE)
	(GLOBAL FOREST HEDGE ARBS STREAM DSTRUCT)>

<ROUTINE AT-TRELS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A fortresslike wall of " D ,ARBS " stretches east and west through the "
D ,FOREST ,PTHE "only breach is an identical pair of arched " 
D ,TRELS ,PCR "A mountain " D ,STREAM " trickles">
		<TWEEN-TREES <>>
		<TELL 
". Paths wander from its banks in many " D ,INTDIR "s." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DOCKSIDE
	(LOC ROOMS)
	(DESC "The River")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(OVER-HEDGE SEPATH)
	(NORTH TO AT-BEND)
	(NE SORRY "The misty waters block your path.")
	(EAST SORRY "The misty waters block your path.")
	(SE SORRY "The misty waters block your path.")
	(SOUTH PER HEDGE-BLOCKS)
	(SW PER HEDGE-BLOCKS)
	(WEST TO AT-TRELS)
	(NW TO GBASE)
        (IN PER DORY-IN)
	(OUT PER DOCKSIDE-OUT)
	(ACTION DOCKSIDE-F)
        (SEE-N BEACH)
	(SEE-S HEDGE)
	(SEE-SW HEDGE)
	(SEE-W FOREST)
	(SEE-NW FOREST)
	(SEE-ALL STYX)
	(GLOBAL HEDGE ARBS STYX FOG DSTRUCT BEACH OPSHORE FOREST)>

<ROUTINE DOCKSIDE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<DESCRIBE-DOCKSIDE>  
		<TELL CR 
"Footpaths wander north, west and northwest. Turning south, you see a magnificent "
D ,HEDGE " growing in an unbroken wall to the " D ,STYX "'s edge." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,DORY ,NODESC>>>
		<MAKE ,DORY ,NODESC>
		<QUEUE I-STYX -1>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-DOCKSIDE ()
	 <TELL "You're ">
	 <COND (<T? ,IN-DORY?>
		<TELL "in a dory">)
	       (T
		<TELL "on a lifeless strip of sand">)>
	 <TELL " beside a great " D ,STYX
,PTHE "water is unnaturally dark and still; ribbons of mist coil across its "
D ,CSURFACE " like ghostly fingers, obscuring what lies beyond." CR>
	 <RTRUE>>

<ROUTINE DOCKSIDE-OUT ()
	 <COND (<T? ,IN-DORY?>
		<PERFORM ,V?EXIT ,DORY>
		<RFALSE>)>
	 <WHICH-WAY-OUT>
	 <RFALSE>>

<OBJECT AT-BEND
	(LOC ROOMS)
	(DESC "The Bend")
	(FLAGS LIGHTED LOCATION SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(HEAR STREAM)
	(NORTH TO UNDER-CLIFF)
	(NE TO AT-CRATER)
	(EAST TO ON-MOOR)
	(SE SORRY "The misty waters block your path.")
	(SOUTH TO DOCKSIDE)
	(SW TO AT-TRELS)
	(WEST TO GBASE)
	(NW TO AT-CHASM)
	(ACTION AT-BEND-F)
	(SEE-ALL FOREST)
	(SEE-S BEACH)
	(SEE-SE STYX)
	(GLOBAL STYX FOG STREAM DSTRUCT BEACH OPSHORE)>

<ROUTINE AT-BEND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "An exhausted " D ,STREAM
" trickles into a river that bends" ,TOS " and ">
		<SAY-EAST>
		<TELL ,PTHE D ,OPSHORE " is veiled behind a thick mist.|
|
Paths meander off in many " D ,INTDIR "s from the river's edge." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-MEADOW
	(LOC ROOMS)
	(DESC "Meadow")
	(FLAGS LIGHTED LOCATION ; SHADOWY)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(UP PER UP-HILL)
	(NORTH PER UP-HILL)
	(NE PER MEADOW-EXIT)
	(EAST PER MEADOW-EXIT)
	(SE PER MEADOW-EXIT)
	(SOUTH PER MEADOW-EXIT)
	(SW PER MEADOW-EXIT)
	(WEST PER MEADOW-EXIT)
	(NW PER MEADOW-EXIT)
        (IN PER DOOR-NOT-HERE)
	(ACTION IN-MEADOW-F)
        (SEE-ALL FOREST)
	(SEE-N SUMMIT)
	(GLOBAL TS0-DOOR DSTRUCT SUMMIT FOREST DFLIES)>

<ROUTINE IN-MEADOW-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You've discovered a golden " D ,MEADOW
", bordered on every side by a dense " D ,FOREST
,PTHE "air is filled with " D ,DFLIES
", and the wood echoes with the cry of mourning doves" ,PCR>
		<COND (<IS? ,IN-MEADOW ,SHADOWY>
		       <TELL "A giant " D ,TS0 " is growing nearby." CR>
		       <RTRUE>)>
		<TELL
"The door you just stepped from opens into a " D ,TS0 
" of impossible size. Its broad crown towers over your head like a fleshy " 
D ,PARASOL ,PERIOD>  
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<MAKE ,IN-MEADOW ,SHADOWY>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-EXIT>
		<UNMAKE ,IN-MEADOW ,SEEN>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE MEADOW-EXIT ()
	 <TELL "The dense " D ,FOREST " is hopelessly impenetrable">
	 <COND (<IS? ,IN-MEADOW ,SEEN>
		<PRINT ,PERIOD>
		<RFALSE>)>
	 <MAKE ,IN-MEADOW ,SEEN>
	 <TELL 
". But an obscure path winds north, to the summit of a gentle hill." CR>
	 <RFALSE>>

<ROUTINE UP-HILL ()
	 <TELL "You ascend the gentle " D ,SUMMIT ,PCR>
	 <RETURN ,ON-HILL>>

<OBJECT SWPATH
	(LOC ROOMS)
	(DESC "Arborvitaes")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR HEDGE)
        (OVERHEAD HEDGE)
      ; (HEAR 0)
	(OVER-HEDGE FCLEARING)
	(NORTH PER HEDGE-BLOCKS)
	(NE TO AT-TRELS)
	(EAST TO ARBORETUM)
	(SE PER HEDGE-BLOCKS)
	(SOUTH PER HEDGE-BLOCKS)
	(SW PER HEDGE-BLOCKS)
	(WEST PER HEDGE-BLOCKS)
	(NW PER HEDGE-BLOCKS)
        (ACTION SWPATH-F)
	(SEE-ALL HEDGE)
	(SEE-NE PATH)
	(SEE-E PATH)
	(GLOBAL HEDGE ARBS DSTRUCT)>

<ROUTINE SWPATH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SAY-HEDGE-PATH>
		<SAY-EAST>
		<TELL " and north">
		<SAY-EAST>
		<PRINT ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SEPATH
	(LOC ROOMS)
	(DESC "Arborvitaes")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR HEDGE)
	(OVERHEAD HEDGE)
      ; (HEAR 0)
	(OVER-ARBOR DOCKSIDE)
	(NORTH PER HEDGE-BLOCKS)
	(NE PER HEDGE-BLOCKS)
	(EAST PER HEDGE-BLOCKS)
	(SE PER HEDGE-BLOCKS)
	(SOUTH PER HEDGE-BLOCKS)
	(SW PER HEDGE-BLOCKS)
	(WEST TO ARBORETUM)
	(NW TO AT-TRELS)
        (ACTION SEPATH-F)
	(SEE-ALL HEDGE)
	(SEE-NW PATH)
	(SEE-W PATH)
	(GLOBAL HEDGE ARBS DSTRUCT)>

<ROUTINE SEPATH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SAY-HEDGE-PATH>
		<SAY-WEST>
		<TELL " and north">
		<SAY-WEST>
		<PRINT ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-HEDGE-PATH ()
	 <TELL 
"Barely eighteen inches separate the thick walls of arborvitae that "
D ,TOWER " on either side. They form an uncomfortably narrow corridor that bends sharply to the ">
	 <RTRUE>>

<OBJECT ARBORETUM
	(LOC ROOMS)
	(DESC "Arboretum")
	(FLAGS LIGHTED LOCATION SHADOWY)
	(ODOR HEDGE)
	(OVERHEAD ARBOR)
      ; (HEAR 0)
	(OVER-HEDGE AT-TRELS)
	(UP PER WHICH-WAY-UP-NS)
	(IN PER WHICH-WAY-IN-NS)
	(OUT PER WHICH-WAY-OUT)
	(NORTH PER ENTER-ARBOR-N)
	(NE PER HEDGE-BLOCKS)
	(EAST TO SEPATH)
	(SE PER HEDGE-BLOCKS)
	(SOUTH PER ENTER-ARBOR-S)
	(SW PER HEDGE-BLOCKS)
	(WEST TO SWPATH)
	(NW PER HEDGE-BLOCKS)
        (ACTION ARBORETUM-F)
	(SEE-N ARBOR)
	(SEE-S ARBOR)
	(SEE-E PATH)
	(SEE-W PATH)
	(SEE-ALL HEDGE)
	(GLOBAL ARBOR HEDGE ARBS DSTRUCT)>

<ROUTINE WHICH-WAY-UP-NS ()
	 <WHICH-WAY "up, north or south">
	 <RFALSE>>

<ROUTINE WHICH-WAY-IN-NS ()
	 <WHICH-WAY "in, north or south">
	 <RFALSE>>

<ROUTINE ARBORETUM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A spectacular " D ,ARBOR " of " D ,ARBS 
" arches over your head like a great green Ferris wheel. Its tangled " 
D ,CSURFACE 
"s are peculiarly twisted, making it difficult to tell where the inside ends and the outside begins.|
|
">
		<DESCRIBE-PERGOLA>
		<TELL 
"Other paths lead east and west, into the surrounding " D ,HEDGE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-PERGOLA ()
	 <TELL "Steep, leafy " D ,TUNNEL "s curve up into the " D ,ARBOR 
	       ,TON " and south. ">
	 <RTRUE>>

<ROUTINE ENTER-ARBOR-N ()
	 <ENTER-ARBOR ,P?NORTH>
	 <RETURN ,NORTH-ARBOR>>

<ROUTINE ENTER-ARBOR-S ()
	 <ENTER-ARBOR ,P?SOUTH>
	 <RETURN ,SOUTH-ARBOR>>

<GLOBAL ENTERED-ARBOR:DIRECTION <>>

<ROUTINE ENTER-ARBOR (DIR)
	 <SETG ENTERED-ARBOR .DIR>
	 <TELL "You ascend the ">
	 <COND (<EQUAL? .DIR ,P?SOUTH>
		<TELL "sou">)
	       (T
		<TELL "nor">)>
	 <TELL "th side of the " D ,ARBOR ,PCR>
	 <RTRUE>>

<OBJECT NORTH-ARBOR
	(LOC ROOMS)
	(DESC "North Arbor")
	(FLAGS LIGHTED LOCATION INDOORS SHADOWY)
      ; (HEAR 0)
	(ODOR HEDGE)
	(OVERHEAD ARBOR)
	(NORTH SORRY "You can only go up or down from here.")
	(NE PER SOMETHING-BUSHY)
	(EAST PER SOMETHING-BUSHY)
	(SE PER SOMETHING-BUSHY)
	(SOUTH SORRY "You can only go up or down from here.")
	(SW PER SOMETHING-BUSHY)
	(WEST PER SOMETHING-BUSHY)
	(NW PER SOMETHING-BUSHY)
	(UP PER TO-ARBOR-TOP)
	(DOWN PER EXIT-ARBOR-N)
	(OUT PER EXIT-ARBOR-N)
	(IN PER TO-ARBOR-TOP)
        (ACTION ARBORSIDE-F)
	(SEE-ALL ARBS)
	(GLOBAL ARBOR HEDGE ARBS)>

<ROUTINE TO-ARBOR-TOP ()
	 <FLOOR-TWISTS>
	 <TELL "continue your ascent" ,PCR>
	 <RETURN ,ARBOR-TOP>>

<ROUTINE FLOOR-TWISTS ()
	 <TELL CTHE ,FLOOR " twists alarmingly as you ">
	 <RTRUE>>

<OBJECT SOUTH-ARBOR
	(LOC ROOMS)
	(DESC "South Arbor")
	(FLAGS LIGHTED LOCATION INDOORS SHADOWY)
      ; (HEAR 0)
	(ODOR HEDGE)
	(OVERHEAD ARBOR)
	(NORTH SORRY "You can only go up or down from here.")
	(NE PER SOMETHING-BUSHY)
	(EAST PER SOMETHING-BUSHY)
	(SE PER SOMETHING-BUSHY)
	(SOUTH SORRY "You can only go up or down from here.")
	(SW PER SOMETHING-BUSHY)
	(WEST PER SOMETHING-BUSHY)
	(NW PER SOMETHING-BUSHY)
	(UP PER TO-ARBOR-TOP)
	(DOWN PER EXIT-ARBOR-S)
	(OUT PER EXIT-ARBOR-S)
	(IN PER TO-ARBOR-TOP)
        (ACTION ARBORSIDE-F)
	(SEE-ALL ARBS)
	(GLOBAL ARBOR HEDGE ARBS)>

<ROUTINE ARBORSIDE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The \"" D ,FLOOR "\" of the " D ,ARBOR 
" curves up and around in an inexplicable way that makes your eyes cross. It seems as if you'd be standing on your head if you went much higher. Little daylight makes its way through the thick walls of arborvitae." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-ARBOR-N ()
	 <EXIT-ARBOR ,P?NORTH>
	 <RETURN ,ARBORETUM>>

<ROUTINE EXIT-ARBOR-S ()
	 <EXIT-ARBOR ,P?SOUTH>
	 <RETURN ,ARBORETUM>>

<ROUTINE EXIT-ARBOR (DIR "AUX" (CNT 0) OBJ X)
	 <COND (<NOT <EQUAL? ,ENTERED-ARBOR .DIR>>
	      	<COND (<ZERO? ,FLIP?>
		       <SETG FLIP? T>)
	              (T
		       <SETG FLIP? <>>)>
	        <RESET-SHDIRS>
		<REPEAT ()
		        <SET OBJ <GET ,FLIPPERS .CNT>>
		        <COND (<ZERO? .OBJ>
			       <RETURN>)>
		        <SET X <GOT? .OBJ>>
			<COND (<ZERO? .X>
			       <COND (<AND <EQUAL? .OBJ ,WTK>
					   <NOT <IS? .OBJ ,TOUCHED>>>
				      T)
				     (<IS? .OBJ ,FLIPPED>
			              <UNMAKE .OBJ ,FLIPPED>)
			             (T
			              <MAKE .OBJ ,FLIPPED>)>)>
		        <INC CNT>>)>
	 <FLOOR-TWISTS>
	 <TELL "descend" ,PCR>
	 <RTRUE>>

<GLOBAL FLIPPERS:TABLE
	<PTABLE GNOMON CREDIT-CARD OCRANE BAD-CRANE PARASOL WTK
		SCOIN BCOIN 0>>

<OBJECT ARBOR-TOP
	(LOC ROOMS)
	(DESC "Top of Arbor")
	(FLAGS LOCATION INDOORS SHADOWY)
      ; (HEAR 0)
	(ODOR HEDGE)
	(OVERHEAD 0)
	(NORTH TO NORTH-ARBOR)
	(SOUTH TO SOUTH-ARBOR)
	(DOWN PER WHICH-WAY-DOWN)
	(OUT PER WHICH-WAY-OUT)
	(IN PER WHICH-WAY-IN)
	(NE PER SOMETHING-BUSHY)
	(EAST PER SOMETHING-BUSHY)
	(SE PER SOMETHING-BUSHY)
	(SW PER SOMETHING-BUSHY)
	(WEST PER SOMETHING-BUSHY)
	(NW PER SOMETHING-BUSHY)
        (ACTION ARBOR-TOP-F)
	(SEE-ALL ARBS)
	(GLOBAL ARBOR HEDGE ARBS)>

<ROUTINE ARBOR-TOP-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The tangled vines and tendrils seem to writhe malignantly in the ">
		<COND (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL "faltering glow of the " D ,LAMP>)
		      (T
		       <TELL "flickering light of the " D ,SHARD>)>
		<TELL ". ">
		<SMELL-HEDGE>
		<TELL CR "Dark, leafy " D ,TUNNEL 
"s curve down" ,TON " and south." CR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<TELL CR
"Your sense of " D ,INTDIR " is very confused." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SOMETHING-BUSHY ()
	 <COND (<ZERO? ,LIT?>
		<TELL "Something bushy blocks">)
	       (T
		<TELL "Arborvitaes block">)>
	 <TELL " your path." CR>
	 <RFALSE>>

<OBJECT ON-BEACH
	(LOC ROOMS)
	(DESC "Sand Bar")
	(FLAGS LIGHTED LOCATION SHADOWY NOGRASS)
      ; (HEAR 0)
      ; (ODOR 0)
        (OVERHEAD FOG)
	(NORTH SORRY "The misty waters block your path.")
	(NE SORRY "The misty waters block your path.")
	(EAST SORRY "The misty waters block your path.")
	(SE SORRY "The misty waters block your path.")
	(SOUTH TO ON-ISLE)
	(SW SORRY "The misty waters block your path.")
	(WEST SORRY "The misty waters block your path.")
	(NW SORRY "The misty waters block your path.")
	(IN PER DORY-IN)
	(ACTION ON-BEACH-F)
	(SEE-ALL STYX)
	(SEE-S BEACH)
	(GLOBAL STYX FOG ; DSTRUCT BEACH OPSHORE)>

<ROUTINE ON-BEACH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"At first glance, this isolated spit seems hopelessly mired in the fog blowing in off the surrounding river. But the sand looks a bit firmer" ,TOS ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ON-ISLE
	(LOC ROOMS)
	(DESC "Islet")
	(FLAGS LIGHTED LOCATION SHADOWY NOGRASS)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD FOG)
	(NORTH TO ON-BEACH)
	(NE SORRY "The misty waters block your path.")
	(EAST SORRY "The misty waters block your path.")
	(SE SORRY "The misty waters block your path.")
	(SOUTH SORRY "The misty waters block your path.")
	(SW SORRY "The misty waters block your path.")
	(WEST SORRY "The misty waters block your path.")
	(NW SORRY "The misty waters block your path.")
	(IN PER ON-ISLE-IN)
        (ACTION ON-ISLE-F)
	(SEE-ALL STYX)
	(SEE-N PATH)
	(GLOBAL STYX FOG TS6-DOOR DSTRUCT BEACH OPSHORE)>
	
<ROUTINE ON-ISLE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"It's impossible to see more than a dozen yards on this fogbound islet. The damp air makes your footsteps sound unnaturally loud as you trudge across the sand at the river's edge.|
|
A lone " D ,TS6 " has found a home at the water's edge">
		<MENTION-DOOR ,TS6-DOOR>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<NOT <IS? ,ON-ISLE ,SEEN>>
		       <MAKE ,ON-ISLE ,SEEN>
		       <CRLF>
		       <VOICE-MUTTERS "Gnomon is an island" <>>)>
		<COND (<IN? ,MEEP ,TS6>
		       <MAKE ,MEEP ,SEEN>
		       <SETG P-IT-OBJECT ,MEEP>
		       <TELL CR "A " D ,MEEP 
			    " is perched on the " D ,TS6 "'s crown">
		       <ENTICINGLY>
		       <TELL ,PERIOD>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTICINGLY ()
	 <TELL ,PTHE "ruby in its beak gleams enticingly">
	 <RTRUE>>

<ROUTINE ON-ISLE-IN ()
	 <COND (<IS? ,TS6-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS6-DOOR ,OPENED>
		<COND (<BROLLY-OPEN?>
		       <RFALSE>)>
		<TELL "You take a deep breath, and step forward.">
		<CARRIAGE-RETURNS>
		<GO-TO-SHACK>
		<RETURN ,IN-SHACK>)
	       (T
		<ITS-CLOSED ,TS6-DOOR>
		<RFALSE>)>>

<GLOBAL TR?:FLAG <>>

<ROUTINE GO-TO-SHACK ("AUX" (CNT 0))
	 <SETG TR? T>
	 <SETG FLIP? <>>
	 <REPEAT ()
		 <PUT ,WIRE-TYPES .CNT <PICK-ONE ,WIRE-COLORS>>
		 <COND (<IGRTR? CNT 3>
			<RETURN>)>>
	 <MAKE ,METEOR ,NOALL>
	 <DEQUEUE I-WTK>
	 <DEQUEUE I-SHADOW>
	 <SETG MINUTES 58>
	 <SETG SECONDS 30>
	 <SETG HOURS 4>
	 <QUEUE I-VOICES -1>
	 <MOVE ,GROVES ,GLOBAL-OBJECTS>
	 <RTRUE>>

"WIRE-TYPES identifies each of the four colored wires.
 0 = red, 1 = blue, 2 = striped, 3 = white."

<GLOBAL WIRE-TYPES:TABLE <TABLE 0 0 0 0>>
<GLOBAL WIRE-COLORS:TABLE <LTABLE 0 "POS" "GND" "INF" "DET">>
<GLOBAL XWIRE:OBJECT <>> "Magic wire stored here."

"PICK-ONE expects an LTABLE of strings, with an initial element of 0."

<ROUTINE PICK-ONE (TBL "AUX" L CNT RND MSG RTBL)
	 <SET L <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <DEC L>
	 <SET TBL <REST .TBL 2>>
	 <SET RTBL <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RTBL .RND>>
	 <PUT .RTBL .RND <GET .RTBL 1>>
	 <PUT .RTBL 1 .MSG>
	 <INC CNT>
	 <COND (<EQUAL? .CNT .L> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 <RETURN .MSG>>

"*** SPACE ***"

<OBJECT IN-ORBIT
	(LOC ROOMS)
	(DESC "Earth Orbit")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (HEAR 0)
	(OVERHEAD STARS)
      ; (ODOR 0)
	(NORTH PER NO-PROPULSION)
	(NE PER NO-PROPULSION)
	(EAST PER NO-PROPULSION)
	(SE PER NO-PROPULSION)
	(SOUTH PER NO-PROPULSION)
	(SW PER NO-PROPULSION)
	(WEST PER NO-PROPULSION)
	(NW PER NO-PROPULSION)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(UP PER NO-PROPULSION)
	(DOWN PER NO-PROPULSION)
        (ACTION IN-ORBIT-F)
	(SEE-ALL STARS)
	(GLOBAL XRAY STARS MOON ICBM THRUSTERS TS1-DOOR PLANET)>

<ROUTINE IN-ORBIT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"You're five hundred miles above a sea of ice, hurtling in profound silence over the Arctic atmosphere. Layers of crimson and violet describe the curve of the " D ,HORIZON 
", blending imperceptibly into a black sky crowded with stars." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-BEG>
		     <ZERO? ,SUITED?>
		     <OR <VERB? LISTEN SMELL>
			 <INTBL? ,PRSA ,TALKVERBS ,NTVERBS>>>
		<DONT-PROPAGATE>
		<RTRUE>)
	     ; (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,IN-ORBIT ,SEEN>>>
		<MAKE ,IN-ORBIT ,SEEN>
		<SETG DO-WINDOW <GET ,QUOTES, RONNIE>>
		<RFALSE>)
	       (T
		<RFALSE>)>> 

<ROUTINE DONT-PROPAGATE ()
	 <COND (<VERB? SMELL>
		<TELL "Odor">)
	       (T
		<TELL "Sound">)>
	 <TELL "s don't propagate well in a vacuum." CR>
	 <RTRUE>>

<ROUTINE NO-PROPULSION ()
	 <TELL "You have no means of propulsion." CR>
	 <RFALSE>> 

<OBJECT ON-SAT
	(LOC ROOMS)
	(DESC "Earth Orbit, on a satellite")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD STARS)
	(NORTH PER NO-PROPULSION)
	(NE PER NO-PROPULSION)
	(EAST PER NO-PROPULSION)
	(SE PER NO-PROPULSION)
	(SOUTH PER NO-PROPULSION)
	(SW PER NO-PROPULSION)
	(WEST PER NO-PROPULSION)
	(NW PER NO-PROPULSION)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(UP PER NO-PROPULSION)
	(DOWN PER NO-PROPULSION)
        (ACTION ON-SAT-F)
	(SEE-ALL STARS)
	(GLOBAL XRAY STARS MOON ICBM THRUSTERS TS1-DOOR PLANET)>

<ROUTINE ON-SAT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<LOOK-AT-XRAY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-AT-XRAY ()
	 <TELL CTHE ,XRAY>
	 <COND (<HERE? ON-SAT>
	        <TELL " you're riding">)
	       (T
		<TELL " drifting ">
		<COND (<EQUAL? ,ORBCNT 3>
		       <TELL "closer to ">)
		      (<G? ,ORBCNT 5>
		       <TELL "away from ">)
		      (T
		       <TELL "past ">)>
		<TELL "you">)>
	 <TELL " is about twenty feet long, and shaped like a beer can">
	 <COND (<HERE? ON-SAT>
		<TELL ,PTHE D ,FILM 
" around you is anchored to the " D ,XRAY "'s hull by the " D ,LUMP>)>
	 <PRINT ,PERIOD>		
	 <RTRUE>>

"*** TUNDRA ***"

<OBJECT ON-PLATFORM
	(LOC ROOMS)
	(DESC "Platform")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(DOWN PER DOWN-PLADDER)
	(NORTH PER PLAT-FALL)
	(NE PER PLAT-FALL)
	(EAST PER PLAT-FALL)
	(SE PER PLAT-FALL)
	(SOUTH PER ON-PLATFORM-IN)
	(SW PER PLAT-FALL)
	(WEST PER PLAT-FALL)
	(NW PER PLAT-FALL)
	(IN PER ON-PLATFORM-IN)
	(ACTION ON-PLATFORM-F)
	(SEE-ALL TMOUNTS)
	(GLOBAL TUNDRA PLATFORM PLADDER TMOUNTS TS4-DOOR RSPEAKER)>

<ROUTINE ON-PLATFORM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"This narrow " D ,PLATFORM
" is attached" ,TON " side of a huge steel " D ,TBOMB
", fifty feet high. All around you, a frozen wasteland stretches off to a " 
D ,HORIZON " lined with gray " D ,TMOUNTS ,PCR>
		<COND (<IS? ,TS4-DOOR ,NOALL>
		       <TELL "A " D ,PLADDER " leads downward." CR>
		       <RTRUE>)>
		<TELL "A">
		<OPEN-CLOSED ,TS4-DOOR T>
		<TELL 
" leads into the " D ,TBOMB 
"'s interior. The topmost rungs of a " D ,PLADDER " stand beside it." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PLAT-FALL ()
	 <YOUD-FALL-OFF ,PLATFORM>
	 <RFALSE>>

<ROUTINE ON-PLATFORM-IN ()
	 <COND (<IS? ,TS4-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS4-DOOR ,OPENED>
		<DEQUEUE I-RCOUNT>
		<DEQUEUE I-RODENTS>
		<COND (<G? ,MINUTES 49>
		       <TELL "Numb with cold, you ">)
		      (T
		       <TELL "You ">)>
		<TELL "leap across the jamb of the " D ,TS4-DOOR ,PERIOD>
		<EXIT-HOLE ,TS4-DOOR ,IN-GARDEN>
		<RFALSE>)>
	 <ITS-CLOSED ,TS4-DOOR>
	 <RFALSE>>

<ROUTINE EXIT-HOLE (DOOR TO)
	 <SETG HERE .TO>
	 <MOVE ,PLAYER .TO>
	 <SETG ODEG 6>
	 <MAKE .DOOR ,NOALL>
	 <UNMAKE .DOOR ,OPENED>
	 <CARRIAGE-RETURNS>
	 <V-LOOK>	 
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL CR CTHE .DOOR 
" fades away into the texture of the " D ,TS0 ,PERIOD>
	 <RTRUE>>

<ROUTINE DOWN-PLADDER ()
	 <TELL "You descend the " D ,PLADDER ,PCR>
	 <RETURN ,UNDER-PLAT>>

<OBJECT UNDER-PLAT
	(LOC ROOMS)
	(DESC "Under Platform")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD PLATFORM)
	(NORTH TO BTUN)
	(NE TO CTUN)
	(EAST TO ETUN)
	(SE TO HTUN)
	(SOUTH TO GTUN)
	(SW TO FTUN)
	(WEST TO DTUN)
	(NW TO ATUN)
	(UP PER UP-PLADDER)
	(GLOBAL PLATFORM TUNDRA PLADDER LEMMINGS RODENTS TCABLES RSPEAKER)
	(SEE-ALL TUNDRA)
	(ACTION UNDER-PLAT-F)>

<ROUTINE UNDER-PLAT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A network of " D ,TCABLES " snakes down the side of the " D ,TBOMB
", then trails southwest across the " D ,TUNDRA 
". Grim tracts of permafrost greet your eyes every way you turn.|
|
A " D ,PLADDER " leads up to a " D ,PLATFORM " overhead." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE UP-PLADDER ()
	 <TELL "You ascend the " D ,PLADDER ,PCR>
	 <RETURN ,ON-PLATFORM>>

<OBJECT ATUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH SORRY "Steep mountains block your path.")
	(NE SORRY "Steep mountains block your path.")
	(EAST TO BTUN)
	(SE TO UNDER-PLAT)
	(SOUTH TO DTUN)
	(SW PER DESOLATION)
	(WEST PER DESOLATION)
	(NW SORRY "Steep mountains block your path.")
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION ATUN-F)
	(SEE-ALL TUNDRA)
	(SEE-N TMOUNTS)
	(SEE-NE TMOUNTS)
	(SEE-NW TMOUNTS)
	(SEE-SE PLATFORM)
	(GLOBAL PLATFORM TUNDRA TMOUNTS LEMMINGS RODENTS)
	(PLAT-DIR P?SE)>

<ROUTINE ATUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The frozen earth slopes north to meet a gray wall of "
D ,TMOUNTS ". " ,YOU-SEE THE ,TBOMB " on the southeast " 
D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESOLATION ()
	 <TELL "There's nothing but cold desolation in " D ,RIGHT ,PERIOD>
	 <RFALSE>>

<OBJECT BTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH SORRY "Steep mountains block your path.")
	(NE SORRY "Steep mountains block your path.")
	(EAST TO CTUN)
	(SE TO ETUN)
	(SOUTH TO UNDER-PLAT)
	(SW TO DTUN)
	(WEST TO ATUN)
	(NW SORRY "Steep mountains block your path.")
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION BTUN-F)
	(SEE-ALL TUNDRA)
	(SEE-N TMOUNTS)
	(SEE-NE TMOUNTS)
	(SEE-NW TMOUNTS)
	(SEE-S PLATFORM)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS)
	(PLAT-DIR P?SOUTH)>

<ROUTINE BTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,TMOUNTS
" range east and west, dark against the frozen ground. The " D ,TBOMB 
" is visible far" ,TOS ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH SORRY "Steep mountains block your path.")
	(NE PER TO-CLIFF)
	(EAST SORRY "Steep mountains block your path.")
	(SE SORRY "Steep mountains block your path.")
	(SOUTH TO ETUN)
	(SW TO UNDER-PLAT)
	(WEST TO BTUN)
	(NW SORRY "Steep mountains block your path.")
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION CTUN-F)
	(GLOBAL TUNDRA PLATFORM PASS TMOUNTS LEMMINGS RODENTS)
	(SEE-ALL TMOUNTS)
	(SEE-NE PASS)
	(SEE-S TUNDRA)
	(SEE-SW PLATFORM)
	(SEE-W TUNDRA)
	(PLAT-DIR P?SW)>

<ROUTINE CTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A prehistoric " D ,PASS " cuts a narrow pass through the " D ,TMOUNTS
" rising north and east. The " D ,TBOMB
" is a gray sentinel on the southwest " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TO-CLIFF ()
	 <TELL "You follow the stream of " D ,RATS ,PCR>
	 <RETURN ,CLIFF-EDGE>>

<OBJECT DTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH TO ATUN)
	(NE TO BTUN)
	(EAST TO UNDER-PLAT)
	(SE TO GTUN)
	(SOUTH TO FTUN)
	(SW PER DESOLATION)
	(WEST PER DESOLATION)
	(NW PER DESOLATION)
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION DTUN-F)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS)
	(SEE-ALL TUNDRA)
	(SEE-E PLATFORM)
	(PLAT-DIR P?EAST)>

<ROUTINE DTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Arctic winds whip across the permafrost in bone-chilling gusts. The distant "
D ,TBOMB " is outlined against the eastern " D ,TMOUNTS ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ETUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH TO CTUN)
	(NE SORRY "Steep mountains block your path.")
	(EAST SORRY "Steep mountains block your path.")
	(SE SORRY "Steep mountains block your path.")
	(SOUTH TO HTUN)
	(SW TO GTUN)
	(WEST TO UNDER-PLAT)
	(NW TO BTUN)
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION ETUN-F)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS)
	(SEE-ALL TUNDRA)
	(SEE-NE TMOUNTS)
	(SEE-E TMOUNTS)
	(SEE-SE TMOUNTS)
	(SEE-W PLATFORM)
	(PLAT-DIR P?WEST)>

<ROUTINE ETUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The barren ground stretches west towards the distant " D ,TBOMB 
" and beyond. Gray " D ,TMOUNTS " rise like a fortress" ,TOE ,PERIOD>  
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH TO DTUN)
	(NE TO UNDER-PLAT)
	(EAST TO GTUN)
	(SE PER DESOLATION)
	(SOUTH PER DESOLATION)
	(SW PER MEET-RUSKIES)
	(WEST PER DESOLATION)
	(NW PER DESOLATION)
	(ACTION FTUN-F)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS TCABLES)
	(SEE-ALL TUNDRA)
	(SEE-NE PLATFORM)
	(SEE-SW GROUP)
	(PLAT-DIR P?NE)>

<ROUTINE FTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The tall " D ,TBOMB
" is still visible on the northeastern " D ,HORIZON ". Thick " 
D ,TCABLES " run southwest across the permafrost, towards a distant "
D ,GROUP ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<SETG P-THEM-OBJECT ,GROUP>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT GTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH TO UNDER-PLAT)
	(NE TO ETUN)
	(EAST TO HTUN)
	(SE PER DESOLATION)
	(SOUTH PER DESOLATION)
	(SW PER DESOLATION)
	(WEST TO FTUN)
	(NW TO DTUN)
	(ACTION GTUN-F)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS)
	(SEE-ALL TUNDRA)
	(SEE-N PLATFORM)
	(PLAT-DIR P?NORTH)>

<ROUTINE GTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Only the " D ,TBOMB " on the northern " D ,HORIZON
" breaks the monotony of this frozen plain." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HTUN
	(LOC ROOMS)
	(DESC "Tundra")
	(FLAGS LIGHTED LOCATION CHILLY)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(NORTH TO ETUN)
	(NE SORRY "Steep mountains block your path.")
	(EAST SORRY "Steep mountains block your path.")
	(SE SORRY "Steep mountains block your path.")
	(SOUTH PER DESOLATION)
	(SW PER DESOLATION)
	(WEST TO GTUN)
	(NW TO UNDER-PLAT)
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION HTUN-F)
	(GLOBAL TUNDRA PLATFORM TMOUNTS LEMMINGS RODENTS)
	(SEE-ALL TUNDRA)
	(SEE-NW PLATFORM)
	(SEE-NE TMOUNTS)
	(SEE-E TMOUNTS)
	(SEE-SE TMOUNTS)
	(PLAT-DIR P?NW)>

<ROUTINE HTUN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Steep " D ,TMOUNTS
" tower" ,TOW " and south in a gray wall. The " 
D ,TBOMB " stands alone on the northwest " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT CLIFF-EDGE
	(LOC ROOMS)
	(DESC "Cliff Edge")
	(FLAGS LIGHTED LOCATION CHILLY)
	(NORTH PER OVER-CLIFF)
	(NE PER OVER-CLIFF)
	(EAST PER OVER-CLIFF)
	(SE PER OVER-CLIFF)
	(SOUTH SORRY "Steep mountains block your path.")
	(SW PER TO-TUNDRA)
	(WEST SORRY "Steep mountains block your path.")
	(NW SORRY "Steep mountains block your path.")
	(UP SORRY "The mountains are much too steep to climb.")
	(ACTION CLIFF-EDGE-F)
	(SEE-ALL TCLIFF)
	(SEE-SW PASS)
	(SEE-NW TMOUNTS)
	(SEE-W TMOUNTS)
	(SEE-S TMOUNTS)
	(GLOBAL TUNDRA TMOUNTS PASS LEMMINGS)>

<ROUTINE CLIFF-EDGE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,PASS 
" ends here, on a cliff overlooking an Arctic sea. But where ancient waters once fell, there now pours a living stream of "
D ,RATS
". Driven by mindless instinct, too stupid or frightened to turn away, they plunge by the hundreds into the crashing waves below">
		<COND (<EQUAL? ,RATS ,RODENTS>
		       <TELL ". You recognize the species now. Lemmings">)>
		<TELL ".|
|
The " D GROUND " underfoot is split by a narrow " D ,FISSURE 
", almost hidden by the scrambling " D ,LEMMINGS ,PERIOD>   
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <EQUAL? ,RATS ,RODENTS>>
		<SWITCH-LEMMINGS>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE OVER-CLIFF ()
	 <SAY-SURE>
	 <TELL "go over that cliff?">
	 <COND (<YES?>
		<CRLF>
		<VOICE-MUTTERS "If you can't beat 'em, join 'em">
		<TELL "You tumble ">
	 	<CLIFF-DROWN>
	 	<RFALSE>)>
	 <CRLF>
	 <VOICE-MUTTERS "Whew" <>>
	 <RFALSE>>
	
<ROUTINE CLIFF-DROWN ()
	 <TELL 
"over the edge of the cliff, where you founder for a while in the Arctic waters.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE TO-TUNDRA ()
	 <TELL "You force a path through the " D ,RATS ,PCR>
	 <RETURN ,CTUN>>
	
"*** UNDERGROUND ***"

<OBJECT TUN1
	(LOC ROOMS)
	(DESC "Underground")
	(FLAGS LOCATION INDOORS)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD RWALLS)
	(NORTH SORRY "Rock walls block your path.")
	(NE SORRY "Rock walls block your path.")
	(EAST PER EXIT-CAVE)
	(SE SORRY "Rock walls block your path.")
	(SOUTH SORRY "Rock walls block your path.")
	(SW SORRY "Rock walls block your path.")
	(WEST TO TUN2)
	(NW SORRY "Rock walls block your path.")
	(IN PER TUN1-IN)
	(OUT PER EXIT-CAVE)
	(ACTION TUN1-F)
	(SEE-ALL RWALLS)
	(SEE-E TS2-DOOR)
	(SEE-W CAVERN)
	(GLOBAL CAVERN RWALLS UCABLES TS2-DOOR)>

<ROUTINE TUN1-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're in a narrow underground chamber, illuminated by ">
		<COND (<AND <NOT <IS? ,TS2-DOOR ,NOALL>>
			    <IS? ,TS2-DOOR ,OPENED>>
		       <TELL "an open door in the east wall">)
		      (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL THE ,LAMP "'s beam">)
		      (T
		       <TELL THE ,SHARD "'s fitful glow">)>
		<TELL ". ">
		<LOOK-AT-RWALLS>
		<TELL CR "A large " D ,UBOMB
" occupies most of the chamber. The maze of " D ,UCABLES
" surrounding it trails west, into the depths of a " 
		      D ,CAVERN ,PERIOD>
		<COND (<AND <NOT <IS? ,TS2-DOOR ,NOALL>>
			    <NOT <IS? ,TS2-DOOR ,OPENED>>>
		       <TELL CR CTHE ,TS2-DOOR 
			     " in the east wall is closed." CR>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TUN1-IN ()
	 <COND (<IS? ,TS2-DOOR ,OPENED>
		<EXIT-CAVE>
		<RFALSE>)>
	 <RETURN ,TUN2>>

<ROUTINE LOOK-AT-RWALLS ()
	 <TELL "The walls and " D ,CEILING 
" are gouged with deep spiral ruts; they look as if they've been routed out with heavy machinery." CR>
	 <RTRUE>>

<ROUTINE EXIT-CAVE ()
	 <COND (<IS? ,TS2-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS2-DOOR ,OPENED>
		<TELL "You slip through the " D ,TS2-DOOR ,PCR>
		<DEQUEUE I-TUNNEL>
		<COND (<GOT? ,WTK>
		       <UNMAKE ,WTK ,SEEN>
		       <QUEUE I-WTK -1>)>
		<EXIT-HOLE ,TS2-DOOR ,OSSUARY>
		<RFALSE>)>
	 <ITS-CLOSED ,TS2-DOOR>
	 <RFALSE>>
		
<OBJECT TUN2
	(LOC ROOMS)
	(DESC "Underground")
	(FLAGS LOCATION INDOORS)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD RWALLS)
	(NORTH SORRY "Rock walls block your path.")
	(NE SORRY "Rock walls block your path.")
	(EAST TO TUN1)
	(SE SORRY "Rock walls block your path.")
	(SOUTH SORRY "Rock walls block your path.")
	(SW SORRY "Rock walls block your path.")
	(WEST TO TUN3)
	(NW SORRY "Rock walls block your path.")
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(ACTION TUN2-F)
	(SEE-E CAVERN)
	(SEE-W CAVERN)
	(SEE-ALL RWALLS)
	(GLOBAL CAVERN RWALLS UCABLES)>

<ROUTINE TUN2-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,UCABLES " lining the " D ,CAVERN 
"'s walls look like bloated veins and arteries in the ">
		<COND (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <COND (<IN? ,LAMP ,PLAYER>
			      <TELL "dancing ">)>
		       <TELL "beam of the " D ,LAMP>)
		      (T
		       <TELL D ,SHARD "'s flickering glow">)>
		<TELL ". Deep " D ,CAVERN 
		      "s bend off" ,TOE " and west." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <T? ,LIT?>
		     <IS? ,SKINK ,NODESC>>
		<MOVE ,SKINK ,TUN2>
		<UNMAKE ,SKINK ,NODESC>
	 	<QUEUE I-SKINK -1>
		<MAKE ,SKINK ,SEEN>
		<TELL CR "As you study the " D ,MIKE
" you spot something moving in the corner of your eye. It's... what do you call them?... yes! A " D ,SKINK ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TUN3
	(LOC ROOMS)
	(DESC "Underground")
	(FLAGS LOCATION INDOORS)
      ; (HEAR 0)
      ; (ODOR 0)
	(OVERHEAD RWALLS)
	(NORTH SORRY "Rock walls block your path.")
	(NE SORRY "Rock walls block your path.")
	(EAST TO TUN2)
	(SE SORRY "Rock walls block your path.")
	(SOUTH SORRY "Rock walls block your path.")
	(SW SORRY "Rock walls block your path.")
	(WEST PER LANDSLIDE-BLOCKS)
	(NW SORRY "Rock walls block your path.")
	(OUT TO TUN2)
	(IN PER LANDSLIDE-BLOCKS)
	(ACTION TUN3-F)
	(SEE-E CAVERN)
	(SEE-W LANDSLIDE)
	(SEE-ALL RWALLS)
	(GLOBAL CAVERN RWALLS UCABLES)>

<ROUTINE TUN3-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The west end of the " D ,CAVERN 
" is sealed off with a " D ,LANDSLIDE " of rocks and dirt. Numerous "
D ,UCABLES " emerge from the " D ,RUBBLE ", trailing away to the ">
		<SAY-EAST>
		<TELL ,PCR>
		<COND (<IN? ,SHARD ,CREVICE>
		       <TELL "Feeble light shines from a ">)
		      (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL CTHE ,LAMP "'s beam reveals a ">)
		      (T
		       <TELL CTHE ,SHARD "'s feeble glow reveals a ">)>
		<TELL "narrow " D ,CREVICE 
		      " in the wall of the " D ,TUNNEL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** ATOLL ***"

<OBJECT ON-SCAFFOLD
	(LOC ROOMS)
	(DESC "Scaffold")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(DOWN PER DOWN-SCAFFOLD)
	(IN PER ON-SCAFFOLD-IN)
	(SOUTH PER DOWN-SCAFFOLD)
	(ACTION ON-SCAFFOLD-F)
	(SEE-ALL MIKE)
	(SEE-S SCAF-STAIR)
	(GLOBAL SCAFFOLD SPEAKER MIKE ; SDOORS TS3-DOOR ESHED ISLAND
	 	SCAF-STAIR)>

<ROUTINE ON-SCAFFOLD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Whoever threw this place together wasn't too worried about permanence. Tin walls rise on flimsy studs to a " D ,CEILING 
" that sags under its own weight. It reminds you of a prefab tool shed, several stories high.|
|
You're standing beside a monstrous conglomeration of pipes, compressors and pressure valves that fills most of the " D ,SCHOOL> 
		<COND (<NOT <IS? ,TS3-DOOR ,NOALL>>
		       <TELL ,PTHE "only familiar " D ,MIKE " is the">
		       <OPEN-CLOSED ,TS3-DOOR>
		       <TELL " set into one of the storage tanks">)>
		<TELL ,PCR "A " D ,SCAF-STAIR " leads ">
	 	<COND (<HERE? ON-SCAFFOLD>
		       <TELL "down">)
	       	      (T
			<TELL "up">)>
		<TELL "ward." CR>  
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DOWN-SCAFFOLD ()
	 <TELL "You descend the " D ,SCAF-STAIR ,PCR>
	 <RETURN ,AT-SDOORS>>

<ROUTINE ON-SCAFFOLD-IN ()
	 <COND (<IS? ,TS3-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS3-DOOR ,OPENED>
		<DEQUEUE I-FLIPPER>
		<DEQUEUE I-TIDE>
		<DEQUEUE I-CRABS>
		<TELL "You hesitate for a moment, then step through the " 
		      D ,TS3-DOOR ,PERIOD>
		<EXIT-HOLE ,TS3-DOOR ,ON-MESA>
		<RFALSE>)>
	 <ITS-CLOSED ,TS3-DOOR>
	 <RFALSE>>
	
<OBJECT AT-SDOORS
	(LOC ROOMS)
	(DESC "Bottom of Scaffold")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (HEAR 0)
      ; (ODOR 0)
      ; (OVERHEAD 0)
	(OUT TO SSAND IF SDOORS IS OPEN)
	(SOUTH TO SSAND IF SDOORS IS OPEN)
	(UP PER CLIMB-SCAFFOLD)
	(NORTH PER CLIMB-SCAFFOLD)
	(ACTION AT-SDOORS-F)
	(SEE-ALL MIKE)
	(SEE-N SCAF-STAIR)
	(SEE-S SDOORS)
	(GLOBAL SDOORS ESHED SPEAKER ISLAND SCAF-STAIR SCAFFOLD MIKE)>

<ROUTINE AT-SDOORS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A maze of plumbing rises before you like the back of a giant refrigerator. Stairs lead up to a " D ,SCAFFOLD " overlooking the " D ,MIKE 
". Turning south, you see a">
		<COND (<IS? ,SDOORS ,OPENED>
		       <TELL "n open ">)
		      (T
		       <TELL " closed ">)>
		<TELL "set of " D ,SDOORS
", with a small box and a " D ,SPEAKER " mounted on the wall beside them." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLIMB-SCAFFOLD ()
	 <TELL "You ascend the " D ,SCAF-STAIR ,PCR>
	 <RETURN ,ON-SCAFFOLD>>
	      
<OBJECT SSAND
	(LOC ROOMS)
	(DESC "South Beach")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(HEAR LAGOON)
	(ODOR LAGOON)
      ; (OVERHEAD 0)
	(NORTH TO AT-SDOORS IF SDOORS IS OPEN)
	(NE PER TO-ESAND)
	(EAST PER TO-ESAND)
	(SE PER LAGOON-SWIMMING)
	(SOUTH PER LAGOON-SWIMMING)
	(SW PER LAGOON-SWIMMING)
	(WEST PER TO-WSAND)
	(NW PER TO-WSAND)
	(IN TO AT-SDOORS IF SDOORS IS OPEN)
	(ACTION SSAND-F)
	(SEE-ALL LAGOON)
	(SEE-N SDOORS)
	(SEE-NE BEACH)
	(SEE-NW BEACH)
	(GLOBAL SDOORS ESHED LSPEAKERS LAGOON ISLAND BEACH)>

"SEEN = quote seen."

<ROUTINE SSAND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SETG P-IT-OBJECT ,OBUTTON>
		<TELL "The waters of a peaceful " D ,LAGOON
" reflect the tropical dawn like a fiery mirror. A few stars are still visible in the rosy sky.|
|
The glorified tool shed dominates this little " D ,ISLAND 
", leaving room only for a narrow strip of sand that curves" ,TON
"east and northwest. A " D ,OBUTTON
" is mounted on the wall beside the">
		<OPEN-CLOSED ,SDOORS>
		<TELL " of the shed." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TO-ESAND ()
	 <WALK-BEACH>
	 <RETURN ,ESAND>>

<ROUTINE TO-WSAND ()
	 <WALK-BEACH>
	 <RETURN ,WSAND>>

<ROUTINE TO-NSAND ()
	 <WALK-BEACH>
	 <RETURN ,NSAND>>

<ROUTINE TO-SSAND ()
	 <WALK-BEACH>
	 <RETURN ,SSAND>>

<ROUTINE WALK-BEACH ()
	 <TELL "You ">
	 <COND (<HERE? NSAND>
		<TELL "duck under the " D ,TUBE " and ">)>
	 <TELL "follow the curve of the " D ,BEACH ,PCR>
	 <RTRUE>>

<ROUTINE LAGOON-SWIMMING ()
	 <COND (<IS? ,LAGOON ,SEEN>
		<TELL 
"You recall the icky things lurking in the water, and change your mind." CR>
		<RFALSE>)>
	 <MAKE ,LAGOON ,SEEN>
	 <TELL
"Icky bits of slime wash past as you wade deeper into the " D ,LAGOON
". Invisible creatures nip at your toes, and something big and menacing brushes your shin. Enthusiasm dwindles; you hastily return to the shore." CR>
	 <RFALSE>> 

<OBJECT ESAND
	(LOC ROOMS)
	(DESC "East Beach")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(HEAR LAGOON)
	(ODOR LAGOON)
      ; (OVERHEAD 0)
	(NORTH PER TO-NSAND)
	(NE PER LAGOON-SWIMMING)
	(EAST PER LAGOON-SWIMMING)
	(SE PER LAGOON-SWIMMING)
	(SOUTH PER TO-SSAND)
	(SW PER TO-SSAND)
	(WEST PER ESHED-BLOCKS)
	(NW PER TO-NSAND)
	(ACTION ESAND-F)
        (SEE-ALL LAGOON)
	(SEE-W ESHED)
	(SEE-NW BEACH)
	(SEE-SW BEACH)
	(GLOBAL ESHED LSPEAKERS ISLAND LAGOON BEACH)>

<ROUTINE ESAND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Palm trees far across the " D ,LAGOON
" stand in dark relief against the eastern sky. The " D ,BEACH
" continues northwest and southwest, around the " D ,ESHED ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NSAND
	(LOC ROOMS)
	(DESC "North Beach")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(HEAR LAGOON)
	(ODOR LAGOON)
      ; (OVERHEAD 0)
	(NORTH PER LAGOON-SWIMMING)
	(NE PER LAGOON-SWIMMING)
	(EAST PER TO-ESAND)
	(SE PER TO-ESAND)
	(SOUTH PER ESHED-BLOCKS)
	(SW PER TO-WSAND)
	(WEST PER TO-WSAND)
	(NW PER LAGOON-SWIMMING)
	(ACTION NSAND-F)
        (SEE-ALL LAGOON)
	(SEE-S ESHED)
	(SEE-SE BEACH)
	(SEE-SW BEACH)
	(GLOBAL ESHED LSPEAKERS ISLAND LAGOON BEACH)>

<ROUTINE NSAND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A square wooden " D ,TUBE " juts out of the side of the "
D ,SCHOOL ", stretching away across the " D ,LAGOON
" as far as you can see.|
|
The beach continues around the " D ,ESHED ,TOS "east and southwest." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WSAND
	(LOC ROOMS)
	(DESC "West Beach")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(HEAR LAGOON)
	(ODOR LAGOON)
      ; (OVERHEAD 0)
	(NORTH PER TO-NSAND)
	(NE PER TO-NSAND)
	(EAST PER ESHED-BLOCKS)
	(SE PER TO-SSAND)
	(SOUTH PER TO-SSAND)
	(SW PER CRABS-ATTACK)
	(WEST PER CRABS-ATTACK)
	(NW PER CRABS-ATTACK)
	(ACTION WSAND-F)
        (SEE-ALL LAGOON)
	(SEE-NE BEACH)
	(SEE-SE BEACH)
	(SEE-E ESHED)
	(SEE-W ISLET)
	(GLOBAL ESHED LSPEAKERS ISLAND LAGOON BEACH NUTS)>

<ROUTINE WSAND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The sand curves northeast and southeast, skirting the dark outline of the " 
D ,ESHED ,PCR "A tiny " D ,ISLET
" is visible a short distance offshore." CR> 
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,CRABS ,NODESC>>>
		<SETG P-THEM-OBJECT ,CRABS>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE CRABS-ATTACK ()
	 <MAKE ,CRABS ,SEEN>
	 <COND (<IS? ,CRABS ,NODESC>
		<UNMAKE ,CRABS ,NODESC>
		<QUEUE I-CRABS -1>		
		<MOVE ,CRABS ,WSAND>
		<SETG P-THEM-OBJECT ,CRABS>
		<TELL 
"A bolt of pain engulfs your foot.|
|
A big, fat crab is pinching your toe! You shake off the wretched thing; it watches with evil satisfaction as you hop around the beach, yowling.|
|
Another crab joins the first, and another. Soon the water's edge is crowded with snapping claws." CR>
		<RFALSE>)>
	 <TELL "A glance at the snapping " D ,CRABS ,CHANGES>
	 <RFALSE>>

"*** NAGASAKI ***"

<OBJECT IN-SKY
	(LOC ROOMS)
	(DESC "Thin Air")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (ODOR 0)
        (OVERHEAD TS5-DOOR)
      ; (HEAR 0)
	(NORTH SORRY "Unassisted flight is not one of your talents.")
	(NE SORRY "Unassisted flight is not one of your talents.")
	(EAST SORRY "Unassisted flight is not one of your talents.")
	(SE SORRY "Unassisted flight is not one of your talents.")
	(SOUTH SORRY "Unassisted flight is not one of your talents.")
	(SW SORRY "Unassisted flight is not one of your talents.")
	(WEST SORRY "Unassisted flight is not one of your talents.")
	(NW SORRY "Unassisted flight is not one of your talents.")
	(UP SORRY "Unassisted flight is not one of your talents.")
	(DOWN SORRY "You're going that way whether you like it or not.")
	(ACTION IN-SKY-F)
	(SEE-ALL SKY)
	(GLOBAL TS5-DOOR CITY NAGASAKI PLANES)>

"NOALL = 2nd fall move, SEEN = I-FALLING queued."

<ROUTINE IN-SKY-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're ">
		<COND (<IS? ,IN-SKY ,NOALL>
		       <TELL "several">)
		      (T
		       <TELL "fourteen">)>
		<TELL " hundred feet above a small city, ">
		<COND (<OR <T? ,SUITED?>
			   <AND <IN? ,PARASOL ,PLAYER>
				<IS? ,PARASOL ,OPENED>>>
		       <TELL "drifting slowly downward as the wind ">
		       <COND (<T? ,SUITED?>
			      <TELL "presses against the " D ,FILM
				    " around you">)
			     (T
			      <TELL "fills your open " D ,PARASOL>)>)
		      (T
		       <TELL "falling straight down at a velocity of ">
		       <COND (<IS? ,IN-SKY ,NOALL>
			      <TELL "a hundred and thir">)
			     (T
			      <TELL "seven">)>
		       <TELL "ty miles an hour">)>
		<TELL ,PCR 
"A " D ,TS5-DOOR " is dwindling away in the sky overhead." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,IN-SKY ,SEEN>>>
		<MAKE ,IN-SKY ,SEEN>
		<MAKE ,IN-SKY ,NOALL>
		<QUEUE I-FALLING 2>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT ON-BIRD
	(LOC ROOMS)
	(DESC "Thin Air, on the giant bird")
	(FLAGS TOUCHED LIGHTED LOCATION NOGRASS)
      ; (ODOR 0)
	(OVERHEAD 0)
	(HEAR 0)
	(NORTH SORRY "Unassisted flight is not one of your talents.")
	(NE SORRY "Unassisted flight is not one of your talents.")
	(EAST SORRY "Unassisted flight is not one of your talents.")
	(SE SORRY "Unassisted flight is not one of your talents.")
	(SOUTH SORRY "Unassisted flight is not one of your talents.")
	(SW SORRY "Unassisted flight is not one of your talents.")
	(WEST SORRY "Unassisted flight is not one of your talents.")
	(NW SORRY "Unassisted flight is not one of your talents.")
	(UP SORRY "Unassisted flight is not one of your talents.")
	(DOWN SORRY "Unassisted flight is not one of your talents.")
	(IN PER EXIT-NAGASAKI)
	(SEE-ALL SKY)
	(ACTION ON-BIRD-F)
	(GLOBAL TS5-DOOR CITY NAGASAKI PLANES ; MCRANE)> 
		
<ROUTINE ON-BIRD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're soaring high over the city on a giant " D ,CRANE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-NAGASAKI ()
	 <COND (<IS? ,TS5-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS5-DOOR ,OPENED>
		<DEQUEUE I-FLIGHT>
		<TELL "You climb off the " D ,MCRANE
		      " and leap through the " D ,TS3-DOOR ,PERIOD>
		<EXIT-HOLE ,TS5-DOOR ,ON-MOOR>
		<RFALSE>)>
	 <ITS-CLOSED ,TS5-DOOR>
	 <RFALSE>>
	 
<OBJECT PLAYGROUND
	(LOC ROOMS)
	(DESC "Playground")
	(FLAGS LIGHTED LOCATION)
	(OVERHEAD 0)
	(HEAR 0)
	(NORTH PER CHILDREN-CATCH)
	(NE PER CHILDREN-CATCH)
	(EAST PER ENTER-SHELTER)
	(SE PER TEACHERS-CATCH)
	(SOUTH PER TEACHERS-CATCH)
	(SW PER BUILDING-BLOCKS)
	(WEST PER ENTER-SCHOOL)
	(NW PER BUILDING-BLOCKS)
	(DOWN PER ENTER-SHELTER)
	(IN PER ENTER-SHELTER)
	(OUT PER WHICH-WAY-OUT)
	(ACTION PLAYGROUND-F)
	(SEE-N KIDS)
	(SEE-S TEACHERS)
	(SEE-E SHELTER)
	(SEE-W SCHOOL)
	(SEE-ALL PGROUND)
	(GLOBAL PGROUND CITY NAGASAKI TS5-DOOR SCHOOL PLANES SHELTER DECOR
	 	SHELHOLE DFLIES SDIRT)>

<ROUTINE PLAYGROUND-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A set of " D ,KIDS "'s " D ,SWINGS " moves ">
		<BACK-AND-FORTH>
		<TELL 
" Behind them stands a long " D ,SCHOOL ", its " D ,SCHOOL-WINDOWS
" hung with " D ,FLOWERS " and birds folded from colored paper.|
|
Mounds of dirt are heaped around a dark " D ,SHELHOLE ,TOE 
". It appears to be a " D ,SHELTER " of some kind.|
|
Several small " D ,KIDS
" are happily chasing " D ,DFLIES
" north of the swing set. Turning south, you see a group of adults (school"
D ,TEACHERS ", by the looks of them), wearily digging another " D ,SHELTER
" like the first." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-BEG>
		     <VERB? YELL ALARM>>
		<TELL "You begin to yell hysterically." CR>
	 	<TEACHERS-NOTICE>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <IS? ,SPILE ,NODESC>>
		<UNMAKE ,SPILE ,NODESC>
		<TELL CR 
"Somewhat shaken, you rise to your feet in a child's " D ,SPILE>
		<LOOK-IN-SPILE>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <T? ,IN-SAND?>>
		<EXIT-SPILE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-IN-SPILE ()
	 <COND (<SEE-ANYTHING-IN? ,SPILE>
		<TELL ". In the pile you see ">
		<PRINT-CONTENTS ,SPILE>)>
	 <RTRUE>>

<ROUTINE EXIT-SPILE ()
	 <SETG IN-SAND? <>>
	 <SETG OLD-HERE <>>
	 <TELL "[climbing out of the " D ,SPILE " first" ,BRACKET>
	 <RTRUE>>

<ROUTINE ENTER-SCHOOL ()
	 <COND (<T? ,IN-SAND?>
		<EXIT-SPILE>)>
	 <TELL "There are no " D ,SBENTRY "s visible here." CR>
	 <RFALSE>>

<ROUTINE ENTER-SHELTER ()
	 <COND (<T? ,IN-SAND?>
		<EXIT-SPILE>)>
         <TELL "You descend into the darkness" ,PCR>
	 <RETURN ,IN-SHELTER>>

<ROUTINE TEACHERS-CATCH ()
	 <COND (<CHICKEN-OUT? ,TEACHERS>
		<RFALSE>)
	       (<T? ,IN-SAND?>
		<EXIT-SPILE>)>
	 <TELL "You step closer to the group of " D ,TEACHERS ,PERIOD>
	 <TEACHERS-NOTICE T>
	 <RFALSE>>

<ROUTINE TEACHERS-NOTICE ("OPTIONAL" (COMING <>))
	 <TELL CR 
"One teacher, a young woman, sees you ">
	 <COND (<ZERO? .COMING>
		<TELL "standing ">
	 	<COND (<ZERO? ,IN-SAND?>
		       <TELL "by ">)
	       	      (T
		       <TELL "in ">)>
		<TELL THE ,SPILE>)
	       (T
		<TELL "coming">)>
	 <TELL 
" and shrieks something in Japanese. Her companions quickly surround you, shouting accusations and sneering at your vacation shorts. You respond by pointing desperately at the sky, shouting \"Bomb! Big boom!\" and struggling to escape into the " D ,SHELTER ".|
|
This awkward scene is cut short by a searing flash.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE CHILDREN-CATCH ()
	 <COND (<CHICKEN-OUT? ,KIDS>
		<RFALSE>)
	       (<T? ,IN-SAND?>
		<EXIT-SPILE>)>
	 <TELL CTHE ,KIDS 
" cry out in surprise and fear at your approach." CR>
	 <TEACHERS-NOTICE T>
	 <RFALSE>>

<ROUTINE CHICKEN-OUT? (WHO)
	 <TELL "You walk a little closer to " THE .WHO
", but hesitate when it occurs to you that they might not take kindly to your presence" ,PCR>
	 <SAY-SURE>
	 <TELL "go that way?">
	 <COND (<YES?>
		<CRLF>
		<RFALSE>)>
	 <NO-DETECTION>
	 <RTRUE>>
	       
<OBJECT IN-SHELTER
	(LOC ROOMS)
	(DESC "Shelter")
	(FLAGS LIGHTED LOCATION INDOORS)
	(ODOR PEE)
	(HEAR 0)
	(OVERHEAD 0)
	(UP PER EXIT-SHELTER)
	(OUT PER EXIT-SHELTER)
	(WEST PER EXIT-SHELTER)
	(IN SORRY "You're already in the shelter as far as you can go.")
	(DOWN SORRY "You're already in the shelter as far as you can go.")
	(ACTION IN-SHELTER-F)
	(SEE-ALL WALLS)
	(SEE-W SHELHOLE)
	(GLOBAL SHELTER SHELHOLE CITY NAGASAKI TS5-DOOR PLANES SDIRT)>

<ROUTINE IN-SHELTER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"You wouldn't want to spend much time in this wretched hole. The bare "
D ,FLOOR " is damp and filthy, and the " D ,CORNER "s reek of " 
D ,PEE ". Luckily, there's an " D ,SHELHOLE ,TOW ,PERIOD> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-SHELTER ()
	 <TELL "You ascend into daylight" ,PCR>
	 <RETURN ,PLAYGROUND>> 

"*** TRINITY ***"

<OBJECT IN-SHACK
	(LOC ROOMS)
	(DESC "Shack")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (OVERHEAD 0)
        (HEAR VOICES)
      ; (ODOR 0)
      ; (NORTH SORRY "The metal wall blocks your path.")
      ; (NE SORRY "The metal wall blocks your path.")
	(EAST PER SLAM-TS6-DOOR)
      ; (SE SORRY "The metal wall blocks your path.")
      ; (SOUTH SORRY "The metal wall blocks your path.")
      ; (SW SORRY "The metal wall blocks your path.")
	(WEST TO TOWER-PLAT)
      ; (NW SORRY "The metal wall blocks your path.")
	(OUT PER IN-SHACK-OUT)	
	(IN PER SLAM-TS6-DOOR)
	(SEE-ALL WALLS)
	(SEE-E TS6-DOOR)
	(SEE-W SHACK-HOLE)
	(GLOBAL TS6-DOOR SHACK SHACK-HOLE TOWER GCABLES SPOT VOICES)
	(ACTION IN-SHACK-F)>

<ROUTINE IN-SHACK-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're in a metal " D ,SHACK
", barely twelve feet square. The oak " D ,FLOOR
" is littered with discarded bits of rope, pulleys and other " D ,HARDWARE
,PA "d">
		<COND (<IS? ,WATT ,LIGHTED>
		       <TELL "im">)
		      (T
		       <TELL "ark">)>
		<TELL " light bulb hangs from the " D ,CEILING>
		<COND (<IS? ,WATT ,LIGHTED>
		       <TELL 
", filling the " D ,DSHADOW "s with a sullen glow">)>
		
		<COND (<IS? ,SPOT ,SEEN>
		       <TELL "; harsh light streams in through an ">)
		      (T
		       <TELL ". You can see an ">)>
		<TELL "exit in the west wall.|
|
A five-foot " D ,GADGET " rests on a bracket in the middle of the " 
D ,FLOOR ". Its " D ,CSURFACE " is studded with " D ,GBOLTS
" and crossed with electrical " D ,GCABLES
", all converging in a boxlike " D ,X5 " nearby.|
|
A">
		<OPEN-CLOSED ,TS6-DOOR T>
		<TELL " is set into the east wall." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-SHACK-OUT ()
	 <COND (<IS? ,TS6-DOOR ,OPENED>
		<WHICH-WAY-OUT>
		<RFALSE>)>
	 <RETURN ,TOWER-PLAT>>

<ROUTINE SLAM-TS6-DOOR ()
	 <COND (<IS? ,TS6-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFALSE>)
	       (<IS? ,TS6-DOOR ,OPENED>
		<KILL-TS6-DOOR>
	 	<RFALSE>)>
	 <ITS-CLOSED ,TS6-DOOR>
	 <RFALSE>>

<ROUTINE KILL-TS6-DOOR ()
	 <PUTP ,IN-SHACK ,P?SEE-E ,WALLS>
	 <UNMAKE ,TS6-DOOR ,OPENED>
	 <ITALICIZE "Bang!">
	 <TELL " The door slams shut at your approach." CR>
	 <SETG DO-WINDOW <GET ,QUOTES ,BYRNE>>
	 <RTRUE>> 

<OBJECT TOWER-PLAT
	(LOC ROOMS)
	(DESC "Tower Platform")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(HEAR VOICES)
      ; (OVERHEAD 0)
      ; (ODOR 0)
	(NORTH PER PLAT-FALL)
	(NE PER PLAT-FALL)
	(EAST TO IN-SHACK)
	(SE PER PLAT-FALL)
	(SOUTH PER PLAT-FALL)
	(SW PER PLAT-FALL)
	(WEST PER PLAT-FALL)
	(NW PER PLAT-FALL)
	(DOWN PER TOWER-PLAT-D)
	(UP SORRY "You're already at the top of the ladder.")
	(IN TO IN-SHACK)
	(SEE-ALL GDESERT)
	(SEE-E SHACK-HOLE)
	(SEE-SW SPOT)
	(SEE-NE DMOUNTS)
	(SEE-SE DMOUNTS)
	(GLOBAL SHACK SHACK-HOLE TOWER TLADDER GDESERT DMOUNTS SPOT VOICES)
	(ACTION TOWER-PLAT-F)>

<ROUTINE TOWER-PLAT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A metal rail is all that stands between you and a hundred-foot drop.|
|
Miles of barren " D ,GDESERT
" lie below, gray and still in the gathering dawn. Black roads radiate outward like the hands of a great clock.|
|
This narrow " D ,TPLAT " opens east into a metal " D ,SHACK>
		<COND (<IS? ,SPOT ,SEEN>
		       <TELL
,PA D ,SPOT " on the southwest " D ,HORIZON " floods the " D ,PLATFORM
" in a raw white glare">)>
		<TELL ,PA D ,TLADDER " is sticking up over the " 
D ,TPLAT "'s edge." CR> 
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<SETG STAIR-DIR "down">
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOWER-PLAT-D ()
	 <COND (<IS? ,VOICES ,SEEN>
		<TELL "You step towards the " D ,TLADDER
", but hesitate when you hear the " D ,VOICES " below" ,PCR>
		<SAY-SURE>
		<TELL "go down there right now?">
		<COND (<NOT <YES?>>
		       <NO-DETECTION>
		       <RFALSE>)>)>
	 <COND (<NOT <IS? ,ON-TOWER ,TOUCHED>>
		<TELL "You clutch the topmost rung of the " D ,TLADDER 
" with sweating palms. Fighting back vertigo, you begin to feel your way downward.|
|
At last your foot touches a flat " D ,CSURFACE ,PCR>)>
	 <RETURN ,ON-TOWER>>

<OBJECT ON-TOWER
	(LOC ROOMS)
	(DESC "Tower Landing")
	(FLAGS LIGHTED LOCATION NOGRASS)
	(OVERHEAD SHACK)
      ; (HEAR 0)
      ; (ODOR 0)
	(UP PER ON-TOWER-U)
	(IN PER WHICH-WAY-IN)
	(DOWN PER ON-TOWER-D)
	(OUT PER WHICH-WAY-OUT)
	(NORTH PER TOWER-FALL)
	(NE PER TOWER-FALL)
	(EAST PER TOWER-FALL)
	(SE PER TOWER-FALL)
	(SOUTH PER TOWER-FALL)
	(SW PER TOWER-FALL)
	(WEST PER TOWER-FALL)
	(NW PER TOWER-FALL)
	(GLOBAL TOWER TLADDER SHACK GDESERT TROPES DMOUNTS SPOT)
	(SEE-SW SPOT)
	(SEE-ALL GDESERT)
	(SEE-E DMOUNTS)
	(SEE-NE DMOUNTS)
	(SEE-SE DMOUNTS)
	(ACTION ON-TOWER-F)>

<ROUTINE ON-TOWER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SETG P-IT-OBJECT ,TLADDER>
		<TELL 
"A spiderweb of steel rises from the " D ,GDESERT 
" floor below, tapering up to the " D ,PLATFORM
" fifty feet overhead. Thick ropes and " D ,GCABLES 
" dangle around the " D ,TLADDER " that continues " ,STAIR-DIR "ward." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOWER-FALL ()
	 <YOUD-FALL-OFF ,LANDING>
	 <RFALSE>>

<ROUTINE ON-TOWER-U ()
	 <TELL "You tighten your grip on the " D ,TLADDER ,PCR>
	 <RETURN ,TOWER-PLAT>>

<ROUTINE ON-TOWER-D ()
	 <COND (<NOT <IS? ,AT-ZERO ,TOUCHED>>
		<TELL "You step back onto the " D ,TLADDER
	       	      " and inch " D ,ME " downward" ,PCR>)>
	 <RETURN ,AT-ZERO>>

<OBJECT AT-ZERO
	(LOC ROOMS)
	(DESC "Base of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
	(OVERHEAD TOWER)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO NZERO)
	(NE TO NEZERO)
	(EAST TO EZERO)
	(SE TO AT-TNT)
	(SOUTH TO S25)
	(SW TO W25)
	(WEST TO WZERO)
	(NW TO N25)
	(UP PER AT-ZERO-U)
	(OUT PER WHICH-WAY-OUT)
	(GLOBAL TOWER TLADDER SHACK GDESERT TROPES NWROAD SWROAD SROAD
	 	SEROAD DMOUNTS SPOT ILINES)
	(SEE-ALL GDESERT)
	(ACTION AT-ZERO-F)>

<ROUTINE AT-ZERO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A steel " D ,TOWER 
" rises overhead, black against the cloudy sky. Your eyes follow the tapered frame up the " D ,TLADDER ", past dangling " D ,TROPES 
", to the " D ,PLATFORM " at its summit.|
|
Paved roads and " D ,ILINES " lead off into the surrounding " 
D ,GDESERT ,PERIOD> 
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<SETG STAIR-DIR "up">
		<COND (<NOT <IS? ,MEEP ,CHILLY>>
		       <RFALSE>)>
		<UNMAKE ,MEEP ,CHILLY>
		<QUEUE I-TMEEP -1>
		<SETG P-IT-OBJECT ,RUBY>
		<MAKE ,MEEP ,SEEN>
		<MOVE ,RUBY ,BOX>
		<TELL CR "A familiar " D ,MEEP 
" is eyeing you from its perch on the box's lid. The ruby in its beak gleams in the early dawn.|
|
With a skillful toss, the " D ,MEEP
" deposits the ruby on the box. Then it leaps off and scampers eagerly around your feet. If you didn't know better, you'd swear it was glad to see you." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE AT-ZERO-U ()
	 <TELL "You grasp the rungs of the " D ,TLADDER
	       " and pull " D ,ME " upward." CR>
	 <DO-MOVES 1>
	 <CRLF>
	 <RETURN ,ON-TOWER>>

<OBJECT N75
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D0)
	(NE TO D1)
	(EAST TO D1)
	(SE TO N50)
	(SOUTH TO D3)
	(SW TO D3)
	(WEST TO D0)
	(NW PER GO-TO-NBUNKERS)
	(IN PER ENTER-JEEP)
	(TDIR P?SE)
	(GLOBAL JEEP JEEPARTS SEAT JDOOR DTOWER GDESERT NWROAD DMOUNTS
	 	ILINES NBUNKERS)
	(SEE-ALL GDESERT)
	(SEE-NW NBUNKERS)
	(SEE-SE NWROAD)
	(ACTION N75-F)>

<ROUTINE N75-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Your eyes follow the " D ,ILINES 
" northwest, where a cluster of " D ,NBUNKERS " and " D ,SLIGHT 
"s is visible on the " D ,HORIZON ,PTHE D ,PROAD " continues in that "
D ,INTDIR ", and also leads southwest.|
|
An abandoned jeep is parked nearby." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GO-TO-NBUNKERS ()
	 <COND (<IS? ,NBUNKERS ,SEEN>
		<YOU-MARCH>
		<TELL " towards the " D ,NBUNKERS ".|
|
Excited shouts ring out as you approach the nearest "
D ,SHELTER ". One of the giant lights sweeps" ,AGROUND 
" until its beam aims directly into your eyes." CR>
		<HOLD-IT>
		<SURROUNDED>
		<RFALSE>)>
	 <MAKE ,NBUNKERS ,SEEN>
	 <TAKE-A-MOMENT-TO ,NBUNKERS>
	 <RFALSE>>

<ROUTINE ENTER-JEEP ()
	 <COND (<NOT <IS? ,JDOOR ,OPENED>>
		<MAKE ,JDOOR ,OPENED>
		<TELL "[" D ,CAVE-HOLE " the " D ,JDOOR " first" ,BRACKET>)>
	 <TELL "You climb into the jeep" ,PCR>
	 <RETURN ,IN-JEEP>>

<OBJECT IN-JEEP
	(LOC ROOMS)
	(DESC "Jeep")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH SORRY "You can't move around like that in a jeep.")
	(NE SORRY "You can't move around like that in a jeep.")
	(EAST SORRY "You can't move around like that in a jeep.")
	(SE SORRY "You can't move around like that in a jeep.")
	(SOUTH SORRY "You can't move around like that in a jeep.")
	(SW SORRY "You can't move around like that in a jeep.")
	(WEST SORRY "You can't move around like that in a jeep.")
	(NW SORRY "You can't move around like that in a jeep.")
	(IN SORRY "You're already in the jeep as far as you can go.")
	(OUT PER EXIT-JEEP)
	(GLOBAL JEEP JEEPARTS SEAT JDOOR DTOWER GDESERT NWROAD DMOUNTS
	 	NBUNKERS)
	(SEE-ALL GDESERT)
	(SEE-NW NBUNKERS)
	(SEE-SE NWROAD)
	(TDIR P?OUT)
	(ACTION IN-JEEP-F)>

<ROUTINE IN-JEEP-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Comfort was clearly not a consideration in the design of this jeep. The seat is narrow and hard, and your shin is scrunched up against a radio bolted to the " D ,FLOOR ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-JEEP ()
	 <COND (<IS? ,JDOOR ,OPENED>
		<TELL "You clamber out of the jeep" ,PCR>
		<RETURN ,N75>)>
	 <ITS-CLOSED ,JDOOR>
	 <RFALSE>>

<OBJECT N50
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D1)
	(NE TO D1)
	(EAST TO D1)
	(SE TO N25)
	(SOUTH TO D3)
	(SW TO D3)
	(WEST TO D3)
	(NW TO N75)
	(TDIR P?SE)
	(GLOBAL DTOWER GDESERT NWROAD DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-NW NWROAD)
	(SEE-SE DTOWER)
	(ACTION N50-F)>

<ROUTINE N50-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A " D ,PROAD " leads northwest across the gray "
D ,GDESERT ", and southeast towards the " D ,DTOWER ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT N25
	(LOC ROOMS)
	(DESC "Northwest of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D1)
	(NE TO D1)
	(EAST TO NZERO)
	(SE TO AT-ZERO)
	(SOUTH TO WZERO)
	(SW TO D3)
	(WEST TO D3)
	(NW TO N50)
	(TDIR P?SE)
	(GLOBAL DTOWER GDESERT NWROAD DTRAIL DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-NW NWROAD)
	(SEE-SE DTOWER)
	(SEE-S DTRAIL)
	(ACTION N25-F)>

<ROUTINE N25-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Stubby poles draped with " D ,ILINES
" follow a " D ,PROAD " northwest " ,INTO-DESERT 
", while a " D ,DTRAIL " curves away" ,TOS ,PCR CTHE ,DTOWER
" is a dim outline against the southeast " D ,TMOUNTS ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT NZERO
	(LOC ROOMS)
	(DESC "North of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D1)
	(NE TO D2)
	(EAST TO NEZERO)
	(SE TO EZERO)
	(SOUTH TO AT-ZERO)
	(SW TO WZERO)
	(WEST TO N25)
	(NW TO D1)
	(TDIR P?SOUTH)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-S DTOWER)
	(ACTION NZERO-F)>

<ROUTINE NZERO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,TOWER 
" is visible not far" ,TOS ". It's the only landmark in this empty "
D ,GDESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NEZERO
	(LOC ROOMS)
	(DESC "Northeast of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D2)
	(NE TO D2)
	(EAST TO D6)
	(SE TO D6)
	(SOUTH TO EZERO)
	(SW TO AT-ZERO)
	(WEST TO NZERO)
	(NW TO D1)
	(TDIR P?SW)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-SW DTOWER)
	(ACTION NEZERO-F)>

<ROUTINE NEZERO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,TOWER " on the southwest " D ,HORIZON
" stands alone against the surrounding " D ,GDESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT EZERO
	(LOC ROOMS)
	(DESC "East of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO NEZERO)
	(NE TO D6)
	(EAST TO D6)
	(SE TO D6)
	(SOUTH TO AT-TNT)
	(SW TO S25)
	(WEST TO AT-ZERO)
	(NW TO NZERO)
	(TDIR P?WEST)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-W DTOWER)
	(ACTION EZERO-F)>

<ROUTINE EZERO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "This bleak stretch of " D GDESERT
		      " lies between the " D ,TOWER ,TOW 
		      ", and a range of " D ,TMOUNTS ,TOE ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT AT-TNT
	(LOC ROOMS)
	(DESC "Shallow Crater")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO EZERO)
	(NE TO D6)
	(EAST TO D6)
	(SE TO NWRANCH)
	(SOUTH TO D8)
	(SW TO D8)
	(WEST TO S25)
	(NW TO AT-ZERO)
	(TDIR P?NW)
	(GLOBAL DTOWER GDESERT DMOUNTS RANCH-ROAD TCRATER)
	(SEE-ALL GDESERT)
	(SEE-SE RANCH-ROAD)
	(SEE-NW DTOWER)
	(ACTION AT-TNT-F)>

<ROUTINE AT-TNT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're standing at the edge of a shallow " D ,TCRATER " in the " 
D ,GDESERT " floor, a few hundred feet across. The ground within is gray and pulverized, as if by a powerful explosion.|
|
A " D ,PROAD " leads southeast " ,INTO-DESERT ", and northwest towards the " 
D ,DTOWER ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WZERO
	(LOC ROOMS)
	(DESC "West of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO N25)
	(NE TO NZERO)
	(EAST TO AT-ZERO)
	(SE TO S25)
	(SOUTH TO W25)
	(SW TO D5)
	(WEST TO D3)
	(NW TO D3)
	(TDIR P?EAST)
	(GLOBAL DTOWER GDESERT DTRAIL DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-E DTOWER)
	(SEE-N DTRAIL)
	(SEE-S DTRAIL)
	(ACTION WZERO-F)>

<ROUTINE WZERO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A tall " D ,FRAME " of steel has been erected here, cousin to the larger "
D ,TOWER " visible not far" ,TOE 
". Suspended within the frame is an enormous metal " D ,JUMBO 
", at least twenty feet long and ten wide, with rounded end caps. It looks like a king-sized cold capsule.|
|
A " D ,DTRAIL " curves north and south." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT W25
	(LOC ROOMS)
	(DESC "Southwest of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO WZERO)
	(NE TO AT-ZERO)
	(EAST TO S25)
	(SE TO D7)
	(SOUTH TO D7)
	(SW TO W50)
	(WEST TO D5)
	(NW TO D3)
	(TDIR P?NE)
	(GLOBAL DTOWER GDESERT SWROAD DTRAIL DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-NE DTOWER)
	(SEE-SW SWROAD)
	(SEE-N DTRAIL)
	(ACTION W25-F)>

<ROUTINE W25-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A " D ,PROAD " leads northeast towards the " D ,DTOWER
", and southwest " ,INTO-DESERT ". There's also a "
D ,DTRAIL " bearing north." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT W50
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D5)
	(NE TO W25)
	(EAST TO D7)
	(SE TO D7)
	(SOUTH TO D7)
	(SW TO W75)
	(WEST TO D5)
	(NW TO D5)
	(TDIR P?NE)
	(GLOBAL DTOWER GDESERT SWROAD DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-NE DTOWER)
	(SEE-SW SWROAD)
	(ACTION W50-F)>

<ROUTINE W50-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,DTOWER
" is a faint outline on the northeast " D ,HORIZON ,PTHE D ,RANCH-ROAD
" leading from it continues southwest, " ,INTO-DESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT W75
	(LOC ROOMS)
	(DESC "Crossroads")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D5)
	(NE TO W50)
	(EAST TO D7)
	(SE TO NEPASS)
	(SOUTH TO D10)
	(SW TO W100)
	(WEST TO D5)
	(NW TO D5)
	(TDIR P?NE)
	(GLOBAL DTOWER SEROAD GDESERT SWROAD DMOUNTS D5ROAD ILINES)
	(SEE-ALL GDESERT)
	(SEE-NE SWROAD)
	(SEE-SE SEROAD)
	(SEE-SW SWROAD)
	(ACTION W75-F)>

<ROUTINE W75-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A " D ,PROAD " bears off in a straight northeast/southwest line. Another road bends southeast, and a " D ,DTRAIL " peters off" ,TON "west." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT W100
	(LOC ROOMS)
	(DESC "Outside Blockhouse")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
	(HEAR DOG)
	(ODOR DOG)
	(NORTH TO D5)
	(NE TO W75)
	(EAST TO D10)
	(SE TO D10)
	(SOUTH TO D9)
	(SW PER W100-SW)
	(WEST TO D9)
	(NW PER W100-NW)
	(TDIR P?NE)
	(GLOBAL DTOWER GDESERT SWROAD DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-NE SWROAD)
	(ACTION W100-F)>

<ROUTINE W100-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The military " D ,BHOUSE
" by the roadside is squat and windowless. A powerful " D ,SLIGHT
", mounted on the roof, directs an intense beam ">
		<COND (<T? ,DISTRACTION>
		       <TELL "onto the road">)
		      (T
		       <TELL "towards the northeast horizon">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-BEG>
		     <IN? ,DOG ,W100>
		     <VERB? YELL ALARM>>
		<WAKE-DOG>
		<RTRUE>)
	       (<EQUAL? .CONTEXT ,M-ENTERED>
		<COND (<T? ,DISTRACTION>
		       <TELL CR "A great, big " D ,DOG " is making">
		       <AKC>
		       <HOLD-IT>
	 	       <KINDA-SPY>
	 	       <SURROUNDED>
	 	       <RTRUE>)
		      (<AND <IN? ,FEATHERS ,W100>
			    <NOT <IS? ,FEATHERS ,SEEN>>>
		       <MAKE ,FEATHERS ,SEEN>
	 	       <TELL CR "A little pile of gray " D ,FEATHERS
" lies scattered" ,AGROUND 
". You watch in silence as the last few blow away across the " 
D ,GDESERT ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE W100-NW ()
	 <TELL "You skirt around the " D ,BHOUSE ,PCR>
	 <RETURN ,D5>>

<ROUTINE W100-SW ()
	 <COND (<G? ,MINUTES 27>
		<AIMLESS ,D9>
		<RETURN ,D9>)>
	 <TELL 
"Another look at the shepherd encourages you not to go that way." CR>
	 <RFALSE>>

<OBJECT S25
	(LOC ROOMS)
	(DESC "South of Tower")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO AT-ZERO)
	(NE TO EZERO)
	(EAST TO AT-TNT)
	(SE TO D8)
	(SOUTH TO S50)
	(SW TO D7)
	(WEST TO W25)
	(NW TO WZERO)
	(TDIR P?NORTH)
	(GLOBAL DTOWER GDESERT SROAD DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-N DTOWER)
	(SEE-S SROAD)
	(ACTION S25-F)>

<ROUTINE S25-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A paved road bears north towards the tower, and south " ,INTO-DESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT S50
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO S25)
	(NE TO D8)
	(EAST TO D8)
	(SE TO D8)
	(SOUTH TO S75)
	(SW TO D7)
	(WEST TO D7)
	(NW TO D7)
	(TDIR P?NORTH)
	(GLOBAL DTOWER GDESERT SROAD DMOUNTS ILINES)
	(SEE-ALL GDESERT)
	(SEE-N DTOWER)
	(SEE-S SROAD)
	(ACTION S50-F)>

<ROUTINE S50-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A " D ,PROAD ", straight and level, bears in a north/south line across the "
D ,GDESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT S75
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO S50)
	(NE TO D8)
	(EAST TO D11)
	(SE TO D11)
	(SOUTH TO S100)
	(SW TO D10)
	(WEST TO D10)
	(NW TO NEPASS)
	(TDIR P?NORTH)
	(GLOBAL DTOWER GDESERT SROAD DMOUNTS ILINES D11ROAD)
	(SEE-ALL GDESERT)
	(SEE-N SROAD)
	(SEE-S SROAD)
	(SEE-NW D11ROAD)
	(SEE-SE D11ROAD)
	(ACTION S75-F)>

<ROUTINE S75-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A " D ,PROAD " bears north and south across the "
D ,GDESERT ". Another road bends northwest, and a " D ,DTRAIL
" wanders off" ,TOS "east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT S100
	(LOC ROOMS)
	(DESC "Behind the Shed")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
	(HEAR JEEPS)
      ; (ODOR JEEPS)
	(NORTH TO S75)
	(NE PER S100-NE)
	(EAST PER S100-E)
	(SE TO D11)
	(SOUTH PER S100-S)
	(SW TO D10)
	(WEST TO D10)
	(NW TO D10)
	(TDIR P?NORTH)
	(GLOBAL DTOWER GDESERT SROAD DMOUNTS ILINES GIBINOS VOICES)
	(SEE-NE SBUNK)
       	(SEE-N SROAD)
	(SEE-S SROAD)
	(SEE-ALL GDESERT)
	(ACTION S100-F)>

<ROUTINE S100-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"You're hiding behind a small storage " D ,SHED ".|
|
Peeking around the " D ,CORNER ", you see a large earth-covered " D ,SBUNK
" immediately" ,TON "east. Several " D ,JEEPS>
		<COND (<L? ,MINUTES 28>
		       <TELL ", manned by nervous " D ,GIS ",">)>
		<TELL 
" are parked around the " D ,SBUNK "'s open " D ,SBENTRY ,PCR>
		<HEAR-SBUNK>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <NOT <IS? ,SBUNK ,TOUCHED>>>
		<MAKE ,SBUNK ,TOUCHED>
		<COND (<L? ,MINUTES 15>
		       <TELL CR
"A pear-shaped man appears at the " D ,SHELTER
"'s " D ,SBENTRY ". He strides up to one of the jeeps and taps the young driver on the shoulder. \"General Groves, soldier. Take me back to Base Camp.\"|
|
Ill-disguised relief passes over the GI's face as the pear man clambers into the back seat. You duck behind the shed as the jeep roars past, and watch as it disappears (rather hastily) down the south road." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? .CONTEXT ,M-ENTERING>
		<TELL "You ">
		<COND (<PROB 50>
		       <TELL "run for cover">)
		      (T
		       <TELL "dodge into hiding">)>
		<TELL " at the ">
		<COND (<PROB 50>
		       <TELL "sound of a nearby voice">)
		      (T
		       <TELL "sight of people nearby">)>
		<TELL ,PCR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE S100-NE ()
	 <TELL "You start to move towards the " D ,SHELTER>
	 <BUT-HESITATE "rifle">
	 <RFALSE>>

<ROUTINE S100-S ()
	 <TELL "You start to move south">
	 <BUT-HESITATE "pair of binoculars">	 
	 <RFALSE>>
		
<ROUTINE BUT-HESITATE (STR)
	 <TELL ", but hesistate when you notice one of the " D ,GIS>
	 <COND (<G? ,MINUTES 27>
		<TELL " in the " D ,TRENCHES>)>
	 <TELL " fingering a " .STR ".|
|
Do you want to continue anyway?">
	 <COND (<NOT <YES?>>
		<NO-DETECTION>
		<RFALSE>)>
	 <CRLF>
	 <YOU-MARCH>
	 <TELL " away from the safety of the shed.|
|
The GI ">
	 <COND (<EQUAL? .STR "rifle">
		<TELL "with the rifle">)
	       (T
		<TELL "drops his binoculars and">)>
	 <TELL " leaps out of his ">
	 <COND (<L? ,MINUTES 28>
		<TELL D ,JEEP>)
	       (T
		<TELL "trench">)>
	 <TELL ". \"Wha... Who the hell is ">
	 <ITALICIZE "that?">
	 <TELL "\"" CR>
	 <SURROUNDED>
	 <RFALSE>>

<ROUTINE YOU-MARCH ()
	 <TELL "You ">
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?RUN ,W?JOG ,W?CRAWL>
		<PRINTB ,P-PRSA-WORD>)
	       (T
		<TELL "march confidently">)>
	 <RTRUE>>	 

<ROUTINE S100-E ()
	 <TELL "You slip quietly around the back of the shed" ,PCR>
	 <RETURN ,D11>>

<ROUTINE HEAR-SBUNK ()
	 <TELL 
"Muted " D ,VOICES " and crackling radios can be heard inside the " 
D ,SBUNK ,PERIOD>
	 <RTRUE>>

<OBJECT NEPASS
	(LOC ROOMS)
	(DESC "Paved Road")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D7)
	(NE TO D7)
	(EAST TO D7)
	(SE TO S75)
	(SOUTH TO D10)
	(SW TO D10)
	(WEST TO D10)
	(NW TO W75)
	(TDIR P?NE)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NW PROAD)
	(SEE-SE PROAD)
	(ACTION NEPASS-F)>

<ROUTINE NEPASS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A " D ,PROAD " leads southeast and northwest across the " D ,GDESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT D0
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER BORING-DESERT)
	(NE PER BORING-DESERT)
	(EAST PER D0-E)
	(SE TO D3)
	(SOUTH PER D0-S)
	(SW PER BORING-DESERT)
	(WEST PER BORING-DESERT)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(ACTION D0-F)>

<ROUTINE D0-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Bleak, featureless " 
D ,GDESERT " stretches away in every " D ,INTDIR ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D0-S ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N75> ,DROOM)
			 (T ,D3)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D0-E ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N75> ,DROOM)
			 (T ,D1)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>		

<GLOBAL DROOM:OBJECT <>>

<ROUTINE BORING-DESERT ()
	 <TELL <PICK-NEXT ,DESERT-BORES> ,PERIOD>
	 <RFALSE>>

<GLOBAL DESERT-BORES:TABLE 
	<LTABLE 2
	 "There's nothing but trackless desert in that direction"
	 "Nothing but trackless desert lies that way"
	 "Little else but desert lies in that direction">>

<OBJECT D1
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER BORING-DESERT)
	(NE PER BORING-DESERT)
	(EAST TO D2)
	(SE PER D1-SE)
	(SOUTH PER D1-S)
	(SW PER D1-SW)
	(WEST PER D1-W)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(ACTION D1-F)>

<ROUTINE D1-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're surrounded by a vast " D ,GDESERT
" landscape, utterly barren and featureless." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D1-SE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,NEZERO ,NZERO> ,DROOM)
			 (<PROB 50> ,NZERO)
			 (T ,NEZERO)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D1-S ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N25 ,NZERO ,N50> ,DROOM)
			 (<PROB 50> ,NZERO)
			 (T ,N25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D1-SW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N75 ,N50 ,N25> ,DROOM)
			 (<PROB 50> ,N50)
			 (T ,N25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D1-W ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N75 ,N50> ,DROOM)
			 (<PROB 50> ,N75)
			 (T ,D0)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D2
	(LOC ROOMS)
	(DESC "Foothills")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER BORING-DESERT)
	(NE PER FHILLS-TOO-STEEP)
	(EAST PER FHILLS-TOO-STEEP)
	(SE PER FHILLS-TOO-STEEP)
	(SOUTH PER D2-S)
	(SW PER D2-SW)
	(WEST TO D1)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT FHILLS DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-E FHILLS)
	(SEE-NE FHILLS)
	(SEE-SE FHILLS)
	(ACTION D2-F)>

<ROUTINE D2-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The trackless " D ,GDESERT
" slopes upward to join the " D ,FHILLS " in the east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D2-S ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,NEZERO> <PROB 50>> ,NEZERO)
			 (T ,D6)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D2-SW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,NZERO ,NEZERO> ,DROOM)
			 (<PROB 50> ,NZERO)
			 (T ,NEZERO)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D3
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D3-N)
	(NE PER D3-NE)
	(EAST PER D3-E)
	(SE PER D3-SE)
	(SOUTH TO D5)
	(SW PER BORING-DESERT)
	(WEST PER BORING-DESERT)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(ACTION D3-F)>

<ROUTINE D3-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Nothing breaks the monotony of the barren " D ,GDESERT
		      " around you." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D3-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N75 ,N50> ,DROOM)
			 (<PROB 50> ,N75)
			 (T ,D0)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D3-NE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N50 ,N75 ,N25> ,DROOM)
			 (<PROB 50> ,N50)
			 (T ,N25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D3-E ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,N25 ,N50 ,WZERO> ,DROOM)
			 (<PROB 50> ,N25)
			 (T ,N50)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D3-SE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,WZERO ,W25> ,DROOM)
			 (<PROB 50> ,WZERO)
			 (T ,W25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D5
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D3)
	(NE TO WZERO)
	(EAST PER D5-E)
	(SE PER D5-SE)
	(SOUTH PER D5-S)
	(SW PER BORING-DESERT)
	(WEST PER BORING-DESERT)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL D5ROAD DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-SE D5ROAD)
	(ACTION D5-F)>

<ROUTINE D5-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Gray, empty " D ,GDESERT 
" stretches away on either side of a road that leads southeast." CR>  
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D5-E ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W75 ,W50 ,W25> ,DROOM)
			 (<PROB 50> ,W50)
			 (T ,W25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D5-SE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W100 ,W50> ,DROOM)
			 (T ,W75)>>
	 <COND (<EQUAL? .DEST ,W75>
		<RETURN ,W75>)>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D5-S ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W100 ,W75 ,W50> ,DROOM)
			 (<PROB 50> ,W75)
			 (T ,D9)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D6
	(LOC ROOMS)
	(DESC "Foothills")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D2)
	(NE PER FHILLS-TOO-STEEP)
	(EAST PER FHILLS-TOO-STEEP)
	(SE PER D6-SE)
	(SOUTH PER D6-S)
	(SW PER D6-SW)
	(WEST PER D6-W)
	(NW PER D6-NW)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT FHILLS DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-E FHILLS)
	(SEE-NE FHILLS)
	(ACTION D6-F)>

<ROUTINE D6-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Rugged foothills slope eastward, away from the " D ,GDESERT
" wasteland." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D6-SE ()
	 <COND (<EQUAL? ,DROOM ,NERANCH ,NCIST>
		<AIMLESS ,DROOM>
		<RETURN ,DROOM>)>
	 <FHILLS-TOO-STEEP>
	 <RFALSE>>

<ROUTINE D6-S ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,NERANCH ,NCIST ,UNDERM>
			      <EQUAL? ,DROOM ,NWRANCH>>
			  ,DROOM)
			 (<PROB 50> ,D6A)
			 (T ,NCIST)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D6-SW ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,NERANCH ,NWRANCH ,NCIST>
			      <EQUAL? ,DROOM ,UNDERM ,EZERO ,AT-TNT>>
			  ,DROOM)
			 (<PROB 50> ,NERANCH)
			 (T ,NCIST)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D6-W ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,AT-TNT ,EZERO ,NEZERO>
			      <EQUAL? ,DROOM ,UNDERM ,NCIST ,SCIST>>
			  ,DROOM)
			 (<PROB 50> ,AT-TNT)
			 (T ,EZERO)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D6-NW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,EZERO ,NEZERO> ,DROOM)
			 (<PROB 50> ,NEZERO)
			 (T ,D2)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D6A
	(LOC ROOMS)
	(DESC "Foothills")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D6A-N)
	(NE PER D6A-NE)
	(EAST PER FHILLS-TOO-STEEP)
	(SE PER FHILLS-TOO-STEEP)
	(SOUTH TO D11)
	(SW TO D11)
	(WEST PER D6A-W)
	(NW PER D6A-NW)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT FHILLS DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-E FHILLS)
	(SEE-NE FHILLS)
	(SEE-SE FHILLS)
	(ACTION D6A-F)>

<ROUTINE D6A-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"A range of foothills slopes up to meet the " D ,TMOUNTS " in the east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D6A-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,SERANCH ,SCIST ,UNDERM> ,DROOM)
			 (<PROB 50> ,SCIST)
			 (T ,D6)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D6A-NE ()
	 <COND (<EQUAL? ,DROOM ,SCIST>
		<AIMLESS ,DROOM>
		<RETURN ,DROOM>)>
	 <FHILLS-TOO-STEEP>
	 <RFALSE>>

<ROUTINE D6A-W ("AUX" DEST)
	 <SET DEST <COND (<PROB 50> ,D8) (T ,D11)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D6A-NW ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,SWRANCH ,SERANCH ,SCIST>
			      <EQUAL? ,DROOM ,UNDERM>>
			  ,DROOM)
			 (<PROB 50> ,SEYARD)
			 (T ,D8)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D7
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D7-N)
	(NE PER D7-NE)
	(EAST TO S50)
	(SE TO S50)
	(SOUTH TO NEPASS)
	(SW TO NEPASS)
	(WEST PER D7-W)
	(NW PER D7-NW)
	(TDIR P?NE)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NE DTOWER)
	(ACTION D7-F)>

<ROUTINE D7-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
	        <TELL "The distant " D ,DTOWER
" is the only point of reference in this bleak " D ,GDESERT " expanse." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D7-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W50 ,W25> ,DROOM)
			 (<PROB 50> ,W50)
			 (T ,W25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D7-NE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,S50 ,S25> ,DROOM)
			 (<PROB 50> ,S50)
			 (T ,S25)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D7-NW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W25 ,W50> ,DROOM)
			 (<PROB 50> ,W25)
			 (T ,W50)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D7-W ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W75 ,W50 ,NEPASS> ,DROOM)
			 (<PROB 50> ,W75)
			 (T ,W50)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D8
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D8-N)
	(NE PER D8-NE)
	(EAST PER D8-E)
	(SE PER D8-SE)
	(SOUTH TO D11)
	(SW PER D8-SW)
	(WEST TO S50)
	(NW PER D8-NW)
	(TDIR P?NW)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NW DTOWER)
	(ACTION D8-F)>

<ROUTINE D8-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,GDESERT
" around you is flat and empty. Only the distant " D ,DTOWER
" relieves the monotony of the landscape." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D8-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,AT-TNT ,SWRANCH> ,DROOM)
			 (<PROB 50> ,SWRANCH)
			 (T ,AT-TNT)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D8-NE ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,SWRANCH ,NWRANCH ,AT-TNT>
			      <EQUAL? ,DROOM ,SERANCH>>
			  ,DROOM)
			 (<PROB 50> ,NWRANCH)
			 (T ,SWRANCH)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D8-E ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,SWRANCH ,NWRANCH> ,DROOM)
			 (<PROB 50> ,SWRANCH)
			 (T ,D6A)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D8-SE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,SWRANCH> ,DROOM)
			 (T ,D6A)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D8-SW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,S50 ,S75> ,DROOM)
			 (<PROB 50> ,S75)
			 (T ,S50)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D8-NW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,S50 ,S25> ,DROOM)
			 (<PROB 50> ,S25)
			 (T ,S50)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D9
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D9-N)
	(NE PER D9-NE)
	(EAST PER D9-E)
	(SE PER BORING-DESERT)
	(SOUTH PER BORING-DESERT)
	(SW PER BORING-DESERT)
	(WEST PER BORING-DESERT)
	(NW PER BORING-DESERT)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(ACTION D9-F)>

<ROUTINE D9-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL CTHE ,GDESERT
" is still and expectant in the gray light of dawn." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D9-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W100> ,W100)
			 (T ,D5)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D9-NE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W100 ,D10> ,DROOM)
			 (T ,D10)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

; <ROUTINE D9-NE ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,W100> <PROB 50>> ,W100)
			 (T ,D10)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D9-E ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W100> ,W100)
			 (T ,D10)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D10
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER D10-N)
	(NE PER D10-NEE)
	(EAST PER D10-NEE)
	(SE PER D10-SE)
	(SOUTH PER BORING-DESERT)
	(SW PER BORING-DESERT)
	(WEST PER D10-W)
	(NW TO W100)
      ; (TDIR 0)
	(GLOBAL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(ACTION D10-F)>

<ROUTINE D10-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Empty tracts of " D ,GDESERT " surround you on every side." CR> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D10-N ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,W75 ,NEPASS> ,DROOM)
			 (<PROB 50> ,W75)
			 (T ,NEPASS)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D10-SE ()
	 <COND (<OR <EQUAL? ,DROOM ,S100>
		    <PROB 50>>
		<AIMLESS ,S100>
		<RETURN ,S100>)>
	 <BORING-DESERT>
	 <RFALSE>>	       

<ROUTINE D10-NEE ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,NEPASS ,S75 ,S100> ,DROOM)
			 (<PROB 50> ,S75)
			 (T ,NEPASS)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<ROUTINE D10-W ("AUX" DEST)
	 <SET DEST <COND (<OR <EQUAL? ,DROOM ,W100> <PROB 50>> ,W100)
			 (T ,D9)>>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

<OBJECT D11
	(LOC ROOMS)
	(DESC "Desert")
	(FLAGS LIGHTED LOCATION DESERT BORING)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D8)
	(NE TO D6A)
	(EAST TO D6A)
	(SE PER BORING-DESERT)
	(SOUTH PER BORING-DESERT)
	(SW PER BORING-DESERT)
	(WEST PER D11-NWW)
	(NW PER D11-NWW)
      ; (TDIR 0)
	(GLOBAL D11ROAD DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NW D11ROAD)
	(ACTION D11-F)>

<ROUTINE D11-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"A lone road wanders northwest across the empty " D ,GDESERT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE D11-NWW ("AUX" DEST)
	 <SET DEST <COND (<EQUAL? ,DROOM ,S100> ,DROOM)
			 (T ,S75)>>
	 <COND (<EQUAL? .DEST ,S75>
		<RETURN .DEST>)>
	 <AIMLESS .DEST>
	 <RETURN .DEST>>

"*** RANCH AREA ***"

<OBJECT NWRANCH
	(LOC ROOMS)
	(DESC "Northwest of Ranch")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D6)
	(NE TO D6)
	(EAST TO NERANCH)
	(SE TO NWYARD IF NWGATE IS OPEN)
	(SOUTH TO SWRANCH)
	(SW TO D8)
	(WEST TO D8)
	(NW TO AT-TNT)
	(IN TO NWYARD IF NWGATE IS OPEN)
	(TDIR P?NW)
	(WALL-SIDE NWYARD)
	(WALL-DIR P?SE)
	(GLOBAL SWALL NWGATE RANCH RANCH-ROAD DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-SE NWGATE)
	(SEE-NW RANCH-ROAD)
	(ACTION NWRANCH-F)>

<ROUTINE NWRANCH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"You're at the northwest " D ,CORNER " of a " D ,SWALL ". A">
		<OPEN-CLOSED ,NWGATE T>
		<TELL " leads in to a dilapidated " D ,RANCH ,PCR
		      "A " D ,RANCH-ROAD " bears northwest " ,INTO-DESERT
". Other paths curve east and south, along the wall's perimeter." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NWYARD
	(LOC ROOMS)
	(DESC "Back Yard")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER SWALL-BLOCKS)
	(NE PER SWALL-BLOCKS)
	(EAST TO NROOM IF NROOM-DOOR IS OPEN)
	(SE SORRY "There's no entrance that way.")
	(SOUTH PER ENTER-SHALL)
	(SW PER SWALL-BLOCKS)
	(WEST PER SWALL-BLOCKS)
	(NW TO NWRANCH IF NWGATE IS OPEN)
	(IN PER WHICH-WAY-IN)
	(OUT TO NWRANCH IF NWGATE IS OPEN)
	(TDIR P?NW)
	(WALL-SIDE NWRANCH)
	(WALL-DIR P?NW)
	(GLOBAL SWALL NWGATE NROOM-DOOR RANCH SHALL DTOWER GDESERT DMOUNTS)
	(SEE-ALL SWALL)
	(SEE-NE RANCH)
	(SEE-E NROOM-DOOR)
	(SEE-SE RANCH)
	(SEE-S SHALL)
	(SEE-NW NWGATE)
	(ACTION NWYARD-F)>

<ROUTINE NWYARD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "This patch of dust lies within the elbow of the "
		      D ,RANCH ", and is enclosed by a " D ,SWALL
		      ,TON " and west.|
|
An open " D ,SHALL " leads south, into the house. There's also a">
		<OPEN-CLOSED ,NROOM-DOOR T>
		<TELL ,TOE ", and a">
		<OPEN-CLOSED ,NWGATE T>
		<TELL " in the northwest " D ,CORNER 
		      " of the " D ,SWALL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NERANCH
	(LOC ROOMS)
	(DESC "Northeast of Ranch")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D6)
	(NE TO D6)
	(EAST TO NCIST)
	(SE PER RESERVOIR-BLOCKS)
	(SOUTH TO ERANCH)
	(SW PER SWALL-BLOCKS)
	(IN PER WHICH-WAY-IN)
	(WEST TO NWRANCH)
	(NW TO D6)
      ; (TDIR 0)
	(WALL-SIDE NEYARD)
	(WALL-DIR P?SW)
	(GLOBAL SWALL RANCH RESERVOIR RANCH-ROAD DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-SW RANCH)
	(SEE-SE RESERVOIR)
	(SEE-W RANCH-ROAD)
	(ACTION NERANCH-F)>

<ROUTINE NERANCH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "A dilapidated " D ,RANCH
" stands nearby, bounded by dusty patches of ground and a low " D ,SWALL 
". Paths lead south and east, on either side of a cement " 
D ,RESERVOIR ,PA D ,RANCH-ROAD " bends off" ,TOW ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BROOM
	(LOC ROOMS)
	(DESC "Bedroom")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(EAST TO NEYARD IF BROOM-DOOR IS OPEN)
	(OUT PER WHICH-WAY-OUT)
	(WEST TO NROOM)
	(IN TO NROOM)
	(GLOBAL BROOM-DOOR RANCH BEDROOM WINDOWS)
	(SEE-E BROOM-DOOR)
	(ACTION BROOM-F)>

<ROUTINE BROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"This room is stripped bare of all furnishings. Only a rectangular area in the " D ,CORNER ", lighter than the " D ,FLOOR
" around it, belies the former presence of a mattress.|
|
A">
		<OPEN-CLOSED ,BROOM-DOOR T>
		<TELL 
" in the east wall leads outside. Another exit opens west, into the " 
D ,RANCH ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-BATH
	(LOC ROOMS)
	(DESC "Bathroom")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(SOUTH TO NROOM)
	(OUT TO NROOM)
	(IN TO NROOM)
	(GLOBAL RANCH BATHROOM WINDOWS)
	(ACTION IN-BATH-F)>

<ROUTINE IN-BATH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "An old porcelain " D ,SINK 
", broken and faucetless, is the only fixture left in this tiny chamber. The south exit doesn't even have a door." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NROOM
	(LOC ROOMS)
	(DESC "Spare Room")
	(FLAGS LIGHTED LOCATION INDOORS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO IN-BATH)
	(EAST TO BROOM)
	(SOUTH TO NWROOM)
	(WEST TO NWYARD IF NROOM-DOOR IS OPEN)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(GLOBAL NROOM-DOOR RANCH BATHROOM BEDROOM WINDOWS)
	(SEE-N BATHROOM)
	(SEE-E BEDROOM)
	(SEE-W NROOM-DOOR)
	(ACTION NROOM-F)>

<ROUTINE NROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Aside from a">
		<OPEN-CLOSED ,NROOM-DOOR T>
		<TELL ,TOW ", this squarish room offers no amenities. Other exits lead north and east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT NWROOM
	(LOC ROOMS)
	(DESC "Northwest Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH TO NROOM)
	(EAST TO NEROOM)
	(SOUTH TO SWROOM)
	(OUT PER WHICH-WAY-OUT)
	(IN PER WHICH-WAY-IN)
	(GLOBAL RANCH KITCHEN WINDOWS)
	(SEE-E RANCH)
	(SEE-S KITCHEN)
	(ACTION NWROOM-F)>

<ROUTINE NWROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"The original purpose of this stark room is uncertain; it might have been used for dining. Exits lead north, south and east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NEROOM
	(LOC ROOMS)
	(DESC "Assembly Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(HEAR SNAKE)
	(ODOR SNAKE)
	(NORTH TO IN-CLOSET IF CLOSET-DOOR IS OPEN)
	(IN PER WHICH-WAY-IN)
	(EAST TO ON-PORCH IF NEROOM-DOOR IS OPEN)
	(OUT PER WHICH-WAY-OUT)
	(SOUTH TO SEROOM)
	(WEST TO NWROOM)
	(GLOBAL SNAKE CLOSET-DOOR CLOSET RANCH)
	(SEE-E NEROOM-DOOR)
	(SEE-N CLOSET)
	(SEE-W RANCH)
	(SEE-S RANCH)
	(ACTION NEROOM-F)>

<ROUTINE NEROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Whoever used this room was paranoid about dirt. The floor is swept spotless, and the edges of both " D ,AWINDOWS " are carefully sealed with tape. A">
		<OPEN-CLOSED ,NEROOM-DOOR T>
		<TELL " leads east, and there's a">
		<COND (<IS? ,CLOSET-DOOR ,OPENED>
		       <TELL "n open " D ,CLOSET>)
		      (T
		       <TELL " closed">)>
		<TELL 
" door in the north wall. Other exits lead south and west." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-ENTERED>
		     <IS? ,XSNAKE ,NODESC>>
		<UNMAKE ,XSNAKE ,NODESC>		
		<QUEUE I-SNAKE -1>
		<TELL CR 
"You turn to face an urgent noise behind you. Your heart skips a beat. Two tiny eyes, bright with hunger, black with menace, are glaring at you from only a few feet away" ,PCR>
	 	<HEAR-SNAKE>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-EXIT>
		     <IS? ,SNAKE ,LIVING>>
		<MAKE ,SNAKE ,SEEN>
		<TELL "You beat a hasty retreat from the " D ,SNAKE
		      ,PCR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HEAR-SNAKE ()
	 <SETG P-IT-OBJECT ,SNAKE>
	 <TELL 
"You hear the noise again. It's like a pebble in an empty can." CR>
	 <RTRUE>>

<OBJECT IN-CLOSET
	(LOC ROOMS)
	(DESC "Closet")
	(FLAGS LIGHTED LOCATION INDOORS)
	(HEAR SNAKE)
	(ODOR SNAKE)
	(SOUTH TO NEROOM IF CLOSET-DOOR IS OPEN)
	(OUT TO NEROOM IF CLOSET-DOOR IS OPEN)
	(IN SORRY "You're in the closet as far as you can go.")
	(GLOBAL SNAKE CLOSET-DOOR CLOSET RANCH)
	(SEE-S CLOSET-DOOR)
	(ACTION IN-CLOSET-F)>

<ROUTINE IN-CLOSET-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"There's barely enough room to turn around in this puny " D ,CLOSET 
". Its single ">
		<COND (<IS? ,CLOSET-DOOR ,OPENED>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL " door is in the south wall." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWROOM
	(LOC ROOMS)
	(DESC "Kitchen")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH TO NWROOM)
	(EAST TO SEROOM)
	(WEST TO IN-HALL IF SWROOM-DOOR IS OPEN)
	(OUT PER WHICH-WAY-OUT)
	(IN PER WHICH-WAY-IN)
	(GLOBAL SWROOM-DOOR KITCHEN RANCH SHALL WINDOWS)
	(SEE-W SWROOM-DOOR)
	(SEE-N RANCH)
	(SEE-E RANCH)
	(ACTION SWROOM-F)>

<ROUTINE SWROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "Disconnected " D ,PIPES " and an open " D ,CUPBOARD>
		<COND (<FIRST? ,CUPBOARD>
		       <TELL " with ">
		       <PRINT-CONTENTS ,CUPBOARD>
		       <TELL " in it">)>
		<TELL
" are the only evidence of this room's identity. A">
		<OPEN-CLOSED ,SWROOM-DOOR T>
		<TELL " in the west wall leads out to a " D ,SHALL 
		      ". Other exits lead north and east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SEROOM
	(LOC ROOMS)
	(DESC "Southeast Room")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH TO NEROOM)
	(EAST TO ON-PORCH IF SEROOM-DOOR IS OPEN)
	(WEST TO SWROOM)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(GLOBAL KITCHEN RANCH WINDOWS)
	(SEE-N RANCH)
	(SEE-W KITCHEN)
	(SEE-E SEROOM-DOOR)
	(ACTION SEROOM-F)>

<ROUTINE SEROOM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL
"Something about this room gives you the impression that it was hastily vacated. The " D ,SEROOM-DOOR " in the east wall is ">
		<COND (<IS? ,SEROOM-DOOR ,OPENED>
		       <TELL "wide open">)
		      (T
		       <TELL "closed">)>
		<TELL ". Other exits lead north and west." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT IN-HALL
	(LOC ROOMS)
	(DESC "Hallway")
	(FLAGS LIGHTED LOCATION INDOORS)
	(NORTH TO NWYARD)
	(EAST TO SWROOM IF SWROOM-DOOR IS OPEN)
	(WEST PER ENTER-IHOUSE)
	(DOWN PER ENTER-IHOUSE)
	(SOUTH TO SWYARD)
	(IN PER WHICH-WAY-IN)
	(OUT PER WHICH-WAY-OUT)
	(GLOBAL RANCH ICEHOUSE SWROOM-DOOR KITCHEN SHALL ISTAIR)
	(SEE-E SWROOM-DOOR)
	(SEE-W ISTAIR)
	(SEE-N SHALL)
	(SEE-S SHALL)
	(ACTION IN-HALL-F)>

<ROUTINE IN-HALL-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "This short " D ,SHALL
" opens outdoors" ,TON " and south. A">
		<OPEN-CLOSED ,SWROOM-DOOR T>
		<TELL " leads east into a " D ,KITCHEN 
". Turning west, you see a " D ,ISTAIR " descending into darkness." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-IHOUSE ()
	 <TELL "You descend the " D ,ISTAIR ,PCR>
	 <RETURN ,IHOUSE>>

<OBJECT IHOUSE
	(LOC ROOMS)
	(DESC "Icehouse")
	(FLAGS LIGHTED LOCATION INDOORS)
        (OVERHEAD ISTAIR)
      ; (HEAR 0)
      ; (ODOR 0)
	(UP PER EXIT-IHOUSE)
	(OUT PER EXIT-IHOUSE)
	(EAST PER EXIT-IHOUSE)
	(GLOBAL ICEHOUSE ISTAIR RANCH SHALL)
	(SEE-E ISTAIR)
	(ACTION IHOUSE-F)>

<ROUTINE IHOUSE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<FEEL-IHOUSE>
		<TELL 
" It feels as if nobody's been down here for a long time.|
|
Gray light seeps in from a " D ,ISTAIR " climbing east." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FEEL-IHOUSE ()
	 <TELL
"The walls of this underground chamber are cool and clammy to your touch.">
	 <RTRUE>>

<ROUTINE EXIT-IHOUSE ()
	 <TELL "You trudge up the " D ,ISTAIR ,PCR>
	 <RETURN ,IN-HALL>>

<OBJECT SWRANCH
	(LOC ROOMS)
	(DESC "Southwest of Ranch")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO NWRANCH)
	(NE TO SWYARD IF SWGATE IS OPEN)
	(IN TO SWYARD IF SWGATE IS OPEN)
	(EAST TO SERANCH)
	(SE TO D6A)
	(SOUTH TO D8)
	(SW TO D8)
	(WEST TO D8)
	(NW TO D8)
	(GLOBAL SWALL SWGATE RANCH SHALL DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NE SWGATE)
	(WALL-SIDE SWYARD)
	(WALL-DIR P?NE)
      ; (TDIR 0)
	(ACTION SWRANCH-F)>

<ROUTINE SWRANCH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The low " D ,SWALL
" before you is almost as run-down as the " D ,RANCH 
" inside it. Paths follow the wall's perimeter" ,TON " and east, and a">
		<OPEN-CLOSED ,SWGATE T>
		<TELL 
" leads northeast into a dusty yard." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE ENTER-SHALL ()
	 <TELL "You step into the " D ,SHALL ,PCR>
	 <RETURN ,IN-HALL>>

<OBJECT SEYARD
	(LOC ROOMS)
	(DESC "Southeast Yard")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER CLIMB-PORCH)
	(UP PER CLIMB-PORCH)
	(IN SORRY "There aren't any entrances here.")
	(NE PER SWALL-BLOCKS)
	(EAST PER SWALL-BLOCKS)
	(SE TO SERANCH IF SEGATE IS OPEN)
	(OUT TO SERANCH IF SEGATE IS OPEN)
	(SOUTH PER SWALL-BLOCKS)
	(SW PER SWALL-BLOCKS)
	(WEST TO SWYARD)
	(NW SORRY "There aren't any entrances here.")
	(GLOBAL SWALL SEGATE RANCH PORCH DTOWER GDESERT DMOUNTS)
	(SEE-NW RANCH)
	(SEE-N PORCH)
	(SEE-SE SEGATE)
	(SEE-ALL SWALL)
	(WALL-SIDE SERANCH)
	(WALL-DIR P?SE)
      ; (TDIR 0)
	(ACTION SEYARD-F)>

<ROUTINE SEYARD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're just inside the " D ,SWALL 
", near the " D ,RANCH "'s southeast " D ,CORNER 
,PA "raised deck stands immediately" ,TON ", and a">
		<OPEN-CLOSED ,SEGATE T>
		<TELL " in the wall leads southeast." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLIMB-PORCH ()
	 <TELL "You stride onto the deck" ,PCR>
	 <RETURN ,ON-PORCH>>

<OBJECT SERANCH
	(LOC ROOMS)
	(DESC "Southeast of Ranch")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (ODOR 0)
      ; (OVERHEAD 0)
      ; (HEAR 0)
	(NORTH TO ERANCH)
	(NE PER RESERVOIR-BLOCKS)
	(EAST TO SCIST)
	(SE TO D6A)
	(SOUTH TO D6A)
	(SW TO D8)
	(WEST TO SWRANCH)
	(NW TO SEYARD IF SEGATE IS OPEN)
	(IN TO SEYARD IF SEGATE IS OPEN)
      ; (TDIR 0)
	(WALL-SIDE SEYARD)
	(WALL-DIR P?NW)
	(GLOBAL SWALL SEGATE RANCH DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-NW SEGATE)
	(ACTION SERANCH-F)>

<ROUTINE SERANCH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "The low " D ,SWALL  
" enclosing this dilapidated " D ,RANCH " has a">
		<OPEN-CLOSED ,SEGATE T>
		<TELL 
" leading inside. Paths follow the wall's perimeter" ,TON
" and west, and another curves east along a cement " D ,RESERVOIR ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NEYARD
	(LOC ROOMS)
	(DESC "Northeast Yard")
	(FLAGS LIGHTED LOCATION)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER SWALL-BLOCKS)
	(NE PER SWALL-BLOCKS)
	(EAST PER SWALL-BLOCKS)
	(SE PER SWALL-BLOCKS)
	(SOUTH PER CLIMB-PORCH)
	(UP PER CLIMB-PORCH)
	(SW SORRY "There's no entrance that way.")
	(WEST TO BROOM IF BROOM-DOOR IS OPEN)
	(IN TO BROOM IF BROOM-DOOR IS OPEN)
	(NW PER SWALL-BLOCKS)
	(GLOBAL BROOM-DOOR SWALL RANCH PORCH RAMP DTOWER GDESERT DMOUNTS)
	(SEE-ALL SWALL)
	(SEE-SW RANCH)
	(SEE-S PORCH)
	(SEE-W BROOM-DOOR)
	(WALL-SIDE NERANCH)
	(WALL-DIR P?NE)
      ; (TDIR 0)
	(ACTION NEYARD-F)>

<ROUTINE NEYARD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"There aren't any " D ,CAVE-HOLE "s in this " D ,CORNER " of the " D SWALL
,PA "raised deck stands immediately" ,TOS ", and a">
		<OPEN-CLOSED ,BROOM-DOOR T>
		<TELL " leads west" ,INRANCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWYARD
	(LOC ROOMS)
	(DESC "Southwest Yard")
	(FLAGS LIGHTED LOCATION)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER ENTER-SHALL)
	(IN PER ENTER-SHALL)
	(NE SORRY "There's no entrance that way.")
	(EAST TO SEYARD)
	(SE PER SWALL-BLOCKS)
	(SOUTH PER SWALL-BLOCKS)
	(SW TO SWRANCH IF SWGATE IS OPEN)
	(OUT TO SWRANCH IF SWGATE IS OPEN)
	(WEST PER SWALL-BLOCKS)
	(NW PER SWALL-BLOCKS)
	(GLOBAL SWGATE SWALL SHALL RANCH PORCH RAMP DTOWER GDESERT DMOUNTS)
	(SEE-SW SWGATE)
	(SEE-N SHALL)
	(SEE-ALL SWALL)
	(SEE-NE RANCH)
	(WALL-SIDE SWRANCH)
	(WALL-DIR P?SW)
      ; (TDIR 0)
	(ACTION SWYARD-F)>

<ROUTINE SWYARD-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "This is the southwest " D ,CORNER
" of the " D ,RANCH ", just inside the " D ,SWALL ,PA D ,SHALL
" opens north into the house, and a">
		<OPEN-CLOSED ,SWGATE T>
		<TELL " in the wall leads southwest." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>	

<OBJECT ON-PORCH
	(LOC ROOMS)
	(DESC "Front Deck")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER ON-PORCH-N)
	(NE PER SWALL-BLOCKS)
	(EAST PER DOWN-RAMP)
	(DOWN PER DOWN-RAMP)
	(SE PER SWALL-BLOCKS)
	(SOUTH PER ON-PORCH-S)
	(SW TO SEROOM IF LEFT-DOOR IS OPEN)
	(WEST PER ENTER-RANCH)
	(NW TO NEROOM IF RIGHT-DOOR IS OPEN)
	(IN PER ENTER-RANCH)
	(GLOBAL SWALL RANCH PORCH RAMP DTOWER GDESERT DMOUNTS)
	(SEE-NW RIGHT-DOOR)
	(SEE-SW LEFT-DOOR)
	(SEE-W RANCH)
	(SEE-E RAMP)
	(SEE-ALL GDESERT)
	(WALL-SIDE ERANCH)
	(WALL-DIR P?EAST)
      ; (TDIR 0)
	(ACTION ON-PORCH-F)>

<ROUTINE ON-PORCH-F ("OPTIONAL" (CONTEXT <>) 
		     "AUX" (L <>) (R <>) (B <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<COND (<IS? ,LEFT-DOOR ,OPENED>
		       <SET L T>)>
		<COND (<IS? ,RIGHT-DOOR ,OPENED>
		       <SET R T>)>
		<TELL 
"You're on a raised deck attached" ,TOE " side of the "
D ,RANCH ". Two ">
		<COND (<AND <T? .L> <T? .R>>
		       <SET B T>
		       <TELL "open ">)
		      (<AND <ZERO? .L> <ZERO? .R>>
		       <SET B T>
		       <TELL "closed ">)>
		<TELL "doors, ">
		<COND (<ZERO? .B>
		       <SAY-A-DOOR ,LEFT-DOOR>)>
		<TELL "one at the deck's left " D ,CORNER " and ">
		<COND (<ZERO? .B>
		       <SAY-A-DOOR ,RIGHT-DOOR>)>
		<TELL 
"one at the right, lead inside. A gentle ramp slopes down to the front yard." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<ROUTINE SAY-A-DOOR (DOOR)
	 <TELL "a">
	 <COND (<IS? .DOOR ,OPENED>
	        <TELL "n open ">)
	       (T
		<TELL " closed ">)>
	 <RTRUE>>

<ROUTINE ENTER-RANCH ("AUX" DEST)
	 <COND (<IS? ,LEFT-DOOR ,OPENED>
		<SET DEST ,SEROOM>
		<COND (<IS? ,RIGHT-DOOR ,OPENED>
		       <TELL
"[Which way do you want to go in, northwest or southwest?]" CR>
		       <RFALSE>)>)
	       (<IS? ,RIGHT-DOOR ,OPENED>
		<SET DEST ,NEROOM>)
	       (T
		<SETG P-THEM-OBJECT ,RIGHT-DOOR>
		<TELL "Both of the doors are closed." CR>
		<RFALSE>)>
	 <TELL "You step inside the " D ,RANCH ,PCR>
	 <RETURN .DEST>>

<ROUTINE DOWN-RAMP ()
	 <TELL "You descend the " D ,RAMP ,PCR>
	 <RETURN ,ERANCH>>

<ROUTINE ON-PORCH-N ()
	 <CLIMB-OFF-PORCH>
	 <RETURN ,NEYARD>>

<ROUTINE ON-PORCH-S ()
	 <CLIMB-OFF-PORCH>
	 <RETURN ,SEYARD>>

<ROUTINE CLIMB-OFF-PORCH ()
	 <TELL "You climb off the deck" ,PCR>
	 <RTRUE>>

<OBJECT ERANCH
	(LOC ROOMS)
	(DESC "Front Yard")
	(FLAGS LIGHTED LOCATION)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO NERANCH)
	(NE TO NCIST)
	(EAST PER RESERVOIR-BLOCKS)
	(SE TO SCIST)
	(SOUTH TO SERANCH)
	(SW PER SWALL-BLOCKS)
	(WEST PER ASCEND-RAMP)
	(UP PER ASCEND-RAMP)
	(NW PER SWALL-BLOCKS)
	(IN PER ASCEND-RAMP)
	(GLOBAL SWALL RANCH RAMP PORCH RESERVOIR RANCH-ROAD DTOWER 
	        GDESERT DMOUNTS)
	(SEE-E RESERVOIR)
	(SEE-W RANCH)
	(SEE-NW SWALL)
	(SEE-SW SWALL)
	(SEE-ALL GDESERT)
	(WALL-SIDE ON-PORCH)
	(WALL-DIR P?WEST)
      ; (TDIR 0)
	(ACTION ERANCH-F)>

<ROUTINE ERANCH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"This patch of ground lies between the " D ,RANCH ,TOW ", and a huge cement " 
D ,RESERVOIR ,TOE 
". Well-worn paths curve north and south, around the "
D ,SWALL " enclosing the house. Other trails skirt the "
D ,RESERVOIR " on either side.|
|
A ramp slopes up through a gap in the " D ,SWALL 
", ending on a raised deck." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ASCEND-RAMP ()
	 <TELL "You ascend the " D ,RAMP ,PCR>
	 <RETURN ,ON-PORCH>>

<OBJECT NCIST
	(LOC ROOMS)
	(DESC "North of Reservoir")
	(FLAGS LIGHTED LOCATION DESERT)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D6)
	(NE TO D6)
	(EAST TO D6)
	(SE TO UNDERM)
	(SOUTH PER RESERVOIR-BLOCKS)
	(SW TO ERANCH)
	(WEST TO NERANCH)
	(NW TO D6)
	(GLOBAL RANCH RESERVOIR MILL MLADDER DTOWER GDESERT DMOUNTS)
	(SEE-S RESERVOIR)
	(SEE-ALL GDESERT)
	(SEE-SE MILL)
	(SEE-SW RANCH)
      ; (TDIR 0)
	(ACTION NCIST-F)>

<ROUTINE NCIST-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're resting at the north side of a big cement " D ,RESERVOIR
". Dusty paths curve west and southwest around a " D ,RANCH
", and a trail leads southeast to the base of a " D ,MILL ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT UNDERM
	(LOC ROOMS)
	(DESC "Under the Windmill")
	(FLAGS LIGHTED LOCATION DESERT)
        (OVERHEAD MLADDER)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH TO D6)
	(NE TO D6)
	(EAST TO D6)
	(SE TO D6A)
	(SOUTH TO D6A)
	(SW TO SCIST)
	(WEST PER RESERVOIR-BLOCKS)
	(NW TO NCIST)
	(UP PER CLIMB-MILL)
	(GLOBAL MILL RANCH MLADDER RESERVOIR DTOWER GDESERT DMOUNTS)
	(SEE-ALL GDESERT)
	(SEE-W RESERVOIR)
      ; (TDIR 0)
	(ACTION UNDERM-F)>

<ROUTINE UNDERM-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<SETG P-IT-OBJECT ,MLADDER>
		<TELL "A squat wooden " D ,MILL
" rises overhead, its dark timbers tapering up to a ">
		<COND (<IS? ,BINOS ,TOUCHED>
		       <TELL "broken ">)
		      (T
		       <TELL "square ">)>
		<TELL D ,LANDING " that">
		<COND (<IS? ,BINOS ,TOUCHED>
		       <TELL "'s tilted over">)
		      (T
		       <TELL " overlooks">)>
		<TELL " the east side of an adjacent " D ,RESERVOIR ".|
|
The bottom rungs of a " D ,MLADDER " are just within reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLIMB-MILL ()
	 <COND (<IS? ,BINOS ,TOUCHED>
		<SETG P-IT-OBJECT ,LANDING>
		<TELL CTHE ,LANDING " overhead is broken. " ,CANT
		      "climb up to it anymore." CR>
		<RFALSE>)
	       (<NOT <IS? ,IN-MILL ,TOUCHED>> ; "DESCRIBE-ROOM will set it."
		<QUEUE I-MILL -1>)>
	 <TELL CTHE ,MLADDER " squeaks and complains as you ascend" ,PCR>
	 <RETURN ,IN-MILL>>

<OBJECT IN-MILL
	(LOC ROOMS)
	(DESC "Windmill")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (OVERHEAD 0)
        (HEAR LANDING)
      ; (ODOR 0)
	(DOWN PER DOWN-MLADDER)
	(OUT PER DOWN-MLADDER)
	(GLOBAL MILL MLADDER RANCH GDESERT DTOWER DMOUNTS RESERVOIR)
	(SEE-ALL GDESERT)
	(SEE-W RANCH)
	(SEE-E DMOUNTS)
      ; (TDIR 0)
	(ACTION IN-MILL-F)>

<ROUTINE IN-MILL-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're on a square " D ,LANDING 
" near the top of the " D ,MILL ,PTHE
"rotting planks underfoot creak ominously as you stand on them.|
|
A rickety " D ,MLADDER " leads downward." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DOWN-MLADDER ()
	 <SAY-GROANS ,MLADDER>
	 <CRLF>
	 <RETURN ,UNDERM>>

<ROUTINE SAY-GROANS (OBJ)
	 <TELL CTHE .OBJ " groans under your weight." CR>
	 <RTRUE>>

<OBJECT SCIST
	(LOC ROOMS)
	(DESC "South of Reservoir")
	(FLAGS LIGHTED LOCATION DESERT)
        (OVERHEAD CISTAIR)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER ENTER-RESERVOIR)
	(UP PER ENTER-RESERVOIR)
	(NE TO UNDERM)
	(EAST TO D6A)
	(SE TO D6A)
	(SOUTH TO D6A)
	(SW TO D6A)
	(WEST TO SERANCH)
	(NW TO ERANCH)
	(GLOBAL RESERVOIR RANCH CISTAIR MILL MLADDER DTOWER GDESERT DMOUNTS)
      ; (TDIR 0)
	(SEE-N CISTAIR)
	(SEE-ALL GDESERT)
	(SEE-NW RANCH)
	(SEE-NE MILL)
	(ACTION SCIST-F)>

<ROUTINE SCIST-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're near the south side of a big cement " D ,RESERVOIR
". Dusty paths lead west and northwest around a " D ,RANCH
". Another curves northeast, to the base of a " D ,MILL ".|
|
A " D ,CISTAIR " climbs up to the " D ,RESERVOIR "'s edge." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTER-RESERVOIR ()
	 <TELL "You climb the " D ,CISTAIR ,PCR>
	 <RETURN ,ON-CIST>>

<OBJECT ON-CIST
	(LOC ROOMS)
	(DESC "Edge of Reservoir")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER INTO-RESERVOIR)
	(IN PER INTO-RESERVOIR)
	(DOWN PER DOWN-CISTAIR)
	(SOUTH PER DOWN-CISTAIR)
	(NE PER RES-FALL)
	(EAST PER RES-FALL)
	(SE PER RES-FALL)
	(SW PER RES-FALL)
	(WEST PER RES-FALL)
	(NW PER RES-FALL)
	(GLOBAL RESERVOIR CISTAIR RANCH GDESERT DTOWER DMOUNTS MILL)
      ; (TDIR 0)
	(SEE-W RANCH)
	(SEE-ALL GDESERT)
	(SEE-N RESERVOIR)
	(SEE-S CISTAIR)
	(ACTION ON-CIST-F)>

<ROUTINE ON-CIST-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL "You're on the edge of a big concrete " D ,RESERVOIR 
", filled with dark water. A short flight of steps leads down to the ground." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RES-FALL ()
	 <YOUD-FALL-OFF ,RESERVOIR>
	 <RFALSE>>

<ROUTINE INTO-RESERVOIR ("AUX" L)
	 <COND (<IN? ,CAGE ,PLAYER>
		<DO-DROWN>)>
	 <SET L <LOC ,WTK>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER>
		    <IN? .L ,PLAYER>>
		<MAKE ,WTK ,CHILLY>)>
	 <SET L <LOC ,BAG>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER>
		    <IN? .L ,PLAYER>>
		<MOVE ,SOGGY .L>
		<REMOVE ,BAG>
		<SETG APPETITE 0>
		<SETG CCNT 0>)>
	 <SET L <LOC ,EBAG>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER>
		    <IN? .L ,PLAYER>>
		<MOVE ,SOGGY .L>
		<REMOVE ,EBAG>)>
	 <ITALICIZE "Splash!">
	 <TELL CR CR>
	 <RETURN ,IN-CIST>>

<ROUTINE DOWN-CISTAIR ()
	 <TELL "You descend the " D ,CISTAIR ,PCR>
	 <RETURN ,SCIST>>

<OBJECT IN-CIST
	(LOC ROOMS)
	(DESC "Reservoir")
	(FLAGS LIGHTED LOCATION NOGRASS)
      ; (OVERHEAD 0)
      ; (HEAR 0)
      ; (ODOR 0)
	(NORTH PER ONLY-SOUTH)
	(NE PER ONLY-SOUTH)
	(EAST PER ONLY-SOUTH)
	(SE PER ONLY-SOUTH)
	(SOUTH PER EXIT-CIST)
	(UP PER EXIT-CIST)
	(OUT PER EXIT-CIST)
	(SW PER ONLY-SOUTH)
	(WEST PER ONLY-SOUTH)
	(NW PER ONLY-SOUTH)
	(DOWN PER IN-CIST-D)
	(IN PER IN-CIST-D)
	(GLOBAL RESERVOIR MILL)
	(SEE-ALL RESERVOIR)
	(ACTION IN-CIST-F)>

<ROUTINE ONLY-SOUTH ()
	 <TELL "The only way out is" ,TOS ,PERIOD>
	 <RFALSE>>

<ROUTINE IN-CIST-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"You're treading water in a big cement " D ,RESERVOIR
", too deep for your feet to touch bottom." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-CIST ()
	 <TELL "You climb out of the " D ,RESERVOIR ,PCR>
	 <RETURN ,ON-CIST>>

<ROUTINE IN-CIST-D ()
	 <COND (<ZERO? ,BREATH-HELD?>
		<SETG BREATH-HELD? 4>
		<QUEUE I-HOLD-BREATH -1>
		<TELL "[holding " D ,BREATH " first" ,BRACKET>)>
	 <TELL "You sink below the " D ,CSURFACE>
	 <TELL ,PCR>
	 <COND (<IN? ,CAGE ,PLAYER>
		<DO-DROWN>)>
	 <RETURN ,UNDER-WATER>>

<OBJECT UNDER-WATER
	(LOC ROOMS)
	(DESC "Underwater")
	(FLAGS LOCATION INDOORS NOGRASS)
	(OVERHEAD CSURFACE)
      ; (ODOR 0)
      ; (HEAR 0)
	(NORTH SORRY "You hit your head against the side of the reservoir.")
	(NE SORRY "You hit your head against the side of the reservoir.")
	(EAST SORRY "You hit your head against the side of the reservoir.")
	(SE SORRY "You hit your head against the side of the reservoir.")
	(SOUTH SORRY "You hit your head against the side of the reservoir.")
	(SW SORRY "You hit your head against the side of the reservoir.")
	(WEST SORRY "You hit your head against the side of the reservoir.")
	(NW SORRY "You hit your head against the side of the reservoir.")
	(UP PER RISE-TO-SURFACE)
	(OUT PER RISE-TO-SURFACE)
	(DOWN SORRY "You're already at the bottom of the reservoir.")
	(GLOBAL RESERVOIR)
	(SEE-ALL RESERVOIR)
	(ACTION UNDER-WATER-F)>

<ROUTINE UNDER-WATER-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<TELL 
"Suspended particles of muck swirl in the beam of the " D ,LAMP
". It's impossible to see more than a few feet." CR>
		<RTRUE>)
	       (<AND <EQUAL? .CONTEXT ,M-BEG>
		     <VERB? SMELL INHALE EXHALE DRINK EAT TASTE SUCK>>
		<NOT-RECOMMENDED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RISE-TO-SURFACE ()
	 <COND (<T? ,BREATH-HELD?>
	        <SETG BREATH-HELD? 0>
		<DEQUEUE I-HOLD-BREATH>)>
	 <TELL "You rise to the " D ,CSURFACE ", gasping for air" ,PCR>
	 <RETURN ,IN-CIST>>
		
<ROUTINE JIGS-UP ()
	 <CARRIAGE-RETURNS>
	 <SETG IN-DORY? <>>
	 <SETG HERE ,DEATH>
	 <MOVE ,PLAYER ,HERE>
	 <SETG LIT? T>
	 <SETG VERBOSITY 1>
	 <DISPLAY-PLACE>
	 <V-LOOK>
	 <FINISH>>

<OBJECT DEATH
	(LOC ROOMS)
	(DESC "The River")
	(FLAGS LIGHTED LOCATION)
	(ACTION DEATH-F)>

<ROUTINE DEATH-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-LOOK>
		<DESCRIBE-DOCKSIDE>
	        <DORY-APPEARS>
		<MAKE-OUT-CHARON>
		<CRLF>
		<SOUNDLESS-LANDING>
		<TELL 
". Something in the way he crooks his skeletal finger compels you to board. You surrender ">
		<COND (<GOT? ,BCOIN>
		       <TELL "your " D ,BCOIN>)
		      (T
		       <TELL "a " D ,BCOIN " you didn't know you had">)>
		<TELL 
", take a seat and wait patiently for your first glimpse of the "
D ,OPSHORE ,PERIOD>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE FINISH ("AUX" X)
	 <CRLF>
	 <V-SCORE>
	 <TELL CR
"Do you want to restart the story, restore a saved position, or quit?" CR CR>
	 <REPEAT ()
		 <TELL "[Type RESTART, RESTORE or QUIT.] >">
	 	 <READ ,P-INBUF ,P-LEXV>
	 	 <SET X <GET ,P-LEXV 1>>
	 	 <COND (<EQUAL? .X ,W?RESTART>
	        	<SET X <RESTART>>
			<FAILED "RESTART">)
	       	       (<EQUAL? .X ,W?RESTORE>
			<SET X <RESTORE>>
			<FAILED "RESTORE">)
	       	       (<EQUAL? .X ,W?Q ,W?QUIT>
			<CRLF>
			<QUIT>)>>>

<CONSTANT BYRNE 0>
<CONSTANT THOREAU 1>
<CONSTANT POPE 2>
<CONSTANT CARROLL 3>
<CONSTANT CLARKE 4>
<CONSTANT PDL 5>
<CONSTANT HAWTHORNE 6>
<CONSTANT MELVILLE 7>
<CONSTANT EMERSON 8>
<CONSTANT MATTHEW 9>
<CONSTANT RIMBAUD 10>
<CONSTANT EMILY 11>
<CONSTANT WHITMAN 12>

<GLOBAL QUOTES:TABLE
	<PTABLE
	 <PLTABLE 24
		  "Time isn't holding us."
	 	  "Time isn't after us.   "
	 	  "Same as it ever was,  "
	 	  "Same as it ever was.   "
	 	  0
	 	  "        -- David Byrne">
	 <PLTABLE 44
		  "They are of sick and diseased imaginations"
	 	  "who would toll the world's knell so soon. "
	 	  0
	 	  "                    -- Henry David Thoreau">
	 <PLTABLE 42 
	 	  "Atoms or systems into ruin hurled,      "
	 	  "And now a bubble burst, and now a world."
	 	  0
	 	  "                       -- Alexander Pope">
	 <PLTABLE 42
	 	  "\"And 'the wabe' is the grass-plot round "
	 	  " a sun-dial, I suppose?\" said Alice,    "
	          " surprised at her own ingenuity.         "
	 	  0
	 	  "\"Of course it is. It's called 'wabe,'   "
	 	  " you know, because it goes a long way   "
	 	  " before it, and a long way behind it --\""
	 	  0
	 	  "                        -- Lewis Carroll">
	 <PLTABLE 22
	 	  "Any sufficiently    "
	 	  "advanced technology "
	 	  "is indistinguishable"
	 	  "from magic.          "
	 	  0
	 	  " -- Arthur C. Clarke">
	 <PLTABLE 22
	          " Any sufficiently   "
	          " arcane magic is    "
	          " indistinguishable  "
	          " from technology.    "
	          0
	          " -- P. David Lebling">
	 <PLTABLE 40
	          "The love of posterity is a consequence"
	 	  "of the necessity of death. If a man   "
	 	  "were sure of living forever, he would "
	 	  "not care about his offspring.          "
	 	  0
	 	  "                -- Nathaniel Hawthorne">
	 <PLTABLE 37 
	 	  "Could annihilation occur in matter,"
	 	  "this were the thing to do it.       "
	 	  0
	 	  "                 -- Herman Melville">
	 <PLTABLE 44
	 	  "From this crude lab that spawned a dud,   "
	 	  "Their necks to Truman's axe uncurled,     "
	 	  "Lo, the embattled savants stood           "
	 	  "And fired the flop heard 'round the world."
	 	  0
	 	  "           -- Los Alamos ditty, circa 1945">
	 <PLTABLE 26
	  	  " Can ye not discern the "
		  " signs of the times?    "
		  0
		  "        -- Matthew 16:3 ">
	 <PLTABLE 20 
	  	  "Il y a une horloge"
		  "qui ne sonne pas. "
		  0
		  " -- Arthur Rimbaud">
	 <PLTABLE 40
		  "'Twere better Charity                 "
		  "To leave me in the Atom's Tomb -      "
		  "Merry, and Nought, and gay, and numb -"
		  "Than this smart Misery.                "
		  0
		  "                    -- Emily Dickinson">
	 <PLTABLE 54
		  "Distant and dead resuscitate,                       "
		  "They show me as the dial or move as the hands of me,"
		  "I am the clock myself.                               "
		  0
		  "                                     -- Walt Whitman">>>




		      
		      
