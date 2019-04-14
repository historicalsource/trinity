"EVENTS for TRINITY: (C)1986 Infocom, Inc. All rights reserved."

<GLOBAL C-TABLE:TABLE <ITABLE NONE 100>>
<CONSTANT C-TABLELEN 100>
<GLOBAL C-INTS:NUMBER 100>

<CONSTANT C-INTLEN 4>	; "Length of an interrupt entry."
<CONSTANT C-RTN 0>	; "Offset of routine name."
<CONSTANT C-TICK 1>	; "Offset of count."

<ROUTINE DEQUEUE (RTN)
	 <SET RTN <QUEUED? .RTN>>
	 <COND (<T? .RTN>
		<PUT .RTN ,C-RTN 0>)>
	 <RTRUE>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

"This version of QUEUE automatically enables as well."

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>))
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (<T? .INT>
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "[Too many interrupts!]" CR>)>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (ELSE
			'<L=? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<GLOBAL CLOCK-WAIT?:FLAG <>>
<GLOBAL CLOCK-HAND:NUMBER <>>
<GLOBAL HOURS:NUMBER 15>
<GLOBAL MINUTES:NUMBER 30>
<GLOBAL SECONDS:NUMBER 0>
<GLOBAL FREEZE?:FLAG <>>
<GLOBAL QUIET?:FLAG <>>

<ROUTINE DO-MOVES (N "AUX" X)
	 <SETG OLD-HERE <>>
	 <SETG QUIET? T>
	 <REPEAT ()
		 <COND (<ZERO? .N>
			<RETURN>)>
		 <SET X <CLOCKER>>
		 <DEC N>>
	 <SETG QUIET? <>>
	 <RTRUE>>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>))
	 <COND (<T? ,CLOCK-WAIT?>
		<SETG CLOCK-WAIT? <>>
		<RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<INC MOVES>
			<COND (<T? ,FREEZE?>
			       <RETURN>)>
			<SETG SECONDS <+ ,SECONDS 15>>
			<COND (<G? ,SECONDS 59>
			       <SETG SECONDS <- ,SECONDS 60>>
	 		       <INC MINUTES>
			       <COND (<G? ,MINUTES 59>
		       	       	      <SETG MINUTES <- ,MINUTES 60>>
		       	       	      <INC HOURS>
		       	       	      <COND (<G? ,HOURS 23>
			      	      	     <SETG HOURS 0>)>)>)>
			<RETURN>)
		       (<T? <GET ,CLOCK-HAND ,C-RTN>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<T? .TICK>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<T? .TICK>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (T
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (<APPLY .RTN>
					     <SET FLG T>)>
				      <COND (<AND <ZERO? .Q?>
						<T? <GET ,CLOCK-HAND ,C-RTN>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<ZERO? .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>
	 <RETURN .FLG>>

"*** GARDENS ***"

<ROUTINE I-BLOW ("AUX" (ST 0))
	 <UNMAKE ,TREE ,NODESC>
	 <MOVE ,PARASOL ,TREE>
	 <UNMAKE ,PARASOL ,OPENED>
	 <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
	 <SETG P-IT-OBJECT ,PARASOL>
	 <MAKE ,JWOMAN ,CHILLY>
	 <MAKE ,JWOMAN ,NODESC>
	 <TELL CR "A strong gust of wind snatches the " D ,PARASOL
" out of the " D ,JWOMAN
"'s hands and sweeps it into the branches of the tree.|
|
The woman circles the tree a few times, gazing helplessly upward. That "
D ,PARASOL
" obviously means a lot to her, for a wistful tear is running down her cheek. But nobody except you seems to notice her loss.|
|
After a few moments, the " D ,JWOMAN
" dries her eyes, gives the tree a vicious little kick and shuffles away down the " D ,LNWALK ,PERIOD>
	 <COND (<ZERO? ,TR?>
		<RTRUE>)>
	 <TELL CR
"You stare up at the " D ,PARASOL>
	 <COND (<ZERO? ,RAID?>
		<TELL ,PCR
"Passersby begin to gather, craning to see what everyone else is looking at. You hardly notice them. Even when the sirens begin ">)
	       (T
		<TELL " for a few moments. Even as the sirens continue ">)>
	 <TELL
"to howl, and the crowd scatters like leaves in the " D ,EWIND
", you can't take your eyes off the "
D ,PARASOL " swaying in the branches, back and forth.|
|
A gentle voice whispers in your ear. ">
	 <COND (<EQUAL? <GETB 0 30> 5> ; "Atari ST?"
		<INC ST>
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)
	       (T
		<TELL "\"">)>
	 <TELL "It's time.">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL CR CR
"You bend to pet the " D ,MEEP " waiting impatiently at your feet">
	 <COND (<VISIBLE? ,BALL>
		<TELL ". Then you ">
		<COND (<NOT <IN? ,BALL ,PLAYER>>
		       <TELL "pick up the " D ,BALL ", ">)>
		<TELL "retrieve the " D ,PARASOL>
		<COND (<IN? ,BALL ,PLAYER>
		       <TELL " with the " D ,BALL>)>
		<TELL " and hurry off">
		<COND (<IN? ,PRAM ,HERE>
		       <TELL ", pushing the " D ,PRAM " before you">)
		      (T
		       <TELL " to find a " D ,PRAM>)>)
	       (T
		<TELL ", then hurry off to find a " D ,BALL>)>
	 <TELL
". But that slogan keeps echoing over and over in your mind...">
	 <CARRIAGE-RETURNS>
	 <SETG HERE ,THE-END>
	 <MOVE ,PLAYER ,HERE>
	 <V-$PRAMS>
	 <TELL CR "You've completed the story of ">
	 <ITALICIZE "Trinity.">
	 <CRLF>
	 <FINISH>
	 <RTRUE>>


<ROUTINE V-$PRAMS ("AUX" X)
	 <CLEAR -1>
	 <SPLIT 13>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 11 <- ,MIDSCREEN 21>>
	 <HLIGHT ,H-BOLD>
	 <TELL ,ALLPRAMS>
	 <HLIGHT ,H-NORMAL>
	 <SCREEN ,S-TEXT>
	 <SET X <INPUT 1>>
         <V-$REFRESH>
	 <V-LOOK>
	 <RTRUE>>

<ROUTINE I-CRANE-APPEARS ()
	 <COND (<NOT <HERE? ROUND-POND>>
		<RFALSE>)
	       (<IS? ,CRANE ,NODESC>     ; "Buys one move"
		<UNMAKE ,CRANE ,NODESC>
		<RFALSE>)
	       (T
		<DEQUEUE I-CRANE-APPEARS>
		<MOVE ,CRANE ,RPOND>
		<SETG P-IT-OBJECT ,CRANE>
		<TELL CR "One of the " D ,BOAT " on the " D ,RPOND
		      " catches your eye. The ">
		<SAY-WIND>
		<TELL
" blows it closer, and you realize that the white sails are actually wings. It's a folded " D ,CRANE ", floating just within reach." CR>
		<RTRUE>)>>

<GLOBAL LAYAWAY:NUMBER 3>

<ROUTINE I-BWOMAN ("AUX" (COIN? <>) (BAG? <>) (BOTH? <>))

	 <COND (<NOT <HERE? BROAD-WALK>>
		<RFALSE>)>

	 <SETG P-HER-OBJECT ,BWOMAN>
	 <COND (<T? ,RAID?>
		<COND (<IS? ,BWOMAN ,SEEN>
		       <UNMAKE ,BWOMAN ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<CRLF>
		<BWOMAN-CRY>
		<RTRUE>)>
	 <COND (<IN? ,SCOIN ,BWOMAN>
		<SETG P-IT-OBJECT ,COIN>
		<SET COIN? T>)>
	 <COND (<IN? ,BAG ,BWOMAN>
		<SETG P-IT-OBJECT ,BAG>
		<SET BAG? T>)>
	 <COND (<AND <ZERO? .BAG?>
		     <ZERO? .COIN?>>
		<COND (<IS? ,BWOMAN ,SEEN>
		       <UNMAKE ,BWOMAN ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<CRLF>
		<BWOMAN-CRY>
		<RTRUE>)
	       (<AND <T? .BAG?>
		     <T? .COIN?>>
		<SET BOTH? T>)>
	 <DEC LAYAWAY>
	 <COND (<ZERO? ,LAYAWAY>
		<MAKE ,BWOMAN ,SEEN>
		<TELL CR CTHE ,BWOMAN " shrugs and ">
		<COND (<OR <T? .BOTH?>
			   <T? .COIN?>>
		       <REMOVE ,SCOIN>
		       <COND (<T? .BAG?>
			      <REMOVE ,BAG>)>
		       <TELL "pockets your change">)
		      (T
		       <REMOVE ,BAG>
		       <TELL "puts your bag away">)>
		<TELL ". \"Keep ">
		<COND (<T? .BOTH?>
		       <TELL "'em">)
		      (T
		       <TELL "it">)>
		<TELL " myself,\" she mutters." CR>
		<RTRUE>)
	       (T
		<MAKE ,BWOMAN ,SEEN>
		<CRLF>
		<COND (<EQUAL? ,LAYAWAY 1>
		       <TELL CTHE ,BWOMAN " tugs your sleeve impatiently. ">)>
		<TELL "\"Take yer ">
		<COND (<AND <T? .COIN?>
			    <T? .BAG?>>
		       <TELL "bag and change">)
		      (<T? .BAG?>
		       <TELL "bag">)
		      (T
		       <TELL "change">)>
		<TELL ", guv'ner">
		<COND (<EQUAL? ,LAYAWAY 1>
		       <TELL "! Ain't got all day">)>
		<TELL "!\"" CR>)>
	 <RTRUE>>

<ROUTINE BWOMAN-CRY ("AUX" (X 0))
	 <COND (<T? ,RAID?>
		<SET X 1>)>
	 <MAKE ,BWOMAN ,SEEN>
	 <TELL "\"" <PICK-NEXT <GET ,BWOMAN-CRIES .X>> "!\"">
	 <COND (<PROB 50>
		<TELL <PICK-NEXT <GET ,BWOMAN-CRIES 2>> "s the " D ,BWOMAN>
		<PRINTC 46>)>
	 <CRLF>
	 <RTRUE>>

<GLOBAL BWOMAN-CRIES
	<PTABLE
	 <LTABLE 2
	 	 "Thirty p! Thirty p a bag"
		 "Feed the hungry birds"
	 	 "Thirty p for the starving birds"
	 	 "Thirty p"
	 	 "Feed the birds">
	 <LTABLE 2
	 	 "Sirens! The sirens"
	 	 "Lord, have mercy"
	 	 "What to do, what to do">
	 <LTABLE 2
		 " crie" " holler" " call" " yell">>>

<ROUTINE I-RUBY ("OPTIONAL" (CR T))
	 <COND (<IS? ,RUBY ,CHILLY>	 ; "1-move delay."
		<UNMAKE ,RUBY ,CHILLY>
		<RFALSE>)
	       (<NOT <VISIBLE? ,RUBY>>
		<RFALSE>)
	       (T
		<COND (<ZERO? .CR>
		       <TELL "As you start to move away ">)
		      (T
		       <TELL CR ,ALLATONCE>)>
		<MEEP-GETS-RUBY>
		<RTRUE>)>>

<GLOBAL RUBYROOM:OBJECT <>>

<ROUTINE MEEP-GETS-RUBY ()
	 <SETG RUBYROOM ,HERE>
	 <UNMAKE ,RUBY ,CHILLY>
	 <MAKE ,RUBY ,TOUCHED>
	 <DEQUEUE I-RUBY>
	 <QUEUE I-MEEP -1>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL "a very large bird races out ">
	 <COND (<HERE? WABE>
		<TELL "of the " D ,THICKET>)
	       (T
		<TELL "from behind a tree">)>
	 <TELL ". It ">
	 <COND (<IN? ,RUBY ,PRAM>
		<TELL "leaps into the open pram, ">)>
	 <TELL "snatches away the " D ,RUBY " with its beak">
	 <COND (<IN? ,RUBY ,PRAM>
		T)
	       (<NOT <HERE? WABE>>
		<TELL ", " <PICK-NEXT <GET ,MEEP-TABLE 0>>>)
	       (T
		<TELL ", scoots between your legs">)>
	 <MOVE ,RUBY ,MEEP>
	 <MOVE-MEEP>
	 <COND (<HERE? BROAD-WALK>
		<UNMAKE ,MEEP ,TOLD>
		<UNMAKE ,RUBY ,TOLD>
		<TELL CR "\"It's time!\" shrieks the " D ,BWOMAN ,PERIOD>)>
	 <COND (<IS? ,EWIND ,SEEN>
		<UNMAKE ,EWIND ,SEEN>
		<MAKE ,WWIND ,SEEN>
		<TELL CR CTHE ,EWIND
" softens to a whisper and dies away.|
|
Blowing leaves settle to the ground, and the trees are still. Then a fresh gust blows in from the west." CR>)>
	 <RTRUE>>

<ROUTINE I-MEEP ()
	 <COND (<NOT <IN? ,MEEP ,HERE>>
		<RFALSE>)>
	 <TELL CR
"The large bird you saw before is here! You catch a glimpse of the "
D ,RUBY " in its beak as it " <PICK-NEXT <GET ,MEEP-TABLE 0>>>
	 <MOVE-MEEP>
	 <RTRUE>>

<GLOBAL MEEP-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 "zigzags through a group of tourists"
	 	 "races between the wheels of a perambulator"
	 	 "dodges a startled nanny">
	 <PTABLE
		 <PTABLE BROAD-WALK "east" ROUND-POND>
		 <PTABLE ROUND-POND "east" LAN-WALK>
		 <PTABLE LION-GATE "southeast" ROUND-POND>
		 <PTABLE LAN-GATE "south" LAN-WALK>
		 <PTABLE PAL-GATE "east" FLOWER-WALK>
		 <PTABLE FLOWER-WALK "north" LAN-WALK>
		 <PTABLE AT-TERRACE "southeast" LAN-WALK>
		 <PTABLE WABE "northeast" LAN-WALK>
		 <PTABLE LONG-WATER "west" LAN-WALK>
		 <PTABLE IN-WATER "west" LAN-WALK>
		 0>
	 <LTABLE 2
		 "is eyeing you with interest"
		 "struts around the top of the toadstool"
		 "cocks its head to watch you"
		 "adjusts the ruby in its beak">
	 <LTABLE 2
	 	 "scampers around your feet"
	 	 "scratches impatiently on the ground"
	 	 "looks up at you inquisitively"
	 	 "emits a brief squawk"
		 "watches every move you make"
	 	 "scoots between your legs"
		 "is eyeing you with interest">
	 <LTABLE 2
		 "prance" "hop" "race" "strut">
	 <LTABLE 2
		 "cocks its head intelligently"
		 "listens intently"
		 "obviously understands you">
	 <LTABLE 2
		 "doesn't respond"
		 "decides to ignore you"
		 "chooses not to respond"
		 "pays you no heed">>>

<ROUTINE MOVE-MEEP ("AUX" (CNT 0) X TBL)
	 <PCLEAR>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL " and disappears to the ">
	 <COND (<HERE? LAN-WALK>
		<REMOVE ,MEEP>
		<TELL "east">)
	       (T
		<SET X <GET ,MEEP-TABLE 1>>
		<REPEAT ()
		 	<SET TBL <GET .X .CNT>>
		 	<COND ; (<ZERO? .TBL> ; "Delete when debugged."
				 <TELL "[BUG!]" CR>
				 <RTRUE>)
		       	      (<EQUAL? ,HERE <GET .TBL 0>>
			       <MOVE ,MEEP <GET .TBL 2>>
			       <TELL <GET .TBL 1>>
			       <RETURN>)>
		 	<INC CNT>>)>
	 <COND (<NOT <IS? ,TREE ,BORING>>
		<MAKE ,TREE ,BORING>
		<TELL
". If you didn't know better, you'd swear that bird was a " D ,MEEP>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE I-FMEEP ()
	 <COND (<NOT <HERE? ON-ISLE>>
		<RFALSE>)
	       (<IS? ,TS6-DOOR ,OPENED>
		<DEQUEUE I-FMEEP>
		<MEEP-TO-ZERO>
		<TELL CR ,CTHEMEEP
"gives you a curt nod of acknowledgement. Then it flutters off the " D ,TS6
", prances through the open door and disappears." CR>
		<RTRUE>)
	       (<IS? ,MEEP ,SEEN>
		<UNMAKE ,MEEP ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,MEEP ,SEEN>
	 <TELL CR ,CTHEMEEP <PICK-NEXT <GET ,MEEP-TABLE 2>> ,PERIOD>
	 <RTRUE>>

<GLOBAL RAID?:NUMBER 0>

<ROUTINE I-AIR-RAID ("AUX" (Q <>))
	 <COND (<ZERO? ,RAID?>
		<COND (<AND <EQUAL? ,MINUTES 57>
			    <EQUAL? ,SECONDS 45>>
		       <PUTP ,BWOMAN ,P?FDESC
"A forgotten woman, too aged to run, is sitting nearby.">
		       <SETG RAID? 10>)
		      (T
		       <RFALSE>)>)>
	 <COND (<HERE? WABE>
		<SET Q T>)>
	 <DEC RAID?>
	 <CRLF>
	 <COND (<EQUAL? ,RAID? 9>
		<MAKE ,TREE ,TOUCHED>
		<TELL "A steady drone begins to rise above the ">
		<SAY-WIND>
		<TELL
". As it grows louder and more insistent, you recognize a " D ,SOUND
" you've heard only in old war movies. Air-raid sirens." CR>
		<SETG DO-WINDOW <GET ,QUOTES ,THOREAU>>
		<RTRUE>)

	       (<EQUAL? ,RAID? 8>
		<TELL "Another siren joins the first">
		<COND (<ZERO? .Q>
		       <TELL
". Tourists search the sky, eyes wide with apprehension">)>
		<PRINT ,PERIOD>
		<COND (<AND <HERE? AT-TERRACE>
			    <IN? ,BOY ,HERE>>
		       <TELL CR "The boy slowly pulls his " D ,SPHONES
" off and glances furtively around. Then he picks up the dish and races off between the prams." CR>
		       <LAST-BUBBLE>)>
		<BOY-SCRAMS>
		<RTRUE>)

	       (<EQUAL? ,RAID? 7>
		<TELL "Sirens are howling all around you">
		<COND (<ZERO? .Q>
		       <TELL
". Children, sensing fear in the air, begin to whimper for their "
D ,NANNIES>)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 6>
		<TELL "Confused shouts can be heard in the distance">
		<COND (<ZERO? .Q>
		       <TELL ". Worried " D ,NANNIES " turn their " D ,GPRAM
			     " toward the gates">)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 5>
		<TELL
"Police and fire alarms join in the rising din">
		<COND (<ZERO? .Q>
		       <TELL
" as the crowd rushes to escape the open sky of the Gardens">)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 4>
		<TELL
"Distant megaphones can be heard barking orders">
		<COND (<ZERO? .Q>
		       <TELL ". Frightened " D ,TOURISTS
" and screaming " D ,GPRAM " flee in every " D ,INTDIR>)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 3>
		<TELL
"A round of gunfire drowns out the wailing " D ,SIRENS>
		<COND (<ZERO? .Q>
		       <TELL
". Tourists cover their heads and trample one another in blind panic">)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 2>
		<TELL CTHE ,GROUND
" trembles with the roar of jet interceptors">
		<COND (<ZERO? .Q>
		       <TELL
". Terror-stricken " D ,TOURISTS " dive for cover">)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,RAID? 1>
		<VAPORIZE-GARDENS>)>
	 <RTRUE>>

<ROUTINE VAPORIZE-GARDENS ()
	 <TELL "The ">
	 <SAY-WIND>
	 <TELL
" falls silent, and a new star flashes to life over the doomed city.">
	 <JIGS-UP>
	 <RTRUE>>

<GLOBAL HCNT:NUMBER 7>

<ROUTINE I-LONDON-HOLE ("OPTIONAL" (CR? T))
	 <DEC HCNT>
	 <COND (<NOT <HERE? LONG-WATER IN-WATER>>
		<RFALSE>)
	       (<T? .CR?>
		<CRLF>)>
	 <COND (<EQUAL? ,HCNT 6>
		<TELL CTHE ,WWIND " is still. Everything is very quiet." CR>
		<RTRUE>)

	       (<EQUAL? ,HCNT 5>
		<PUTP ,LONG-WATER ,P?OVERHEAD ,MISSILE>
		<PUTP ,IN-WATER ,P?OVERHEAD ,MISSILE>
		<MAKE ,MISSILE ,TOUCHED>
		<SETG P-IT-OBJECT ,MISSILE>
		<TELL
"A gleam overhead catches your eye.|
|
Oh, dear. A " D ,MISSILE " is hanging motionless in the sky." CR>
		<RTRUE>)

	       (<EQUAL? ,HCNT 4>
		<MAKE ,LWDOOR ,TOUCHED>
		<PUTP ,LONG-WATER ,P?SEE-E ,LWDOOR>
		<PUTP ,IN-WATER ,P?SEE-E ,LWDOOR>
		<SETG P-IT-OBJECT ,LWDOOR>
		<TELL CTHE ,MISSILE
" isn't completely motionless. It's falling very, very slowly towards the "
D ,LWATER ,PCR "Your eyes follow the " D ,MISSILE
"'s trajectory downward, where you notice another peculiar phenomenon. It looks like a "
D ,LWDOOR ", suspended just above the " D ,CSURFACE " of the water." CR>
		<RTRUE>)

	       (<EQUAL? ,HCNT 3>
		<TELL
"A flock of ravens glides into view! They circle over the "
D ,LWATER " and disappear through the open " D ,LWDOOR ,PCR CTHE ,MISSILE
" continues its slow descent." CR>
		<RTRUE>)

	       (<EQUAL? ,HCNT 2>
		<TELL "Swans and ducks paddle through the open "
D ,LWDOOR ", vanishing without a trace" ,PCR CTHE ,MISSILE
" is only a few dozen yards above the door." CR>
		<RTRUE>)

	       (<EQUAL? ,HCNT 1>
		<TELL
"A log is being pushed across the " D ,LWATER
" by a pair of mallards. Its " D ,CSURFACE
" is crowded with squirrels, chipmunks and other inhabitants of the "
D ,GARDENS ", including the " D ,MEEP " you met before">
		<ENTICINGLY>
		<TELL " as the log sails through the " D ,LWDOOR ,PCR
		      CTHE ,MISSILE " is closing in fast." CR>
		<RTRUE>)>

	 <TELL
CTHE ,MISSILE "'s nose nudges into the " D ,LWDOOR
". Then a searing glare envelops the "
D ,LWATER ", and you discover what it feels like to be vaporized in extreme slow motion.">
	 <JIGS-UP>
	 <RTRUE>>

<GLOBAL BREATH-HELD?:NUMBER 0>

<ROUTINE I-HOLD-BREATH ("OPTIONAL" (CR? T))
	 <DEC BREATH-HELD?>
	 <COND (<EQUAL? ,BREATH-HELD? 3 2>
		<RFALSE>)
	       (<T? .CR?>
		<CRLF>)>
	 <COND (<EQUAL? ,BREATH-HELD? 1>
		<TELL ,CANT "hold " D ,BREATH " much longer." CR>
		<RTRUE>)
	       (T
		<SETG BREATH-HELD? 0>
		<DEQUEUE I-HOLD-BREATH>
		<COND (<HERE? UNDER-WATER>
		       <TELL
"You claw your way to the " D ,CSURFACE " as " D ,BREATH " gives out" ,PCR>
		       <GOTO ,IN-CIST>)
		      (T
		       <TELL
"With an involuntary gasp, you begin to breathe normally." CR>)>)>
	 <RTRUE>>

<GLOBAL ODEG:NUMBER 6>
<GLOBAL OSIGN:NUMBER 0>
<GLOBAL IDEG:NUMBER 14>
<GLOBAL ISIGN:NUMBER 0>

<GLOBAL OROOMS:TABLE
	<PTABLE IN-MEADOW ON-HILL AT-FALLS BONEYARD
		OSSUARY PROM ON-MESA ON-BLUFF
		IN-GARDEN AT-CRATER ON-MOOR ON-BEACH ON-ISLE>>

<GLOBAL IROOMS:TABLE
	<PTABLE FCLEARING SBOG NBOG AT-CHASM UNDER-CLIFF
		AT-BEND DOCKSIDE DOCKSIDE>>

<GLOBAL OSIGN-DOORS:TABLE
	<PTABLE TS0-DOOR <> TS1-DOOR <> TS2-DOOR <> TS3-DOOR <>
		TS4-DOOR <> TS5-DOOR <> TS6-DOOR <>>>

<ROUTINE NEW-OSIGN (DOOR "OPTIONAL" (V T) "AUX" OLD)
	 <UNMAKE ,TS1-DOOR ,OPENED>
	 <UNMAKE ,TS2-DOOR ,OPENED>
	 <UNMAKE ,TS3-DOOR ,OPENED>
	 <UNMAKE ,TS4-DOOR ,OPENED>
	 <UNMAKE ,TS5-DOOR ,OPENED>
	 <UNMAKE ,TS6-DOOR ,OPENED>
	 <SET OLD ,OSIGN>
	 <SETG OSIGN .DOOR>
	 <SETG ODEG 5>
	 <SETG ISIGN </ ,OSIGN 2>>
	 <SETG IDEG 12>
	 <MOVE ,OUTER-SHADOW <GET ,OROOMS ,OSIGN>>
	 <MOVE ,INNER-SHADOW <GET ,IROOMS ,ISIGN>>
	 <SET DOOR <GET ,OSIGN-DOORS ,OSIGN>>
	 <COND (<AND <T? .DOOR>
		     <NOT <IS? .DOOR ,NOALL>>>
		<MAKE .DOOR ,OPENED>
		<COND (<EQUAL? .DOOR ,TS2-DOOR>
		       <MAKE ,TUN1 ,LIGHTED>)>)>
	 <RESET-SHDIRS>
	 <COND (<T? .V>
		<TELL "clicks into place at the dial's "
		      <GET ,SYMBOL-NAMES ,OSIGN> " symbol." CR>)>
	 <COND (<PRSI? LEFT RIGHT>
		<COND (<AND <G? .OLD 11>
		     	    <ZERO? ,OSIGN>>
		       <REPORT-SUNSET>
		       <RTRUE>)
	       	      (<AND <EQUAL? .OLD 0 1>
		     	    <G? ,OSIGN 11>>
		       <REPORT-SUNSET T>)>
		<RTRUE>)
	     ; (<PRSI? LEFT>
		<COND (<AND <G? .OLD 11>
		     	    <ZERO? ,OSIGN>>
		       <REPORT-SUNSET>
		       <RTRUE>)
	       	      (<AND <EQUAL? .OLD 0 1>
		     	    <G? ,OSIGN 11>>
		       <REPORT-SUNSET T>)>
		<RTRUE>)>
	 <RTRUE>>

"0 = shadow movement string, 1 = P? of shadow movement,
 2 = sun direction, 3 = shadow direction."

<GLOBAL SHDIRS <TABLE "north" P?NORTH "east" "west">>

<ROUTINE RESET-SHDIRS ("AUX" X Y Z Q)
	 <COND (<L? ,OSIGN 3>
		<SET X "north">
		<SET Y ,P?NORTH>
		<COND (<ZERO? ,FLIP?>
		       <SET Z "east">
		       <SET Q "west">)
		      (T
		       <SET Z "west">
		       <SET Q "east">)>)
	       (<L? ,OSIGN 5>
		<COND (<ZERO? ,FLIP?>
		       <SET X "northeast">
		       <SET Y ,P?NE>
		       <SET Z "southeast">
		       <SET Q "northwest">)
		      (T
		       <SET X "northwest">
		       <SET Y ,P?NW>
		       <SET Z "southwest">
		       <SET Q "northeast">)>)
	       (<L? ,OSIGN 8>
		<SET Z "south">
		<SET Q "north">
		<COND (<ZERO? ,FLIP?>
		       <SET X "east">
		       <SET Y ,P?EAST>)
		      (T
		       <SET X "west">
		       <SET Y ,P?WEST>)>)
	       (<L? ,OSIGN 10>
		<COND (<ZERO? ,FLIP?>
		       <SET X "southeast">
		       <SET Y ,P?NW>
		       <SET Z "southwest">
		       <SET Q "northeast">)
		      (T
		       <SET X "southwest">
		       <SET Y ,P?NE>
		       <SET Z "southeast">
		       <SET Q "northwest">)>)
	       (T
		<SET X "south">
	 	<SET Y ,P?SOUTH>
	 	<COND (<ZERO? ,FLIP?>
		       <SET Z "west">
		       <SET Q "east">)
		      (T
		       <SET Z "east">
		       <SET Q "west">)>)>
	 <PUT ,SHDIRS 0 .X>
	 <PUT ,SHDIRS 1 .Y>
	 <PUT ,SHDIRS 2 .Z>
	 <PUT ,SHDIRS 3 .Q>
	 <RTRUE>>

<ROUTINE I-SHADOW ("AUX" (V <>) (DOOR <>) (OHERE <>))
	 <COND (<ZERO? ,SUN-MOVING?>
		<RFALSE>)>

       ; "Handle outer shadow."

	 <INC ODEG>
	 <COND (<G? ,ODEG 12>
		<SETG ODEG 0>
		<INC OSIGN>
		<RESET-SHDIRS>
		<COND (<IN? ,OUTER-SHADOW ,HERE>
		       <INC V>
		       <SHADOW-GOES>)>
		<COND (<G? ,OSIGN 12>
		       <SETG OSIGN 0>
		       <SETG ODEG 0>
		       <SETG ISIGN 0>
		       <SETG IDEG 7>
		       <RESET-SHDIRS>
		       <MOVE ,OUTER-SHADOW ,IN-MEADOW>
		       <MOVE ,INNER-SHADOW ,FCLEARING>
		       <COND (<AND <IS? ,HERE ,SHADOWY>
				   <NOT <IS? ,HERE ,INDOORS>>>
			      <REPORT-SUNSET>
			      <COND (<HERE? IN-MEADOW FCLEARING>
				     <SHADOW-COMES>)>
			      <RTRUE>)>
		       <RETURN .V>)>
		<MOVE ,OUTER-SHADOW <GET ,OROOMS ,OSIGN>>
		<COND (<IN? ,OUTER-SHADOW ,HERE>
		       <INC V>
		       <SHADOW-COMES>)>)>

	 <SET DOOR <GET ,OSIGN-DOORS ,OSIGN>>
	 <COND (<AND <EQUAL? ,ODEG 5>
		     <T? .DOOR>
		     <HERE? ON-GNOMON>>
		<SET V T>
		<SETG P-IT-OBJECT ,RING>
		<TELL CR CTHE ,RING " on the " D ,BDIAL
		      " rotates with a sudden ">
		<ITALICIZE "click.">
		<CRLF>
	      ; <PRINT ,PERIOD>)>

       ; "Handle inner shadow."

	 <INC IDEG>
	 <COND (<G? ,IDEG 25>
		<SETG IDEG 0>
		<INC ISIGN>
		<COND (<IN? ,INNER-SHADOW ,HERE>
		       <INC V>
		       <SHADOW-GOES>)>
		<MOVE ,INNER-SHADOW <GET ,IROOMS ,ISIGN>>
		<COND (<IN? ,INNER-SHADOW ,HERE>
		       <INC V>
		       <SHADOW-COMES>)>)>

       ; "Handle doors."

	 <COND (<IN? ,OUTER-SHADOW ,HERE>
		<SET OHERE T>)>

	 <COND (<AND <EQUAL? ,ODEG 5>
		     <T? .DOOR>>
		<COND (<T? .OHERE>
		       <INC V>
		       <TELL CR
"The tip of the " D ,OUTER-SHADOW " touches the " D ,TS0 ,PERIOD>)>
		<COND (<NOT <IS? .DOOR ,NOALL>>
		       <MAKE .DOOR ,OPENED>
		       <COND (<EQUAL? .DOOR ,TS2-DOOR>
			      <MAKE ,TUN1 ,LIGHTED>)>
		       <COND (<T? .OHERE>
			      <TELL CR
"With a faint creak, the " D .DOOR " in the " D ,TS0 " swings open." CR>
			      <COND (<AND <HERE? ON-ISLE>
					  <IN? ,MEEP ,TS6>>
				     <I-FMEEP>)>
			      <RTRUE>)>)>
		<RETURN .V>)

	       (<AND <EQUAL? ,ODEG 6>
		     <T? .DOOR>
		     <T? .OHERE>>
		<SETG P-IT-OBJECT ,OUTER-SHADOW>
		<TELL CR CTHE ,OUTER-SHADOW <PICK-NEXT ,CREEPERS>
		      "across the " D ,TS0>
		<COND (<NOT <IS? .DOOR ,NOALL>>
		       <SETG P-IT-OBJECT .DOOR>
		       <TELL "'s open door">)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,ODEG 7>
		<COND (<T? .DOOR>
		       <UNMAKE .DOOR ,OPENED>
		       <COND (<EQUAL? .DOOR ,TS2-DOOR>
			      <UNMAKE ,TUN1 ,LIGHTED>)>
		       <COND (<HERE? IN-ORBIT ON-SAT PLAYGROUND ON-BIRD>
			      <RETURN .V>)
			     (<T? .OHERE>
			      <INC V>
			      <TELL CR
CTHE ,OUTER-SHADOW <PICK-NEXT ,CREEPERS> "away from the " D ,TS0>)>
		       <COND (<IS? .DOOR ,NOALL>
			      <COND (<T? .OHERE>
				     <PRINT ,PERIOD>)>
			      <RETURN .V>)
			     (<T? .OHERE>
			      <TELL ", and the ">)
			     (<GLOBAL-IN? .DOOR ,HERE>
			      <TELL CR "The ">)
			     (T
			      <RETURN .V>)>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL "door ">
		       <COND (<IS? ,HERE ,SHADOWY>
			      <TELL "in the stem ">)>
		       <TELL "swings shut with a faint creak">
		       <COND (<OR <EQUAL? .DOOR ,TS0-DOOR>
				  <NOT <IS? ,HERE ,SHADOWY>>>
			      <MAKE .DOOR ,NOALL>
			      <TELL
". You stare in wonder as the door shimmers and fades from view." CR>
			      <COND (<HERE? TUN1>
				     <SAY-IF-HERE-LIT>)>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<T? .OHERE>
		       <SHADOW-CREEPS>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (T
		       <RETURN .V>)>)

	       (<AND <IN? ,INNER-SHADOW ,HERE>
		     <ZERO? <MOD ,IDEG 5>>>
		<SETG P-IT-OBJECT ,INNER-SHADOW>
		<SHADOW-CREEPS>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<OR <AND <T? .OHERE>
			 <EQUAL? ,ODEG 11>>
		    <AND <IN? ,INNER-SHADOW ,HERE>
			 <EQUAL? ,IDEG 23>>>
		<SETG P-IT-OBJECT <COND (<ZERO? .OHERE>
					 ,INNER-SHADOW)
					(T
					 ,OUTER-SHADOW)>>
		<SHADOW-CREEPS>
		<TELL ". It's almost" ,OUTASITE>
		<RTRUE>)

	       (T
		<RETURN .V>)>>

<ROUTINE SHADOW-CREEPS ()
	 <SETG P-IT-OBJECT <COND (<IN? ,OUTER-SHADOW ,HERE>
				  ,OUTER-SHADOW)
	       			 (T
				  ,INNER-SHADOW)>>
	 <TELL CR CTHE ,OUTER-SHADOW <PICK-NEXT ,CREEPERS>>
	 <SHDIRWARD>
	 <RTRUE>>

<ROUTINE SHDIRWARD ()
	 <TELL <GET ,SHDIRS 0> "ward">
	 <RTRUE>>

<ROUTINE SHADOW-COMES ()
	 <SETG P-IT-OBJECT <COND (<IN? ,OUTER-SHADOW ,HERE>
				  ,OUTER-SHADOW)
	       			 (T
				  ,INNER-SHADOW)>>
	 <EDGE-OF>
	 <TELL A ,OUTER-SHADOW <PICK-NEXT ,CREEPERS> "into view." CR>
	 <RTRUE>>

<ROUTINE EDGE-OF ()
	 <TELL CR "The edge of ">
	 <RTRUE>>

<ROUTINE SHADOW-GOES ()
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <EDGE-OF>
	 <TELL THE ,OUTER-SHADOW " disappears ">
	 <SHDIRWARD>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<GLOBAL CREEPERS:TABLE
	<LTABLE 2 " inches " " creeps " " moves slowly ">>

<ROUTINE REPORT-SUNSET ("OPTIONAL" (BW <>))
	 <CRLF>
	 <COND (<NOT <IS? ,SUN ,TOUCHED>>
		<TELL "Shadows lengthen in the gathering dusk. ">)>
	 <TELL "You pause to watch as the sun touches the ">
	 <COND (<ZERO? .BW>
		<SAY-WEST>)
	       (T
		<SAY-EAST>)>
	 <TELL "ern " D ,HORIZON>
	 <COND (<IS? ,SUN ,TOUCHED>
		<TELL
" and sinks from view, while its mirror image rises in the ">
		<COND (<ZERO? .BW>
		       <SAY-EAST>)
		      (T
		       <SAY-WEST>)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <MAKE ,SUN ,TOUCHED>
	 <TELL
", painting the clouds with a fiery glow that spreads across the sky.|
|
Wait a minute.|
|
The sky is getting ">
	 <ITALICIZE "brighter.">
	 <TELL
" You rub your eyes and blink as the " D ,DMOUNTS " and " D ,TREETOPS
" magically emerge from darkness, suffused in a golden light swelling somewhere behind you...|
|
Another sun is rising! You turn east and west, gaping with astonishment as the twin orbs rise and set in perfect synchronization. For a moment, both are bisected by the " D ,HORIZON
", casting double " D ,DSHADOW "s that cross the ground in fantastic patterns. Then the ">
	 <COND (<ZERO? .BW>
		<SAY-WEST>)
	       (T
		<SAY-EAST>)>
	 <TELL "ern sun sinks from view, and the ">
	 <COND (<ZERO? .BW>
		<SAY-EAST>)
	       (T
		<SAY-WEST>)>
	 <TELL "ern sun rises to command the morning." CR>
	 <RTRUE>>

<ROUTINE I-DROP-OAK ()
	 <MAKE ,OAK ,TOUCHED>
	 <COND (<HERE? AT-CHASM>
		<TELL CR "With a leafy whoosh, the " D ,OAK
" topples away from the chasm and crashes to the ground." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL ORBCNT:NUMBER 0>

<ROUTINE I-ORBIT ("AUX" (ON? <>) (MAG? <>) (DOOR <>))
	 <COND (<AND <HERE? ON-SAT>
		     <T? ,SUITED?>>
		<SET ON? T>
		<COND (<AND <IS? ,TS1-DOOR ,OPENED>
			    <NOT <IS? ,TS1-DOOR ,NOALL>>>
		       <SET DOOR T>)>)>
	 <COND (<GOT? ,LUMP>
		<SET MAG? T>)>
	 <INC ORBCNT>
	 <CRLF>
	 <COND (<EQUAL? ,ORBCNT 1>
	   	<COND (<T? ,SUITED?>
		       <TELL CTHE ,FILM
" around you freezes instantly, but remains intact" ,PCR>)>
		<TELL CTHE ,TS1-DOOR " drops away behind you." CR>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 2>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		<TELL "You watch helplessly as the " D ,TS1-DOOR
" dwindles to a distant speck, vanishing at last between the horns of the rising moon." CR>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 3>
		<MAKE ,XRAY ,TOUCHED>
		<SETG P-IT-OBJECT ,XRAY>
		<TELL "Far ahead, a " D ,XRAY " drifts into view." CR>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 4>
		<TELL CTHE ,XRAY " drifts closer." CR>
		<COND (<T? .MAG?>
		       <TELL CR "You feel the " D ,LUMP
" tug in your arms. It's pulling you towards the " D ,XRAY "!" CR>)>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 5>
		<COND (<T? .MAG?>
		       <MOVE ,LUMP ,ON-SAT>
		       <MAKE ,LUMP ,NODESC>
		       <UNMAKE ,LUMP ,TAKEABLE>
		       <MAKE ,LUMP ,TRYTAKE>
		       <TELL CTHE ,LUMP
" twists in your arms as the " D ,XRAY " glides past. ">
		       <COND (<ZERO? ,SUITED?>
			      <TELL "It">
			      <CLANGS>
			      <TELL "just out of reach">)
			     (T
			      <SET ON? T>
		       	      <SETG HERE ,ON-SAT>
		       	      <MOVE ,PLAYER ,HERE>
		       	      <SETG OLD-HERE <>>
		       	      <TELL "You find " D ,ME
" being yanked out of your old trajectory, into what is obviously a collision course" ,PCR>
		       	      <ITALICIZE "Ploop!">
		       	      <TELL " The " D ,FILM
" bounces against the " D ,XRAY ,PTHE D ,LUMP>
			      <CLANGS>
			      <TELL "anchoring the film securely">)>
		       <TELL ,PCR>
		       <VOICE-MUTTERS "Where gnomon has gone before">)>
		<TELL CTHE ,XRAY>
		<COND (<ZERO? .ON?>
		       <SETG P-IT-OBJECT ,XRAY>
		       <TELL " begins to drift away." CR>
		       <RTRUE>)>
		<SETG P-THEM-OBJECT ,THRUSTERS>
		<TELL "'s " D ,THRUSTERS
" fire briefly to compensate for your added momentum." CR>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 6>
		<TELL CTHE ,XRAY " drifts ">
		<COND (<ZERO? .ON?>
		       <TELL "farther ">)>
		<TELL "back in the " D ,INTDIR " you just came from." CR>
		<COND (<T? .DOOR>
		       <SETG P-IT-OBJECT ,TS1-DOOR>
		       <TELL CR CTHE ,TS1-DOOR
			    " reappears far ahead of you." CR>)>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 7>
		<SETG P-IT-OBJECT ,ICBM>
		<MAKE ,ICBM ,TOUCHED>
		<TELL
"A red flash draws your eyes to the ground below, where the contrail of a "
D ,ICBM " is climbing into the stratosphere." CR>
		<COND (<T? .DOOR>
		       <TELL CR CTHE ,XRAY
			     " is heading straight for the "
			     D ,TS1-DOOR ,PERIOD>)>
		<RTRUE>)

	       (<EQUAL? ,ORBCNT 8>
		<TELL CTHE ,THRUSTERS " on the ">
		<COND (<ZERO? .ON?>
		       <TELL "distant ">)>
		<TELL D ,XRAY
" fire, turning the nose until it faces the ascending " D ,ICBM ,PERIOD>
		<COND (<T? .DOOR>
		       <SETG P-IT-OBJECT ,TS1-DOOR>
		       <TELL CR CTHE ,TS1-DOOR
			    " is very close now." CR>)>
		<RTRUE>)>
	 <TELL CTHE ,XRAY
" erupts in a savage glare that lights up the ground below">
	 <STAR-WARS>
	 <RTRUE>>

<ROUTINE STAR-WARS ()
	 <TELL
,PA "beam of violet radiation flashes downward, obliterating the distant "
D ,ICBM
". Unfortunately, you have little time to admire this triumph of engineering before the " D ,XRAY "'s blast incinerates you.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE CLANGS ()
	 <TELL
" leaps from your grasp and fastens itself to the metal hull, ">
	 <RTRUE>>

<GLOBAL BACTION:NUMBER 0>

"0 = giant dips stick, 1 = blows bubble, 2 = listens to music."

<ROUTINE I-BUBBLES ()
	 <COND (<AND <HERE? NBOG AT-CHASM>
		     <PROB 20>>
		<TELL CR "A " D ,SBUBBLE
" appears high overhead. It hovers for a moment before it">
		<SAY-POP>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<NOT <HERE? PROM>>
		<SETG BACTION 0>
		<RFALSE>)
	       (<ZERO? ,BACTION>
		<CRLF>
		<BOY-DIPS>
		<COND (<T? ,IN-DISH?>
		       <SETG IN-DISH? <>>
		       <SETG OLD-HERE <>>
		       <SETG SUITED? ,SUIT-LIFE>
		       <SETG BACTION 1> ; "So BOY-BLOWS can set to 2."
		       <QUEUE I-BUBBLE-SUIT -1>
		       <TELL
". Trapped in a whirlpool of suds, you cling helplessly to the boy's wand"
,PCR>
		       <BOY-BLOWS-BUBBLE>
		       <TELL ". You find " D ,ME
" slowly drifting to the ground, enveloped in a " D ,FILM
			     " of iridescent color">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,BACTION 1>
		<CRLF>
		<BOY-BLOWS-BUBBLE>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<CRLF>
		<BOY-WAITS>)>
	 <RTRUE>>

<ROUTINE I-BOY ("OPTIONAL" (CR T))
	 <COND (<NOT <HERE? AT-TERRACE>>
		<SETG BACTION 0>
		<RFALSE>)
	       (<T? .CR>
		<CRLF>)>
	 <COND (<ZERO? ,BACTION>
		<BOY-DIPS>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,BACTION 1>
		<BOY-BLOWS-BUBBLE>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<BOY-WAITS>)>
	 <RTRUE>>

<ROUTINE BOY-DIPS ()
	 <INC BACTION>
	 <TELL CTHE ,GIANT " dips the " D ,WAND
	       " in the dish and swishes it around">
	 <RTRUE>>

<ROUTINE BOY-BLOWS-BUBBLE ()
	 <INC BACTION>
	 <UNMAKE ,HERE ,NOALL>
	 <TELL CTHE ,GIANT " pulls the " D ,WAND
" out of the dish, puts it to his lips and blows a big " D ,SBUBBLE>
	 <RTRUE>>

<ROUTINE BOY-WAITS ()
	 <SAY-BOY-BOPS>
	 <MAKE ,HERE ,NOALL>
	 <COND (<T? ,SUITED?>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <TELL " as the " D ,SBUBBLE>
	 <COND (<NOT <IS? ,BOY ,SEEN>>
		<MAKE ,BOY ,SEEN>
		<SAY-POP>
		<PRINT ,PERIOD>
		<SETG DO-WINDOW <GET ,QUOTES ,POPE>>
		<RTRUE>)
	       (<PROB 50>
		<TELL " floats away." CR>
		<RTRUE>)
	       (T
		<SAY-POP>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<ROUTINE SAY-POP ()
	 <TELL " bursts with a flabby ">
	 <HLIGHT ,H-ITALIC>
	 <TELL "pop">
	 <HLIGHT ,H-NORMAL>
	 <RTRUE>>

<ROUTINE SAY-BOY-BOPS ()
	 <COND (<EQUAL? ,BACTION 2>
		<SETG BACTION 0>)>
	 <TELL CTHE ,GIANT <PICK-NEXT ,BOY-BOPS> " to the headphone music">
	 <RTRUE>>

<GLOBAL BOY-BOPS:TABLE
	<LTABLE 2
	" snaps his fingers"
	" bobs his head"
	" kicks his feet"
	" hums softly">>

<GLOBAL VACUUM:NUMBER 3>

<ROUTINE I-VACUUM ("AUX" (X <>))
	 <COND (<T? ,SUITED?>
		<RFALSE>)>
	 <DEC VACUUM>
	 <COND (<VISIBLE? ,CAGE>
		<COND (<IN? ,LEM ,CAGE>
		       <SET X ,LEM>)
		      (<IN? ,MAGPIE ,CAGE>
		       <SET X ,MAGPIE>)>)>
	 <COND (<EQUAL? ,VACUUM 2>
		<ICE-VAC>
		<TELL CR
"The total lack of air pressure is making you uncomfortable">
		<COND (<T? .X>
		       <TELL ,PTHE D .X
			     " isn't looking too happy, either">)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <CRLF>
	 <COND (<EQUAL? ,VACUUM 1>
		<TELL "Hmm. It seems that your blood is beginning to boil">
		<COND (<T? .X>
		       <TELL ". So is the " D .X
			     "'s, from the look of it">)>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <TELL
"You lose consciousness just as your internal organs begin to rupture.">
	 <JIGS-UP>
	 <RTRUE>>

<GLOBAL SUITED?:NUMBER 0>
<CONSTANT SUIT-LIFE 4>

<ROUTINE I-BUBBLE-SUIT ("OPTIONAL" (CR? T))
	 <COND (<HERE? IN-ORBIT ON-SAT IN-SKY>
		<RFALSE>)
	       (<T? .CR?>
		<CRLF>)>
	 <DEC SUITED?>
	 <TELL CTHE ,FILM " around you">
	 <COND (<EQUAL? ,SUITED? 3>
		<TELL " shimmers with iridescent color." CR>
		<RTRUE>)
	       (<EQUAL? ,SUITED? 2>
		<TELL " is sagging a bit." CR>
		<RTRUE>)
	       (<EQUAL? ,SUITED? 1>
		<TELL " won't hold up much longer." CR>
		<RTRUE>)
	       (T
		<POP-BUBBLE-SUIT>
		<SAY-POP>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<GLOBAL ILIFE:NUMBER 6>

<ROUTINE I-ICE ("AUX" (SEE 0) (GOT 0))
	 <COND (<VISIBLE? ,ICE>
		<INC SEE>
		<COND (<GOT? ,ICE>
		       <INC GOT>)>)>
	 <COND (<OR <AND <HERE? IN-ORBIT ON-SAT>
			 <ZERO? ,SUITED?>>
		    <CHILLY? ,ICE>>
		<COND (<EQUAL? ,ILIFE 6>
		       <RFALSE>)>
		<SETG ILIFE 6>
		<COND (<T? .SEE>
		       <ICE-HARDENS-IN>
		       <COND (<HERE? ON-GNOMON>
			      <TELL "thin, ">)>
		       <TELL "frosty air." CR>
		       <RTRUE>)>
		<RFALSE>)>
	 <DEC ILIFE>
	 <COND (<ZERO? ,ILIFE>
		<REMOVE-ICE>
		<COND (<T? .SEE>
		       <TELL CR "The ">
		       <COND (<T? .GOT>
			      <TELL "melting ">)>
		       <TELL D ,ICE>
		       <COND (<ZERO? .GOT>
			      <TELL
" slowly melts away. Soon there's nothing left of it." CR>
			      <RTRUE>)>
		       <TELL " slips from your grasp and ">
		     ; <COND (<T? ,SUITED?>
			      <POP-BUBBLE-SUIT>
			      <TELL "slices through the " D ,FILM ". ">
			      <ITALICIZE "Pop!">
			      <TELL " Then the crystal ">)>
		       <COND (<HERE? IN-ORBIT ON-SAT IN-SKY>
			      <TELL "tumbles" ,OUTASITE>
			      <RTRUE>)
			     (<AND <HERE? PROM>
				   <T? ,IN-DISH?>>
			      <TELL "disappears in the water." CR>
			      <RTRUE>)>
		       <TELL "shatters to bits at your feet." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<ZERO? .SEE>
		<RFALSE>)
	       (<EQUAL? ,ILIFE 3>
		<TELL CR "The warm air makes the " D ,ICE " glisten." CR>
		<RTRUE>)
	       (<EQUAL? ,ILIFE 2>
		<CRLF>
		<COND (<ZERO? .GOT>
		       <TELL "It looks as if the " D ,ICE
			     " is starting to melt." CR>
		       <RTRUE>)>
		<TELL
"It's getting hard to hold the slippery " D ,ICE ,PERIOD>
		<RTRUE>)
	       (<EQUAL? ,ILIFE 1>
		<TELL CR CTHE ,ICE " is ">
		<COND (<ZERO? .GOT>
		       <TELL "melting away as you watch." CR>
		       <RTRUE>)>
		<TELL "almost too slippery to hold." CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE ICE-VAC ()
	 <COND (<NOT <IN? ,ICE ,PLAYER>>
		<RFALSE>)>
	 <SETG ILIFE 6>
	 <ICE-HARDENS-IN>
	 <TELL "sudden vacuum." CR>
	 <RTRUE>>

<ROUTINE ICE-HARDENS-IN ()
	 <TELL CR CTHE ,ICE " hardens in the ">
	 <RTRUE>>

<ROUTINE CHILLY? (OBJ "AUX" L)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,LOCAL-GLOBALS ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<OR <AND <IN? .L ,ROOMS>
			 <IS? .L ,CHILLY>>
		    <CHILLY? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-LEM ("OPTIONAL" (CR T) "AUX" L)
	 <COND (<T? ,QUIET?>
		<RFALSE>)>
	 <SET L <LOC ,LEM>>
	 <COND (<OR <ZERO? .L>
		    <NOT <VISIBLE? ,LEM>>>
		<UNMAKE ,LEM ,SEEN>
		<MAKE ,LEM ,CHILLY>
		<RFALSE>)
	       (<EQUAL? .L ,PLAYER>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<IS? ,LEM ,CHILLY>
		       <UNMAKE ,LEM ,CHILLY>
		       <MAKE ,LEM ,SEEN>
		       <TELL ,CTHELEM
"squirms violently in " D ,HANDS ,PERIOD>
		       <RTRUE>)>
		<TELL "With a desperate lurch, the " D ,LEM
		      " wiggles from your grasp and ">
		<COND (<ZERO? ,LIT?>
		       <TELL "falls with a ">)>
		<FREE-LEM>
		<RTRUE>)
	       (<EQUAL? .L ,FISSURE>
		<MAKE ,LEM ,CHILLY>
		<COND (<ZERO? .CR>
		       T)
		      (<IS? ,LEM ,SEEN>
		       <UNMAKE ,LEM ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<COND (<T? .CR>
		       <CRLF>)>
		<MAKE ,LEM ,SEEN>
		<TELL ,CTHELEM <PICK-NEXT <GET ,RAT-TABLE 2>> ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .L ,IN-CLOSET>
		<MAKE ,LEM ,CHILLY>
		<COND (<IS? ,CLOSET-DOOR ,OPENED>
		       <EXIT-LEM>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL ,CTHELEM>
		       <SNAKE-LUNCH>
		       <RTRUE>)
		      (<ZERO? .CR>
		       T)
		      (<IS? ,LEM ,SEEN>
		       <UNMAKE ,LEM ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)
		      (T
		       <CRLF>)>
		<COND (<ZERO? ,LIT?>
		       <TELL <PICK-NEXT <GET ,SKINK-TABLE 1>> ,PERIOD>
		       <RTRUE>)>
		<TELL ,CTHELEM <PICK-NEXT <GET ,RAT-TABLE 3>> ,PERIOD>
		<RTRUE>)
	       (<EQUAL? .L ,CAGE>
		<MAKE ,LEM ,CHILLY>
		<COND (<IS? .L ,OPENED>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <COND (<ZERO? ,LIT?>
			      <TELL "You hear the ">)
			     (T
			      <TELL "The ">)>
		       <TELL D ,LEM>
		       <COND (<SEE-SNAKE?>
			      <MAKE ,LEM ,FLIPPED>
			      <MAKE ,LEM ,SEEN>
			      <UNMAKE ,LEM ,TOUCHED>
			      <TELL
" cowers in the cage, trembling violently." CR>
			      <RTRUE>)
			     (<IS? ,LEM ,TOUCHED>
			      <UNMAKE ,LEM ,TOUCHED>
			      <MAKE ,LEM ,SEEN>
			      <TELL " scamper">
			      <COND (<ZERO? ,LIT?>
				     <TELL "ing">)
				    (T
				     <TELL "s">)>
			      <TELL " uneasily around the cage." CR>
			      <RTRUE>)
			     (T
			      <TELL " scramble">
			      <COND (<T? ,LIT?>
				     <TELL "s">)>
			      <TELL " out of the cage and ">
			      <FREE-LEM>)>
		       <RTRUE>)
		      (<SEE-SNAKE?>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <MAKE ,LEM ,SEEN>
		       <TELL ,CTHELEM>
		       <COND (<NOT <IS? ,LEM ,FLIPPED>>
			      <MAKE ,LEM ,FLIPPED>
			      <TELL "sees the " D ,SNAKE
				    " and begins to tremble." CR>
			      <RTRUE>)>
		       <TELL <PICK-NEXT <GET ,RAT-TABLE 3>> ,PERIOD>
		       <RTRUE>)
		      (<IS? ,LEM ,SEEN>
		       <UNMAKE ,LEM ,SEEN>
		       <RFALSE>)
		      (<OR <ZERO? .CR>
			   <PROB 25>>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <COND (<ZERO? ,LIT?>
			      <HEAR-LEM-IN ,CAGE>
			      <RTRUE>)>
		       <MAKE ,LEM ,SEEN>
		       <TELL ,CTHELEM "in the cage "
			     <PICK-NEXT <GET ,RAT-TABLE 2>> ,PERIOD>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<COND (<T? .CR>
		       <CRLF>)>
		<MAKE ,LEM ,SEEN>
		<TELL ,CTHELEM>
		<COND (<AND <IS? .L ,CONTAINER>
			    <IS? .L ,OPENED>>
		       <TELL "leaps out of " THE .L " and ">)
		      (<IS? .L ,SURFACE>
		       <TELL "leaps off " THE .L " and ">)>
		<FREE-LEM>
		<RTRUE>)
	     ; (T
		<MAKE ,LEM ,CHILLY>
		<RFALSE>)>>

<ROUTINE SNAKE-LUNCH ()
	 <TELL "scrambles through the open " D ,CLOSET-DOOR
", straight into the fangs of the " D ,SNAKE ,PCR CTHE ,LEM
" twitches for a while as the venom takes effect. Then the snake drags its prize across the floor, shakes its tail once for effect">
	 <SNAKE-LEAVES>
	 <EXIT-LEM>
	 <UPDATE-SCORE 3>
	 <RTRUE>>

<GLOBAL RAT-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 " race between your legs"
	 	 " swarm across the tundra"
	 	 " scurry over your feet"
	 	 " show no sign of stopping">
	 <LTABLE 2
	 	 " scratching "
		 " pacing "
		 " moving "
		 " scrambling "
		 " sniffing ">
	 <LTABLE 2
	 	 "sniffs the air inquisitively"
		 "trembles with agitation"
		 "scratches its ear"
		 "peers around nervously"
		 "washes its face with its paws"
		 "blinks at you">
	 <LTABLE 2
	 	 "covers its face with its paws and trembles"
	 	 "emits a squeak of terror"
		 "shivers with fear">>>

<ROUTINE HEAR-LEM-IN (THING)
	 <MAKE ,LEM ,SEEN>
	 <TELL "You can hear the " D ,LEM <PICK-NEXT <GET ,RAT-TABLE 1>>
	       " about in " THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE FREE-LEM ()
	 <MAKE ,LEM ,CHILLY>
	 <MAKE ,LEM ,SEEN>
	 <COND (<T? ,SUITED?>
		<COND (<NOT <IN? ,LEM ,PLAYER>>
		       <MOVE ,LEM ,PLAYER>)>
		<SETG P-IT-OBJECT ,LEM>
		<BOUNCES-IN-FILM ,LEM>
		<RTRUE>)
	       (<HERE? CLIFF-EDGE TOWER-PLAT ON-TOWER>
		<EXIT-LEM>
		<TELL "flings itself joyfully off the ">
		<COND (<HERE? CLIFF-EDGE>
		       <TELL D ,TCLIFF>)
		      (T
		       <MOVE ,DLEM ,AT-ZERO>
		       <MAKE ,DLEM ,NOGRASS>
		       <TELL D ,TOWER>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <HERE? IN-ORBIT ON-SAT>
		     <ZERO? ,SUITED?>>
		<EXIT-LEM>
		<TELL "tumbles slowly" ,OUTASITE>
		<RTRUE>)
	       (<HERE? IN-CLOSET>
	      ; <MAKE ,LEM ,NODESC>
		<MOVE ,LEM ,HERE>
		<TELL "plop">
		<COND (<T? ,LIT?>
		       <TELL "s">)>
		<TELL " to the " D ,FLOOR>
		<COND (<IS? ,CLOSET-DOOR ,OPENED>
		       <TELL ". Then it ">
		       <SNAKE-LUNCH>
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<UNMAKE ,LEM ,SEEN>
		<RTRUE>)
	       (<HERE? IN-GARDEN>
		<COND (<AND <IS? ,TS4-DOOR ,OPENED>
			    <NOT <IS? ,TS4-DOOR ,NOALL>>>
		       <EXIT-LEM>
		       <TELL "scurries through the open "
			     D ,TS4-DOOR ,PERIOD>
		       <RTRUE>)>
		<OUT-THE-DOOR ,GARDEN-DOOR>
		<COND (<NOT <IS? ,COTTAGE-DOOR ,OPENED>>
		       <MAKE ,COTTAGE-DOOR ,OPENED>
		       <TELL CR "You hear a faint creak in the "
			     D ,COTTAGE ,PERIOD>)>
		<RTRUE>)
	       (<HERE? SEROOM>
		<TELL
"races" ,TON " exit. It skids to a stop at the threshold, flips over and ">
		<OUT-THE-DOOR ,SEROOM-DOOR>
		<RTRUE>)
	       (<HERE? SWROOM>
		<OUT-THE-DOOR ,SWROOM-DOOR>
		<RTRUE>)
	       (<HERE? NROOM>
		<OUT-THE-DOOR ,NROOM-DOOR>
		<RTRUE>)
	       (<HERE? BROOM>
		<OUT-THE-DOOR ,BROOM-DOOR>
		<RTRUE>)
	       (<HERE? NWROOM>
		<SCAMPER-OFF-TO "north">
		<RTRUE>)
	       (<HERE? IN-BATH>
		<SCAMPER-OFF-TO "south">
		<RTRUE>)
	       (<HERE? IN-COTTAGE>
		<OUT-THE-DOOR ,COTTAGE-DOOR>
		<RTRUE>)
	       (<HERE? IN-MILL>
		<EXIT-LEM>
		<MOVE ,DLEM ,UNDER-WATER>
		<MAKE ,DLEM ,CHILLY>
		<TELL "leaps over the " D ,LANDING "'s edge.|
|
A moment later, you hear a faint splash." CR>
		<RTRUE>)
	       (<HERE? IN-SHACK>
		<MOVE ,DLEM ,AT-ZERO>
		<MAKE ,DLEM ,NOGRASS>)>
	 <EXIT-LEM>
	 <TELL "scurries" ,OUTASITE>
	 <RTRUE>>

<ROUTINE SCAMPER-OFF-TO (DIR)
	 <EXIT-LEM>
	 <TELL "scurries off to the " .DIR>
	 <COND (<NOT <IS? ,NROOM-DOOR ,OPENED>>
		<MAKE ,NROOM-DOOR ,OPENED>
		<TELL ", where you hear a faint creak">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE OUT-THE-DOOR (DOOR)
	 <EXIT-LEM>
	 <COND (<IS? .DOOR ,OPENED>
		<TELL "scurries out the open " D .DOOR ,PERIOD>
		<RTRUE>)>
	 <MAKE .DOOR ,OPENED>
	 <TELL "nudges open the " D .DOOR ". Then it scurries" ,OUTASITE>
	 <RTRUE>>

<ROUTINE EXIT-LEM ()
	 <DEQUEUE I-LEM>
	 <VANISH ,LEM>
	 <RTRUE>>

<ROUTINE I-RODENTS ("OPTIONAL" (CR T))
	 <COND (<HERE? ON-PLATFORM>
		<UNMAKE ,RODENTS ,SEEN>
		<RFALSE>)
	       (<IS? ,RODENTS ,TOUCHED>
		<UNMAKE ,RODENTS ,TOUCHED>
		<MAKE ,RODENTS ,SEEN>
		<SETG P-THEM-OBJECT ,RATS>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL
"Something touches your sneaker.|
|
You kick it away with a shout. A rodent sails through the air, lands unharmed and scrambles" ,OUTASITE>
		<RTRUE>)
	       (<IS? ,RODENTS ,CHILLY>
		<UNMAKE ,RODENTS ,CHILLY>
		<MAKE ,RODENTS ,SEEN>
		<SETG P-THEM-OBJECT ,RATS>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL CTHE ,GROUND
" is covered with " D ,RATS "! They're racing ">
		<COND (<HERE? ATUN BTUN>
		       <TELL "east">)
		      (T
		       <TELL "north">
		       <COND (<NOT <HERE? ETUN HTUN>>
			      <TELL "east">)>)>
		<TELL
", oblivious to you or anything else in their path." CR>
		<RTRUE>)
	       (<ZERO? .CR>
		T)
	       (<IS? ,RODENTS ,SEEN>
		<UNMAKE ,RODENTS ,SEEN>
		<RFALSE>)
	       (<PROB 30>
		<RFALSE>)
	       (T
		<CRLF>)>
	 <SETG P-THEM-OBJECT ,RATS>
	 <MAKE ,RODENTS ,SEEN>
	 <TELL CTHE ,RATS <PICK-NEXT <GET ,RAT-TABLE 0>> ,PERIOD>
	 <RTRUE>>

<ROUTINE I-METEOR ()
	 <CRLF>
	 <COND (<IS? ,METEOR ,NOALL>
		<UNMAKE ,METEOR ,NOALL>
		<SETG P-IT-OBJECT ,METEOR>
		<TELL
"A glare lights up the sky! You look up just in time to see a " D ,METEOR
" streak overhead." CR>
		<RTRUE>)
	       (T
		<MAKE ,METEOR ,SEEN>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		<DEQUEUE I-METEOR>
		<TELL CTHE ,METEOR
" disappears below the " D ,HORIZON ,PCR
"You feel the ground shudder, and hear a roar like thunder">
		<ALL-IS-STILL>
		<RTRUE>)>>

<ROUTINE I-MAGPIE ("OPTIONAL" (CR T) "AUX" X CNT)
	 <COND (<OR <T? ,QUIET?>
		    <ZERO? ,LIT?>>
		<RFALSE>)
	     ; (<AND <IN? ,MAGPIE ,CAGE>
		     <IS? ,CAGE ,OPENED>
		     <T? ,LIT?>>
		<MAGPIE-SCRAMS>
		<RTRUE>)
	       (<VISIBLE? ,MAGPIE>
		<COND (<ZERO? .CR>
		       T)
		      (<IS? ,MAGPIE ,SEEN>
		       <UNMAKE ,MAGPIE ,SEEN>
		       <RFALSE>)
		      (<PROB 30>
		       <RFALSE>)
		      (T
		       <CRLF>)>
		<MAKE ,MAGPIE ,SEEN>
		<COND (<PROB 30>
		       <TELL CTHE ,MAGPIE <PICK-NEXT <GET ,PIE-TABLE 2>>
			     ,PERIOD>
		       <RTRUE>)>
		<COND (<PROB 30>
		       <SET X T>
		       <TELL CTHE ,MAGPIE <PICK-NEXT <GET ,PIE-TABLE 0>>
			     "s, ">)>
		<PRINTC 34>
		<COND (<PROB 50>
		       <TELL "Awk! ">)>
		<COND (<OR <ZERO? ,INLEN>
			   <VERB? WAIT WAIT-FOR LISTEN>
			   <PROB 50>>
		       <TELL <PICK-NEXT <GET ,PIE-TABLE 1>>>)
		      (T
		       <PRINT-SENTENCE>)>
		<COND (<OR <T? .X>
			   <PROB 50>>
		       <TELL ".">
		       <COND (<PROB 50>
			      <TELL " Awk!">)>
		       <TELL "\"" CR>
		       <RTRUE>)>
		<COND (<PROB 50>
		       <TELL ". Awk!">)
		      (T
		       <TELL ",">)>
		<TELL "\"" <PICK-NEXT <GET ,PIE-TABLE 0>>
		      "s the " D ,MAGPIE ,PERIOD>
		<RTRUE>)
	       (T
		<UNMAKE ,MAGPIE ,SEEN>
		<RFALSE>)>>

<ROUTINE EXIT-MAGPIE ()
	 <DEQUEUE I-MAGPIE>
	 <VANISH ,MAGPIE>
	 <RTRUE>>

<GLOBAL PIE-TABLE:TABLE
	<PTABLE
	 <LTABLE 2 " croak" " squawk" " screeche" " say" " mutter">
	 <LTABLE 2
	 	 "Milk and honey"
	 	 "Milk and honey, fresh whole lizard"
	 	 "Fresh whole lizard"
	 	 "Killed in the light of a crescent moon"
	 	 "Crescent moon"
	 	 "Mix 'em with a pinch o' garlic"
	 	 "Then stand back! 'Cause it go BOOM"
	 	 "It go BOOM">
	 <LTABLE 2
		 " blinks at you"
		 " makes a croaking sound"
		 " wiggles its head"
		 " whistles"
		 " ruffles its feathers"
		 " scratches an itchy wing"
		 " eyes you suspiciously"
		 " cranes its neck"
		 " beats its wings"
		 " sharpens its beak">>>

<ROUTINE I-JAWS ("AUX" (X <>))
	 <DEC JAW-TIME>
	 <COND (<ZERO? ,JAW-TIME>
		<DEQUEUE I-JAWS>
		<MAKE ,TRAP ,OPENED>
		<REMOVE ,ICHOR>
		<SET X <FIRST? ,TRAP>>
		<COND (<T? .X>
		       <COND (<EQUAL? .X ,CAGE>
			      <COND (<IN? ,LEM .X>
				     <REMOVE ,LEM>)
				    (<IN? ,MAGPIE .X>
				     <REMOVE ,MAGPIE>)>)>
		       <MOVE .X ,NBOG>)>
		<MOVE ,ICHOR ,TRAP>
		<COND (<HERE? NBOG>
		       <TELL CR "The jaws of the " D ,TRAP " slowly reopen">
		       <COND (<T? .X>
			      <TELL ", and " THE .X " fall">
			      <COND (<NOT <IS? .X ,PLURAL>>
				     <TELL "s">)>
			      <TELL " out onto the ground">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<ROUTINE I-BEE ()
	 <COND (<NOT <IN? ,BEE ,HERE>>
		<MAKE ,BEE ,TOUCHED>
		<COND (<AND <IS? ,HERE ,SHADOWY>
			    <NOT <IS? ,HERE ,INDOORS>>>
		       <MOVE ,BEE ,HERE>
		       <TELL CR <PICK-NEXT <GET ,BEE-TABLE 0>> ,PERIOD>
		       <COND (<HERE? NBOG>
			      <COND (<IS? ,TRAP ,OPENED>
				     <BEE-ENTERS-TRAP>
				     <RTRUE>)>
			      <TELL CR
"The bee hovers near the " D ,TRAP
" for a moment, drawn by the tantalizing aroma. Finding no means of entry, it shrugs its little shoulders and buzzes back to annoy you." CR>)>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <HERE? NBOG>
		     <IS? ,TRAP ,OPENED>>
		<BEE-ENTERS-TRAP>
		<RTRUE>)
	       (<T? ,SUITED?>
		<POP-BUBBLE-SUIT>
		<TELL CR CTHE ,BEE " hovers uncertainly outside the " D ,FILM
" for a moment. Then it buzzes with exasperation and launches an assault with its three-inch stinger" ,PCR>
		<ITALICIZE "Pop!">
		<CRLF>
		<RTRUE>)
	       (<IS? ,BEE ,TOUCHED>
		<UNMAKE ,BEE ,TOUCHED>
		<TELL CR <PICK-NEXT <GET ,BEE-TABLE 1>> ,PERIOD>
		<RTRUE>)
	       (<IS? ,BEE ,SEEN>
		<UNMAKE ,BEE ,SEEN>
		<MAKE ,BEE ,TOUCHED>
		<TELL CR CTHE ,BEE
" evades your flying hands, and plants a second sting right in the middle of your forehead. You scream with blinding agony" ,PCR>
		<VOICE-MUTTERS "One more like that, and you've had it" <>>
		<RTRUE>)
	       (T
		<TELL CR "With a triumphant buzz, the " D ,BEE
" sinks its stinger deep into the back of your neck.|
|
Your muscles convulse for a while as the accumulated venom eats away at your central nervous system.">
		<JIGS-UP>
		<RTRUE>)>>

<ROUTINE BEE-ENTERS-TRAP ()
	 <CLOSE-TRAP>
	 <DEQUEUE I-BEE>
	 <REMOVE ,BEE>
	 <TELL CR "The sweet smell of the " D ,TRAP
" stops the bee in mid-buzz. Forgetting its anger, the insect hovers above the open jaws, then touches down to sample the glistening ichor.|
|
">
	 <ITALICIZE "Click!">
	 <TELL " The " D ,TRAP
" snaps shut. After a few minutes, the faint buzzing dies away." CR>
	 <RTRUE>>

<GLOBAL BEE-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 "You hear a familiar buzz nearby"
	 	 "Buzzing angrily, the giant bee hovers close by"
	 	 "The giant bee maintains its orbit around your head"
	 	 "With an angry buzz, the giant bee streaks into view">
	 <LTABLE 2
	  "The giant bee spit-polishes its stinger"
	  "You hear the bee circling above your head"
	  "The bee zooms around your head, waiting for a chance to strike"
	  "The bee's three-inch stinger is poised for a strike">
	 <LTABLE 2
	 	 " deftly swerves away, then buzzes back for more"
	 	 " avoids your touch with ease"
	 	 " buzzes safely out of reach"
	 	 " defies your hopeless attempt">>>

<ROUTINE I-SKINK ("AUX" L)
	 <SET L <LOC ,SKINK>>
	 <COND (<NOT <EQUAL? .L ,PLAYER>>
		<MAKE ,SKINK ,CHILLY>)>

	 <COND (<AND <ZERO? ,LIT?>
		     <EQUAL? .L ,HERE>>
		<COND (<IS? ,SKINK ,SEEN>
		       <UNMAKE ,SKINK ,SEEN>
		       <RFALSE>)>
		<MAKE ,SKINK ,SEEN>
		<TELL CR <PICK-NEXT <GET ,SKINK-TABLE 1>> ,PERIOD>
		<RTRUE>)

	       (<AND <EQUAL? .L ,TUN3>
		     <HERE? TUN3>>
		<CRLF>
		<COND (<NOT <IN? ,SHARD ,CREVICE>>
		       <UNMAKE ,SKINK ,SEEN>
		       <MOVE ,SKINK ,CREVICE>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL "With a nimble leap, the " D ,SKINK
" scrambles into the dark " D ,CREVICE ,PERIOD>
		       <RTRUE>)>
		<TELL CTHE ,SKINK>
		<COND (<AND <IN? ,LAMP ,TUN2>
			    <IS? ,LAMP ,LIGHTED>>
		       <COND (<NOT <IS? ,SKINK ,SHADOWY>>
			      <SKINK-TO-TUN2>
			      <FIRST-SKINK-EXIT>
			      <RTRUE>)
			     (<NOT <IS? ,SKINK ,SEEN>>
			      <PUT <GET ,SKINK-TABLE 2> 1 2>
			      <TELL
" squints forlornly down the east " D ,TUNNEL ", blinks and">)>
		       <MAKE ,SKINK ,SEEN>
		       <SETG P-IT-OBJECT ,SKINK>
		       <TELL <PICK-NEXT <GET ,SKINK-TABLE 2>> ,PERIOD>
		       <RTRUE>)>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 	<UNMAKE ,SKINK ,SEEN>
	 	<COND (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL " winces in the stab of the " D ,LAMP ", and">)>
		<SKINK-TO-TUN2>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<AND <EQUAL? .L ,CREVICE>
		     <HERE? TUN3>>
		<COND (<IN? ,SHARD ,CREVICE>
		       <TELL CR CTHE ,SKINK
" scrambles out of the lighted " D ,CREVICE
", slips between your legs and">
		       <SKINK-TO-TUN2>
		       <COND (<AND <IN? ,LAMP ,TUN2>
		     	 	   <IS? ,LAMP ,LIGHTED>>
			      <FIRST-SKINK-EXIT>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<IS? ,SKINK ,SEEN>
		       <UNMAKE ,SKINK ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<MAKE ,SKINK ,SEEN>
		<SETG P-IT-OBJECT ,CREVICE>
		<TELL CR <PICK-NEXT <GET ,SKINK-TABLE 3>> ,PERIOD>
		<RTRUE>)

	       (<AND <EQUAL? .L ,TUN2>
		     <HERE? TUN2>>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		<UNMAKE ,SKINK ,SEEN>
		<MOVE ,SKINK <COND (<OR <IN? ,SHARD ,TUN3>
			   		<AND <IN? ,LAMP ,TUN3>
			    		     <IS? ,LAMP ,LIGHTED>>>
		       		    ,CREVICE)
		      		   (T
		       		    ,TUN3)>>
		<TELL CR CTHE ,SKINK " blinks helplessly in the ">
		<COND (<AND <VISIBLE? ,LAMP>
			    <IS? ,LAMP ,LIGHTED>>
		       <TELL "beam of the " D ,LAMP>)
		      (T
		       <TELL "glow of the " D ,SHARD>)>
		<TELL ", and scrambles away down the west "
		      D ,CAVERN ,PERIOD>
		<RTRUE>)

	       (<EQUAL? .L ,POCKET>
		<MAKE ,SKINK ,CHILLY>
		<COND (<IS? ,SKINK ,SEEN>
		       <UNMAKE ,SKINK ,SEEN>
		       <RFALSE>)
		      (<PROB 50>
		       <RFALSE>)>
		<MAKE ,SKINK ,SEEN>
		<TELL CR <PICK-NEXT <GET ,SKINK-TABLE 0>> ,PERIOD>
		<RTRUE>)

	       (<NOT <VISIBLE? ,SKINK>>
		<UNMAKE ,SKINK ,SEEN>
		<MAKE ,SKINK ,CHILLY>
		<RFALSE>)

	       (<EQUAL? .L ,PLAYER>
		<UNMAKE ,SKINK ,SEEN>
		<CRLF>
		<COND (<IS? ,SKINK ,CHILLY>
		       <UNMAKE ,SKINK ,CHILLY>
		       <SETG P-IT-OBJECT ,SKINK>
		       <TELL CTHE ,SKINK
" squirms violently in " D ,HANDS ,PERIOD>
		       <RTRUE>)>
		<TELL
"With a sudden lurch, the " D ,SKINK " wiggles out of your grasp and ">
		<FREE-SKINK>
		<RTRUE>)>

	 <TELL CR CTHE ,SKINK>
	 <PRINTC 32>
	 <COND (<EQUAL? .L ,CAGE>
		<TELL "squeezes out of the cage and ">)
	       (<AND <IS? .L ,CONTAINER>
		     <IS? .L ,OPENED>>
		<TELL "leaps out of " THE .L " and ">)
	       (<IS? .L ,SURFACE>
		<TELL "leaps off " THE .L " and ">)>
	 <FREE-SKINK>
	 <RTRUE>>

<ROUTINE SKINK-TO-TUN2 ()
	 <MOVE ,SKINK ,TUN2>
	 <TELL " scurries away into the east " D ,TUNNEL>
	 <RTRUE>>

<ROUTINE FIRST-SKINK-EXIT ()
	 <MAKE ,SKINK ,SHADOWY>
	 <SETG P-IT-OBJECT ,SKINK>
	 <MAKE ,SKINK ,SEEN>
	 <MOVE ,SKINK ,TUN3>
	 <TELL
,PA "moment later it reappears, blinking helplessly from the glow of the "
D ,LAMP ,PCR "With no place to hide, the flummoxed " D ,SKINK
" runs in circles at your feet." CR>
	 <RTRUE>>

<GLOBAL SKINK-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 "The skink squirms in your pocket"
	 	 "The skink in your pocket scratches restlessly"
		 "You can feel the skink moving in your pocket">
	 <LTABLE 2
	 	 "Something is scratching around in the darkness"
	 	 "You can hear something scrambling around your feet"
	 	 "You hear a scrambling noise underfoot">
	 <LTABLE 2
	 	 " scurries blindly around your feet"
	 	 " blinks its eyes helplessly"
	 	 " is running about underfoot">
	 <LTABLE 2
	 	 "You can hear something moving in the crevice"
	 	 "Something in the crevice is moving around"
	 	 "There's something scratching around inside the crevice">>>

<ROUTINE FREE-SKINK ()
	 <MAKE ,SKINK ,CHILLY>
	 <MAKE ,SKINK ,SEEN>
	 <COND (<T? ,SUITED?>
		<COND (<NOT <IN? ,SKINK ,PLAYER>>
		       <MOVE ,SKINK ,PLAYER>)>
		<SETG P-IT-OBJECT ,SKINK>
		<BOUNCES-IN-FILM ,SKINK>
		<RTRUE>)>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <COND (<HERE? TUN2>
		<MOVE ,SKINK ,TUN3>
		<TELL "scurries away" ,TOW ,PERIOD>
		<RTRUE>)
	       (<HERE? TUN3>
		<MOVE ,SKINK ,CREVICE>
		<TELL "scurries into the ">
		<COND (<IN? ,SHARD ,CREVICE>
		       <TELL "lighted ">)>
		<TELL D ,CREVICE ,PERIOD>
		<RTRUE>)>
	 <EXIT-SKINK>
	 <COND (<AND <HERE? IN-ORBIT ON-SAT>
		     <ZERO? ,SUITED?>>
		<TELL "drifts slowly">)
	       (<HERE? IN-CLOSET>
		<TELL "disappears">
		<COND (<T? ,LIT?>
		       <TELL " through a crack in the " D ,FLOOR>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<COND (<AND <HERE? PROM>
			    <T? ,IN-DISH?>>
		       <TELL "swims out of the dish and ">)>
		<TELL "scurries">)>
	 <PRINT ,OUTASITE>
	 <RTRUE>>

<ROUTINE EXIT-SKINK ()
	 <VANISH ,SKINK>
	 <DEQUEUE I-SKINK>
	 <RTRUE>>

<GLOBAL STICKS:NUMBER 0>

<ROUTINE I-STYX ("OPTIONAL" (CR? T) "AUX" (DOCK <>) (B <>))
	 <COND (<T? ,IN-DORY?>
		<RFALSE>)
	       (<ZERO? ,STICKS>
		<COND (<NOT <HERE? DOCKSIDE>>
		       <RFALSE>)>
		<INC STICKS>
		<SETG P-IT-OBJECT ,DORY>
		<MOVE ,DORY ,HERE>
		<DORY-APPEARS>
		<PRINT ,PERIOD>
		<RTRUE>)>

	 <INC STICKS> ; "Update counter."
	 <COND (<G? ,STICKS 12>
		<SETG STICKS 1>)>

       ; "Handle mandatory movements."

	 <COND (<EQUAL? ,STICKS 1>
		<MOVE ,DORY ,DOCKSIDE>)
	       (<EQUAL? ,STICKS 3>
		<MAKE ,DORY ,TOUCHED>
		<MOVE ,SHADES ,DOCKSIDE>)
	       (<EQUAL? ,STICKS 4>
		<MOVE ,SHADES ,DORY>)
	       (<EQUAL? ,STICKS 6 11>
		<UNMAKE ,DORY ,TOUCHED>)
	       (<EQUAL? ,STICKS 7>
		<REMOVE ,DORY>)
	       (<EQUAL? ,STICKS 8>
		<MOVE ,DORY ,ON-BEACH>)
	       (<EQUAL? ,STICKS 10>
		<MAKE ,DORY ,TOUCHED>
		<REMOVE ,SHADES>)
	       (<EQUAL? ,STICKS 12>
		<REMOVE ,DORY>)>

       ; "Handle move-specific text."

	 <COND (<HERE? DOCKSIDE>
		<SET DOCK T>)
	       (<HERE? ON-BEACH>
		<SET B T>)
	       (T
		<RFALSE>)>

	 <COND (<OR <AND <EQUAL? ,STICKS 1>
			 <T? .DOCK>>
		    <AND <EQUAL? ,STICKS 8>
			 <T? .B>>>
		<COND (<T? .CR?>
		       <CRLF>)>
	  	<SETG P-HIM-OBJECT ,CHARON>
		<TELL CTHE ,DORY " reappears out of the mist." CR>
		<RTRUE>)

	       (<OR <AND <EQUAL? ,STICKS 2>
		     	 <T? .DOCK>>
		    <AND <EQUAL? ,STICKS 9>
			 <T? .B>>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,CHARON>
		<TELL CTHE ,DORY " draws closer to the " D ,BEACH>
	 	<COND (<NOT <IS? ,CHARON ,TOUCHED>>
		       <MAKE ,CHARON ,TOUCHED>
		       <MAKE-OUT-CHARON>
		       <RTRUE>)>
	 	<PRINT ,PERIOD>
		<RTRUE>)

	       (<OR <AND <EQUAL? ,STICKS 3>
		     	 <T? .DOCK>>
		    <AND <EQUAL? ,STICKS 10>
			 <T? .B>>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,CHARON>
		<SETG P-THEM-OBJECT ,SHADES>
		<SOUNDLESS-LANDING>
		<TELL ,PCR>
		<COND (<T? .DOCK>
		       <SETG P-THEM-OBJECT ,SHADES>
		       <TELL
"A puff of wind ripples the water.|
|
Eddies of sand swirl across the " D ,BEACH
" and coalesce into ghostly figures of dust and vapor. Before you can think or move, you find "
D ,ME " amid a gathering of human " D ,SHADES
", pale and gaunt, silent as death." CR>
		       <RTRUE>)>
		<ONE-BY-ONE>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<AND <EQUAL? ,STICKS 4>
		     <T? .DOCK>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,CHARON>
		<SETG P-THEM-OBJECT ,SHADES>
		<TELL
"The ghostly " D ,SHADES " begin to converge on the dory. One by one, they step into the vessel, hand the " D ,CHARON
" a silver coin, and take a seat." CR>
		<RTRUE>)

	       (<AND <EQUAL? ,STICKS 5>
		     <T? .DOCK>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,CHARON>
		<SETG P-THEM-OBJECT ,SHADES>
		<TELL
"The last of the " D ,SHADES " seats itself in the crowded dory." CR>
		<RTRUE>)

	       (<OR <AND <EQUAL? ,STICKS 6>
			 <T? .DOCK>>
		    <AND <EQUAL? ,STICKS 11>
			 <T? .B>>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,CHARON>
		<TELL "With practiced skill, the " D ,CHARON
		      " pushes his ">
		<COND (<T? .DOCK>
		       <SETG P-THEM-OBJECT ,SHADES>
		       <TELL "crowded ">)
		      (T
		       <TELL "empty ">)>
		<TELL D ,DORY " away from the " D ,BEACH ,PERIOD>
		<RTRUE>)

	       (<OR <AND <EQUAL? ,STICKS 7>
			 <T? .DOCK>>
		    <AND <EQUAL? ,STICKS 12>
			 <T? .B>>>
		<COND (<T? .CR?>
		       <CRLF>)>
		<SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<TELL "You watch as the " D ,DORY " and its ">
		<COND (<ZERO? .DOCK>
		       <TELL "navigator ">)
		      (T
		       <TELL "passengers ">)>
		<TELL
"glide across the river, vanishing at last into obscurity." CR>
		<RTRUE>)

	       (T
		<RFALSE>)>>

<ROUTINE DORY-APPEARS ()
	 <TELL CR
"As you peer across the river you notice a lone vessel gliding out of the fog">
	 <RTRUE>>

<ROUTINE MAKE-OUT-CHARON ()
	 <TELL ". You can make out a dark " D ,CHARON " at the stern." CR>
	 <RTRUE>>

<ROUTINE SOUNDLESS-LANDING ()
	 <TELL CTHE ,CHARON " guides his dory to a " D ,SOUND
	       "less " D ,LANDING>
	 <RTRUE>>

<ROUTINE ONE-BY-ONE ()
	 <TELL "One by one, the " D ,SHADES
" slink out of the vessel and drift across the sand like leaves on a breath of wind">
	 <RTRUE>>

<GLOBAL PATIENCE:NUMBER 3>

<ROUTINE I-CHARON ()
	 <DEC PATIENCE>
	 <COND (<EQUAL? ,PATIENCE 2>
		<RFALSE>)>
	 <TELL CR CTHE ,CHARON>
	 <COND (<EQUAL? ,PATIENCE 1>
		<TELL
" stretches out his palm with growing impatience." CR>
		<RTRUE>)
	       (T
		<TELL
" points you in the " D ,INTDIR " of the " D ,BEACH
,PA "swift kick encourages you to visit it quickly." CR>
		<EXIT-DORY>
		<RTRUE>)>>

<ROUTINE I-CRABS ("OPTIONAL" (CR T))
	 <COND (<OR <NOT <HERE? WSAND>>
		    <IS? ,CRABS ,SEEN>>
		<UNMAKE ,CRABS ,SEEN>
		<RFALSE>)
	       (<ZERO? .CR>
		T)
	       (<PROB 50>
		<RFALSE>)
	       (T
		<CRLF>)>
	 <TELL "The ">
	 <COND (<PROB 50>
		<COND (<PROB 50>
		       <TELL "alert ">)
		      (T
		       <TELL "wretched ">)>)>
	 <TELL D ,CRABS <PICK-NEXT <GET ,LAGOON-TABLE 0>> ,PERIOD>
	 <SETG P-THEM-OBJECT ,CRABS>
	 <RTRUE>>

<GLOBAL LAGOON-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 " snap their claws at you"
	 	 " glare at you with beady little eyes"
	 	 " sharpen their claws with anticipation"
	 	 " are watching every move you make">
	 <LTABLE 2
	 	 " stands on its tail"
	 	 " chatters happily"
	 	 " gives you a playful splash"
	 	 " looks at you with bright, intelligent eyes"
	 	 " is watching you curiously"
	 	 " makes an odd whistling sound"
	 	 " dives underwater, but soon reappears"
	 	 " spins in crazy circles">>>

<GLOBAL FCOUNT:NUMBER 6>

<ROUTINE I-FLIPPER ("OPTIONAL" (CR T))
	 <COND (<OR <HERE? ON-SCAFFOLD AT-SDOORS>
		    <IS? ,FLIPPER ,SEEN>>
		<UNMAKE ,FLIPPER ,SEEN>
		<RFALSE>)
	       (<T? ,FCOUNT>
		<DEC FCOUNT>
		<COND (<G? ,FCOUNT 2>
		       <RFALSE>)
		      (<EQUAL? ,FCOUNT 2>
		       <MOVE ,FIN ,HERE>
		       <SETG P-IT-OBJECT ,FIN>
		       <TELL CR
"A gray fin is gliding across the " D ,LAGOON ,PERIOD>
		       <RTRUE>)
		      (<NOT <IN? ,FIN ,HERE>>
		       <MOVE ,FIN ,HERE>
		       <SETG P-IT-OBJECT ,FIN>
		       <SETG FCOUNT 2>
		       <TELL CR CTHE ,FIN " reappears just offshore." CR>
		       <RTRUE>)
		      (<EQUAL? ,FCOUNT 1>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL "The gray fin glides closer." CR>
		       <RTRUE>)
		      (T
		       <SETG FCOUNT 0>
		       <REMOVE ,FIN>
		       <MOVE ,FLIPPER ,HERE>
		       <THIS-IS-IT ,FLIPPER>
		       <MAKE ,FLIPPER ,SEEN>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL
"With a sudden splash, the gray fin shoots upward! You shriek and cover your face with " D ,HANDS
"s as a mouthful of sharp teeth leaps from the "
D ,LAGOON "...|
|
A friendly chatter encourages you to open your eyes. It's a bottle-nosed "
D ,FLIPPER ", standing on its tail just offshore." CR>
		       <RTRUE>)>)
	       (<NOT <IN? ,FLIPPER ,HERE>>
		<MAKE ,FLIPPER ,SEEN>
		<MOVE ,FLIPPER ,HERE>
		<THIS-IS-IT ,FLIPPER>
		<TELL CR CTHE ,FLIPPER " glides into view nearby." CR>
		<RTRUE>)
	       (<T? .CR>
		<COND (<PROB 50>
		       <CRLF>)
		      (T
		       <RFALSE>)>)>
	 <MAKE ,FLIPPER ,SEEN>
	 <TELL CTHE ,FLIPPER <PICK-NEXT <GET ,LAGOON-TABLE 1>> ,PERIOD>
	 <RTRUE>>

<ROUTINE I-TIDE ("AUX" (W <>))
	 <COND (<ZERO? ,MINUTES>
		<COND (<NOT <IS? ,TSWITCH ,OPENED>>
		       <TELL CR "\"Five. Four. Three. Two. One.\"" CR>)>
		<TELL CR
"Your tropical vacation is cut short by a multimegaton thermonuclear detonation, centered in the nearby ">
		<COND (<HERE? ON-SCAFFOLD AT-SDOORS>
		       <TELL "maze of plumbing">)
		      (T
		       <TELL D ,ESHED>)>
		<TELL ".">
		<JIGS-UP>
		<RTRUE>)
	       (<HERE? WSAND>
		<SET W T>)>

       ; "Handle tide and coconut."

	 <COND (<OR <HERE? ON-SCAFFOLD AT-SDOORS>
		    <L? ,MINUTES 54>
		    <NOT <EQUAL? ,SECONDS 45 15>>> ; "Always at 45 or 15."
		T)
	       (<EQUAL? ,MINUTES 54>
		<CRLF>
		<COND (<EQUAL? ,SECONDS 15>
		       <TELL
"A wave washes up underfoot. It looks as if the tide is rising." CR>)
		      (T
		       <TELL "The ">
		       <COND (<T? .W>
		       	      <TELL "distant " D ,ISLET>)
		      	     (T
		       	      <TELL D ,BEACH>)>
		       <TELL
" is shrinking in the rising tide." CR>)>
		<BURNS-QUOTED?>
		<RTRUE>)
	       (<EQUAL? ,MINUTES 55>
		<COND (<AND <EQUAL? ,SECONDS 15>
			    <NOT <IS? ,COCO ,TRYTAKE>>>
		       <MAKE ,COCO ,TRYTAKE>
		       <MOVE ,COCO ,ISLET>
		       <COND (<T? .W>
		       	      <SETG P-IT-OBJECT ,COCO>
		       	      <TELL CR "A faint ">
		       	      <ITALICIZE "plop">
		       	      <TELL " draws your eyes to the " D ,ISLET
". There's now a " D ,COCO " lying at the water's edge." CR>
		       	      <RTRUE>)>
		       <RFALSE>)
		      (<AND <T? .W>
			    <EQUAL? ,SECONDS 45>>
		       <TELL CR "The tide creeps towards the " D ,COCO
		      		" under the distant tree." CR>
		       <BURNS-QUOTED?>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? ,MINUTES 56>
		<COND (<EQUAL? ,SECONDS 15>
		       <MOVE ,COCO ,WSAND>
		       <MAKE ,COCO ,CHILLY>
		       <UNMAKE ,COCO ,NODESC>
		       <PUTP ,COCO ,P?DESCFCN ,DESCRIBE-COCO>
		       <COND (<T? .W>
		       	      <SETG P-IT-OBJECT ,COCO>
		       	      <TELL CR CTHE ,COCO
" floats away from the distant " D ,ISLET " on the rising tide." CR>
		       	      <BURNS-QUOTED?>
			      <RTRUE>)>
		       <RFALSE>)
		      (<AND <IS? ,COCO ,CHILLY>
			    <T? .W>>
		       <TELL CR CTHE ,COCO " bobs gently on the "
		      	     D ,CSURFACE " of the " D ,LAGOON ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<EQUAL? ,MINUTES 57>
		<COND (<EQUAL? ,SECONDS 45>
		       <TELL CR
"The tide is making the sand squishy." CR>
		       <COND (<AND <T? .W>
			    	   <IS? ,COCO ,CHILLY>>
		       	      <TELL CR CTHE ,COCO
" floats further away. It's almost" ,OUTASITE>)>
		       <BURNS-QUOTED?>
		       <RTRUE>)
		      (<AND <IS? ,COCO ,CHILLY>
			    <T? .W>>
		       <TELL CR CTHE ,COCO
			     " is beginning to float away." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <EQUAL? ,MINUTES 58>
		     <EQUAL? ,SECONDS 15>
		     <IS? ,COCO ,CHILLY>
		     <T? .W>>
		<VANISH ,COCO>
		<TELL CR CTHE ,COCO " disappears across the " D ,LAGOON
		      ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>

       ; "Handle PA system."

	 <COND (<IS? ,TSWITCH ,OPENED> ; "Nothing if PA is off."
		<RFALSE>)
	       (<ZERO? ,SECONDS>
		<TELL ,Z-MINUS <GET <GET ,PA-TABLE 1> <- 60 ,MINUTES>>
		      " minute">
		<COND (<NOT <EQUAL? ,MINUTES 59>>
		       <TELL "s">)>
		<TELL ".\"" CR>
		<RTRUE>)
	       (<AND <EQUAL? ,MINUTES 58>
		     <EQUAL? ,SECONDS 30>>
		<TELL ,Z-MINUS "ninety seconds.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,MINUTES 59>
		<PRINT ,Z-MINUS>
		<COND (<EQUAL? ,SECONDS 15>
	 	       <TELL "forty-five seconds.\"" CR>
		       <RTRUE>)
		      (<EQUAL? ,SECONDS 30>
		       <TELL "thirty seconds.\"" CR>
		       <RTRUE>)>
		<TELL
"fifteen seconds. Personnel not issued protective goggles should face away from Zero at this time.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 30>
		<CRLF>
		<PRINTC 34>
		<TELL <PICK-NEXT <GET ,PA-TABLE 0>> ".\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BURNS-QUOTED? ()
	 <COND (<IS? ,LAGOON ,SEEN>
		<RFALSE>)>
	 <MAKE ,LAGOON ,SEEN>
	 <CRLF>
	 <VOICE-MUTTERS "Gnomon can tether time or tide" <>>
	 <RTRUE>>

<GLOBAL PA-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 "Switch to one zero three"
	 	 "Detonator check, go"
	 	 "Geo, sync at three, two, one, mark"
	 	 "Patch to Alpha Echo Three Five"
	 	 "Seismographic, confirm"
	 	 "H-E nominal"
	 	 "Continuity on gamma three"
	 	 "Roger. Signature established">
	 <PTABLE "BUG!" "one" "two" "three" "four" "five"
		 "six" "seven" "eight" "nine" "ten">>>

<ROUTINE I-FALLING ("OPTIONAL" (CR T) "AUX" OBJ NXT)
	 <COND (<T? .CR>
		<CRLF>)>
	 <COND (<OR <T? ,SUITED?>
		    <AND <IN? ,PARASOL ,PLAYER>
			 <IS? ,PARASOL ,OPENED>>>
		<QUEUE I-NAGASAKI -1>
		<TELL CTHE ,CITY
" below draws closer. You glimpse a river, railroad tracks, streets busy with horses and bicycles, a "
D ,PGROUND ".." ,PCR>
		<COND (<T? ,SUITED?>
		       <POP-BUBBLE-SUIT>
		       <HLIGHT ,H-ITALIC>
		       <TELL "Pop">
		       <HLIGHT ,H-NORMAL>
		       <TELL "! The " D ,FILM
" holding you aloft disappears in a spray of color">
		       <COND (<BROLLY-FILLS?>
			      <CRLF>)
			     (T
		       	      <I-FALLING>
		       	      <RTRUE>)>)>

		<ITALICIZE "Crunch.">
		<CRLF> <CRLF>

		<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
			<COND (<ZERO? .OBJ>
			       <RETURN>)>
			<SET NXT <NEXT? .OBJ>>
			<COND (<AND <NOT <EQUAL? .OBJ ,POCKET ,HONEY>>
				    <NOT <IS? .OBJ ,WORN>>>
			       <MOVE .OBJ ,SPILE>)>
			<SET OBJ .NXT>>
		<SETG IN-SAND? T>
		<GOTO ,PLAYGROUND>)
	       (T
		<TELL
"The wind in your ears becomes a roar as you plunge faster towards the city below. You close your eyes for the last few hundred feet.">
		<JIGS-UP>)>
	 <RTRUE>>

<ROUTINE I-NAGASAKI ("OPTIONAL" (CR T) "AUX" (S <>))
	 <COND (<HERE? IN-SHELTER>
		<SET S T>)>
	 <COND (<AND <EQUAL? ,MINUTES 56>
		     <ZERO? ,SECONDS>>
		<MOVE ,GIRL ,PLAYGROUND>
		<QUEUE I-GIRL -1>
		<COND (<ZERO? .S>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <GIRL-APPEARS>
		       <RTRUE>)
		      (<OR <IN? ,PARASOL ,PLAYGROUND>
			   <IN? ,PARASOL ,SPILE>>
		       <MOVE ,PARASOL ,GIRL>)>
		<RFALSE>)
	       (<EQUAL? ,MINUTES 2>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL ,ALLATONCE "the ">
		<COND (<T? .S>
		       <TELL D ,SHELTER>)
		      (T
		       <TELL D ,SKY>)>
		<TELL
" is lit by a terrifying flash of light. You dive ">
		<COND (<IN? ,GIRL ,HERE>
		       <TELL "to cover the screaming " D ,GIRL
", and feel the earth shudder beneath a crushing blast wave.|
|
Your body absorbs much of the deadly radiation that might otherwise have reached the child. Years later, she recalls to her grand" D ,CHILDREN
" the tale of a mysterious stranger who shielded her life at " D ,NAGASAKI>)
		      (T
		       <TELL
"for cover, but never make it to the ground">)>
		<TELL ".">
		<JIGS-UP>
		<RTRUE>)
	       (<NOT <EQUAL? ,MINUTES 1>>
		<RFALSE>)
	       (<EQUAL? ,SECONDS 15>
		<MAKE ,PLANES ,SEEN>
		<SETG P-THEM-OBJECT ,PLANES>
		<MOVE ,PLANES ,LOCAL-GLOBALS>
		<PUTP ,PLAYGROUND ,P?HEAR ,PLANES>
		<PUTP ,PLAYGROUND ,P?OVERHEAD ,PLANES>
		<PUTP ,ON-BIRD ,P?HEAR ,PLANES>
		<PUTP ,ON-BIRD ,P?OVERHEAD ,PLANES>
		<PUTP ,IN-SHELTER ,P?HEAR ,PLANES>
		<TELL CR
"You've noticed a faint " D ,SOUND " coming from somewhere">
		<OVER-OR-OUT>
		<COND (<IN? ,GIRL ,HERE>
		       <MAKE ,GIRL ,SEEN>
		       <TELL ,PTHE D ,GIRL " turns to stare at the ">
		       <COND (<T? .S>
			      <TELL D ,CEILING>)
			     (T
			      <TELL D ,SKY>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<ZERO? .S>
		       <TELL ,PTHE D ,KIDS " and " D ,TEACHERS
			     " stop to stare at the sky." CR>
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<RTRUE>)

	       (<EQUAL? ,SECONDS 30>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL CTHE ,SOUND>
		<OVER-OR-OUT>
		<TELL
" grows louder. There's no mistaking the drone of " D ,PLANES ,PERIOD>
		<COND (<IN? ,GIRL ,HERE>
		       <MAKE ,GIRL ,SEEN>
		       <TELL CR CTHE ,GIRL
			 " looks at you expectantly and ">
		       <COND (<T? .S>
			      <TELL "crouches down in a " D ,CORNER " of ">)
			     (T
			      <TELL "tries to pull you towards ">)>
		       <TELL THE ,SHELTER ,PERIOD>)>
		<COND (<ZERO? .S>
		       <TEACHERS-COME>)>
		<RTRUE>)

	       (<EQUAL? ,SECONDS 45>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL "The drone of the " D ,PLANES>
		<OVER-OR-OUT>
		<TELL " increases. It " D ,SOUND
		      "s as if they're in a power dive." CR>
		<COND (<IN? ,GIRL ,HERE>
		       <MAKE ,GIRL ,SEEN>
		       <TELL CR CTHE ,GIRL
" covers her ears with her hands and whimpers." CR>
		       <RTRUE>)
		      (<ZERO? .S>
		       <TEACHERS-COME>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GIRL-APPEARS ()
	 <TELL
"A little girl races between the " D ,SWINGS
", hot on the trail of a dragonfly. She trips and sprawls across the sand, laughing with hysterical glee. Then she sees you." CR>
	 <GIRL-SEES-YOU>
	 <RTRUE>>

<ROUTINE GIRL-SEES-YOU ()
	 <UNMAKE ,GIRL ,NODESC>
	 <SETG P-HER-OBJECT ,GIRL>
	 <TELL CR
"At first, you're sure she's going to scream. Her eyes dart back and forth between you and the " D ,TEACHERS
"; you can see a cry forming on her lips." CR>
	 <COND (<IN? ,PARASOL ,GIRL>
		<SETG P-IT-OBJECT ,PARASOL>
		<MOVE ,PARASOL ,PLAYGROUND>
		<TELL CR
"Suddenly, she remembers the " D ,PARASOL
" in her hands. Her expression changes from fear to embarrassment. With a red face, she lays the thing at your feet." CR>
		<RTRUE>)
	       (<VISIBLE? ,PARASOL>
		<SETG P-IT-OBJECT ,PARASOL>
		<TELL CR "Suddenly, the " D ,PARASOL>
		<COND (<IN? ,PARASOL ,PLAYER>
		       <TELL " in " D ,HANDS>)
		      (T
		       <TELL " at your feet">)>
		<TELL " catches her eye. You watch her expression soften from fear to curiosity." CR>)>
	 <RTRUE>>

<ROUTINE OVER-OR-OUT ()
	 <COND (<HERE? IN-SHELTER>
		<TELL " outside">)
	       (T
		<TELL " overhead">)>
	 <RTRUE>>

<ROUTINE TEACHERS-COME ()
	 <TELL CR
"Muttering with exasperation, the " D ,TEACHERS " drop their " D ,SPADE
"s and begin to trudge in the " D ,INTDIR " of the " D ,SHELTER ,PERIOD>
	 <TEACHERS-NOTICE>
	 <RTRUE>>

<ROUTINE I-GIRL ("OPTIONAL" (CR T) "AUX" (S <>))
	 <COND (<HERE? IN-SHELTER>
		<SET S T>)>
	 <COND (<NOT <IN? ,GIRL ,HERE>>
		<MAKE ,GIRL ,SHADOWY> ; "New fear delay."
		<COND (<OR <IS? ,GIRL ,NODESC>
			   <IN? ,PARASOL ,GIRL>>
		       <RFALSE>)
		      (T
		       <MOVE ,GIRL ,HERE>
		       <SETG P-HER-OBJECT ,GIRL>
		       <TELL CR CTHE ,GIRL>
		       <COND (<T? .S>
			      <UNMAKE ,GIRL ,CHILLY>
			      <TELL " appears in the doorway ">)
			     (T
			      <TELL " silently follows you out ">)>
		       <TELL "of the " D ,SHELTER ,PERIOD>
		       <RTRUE>)>)>

	 <SETG P-HER-OBJECT ,GIRL>
	 <COND (<IS? ,GIRL ,NODESC> ; "1st time seen?"
		<TELL CR "A little girl is crouched in the " D ,SPILE>
		<COND (<IN? ,PARASOL ,GIRL>
		       <TELL ", playing with the " D ,PARASOL>)>
		<TELL ". She leaps to her feet as you appear." CR>
		<GIRL-SEES-YOU>
		<RTRUE>)
	       (<IS? ,GIRL ,SEEN>
		<UNMAKE ,GIRL ,SEEN>
		<RFALSE>)
	       (<T? .CR>
		<CRLF>)>
	 <COND (<IN? ,PARASOL ,GIRL>
		<SETG P-IT-OBJECT ,PARASOL>
		<TELL CTHE ,GIRL <PICK-NEXT <GET ,GIRL-TABLE 0>> ,PERIOD>
		<RTRUE>)
	       (<VISIBLE? ,PARASOL>
		<SETG P-IT-OBJECT ,PARASOL>
		<TELL CTHE ,GIRL <PICK-NEXT <GET ,GIRL-TABLE 1>> ,PERIOD>
		<RTRUE>)
	       (<IS? ,GIRL ,SHADOWY>
		<UNMAKE ,GIRL ,SHADOWY>
		<TELL CTHE ,GIRL " looks anxiously ">
		<COND (<T? .S>
		       <TELL "around the " D ,SHELTER
			     ", then back at you." CR>
		       <RTRUE>)>
		<TELL "towards the " D ,TEACHERS
		      " and begins to whimper." CR>
		<RTRUE>)
	       (T
		<TELL "With a sudden yelp of fright, the girl races">
		<COND (<T? .S>
		       <DEQUEUE I-GIRL>
		       <REMOVE ,GIRL>
		       <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
		       <PRINT ,OUTASITE>
		       <RTRUE>)>
		<TELL " away towards the " D ,TEACHERS ,PERIOD>
		<TEACHERS-NOTICE>
		<RTRUE>)>>

<GLOBAL GIRL-TABLE:TABLE
	<PTABLE
	 <LTABLE 2
	 	 " gazes lovingly at the umbrella"
	 	 " twirls the umbrella and giggles"
	 	 " admires the umbrella from all sides"
	 	 " turns the umbrella over and over in her hands">
	 <LTABLE 2
	 	 " can't keep her eyes off the umbrella"
	 	 " gazes at the umbrella, then at you"
	 	 " looks at you, then at the umbrella"
	 	 " eyes the umbrella longingly">
	 <LTABLE 2
		 "The paper bird glows with an eerie violet radiance"
		 "Ghostly light flickers around the paper bird"
		 "A twinkling aurora engulfs the paper bird">>>

<ROUTINE I-NEWCRANE ("OPTIONAL" (CR T))
	 <COND (<NOT <VISIBLE? ,CRANE>>
		<UNMAKE ,CRANE ,SEEN>
		<RFALSE>)
	       (<HERE? IN-SHELTER>
		<COND (<IS? ,CRANE ,SEEN>
		       <UNMAKE ,CRANE ,SEEN>
		       <RFALSE>)
		      (<T? .CR>
		       <COND (<PROB 50>
			      <CRLF>)
			     (T
			      <RFALSE>)>)>
		<TELL <PICK-NEXT <GET ,GIRL-TABLE 2>> ,PERIOD>
		<RTRUE>)
	       (T
		<DEQUEUE I-NEWCRANE>
		<SETG MCOUNT <COND (<NOT <EQUAL? ,MINUTES 1>> 4)
				   (<EQUAL? ,SECONDS 45> 1)
				   (<EQUAL? ,SECONDS 30> 2)
				   (<EQUAL? ,SECONDS 15> 3)
				   (T 			 4)>>
		<QUEUE I-MCRANE -1>
		<REMOVE ,CRANE>
		<MOVE ,MCRANE ,PLAYGROUND>
		<SETG P-IT-OBJECT ,MCRANE>
		<TELL CR "Something twitches in " D ,HANDS ,PCR
		      CTHE ,CRANE " is ">
		<ITALICIZE "growing!">
		<TELL
" The wings and tail are unfolding like the petals of a flower, the long neck craning further and further out of the expanding body...|
|
You drop the demonic thing with a yelp of dismay. In moments, it opens up into a monstrous construction of folded paper the size of a foreign car." CR>
		<RTRUE>)>>

<GLOBAL MCOUNT:NUMBER 0>

<ROUTINE I-MCRANE ("OPTIONAL" (CR T))
	 <DEC MCOUNT>
	 <COND (<ZERO? ,MCOUNT>
		<DEQUEUE I-MCRANE>
		<REMOVE ,MCRANE>
		<COND (<HERE? IN-SHELTER>
		       <TELL CR
"A gust of wind outside blows dust into the " D ,SHELTER ,PERIOD>)
		      (T
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL CTHE ,MCRANE
" looks at you once more with a sad expression. Then, with a stroke of its paper wings, the creature lifts itself into the sky.|
|
When the dust clears, the " D ,CRANE " is nowhere to be seen." CR>)>
		<RTRUE>)
	       (<HERE? IN-SHELTER>
		<RFALSE>)
	       (<T? .CR>
		<CRLF>)>
	 <SETG P-IT-OBJECT ,MCRANE>
	 <TELL CTHE ,MCRANE>
	 <COND (<EQUAL? ,MCOUNT 1>
		<TELL
" beats its paper wings a few times, raising a whirlpool of dust" ,AS-IF
"it's getting ready to fly!" CR>
		<RTRUE>)
	       (<EQUAL? ,MCOUNT 2>
		<TELL " beckons to you with a friendly wing." CR>
		<RTRUE>)
	       (T
		<TELL
" turns to look at you. Though the paper face is utterly featureless, you somehow get the feeling that it likes you." CR>
		<RTRUE>)>>

<ROUTINE I-FLIGHT ("OPTIONAL" (CR T))
	 <DEC MCOUNT>
	 <SETG MINUTES 1>
	 <SETG HOURS 11>
	 <SETG SECONDS 15>
	 <COND (<T? .CR>
		<CRLF>)>
	 <COND (<EQUAL? ,MCOUNT 2>
		<MAKE ,PLANES ,SEEN>
		<PUTP ,ON-BIRD ,P?HEAR ,PLANES>
		<PUTP ,ON-BIRD ,P?OVERHEAD ,PLANES>
		<TELL CTHE ,MCRANE
" soars high over the city, banking left and right with effortless grace. You hear the rhythmic pump of its great wings, wind whipping past your ears... and, far overhead, the drone of approaching " D ,PLANES ,PCR>
		<COND (<AND <IS? ,TS5-DOOR ,OPENED>
			    <NOT <IS? ,TS5-DOOR ,NOALL>>>
		       <TELL
"A speck in the sky grows into the familiar outline of the "
D ,TS5-DOOR ,PTHE "bird circles once, slows to a stall and hovers only a few feet from the threshold." CR>
		       <RTRUE>)
		      (T
		       <TELL
"Your companion circles back and forth, searching for a door it cannot find. ">
		       <SAY-DRONE-LOUDER>
		       <TELL CR CTHE ,FATMAN
" disappears in a burst of light that vaporizes the bird, the city and you.">
		       <JIGS-UP>)>)
	       (<EQUAL? ,MCOUNT 1>
		<SAY-DRONE-LOUDER>
		<RTRUE>)
	       (T
		<TELL CTHE ,FATMAN " shatters the " D ,TS5-DOOR
", then promptly envelops the bird, the city and you in a flash of nuclear fire.">
		<JIGS-UP>
		<RTRUE>)>>

<ROUTINE SAY-DRONE-LOUDER ()
	 <MAKE ,FATMAN ,SEEN>
	 <TELL "The drone of the " D ,PLANES
" becomes a roaring power dive; and a new object appears in the sky, falling towards you at great speed.|
|
The giant bird looks at you again. Its urgency is overpowering!" CR>
	 <RTRUE>>

<GLOBAL DRIBBLE:NUMBER 0>

<ROUTINE I-MILK ("OPTIONAL" (CR T) "AUX" L (V <>))
	 <SET L <LOC ,OCOCO>>
	 <COND (<ZERO? .L>
		<KILL-MILK>
		<RFALSE>)
	       (<VISIBLE? ,OCOCO>
		<SET V T>)>
	 <DEC DRIBBLE>
	 <COND (<ZERO? ,DRIBBLE>
		<KILL-MILK>
		<COND (<ZERO? .V>
		       <RFALSE>)
		      (<T? .CR>
		       <CRLF>)>
	 	<SETG P-IT-OBJECT ,OCOCO>
	 	<LAST-DROPS>
		<RTRUE>)>
	 <MOVE ,MILK .L>
	 <MAKE ,MILK ,NODESC>
	 <COND (<AND <EQUAL? ,DRIBBLE 1>
		     <T? .V>>
		<SETG P-IT-OBJECT ,OCOCO>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL "Liquid dribbles out of the " D ,OCOCO ,PERIOD>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE LAST-DROPS ()
	 <TELL "The last drops of " D ,MILK
	       " dribble out of the " D ,OCOCO ,PERIOD>
	 <RTRUE>>

<ROUTINE KILL-MILK ()
	 <SETG DRIBBLE 0>
	 <DEQUEUE I-MILK>
	 <REMOVE ,MILK>
	 <RTRUE>>

<GLOBAL XCOUNT:NUMBER 3>

<ROUTINE I-EXPLODE ("OPTIONAL" (CR T))
	 <DEC XCOUNT>
	 <COND (<ZERO? ,XCOUNT>
		<COND (<HERE? IN-COTTAGE>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL "With a deafening blast, the "
D ,CAULDRON " vomits up a volcano of energy that cremates you instantly.">
		       <JIGS-UP>
		       <RTRUE>)>
		<COND (<OR <IN? ,CAGE ,IN-COTTAGE>
			   <IN? <LOC ,CAGE> ,IN-COTTAGE>>
		       <COND (<IN? ,MAGPIE ,CAGE>
			      <EXIT-MAGPIE>
			      <MOVE ,DMAGPIE ,CAGE>)>
		       <COND (<IN? ,LEM ,CAGE>
			      <EXIT-LEM>
			      <MOVE ,DLEM ,CAGE>)>)>
		<DEQUEUE I-EXPLODE>
		<UNMAKE ,EMERALD ,NODESC>
		<MOVE ,EMERALD ,CAULDRON>
		<REMOVE ,STEAM>
		<REMOVE ,CWATER>
		<REMOVE ,TOME>
		<REMOVE ,PEDESTAL>
		<REMOVE ,PAGES>
		<MOVE ,CINDERS ,IN-COTTAGE>
		<MAKE ,GMAP ,NODESC>
		<COND (<HERE? ON-BLUFF IN-GARDEN>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <ITALICIZE "Boom!">
		       <TELL
" A powerful concussion sends you sprawling. Your ears ring as you regain your feet." CR>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? ,XCOUNT 1>
		     <HERE? IN-COTTAGE IN-GARDEN ON-BLUFF>>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL "The rumble in the ">
		<PRINTD <COND (<HERE? IN-COTTAGE> ,CAULDRON)
			      (T ,COTTAGE)>>
		<TELL
" grows to a shuddering roar that shakes the ">
		<PRINTD <COND (<HERE? IN-COTTAGE> ,COTTAGE)
			      (T ,GROUND)>>
		<TELL
" with power. It feels as if something's about to explode!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-WHOOSH ()
	 <SETG P-IT-OBJECT ,RBOOT>
	 <TELL CR "Your boots are tingling with energy." CR>
	 <RTRUE>>

<GLOBAL LLIFE:NUMBER 4>

<ROUTINE I-MILL ("OPTIONAL" (CR T))
	 <COND (<NOT <HERE? IN-MILL>>
		<RFALSE>)
	       (<T? .CR>
		<CRLF>)>
	 <DEC LLIFE>
	 <COND (<ZERO? ,LLIFE>
		<SPILL-MILL>
		<RTRUE>)>
	 <SETG P-IT-OBJECT ,LANDING>
	 <TELL CTHE ,LANDING>
	 <COND (<EQUAL? ,LLIFE 1>
		<TELL
" is sagging dangerously. It's not going to last much longer!" CR>
		<RTRUE>)
	       (<EQUAL? ,LLIFE 2>
		<TELL " emits a wooden moan of discomfort." CR>
		<RTRUE>)
	       (T
		<TELL
" creaks under your weight. It isn't in very good shape." CR>)>
	 <RTRUE>>

<ROUTINE I-TMEEP ("OPTIONAL" (CR T) "AUX" L (FOOD <>))
	 <COND (<T? ,QUIET?>
		<RFALSE>)>
	 <UNMAKE ,MEEP ,NODESC>
	 <SET L <LOC ,MEEP>>
	 <COND (<AND <T? .L> ; "Does MEEP have food?"
		     <LOC ,BAG>
		     <T? ,CCNT>
		     <IN? ,BAG .L>>
		<UNMAKE ,MEEP ,SEEN>
		<SET FOOD T>)
	       (T
		<SETG APPETITE 0>)>

       ; "Handle case where MEEP is visible."

	<COND (<AND <IN? ,MEEP ,HERE> ; "Doesn't like these places."
		    <HERE? IN-SHACK TOWER-PLAT ON-TOWER
			   IN-MILL IN-CIST ON-CIST IN-JEEP IN-CLOSET>>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL ,CTHEMEEP>
		<COND (<T? .FOOD>
		       <SAY-PECKS>
		       <RTRUE>)>
		<MEEP-ESCAPES>
		<RTRUE>)
	       (<VISIBLE? ,MEEP>
		<COND (<AND <EQUAL? .L ,W100>
		       	    <IN? ,DOG .L>>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <COND (<T? .FOOD>
			      <TELL ,CTHEMEEP>
			      <COND (<IS? ,DOG ,WINDY>
				     <UNMAKE ,DOG ,WINDY>
				     <TELL
"raises its head and sniffs the air. You stifle a sigh of relief as it abandons the dog, trots back to your side and ">)>
			      <SAY-PECKS>
			      <RTRUE>)
			     (<IS? ,DOG ,WINDY>
			      <LAST-PECK>
			      <RTRUE>)>
		       <MEEP-SEES-DOG>
		       <RTRUE>)>
		<UNMAKE ,DOG ,WINDY>       ; "Not on dog."
		<COND (<EQUAL? .L ,PLAYER> ; "Doesn't like to be held."
		       <SETG APPETITE 0>
		       <MAKE ,LEM ,SEEN>   ; "Shut up the lemming."
		       <UNMAKE ,MEEP ,SEEN>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL ,CTHEMEEP>
		       <COND (<IS? ,MEEP ,TOUCHED> ; "Only waits 1 move."
			      <UNMAKE ,MEEP ,TOUCHED>
			      <TELL
"pecks angrily at your fingers with its sharp beak. Ouch!" CR>
			      <RTRUE>)>
		       <TELL "struggles out of your grasp and ">
		       <MEEP-ESCAPES>
		       <RTRUE>)>
		<COND (<IS? .L ,SURFACE> ; "Won't stay on a SURFACE."
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL ,CTHEMEEP>
		       <COND (<T? .FOOD>
			      <SAY-PECKS>
			      <RTRUE>)>
		       <TELL "hops off " THE .L " and ">
		       <MEEP-ESCAPES>
		       <RTRUE>)
		      (<IS? .L ,CONTAINER>
		       <COND (<IS? .L ,OPENED> ; "Hates open containers."
			      <COND (<T? .CR>
				     <CRLF>)>
			      <TELL ,CTHEMEEP>
			      <COND (<SEE-SNAKE?>
				     <TELL
"cowers in a corner of the cage, trembling violently." CR>
				     <RTRUE>)
				    (<T? .FOOD>
				     <SAY-PECKS>
				     <RTRUE>)
				    (<AND <EQUAL? .L ,CAGE>
					  <IS? ,MEEP ,TOUCHED>>
				     <UNMAKE ,MEEP ,TOUCHED>
				     <TELL
"flutters anxiously around the cage." CR>
				     <RTRUE>)>
			      <TELL "hops out of " THE .L " and ">
			      <MEEP-ESCAPES>
			      <RTRUE>)
			     (<IS? ,MEEP ,SEEN>
			      <UNMAKE ,MEEP ,SEEN>
			      <RFALSE>)
			     (T
			      <MAKE ,MEEP ,SEEN>
			      <COND (<T? .CR>
				     <CRLF>)>
			      <TELL ,CTHEMEEP>
			      <COND (<SEE-SNAKE?>
				     <TELL
"trembles at the sight of the " D ,SNAKE ,PERIOD>
				     <RTRUE>)
				    (<T? .FOOD>
				     <SAY-PECKS>
				     <RTRUE>)
				    (<PROB 50>
				     <COND (<PROB 50>
					    <TELL "glares at you from">)
					   (T
					    <TELL "paces back and forth">)>)
				    (T
				     <COND (<PROB 50>
					    <TELL "looks very unhappy">)
					   (T
					    <TELL "is quietly sulking">)>)>
			      <TELL " inside " THE .L ,PERIOD>
			      <RTRUE>)>)
		      (<T? .FOOD>
		       <MAKE ,MEEP ,SEEN>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL ,CTHEMEEP>
		       <SAY-PECKS>
		       <COND (<AND <ZERO? ,APPETITE>
				   <ZERO? ,CCNT>
				   <HERE? W100>
				   <IN? ,DOG ,HERE>>
			      <CRLF>
			      <MEEP-SEES-DOG>)>
		       <RTRUE>)
		      (<AND <HERE? W100>
			    <IN? ,DOG ,HERE>>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <MEEP-SEES-DOG>
		       <RTRUE>)
		      (<IS? ,MEEP ,SEEN>
		       <UNMAKE ,MEEP ,SEEN>
		       <RFALSE>)
		      (T
		       <MAKE ,MEEP ,SEEN> ; "Normal case."
		       <MAKE ,LEM ,SEEN>
		       <COND (<T? .CR>
			      <CRLF>)>
		       <TELL ,CTHEMEEP <PICK-NEXT <GET ,MEEP-TABLE 3>>
			     ,PERIOD>
		       <RTRUE>)>)>

       ; "MEEP can't follow you under these conditions."

	 <COND (<T? .FOOD> ; "Next bite if eating."
		<UPDATE-APPETITE>
		<COND (<AND <ZERO? ,CCNT>      ; "Bag empty?"
			    <ZERO? ,APPETITE>> ; "Yes, done eating."
		       <SET FOOD <>>)>)>

	 <COND (<T? .FOOD>     		       ; "Continue if still eating."
		T)
	       (<NOT <IN? ,DOG ,W100>>
		T)
	       (<OR <EQUAL? .L ,W100>     ; "Pecking?"
		    <AND <EQUAL? .L ,CAGE>
			 <IN? .L ,W100>
			 <IS? .L ,OPENED>>>
		<UNMAKE ,MEEP ,SEEN>
		<SETG MDELAY 0>
		<COND (<ZERO? ,DISTRACTION>
		       <COND (<NOT <IN? ,MEEP ,W100>>
			      <MOVE ,MEEP ,W100>)>
		       <SETG DISTRACTION 3> ; "Start distraction."
		       <UNMAKE ,DOG ,WINDY>
		       <MAKE ,DOG ,NODESC>
		       <SETG TOLERANCE 2>
		       <UNMAKE ,W100 ,TOUCHED>)>
		<RFALSE>)>

	 <COND (<OR <T? .FOOD>
		    <T? ,MDELAY>
		    <AND <IS? .L ,CONTAINER>
			 <NOT <IS? .L ,OPENED>>>
		    <AND <IS? ,HERE ,INDOORS>
			 <NOT <IS? .L ,INDOORS>>
			 <NOT <RANCH-OPEN?>>>
		    <HERE? IN-SHACK TOWER-PLAT ON-TOWER ON-CIST
		       	   IN-CIST UNDER-WATER IN-MILL IN-JEEP IN-CLOSET>>
		<UNMAKE ,MEEP ,SEEN>
		<COND (<T? ,MDELAY>
		       <DEC MDELAY>)>
		<RFALSE>)
	       (<SEE-SNAKE?>
		<MAKE ,SNAKE ,CHILLY>
		<COND (<T? .CR>
		       <CRLF>)>
		<TELL ,CTHEMEEP "trots into the room">
		<COND (<IS? ,SNAKE ,BORING>
		       <TELL ", sees the " D ,SNAKE " again">)
		      (T
		       <MAKE ,SNAKE ,BORING>
		       <TELL
" and freezes. Tension mounts as snake and bird study one another, their eyes bright with familiar hatred.|
|
Suddenly the " D ,MEEP
" explodes into action! It dances around the snake, fluttering off the walls as it tries to grab the hissing reptile in its beak. But the room isn't big enough to support this style of attack; and after a few very close calls, the "
D ,MEEP " abandons the fray">)>
		<TELL " and retreats with a squall of frustration." CR>
		<RTRUE>)

	       (T
		<MOVE ,MEEP ,HERE>
		<MEEP-ARRIVES>
		<RTRUE>)>>

<ROUTINE EXIT-MEEP ()
	 <DEQUEUE I-TMEEP>
	 <VANISH ,MEEP>
	 <RTRUE>>

<ROUTINE MEEP-SEES-DOG ("AUX" X)
	 <MAKE ,DOG ,SEEN>
	 <TELL ,CTHEMEEP>
	 <COND (<NOT <IS? ,DOG ,BORING>>
		<MAKE ,DOG ,BORING>
		<UNMAKE ,W100 ,TOUCHED>
		<MAKE ,DOG ,WINDY>
		<SET X <FIRST? ,MEEP>>
		<TELL "notices the " D ,DOG>
		<COND (<T? .X>
		       <MOVE .X ,W100>
		       <TELL ", drops " THE .X>)>
		<TELL
" and perches on its massive head. You stifle a shriek as the silly bird cocks its head this way and that, wondering what to make of the sleeping monster. Then it gives you a sly glance, ruffles its feathers and begins to peck at the sand fleas behind the dog's ears." CR>
		<RTRUE>)>
	 <TELL "remembers an especially tasty sand flea, returns to the dog's head and continues pecking where it left off" ,PCR>
	 <LAST-PECK>
	 <RTRUE>>

<ROUTINE LAST-PECK ()
	 <TELL
"The shepherd lifts an eyelid and peeks up at the bird">
	 <COND (<IS? ,DOG ,WINDY>
		<TELL " perched on its head">)>
	 <TELL
". Its expression hardens from sleepy distraction to annoyance... and then to outrage!|
|
In a single motion, the monster bounds to its feet and snaps at the "
D ,MEEP ,PTHE "bird digs deep and holds on for dear life as the dog whirls in a frenzied circle, trying to throw off the squalling pest.|
|
Then the dog sees you." CR>
	 <DOG-ALERT>
	 <RTRUE>>

<ROUTINE SAY-PECKS ("OPTIONAL" (CR T) "AUX" X)
	 <MAKE ,LEM ,SEEN> ; "Shut up the lemming."
	 <UNMAKE ,MEEP ,SEEN>
	 <UNMAKE ,DOG ,WINDY>
	 <SET X <FIRST? ,MEEP>>
	 <COND (<T? .X>
		<MOVE .X <LOC ,MEEP>>
		<TELL "drops " THE .X " and ">)>
	 <COND (<ZERO? ,APPETITE>
		<SETG APPETITE 4>
		<TELL "begins to peck at ">)
	       (T
		<UPDATE-APPETITE>
		<TELL <PICK-NEXT ,PECKINGS>>)>
	 <TELL "the ">
	 <COND (<AND <ZERO? ,APPETITE>
		     <ZERO? ,CCNT>>
		<TELL "last few ">)>
	 <TELL "crumbs in the bag.">
	 <COND (<T? .CR>
		<CRLF>)>
	 <RTRUE>>

<GLOBAL PECKINGS:TABLE
	<LTABLE 2
	 "pecks contentedly at " "gobbles down " "snaps up ">>

<ROUTINE UPDATE-APPETITE ()
	 <UNMAKE ,DOG ,WINDY>
	 <DEC APPETITE>
	 <COND (<ZERO? ,APPETITE>
		<EMPTY-BAG>
		<RTRUE>)
	       (<EQUAL? ,APPETITE ,CCNT>
		<RTRUE>)
	       (<G? ,CCNT 1>
		<DEC CCNT>
		<RTRUE>)
	       (T
		<SETG CCNT 1>)>
	 <RTRUE>>

<ROUTINE MEEP-ARRIVES ()
	 <MAKE ,LEM ,SEEN>
	 <MAKE ,MEEP ,SEEN>
	 <UNMAKE ,DOG ,WINDY>
	 <TELL CR ,CTHEMEEP>
	 <COND (<PROB 30>
		<TELL "reappears">
		<COND (<PROB 50>
		       <TELL " at your side">)>)
	       (T
		<TELL <PICK-NEXT <GET ,MEEP-TABLE 4>> "s ">
		<COND (<PROB 50>
		       <TELL "into view">)
		      (T
		       <TELL "to your side">)>)>
	 <PRINT ,PERIOD>
	 <COND (<AND <VISIBLE? ,BAG>
		     <NOT <IN? ,BAG ,PLAYER>>>
		<MEEP-SEES-BAG>)
	       (<AND <HERE? W100>
		     <IN? ,DOG ,HERE>>
		<CRLF>
		<MEEP-SEES-DOG>)>
	 <RTRUE>>

<ROUTINE RANCH-OPEN? ()
	 <COND (<OR <IS? ,NEROOM-DOOR ,OPENED>
		    <IS? ,SEROOM-DOOR ,OPENED>
		    <IS? ,SWROOM-DOOR ,OPENED>
		    <IS? ,NROOM-DOOR ,OPENED>
		    <IS? ,BROOM-DOOR ,OPENED>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MEEP-ESCAPES ("AUX" (DOOR <>))
	 <UNMAKE ,MEEP ,TOUCHED>
	 <UNMAKE ,MEEP ,SEEN>
	 <MAKE ,LEM ,SEEN> ; "Shut up the lemming."
	 <SETG APPETITE <>>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <COND (<HERE? ON-CIST IN-CIST>
		<MOVE ,MEEP ,SCIST>
		<TELL "flutters out of the " D ,RESERVOIR
		      " and disappears." CR>
		<RTRUE>)
	       (<HERE? IN-MILL>
		<MOVE ,MEEP ,UNDERM>
		<TELL "leaps over the " D ,LANDING
		      "'s edge and flutters" ,OUTASITE>
		<RTRUE>)
	       (<HERE? IN-JEEP>
		<MOVE ,MEEP ,N75>
		<TELL "leaps out of the jeep." CR>
		<RTRUE>)
	       (<SEE-SNAKE?>
		<MOVE ,MEEP ,SEROOM>
		<TELL "narrowly escapes the fangs of the " D ,SNAKE
		      ". It races away with a fearful squawk." CR>
		<RTRUE>)
	       (<AND <VISIBLE? ,BAG>
		     <NOT <IN? ,BAG ,PLAYER>>>
		<MOVE ,MEEP ,HERE>
		<TELL "lands at your feet." CR>
		<MEEP-SEES-BAG>
		<RTRUE>)
	       (<HERE? IHOUSE IN-HALL>
		<MOVE ,MEEP ,NWYARD>
		<TELL "scoots ">
		<COND (<HERE? IHOUSE>
		       <TELL "up the stairs." CR>
		       <RTRUE>)
		      (T
		       <TELL "off down the hall." CR>)>
		<RTRUE>)
	       (<OR <AND <HERE? IN-CLOSET>
		     	 <IS? ,CLOSET-DOOR ,OPENED>>
		    <HERE? IN-BATH BROOM NROOM NWROOM SWROOM NEROOM SEROOM>>
		<COND (<AND <HERE? NEROOM>
			    <NOT <IS? ,NEROOM-DOOR ,OPENED>>>
		       <SET DOOR ,NEROOM-DOOR>)
		      (<AND <HERE? SEROOM>
			    <NOT <IS? ,SEROOM-DOOR ,OPENED>>>
		       <SET DOOR ,SEROOM-DOOR>)
		      (<AND <HERE? SWROOM>
			    <NOT <IS? ,SWROOM-DOOR ,OPENED>>>
		       <SET DOOR ,SWROOM-DOOR>)
		      (<AND <HERE? NROOM>
			    <NOT <IS? ,NROOM-DOOR ,OPENED>>>
		       <SET DOOR ,NROOM-DOOR>)>
		<COND (<T? .DOOR>
		       <MAKE .DOOR ,OPENED>
		       <TELL "nudges open " THE .DOOR
			     ". It gives you a sly glance before it ">)>
		<MOVE ,MEEP <COND (<RANCH-OPEN?> ,ERANCH)
				  (<HERE? IN-BATH> ,BROOM)
				  (T ,IN-BATH)>>
		<TELL "trots" ,OUTASITE>
		<RTRUE>)
	       (<HERE? IN-SHACK TOWER-PLAT ON-TOWER>
		<MOVE ,MEEP ,AT-ZERO>
		<TELL "disappears ">
		<COND (<HERE? IN-SHACK>
		       <TELL "to the west">)
		      (T
		       <TELL "over the side of the " D ,PLATFORM>)>
		<TELL ,PCR
"You hear a flurry of wings that quickly fades." CR>
		<RTRUE>)

	       (T
		<UNMAKE ,DOG ,WINDY>
		<MOVE ,MEEP ,HERE>
		<MAKE ,MEEP ,SEEN>
		<SETG P-IT-OBJECT ,MEEP>
		<COND (<ZERO? ,LIT?>
		       <TELL "scratches around in the darkness." CR>
		       <RTRUE>)
		      (T
		       <TELL <PICK-NEXT <GET ,MEEP-TABLE 3>> ,PERIOD>)>
		<COND (<AND <HERE? W100>
			    <IN? ,DOG ,HERE>>
		       <CRLF>
		       <MEEP-SEES-DOG>)>
		<RTRUE>)>>

<ROUTINE MEEP-SEES-BAG ("AUX" L)
	 <UNMAKE ,MEEP ,TOUCHED>
	 <UNMAKE ,DOG ,WINDY>
	 <SET L <LOC ,BAG>>
	 <COND (<AND <EQUAL? .L ,CAGE>
		     <NOT <IS? .L ,OPENED>>
		     <IS? ,BAG ,SEEN>>
		<RTRUE>)>
	 <TELL CR "The bird spies the " D ,EBAG>
	 <COND (<EQUAL? .L ,HERE>
		T)
	       (<IS? .L ,SURFACE>
		<MOVE ,MEEP .L>
		<TELL ". It leaps up onto " THE .L>)
	       (<NOT <IS? .L ,OPENED>>
		<MAKE ,BAG ,SEEN>
		<SETG APPETITE 0>
		<TELL " inside " THE .L ", and blinks at it hungrily." CR>
		<RTRUE>)
	       (T
		<MOVE ,MEEP .L>
		<TELL ". It leaps into " THE .L>)>
	 <TELL " and ">
	 <SAY-PECKS>
	 <RTRUE>>

<ROUTINE I-SNAKE ("OPTIONAL" (CR T))
	 <COND (<NOT <SEE-SNAKE?>>
		<MAKE ,SNAKE ,SEEN>
		<RFALSE>)
	       (<T? .CR>
		<CRLF>)>
	 <SETG P-IT-OBJECT ,SNAKE>
	 <COND (<IS? ,SNAKE ,SEEN>
		<UNMAKE ,SNAKE ,SEEN>
		<TELL CTHE ,SNAKE>
		<COND (<HERE? IN-CLOSET>
		       <TELL " lurks just outside the open door">)
		      (T
		       <TELL <PICK-NEXT ,SNAKE-DOINGS>>)>
		<TELL ,AS-IF "it's about to strike!" CR>
		<RTRUE>)>
	 <MAKE ,ANKLE ,SURFACE>
	 <QUEUE I-BITTEN 1>
	 <TELL CTHE ,SNAKE
" strikes " D ,ANKLE " like lightning, recoils in an instant">
	 <SNAKE-LEAVES>
	 <TELL CR
"Sobbing with pain and shock, you peer at the tender wound. ">
	 <ITS-ALREADY "beginning to swell">
	 <RTRUE>>

<ROUTINE SEE-SNAKE? ()
	 <COND (<NOT <IS? ,SNAKE ,LIVING>>
		<RFALSE>)
	       (<HERE? NEROOM>
		<RTRUE>)
	       (<AND <HERE? IN-CLOSET>
		     <IS? ,CLOSET-DOOR ,OPENED>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL SNAKE-DOINGS:TABLE
	<LTABLE 2
	 " rears its wedge-shaped head"
	 " flicks its tongue in and out"
	 " hisses a threat">>

<ROUTINE SNAKE-LEAVES ()
	 <UNMAKE ,SNAKE ,LIVING>
	 <REMOVE ,XSNAKE>
	 <VANISH ,SNAKE>
	 <DEQUEUE I-SNAKE>
	 <PUTP ,NEROOM ,P?ODOR 0>
	 <PUTP ,NEROOM ,P?HEAR 0>
	 <PUTP ,IN-CLOSET ,P?ODOR 0>
	 <PUTP ,IN-CLOSET ,P?HEAR 0>
	 <TELL " and slithers" ,OUTASITE>
	 <RTRUE>>

<ROUTINE I-BITTEN ("OPTIONAL" (CR T))
	 <COND (<T? .CR>
		<CRLF>)>
	 <TELL
"The throbbing fire in your ankle overcomes you. Moaning with despair, you sink helplessly to the ">
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL D ,FLOOR>)
	       (T
		<TELL D ,GROUND>)>
	 <TELL ,PCR>
	 <COND (<G? ,MINUTES 27>
		<TELL "Moment">)
	       (T
		<TELL "Minute">)>
	 <TELL "s later, ">
	 <DO-KABOOM>
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE I-TUNNEL ("OPTIONAL" (CR T))
	 <COND (<ZERO? ,MINUTES>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<HERE? TUN1>
		       <TELL CTHE ,UBOMB " erupts ">)
		      (T
		       <TELL "For a brief moment, the " D ,TUNNEL
			     " is bathed ">)>
		<TELL "in a raw white glare.">
		<JIGS-UP>
		<RTRUE>)
	       (<OR <IS? ,WSWITCH ,OPENED>
		    <NOT <VISIBLE? ,WTK>>>
		<RFALSE>)
	       (<OR <NOT <EQUAL? ,TFREQ 42>>
		    <NOT <IS? ,ANTENNA ,OPENED>>>
		<COND (<T? ,QUIET?>
		       <RFALSE>)
		      (<T? .CR>
		       <COND (<EQUAL? ,SECONDS 0 30>
			      <RFALSE>)
			     (T
			      <CRLF>)>)>
		<MAKE ,WTK ,SEEN>
		<TELL CTHE ,WTK <PICK-NEXT ,HISSES> ,PERIOD>
		<RTRUE>)
	       (<ZERO? ,SECONDS>
		<MAKE ,WTK ,SEEN>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<NOT <IS? ,WTK ,SHADOWY>>
		       <MAKE ,WTK ,SHADOWY>
		       <TELL "A tinny voice, half-buried in static, says ">)>
		<TELL "\"" <GET <GET ,WTK-TABLE 0> <- 60 ,MINUTES>> ".\"" CR>
		<RTRUE>)
	       (<OR <ZERO? .CR>
		    <EQUAL? ,SECONDS 30>>
		<COND (<T? .CR>
		       <CRLF>)>
		<MAKE ,WTK ,SEEN>
		<TELL CTHE ,WTK <PICK-NEXT ,HISSES> ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL WTK-TABLE:TABLE
	<PTABLE
	 <PTABLE "BUG!" "One" "Two" "Three" "Four" "Five" "Six"
		 "Seven" "Eight" "Nine" "Ten">
	 <LTABLE 2 " hisses" " says" " crackles" " chatters" " rasps"
		   " says" " buzzes" " chirps">>>

<GLOBAL HISSES:TABLE
	<LTABLE 2 " hisses quietly" " emits a burst of static"
		  " crackles for a moment" " clicks and hisses">>

<ROUTINE I-WTK ()
	 <COND (<AND <ZERO? ,QUIET?>
		     <NOT <IS? ,WSWITCH ,OPENED>>
		     <NOT <IS? ,WTK ,CHILLY>>
		     <NOT <IS? ,WTK ,SEEN>>
		     <VISIBLE? ,WTK>
		     <PROB 30>>
		<MAKE ,WTK ,SEEN>
		<TELL CR CTHE ,WTK <PICK-NEXT ,HISSES> ,PERIOD>
		<RTRUE>)>
	 <UNMAKE ,WTK ,SEEN>
	 <RFALSE>>

<ROUTINE I-FLARE ()
	 <COND (<AND <EQUAL? ,MINUTES 29>
		     <EQUAL? ,SECONDS 45>>
		<KABOOM>
		<RTRUE>)
	       (<AND <NOT <IS? ,HERE ,INDOORS>>
		     <EQUAL? ,MINUTES 24 27 28>
		     <EQUAL? ,SECONDS 45>>
	      	<COND (<EQUAL? ,MINUTES 24>
		       <COND (<HERE? S100 W100>
			      <CRACKLES "five">
			      <FIVE-MINUTE-WARNING>)>
		       <FIRST-SEE-FLARE>
		       <TELL " curves in a graceful arc and fades." CR>
		       <RTRUE>)
		      (<EQUAL? ,MINUTES 27>
		       <COND (<HERE? S100 W100>
			      <CRACKLES "two">
			      <TWO-MINUTE-WARNING>
			      <COND (<HERE? W100>
				     <HINGE-SQUEAK>
				     <RTRUE>)>
			      <TELL CR
"The GIs hurry out of their jeeps and take cover in some " D ,TRENCHES
" nearby." CR>)>
		       <PUTP ,W100 ,P?ODOR 0>
		       <PUTP ,W100 ,P?HEAR 0>
		     ; <SETG DISTRACTION 0>
		       <REMOVE ,DOG>
		       <DEQUEUE I-DOG>
		       <COND (<IS? ,FLARE ,NODESC>
			      <FIRST-SEE-FLARE>)
			     (T
			      <MAKE ,FLARE ,CHILLY>
			      <TELL CR
"Another " D ,FLARE " arcs across the sky,">)>
		       <TELL " sputters prematurely and blinks out." CR>
		       <RTRUE>)
		      (T
		       <COND (<IS? ,FLARE ,NODESC>
			      <FIRST-SEE-FLARE>)
			     (T
			      <TELL CR "A ">
			      <COND (<IS? ,FLARE ,CHILLY>
			       	     <TELL "third ">)
			      	    (T
			       	     <TELL "second ">)>
			      <TELL D ,FLARE>)>
		       <TELL " arcs across the sky and disappears." CR>
		       <RTRUE>)>)
	       (T
		<RFALSE>)>>

<ROUTINE HINGE-SQUEAK ()
	 <TELL CR
"A hinge squeaks on the far side of the " D ,BHOUSE>
	 <COND (<IN? ,DOG ,W100>
		<TELL ". \"It's time, Wolf!\" calls a voice">)>
	 <TELL
". You stumble down the road, away from the crunch of footsteps." CR>
	 <HOLD-IT>
	 <KINDA-SPY>
	 <SURROUNDED>
	 <RTRUE>>

<ROUTINE FIRST-SEE-FLARE ()
	 <UNMAKE ,FLARE ,NODESC>
	 <TELL CR "A distant glare lights the " D ,GDESERT
"! You watch as a rocket " D ,FLARE " streaks upward,">
	 <RTRUE>>

<ROUTINE CRACKLES (STR)
	 <TELL CR
"A " D ,SPEAKER " crackles to life. \"Minus " .STR " minutes">
	 <RTRUE>>

<ROUTINE KABOOM ()
	 <TELL CR ,ALLATONCE>
	 <DO-KABOOM>
	 <RTRUE>>

<ROUTINE DO-KABOOM ()
	 <TELL "the ">
	 <COND (<HERE? IN-CLOSET IHOUSE>
		<TELL "cracks in the north wall are">
		<BLIGHT>)
	       (<HERE? UNDER-WATER>
		<TELL "water around you is">
		<BLIGHT>)
	       (<HERE? IN-HALL>
		<TELL "hallway is">
		<BLIGHT>)
	       (<HERE? IN-SHACK TOWER-PLAT ON-TOWER AT-ZERO N25 NZERO
		       NEZERO EZERO AT-TNT S25 W25 WZERO>
		<COND (<HERE? IN-SHACK>
		       <TELL D ,GADGET>)
		      (T
		       <COND (<NOT <HERE? ON-TOWER AT-ZERO TOWER-PLAT>>
			      <TELL "distant ">)>
		       <TELL D ,DTOWER>)>
		<DAZZLE>)
	       (<IS? ,HERE ,INDOORS>
		<TELL D ,WINDOWS " are">
		<BLIGHT>)
	       (T
		<TELL "desert around you">
		<DAZZLE>)>
	 <TELL "! You jam " D ,HANDS
"s over your eyes in the awful glare; never see the fireball closing in at many times the speed of sound; and never feel the stellar heat that annihilates ">
	 <MUCH-OF>
	 <RTRUE>>

<ROUTINE BLIGHT ()
	 <TELL " filled with light of startling intensity">
	 <RTRUE>>

<ROUTINE DAZZLE ()
	 <TELL " disappears in a flash of startling brilliance">
	 <RTRUE>>

<GLOBAL DISTRACTION:NUMBER 0> "Countdown timer for pooch distraction."
<GLOBAL TOLERANCE:NUMBER 4> "Stay in tower no more than 45 seconds."
<GLOBAL MLIVES:NUMBER 2> "Don't bother dog more than twice."

<ROUTINE I-TRINITY ("AUX" (W <>) (V <>) (Z <>) X )

       ; "Determine status of walkie-talkie."

	 <COND (<IS? ,WTK ,CHILLY> ; "No talkie if wet."
		T)
	       (<AND <NOT <IS? ,WSWITCH ,OPENED>>	; "Turned on?"
		     <VISIBLE? ,WTK>>			; "Hearable?"
		<COND (<AND <IS? ,ANTENNA ,OPENED>      ; "Antenna up?"
			    <IS? ,RDIAL ,SEEN>		; "Right freq?"
		     	    <EQUAL? ,TFREQ ,MAGICFREQ>>
		       <SET W T>
		       <UNMAKE ,WTK ,SEEN>)
	       	      (<T? ,QUIET?>
		       T)
		      (<IS? ,WTK ,SEEN>   ; "Delay."
		       <UNMAKE ,WTK ,SEEN>)
	       	      (<PROB 50> ; "Random talkie noise."
		       <SET V T>
		       <MAKE ,WTK ,SEEN>
		       <TELL CR CTHE ,WTK <PICK-NEXT ,HISSES>
			     ,PERIOD>)>)>

	; "Monitor BREAKER."

	 <COND (<IS? ,BREAKER ,OPENED>
		<COND (<IS? ,BREAKER ,BORING> ; "Opened more than once."
		       <COND (<T? .W>
			      <KSCRUB>)>
		       <POLICE-CONVERGE>
		       <RTRUE>)
		      (<IS? ,BREAKER ,SHADOWY>
		       <COND (<T? .W>
			      <TELL CR "\"Looks like a no-go without X">
	 		      <BITTER-VOICE>)>
		       <POLICE-CONVERGE>
		       <RTRUE>)>
		<MAKE ,BREAKER ,SHADOWY>
		<COND (<T? .W>
		       <SET V T>
		       <REVEAL-WIRE>)>)> ; "Second move."

	 <COND (<AND <HERE? ON-TOWER TOWER-PLAT>
		     <L? ,MINUTES 30>
		     <ZERO? ,DISTRACTION>>
		<DEC TOLERANCE>
		<COND (<ZERO? ,TOLERANCE>
		       <COND (<T? .W>
			      <NO-TOLERANCE>)>
		       <POLICE-CONVERGE>
		       <RTRUE>)
		      (<AND <T? .W>
			    <EQUAL? ,TOLERANCE 1>>
		       <SET V T>
		       <EYES-SEE-MOVEMENT>)>)>

       ; "Handle distraction."

	 <COND (<T? ,DISTRACTION>
		<DEC DISTRACTION>
		<COND (<ZERO? ,DISTRACTION>
		       <UNMAKE ,DOG ,NODESC>
		       <UNMAKE ,DOG ,SEEN>
		       <MAKE ,SPOT ,SEEN>
		       <UNMAKE ,TOWER-PLAT ,TOUCHED>
		       <UNMAKE ,ON-TOWER ,TOUCHED>
		       <UNMAKE ,IN-SHACK ,TOUCHED>
		       <COND (<T? .W>
			      <SET V T>
			      <SOME-BUZZARD>)>
		       <COND (<IN? ,CAGE ,W100>
			      <REMOVE ,CAGE>)>
		       <COND (<IN? ,WALLET ,W100>
			      <REMOVE ,WALLET>)>
		       <COND (<T? ,MLIVES>
			      <MOVE ,MEEP ,W75>)>
		       <COND (<HERE? W75 W50 W25>
			      <SET V T>
			      <COND (<AND <HERE? W75>
				   	  <T? ,MLIVES>>
			      	     <MEEP-ARRIVES>)>
			      <SPOT-SWEEPS "northeast">)
			     (<HERE? AT-ZERO ON-TOWER TOWER-PLAT IN-SHACK>
		       	      <SET V T>
			      <TELL CR CTHE ,SLIGHT
				    " sweeps back onto the tower." CR>)>)

		      (<EQUAL? ,DISTRACTION 2>
		       <UNMAKE ,SPOT ,SEEN>
		       <UNMAKE ,TOWER-PLAT ,TOUCHED>
		       <UNMAKE ,IN-SHACK ,TOUCHED>
		       <MAKE ,SLIGHT ,SEEN>
		       <COND (<T? .W>
			      <SET V T>
			      <HEAR-BARKING>)>
		       <COND (<HERE? W75 W50 W25>
			      <SET V T>
			      <SPOT-SWEEPS "southwest">)
			     (<HERE? AT-ZERO ON-TOWER TOWER-PLAT IN-SHACK>
		       	      <SET V T>
			      <TELL CR "The harsh light illuminating the "
D ,TOWER " sweeps away suddenly." CR>)>)

		      (T
		       <DEC MLIVES>
		       <COND (<ZERO? ,MLIVES>
			      <DEQUEUE I-TMEEP>
	 		      <REMOVE ,MEEP>
			      <MOVE ,FEATHERS ,W100>)>
		       <COND (<T? .W>
			      <SET V T>
		       	      <BARK-CONTINUES>)>
		       <COND (<AND <ZERO? ,MLIVES>
				   <HERE? W75 D5 D9>>
			      <SET V T>
			      <TELL CR
"A distant gunshot rings across the " D ,GDESERT ,PERIOD>)>)>)>

	 ; "Handle countdown."

	  <COND (<ZERO? .W>
		 <RETURN .V>)
		(<EQUAL? ,MINUTES 29>
		 <COND (<ZERO? ,SECONDS>
			<Z-MINUS-45>
			<RTRUE>)
		       (<EQUAL? ,SECONDS 15>
			<Z-MINUS-30>
			<RTRUE>)
		       (<EQUAL? ,SECONDS 30>
			<Z-MINUS-15>
			<RTRUE>)>
		 <FINAL-SECONDS>
		 <RTRUE>)
		(<EQUAL? ,MINUTES 9>
		 <DO-NINE>
		 <RTRUE>)
		(<EQUAL? ,MINUTES 28>
		 <DO-28>
		 <RTRUE>)
		(<AND <EQUAL? ,MINUTES 27>
		      <EQUAL? ,SECONDS 30>>
		 <TELL CR "\"Ninety seconds to auto-sequencer. Mark.\"" CR>
		 <RTRUE>)
		(<L? ,MINUTES 9>
		 <COND (<OR <T? ,QUIET?>
			    <T? .V>
			    <EQUAL? ,SECONDS 15 45>>
			<RFALSE>)>
		 <CRLF>
		 <COND (<ZERO? ,SECONDS>
			<TELL CTHE ,WTK <PICK-NEXT ,HISSES>
			      ,PERIOD>
			<RTRUE>)
		       (<PROB 50>
			<SET Z T>
			<COND (<PROB 50>
			       <COND (<PROB 50>
			       	      <TELL "A voice on the " D ,WTK>)
			      	     (T
			       	      <TELL CTHE ,WTK>)>
			       <TELL <PICK-NEXT <GET ,WTK-TABLE 1>> ", ">)
			      (T
			       <TELL CTHE ,WTK <PICK-NEXT ,HISSES> ". ">)>)>
		 <TELL "\"" <PICK-NEXT ,BABBLE>>
		 <COND (<OR <T? .Z>
			    <PROB 50>>
			<TELL ".\"" CR>
			<RTRUE>)>
		 <TELL ",\"" <PICK-NEXT <GET ,WTK-TABLE 1>>>
		 <COND (<PROB 50>
			<TELL " a voice on">)>
		 <TELL " the " D ,WTK ,PERIOD>
		 <RTRUE>)
		(<EQUAL? ,SECONDS 15>
		 <TELL CR <GET ,TECHNOBABBLE <- 27 ,MINUTES>> CR>
		 <RTRUE>)
		(<EQUAL? ,SECONDS 0 30>
		 <RFALSE>)
		(T
		 <SET X <- ,MINUTES 10>>
	   	 <TELL ,Z-MINUS <GET ,CDOWN .X> " minutes">
	   	 <COND (<HERE? W100 S100>
			T)
		       (<EQUAL? ,MINUTES 27>
			<TWO-MINUTE-WARNING>
			<TELL CR "A siren wails through the " D ,WTK ,PERIOD>
			<RTRUE>)
		       (<EQUAL? ,MINUTES 24>
			<FIVE-MINUTE-WARNING>
			<TELL CR CTHE ,WTK
" emits a short blast of distortion. It sounded like a siren." CR>
			<RTRUE>)>
		 <TELL ".\"" CR>)>
	  <RTRUE>>

<ROUTINE TWO-MINUTE-WARNING ()
	 <TELL
". All personnel whose duties do not specifically require otherwise will now assume a prone position, with face and eyes directed ">
	 <ITALICIZE "away">
	 <TELL " from Zero.\"" CR>
	 <RTRUE>>

<ROUTINE FIVE-MINUTE-WARNING ()
	 <TELL
". Personnel, prepare to assume safe positions.\"" CR>
	 <RTRUE>>

<GLOBAL BABBLE:TABLE
	<LTABLE 2
	 "Roger. Displacement, report"
	 "H-E secured"
	 "Baker, get calibration on the horn"
	 "SCR-299 checks, Able"
	 "Excess velocity is two baker. Repeat, two baker"
	 "We got confirmation from Carrizozo"
	 "The CITs are sittin' pretty, Baker"
	 "That's procurement's problem, not mine">>

<GLOBAL TECHNOBABBLE:TABLE
	<PTABLE
"\"Who's takin' care of the WACS in Fubar, Baker?\" (General laughter.)"

"You wince as the music's pitch wavers uncertainly."

"The talkie buzzes. \"Baker, can you get medic on a secure line?\""

"The talkie mutters, \"It'll never work.\""

"Faint strains of music swim in and out of static."

"\"Able to Baker. We got a breeze blowin' right in our face! Is TR-4 sleepin' down there?\"|
|
\"It's worse than that.\""

"\"Oscillograph check,\" squeaks the talkie."

"For a moment, the talkie's music is crystal clear. Then the strings break up into distortion."

"The talkie hisses; you make out the word \"condenser.\""

"\"No luck on that radiosonde.\"|
|
The talkie clicks twice. \"Keep on it.\""

"Persistent clicks modulate a passage of music."

"You hear a hearty guffaw on the talkie. \"Never get that one past CIC.\""

"\"Baker to Pittsburg. Did four-charlie get that radiosonde up yet?\"|
|
\"Ah, negative, Baker. Will advise.\""

"A distorted waltz competes with the hissing of the talkie."

"The talkie makes a sound like indigestion."

"\"Can't we nix that?\" complains the talkie as romantic strings fade in and out."

"The phrase \"gas for the generator\" emerges from a background of hiss."

"A lush string ensemble begin to swell above the talkie's hiss."

"Distant announcers rasp beneath a wash of static.">>

<ROUTINE DO-28 ()
	 <COND (<EQUAL? ,SECONDS 45>
		<TELL ,Z-MINUS
"one minute. Sequencer will assume control in fifteen seconds.\"" CR>
		<RTRUE>)>
	 <CRLF>
	 <COND (<ZERO? ,SECONDS>
		<TELL "\"Auto-sequencer in sixty.\"|
|
\"Roger. Six-oh seconds.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 15>
		<TELL "\"Forty-five seconds to auto-sequencer.\"" CR>
		<RTRUE>)>
	 <TELL
"The music on the " D  ,WTK
" distorts badly. \"Thirty seconds to auto-sequencer.\"" CR>
	 <RTRUE>>

<ROUTINE DO-NINE ()
	 <CRLF>
	 <COND (<ZERO? ,SECONDS>
		<TELL CTHE ,WTK
" whines softly. \""  D ,BAKER " to all units. Are we all in on this?\"" CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 15>
		<TELL
"\"" D ,ABLE " to "  D ,BAKER ". Us cowboys been waitin' all night.\"|
|
\"Roger, " D ,ABLE ".\"" CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 30>
		<TELL
"\"Everything's go at Forbes Field.\"|
|
\"Roger.\" (A pop of static.) \"It's time, gentlemen.\"" CR>
		 <RTRUE>)>
	 <TELL CTHE ,WTK
" emits a burst of interference, followed by faint strains of music. It's \"The Star-Spangled Banner.\"|
|
A lone voice speaks, half-buried in the melody. \"It is now zero minus twenty minutes.\"" CR>
	 <RTRUE>>

<ROUTINE SPOT-SWEEPS (STR)
	 <TELL CR "A " D ,SLIGHT " beam sweeps " .STR " across the "
	       D ,GDESERT ,PERIOD>
	 <RTRUE>>

<GLOBAL CDOWN:TABLE
	<PTABLE "nineteen" "eighteen" "seventeen" "sixteen" "fifteen"
		"fourteen" "thirteen" "twelve" "eleven" "ten" "nine"
		"eight" "seven" "six" "five" "four" "three" "two"
		"one" "[BUG!]">>

<ROUTINE REVEAL-WIRE ()
	 <TELL CR "\"What the... ?\" mutters the " D ,WTK ,PCR
"\"I didn't copy, " D ,BAKER ".\"|
|
\"Aw, hell.\" You hear a flurry of excited " D ,VOICES
". \"" D ,BAKER
" to all units. We have 100% continuity loss towerside. Repeat, ">
	 <ITALICIZE "zero">
	 <TELL " continuity.\"|
|
A chorus of expletives fills the airwaves. \"">
	 <COND (<G? ,MINUTES 28>
		<TELL "Is this a scrub, " D ,BAKER "?\"|
|
\"Affirmative, " D ,ABLE ". Sequencer's going. Too late to risk it. This is a scrub, everybody. Repeat, scrub it.\"" CR>
		<POLICE-CONVERGE>
		<RTRUE>)>
	 <TELL
"Check your idiot bulb, " D ,BAKER ". I replaced two duds last night.\"|
|
\"" D ,ABLE ", my bulb lights up real pretty. Is this a scrub?\"|
|
\"I dunno. Ask the kid if he reconnected the ">
	 <WIRE-ID>
	 <TELL " line on X after the continuity check.\"|
|
A burst of static. \"The kid ain't laughin', " D ,ABLE ".\"" CR>
	 <RTRUE>>

<ROUTINE WIRE-ID ()
	 <COND (<ZERO? ,XWIRE>
		<SETG XWIRE <PICK-ONE ,WIRE-COLORS>>)>
	 <COND (<EQUAL? ,XWIRE "POS">
		<TELL "positive">)
	       (<EQUAL? ,XWIRE "GND">
		<TELL "ground">)
	       (<EQUAL? ,XWIRE "INF">
		<TELL "informer">)
	       (T
		<TELL "detonator">)>
	 <RTRUE>>

<ROUTINE KSCRUB ("OPTIONAL" (WIN <>))
	 <TELL CR "\"X-unit just went out">
	 <COND (<IS? ,BREAKER ,BORING>
		<TELL " again">)>
	 <COND (<ZERO? .WIN>
		<BITTER-VOICE>
		<RTRUE>)>
	 <TELL ",\" shouts a voice.|
|
\"Which line is it, " D ,BAKER "?\"|
|
\"Kid's board says it's the ">
	 <WIRE-ID>
	 <TELL ,PTHE "others look okay. We're lettin' it go, "
D ,ABLE ,PTHE "sequencer's running.\"" CR CR CTHE ,WTK
<PICK-NEXT ,HISSES> ,PERIOD>
	 <RTRUE>>

<ROUTINE BITTER-VOICE ()
	 <TELL ", " D ,ABLE ".\"|
|
A steady hiss fills the silence. \"Damn,\" sobs a bitter voice.|
|
\"" D ,BAKER " to all units. This is a scrub, guys. Repeat, scrub it.\"" CR>
	 <RTRUE>>

<ROUTINE NO-TOLERANCE ()
	 <TELL CR
"\"" D ,PITTS " to all units. We've definitely got something moving on that "
D ,TOWER "!\"|
|
\"Roger. Attention, all units. Security alert. Scrub the shot and get Anderson out there. This is a scrub. Repeat, scrub.\"" CR>
	 <RTRUE>>

<ROUTINE EYES-SEE-MOVEMENT ()
	 <QUEUE I-EYE 1>
	 <TELL CR "\"" D ,PITTS " to " D ,ABLE ". ">
	 <COND (<NOT <IS? ,WIGHT ,LOCATION>>
		<MAKE ,WIGHT ,LOCATION>
		<TELL "One of our eyes just caught a movement on the tower. Can you confirm? Over.\"|
|
There's a brief pause. The " D ,WTK " crackles.|
|
\"Negative, " D ,PITTS ". What're you guys drinking down there?\"" CR>
		<RTRUE>)
	       (<NOT <IS? ,WIGHT ,LIGHTED>>
		<MAKE ,WIGHT ,LIGHTED>
		<TELL "We're still seein' spooks up on that tower.\"|
|
\"Sure it ain't one your buzzards, " D ,PITTS "?\"|
|
\"Har har, " D ,ABLE ". " D ,PITTS
", double-check and get back to us on that spook.\"|
|
\"Roger and out, " D ,BAKER ".\"" CR>
		<RTRUE>)>
	 <TELL "More movement towerside.\"|
|
\"This one better be good, " D ,PITTS ".\"|
|
\"Checkin' it twice, " D ,BAKER ". Stand by.\"" CR>
	 <RTRUE>>

<ROUTINE I-EYE ()
	 <COND (<HERE? ON-TOWER TOWER-PLAT>
		<RFALSE>)>
	 <TELL CR "\"" D ,PITTS " to " D ,BAKER ". ">
	 <COND (<NOT <IS? ,WIGHT ,LIGHTED>>
		<TELL "Whatever we saw up there went home">)
	       (T
		<TELL "Cancel that spook report">)>
	 <TELL ".\"|
|
\"Roger, " D ,PITTS ".\"" CR>
	 <RTRUE>>

<ROUTINE HEAR-BARKING ()
	 <CRLF>
	 <COND (<EQUAL? ,MLIVES 1> ; "2nd time around?"
		<TELL "More barking erupts from the " D ,WTK
		      ,PCR "\"Buzzards, " D ,PITTS "?\" smirks a voice.|
|
\"(Sigh.) Checkin' it out, " D ,BAKER ". Stand by.\"" CR>
		<RTRUE>)>
	 <TELL "A commotion of noise erupts from the " D ,WTK
". It sounds like a barking dog.|
|
\"" D ,PITTS " to all units.\" The voice is urgent.|
|
\"" D ,BAKER ". What's on, " D ,PITTS "?\"|
|
\"Stand by, " D ,BAKER ". Some kinda trouble outside.\"|
|
\"" D ,BAKER ", are we holding?\"|
|
\"Negative, " D ,ABLE ". No hold. " D ,PITTS
", get a line on that disturbance and report on the double.\"|
|
\"Will do. " D ,PITTS ".\"" CR>
	 <RTRUE>>

<ROUTINE BARK-CONTINUES ()
	 <TELL CR "The barking on the " D ,WTK
		  " continues for a few moments">
	 <COND (<ZERO? ,MLIVES>
		<TELL ". Then you hear a sharp ">
		<ITALICIZE "crack,">
		<TELL " and the barking stops." CR>
		<RTRUE>)>
	 <TELL ", then dies away." CR>
	 <RTRUE>>

<ROUTINE SOME-BUZZARD ()
	 <TELL CR "\"" D ,PITTS " to " D ,BAKER ".">
	 <COND (<ZERO? ,MLIVES>
		<TELL
"\" An evil chuckle. \"That buzzard ain't botherin' us again.\"" CR CR>)
	       (T
		<TELL
" Just some buzzard raisin' hell with the dog. I chased it away.\"|
|
A nervous chortle. ">)>
	 <TELL "\"Roger, " D ,PITTS ". Stand by.\"" CR>
	 <COND (<IN? ,CAGE ,W100>
		<TELL CR "\"Er, by the way. We got us a " D ,CAGE " out here">
		<COND (<IN? ,LEM ,CAGE>
		       <TELL " with a hamster inside">)>
		<TELL ". Anybody lose it?\"|
|
\"Nix the clowning, " D ,BAKER ".\"" CR>)>
	 <RTRUE>>

<ROUTINE Z-MINUS-45 ()
	 <TELL ,Z-MINUS "forty-five seconds. Commence auto-sequence.\"|
|
\"We copy, " D ,BAKER ". Sequencer affirmative. Good luck.\"" CR>
	 <RTRUE>>

<ROUTINE Z-MINUS-30 ()
	 <TELL ,Z-MINUS "thirty seconds. All personnel should face ">
	 <ITALICIZE "away">
	 <TELL " from Zero at this time.\"" CR>
	 <RTRUE>>

<ROUTINE Z-MINUS-15 ()
	 <TELL ,Z-MINUS
"fifteen seconds. Fourteen. Thirteen. Twelve. Eleven.\"" CR>
	 <RTRUE>>

<ROUTINE FINAL-SECONDS ()
	 <TELL ,Z-MINUS
"ten seconds. Nine seconds. Eight. Seven. Six. Five seconds. Four. Three. Two.\"|
|
You hear a loud ">
	 <ITALICIZE "clunk">
	 <TELL " at the word \"One.\"" CR>
	 <RTRUE>>

<ROUTINE I-BIKES ()
	 <COND (<HERE? LAN-WALK>
		<DEQUEUE I-BIKES>
		<MAKE ,BIKES ,SEEN>
		<TELL CR
"A young couple zooms down the " D ,LAN-WALK
" on bicycles. You watch them roll across the grass and disappear into the crowd." CR>
		<RTRUE>)>
	 <RFALSE>>

<GLOBAL WIGHTER:NUMBER 3>

<ROUTINE I-WIGHT ()
	 <COND (<NOT <HERE? IN-BARROW>>
		<RFALSE>)
	       (<ZERO? ,LIT?>
		<DEC WIGHTER>
		<CRLF>
		<COND (<EQUAL? ,WIGHTER 3>
		       <TELL
"Something is breathing in the darkness." CR>
		       <WIGHT-ID>)
		      (<EQUAL? ,WIGHTER 2>
		       <TELL "The breathing is getting closer." CR>)
		      (<EQUAL? ,WIGHTER 1>
		       <TELL
"Only a few feet lie between you and the breathing." CR>)
		      (T
		       <WIGHT-KILLS-YOU>
		       <RTRUE>)>
		<COND (<AND <IN? ,KEY ,KEYHOLE>
			    <NOT <IS? ,SLOPE ,OPENED>>>
		       <MOVE ,KEY ,WIGHT>
		       <TELL CR
"You hear a noise that sounds suspiciously like a "
D ,KEY " being drawn from a hole." CR>)>
		<RTRUE>)
	       (<IS? ,WIGHT ,SEEN>
		<UNMAKE ,WIGHT ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <TELL CR CTHE ,WIGHT <PICK-NEXT ,WIGHT-DOINGS> ,PERIOD>
	 <RTRUE>>

<GLOBAL WIGHT-DOINGS:TABLE
	<LTABLE 2
	 " studies you with its red eye"
	 " licks a stream of drool off its chin"
	 "'s breathing echoes in the tunnel"
	 " sharpens its claws on a rock"
	 " is watching you with interest"
	 " rubs its eye, then turns to squint at you"
	 " growls in its throat">>

<ROUTINE WIGHT-KILLS-YOU ()
	 <TELL
"Something sharp closes around your throat. It caresses your chin and the nape of your neck, delighting in the living warmth. Then, with a quick, practiced ">
	 <ITALICIZE "snap,">
	 <TELL " it breaks your neck at the collarbone.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE I-SLOPE ()
	 <COND (<AND <HERE? ICE-CAVE>
		     <IS? ,SLOPE ,OPENED>>
		<UNMAKE ,SLOPE ,OPENED>
		<TELL CR
"With a rusty creak, the " D ,SLOPE
" behind you retracts into the " D ,CEILING ,PA "clatter and ">
		<ITALICIZE "thump">
		<TELL
" fill the " D ,CAVE " with a sinister echo">
		<ALL-IS-STILL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-HARDHAT ("AUX" (V <>))
	 <COND (<VISIBLE? ,LAMP>
		<SET V T>)>
	 <DEC BEAM>
	 <COND (<ZERO? ,BEAM>
		<DEQUEUE I-HARDHAT>
		<UNMAKE ,LAMP ,LIGHTED>
		<COND (<T? .V>
		       <LAMPLIGHT "flickers and goes out">
		       <SAY-IF-HERE-LIT>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <HERE? IN-SHACK>
		     <IS? ,X5 ,OPENED>
		     <NOT <IS? ,WATT ,TOUCHED>>>
		<GET-WIRES>)>
	 <COND (<ZERO? .V>
		<RFALSE>)
	       (<EQUAL? ,BEAM 4>
		<LAMPLIGHT "is quite dim now">
		<RTRUE>)
	       (<EQUAL? ,BEAM 9>
		<LAMPLIGHT "is getting dimmer">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LAMPLIGHT (STR)
	 <TELL CR CTHE ,LAMP "'s light " .STR ,PERIOD>
	 <RTRUE>>

<ROUTINE I-DOG ()
	 <COND (<NOT <HERE? W100>>
		<RFALSE>)
	       (<IS? ,DOG ,SEEN>
		<UNMAKE ,DOG ,SEEN>
		<RFALSE>)
	       (<PROB 50>
		<RFALSE>)>
	 <MAKE ,DOG ,SEEN>
	 <TELL CR CTHE ,DOG <PICK-NEXT ,DOGGIE-DOOS> ,PERIOD>
	 <RTRUE>>

<GLOBAL DOGGIE-DOOS:TABLE
	<LTABLE 2
	 " twitches"
	 " growls softly"
	 " turns over"
	 " whines gently"
	 " snuffles"
	 " scratches itself">>

<ROUTINE I-VOICES ()
	 <COND (<HERE? ON-TOWER>
		<HOLD-IT>
		<TELL CR
"You hear boots stomping up the " D ,TLADDER ". Before you can move, an MP is shoving a barrel into the small of your back. ">
		<EXCUSES>
		<RTRUE>)
	       (<AND <HERE? TOWER-PLAT>
		     <IS? ,SPOT ,SEEN>>
		<DEC TOLERANCE>)>
	 <COND (<ZERO? ,MINUTES>
		<DEQUEUE I-VOICES>
		<QUEUE I-FLARE -1>
	 	<QUEUE I-TRINITY -1>
	 	<QUEUE I-DOG -1>
		<QUEUE I-OPPIE -1>
		<UNMAKE ,VOICES ,SEEN>
		<PUTP ,IN-SHACK ,P?HEAR 0>
		<PUTP ,TOWER-PLAT ,P?HEAR 0>
		<TELL CR
"You hear a motor revving to life below. One of the " D ,VOICES
" barks something; there's a squeal of rubber, and ">
		<COND (<HERE? IN-SHACK>
		       <TELL "the motor fades into the distance">
		       <ALL-IS-STILL>
		       <RTRUE>)>
		<TELL
"a jeep appears on the south road. You watch the headlights dwindle into the distance." CR>
		<RTRUE>)
	       (<EQUAL? ,MINUTES 58>
		<COND (<EQUAL? ,SECONDS 15>
		       <RFALSE>)
		      (<EQUAL? ,SECONDS 30>
		       <MAKE ,VOICES ,SEEN>
		       <TELL CR "A faint sound drifts ">
		       <COND (<HERE? IN-SHACK>
			      <TELL "in from somewhere outside">)
			     (T
			      <TELL "up from somewhere far below">)>
		       <TELL ". It sounded like a man's voice." CR>
		       <RTRUE>)>
		<TELL CR
"You hear the voice again, followed by a sharp clatter. There's definitely somebody ">
		<COND (<HERE? IN-SHACK>
		       <TELL "outside." CR>
		       <RTRUE>)>
		<TELL "down below." CR>
		<RTRUE>)>
	 <CRLF>
	 <COND (<ZERO? ,SECONDS>
		<TELL
"Another voice joins the first. You strain to listen.|
|
\"Towerside breaker closed. Check.\"|
|
\"" D ,PITTS "'s on the line, Lieutenant.\"|
|
\"Give him to me, Joe.\"" CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 15>
		<TELL
"A gust of wind obscures the conversation ">
		<COND (<HERE? IN-SHACK>
		       <TELL "outside">)
		      (T
		       <TELL "below">)>
		<TELL
" for a few moments. You can pick out the words \"focus,\" \"groves\" and \"surveillance,\" but little else." CR>
		<RTRUE>)
	       (<EQUAL? ,SECONDS 30>
		<MAKE ,SPOT ,SEEN>
		<UNMAKE ,TOWER-PLAT ,TOUCHED>
		<UNMAKE ,IN-SHACK ,TOUCHED>
		<TELL ,ALLATONCE "the ">
		<COND (<HERE? IN-SHACK>
		       <TELL D ,SHACK>)
		      (T
		       <TELL D ,PLATFORM>)>
		<TELL " is filled with light! It seems to be coming from ">
		<COND (<HERE? IN-SHACK>
		       <TELL "somewhere outside">)
		      (T
		       <TELL "a point on the southwest " D ,HORIZON>)>
		<TELL ".|
|
\"Lower!\" shouts one of the " D ,VOICES ".|
|
The light brightens to a hard, steady glare." CR>
		<RTRUE>)
	       (T
		<TELL
"The wind rises again, drowning out the " D ,VOICES " altogether." CR>)>
	 <RTRUE>>

<ROUTINE I-RCOUNT ("OPTIONAL" (CR T) "AUX" (X <>) STR)
	 <COND (<EQUAL? ,HOURS 15>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<HERE? ON-PLATFORM UNDER-PLAT>
		       <TELL
"\"Pyat, chetirye, tree, dva, adeen,\" barks the " D ,RSPEAKER ,PCR>)
		      (T
		       <TELL "A searing glare engulfs the mountaintops! ">)>
		<COND (<HERE? CLIFF-EDGE>
		       <TELL
"You turn, and stare in horror at a seething mass of flame billowing above the tundra.|
|
Seconds later, ">
		       <HURRICANE>
		       <CLIFF-DROWN>
		       <RTRUE>)>
		<TELL
"For an instant, you see your own " D ,DSHADOW
" cast in stark silhouette across the ">
		<COND (<HERE? ON-PLATFORM>
		       <TELL D ,PLATFORM>)
		      (T
		       <TELL D ,GROUND>)>
		<TELL ".">
		<COND (<HERE? ON-PLATFORM UNDER-PLAT>
		       <JIGS-UP>
		       <RTRUE>)>
		<TELL " Then ">
		<HURRICANE>
		<TELL "into oblivion.">
		<JIGS-UP>
		<RTRUE>)
	       (<NOT <HERE? ON-PLATFORM UNDER-PLAT>>
		<RFALSE>)>
	 <COND (<EQUAL? ,MINUTES 59>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<PROB 50>
		       <SET X T>
		       <RSPEAKER-BARKS>)>
		<SET STR <COND (<ZERO? ,SECONDS> "Shestdyesiat")
			       (<EQUAL? ,SECONDS 15> "Sorokpyat")
		      	       (<EQUAL? ,SECONDS 30> "Treetsat")
		      	       (T "Pyatnatsat")>>
		<TELL "\"" .STR " sekund">
		<COND (<OR <T? .X>
			   <PROB 50>>
		       <TELL ".\"" CR>)
		      (T
		       <BARKS-RSPEAKER>)>
		<COND (<VISIBLE? ,MAGPIE>
		       <TELL CR "\"" .STR " sekund,\""
			     <PICK-NEXT <GET ,PIE-TABLE 0>>
			     "s the " D ,MAGPIE ,PERIOD>)>
		<RTRUE>)
	       (<EQUAL? ,MINUTES 58>
		<COND (<ZERO? ,SECONDS>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <RSPEAKER-BARKS>
		       <TELL "\"Dva minut.\"" CR>
		       <RTRUE>)
		      (<EQUAL? ,SECONDS 30>
		       <COND (<T? .CR>
		       	      <CRLF>)>
		       <TELL "\"Dyevianosta sekund">
		       <BARKS-RSPEAKER>
		       <RTRUE>)>
		<RFALSE>)
	       (<ZERO? ,SECONDS>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<EQUAL? ,MINUTES 40>
		       <SET X T>
		       <TELL "A hidden " D ,RSPEAKER>
		       <SAY-BARKS>
		       <TELL " something incomprehensible. It sounded like ">)
		      (<PROB 50>
		       <SET X T>
		       <RSPEAKER-BARKS>)>
		<TELL "\"" <GET ,RMINUTES <- ,MINUTES 41>> " minut">
		<COND (<ZERO? .X>
		       <BARKS-RSPEAKER>
		       <RTRUE>)>
		<TELL ".\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RSPEAKER-BARKS ()
	 <TELL "A " D ,RSPEAKER>
	 <SAY-BARKS>
	 <TELL ", ">
	 <RTRUE>>

<ROUTINE BARKS-RSPEAKER ()
	 <TELL ",\"">
	 <SAY-BARKS>
	 <TELL " a " D ,RSPEAKER ,PERIOD>
	 <RTRUE>>

<ROUTINE SAY-BARKS ()
	 <COND (<PROB 50>
		<TELL " barks">
		<RTRUE>)>
	 <TELL " intones">
	 <RTRUE>>

<GLOBAL RMINUTES
	<PTABLE "Dyevianatsat" "Vosyemnatsat" "Syemnatsat" "Shestnatsat"
		"Pyatnatsat" "Chetirnatsat" "Treenatsat" "Dvenatsat"
		"Adeenatsat" "Dyesiat" "Dyeviat" "Vosyem" "Syem" "Shest"
		"Pyat" "Chetirye" "Tree" "[BUG!]">>

<ROUTINE HURRICANE ()
	 <TELL "a gale of radioactive debris sweeps you ">
	 <RTRUE>>

<GLOBAL OSC:NUMBER 16>

<ROUTINE I-OPPIE ("OPTIONAL" (CR T))
	 <DEC OSC>
	 <COND (<G? ,MINUTES 27>
		<COND (<G? ,OSC 8>
		       <DEQUEUE I-OPPIE>
		       <RFALSE>)
		      (<G? ,OSC 4>
		       <SETG OSC 4>)>)>
	 <COND (<EQUAL? ,OSC 4>
		<UNMAKE ,OPPIE ,NODESC>
		<COND (<NOT <HERE? S100>>
		       <RFALSE>)
		      (<T? .CR>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,OPPIE>
		<COND (<IS? ,OPPIE ,SEEN>
		       <TELL CTHE ,OPPIE " reappears">)
		      (T
		       <MAKE ,OPPIE ,SEEN>
		       <TELL
"A " D ,OPPIE " steps into view, standing just">)>
		<TELL " inside the " D ,SHELTER "'s " D ,SBENTRY ,PERIOD>
		<RTRUE>)
	       (<ZERO? ,OSC>
		<SETG OSC 16>
		<MAKE ,OPPIE ,NODESC>
		<COND (<NOT <HERE? S100>>
		       <RFALSE>)
		      (<T? .CR>
		       <CRLF>)>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<MAKE ,OPPIE ,SEEN>
		<TELL
"With a nervous sigh, the " D ,OPPIE
" disappears into the " D ,SHELTER ,PERIOD>
		<COND (<G? ,MINUTES 27>
		       <DEQUEUE I-OPPIE>)>
		<RTRUE>)
	       (<AND <L? ,OSC 4>
		     <HERE? S100>>
		<MAKE ,OPPIE ,SEEN>
		<SETG P-HIM-OBJECT ,OPPIE>
		<COND (<T? .CR>
		       <CRLF>)>
		<COND (<EQUAL? ,OSC 3>
		       <TELL
"Pushing back his porkpie hat, the " D ,OPPIE
" peers up at the overcast sky." CR>
		       <RTRUE>)
		      (<EQUAL? ,OSC 2>
		       <TELL
"You notice the " D ,OPPIE " glancing at his watch." CR>
		       <RTRUE>)>
		<TELL CTHE ,OPPIE
		      " draws thoughtfully on his pipe." CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE I-LUMP ("OPTIONAL" (V <>) "AUX" (OBJ <>) X Y)
	 <COND (<T? .V>
		T)
	       (<NOT <VISIBLE? ,LUMP>>
		<UNMAKE ,LUMP ,SEEN>
		<RFALSE>)>
	 <SET X <FIRST? ,PLAYER>>
	 <REPEAT ()
		 <COND (<OR <ZERO? .X>
			    <T? .OBJ>>
			<RETURN>)
		       (<EQUAL? .X ,LUMP>
			T)
		       (<IS? .X ,FERRIC>
			<SET OBJ .X>
			<RETURN>)
		       (<SEE-ANYTHING-IN? .X>
			<SET Y <FIRST? .X>>
			<REPEAT ()
				<COND (<ZERO? .Y>
				       <RETURN>)
				      (<EQUAL? .Y ,LUMP>
				       T)
				      (<IS? .Y ,FERRIC>
				       <SET OBJ .Y>
				       <RETURN>)>
				<SET Y <NEXT? .Y>>>)>
		 <SET X <NEXT? .X>>>
	 <COND (<ZERO? .OBJ>
		<RFALSE>)
	       (<T? .V>
		T)
	       (<IS? ,LUMP ,SEEN>
		<UNMAKE ,LUMP ,SEEN>
		<RFALSE>)
	       (<PROB 25>
		<RFALSE>)>
	 <SET X <LOC .OBJ>>
	 <MAKE ,LUMP ,SEEN>
	 <TELL CR "You can feel ">
	 <COND (<EQUAL? .X ,PLAYER>
		<TELL THE .OBJ>)
	       (T
		<TELL "something ">
		<COND (<IS? .X ,SURFACE>
		       <TELL " on ">)
		      (T
		       <TELL " in ">)>
		<TELL THE .X>)>
	 <TELL " pulling towards the " D ,LUMP ,PERIOD>
	 <RTRUE>>
