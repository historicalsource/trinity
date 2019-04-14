"THINGS for TR: (C)1986 Infocom, Inc. All rights reserved."

<OBJECT GTRINITY
	(LOC GLOBAL-OBJECTS)
	(DESC "Trinity")
	(SYNONYM TRINITY SITE GAME STORY)
	(ADJECTIVE TRINITY)
	(FLAGS NODESC NOARTICLE)
	(ACTION GTRINITY-F)>

<ROUTINE GTRINITY-F ()
	 <COND (<VERB? PLAY READ>
		<ALREADY-DOING-THAT>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<V-LOOK>
		<RTRUE>)
	       (T
		<USELESS>
		<RFATAL>)>>

<OBJECT LONDON
	(LOC LOCAL-GLOBALS)
	(DESC "London")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM LONDON CITY)
	(GENERIC GENERIC-LONDON-F)
	(ACTION LONDON-F)>

<OBJECT LCITY
	(LOC LOCAL-GLOBALS)
	(DESC "city")
	(FLAGS NODESC)
	(SYNONYM CITY)
	(GENERIC GENERIC-LONDON-F)
	(ACTION LONDON-F)>

<ROUTINE GENERIC-LONDON-F (TBL)
	 <RETURN ,LCITY>>

<ROUTINE LONDON-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE WATCH LOOK SEARCH LOOK-ON>
		<TELL "You're sick of looking at " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK-UNDER LOOK-OUTSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PATH
	(LOC GLOBAL-OBJECTS)
	(DESC "path")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM PATH PATHS ROAD ROADS TRAIL TRAILS FOOTPATH FOOTPATHS)
	(GENERIC GENERIC-WALK-F)
	(ACTION PATH-F)>

<ROUTINE PATH-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<V-WALK-AROUND>
		<RFATAL>)
	       (<VERB? LOOK-DOWN LOOK-UP LOOK-BEHIND LOOK-OUTSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH COUNT>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>
		    <VERB? FOLLOW CROSS STAND-ON CLIMB-OVER CLIMB-UP
			   CLIMB-DOWN TAKE USE RIDE>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>		       

<OBJECT METEOR
	(LOC GLOBAL-OBJECTS)
	(DESC "meteor")
	(FLAGS NODESC NOALL)
	(SYNONYM METEOR)
	(ACTION METEOR-F)>

"SEEN = gone, NOALL = delay flag for I-METEOR."

<ROUTINE METEOR-F ()
	 <COND (<IS? ,METEOR ,NOALL>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<IS? ,METEOR ,SEEN>
		<TELL ,CANT "see it anymore." CR>
		<RFATAL>)
	       (<VERB? EXAMINE WATCH WALK-TO FOLLOW FIND>
		<TELL CTHEO " is moving northeast." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SKY
	(LOC GLOBAL-OBJECTS)
	(DESC "sky")
	(FLAGS NODESC)
	(SYNONYM SKY CLOUD CLOUDS AIR ATMOSPHERE)
	(ACTION SKY-F)>

<ROUTINE SKY-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<CANT-SEE-FROM-HERE ,SKY>
		<RFATAL>)
	       (<HERE? IN-ORBIT ON-SAT>
		<COND (<STARS-F>
		       <RTRUE>)>
		<RFALSE>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<IN? ,METEOR ,GLOBAL-OBJECTS>
		       <PERFORM ,V?EXAMINE ,METEOR>)
		      (T
		       <TELL CTHE ,SKY " is ">
		       <COND (<IS? ,HERE ,CHILLY>
			      <TELL "gray and overcast." CR>)
			     (<OR <IS? ,HERE ,DESERT>
				  <HERE? IN-JEEP>>
			      <TELL "dark, with scattered clouds." CR>)
			     (T
			      <TELL "bright with sunshine." CR>)>)>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BREEZE
	(LOC GLOBAL-OBJECTS)
	(DESC "breeze")
	(FLAGS NODESC)
	(SYNONYM BREEZE WIND GUST)
	(ACTION BREEZE-F)>


<ROUTINE BREEZE-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL ,DONT "feel any" ,AT-MOMENT CR>
		<RFATAL>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<TELL "It's transparent." CR>
		<RTRUE>)
	       (<VERB? TOUCH REACH-IN LISTEN>
		<TELL "It ">
		<COND (<HERE? IN-SKY ON-BIRD>
		       <TELL "whips past ">)
		      (T
		       <TELL "whispers in ">)>
		<TELL "your ears." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? SMELL INHALE>
		<PERFORM ,V?SMELL ,ROOMS>
		<RTRUE>)>
	 <YOU-DONT-NEED ,BREEZE>
	 <RFATAL>>

<OBJECT HORIZON
	(LOC GLOBAL-OBJECTS)
	(DESC "horizon")
	(FLAGS NODESC)
	(SYNONYM HORIZON DISTANCE)
	(ACTION HORIZON-F)>

<ROUTINE HORIZON-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL ,CANT "see that from here." CR>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON SEARCH LOOK-INSIDE WATCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SUN
	(LOC GLOBAL-OBJECTS)
	(DESC "sun")
	(FLAGS NODESC)
	(SYNONYM SUN SUNSHINE SUNLIGHT)
	(ACTION SUN-F)>

"TOUCHED = sunset seen."

<ROUTINE SUN-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<CANT-SEE-FROM-HERE ,SUN>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-INSIDE>
	        <TELL CTHE ,SUN>
		<COND (<IS? ,HERE ,SHADOWY>
		       <TELL " broods silently in the "
			     <GET ,SHDIRS 2> "ern sky." CR>
		       <RTRUE>)
		      (<OR <IS? ,HERE ,DESERT>
			   <HERE? NSAND WSAND ESAND SSAND AT-SDOORS
			          IN-ORBIT ON-SAT IN-SHACK TOWER-PLAT
				  ON-TOWER ON-CIST IN-CIST IN-MILL>>
		       <TELL " is still below the " D ,HORIZON ,PERIOD>
		       <RTRUE>)
		      (<IS? ,HERE ,CHILLY>
		       <TELL " is hidden by the overcast." CR>
		       <RTRUE>)
		      (T
		       <TELL " is warm and bright." CR>)>
		<RTRUE>)
	       (<AND <VERB? TOUCH>
		     <EQUAL? ,P-PRSA-WORD ,W?FEEL>>
		<TELL "It feels warm." CR>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT GARDENS
	(LOC LOCAL-GLOBALS)
	(DESC "Kensington Gardens")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM GARDEN GARDENS KENSINGTON)
	(ADJECTIVE KENSINGTON)
	(ACTION GARDENS-F)>

<ROUTINE GARDENS-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? LION-GATE LAN-GATE PAL-GATE AT-TERRACE>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WRISTWATCH
	(LOC PLAYER)
	(DESC "wristwatch")
	(SYNONYM WRISTWATCH WATCH CLOCK TIME)
	(ADJECTIVE WRIST MY ELECTRONIC DIGITAL)
	(FLAGS TAKEABLE CLOTHING WORN CHILLY)
	(SIZE 1)
	(VALUE 0)
	(MASS 1)
	(GENERIC GENERIC-CLOCK-F)
	(ACTION WRISTWATCH-F)>

<ROUTINE WRISTWATCH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? READ LOOK-ON EXAMINE USE>
		<TELL "Your " D ,WRISTWATCH>
		<COND (<IS? ,HERE ,SHADOWY>
		       <TELL "'s digits are flashing randomly." CR>
		       <RTRUE>)>
		<TELL-TIME>
		<COND (<T? ,FREEZE?>
		       <TELL CR
"(That's odd. The \"seconds\" display has stopped working.)" CR>)>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH ADJUST>
		<FORGOT-HOW>
		<RTRUE>)
	       (<VERB? TURN-TO TUNE-TO>
		<COND (<PRSI? INTNUM INTDIR>
		       <FORGOT-HOW>
		       <RTRUE>)>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? CLOSE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		     		       
<ROUTINE FORGOT-HOW ()
	 <TELL "You forgot how to operate your electronic " D ,PRSO
	       " long ago." CR>
	 <RTRUE>>

<OBJECT COIN
	(LOC POCKET)
	(DESC "seven-sided coin")
	(FLAGS TAKEABLE)
	(SIZE 0)
	(MASS 0)
	(VALUE 0)
	(SYNONYM COIN P PENCE MONEY)
	(ADJECTIVE MY SEVEN SIDED SEVEN\-SIDED THIRTY FIFTY)
	(ACTION COIN-F)>

<ROUTINE COIN-F ()
	 <COND (<ADJ-USED? ,W?THIRTY>
		<TELL CTHE ,COIN " is worth fifty pence, not thirty." CR>
		<RFATAL>)
	       (<HANDLE-COIN? "fifty">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-COIN? ("OPTIONAL" (STR <>))
	 <COND (<AND <T? .STR>
		     <VERB? EXAMINE LOOK-ON READ>>
		<TELL "It's standard British currency, worth " .STR " pence">
		<COND (<IS? ,PRSO ,FLIPPED>
		       <TELL
". This one seems to have been minted backwards">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TURN>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <EQUAL? ,P-PRSA-WORD ,W?FLIP>>
		<COND (<DONT-HAVE? ,PRSO>
		       <RTRUE>)
		      (<PROB 50>
		       <TELL "Heads." CR>
		       <RTRUE>)>
		<TELL "Tails." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCOIN
	(DESC "small coin")
	(FLAGS TAKEABLE)
	(SIZE 0)
	(MASS 0)
	(VALUE 0)
	(SYNONYM COIN P PENCE MONEY CHANGE)
	(ADJECTIVE MY SMALL TINY TWENTY)
	(ACTION SCOIN-F)>

<ROUTINE SCOIN-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,SCOIN ,TOUCHED>>>
		<SETG LAYAWAY 3>
		<RFALSE>)
	       (<HANDLE-COIN? "twenty">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CREDIT-CARD
	(LOC POCKET)
	(DESC "credit card")
	(FLAGS TAKEABLE)
	(SIZE 0)
	(MASS 0)
	(VALUE 0)
	(SYNONYM CARD CODES)
	(ADJECTIVE MY CREDIT CHARGE)
	(ACTION CREDIT-CARD-F)>

 <ROUTINE CREDIT-CARD-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " is embossed ">
		<COND (<IS? ,PRSO ,FLIPPED>
		       <TELL "(backwards) ">)>
		<TELL "with the usual codes. It expires tomorrow." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PIGEONS
	(LOC LOCAL-GLOBALS)
	(DESC "pigeons")
	(FLAGS NODESC PLURAL TRYTAKE LIVING)
	(SYNONYM PIGEONS PIGEON BIRDS BIRD WINGS)
	(ADJECTIVE STARVING HUNGRY)
	(GENERIC GENERIC-BIRD-F)
	(ACTION PIGEONS-F)>

<ROUTINE PIGEONS-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO " stare back at you hungrily." CR>
		<RTRUE>)
	       (<FEED-THE-BIRDS?>
		<RTRUE>)	       
	       (<VERB? LISTEN>
		<TELL CTHEO " coo incessantly." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHE ,PIGEONS " coo in reply." CR>
		<RFATAL>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<TELL CTHE ,PIGEONS " deftly avoid you." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FEED-THE-BIRDS? ()
	 <COND (<THIS-PRSO?>
		<RFALSE>)
	       (<VERB? GIVE FEED>
		<COND (<PRSO? BAG>
		       <TAKE-CRUMBS>
		       <RTRUE>)
		      (T
		       <NOT-LIKELY ,PRSI
			"would be impressed by your offer">)>
		<RTRUE>)
	       (<AND <VERB? THROW THROW-OVER>
		     <PRSO? BAG>
		     <T? ,CCNT>>
		<TAKE-CRUMBS>
		<RTRUE>)
	       (<VERB? SHOW>
		<TELL CTHEI>
		<COND (<PRSO? BAG>
		       <COND (<PRSI? PIGEONS>
			      <TELL " strut">)
			     (T
			      <TELL " swim">)>
		       <TELL " about excitedly at the sight of ">)
		      (T
		       <TELL " don't seem to care about ">)>
		<TELL THEO ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FLWALK
	(LOC GLOBAL-OBJECTS)
	(DESC "Flower Walk")
	(FLAGS NODESC)
	(SYNONYM WALK PATH)
	(ADJECTIVE FLOWER)
	(GENERIC GENERIC-WALK-F)
	(ACTION FLWALK-F)>

<ROUTINE FLWALK-F ()
	 <COND (<NOT <HERE? PAL-GATE FLOWER-WALK>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-PLACE? ,FLOWER-WALK <> <> <> ,PAL-GATE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PGATE
	(LOC GLOBAL-OBJECTS)
	(DESC "Palace Gate")
	(FLAGS NODESC)
	(SYNONYM GATE)
	(ADJECTIVE PALACE)
	(GENERIC GENERIC-GATE-F)
	(ACTION PGATE-F)>

<ROUTINE PGATE-F ()
	 <COND (<NOT <HERE? PAL-GATE>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-GATES?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BLGATE
	(LOC GLOBAL-OBJECTS)
	(DESC "Black Lion Gate")
	(FLAGS NODESC)
	(SYNONYM GATE)
	(ADJECTIVE BLACK LION)
	(GENERIC GENERIC-GATE-F)
	(ACTION BLGATE-F)>

<ROUTINE GENERIC-GATE-F (TBL)
	 <COND (<EQUAL? ,P-IT-OBJECT ,BLGATE ,PGATE ,LGATE>
		<RETURN ,P-IT-OBJECT>)
	       (<HERE? LION-GATE>
		<RETURN ,BLGATE>)
	       (<HERE? PAL-GATE>
		<RETURN ,PGATE>)
	       (<HERE? LAN-GATE>
		<RETURN ,LGATE>)
	       (T
		<CANT-SEE-ANY>
		<RETURN ,NOT-HERE-OBJECT>)>>

<ROUTINE BLGATE-F ()
	 <COND (<NOT <HERE? LION-GATE>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-GATES?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LGATE
	(LOC GLOBAL-OBJECTS)
	(DESC "Lancaster Gate")
	(FLAGS NODESC)
	(SYNONYM GATE)
	(ADJECTIVE LANCASTER)
	(GENERIC GENERIC-GATE-F)
	(ACTION LGATE-F)>

<ROUTINE LGATE-F ()
	 <COND (<NOT <HERE? LAN-GATE>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-GATES?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-GATES? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<OR <ENTERING?>
		    <EXITING?>
		    <VERB? CROSS>>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? CLIMB-OVER CLIMB-ON CLIMB-UP LEAP>
		<TOURISTS-SNICKER>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-OUTSIDE WATCH>
		<DESCRIBE-GATE>
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL ,CANT "do that. ">
		<DESCRIBE-GATE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-GATE ()
	 <TELL "The gate is swarming with ">
	 <SAY-TOURISTS>
	 <TELL ,PERIOD>
	 <RTRUE>>

<ROUTINE TOURISTS-SNICKER ()
	 <TELL "Passersby ">
	 <COND (<ZERO? ,RAID?>
		<TELL "snicker at">)
	       (T
		<TELL "ignore">)>
	 <TELL " your hopeless attempt." CR>
	 <RTRUE>>

<OBJECT IFENCE
	(LOC LOCAL-GLOBALS)
	(DESC "iron fence")
	(FLAGS NODESC VOWEL)
	(SYNONYM FENCE)
	(ADJECTIVE IRON METAL)
	(ACTION IFENCE-F)>

<ROUTINE IFENCE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW-OVER>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is quite high." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND LOOK-OUTSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? CLIMB-OVER CLIMB-ON LEAP THROUGH>
		<TOURISTS-SNICKER>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT LNWALK
	(LOC GLOBAL-OBJECTS)
	(DESC "Lancaster Walk")
	(FLAGS NODESC)
	(SYNONYM WALK)
	(ADJECTIVE LANCASTER)
	(GENERIC GENERIC-WALK-F)
	(ACTION LNWALK-F)>

<ROUTINE GENERIC-WALK-F (TBL)
	 <COND (<EQUAL? ,P-IT-OBJECT ,FLWALK ,LNWALK ,BWALK>
		<RETURN ,P-IT-OBJECT>)
	       (<HERE? LAN-WALK LAN-GATE>
		<RETURN ,LNWALK>)
	       (<HERE? FLOWER-WALK>
		<RETURN ,FLWALK>)
	       (<HERE? BROAD-WALK PAL-GATE LION-GATE>
		<RETURN ,BWALK>)
	       (T
		<RETURN ,PATH>)>>	

<ROUTINE LNWALK-F ()
	 <COND (<NOT <HERE? LAN-WALK LAN-GATE FLOWER-WALK ROUND-POND>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-PLACE? ,LAN-WALK ,LAN-GATE ,LONG-WATER ,FLOWER-WALK
			       ,ROUND-POND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TERRACE
	(LOC GLOBAL-OBJECTS)
	(DESC "Inverness Terrace")
	(FLAGS NODESC VOWEL)
	(SYNONYM TERRACE)
	(ADJECTIVE INVERNESS)
	(ACTION TERRACE-F)>

<ROUTINE TERRACE-F ()
	 <COND (<NOT <HERE? AT-TERRACE>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	  
<OBJECT LWATER
	(LOC GLOBAL-OBJECTS)
	(DESC "Long Water")
	(FLAGS NODESC SURFACE CONTAINER OPENED)
	(SYNONYM WATER LAKE RIVER SERPENTINE)
	(ADJECTIVE LONG SERPENTINE)
	(CAPACITY 100)
	(GENERIC GENERIC-WATER-F)
	(ACTION LWATER-F)>
		
<ROUTINE GENERIC-WATER-F (TBL)
	 <COND (<EQUAL? ,P-IT-OBJECT ,RPOND ,GRPOND ,LWATER>		    
		<RETURN ,P-IT-OBJECT>)
	       (<HERE? ROUND-POND>
		<RETURN ,RPOND>)
	       (<OR <HERE? LAN-WALK LONG-WATER IN-WATER>
		    <EQUAL? ,W?LONG ,P-ADJ ,P-XADJ>>
		<RETURN ,LWATER>)
	       (<OR <HERE? BROAD-WALK>
		    <EQUAL? ,W?ROUND ,P-ADJ ,P-XADJ>>
		<RETURN ,GRPOND>)
	       (T
		<REFERRING>
		<RETURN ,NOT-HERE-OBJECT>)>>	       

<ROUTINE LWATER-F ()
	 <COND (<VERB? FIND>
		<COND (<HERE? LONG-WATER IN-WATER>
		       <ITS-RIGHT-HERE>
		       <RTRUE>)
		      (<HERE? LAN-WALK>
		       <SEE-IT-SPARKLE>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<NOT <HERE? LAN-WALK IN-WATER LONG-WATER>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON>
		<COND (<HERE? LONG-WATER>
		       <OPAQUE-WATER>
		       <RTRUE>)
		      (<HERE? IN-WATER>
		       <V-LOOK>
		       <RTRUE>)
		      (<HERE? LAN-WALK>
		       <SEE-IT-SPARKLE>
		       <RTRUE>)>
		<CANT-SEE-FROM-HERE ,LWATER>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER SEARCH>
		<COND (<HERE? LONG-WATER IN-WATER>
		       <OPAQUE-WATER>
		       <RTRUE>)>
		<CANT-SEE-FROM-HERE ,LWATER>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<HERE? LONG-WATER LAN-WALK>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)
		      (<HERE? IN-WATER>
		       <ALREADY-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? IN-WATER>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<NOT <HERE? LONG-WATER IN-WATER>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? SWIM DIVE LEAP CLIMB-DOWN STAND-UNDER>
		<DO-WALK <COND (<HERE? LONG-WATER> ,P?EAST)
			       (T ,P?DOWN)>>
		<RTRUE>)
	       (<HANDLE-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SEE-IT-SPARKLE ()
	 <TELL "You can see it sparkling">
	 <TWEEN-TREES <>>
	 <TELL ,TOE ,PERIOD>
	 <RTRUE>>

<OBJECT GRPOND
	(LOC GLOBAL-OBJECTS)
	(DESC "Round Pond")
	(FLAGS NODESC SURFACE OPENED CONTAINER)
	(SYNONYM POND WATER)
	(ADJECTIVE ROUND)
	(GENERIC GENERIC-WATER-F)
	(ACTION GRPOND-F)>

<ROUTINE GRPOND-F ()
	 <COND (<VERB? FIND>
		<COND (<HERE? BROAD-WALK>
		       <TELL ,YOU-SEE "it" ,TOE ,PERIOD>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<NOT <HERE? BROAD-WALK LAN-WALK LAN-GATE AT-TERRACE
			    LION-GATE WABE>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<ENTERING?>
		<DO-WALK <COND (<HERE? BROAD-WALK> ,P?EAST)
			       (<HERE? LAN-WALK> ,P?WEST)
			       (<HERE? AT-TERRACE> ,P?SOUTH)
			       (<HERE? WABE> ,P?NORTH)
			       (<HERE? LION-GATE> ,P?SE)
			       (T ,P?SW)>>
		<RTRUE>)
	       (T
		<CANT-FROM-HERE>
		<RTRUE>)>>

<OBJECT RPOND
	(LOC ROUND-POND)
	(DESC "Round Pond")
	(FLAGS WATERY NODESC SURFACE CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM POND WATER)
	(ADJECTIVE ROUND)
	(GENERIC GENERIC-WATER-F)
	(ACTION RPOND-F)>

<ROUTINE RPOND-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Ducks and swans paddle between the ">
		<COND (<T? ,RAID?>
		       <TELL D ,GDESERT "ed ">)>
		<TELL D ,BOAT " of the " D ,CHILDREN ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-ON LOOK-INSIDE SEARCH>
		<TELL "Aside from the birds and boats, you see ">
		<PRINT-CONTENTS ,PRSO>
		<TELL " on the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM TASTE>
		<TELL "The sight of a ">
		<COND (<T? ,RAID?>
		       <TELL "frightened ">)>
		<TELL 
"child relieving itself in the pond" ,CHANGES>
		<RTRUE>)
	       (<OR <GETTING-INTO?>
		    <VERB? SWIM DIVE>>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<HANDLE-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE HANDLE-WATER? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? TAKE PUSH-TO>			   
		       <RFALSE>)
		      (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<OR <PRSO? BALL CRANE>
			   	  <AND <PRSO? PARASOL>
				       <IS? ,PRSO ,OPENED>>>
		       	      <TELL CTHEO
				    " might float out of reach" ,IF-YOU-DID>
		       	      <RTRUE>)>
		       <VANISH>
		       <TELL CTHEO>
		       <COND (<PRSO? OCRANE BAD-CRANE>
		       	      <TELL " floats away ">)
		      	     (T
		       	      <TELL " disappears ">)>
		       <SAY-IN-WATER>
		       <RTRUE>)
		      (<OR <VERB? FILL>
			   <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		       <SPLASHES>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-UNDER>
		<OPAQUE-WATER>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? CLOSE OPEN OPEN-WITH>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<TELL CTHEO>
		<ISNT-ARENT>
		<TELL "very clean." CR>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<SPLASHES>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OPAQUE-WATER ()
	 <TELL "Little can be seen ">
	 <SAY-IN-WATER>
	 <RTRUE>>

<ROUTINE SAY-IN-WATER ()
	 <TELL "in the dark water." CR>
	 <RTRUE>>

<OBJECT CRANE
	(DESC "paper bird")
	(FLAGS TAKEABLE READABLE NODESC)
	(SYNONYM PAPER BIRD CRANE ORIGAMI WING WINGS WRITING WORDS)
	(ADJECTIVE FOLDED PAPER ORIGAMI)
	(VALUE 0)
	(SIZE 7)
	(MASS 1)
	(GENERIC GENERIC-BIRD-F)
	(ACTION CRANE-F)>

"NODESC = timing flag, LIGHTED = glowing, SEEN = just referenced."

<ROUTINE CRANE-F ()
	 <MAKE ,CRANE ,SEEN>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is ">
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL "twinkling." CR>
		       <RTRUE>)>
		<TELL "skillfully folded from a " D ,OCRANE
". Something is written between the folds." CR>
		<RTRUE>)
	       (<VERB? READ LOOK-ON LOOK-INSIDE SEARCH>
		<YOUD-HAVE-TO "unfold" ,PRSO>
		<RTRUE>)
	       (<VERB? UNFOLD OPEN OPEN-WITH>
		<COND (<AND <VERB? OPEN-WITH>
			    <NOT <PRSI? HANDS>>>
		       <TELL ,DONT "need " THEI
			     " to do that." CR>
		       <RTRUE>)
		      (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding" ,PRSO>
		       <RTRUE>)
		      (<CRANE-LIT?>
		       <RTRUE>)>
		<MOVE ,OCRANE ,PLAYER>
		<REMOVE ,PRSO>
		<SETG P-IT-OBJECT ,OCRANE>
		<TELL "You gently ">
		<PRINTB ,P-PRSA-WORD>
		<TELL " the " D ,PRSO " to its full size." CR>
	      ; <STOP-TWINKLE?>
		<RTRUE>)
	       (<VERB? FOLD CLOSE>
		<ITS-ALREADY "folded quite nicely, thank you">
		<RTRUE>)  
	       (<VERB? CUT RIP MUNG WRAP-AROUND>
		<RUIN-LOVELY-CRANE>
		<RTRUE>)
	       (<VERB? MUNG HIT SQUEEZE KICK SHAKE>
		<COND (<CRANE-LIT?>
		       <RTRUE>)>
		<MOVE ,BAD-CRANE <LOC ,PRSO>>
		<REMOVE ,PRSO>
		<SETG P-IT-OBJECT ,BAD-CRANE>
		<TELL "Done. All that's left is a " D ,BAD-CRANE ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? WATCH>
		     <IS? ,PRSO ,LIGHTED>>
		<UNMAKE ,PRSO ,CHILLY>
		<I-NEWCRANE <>>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <TELL "You lean over the edge of the " D ,RPOND
", and pluck the " D ,PRSO " out of the water." CR>
		       <UPDATE-SCORE 3>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RUIN-LOVELY-CRANE ()
	 <TELL "And ruin the lovely " D ,PRSO "? Unthinkable." CR>
	 <RTRUE>>

; <ROUTINE STOP-TWINKLE? ()
	 <COND (<IS? ,PRSO ,LIGHTED>
		<UNMAKE ,PRSO ,LIGHTED>
		<DEQUEUE I-NEWCRANE>
		<TELL CR 
"The edges of the paper stop twinkling." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT OCRANE
	(DESC "piece of paper")
	(FLAGS TAKEABLE READABLE TOUCHED CHILLY)
	(SYNONYM PAPER SHEET PIECE BIRD CRANE ORIGAMI WRITING WORDS)
	(ADJECTIVE PAPER ORIGAMI CREASED)
	(VALUE 0)
	(SIZE 3)
	(MASS 1)
	(GENERIC GENERIC-BIRD-F)
	(ACTION OCRANE-F)>

"CHILLY = not folded by girl."

<ROUTINE OCRANE-F ()
	 <COND (<HANDLE-OPEN-BIRD?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BAD-CRANE
	(DESC "crumpled piece of paper")
	(FLAGS TAKEABLE READABLE TOUCHED CHILLY)
	(SYNONYM PAPER SHEET PIECE BIRD CRANE ORIGAMI WRITING WORDS)
	(ADJECTIVE PAPER ORIGAMI CREASED CRUMPLED CRUSHED)
	(FDESC 0)
	(VALUE 0)
	(SIZE 3)
	(MASS 1)
	(GENERIC GENERIC-BIRD-F)
	(ACTION BAD-CRANE-F)>

"CHILLY = not folded by girl."

<ROUTINE BAD-CRANE-F ()
	 <COND (<HANDLE-OPEN-BIRD?>
		<RTRUE>)
	       (T
		<RFALSE>)>>  

<ROUTINE HANDLE-OPEN-BIRD? ()
	 <COND (<THIS-PRSI?>
	       	<RFALSE>)
	       (<VERB? READ LOOK-ON EXAMINE LOOK-INSIDE>
		<TELL "The words \"">
		<COND (<IS? ,PRSO ,FLIPPED>
		       <TELL "kcolC'O ruoF ,retaW gnoL">)
		      (T
		       <TELL "Long Water, Four O'Clock">)>
		<TELL "\" are scrawled on the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? WRAP-AROUND>
	        <COND (<PRSI? PRSO>
		       <EQUAL? <GET ,P-NAMW 1> ,W?BIRD ,W?CRANE ,W?ORIGAMI>
		       <FUMBLE>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<VERB? MUNG HIT SQUEEZE CUT RIP KICK SHAKE>
		<COND (<PRSO? OCRANE>
		       <RUIN-LOVELY-CRANE>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNFOLD>
		<ITS-ALREADY "unfolded">
		<RTRUE>)
	       (<VERB? FOLD REPAIR CLOSE>
		<FUMBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FUMBLE ()
	 <TELL "Your fumbling attempt to ">
	 <PRINTB ,P-PRSA-WORD>
	 <TELL " the paper back into a bird fails." CR>
	 <RTRUE>>

<OBJECT POND-BIRDS
	(LOC ROUND-POND)
	(DESC "wild birds")
	(FLAGS NODESC PLURAL LIVING)
	(SYNONYM BIRDS BIRD DUCKS DUCK SWANS SWAN WINGS)
	(ADJECTIVE WILD)
	(GENERIC GENERIC-BIRD-F)
	(ACTION POND-BIRDS-F)>

<ROUTINE POND-BIRDS-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO " stare back at you coolly." CR>
		<RTRUE>)
	       (<FEED-THE-BIRDS?>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " honk incessantly." CR>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <INTBL? ,PRSA ,TALKVERBS ,NTVERBS>>
		<TELL CTHE ,POND-BIRDS " honk in reply." CR>
		<RFATAL>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHE ,POND-BIRDS " paddle out of reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT BOAT 
	(LOC ROUND-POND)
	(DESC "toy boats")
	(FLAGS TRYTAKE NODESC PLURAL)
	(SYNONYM BOAT BOATS TOYS)
	(ADJECTIVE TOY)
	(ACTION BOAT-F)>

<ROUTINE BOAT-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO 
" are crafted of paper and sticks. They bob freely among the "
D ,POND-BIRDS ", who can barely conceal their outrage." CR>
		<RTRUE>)
	       (<VERB? SWIM DIVE WALK-TO FOLLOW SIT LIE-DOWN ENTER>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHE ,BOAT " are far out of reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 	
<OBJECT DIAL
	(LOC WABE)
	(DESC "sundial")
	(FLAGS TRYTAKE SURFACE NOALL)
	(CAPACITY 6)
	(SYNONYM SUNDIAL DIAL FACE SHADOW LEGEND WORDS SHAFT SUNLIGHT LIGHT)
	(ADJECTIVE SUN HANDSOME ANTIQUE GOLDEN)
        (DESCFCN DESCRIBE-DIAL)
	(ACTION DIAL-F)>

"TOUCHED = quote given."

<ROUTINE DESCRIBE-DIAL (CONTEXT)
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL 
"A shaft of golden sunlight falls across a handsome antique "
D ,DIAL ", erected at the exact center of the " D ,CLEARING>
		<LOOK-AT-DIAL ,DIAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DIAL-F ()
	 <COND (<NOUN-USED? ,W?SUNLIGHT ,W?LIGHT>
		<COND (<SUN-F>
		       <RTRUE>)>
		<USELESS>
		<RTRUE>)
	       (<OR <NOUN-USED? ,W?SHAFT>
		    <ADJ-USED? ,W?GOLDEN>>
		<USELESS>
		<RTRUE>)>
	 <RETURN <HANDLE-DIAL? ,DIAL>>> 

<OBJECT BDIAL
	(LOC ON-GNOMON)
	(DESC "sundial")
	(FLAGS TRYTAKE SURFACE NOALL)
	(CAPACITY 6)
	(SYNONYM SUNDIAL DIAL FACE SHADOW LEGEND WORDS)
	(ADJECTIVE SUN HANDSOME ANTIQUE)
	(DESCFCN DESCRIBE-BDIAL)
	(ACTION BDIAL-F)>

<ROUTINE LOOK-AT-DIAL (D "AUX" (ANY <>) (H <>))
	 <COND (<SEE-ANYTHING-IN? .D>
		<SET ANY T>)>
	 <COND (<OR <NOT <IN? ,GNOMON .D>>
		    <NOT <IS? ,GNOMON ,NODESC>>>
		<SET H T>)>
	 <COND (<OR <T? .ANY>
		    <T? .H>>
		<TELL ". " ,YOU-SEE>
		<COND (<T? .H>
		       <TELL A ,DIAL-HOLE>
		       <COND (<T? .ANY>
			      <TELL " along with ">)>)>
		<COND (<T? .ANY>
		       <PRINT-CONTENTS .D>)>
		<TELL " on the dial's face">)>
	 <TELL ".">
	 <RTRUE>>

<ROUTINE DESCRIBE-BDIAL ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "At the center of the " D ,PLATFORM
" stands a handsome antique " D ,BDIAL>
		<LOOK-AT-DIAL ,BDIAL>
		<TELL 
" The circumference is enclosed in a wide " D ,RING ".">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BDIAL-F ()
	 <COND (<NOUN-USED? ,W?SHADOW>
		T)
	       (<AND <THIS-PRSO?>
		     <VERB? TURN-TO TUNE-TO POINT-AT PUSH-TO TURN MOVE
			    LOOSEN SPIN PUSH SWING>>
	        <TELL CTHEO " is firmly imbedded in the " D ,PLATFORM
", and cannot be moved. But the " D ,RING " around its perimeter">
		<WOBBLES>
		<RTRUE>)>
	 <RETURN <HANDLE-DIAL? ,BDIAL>>>

<ROUTINE HANDLE-DIAL? (D "AUX" (G <>))
	 <COND (<AND <IN? ,GNOMON .D>
		     <IS? ,GNOMON ,NODESC>>
		<SET G T>)>
	 <COND (<NOUN-USED? ,W?SHADOW>
		<COND (<ZERO? .G>
		       <COND (<HERE? WABE>
			      <TELL ,CANT "see the " D ,DSHADOW " now." CR>
			      <RFATAL>)
			     (<DSHADOW-F>
			      <RTRUE>)>)
		      (<VERB? EXAMINE READ WATCH LOOK-INSIDE SEARCH>
		       <TELL CTHE ,DSHADOW>
		       <READ-DIAL>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		       <HOW?>
		       <RTRUE>)
		      (<ENTERING?>
		       <V-WALK-AROUND>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL "The perimeter of the " D ,PRSO
" is inscribed with seven curious " D ,SYMBOLS
" and a " D ROSE ", with the legend \"">
	 	<COND (<OR <PRSO? DIAL>
		    	   <ZERO? ,FLIP?>>
		       <TELL "TEMPUS EDAX RERUM">)
	       	      (T
		       <TELL "MURER XADE SUPMET">)>
	 	<TELL "\" emblazoned across the bottom. A ">
	 	<COND (<ZERO? .G>
		       <TELL D ,DIAL-HOLE 
			     " is set into the center of the dial">)
	       	      (T
		       <TELL "triangular " D ,GNOMON
		      	     " casts a fingerlike " D ,DSHADOW " that">
		       <READ-DIAL>)>
	 	<COND (<SEE-ANYTHING-IN? ,PRSO>
		       <TELL ". You also see ">
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " lying on top">)>
	 	<PRINT ,PERIOD>
	 	<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <SETG DO-WINDOW
			     <GET ,QUOTES <COND (<PRSO? DIAL> ,CARROLL)
						(T ,RIMBAUD)>>>
		       <RFATAL>)>
		<RTRUE>)
	       (<VERB? TAKE MOVE PUSH PULL RAISE TURN LOOSEN
		       UNSCREW UNSCREW-FROM TAKE-WITH>
		<TELL CTHEO " is firmly set into the ">
		<COND (<PRSO? DIAL>
		       <TELL D ,GROUND>)
		      (T
		       <TELL D ,PLATFORM>)>
		<TELL ". It cannot be moved." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<LOOK-UNDER-DIAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-UNDER-DIAL ()
	 <TELL "There's nothing " <PICK-NEXT ,YAWNS>>
	 <COND (<HERE? WABE>
		<TELL " in the " D ,CLEARING>)
	       (T
		<TELL " on the " D ,PLATFORM>)>
	 <TELL " around the " D ,DIAL ,PERIOD>
	 <RTRUE>>

<ROUTINE READ-DIAL ("AUX" DOOR)
	 <SET DOOR <GET ,OSIGN-DOORS ,OSIGN>>
	 <COND (<HERE? WABE>
		<TELL " is creeping slowly towards">)
	       (<T? ,SUN-MOVING?>
		<TELL " appears to be drifting slowly ">
		<COND (<AND <EQUAL? ,OSIGN 12>
			    <G? ,ODEG 6>>
		     ; <OR <EQUAL? ,OSIGN 13>
			   <AND <EQUAL? ,OSIGN 12>
				<G? ,ODEG 6>>>
		       <TELL "away from">)
		      (<ZERO? .DOOR>
		       <SAY-BETWEEN>
		       <RTRUE>)
		      (<EQUAL? ,ODEG 5 6>
		       <TELL "across">)
		      (<G? ,ODEG 6>
		       <TELL "away from">)
		      (T
		       <TELL "towards">)>)
	       (T
		<TELL " rests ">
		<COND (<AND <EQUAL? ,OSIGN 12>
			    <G? ,ODEG 6>>
		     ; <OR <EQUAL? ,OSIGN 13>
			   <AND <EQUAL? ,OSIGN 12>
				<G? ,ODEG 6>>>
		       <TELL "a little after">)
		      (<ZERO? .DOOR>
		       <SAY-BETWEEN>
		       <RTRUE>)
		      (<EQUAL? ,ODEG 5 6>
		       <TELL "exactly on">)
		      (<G? ,ODEG 6>
		       <TELL "a little after">)
		      (T
		       <TELL "a bit before">)>)>
	 <TELL " the " <GET ,SYMBOL-NAMES ,OSIGN> " symbol">
	 <RTRUE>>

<ROUTINE SAY-BETWEEN ()
	 <TELL "between the " <GET ,SYMBOL-NAMES ,OSIGN>
	       " and " <GET ,SYMBOL-NAMES <+ ,OSIGN 1>> 
	       " " D ,SYMBOLS>
	 <RTRUE>>

<GLOBAL SYMBOL-NAMES:TABLE
	<PTABLE "first" "first" "second" "second"
	        "third" "third" "fourth" "fourth" 
		"fifth" "fifth" "sixth" "sixth"
	        "seventh" "seventh" ; "seventh">>

<OBJECT RING
	(LOC BDIAL)
	(DESC "brass ring")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM RING ARROW POINTER INDICATOR)
	(ADJECTIVE BRASS METAL WIDE BROAD)
	(ACTION RING-F)>

"SEEN = arrow seen."

<ROUTINE RING-F ("AUX" (G <>) (A <>) X)
	 <COND (<AND <IN? ,GNOMON ,BDIAL>
		     <IS? ,GNOMON ,NODESC>>
		<SET G T>)>
	 <COND (<NOUN-USED? ,W?ARROW ,W?POINTER ,W?INDICATOR>
		<SET A T>)>
	 <COND (<AND <ZERO? .G>
		     <T? .A>>
		<TELL ,CANT "see that any">
		<COND (<IS? ,RING ,SEEN>
		       <TELL "mo">)
		      (T
		       <TELL "whe">)>
		<TELL "re." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE READ SEARCH>
		<COND (<T? .A>
		       <TELL "The arrow on the " D ,PRSO>
		       <READ-ARROW>
		       <RTRUE>)>
		<TELL CTHEO
		      " fits perfectly around the dial's perimeter">
		<COND (<T? .G>
		       <TELL ". It's inscribed with an arrow, which">
		       <READ-ARROW>
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TOUCH SHAKE SQUEEZE PLAY SWING KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO>
		<WOBBLES>
		<RTRUE>)
	       (<VERB? TURN-TO TUNE-TO POINT-AT PUSH-TO>
		<COND (<ZERO? .G>
		       <TELL CTHEO>
		       <COND (<IS? ,PRSO ,SEEN>
			      <TELL " no longer has any ">)
			     (T
			      <TELL " has no ">)>
		       <TELL "visible markings to use as a reference." CR>
		       <RTRUE>)
		      (<PRSI? BDIAL>
		       <COND (<EQUAL? <GET ,P-NAMW 1> ,W?SHADOW>
			      <TELL 
"The arrow already lies within the " D ,DSHADOW " on the " D ,GNOMON ,PERIOD>
			      <RTRUE>)>
		       <SPECIFY-SYMBOL>
		       <RFATAL>)
		      (<PRSI? SYMBOLS>
		       <SET X <GET ,P-ADJW 1>>
		       <SET X <COND (<EQUAL? .X ,W?FIRST ,W?OMEGA ,W?ONE>
				     0)
				    (<EQUAL? .X ,W?SECOND ,W?MERCURY ,W?TWO>
				     2)
				    (<EQUAL? .X ,W?THIRD ,W?PLUTO ,W?THREE>
				     4)
				    (<EQUAL? .X ,W?FOURTH ,W?NEPTUNE ,W?FOUR>
				     6)
				    (<EQUAL? .X ,W?FIFTH ,W?LIBRA ,W?FIVE>
				     8)
				    (<EQUAL? .X ,W?SIXTH ,W?MARS ,W?SIX>
				     10)
				    (<OR <EQUAL? .X ,W?SEVENTH ,W?ALPHA>
					 <EQUAL? .X ,W?SEVEN ,W?LAST>>
				     12)
				    (T 7)>>
		       <COND (<OR <EQUAL? .X 7>
				  <EQUAL? <GET ,P-NAMW 1>
					  ,W?SYMBOLS ,W?GLYPHS>>
			      <SPECIFY-SYMBOL>
			      <RFATAL>)
			     (<OR <EQUAL? ,OSIGN <+ .X 1>>
				  <AND <EQUAL? ,OSIGN .X>
				       <G? ,ODEG 4>>>
			      <TELL ,ARROW-ON "to the ">
			      <PRINTB <GET ,P-ADJW 1>>
			      <TELL " symbol." CR>
			      <RTRUE>)
			     (<IS? ,PRSO ,TOUCHED>
			      <SECOND-MOVE>)
			     (T
			      <FIRST-MOVE T>)>
		       <NEW-OSIGN .X>
		       <RTRUE>)
		      (<PRSI? INTDIR>
		       <SET X <COND (<EQUAL? ,P-DIRECTION ,P?NORTH> 6)
				    (<EQUAL? ,P-DIRECTION ,P?NE>
				     <COND (<ZERO? ,FLIP?> 8)
					   (T 4)>)
				    (<EQUAL? ,P-DIRECTION ,P?EAST>
				     <COND (<ZERO? ,FLIP?> 10)
					   (T 2)>)
				    (<EQUAL? ,P-DIRECTION ,P?SE>
				     <COND (<ZERO? ,FLIP?> 12)
					   (T 0)>)
				    (<EQUAL? ,P-DIRECTION ,P?SW>
				     <COND (<ZERO? ,FLIP?> 0)
					   (T 12)>)
				    (<EQUAL? ,P-DIRECTION ,P?WEST>
				     <COND (<ZERO? ,FLIP?> 2)
					   (T 10)>)
				    (<EQUAL? ,P-DIRECTION ,P?NW>
				     <COND (<ZERO? ,FLIP?> 4)
					   (T 8)>)
				    (T 7)>>
		       <COND (<EQUAL? .X 7>
			      <TELL CTHEO
				    " refuses to move that way." CR>
			      <RTRUE>)
			     (<OR <EQUAL? ,OSIGN <+ .X 1>>
				  <AND <EQUAL? ,OSIGN .X>
				       <G? ,ODEG 4>>>
			      <ALREADY-POINTING>
			      <RTRUE>)
			     (<IS? ,PRSO ,TOUCHED>
			      <SECOND-MOVE>)
			     (T
			      <FIRST-MOVE T>)>
		       <NEW-OSIGN .X>
		       <RTRUE>)
		      (<PRSI? INTNUM>
		       <COND (<L? ,P-NUMBER 1>
			      <SPECIFY-SYMBOL>
			      <RFATAL>)
			     (<G? ,P-NUMBER 7>
			      <TELL "There are only seven " D ,SYMBOLS
				    " on the " D ,DIAL ,PERIOD>
			      <RTRUE>)>
		       <SET X <* <- ,P-NUMBER 1> 2>>
		       <COND (<OR <EQUAL? ,OSIGN <+ .X 1>>
				  <AND <EQUAL? ,OSIGN .X>
				       <G? ,ODEG 4>>>
			      <ALREADY-POINTING>
			      <RTRUE>)
			     (<IS? ,PRSO ,TOUCHED>
			      <SECOND-MOVE>)
			     (T
			      <FIRST-MOVE T>)>
		       <NEW-OSIGN .X>
		       <RTRUE>)
		      (<PRSI? RIGHT>
		       <SET X <COND (<ZERO? ,FLIP?>
			      	     <COND (<G? ,OSIGN 10> 0)
				    	   (<EQUAL? ,OSIGN 0 1> 2)
				    	   (<MOD ,OSIGN 2> <+ ,OSIGN 1>)
				    	   (T <+ ,OSIGN 2>)>)
			     	    (T
			      	     <COND (<EQUAL? ,OSIGN 0 1> 12)
				    	   (<MOD ,OSIGN 2> <- ,OSIGN 3>)
				    	   (T <- ,OSIGN 2>)>)>>
		       <COND (<OR <EQUAL? ,OSIGN <+ .X 1>>
				  <AND <EQUAL? ,OSIGN .X>
				       <G? ,ODEG 4>>>
			      <ALREADY-POINTING>
			      <RTRUE>)
			     (<IS? ,PRSO ,TOUCHED>
			      <SECOND-MOVE>)
			     (T
			      <FIRST-MOVE T>)>
		       <NEW-OSIGN .X>
		       <RTRUE>)
		      (<PRSI? LEFT>
		       <SET X <COND (<ZERO? ,FLIP?>
			      	     <COND (<EQUAL? ,OSIGN 0 1> 12)
				    	   (<MOD ,OSIGN 2> <- ,OSIGN 3>)
				    	   (T <- ,OSIGN 2>)>)
			     	    (T
			      	     <COND (<G? ,OSIGN 10> 0)
				    	   (<EQUAL? ,OSIGN 0 1> 2)
				    	   (<MOD ,OSIGN 2> <+ ,OSIGN 1>)
				    	   (T <+ ,OSIGN 2>)>)>>
		       <COND (<OR <EQUAL? ,OSIGN <+ .X 1>>
				  <AND <EQUAL? ,OSIGN .X>
				       <G? ,ODEG 4>>>
			      <ALREADY-POINTING>
			      <RTRUE>)
			     (<IS? ,PRSO ,TOUCHED>
			      <SECOND-MOVE>)
			     (T
			      <FIRST-MOVE T>)>
		       <NEW-OSIGN .X>
		       <RTRUE>)		      
		      (T
		       <TELL CTHEO " can't be moved that way." CR>)>
		<RTRUE>)
	       (<VERB? TURN MOVE SPIN PUSH>
		<COND (<NOT <EQUAL? ,PRSI <> ,HANDS ,ROOMS>>
		       <TELL ,DONT "need " THEI " to ">
		       <PRINTB ,P-PRSA-WORD>
		       <TELL " the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<REPEAT ()
			<SET X <* <- <RANDOM 7> 1> 2>>
			<COND (<NOT <EQUAL? .X ,OSIGN>>
			       <RETURN>)>>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <FIRST-MOVE .G>)
		      (T
		       <TELL 
"The sun races across the sky as you casually spin the " D ,RING>
		       <COND (<T? .G>
			      <TELL ,PTHE "arrow ">
			      <NEW-OSIGN .X>
			      <RTRUE>)
			     (T
			      <PRINT ,PERIOD>)>)>
		<NEW-OSIGN .X .G>
		<RTRUE>)
	       (<VERB? TAKE RAISE UNPLUG LOWER PULL RELEASE UNSCREW LOOSEN
		       UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO ,BDIAL>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<COND (<ZERO? ,SUN-MOVING?>
		       <PRSO-NOT-MOVING>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WOBBLES ()
	 <TELL " wobbles a bit when you touch it." CR>
	 <RTRUE>>


<ROUTINE ALREADY-POINTING ()
	 <TELL ,ARROW-ON "in " D ,RIGHT ,PERIOD>
	 <RTRUE>>

<ROUTINE SPECIFY-SYMBOL ()
	 <TELL "[You must specify just ">
         <ITALICIZE "one">
	 <TELL " of the seven " D ,SYMBOLS " on the " D ,DIAL 
"; for example, TURN THE RING TO THE FOURTH SYMBOL or POINT THE ARROW TO OMEGA.]" CR>
	 <RTRUE>>

<ROUTINE READ-ARROW ()
	 <MAKE ,RING ,SEEN>
	 <TELL " is pointing to the " <GET ,SYMBOL-NAMES ,OSIGN>
	       " symbol on the dial." CR>
	 <RTRUE>>	

<ROUTINE FIRST-MOVE ("OPTIONAL" (P <>))
	 <MAKE ,RING ,TOUCHED>
	 <TELL "You grasp the edges of the " D ,RING
" and begin to turn it.|
|
An ominous vibration makes the " D ,PLATFORM
" tremble. Then a motion catches your eye" ,PCR>
	 <ITALICIZE "The sun is moving!">
	 <TELL
" It's arcing across the sky like a time-lapse movie, smooth and terribly silent.|
|
You let go of the ring with a cry. The sun instantly stops, and the strange vibration with it." CR>
	 <COND (<T? .P>
		<TELL CR
"After your pulse slows, you grasp the ring again and turn it, ever so carefully, until it ">)>
	 <RTRUE>>

<ROUTINE SECOND-MOVE ()
	 <TELL 
"The sun sweeps across the sky as you rotate the " D ,PRSO ". It ">
	 <RTRUE>>

<OBJECT DIAL-HOLE
	(LOC DIAL)
	(DESC "threaded hole")
	(FLAGS NODESC NOALL CONTAINER OPENED)
	(CAPACITY 0)
	(SIZE 0)
	(SYNONYM HOLE THREAD)
	(ADJECTIVE THREADED)
	(ACTION DIAL-HOLE-F)>

<ROUTINE DIAL-HOLE-F ()
	 <COND (<HANDLE-HOLE? ,DIAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BDIAL-HOLE
	(LOC BDIAL)
	(DESC "threaded hole")
	(FLAGS NODESC NOALL CONTAINER OPENED)
	(CAPACITY 0)
	(SIZE 0)
	(SYNONYM HOLE THREAD)
	(ADJECTIVE THREADED)
	(ACTION BDIAL-HOLE-F)>

<ROUTINE BDIAL-HOLE-F ()
	 <COND (<HANDLE-HOLE? ,BDIAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-HOLE? (D)
	 <COND (<AND <IN? ,GNOMON .D>
		     <IS? ,GNOMON ,NODESC>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT SCREW>
		       <COND (<PRSO? GNOMON>
		       	      <PERFORM ,V?SCREW ,GNOMON .D>
		       	      <RTRUE>)>
		       <PRSO-WONT-FIT>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PERFORM ,V?PUT-ON ,PRSO .D>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The hole has a ">
		<COND (<OR <HERE? WABE>
			   <T? ,FLIP?>>
		       <TELL "lef">)
		      (T
		       <TELL "righ">)>
		<EXAMINE-HOLE>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TOO-SMALL>
		<RTRUE>)
	       (<VERB? COVER>
		<PERFORM ,V?PUT-ON ,PRSO .D>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXAMINE-HOLE ()
	 <TELL "t-handed thread, and is set in the center of the dial." CR>
	 <RTRUE>>

<OBJECT ROSE
	(LOC LOCAL-GLOBALS)
	(DESC "compass rose")
	(FLAGS NODESC TRYTAKE NOALL READABLE)
	(SYNONYM ROSE HEADINGS HEADING)
	(ADJECTIVE COMPASS)
	(ACTION ROSE-F)>

<ROUTINE ROSE-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " on the dial appears quite ordinary">
		<COND (<AND <HERE? ON-GNOMON>
			    <T? ,FLIP?>>
		       <TELL 
", except that the headings are all backwards">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-GLYPHS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			   
<OBJECT SYMBOLS
	(LOC LOCAL-GLOBALS)
	(DESC "symbols")
	(FLAGS NODESC TRYTAKE NOALL READABLE PLURAL)
	(SYNONYM SYMBOLS SYMBOL GLYPHS GLYPH PERIMETER CHARACTER
	 	 INSCRIPTI WRITING)
	(ADJECTIVE SEVEN CURIOUS
	 	   ONE TWO THREE FOUR FIVE SIX SEVEN LAST
		   FIRST SECOND THIRD FOURTH FIFTH SIXTH SEVENTH
		   OMEGA MERCURY PLUTO NEPTUNE LIBRA MARS ALPHA)
	(ACTION SYMBOLS-F)>

<ROUTINE SYMBOLS-F ()
	 <COND (<VERB? EXAMINE READ LOOK-INSIDE SEARCH LOOK-UP>
		<TELL "The seven " D ,PRSO 
" are arranged in a circle. The series begins with a Greek omega and runs ">
		<COND (<T? ,FLIP?>
		       <TELL "counter">)>
		<TELL "clockwise around the dial, ending with a Greek alpha">
		<COND (<T? ,FLIP?>
		       <TELL ". All of the " D ,PRSO
			     " are inscribed backwards">)>
		<TELL ".|
|
[You'll find the " D ,PRSO " reproduced on the " D ,DIAL " in your ">
		<ITALICIZE "Trinity">
		<TELL " package.]" CR>
		<COND (<NOT <IS? ,PRSO ,SEEN>>
		       <MAKE ,PRSO ,SEEN>
		       <SETG DO-WINDOW <GET ,QUOTES ,MATTHEW>>
		       <RFATAL>)>		       
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "There are exactly seven." CR>
		<RTRUE>)
	       (<AND <VERB? TURN-TO TUNE-TO POINT-AT PUSH-TO>
		     <THIS-PRSI?>
		     <NOT <PRSO? RING BDIAL>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<HANDLE-GLYPHS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-GLYPHS? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW-OVER>
		       <COND (<HERE? ON-GNOMON>
		       	      <PERFORM ,PRSA ,PRSO ,BDIAL>
		       	      <RTRUE>)>
		       <PERFORM ,PRSA ,PRSO ,DIAL>
		       <RTRUE>)>
		<RFALSE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GNOMON
	(LOC DIAL)
	(DESC "gnomon")
	(FLAGS TAKEABLE NOALL NODESC FERRIC)
	(SYNONYM GNOMON METAL PIECE BOLT THREAD)
	(ADJECTIVE TRIANGULAR THREADED)
	(SIZE 4)
	(VALUE 5)
	(MASS 4)
	(GENERIC GENERIC-METAL-F)
	(ACTION GNOMON-F)>

"NODESC = gnomon screwed into face plate, SEEN = tried screw w/bad thread,
 BORING = noticed wobble."

<ROUTINE GNOMON-F ()
	 <COND (<NOUN-USED? ,W?BOLT ,W?THREAD>
		<COND (<IS? ,GNOMON ,NODESC>
		       <CANT-SEE-ANY>
		       <RFATAL>)
	       	      (<THIS-PRSI?>
		       <RFALSE>)
		      (<VERB? EXAMINE>
		       <TELL "The bolt has a ">
		       <COND (<IS? ,GNOMON ,FLIPPED>
		       	      <TELL "righ">)
		      	     (T
		       	      <TELL "lef">)>
		       <TELL "t-handed thread, and is ">
		       <ATTACHED-TO>
		       <RTRUE>)
	       	      (<AND <VERB? UNSCREW-FROM>
			    <PRSO? PRSI>>
		       <TELL "The bolt is ">
		       <ATTACHED-TO>
		       <RTRUE>)
		      (<VERB? TAKE MOVE PULL PUSH RAISE LOWER LOOSEN UNPLUG
			      TAKE-OFF SHAKE HIT KICK KNOCK SWING UNSCREW>
		       <TELL "The bolt is ">
		       <ATTACHED-TO>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"It's a triangular piece of metal, about a quarter-inch thick and four inches long">
		<COND (<IS? ,GNOMON ,NODESC>
		       <TELL ", screwed into the center of the " D ,DIAL>)
		      (T
		       <TELL ,PA "long bolt is welded to the bottom">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? UNSCREW SPIN TURN UNSCREW-FROM UNPLUG>
		     <IS? ,PRSO ,NODESC>>
		<COND (<VERB? UNSCREW-FROM>
		       <COND (<NOT <PRSI? DIAL BDIAL DIAL-HOLE BDIAL-HOLE>>
		       	      <RFALSE>)>)
		      (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		       <NOT-LIKELY ,PRSI "would help you move the gnomon">
		       <RTRUE>)>
		<MAKE ,PRSO ,BORING>
		<UNMAKE ,PRSO ,NODESC>
		<UNMAKE ,PRSO ,NOALL>
		<TELL "You can feel the " D ,PRSO
		      " getting more and more wobbly as you ">
		<PRINTB ,P-PRSA-WORD>
		<TELL
" it. A final twist, and it falls with a clatter onto the face of the "
D ,DIAL ,PERIOD>
		<COND (<HERE? ON-GNOMON>
		       <REMOVE ,LEVER>
		       <TELL CR CTHE ,RING " twinkles again as the " D ,LEVER>
		       <COND (<ZERO? ,SUN-MOVING?>
			      <SETG SUN-MOVING? T>
			      <TELL " straightens itself and">)>
		       <TELL " silently retracts into the " 
			     D ,FLOOR ,PERIOD>)>
		<RTRUE>)
	       (<AND <VERB? TAKE TOUCH MOVE LOOSEN PULL PUSH SHAKE
			    PUSH-TO RAISE KNOCK SQUEEZE SWING KICK PLAY>
		     <IS? ,PRSO ,NODESC>>
		<MAKE ,PRSO ,BORING>
		<TELL CTHEO " on the dial wobbles loosely when you ">
		<COND (<VERB? TOUCH PUSH SQUEEZE KICK KNOCK SHAKE SWING>
		       <PRINTB ,P-PRSA-WORD>)
		      (T
		       <TELL "try to move">)>
		<TELL " it." CR>
		<RTRUE>)
	       (<AND <VERB? SCREW PUT PUSH-TO PLUG>
		     <PRSI? DIAL BDIAL>>
		<COND (<G? <WEIGHT ,PRSI> 3>
		       <YOUD-HAVE-TO "clear off" ,PRSI>
		       <RTRUE>)
		      (<AND <PRSI? BDIAL>
			    <NOT <GNOMON-FITS?>>>
		       <COND (<NOT <IS? ,PRSO ,SEEN>>
			      <MAKE ,PRSO ,SEEN>
			      <TELL 
"You twist and push the " D ,PRSO " into the hole on the " D ,PRSI
", but it doesn't seem to fit very well. A quick glance shows the reason why. ">)>
		       <TELL 
"The thread on the bolt doesn't match the thread in the dial's hole." CR>
		       <RTRUE>)
		      (T
		       <MOVE ,GNOMON ,PRSI>
		       <MAKE ,GNOMON ,NODESC>
		       <MAKE ,GNOMON ,NOALL>
		       <TELL 
"You screw the " D ,GNOMON " into the hole on the " D ,DIAL ,PERIOD>
		       <COND (<HERE? ON-GNOMON>
			      <MOVE ,LEVER ,HERE>
			      <THIS-IS-IT ,LEVER>
			      <TELL CR "A long metal " D ,LEVER
" silently rises out of the " D ,FLOOR 
". As it clicks to a stop, the ring around the " D ,BDIAL 
" emits a brilliant twinkle of light." CR>
			      <COND (<NOT <IS? ,LEVER ,TOUCHED>>
				     <MAKE ,LEVER ,TOUCHED>
				     <UPDATE-SCORE 5>
				     <CRLF>
				     <VOICE-MUTTERS 
				      "The Gnomon Conquest" <>>)>)>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GNOMON-FITS? ()
	 <COND (<OR <AND <T? ,FLIP?>
		         <NOT <IS? ,GNOMON ,FLIPPED>>>
		    <AND <ZERO? ,FLIP?>
		         <IS? ,GNOMON ,FLIPPED>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LEVER
	(DESC "lever")
	(FLAGS TRYTAKE NOALL FERRIC)
	(SYNONYM LEVER)
	(ADJECTIVE LONG METAL)
	(DESCFCN DESCRIBE-LEVER)
	(ACTION LEVER-F)>

"TOUCHED = lever discovered."

<GLOBAL SUN-MOVING?:FLAG T>

<ROUTINE DESCRIBE-LEVER ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A long metal " D ,LEVER>
		<SAY-LEVER>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<ROUTINE SAY-LEVER ()
	 <TELL " stands ">
	 <COND (<ZERO? ,SUN-MOVING?>
		<TELL "at a sharp angle to ">)
	       (T
		<TELL "vertically out of ">)>
	 <TELL THE ,PLATFORM>
	 <PRINTC 46>
	 <RTRUE>>

<ROUTINE LEVER-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,LEVER " is about five feet long, and">
		<SAY-LEVER>
		<CRLF>
		<RTRUE>)
	       (<VERB? RAISE PULL LOOSEN>
		<COND (<ZERO? ,SUN-MOVING?>
		       <RAISE-LEVER>)
		      (T
		       <LEVER-MOVED "up">)>
		<RTRUE>)
	       (<VERB? LOWER PUSH>
		<COND (<ZERO? ,SUN-MOVING?>
		       <LEVER-MOVED "down">)
		      (T
		       <LOWER-LEVER>)>
		<RTRUE>)
	       (<VERB? MOVE TURN>
		<COND (<ZERO? ,SUN-MOVING?>
		       <RAISE-LEVER>)
		      (T
		       <LOWER-LEVER>)>
		<RTRUE>)
	       (<VERB? PUSH-TO>
		<COND (<PRSI? GROUND>
		       <PERFORM ,V?LOWER ,LEVER>
		       <RTRUE>)
		      (<NOT <PRSI? INTDIR>>
		       <CANT-PRSA-LEVER>
		       <TELL " to that." CR>
		       <RTRUE>)
		      (<EQUAL? ,P-DIRECTION ,P?UP>
		       <PERFORM ,V?RAISE ,LEVER>
		       <RTRUE>)
		      (<EQUAL? ,P-DIRECTION ,P?DOWN>
		       <PERFORM ,V?LOWER ,LEVER>
		       <RTRUE>)
		      (T
		       <CANT-PRSA-LEVER>
		       <TELL " in " D ,RIGHT ,PERIOD>)>
		<RTRUE>)
	       (<VERB? TAKE MUNG SHAKE KICK KNOCK HIT>
		<FIRMLY-ATTACHED ,LEVER ,FLOOR>
		<RTRUE>)
	       (<VERB? LAMP-ON LAMP-OFF OPEN CLOSE OPEN-WITH>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<ROUTINE LOWER-LEVER ()
	 <SETG SUN-MOVING? <>>
	 <TELL "As you lower">
	 <SAY-GRIND "stops vibrating">
	 <RTRUE>>

<ROUTINE RAISE-LEVER ()
	 <SETG SUN-MOVING? T>
	 <TELL "As you raise">
	 <SAY-GRIND "begins to vibrate again">
	 <RTRUE>>

<ROUTINE SAY-GRIND (STR)
	 <TELL " the " D ,LEVER 
" you hear a loud, mechanical groan below your feet. The " D ,FLOOR
" lurches and " .STR
"; you feel a momentary dizziness, and a brief gust of wind">
	 <ALL-IS-STILL>
	 <RTRUE>>

<ROUTINE ALL-IS-STILL ()
	 <TELL ". Then ">
	 <COND (<PROB 50>
		<TELL "everything is quiet." CR>
		<RTRUE>)>
	 <TELL "all is still." CR>
	 <RTRUE>>

<ROUTINE LEVER-MOVED (STR)
	 <TELL CTHE ,LEVER " is moved " .STR
	       " as far as it can go." CR>
	 <RTRUE>>

<ROUTINE CANT-PRSA-LEVER ()
	 <PRINT ,CANT>
         <PRINTB ,P-PRSA-WORD>
	 <TELL " the " D ,LEVER>
	 <RTRUE>>

<OBJECT BEDS
	(LOC FLOWER-WALK)
	(DESC "flower beds")
	(FLAGS NODESC PLURAL SURFACE)
	(SYNONYM BEDS BED BLOSSOMS)
	(ADJECTIVE FLOWER)
	(CAPACITY 50)
	(ACTION BEDS-F)>

<ROUTINE BEDS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <UNTIDY-BEDS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<COND (<FIRST? ,PRSO>
		       <LOOK-IN-BEDS>
		       <RTRUE>)>
		<LOVELY>
		<RTRUE>)
	       (<VERB? TAKE PICK>
		<NO-PICKING>
		<RTRUE>)
	       (<VERB? MUNG HIT KICK SHAKE SQUEEZE DIG LOOSEN>
		<UNTIDY-BEDS>
		<RTRUE>)
	       (<GETTING-INTO?>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-FLOWERS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-IN-BEDS ()
	 <TELL "You can see ">
	 <PRINT-CONTENTS ,BEDS>
	 <TELL " half-hidden among the blossoms." CR>
	 <RTRUE>>

<ROUTINE SMELL-FLOWERS ()
	 <TELL "The air is filled with a delicate fragrance." CR>
	 <RTRUE>>

<ROUTINE UNTIDY-BEDS ()
	 <TELL "That would make the " D ,BEDS " appear most untidy." CR>
	 <RTRUE>>

<ROUTINE LOVELY ()
	 <TELL CTHE ,FLOWERS " are lovely to behold." CR>
	 <RTRUE>>

<OBJECT FLOWERS
	(LOC LOCAL-GLOBALS)
	(DESC "flowers")
	(FLAGS NODESC NOALL TRYTAKE PLURAL)
	(SYNONYM FLOWER FLOWERS LEAF BLOSSOM BLOSSOMS PETALS)
	(ACTION FLOWERS-F)>

<ROUTINE NO-PICKING ()
	 <TELL "Flower-picking in the " D ,GARDENS
	       " is strictly forbidden." CR>
	 <RTRUE>>

<ROUTINE FLOWERS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <UNTIDY-BEDS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<LOVELY>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-FLOWERS>
		<RTRUE>)
	       (<VERB? TAKE PICK PULL>
		<NO-PICKING>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<UNTIDY-BEDS>
		<RTRUE>)
	       (T
		<RFALSE>)>>  

<OBJECT THICKET
	(LOC WABE)
	(DESC "thicket")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM THICKET THORN THORNS BUSH BUSHES)
	(ADJECTIVE DENSE THICK THORNY)
	(ACTION THICKET-F)>

<ROUTINE THICKET-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-DOWN SEARCH LOOK>
		<TELL "The surrounding " D ,PRSO 
		      " is dense and full of thorns." CR>
		<RTRUE>)
	       (<EXITING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<TELL "Ouch! The " D ,THICKET
		      " is full of thorns." CR>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT CLEARING
	(LOC WABE)
	(DESC "clearing")
	(FLAGS NODESC)
	(SYNONYM CLEARING WABE CENTER MIDDLE PLOT GRASS\-PLOT)
	(ADJECTIVE ROUND CIRCULAR GRASS GRASSY)
	(ACTION CLEARING-F)>

"TOUCHED = clearing referenced as WABE."

<ROUTINE CLEARING-F ()
	 <COND (<VERB? LOOK-UNDER LOOK-DOWN>
		<LOOK-UNDER-DIAL>
		<RTRUE>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT MEMORIAL
	(LOC GLOBAL-OBJECTS)
	(DESC "Albert Memorial")
	(FLAGS NODESC VOWEL)
	(SYNONYM MEMORIAL ALBERT MONUMENT EDIFICE SPIRES)
	(ADJECTIVE ALBERT HIDEOUS VICTORIAN PRINCE)
	(ACTION MEMORIAL-F)>

<ROUTINE MEMORIAL-F ()
	 <COND (<NOT <HERE? FLOWER-WALK>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE READ>
		<COND (<IS? ,MEMORIAL ,TOUCHED>
		       <TELL ,CANT
"bear to look at the " D ,MEMORIAL " a moment longer.">)
		      (T
		       <MAKE ,MEMORIAL ,TOUCHED>
		       <TELL
"Your " D ,LONDON " guide book warned you that the " D ,PRSO
" was ugly, but nothing could have prepared you for this embarrassing spectacle!">)>
		<CRLF>
		<RTRUE>)
	       (<GETTING-INTO?>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<WHICH-WAY-OUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<OBJECT BWALK
	(LOC GLOBAL-OBJECTS)
	(DESC "Broad Walk")
	(FLAGS NODESC)
	(SYNONYM WALK)
	(ADJECTIVE BROAD)
	(GENERIC GENERIC-WALK-F)
	(ACTION BWALK-F)>

<ROUTINE BWALK-F ()
	 <COND (<NOT <HERE? BROAD-WALK PAL-GATE LION-GATE ROUND-POND>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HANDLE-PLACE? ,BROAD-WALK ,LION-GATE ,ROUND-POND
			       ,PAL-GATE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT VICTORIA
	(LOC BROAD-WALK)
	(DESC "statue of Queen Victoria")
	(FLAGS NODESC)
	(SYNONYM STATUE FIGURE MONUMENT VICTORIA QUEEN)
	(ADJECTIVE STATUE BROODING QUEEN)
	(ACTION VICTORIA-F)>

<ROUTINE VICTORIA-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "She wasn't much to look at." CR>
		<RTRUE>)
	       (<ENTERING?>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<GETTING-INTO?>
		<TOURISTS-SNICKER>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       		       
<OBJECT BAG
	(DESC "bag of crumbs")
	(FLAGS FOODBIT TAKEABLE CONTAINER OPENABLE OPENED BUYABLE)
	(CAPACITY 0)
	(SIZE 3)
	(MASS 2)
	(VALUE 0)
	(SYNONYM BAG SACK CRUMBS FEED BIRDFEED BREAD HANDFUL FOOD)
	(ADJECTIVE MY PAPER BREAD OLD STALE DRY)
	(GENERIC GENERIC-BAG-F)
	(ACTION BAG-F)>

"SEEN = seen by roadrunner."

<GLOBAL CCNT:NUMBER 5> "# handfuls of crumbs left in BAG"
<GLOBAL APPETITE:NUMBER 0> "Meep takes 4 moves to eat entire bag." 

<ROUTINE SAID-CRUMBS? ()
	 <COND (<NOT <IN? ,BAG ,PLAYER>>
		<RFALSE>)
	       (<AND <THIS-PRSO?>
		     <EQUAL? <GET ,P-OFW 0> ,W?BAG ,W?SACK>>
		<RFALSE>)
	       (<AND <THIS-PRSI?>
		     <EQUAL? <GET ,P-OFW 1> ,W?BAG ,W?SACK>>
		<RFALSE>)
	       (<ADJ-USED? ,W?PAPER>
		<RFALSE>)
	       (<OR <NOUN-USED? ,W?CRUMBS ,W?BREAD ,W?HANDFUL>
		    <NOUN-USED? ,W?FEED ,W?BIRDFEED ,W?FOOD>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CRUMBS? (X)
	 <COND (<OR <EQUAL? .X ,W?CRUMBS ,W?BREAD ,W?HANDFUL>
		    <EQUAL? .X ,W?FEED ,W?BIRDFEED ,W?FOOD>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BAG-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? POUR-FROM>
		     	    <PRSO? PRSI>>
		       <COND (<OR <CRUMBS? <GET ,P-NAMW 1>>
				  <EQUAL? <GET ,P-NAMW 0> ,W?BAG ,W?SACK>
				  <EQUAL? <GET ,P-OFW 0> ,W?BAG ,W?SACK>
				  <EQUAL? <GET ,P-ADJW 0> ,W?PAPER>>
			      <IMPOSSIBLE>
			      <RTRUE>)>
		       <EMPTY-OUT-BAG>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 1>
		       	      <YOUD-HAVE-TO "empty out" ,BAG>
		       	      <RTRUE>)>
		       <TELL "You'd probably lose " THEO
		      	     " in the crumbs" ,IF-YOU-DID>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? BUY CHARGE>
		<TRY-BUY>
		<RTRUE>)
	       (<AND <VERB? BUY-FROM>
		     <PRSI? BWOMAN>>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (<VERB? EMPTY-INTO>
		<COND (<PRSI? PRSO>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<PRSI? POCKET>
		       <TELL "You try to empty the " D ,PRSO " into " 
D ,POCKET ", but crumbs pile up around the edges">
		       <DROP-CRUMBS>
		       <RTRUE>)
		      (<PRSI? PRAM>
		       <CRUMBS-INTO-PRAM>
		       <RTRUE>)
		      (<OR <PRSI? GROUND FLOOR>
			   <IS? ,PRSI ,SURFACE>
			   <AND <IS? ,PRSI ,CONTAINER>
			        <IS? ,PRSI ,OPENED>>>
		       <EMPTY-OUT-BAG>
		       <RTRUE>)>
	        <RFALSE>)
	       (<VERB? EMPTY POUR>
		<COND (<DONT-HAVE? ,PRSO>
		       <RTRUE>)>
		<EMPTY-OUT-BAG>
		<RTRUE>)
	       (<VERB? SHAKE SQUEEZE>
		<TELL "Bread crumbs jitter in " THEO ,PERIOD>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "The crumbs in the bag smell a bit stale." CR>
		<RTRUE>)
	       (<AND <VERB? REACH-IN DIG>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<FEEL-RUBY>
		<RTRUE>)
	       (<SAID-CRUMBS?>
		<COND (<VERB? EXAMINE>
		       <TELL "The bread crumbs look old and stale. ">
		       <LOOK-IN-BAG>
		       <RTRUE>)
	       	      (<VERB? TAKE DROP PUT PUT-ON THROW PUT-UNDER PUT-BEHIND>
		       <TAKE-CRUMBS>
		       <RTRUE>)
	       	      (<AND <VERB? TOUCH SQUEEZE PLAY>
		     	    <EQUAL? ,PRSI <> ,HANDS>>
		       <FEEL-RUBY>
		       <RTRUE>)
	       	      (<VERB? KISS>
		       <FEEL-STALE>
		       <RTRUE>)
		      (<VERB? DRINK DRINK-FROM>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<VERB? EAT TASTE BITE>
		       <TELL "You grab ">
		       <SAY-HANDFUL>
		       <TELL " and cram them into your mouth">
		       <COND (<IS? ,HERE ,WINDY>
		       	      <LOOK-ON-HUNGRY ,PIGEONS>)
		      	     (<VISIBLE? ,MEEP>
		       	      <LOOK-ON-HUNGRY ,MEEP>)>
		       <PRINT ,PERIOD>
		       <COND (<NOT <IS? ,RUBY ,SEEN>>
		       	      <GET-RUBY>
		       	      <TELL CR 
"As you munch the bread, your teeth clamp down on something hard. Ouch! You spit out the particle with a muffled curse.|
|
A brilliant ruby lands ">
			      <COND (<ZERO? ,IN-PRAM?>
			      	     <TELL "at your feet." CR>
			      	     <RTRUE>)>
		       	      <TELL "on the ground." CR>)>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<LOOK-IN-BAG>
		<RTRUE>)
	       (<VERB? MUNG HIT CUT RIP SQUEEZE>
		<COND (<DONT-HAVE? ,PRSO>
		       <RTRUE>)>
		<EMPTY-PRSO-FIRST>
		<RTRUE>)
	       (<VERB? DROP>
		<COND (<IDROP>
		       <SAY-DROPPED>
		       <COND (<IS? ,HERE ,WINDY>
		       	      <CRLF>
			      <PIGEONS-EAT-BAG>)>)> 
		<RTRUE>)
	       (<DO-BAG?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-BAG? ()
	 <COND (<AND <VERB? FILL>
		     <IS? ,PRSI ,WATERY>>
		<TELL CTHEO 
" would get all soggy if you tried that." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL CTHEO " refuses to stay closed." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-ON-HUNGRY (OBJ)
	 <TELL ,PTHE D .OBJ " look">
	 <COND (<NOT <IS? .OBJ ,PLURAL>>
		<TELL "s">)>
	 <TELL " on hungrily">
	 <RTRUE>>

<ROUTINE PIGEONS-EAT-BAG ()
	 <EMPTY-BAG>
	 <SETG P-THEM-OBJECT ,PIGEONS>
	 <TELL CTHE ,PIGEONS 
" flock eagerly around the bag. Soon the bread crumbs are history." CR>
	 <COND (<NOT <IS? ,RUBY ,SEEN>>
		<GET-RUBY>
		<TELL CR "As the birds wander away ">
		<NOTICE-RUBY>)>
	 <RTRUE>>

<ROUTINE FEEL-RUBY ()
	 <FEEL-STALE>
	 <COND (<IS? ,RUBY ,SEEN>
		<RTRUE>)>
	 <GET-RUBY>
	 <TELL CR 
"As you rummage through the crumbs, your fingers brush against something solid. A brilliant ruby slips out of the bag and falls to the ground." CR>
	 <RTRUE>>

<ROUTINE EMPTY-PRSO-FIRST ()
	 <TELL "Maybe you should empty the " D ,PRSO " first." CR>
	 <RTRUE>>

<ROUTINE CRUMBS-INTO-PRAM ()
	 <COND (<NOT <IS? ,PRSI ,OPENED>>
		<YOUD-HAVE-TO "open" ,PRSI>
		<RTRUE>)
	       (<T? ,IN-PRAM?>
		<YOUD-HAVE-TO "get out of" ,PRSI>
		<RTRUE>)>
	 <SAY-CRUMBS-FALL>
	 <TELL " and tumble into the open " D ,PRSI ".|
|
In moments, the pram is covered with greedy " D ,PIGEONS
"! Soon there's not a crumb to be seen" ,PCR>
	 <COND (<IS? ,RUBY ,SEEN>
		<RTRUE>)>
	 <GET-RUBY T>
	 <TELL "As you brush the last few " D ,PIGEONS " off the pram ">
	 <NOTICE-RUBY>
	 <RTRUE>> 

<ROUTINE SAY-CRUMBS-FALL ()
	 <EMPTY-BAG>
	 <TELL "Bread crumbs fall out of the bag">
	 <RTRUE>>

<ROUTINE EMPTY-OUT-BAG ()
	 <SAY-CRUMBS-FALL>
	 <DROP-CRUMBS>
	 <RTRUE>>

<ROUTINE LOOK-IN-BAG ()
	 <TELL "There">
	 <COND (<EQUAL? ,CCNT 1>
		<TELL "'s only one more handful">)
	       (T
		<TELL " are ">
		<COND (<EQUAL? ,CCNT 2 3>
		       <TELL "a couple of">)
		      (T
		       <TELL "several">)>
		<TELL " handfuls">)>
	 <TELL " left in the " D ,BAG ,PERIOD>
	 <RTRUE>>

<ROUTINE EMPTY-BAG ()
         <SETG APPETITE 0>
	 <MOVE ,EBAG <LOC ,BAG>>
	 <REMOVE ,BAG>
	 <SETG CCNT 0>
	 <SETG P-IT-OBJECT ,EBAG>
	 <MAKE ,EBAG ,TOUCHED>
	 <RTRUE>>

<ROUTINE SAY-HANDFUL ()
	 <DEC CCNT>
	 <COND (<ZERO? ,CCNT>
		<EMPTY-BAG>
		<TELL "the last ">)
	       (T
		<TELL "a ">)>
	 <TELL "handful of crumbs">
	 <RTRUE>>

<ROUTINE TAKE-CRUMBS ()
	 <TELL "You take ">
	 <SAY-HANDFUL>
	 <TELL " out of the bag. ">
	 <COND (<AND <VERB? PUT PUT-ON THROW THROW-OVER PUT-UNDER
			    PUT-BEHIND>
		     <PRSO? BAG>>
	        <TELL "But before you can ">
		<COND (<VERB? PUT PUT-ON PUT-UNDER PUT-BEHIND>
		       <TELL "put them ">
		       <COND (<VERB? PUT>
			      <TELL "in ">)
			     (<VERB? PUT-ON>
			      <TELL "on ">)
			     (<VERB? PUT-UNDER>
			      <TELL "under ">)
			     (T
			      <TELL "behind ">)>)
		      (<VERB? THROW THROW-OVER>
		       <TELL "throw them ">
		       <COND (<VERB? THROW>
			      <TELL "at ">)
			     (T
		       	      <TELL "over ">)>)>
		<TELL THEI ", they ">)
	       (T
		<TELL "They ">)>
	 <TELL "fall between your fingers">
	 <DROP-CRUMBS>
	 <RTRUE>>

<ROUTINE DROP-CRUMBS ()
	 <TELL " and ">
	 <COND (<HERE? IN-SKY ON-BIRD>
		<TELL "scatter in the wind." CR>
		<RTRUE>)
	       (<OR <HERE? IN-WATER IN-CIST UNDER-WATER>
		    <T? ,IN-DISH?>
		    <T? ,IN-DORY?>>
		<TELL "disappear in the water." CR>
		<RTRUE>)
	       (<T? ,SUITED?>
		<COND (<ZERO? ,CCNT>
		       <MOVE ,BAG <LOC ,EBAG>>
		       <REMOVE ,EBAG>
		       <UNMAKE ,EBAG ,TOUCHED>
		       <SETG P-IT-OBJECT ,BAG>)>
	        <INC CCNT>
		<TELL "jiggle around inside the " D ,FILM
		      " until you scoop them all up with the bag." CR>
		<RTRUE>)
	       (<HERE? IN-ORBIT ON-SAT>
		<TELL "tumble" ,OUTASITE>
		<RTRUE>)>
	 <TELL "tumble ">
	 <COND (<T? ,IN-PRAM?>
		<TELL "out of the " D ,PRAM>)
	       (T
		<TELL "across the ">
		<COND (<AND <IS? ,HERE ,INDOORS>
			    <NOT <HERE? TUN1 TUN2 TUN3 IN-BARROW>>>
		       <TELL D ,FLOOR>)
		      (T
		       <TELL D ,GROUND>)>)>
	 <COND (<NOT <IS? ,RUBY ,SEEN>>
		<GET-RUBY>		
		<TELL ".|
|
As the ">
		<COND (<OR <T? ,IN-PRAM?>
			   <HERE? WABE>>
		       <TELL "breeze scatters ">)
		      (T
		       <TELL D ,POND-BIRDS " gobble down ">)>
		<TELL "the crumbs, ">
		<NOTICE-RUBY>
		<RTRUE>)
	       (<ZERO? ,LIT?>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<TELL ", where ">
		<COND (<IN? ,MEEP ,HERE>
		       <TELL THE ,MEEP " gobbles them all up">
		       <COND (<AND <HERE? W100>
				   <IS? ,DOG ,WINDY>>
			      <TELL " before returning to the dog's head">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<IS? ,HERE ,INDOORS>
		       <TELL "they scatter all over the place." CR>
		       <RTRUE>)>
		<TELL "the breeze blows them all away." CR>)>
	 <RTRUE>>

<ROUTINE NOTICE-RUBY ()
	 <TELL "a glint of red catches your eye. Frowning, you ">
	 <COND (<IN? ,RUBY ,PRAM>
		<TELL "peer inside">)
	       (<ZERO? ,IN-PRAM?>
		<TELL "stoop down">)
	       (T
		<TELL "peer over the edge of the " D ,PRAM>)>
	 <TELL " for a closer look... and gasp with astonishment!|
|
The ruby ">
	 <COND (<IN? ,RUBY ,PRAM>
		<TELL "in the pram">)
	       (<ZERO? ,IN-PRAM?>
		<TELL "at your feet">)
	       (T
		<TELL "on the ground">)>
	 <TELL " is bigger than a walnut, with finely cut facets that sparkle with crimson fire. It must have been in the " D ,BAG ,PERIOD>
	 <RTRUE>>

<ROUTINE FEEL-STALE ()
	 <TELL "The crumbs feel dry and stale." CR>
	 <RTRUE>>

<OBJECT EBAG
	(DESC "paper bag")
	(FLAGS TAKEABLE CONTAINER OPENED OPENABLE)
	(SYNONYM BAG SACK CRUMBS BREAD HANDFUL FEED BIRDFEED FOOD)
	(ADJECTIVE MY PAPER BREAD)
	(CAPACITY 3)
	(SIZE 3)
	(MASS 1)
	(VALUE 0)
        (GENERIC GENERIC-BAG-F)
	(ACTION EBAG-F)>

"TOUCHED = BAG emptied."

<OBJECT SOGGY
	(DESC "soggy bag")
	(FLAGS TOUCHED TAKEABLE CONTAINER OPENED OPENABLE)
	(SYNONYM BAG SACK CRUMBS BREAD)
	(ADJECTIVE MY PAPER BREAD SOGGY)
	(CAPACITY 3)
	(SIZE 3)
	(MASS 1)
	(VALUE 0)
        (GENERIC GENERIC-BAG-F)
	(CONTFCN IN-EBAG)
	(ACTION EBAG-F)>

<ROUTINE IN-EBAG ("OPTIONAL" (CONTEXT <>))
	 <COND (<AND <EQUAL? .CONTEXT ,M-CONT>
		     <TAKE-OUT-EBAG?>>
		<RTRUE>)
	       (T
		<RFALSE>)>>	 

<ROUTINE TAKE-OUT-EBAG? ("AUX" L)
	 <SET L <LOC ,EBAG>>
	 <COND (<EQUAL? .L ,POCKET ,FISSURE ,CREVICE>
		<YOUD-HAVE-TO "take out" ,EBAG>
	      ; <TELL "You'd have to take the " D ,EBAG
	       	      " out of " THE .L " first." CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE EBAG-F ()
	 <COND (<SAID-CRUMBS?>
		<TELL "The crumbs are all gone." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<AND <VERB? PUT PUT-ON>
		       	    <TAKE-OUT-EBAG?>>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? BUY-FROM>
		     <PRSI? BWOMAN>>
		<HOW?>
		<RTRUE>)
	       (<VERB? MUNG CUT RIP HIT SQUEEZE KICK STAND-ON UNFOLD>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<DO-BAG?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GBAG
	(LOC BWOMAN)
	(DESC "bag")
	(FLAGS NODESC TRYTAKE NOALL BUYABLE)
	(SYNONYM BAGS BAG CRUMBS SACK SACKS BREAD FOOD FEED BIRDFEED)
	(ADJECTIVE BREAD)
	(GENERIC GENERIC-BAG-F)
	(ACTION GBAG-F)>

<ROUTINE GBAG-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PERFORM ,V?GIVE ,PRSO ,BWOMAN>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? BUY CHARGE>
		<TRY-BUY>
		<RTRUE>)
	       (<AND <VERB? BUY-FROM>
		     <PRSI? BWOMAN>>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL "The bags are full of bread crumbs." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<NO-TOUCHIN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-TOUCHIN ()
	 <MAKE ,BWOMAN ,SEEN>
	 <TELL 
"The woman slaps " D ,HANDS " away. \"No touchin' the merchandise!\"" CR>
	 <RTRUE>>

<ROUTINE GENERIC-BAG-F (TBL)
	 <COND (<IS? ,EBAG ,TOUCHED>
		<RETURN ,EBAG>)>
	 <RETURN ,BAG>>

<ROUTINE TRY-BUY ()
	 <COND (<NOT <HERE? BROAD-WALK>>
		<TELL "There's nobody here to sell you any." CR>
		<RTRUE>)
	       (<PRSI? COIN SCOIN CREDIT-CARD>
		<PERFORM ,V?GIVE ,PRSI ,BWOMAN>
		<RTRUE>)
	       (<T? ,PRSI>
		<MAKE ,BWOMAN ,SEEN>
		<TELL CTHE ,BWOMAN " scowls. \"I ain't no pawn shop!\"" CR>
		<RTRUE>)
	       (<GOT? ,COIN>
		<BUY-WITH ,COIN>
		<RTRUE>)
	       (<GOT? ,SCOIN>
		<BUY-WITH ,SCOIN>
		<RTRUE>)
	       (<GOT? ,CREDIT-CARD>
		<BUY-WITH ,CREDIT-CARD>
		<RTRUE>)
	       (T
		<NO-MONEY>)>
	 <RTRUE>>

<ROUTINE BUY-WITH (THING)
	 <TELL "[with " THE .THING ,BRACKET>
	 <PERFORM ,V?GIVE .THING ,BWOMAN>
	 <RTRUE>>

<ROUTINE GET-RUBY ("OPTIONAL" (P <>))
	 <MAKE ,RUBY ,SEEN>
	 <MOVE ,RUBY <COND (<ZERO? .P> ,HERE) (T ,PRAM)>>
	 <SETG P-IT-OBJECT ,RUBY>
	 <QUEUE I-RUBY -1>
	 <RTRUE>>

<OBJECT RUBY
	(DESC "ruby")
	(FLAGS CHILLY TAKEABLE)
	(FDESC "A ruby is lying at your feet.")
	(SYNONYM RUBY JEWEL STONE GEM GEMSTONE FACETS FACET)
	(ADJECTIVE RED CRIMSON RUBY BRILLIANT BRIGHT)
	(VALUE 1)
	(SIZE 0)
	(MASS 1)
	(ACTION RUBY-F)>

"SEEN = found, CHILLY = delay timer."

<ROUTINE RUBY-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<TRUBY-F>
		<RTRUE>)
	       (<AND <VERB? TAKE TOUCH HIT KISS SQUEEZE SHAKE PLAY KNOCK
			    MOVE PULL PUSH PUSH-TO RAISE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<MAKE ,PRSO ,TOUCHED>
		<TELL "As you reach down to touch the ruby, ">
		<MEEP-GETS-RUBY>
		<RTRUE>)
	       (T
		<RFALSE>)>>	
		
<ROUTINE TRUBY-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<SPARKLE-WITH "crimson">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPARKLE-WITH (STR)
	 <TELL "Its finely cut edges sparkle with " .STR " fire." CR>
	 <RTRUE>>

<OBJECT EMERALD
	(DESC "emerald")
	(FLAGS NODESC TAKEABLE VOWEL NOALL)
	(SIZE 1)
	(VALUE 1)
	(MASS 1)
	(SYNONYM EMERALD JEWEL GEM STONE GEMSTONE)
	(ADJECTIVE GREEN EMERALD)
	(ACTION EMERALD-F)>

<ROUTINE EMERALD-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<SPARKLE-WITH "green">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       		
<OBJECT GPRAM
	(LOC LOCAL-GLOBALS)
	(DESC "perambulators")
	(FLAGS NODESC PLURAL CONTAINER OPENED)
	(SYNONYM PERAMBULA PRAM PRAMS CARRIAGE CARRIAGES WHEELS)
	(ADJECTIVE BABY)
	(GENERIC GENERIC-PRAM-F)
	(ACTION GPRAM-F)>

<ROUTINE GPRAM-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH WATCH>
		<TELL "They're probably full of British babies." CR>
		<RTRUE>)
	       (<HANDLE-BABES?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-PRAM-F (TABLE)
	 <RETURN ,PRAM>>

<OBJECT PRAM
	(LOC LION-GATE)
	(DESC "perambulator")
        (FLAGS TRYTAKE CONTAINER OPENABLE)
	(SYNONYM PERAMBULA PRAM CARRIAGE WHEELS BUGGY STROLLER)
	(ADJECTIVE BABY)
	(CAPACITY 30)
	(DESCFCN DESCRIBE-PRAM)
	(GENERIC GENERIC-PRAM-F)
	(ACTION PRAM-F)>
		
<ROUTINE DESCRIBE-PRAM ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A careless nanny has left her " D ,PRAM " unattended">
	 <COND (<AND <FIRST? ,PRAM>
		     <IS? ,PRAM ,OPENED>>
		<TELL ". Inside it you see ">
		<PRINT-CONTENTS ,PRAM>)>
	 <TELL ".">
	 <RTRUE>>

<GLOBAL IN-PRAM?:FLAG <>>

<ROUTINE PRAM-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<PRSO? ME>
			      <PERFORM ,V?ENTER ,PRAM>
			      <RTRUE>)
			     (<PRSO? BAG>
			      <PIGEONS-EAT-BAG>
			      <RTRUE>)>)>
		<RFALSE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE SEARCH>
		     <T? ,IN-PRAM?>>
		<TELL "Aside from " D ,ME ", you see ">
		<PRINT-CONTENTS ,PRAM>
	        <TELL " in the " D ,PRAM ,PERIOD>
		<RTRUE>)
	       
	       (<VERB? ENTER CLIMB-ON SIT LIE-DOWN CLIMB-UP STAND-ON STAND>
		<COND (<AND <T? ,IN-PRAM?>
			    <NOT <VERB? STAND-ON STAND>>>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <YOUD-HAVE-TO "open" ,PRSO>
		       <RTRUE>)
		      (<VERB? STAND-ON STAND>
		       <COND (<ZERO? ,IN-PRAM?>
			      <TELL "You clamber into the " D ,PRSO 
" and slowly rise to your feet, knees wobbling">)
			     (T
			      <SETG OLD-HERE <>>
		       	      <SETG IN-PRAM? <>>
		       	      <UNMAKE ,PRSO ,NODESC>
			      <TELL 
"With wobbling knees, you slowly rise to your feet">)>
		       <TELL ,PCR>
		       <ITALICIZE "Crash!">
		       <TELL 
" The pram skitters away and deposits you on the ground">
		       <COND (<AND <ZERO? ,RAID?>
				   <NOT <HERE? WABE>>>
			      <TELL ", much to the amusement of passersby">)>
		       <TELL 
".|
|
With as much dignity as possible, you rise to your feet and discipline the pram with an angry kick." CR>
		       <RTRUE>)
		      (<VISIBLE? ,RUBY>
		       <TELL "You start to climb into the " D ,PRSO
			     ", but stop short as ">
		       <MEEP-GETS-RUBY>
		       <RTRUE>)
		      (T
		       <SETG IN-PRAM? T>
		       <MAKE ,PRSO ,NODESC>
		       <SETG OLD-HERE <>>
		       <TELL "With great difficulty, ">
		       <COND (<AND <ZERO? ,RAID?>
				   <NOT <HERE? WABE>>>
		              <TELL
"and much to the amusement of passersby, ">)>
		       <TELL "you jam yourself into the unfortunate "
			     D ,PRSO ,PERIOD>)>
		<RTRUE>)
	       
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? ,IN-PRAM?>
		       <NOT-IN>)
		      (T
		       <SETG IN-PRAM? <>>
		       <UNMAKE ,PRSO ,NODESC>
		       <SETG OLD-HERE <>>
		       <TELL "Gratefully, you clamber out of the cramped "
			     D ,PRSO ,PERIOD>)>
		<RTRUE>)
	       (<VERB? PUSH-TO>
		<COND (<OR <AND <PRSI? GRASS LWATER>
				<HERE? LAN-WALK>>
			   <AND <PRSI? GRPOND>
				<HERE? BROAD-WALK>>>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)		      
		      (<PRSI? INTDIR>
		       <MOVE ,PRSO ,PLAYER>
		       <DO-WALK ,P-DIRECTION>
		       <MOVE ,PRSO ,HERE>
		       <PUTP ,PRSO ,P?DESCFCN 0>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? TAKE RAISE>
		<TELL ,CANT "lift the clumsy " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? MOVE PUSH PULL TURN SPIN>
		<TELL
"[To move the " D ,PRSO ", simply push it in the desired " D ,INTDIR
"; for example, PUSH THE PERAMBULATOR TO THE SOUTH or PULL PRAM EAST.]" CR>
		<RTRUE>)
	       (<AND <VERB? LOOSEN>
		     <T? ,PRSI>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?LOOSEN ,W?HOOK ,W?PRY>>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 2>
		       <TELL CTHEO " rolls a few feet, then stops." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would move the pram very far">
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <T? ,IN-PRAM?>>
		<CANT-WHILE-IN-PRAM>
		<RTRUE>)
	       (<AND <VERB? KICK SHAKE RAPE>
		     <ZERO? ,IN-PRAM?>
		     <NOT <HERE? WABE>>>
		<COND (<ZERO? ,RAID?>
		       <TELL "Pass">)
		      (T
		       <TELL "Flee">)>
		<TELL "ing " D ,NANNIES " look on in horror." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE CANT-WHILE-IN-PRAM ()
	 <TELL "That'd be easier to do if you got out of the pram first." CR>
	 <RTRUE>>

<OBJECT BPRAM
	(LOC LONG-WATER)
	(DESC "broken perambulator")
	(FLAGS TRYTAKE CONTAINER OPENABLE OPENED)
	(SYNONYM PERAMBULA PRAM CARRIAGE WHEELS BUGGY STROLLER)
	(ADJECTIVE BROKEN USELESS BABY)
	(CAPACITY 30)
	(ACTION BPRAM-F)>

<ROUTINE BPRAM-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,PRAM
" is lying on its side, bent and useless." CR>
		<RTRUE>)
	       (<VERB? TAKE RAISE>
		<TELL CTHEO
" topples over on its side again. It's quite useless." CR>
		<RTRUE>)
	       (<VERB? PUSH-TO MOVE PULL PUSH>
		<TELL CTHEO 
"'s days of carefree rolling are over." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<TELL "The top of the " D ,PRAM
		      " is hopelessly broken." CR>
		<RTRUE>)
	       (<VERB? ENTER CLIMB-ON SIT LIE-DOWN CLIMB-UP STAND-ON STAND>
		<TELL CTHEO " would never support you now." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>		      

<OBJECT NOTICE
	(LOC LAN-WALK)
	(DESC "notice")
	(FDESC "A printed notice is stuck into the grass.")
	(FLAGS READABLE TRYTAKE)
	(SYNONYM SIGN NOTICE WORDS PRINTING)
	(ADJECTIVE PRINTED)
	(ACTION NOTICE-F)>

"TOUCHED = warning given."

<ROUTINE NOTICE-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<MAKE ,NOTICE ,TOUCHED>
		<TELL "The words ">
		<ITALICIZE "Do Not Walk On The Grass">
		<TELL " are sternly printed on the " D ,NOTICE ,PERIOD>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<COND (<IS? ,NOTICE ,TOUCHED>
		       <GRASS-STOPS-YOU "As you approach the notice">
		       <RFATAL>)>
		<READ-NOTICE-FIRST>
		<RFATAL>)
	       (T
	       	<RFALSE>)>>

<OBJECT GRASS
	(LOC LOCAL-GLOBALS)
	(DESC "grass")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(CAPACITY 100)
	(SYNONYM GRASS GRASSES LAWN FIELD)
	(ADJECTIVE BROAD LUSH MANICURED)
	(ACTION GRASS-F)>

"TOUCHED = attacked, SEEN = bikes seen, CHILLY = heard."

<ROUTINE GRASS-F ()
	 <COND (<IS? ,HERE ,INDOORS>
		<CANT-SEE-ANY ,GRASS>
		<RFATAL>)
	       (<NOT <HERE? LAN-WALK>>
		<COND (<GROUND-F>
		       <RTRUE>)>
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <MAKE ,PRSI ,CHILLY>
		       <REMOVE ,PRSO>
		       <TELL CTHEO
" lands on the " D ,GRASS " with a gentle thud.|
|
You hear a mutter of sinister little " D ,VOICES
" and a brief rustling " D ,SOUND
". When you look again, " THEO " is gone without a trace!" CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<TELL "It seems innocent enough." CR>
		<RTRUE>)
	       (<VERB? CROSS CLIMB-ON ENTER WALK-TO CLIMB-OVER
		       STAND-ON SIT LIE-DOWN LEAP THROUGH WALK-AROUND>
		<COND (<IS? ,NOTICE ,TOUCHED>
		       <GRASS-STOPS-YOU "As your feet touch the grass">
		       <RFATAL>)>
		<READ-NOTICE-FIRST>
		<RFATAL>)
	       (<AND <EQUAL? ,PRSI <> ,HANDS>
		     <VERB? TAKE TOUCH CUT RIP MOVE PULL LOOSEN DIG
			    LOOK-UNDER SQUEEZE MUNG HIT SHAKE REACH-IN PICK
			    PLAY KISS KICK>> 
		<COND (<IS? ,NOTICE ,TOUCHED>
		       <GRASS-STOPS-YOU "As you bend to touch the grass">
		       <RFATAL>)>
		<READ-NOTICE-FIRST>
		<RFATAL>)
	       (<AND <VERB? LISTEN>
		     <IS? ,PRSO ,CHILLY>>
		<UNMAKE ,PRSO ,CHILLY>
		<TELL
"You hear tiny " D ,VOICES " giggling \"Shh! Shh! Quiet!\" for a moment">
		<ALL-IS-STILL>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	        
<ROUTINE GRASS-STOPS-YOU (STR "OPTIONAL" (UMB? <>))
	 <MAKE ,GRASS ,CHILLY>
	 <COND (<NOT <IS? ,GRASS ,TOUCHED>>
		<MAKE ,GRASS ,TOUCHED>
		<TELL .STR " you sense a strange motion around you. Looking down, you watch with horror as the "
D ,GRASS " begins to ripple and writhe with vegetable indignance!" CR CR>)>
	 <TELL 
"Angry green stalks whip around your legs, pull you to the ground and drag you, kicking and screaming, back to the paved " D ,CSURFACE
" of the " D ,LNWALK ,PCR 
"A chorus of offended little " D ,VOICES 
" subsides as you regain your footing">
	 <COND (<OR <T? .UMB?>
		    <AND <HELD? ,PARASOL>
			 <IS? ,PARASOL ,OPENED>>>
		<AND-SNAP>
		<RTRUE>)>
	 <PRINT ,PERIOD>
	 <COND (<NOT <IS? ,GRASS ,SEEN>>
		<MAKE ,GRASS ,SEEN>
		<QUEUE I-BIKES -1>)>
	 <RTRUE>>

<OBJECT ENERGY
	(LOC LAN-WALK)
	(DESC "sculpture")
	(FLAGS NODESC)
	(SYNONYM SCULPTURE HORSE RIDER STATUE ENERGY PLAQUE)
	(ADJECTIVE PHYSICAL IMPRESSIVE)
	(ACTION ENERGY-F)>

<ROUTINE ENERGY-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL "According to a plaque, the " D ,PRSO " is called ">
		<ITALICIZE "Physical Energy.">
		<CRLF>
		<RTRUE>)
	       (<GETTING-INTO?>
		<TELL CTHE ,ENERGY "'s design would make that difficult." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		  
<OBJECT BALL
        (LOC BEDS)
	(DESC "soccer ball")
	(FLAGS TAKEABLE)
        (SYNONYM BALL FOOTBALL)
        (ADJECTIVE ABANDONED SOCCER FOOT)
	(SIZE 7)
	(MASS 5)
	(VALUE 1)
	(ACTION BALL-F)>

<ROUTINE BALL-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? THROW>
		     	    <PRSO? PARASOL>
		     	    <IN? ,PRSI ,TREE>>
		       <TREE-SWITCH>
		       <RTRUE>)>
		<RFALSE>)
	       (<IN? ,PRSO ,TREE>
		<COND (<AND <T? ,PRSI>
		     	    <VERB? HIT LOOSEN TAKE TAKE-WITH TOUCH
				   TOUCH-TO SHAKE>>
		       <NICE-TRY>
	               <RTRUE>)
	       	      (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		       <CANT-REACH ,BALL>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? KICK PLAY BOUNCE>
		<TELL "You ">
		<PRINTB ,P-PRSA-WORD>
		<TELL " the " D ,PRSO>
		<COND (<VERB? KICK>
		       <TELL " around">)>
		<TELL " for a few moments, but ">
		<COND (<HERE? WABE>
		       <TELL "there's nobody here ">)
		      (T
		       <TELL "nobody stops ">)>
		<TELL "to admire your athletic prowess." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT PARASOL
	(LOC JWOMAN)
	(DESC "umbrella")
	(FLAGS NODESC VOWEL TAKEABLE OPENABLE OPENED SURFACE FERRIC)
	(SYNONYM UMBRELLA BROLLY BUMBERSHOOT SLOGAN HANDLE PARROT HEAD)
	(ADJECTIVE PARROT\'S)
	(SIZE 10)
	(VALUE 0)
	(MASS 7)
	(ACTION PARASOL-F)>

<ROUTINE PARASOL-F ()
	 <COND (<IN? ,PARASOL ,JWOMAN>
		<TELL "You approach the " D ,PARASOL
		      " in the " D ,JWOMAN "'s hands, but stop short" ,PCR>
		<PERFORM ,V?EXAMINE ,JWOMAN>
		<RTRUE>)
	       (<OR <NOUN-USED? ,W?HANDLE ,W?PARROT ,W?HEAD>
		    <ADJ-USED? ,W?PARROT\'S>>
		<COND (<VERB? EXAMINE LOOK-ON>
		       <TELL "The parrot's head stares back at you." CR>
		       <RTRUE>)>
		<USELESS>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <COND (<AND <PRSO? BALL>
			    	   <IN? ,PRSI ,TREE>>
		       	      <TREE-SWITCH>
		       	      <RTRUE>)>
		       <TELL CTHEO " glances off the " D ,PRSI " and ">
		       <LANDS-AT-YOUR-FEET>
		       <COND (<IN? ,PRSI ,TREE>
		       	      <TELL CR CTHEI 
			       " teeters uncertainly for a moment." CR>)>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON>
		       <COND (<IN? ,PRSI ,TREE>
		       	      <CANT-REACH ,PRSI>
		       	      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)> 
		<RFALSE>)
	       (<AND <VERB? FILL>
		     <IS? ,PRSI ,WATERY>>
		<SPLASHES>
		<RTRUE>)
	       (<VERB? FIND FOLLOW>
		<COND (<VISIBLE? ,PARASOL>
		       <ITS-RIGHT-HERE>
		       <RTRUE>)>
		<CANT-SEE-ANY>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The">
		<OPEN-CLOSED ,PRSO>
		<COND (<IN? ,PRSO ,TREE>
		       <TELL 
" dangles in the tree overhead, high out of reach. It">)
		      (T
		       <TELL "'">)>
		<TELL "s handle is carved in the shape of a parrot's head">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL ", and the ">
		       <READ-SLOGAN>
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<RTRUE>)	       
	       (<VERB? READ LOOK-ON>
		<COND (<IN? ,PRSO ,TREE>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <TELL "The ">
		       <READ-SLOGAN>
		       <RTRUE>)>
		<YOUD-HAVE-TO "open" ,PRSO>
		<RTRUE>)	       
	       (<IN? ,PRSO ,TREE>
		<COND (<AND <T? ,PRSI>
		     	    <VERB? HIT LOOSEN TAKE TAKE-WITH TOUCH
				   TOUCH-TO SHAKE>>
		       <NICE-TRY>
	               <RTRUE>)
		      (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		       <CANT-REACH ,PARASOL>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,SEEN>>>
		<COND (<ITAKE>
		       <MAKE ,PRSO ,SEEN>
		       <TELL "As you pick up the " D ,PRSO
" and smooth the wrinkles, you notice a touristy slogan printed around the outside: \"" ,ALLPRAMS "\"" CR>
		       <UPDATE-SCORE 5>)>
		<RTRUE>)	       
	       (<VERB? STAND-UNDER>
		<COND (<NOT <IN? ,PARASOL ,PLAYER>>
		       <YOUD-HAVE-TO "be holding" ,PRSO>
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-CLOSED>
		       <RTRUE>)
		      (T
		       <ALREADY-DOING-THAT>)>
		<RTRUE>)	       
	       (<AND <VERB? OPEN OPEN-WITH UNFOLD>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<DONT-HAVE? ,PRSO>
		       <RTRUE>)
		      (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<AND <HERE? IN-SKY>
			    <ZERO? ,SUITED?>>
		       <MAKE ,PRSO ,OPENED>
		       <TELL CTHEO
" snaps open and nearly flies to pieces in the fury of your descent. But a sympathetic breeze fills the cloth panels with air, and your death-plunge slows to a leisurely drift." CR>
		       <RTRUE>)
		      (<T? ,SUITED?>
		       <TELL CTHE ,FILM>
		       <COND (<HERE? IN-ORBIT ON-SAT>
			      <TELL " won't stretch enough now." CR>
			      <RTRUE>)>
		       <MAKE ,PRSO ,OPENED>
		       <TELL " stretches as you open the " D ,PRSO ,PERIOD>
		       <RTRUE>)
		      (<NOT <IS? ,HERE ,WINDY>>
		       <RFALSE>)>
		
		<TELL "The ">
		<SAY-WIND>
		<TELL " fills the " D ,PRSO " the moment you open it. You">
		
		<COND (<ZERO? ,IN-PRAM?>
		       <TELL "'">)
		      (T
		       <MOVE ,PRAM ,PLAYER>
		       <TELL " and your " D ,PRAM " a">)>
		<TELL "re blown helplessly ">
	 	<COND (<IS? ,EWIND ,SEEN>
		       <TELL "we">)
	       	      (T
		       <TELL "ea">)>
	 	<TELL "stward">
		<COND (<HERE? LAN-GATE LION-GATE AT-TERRACE>
		       <COND (<AND <HERE? LION-GATE AT-TERRACE>
				   <IS? ,WWIND ,SEEN>>
		              <COND (<HERE? LION-GATE>
				     <TELL " past " D ,TERRACE>)>
			      <SETG HERE ,LAN-GATE>
		              <MOVE ,PLAYER ,HERE>
		              <TELL " to the " D ,LGATE ", where">)
			     (<AND <HERE? LAN-GATE AT-TERRACE>
				   <IS? ,EWIND ,SEEN>>
			      <COND (<HERE? LAN-GATE>
				     <TELL " past " D ,TERRACE>)>
			      <SETG HERE ,LION-GATE>
			      <MOVE ,PLAYER ,HERE>
			      <TELL " to the " D ,BLGATE ", where">)
			     (T
			      <TELL " until">)>
		       <TELL " you collide with a crowd of ">
		       <SAY-TOURISTS>)
		      
		      (<HERE? WABE>
		       <TELL " until you plow into the " D ,THICKET>)
		      
		      (<HERE? PAL-GATE FLOWER-WALK>
		       <COND (<AND <HERE? PAL-GATE>
				   <IS? ,WWIND ,SEEN>>
			      <SETG HERE ,FLOWER-WALK>
			      <MOVE ,PLAYER ,HERE>
			      <TELL " to the " D ,FLWALK ", where">)
			     (<AND <HERE? FLOWER-WALK>
				   <IS? ,EWIND ,SEEN>>
			      <SETG HERE ,PAL-GATE>
			      <MOVE ,PLAYER ,HERE>
			      <TELL " to the " D ,PAL-GATE ", where">)
			     (T
			      <TELL " until">)>
		       <TELL " you careen into the ">
		       <COND (<HERE? FLOWER-WALK>
			      <TELL D ,BEDS>)
			     (T
			      <SAY-TOURISTS>)>)
		      
		      (<IS? ,WWIND ,SEEN> 
		       <COND (<HERE? BROAD-WALK ROUND-POND>
			      <COND (<HERE? BROAD-WALK>
				     <TELL " past the " D ,RPOND>)>
			      <COND (<ZERO? ,IN-PRAM?>
				     <SETG HERE ,LAN-WALK>
		                     <MOVE ,PLAYER ,HERE>)>
			      <TELL " to the " D ,LNWALK 
				    ", where you roll">)>
		       
		       <TELL " onto the " D ,GRASS ,PCR>
		       <COND (<T? ,IN-PRAM?>
			      <GO-TO-LONG-WATER>
			      <RFATAL>)>
		       <GRASS-STOPS-YOU "As you stumble across the lawn" T>
		       <COND (<NOT <EQUAL? ,HERE ,OLD-HERE>>
			      <CRLF>
			      <V-LOOK>)>
		       <RFATAL>)
		      (T
		       <COND (<HERE? LAN-WALK ROUND-POND>
			      <COND (<HERE? LAN-WALK>
				     <TELL " past the " D ,RPOND>)>
			      <SETG HERE ,BROAD-WALK>
		              <MOVE ,PLAYER ,HERE>
			      <TELL " to the " D ,BROAD-WALK ", where">)
			     (T
			      <TELL " until">)>
		       <TELL " you careen into the " D ,VICTORIA>)>
		
		<COND (<T? ,IN-PRAM?>
		       <SETG OLD-HERE <>>
		       <SETG IN-PRAM? <>>
		       <UNMAKE ,PRAM ,NODESC>
		       <MOVE ,PRAM ,HERE>
		       <MOVE-ALL ,PRAM ,HERE>
		       <TELL " and tumble out of the " D ,PRAM>)>
		<PRINT ,PERIOD>
		<PAIN-REGAIN>
		<COND (<NOT <EQUAL? ,HERE ,OLD-HERE>>
		       <CRLF>
		       <V-LOOK>)>
		<RFATAL>)
	       (<VERB? CLOSE FOLD>
		<COND (<DONT-HAVE? ,PRSO>
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-ALREADY "closed">
		       <RTRUE>)
		      (T
		       <RFALSE>)>)     
	       (T
		<RFALSE>)>>

<ROUTINE READ-SLOGAN ()
       ; <MAKE ,PRSO ,SEEN>
	 <TELL "slogan \"">
	 <COND (<IS? ,PRSO ,FLIPPED>
		<TELL "snedraG notgnisneK eht ot dael smarp llA">)
	       (T
	        <TELL "All prams lead to the " D ,GARDENS>)>
	 <TELL "\" is printed around the outside." CR>
	 <RTRUE>>

<ROUTINE TREE-SWITCH ()
	 <MOVE ,PRSO ,TREE>
	 <MAKE ,PRSO ,NODESC>
	 <MOVE ,PRSI ,LAN-GATE>
	 <UNMAKE ,PRSI ,NODESC>
	 <SETG P-IT-OBJECT ,PRSI>
	 <TELL CTHEO 
" lodges itself in the tree beside the " D ,PRSI ".|
|
The " D ,PRSI 
" teeters uncertainly for a moment, then tumbles out of the tree and lands at your feet." CR>
	 <RTRUE>>

<ROUTINE NICE-TRY ()
	 <TELL "Nice try. Unfortunately, ">
	 <COND (<EQUAL? ,PRSI ,HANDS <>>
		<TELL "your arm">)
	       (T
		<TELL THEI>)>
	 <TELL " isn't long enough to reach " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE GO-TO-LONG-WATER ()
	 <SETG IN-PRAM? <>>
	 <UNMAKE ,PRAM ,NODESC>
	 <SETG FREEZE? T>
	 <SETG MINUTES 59>
	 <SETG HOURS 15>
	 <SETG SECONDS 45>
	 <SETG HERE ,LONG-WATER>
	 <MOVE ,PLAYER ,HERE>
	 <MOVE-ALL ,PRAM ,HERE>
	 <DROP-ALL>
	 <MOVE ,PARASOL ,PLAYER>
	 <REMOVE ,PRAM>
	 <COND (<IN? ,CRANE ,HERE>
		<REMOVE ,CRANE>
		<MOVE ,BAD-CRANE ,HERE>
		<UNMAKE ,BAD-CRANE ,TOUCHED>
		<PUTP ,BAD-CRANE ,P?FDESC "Your paper bird didn't survive the crash very well. All that's left of it is a crumpled piece of paper.">)>
	 <DEQUEUE I-MEEP>
	 <DEQUEUE I-AIR-RAID>
	 <DEQUEUE I-BWOMAN>
	 <DEQUEUE I-BOY>
	 <COND (<NOT <IN? ,WAND ,GIANT>>
		<MOVE ,WAND ,GIANT>)>
	 <DEQUEUE I-CRANE-APPEARS>
	 <DEQUEUE I-BIKES>
	 <QUEUE I-LONDON-HOLE -1>
	 <UNMAKE ,WWIND ,SEEN>
	 <TELL 
"You zoom down a long slope, barely missing several trees and boulders. Peering over the top of the "
D ,PRAM ", you see the " D ,LWATER
" coming closer and closer. Unable to stop, and too stupid to let go of the "
D ,PARASOL ", you bravely close your eyes and pinch your nose shut" ,PCR>
	 <ITALICIZE "Crash!">
	 <CARRIAGE-RETURNS>
       ; <TELL 
"You come to your senses empty-handed and aching all over" ,PCR>
	 <V-LOOK>
	 <PAIN-REGAIN>
	 <RTRUE>>

<ROUTINE PAIN-REGAIN ()
	 <TELL CR "Painfully, you regain your footing">
	 <AND-SNAP>
	 <RTRUE>>

<ROUTINE AND-SNAP ()
	 <UNMAKE ,PARASOL ,OPENED>
	 <TELL " and snap the " D ,PARASOL " shut." CR>
	 <RTRUE>>

<OBJECT TREE
	(LOC LAN-GATE)
	(DESC "tree")
	(FLAGS NODESC CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM TREE BRANCH BRANCHES LEAVES)
	(ADJECTIVE TREE CROOKED OLD ANCIENT)
	(DESCFCN DESCRIBE-TREE)
	(ACTION TREE-F)>

<ROUTINE DESCRIBE-TREE ("OPTIONAL" (CONTEXT <>) "AUX" X)
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <SET X <FIRST? ,TREE>>
	 <TELL "A">
	 <COND (<IS? .X ,VOWEL>
		<TELL "n">)>
         <TELL " " D .X " is wedged in the branches overhead.">
	 <RTRUE>>

<ROUTINE TREE-F ("AUX" (ST 0) WORD)
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <TELL CTHEO " tumbles out of the tree and ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-UP>
		<TELL "It's quite a nice tree, actually">
		<SET WORD <FIRST? ,TREE>>
		<COND (<T? .WORD>
		       <TELL ", except for " THE .WORD 
			     " wedged in its branches">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? ENTER CLIMB-ON CLIMB-UP CLIMB-OVER SIT LIE-DOWN
		       STAND-ON STAND REACH-IN>
		<NO-FOOTHOLDS>    
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? LEAP CLIMB-DOWN>>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? SHAKE HIT KNOCK PUSH PULL MOVE LOOSEN SWING>
		<SET WORD <GET ,P-NAMW 0>>
		<TELL "The ">
		<PRINTB .WORD>
		<TELL " move">
		<COND (<NOT <EQUAL? .WORD ,W?BRANCHES ,W?LEAVES>>
		       <TELL "s">)>
		<TELL " ever so slightly">
		<SET WORD <FIRST? ,TREE>>
		<COND (<T? .WORD>
		       <TELL ", " THE .WORD " not at all">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<TELL ,YOURE-ALREADY "under the tree." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
		 
<OBJECT PAN
	(LOC LONG-WATER)
	(DESC "statue")
	(FDESC "A charming statue stands nearby.")
	(SYNONYM STATUE SCULPTURE PETER PAN BOY PIPE PIPES)
	(ADJECTIVE CHARMING PETER)
	(ACTION PAN-F)>

<ROUTINE PAN-F ()
	 <COND (<VERB? EXAMINE READ LOOK-ON>
		<TELL CTHE ,PAN 
" portrays a carefree little boy playing a set of pipes." CR>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER CLIMB-UP SIT STAND-ON ENTER
		       LIE-DOWN>
		<TELL CTHE ,PAN "'s design prevents this." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<OBJECT SIRENS
	(LOC GLOBAL-OBJECTS)
	(DESC "sirens")
	(FLAGS NODESC PLURAL)
	(SYNONYM SIRENS SIREN WAIL)
	(ADJECTIVE AIR\-RAID AIR RAID)
	(ACTION SIRENS-F)>

<ROUTINE SIRENS-F ()
	 <COND (<OR <ZERO? ,RAID?>
		    <T? ,FREEZE?>>
		<TELL ,CANT "hear any" ,AT-MOMENT CR>
		<RFATAL>)
	       (<VERB? LISTEN>
		<TELL CTHEO " rise and fall with fateful urgency." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT MISSILE
	(LOC LOCAL-GLOBALS)
	(DESC "missile")
	(FLAGS NODESC)
	(SYNONYM MISSILE ROCKET CONE)
	(ADJECTIVE ENORMOUS LARGE BIG SILVER METAL NOSE
	 	   NUCLEAR THERMONUC ATOMIC RUSSIAN SOVIET COMMIE)
	(ACTION MISSILE-F)>

"TOUCHED = missile noticed."

<ROUTINE MISSILE-F ()
	 <COND (<NOT <IS? ,MISSILE ,TOUCHED>>
		<CANT-SEE-ANY ,MISSILE>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HCNT 5>
		       <I-LONDON-HOLE <>> ; "No CR."
		       <RTRUE>)>
		<TELL "The ">
		<COND (<L? ,HCNT 6>
		       <TELL "slowly falling ">)
		      (T
		       <TELL "floating ">)>
		<TELL D ,MISSILE
" is impressively large, sixty or seventy feet from nose to tail, aiming straight downward. A crimson hammer and sickle are lovingly painted on the hull."
		      CR>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER RIDE SIT STAND-ON LIE-DOWN>
		<THIS-IS-NOT "Dr. Strangelove">
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT LWDOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS PORTAL)
	(ADJECTIVE WOOD WOODEN WHITE)
	(ACTION LWDOOR-F)>

"TOUCHED = door seen."

<ROUTINE LWDOOR-F ()
	 <COND (<NOT <IS? ,LWDOOR ,TOUCHED>>
		<CANT-SEE-ANY ,LWDOOR>
		<RFATAL>)
	       (<NOUN-USED? ,W?DOORS ,W?DOORWAYS>
		<TELL "There's only one door here." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<UNEASY-DOOR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SWIM DIVE>>
		<COND (<HERE? IN-WATER>
		       <GO-INTO-LWDOOR>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? CLOSE>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<AND <NOT <HERE? IN-WATER>>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNEASY-DOOR ()
	 <TELL 
"Looking directly at the " D ,PRSO " makes you uneasy. It's as if your eyes can't decide whether it's really there or not." CR>
	 <RTRUE>>

<ROUTINE GO-INTO-LWDOOR ("AUX" (ST 0) X)
	 <COND (<BROLLY-OPEN?>
		<RFALSE>)>
	 
	 <MOVE ,MEEP ,TS6>
	 <QUEUE I-FMEEP -1>
	 <PUTP ,MEEP ,P?CONTFCN ,IN-TS6>

       ; <MEEP-TO-ZERO>
	 
	 <SETG RAID? <>>
	 <SETG FREEZE? <>>
	 <DEQUEUE I-LONDON-HOLE>
	 <DEQUEUE I-MEEP>
	 <DEQUEUE I-RUBY>
	 
	 <QUEUE I-SHADOW -1>
	 <QUEUE I-BUBBLES -1>
	 <QUEUE I-METEOR -1>
	 <QUEUE I-MAGPIE -1>
	 <QUEUE I-LUMP -1>
	 
	 <COND (<G? ,HCNT 1>
		<TELL "As y">)
	       (T
		<TELL "Y">)>
	 <TELL "ou wade to the threshold ">
	 <COND (<G? ,HCNT 1>
		<TELL "a familiar " D ,MEEP " flutters past">
		<ENTICINGLY>
		<TELL " as it slips through ">)
	       (T
		<TELL "of ">)>
	 <TELL THE ,LWDOOR ,PCR 
"All color abruptly drains from the landscape. Trees, sky and sun flatten into a spherical shell, with you at the very center. A hissing in your ears becomes a rumble, then a roar as the walls of the shell collapse inward, faster and faster" ,PCR>
	 <COND (<EQUAL? <GETB 0 30> 5>
		<INC ST>
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)
	       (T
		<TELL "\"">)>
	 <TELL "This way, please.">
	 <SEE-NO-ONE .ST>
	 <CRLF>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "This way,">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL " the voice urges. ">
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "Be quick.">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <ARTICULATES>
	 <TELL 
"\"No!\" your mind shudders. \"That's not a " D ,INTDIR "!\"" CR CR>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "It's a perfectly legitimate " D ,INTDIR ",">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL " retorts the voice with cold amusement. ">
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "Now come along.">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <CARRIAGE-RETURNS>
	 <CLEAR -1>
	 <SPLIT 14>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 10 25>
	 <BIG-TRINITY>	       
	 <CURSET 12 29>
	 <FANTASY>
	 <CURSET 13 15>
	 <COPYRIGHT>
	 <CURSET 14 21>
	 <TRADEMARK>
	 <SCREEN ,S-TEXT>
	 <SET X <INPUT 1>>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <TELL CR "You step out of the " D ,TS0-DOOR ,PCR>
	 <GOTO ,IN-MEADOW>
         <I-SHADOW>
	 <RTRUE>> 
				       	        	       	 
<ROUTINE MEEP-TO-ZERO ()
	 <MOVE ,MEEP ,AT-ZERO>
         <MAKE ,MEEP ,CHILLY>
         <MAKE ,MEEP ,TAKEABLE>
         <UNMAKE ,MEEP ,TRYTAKE>		       
	 <PUTP ,MEEP ,P?CONTFCN 0>
       ; <MAKE ,RUBY ,TOUCHED>
	 <MAKE ,RUBY ,SEEN>
	 <PUTP ,RUBY ,P?ACTION ,TRUBY-F>
	 <PUTP ,RUBY ,P?FDESC 0>
	 <RTRUE>>

<ROUTINE SEE-NO-ONE (ST)
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL CR CR "You turn, but see no one." CR>
	 <RTRUE>>

<ROUTINE ARTICULATES ()
	 <TELL CR CR "The space around you articulates. ">
	 <RTRUE>>

<OBJECT EWIND
	(LOC LOCAL-GLOBALS)
	(DESC "east wind")
	(FLAGS NODESC VOWEL SEEN)
	(SYNONYM WIND BREEZE GUST)
	(ADJECTIVE EAST EASTERN EASTERLY)
	(GENERIC GENERIC-WIND-F)
	(ACTION EWIND-F)>

<ROUTINE SAY-WIND ()
	 <COND (<IS? ,EWIND ,SEEN>
		<TELL D ,EWIND>)
	       (T
		<TELL D ,WWIND>)>
	 <RTRUE>>

<ROUTINE EWIND-F ()
	 <COND (<OR <T? ,FREEZE?>
		    <NOT <IS? ,EWIND ,SEEN>>>
		<TELL CTHE ,EWIND " seems to have stopped." CR>
		<RTRUE>)
	       (<HANDLE-WIND?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-WIND-F (TBL)
	 <COND (<IS? ,EWIND ,SEEN>
		<RETURN ,EWIND>)>
	 <RETURN ,WWIND>>

<OBJECT WWIND
	(LOC LOCAL-GLOBALS)
	(DESC "west wind")
	(FLAGS NODESC)
	(SYNONYM WIND BREEZE GUST)
	(ADJECTIVE WEST WESTERN WESTERLY)
	(GENERIC GENERIC-WIND-F)
	(ACTION WWIND-F)>

<ROUTINE WWIND-F ()
	 <COND (<OR <T? ,FREEZE?>
		    <NOT <IS? ,WWIND ,SEEN>>>
		<TELL CTHE ,WWIND " seems to have stopped." CR>
		<RTRUE>)
	       (<HANDLE-WIND?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-WIND? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL ,CANT "see wind!" CR>
		<RTRUE>)
	       (<AND <VERB? LISTEN TOUCH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "It blows briskly through the trees." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "It smells unusually fresh." CR>
		<RTRUE>)
	       (<VERB? LAMP-ON LAMP-OFF>
		<IMPOSSIBLE>
	        <RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT STAIR
	(LOC LOCAL-GLOBALS)
	(DESC "stairway")
	(FLAGS NODESC)
	(SYNONYM STAIR STAIRS STAIRWAY HYPOTENUSE TRIANGLE)
	(ADJECTIVE STEEP NARROW)
	(GENERIC GENERIC-TRIANGLE-F)
	(ACTION STAIR-F)>

<ROUTINE STAIR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The steep, narrow " D ,STAIR " extends ">
		<COND (<NOT <HERE? ON-GNOMON>>
		       <TELL "up">
		       <COND (<HERE? HALFWAY>
			      <TELL " and down,">)>)
		      (T
		       <TELL "down">)>
		<TELL " along the diagonal edge of the " D ,STRUCTURE
		      ,PERIOD>
		<RTRUE>)
	       (<HERE? HALFWAY>
		<COND (<VERB? CLIMB-DOWN>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<VERB? CLIMB-UP CLIMB-ON CLIMB-OVER>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (<VERB? USE CROSS FOLLOW>
		       <V-WALK-AROUND>
		       <RTRUE>)
		      (<VERB? LOOK-UP LOOK-DOWN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>)>
	 <COND (<HANDLE-STAIRS? ,ON-GNOMON>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE HANDLE-STAIRS? (TOP)
	 <COND (<NOT <EQUAL? ,HERE .TOP>>
		<SET TOP <>>)>
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <TELL "Better not. You might trip over ">
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "them ">)
			     (T
			      <TELL "it ">)>
		       <TELL "later." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? WALK-TO FOLLOW USE>
		<DO-WALK <COND (<ZERO? .TOP> ,P?UP) (T ,P?DOWN)>>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-ON>
		<COND (<ZERO? .TOP>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<COND (<ZERO? .TOP>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? LOOK-UP>
		<COND (<ZERO? .TOP>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? LOOK-DOWN LOOK-UNDER>
		<COND (<ZERO? .TOP>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GPLATFORM
	(LOC ON-GNOMON)
	(DESC "platform")
	(FLAGS NODESC)
	(SYNONYM PLATFORM FLOOR)
	(ADJECTIVE CIRCULAR ROUND TINY SMALL)
	(ACTION GPLATFORM-F)>

<ROUTINE GPLATFORM-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<ALREADY-IN ,GPLATFORM T>
		<RTRUE>)
	       (<OR <VERB? CLIMB-DOWN>
		    <EXITING?>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT STRUCTURE
	(LOC LOCAL-GLOBALS)
	(DESC "structure")
	(FLAGS NODESC)
	(SYNONYM STRUCTURE TRIANGLE)
	(ADJECTIVE TRIANGULAR)
	(GENERIC GENERIC-TRIANGLE-F)
	(ACTION STRUCTURE-F)>

<ROUTINE GENERIC-TRIANGLE-F (TBL)
	 <COND (<NOUN-USED? ,W?HYPOTENUSE>
		<RETURN ,STAIR>)>
	 <RETURN ,STRUCTURE>>

<ROUTINE STRUCTURE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "High and broad as it is, the " D ,STRUCTURE
" is only a few feet thick. Its "
D ,CSURFACE " is smooth and featureless, except for the " 
D ,STAIR " along the diagonal edge." CR>
		<RTRUE>)
	       (<AND <VERB? TOUCH KNOCK KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHE ,STRUCTURE " feels smooth and hard." CR>
		<RTRUE>)
	       (<VERB? ENTER THROUGH>
		<TELL "There are no visible " D ,CAVE-HOLE "s." CR>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP>
		<COND (<HERE? ON-GNOMON>
		       <ALREADY-AT-TOP>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? STAND-ON>
		<COND (<HERE? GBASE>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<TELL ,YOURE-ALREADY "on " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? CLIMB-DOWN>
		    <EXITING?>>
		<COND (<HERE? GBASE>
		       <NOT-IN ,STRUCTURE T>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT OUTER-SHADOW
	(LOC IN-MEADOW)
	(DESC "shadow")
	(SYNONYM SHADOW POINT TIP EDGE)
	(ADJECTIVE DARK BLACK TRIANGULAR)
	(DESCFCN DESCRIBE-OUTER-SHADOW)
        (ACTION OUTER-SHADOW-F)>

<ROUTINE DESCRIBE-OUTER-SHADOW ("OPTIONAL" (CONTEXT <>) "AUX" X)
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A triangular " D ,OUTER-SHADOW>
	 <COND (<ZERO? ,SUN-MOVING?>
		<TELL " lies ">)
	       (T
		<TELL <PICK-NEXT ,CREEPERS>>)>
	 <TELL "across the " D ,GROUND>
	 <SET X <GET ,OSIGN-DOORS ,OSIGN>>
	 <COND (<T? .X>
		<TELL ". ">
		<EXAMINE-OUTER-SHADOW>)>
	 <TELL ".">
	 <RTRUE>>
	
<ROUTINE OUTER-SHADOW-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<EXAMINE-OUTER-SHADOW>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<FOLLOW-SHADOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXAMINE-OUTER-SHADOW ("AUX" DOOR)
	 <SET DOOR <GET ,OSIGN-DOORS ,OSIGN>>
	 <TELL "Its sharp point ">
	 <COND (<ZERO? .DOOR>
		<COND (<ZERO? ,SUN-MOVING?>
		       <TELL "lies motionless" ,AGROUND>
		       <RTRUE>)>
		<TELL "is sweeping slowly ">
	        <SHDIRWARD>
		<RTRUE>)
	       (<ZERO? ,SUN-MOVING?>
		<TELL "rests ">
		<COND (<EQUAL? ,ODEG 5 6>
		       <TELL "exactly on ">)
		      (T
			<TELL "near ">)>)
	       (T
		<TELL "is ">
		<COND (<EQUAL? ,ODEG 4>
		       <TELL "almost touching ">)
		      (T
		       <TELL "sweeping ">
		       <COND (<EQUAL? ,ODEG 5 6>
		       	      <TELL "across ">)
		      	     (T
		       	      <SHDIRWARD>
			      <TELL ", ">
		       	      <COND (<L? ,ODEG 4>
			      	     <TELL "towards ">)
			     	    (T
			      	     <TELL "away from ">)>)>)>)>
	 <COND (<AND <NOT <IS? .DOOR ,NOALL>>
		     <IS? .DOOR ,OPENED>>
		<TELL "the open door in ">)>
	 <TELL THE ,TS0>
	 <RTRUE>>

<OBJECT INNER-SHADOW
	(LOC FCLEARING)
	(DESC "shadow")
	(SYNONYM SHADOW EDGE)
	(ADJECTIVE DARK BLACK)
	(DESCFCN DESCRIBE-INNER-SHADOW)
        (ACTION INNER-SHADOW-F)>

<ROUTINE DESCRIBE-INNER-SHADOW ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A dark " D ,INNER-SHADOW>
		<COND (<ZERO? ,SUN-MOVING?>
		       <TELL " lies">)
		      (T
		       <TELL <PICK-NEXT ,CREEPERS>>
		       <SHDIRWARD>)>
		<TELL ,AGROUND ".">
		<RTRUE>)
	       (T
		<RFALSE>)>>
	  
<ROUTINE INNER-SHADOW-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO>
		<COND (<ZERO? ,SUN-MOVING?>
		       <TELL " lies motionless" ,AGROUND ,PERIOD>
		       <RTRUE>)>
		<TELL " is sweeping slowly ">
		<SHDIRWARD>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<FOLLOW-SHADOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>			

<ROUTINE FOLLOW-SHADOW? ()
	 <COND (<AND <VERB? FOLLOW>
		     <IN? ,PRSO ,HERE>>
		<COND (<ZERO? ,SUN-MOVING?>
		       <PRSO-NOT-MOVING>
		       <RTRUE>)>
		<TELL "You follow the " D ,PRSO "'s sweep ">
		<SHDIRWARD>
		<TELL ,PCR>
		<DO-WALK <GET ,SHDIRS 1>>
		<RTRUE>)
	       (<MOVING-SHADOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MOVING-SHADOW? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? LAMP-OFF>
		<COND (<ZERO? ,SUN-MOVING?>
		       <PRSO-NOT-MOVING>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)
	       (<VERB? LAMP-ON MOVE>
		<COND (<ZERO? ,SUN-MOVING?>
		       <HOW?>
		       <RTRUE>)>
		<TELL CTHEO " is already moving." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSO-NOT-MOVING ()
	 <TELL CTHEO " doesn't seem to be moving" ,AT-MOMENT CR>
	 <RTRUE>>

<OBJECT DSHADOW
	(LOC LOCAL-GLOBALS)
	(DESC "shadow")
	(FLAGS NODESC)
	(SYNONYM SHADOW)
	(ADJECTIVE LONG DARK BLACK)
	(ACTION DSHADOW-F)>

<ROUTINE DSHADOW-F ("AUX" X)
	 <COND (<VERB? EXAMINE WATCH>
		<TELL "The long " D ,DSHADOW " stretches " <GET ,SHDIRS 3>
		      ,AGROUND>
		<COND (<NOT <HERE? GBASE>>
		       <TELL " below">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND LOOK-UNDER SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<MOVING-SHADOW?>
		<RTRUE>)
	       (<ENTERING?>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS0
	(LOC IN-MEADOW)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM BASE CROWN)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(TDOOR TS0-DOOR)
	(CAPACITY 30)
	(ACTION TS-F)>

<OBJECT TS1
	(LOC AT-FALLS)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM BASE CROWN)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(TDOOR TS1-DOOR)
	(CAPACITY 30)
	(ACTION TS-F)>

<OBJECT TS2
	(LOC OSSUARY)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM BASE CROWN)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(CAPACITY 30)
	(TDOOR TS2-DOOR)
	(ACTION TS-F)>

<OBJECT TS3
	(LOC ON-MESA)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM BASE CROWN)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(TDOOR TS3-DOOR)
	(CAPACITY 30)
	(ACTION TS-F)>

<OBJECT TS4
	(LOC IN-GARDEN)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM BASE CROWN)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(TDOOR TS4-DOOR)
	(CAPACITY 30)
	(ACTION TS-F)>

<OBJECT TS5
	(LOC ON-MOOR)
	(DESC "larger toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM STOOLS MUSHROOMS STEMS
	 	 BASE CROWN)
	(ADJECTIVE TOAD LARGER FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG
	 	   BIGGER)
	(FLAGS NODESC SURFACE)
	(TDOOR TS5-DOOR)
	(CAPACITY 30)
	(GENERIC GENERIC-TS-F)
	(ACTION TS-F)>

<OBJECT HTS
	(LOC ON-MOOR)
	(DESC "smaller toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM STOOLS MUSHROOMS STEMS
	 	 BASE CROWN)
	(ADJECTIVE TOAD SMALLER SMALL TINY)
	(FLAGS NODESC SURFACE)
	(CAPACITY 30)
	(GENERIC GENERIC-TS-F)
	(ACTION HTS-F)>

<ROUTINE GENERIC-TS-F (TABLE)
	 <COND (<EQUAL? ,P-IT-OBJECT ,TS5 ,HTS>
		<RETURN ,P-IT-OBJECT>)
	       (T
		<RETURN ,TS5>)>>

<ROUTINE HTS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Except for its size ">
		<COND (<NOT <IS? ,TS5-DOOR ,NOALL>>
		       <TELL "and lack of a door">)>
		<TELL ", the " D ,PRSO " is identical to the " D ,TS5 ,PERIOD>
		<RTRUE>)
	       (<AND <THIS-PRSI?>
		     <VERB? PUT-ON>>
		<PRSI-TOP-TOO-HIGH>
		<RTRUE>)
	       (<ENTERING?>
		<TELL CTHE ,HTS " has no visible " D ,HOPENING "s." CR>
		<RTRUE>)
	       (<SLIDE-OFF-STOOL?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS6
	(LOC ON-ISLE)
	(DESC "toadstool")
	(SYNONYM TOADSTOOL STOOL MUSHROOM STEM CROWN BASE)
	(ADJECTIVE TOAD FLESHY GIANT HUGE ENORMOUS GIGANTIC LARGE BIG)
	(FLAGS NODESC SURFACE)
	(TDOOR TS6-DOOR)
	(CAPACITY 30)
	(CONTFCN IN-TS6)
	(ACTION TS-F)>

<ROUTINE IN-TS6 ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL ,CANT "reach ">
		<COND (<THIS-PRSO?>
		       <TELL THEO>)
		      (T
		       <TELL THEI>)>
		<TELL ". ">
		<TOO-HIGH ,TS6>
		<RTRUE>)>
	 <RFALSE>>	 

<ROUTINE TS-F ("AUX" DOOR)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <PERFORM ,V?PUT ,PRSO <GETP ,PRSI ,P?TDOOR>>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PRSI-TOP-TOO-HIGH>
		       <RTRUE>)>
		<RFALSE>)>
	 <SET DOOR <GETP ,PRSO ,P?TDOOR>>
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO 
" must be at least twelve feet from base to crown">
		<COND (<NOT <IS? .DOOR ,NOALL>>
		       <TELL ". A">
		       <OPEN-CLOSED .DOOR T>
		       <TELL " is set into its fleshy stem">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND>
		<PERFORM ,V?LOOK-INSIDE .DOOR>
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<THIS-IS-NOT "Alice">
		<RTRUE>)
	       (<ENTERING?>
		<COND (<IS? .DOOR ,NOALL>
		       <DOOR-NOT-HERE>
		       <RTRUE>)
		      (<IS? .DOOR ,OPENED>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<ITS-CLOSED .DOOR>
		<RTRUE>)
	       (<SLIDE-OFF-STOOL?>
		<RTRUE>)	       
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-TOP-TOO-HIGH ()
	 <TELL "The top of the " D ,PRSI " is high out of reach." CR>
	 <RTRUE>>

<ROUTINE SLIDE-OFF-STOOL? ()
	 <COND (<VERB? CLIMB-ON CLIMB-OVER STAND-ON CLIMB-UP SIT LIE-DOWN
		       RIDE>
		<TELL "You slide off the slippery " D ,TS0 ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? CLIMB-DOWN>
		    <EXITING?>>
		<TELL "You're not on the " D ,TS0 ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS0-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN)
	(ACTION TS0-DOOR-F)>

<ROUTINE TS0-DOOR-F ()
	 <DOOR-NOT-HERE>
	 <RFATAL>>

<ROUTINE DOOR-NOT-HERE ()
	 <GONE-NOW ,TS1-DOOR>
	 <RFALSE>>

<OBJECT TS1-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN STATELY RESIDENTIAL)
	(ACTION TS1-DOOR-F)>

"NOALL = door used."

<ROUTINE TS1-DOOR-F ()
	 <COND (<OR <IS? ,TS1-DOOR ,NOALL>
		    <AND <HERE? IN-ORBIT ON-SAT>
			 <NOT <IS? ,TS1-DOOR ,OPENED>>>>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<NOT <HERE? AT-FALLS>>
		<COND (<OR <EQUAL? ,ORBCNT 1>
			   <AND <T? ,SUITED?>
				<HERE? ON-SAT>
				<EQUAL? ,ORBCNT 6 7 8>>>
		       <COND (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
			      <COND (<EQUAL? ,ORBCNT 7 8>
				     <RFALSE>)>
			      <CANT-SEE-MUCH>
			      <RTRUE>)
			     (<VERB? ENTER WALK-TO THROUGH USE FOLLOW>
			      <COND (<EQUAL? ,ORBCNT 1>
				     <CANT-FROM-HERE>
				     <RTRUE>)>
			      <FILM-HOLDS-YOU>
			      <RTRUE>)
			     (<VERB? EXIT LEAVE ESCAPE>
			      <NOT-IN>
			      <RTRUE>)
			     (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
			      <TELL "The door is ">
			      <COND (<EQUAL? ,ORBCNT 7 8>
				     <TELL "still a bit ">)>
			      <TELL "too far away." CR>
			      <RTRUE>)
			     (T
			      <CANT-FROM-HERE>
			      <RTRUE>)>)>
		<TELL ,CANT "see the door anymore. It's too far away." CR>
		<RFATAL>)
	       (<THRU-DOOR? ,AT-FALLS ,IN-ORBIT>
		<RTRUE>)
	       (<HANDLE-TSDOOR? ,AT-FALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE THRU-DOOR? (OUT IN)
	 <COND (<THIS-PRSO?>
		<RFALSE>)
	       (<NOT <VERB? PUT THROW>>
		<RFALSE>)
	       (<NOT <IS? ,PRSI ,OPENED>>
		<TELL CTHEO " strikes the closed door and ">
		<LANDS-AT-YOUR-FEET>
		<RTRUE>)
	       (<AND <PRSO? PARASOL>
		     <IS? ,PRSO ,OPENED>>
		<YOUD-HAVE-TO "close" ,PRSO>
		<RTRUE>)>
	 <COND (<HERE? AT-FALLS ON-MOOR>
		<REMOVE ,PRSO>)
	       (<EQUAL? ,HERE .OUT>
		<MOVE ,PRSO .IN>)
	       (<EQUAL? ,HERE .IN>
		<MOVE ,PRSO .OUT>)
	       (T
		<REMOVE ,PRSO>)>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL CTHEO " disappears through the open door." CR>
	 <RTRUE>>

<ROUTINE HANDLE-TSDOOR? (OUT)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The">
	 	<OPEN-CLOSED ,PRSO>
	 	<TELL " is of stately residential design." CR>
		<RTRUE>)
	       (<AND <VERB? LOOK-INSIDE LOOK-BEHIND LOOK-OUTSIDE>
		     <IS? ,PRSO ,OPENED>
		     <EQUAL? ,HERE .OUT>>
		<UNEASY-DOOR>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH SHAKE RAISE SQUEEZE LOOSEN>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<PRSO-WONT-BUDGE>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <IS? ,PRSO ,OPENED>>
		<TELL "That's odd. ">
		<PRSO-WONT-BUDGE>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "You feel a gentle but firm pressure." CR>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (<VERB? UNLOCK>
		<TELL CTHEO " doesn't have a keyhole." CR>
		<RTRUE>)
	       (<ENTERING?>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS2-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN STATELY RESIDENTIAL)
	(ACTION TS2-DOOR-F)>

"NOALL = door used."

<ROUTINE TS2-DOOR-F ()
	 <COND (<OR <IS? ,TS2-DOOR ,NOALL>
		    <AND <HERE? TUN1>
			 <NOT <IS? ,TS2-DOOR ,OPENED>>>>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<THRU-DOOR? ,OSSUARY ,TUN1>
		<RTRUE>)
	       (<HANDLE-TSDOOR? ,OSSUARY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS3-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN)
	(ACTION TS3-DOOR-F)>

"NOALL = door used."

<ROUTINE TS3-DOOR-F ()
	 <COND (<IS? ,TS3-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<THRU-DOOR? ,ON-MESA ,ON-SCAFFOLD>
		<RTRUE>)
	       (<HANDLE-TSDOOR? ,ON-MESA>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS4-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE WHITE WOOD WOODEN)
	(GENERIC GENERIC-DOOR-F)
	(ACTION TS4-DOOR-F)>

"NOALL = door used."

<ROUTINE TS4-DOOR-F ()
	 <COND (<OR <IS? ,TS4-DOOR ,NOALL>
		    <AND <HERE? ON-PLATFORM>
			 <NOT <IS? ,TS4-DOOR ,OPENED>>>>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<THRU-DOOR? ,IN-GARDEN ,ON-PLATFORM>
		<RTRUE>)
	       (<HANDLE-TSDOOR? ,IN-GARDEN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS5-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN)
      	(ACTION TS5-DOOR-F)>

"NOALL = door used."

<ROUTINE TS5-DOOR-F ()
	 <COND (<OR <IS? ,TS5-DOOR ,NOALL>
		    <AND <HERE? IN-SKY ON-BIRD>
			 <NOT <IS? ,TS5-DOOR ,OPENED>>>>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<HERE? IN-SKY>
		<COND (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<OR <ENTERING?>
			   <VERB? CLIMB-UP>>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (T
		       <CANT-FROM-HERE>)>
		<RTRUE>)
	       (<NOT <HERE? ON-MOOR ON-BIRD>>
		<TELL ,CANT "see the door from here." CR>
		<RFATAL>)
	       (<THRU-DOOR? ,ON-MOOR ,ON-BIRD>
		<RTRUE>)
	       (<HANDLE-TSDOOR? ,ON-MOOR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TS6-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "white door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORWAY PORTAL ENTRY EXIT ENTRANCE THRESHOLD)
	(ADJECTIVE WHITE WOOD WOODEN)
	(ACTION TS6-DOOR-F)>

"NOALL = door used."

<ROUTINE TS6-DOOR-F ()
	 <COND (<IS? ,TS6-DOOR ,NOALL>
		<DOOR-NOT-HERE>
		<RFATAL>)
	       (<THRU-DOOR? ,ON-ISLE ,IN-SHACK>
		<RTRUE>)
	       (<AND <HERE? IN-SHACK>
		     <IS? ,TS6-DOOR ,OPENED>
		     <OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
			 <ENTERING?>>>
		<KILL-TS6-DOOR>
		<RFATAL>)
	       (<HANDLE-TSDOOR? ,ON-ISLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCULPTURE
	(LOC ARBORETUM)
	(DESC "sparkling sculpture")
	(FLAGS TRYTAKE CONTAINER TRANSPARENT OPENED)
	(SYNONYM SCULPTURE BOTTLE CRYSTAL INSCRIPTI BASE WORDS DATE
	 	 DATES)
	(ADJECTIVE ABSTRACT KLEIN CRYSTAL SPARKLING CRYSTALLI)
	(CAPACITY 50)
	(DESCFCN DESCRIBE-SCULPTURE)
	(ACTION SCULPTURE-F)>

"TOUCHED = examined."

<ROUTINE DESCRIBE-SCULPTURE ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "An abstract " D ,SCULPTURE
	       " stands between the " D ,TUNNEL "s. ">
	 <READ-KLEIN>
	 <RTRUE>>

<ROUTINE READ-KLEIN ()
	 <TELL "The words ">
	 <ITALICIZE <COND (<ZERO? ,FLIP?> "Felix Klein 1849-1925")
			  (T "5291-9481 nielK xileF")>>
	 <TELL " are inscribed on the base.">
	 <RTRUE>>

<ROUTINE SCULPTURE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <COND (<AND <PRSO? PARASOL>
				   <IS? ,PRSO ,OPENED>>
			      <YOUD-HAVE-TO "close" ,PRSO>
			      <RTRUE>)>
		       <MOVE ,PRSO ,ARBOR-TOP>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO
" disappears into the " D ,ENERGY "'s sparkling depths." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" looks like a crystalline bottle, eight feet high, with a polished " 
D ,CSURFACE " that twists in impossible curves. ">
		<INSIDE-BEGINS>
		<CRLF>
		<READ-KLEIN>
		<CRLF>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <WINDOW <GET ,QUOTES ,CLARKE> 9>
		       <WINDOW <GET ,QUOTES ,PDL> 49>
		       <COND (<ZERO? ,VERBOSITY>
			      <CRLF>)>
		       <RFATAL>)>
		<RTRUE>)
	       (<VERB? READ LOOK-ON>
		<READ-KLEIN>
		<CRLF>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<TELL "Staring into the " D ,PRSO
		      " makes your eyes hurt. ">
		<INSIDE-BEGINS>
		<RTRUE>)
	       (<VERB? REACH-IN OPEN OPEN-WITH CLOSE ENTER THROUGH CLIMB-ON
		       CLIMB-OVER STAND-ON SIT CLIMB-UP>
		<TELL "Easier said than done. ">
		<INSIDE-BEGINS>
		<RTRUE>)
	       (<AND <VERB? TOUCH SQUEEZE KISS KNOCK KICK>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO " feels oddly insubstantial." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
	        <PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<ROUTINE INSIDE-BEGINS ()
	 <TELL "It's hard to tell where the outside of the " D ,ENERGY
	       " ends and the inside begins." CR>
	 <RTRUE>>
		
<OBJECT AXE
	(LOC ARBOR-TOP)
	(DESC "axe")
	(FLAGS SHARPENED TAKEABLE VOWEL ; FERRIC)
	(FDESC
"An arborvitae is cleaved by a silver axe.")
	(SYNONYM AXE AX BLADE)
	(ADJECTIVE SILVER)
	(VALUE 0)
	(SIZE 7)
	(MASS 7)
        (ACTION AXE-F)>

<ROUTINE AXE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? CUT RIP HIT MUNG OPEN-WITH>
		     	    <IN? ,PRSO ,PLAYER>>
		       <TELL 
"It'd be dangerous to do that while holding " THEO ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? EXAMINE TOUCH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "The silver blade is still sharp." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <TELL "You yank the axe out of the arborvitae." CR>
		       <UPDATE-SCORE>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT OAK
	(LOC LOCAL-GLOBALS)
	(DESC "oak tree")
	(FLAGS NODESC VOWEL TRYTAKE NOALL)
	(SYNONYM TREE OAK BRANCHES BRANCH WOOD)
	(ADJECTIVE OAK WOODEN)
	(VALUE 0)
	(GENERIC GENERIC-TREE-F)
	(ACTION OAK-F)>

<ROUTINE GENERIC-TREE-F (TBL)
	 <COND (<HERE? AT-CHASM ON-MESA>
		<RETURN ,OAK>)>
	 <RFALSE>>

"NOALL = standing, TOUCHED = fallen, WINDY = fallen across chasm."

<ROUTINE OAK-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,NOALL>
		       <TELL " spreads like a green canopy overhead." CR>
		       <RTRUE>)
		      (<IS? ,PRSO ,TOUCHED>
		       <TELL " lies fallen across the ">
		       <COND (<IS? ,PRSO ,WINDY>
			      <TELL D ,CHASM>)
			     (T
			      <TELL D ,GROUND>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<TELL " is falling!" CR>
		<RTRUE>)
	       
	       (<VERB? TAKE PUSH PULL MOVE TURN>
		<COND (<OR <IS? ,PRSO ,TOUCHED>
			   <IS? ,PRSO ,NOALL>>
		       <TRY-MOVING-OAK>
		       <RTRUE>)>
		<HAPHAZARD>
		<RTRUE>)
	       
	       (<VERB? PUSH-TO>
		<COND (<OR <IS? ,PRSO ,TOUCHED>
			   <IS? ,PRSO ,NOALL>>
		       <TRY-MOVING-OAK>
		       <RTRUE>)
		      (<OR <PRSI? CHASM MESA>
			   <AND <PRSI? INTDIR>
		                <EQUAL? ,P-DIRECTION ,P?NORTH ,P?NE ,P?NW>>>
		       <DEQUEUE I-DROP-OAK>
	               <MAKE ,PRSO ,TOUCHED>
	               <MAKE ,PRSO ,WINDY>
		       <TELL "You ">
	               <PRINTB ,P-PRSA-WORD>
	               <TELL 
" the teetering oak northward with all your strength. It arcs across the chasm with a leafy whoosh and crashes onto the mesa, barely missing the "
D ,TS3 ,PERIOD>
	               <UPDATE-SCORE 3>
		       <RTRUE>)>
		<HAPHAZARD>
		<RTRUE>)
	       
	       (<VERB? CUT RIP MUNG KILL>
		<COND (<NOT <IS? ,PRSO ,NOALL>>
		       <TELL "You've already killed the oak." CR>
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? AXE>
		       <PUTP ,AT-CHASM ,P?OVERHEAD 0>
		       <UNMAKE ,PRSO ,NOALL>
		       <QUEUE I-DROP-OAK 2>
		       <TELL
"You chop at both sides of the oak's trunk until it teeters uncertainly, deciding which way it will fall." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would affect the oak">
		<RTRUE>)
	       (<VERB? CROSS CLIMB-OVER FOLLOW>
		<COND (<IS? ,PRSO ,WINDY>
		       <DO-WALK <COND (<HERE? AT-CHASM> ,P?NORTH)
				      (T                ,P?SOUTH)>>
		       <RTRUE>)
		      (<IS? ,PRSO ,TOUCHED>
		       <CAVORTING>
		       <RTRUE>)>
		<NO-FOOTHOLDS>
		<RTRUE>)
	       (<VERB? ENTER CLIMB-ON CLIMB-UP SIT STAND-ON LIE-DOWN>
		<COND (<IS? ,PRSO ,NOALL>
		       <NO-FOOTHOLDS>
		       <RTRUE>)>
		<CAVORTING>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TRY-MOVING-OAK ()
	 <TELL "You aren't strong enough to do that." CR>
	 <RTRUE>>
		      
<ROUTINE CAVORTING ()
	 <TELL "You soon tire of cavorting around the oak." CR>
	 <RTRUE>>

<ROUTINE HAPHAZARD ()
	 <TELL "Your uncoordinated attempt to ">
	 <PRINTB ,P-PRSA-WORD>
	 <TELL " the oak only speeds its descent." CR>
	 <RTRUE>>
                                       
<OBJECT CHASM
	(LOC LOCAL-GLOBALS)
	(DESC "chasm")
	(FLAGS NODESC CONTAINER OPENED)
	(SYNONYM CHASM CANYON EDGE BRINK ROCKS ROCK)
	(ADJECTIVE CHASM\'S DEEP BROAD WIDE ROCK)
        (ACTION CHASM-F)>

"TOUCHED = chasm examined."

<ROUTINE CHASM-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <VANISH>
		       <TELL CTHEO " disappears into the " D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-DOWN>
		<MAKE ,PRSO ,TOUCHED>
		<TELL CTHEO
" is several hundred feet deep. Treetops block your view of the bottom." CR>
		<RTRUE>)
	       (<VERB? LOOK-UP>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? LEAP DIVE ENTER CLIMB-DOWN>
		<CHASM-FALL>		      
		<RTRUE>)
	       (<VERB? CROSS CLIMB-OVER>
		<COND (<HERE? AT-CHASM>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)
		      (<HERE? ON-MESA>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TREETOPS
	(LOC LOCAL-GLOBALS)
	(DESC "treetops")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM TREES TREETOPS TOPS TOP)
	(ADJECTIVE TREE)
	(ACTION TREETOPS-F)>

<ROUTINE TREETOPS-F ()
	 <COND (<NOT <IS? ,CHASM ,TOUCHED>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH LOOK-UNDER
		       LOOK-BEHIND>
		<TELL "Looking at the " D ,PRSO
		      " below makes you giddy." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT MESA
	(LOC LOCAL-GLOBALS)
	(DESC "mesa")
	(FLAGS NODESC)
	(SYNONYM MESA SUMMIT TOP)
        (ACTION MESA-F)>
			
<ROUTINE MESA-F ("AUX" (ON <>))
	 <COND (<HERE? ON-MESA>
		<SET ON T>)>
	 <COND (<AND <THIS-PRSI?>
		     <VERB? PUSH-TO>
		     <PRSO? OAK>>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<COND (<ZERO? .ON>
		       <TELL CTHEO
"'s summit is ornamented with a giant " D ,AUX-TS3 ,PERIOD>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-OVER CROSS STAND-ON CLIMB-UP>>
		<COND (<ZERO? .ON>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? .ON>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<AND <ZERO? .ON>
		     <OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
			 <ENTERING?>>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>	 

<OBJECT AUX-TS3
	(LOC AT-CHASM)
	(DESC "toadstool")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM TOADSTOOL STOOL MUSHROOM)
	(ADJECTIVE TOAD LARGE BIG GIANT HUGE)
	(TDOOR TS3-DOOR)
	(ACTION AUX-TS3-F)>

<ROUTINE AUX-TS3-F ()
	 <COND (<ENTERING?>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<NOT <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<TS-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GLOWING-LOG
	(LOC SBOG)
	(DESC "log")
	(FLAGS SURFACE TRYTAKE)
	(SYNONYM LOG LIGHT GLOW EDGE WOOD)
	(ADJECTIVE EERIE GLOWING PHOSPHORE ROTTEN SPLINTERE)
	(DESCFCN DESCRIBE-LOG)
	(ACTION GLOWING-LOG-F)>

<ROUTINE DESCRIBE-LOG ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL 
"A splintered log lies rotting in the mist at your feet. ">
		<SAY-GLOWS>
		<RTRUE>)
	       (T
		<RFALSE>)>>  

<ROUTINE SAY-GLOWS ()
	 <TELL 
"Its edges flicker with the eerie phosphorescence of decay.">
	 <RTRUE>>

<ROUTINE GLOWING-LOG-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? THROW>
			    <G? <GETP ,PRSO ,P?MASS> 2>>
		       <MOVE ,PRSO ,SBOG>
		       <TELL CTHEO " shatters the log ">
		       <INTO-CORRUPTION>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON THROW>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<SAY-GLOWS>
		<CRLF>
		<RTRUE>)
	       (<HANDLE-LOG?>
		<RTRUE>)
	       (<OR <VERB? KICK HIT KNOCK>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL CTHEO " crumbles ">
		<INTO-CORRUPTION T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-LOG? ()
	 <COND (<VERB? LOOK-INSIDE SEARCH>
		<TELL CTHEO " is rotten with decay." CR>
		<RTRUE>)
	       (<VERB? TOUCH SQUEEZE KISS>
		<TELL CTHEO " feels old and squishy." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " is dank with corruption." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE INTO-CORRUPTION ("OPTIONAL" (TOUCH? <>))
	 <MOVE ,HEAP ,SBOG>
	 <REMOVE ,GLOWING-LOG>
	 <MOVE ,SHARD ,SBOG>
	 <SETG P-IT-OBJECT ,SHARD>
	 <TELL "into a " D ,HEAP>
	 <COND (<T? .TOUCH?>
		<TELL " when you try to move it">)>
	 <TELL ". Only a big " D ,SHARD " of wood remains." CR>
	 <RTRUE>> 

<OBJECT SHARD
	(DESC "splinter")
	(FLAGS TAKEABLE LIGHTED)
	(SYNONYM SPLINTER SHARD WOOD LIGHT)
	(ADJECTIVE GLOWING FLICKERING BIG LARGE)
	(SIZE 5)
	(MASS 3)
	(VALUE 1)
	(GENERIC GENERIC-BULB-F)
	(ACTION SHARD-F)>

<ROUTINE SHARD-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " is about a foot long. ">
		<SAY-GLOWS>
		<CRLF>
		<RTRUE>)
	       (<VERB? POINT-AT SHINE-AT>
		<TELL CTHEO " illuminates " THEI " rather poorly." CR>
		<RTRUE>)
	       (<HANDLE-LOG?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HEAP
	(DESC "heap of damp corruption")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM HEAP CORRUPTION LOG)
	(ADJECTIVE DAMP)
	(ACTION HEAP-F)>

<ROUTINE HEAP-F ()
	 <COND (<NOUN-USED? ,W?LOG>
		<TELL "All that's left of the log is a " D ,HEAP ,PERIOD>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER SEARCH DIG>
		<TELL "Nothing " <PICK-NEXT ,YAWNS> " turns up." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL "It crumbles uselessly." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT XRAY
	(LOC LOCAL-GLOBALS)
	(DESC "satellite")
	(FLAGS NODESC)
	(SYNONYM SATELLITE SPACECRAFT SHIP CRAFT FUSILAGE HULL)
        (ACTION XRAY-F)>

"TOUCHED = satellite seen."

<ROUTINE XRAY-F ("AUX" (ON? <>))
	 <COND (<NOT <IS? ,XRAY ,TOUCHED>>
		<CANT-SEE-ANY ,XRAY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<HERE? ON-SAT>
		<SET ON? T>)>
	 <COND (<VERB? EXAMINE LOOK-ON SEARCH>
		<LOOK-AT-XRAY>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<HOW?>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? LEAP>>
		<COND (<ZERO? .ON?>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<FILM-HOLDS-YOU>
		<RTRUE>)
	       (<VERB? WALK-TO CLIMB-ON CLIMB-OVER>
		<COND (<T? .ON?>
		       <ALREADY-IN ,PRSO T>
		       <RTRUE>)>
		<XRAY-TOO-FAR>
		<RTRUE>)
	       (<AND <ZERO? .ON?>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<XRAY-TOO-FAR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FILM-HOLDS-YOU ()
	 <TELL "You struggle to push " D ,ME " away from the " D ,XRAY
	       ", but the " D ,FILM " holds you fast." CR>
	 <RTRUE>>

<ROUTINE XRAY-TOO-FAR ()
	 <TELL CTHE ,XRAY " is ">
	 <COND (<EQUAL? ,ORBCNT 4 5>
		<TELL "a little ">)>
	 <TELL "too far away." CR>
	 <RTRUE>>

<OBJECT STARS
	(LOC LOCAL-GLOBALS)
	(DESC "stars")
	(FLAGS PLURAL)
	(SYNONYM STARS STAR CONSTELLA)
	(ADJECTIVE BRIGHT NUMEROUS)
	(ACTION STARS-F)>

<ROUTINE STARS-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-UP>
		<TELL CTHEO 
" are remarkably bright and numerous." CR>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ICBM
	(LOC LOCAL-GLOBALS)
	(DESC "missile")
	(SYNONYM MISSILE ROCKET FLAME PILLAR EXHAUST)
	(ADJECTIVE RISING)
	(ACTION ICBM-F)>

<ROUTINE ICBM-F ()
	 <COND (<NOT <IS? ,ICBM ,TOUCHED>>
		<CANT-SEE-ANY ,ICBM>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" is too far away to see clearly. But its trajectory is hurling it northward, over the Arctic pole." CR>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <ENTERING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT THRUSTERS
	(LOC LOCAL-GLOBALS)
	(DESC "maneuvering thrusters")
	(FLAGS NOALL NODESC PLURAL TRYTAKE)
	(SYNONYM THRUSTERS THRUSTER JET JETS)
	(ADJECTIVE MANEUVERING SMALL TINY)
	(ACTION THRUSTERS-F)>

<ROUTINE THRUSTERS-F ()
	 <COND (<NOT <IS? ,XRAY ,TOUCHED>>
		<CANT-SEE-ANY ,THRUSTERS>
		<RFATAL>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" are tiny jets attached to the " D ,XRAY "'s hull." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       		       
<OBJECT SPHONES
	(LOC BOY)
	(DESC "headphones")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM PHONES HEADPHONES EARPHONES CANS MUSIC)
	(ADJECTIVE HEAD EAR STEREO)
	(ACTION SPHONES-F)>

<ROUTINE SPHONES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? LISTEN USE>
		<HEAR-GIANT-MUSIC>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<ANNOY-BOY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PHONES
	(LOC GIANT)
	(DESC "headphones")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM PHONES HEADPHONES EARPHONES MUSIC)
	(ADJECTIVE HEAD EAR STEREO)
	(ACTION PHONES-F)>

"TOUCHED = phones mentioned in room description."

<ROUTINE PHONES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"Except for their size (about four feet across), you see nothing "
<PICK-NEXT ,YAWNS> " about the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN USE>
		<HEAR-GIANT-MUSIC>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-REACH ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DISH
	(LOC PROM)
	(DESC "dish")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM DISH)
	(ADJECTIVE BIG LARGE)
	(ACTION DISH-F)>

<GLOBAL IN-DISH?:FLAG <>>

<ROUTINE DISH-F ()
	 <COND (<VERB? EMPTY>
		<SPLASHES>
		<RTRUE>)
	       (<HANDLE-SOAPY-WATER?>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO 
" is about the size of a small swimming pool, and">
		<IS-FILLED>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SDISH
	(LOC AT-TERRACE)
	(DESC "dish")
	(FLAGS NODESC TRYTAKE CONTAINER OPENED WATERY)
	(CAPACITY 5)
	(SYNONYM DISH BOWL WATER LIQUID)
	(ADJECTIVE SOAP SOAPY WHITE)
	(ACTION SDISH-F)>

<ROUTINE SDISH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		       <ANNOY-BOY>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO>
		<IS-FILLED>
		<RTRUE>)
	       (<VERB? EMPTY>
		<SPLASHES>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<ANNOY-BOY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IS-FILLED ()
	 <TELL " is filled to the brim with " D ,SOAPY-WATER ,PERIOD>
	 <RTRUE>> 

<OBJECT SOAPY-WATER
	(LOC DISH)
	(DESC "soapy water")
	(FLAGS NODESC TRYTAKE NOALL WATERY)
	(SYNONYM WATER LIQUID SOAP)
	(ADJECTIVE WHITE SOAPY)
	(ACTION SOAPY-WATER-F)>

<ROUTINE SOAPY-WATER-F ()
	 <COND (<HANDLE-SOAPY-WATER?>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL "The water is white and soapy." CR>
		<RTRUE>)
	       (<VERB? TAKE SHAKE KICK>
		<SPLASHES ,PRSO>
		<RTRUE>)
	       (<VERB? STAND-ON CROSS>
		<THIS-IS-NOT "The New Testament">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPLASHES ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<TELL "Water">)
	       (T
		<TELL CTHE .OBJ>)>
	 <TELL " splashes all over the place." CR>
	 <RTRUE>>
		
<ROUTINE HANDLE-SOAPY-WATER? ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<PRSO? HANDS FEET>
		       	      <WET-AND-SLIPPERY>
		       	      <RTRUE>)>
		       <PRSO-INTO-SOAPY-WATER>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-DOWN>>
		<COND (<ZERO? ,IN-DISH?>
		       <ENTER-DISH>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<VERB? SIT LIE-DOWN SWIM DIVE LEAP>
		<COND (<ZERO? ,IN-DISH?>
		       <ENTER-DISH>
		       <RTRUE>)>
		<TELL "You're wet enough already." CR>
		<RTRUE>)
	       (<OR <VERB? CLIMB-UP>
		    <EXITING?>>
		<COND (<ZERO? ,IN-DISH?>
		       <NOT-IN>
		       <RTRUE>)>
		<EXIT-DISH>
		<RTRUE>)
	       (<AND <VERB? TOUCH REACH-IN KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<WET-AND-SLIPPERY>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<TELL "Yuck! " CTHEO " tastes awful." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL 
"Its lemony scent reminds you of dishwashing liquid." CR>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE WET-AND-SLIPPERY ()
	 <TELL "It feels wet and slippery." CR>
	 <RTRUE>>

<ROUTINE PRSO-INTO-SOAPY-WATER ()
	 <VANISH>
	 <TELL CTHEO " sinks without a trace into the white, " 
	       D ,SOAPY-WATER ,PERIOD>
	 <RTRUE>>

<ROUTINE ENTER-DISH ()
	 <SETG OLD-HERE <>>
	 <SETG IN-DISH? T>
	 <TELL "You clamber over the edge of the dish">
	 <COND (<T? ,SUITED?>
		<POP-BUBBLE-SUIT>
		<TELL ,PTHE D ,FILM " around you">
		<SAY-POP>
		<TELL ", and you ">)
	       (T
		<TELL ", and ">)>
	 <TELL "find " D ,ME 
" up to your knees in white, slippery water." CR>
	 <RTRUE>>

<ROUTINE POP-BUBBLE-SUIT ()
	 <SETG SUITED? 0>
	 <SETG OLD-HERE <>>
	 <DEQUEUE I-BUBBLE-SUIT>
	 <RTRUE>>

<ROUTINE EXIT-DISH ()
	 <SETG OLD-HERE <>>
	 <SETG IN-DISH? <>>
	 <TELL "You clamber out of the dish." CR>
	 <RTRUE>>

<OBJECT WAND
	(LOC BOY)
	(DESC "bubble wand")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WAND STICK HOOP HOOPS)
	(ADJECTIVE FLAT PLASTIC BUBBLE HIS)
	(ACTION WAND-F)>

<ROUTINE WAND-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"It's a flat plastic stick, with hoops molded onto each end for blowing "
D ,SBUBBLE "s." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<COND (<IN? ,PRSO ,BOY>
		       <ANNOY-BOY>
		       <RTRUE>)>
		<CANT-REACH ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ANNOY-BOY ()
	 <TELL "\"Aow!\"|
|
The startled boy leaps backward at your approach, splashing water all over the place. \"Stupid git!\" he cries (in an intriguing Cockney accent). Then he retrieves the empty dish, pockets the wand and disappears between the prams, glaring at you over his shoulder." CR>
	 <LAST-BUBBLE>
	 <BOY-SCRAMS>
	 <RTRUE>>

<ROUTINE LAST-BUBBLE ()
	 <COND (<EQUAL? ,BACTION 1 2>
		<TELL CR 
"His last bubble floats away over the treetops." CR>)>
	 <RTRUE>>

<ROUTINE BOY-SCRAMS ()
	 <REMOVE ,BOY>
	 <MAKE ,BOY ,CHILLY>
	 <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
	 <REMOVE ,SDISH>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <MAKE ,HERE ,NOALL>
	 <DEQUEUE I-BOY>
	 <SETG BACTION 0>
	 <MOVE ,WAND ,GIANT>
	 <RTRUE>>

<OBJECT SBUBBLE
	(LOC GLOBAL-OBJECTS)
	(DESC "soap bubble")
	(FLAGS NODESC)
	(SYNONYM BUBBLE BUBBLES)
	(ADJECTIVE SOAP IRIDESCENT COLORS)
	(GENERIC GENERIC-BUBBLE-F)
	(ACTION SBUBBLE-F)>

"NOALL in room = bubble not visible."

<ROUTINE SBUBBLE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? BLOW-INTO>
		<TELL ,DONT "have any bubble-blowing " D ,MIKE ,PERIOD>
		<RTRUE>)
	       (<OR <NOT <HERE? PROM AT-TERRACE>>
		    <IS? ,HERE ,NOALL>>
		<NONE-AT-MOMENT>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " shimmers with iridescent color." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<TELL CTHEO " is filled with air." CR>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHEO " is floating high out of reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-BUBBLE-F (TABLE)
	 <COND (<IS? ,HERE ,NOALL>
		<RETURN ,FILM>)
	       (<ZERO? ,SUITED?>
		<RETURN ,SBUBBLE>)
	       (T
		<RETURN ,FILM>)>>

<OBJECT FILM
	(LOC GLOBAL-OBJECTS)
	(DESC "soapy film")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM FILM COLORS COLOR BUBBLE)
	(ADJECTIVE SOAP SOAPY IRIDESCENT)
	(GENERIC GENERIC-BUBBLE-F)
	(ACTION FILM-F)>

<ROUTINE FILM-F ("AUX" (VAC? <>))
	 <COND (<ZERO? ,SUITED?>
		<REFERRING>
		<RFATAL>)
	       (<HERE? IN-ORBIT ON-SAT>
		<SET VAC? T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER TOUCH-TO>
		       <COND (<PRSO? AXE PARASOL GNOMON SPADE>
		       	      <BREAK-FILM-WITH ,PRSO>
		       	      <RTRUE>)>
		       <PRSO-BOUNCES>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH WATCH>
		<COND (<HERE? ON-SAT>
		       <TELL CTHEO " is anchored to the " D ,XRAY
			     " with the " D ,LUMP ,PERIOD>
		       <RTRUE>)
		      (<HERE? IN-SKY IN-ORBIT ON-SAT>
		       <TELL CTHEO " strains against the ">
		       <COND (<HERE? IN-SKY>
			      <TELL "passing wind." CR>
			      <RTRUE>)>
		       <TELL "surrounding vacuum." CR>
		       <RTRUE>)>
		<I-BUBBLE-SUIT <>>
		<RTRUE>)
	       (<AND <VERB? TOUCH KNOCK KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO " feels remarkably ">
		<COND (<ZERO? .VAC?>
		       <TELL "flexible." CR>
		       <RTRUE>)>
		<TELL "firm in the vacuum of space." CR>
		<RTRUE>)
	       (<VERB? HIT KICK POP SQUEEZE CUT RIP MUNG>
		<COND (<PRSI? AXE PARASOL GNOMON SPADE>
		       <BREAK-FILM-WITH ,PRSI>
		       <RTRUE>)
                      (<AND <EQUAL? ,SUITED? 1>
			    <NOT <HERE? IN-ORBIT ON-SAT IN-SKY>>>
		       <I-BUBBLE-SUIT <>>
		       <RTRUE>)>
		<TELL CTHEO> 
		<COND (<NOT <HERE? IN-ORBIT ON-SAT>>
		       <TELL " flexes like rubber, but">)>
		<TELL " remains intact." CR>
		<RTRUE>)
	       (<ENTERING?>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<ROUTINE PRSO-BOUNCES ()
	 <TELL CTHEO " bounces off the " D ,FILM
	       " and ricochets around until you catch it." CR>
	 <RTRUE>>

<ROUTINE BREAK-FILM-WITH (OBJ)
	 <POP-BUBBLE-SUIT>
	 <TELL "The sharp ">
	 <COND (<EQUAL? .OBJ ,AXE ,GNOMON>
	        <TELL "edge">)
	       (T
		<TELL "point">)>
	 <TELL " of " THE .OBJ " str">
	 <COND (<VERB? THROW>
		<TELL "ike">)
	       (T
		<TELL "ain">)>
	 <TELL "s against the shimmering wall of soap.." ,PCR>
	 <ITALICIZE "Bang!">
	 <TELL " The film disappears in an explosion of color">
	 <COND (<HERE? IN-SKY>
		<BROLLY-FILLS?>
		<RTRUE>)
	       (<HERE? IN-ORBIT ON-SAT>
		<TELL "ful ice crystals">
		<COND (<VERB? THROW>
		       <REMOVE .OBJ>
		       <TELL ". " CTHE .OBJ
			     " sails off on a new orbit of its own">)>
		
		<COND (<HERE? ON-SAT>
		       <TELL ".|
|
You're blown violently away from the " D ,XRAY>
		       <COND (<EQUAL? ,ORBCNT 7 8>
			      <COND (<AND <IS? ,TS1-DOOR ,OPENED>
					  <NOT <IS? ,TS1-DOOR ,NOALL>>>
				     <TELL ", straight towards the "
				    	   D ,TS1-DOOR>)>
			      <PRINT ,PERIOD>
			      <ICE-VAC>
			      <COND (<EQUAL? ,ORBCNT 7>
				     <I-ORBIT>)>
			      <TELL CR "The plutonium heart of the " D ,XRAY
 				    " erupts in a searing glare">
			      <COND (<OR <NOT <IS? ,TS1-DOOR ,OPENED>>
					 <IS? ,TS1-DOOR ,NOALL>>
				     <STAR-WARS>
				     <RTRUE>)>
			      <TELL " as you cross the threshold...">
			      <DEQUEUE I-VACUUM>
			      <DEQUEUE I-ORBIT>
			      <DEQUEUE I-LUMP>
			      <SETG QUIET? <>>
			      <EXIT-HOLE ,TS1-DOOR ,AT-FALLS>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <GOTO ,IN-ORBIT>
		       <ICE-VAC>		       
		       <RTRUE>)>
		<PRINT ,PERIOD>
		<ICE-VAC>
		<RTRUE>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>		      

<ROUTINE BROLLY-FILLS? ()
	 <COND (<AND <IN? ,PARASOL ,PLAYER>
		     <IS? ,PARASOL ,OPENED>>
		<TELL
". Fortunately, your open " D ,PARASOL
" fills with wind and saves you from a nasty fall." CR>
		<RTRUE>)>
	 <PRINT ,PERIOD>
	 <RFALSE>>

<OBJECT LUMP
	(LOC IN-CRATER)
	(DESC "lump of metal")
	(FLAGS TAKEABLE SURFACE CHILLY)
	(SYNONYM LUMP METAL MAGNET METEOR METEORITE)
	(ADJECTIVE BLACK DARK SCORCHED MAGNETIC LUMP METAL)
	(CAPACITY 10)
	(VALUE 1)
	(SIZE 10)
	(MASS 10)
	(DESCFCN DESCRIBE-LUMP)
	(GENERIC GENERIC-METAL-F)
	(ACTION LUMP-F)>

<ROUTINE GENERIC-METAL-F (TBL)
	 <RETURN ,LUMP>>

"CHILLY = hot, TRYTAKE = stuck on satellite."

<ROUTINE DESCRIBE-LUMP ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A ">
		<COND (<IS? ,LUMP ,CHILLY>
		       <TELL "glowing ">)
		      (T
		       <TELL "dark ">)>
		<TELL D ,LUMP " lies half-buried at your feet">
		<COND (<FIRST? ,LUMP>
		       <TELL ". On it you see ">
		       <PRINT-CONTENTS ,LUMP>)>
		<TELL ".">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LUMP-F ("AUX" OBJ NXT)
	 <COND (<AND <T? ,SUITED?>
		     <NOT <IS? ,LUMP ,TRYTAKE>>
		     <NOT <GOT? ,LUMP>>>
		<CANT-REACH-THRU-FILM>
		<RFATAL>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER>
		       <PERFORM ,V?LOOSEN ,PRSI ,PRSO>
		       <RTRUE>)
	       	      (<VERB? PUT-ON PLUG TOUCH-TO>
		       <COND (<PRSO? HANDS ME MOUTH>
			      <PERFORM ,V?TOUCH ,PRSI>
			      <RTRUE>)
			     (<PRSO? FEET ANKLE>
			      <PERFORM ,V?KICK ,PRSI>
			      <RTRUE>)
			     (<PRSO? POCKET>
			      <WASTE-OF-TIME>
			      <RTRUE>)
		      	     (<PRSO? ICE>
		       	      <COOL-LUMP>
		       	      <RTRUE>)
		      	     (<PRSO? PARASOL SPADE>
			      <MAGNETIC>
			      <RTRUE>)
			     (<AND <IS? ,PRSI ,CHILLY>
				   <PRSO? EBAG SOGGY>
				   <FIRST? ,PRSO>>
			      <EMPTY-PRSO-FIRST>
			      <RTRUE>)
			     (<AND <IS? ,PRSI ,CHILLY>
		            	   <PRSO? OCRANE BAD-CRANE SHROUD BANDAGE
					  BAG EBAG SOGGY>>
			      <VANISH>
			      <TELL CTHEO
" bursts into flame when it touches the " D ,PRSI
". Soon there's nothing left of it." CR>
			      <RTRUE>)
			     (<IS? ,PRSO ,FERRIC>
			      <COND (<AND <IS? ,PRSO ,TAKEABLE>
					  <IN? ,PRSO ,PLAYER>
					  <L? <GETP ,PRSO ,P?SIZE> 6>>
				     <MOVE ,PRSO ,PRSI>
				     <TELL CTHEO " attaches itself to the ">
				     <COND (<IS? ,PRSI ,CHILLY>
					    <TELL "hot ">)>
				     <TELL D ,PRSI " with a sharp ">
				     <ITALICIZE "click.">
				     <CRLF>
				     <RTRUE>)>
			      <MAGNETIC>
			      <RTRUE>)
			     (<VERB? TOUCH-TO>
			      <TELL "Nothing happens." CR>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO 
" is roughly the size and shape of a large grapefruit. Its " D ,CSURFACE>
		<COND (<IS? ,PRSO ,CHILLY>
		       <TELL " glows with heat">)
		      (T
		       <TELL " is black and scorched">)>
		<COND (<FIRST? ,PRSO>
		       <TELL ". " ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " clinging to it">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE-WITH DIG LOOSEN>
		<COND (<PRSI? HANDS>
		       <COND (<IN? ,SPADE ,PLAYER>
			      <SPADE-LUMP>
			      <RTRUE>)>
		       <PERFORM ,V?TOUCH ,PRSO>
		       <RTRUE>)
		      (<PRSI? POCKET MOUTH ANKLE HEAD EYES>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<PRSI? FEET>
		       <PERFORM ,V?KICK ,PRSO>
		       <RTRUE>)
		      (<PRSI? SPADE>
		       <SPADE-LUMP>
		       <RTRUE>)
		      (<PRSI? PARASOL>
		       <TELL CTHEI " proves awkward for this purpose." CR>
		       <RTRUE>)
		      (<PRSI? ICE>
		       <COOL-LUMP>
		       <RTRUE>)
		      (<AND <IS? ,PRSO ,CHILLY>
		            <PRSI? OCRANE BAD-CRANE SHROUD BANDAGE
				   BAG EBAG>>
		       <PERFORM ,V?PUT ,PRSI ,PRSO>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       
	       (<VERB? TAKE TOUCH PULL PUSH MOVE PUSH-TO
		       TURN RELEASE TAKE-OFF>
		<COND (<IS? ,PRSO ,TRYTAKE>
		       <NO-AVAIL>
		       <RTRUE>)
		      (<IS? ,PRSO ,CHILLY>
		       <TOUCH-LUMP>
		       <RTRUE>)
		      (<VERB? TAKE>
		       <PUTP ,PRSO ,P?DESCFCN 0>)>
		<RFALSE>)
	       (<VERB? KICK>
		<COND (<IS? ,PRSO ,TRYTAKE>
		       <TELL CTHEO " refuses to budge." CR>
		       <RTRUE>)
		      (<IS? ,PRSO ,CHILLY>
		       <TELL "Your sneaker sizzles with intense heat." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE MAGNETIC ()
	 <TELL "You feel a strong magnetic attraction." CR>
	 <RTRUE>>

<ROUTINE TOUCH-LUMP ()
	 <TELL
"You recklessly burn your fingers on the hot metal. Ouch!" CR>
	 <RTRUE>>

<ROUTINE SPADE-LUMP ()
	 <TELL "You try really hard to ">
	 <COND (<VERB? TAKE-WITH>
		<TELL "lift">)
	       (T
		<TELL "budge">)>
	 <TELL " the lump of metal with the " D ,SPADE
	       ". But it's hopeless. Every time you ">
	 <COND (<VERB? TAKE-WITH>
		<TELL 
"get the awkward thing balanced, it slides off with an infuriating ">
	        <ITALICIZE "thunk.">
	 	<CRLF>
	 	<RTRUE>)>
	 <TELL 
"move the awkward thing a few inches, the " D ,SPADE
" slips out from underneath." CR>
	 <RTRUE>>
	  
<ROUTINE COOL-LUMP ()
	 <REMOVE ,ICE>
	 <DEQUEUE I-ICE>
	 <UNMAKE ,LUMP ,CHILLY>
	 <SETG P-IT-OBJECT ,LUMP>
	 <TELL CTHE ,ICE
" disappears in a hissing cloud as it touches the hot " D ,LUMP
". When the steam clears, the " D ,CSURFACE
" of the lump is black and wet." CR>
	 <UPDATE-SCORE 3>
	 <RTRUE>>

<OBJECT CRATER
	(LOC LOCAL-GLOBALS)
	(DESC "crater")
	(FLAGS NODESC)
	(SYNONYM CRATER HOLE PIT EDGE BRINK LIP)
	(ACTION CRATER-F)>

<ROUTINE CRATER-F ("AUX" (IN <>))
	 <COND (<HERE? IN-CRATER>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<ZERO? .IN>
			      <MOVE ,PRSO ,IN-CRATER>
			      <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
			      <TELL CTHEO
" disappears into the smoky " D ,PRSI ,PERIOD>
			      <RTRUE>)>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-DOWN STAND-ON CROSS>>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<AND <EXITING?>
		     <VERB? CLIMB-UP LEAP>>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? SIT LIE-DOWN>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SMOKE
	(LOC LOCAL-GLOBALS)
	(DESC "smoke")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM SMOKE FUMES CLOUD STENCH ODOR)
	(ADJECTIVE SMOKY SOOTY ACRID BLACK DARK SMOKE)
	(ACTION SMOKE-F)>

<ROUTINE SMOKE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? SMELL INHALE>
		<TELL CTHEO " smells sooty and acrid." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO " is dark and sooty." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>
		    <VERB? CROSS>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RUBBLE
	(LOC LOCAL-GLOBALS)
	(DESC "rubble")
	(FLAGS NODESC TRYTAKE NOALL NOARTICLE)
	(SYNONYM RUBBLE ASH ASHES SOOT)
	(ACTION RUBBLE-F)>

<ROUTINE RUBBLE-F ()
	 <COND (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER DIG REACH-IN>
		<TELL "Sifting through the " D ,PRSO
		      " reveals nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <VERB? TAKE LOOSEN PUSH RAISE MOVE PUSH-TO PULL>>
		<TELL "Bits of " D ,PRSO " fall through your fingers." CR>
		<RTRUE>)
	       (<AND <THIS-PRSI?>
		     <VERB? PUT PUT-ON THROW>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<GROUND-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<OBJECT WATERFALL
	(LOC LOCAL-GLOBALS)
	(DESC "waterfall")
	(FLAGS NODESC WATERY)
	(SYNONYM WATERFALL FALLS CASCADE WATER FALL CURTAIN)
	(ADJECTIVE WATER WHITE)
	(GENERIC GENERIC-RIVER-F)
	(ACTION WATERFALL-F)>

<ROUTINE WATERFALL-F ("AUX" (IN <>))
	 <COND (<HERE? ICE-CAVE>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The water falls in a white curtain ">
		<COND (<ZERO? .IN>
		       <TELL "from the overhanging cliffs." CR>
		       <RTRUE>)>
		<TELL "across the " D ,CAVE-HOLE " in the wall." CR>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND SEARCH>
		<COND (<ZERO? .IN>
		       <COND (<IS? ,CAVE-HOLE ,SEEN>
			      <TELL "There's ">)
			     (T
			      <MAKE ,CAVE-HOLE ,SEEN>
			      <TELL "Careful inspection reveals ">)>
		       <TELL A ,CAVE-HOLE " in the cliff behind the "
			     D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
		<COND (<T? .IN>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)
		      (<IS? ,CAVE-HOLE ,SEEN>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<TELL "There's no obvious way around the "
		      D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " fills the air with its hissing roar." CR>
		<RTRUE>)
	       (<HANDLE-MOUNTAIN-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT CAVE-HOLE
	(LOC LOCAL-GLOBALS)
	(DESC "opening")
	(FLAGS NODESC VOWEL)
	(SYNONYM OPENING HOLE)
	(ACTION CAVE-HOLE-F)>

"SEEN = opening seen."

<ROUTINE CAVE-HOLE-F ("AUX" (IN <>))
	 <COND (<NOT <IS? ,CAVE-HOLE ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<HERE? ICE-CAVE>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<PERFORM ,V?EXAMINE ,WATERFALL>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? WALK-AROUND CROSS>>
		<DO-WALK <COND (<ZERO? .IN> ,P?WEST) (T ,P?EAST)>>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT POOL
	(LOC AT-FALLS)
	(DESC "pool")
	(FLAGS NODESC)
	(SYNONYM POOL POND)
	(ADJECTIVE DEEP)
	(ACTION POOL-F)>

<ROUTINE POOL-F ()
	 <COND (<HANDLE-MOUNTAIN-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT STREAM
	(LOC LOCAL-GLOBALS)
	(DESC "stream")
	(FLAGS WATERY NODESC CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM STREAM BROOK WATER FOAM)
	(ADJECTIVE SPARKLING COLD MOUNTAIN WHITE FOAMING FOAMY)
	(GENERIC GENERIC-RIVER-F)
	(ACTION STREAM-F)>

<ROUTINE STREAM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO " flows ">
		<COND (<HERE? SBOG>
		       <TELL "south">)
		      (<HERE? AT-TRELS>
		       <TELL "north">)>
		<SAY-EAST>
		<TELL "ward, into the ">
		<COND (<HERE? AT-BEND>
		       <TELL D ,STYX>)
		      (T
		       <TELL D ,FOREST>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? CROSS CLIMB-OVER LEAP>
		<TELL "You easily jump over the narrow " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? FOLLOW CLIMB-DOWN>
		<DO-WALK <COND (<HERE? SBOG> ,P?SE)
		      	       (<HERE? AT-TRELS> ,P?NE)
		      	       (T ,P?EAST)>>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-ON>
		<DO-WALK <COND (<HERE? AT-BEND> ,P?SW)
		      	       (<HERE? AT-TRELS> ,P?NW)
		      	       (T ,P?WEST)>>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " trickles faintly." CR>
		<RTRUE>)
	       (<HANDLE-MOUNTAIN-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-RIVER-F (TBL)
	 <COND (<HERE? DOCKSIDE>
		<RETURN ,STYX>)>
	 <RETURN ,STREAM>>
		
<ROUTINE HANDLE-MOUNTAIN-WATER? ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <REMOVE ,PRSO>
		       <TELL "Splash! " CTHEO " disappears ">
		       <SAY-IN-MOUNTAIN-WATER>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL ,CANT "make out anything ">
		<SAY-IN-MOUNTAIN-WATER>
		<RTRUE>)	       
	       (<VERB? DRINK-FROM DRINK TASTE>
		<TELL "The cold water is quite refreshing." CR>
		<RTRUE>)
	       (<DO-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE SAY-IN-MOUNTAIN-WATER ()
	 <TELL "in the white, foaming water." CR>
	 <RTRUE>>

<ROUTINE DO-WATER? ()
	 <COND (<OR <ENTERING?>
		    <VERB? SWIM DIVE LIE-DOWN SIT STAND-UNDER STAND-ON>>
		<TELL 
"One touch of the frigid water" ,CHANGES>
		<RTRUE>)
	       (<AND <VERB? TOUCH REACH-IN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "The water is very cold." CR>
		<COND (<IN? ,HONEY ,PLAYER>
		       <EXIT-HONEY>
		       <PRINT ,PERIOD>)>		       
		<RTRUE>)
	       (<VERB? TAKE KICK SHAKE KNOCK MUNG>
		<SPLASHES>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SSTEPS
	(LOC LOCAL-GLOBALS)
	(DESC "stone steps")
	(SYNONYM STEPS STAIR STAIRS STAIRWAY FLIGHT)
	(ADJECTIVE STONE ROCK)
	(ACTION SSTEPS-F)>

<ROUTINE SSTEPS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO " are carved into the face of the cliff." CR>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,BONEYARD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CLIFF
	(LOC LOCAL-GLOBALS)
	(DESC "cliff")
	(FLAGS NODESC)
	(SYNONYM CLIFF FACE WALLS ROCKS ROOF)
	(ADJECTIVE SHEER CLIFF DAMP SLIPPERY ROCK)
	(ACTION CLIFF-F)>

<ROUTINE CLIFF-F ("AUX" (TOP? <>))
	 <COND (<AND <NOUN-USED? ,W?ROOF>
		     <NOT <HERE? UNDER-CLIFF>>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HERE? BONEYARD ON-BLUFF>
		<SET TOP? T>)>
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <VERB? EXAMINE TOUCH KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "The walls of the " D ,CLIFF 
		      " are damp and slippery." CR>
		<RTRUE>)
	       (<VERB? LOOK-UP>
		<COND (<ZERO? .TOP?>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? LOOK-DOWN>
		<COND (<ZERO? .TOP?>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER>
		<CLIFF-TOO-STEEP>
		<RTRUE>)
	       (<VERB? CLIMB-UP>
		<COND (<ZERO? .TOP?>
		       <CLIFF-TOO-STEEP>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN LEAP DIVE>
		<COND (<ZERO? .TOP?>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)
		      (<OR <VERB? DIVE>
			   <EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP>>
		       <TELL "Desperate?" CR>
		       <RTRUE>)>
		<CLIFF-TOO-STEEP>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<COND (<ZERO? .TOP?>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? STAND-ON>
		<COND (<ZERO? .TOP?>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CLIFF-TOO-STEEP ()
	 <TELL "The walls of the " D ,CLIFF " are too steep." CR>
	 <RTRUE>>
		       
<OBJECT STATUES
	(LOC BONEYARD)
	(DESC "statues")
	(SYNONYM STATUES STATUE FIGURES)
	(ADJECTIVE GLOOMY BROKEN)
	(FLAGS PLURAL NODESC TRYTAKE NOALL)
	(ACTION STATUARY-F)>

<OBJECT LIMBS
	(LOC BONEYARD)
	(DESC "broken limbs")
	(FLAGS NODESC VOWEL PLURAL TRYTAKE NOALL)
	(SYNONYM ARM ARMS LIMBS LIMB LEGS LEG CARNAGE)
	(ADJECTIVE BROKEN)
	(ACTION STATUARY-F)>

<OBJECT HEADS
	(LOC BONEYARD)
	(DESC "broken heads")
	(FLAGS TRYTAKE NOALL NODESC PLURAL)
	(SYNONYM HEAD HEADS)
	(ADJECTIVE BROKEN)
	(ACTION HEADS-F)>

<ROUTINE HEADS-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL "The sightless eyes seem to follow you around." CR>
		<RTRUE>)
	       (<STATUARY-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE STATUARY-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL CTHEO " lie motionless in the grass." CR>
		<RTRUE>)
	       (<VERB? TAKE RAISE PUSH PULL MOVE>
		<TELL "The cold, clammy feel of the " D ,PRSO ,CHANGES>
		<RTRUE>)
	       (<AND <VERB? TOUCH KISS SHAKE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COLD-PRSOS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE COLD-PRSOS ()
	 <TELL CTHEO " are cold and clammy." CR>
	 <RTRUE>>

<OBJECT TOMBS
	(LOC BONEYARD)
	(DESC "tombstones")
	(FLAGS NODESC PLURAL TRYTAKE READABLE NOALL)
	(SYNONYM TOMBS TOMBSTONES GRAVES GRAVESTONE STONES NAMES EPITAPHS
	 	 NAME EPITAPH ENGRAVING WRITING)
	(ADJECTIVE TOMB GRAVE ENGRAVED FORGOTTEN HOPELESS)
	(GENERIC GENERIC-TOMB-F)
	(ACTION TOMBS-F)>

<ROUTINE GENERIC-TOMB-F (TBL)
	 <COND (<EQUAL? ,P-IT-OBJECT ,CRYPT ,TOMBS>
		<RETURN ,P-IT-OBJECT>)
	       (<OR <EQUAL? ,W?NAME ,P-NAM ,P-XNAM>
		    <EQUAL? ,W?WRITING ,P-NAM ,P-XNAM>
		    <EQUAL? ,W?ENGRAVING ,P-NAM ,P-XNAM>>
		<RETURN ,CRYPT>)
	       (T
		<RETURN ,TOMBS>)>>

<ROUTINE TOMBS-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO 
" are covered with forgotten names and hopeless epitaphs">
		<COND (<T? ,FLIP?>
		       <TELL ", all engraved backwards">)>
		<PRINT ,PERIOD>
		<COND (<NOT <IS? ,PRSO ,SEEN>>
		       <MAKE ,PRSO ,SEEN>
		       <CRLF>
		       <VOICE-MUTTERS "Let gnomon write my epitaph" <>>)>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL CTHEO " are deeply imbedded in the ground." CR>
		<RTRUE>)
	       (<AND <VERB? TOUCH KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COLD-PRSOS>
		<RTRUE>)
	       (<DISRESPECT?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		     
<OBJECT CRYPT
	(LOC BONEYARD)
	(DESC "crypt")
	(FLAGS NODESC SURFACE READABLE)
	(CAPACITY 20)
	(SYNONYM CRYPT GRAVE TOMB COFFIN CASKET NAME ENGRAVING WRITING)
	(ADJECTIVE STONE ROCK GRANITE GRAY)
	(GENERIC GENERIC-TOMB-F)
	(ACTION CRYPT-F)>

"SEEN = Bird echoed name."

<ROUTINE CRYPT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<T? .CONTEXT> ; "Since CRYPT is LOC of GOON."
		<RFALSE>)
	       (<THIS-PRSI?>
		<COND (<AND <VERB? PUT>
		     	    <NOT <IS? ,PRSI ,OPENED>>>
		       <PERFORM ,PRSA ,PRSO ,LID>
		       <RTRUE>)
	       	      (<AND <VERB? TAKE>
		     	    <NOT <IS? ,PRSI ,OPENED>>>
		       <PERFORM ,V?TAKE ,PRSO ,LID>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The granite " D ,PRSO
" must be hundreds of years old. It">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL 
"s lid is broken off, leaving a jagged " D ,CAVE-HOLE>)
		      (T
		       <TELL 
"'s sealed shut with a heavy lid">
		       <COND (<SEE-ANYTHING-IN? ,LID>
			      <TELL ", on which you see ">
			      <PRINT-CONTENTS ,LID>)>)>
		<TELL ".|
|
A name is engraved across the bottom of the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? READ>
		<TELL "The name on the " D ,PRSO " is ">
		<COND (<ZERO? ,FLIP?>
		       <TELL "WABEWALKER">)
		      (T
		       <TELL "REKLAWEBAW">)>
		<PRINT ,PERIOD>
		<COND (<AND <VISIBLE? ,MAGPIE>
			    <NOT <IS? ,PRSO ,SEEN>>>
		       <MAKE ,PRSO ,SEEN>
		       <TELL CR "\"Wabewalker. Awk!\"" CR>
		       <RTRUE>)>
		<RTRUE>)
	       (<AND <VERB? LOOK-ON>
		     <IS? ,PRSO ,OPENED>>
		<TELL CTHEO " is open." CR>
		<RTRUE>)
	       (<AND <VERB? LOOK-INSIDE SEARCH>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "You feel something nasty." CR>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH LOOSEN>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<PERFORM ,PRSA ,LID ,PRSI>
		<RTRUE>)
	       (<VERB? TAKE RAISE PULL PUSH MOVE LOOK-UNDER>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL ,CANT "do that now. You broke the " D ,LID
			     ,PERIOD>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<VERB? ENTER LIE-DOWN>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "There's room for only one stiff." CR>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<DISRESPECT?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LID
	(LOC CRYPT)
	(DESC "lid")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(CAPACITY 20)
	(SYNONYM LID COVER SLAB ROCK STONE GRANITE)
	(ADJECTIVE FORMIDABLE MASSIVE STONE ROCK GRANITE)
	(ACTION LID-F)>

<ROUTINE LID-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER>
		       <COND (<PRSO? SPADE PARASOL AXE>
		       	      <PERFORM ,V?OPEN-WITH ,PRSI ,PRSO>
		       	      <RTRUE>)>
		       <YOUD-HAVE-TO "raise" ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<DESCRIBE-LID>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH LOOSEN>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <LIFT-LID>
		       <RTRUE>)
		      (<PRSI? PARASOL AXE>
		       <COND (<AND <PRSI? PARASOL>
				   <IS? ,PRSI ,OPENED>>
			      <TELL 
"[closing the " D ,PRSI " first" ,BRACKET>)>
		       <VANISH ,PRSI>
		       <LEAN-ON-LID>
		       <TELL CTHEI 
"'s handle snaps neatly in half.|
|
You curse and fume at the stupid, flimsy " D ,PRSI 
", and obtain great satisfaction by throwing the broken pieces over the edge of the cliff." CR>
		       <RTRUE>)
		      (<PRSI? SPADE>
		       <PUTP ,HERE ,P?ODOR ,GOON>
		       <UNMAKE ,CRYPT ,SURFACE>
	 	       <MAKE ,CRYPT ,OPENED>
	 	       <MAKE ,CRYPT ,OPENABLE>
	 	       <MAKE ,CRYPT ,CONTAINER>
	 	       <PUTP ,CRYPT ,P?CAPACITY 50>
	 	       <REMOVE ,LID>
	 	       <MOVE ,BROKEN-LID ,BONEYARD>
	 	       <SETG P-IT-OBJECT ,BROKEN-LID>
	 	       <LEAN-ON-LID>
		       <TELL 
"You feel a puff of foul-smelling air as a section of the crypt's lid breaks away">
	 	       <COND (<FIRST? ,LID>
			      <MOVE-ALL ,LID ,BONEYARD>
			      <TELL ". Everything that was on the " 
				    D ,CRYPT " scatters to the ground">)>
	 	       <PRINT ,PERIOD>
	 	       <MOVE ,GOON ,CRYPT>
	 	       <UPDATE-SCORE 3>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "could budge the lid">
		<RTRUE>)
	       (<VERB? TAKE RAISE PULL PUSH MOVE LOOK-UNDER>
		<LIFT-LID>
		<RTRUE>)
	       (<VERB? CLOSE REPLACE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<AND <VERB? HIT>
		     <PRSI? AXE>>
		<TELL "You'd probably ruin the blade." CR>
		<RTRUE>)
	       (<DISRESPECT?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LIFT-LID ()
	 <TELL
"Beads of sweat stand out on your forehead as you strain against the lid. But it'll take more leverage than you've got to budge it." CR>
	 <RTRUE>>

<ROUTINE LEAN-ON-LID ()
	 <TELL "You slide the end of " THEI
" under the lid's edge and lean on it with all your strength.|
|
">
	 <ITALICIZE "Crack!">
	 <TELL " ">
	 <RTRUE>> 

<ROUTINE DESCRIBE-LID ()
	 <TELL CTHEO " is a formidable slab of granite">
	 <COND (<FIRST? ,PRSO>
	        <TELL ". " ,YOU-SEE>
	        <PRINT-CONTENTS ,PRSO>
		<TELL " on top">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT BROKEN-LID
	(DESC "broken lid")
	(FLAGS TRYTAKE SURFACE)
	(CAPACITY 20)
	(SYNONYM LID COVER PIECE SECTION SLAB GRANITE STONE ROCK)
	(ADJECTIVE CRACKED BROKEN FORMIDABLE ROCK STONE GRANITE)
	(ACTION BROKEN-LID-F)>
	
<ROUTINE BROKEN-LID-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<DESCRIBE-LID>
		<RTRUE>)
	       (<VERB? TAKE MOVE PULL PUSH LOOSEN LOOK-UNDER>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (<DISRESPECT?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DISRESPECT? ()
	 <COND (<VERB? SMELL>
		<SMELLS-OF-DEATH>
		<RTRUE>)
	       (<VERB? STAND-ON SIT LIE-DOWN CLIMB-ON CLIMB-OVER CROSS
		       CLIMB-UP RIDE>
		<TELL "That would be a disrespectful thing to do." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BARROW
	(LOC LOCAL-GLOBALS)
	(DESC "barrow")
	(FLAGS NODESC)
	(SYNONYM BARROW MOUND)
	(ADJECTIVE BURIAL)
	(ACTION BARROW-F)>

<OBJECT TUNNEL
	(LOC LOCAL-GLOBALS)
	(DESC "tunnel")
	(FLAGS NODESC)
	(SYNONYM TUNNEL)
	(ACTION BARROW-F)>

<ROUTINE BARROW-F ("AUX" (IN <>))
	 <COND (<HERE? IN-BARROW>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW>
		       <COND (<HERE? IN-BARROW>
		       	      <PERFORM ,V?DROP ,PRSO>
		       	      <RTRUE>)
			     (<AND <HERE? BONEYARD>
				   <NOT <IS? ,BARROW-DOOR ,OPENED>>>
			      <ITS-CLOSED ,BARROW-DOOR>
			      <RTRUE>)>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <MOVE ,PRSO ,IN-BARROW>
		       <TELL CTHEO " disappears into the darkness of the "
		      	     D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER>>
		<COND (<HERE? BONEYARD>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)
		      (<HERE? OSSUARY>
		       <DO-WALK ,P?SW>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER>
		<COND (<ZERO? .IN>
		       <TELL "The sides of the " D ,PRSO
			     " are too steep." CR>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELLS-OF-DEATH>
		<RTRUE>)
	       (T
		<RFALSE>)>>		       

<OBJECT BARROW-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "spiked door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED FERRIC)
	(SYNONYM DOOR DOORWAY SPIKES SPIKE)
	(ADJECTIVE MASSIVE LARGE BIG METAL IRON SPIKED RAZOR SHARP
	 	   RAZOR\-SHARP)
	(ACTION BARROW-DOOR-F)>

<ROUTINE BARROW-DOOR-F ()
	 <COND (<IS? ,BARROW-DOOR ,OPENED>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH LOOK-UNDER>
		<TELL "The door bristles with iron spikes." CR>
		<RTRUE>)
	       (<AND <VERB? TOUCH KNOCK SHAKE SQUEEZE PLAY CLIMB-ON ENTER
		       	    THROUGH CLIMB-OVER KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "Ouch! The spikes on the door are razor-sharp." CR>
		<RTRUE>)
	       (<VERB? OPEN MOVE PUSH PULL LOOSEN SHAKE SQUEEZE PUSH-TO
		       OPEN-WITH>
		<NO-AVAIL>
		<RTRUE>)
	       (<VERB? KNOCK HIT CUT RIP MUNG KICK>
		<TELL CTHEO " resists your feeble assault." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CROSS>>
		<DO-WALK <COND (<HERE? IN-BARROW> ,P?SOUTH)
			       (T ,P?NORTH)>>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? IN-BARROW>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? LOOK-OUTSIDE LOOK-BEHIND LOOK-INSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-AVAIL ()
	 <TELL "You strain against the " D ,PRSO
	       ", but to no avail." CR>
	 <RTRUE>>

<OBJECT SHROUD
	(LOC GOON)
	(DESC "burial shroud")
	(FLAGS NODESC TAKEABLE CLOTHING)
	(VALUE 0)
	(SIZE 10)
	(MASS 4)
	(SYNONYM SHROUD CLOTH SHEET)
	(ADJECTIVE BURIAL GRAY GREY TATTERED)
	(ACTION SHROUD-F)>

"NODESC = shroud on corpse, SEEN = point given."

<ROUTINE SHROUD-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-UNDER>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,WORN>
		       <TELL " you're wearing">)>
		<TELL " is gray and tattered">
		<COND (<IS? ,PRSO ,NODESC>
		       <TELL ". It's wrapped loosely around the " D ,GOON>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,SEEN>>>
		<COND (<ITAKE>
		       <MAKE ,PRSO ,SEEN>
		       <TELL "You remove the " D ,PRSO
			     " from the " D ,GOON 
			     ", revealing its decomposed body." CR>
		       <UPDATE-SCORE>)>
		<RTRUE>)
	       (<HANDLE-CLOTH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<ROUTINE HANDLE-CLOTH? ()
	 <COND (<AND <VERB? CUT RIP>
		     <OR <EQUAL? ,PRSI <> ,HANDS ,KNIFE>
		     	 <EQUAL? ,PRSI ,AXE>>>
		<TELL CTHEO " is tattered enough already." CR>
		<RTRUE>)
	       (<AND <VERB? SMELL>
		     <NOT <HERE? UNDER-WATER>>>
		<SMELLS-OF-DEATH>
		<RTRUE>)
	       (<VERB? FOLD WRAP-AROUND>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNFOLD>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SMELLS-OF-DEATH ()
	 <TELL "You sense the gray odor of death." CR>
	 <RTRUE>>

<OBJECT BANDAGE
	(LOC GOON)
	(DESC "bandage")
	(FLAGS NODESC TAKEABLE CLOTHING)
	(VALUE 0)
	(SIZE 3)
	(MASS 2)
	(SYNONYM BANDAGE CLOTH STRIP)
	(ADJECTIVE GRAY GREY BROAD TATTERED)
	(ACTION BANDAGE-F)>

"NODESC = bandage on goon."

<ROUTINE BANDAGE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-UNDER>
		<TELL "It's a broad strip of gray cloth">
		<COND (<IS? ,PRSO ,NODESC>
		       <TELL ", wrapped over the top of the " D ,GOON
			     "'s head and under its chin">)
		      (<IS? ,PRSO ,WORN>
		       <TELL ", wrapped around your head">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TAKE UNTIE>
		     <IS? ,PRSO ,NODESC>>
		<COND (<ITAKE>
		       <MAKE ,GOON-MOUTH ,OPENED>
		       <TELL "As you pull the " D ,PRSO " off the " D ,GOON
		      	     " its " D ,GOON-MOUTH " drops wide open." CR>)>
		<RTRUE>)
	       (<HANDLE-CLOTH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RBOOT
	(LOC GOON)
	(DESC "red boot")
	(FLAGS NODESC TAKEABLE CLOTHING CONTAINER OPENED)
	(SYNONYM BOOT BOOTS PAIR TOE TIP HEEL RECESS WINGS WING)
	(ADJECTIVE RED CRIMSON)
	(CAPACITY 2)
	(VALUE 0)
	(SIZE 3)
	(MASS 3)
        (GENERIC GENERIC-BOOT-F)
	(ACTION RBOOT-F)>

<OBJECT GBOOT
	(LOC GOON)
	(DESC "green boot")
	(FLAGS NODESC TAKEABLE CLOTHING CONTAINER OPENED)
	(SYNONYM BOOT BOOTS PAIR TOE TIP HEEL RECESS WINGS WING)
	(ADJECTIVE GREEN)
	(CAPACITY 2)
	(VALUE 0)
	(SIZE 3)
	(MASS 3)
        (GENERIC GENERIC-BOOT-F)
	(ACTION GBOOT-F)>

<ROUTINE GENERIC-BOOT-F (TABLE "AUX" LEN)
	 <COND (<EQUAL? ,P-IT-OBJECT ,RBOOT ,GBOOT>
		<RETURN ,P-IT-OBJECT>)
	       (<OR <EQUAL? ,P-NAM ,W?BOOTS ,W?PAIR>
		    <EQUAL? ,P-XNAM ,W?BOOTS ,W?PAIR>>
		<RETURN ,RBOOT>)
	       (<OR <EQUAL? ,P-NAM ,W?WINGS ,W?WING>
		    <EQUAL? ,P-XNAM ,W?WINGS ,W?WING>>
		<COND (<IS? ,RBOOT ,CHILLY>
		       <COND (<IS? ,GBOOT ,CHILLY>
			      <RFALSE>)>
		       <RETURN ,RBOOT>)
		      (<IS? ,GBOOT ,CHILLY>
		       <RETURN ,GBOOT>)>
		<REFERRING>
		<RETURN ,NOT-HERE-OBJECT>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE RBOOT-F ("AUX" X)
	 <COND (<BAD-BOOT-PART? ,RBOOT>
		<RFATAL>)>
	 <SET X <MULTIBOOT? ,RBOOT>>
	 <COND (<T? .X>
		<RETURN .X>)>
	 <RETURN <HANDLE-BOOT? "red">>>

<ROUTINE GBOOT-F ("AUX" X)
	 <COND (<BAD-BOOT-PART? ,GBOOT>
		<RFATAL>)>
	 <SET X <MULTIBOOT? ,GBOOT>>
	 <COND (<T? .X>
		<RETURN .X>)>
	 <RETURN <HANDLE-BOOT? "green">>>

<ROUTINE BAD-BOOT-PART? (BOOT)
	 <COND (<AND <IS? .BOOT ,CHILLY>
		     <NOUN-USED? ,W?RECESS>>
		<TELL "The recess you saw before is gone now." CR>
		<RTRUE>)
	       (<AND <NOT <IS? .BOOT ,CHILLY>>
		     <NOUN-USED? ,W?WING ,W?WINGS>>
		<CANT-SEE-ANY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ONE-AT-A-TIME (STR)
	 <TELL "[You can only do that to one " .STR " at a time.]" CR>
	 <RTRUE>>

<ROUTINE MULTIBOOT? (BOOT "AUX" X)
	 <COND (<OR <T? ,P-MULT?>
		    <NOT <NOUN-USED? ,W?BOOTS ,W?PAIR>>>
		<RFALSE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<ONE-AT-A-TIME "boot">
		<RFATAL>)
	       (<OR <AND <EQUAL? .BOOT ,RBOOT>
		     	 <NOT <VISIBLE? ,GBOOT>>>
		    <AND <EQUAL? .BOOT ,GBOOT>
			 <NOT <VISIBLE? ,RBOOT>>>>
		<TELL "There's only one boot here." CR>
		<RFATAL>)>
	 <SETG P-THEM-OBJECT ,RBOOT>
	 <COND (<THIS-PRSO?>
		<PUT ,P-NAMW 0 ,W?BOOT>
		<PUT ,P-OFW 0 <>>
		<TELL CTHE ,RBOOT ": ">
		<SET X <PERFORM ,PRSA ,RBOOT ,PRSI>>
		<COND (<NOT <EQUAL? .X <> ,M-FATAL>>
		       <TELL CTHE ,GBOOT ": ">
		       <SET X <PERFORM ,PRSA ,GBOOT ,PRSI>>)>
		<RETURN .X>)
	       (<T? ,PRSI>
		<PUT ,P-NAMW 1 ,W?BOOT>
		<PUT ,P-OFW 1 <>>
		<TELL CTHE ,RBOOT ": ">
		<SET X <PERFORM ,PRSA ,PRSO ,RBOOT>>
		<COND (<NOT <EQUAL? .X <> ,M-FATAL>>
		       <TELL CTHE ,GBOOT ": ">
		       <SET X <PERFORM ,PRSA ,PRSO ,GBOOT>>)>
		<RETURN .X>)
	       (T
		<RFALSE>)>>
		
<ROUTINE HANDLE-BOOT? (STR)
	 <COND (<NOUN-USED? ,W?RECESS>
		<COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		       <TELL "It's empty." CR>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<OR <AND <PRSO? EMERALD>
				       <PRSI? GBOOT>>
				  <AND <PRSO? RUBY>
				       <PRSI? RBOOT>>>
			      <REMOVE ,PRSO>
			      <MAKE ,PRSI ,CHILLY>
			      <TELL "You press the " D ,PRSO
" into the toe of the " D ,PRSI ". As you watch, the " .STR 
" leather closes around the jewel and absorbs it like melting wax.|
|
A shudder of ecstasy ripples up and down the length of the boot. It begins to glow with raw energy, brighter and brighter, until you shield your eyes from the glare.|
|
When you peek again, a tiny pair of wings has sprouted out of the heel." CR>
			      <UPDATE-SCORE>
		       	      <RTRUE>)
			     (<NOUN-USED? ,W?RECESS>
			      T)
			     (<PRSO? FEET>
			      <COND (<IS? ,PRSI ,WORN>
				     <TELL ,YOURE-ALREADY "wearing the "
					   D ,PRSI ,PERIOD>
				     <RTRUE>)>
			      <PERFORM ,V?WEAR ,PRSI>
			      <RTRUE>)
			     (<IS? ,PRSI ,WORN>
			      <YOUD-HAVE-TO "take off" ,PRSI>
			      <RTRUE>)>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 2>
			      <TELL CTHEO " wouldn't fit in there." CR>
			      <RTRUE>)>
		       <TELL CTHEO " slides out and ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"The boot is exceedingly well-made, and colored bright "
		      .STR ,PA>
	 	<COND (<IS? ,PRSO ,CHILLY>
		       <TELL "pair of miniature wings sprouts from the heel">)
	       	      (T
		       <TELL "small recess is visible at the toe's tip">)>
	 	<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? LOOK-INSIDE SEARCH EMPTY REACH-IN EMPTY-INTO
			    EMPTY>
		     <IS? ,PRSO ,WORN>>
		<YOUD-HAVE-TO "take off" ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			      
<OBJECT BCOIN
	(LOC GOON-MOUTH)
	(DESC "silver coin")
	(FLAGS TAKEABLE NOALL)
	(SIZE 0)
	(MASS 0)
	(VALUE 1)
	(SYNONYM COIN MONEY CURRENCY SILVER)
	(ADJECTIVE SILVER METAL)
	(ACTION BCOIN-F)>
	
<ROUTINE BCOIN-F ()
	 <COND (<VERB? EXAMINE READ LOOK-ON>
		<TELL "The words ">
		<COND (<IS? ,PRSO ,FLIPPED>
		       <TELL "ELBAREFSNART TON">)
		      (T
		       <TELL "NOT TRANSFERABLE">)>
		<TELL " are engraved on the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<HANDLE-COIN?>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT ICAVE
	(LOC LOCAL-GLOBALS)
	(DESC "cavern")
	(FLAGS NODESC)
	(SYNONYM CAVERN CAVE)
	(ADJECTIVE ICE)
	(ACTION HERE-F)>

<OBJECT ICICLES
	(LOC ICE-CAVE)
	(DESC "icicles")
	(FLAGS NODESC NOALL TRYTAKE PLURAL VOWEL)
	(SYNONYM ICICLES ICICLE ICE NEEDLE NEEDLES)
	(ADJECTIVE CRYSTAL)
	(GENERIC GENERIC-ICE-F)
	(ACTION ICICLES-F)>

<ROUTINE GENERIC-ICE-F (TABLE)
	 <RETURN ,ICE>>

<ROUTINE ICICLES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW>
		       <TELL CTHEO " strikes the " D ,ICICLES " and ">
		       <LANDS-AT-YOUR-FEET>
		       <COND (<G? <GETP ,PRSO ,P?MASS> 3>
			      <CRLF>
			      <COND (<IS? ,ICE ,NODESC>
				     <BREAK-OFF-ICE>
				     <TELL 
"An " D ,ICE " breaks off the " D ,CEILING " and falls to the ground." CR>
				     <RTRUE>)>
			      <TELL
"You're showered with useless ice fragments">
			      <COND (<T? ,SUITED?>
				     <POP-BUBBLE-SUIT>
				     <TELL ", and the " D ,FILM>
				     <SAY-POP>)>
			      <PRINT ,PERIOD>)>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" cover the " D ,CEILING " of the " D ,CAVE ", high out of reach." CR>
		<RTRUE>)
	       (<AND <VERB? HIT LOOSEN>
		     <T? ,PRSI>>
		<COND (<PRSI? PARASOL SHROUD>
		       <COND (<IS? ,ICE ,NODESC>
			      <BREAK-OFF-ICE>		       
		       	      <TELL "A quick swipe with the " D ,PRSI
" breaks one of the " D ,PRSO " off the " D ,CEILING>)
			     (T
			      <TELL "There aren't any more " D ,PRSO
				    " within reach of the " D ,PRSI>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<NICE-TRY>
		<RTRUE>)	       
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-REACH ,ICICLES>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BREAK-OFF-ICE ()
	 <UNMAKE ,ICE ,NODESC>
         <MOVE ,ICE ,ICE-CAVE>
	 <SETG P-IT-OBJECT ,ICE>
	 <QUEUE I-ICE -1>
	 <RTRUE>>

<OBJECT ICE
	(DESC "icicle")
	(FLAGS VOWEL TAKEABLE NODESC)
	(SYNONYM ICICLE ICE NEEDLE)
	(ADJECTIVE MELTING BROKEN BIG LARGE)
	(VALUE 1)
	(SIZE 7)
	(MASS 5)
	(GENERIC GENERIC-ICE-F)
	(ACTION ICE-F)>

"NODESC = icicle not yet broken."

<ROUTINE ICE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The ">
		<COND (<L? ,ILIFE 4>
		       <TELL "melting ">)>
		<TELL D ,ICE 
" looks like a crystal needle, eighteen inches long." CR>
		<RTRUE>)
	       (<AND <VERB? TOUCH TASTE KISS SQUEEZE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHE ,ICE " feels cold and wet." CR>
		<RTRUE>)
	       (<VERB? EAT BITE MUNG KICK SHAKE STAND-ON KNOCK>
		<SHATTER-ICE>
		<RTRUE>)
	       (<VERB? DRINK>
		<YOUD-HAVE-TO "melt" ,ICE>
		<RTRUE>)
	       (<VERB? MELT>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	        
<ROUTINE SHATTER-ICE ()
	 <REMOVE-ICE>
	 <TELL CTHE ,ICE " shatters into useless fragments">
	 <COND (<NOT <IS? ,HERE ,CHILLY>>
		<TELL " that quickly melt away">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE REMOVE-ICE ()
	 <VANISH ,ICE>
	 <DEQUEUE I-ICE>
	 <RTRUE>>

<OBJECT KEYHOLE
	(LOC IN-BARROW)
	(DESC "hole")
	(FLAGS CONTAINER OPENED OPENABLE)
	(CAPACITY 1)
	(SYNONYM KEYHOLE HOLE LOCK OPENING)
	(ADJECTIVE SMALL TINY)
        (DESCFCN DESCRIBE-KEYHOLE)
	(ACTION KEYHOLE-F)>

<ROUTINE DESCRIBE-KEYHOLE ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A ">
	 <COND (<IN? ,KEY ,KEYHOLE>
		<TELL D ,KEY " is sticking out of ">)
	       (T
		<TELL "small hole is visible in ">)>
	 <TELL "the wall.">
	 <RTRUE>>

<ROUTINE KEYHOLE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON>
		       <COND (<NOT <IN? ,PRSO ,PLAYER>>
			      <YOUD-HAVE-TO "be holding" ,PRSO>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<VERB? PUT>
		       <COND (<NOT <IN? ,PRSO ,PLAYER>>
			      <YOUD-HAVE-TO "be holding" ,PRSO>
			      <RTRUE>)
			     (<PRSO? KEY>
			      <MOVE ,PRSO ,KEYHOLE>
			      <TELL CTHEO
" slides into the hole with a satisfying click." CR>
			      <RTRUE>)
		      	     (<OR <PRSO? HANDS FEET>
				  <G? <GETP ,PRSO ,P?SIZE> 1>>
			      <TOO-SMALL ,PRSI>
		       	      <RTRUE>)
			     (<IN? ,KEY ,PRSI>
			      <YOUD-HAVE-TO "take out" ,KEY>
			      <RTRUE>)
			     (T
			      <TELL "You try jamming " THEO
" into the hole, but it doesn't fit." CR>)>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<COND (<IN? ,KEY ,PRSO>
		       <TELL "There's a " D ,KEY " in it." CR>
		       <RTRUE>)>
		<TELL CTHEO " is quite small." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND>
		<COND (<IN? ,KEY ,PRSO>
		       <TELL CTHE ,KEY " is blocking the hole." CR>
		       <RTRUE>)>
		<TELL 
"It occurs to you that there might be another " D ,WIGHT " beyond that wall, waiting to jab a hot spike into your eye. You decide not to risk it." CR>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TOO-SMALL>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER>
		     <IS? ,SLOPE ,OPENED>>
		<PERFORM ,V?EXAMINE ,SLOPE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE TOO-SMALL ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <TELL CTHE .OBJ " is too small." CR>
	 <RTRUE>>

<OBJECT SLOPE
	(LOC LOCAL-GLOBALS)
	(DESC "slope")
	(FLAGS CONTAINER SURFACE NODESC)
	(SYNONYM SLOPE INCLINE SLIDE)
	(ADJECTIVE SLIPPERY ICY STEEP)
	(ACTION SLOPE-F)>

"OPENED = key used."

<ROUTINE SLOPE-F ()
	 <COND (<NOT <IS? ,SLOPE ,OPENED>>
		<SLOPE-GONE>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <MOVE ,PRSO ,ICE-CAVE>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO " slides down the " D ,SLOPE 
			     " into the darkness below." CR>
		       <SAY-IF-HERE-LIT>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-BEHIND LOOK-DOWN>
		<TELL CTHEO " leads down into darkness." CR>
		<RTRUE>)
	       (<VERB? LOOK-UP CLIMB-UP CLIMB-ON>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-DOWN STAND-ON SIT LIE-DOWN LEAP
			   CROSS CLIMB-OVER>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<AND <VERB? TOUCH KISS KICK CLEAN KNOCK>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "It feels slippery." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<OBJECT CAVE
	(LOC LOCAL-GLOBALS)
	(DESC "cavern")
	(FLAGS NODESC)
	(SYNONYM CAVERN CAVE)
	(ADJECTIVE UNDERGROUND VAST)
	(ACTION CAVE-F)>

<ROUTINE CAVE-F ("AUX" (IN <>))
	 <COND (<NOT <IS? ,CAVE-HOLE ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<HERE? ICE-CAVE>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT COTTAGE
	(LOC LOCAL-GLOBALS)
	(DESC "cottage")
	(FLAGS NODESC)
	(SYNONYM COTTAGE HOUSE HOME HUT CABIN SHANTY HOVEL BUILDING STRUCTURE)
	(ADJECTIVE MODEST SMALL LITTLE TINY ONE\-ROOM ROOM)
	(ACTION COTTAGE-F)>

<ROUTINE COTTAGE-F ("AUX" (IN <>))
	 <COND (<HERE? IN-COTTAGE>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE>
		<COND (<HERE? ON-BLUFF>
		       <PERFORM ,V?EXAMINE ,COTTAGE-DOOR>
		       <RTRUE>)
		      (<HERE? IN-GARDEN>
		       <PERFORM ,V?EXAMINE ,GARDEN-DOOR>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<HERE? IN-GARDEN>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (<HERE? ON-BLUFF>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT STOOLS
	(LOC LOCAL-GLOBALS)
	(DESC "toadstools")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM TOADSTOOL MUSHROOM MUSHROOMS STOOLS DOMES STEMS)
	(ADJECTIVE TOAD GIANT LARGE HUGE ENORMOUS)
	(ACTION STOOLS-F)>

<ROUTINE STOOLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO
" become more numerous as your eyes sweep ">
		<SAY-WEST>
		<TELL "ward." CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<HUNDREDS-OF-THEM>
		<CRLF>
		<RTRUE>)
	       (<ENTERING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT COPSE
	(LOC ON-BLUFF)
	(DESC "copse")
	(FLAGS NODESC)
	(SYNONYM COPSE CLEARING)
	(ACTION COPSE-F)>

<ROUTINE COPSE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>
		    <VERB? CROSS STAND-ON>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GARDEN
	(LOC LOCAL-GLOBALS)
	(DESC "garden")
	(FLAGS NODESC)
	(SYNONYM GARDEN)
	(ADJECTIVE HERB HERBAL)
	(ACTION GARDEN-F)>

<ROUTINE GARDEN-F ("AUX" (IN <>))
	 <COND (<HERE? IN-GARDEN>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<VERB? DIG>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DIG-IN-GARDEN>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-GARLIC>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			
<ROUTINE DIG-IN-GARDEN ()
	 <TELL "It would be a shame to disturb the " D ,HERBS
	       ". They're so nice and symmetrical." CR>
	 <RTRUE>>

<OBJECT COTTAGE-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "front door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL FRONT)
	(ADJECTIVE FRONT)
	(GENERIC GENERIC-DOOR-F)
	(ACTION COTTAGE-DOOR-F)>

<ROUTINE COTTAGE-DOOR-F ("AUX" (IN P?EAST) (OUT P?WEST))
	 <COND (<T? ,FLIP?>
		<SET IN ,P?WEST>
		<SET OUT ,P?EAST>)>
	 <COND (<DO-COTTAGE-DOOR? .IN .OUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GARDEN-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "back door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL BACK)
	(ADJECTIVE BACK REAR)
	(GENERIC GENERIC-DOOR-F)
	(ACTION GARDEN-DOOR-F)>

<ROUTINE GARDEN-DOOR-F ("AUX" (IN P?WEST) (OUT P?EAST))
	 <COND (<T? ,FLIP?>
		<SET IN ,P?EAST>
		<SET OUT ,P?WEST>)>
	 <COND (<DO-COTTAGE-DOOR? .IN .OUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE DO-COTTAGE-DOOR? (IN OUT)
	 <COND (<ENTERING?>
		<DO-WALK <COND (<HERE? IN-COTTAGE> .OUT)
			       (T .IN)>>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? IN-COTTAGE>
		       <DO-WALK .OUT>
		       <RTRUE>)>
		<NOT-IN ,COTTAGE>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-OUTSIDE LOOK-BEHIND>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GFENCE
	(LOC IN-GARDEN)
	(DESC "tall fence")
	(FLAGS NODESC)
	(SYNONYM FENCE BARRIER)
	(ADJECTIVE HIGH TALL)
	(ACTION GFENCE-F)>

<ROUTINE GFENCE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "It's at least ten feet high." CR>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? EXAMINE CLIMB-ON CLIMB-OVER CROSS LEAP STAND-ON SIT
		       LIE-DOWN THROUGH>
		<TOO-HIGH>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,GFENCE T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HERBS
	(LOC IN-GARDEN)
	(DESC "rows of herbs")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM ROWS HERB HERBS PLANTS PLANT)
	(ADJECTIVE PARALLEL NEAT)
	(ACTION HERBS-F)>

<ROUTINE HERBS-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL 
"The herbs are lovingly planted in neat, parallel rows." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-GARLIC>
		<RTRUE>)
	       (<VERB? TAKE PICK LOOSEN PULL MOVE PUSH EMPTY DIG
		       LOOK-UNDER EAT BITE MUNG CUT RIP KICK SHAKE
		       SQUEEZE>
		<DIG-IN-GARDEN>
		<RTRUE>)
	       (<PLAYING-IN?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PILE
	(LOC IN-GARDEN)
	(DESC "pile of refuse")
	(FLAGS SURFACE TRYTAKE NOALL)
	(CAPACITY 20)
	(SYNONYM PILE HEAP REFUSE GARBAGE JUNK STALKS STALK DIRT)
	(ADJECTIVE DRIED DRY DISCARDED REFUSE)
	(DESCFCN DESCRIBE-PILE)
	(ACTION PILE-F)>

<ROUTINE DESCRIBE-PILE ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A " D ,PILE " lies in the " D ,CORNER ".">
		<LOOK-ON-PILE>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<ROUTINE LOOK-ON-PILE ()
	 <COND (<SEE-ANYTHING-IN? ,PILE>
		<TELL " On it you see ">
		<PRINT-CONTENTS ,PILE>
		<TELL ".">)>
	 <RTRUE>>

<ROUTINE PILE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It's just a dry heap of discarded stalks and dirt.">
		<LOOK-ON-PILE>
		<CRLF>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH DIG LOOK-UNDER REACH-IN>
		<COND (<IS? ,GARLIC ,NODESC>
		       <UNMAKE ,GARLIC ,NODESC>
		       <MOVE ,GARLIC ,PRSO>
		       <SETG P-IT-OBJECT ,GARLIC>
		       <TELL
"You find nothing in the pile except a rotten " D ,GARLIC>)
		      (T
		       <TELL
"Further sifting reveals nothing new in the " D ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL "Dirt falls uselessly through your fingers." CR>
		<RTRUE>)
	       (<PLAYING-IN?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT GARLIC
	(DESC "clove of garlic")
	(FLAGS NODESC TAKEABLE)
	(SYNONYM GARLIC CLOVE BULB BIT)
	(ADJECTIVE OLD ROTTEN)
	(VALUE 1)
	(SIZE 3)
	(MASS 2)
	(ACTION GARLIC-F)>

<ROUTINE GARLIC-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is at least a year old." CR>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<VANISH>
		<TELL "You cram the dirty " D ,PRSO
" in your mouth and chew with enthusiasm. Soon it's completely gone." CR>
		<RTRUE>)
	       (<VERB? MUNG CUT RIP>
		<TELL "It's just a tiny " D ,PRSO ", too small to ">
		<PRINTB ,P-PRSA-WORD>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? CLEAN>
		<TELL CTHEO " is beyond hope." CR>
		<RTRUE>)
	       (<AND <VERB? SMELL>
		     <NOT <HERE? UNDER-WATER>>>
		<SMELL-GARLIC>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SMELL-GARLIC ()
	 <TELL "You make out a distinctly rancid odor." CR>
	 <RTRUE>>

<OBJECT PATCH
	(LOC IN-GARDEN)
	(DESC "patch of thyme")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM PATCH THYME)
	(ACTION PATCH-F)>

<ROUTINE PATCH-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO
" must have looked nice before the " D ,TS4 " ruined it." CR>
		<RTRUE>)
	       (<VERB? TAKE PICK PULL DIG LOOSEN MOVE EAT BITE
		       LOOK-UNDER REACH-IN>
		<TELL "Better not. There isn't much thyme left." CR>
		<RTRUE>)
	       (<VERB? KILL>
		<V-WAIT>
		<RTRUE>)
	       (<PLAYING-IN?>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "The scent is vaguely aromatic." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>				

<ROUTINE PLAYING-IN? ()
	 <COND (<VERB? STAND-ON CROSS SIT LIE-DOWN ENTER PLAY>
		<TELL
"Cavorting in " THEO " isn't likely to help matters." CR>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT PLATFORM
	(LOC LOCAL-GLOBALS)
	(DESC "platform")
	(FLAGS NODESC SURFACE)
	(SYNONYM PLATFORM TOWER STRUCTURE)
	(ACTION PLATFORM-F)>

<ROUTINE PLATFORM-F ("AUX" (ON? <>))
	 <COND (<HERE? ON-PLATFORM>
		<SET ON? T>)>
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<COND (<HERE? ON-PLATFORM UNDER-PLAT>
		       <V-LOOK>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP ENTER THROUGH>
		<COND (<HERE? UNDER-PLAT>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (<ZERO? .ON?>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN EXIT LEAVE>
		<COND (<ZERO? .ON?>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? WALK-TO STAND-UNDER>
		<COND (<HERE? UNDER-PLAT>
		       <TELL ,YOURE-ALREADY "under " THEO ,PERIOD>
		       <RTRUE>)
		      (<ZERO? .ON?>
		       <DO-WALK <GETP ,HERE ,P?PLAT-DIR>>
		       <RTRUE>)>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<COND (<ZERO? .ON?>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TUNDRA
	(LOC LOCAL-GLOBALS)
	(DESC "tundra")
	(FLAGS NODESC)
	(SYNONYM TUNDRA PLAIN LANDSCAPE WASTELAND PERMAFROST FROST)
	(ACTION TUNDRA-F)>

<ROUTINE TUNDRA-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<COND (<HERE? ON-PLATFORM UNDER-PLAT>
		       <TELL CTHEO
" stretches away in all " D ,INTDIR "s." CR>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? WALK-TO CLIMB-ON STAND-ON>
		<COND (<HERE? ON-PLATFORM>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? CLIFF-EDGE>
		       <DO-WALK ,P?SW>
		       <RTRUE>)>
		<ALREADY-IN ,TUNDRA T>
		<RTRUE>)
	       (<VERB? CROSS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT PLADDER
	(LOC LOCAL-GLOBALS)
	(DESC "ladder")
	(FLAGS NODESC)
	(SYNONYM LADDER RUNG RUNGS)
	(ACTION PLADDER-F)>

<ROUTINE PLADDER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO " leads ">
		<COND (<HERE? UNDER-PLAT>
		       <TELL "up to the " D ,PLATFORM>)
		      (T
		       <TELL "down to the ground">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,ON-PLATFORM>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TMOUNTS
	(LOC LOCAL-GLOBALS)
	(DESC "mountains")
	(FLAGS NODESC PLURAL)
	(SYNONYM MOUNTAINS HILLS MOUNTAIN HILL HORIZON WALL WALLS FORTRESS)
	(ADJECTIVE FRIGID SNOWY GRAY)
	(ACTION TMOUNTS-F)>

"TOUCHED = seen through open door on mesa."

<ROUTINE TMOUNTS-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<TELL CTHEO
" tower like gray walls against the sky." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP ENTER THROUGH CLIMB-OVER
		       CROSS SIT STAND-ON LIE-DOWN>
		<COND (<HERE? ATUN BTUN CTUN ETUN HTUN CLIFF-EDGE>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN EXIT LEAVE>
		<NOT-IN ,TMOUNTS T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PASS
	(LOC LOCAL-GLOBALS)
	(DESC "river bed")
	(FLAGS NODESC)
	(SYNONYM PASS OPENING HOLE RIVER BED)
	(ADJECTIVE ANCIENT PREHISTORIC RIVER)
	(ACTION PASS-F)>

<ROUTINE PASS-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO " leads ">
		<COND (<HERE? CTUN>
		       <TELL "northea">)
		      (T
		       <TELL "southwe">)>
		<TELL "st, between the " D ,TMOUNTS ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CROSS CLIMB-OVER>>
		<DO-WALK <COND (<HERE? CTUN> ,P?NE)
			       (T ,P?SW)>>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT RODENTS
	(LOC LOCAL-GLOBALS)
	(DESC "rodents")
	(FLAGS NODESC TRYTAKE PLURAL TOUCHED CHILLY)
	(SYNONYM RODENT RODENTS ANIMAL ANIMALS LEMMING LEMMINGS)
	(ADJECTIVE BROWN FURRY SMALL TINY)
	(GENERIC GENERIC-LEMMINGS-F)
	(ACTION RODENTS-F)>

"TOUCHED, CHILLY = timing flags for I-RODENTS."

<ROUTINE RODENTS-F ()
	 <COND (<IS? ,RODENTS ,TOUCHED> ; "For cheaters."
		<REFERRING>
		<RTRUE>)
	       (<AND <NOT <IS? ,LEMMINGS ,TOUCHED>>
		     <NOUN-USED? ,W?LEMMING ,W?LEMMINGS>>
		<SWITCH-LEMMINGS>
	 	<VOICE-MUTTERS "Heavy">)>
	 <COND (<LEMMINGS-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"This global indicates whether RODENTS or LEMMINGS are in force."

<GLOBAL RATS:OBJECT <>>

<ROUTINE GENERIC-LEMMINGS-F (TABLE)
	 <RETURN ,RATS>>

<ROUTINE SWITCH-LEMMINGS ()
	 <SETG P-THEM-OBJECT ,LEMMINGS>
	 <SETG RATS ,LEMMINGS>
	 <MAKE ,LEMMINGS ,TOUCHED>
	 <RTRUE>>

<OBJECT LEMMINGS
	(LOC LOCAL-GLOBALS)
	(DESC "lemmings")
	(FLAGS NODESC TRYTAKE PLURAL LIVING)
	(SYNONYM LEMMING LEMMINGS ANIMAL ANIMALS RODENT RODENTS)
	(ADJECTIVE BROWN FURRY SMALL TINY)
	(GENERIC GENERIC-LEMMINGS-F)
	(ACTION LEMMINGS-F)>
		
"TOUCHED = player referred to rodents as LEMMINGS."

<ROUTINE LEMMINGS-F ()
	 <COND (<IS? ,RODENTS ,TOUCHED>
		<REFERRING>
		<RFATAL>)>
	 <MAKE ,RODENTS ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE FEED SHOW>
		       <TELL CTHE ,RATS " are too busy">
		       <RUN-OR-LEAPING>
		       <TELL " to notice." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <TELL "The running " D ,RATS 
			     " would be hard to hit." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? WATCH>
		<UNMAKE ,RODENTS ,SEEN>
		<I-RODENTS <>>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<IS? ,RODENTS ,CHILLY>
		       <UNMAKE ,RODENTS ,SEEN>
		       <I-RODENTS <>>
		       <RTRUE>)>
		<TELL CTHE ,RATS>
		<RUN-OR-LEAPING>
		<TELL " look something like hamsters">
		<LONG-BROWN>
		<TELL ,PTHE "largest are only five or six inches long." CR>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<DO-WALK
		  <COND (<HERE? FTUN UNDER-PLAT CTUN CLIFF-EDGE> ,P?NE)
			(<HERE? ATUN BTUN DTUN> ,P?EAST)
			(T ,P?NORTH)>>
		<RTRUE>)
	       (<VERB? TAKE RAISE>
		<TELL "You manage to grab one of the " D ,RATS
", but it relieves itself in " D ,HANDS "s and struggles away." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHE ,RATS " are too busy">
		<RUN-OR-LEAPING>
		<TELL " to chat right now." CR>
		<RFATAL>)
	       (<AND <VERB? TOUCH SHAKE SQUEEZE PLAY KNOCK>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "You'd have to catch one first." CR>
		<RTRUE>)
	       (<VERB? STAND-ON KILL HIT CLIMB-ON>
		<TELL CTHE ,RATS " nimbly leap out of way." CR>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE LONG-BROWN ()
	 <TELL ", with long brown fur and beady eyes">
	 <RTRUE>>

<ROUTINE RUN-OR-LEAPING ()
	 <COND (<HERE? CLIFF-EDGE>
		<TELL " leaping off the " D ,TCLIFF>
		<RTRUE>)>
	 <TELL " running past">
	 <RTRUE>>
		
<OBJECT LEM
	(DESC "lemming")
	(FLAGS TAKEABLE LIVING PERSON)
	(VALUE 0)
	(SIZE 4)
	(MASS 3)
	(SYNONYM LEMMING LEMMINGS RODENT ANIMAL)
	(ADJECTIVE BROWN SMALL TINY FURRY)
	(ACTION LEM-F)>

"CHILLY = holding delay, SEEN = just referenced."

<ROUTINE LEM-F ()
	 <MAKE ,LEM ,SEEN>
	 <COND ; (<AND <NOUN-USED? ,W?LEMMINGS>
		     <VISIBLE? ,LEM>>
		<TELL "You">
		<COND (<GOT? ,LEM>
		       <TELL "'ve got">)
		      (T
		       <TELL " see">)>
		<TELL " only one " D ,LEM ,PERIOD>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE FEED>
		       <COND (<PRSO? BAG GARLIC>
			      <TELL ,CTHELEM "sniffs at " THEO 
				    ", but shows no interest." CR>
			      <RTRUE>)>
		       <NOT-LIKELY ,PRSO "would appeal to a lemming">
		       <RTRUE>)>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL ,CTHELEM "sulks, refusing to respond." CR>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL ,CTHELEM "looks something like a hamster">
		<LONG-BROWN>
		<TELL " that ">
		<COND (<AND <HERE? IN-ORBIT ON-SAT>
			    <ZERO? ,SUITED?>>
		       <TELL "bulge in the vacuum of space." CR>
		       <RTRUE>)>
		<TELL "glare at you defiantly." CR>
		<RTRUE>)
	       (<VERB? WATCH>
		<COND (<AND <HERE? IN-ORBIT ON-SAT>
			    <ZERO? ,SUITED?>>
		       <TELL "It isn't looking well." CR>
		       <RTRUE>)>
		<UNMAKE ,PRSO ,SEEN>
		<I-LEM <>>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL ,CTHELEM "chatters nervously." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>	    

<OBJECT FISSURE
	(LOC CLIFF-EDGE)
	(DESC "fissure")
	(FLAGS NODESC CONTAINER OPENED)
	(CAPACITY 20)
	(SYNONYM FISSURE CREVICE CLEFT OPENING HOLE)
	(ADJECTIVE NARROW)
	(ACTION FISSURE-F)>

"TOUCHED = looked inside."

<ROUTINE FISSURE-F ("AUX" X)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <PRSO-FALLS-DEEP>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE SEARCH>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<MAKE ,PRSO ,TOUCHED>
		<QUEUE I-LEM -1>
		<MAKE ,LEM ,CHILLY>
		<SETG P-IT-OBJECT ,LEM>
		<TELL "A trapped " D ,LEM " glares up at you defiantly">
		<COND (<FIRST? ,PRSO>
		       <TELL ". There's also ">
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " in the " D ,PRSO>)>
		<PRINT ,PERIOD>
		<MOVE ,LEM ,PRSO>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER STAND-ON SIT LIE-DOWN>>
		<TELL CTHE ,FISSURE " is much too narrow." CR>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TCLIFF
	(LOC CLIFF-EDGE)
	(DESC "cliff")
	(FLAGS NODESC)
	(SYNONYM CLIFF EDGE LEDGE SIDE BOTTOM)
	(ADJECTIVE STEEP CLIFF)
	(ACTION TCLIFF-F)>

"TOUCHED = cliff examined."

<ROUTINE TCLIFF-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <VANISH>
		       <TELL CTHEO " disappears over the edge of the "
			     D ,TCLIFF ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-DOWN LOOK-BEHIND>
		<LOOK-DOWN-TCLIFF>
		<RTRUE>)
	       (<VERB? CLIMB-OVER CLIMB-DOWN LEAP>
		<COND (<IS? ,PRSO ,TOUCHED>
		       <DO-WALK ,P?NE>
		       <RTRUE>)>
		<MAKE ,PRSO ,TOUCHED>
		<TAKE-A-MOMENT-TO ,TCLIFF>
		<RFATAL>)
	       (<VERB? LOOK-UP CLIMB-ON CLIMB-UP>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? STAND-ON>
		<ALREADY-DOING-THAT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-DOWN-TCLIFF ()
	 <MAKE ,TCLIFF ,TOUCHED>
	 <TELL 
"The waves dashing on the rocks below are choked with " D ,DLEM "s." CR>
	 <RTRUE>>

<OBJECT TSEA
	(LOC CLIFF-EDGE)
	(DESC "sea")
	(FLAGS NODESC)
	(SYNONYM SEA OCEAN SEAWATER WATER WAVES WAVE ROCKS ROCK BODIES)
	(ADJECTIVE COLD)
	(ACTION TSEA-F)>

<ROUTINE TSEA-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <VANISH>
		       <TELL CTHEO " disappears over the cliff." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<LOOK-DOWN-TCLIFF>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-OVER STAND-UNDER STAND-ON SIT
			   LIE-DOWN>>
		<PERFORM ,V?CLIMB-OVER ,TCLIFF>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER LOOK-BEHIND SEARCH>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT TBOMB
	(LOC ON-PLATFORM)
	(DESC "enclosure")
	(FLAGS NODESC VOWEL TRYTAKE NOALL)
	(SYNONYM ENCLOSURE BOMB DEVICE)
	(ADJECTIVE MASSIVE LARGE STEEL METAL)
        (ACTION TBOMB-F)>

<ROUTINE TBOMB-F ()
	 <COND (<HANDLE-BOMB?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TCABLES
	(LOC LOCAL-GLOBALS)
	(DESC "cables")
	(FLAGS NODESC TRYTAKE FERRIC PLURAL)
	(SYNONYM CABLES WIRES CABLE WIRE)
	(ADJECTIVE THICK)
	(ACTION TCABLES-F)>

<ROUTINE TCABLES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " run southwest, across the " D ,TUNDRA ,PERIOD>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<COND (<HERE? UNDER-PLAT>
		       <DO-WALK ,P?SW>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (<VERB? HIT CUT RIP MUNG>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT GROUP
	(LOC FTUN)
	(DESC "group of buildings")
	(FLAGS NODESC)
	(SYNONYM GROUP BUILDINGS BUILDING STRUCTURE BUNKER BUNKERS)
	(ACTION GROUP-F)>

"TOUCHED = group examined."

<ROUTINE GROUP-F ()
	 <COND (<VERB? EXAMINE>
		<MAKE ,PRSO ,TOUCHED>
		<TELL "The distant " D ,SCHOOL
		      "s look like military " D ,NBUNKERS 
		      ". Armed guards are patrolling the area." CR>
		<RTRUE>)
	       (<RUSSIA?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RUSSIANS
	(LOC FTUN)
	(DESC "guards")
	(FLAGS NODESC PERSON PLURAL)
	(SYNONYM GUARDS GUARDS SOLDIER SOLDIERS MEN RUSSIAN RUSSIANS)
	(ADJECTIVE ARMED RUSSIAN)
	(ACTION RUSSIANS-F)>

<ROUTINE RUSSIANS-F ()
	 <COND (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL "Luckily, the " D ,RUSSIANS 
" don't notice. You're still too far away." CR>
		<RFATAL>)
	       (<RUSSIA?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE RUSSIA? ()
	 <COND (<AND <VERB? WALK-TO FOLLOW>
		     <HERE? FTUN>>
		<MEET-RUSKIES>
		<RTRUE>)
	       (<OR <VERB? LOOK-INSIDE SEARCH READ>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MEET-RUSKIES ()
	 <COND (<NOT <IS? ,GROUP ,TOUCHED>>
		<MAKE ,GROUP ,TOUCHED>
		<TAKE-A-MOMENT-TO ,GROUP>
		<RFALSE>)>
	 <SAY-SURE>
	 <TELL "go that way?">
	 <COND (<YES?>
		<CRLF>
		<VOICE-MUTTERS "It's your funeral">
		<TELL "You draw closer to the " 
		      D ,GROUP ,PCR>
	 	<HLIGHT ,H-BOLD>
	 	<TELL "Control Bunkers">
	 	<HLIGHT ,H-NORMAL>
	 	<TELL CR CR "This cluster of military " D ,NBUNKERS
" is choked with scientific instruments, tended by men in heavy overcoats.|
|
One of the guards patrolling the area greets your unexpected arrival by shooting you in the back. As your blood seeps into the permafrost, you note with interest the hammer-and-sickle insignia on the uniform of your grim assailant.">
	 	<JIGS-UP>
		<RFALSE>)>
	 <UNMAKE ,GROUP ,TOUCHED>
	 <NO-DETECTION>
	 <RFALSE>>  
			       
<OBJECT VALLEY
	(LOC ON-BLUFF)
	(DESC "valley")
	(FLAGS NODESC)
	(SYNONYM VALLEY)
	(ACTION VALLEY-F)>

<ROUTINE VALLEY-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-DOWN>
		<LOOK-AT-VALLEY>
		<CRLF>
		<RTRUE>)
	       (<VERB? LEAP DIVE ENTER CLIMB-DOWN>
		<CHASM-FALL>
		<RTRUE>)
	       (<VERB? CROSS CLIMB-OVER>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT BLUFF
	(LOC ON-BLUFF)
	(DESC "bluff")
	(FLAGS NODESC)
	(SYNONYM BLUFF)
	(ACTION HERE-F)>

<OBJECT FOREST
	(LOC LOCAL-GLOBALS)
	(DESC "forest")
	(FLAGS NODESC)
	(SYNONYM FOREST WOODS TREES TREE)
	(ADJECTIVE DENSE THICK BLACK DARK)
	(GENERIC GENERIC-TREE-F)
	(ACTION FOREST-F)>

<ROUTINE FOREST-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-UNDER LOOK-BEHIND>
		<TELL ,YOU-SEE "nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP SIT STAND-ON LIE-DOWN>
		<TELL "There aren't any good footholds." CR>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP DIVE>>
	        <TELL "You're not in a tree." CR>
		<RTRUE>)
	       (<ENTERING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " is very quiet." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " smells old and damp." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <OBJECT ALB
	(LOC AT-TRELS)
	(DESC "alabaster statue")
	(FLAGS NODESC TRYTAKE NOALL VOWEL)
	(SYNONYM STATUE ART FIGURE GIRL CHILD KID FEMALE LIKENESS)
	(ADJECTIVE WHITE ALABASTER GYPSUM SMALL LITHE)
	(ACTION ALB-F)>

; <ROUTINE ALB-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? THROW>
			    <G? <GETP ,PRSO ,P?SIZE> 3>>
		       <SHAME-ALB>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" is carved in the likeness of a young girl. Her lithe arm gestures enticingly towards the south">
		<SAY-EAST>
		<TELL " trellis." CR>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN MOVE PULL PUSH PUSH-TO SHAKE TURN>
		<FIRMLY-ATTACHED ,PRSO ,GROUND>
		<RTRUE>)
	       (<VERB? CUT MUNG HIT>
		<COND (<PRSI? AXE LUMP SPADE>
		       <SHAME-ALB>
		       <RTRUE>)>
		<TELL "This has little effect." CR>
		<RTRUE>)
	       (<VERB? STAND-ON SIT LIE-DOWN CLIMB-OVER CLIMB-ON LEAP>
		<TELL "The statue's design discourages this." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE SHAME-ALB ()
	 <TELL "It's pointless to ruin the " D ,ALB
	       " without reason." CR>
	 <RTRUE>>

<OBJECT TRELS
	(LOC AT-TRELS)
	(DESC "trellises")
	(FLAGS NODESC)
	(SYNONYM TRELLISES ARCHES OPENINGS HOLES BREACHES)
	(ACTION TRELS-F)>

<ROUTINE TRELS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "They lead southeast and southwest, into the "
		      D ,HEDGE ,PERIOD>
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "One, two." CR>
		<RTRUE>)
	       (<HANDLE-TRELS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RTREL
	(LOC AT-TRELS)
	(DESC "right trellis")
	(FLAGS NODESC)
	(SYNONYM TRELLIS ARCH ARCHWAY OPENING HOLE ENTRY ENTRANCE
	  	 BREACH)
	(ADJECTIVE RIGHT RIGHT\-HAND)
	(ACTION RTREL-F)>

<ROUTINE RTREL-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-TRELLIS "southwest">
		<RTRUE>)
	       (<THRU-TRELLIS? ,P?SW>
		<RTRUE>)
	       (<HANDLE-TRELS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LTREL
	(LOC AT-TRELS)
	(DESC "left trellis")
	(FLAGS NODESC)
	(SYNONYM TRELLIS ARCH ARCHWAY OPENING HOLE ENTRY ENTRANCE
	  	 BREACH)
	(ADJECTIVE LEFT LEFT\-HAND)
	(ACTION LTREL-F)>

<ROUTINE LTREL-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-TRELLIS "southeast">
		<RTRUE>)
	       (<THRU-TRELLIS? ,P?SE>
		<RTRUE>)
	       (<HANDLE-TRELS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE SEE-TRELLIS (STR)
	 <TELL 
"The arched " D ,ATREL " is thickly woven with " D ,ARBS ". It opens " .STR
", into the " D ,HEDGE ,PERIOD>
	 <RTRUE>>

<ROUTINE THRU-TRELLIS? (DIR)
	 <COND (<OR <ENTERING?>
		    <VERB? STAND-UNDER>>
		<DO-WALK .DIR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-TRELS? ()
	 <COND (<VERB? LOOK-INSIDE LOOK-BEHIND>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER STAND-ON SIT LIE-DOWN
		       LEAP>
		<TOO-HIGH>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ATREL
	(LOC SWPATH)
	(DESC "trellis")
	(FLAGS NODESC)
	(SYNONYM TRELLIS ARCH ARCHWAY OPENING HOLE)
	(ADJECTIVE ARCHED NORTHEAST NE)
	(ACTION ATREL-F)>

<ROUTINE ATREL-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-TRELLIS "northeast">
		<RTRUE>)
	       (<THRU-TRELLIS? ,P?NE>
		<RTRUE>)
	       (<HANDLE-TRELS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BTREL
	(LOC SEPATH)
	(DESC "trellis")
	(FLAGS NODESC)
	(SYNONYM TRELLIS ARCHWAY ARCH OPENING HOLE)
	(ADJECTIVE ARCHED NORTHWEST NW)
	(ACTION BTREL-F)>

<ROUTINE BTREL-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-TRELLIS "northwest">
		<RTRUE>)
	       (<THRU-TRELLIS? ,P?NW>
		<RTRUE>)
	       (<HANDLE-TRELS?>
		<RTRUE>)
	       (T
		<RFALSE>)>>	
	 
<OBJECT ARBS
	(LOC LOCAL-GLOBALS)
	(DESC "arborvitaes")
	(FLAGS NODESC VOWEL PLURAL)
	(SYNONYM HEDGE BUSH BUSHES ARBORVITA GROWTH WALL WALLS VITAE VITAES
	 	 VINE VINES TENDRIL TENDRILS)
	(ADJECTIVE TALL HIGH OVERGROWN GREEN)
	(GENERIC GENERIC-ARBS-F)
	(ACTION HEDGE-F)>

<OBJECT HEDGE
	(LOC LOCAL-GLOBALS)
	(DESC "hedge")
	(FLAGS NODESC)
	(SYNONYM HEDGE BUSH BUSHES ARBORVITA GROWTH WALL WALLS VITAE VITAES
	 	 VINE VINES TENDRIL TENDRILS)
	(ADJECTIVE TALL HIGH OVERGROWN GREEN ARBOR)
	(GENERIC GENERIC-ARBS-F)
	(ACTION HEDGE-F)>

<ROUTINE GENERIC-ARBS-F (TABLE)
	 <COND (<HERE? ARBORETUM NORTH-ARBOR SOUTH-ARBOR ARBOR-TOP>
		<RETURN ,ARBOR>)
	       (<OR <EQUAL? ,W?ARBORVITA ,P-NAM ,P-XNAM>
		    <EQUAL? ,W?VITAES ,P-NAM ,P-XNAM>>
		<RETURN ,ARBS>)>
	 <RETURN ,HEDGE>>

<ROUTINE HEDGE-F ("AUX" (IN <>))
	 <COND (<HERE? SWPATH ARBORETUM SEPATH
		       NORTH-ARBOR ARBOR-TOP SOUTH-ARBOR>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW-OVER PUT-BEHIND>
		       <COND (<HERE? NORTH-ARBOR ARBOR-TOP SOUTH-ARBOR>
			      <CANT-FROM-HERE>
			      <RTRUE>)>
		       <MOVE ,PRSO <GETP ,HERE ,P?OVER-HEDGE>>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO 
" sails over the top of the hedge and disappears." CR>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PRSI-TOP-TOO-HIGH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,HEDGE
" is a dense tangle of " D ,ARBS ", thirty feet high">
		<COND (<HERE? AT-TRELS>
		       <TELL ,PA "pair of " D ,TRELS " leads inside">)
		      (<HERE? DOCKSIDE>
		       <TELL ". It ends at the river's edge">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND SEARCH>
		<COND (<HERE? AT-TRELS>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<TELL CTHE ,HEDGE " is much too thick." CR>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<COND (<HERE? DOCKSIDE>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (<HERE? FCLEARING>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<HERE? AT-TRELS>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<T? .IN>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER CLIMB-UP SIT STAND-ON
		       LIE-DOWN LEAP>
		<TOO-HIGH>
		<RTRUE>)
	       (<EXITING?>
		<COND (<T? .IN>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN TAKE-OFF>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-HEDGE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SMELL-HEDGE ()
	 <TELL "The air is pungent with the odor of " D ,ARBS ,PERIOD>
	 <RTRUE>>

<OBJECT ARBOR
	(LOC LOCAL-GLOBALS)
	(DESC "pergola")
	(FLAGS NODESC)
	(SYNONYM PERGOLA ARCH TUNNEL TUNNELS
	 	 ARBORVITA VITAES VITAE VINE VINES TENDRIL TENDRILS)
	(ADJECTIVE GREEN ARBOR)
	(GENERIC GENERIC-ARBS-F)
	(ACTION ARBOR-F)>

<ROUTINE ARBOR-F ("AUX" (UNDER <>))
	 <COND (<HERE? ARBORETUM>
		<SET UNDER T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .UNDER>
		       <V-LOOK>
		       <RTRUE>)>
		<TELL CTHEO 
" resembles a doughnut, fifty feet across and woven entirely of " D ,ARBS 
". This \"doughnut\" is standing on end, and you're gawking up at it from underneath. ">
		<DESCRIBE-PERGOLA>
		<TELL 
"The whole affair is oddly skewed; some parts look as if they're turned inside out." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-OVER CLIMB-ON>>
		<COND (<T? .UNDER>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? CLIMB-UP>
		<COND (<HERE? ARBOR-TOP>
		       <ALREADY-AT-TOP>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<OR <VERB? CLIMB-DOWN>
		    <EXITING?>>
		<COND (<T? .UNDER>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? WALK-TO STAND-ON>
		<COND (<T? .UNDER>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<COND (<T? .UNDER>
		       <ALREADY-DOING-THAT>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
				  		        
<OBJECT MIASMA
	(LOC LOCAL-GLOBALS)
	(DESC "air")
	(FLAGS NODESC VOWEL NOARTICLE)
	(SYNONYM MIASMA AIR ATMOSPHERE)
	(ADJECTIVE THICK SUFFOCATING)
	(ACTION MIASMA-F)>

<ROUTINE MIASMA-F ()
	 <COND (<VERB? SMELL INHALE>
		<SUFFOCATE>
		<RTRUE>)
	       (<SKY-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>	

<ROUTINE SUFFOCATE ()
	 <TELL CTHE ,MIASMA " is thick and suffocating." CR>
	 <RTRUE>>

<OBJECT TRAP
	(LOC NBOG)
	(DESC "flytrap")
	(FLAGS TRYTAKE NOALL CONTAINER OPENABLE OPENED)
	(SYNONYM FLYTRAP TRAP PLANT INSECTIVO JAW JAWS CAVITY STEM)
	(ADJECTIVE VENUS VENUS\'S FLY INSECTIVO RED CRIMSON FLESHY)
	(CAPACITY 10)
	(DESCFCN DESCRIBE-TRAP)
	(ACTION TRAP-F)>

<ROUTINE DESCRIBE-TRAP ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A big Venus " D ,TRAP 
" is growing nearby. Its crimson jaws are ">
		<COND (<IS? ,TRAP ,OPENED>
		       <TELL 
"wide open, exposing a cavity that gleams with sweet-smelling " D ,ICHOR ".">
		       <RTRUE>)>
		<TELL "tightly closed.">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TRAP-F ()
	 <COND (<HANDLE-TRAP?>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO "'s ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "open ">)
		      (T
		       <TELL "tightly closed ">)>
		<TELL "jaws are fully three feet across.">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL " The inside">
		       <LOOK-INTO-TRAP>)>
		<CRLF>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<DESCRIBE-ICHOR>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <IS? ,PRSO ,OPENED>>
		<CLOSE-TRAP>
		<TELL CTHEO " closes instantly at your touch." CR>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH LOOSEN UNFOLD>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<TELL "Despite your best efforts, the " D ,PRSO
		      " refuses to open." CR>
		<RTRUE>)
	       (<VERB? CUT HIT MUNG>
		<COND (<PRSI? AXE SPADE PARASOL GNOMON>
		       <ITALICIZE "Boing!">
		       <TELL " " CTHEI "'s edge bounces off the " D ,PRSO
			     "'s fleshy stem">
		       <COND (<IS? ,PRSO ,OPENED>
			      <CLOSE-TRAP>
			      <TELL ", and the huge jaws snap shut">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would have much effect">
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL "Your attempt to ">
		<PRINTB ,P-PRSA-WORD>
		<TELL " the " D ,PRSO " ends ">
		<COND (<IS? ,PRSO ,OPENED>
		       <CLOSE-TRAP>
		       <TELL "when it snaps its jaws shut, nearly severing "
			     D ,HANDS ,PERIOD>
		       <RTRUE>)>
		<TELL "in failure." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-ICHOR ()
	 <COND (<IS? ,TRAP ,OPENED>
		<TELL "The inside of the " D ,TRAP>
		<LOOK-INTO-TRAP>
		<CRLF>
		<RTRUE>)>
	 <ITS-CLOSED ,TRAP>
	 <RTRUE>>

<ROUTINE HANDLE-TRAP? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <COND (<IS? ,TRAP ,OPENED>
			      <COND (<PRSO? LEM>
				     <EXIT-LEM>)
				    (<PRSO? SKINK>
				     <EXIT-SKINK>)
				    (T
				     <MOVE ,PRSO ,TRAP>)>
			      <CLOSE-TRAP>
			      <LEAP-FROM-TRAP>
			      <RTRUE>)
			     (<VERB? PUT-ON THROW>
			      <PRSO-SLIDES-OFF-PRSI>
			      <RTRUE>)>
		       <ITS-CLOSED ,PRSI>
		       <RTRUE>)
		      (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		       <TOUCH-TRAP>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? SMELL>
		<SMELL-TRAP>
		<RTRUE>)
	       (<VERB? ENTER SIT LIE-DOWN STAND-ON CLIMB-ON CLIMB-OVER
		       THROUGH CLIMB-UP CLIMB-DOWN>
		<COND (<IS? ,TRAP ,OPENED>
		       <CLOSE-TRAP>
		       <LEAP-FROM-TRAP>
		       <RTRUE>)>
		<ITS-CLOSED ,TRAP>
		<RTRUE>)
	       (<VERB? TOUCH PLAY SQUEEZE PICK CLEAN KICK HIT ADJUST SPIN
		       SHAKE> 
		<TOUCH-TRAP>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCH-TRAP ()
	 <COND (<IS? ,TRAP ,OPENED>
		<CLOSE-TRAP>
		<LEAP-FROM-TRAP>
		<RTRUE>)>
	 <TELL "The closed " D ,TRAP " doesn't respond." CR>
	 <RTRUE>>

<ROUTINE SMELL-TRAP ()
	 <TELL CTHE ,TRAP "'s smell reminds you of corn syrup." CR>
	 <RTRUE>>

<GLOBAL JAW-TIME:NUMBER 10>

<ROUTINE CLOSE-TRAP ()
	 <SETG JAW-TIME 10>
	 <QUEUE I-JAWS -1>
	 <UNMAKE ,TRAP ,OPENED>
	 <RTRUE>> 

<ROUTINE LEAP-FROM-TRAP ()
	 <TELL
"You barely manage to leap away from the " D ,TRAP
" before the crimson jaws snap shut." CR>
	 <RTRUE>>

<ROUTINE LOOK-INTO-TRAP ()
	 <TELL 
" is coated with a glistening " D ,ICHOR " that resembles morning dew.">
	 <RTRUE>>

<OBJECT ICHOR
	(LOC TRAP)
	(DESC "ichor")
	(FLAGS NODESC VOWEL TRYTAKE NOALL)
	(SYNONYM ICHOR ICHORS SYRUP LIQUID MOISTURE DEW MORNINGDEW)
	(ADJECTIVE SWEET SWEET\-SMELL)
	(ACTION ICHOR-F)>

<ROUTINE ICHOR-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<DESCRIBE-ICHOR>
		<RTRUE>)
	       (<HANDLE-TRAP?>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		    <VERB? DRINK TASTE EAT BITE>>
		<TOUCH-TRAP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BOG
	(LOC LOCAL-GLOBALS)
	(DESC "bog")
	(FLAGS NODESC)
	(SYNONYM BOG SWAMP LIQUIDS DRIP SOUNDS)
	(ADJECTIVE DRIPPING MOIST)
	(ACTION BOG-F)>

<ROUTINE BOG-F ()
	 <COND (<VERB? LISTEN>
		<HEAR-DRIPPING>
		<RTRUE>)
	       (<VERB? SMELL INHALE>
		<SUFFOCATE>
		<RTRUE>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE HEAR-DRIPPING ()
	 <TELL 
"You can hear dripping liquids and other moist " D ,SOUND "s close by." CR>
	 <RTRUE>>

<OBJECT HIVE
	(LOC UNDER-CLIFF)
	(DESC "beehive")
	(FLAGS NODESC CONTAINER SURFACE OPENED TRYTAKE NOALL)
	(CAPACITY 50)
	(SYNONYM HIVE BEEHIVE NEST OPENING HOLE BOTTOM)
	(ADJECTIVE BEE GRAY GREY DARK PAPERY)
	(ACTION HIVE-F)>

<ROUTINE HIVE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON THROW TOUCH-TO PUSH-TO>
		       <COND (<PRSO? HANDS>
			      <FEEL-HIVE>
			      <RTRUE>)>
		       <MUNG-HIVE ,PRSO>
		       <RTRUE>)	     
		      (<VERB? PUT>
		       <COND (<PRSO? HANDS>
			      <PUT-HAND-IN-HIVE>
			      <RTRUE>)
			     (<L? <GETP ,PRSO ,P?MASS> 4>
			      <MOVE ,PRSO ,HERE>
			      <TELL CTHEO
" drops out of the " D ,PRSI " and lands at your feet." CR>
			      <BUZZ-RISES>
			      <RTRUE>)>
		       <RUPTURES-HIVE ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The gray mass of the " D ,PRSO
" hangs down from the overhanging cliff. A dark " D ,CAVE-HOLE
" in the bottom is low enough to reach." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<AND <VERB? TOUCH KNOCK KISS>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<FEEL-HIVE>
		<RTRUE>)
	       (<VERB? REACH-IN EMPTY>
		<PUT-HAND-IN-HIVE>
		<RTRUE>)
	       (<VERB? CUT RIP MUNG HIT LOOSEN>
		<COND (<ZERO? ,PRSI>
		       <RUPTURES-HIVE ,HANDS>
		       <RTRUE>)>
		<MUNG-HIVE ,PRSI>
		<RTRUE>)
	       (<VERB? SMELL INHALE>
		<TELL CTHEO " fills the air with a sweet odor." CR>
		<RTRUE>)
	       (<VERB? SHAKE SQUEEZE>
		<RUPTURES-HIVE ,HANDS>
		<RTRUE>)
	       (<VERB? KICK>
		<RUPTURES-HIVE ,FEET>
		<RTRUE>)
	       (<VERB? LISTEN>
		<HEAR-HIVE>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<VERB? CLOSE>
		<HOW?>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL "A crescendo of buzzing" ,CHANGES>
		<RTRUE>)	       
	       (T
		<RFALSE>)>>
	       
<ROUTINE MUNG-HIVE (OBJ)
	 <COND (<EQUAL? .OBJ ,HANDS ,FEET>
		<RUPTURES-HIVE .OBJ>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,PLAYER>>
		<YOUD-HAVE-TO "be holding" .OBJ>
		<RTRUE>)
	       (<OR <EQUAL? .OBJ ,AXE ,ICE ,LUMP>
		    <EQUAL? .OBJ ,PARASOL ,GNOMON ,SPADE>
		    <EQUAL? .OBJ ,SHARD ,CAGE>>
		<RUPTURES-HIVE .OBJ>
		<RTRUE>)>
	 <MOVE .OBJ ,HERE>
	 <TELL CTHE .OBJ 
" strikes the hive and lands harmlessly at your feet." CR>
	 <BUZZ-RISES>
	 <RTRUE>>
	       
<ROUTINE PUT-HAND-IN-HIVE ()
	 <TELL "You reach ">
	 <COND (<IN? ,HONEY ,HIVE>
		<TELL "reckless">)
	       (T
		<TELL "greedi">)>
	 <TELL 
"ly into the hive, and feel something sticky at your fingertips. ">
	 <COND (<IS? ,BEE ,BORING>
		<UNMAKE ,BEE ,BORING>
		<MOVE ,BEE ,UNDER-CLIFF>
		<QUEUE I-BEE -1>
		<TELL "Then a sharp, burning pain sears " D ,HANDS
" like fire!|
|
Howling with agony">
		<YANK-ARM>
		<TELL "shake a gigantic bee off your swelling hand." CR>
		<RTRUE>)>
	 <TELL "Without hesitation">
	 <YANK-ARM>
	 <TELL "find " D ,HANDS>
	 <COND (<IN? ,HONEY ,HIVE>
		<UNMAKE ,HONEY ,NODESC>
		<MOVE ,HONEY ,PLAYER>
		<TELL " gleaming with a golden " D ,HONEY ,PERIOD>
		<UPDATE-SCORE 3>
		<RTRUE>)>
	 <TELL " covered with gigantic bees!" CR>
	 <BEES-ATTACK>
	 <RTRUE>>		
		 
<ROUTINE YANK-ARM ()
	 <TELL ", you yank your arm out of the hive and ">
	 <RTRUE>>

<ROUTINE RUPTURES-HIVE (THING)
	 <TELL "With a papery ">
	 <ITALICIZE "crunch,">
	 <TELL " " THE .THING 
" ruptures the " D ,CSURFACE " of the " D ,HIVE ,PERIOD>
	 <BEES-ATTACK>
	 <RTRUE>>

<ROUTINE BEES-ATTACK ()
	 <TELL CR 
"Giant bees pour out of the hive in an angry cloud! They cover your face and neck with hundreds of stings, any few of which would have been enough to kill you.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE FEEL-HIVE ()
	 <TELL "The gray " D ,CSURFACE " feels dry and papery." CR>
	 <BUZZ-RISES>
	 <RTRUE>>

<ROUTINE BUZZ-RISES ()
	 <TELL CR CTHE ,HIVE 
"'s buzz grows louder, then slowly subsides." CR>
	 <RTRUE>>
	
<OBJECT HONEY
        (LOC HIVE)
	(DESC "handful of honey")
	(FLAGS FOODBIT NODESC TOUCHED TAKEABLE NOALL SURFACE)
	(SYNONYM HONEY FOOD HANDFUL)
	(ADJECTIVE GOLDEN STICKY WET MOIST SWEET)
	(CAPACITY 0)
	(SIZE 0)
	(MASS 1)
      ; (VALUE 0)
	(ACTION HONEY-F)>

<ROUTINE HONEY-F ()
	 <COND (<IN? ,HONEY ,HIVE>
		<CANT-SEE-ANY "any honey" T>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON COVER>
		       <HONEYFY ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "It's all over " D ,HANDS ,PERIOD>
		<RTRUE>)
	       (<VERB? CLEAN CLEAN-OFF>
		<COND (<PRSI? PRSO>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <HONEY-STICKS>
		       <RTRUE>)>
		<HONEYFY ,PRSI>
		<RTRUE>)
	       (<VERB? TASTE EAT>
		<VANISH>
		<TELL "You lick all the honey off your fingers. Yum." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<HONEY-STICKS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HONEYFY (OBJ)
	 <TELL "You'd get honey all over " THE .OBJ ,IF-YOU-DID>
	 <RTRUE>>

<ROUTINE HONEY-STICKS ()
	 <TELL "The honey sticks stubbornly to " D ,HANDS ,PERIOD>
	 <RTRUE>>

<OBJECT BEES
	(LOC UNDER-CLIFF)
	(DESC "bees")
	(FLAGS PLURAL TRYTAKE NOALL NODESC)
	(SYNONYM BEES BEE INSECTS INSECT BUMBLEBEE HONEYBEE HONEYBEES
	 	 BUZZ BUZZING)
	(ADJECTIVE BUMBLE HONEY BUZZING)
	(GENERIC GENERIC-BEE-F)
	(ACTION BEES-F)>

<ROUTINE GENERIC-BEE-F (TBL)
	 <RETURN ,BEE>>

<ROUTINE BEES-F ()
	 <COND (<VERB? LISTEN>
		<TELL "T">
		<EARS-RING>
		<RTRUE>)
	       (<VERB? SMELL>
		<PERFORM ,V?SMELL ,HIVE>
		<RTRUE>)
	       (<AND <VERB? KILL HIT>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<RUPTURES-HIVE ,HANDS>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <VERB? FIND FOLLOW>>
		<TELL ,CANT "see any bees" ,AT-MOMENT " But t">
		<EARS-RING>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EARS-RING ()
	 <TELL "heir buzz is making your ears ring." CR>
	 <RTRUE>>

<OBJECT BEE
	(DESC "giant bee")
	(FLAGS NODESC LIVING TRYTAKE NOALL TOUCHED SEEN BORING)
	(SYNONYM BEE BEES INSECT BUMBLEBEE HONEYBEE BUZZ BUZZING)
	(ADJECTIVE BUMBLE HONEY GIANT GIGANTIC HUGE LARGE OVERGROWN BUZZING)
	(GENERIC GENERIC-BEE-F)
	(ACTION BEE-F)>
       
"TOUCHED = bee poised to strike, SEEN = 2 stings left, BORING = not seen."

<ROUTINE BEE-F ()
	 <COND (<NOUN-USED? ,W?BEES>
		<TELL "You see only one bee here." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <TELL CTHEI " easily avoids " THEO ", which ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO
" is about a foot long, including a three-inch stinger tipped with a drop of your own blood." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE TOUCH HIT KILL KNOCK SQUEEZE PUSH PULL
			    MOVE KICK STAND-ON SIT LIE-DOWN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO <PICK-NEXT <GET ,BEE-TABLE 2>> ,PERIOD>
		<RTRUE>)
	       (<VERB? KISS RIDE RAPE BLOW-INTO>
		<TELL "You have lost your mind." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " buzzes with indignance." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO " buzzes angrily in reply." CR>
		<RFATAL>)
	       (<VERB? WALK-TO FOLLOW>
		<ITS-RIGHT-HERE>
		<RTRUE>)
	       (<EXITING?>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
				
<OBJECT CAVERN
	(LOC LOCAL-GLOBALS)
	(DESC "tunnel")
	(FLAGS NODESC)
	(SYNONYM CAVERN CAVE TUNNEL TUNNELS CHAMBER UNDERGROUND 
	 	 PASSAGE PASSAGES DARKNESS)
	(ADJECTIVE ROCK UNDERGROUND DARK)
	(ACTION HERE-F)>

<OBJECT UBOMB
	(LOC TUN1)
	(DESC "cylinder")
	(FLAGS NODESC SURFACE CONTAINER TRYTAKE READABLE NOALL)
	(SYNONYM CYLINDER BOMB DEVICE WARNINGS WARNING)
	(CAPACITY 50)
	(ACTION UBOMB-F)>

"CHILLY = bomb examined."

<ROUTINE UBOMB-F ()
	 <COND (<HANDLE-BOMB?>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
" is about three feet in diameter and ten feet long. ">
		<READ-UBOMB>
		<RTRUE>)
	       (<VERB? READ LOOK-ON>
		<READ-UBOMB>
		<RTRUE>)
	       (<VERB? UNSCREW UNSCREW-FROM>
		<THIS-IS-NOT "The War of the Worlds">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE HANDLE-BOMB? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-UNDER PUT-BEHIND>
		       <NO-OPENINGS>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <NO-GOOD-SURFACE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE OPEN OPEN-WITH CLOSE REACH-IN SEARCH>
		<NO-OPENINGS>
		<RTRUE>)
	       (<VERB? DETONATE>
		<HOW?>
		<RTRUE>)
	       (<VERB? HIT CUT RIP MUNG>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? AXE SPADE GNOMON LUMP> 
		       <VOICE-MUTTERS "Brilliant">
		       <TELL "Your " D ,PRSI " cuts deep into the " D ,PRSO
		      	     ", lodging ">
		       <RESULTING-BLAST>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would do much damage">
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER SIT STAND-ON STAND-UNDER LIE-DOWN
		       LEAP RIDE CLIMB-UP CLIMB-DOWN>
		<TELL "Cavorting around the " D ,PRSO>
		<WONT-HELP>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RESULTING-BLAST ()
	 <TELL 
"into a compartment lined with high explosives. The resulting blast fails to initiate the nuclear reaction it was designed to trigger. It is, nevertheless, sufficiently powerful to blow you to bits.">
	 <JIGS-UP>
	 <RTRUE>>

<ROUTINE NO-OPENINGS ()
	 <TELL ,CANT "see any " D ,CAVE-HOLE "s." CR>
	 <RTRUE>>

<ROUTINE READ-UBOMB ()
	 <TELL
"Warnings indicate the presence of radioactivity." CR>
	 <RTRUE>> 
		       
<OBJECT UCABLES
	(LOC LOCAL-GLOBALS)
	(DESC "cables and pipes")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM CABLE CABLES PIPE PIPES PLUMBING MAZE COMPLEX)
	(ACTION UCABLES-F)>

<ROUTINE UCABLES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " lead west, into the ">
		<COND (<HERE? TUN3>
		       <TELL D ,LANDSLIDE>)
		      (T
		       <TELL D ,CAVERN>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT LANDSLIDE
	(LOC TUN3)
	(DESC "landslide")
	(FLAGS NODESC)
	(SYNONYM LANDSLIDE ROCKS DIRT)
      ; (ACTION LANDSLIDE-F)>

; <ROUTINE LANDSLIDE-F ()
	 <RFALSE>>
	
<OBJECT CREVICE
	(LOC TUN3)
	(DESC "crevice")
	(FLAGS NODESC CONTAINER OPENED)
	(CAPACITY 20)
	(SYNONYM CREVICE OPENING HOLE)
	(CONTFCN IN-CREVICE)
	(ACTION CREVICE-F)>

<ROUTINE IN-CREVICE ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-CONT>
		<COND (<AND <NOT <IN? ,SHARD ,CREVICE>>
			    <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		       <TOO-DARK-IN-CREVICE>
		       <RTRUE>)
		      (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		       <DEEP-CREVICE <COND (<THIS-PRSO?> ,PRSO) (T ,PRSI)>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<ROUTINE DEEP-CREVICE (THING)
	 <TELL ,CANT "quite reach " THE .THING ,PTHE D ,CREVICE
	       " is too deep." CR>
	 <RTRUE>>

<ROUTINE TOO-DARK-IN-CREVICE ()
	 <TELL "It's too dark to see anything in the "
	       D ,CREVICE ,PERIOD>
	 <RTRUE>>    

<ROUTINE CREVICE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<PRSO? SHARD>
			      <MOVE ,PRSO ,PRSI>
			      <TELL 
"It doesn't look as if the " D ,PRSO
" is going to fit. But you twist it harder against the narrow " 
D ,CAVE-HOLE ", harder.." ,PCR>
		       	      <ITALICIZE "Thunk.">
			      <TELL 
" The soft wood falls to the bottom of the " D ,PRSI
", filling it with pale light." CR>
		       	      <RTRUE>)>
		       <PRSO-FALLS-DEEP>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-DOWN LOOK-BEHIND
		       LOOK-UNDER>
		<COND (<IN? ,SHARD ,PRSO>
		       <TELL ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " in the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<TOO-DARK-IN-CREVICE>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TELL CTHEO " is too deep." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSO-FALLS-DEEP ()
	 <COND (<AND <PRSO? PARASOL>
		     <IS? ,PRSO ,OPENED>>
		<YOUD-HAVE-TO "close" ,PRSO>
		<RTRUE>)>
	 <TELL CTHEO>
	 <COND (<PRSO? LEM>
		<TELL " has other ideas." CR>
		<RTRUE>)
	       (<G? <GETP ,PRSO ,P?SIZE> 3>
		<TELL " won't fit ">)
	       (T
		<MOVE ,PRSO ,PRSI>
		<TELL " falls deep ">)>
	 <TELL "into the " D ,PRSI ,PERIOD>
	 <RTRUE>>

<OBJECT SKINK
	(DESC "skink")
	(FDESC "A skink is squinting at you from the shadows nearby.")
	(FLAGS NODESC LIVING TAKEABLE CHILLY)
	(SYNONYM SKINK LIZARD REPTILE)
	(ADJECTIVE SCALY)
	(VALUE 3)
	(SIZE 1)
	(MASS 1)
	(ACTION SKINK-F)>

"CHILLY = timing flag for holding, SEEN = just referenced,
 SHADOWY = tried exiting to TUN2, TOUCHED = first seen."

<ROUTINE SKINK-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<UNMAKE ,PRSO ,SEEN>
		<TELL 
"It's a scaly lizard, four inches long, with big eyes and a little pink mouth." CR>
		<RTRUE>)>
	 <MAKE ,SKINK ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE FEED SHOW>
		       <TELL CTHEI " wrinkles its nose." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <COND (<NOT <G? <GETP ,PRSO ,P?SIZE> 3>>
			      <NOT-LIKELY ,PRSO "would affect the skink">
			      <RTRUE>)
			     (<IN? ,PRSI ,PLAYER>
			      <YOUD-HAVE-TO "put down" ,PRSI>
			      <RTRUE>)>
		       <SKINK-SCAMP>
		       <CRLF>
		       <TELL CTHEO>
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? SQUEEZE>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding" ,PRSO>
		       <RTRUE>)>
		<TELL
"The tiny lizard writhes in your grasp and claws at your fingers, its pink mouth gasping for breath. You squeeze harder and harder until your fist trembles with the effort" ,PCR CTHEO " stops squirming." CR>
		<EXIT-SKINK>
		<MOVE ,DSKINK ,PLAYER>
		<SETG P-IT-OBJECT ,DSKINK>
		<COND (<HERE? IN-ORBIT ON-SAT>
		       <MAKE ,DSKINK ,CHILLY>
		       <UPDATE-SCORE 3>)>
		<RTRUE>)
	       (<VERB? KILL MUNG HIT CUT>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <PERFORM ,V?SQUEEZE ,PRSO>
		       <RTRUE>)
		      (<NOT <G? <GETP ,PRSI ,P?SIZE> 3>>
		       <NOT-LIKELY ,PRSI "would affect the skink">
		       <RTRUE>)
		      (<IN? ,PRSO ,PLAYER>
		       <YOUD-HAVE-TO "put down" ,PRSO>
		       <RTRUE>)>
		<SKINK-SCAMP>		
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<EAT-SKINK>
		<RTRUE>)
	       (<VERB? KISS>
		<V-RAPE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO " decides not to respond." CR>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE SKINK-SCAMP ()
	 <TELL CTHE ,SKINK " scampers out of the way." CR>
	 <RTRUE>>

<OBJECT DSKINK
	(DESC "dead skink")
	(FLAGS TAKEABLE TOUCHED)
	(SYNONYM SKINK LIZARD REPTILE)
	(ADJECTIVE SCALY DEAD LIFELESS)
	(VALUE 0)
	(SIZE 1)
	(MASS 1)
	(ACTION DSKINK-F)>

"CHILLY = killed in space."

<ROUTINE DSKINK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Did it just move a little? No; it's quite dead." CR>
		<RTRUE>)
	       (<VERB? KILL SQUEEZE>
		<ITS-ALREADY "dead">
		<RTRUE>)
	       (<VERB? EAT TASTE>
		<EAT-SKINK>
		<RTRUE>)
	       (<VERB? KISS>
		<V-RAPE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EAT-SKINK ()
	 <COND (<DONT-HAVE? ,PRSO>
		<RTRUE>)>
	 <VANISH>
	 <TELL "You jam the ">
	 <COND (<PRSO? SKINK>
		<TELL "squirming ">)>
	 <TELL D ,PRSO
" into your mouth, bite deep and swallow it with a satisfying gulp." CR>
	 <RTRUE>>
		     
<OBJECT HOLLOW
	(LOC OSSUARY)
	(DESC "hollow")
	(FLAGS NODESC)
	(SYNONYM HOLLOW SLOPE SLOPES)
	(ADJECTIVE NATURAL STEEP NAKED)
	(ACTION HOLLOW-F)>

<ROUTINE HOLLOW-F ()
	 <COND (<EXITING?>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-OVER CLIMB-ON>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<HERE-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BONES
	(LOC OSSUARY)
	(DESC "bones")
	(FLAGS NODESC TRYTAKE PLURAL CONTAINER OPENED SURFACE)
	(SYNONYM BONES BONE SKELETONS SKELETON RIB RIBS SKULL SKULLS
	 	 BIT BITS PIECE PIECES PILE PILES FERTILIZER)
	(ADJECTIVE WHITE BLEACHED HUMAN COMPLETE RICH)
	(ACTION BONES-F)>

<ROUTINE BONES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
	        <TELL CTHEO
" are bleached white from years in the sun. They range from bits of rib and skull to complete skeletons." CR>
		<RTRUE>)
	       (<VERB? TAKE LOOK-INSIDE SEARCH LOOK-UNDER LOOK-BEHIND
		       LOOSEN MOVE PUSH PULL RAISE REACH-IN DIG EMPTY>
		<COND (<IS? ,KEY ,NODESC>
		       <UNMAKE ,KEY ,NODESC>
		       <MOVE ,KEY ,OSSUARY>
	 	       <SETG P-IT-OBJECT ,KEY>
	 	       <TELL 
"As you sift dispiritedly through the " D ,PRSO ", a " 
D ,KEY ", still clutched in a long-dead hand, catches your eye." CR>
		       <RTRUE>)>
		<TELL "Further sifting through the " D ,PRSO
" reveals nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TOUCH SQUEEZE KISS SHAKE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO " feel dry and brittle." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " are completely odorless." CR>
		<RTRUE>)
	       (<VERB? HIT KICK KNOCK>
		<TELL "Bones clatter in all " D ,INTDIR "s." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT KEY
	(DESC "skeleton key")
	(FLAGS NODESC TAKEABLE KEYBIT)
	(SYNONYM KEY)
	(ADJECTIVE SKELETON)
	(VALUE 0)
	(SIZE 1)
	(MASS 1)
	(ACTION KEY-F)>

"NODESC = not discovered, CHILLY = point given."

<ROUTINE KEY-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "Its slender form reminds you of a crooked finger." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<ITAKE>
		       <TELL "You gently pry the " D ,PRSO
" out from between the fingers." CR>
		       <UPDATE-SCORE>)>
		<RTRUE>)
	       (<AND <VERB? TURN MOVE>
		     <IN? ,PRSO ,KEYHOLE>>
		<COND (<IS? ,SLOPE ,OPENED>
		       <TELL CTHEO " won't turn anymore." CR>
		       <RTRUE>)>
		<MAKE ,SLOPE ,OPENED>
		<MAKE ,SLOPE ,SEEN>
		<SETG P-IT-OBJECT ,SLOPE>
		<TELL "You slowly twist the key in the hole" ,PCR
		      CTHE ,GROUND 
" under your feet is moving! You leap out of the way, and watch as a hidden slope opens up beneath the keyhole." CR>
		<COND (<NOT <IS? ,PRSO ,CHILLY>>
		       <MAKE ,PRSO ,CHILLY>
		       <UPDATE-SCORE>)>
		<MAKE ,WIGHT ,SEEN>
		<TELL CR CTHE ,WIGHT
		      " stomps its feet and howls with rage." CR>
		<RTRUE>)
	       (<AND <VERB? TURN-TO PUSH-TO TUNE-TO>
		     <IN? ,PRSO ,KEYHOLE>>
		<COND (<PRSI? LEFT RIGHT>
		       <PERFORM ,V?TURN ,PRSO>
		       <RTRUE>)>
		<TELL ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<TELL " the key that way." CR>
		<RTRUE>)
	       (<AND <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		     <IN? ,PRSO ,KEYHOLE>
		     <IS? ,SLOPE ,OPENED>>
		<TELL "The key is firmly locked into place." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HOPENING
	(LOC OSSUARY)
	(DESC "opening")
	(FLAGS NODESC VOWEL CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM OPENING HOLE)
	(ADJECTIVE DARK BLACK)
	(ACTION HOPENING-F)>

<ROUTINE HOPENING-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW>
		       <COND (<OR <EQUAL? ,PRSO ,SHARD>
				  <AND <EQUAL? ,PRSO ,LAMP>
				       <IS? ,PRSO ,LIGHTED>>>
			      <MOVE ,PRSO ,IN-BARROW>)
			     (T
			      <MOVE ,PRSO ,WIGHT>)>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO " disappears into the dark " 
			     D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " leads south." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<TELL "Nothing awful happens." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE EMPTY>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER>>
		<DO-WALK ,P?SOUTH>
	        <RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT SCAF-STAIR
	(LOC LOCAL-GLOBALS)
	(DESC "stairway")
	(FLAGS NODESC)
	(SYNONYM STAIRWAY STAIRS STEPS FLIGHT STAIR)
	(ACTION SCAF-STAIR-F)>

<ROUTINE SCAF-STAIR-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " leads ">
		<COND (<HERE? ON-SCAFFOLD>
		       <TELL "down to the " D ,FLOOR>)
		      (T
		       <TELL "up to the " D ,SCAFFOLD>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,ON-SCAFFOLD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCAFFOLD
	(LOC LOCAL-GLOBALS)
	(DESC "scaffold")
	(FLAGS NODESC)
	(SYNONYM SCAFFOLD PLATFORM UPSTAIRS)
	(ACTION SCAFFOLD-F)>

<ROUTINE SCAFFOLD-F ("AUX" (ON <>))
	 <COND (<HERE? ON-SCAFFOLD>
		<SET ON T>)>
	 <COND (<VERB? EXAMINE LOOK-ON LOOK>
		<COND (<T? .ON>
		       <V-LOOK>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-UP CLIMB-ON CLIMB-OVER STAND-ON>>
		<COND (<ZERO? .ON>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<ALREADY-IN ,SCAFFOLD T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<ZERO? .ON>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<NOT-IN ,SCAFFOLD T>
		<RTRUE>)
	       (<VERB? LOOK-UNDER STAND-UNDER>
		<TELL "There's nothing " <PICK-NEXT ,YAWNS>
		      " under there." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MIKE
	(LOC LOCAL-GLOBALS)
	(DESC "equipment")
	(FLAGS NODESC PLURAL VOWEL TRYTAKE NOALL)
	(SYNONYM CONGLOMER EQUIPMENT MACHINERY MACHINES PIPES TANKS PIPE TANK
	 	 VALVE VALVES COMPRESSOR BOMB WARNINGS WARNING)
	(ADJECTIVE MONSTROUS PRESSURE STORAGE LARGE HUGE LIQUID HYDROGEN)
	(ACTION MIKE-F)>

<ROUTINE MIKE-F ()
	 <COND (<HANDLE-BOMB?>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-DOWN LOOK-UP READ>
		<READ-UBOMB>
		<RTRUE>)
	       (<ENTERING?>
		<DO-WALK <COND (<HERE? ON-SCAFFOLD> ,P?IN)
			       (T ,P?UP)>>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? ON-SCAFFOLD>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	
<OBJECT RWALLS
	(LOC LOCAL-GLOBALS)
	(DESC "rock walls")
	(FLAGS NODESC PLURAL)
	(SYNONYM WALLS WALL ROCK STONE RUT RUTS SPIRALS)
	(ADJECTIVE ROCK STONE ROUTED DEEP SPIRAL RUTTED)
	(ACTION RWALLS-F)>

<ROUTINE RWALLS-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE LOOK-BEHIND SEARCH>
		<LOOK-AT-RWALLS>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		        
<OBJECT CAGE
	(LOC IN-COTTAGE)
	(DESC "birdcage")
	(FLAGS TAKEABLE CONTAINER TRANSPARENT OPENABLE)
	(SYNONYM CAGE BIRDCAGE WICKER)
	(ADJECTIVE BIRD WICKER BROWN YELLOW)
	(SIZE 10)
	(CAPACITY 8)
	(VALUE 1)
	(MASS 6)
	(GENERIC GENERIC-DOOR-F)
	(CONTFCN IN-CAGE)
	(ACTION CAGE-F)>

<ROUTINE IN-CAGE ("OPTIONAL" (CONTEXT <>))
	 <COND (<OR <NOT <EQUAL? .CONTEXT ,M-CONT>>
		    <IS? ,CAGE ,OPENED>>
		<RFALSE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,HURTVERBS ,NHVERBS>>
		<YOUD-HAVE-TO "open" ,CAGE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CAGE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <YOUD-HAVE-TO "open" ,PRSI>
			      <RTRUE>)
			     (<PRSO? MEEP>
			      <MAKE ,PRSO ,TOUCHED>
			      <MOVE ,PRSO ,PRSI>
			      <TELL ,CTHEMEEP "pecks furiously at " D ,HANDS
", but you grit your teeth and stuff the protesting bird into the cage." CR>
			      <RTRUE>)
			     (<PRSO? LEM>
			      <MOVE ,PRSO ,PRSI>
			      <TELL CTHEO 
" sinks its teeth into your thumb when it sees the cage. But you jam it inside anyway." CR>
		       	      <COND (<NOT <IS? ,PRSI ,BORING>>
				     <MAKE ,PRSI ,BORING>
				     <UPDATE-SCORE>)>
			      <RTRUE>)
			     (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <PRSO-WONT-FIT>)
			     (T
			      <MOVE ,PRSO ,PRSI>
			      <TELL "You put " THEO " into " THEI ,PERIOD>)>
		       
		       <COND (<AND <PRSO? BAG>
				   <T? ,CCNT>
				   <IN? ,MEEP ,HERE>>
			      <UNMAKE ,BAG ,SEEN>
			      <MEEP-SEES-BAG>)>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The">
		<OPEN-CLOSED ,PRSO>
		<TELL " is cunningly woven of brown and yellow wicker">
		<COND (<SEE-ANYTHING-IN? ,PRSO>
		       <TELL ". Peering between the slats, you see ">
		       <PRINT-CONTENTS ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,PRSO ,OPENED>
		<UNMAKE ,LEM ,CHILLY>
		<TELL "You open the " D ,PRSO ,PERIOD>
		<COND (<AND <IN? ,MAGPIE ,PRSO>
			    <T? ,LIT?>>
		       <TELL CR CTHE ,MAGPIE " flutters out of the cage and ">
         	       <COND (<T? ,SUITED?>
			      <FREE-MAG ,FILM>
			      <RTRUE>)
			     (<AND <HERE? IN-CLOSET>
				   <NOT <IS? ,CLOSET-DOOR ,OPENED>>>
			      <FREE-MAG ,CLOSET>
			      <RTRUE>)
			     (<HERE? IN-COTTAGE>
			      <COND (<OR <IS? ,COTTAGE-DOOR ,OPENED>
					 <IS? ,GARDEN-DOOR ,OPENED>>
				     <EXIT-MAGPIE>
				     <TELL "soars through the open door." CR>
				     <RTRUE>)>
			      <FREE-MAG ,COTTAGE>
			      <RTRUE>)>
		       <TELL "soars" ,OUTASITE>
		       <EXIT-MAGPIE>
		       <RTRUE>)
		      (<IN? ,LEM ,PRSO>
		       <UNMAKE ,LEM ,SEEN>
		       <I-LEM>
		       <RTRUE>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       		       
<ROUTINE FREE-MAG (OBJ)
	 <UNMAKE ,CAGE ,OPENED>
	 <TELL "circles around the inside of the " D .OBJ 
". After considerable effort, you manage to stuff it back in the cage and slam the door shut." CR>
	 <RTRUE>>

<OBJECT MAGPIE
	(LOC CAGE)
	(DESC "magpie")
	(FLAGS TRYTAKE LIVING)
	(SYNONYM MAGPIE BIRD)
	(ADJECTIVE BLACK)
	(GENERIC GENERIC-BIRD-F)
	(ACTION MAGPIE-F)>

"SEEN = magpie just referenced, TOUCHED = stools discovered."

<ROUTINE MAGPIE-F ()
	 <MAKE ,MAGPIE ,SEEN> ; "Prevents I-MAGPIE after any reference."
	 <COND (<THIS-PRSI?>
		<COND (<VERB? FEED GIVE SHOW>
		       <TELL CTHEI <PICK-NEXT <GET ,PIE-TABLE 2>>
			     ", but shows no interest." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"Its sharp little eyes stare back at you suspiciously." CR>
		<RTRUE>)
	       (<VERB? WATCH LISTEN>
		<UNMAKE ,PRSO ,SEEN>
		<I-MAGPIE <>>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<COND (<T? ,INLEN>
		       <TELL "\"">
		       <COND (<PROB 50>
			      <TELL "Awk! ">)>
		       <PRINT-SENTENCE>
		       <TELL "!">
		       <COND (<PROB 50>
			      <TELL " Awk!">)>
		       <TELL "\"" CR>
		       <RFATAL>)>
		<TELL CTHEO <PICK-NEXT <GET ,PIE-TABLE 2>>
		      ", pretending not to understand." CR>
		<RFATAL>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,HURTVERBS ,NHVERBS>>
		<TELL CTHEO " won't let you near." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT CAULDRON
	(LOC IN-COTTAGE)
	(DESC "cauldron")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENED OPENABLE FERRIC)
	(CAPACITY 10)
	(SYNONYM CAULDRON POT VAT DEPTHS BRIM SIDES SIDE STENCH)
	(ADJECTIVE METAL CAST IRON MASSIVE HEAVY LARGE HUGE BIG CRUSTY)
	(ACTION CAULDRON-F)>

<ROUTINE CAULDRON-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? HOLD-OVER EMPTY-INTO>
			    <PRSO? OCOCO MILK>
			    <T? ,DRIBBLE>>
		       <HOLD-OCOCO-OVER-CAULDRON>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON THROW>
		       <COND (<AND <PRSO? PARASOL>
				   <IS? ,PRSO ,OPENED>>
			      <UNMAKE ,PRSO ,OPENED>
			      <TELL "[closing the " D ,PRSO " first"
				    ,BRACKET>)>
		       <COND (<NOT <IS? ,EMERALD ,NODESC>>
			      <RFALSE>)
			     (<PRSO? HANDS>
			      <TOUCH-CWATER>
			      <RTRUE>)
			     (<AND <PRSO? MILK>
				   <T? ,DRIBBLE>>
			      <HOLD-OCOCO-OVER-CAULDRON>
			      <RTRUE>)>
		       <VANISH>
		       <TELL CTHEO
" disappears into the " D ,PRSI " in a greasy puff of steam">
		       <COND (<PRSO? PARASOL SPADE>
			      <TELL "; a startling result, for "
				    THEO " was longer than the " D ,PRSI
				    " is deep." CR>
			      <RTRUE>)
			     (<AND <PRSO? OCOCO>
				   <T? ,DRIBBLE>>
			      <KILL-MILK>
			      <UPDATE-RECIPE>
			      <RTRUE>)
			     (<OR <PRSO? GARLIC>
				  <AND <PRSO? DSKINK>
				       <IS? ,PRSO ,CHILLY>>>
			      <UPDATE-RECIPE>
			      <RTRUE>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<IS? ,EMERALD ,NODESC>
		       <TELL 
"White " D ,STEAM " writhe mysteriously from " THEO "'s depths." CR>
		       <RTRUE>)>
		<TELL 
"Your amateur conjuring doesn't seem to have damaged " THEO " very much." CR> 
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<IS? ,EMERALD ,NODESC>
		       <TELL CTHEO
" is filled to the brim with dark, " D ,CWATER ,PERIOD>
		       <RTRUE>)>
		<UNMAKE ,EMERALD ,NOALL>
		<RFALSE>)
	       (<VERB? REACH-IN>
		<COND (<IS? ,EMERALD ,NODESC>
		       <TOUCH-CWATER>
		       <RTRUE>)>
		<UNMAKE ,EMERALD ,NOALL>
		<RFALSE>)
	       (<AND <VERB? TOUCH KNOCK SHAKE KISS SQUEEZE EMPTY>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,EMERALD ,NODESC>>
		<TELL "The sides of the " D ,PRSO 
		      " are uncomfortably warm." CR>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER PUT-UNDER>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL CTHEO  
" probably weighs several hundred pounds." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SWIM DIVE>>
	        <TELL "That'd be a tight squeeze." CR>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? SMELL>
		<COND (<IS? ,EMERALD ,NODESC>
		       <SMELL-CWATER>
		       <RTRUE>)>
		<TELL CTHEO " fills the " D ,COTTAGE
		      " with the odor of burned grease." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HOLD-OCOCO-OVER-CAULDRON ()
	 <KILL-MILK>		
	 <TELL "You hold the " D ,OCOCO " over the " D ,CAULDRON ".|
|
The last few drops of milk dribble into the " D ,CWATER>		
	 <UPDATE-RECIPE>
	 <RTRUE>>

<GLOBAL INGREDIENTS:NUMBER 4>

<ROUTINE UPDATE-RECIPE ()
	 <PRINT ,PERIOD>
	 <DEC INGREDIENTS>
	 <COND (<ZERO? ,INGREDIENTS>
		<QUEUE I-EXPLODE -1>
		<TELL CR CTHE ,CAULDRON
" begins to bubble and fume more furiously than ever. Steam fills the " 
D ,COTTAGE " in a thick, oily cloud; and an ominous rumbling sound begins to rise from the " D ,CAULDRON "'s depths." CR>)>
         <UPDATE-SCORE>
	 <RTRUE>>

<OBJECT STEAM
	(LOC IN-COTTAGE)
	(DESC "coils of steam")
	(FLAGS NODESC PLURAL)
	(SYNONYM CLOUD CLOUDS STEAM VAPOR COIL COILS SHAPES)
	(ADJECTIVE WHITE WET DAMP HOT WARM GREASY UNSPEAKABLE)
	(ACTION STEAM-F)>

<ROUTINE STEAM-F ()
	 <COND (<VERB? SMELL INHALE>
		<WET-AND-OILY " smell">
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH BLOW-INTO>
		<TELL CTHEO
" twist in unspeakable shapes as they rise out of the " D ,CAULDRON ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? TOUCH REACH-IN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<WET-AND-OILY " feel">
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WET-AND-OILY (STR)
	 <TELL CTHEO .STR " hot and greasy." CR>
	 <RTRUE>>

<OBJECT CWATER
	(LOC CAULDRON)
	(DESC "boiling liquid")
	(FLAGS NODESC TRYTAKE NOALL WATERY)
	(SYNONYM WATER FLUID LIQUID BUBBLES)
	(ADJECTIVE OILY PUTRID BOILING BUBBLING)
	(GENERIC GENERIC-LIQUID-F)
	(ACTION CWATER-F)>

<ROUTINE CWATER-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<OPAQUE-WATER>
		<RTRUE>)
	       (<VERB? DRINK TASTE>
		<TELL "You scald your tongue on the " D ,PRSO
		      ". Ouch!" CR>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<SMELL-CWATER>
		<RTRUE>)
	       (<AND <THIS-PRSI?>
		     <VERB? PUT PUT-ON THROW EMPTY-INTO HOLD-OVER>>
		<PERFORM ,PRSA ,PRSO ,CAULDRON>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TOUCH-CWATER>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       		
<ROUTINE SMELL-CWATER ()
	 <TELL "The hot, greasy odor makes your head spin." CR>
	 <RTRUE>>

<ROUTINE TOUCH-CWATER ()
	 <TELL "You plunge " D ,HANDS " into the " D ,CWATER ". Ouch!" CR>
	 <COND (<IN? ,HONEY ,PLAYER>
		<EXIT-HONEY>
		<UPDATE-RECIPE>)>
	 <RTRUE>>
	
<ROUTINE EXIT-HONEY ()
	 <VANISH ,HONEY>
	 <TELL CR "At least you got that honey off your fingers">
	 <RTRUE>>

<OBJECT DORY
	(DESC "dory")
	(FLAGS CONTAINER OPENED)
	(SYNONYM DORY BOAT CANOE DUGOUT SHIP VESSEL)
	(ADJECTIVE WOOD WOODEN LARGE BIG HUGE)
	(CAPACITY 100)
	(ACTION DORY-F)>

"NODESC = started, TOUCHED = beached."

<GLOBAL IN-DORY?:FLAG <>>
		
<ROUTINE DORY-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PERFORM ,V?GIVE ,PRSO ,CHARON>
		       <RTRUE>)
		      (<AND <NOT <IS? ,DORY ,TOUCHED>>
			    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO " is quite large, and of ancient design." CR>
		<RTRUE>)
	       (<VERB? WATCH>
		<I-STYX <>>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-ON SEARCH>
		<MAKE ,CHARON ,TOUCHED>
		<TELL ,YOU-SEE "a dark " D ,CHARON
		      " standing at the vessel's stern">
		<COND (<IN? ,SHADES ,DORY>
		       <TELL ,PTHE "deck is nearly filled with silent "
			     D ,SHADES>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? RIDE CLIMB-ON CLIMB-UP CLIMB-OVER STAND-ON SIT>>
		<GET-IN-DORY>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? ,IN-DORY?>
		       <NOT-IN>
		       <RTRUE>)>
		<EXIT-DORY>
		<TELL "You clamber out of the dory." CR>
		<RTRUE>) 
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <NOT <IS? ,DORY ,TOUCHED>>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXIT-DORY ()
	 <SETG PATIENCE 3>
	 <DEQUEUE I-CHARON>
	 <SETG IN-DORY? <>>
	 <SETG OLD-HERE <>>
	 <RTRUE>>

<ROUTINE DORY-IN ()
	 <COND (<IN? ,DORY ,HERE>
		<TELL "[into the dory" ,BRACKET>
		<GET-IN-DORY>
		<RFALSE>)>
	 <WHICH-WAY-IN>
	 <RFALSE>>

<ROUTINE GET-IN-DORY ()
	 <COND (<T? ,IN-DORY?>
		<ALREADY-IN ,DORY>
		<RTRUE>)
	       (<NOT <IS? ,DORY ,TOUCHED>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<HERE? ON-BEACH>
		<TELL CTHE ,CHARON
" shakes his head (a bit sadly, perhaps), and pushes you away from the dory." CR>
		<RTRUE>)>
	  <SETG IN-DORY? T>
	  <SETG OLD-HERE <>>
	  <TELL CTHE ,DORY " tips alarmingly as you climb aboard">
	  <COND (<EQUAL? ,STICKS 4 5>
		<TELL "; one of the " D ,SHADES " is nearly thrown out">)>
	  <TELL ".|
|
The " D ,CHARON>
	  <COND (<OR <NOT <IN? ,SHROUD ,PLAYER>>
		     <NOT <IS? ,SHROUD ,WORN>>>
		 <SETG IN-DORY? <>>
		 <SETG OLD-HERE <>>
		 <COND (<IS? ,CHARON ,NOALL>
		        <TELL 
" recognizes your vacation shorts and kicks you off his dory again." CR>
			<RTRUE>)>
		 <MAKE ,CHARON ,NOALL>
		 <TELL " stares at your " D ,LONDON 
" vacation shorts with barely concealed outrage. He makes a broad gesture with his oar, inviting you to debark at your earliest convenience; a well-placed kick sends you on your way." CR>
		 <RTRUE>)>
	   <SETG PATIENCE 3>
	   <QUEUE I-CHARON -1>		
	   <TELL " glances at the " D ,SHROUD 
" you're wearing with silent approval, and stretches out his skeletal hand expectantly." CR>
	   <RTRUE>>
	  
<OBJECT SHADES
	(DESC "shades")
	(FLAGS NODESC PLURAL LIVING TRYTAKE NOALL)
	(SYNONYM SHADE SHADES GHOST GHOSTS SPIRIT SPIRITS APPARITION
	 	 SHADOWS FORM FORMS HUMANS)
	(ADJECTIVE GHOSTLY HUMAN SHROUDED)
	(ACTION SHADES-F)>

"TOUCHED = shades' cargo noticed."

<ROUTINE SHADES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <MOVE ,PRSO ,HERE>
		       <TELL CTHEO " passes right through one of the "
			     D ,PRSI " and lands on the " D ,BEACH ,PERIOD>
		       <RTRUE>)
		      (<VERB? GIVE SHOW FEED>
		       <TELL "You ">
		       <COND (<VERB? SHOW>
			      <TELL "show ">)
			     (T
			      <TELL "offer ">)>
		       <TELL THEO " to one of the " D ,PRSI
			     ". It gives you a look of pity, but ">
		       <COND (<VERB? SHOW>
			      <TELL "remains silent." CR>
			      <RTRUE>)>
		       <TELL "refuses to accept it." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL "The shrouded forms ">
		<COND (<IN? ,PRSO ,DORY>
		       <TELL "in the dory">)
		      (T
		       <TELL "on the beach">)>
		<TELL " are stooped and emaciated, their sunken eyes dark with inscrutable emotions." CR>
		<RTRUE>)  
	       (<AND <VERB? TOUCH SQUEEZE SHAKE KNOCK HIT MUNG CUT RIP KICK
			    TURN PUSH PULL MOVE PUSH-TO REACH-IN TAKE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<AND <ZERO? ,IN-DORY?>
		     	    <G? ,STICKS 4>>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<OR <VERB? KICK>
			   <PRSI? FEET>>
		       <TELL "Your foot">)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL "Your hand">)		      
		      (T
		       <TELL CTHEI>)>
		<TELL " encounters nothing but vapor." CR>
		<RTRUE>)
	       (<VERB? WAVE-AT BOW>
		<TELL ,ONE-SHADE "sadly mimics you." CR>
		<RTRUE>)
	       (<VERB? KISS>
		<TELL ,ONE-SHADE "looks at you wistfully." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL ,ONE-SHADE "turns at the " D ,SOUND 
" of your voice. It gives you a reproachful look and lifts a skeletal finger to its lips." CR>
		<RFATAL>)
	       (<VERB? WATCH>
		<I-STYX <>>
		<RTRUE>)
	       (T
		<RFALSE>)>>		        
	       
<OBJECT STYX
	(LOC LOCAL-GLOBALS)
	(DESC "river")
	(FLAGS WATERY NODESC TRYTAKE NOALL)
	(SYNONYM RIVER STYX ACHERON WATER CURRENT)
	(ADJECTIVE RIVER)
	(GENERIC GENERIC-RIVER-F)
	(ACTION STYX-F)>

"CHILLY = referenced by name."

<ROUTINE STYX-F ()
	 <COND (<AND <NOUN-USED? ,W?STYX ,W?ACHERON>
		     <NOT <IS? ,STYX ,CHILLY>>>
		<MAKE ,STYX ,CHILLY>
		<VOICE-MUTTERS "Show-off">)>
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <VANISH>
		       <TELL "Splash! " CTHEO>
		       <COND (<OR <PRSO? OCRANE BAD-CRANE>
				  <AND <PRSO? PARASOL>
				       <IS? ,PRSO ,OPENED>>>
			      <TELL " floats away across ">)
			     (T
			      <TELL " disappears into ">)>
		       <TELL "the dark water." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<OPAQUE-WATER>
		<RTRUE>)
	       (<NOT-CLEAN?>
		<RTRUE>)
	       (<DO-WATER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
				
<OBJECT MBOX
	(LOC AT-SDOORS)
	(DESC "box")
	(FLAGS NODESC CONTAINER OPENABLE)
	(CAPACITY 5)
	(SYNONYM BOX SWITCHBOX)
	(ADJECTIVE SMALL TINY LITTLE)
	(ACTION MBOX-F)>

<ROUTINE MBOX-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW>
		       <TELL CTHEO " would probably fall right out." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<IS? ,PRSO ,OPENED>
		       <LOOK-IN-MBOX>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<SWING-BOX>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<IS? ,PRSO ,OPENED>
		       <SWING-BOX>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-IN-MBOX ()
	 <TELL "A " D ,TSWITCH " and a " D ,IBUTTON 
	       " are mounted inside." CR>
	 <RTRUE>>

<ROUTINE SWING-BOX ()
	 <TELL "You swing the box ">
	 <COND (<IS? ,PRSO ,OPENED>
		<UNMAKE ,PRSO ,OPENED>
		<TELL "shut." CR>
		<RTRUE>)>
	 <MAKE ,PRSO ,OPENED>
	 <TELL "open" ,PCR>
	 <LOOK-IN-MBOX>
	 <RTRUE>>

<OBJECT TSWITCH
	(LOC MBOX)
	(DESC "toggle switch")
	(FLAGS NODESC TRYTAKE NOALL OPENED READABLE)
	(SYNONYM SWITCH LETTERS)
	(ADJECTIVE TOGGLE PA)
	(ACTION TSWITCH-F)>

<ROUTINE TSWITCH-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " is turned ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "off">)
		      (T
		       <TELL "on">)>
		<TELL 
,PTHE "letters \"P\" and \"A\" are scrawled underneath." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF OPEN OPEN-WITH RAISE PULL>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <ALREADY-SWITCHED>
		       <RTRUE>)>
		<FLIP-SWITCH>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON CLOSE PUSH LOWER>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <FLIP-SWITCH>
		       <RTRUE>)>
		<ALREADY-SWITCHED>
		<RTRUE>)
	       (<AND <VERB? TURN USE TOUCH MOVE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<FLIP-SWITCH>
		<RTRUE>)
	       (<HANDLE-SWITCH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>		       
		
<ROUTINE FLIP-SWITCH ()
	 <TELL "You turn ">
	 <COND (<IS? ,TSWITCH ,OPENED>
		<UNMAKE ,TSWITCH ,OPENED>
		<TELL "on">)
	       (T
		<MAKE ,TSWITCH ,OPENED>
		<TELL "off">)>
	 <TELL " the " D ,TSWITCH ".|
|
The " D ,SPEAKER " emits a burst of static, then ">
	 <COND (<IS? ,TSWITCH ,OPENED>
		<TELL "falls silent." CR>
		<RTRUE>)>
	 <TELL "a steady hiss." CR>
	 <RTRUE>>

<ROUTINE ALREADY-SWITCHED ()
	 <TELL CTHEO " is already turned o">
	 <COND (<IS? ,PRSO ,OPENED>
		<TELL "ff." CR>
		<RTRUE>)>
	 <TELL "n." CR>
	 <RTRUE>>

<OBJECT IBUTTON
	(LOC MBOX)
	(DESC "red button")
	(FLAGS NODESC TRYTAKE NOALL OPENED READABLE)
	(SYNONYM PUSHBUTTON BUTTON)
	(ADJECTIVE RED CRIMSON GULES)
	(GENERIC GENERIC-BUTTON-F)
	(ACTION BUTTON-F)>

<OBJECT OBUTTON
	(LOC SSAND)
	(DESC "red button")
	(FLAGS NODESC TRYTAKE NOALL OPENED READABLE)
	(SYNONYM PUSHBUTTON BUTTON)
	(ADJECTIVE RED CRIMSON GULES)
	(GENERIC GENERIC-BUTTON-F)
	(ACTION BUTTON-F)>

<ROUTINE GENERIC-BUTTON-F (TABLE)
	 <COND (<OR <EQUAL? ,P-IT-OBJECT ,WBUTTON ,WTK ,ANTENNA>
		    <EQUAL? ,P-IT-OBJECT ,WSWITCH ,SLIDER>>
		<RETURN ,WBUTTON>)
	       (<EQUAL? ,P-IT-OBJECT ,IBUTTON ,MBOX>
		<RETURN ,IBUTTON>)
	       (<EQUAL? ,P-IT-OBJECT ,OBUTTON>
		<RETURN ,P-IT-OBJECT>)
	       (T
		<RFALSE>)>>

<ROUTINE BUTTON-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " isn't labeled." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF LAMP-ON OPEN OPEN-WITH CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO 
" has no ON or OFF position. All you can do is push it." CR>
		<RTRUE>)
	       (<AND <VERB? PUSH TOUCH MOVE USE LOWER>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<SETG P-THEM-OBJECT ,SDOORS>
	 	<TELL "You push the " D ,PRSO ".|
|
With an electric whirr, the heavy doors slide ">
	 	<COND (<IS? ,SDOORS ,OPENED>
		       <UNMAKE ,SDOORS ,OPENED>
		       <TELL "shut." CR>
		       <RTRUE>)>
		<MAKE ,SDOORS ,OPENED>
		<TELL "open." CR>
		<RTRUE>)
	       (<HANDLE-SWITCH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>		 

<ROUTINE HANDLE-SWITCH? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (<VERB? MUNG KICK CUT RIP SHAKE>
		<TELL "These military " D ,TSWITCH
	       	      "es are built to resist such abuse." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT SDOORS
	(LOC LOCAL-GLOBALS)
	(DESC "sliding doors")
	(FLAGS NODESC DOORLIKE OPENABLE PLURAL)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE SLIDING)
	(ACTION SDOORS-F)>

<ROUTINE SDOORS-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The">
		<OPEN-CLOSED ,PRSO>
		<TELL " are tall and massive." CR>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK-INSIDE LOOK-OUTSIDE>
	        <COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<OR <AND <VERB? OPEN OPEN-WITH>
			 <EQUAL? ,PRSI <> ,HANDS>
			 <NOT <IS? ,PRSO ,OPENED>>>
		    <AND <VERB? CLOSE>
			 <EQUAL? ,PRSI <> ,HANDS>
			 <IS? ,PRSO ,OPENED>>
		    <VERB? MOVE PUSH PULL LOOSEN SHAKE>>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SPEAKER
	(LOC LOCAL-GLOBALS)
	(DESC "loudspeaker")
	(FLAGS NODESC TRYTAKE NOALL FERRIC)
	(SYNONYM SPEAKER LOUDSPEAKER SYSTEM ADDRESS VOICE VOICES STATIC HISS)
	(ADJECTIVE LOUD PA P\.A\. PUBLIC ADDRESS)
	(ACTION SPEAKER-F)> 

<ROUTINE SPEAKER-F ()
	 <COND (<AND <VERB? LISTEN>
		     <NOT <IS? ,TSWITCH ,OPENED>>>
		<TELL CTHEO <PICK-NEXT ,HISSES> ,PERIOD>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<HERE? AT-SDOORS>
		       <TELL "It's an ordinary " D ,PRSO
		      	     "; a bit old-fashioned, perhaps." CR>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<AND <HERE? ON-SCAFFOLD>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? LAMP-ON LAMP-OFF>
		<HOW?>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LSPEAKERS
	(LOC LOCAL-GLOBALS)
	(DESC "loudspeakers")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM SPEAKERS LOUDSPEAKER HORN HORNS SYSTEM)
	(ADJECTIVE LOUD PA P\.A\.)
	(ACTION LSPEAKERS-F)>

<ROUTINE LSPEAKERS-F ("AUX" STR)
	 <COND (<AND <VERB? LISTEN>
		     <NOT <IS? ,TSWITCH ,OPENED>>>
		<TELL CTHEO " click and hiss." CR>
		<RTRUE>)
	       (<OR <VERB? EXAMINE LOOK-INSIDE SEARCH>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-REACH ,LSPEAKERS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT ESHED
	(LOC LOCAL-GLOBALS)
	(DESC "equipment shed")
	(FLAGS NODESC VOWEL)
	(SYNONYM SHED BUILDING STRUCTURE)
	(ADJECTIVE EQUIPMENT METAL)
	(ACTION ESHED-F)>

<ROUTINE ESHED-F ("AUX" (IN <>))
	 <COND (<HERE? AT-SDOORS ON-SCAFFOLD>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE>
		<COND (<ZERO? .IN>
		       <TELL CTHEO
" stands in silhouette against the red morning." CR>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<HERE? SSAND>
		       <COND (<IS? ,SDOORS ,OPENED>
			      <CANT-SEE-MUCH>
			      <RTRUE>)>
		       <ITS-CLOSED ,SDOORS>
		       <RTRUE>)
		      (<ZERO? .IN>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT LAGOON
	(LOC LOCAL-GLOBALS)
	(DESC "lagoon")
	(FLAGS WATERY NODESC)
	(SYNONYM LAGOON WATER WATERS TIDE SEA OCEAN LIQUID OFFSHORE
	 	 WAVE WAVES)
	(ACTION LAGOON-F)>

"SEEN = Burns quoted."

<ROUTINE LAGOON-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<IN? ,FLIPPER ,HERE>
			      <TELL "You throw " THEO
				    " out over the " D ,PRSI ,PERIOD>
			      <THROW-PRSO-AT-FLIPPER>
			      <RTRUE>)>
		       <VANISH>
		       <TELL CTHEO>
		       <COND (<OR <PRSO? OCRANE BAD-CRANE>
				  <AND <PRSO? PARASOL>
				       <IS? ,PRSO ,OPENED>>>
			      <TELL " floats away across the " D ,PRSI
				    "; it's soon" ,OUTASITE>
			      <RTRUE>)>
		       <TELL " sinks beneath the water." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL "The tide is slowly rising." CR>  
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-ON SEARCH LOOK-BEHIND>
		<TELL
"Little can be seen in the fiery reflections on the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SWIM DIVE CROSS CLIMB-OVER CLIMB-ON LIE-DOWN SIT>>
		<COND (<HERE? WSAND>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<LAGOON-SWIMMING>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<AND <VERB? TOUCH KISS REACH-IN SHAKE SQUEEZE KICK>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "The tropical water feels warm." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM TASTE>
		<TELL "Ugh! Too salty." CR>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " smells fresh and salty." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "You hear the distant roar of surf." CR>
		<RTRUE>)
	       (<VERB? FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ISLAND
	(LOC LOCAL-GLOBALS)
	(DESC "island")
	(FLAGS NODESC VOWEL)
	(SYNONYM ISLE ISLAND ELUGELAB ATOLL ENIWETOK)
	(ADJECTIVE TROPICAL)
	(ACTION ISLAND-F)>

"CHILLY = referenced by name."

<ROUTINE ISLAND-F ()
	 <COND (<AND <NOT <IS? ,ISLAND ,CHILLY>>
		     <NOUN-USED? ,W?ELUGELAB ,W?ENIWETOK>>
		<MAKE ,ISLAND ,CHILLY>
		<VOICE-MUTTERS "Impressive">)>
	 <COND (<VERB? EXAMINE LOOK-ON SEARCH>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-ON CLIMB-ON>>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CROSS FOLLOW CLIMB-DOWN CLIMB-UP>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ISLET
	(LOC WSAND)
	(DESC "islet")
	(FLAGS NODESC VOWEL SURFACE)
	(SYNONYM ISLET ISLE ISLAND END)
	(ADJECTIVE SMALL TINY LITTLE SHRINKING BARREN CRESCENT)
	(CAPACITY 100)
	(CONTFCN IN-ISLET)
	(ACTION ISLET-F)>

<ROUTINE IN-ISLET ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<AND <VERB? WALK-TO SWIM>
		     <HERE? WSAND>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<VERB? THROW THROW-OVER>
		<RFALSE>)
	       (<NOT <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ISLET-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH WATCH>
		<TELL CTHEO 
" is just a barren crescent of sand, gradually shrinking away in the rising tide.|
|
A lone " D ,CTREE " stands near one end of the " D ,PRSO>
		<COND (<IN? ,COCO ,PRSO>
		       <TELL ". There's a " D ,COCO 
			     " lying under the tree">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SWIM DIVE FOLLOW CROSS CLIMB-ON CLIMB-UP
			   CLIMB-OVER>>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT CTREE
	(LOC ISLET)
	(DESC "coconut tree")
	(FLAGS NODESC SURFACE)
	(CAPACITY 100)
	(SYNONYM TREE)
	(ADJECTIVE COCONUT NUT LONE)
	(CONTFCN IN-ISLET)
	(ACTION CTREE-F)>

<ROUTINE CTREE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <PERFORM ,PRSA ,PRSO ,LAGOON>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<TELL "The tree is heavy with " D ,NUTS ,PERIOD>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NUTS
	(LOC LOCAL-GLOBALS)
	(DESC "coconuts")
	(FLAGS TRYTAKE PLURAL NOALL)
	(SYNONYM COCONUTS COCONUT NUTS NUT)
	(ADJECTIVE BROWN RIPE PLUMP JUICY)
	(GENERIC GENERIC-COCO-F)
	(ACTION NUTS-F)>

<ROUTINE NUTS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <PERFORM ,PRSA ,PRSO ,LAGOON>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO " in the tree look plump and juicy." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<RFALSE>)
	       (<VERB? WALK-TO SWIM>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT COCO
	(DESC "coconut")
	(FLAGS NODESC NOALL)
	(SYNONYM COCONUT NUT COCOANUT SHELL)
	(ADJECTIVE BROWN RIPE PLUMP JUICY)
	(VALUE 3)
	(SIZE 5)
	(MASS 4)
	(DESCFCN 0)
	(GENERIC GENERIC-COCO-F)
	(ACTION COCO-F)>

<ROUTINE GENERIC-COCO-F (TBL)
	 <COND (<LOC ,COCO>
		<RETURN ,COCO>)>
	 <RETURN ,OCOCO>>

"TRYTAKE = coco fallen & out of reach, CHILLY = floating."

<ROUTINE DESCRIBE-COCO ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A " D ,COCO " is floating in the " D ,LAGOON>
		<PRINTC 46>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE COCO-F ()
	 <COND ; (<AND <VERB? POINT>
		       <VISIBLE? ,FLIPPER>>
		  <SHOW-TO-FLIPPER ,PRSO>
		  <RTRUE>)
	       (<THIS-PRSI?>
		<COND (<AND <VERB? THROW THROW-OVER>
			    <IS? ,PRSI ,TRYTAKE>>
		       <PERFORM ,PRSA ,PRSO ,LAGOON>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <IS? ,COCO ,TRYTAKE>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		     <INTBL? ,PRSA ,HURTVERBS ,NHVERBS>>
		<TELL ,CANT "reach the " D ,COCO " from here." CR>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO>
		<COND (<IN? ,PRSO ,ISLET>
		       <TELL " under the tree">)
		      (<IS? ,PRSO ,CHILLY>
		       <TELL " floating in the water">)>
		<TELL " looks especially plump and juicy." CR>
		<RTRUE>)
	       (<VERB? CUT RIP HIT MUNG OPEN OPEN-WITH>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? AXE LUMP SPADE>
		       <COND (<IN? ,PRSO ,PLAYER>
			      <TELL "While holding the " D ,PRSO
				    "? Unwise." CR>
			      <RTRUE>)>
		       <MOVE ,OCOCO <LOC ,PRSO>>
		       <MOVE ,MILK <LOC ,OCOCO>>
		       <REMOVE ,PRSO>
		       <SETG P-IT-OBJECT ,OCOCO>
		       <SETG DRIBBLE 3>
		       <QUEUE I-MILK -1>
		       <TELL "You deal the " D ,PRSO " a mortal blow with "
			     THEI ,PCR>
		       <SAY-MILK>
		       <UPDATE-SCORE>
		       <RTRUE>)
		      (<VERB? HIT>
		       <DULL-THUD>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would affect the coconut">
		<RTRUE>)
	       (<VERB? SHAKE>
		<TELL "You hear liquid slooshing around inside." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-MILK ()
	 <SETG P-IT-OBJECT ,MILK>
	 <TELL "Pale " D ,MILK " dribbles out of a crack in the shell." CR>
	 <RTRUE>>

<OBJECT OCOCO
	(DESC "cracked coconut")
	(FLAGS TAKEABLE CONTAINER TOUCHED OPENED)
	(SYNONYM COCONUT NUT SHELL COCOANUT CRACK)
	(ADJECTIVE COCONUT COCOANUT CRACKED BROKEN BROWN)
	(CAPACITY 1)
	(VALUE 0)
	(SIZE 5)
	(MASS 4)
	(GENERIC GENERIC-COCO-F)
	(ACTION OCOCO-F)>

<ROUTINE OCOCO-F ("AUX" (M <>))
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 1>
			      <NARROW-OCOCO>
			      <RTRUE>)
			     (<T? ,DRIBBLE>
			      <MILK-HARD>
			      <RTRUE>)>
		       <TELL CTHEO " falls out of the " D ,PRSI " and ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? WATCH SHAKE>
		     <T? ,DRIBBLE>>
		<I-MILK <>>
		<RTRUE>)
	       (<AND <VERB? POUR EMPTY>
		     <T? ,DRIBBLE>>
		<KILL-MILK>
		<LAST-DROPS>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<TELL CTHE ,COCO
" has a deep crack where you hit it">
		<COND (<T? ,DRIBBLE>
		       <TELL ". Pale " D ,MILK " is dribbling out">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<T? ,DRIBBLE>
		       <SAY-MILK>
		       <RTRUE>)>
		<TELL CTHEO " is empty." CR>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<COND (<T? ,DRIBBLE>
		       <MILK-HARD>
		       <RTRUE>)>
		<NARROW-OCOCO>
		<RTRUE>)
	       (<VERB? CUT RIP HIT MUNG OPEN OPEN-WITH>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? AXE LUMP SPADE>
		       <VANISH>
		       <TELL CTHEO
" shatters into useless fragments">
		       <COND (<T? ,DRIBBLE>
			      <KILL-MILK>
			      <TELL ", with milk splattering everywhere">)>
		       <PRINT ,PERIOD>
		       <RTRUE>)
		      (<VERB? HIT>
		       <DULL-THUD>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would affect the coconut">
		<RTRUE>)
	       (<VERB? CLOSE REPAIR REPLACE>
		<HOW?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE BEST-KARATE ()
	 <TELL 
"Your best karate technique has no effect on the " D ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE DULL-THUD ()
	 <TELL CTHEI " strikes the " D ,COCO " with a dull thud.|
|
Nothing " <PICK-NEXT ,YAWNS> " happens." CR>
	 <RTRUE>>

<ROUTINE MILK-HARD ()
	 <TELL "The dribbling " D ,MILK " would make that difficult." CR>
	 <RTRUE>>

<ROUTINE NARROW-OCOCO ()
	 <TELL "The crack in the " D ,COCO " is too narrow." CR>
	 <RTRUE>>

<OBJECT MILK
	(DESC "milk")
	(FLAGS NODESC TAKEABLE PLURAL)
	(SYNONYM MILK LIQUID)
	(ADJECTIVE MILKY PALE WHITE COCONUT)
	(GENERIC GENERIC-LIQUID-F)
	(ACTION MILK-F)>

<ROUTINE GENERIC-LIQUID-F (TBL)
	 <COND (<AND <HERE? IN-COTTAGE>
		     <EQUAL? ,W?LIQUID ,P-NAM ,P-XNAM>
		     <NOT <IS? ,EMERALD ,NODESC>>>
		<RETURN ,CWATER>)>
	 <RETURN ,MILK>>

<ROUTINE MILK-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<I-MILK <>>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM KISS TASTE>
		<TELL "The pale liquid is rich and slightly sweet." CR>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		    <VERB? POUR POUR-FROM>>
		<COND (<IN? ,OCOCO ,PLAYER>
		       <SPLASHES ,MILK>
		       <RTRUE>)>
		<YOUD-HAVE-TO "be holding" ,OCOCO>
		<RTRUE>)
	       (<VERB? TAKE TOUCH SQUEEZE REACH-IN SHAKE PLAY TOUCH KICK>
		<SPLASHES ,MILK>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT FIN
	(DESC "fin")
	(FLAGS TRYTAKE NOALL)
	(FDESC "A gray fin is lurking just offshore.")
	(SYNONYM FIN FISH SHARK DOLPHIN PORPOISE WHALE MAMMAL JAWS FLIPPER)
	(ADJECTIVE GRAY GREY DORSAL)
	(ACTION FIN-F)>

<ROUTINE FIN-F ()
	 <COND (<AND <NOT <IS? ,FIN ,SEEN>>
		     <NOT <NOUN-USED? ,W?FIN>>>
		<MAKE ,FIN ,SEEN>
		<VOICE-MUTTERS "Don't be so sure">)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <PERFORM ,V?THROW ,PRSO ,LAGOON>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<I-FLIPPER <>> 
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<RFALSE>)
	       (<FTOUCH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT FLIPPER
	(DESC "dolphin")
	(FDESC "A bottle-nosed dolphin is playing just offshore.")
	(FLAGS LIVING TRYTAKE NOALL PERSON)
	(SYNONYM DOLPHIN PORPOISE MAMMAL WHALE FISH FIN NOSE FLIPPER)
	(ADJECTIVE BOTTLE NOSED BOTTLE\-NOSED)
	(ACTION FLIPPER-F)>

"CHILLY = referred to as FISH, SHADOWY = referred to as Flipper."

<ROUTINE FLIPPER-F ("OPTIONAL" (CONTEXT <>))
	 <MAKE ,FLIPPER ,SEEN>
	 <COND (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<AND <THIS-PRSO?>
			    <VERB? TAKE EXAMINE WATCH FIND FOLLOW RAISE
				   PUSH-TO>
			    <NOT <EQUAL? ,FLIPPER ,PRSO ,PRSI>>>
		       <SHOW-TO-FLIPPER ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? GET-FOR>
			    <PRSI? ME>>
		       <PERFORM ,V?TAKE ,PRSO>
		       <RFATAL>)
		      (<AND <VERB? SGET-FOR>
			    <PRSO? ME>>
		       <PERFORM ,V?TAKE ,PRSI>
		       <RFATAL>)>
		<TELL CTHE ,FLIPPER <PICK-NEXT ,FLIP-SAYS> ,PERIOD>
		<RFATAL>)
	       (<AND <NOT <IS? ,FLIPPER ,CHILLY>>
		     <NOUN-USED? ,W?FISH>>
		<MAKE ,FLIPPER ,CHILLY>
		<VOICE-MUTTERS "It's not a fish">)
	       (<AND <NOT <IS? ,FLIPPER ,SHADOWY>>
		     <NOUN-USED? ,W?FLIPPER>>
		<MAKE ,FLIPPER ,SHADOWY>
		<VOICE-MUTTERS "I suppose that makes you Luke Halpin">)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE FEED THROW THROW-OVER>
		       <TELL "You throw " THEO " towards the " D ,FLIPPER
			     ,PERIOD>
		       <THROW-PRSO-AT-FLIPPER>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <TELL CTHE ,FLIPPER " looks at " THEO>
		       <COND (<OR <PRSO? LUMP AXE LEM SKINK CAGE>
				  <AND <PRSO? PARASOL>
				       <IS? ,PRSO ,OPENED>>>
			      <TELL " and shakes its head vigorously." CR>
			      <RTRUE>)>
		       <TELL ", nods eagerly and chatters." CR>
		       <RTRUE>)
		      (<FTOUCH?>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<UNMAKE ,FLIPPER ,SEEN>
		<I-FLIPPER <>>
		<RTRUE>)
	       (<VERB? WAVE-AT POINT-AT>
		<TELL CTHE ,FLIPPER
		      " responds with a happy squeal." CR>
		<RTRUE>)
	       (<AND <VERB? TELL>
		     <T? ,P-CONT>>
		<RFALSE>)
	       (<AND <VERB? TELL-ABOUT ASK-FOR ASK-ABOUT>
		     <NOT <PRSI? FLIPPER>>>
		<SHOW-TO-FLIPPER ,PRSI>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO <PICK-NEXT ,FLIP-SAYS> ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO>
		<COND (<PROB 50>
		       <TELL " whistle">)
		      (T
		       <TELL " croak">)>
		<TELL "s endearingly." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<FTOUCH?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FTOUCH? ()
	 <COND (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL "It's a little too far offshore." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SHOW-TO-FLIPPER (OBJ)
	 <MAKE ,FLIPPER ,SEEN>
	 <COND (<EQUAL? .OBJ ,INTDIR ,RIGHT ,LEFT>
		<COND (<AND <EQUAL? ,P-DIRECTION ,P?WEST>
			    <HERE? WSAND>
			    <IS? ,COCO ,TRYTAKE>>
		       <SET OBJ ,COCO>)
		      (T
		       <LOOKS-INTDIR ,FLIPPER>
		       <RTRUE>)>)
	       (<OR <ZERO? .OBJ>
		    <NOT <VISIBLE? .OBJ>>>
		<PERPLEXED ,FLIPPER>
		<RTRUE>)>
	 <TELL CTHE ,FLIPPER>
	 <COND (<AND <EQUAL? .OBJ ,COCO>
		     <NOT <IS? .OBJ ,TAKEABLE>>>
		<TELL " sees the ">
		<COND (<NOT <IS? .OBJ ,CHILLY>>
		       <TELL D .OBJ
" on the islet and tries to nudge it with its snout. But the tide hasn't risen high enough yet." CR>
		       <RTRUE>)>
	        <UNMAKE .OBJ ,CHILLY>
	 	<UNMAKE .OBJ ,TRYTAKE>
	 	<UNMAKE .OBJ ,NOALL>
	 	<MAKE .OBJ ,TAKEABLE>
		<PUTP .OBJ ,P?DESCFCN 0>
		<TELL "floating " D .OBJ
		      ", snatches it out of the " D ,LAGOON
		      " and tosses it into the sand at your feet." CR>
		<RTRUE>)>
	 <TELL " looks at " THE .OBJ
	       " and chatters mischievously." CR>
	 <RTRUE>>

<ROUTINE LOOKS-INTDIR (OBJ)
	 <TELL CTHE .OBJ " glances in " D ,RIGHT ", then back at you." CR>
	 <RTRUE>>

<GLOBAL FLIP-SAYS:TABLE 
	<LTABLE 2
	 " struggles to respond, but can only chatter"
	 " responds with a stream of chatter"
	 " longs to respond, but can't">>
	
<ROUTINE THROW-PRSO-AT-FLIPPER ()
	 <MAKE ,FLIPPER ,SEEN>
	 <TELL CR CTHE ,FLIPPER>
	 <COND (<PRSO? LUMP AXE LEM SKINK CAGE>
		<VANISH>
	 	<TELL " avoids the flying " D ,PRSO 
		      " and gives you a reproachful look" ,PCR
		       CTHEO " splashes into the " D ,LAGOON>
	 	<COND (<PRSO? LEM SKINK>
		       <TELL ", struggles for a moment">)>
	 	<TELL " and sinks" ,OUTASITE>
		<RTRUE>)
	       (<AND <PRSO? PARASOL>
		     <IS? ,PRSO ,OPENED>>
		<VANISH>
		<TELL " tries to catch the open " D ,PRSO
		      " in its mouth, but fails.|
|
The " D ,PARASOL " lands on the " D ,LAGOON " and floats" ,OUTASITE>
		<RTRUE>)>
	 <TELL " catches the flying " D ,PRSO
" in its mouth and skillfully tosses it back to you." CR>
	 <RTRUE>>

<OBJECT CRABS
	(DESC "crabs")
	(FDESC "An army of crabs is guarding the water's edge.")
	(FLAGS NODESC PLURAL TRYTAKE LIVING PERSON)
	(SYNONYM CRABS ARMY CRAB CRUSTACEAN CLAW CLAWS)
	(ACTION CRABS-F)>

"NODESC = not seen, SEEN = just referenced."

<ROUTINE CRABS-F ()
	 <MAKE ,CRABS ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW>
		       <TELL CTHEI>
		       <COND (<PROB 50>
		       	      <TELL 
" are more interested in snapping at you." CR>
			      <RTRUE>)>
		       <TELL " peer suspiciously at " THEO 
			     ", but show no interest." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER PUT-ON>
		       <MOVE ,PRSO ,HERE>
		       <TELL CTHEI 
" skillfully dodge out of the way." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<UNMAKE ,PRSO ,SEEN>
		<I-CRABS <>>
		<RTRUE>)	       
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO " respond with a chorus of vicious snaps." CR>
		<RFATAL>)
	       (<VERB? CLIMB-OVER CROSS LEAP>
		<TELL "There are too many " D ,PRSO " to do that." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHEO " scurry out of ">
		<COND (<PROB 50>
		       <TELL "reach." CR>
		       <RTRUE>)>
		<TELL "your way." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CATS
	(LOC ON-MOOR)
	(DESC "cattails")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM CATTAILS CATTAIL TAIL TAILS)
	(ADJECTIVE CAT)
	(ACTION CATS-F)>

<ROUTINE CATS-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER LOOK-BEHIND SEARCH>
		<TELL "You discover nothing " <PICK-NEXT ,YAWNS>
		      " among the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN TOUCH KISS SQUEEZE PLAY>
		<TELL "You hear a faint purring " D ,SOUND ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE PICK PULL LOOSEN PUSH MOVE PUSH-TO DIG
		       KILL CUT MUNG KICK>
		<TELL "A chorus of anxious mewing" ,CHANGES>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER>>
		<TELL ,YOURE-ALREADY "surrounded by " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CROSS CLIMB-OVER>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT NAGASAKI
	(LOC LOCAL-GLOBALS)
	(DESC "Nagasaki")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM NAGASAKI HIROSHIMA CITY)
	(GENERIC GENERIC-CITY-F)
	(ACTION CITY-F)>

<OBJECT CITY
	(LOC LOCAL-GLOBALS)
	(DESC "city")
	(FLAGS NODESC)
	(SYNONYM CITY)
	(GENERIC GENERIC-CITY-F)
	(ACTION CITY-F)>

<ROUTINE GENERIC-CITY-F (TBL)
	 <RETURN ,CITY>>

"BORING = called HIROSHIMA once, NOALL = corrected."

<ROUTINE CITY-F ("AUX" (S <>))
	 <COND (<AND <NOUN-USED? ,W?HIROSHIMA>
		     <NOT <IS? ,CITY ,BORING>>>
		<MAKE ,CITY ,BORING>
		<VOICE-MUTTERS "Nope. Wrong city">)
	       (<AND <NOT <IS? ,CITY ,NOALL>>
		     <IS? ,CITY ,BORING>
		     <NOUN-USED? ,W?NAGASAKI>>
		<MAKE ,CITY ,NOALL>
		<VOICE-MUTTERS "Got it">)>
	 <COND (<HERE? IN-SKY>
		<SET S T>)>
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-DOWN SEARCH LOOK-INSIDE WATCH>
		<COND (<T? .S>
		       <I-FALLING <>>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .S>
		       <TELL "Patience. You'll be there soon." CR>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CROSS CLIMB-OVER>>
		<COND (<T? .S>
		       <TELL "You're not in the city... yet." CR>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<COND (<T? .S>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			      
<OBJECT SPILE
	(LOC PLAYGROUND)
	(DESC "sandpile")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER OPENED)
	(CAPACITY 100)
	(SYNONYM SAND PILE SANDPILE)
	(ADJECTIVE SAND)
	(DESCFCN DESCRIBE-SPILE)
	(ACTION SPILE-F)>

"NODESC = unseen."

<GLOBAL IN-SAND?:FLAG <>>

<ROUTINE DESCRIBE-SPILE ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<COND (<ZERO? ,IN-SAND?>
		       <TELL "A child's " D ,SPILE 
			     " covers the ground at your feet">)
		      (T
		       <TELL "You're standing in a child's " D ,SPILE>)>
		<LOOK-IN-SPILE>
		<PRINTC 46>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPILE-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH LOOK-DOWN>
		<COND (<T? ,IN-SAND?>
		       <TELL "Aside from " D ,ME ", you ">)
		      (T
		       <TELL "You ">)>
		<TELL "see ">
		<PRINT-CONTENTS ,PRSO>
		<TELL " in the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? DIG REACH-IN LOOK-UNDER LOOK-BEHIND TAKE-WITH>
		<TELL "Poking around in the " D ,PRSO
		      " reveals nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-UP STAND-ON LEAP RIDE>>
		<COND (<ZERO? ,IN-SAND?>
		       <SETG OLD-HERE <>>
		       <SETG IN-SAND? T>
		       <TELL "You climb back into the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<ZERO? ,IN-SAND?>
		       <NOT-IN>
		       <RTRUE>)>
		<SETG OLD-HERE <>>
		<SETG IN-SAND? <>>
		<TELL "You climb out of the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? PLAY SIT LIE-DOWN STAND-UNDER KICK>
		<TELL
"This is hardly the time for frolicking in the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE PUSH MOVE PULL PUSH-TO SQUEEZE RAISE>
		<TELL "Sand trickles uselessly between your fingers." CR>
		<RTRUE>)
	       (<OR <VERB? KNOCK>
		    <AND <VERB? HIT>
			 <PRSI? ROOMS HANDS>>>
		<TELL "Frustrated? Save your energy." CR>
		<RTRUE>)
	       (<VERB? HIT KICK>
		<TELL "Sand flies in all " D ,INTDIR "s." CR>
		<RTRUE>)
	       (<VERB? BITE EAT KISS>
		<TELL "This is no time for biting the dust." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PGROUND
	(LOC LOCAL-GLOBALS)
	(DESC "playground")
	(FLAGS NODESC)
	(SYNONYM PLAYGROUND GROUND)
	(ADJECTIVE PLAY)
	(ACTION HERE-F)>

<OBJECT SDIRT
	(LOC LOCAL-GLOBALS)
	(DESC "dirt")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM DIRT EARTH)
	(GENERIC GENERIC-DIRT-F)
	(ACTION SDIRT-F)>

<ROUTINE GENERIC-DIRT-F (TBL)
	 <RETURN ,SDIRT>>

<ROUTINE SDIRT-F ()
	 <COND (<VERB? SEARCH LOOK-INSIDE LOOK-UNDER DIG FIND>
		<TELL "There's nothing to find." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<RFALSE>)
	       (<VERB? TAKE REACH-IN>
		<TELL "Dirt falls between your fingers." CR>
		<RTRUE>)>
	 <YOU-DONT-NEED ,SDIRT>
	 <RFATAL>>

<OBJECT SHELTER
	(LOC LOCAL-GLOBALS)
	(DESC "shelter")
	(FLAGS NODESC)
	(SYNONYM SHELTER CELLAR MOUND MOUNDS DIRT)
	(ADJECTIVE BOMB DARK MOUND MOUNDS DIRT)
	(GENERIC GENERIC-DIRT-F)
	(ACTION SHELTER-F)>

<ROUTINE SHELTER-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<HERE? IN-SHELTER>
		       <V-LOOK>
		       <RTRUE>)
		      (<VERB? EXAMINE>
		       <TELL
"All you can see is a mound of dirt, with a dark " D ,SHELHOLE
" leading downward." CR>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<HANDLE-SHELTER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHELHOLE
	(LOC LOCAL-GLOBALS)
	(DESC "opening")
	(FLAGS NODESC VOWEL)
	(SYNONYM OPENING HOLE)
	(ACTION SHELHOLE-F)>

<ROUTINE SHELHOLE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<TELL CTHEO " leads ">
		<COND (<HERE? IN-SHELTER>
		       <TELL "west." CR>
		       <RTRUE>)>
		<TELL "east." CR>
		<RTRUE>)
	       (<HANDLE-SHELTER?>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,PLAYGROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-SHELTER? ("AUX" (IN <>))
	 <COND (<HERE? IN-SHELTER>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT THROW THROW-OVER>
		       <COND (<ZERO? .IN>
			      <MOVE ,PRSO ,IN-SHELTER>
			      <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
			      <TELL CTHEO " disappears into the "
				    D ,SHELHOLE ,PERIOD>
			      <RTRUE>)>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-DOWN STAND-UNDER HIDE>>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-UP>>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TEACHERS
	(LOC PLAYGROUND)
	(DESC "teachers")
	(FLAGS PLURAL PERSON LIVING NODESC)
	(SYNONYM TEACHERS TEACHER ADULTS ADULT SCHOOLTEA PEOPLE
	 	 GROUP CROWD BUNCH JAPS ORIENTALS)
	(ADJECTIVE SCHOOL JAP JAPANESE ORIENTAL)
	(GENERIC GENERIC-JAPS-F)
	(ACTION TEACHERS-F)>

<ROUTINE TEACHERS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO>
		<COND (<AND <EQUAL? ,MINUTES 1>
			    <T? ,SECONDS>>
		       <WATCHING-SKY>
		       <RTRUE>)>
		<TELL " are intent upon their work." CR>
		<RTRUE>)
	       (<VERB? FOLLOW WALK-TO>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <NOT <EQUAL? ,MINUTES 1>>>
		<TELL CTHEO " mutter among themselves as they work." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-JAPS?>>>

<ROUTINE GENERIC-JAPS-F (TABLE)
	 <COND (<OR <EQUAL? ,P-NAM ,W?GIRL ,W?CHILD ,W?KID>
		    <EQUAL? ,P-XNAM ,W?GIRL ,W?CHILD ,W?KID>>
		<COND (<IS? ,GIRL ,NODESC>
		       <RETURN ,KIDS>)>
		<RETURN ,GIRL>)
	       (<EQUAL? ,P-THEM-OBJECT ,KIDS ,TEACHERS>
		<RETURN ,P-THEM-OBJECT>)
	       (T
		<RFALSE>)>>
		
<ROUTINE WATCHING-SKY ()
	 <TELL " are watching the sky apprehensively." CR>
	 <RTRUE>>

<OBJECT KIDS
	(LOC PLAYGROUND)
	(DESC "children")
	(FLAGS PLURAL PERSON LIVING NODESC)
	(SYNONYM CHILDREN KIDS CHILD KID GROUP BUNCH GATHERING
	 	 PEOPLE BOYS GIRLS JAPS ORIENTALS)
	(ADJECTIVE SCHOOL JAP JAPANESE ORIENTAL)
	(GENERIC GENERIC-JAPS-F)
	(ACTION KIDS-F)>

"TOUCHED = quote seen."

<ROUTINE KIDS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO>
		<COND (<AND <EQUAL? ,MINUTES 1>
			    <T? ,SECONDS>>
		       <WATCHING-SKY>)
		      (T
		       <TELL
" tumble over one another as they leap to catch the elusive " 
D ,DFLIES ,PERIOD>)>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <MAKE ,PRSO ,TOUCHED>
		       <SETG DO-WINDOW <GET ,QUOTES ,HAWTHORNE>>
		       <RFATAL>)>
		<RTRUE>)
	       (<VERB? FOLLOW WALK-TO>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <NOT <EQUAL? ,MINUTES 1>>>
		<TELL CTHEO " shout with delight as they play." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-JAPS?>>>

<ROUTINE HANDLE-JAPS? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)		
	       (<VERB? WAVE-AT POINT-AT>
		<TELL CTHEO " didn't notice your gesture." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO 
" don't respond. They're a little too far away to hear you." CR>
		<RFATAL>)
	       (<VERB? WALK-TO FOLLOW>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DFLIES
	(LOC LOCAL-GLOBALS)
	(DESC "dragonflies")
	(FLAGS NODESC PLURAL TRYTAKE NOALL LIVING)
	(SYNONYM FLIES FLY DRAGONFLIES DRAGONFLY INSECT INSECTS)
	(ADJECTIVE DRAGON)
	(ACTION DFLIES-F)>

<ROUTINE DFLIES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL CTHEO " dart mischievously to and fro">
		<COND (<HERE? PLAYGROUND>
		       <TELL ", just out of the " D ,KIDS "'s reach">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? SMELL LISTEN>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<DO-WALK ,P?NORTH>
		<RTRUE>)	       
	       (T
		<RFALSE>)>>

<OBJECT SCHOOL
	(LOC PLAYGROUND)
	(DESC "building")
	(FLAGS NODESC)
	(SYNONYM SCHOOL SCHOOLHOUSE BUILDING STRUCTURE CLASSROOM)
	(ADJECTIVE PRIMARY ELEMENTARY SCHOOL CONCRETE CEMENT LONG)
	(ACTION SCHOOL-F)>

<ROUTINE SCHOOL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The concrete " D ,SCHOOL
" appears to be a schoolhouse, somewhat the worse for neglect." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<LOOK-IN-SCHOOL>
		<RTRUE>)
	       (<ENTERING?>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK-OUTSIDE REACH-IN>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SCHOOL-WINDOWS
	(LOC PLAYGROUND)
	(DESC "windows")
	(FLAGS PLURAL NODESC OPENABLE)
	(SYNONYM WINDOWS WINDOW)
	(ACTION SCHOOL-WINDOWS-F)>

<ROUTINE SCHOOL-WINDOWS-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE LOOK-BEHIND SEARCH USE>
		<LOOK-IN-SCHOOL>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLOSE CLIMB-OVER CROSS REACH-IN>>
		<ITS-CLOSED ,SCHOOL-WINDOWS>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<TELL CTHE ,SCHOOL-WINDOWS " open from the inside." CR>
		<RTRUE>)
	       (<VERB? HIT MUNG CUT RIP THROW THROW-OVER>
		<TELL "Pointless vandalism">
		<WONT-HELP>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,SCHOOL>
		<RTRUE>)
	       (<VERB? LOOK-OUTSIDE>
		<TELL ,YOURE-ALREADY "outside." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DECOR
	(LOC LOCAL-GLOBALS)
	(DESC "folded decorations")
	(FLAGS NODESC PLURAL TRYTAKE NOALL READABLE)
	(SYNONYM FLOWERS FLOWER BIRD BIRDS DECORATION DECOR PAPER PAPERS
	 	 DRAWINGS WRITING WORDS DRAWING)
	(ADJECTIVE FOLDED COLORED CLUMSY JAPANESE ORIGAMI)
	(ACTION DECOR-F)>

<ROUTINE DECOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO
" are illustrated with clumsy drawings and Japanese writing." CR>
		<RTRUE>)
	       (<VERB? READ LOOK-ON>
		<TELL "The Japanese writing on the " D ,DECOR
		      " means nothing to you." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
      
<ROUTINE LOOK-IN-SCHOOL ()
	 <TELL "A " D ,CCLOCK
	       " is visible in a classroom beyond the " D ,SCHOOL-WINDOWS
	       ,PERIOD>
	 <RTRUE>>

<OBJECT CCLOCK
	(LOC PLAYGROUND)
	(DESC "clock")
	(FLAGS NODESC READABLE TRYTAKE NOALL)
	(SYNONYM CLOCK TIME HANDS DIGITS FACE)
	(GENERIC GENERIC-CLOCK-F)
	(ACTION CCLOCK-F)>

<ROUTINE CCLOCK-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ LOOK-INSIDE>
		<TELL CTHEO>
		<TELL-TIME>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GENERIC-CLOCK-F (TABLE)
	 <COND (<EQUAL? ,W?CLOCK ,P-NAM ,P-XNAM>
		<RETURN ,CCLOCK>)>
	 <RETURN ,WRISTWATCH>>		

<OBJECT SWINGS
	(LOC PLAYGROUND)
	(DESC "swings")
	(FLAGS NODESC TRYTAKE NOALL PLURAL SURFACE)
	(CAPACITY 5)
	(SYNONYM SWINGS SWING SET SEAT SEATS)
	(ADJECTIVE SWING RED LITTLE SMALL TINY)
	(ACTION SWINGS-F)>

<ROUTINE SWINGS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL CTHEO 
" are like little red pendulums as they arc ">
		<BACK-AND-FORTH>
		<CRLF>
		<RTRUE>)
	       (<VERB? TOUCH PUSH PULL MOVE KICK PUSH-TO KNOCK
		       SHAKE HIT SWING RAISE LOWER>
		<TELL 
"The seats swing a little faster for a while." CR>
		<RTRUE>)
	       (<VERB? ENTER SIT RIDE CLIMB-ON CLIMB-UP>
		<TELL "These " D ,PRSO
" are designed for bottoms far slimmer than yours." CR>
		<RTRUE>)
	       (<VERB? STAND-ON LIE-DOWN>
		<TELL "Acrobatics">
		<WONT-HELP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BACK-AND-FORTH ()
	 <TELL "slowly back and forth in the humid breeze.">
	 <RTRUE>>
		       
<OBJECT PLANES
	(LOC LOCAL-GLOBALS)
	(DESC "aircraft")
	(FLAGS NODESC PLURAL VOWEL)
	(SYNONYM AIRCRAFT PLANE PLANES AIRPLANE AIRPLANES BOMBER BOMBERS
	 	 CAR)
	(ADJECTIVE BOCK\'S AIR)
	(ACTION PLANES-F)>

"SEEN = heard."

<ROUTINE PLANES-F ()
	 <COND (<NOT <IS? ,PLANES ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<VERB? LISTEN>
		<I-NAGASAKI <>>
		<RTRUE>)>
	 <SETG P-IT-OBJECT ,PLANES>
	 <COND (<VERB? EXAMINE LOOK-UP COUNT FIND FOLLOW>
		<COND (<IS? ,HERE ,INDOORS>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<TELL "You can just make out two " D ,PRSO
" high overhead. No, there's another! They're flying southwest." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <VERB? LOOK-INSIDE SEARCH READ LOOK-BEHIND>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
				
<OBJECT DSTRUCT
	(LOC LOCAL-GLOBALS)
	(DESC "giant triangle")
	(FLAGS NODESC)
	(SYNONYM STRUCTURE TRIANGLE GNOMON)
	(ADJECTIVE TRIANGULAR DARK BLACK GIANT LARGE HUGE)
	(ACTION DSTRUCT-F)>

<ROUTINE DSTRUCT-F ()
	 <COND (<OR <IS? ,HERE ,INDOORS>
		    <HERE? IN-CRATER SWPATH SEPATH ARBORETUM>>
		<TELL ,CANT "see the " D ,DSTRUCT " from here." CR>
		<RFATAL>)
	       (<VERB? WALK-TO ENTER FOLLOW CLIMB-ON STAND-ON>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<NOT-IN ,DSTRUCT T>
		<RTRUE>)
	       (<VERB? EXAMINE WATCH>
		<TELL "Its dark edge" ,RAZOR ,PERIOD>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 
<OBJECT SUMMIT
	(LOC LOCAL-GLOBALS)
	(DESC "hill")
	(FLAGS NODESC)
	(SYNONYM HILL HILLTOP HILLSIDE SUMMIT TOP SIDE SIDES SLOPE)
	(ADJECTIVE HILL GENTLE)
	(ACTION SUMMIT-F)>

<ROUTINE SUMMIT-F ("AUX" (ON <>))
	 <COND (<HERE? ON-HILL>
		<SET ON T>)>
	 <COND (<VERB? EXAMINE SEARCH LOOK-UP>
		<COND (<ZERO? .ON>
		       <TELL CTHEO " slopes upward to the ">
		       <COND (<HERE? IN-MEADOW>
			      <TELL "north." CR>
			      <RTRUE>)
			     (<HERE? SBOG>
			      <TELL "south">)>
		       <SAY-WEST>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-DOWN LOOK-BEHIND>
		<COND (<ZERO? .ON>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-UP CLIMB-OVER CROSS STAND-ON>>
		<COND (<ZERO? .ON>
		       <DO-WALK <COND (<HERE? IN-MEADOW>
				       ,P?NORTH)
				      (<HERE? FCLEARING>
				       ,P?WEST)
				      (T
				       ,P?SW)>>
		       <RTRUE>)>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<ZERO? .ON>
		       <NOT-IN ,SUMMIT T>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<AND <ZERO? .ON>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT SPADE
	(LOC IN-SHELTER)
	(DESC "spade")
	(FDESC "A spade is leaning against the wall.")
	(FLAGS TAKEABLE FERRIC)
	(SYNONYM SPADE)
	(VALUE 1)
	(SIZE 10)
	(MASS 7)
	(ACTION SPADE-F)>

<ROUTINE SPADE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It looks sturdy enough." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PEE
	(LOC GLOBAL-OBJECTS)
	(DESC "urine")
	(FLAGS NODESC VOWEL TRYTAKE NOALL NOARTICLE)
	(SYNONYM URINE PISS PEE)
	(ACTION PEE-F)>

<ROUTINE PEE-F ()
	 <COND (<NOT <HERE? IN-SHELTER>>
		<COND (<NOUN-USED? ,W?URINE>
		       <CANT-SEE-ANY>
		       <RTRUE>)>
		<CRUDITY>
		<RFATAL>)
	       (<VERB? SMELL INHALE>
		<TELL "Come on. You know what " D ,PRSO
		      " smells like." CR>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<V-RAPE>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		<TELL ,CANT "see any " D ,PEE
		      " here. But you sure can smell it." CR>
		<RTRUE>)
	       (T
		<CRUDITY>
		<RTRUE>)>>
	       
<OBJECT MCRANE
	(DESC "giant bird")
	(FDESC "A gigantic paper bird is perched nearby.")
	(FLAGS TRYTAKE NOALL LIVING PERSON)
	(SYNONYM BIRD CRANE ORIGAMI CONSTRUCT WING WINGS)
	(ADJECTIVE GIANT HUGE PAPER HUMONGOUS)
	(ACTION MCRANE-F)>

<ROUTINE MCRANE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <REPROACH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? WATCH>
		<I-MCRANE <>>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "It looks like a sixteen-foot version of the " 
		      D ,CRANE " you found in the " D ,RPOND ,PERIOD>
		<RTRUE>)
	       (<VERB? RIDE CLIMB-ON ENTER CLIMB-UP STAND-ON SIT LIE-DOWN
		       CLIMB-OVER>
		<COND (<HERE? ON-BIRD>
		       <ALREADY-IN ,PRSO T>
		       <RTRUE>)>
		<SETG IN-SAND? <>>
		<DEQUEUE I-MCRANE>
		<DEQUEUE I-GIRL>
		<DEQUEUE I-NAGASAKI>
		<SETG MCOUNT 3>
		<QUEUE I-FLIGHT -1>
		<MOVE ,PRSO ,ON-BIRD>
		<MAKE ,PRSO ,NODESC>
		<TELL 
"Gulping with fear, you climb into the crackling folds of the " D ,PRSO 
"'s back.|
|
With a powerful beat of its wings, the strange creature lifts away from the ground. Blowing sand obscures the view, but you can hear "
D ,VOICES " crying out in wonder. When the air clears, the " D ,PGROUND
" is far below" ,PCR>
		<GOTO ,ON-BIRD>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO 
" doesn't respond verbally. But you feel a wave of urgent emotion." CR>
		<RFATAL>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<HERE? ON-BIRD>
		       <EXIT-NAGASAKI>
		       <RFATAL>)>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<REPROACH>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
		       
<ROUTINE REPROACH ()
	 <TELL "A wave of reproachful emotion" ,CHANGES>
	 <RTRUE>>

<OBJECT MOON
	(LOC LOCAL-GLOBALS)
	(DESC "moon")
	(FLAGS NODESC)
	(SYNONYM MOON)
	(ADJECTIVE CRESCENT HORNS)
	(ACTION MOON-F)>

<ROUTINE MOON-F ()
	 <COND (<VERB? EXAMINE WATCH>
	 	<TELL CTHEO 
" is a delicate crescent, hovering just above the " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT GADGET
	(LOC IN-SHACK)
	(DESC "sphere")
	(FLAGS NODESC TRYTAKE NOALL OPENABLE FERRIC SURFACE)
	(CAPACITY 5)
	(SYNONYM SPHERE BALL GADGET BOMB BEAST THING DEVICE UNIT BRACKET
	 	 SURFACE)
	(ADJECTIVE X ATOMIC NUCLEAR METAL BLACK DARK)
      	(ACTION GADGET-F)>

"SEEN = quote given."

<ROUTINE GADGET-F ()
	 <COND (<HANDLE-BOMB?>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<SEE-GADGET-IN-MANUAL>
		<COND (<NOT <IS? ,PRSO ,SEEN>>
		       <MAKE ,PRSO ,SEEN>
		       <SETG DO-WINDOW <GET ,QUOTES ,MELVILLE>>
		       <RFATAL>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SEE-GADGET-IN-MANUAL ()
	 <TELL "[You'll find the " D ,PRSO " pictured in ">
	 <ITALICIZE "The Illustrated Story of the Atom Bomb.">
	 <TELL "]" CR>
	 <RTRUE>>

<OBJECT X5
	(LOC IN-SHACK)
	(DESC "enclosure")
	(FLAGS NODESC VOWEL TRYTAKE NOALL SURFACE)
	(SYNONYM ENCLOSURE BOX)
	(ADJECTIVE BOXLIKE JUNCTION)
	(CAPACITY 5)
	(CONTFCN IN-X5)
	(ACTION X5-F)>

<ROUTINE IN-X5 ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<NOT <IS? ,X5 ,OPENED>>
		<RFALSE>)
	       (<SEE-IN-X5?>
		<RFALSE>)>
	 <TELL ,CANT "see anything in the " D ,X5 ". It's too dark." CR>
	 <RTRUE>>

<ROUTINE SEE-IN-X5? ()
	 <COND (<IS? ,WATT ,LIGHTED>
		<RTRUE>)
	       (<AND <VISIBLE? ,LAMP>
		     <IS? ,LAMP ,LIGHTED>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE X5-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <ITS-CLOSED ,APANEL>
			      <RTRUE>)
			     (<G? <GETP ,PRSO ,P?SIZE> 1>
			      <TELL "You'd never get " THEO
				    " in with all those " D ,WIRES ,PERIOD>
			      <RTRUE>)>
		       <VANISH>
		       <TELL CTHEO " falls between the " D ,WIRES
			     " and slides" ,OUTASITE>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <TELL "The top of the " D ,PRSI
			     " is covered with " D ,GCABLES ,PERIOD>
		       <RTRUE>)		       
		      (<AND <VERB? POINT-AT SHINE-AT>
			    <IS? ,PRSI ,OPENED>
			    <PRSO? LAMP>
			    <IS? ,PRSO ,LIGHTED>>
		       <TELL "You aim the " D ,PRSO 
			     " into the open " D ,PRSI ,PCR>
		       <PERFORM ,V?LOOK-INSIDE ,PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO
" is a central junction for the forest of " D ,GCABLES
" connected to the " D ,GADGET ". An " D ,APANEL " on the side is ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "open, exposing a ">
		       <COND (<SEE-IN-X5?>
			      <TELL "maze of wiring." CR>
			      <RTRUE>)>
		       <TELL "dark interior." CR>
		       <RTRUE>)>
		<TELL "closed." CR>
		<RTRUE>)
	       (<HANDLE-X5?>
		<RTRUE>)
	       (T
		<RFALSE>)>>		     

<ROUTINE HANDLE-X5? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<OR <VERB? CLOSE>
		    <AND <VERB? SCREW-WITH>
			 <PRSI? SDRIVER KNIFE>>
		    <AND <VERB? COVER>
			 <PRSI? APANEL>>>
		<COND (<IS? ,X5 ,OPENED>
		       <TELL
"A few moments of fumbling with the " D ,APANEL
" persuades you to leave the " D ,X5 " open." CR>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<NOT <IS? ,X5 ,OPENED>>
		       <ITS-CLOSED ,APANEL>
		       <RTRUE>)
		      (<NOT <HERE? IN-SHACK>>
		       <RFALSE>)>
		<TELL CTHEO "'s interior is ">
		<COND (<SEE-IN-X5?>
		       <TELL 
"neatly packed with colored wires. Prominent among them are a " D ,RWIRE 
", a " D ,BWIRE ", a " D ,SWIRE " and a " D ,WWIRE ,PERIOD>
		       <RTRUE>)>
		<TELL "dark." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH LOOSEN UNSCREW TAKE-WITH TURN>
		<COND (<IS? ,X5 ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <TELL "You pry at the " D ,APANEL
" with your fingers. But the screws hold it fast." CR>
		       <RTRUE>)
		      (<PRSI? SDRIVER>
		       <MOVE ,APANEL ,HERE>
		       <UNMAKE ,APANEL ,NOALL>
		       <MAKE ,X5 ,OPENED>
		       <MAKE ,X5 ,CONTAINER>
		       <MAKE ,X5 ,OPENABLE>
		     ; <UNMAKE ,X5 ,SURFACE>
		       <COND (<SEE-IN-X5?>
			      <GET-WIRES>)>
		       <TELL "You loosen the screws on the " D ,APANEL
". It falls off the " D ,X5 " and clatters to the " D ,FLOOR ,PERIOD>
		       <UPDATE-SCORE 3>
		       <RTRUE>)
		      (<PRSI? SCOIN>
		       <TELL CTHEI
" won't fit the screws on the " D ,APANEL ,PERIOD>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "could loosen the screws">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT APANEL
	(LOC X5)
	(DESC "access panel")
	(FLAGS NODESC VOWEL TAKEABLE NOALL)
	(SYNONYM PANEL SCREW SCREWS)
	(ADJECTIVE ACCESS FOUR)
	(VALUE 0)
	(SIZE 4)
	(MASS 4)
	(ACTION APANEL-F)>

"NOALL = panel closed."

<ROUTINE APANEL-F ()
	 <COND (<HANDLE-X5?>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? UNSCREW-FROM>
		<COND (<AND <PRSI? X5>
			    <IS? ,PRSO ,NOALL>>
		       <COND (<IN? ,SDRIVER ,PLAYER>
		       	      <TELL "[with the " D ,SDRIVER ,BRACKET>
			      <PERFORM ,V?UNSCREW ,PRSO ,SDRIVER>
			      <RTRUE>)>
		       <PERFORM ,V?UNSCREW ,PRSO ,HANDS>
		       <RTRUE>)>
		<TELL CTHEO " isn't attached to " THEI ,PERIOD>
		<RTRUE>)		
	       (<NOT <IS? ,APANEL ,NOALL>>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
" is attached to the " D ,X5 " with four screws." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<ITS-CLOSED>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
	        <FIRMLY-ATTACHED ,PRSO ,X5>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GET-WIRES ()
	 <MAKE ,WATT ,TOUCHED>
	 <MOVE ,RWIRE ,X5>
	 <MOVE ,BWIRE ,X5>
	 <MOVE ,WWIRE ,X5>
	 <MOVE ,SWIRE ,X5>
	 <MOVE ,WIRES ,X5>
	 <RTRUE>>

<OBJECT WATT
	(LOC IN-SHACK)
	(DESC "hanging bulb")
	(FLAGS NODESC TRYTAKE NOALL OPENABLE)
	(SYNONYM BULB LAMP CHAIN LIGHT)
	(ADJECTIVE HANGING DANGLING LIGHT)
	(GENERIC GENERIC-BULB-F)
	(ACTION WATT-F)>

"TOUCHED = wires moved."

<ROUTINE WATT-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"It's an ordinary 60-watt bulb, with a chain to turn it on and off">
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL 
". Its sullen glow fills the " D ,DSHADOW 
"s cast by the harsh light outside">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON LIGHT-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,LIGHTED>
		       <ITS-ALREADY "on">
		       <RTRUE>)>
		<SWITCH-WATT>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<COND (<IS? ,PRSO ,LIGHTED>
		       <SWITCH-WATT>
		       <RTRUE>)>
		<ITS-ALREADY "off">
		<RTRUE>)
	       (<VERB? PULL LOWER>
		<SWITCH-WATT>
		<RTRUE>)
	       (<VERB? PUSH SWING SHAKE TOUCH>
		<TELL CTHEO
" swings back and forth for a moment, then stops." CR>
		<RTRUE>)
	       (<AND <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,LIGHTED>>
		<TELL "Ouch! It's hot." CR>
		<RTRUE>)
	       (<VERB? TAKE UNSCREW TURN TAKE-WITH>
		<TELL CTHEO 
" would be of little use. You decide to leave it alone." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		        
<ROUTINE SWITCH-WATT ()
	 <TELL "You pull the chain, and the bulb ">
	 <COND (<IS? ,WATT ,LIGHTED>
		<UNMAKE ,WATT ,LIGHTED>
		<TELL "goes out">)
	       (T
		<COND (<AND <IS? ,X5 ,OPENED>
			    <NOT <IS? ,WATT ,TOUCHED>>>
		       <GET-WIRES>)>
		<MAKE ,WATT ,LIGHTED>
		<TELL "begins to glow">)>
	 <TELL ,PERIOD>
	 <RTRUE>>
		       
<OBJECT RWIRE
	(DESC "red wire")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WIRE LINE CABLE POS POSITIVE PLUS GND GROUND DET DETONATOR
	 	 INF INFORMER)
	(ADJECTIVE RED RD)
	(GENERIC GENERIC-WIRE-F)
	(ACTION WIRE-F)>

<OBJECT BWIRE
	(DESC "blue wire")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WIRE LINE CABLE POS POSITIVE PLUS GND GROUND DET DETONATOR
	 	 INF INFORMER)
	(ADJECTIVE BLUE BL)
	(GENERIC GENERIC-WIRE-F)
	(ACTION WIRE-F)>

<OBJECT SWIRE
	(DESC "striped wire")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WIRE LINE CABLE POS POSITIVE PLUS GND GROUND DET DETONATOR
	 	 INF INFORMER STRIPES STRIPE)
	(ADJECTIVE STRIPED ST)
	(GENERIC GENERIC-WIRE-F)
	(ACTION WIRE-F)>

<OBJECT WWIRE
	(DESC "white wire")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WIRE LINE CABLE POS POSITIVE PLUS GND GROUND DET DETONATOR
	 	 INF INFORMER)
	(ADJECTIVE WHITE WH PALE)
	(GENERIC GENERIC-WIRE-F)
	(ACTION WIRE-F)>

<ROUTINE GENERIC-WIRE-F (TABLE "AUX" LEN)
	 <COND (<OR <EQUAL? ,P-NAM ,W?POS ,W?POSITIVE ,W?PLUS>
		    <EQUAL? ,P-NAM ,W?GND ,W?GROUND ,W?DET>
		    <EQUAL? ,P-NAM ,W?DETONATOR ,W?INF ,W?INFORMER>
		    <EQUAL? ,P-XNAM ,W?POS ,W?POSITIVE ,W?PLUS>
		    <EQUAL? ,P-XNAM ,W?GND ,W?GROUND ,W?DET>
		    <EQUAL? ,P-XNAM ,W?DETONATOR ,W?INF ,W?INFORMER>>
		<TELL "[You must refer to the wires by their color.]" CR>
		<RETURN ,NOT-HERE-OBJECT>)>
	 <SET LEN <GET .TABLE 0>>
	 <COND (<ZERO? .LEN>
		<RFALSE>)
	       (<INTBL? ,P-IT-OBJECT <REST .TABLE 1> .LEN>
		<RETURN ,P-IT-OBJECT>)
	       (T
		<RFALSE>)>>

<ROUTINE WIRE-F ("AUX" (WIN? <>))
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? TAKE UNPLUG PULL MOVE TURN RAISE LOWER>
		<PULL-ON-WIRE>
		<RTRUE>)
	       (<VERB? CUT RIP MUNG>
		<COND (<PRSI? HANDS>
		       <PULL-ON-WIRE>
		       <RTRUE>)
		      (<PRSI? KNIFE>
		       <COND (<OR <ZERO? ,XWIRE>
				  <L? ,MINUTES 29>>
			      T)
			     (<OR <AND <PRSO? RWIRE>
				       <EQUAL? ,XWIRE <GET ,WIRE-TYPES 0>>>
				  <AND <PRSO? BWIRE>
				       <EQUAL? ,XWIRE <GET ,WIRE-TYPES 1>>>
				  <AND <PRSO? SWIRE>
				       <EQUAL? ,XWIRE <GET ,WIRE-TYPES 2>>>
				  <AND <PRSO? WWIRE>
				       <EQUAL? ,XWIRE <GET ,WIRE-TYPES 3>>>>
			      <UPDATE-SCORE 5 <>>
			      <CRLF>
			      <SET WIN? T>)>
		     ; <MAKE ,PRSO ,OPENED>
		       <TELL
"You slide the blade of the " D ,PRSI " under the " D ,PRSO
" and pull back on it as hard as you can. The thick insulation cracks under the strain, stretches, frays and splits...|
|
">
		       <ITALICIZE "Snap!">
		       <TELL 
" A shower of sparks erupts from the " D ,X5
". You lose your balance and fall backwards to the " D ,FLOOR ,PERIOD>
		       <COND (<T? .WIN?>
			      <ENDGAME>
			      <RFATAL>)
		             (<HEAR-BAKER?>
			      <KSCRUB>)>
		       <POLICE-CONVERGE>
		       <RTRUE>)
		      (<PRSI? AXE>
		       <AXE-TOO-BIG>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "could cut the wire">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PULL-ON-WIRE ()
	 <TELL "You tug on the " D ,PRSO 
", bending it this way and that. But it stubbornly refuses to break." CR>
	 <RTRUE>>

<ROUTINE AXE-TOO-BIG ()
	 <TELL CTHE ,HOPENING " in the " D ,X5
" is hardly big enough to get " D ,HANDS " through, much less the axe." CR>
	 <RTRUE>>

<OBJECT WIRES
	(DESC "mass of wires")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM WIRES MASS NETWORK)
	(ADJECTIVE COLORED COLORS)
	(ACTION WIRES-F)>

<ROUTINE WIRES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is tightly packed inside the " D ,X5
". Four of them are easily distinguishable. There's a " D ,RWIRE
", a " D ,BWIRE ", a " D ,SWIRE " and a " D ,WWIRE ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE PULL RAISE>
		<PULL-WIRES>
		<RTRUE>)
	       (<VERB? CUT RIP MUNG LOOSEN>
		<COND (<EQUAL? ,PRSI <> ,HANDS>
		       <PULL-WIRES>
		       <RTRUE>)
		      (<PRSI? AXE>
		       <AXE-TOO-BIG>
		       <RTRUE>)
		      (<PRSI? KNIFE>
		       <TELL CTHEI 
" couldn't cut more than one wire at a time." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSO "could break the wires">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PULL-WIRES ()
	 <TELL CTHEO " can be tugged only a few inches." CR>
	 <RTRUE>>

<OBJECT GCABLES
	(LOC LOCAL-GLOBALS)
	(DESC "cables")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM CABLES WIRES CABLE WIRE)
	(ADJECTIVE THICK ELECTRICAL)
	(ACTION GCABLES-F)>

<ROUTINE GCABLES-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<SEE-GADGET-IN-MANUAL>
		<RTRUE>)
	       (<VERB? TAKE UNPLUG PULL UNTIE RAISE>
		<VOICE-MUTTERS "Oh, great">
		<TELL "You yank hard on ">
		<SPARK>
		<RTRUE>)
	       (<VERB? CUT MUNG HIT>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? AXE SPADE KNIFE GNOMON LUMP>
		       <VOICE-MUTTERS "Oh, great">
		       <TELL "Your " D ,PRSI " cuts deep into ">
		       <SPARK>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would affect the cables">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPARK ()
	 <TELL "one of the " D ,PRSO 
	       ", creating an electric spark that finds its way ">
	 <RESULTING-BLAST>
	 <RTRUE>>

<OBJECT GBOLTS
	(LOC GADGET)
	(DESC "bolts")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM BOLTS BOLT)
	(ACTION GBOLTS-F)>

<ROUTINE GBOLTS-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-GADGET-IN-MANUAL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GROPES
	(LOC IN-SHACK)
	(DESC "rope")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROPES ROPE COILS COIL)
	(ACTION GROPES-F)>

<ROUTINE GROPES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO 
" lies in a hopeless tangle at your feet." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<HOPELESS-TANGLE ,GROPES>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HOPELESS-TANGLE (OBJ)
	 <TELL "You try to sort out the " D .OBJ
	       ", but it's a hopeless tangle." CR>
	 <RTRUE>>

<OBJECT HARDWARE
	(LOC IN-SHACK)
	(DESC "hardware")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM PULLEYS PULLEY HARDWARE DEBRIS)
	(ACTION HARDWARE-F)>

<ROUTINE HARDWARE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO
" is all tangled up in the " D ,GROPES ,PERIOD>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
	        <HOPELESS-TANGLE ,HARDWARE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHACK
	(LOC LOCAL-GLOBALS)
	(DESC "shack")
	(FLAGS NODESC)
	(SYNONYM SHACK CABIN SHED)
	(ACTION SHACK-F)>

<ROUTINE SHACK-F ("AUX" (IN <>))
	 <COND (<HERE? IN-SHACK>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<T? .IN>
			      <PERFORM ,V?DROP ,PRSO>
			      <RTRUE>)>
		       <PERFORM ,V?PUT ,PRSO ,SHACK-HOLE>
		       <RTRUE>)
		      (<TOUCH-SHACK?>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)
		      (<HERE? TOWER-PLAT>
		       <TELL "An " D ,CAVE-HOLE " in the " D ,PRSO
			     " leads inside." CR>
		       <RTRUE>)>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? TOWER-PLAT>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<YOUD-HAVE-TO "climb" ,TOWER>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (<HERE? ON-TOWER AT-ZERO>
		       <V-LOOK>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<COND (<T? .IN>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<TOUCH-SHACK?>
		<RTRUE>)
	       (T
		<RFALSE>)>>		       

<ROUTINE TOUCH-SHACK? ()
	 <COND (<AND <HERE? ON-TOWER AT-ZERO>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHACK-HOLE
	(LOC LOCAL-GLOBALS)
	(DESC "opening")
	(FLAGS NODESC VOWEL)
	(SYNONYM OPENING HOLE)
	(ACTION SHACK-HOLE-F)>

<ROUTINE SHACK-HOLE-F ("AUX" (IN <>))
	 <COND (<HERE? IN-SHACK>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <MOVE ,PRSO 
			     <COND (<ZERO? .IN> ,IN-SHACK) (T ,TOWER-PLAT)>>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO " disappears through the " D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-OUTSIDE SEARCH>
		<TELL CTHEO " opens ">
		<COND (<ZERO? .IN>
		       <TELL "east, into ">)
		      (T
		       <TELL "west, out of ">)>
		<TELL THE ,SHACK ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-OVER CROSS>>
		<DO-WALK <COND (<ZERO? .IN> ,P?EAST) (T ,P?WEST)>>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN ,SHACK>
		       <RTRUE>)>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (T
		<RFALSE>)>>		

<OBJECT BROOM-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "outside door")
	(FLAGS NODESC DOORLIKE OPENABLE VOWEL)
      ; (GENERIC GENERIC-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE OUTSIDE OUTER)
	(ACTION BROOM-DOOR-F)>

<ROUTINE BROOM-DOOR-F ()
	 <COND (<ONLY-ONE-DOOR?>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE ONLY-ONE-DOOR? ()
	 <COND (<NOUN-USED? ,W?DOORS ,W?DOORWAYS>
		<TELL "There's only one door here." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NROOM-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "screen door")
	(FLAGS NODESC DOORLIKE OPENABLE)
      ; (GENERIC GENERIC-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE SCREEN)
	(ACTION NROOM-DOOR-F)>

<ROUTINE NROOM-DOOR-F ()
	 <COND (<AND <HERE? NROOM>
		     <ONLY-ONE-DOOR?>>
		<RFATAL>)
	       (<VERB? LOOK-INSIDE LOOK-BEHIND>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LEFT-DOOR
	(LOC ON-PORCH)
	(DESC "left door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(GENERIC PORCH-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE LEFT LEFT\-HAND)
	(ACTION LEFT-DOOR-F)>

<ROUTINE LEFT-DOOR-F ()
	 <COND (<MULTIDOOR?>
		<RTRUE>)
	       (<THIS-PRSI?>
	        <RFALSE>)
	       (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,SEROOM-DOOR ,OPENED>
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,SEROOM-DOOR ,OPENED>
		<RFALSE>)
	       (<ENTERING?>
		<DO-WALK ,P?SW>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RIGHT-DOOR
	(LOC ON-PORCH)
	(DESC "right door")
	(FLAGS NODESC DOORLIKE OPENABLE READABLE)
	(GENERIC PORCH-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE RIGHT RIGHT\-HAND)
	(ACTION RIGHT-DOOR-F)>

<ROUTINE RIGHT-DOOR-F ()
	 <COND (<MULTIDOOR?>
		<RTRUE>)
	       (<THIS-PRSI?>
	       	<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL 
"The words PLEASE WIPE FEET are scrawled across the top of the">
	 	<OPEN-CLOSED ,PRSO>
	 	<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,NEROOM-DOOR ,OPENED>
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,NEROOM-DOOR ,OPENED>
		<RFALSE>)
	       (<ENTERING?>
		<DO-WALK ,P?NW>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MULTIDOOR? ("AUX" X)
	 <COND (<NOT <NOUN-USED? ,W?DOORS ,W?DOORWAYS>>
		<RFALSE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<ONE-AT-A-TIME "door">
		<RFATAL>)>
	 <SETG P-THEM-OBJECT ,RIGHT-DOOR>
	 <COND (<ZERO? ,NOW-PRSI?>
		<PUT ,P-NAMW 0 ,W?DOOR>
		<PUT ,P-OFW 0 <>>
		<TELL CTHE ,RIGHT-DOOR ": ">
		<SET X <PERFORM ,PRSA ,RIGHT-DOOR ,PRSI>>
		<COND (<NOT <EQUAL? .X <> ,M-FATAL>>
		       <TELL CR CTHE ,LEFT-DOOR ": "> 
		       <SET X <PERFORM ,PRSA ,LEFT-DOOR ,PRSI>>)>
		<RTRUE>)
	       (<T? ,PRSI>
		<PUT ,P-NAMW 1 ,W?DOOR>
		<PUT ,P-OFW 1 <>>
		<TELL CTHE ,RIGHT-DOOR ": ">
		<SET X <PERFORM ,PRSA ,PRSO ,RIGHT-DOOR>>
		<COND (<NOT <EQUAL? .X <> ,M-FATAL>>
		       <TELL CR CTHE ,LEFT-DOOR ": ">
		       <SET X <PERFORM ,PRSA ,PRSO ,LEFT-DOOR>>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PORCH-DOOR-F (TABLE)
	 <COND (<EQUAL? ,P-IT-OBJECT ,LEFT-DOOR ,RIGHT-DOOR>
		<RETURN ,P-IT-OBJECT>)
	       (<EQUAL? ,P-NAM ,W?DOORS ,W?DOORWAYS>
		<RETURN ,RIGHT-DOOR>)
	       (T
		<RFALSE>)>>
	
<OBJECT NEROOM-DOOR
	(LOC NEROOM)
	(DESC "front door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(GENERIC GENERIC-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE FRONT OUTSIDE OUTER)
	(ACTION NEROOM-DOOR-F)>
	
<ROUTINE NEROOM-DOOR-F ()
	 <COND (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,RIGHT-DOOR ,OPENED>
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,RIGHT-DOOR ,OPENED>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT SEROOM-DOOR
	(LOC SEROOM)
	(DESC "front door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(GENERIC GENERIC-DOOR-F)
	(ADJECTIVE FRONT)
	(ACTION SEROOM-DOOR-F)>

<ROUTINE SEROOM-DOOR-F ()
	 <COND (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,LEFT-DOOR ,OPENED>
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,LEFT-DOOR ,OPENED>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT CLOSET-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "closet door")
	(FLAGS NODESC DOORLIKE OPENABLE OPENED)
	(GENERIC GENERIC-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE CLOSET)
	(ACTION CLOSET-DOOR-F)>

<ROUTINE CLOSET-DOOR-F ()
	 <COND (<AND <HERE? IN-CLOSET>
		     <ONLY-ONE-DOOR?>>
		<RFATAL>)
	       (<AND <VERB? OPEN OPEN-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,PRSO ,OPENED>
		<MAKE ,IN-CLOSET ,LIGHTED>
		<TELL "You open the " D ,PRSO ,PERIOD>
		<COND (<HERE? IN-CLOSET>			    
		       <COND (<IS? ,SNAKE ,LIVING>
			      <PUTP ,HERE ,P?ODOR ,SNAKE>
		       	      <PUTP ,HERE ,P?HEAR ,SNAKE>)>
		       <COND (<ZERO? ,LIT?>
			      <SETG LIT? T>
		       	      <SETG OLD-HERE <>>)>)>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,PRSO ,OPENED>
		<UNMAKE ,IN-CLOSET ,LIGHTED>
		<TELL "You close the " D ,PRSO ,PERIOD>
		<COND (<HERE? IN-CLOSET>
		       <PUTP ,HERE ,P?HEAR 0>
		       <PUTP ,HERE ,P?ODOR 0>
		       <SAY-IF-HERE-LIT>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWROOM-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "outer door")
	(FLAGS NODESC DOORLIKE OPENABLE VOWEL)
	(GENERIC GENERIC-DOOR-F)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE OUTER)>

<OBJECT CLOSET
	(LOC LOCAL-GLOBALS)
	(DESC "closet")
	(FLAGS NODESC)
	(SYNONYM CLOSET)
	(ACTION CLOSET-F)>

<ROUTINE CLOSET-F ("AUX" (IN <>))
	 <COND (<HERE? IN-CLOSET>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<T? .IN>
			      <PERFORM ,V?DROP ,PRSO>
			      <RTRUE>)
			     (<IS? ,CLOSET-DOOR ,OPENED>
			      <MOVE ,PRSO ,IN-CLOSET>
			      <TELL "You put " THEO " into the " D ,PRSI
				    ,PERIOD>
			      <RTRUE>)>
		       <ITS-CLOSED ,CLOSET-DOOR>
		       <RTRUE>)>
		<RFALSE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK P?NORTH>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)
		      (<IS? ,CLOSET-DOOR ,OPENED>
		       <TELL ,YOU-SEE>
		       <PRINT-CONTENTS ,IN-CLOSET>
		       <TELL " in the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<ITS-CLOSED ,CLOSET-DOOR>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS ,FEET>>
		<PERFORM ,PRSA ,CLOSET-DOOR ,PRSI>
		<RTRUE>)
	       (<VERB? REACH-IN>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<IS? ,CLOSET-DOOR ,OPENED>
		       <TELL "You put " D ,HANDS " into the " D ,PRSO
			     ", but nothing happens." CR>
		       <RTRUE>)>
		<ITS-CLOSED ,CLOSET-DOOR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHALL
	(LOC LOCAL-GLOBALS)
	(DESC "hallway")
	(FLAGS NODESC)
	(SYNONYM HALLWAY HALL CORRIDOR)
	(ACTION SHALL-F)>

<ROUTINE SHALL-F ("AUX" (IN <>))
	 <COND (<HERE? IN-HALL>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? SWYARD>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)
		      (<HERE? NWYARD>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BATHROOM
	(LOC LOCAL-GLOBALS)
	(DESC "bathroom")
	(FLAGS NODESC)
	(SYNONYM BATHROOM TOILET)
	(ACTION BATHROOM-F)>

<ROUTINE BATHROOM-F ("AUX" (IN <>))
	 <COND (<HERE? IN-BATH>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BEDROOM
	(LOC LOCAL-GLOBALS)
	(DESC "bedroom")
	(FLAGS NODESC)
	(SYNONYM BEDROOM)
	(ACTION BEDROOM-F)>

<ROUTINE BEDROOM-F ("AUX" (IN <>))
	 <COND (<HERE? BROOM>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT KITCHEN
	(LOC LOCAL-GLOBALS)
	(DESC "kitchen")
	(FLAGS NODESC)
	(SYNONYM KITCHEN PANTRY)
	(ACTION KITCHEN-F)>

<ROUTINE KITCHEN-F ("AUX" (IN <>))
	 <COND (<HERE? SWROOM>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? SEROOM>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (<HERE? NWROOM>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RANCH
	(LOC LOCAL-GLOBALS)
	(DESC "ranch house")
	(FLAGS NODESC)
	(SYNONYM RANCH HOUSE BUILDING STRUCTURE)
	(ADJECTIVE RANCH MCDONALD)
	(ACTION RANCH-F)>

<ROUTINE RANCH-F ("AUX" (IN <>))
	 <COND (<IS? ,HERE ,INDOORS>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)>
		<TELL CTHEO
" is squat and ugly, with adobe walls and a cheap tin roof">
		<COND (<HERE? NWYARD>
		       <TELL ". A">
		       <OPEN-CLOSED ,NROOM-DOOR T>
		       <TELL " leads east, and a " D ,SHALL
			     " opens" ,TOS ,PERIOD>
		       <RTRUE>)
		      (<HERE? SWYARD>
		       <TELL ,PA D ,SHALL " opens" ,TON ,PERIOD>
		       <RTRUE>)
		      (<HERE? SEYARD>
		       <TELL ,PA "deck stands" ,TON ,PERIOD>
		       <RTRUE>)
		      (<HERE? NEYARD>
		       <TELL ". A">
		       <OPEN-CLOSED ,BROOM-DOOR T>
		       <TELL 
" leads west, and a deck stands" ,TOS ,PERIOD>
		       <RTRUE>)
		      (<HERE? ON-PORCH>
		       <TELL ". Two doors lead inside." CR>
		       <RTRUE>)
		      (<HERE? NERANCH ERANCH SERANCH>
		       <TELL ,PA "deck is attached to the front." CR>
		       <RTRUE>)>
		<PRINT ,PERIOD>		        
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? SERANCH>
		       <DO-WALK ,P?NORTH ,P?IN>
		       <RTRUE>)
		      (<HERE? NERANCH>
		       <DO-WALK ,P?SOUTH ,P?IN>
		       <RTRUE>)
		      (<HERE? ON-CIST UNDERM IN-MILL IN-CIST>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT RAMP
	(LOC LOCAL-GLOBALS)
	(DESC "ramp")
	(FLAGS NODESC SURFACE)
	(CAPACITY 50)
	(SYNONYM RAMP PLANE)
	(ADJECTIVE GENTLE)
	(ACTION RAMP-F)>

<ROUTINE RAMP-F ()
	 <COND (<VERB? EXAMINE LOOK-ON SEARCH>
		<TELL "The gentle ramp leads ">
		<COND (<HERE? ERANCH>
		       <TELL "up to the " D ,PORCH>)
		      (T
		       <TELL "down to the front yard">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,ON-PORCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PORCH
	(LOC LOCAL-GLOBALS)
	(DESC "deck")
	(FLAGS NODESC)
	(SYNONYM DECK PORCH PLATFORM)
	(ADJECTIVE FRONT RAISED)
	(ACTION PORCH-F)>

<ROUTINE PORCH-F ("AUX" (ON <>))
	 <COND (<HERE? ON-PORCH>
		<SET ON T>)>
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<COND (<ZERO? .ON>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CROSS CLIMB-OVER CLIMB-ON CLIMB-UP>>
		<COND (<T? .ON>
		       <ALREADY-IN ,PRSO T>
		       <RTRUE>)
		      (<HERE? ERANCH>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? .ON>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ICEHOUSE
	(LOC LOCAL-GLOBALS)
	(DESC "icehouse")
	(FLAGS NODESC VOWEL)
	(SYNONYM ICEHOUSE HOUSE)
	(ADJECTIVE ICE)
	(ACTION ICEHOUSE-F)>

<ROUTINE ICEHOUSE-F ("AUX" (IN <>))
	 <COND (<HERE? IHOUSE>
		<SET IN T>)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-UP>>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ISTAIR
	(LOC LOCAL-GLOBALS)
	(DESC "stairway")
	(FLAGS NODESC SURFACE)
	(CAPACITY 10)
	(SYNONYM STAIR STAIRS STAIRWAY FLIGHT)
	(ADJECTIVE STONE ROCK ICEHOUSE)
	(ACTION ISTAIR-F)>

<ROUTINE ISTAIR-F ()
	 <COND (<VERB? EXAMINE SEARCH>
		<TELL CTHEO " leads ">
		<COND (<HERE? IHOUSE>
		       <TELL "up to the " D ,SHALL>)
		      (T
		       <TELL "down into the " D ,ICEHOUSE>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,IN-HALL>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CISTAIR
	(LOC LOCAL-GLOBALS)
	(DESC "stairway")
	(FLAGS NODESC SURFACE)
	(CAPACITY 10)
	(SYNONYM STAIR STAIRS STAIRWAY FLIGHT)
	(ADJECTIVE STONE ROCK)
	(ACTION CISTAIR-F)>

<ROUTINE CISTAIR-F ()
	 <COND (<VERB? EXAMINE SEARCH>
		<TELL CTHEO " leads ">
		<COND (<HERE? SCIST>
		       <TELL "up to the edge of the " D ,RESERVOIR>)
		      (T
		       <TELL "down to the ground">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<HANDLE-STAIRS? ,ON-CIST>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RESERVOIR
	(LOC LOCAL-GLOBALS)
	(DESC "reservoir")
	(FLAGS NODESC CONTAINER OPENED WATERY)
	(SYNONYM RESERVOIR CISTERN POOL SIDE SIDES TROUGH WATER LIQUID MURK
	 	 BOTTOM)
	(ADJECTIVE LARGE BIG HUGE CATTLE CONCRETE CEMENT BLACK DARK MURKY)
	(CAPACITY 100)
	(ACTION RESERVOIR-F)>

<ROUTINE RESERVOIR-F ("AUX" (IN <>) (WATER <>) (HAT <>))
	 <COND (<HERE? UNDER-WATER>
		<SET IN T>)>
	 <COND (<NOUN-USED? ,W?WATER ,W?LIQUID ,W?MURK>
		<SET WATER T>)
	       (<NOUN-USED? ,W?BOTTOM>
		<COND (<ZERO? .IN>
		       <TELL ,CANT "see the bottom from here." CR>
		       <RFATAL>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <COND (<T? .IN>
			      <MOVE ,PRSO ,HERE>
			      <TELL CTHEO " slowly sinks to the bottom." CR>
			      <RTRUE>)
			     (<PRSO? MEEP LEM>
			      <TELL "Seeing your intent, " THEO
				    " squirms even harder." CR>
			      <RTRUE>)
			     (<PRSO? BAG EBAG>
			      <COND (<PRSO? EBAG>
				     <MOVE-ALL ,PRSO ,SOGGY>)>
			      <VANISH>
			      <MOVE ,SOGGY ,UNDER-WATER>
			      <SETG APPETITE 0>
			      <SETG CCNT 0>)
			     (T
			      <COND (<PRSO? WTK>
				     <MAKE ,PRSO ,CHILLY>)
				    (<PRSO? CAGE>
				     <DO-DROWN>)>
			      <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
			      <MOVE ,PRSO ,UNDER-WATER>)>
		       <COND (<HERE? IN-CIST ON-CIST IN-MILL>
			      <TELL "Splash! " CTHEO>
			      <COND (<AND <PRSO? LAMP>
					  <IS? ,PRSO ,LIGHTED>>
				     <TELL "'s light fades as it">)>
			      <TELL " sinks into the murky water." CR>
			      <RTRUE>)>
		       <TELL "You ">
		       <PRINTB ,P-PRSA-WORD>
		       <TELL " " THEO " over the side of the "
			     D ,RESERVOIR ". Splash!" CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<T? .WATER>
		       <LOOK-IN-RWATER>
		       <RTRUE>)
		      (<HERE? IN-CIST UNDER-WATER>
		       <V-LOOK>
		       <RTRUE>)>
		<TELL CTHEO
" resembles a big aboveground swimming pool, sixty feet long and thirty across, with tall concrete sides." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-DOWN>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)
		      (<T? .WATER>
		       <LOOK-IN-RWATER>
		       <RTRUE>)>	       
		<TELL CTHEO>
		<COND (<HERE? IN-CIST>
		       <TELL " you're in">)>
		<TELL " is filled to the brim with black, murky water." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER LEAP SWIM DIVE CLIMB-UP CLIMB-ON
			   CROSS CLIMB-OVER>>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? IN-MILL>
		       <VOICE-MUTTERS "Just stick around" <>>
		       <RTRUE>)
		      (<HERE? IN-CIST>
		       <COND (<VERB? DIVE THROUGH STAND-UNDER>
			      <DO-WALK ,P?DOWN>
			      <RTRUE>)>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? ON-CIST>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<HERE? SCIST>
		       <DO-WALK ,P?UP>
		       <COND (<VERB? LEAP SWIM DIVE>
			      <DO-WALK ,P?IN>)>
		       <RTRUE>)>
		<TELL "The sides of the " D ,PRSO " are too high." CR>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<COND (<HERE? IN-CIST UNDER-WATER>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? ON-CIST>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-UP>>
		<COND (<T? .IN>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (<HERE? IN-CIST ON-CIST>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)>
		<LOOK-IN-RWATER>
		<RTRUE>)
	       (<VERB? REACH-IN TOUCH KNOCK>
		<COND (<T? .IN>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? ON-CIST IN-CIST>
		       <TELL "You feel nothing but water." CR>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<AND <HERE? IN-MILL>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? EMPTY EMPTY-INTO>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<ZERO? .WATER>
		<RFALSE>)	       
	       (<NOT-CLEAN?>
		<RTRUE>)
	       (<VERB? EAT BITE>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE NOT-CLEAN? ()
	 <COND (<NOT <VERB? DRINK DRINK-FROM TASTE>>
		<RFALSE>)>
	 <TELL "It doesn't look very clean." CR>
	 <RTRUE>>

<ROUTINE LOOK-IN-RWATER ()
	 <COND (<HERE? UNDER-WATER>
	 	<V-LOOK>
		<RTRUE>)
	       (<NOT <HERE? IN-CIST ON-CIST>>
		<TELL "You stand on tiptoe and peer into the " D RESERVOIR
		      ". But l">)
	       (T
		<TELL "L">)>
	 <TELL "ittle can be seen beneath the murky water." CR>
	 <RTRUE>>		

<OBJECT MILL
	(LOC LOCAL-GLOBALS)
	(DESC "windmill")
	(FLAGS NODESC)
	(SYNONYM WINDMILL MILL BEAMS PLANKS LANDING SIDE SIDES TOP BOTTOM)
	(ADJECTIVE WIND WOOD WOODEN SQUAT UNSIGHTLY SQUARE)
	(GENERIC GENERIC-LANDING-F)
	(ACTION MILL-F)>

<ROUTINE MILL-F ("AUX" (ON <>))
	 <COND (<HERE? IN-MILL>
		<SET ON T>)>
	 <COND (<VERB? EXAMINE LOOK-ON>
		<COND (<ZERO? .ON>
		       <TELL CTHEO
" is a squat, unsightly affair of beams and planks. A rickety " D ,MLADDER
" climbs the side to a ">
		       <COND (<IS? ,BINOS ,TOUCHED>
			      <TELL "broken-down ">)
			     (T
			      <TELL "square ">)>
		       <TELL D ,LANDING " near the top." CR>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<ZERO? .ON>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP ENTER THROUGH FOLLOW>
		<COND (<T? .ON>
		       <ALREADY-IN ,PRSO T>
		       <RTRUE>)
		      (<HERE? UNDERM>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<ZERO? .ON>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? LOOK-UP>
		<COND (<ZERO? .ON>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? LOOK-DOWN>
		<COND (<ZERO? .ON>
		       <NOT-IN ,PRSO T>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? WALK-TO STAND-UNDER>
		<COND (<HERE? UNDERM>
		       <TELL ,YOURE-ALREADY "under the " D ,PRSO ,PERIOD>
		       <RTRUE>)
		      (<T? .ON>
		       <COND (<VERB? STAND-UNDER>
			      <DO-WALK ,P?DOWN>
			      <RTRUE>)>
		       <ALREADY-IN>
		       <RTRUE>)
		      (<HERE? NCIST>
		       <DO-WALK ,P?SE>
		       <RTRUE>)
		      (<HERE? SCIST>
		       <DO-WALK ,P?NE>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT LANDING
	(LOC IN-MILL)
	(DESC "landing")
	(FLAGS NODESC PLURAL SURFACE)
	(SYNONYM LANDING PLATFORM PLANKS PLANK)
	(ADJECTIVE GRAY GREY ROTTEN)
	(GENERIC GENERIC-LANDING-F)
	(ACTION LANDING-F)>

<ROUTINE GENERIC-LANDING-F (TABLE)
	 <RETURN ,LANDING>>

<ROUTINE LANDING-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? WATCH LISTEN CLIMB-OVER CROSS STAND-ON CLIMB-ON
		       KICK KNOCK HIT MUNG>
		<I-MILL <>>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH LOOK-INSIDE LOOK-BEHIND>
		<TELL CTHEO " overlooks the edge of the adjacent "
		      D ,RESERVOIR 
		      ". Its planks are gray and rotten with age." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? LISTEN>
		<SAY-GROANS ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MLADDER
	(LOC LOCAL-GLOBALS)
	(DESC "ladder")
	(FLAGS NODESC)
	(SYNONYM LADDER RUNGS)
	(ADJECTIVE RICKETY)
	(ACTION MLADDER-F)>

<ROUTINE MLADDER-F ("AUX" (TOP <>))
	 <COND (<HERE? IN-MILL>
		<SET TOP T>)>
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO " leads ">
		<COND (<ZERO? .TOP>
		       <TELL "up ">)
		      (T
		       <TELL "down ">)>
		<TELL "the side of the " D ,MILL ,PERIOD>
		<RTRUE>)
	       (<VERB? CLIMB-UP>
		<COND (<T? .TOP>
		       <ALREADY-AT-TOP>
		       <RTRUE>)
		      (<HERE? UNDERM>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN ESCAPE>
		<COND (<T? .TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? UNDERM>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER ENTER USE FOLLOW>
		<COND (<NOT <HERE? UNDERM IN-MILL>>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<DO-WALK <COND (<ZERO? .TOP> ,P?UP) (T ,P?DOWN)>>
		<RTRUE>)
	       (<VERB? STAND-UNDER WALK-TO>
		<COND (<T? .TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? UNDERM>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<AND <NOT <HERE? UNDERM IN-MILL>>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TOWER
	(LOC LOCAL-GLOBALS)
	(DESC "tower")
	(FLAGS NODESC)
	(SYNONYM TOWER FRAME FRAMEWORK)
	(ADJECTIVE METAL STEEL TAPERED TAPERING)
	(ACTION TOWER-F)>

<ROUTINE TOWER-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<COND (<HERE? IN-SHACK>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<HERE? AT-ZERO>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-ON>>
		<COND (<HERE? AT-ZERO>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<ALREADY-IN ,TOWER T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<COND (<HERE? AT-ZERO>
		       <NOT-IN ,TOWER T>
		       <RTRUE>)
		      (<HERE? IN-SHACK>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-UP CLIMB-OVER>
		<COND (<HERE? IN-SHACK TOWER-PLAT>
		       <ALREADY-AT-TOP>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<COND (<HERE? AT-ZERO>
		       <TELL "That's what you're doing." CR>
		       <RTRUE>)
		      (<HERE? IN-SHACK>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND>
		<COND (<HERE? AT-ZERO ON-TOWER>
		       <V-LOOK>
		       <RTRUE>)>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DTOWER
	(LOC LOCAL-GLOBALS)
	(DESC "tower")
	(FLAGS NODESC)
	(SYNONYM TOWER SHACK SHED CABIN ZERO)
	(ADJECTIVE METAL STEEL GROUND)
	(ACTION DTOWER-F)>

<ROUTINE DTOWER-F ("AUX" DIR)
	 <SET DIR <GETP ,HERE ,P?TDIR>>
	 <COND (<VERB? EXAMINE WATCH LOOK-UP>
		<TELL CTHEO " is a gray finger on the " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW>
		<COND (<ZERO? .DIR>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-ON SEARCH LOOK-BEHIND LOOK-UNDER>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<OR <VERB? LOOK-DOWN>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GDESERT
	(LOC LOCAL-GLOBALS)
	(DESC "desert")
	(FLAGS NODESC)
	(SYNONYM DESERT)
	(ACTION HERE-F)>

<OBJECT TLADDER
	(LOC LOCAL-GLOBALS)
	(DESC "ladder")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM LADDER)
	(ACTION TLADDER-F)>

<ROUTINE TLADDER-F ("AUX" (TOP <>))
	 <COND (<HERE? TOWER-PLAT>
		<SET TOP T>)>
	 <COND (<VERB? LOOK-DOWN LOOK-UNDER>
		<LOOK-AT-ZERO>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " leads ">
		<COND (<T? .TOP>
		       <TELL "down to the ground." CR>
		       <RTRUE>)>
		<TELL "up into the tower." CR>
		<RTRUE>)
	       (<VERB? CLIMB-UP>
		<COND (<ZERO? .TOP>
		       <DO-WALK ,P?UP>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<COND (<HERE? AT-ZERO>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<EXITING?>
		<COND (<HERE? ON-TOWER>
		       <V-WALK-AROUND>
		       <RTRUE>)>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER ENTER USE FOLLOW>
		<COND (<T? .TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? AT-ZERO>
		       <DO-WALK P?UP>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? STAND-UNDER WALK-TO>
		<COND (<HERE? AT-ZERO>
		       <ALREADY-AT-BOTTOM>
		       <RTRUE>)
		      (<VERB? STAND-UNDER>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<ZERO? .TOP>
		       <ALREADY-IN ,PRSO T>
		       <RTRUE>)>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-AT-ZERO ()
	 <COND (<HERE? AT-ZERO>
		<ALREADY-AT-BOTTOM>
		<RTRUE>)
	       (<HERE? TOWER-PLAT>
		<TELL "The width of the " D ,TPLAT
		      " makes it hard to see what's directly below." CR>
		<RTRUE>)>
	 <TELL CTHE ,GROUND " is about fifty feet below." CR>
	 <RTRUE>>

<OBJECT TPLAT
	(LOC TOWER-PLAT)
	(DESC "platform")
	(FLAGS NODESC SURFACE)
	(CAPACITY 50)
	(SYNONYM PLATFORM)
	(ACTION TPLAT-F)>

<ROUTINE TPLAT-F ()
	 <COND (<VERB? EXAMINE LOOK-ON SEARCH>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-DOWN LOOK-UNDER>
		<LOOK-AT-ZERO>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CROSS CLIMB-OVER FOLLOW>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-ON>>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<VERB? SIT LIE-DOWN>
		<TELL CTHEO " is too narrow." CR>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? CLIMB-UP>
		<ALREADY-AT-TOP>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RAIL
	(LOC TOWER-PLAT)
	(DESC "rail")
	(FLAGS NODESC FERRIC TRYTAKE NOALL)
	(SYNONYM RAIL RAILING)
	(ADJECTIVE METAL)
	(ACTION RAIL-F)>

<ROUTINE RAIL-F ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,P-PRSA-WORD ,W?HOLD ,W?GRAB>
		     <THIS-PRSO?>>
		<TELL "Don't worry. You won't fall." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<OBJECT TROPES
	(LOC LOCAL-GLOBALS)
	(DESC "ropes and cables")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM ROPES ROPE CABLES CABLE WIRES WIRE)
	(ADJECTIVE DANGLING SWAYING)
	(ACTION TROPES-F)>

<ROUTINE TROPES-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO
" sway back and forth against the dark sky." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHE ,TROPES " are out of your reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NWROAD
	(LOC LOCAL-GLOBALS)
	(DESC "northwest road")
	(FLAGS NODESC)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE NORTHWEST NW PAVED)
	(ACTION NWROAD-F)>

<ROUTINE NWROAD-F ()
	 <COND (<HANDLE-DESERT-ROAD? ,P?NW "southeast" "northwest">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SWROAD
	(LOC LOCAL-GLOBALS)
	(DESC "southwest road")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE SOUTHWEST SW PAVED)
	(ACTION SWROAD-F)>

<ROUTINE SWROAD-F ()
	 <COND (<HANDLE-DESERT-ROAD? ,P?SW "northeast" "southwest">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SROAD
	(LOC LOCAL-GLOBALS)
	(DESC "south road")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE SOUTH S SOUTHERN PAVED)
	(ACTION SROAD-F)>

<ROUTINE SROAD-F ()
	 <COND (<HANDLE-DESERT-ROAD? ,P?SOUTH "north" "south">
		<RTRUE>)
	       (T
		<RFALSE>)>>

"DDIR = P?DIR from tower, TSTR = tower dir, DSTR = desert dir."

<ROUTINE HANDLE-DESERT-ROAD? (DDIR TSTR DSTR)
	 <COND (<EXAMINING-ROAD?>
		<TELL "The road leads ">
		<COND (<NOT <HERE? AT-ZERO>>
		       <TELL .TSTR>
		       <COND (<GLOBAL-IN? ,DTOWER ,HERE>
			      <TELL " towards the " D ,DTOWER ",">)>
		       <TELL " and ">)>
		<TELL .DSTR " " ,INTO-DESERT ,PERIOD>
		<RTRUE>)
	       (<USING-ROAD?>
		<COND (<HERE? AT-ZERO>
		       <DO-WALK .DDIR>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT D5ROAD
	(LOC LOCAL-GLOBALS)
	(DESC "dirt road")
	(FLAGS NODESC)
	(SYNONYM ROAD PATH TRAIL)
	(ADJECTIVE DIRT)
	(ACTION D5ROAD-F)>

<ROUTINE D5ROAD-F ()
	 <COND (<BORING-ROAD? ,D5>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT D11ROAD
	(LOC LOCAL-GLOBALS)
	(DESC "dirt road")
	(FLAGS NODESC)
	(SYNONYM ROAD PATH TRAIL)
	(ADJECTIVE DIRT)
	(ACTION D11ROAD-F)>

<ROUTINE D11ROAD-F ()
	 <COND (<BORING-ROAD? ,S75>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BORING-ROAD? (NW)
	 <COND (<EXAMINING-ROAD?>
		<TELL CTHEO " leads ">
		<COND (<EQUAL? ,HERE .NW>
		       <TELL "southeast." CR>
		       <RTRUE>)>
		<TELL "northwest." CR>
		<RTRUE>)
	       (<USING-ROAD?>
		<DO-WALK <COND (<EQUAL? ,HERE .NW> ,P?SE) (T ,P?NW)>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXAMINING-ROAD? ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-DOWN LOOK-UP SEARCH LOOK-BEHIND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE USING-ROAD? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? FOLLOW ENTER WALK-TO THROUGH TAKE USE CROSS
		       CLIMB-ON CLIMB-OVER CLIMB-UP CLIMB-DOWN>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SEROAD
	(LOC LOCAL-GLOBALS)
	(DESC "southeast road")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE SOUTHEAST SE PAVED)
	(ACTION SEROAD-F)>

<ROUTINE SEROAD-F ()
	 <COND (<EXAMINING-ROAD?>
	       	<TELL "The road bends southeast, " ,INTO-DESERT ,PERIOD>
	        <RTRUE>)
	       (<USING-ROAD?>
	        <DO-WALK ,P?SE>
	        <RTRUE>)
	       (<EXITING?>
	        <V-WALK-AROUND>
	        <RTRUE>)
	       (T
	        <RFALSE>)>>

<OBJECT NROAD
	(LOC S75)
	(DESC "northwest road")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE NORTHWEST NW PAVED)
	(ACTION NROAD-F)>

<ROUTINE NROAD-F ()
	 <COND (<EXAMINING-ROAD?>
	        <TELL "The road curves northwest, " ,INTO-DESERT ,PERIOD>
	        <RTRUE>)
	       (<USING-ROAD?>
	        <DO-WALK ,P?NW>
	        <RTRUE>)
	       (<EXITING?>
	        <V-WALK-AROUND>
	        <RTRUE>)
	       (T
	        <RFALSE>)>>

<OBJECT PROAD
	(LOC NEPASS)
	(DESC "paved road")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE PAVED)
	(ACTION PROAD-F)>

<ROUTINE PROAD-F ()
	 <COND (<EXAMINING-ROAD?>
		<TELL CTHEO " leads southeast and northwest, "
		      ,INTO-DESERT ,PERIOD>
		<RTRUE>)
	       (<OR <USING-ROAD?>
		    <EXITING?>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT DTRAIL
	(LOC LOCAL-GLOBALS)
	(DESC "dirt trail")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM TRAIL)
	(ADJECTIVE DIRT)
	(ACTION DTRAIL-F)>

<ROUTINE DTRAIL-F ()
	 <COND (<EXAMINING-ROAD?>
		<TELL CTHEO " bends ">
		<COND (<HERE? N25>
		       <TELL "sou">)
		      (T
		       <TELL "nor">
		       <COND (<HERE? WZERO>
			      <TELL "th and sou">)>)>
		<TELL "th around the " D ,DTOWER ,PERIOD>
		<RTRUE>)
	       (<USING-ROAD?>
		<COND (<HERE? N25>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)
		      (<HERE? W25>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RANCH-ROAD
	(LOC LOCAL-GLOBALS)
	(DESC "paved road")
	(FLAGS NODESC)
	(SYNONYM ROAD PATH PAVEMENT PAVING)
	(ADJECTIVE PAVED)
	(ACTION RANCH-ROAD-F)>

<ROUTINE RANCH-ROAD-F ()
	 <COND (<EXAMINING-ROAD?>
	       	<TELL CTHEO>
		<COND (<HERE? AT-TNT NWRANCH>
		       <TELL " leads northeast towards the " D ,DTOWER
			     ", and ">
		       <COND (<HERE? AT-TNT>
			      <TELL "southeast " ,INTO-DESERT>)
			     (T
			      <TELL "bends east along the north side of the "
				    D ,SWALL>)>)
		      (T
		       <TELL " bends ">
		       <COND (<HERE? NERANCH>
		       	      <TELL "west and sou">)
		      	     (T
		       	      <TELL "nor">)>
		       <TELL "th, along the outside of the " D ,SWALL>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<USING-ROAD?>
	        <COND (<HERE? ERANCH>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)>
	        <V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
	        <V-WALK-AROUND>
	        <RTRUE>)
	       (T
	        <RFALSE>)>>

<OBJECT FHILLS
	(LOC LOCAL-GLOBALS)
	(DESC "foothills")
	(FLAGS NODESC PLURAL)
	(SYNONYM FOOTHILLS FOOTHILL HILLS HILL SLOPE)
	(ADJECTIVE RUGGED)
	(ACTION FHILLS-F)>

<ROUTINE FHILLS-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-UP SEARCH>
		<TELL CTHEO 
" are as rugged and formidable as the " D ,DMOUNTS " beyond them." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-UP CROSS CLIMB-OVER>>
		<FHILLS-TOO-STEEP>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<NOT-IN>
		<RTRUE>)
	       (<OR <VERB? LOOK-BEHIND>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE FHILLS-TOO-STEEP ()
	 <TELL CTHE ,FHILLS " are much too steep and rugged to climb." CR>
	 <RFALSE>>

<OBJECT DMOUNTS
	(LOC LOCAL-GLOBALS)
	(DESC "mountains")
	(FLAGS NODESC PLURAL)
	(SYNONYM MOUNTAINS PEAKS MOUNTAIN PEAK RANGE OSCUROS)
	(ADJECTIVE MOUNTAIN OSCURO)
	(ACTION DMOUNTS-F)>

<ROUTINE DMOUNTS-F ()
	 <COND (<VERB? EXAMINE LOOK-ON SEARCH LOOK-UP>
		<TELL CTHEO " loom on the eastern " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-UP CROSS CLIMB-OVER>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<NOT-IN>
		<RTRUE>)
	       (<OR <VERB? LOOK-BEHIND>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<OBJECT BOOK
	(LOC IN-SHACK)
	(DESC "book")
	(FDESC "A paperback book is lying in the corner.")
	(FLAGS TAKEABLE OPENABLE CONTAINER SURFACE)
	(SYNONYM BOOK PAPERBACK PAGE PAGES COVER COVERS)
	(ADJECTIVE PAPERBACK CHEAP)
	(VALUE 0)
	(SIZE 3)
	(MASS 2)
	(ACTION BOOK-F)>

<ROUTINE BOOK-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <ITS-CLOSED ,PRSI>
			      <RTRUE>)>
		       <TELL CTHEO>
		       <COND (<PRSO? MARKER>
			      <MOVE ,PRSO ,PRSI>
			      <TELL " slips between the pages." CR>
			      <RTRUE>)
			     (<G? <GETP ,PRSO ,P?SIZE> 1>
			      <TELL " wouldn't fit in the book." CR>
			      <RTRUE>)>
		       <TELL " falls out of the book and ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "It's a cheap paperback called ">
		<ITALICIZE "Desert Island Decameron.">
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH UNFOLD>
		     <EQUAL? ,PRSI <> ,HANDS>
		     <NOT <IS? ,PRSO ,OPENED>>>
		<MAKE ,PRSO ,OPENED>
		<COND (<IN? ,MARKER ,PRSO>
		       <MOVE ,MARKER ,HERE>
		       <SETG P-IT-OBJECT ,MARKER>
		       <TELL "A " D ,MARKER
" falls out of the book as you open it." CR>
		       <RTRUE>)>
		<TELL "You open the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? READ LOOK-ON LOOK-INSIDE SEARCH TURN TURN-TO>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <YOUD-HAVE-TO "be holding" ,PRSO>
		       <RTRUE>)
		      (<NOT <IS? ,PRSO ,OPENED>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <CRLF>)>
		<TELL 
"You flip through the book, but nothing catches your eye." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MARKER
	(LOC BOOK)
	(DESC "slip of cardboard")
	(FLAGS TAKEABLE READABLE SURFACE)
	(CAPACITY 0)
	(SYNONYM CARDBOARD CARD BOOKMARK SLIP LINES POEM POETRY STANZA
	 	 DIAGRAM LEGEND)
	(ADJECTIVE INTERSECTING)
	(VALUE 1)
	(SIZE 0)
	(MASS 1)
	(ACTION MARKER-F)>

"SEEN = verse read, CHILLY = diagram read."

<ROUTINE MARKER-F ("AUX" (D <>))
	 <COND (<OR <NOUN-USED? ,W?DIAGRAM ,W?LINES ,W?LEGEND>
		    <ADJ-USED? ,W?INTERSECTING>>
		<SET D T>)>
	 <COND (<AND <T? .D>
		     <NOT <IS? ,MARKER ,TOUCHED>>>
		<TELL "You haven't seen any here." CR>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <NO-GOOD-SURFACE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ SEARCH>
		<COND (<T? .D>
		       <TELL 
"The diagram is a meaningless network of intersecting lines. The legend \"RD=" <GET ,WIRE-TYPES 0>
			     " BL=" <GET ,WIRE-TYPES 1>
			     " ST=" <GET ,WIRE-TYPES 2> 
			     " WH=" <GET ,WIRE-TYPES 3>
			     "\" is ">
		       <SAY-SCRIBBLED>
		       <COND (<NOT <IS? ,PRSO ,CHILLY>>
		       	      <MAKE ,PRSO ,CHILLY>
		       	      <UPDATE-SCORE 3>)>
			<RTRUE>)
		      (<NOUN-USED? ,W?POETRY ,W?STANZA ,W?POEM>
		       <TELL "It's a send-up of a famous Emerson poem." CR>
		       <COND (<NOT <IS? ,PRSO ,SEEN>>
		       	      <MAKE ,PRSO ,SEEN>
		       	      <SETG DO-WINDOW <GET ,QUOTES ,EMERSON>>
		       	      <RFATAL>)>
		       <RTRUE>)>
		<TELL CTHEO
" seems to have been used as a bookmark. A stanza of poetry is typed on ">
		<COND (<IN? ,PRSO ,PLAYER>
		       <MAKE ,PRSO ,TOUCHED>
		       <TELL 
"one side. The other side is covered with some kind of diagram." CR>
		       <RTRUE>)
		      (T
		       <TELL "the side you can see." CR>)>
		<RTRUE>)
	       (<AND <VERB? TURN SPIN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IN? ,PRSO ,PLAYER>
		       <TELL "You turn the " D ,PRSO
			     " over in " D ,HANDS "s." CR>
		       <RTRUE>)>
		<YOUD-HAVE-TO "be holding" ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-SCRIBBLED ()
	 <TELL "scribbled across the bottom." CR>
	 <RTRUE>>
	
<OBJECT CSURFACE
	(LOC UNDER-WATER)
	(DESC "surface")
	(FLAGS NODESC)
	(SYNONYM SURFACE)
	(ACTION CSURFACE-F)>

<ROUTINE CSURFACE-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-UP>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<PRINT ,YOU-SEE>
		<PRINT-CONTENTS ,HERE>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SWIM CLIMB-UP CLIMB-ON>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? DIVE CLIMB-DOWN CLIMB-OVER CROSS LOOK-BEHIND>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BINOS
	(LOC IN-MILL)
	(DESC "pair of binoculars")
	(FDESC
"Somebody has left a nice pair of binoculars at the landing's edge.")
	(FLAGS TAKEABLE CLOTHING)
	(SYNONYM BINOCULAR GLASSES BINOCS PAIR SET STRAP)
	(ADJECTIVE NICE BINOCULAR PAIR SET)
	(VALUE 1)
	(SIZE 4)
	(MASS 4)
	(ACTION BINOS-F)>

<ROUTINE WITH-BINOS ()
	 <TELL "Peering closely, you can see that ">
	 <RTRUE>>

<GLOBAL BSEEN:OBJECT <>> "Last object focused."

<ROUTINE BINOS-F ()
	 <SETG P-THEM-OBJECT ,BINOS>
	 <COND (<AND <THIS-PRSO?>
		     <NOUN-USED? ,W?STRAP>>
		<COND (<VERB? TIE-UP TIE UNTANGLE FOLD UNFOLD SWING PLAY>
		       <COND (<NOT <IN? ,PRSO ,PLAYER>>
			      <YOUD-HAVE-TO "be holding" ,PRSO>
			      <RTRUE>)>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<OR <VERB? EXAMINE>
			   <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		       <TELL "The strap is ">
		       <ATTACHED-TO>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? LOOK-THRU>
		       <COND (<NOT <IN? ,PRSI ,PLAYER>>
			      <YOUD-HAVE-TO "be holding" ,PRSI>
			      <RTRUE>)
			     (<AND <PRSO? BBOX TKEY>
				   <NOT <IS? ,PRSO ,SEEN>>>
			      <REFERRING>
			      <RFATAL>)
			     (<OR <GOT? ,PRSO>
				  <PRSO? ME HANDS FEET POCKET GROUND
					 EYES ANKLE MOUTH HEAD>>
			      <TELL CTHEI " won't focus that closely." CR>
			      <RTRUE>)
			     (<NOT <EQUAL? ,BSEEN ,PRSO>>
			      <SETG BSEEN ,PRSO>
			      <TELL "You focus the binoculars on " 
				    THEO ,PCR>)>
		       <COND (<PRSO? SBUNK SBENTRY>
			      <TELL "The inside of the " D ,PRSO
" is only about twenty feet square. Every inch is crowded with technicians, tending racks filled with electrical " D ,MIKE ,PCR 
"One technician is hunched over a stool, clutching a microphone. The tension in his grasp is reflected on every face" ,PCR>
			      <SETG P-IT-OBJECT ,BBOX>
			      <COND (<NOT <IS? ,BBOX ,SEEN>>
				     <MAKE ,BBOX ,SEEN>
				     <MOVE ,BBOX ,S100>			      
				     <TELL
"As your eyes take in the maze of " D ,MIKE
", you notice a long wooden box, similar to the one you saw under the " 
D ,TOWER>)
				    (T
				     <TELL 
"There's a long wooden box lying across the " D ,FLOOR>)>
			      <MENTION-TKEY>
			      <COND (<VISIBLE? ,MEEP>
				     <MAKE ,MEEP ,SEEN>
				     <TELL CR ,CTHEMEEP
"cranes its neck and peers into the " D ,SBUNK
", its sharp eyes keen with interest." CR>)>
			      <COND (<NOT <IS? ,TKEY ,SEEN>>
				     <MAKE ,TKEY ,SEEN>
				     <UPDATE-SCORE 3>)>
			      <RTRUE>)
			     (<PRSO? DTOWER>
			      <WITH-BINOS>
			      <TELL THE ,SPOT " is">
			      <COND (<IS? ,SPOT ,SEEN>
				     <TELL " still">)
				    (T
				     <TELL "n't">)>
			      <TELL " shining on the " D ,DTOWER>
			      <COND (<NOT <IS? ,SPOT ,SEEN>>
				     <TELL " anymore">)>
			      <PRINT ,PERIOD>
			      <RTRUE>)
			     (<PRSO? NBUNKERS>
			      <WITH-BINOS>
			      <TELL THEO " are heavily manned." CR>
			      <RTRUE>)
			     (<PRSO? SPOT SLIGHT>
			      <TELL CTHEO " appears very bright." CR>
			      <RTRUE>)
			     (<PRSO? GDESERT DMOUNTS FHILLS>
			      <WITH-BINOS>
			      <TELL THEO>
			      <IS-ARE>
			      <TELL "barren and featureless." CR>
			      <RTRUE>)
			     (<IS? ,PRSO ,PLURAL>
			      <TELL "They appear ">)
			     (<AND <NOT <PRSO? MEEP LEM DOG>>
				   <IS? ,PRSO ,PERSON>>
			      <TELL "He appears ">)
			     (T
			      <TELL "It appears ">)>
		       <TELL "much closer now." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL 
"The binoculars are of standard Army issue, with a strap for wearing." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Everything appears much closer." CR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<TELL "A loud, plaintive ">
		<ITALICIZE "creak">
		<TELL " makes you draw " D ,HANDS 
" back in alarm. You hold " D ,BREATH " as the " D ,LANDING 
" sways uncertainly for a moment, back and forth">
		<ALL-IS-STILL>
		<TELL CR 
"Slowly, carefully, you stretch your arm towards the " D ,PRSO ".." ,PCR>
		<SPILL-MILL>
		<RFATAL>)
	       (<AND <VERB? OPEN OPEN-WITH CLOSE REACH-IN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<VERB? ADJUST PLAY>
		<TELL "You fiddle aimlessly with the controls." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MENTION-TKEY ()
	 <COND (<IN? ,TKEY ,BBOX>
		<SETG P-IT-OBJECT ,TKEY>
		<TELL ,PA D ,TKEY
" is visible in its open " D ,PADLOCK>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE SPILL-MILL ("AUX" L)
	 <COND (<EQUAL? <LOC ,CAGE> ,PLAYER ,IN-MILL>
		<DO-DROWN>)>
	 <SET L <LOC ,WTK>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER ,IN-MILL>
		    <IN? .L ,PLAYER>>
		<MAKE ,WTK ,CHILLY>)>
	 <SET L <LOC ,BAG>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER ,IN-MILL>
		    <IN? .L ,PLAYER>>
		<MOVE ,SOGGY .L>
		<REMOVE ,BAG>
		<SETG APPETITE 0>
		<SETG CCNT 0>)>
	 <SET L <LOC ,EBAG>>
	 <COND (<ZERO? .L>
		T)
	       (<OR <EQUAL? .L ,PLAYER ,IN-MILL>
		    <IN? .L ,PLAYER>>
		<MOVE-ALL ,EBAG ,SOGGY>
		<MOVE ,SOGGY .L>
		<REMOVE ,EBAG>)>	 
	 <SET L <LOC ,MEEP>>
	 <COND (<EQUAL? .L ,PLAYER ,IN-MILL>
		<EXIT-MEEP>
		<MOVE ,DMEEP .L>
		<MAKE ,DMEEP ,CHILLY>)>
	 <DEQUEUE I-MILL>
	 <MAKE ,BINOS ,TOUCHED>
	 <PUTP ,BINOS ,P?FDESC 0>
	 <DROP-ALL ,UNDER-WATER>
	 <UNMAKE ,IN-CIST ,TOUCHED>
	 <UNMAKE ,UNDER-WATER ,TOUCHED>
	 <UNMAKE ,UNDERM ,TOUCHED>
	 <COND (<T? ,BREATH-HELD?>
		<SETG BREATH-HELD? 1>)>
	 <ITALICIZE "Crack!">
	 <TELL " The " D ,LANDING
" tips wildly under your feet. You manage a brief, hysterical shriek...">
	 <CARRIAGE-RETURNS>
	 <TELL "... and your mouth fills with water" ,PCR>
	 <GOTO ,IN-CIST>
	 <MOVE-ALL ,IN-MILL ,UNDER-WATER>
	 <RTRUE>>

<ROUTINE DO-DROWN ()
	 <COND (<IN? ,LEM ,CAGE>
		<EXIT-LEM>
		<MAKE ,DLEM ,CHILLY>
		<MOVE ,DLEM ,CAGE>)>
	 <COND (<IN? ,MAGPIE ,CAGE>
		<EXIT-MAGPIE>
		<MAKE ,DMAGPIE ,CHILLY>
		<MOVE ,DMAGPIE ,CAGE>)>
	 <COND (<IN? ,MEEP ,CAGE>
	        <EXIT-MEEP>
		<MAKE ,DMEEP ,CHILLY>
		<MOVE ,DMEEP ,CAGE>)>
	 <RTRUE>>

<OBJECT DLEM
	(DESC "dead lemming")
	(FLAGS TAKEABLE)
	(VALUE 0)
	(SIZE 3)
	(MASS 3)
	(SYNONYM LEMMING RODENT ANIMAL)
	(ADJECTIVE DEAD DROWNED BROWN SMALL TINY FURRY INCINERAT
	 	   BURNED CREMATED)
	(ACTION DEAD-ANIMAL-F)>
 
"CHILLY = drowned, NOGRASS = dropped."

<OBJECT DMAGPIE
	(DESC "dead magpie")
	(FLAGS TAKEABLE)
	(SYNONYM MAGPIE BIRD)
	(ADJECTIVE DEAD BLACK WHITE DROWNED INCINERAT BURNED CREMATED)
	(VALUE 0)
	(SIZE 3)
	(MASS 3)
	(ACTION DEAD-ANIMAL-F)>

"CHILLY = drowned."

<OBJECT DMEEP
	(DESC "dead roadrunner")
	(FLAGS TAKEABLE)
	(SYNONYM ROADRUNNER BIRD)
	(ADJECTIVE DEAD DROWNED)
	(VALUE 0)
	(SIZE 5)
	(MASS 5)
	(GENERIC GENERIC-BIRD-F)
	(ACTION DEAD-ANIMAL-F)>

"CHILLY = drowned."

<ROUTINE DEAD-ANIMAL-F ("AUX" X)
	 <SET X <COND (<THIS-PRSO?> ,PRSO) (T ,PRSI)>>
	 <COND (<OR <AND <ADJ-USED? ,W?DROWNED>
		     	 <NOT <IS? .X ,CHILLY>>>
		    <AND <ADJ-USED? ,W?CREMATED ,W?INCINERAT ,W?BURNED>
			 <IS? .X ,CHILLY>>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<VERB? EXAMINE>
		<TELL "It's dead.">
		<COND (<IS? ,PRSO ,NOGRASS>
		       <CRLF>
		       <RTRUE>)
		      (<IS? ,PRSO ,CHILLY>
		       <TELL " Drown">)
		      (T
		       <TELL " Cremat">)>
		<TELL "ed, as a matter of fact." CR>
		<RTRUE>)
	       (<VERB? KILL>
		<ITS-ALREADY "dead">
		<RTRUE>)
	       (<VERB? KISS>
		<V-RAPE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT BOX
	(LOC AT-ZERO)
	(DESC "box")
	(FLAGS TAKEABLE TRYTAKE SURFACE OPENABLE)
	(SYNONYM BOX LID)
	(ADJECTIVE WOODEN WOODEN LONG)
	(CAPACITY 15)
	(DESCFCN DESCRIBE-BOX)
	(ACTION BOX-F)>

<ROUTINE DESCRIBE-BOX ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A">
	 <OPEN-CLOSED ,BOX T>
	 <COND (<BOX-LOCKED?>
		<TELL ", locked with a steel " D ,PADLOCK ",">)>
	 <TELL " is lying" ,AGROUND " nearby.">
	 <COND (<SEE-ANYTHING-IN? ,BOX>
		<COND (<IS? ,BOX ,OPENED>
		       <TELL " Inside ">)
		      (T
		       <TELL " On it ">)>
		<TELL "you see ">
		<PRINT-CONTENTS ,BOX>
		<TELL ".">)>
	 <RTRUE>>
		     
<ROUTINE BOX-LOCKED? ()
	 <COND (<AND <NOT <IS? ,BOX ,OPENED>>
		     <IN? ,PADLOCK ,BOX>
		     <IS? ,PADLOCK ,LOCKED>
		     <IS? ,PADLOCK ,NODESC>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BAG-IN-BOX? ()
	 <COND (<NOT <PRSO? BAG>>
		<RFALSE>)>
	 <MOVE ,PRSO ,AT-ZERO>
	 <TELL "The top-heavy " D ,PRSO " falls ">
	 <COND (<VERB? PUT>
		<TELL "out of the shallow">)
	       (T
		<TELL "off the">)>
	 <TELL " box and lands at your feet." CR>
	 <RTRUE>>

<ROUTINE BOX-F ("AUX" (L <>))
	 <SET L <BOX-LOCKED?>>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<NOT <IS? ,PRSI ,OPENED>>
			      <ITS-CLOSED ,PRSI>
			      <RTRUE>)
			     (<BAG-IN-BOX?>
			      <RTRUE>)>
		       <RFALSE>)
		      (<AND <VERB? PUT-ON>
			    <BAG-IN-BOX?>>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "The">
		<OPEN-CLOSED ,PRSO>
		<TELL " is several feet in length">
		<COND (<T? .L>
		       <TELL ", and secured with a steel " D ,PADLOCK>)>
		<COND (<AND <NOT <IS? ,PRSO ,OPENED>>
			    <SEE-ANYTHING-IN? ,PRSO>>
		       <TELL ". On it you see ">		       
		       <PRINT-CONTENTS ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<IS? ,PRSO ,OPENED>
		       <PRINT ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " inside the box." CR>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <COND (<AND <IN? ,PADLOCK ,PRSO>
				   <IS? ,PADLOCK ,NODESC>>
			      <SETG P-IT-OBJECT ,PADLOCK>
			      <YOUD-HAVE-TO "take off" ,PADLOCK>
			      <RTRUE>)>
		       <OPEN-BOX>
		       <RTRUE>)
		      (<PRSI? TKEY>
		       <COND (<T? .L>
			      <SET L <PERFORM ,V?UNLOCK ,PADLOCK ,PRSI>>
			      <CRLF>
			      <OPEN-BOX>
			      <RTRUE>)>
		       <BOX-NOT-LOCKED>
		       <RTRUE>)
		      (<PRSI? AXE SPADE>
		       <HURT-BOX>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would open the box">
		<RTRUE>)
	       (<VERB? UNLOCK>
		<COND (<ZERO? .L>
		       <BOX-NOT-LOCKED>
		       <RTRUE>)
		      (<PRSI? TKEY>
		       <SET L <PERFORM ,V?UNLOCK ,PADLOCK ,PRSI>>
		       <CRLF>
		       <OPEN-BOX>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would unlock the box">
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<NOT <IS? ,PRSO ,OPENED>>
		       <ITS-ALREADY "closed">
		       <RTRUE>)
		      (<IN? ,MEEP ,PRSO>
		       <YOUD-HAVE-TO "take out" ,MEEP>
		       <RTRUE>)>
		<UNMAKE ,PRSO ,OPENED>
		<UNMAKE ,PRSO ,CONTAINER>
		<MAKE ,PRSO ,SURFACE>
		<MOVE-ALL ,PRSO ,IN-BOX>
		<TELL "You swing the lid of the box shut." CR>
		<RTRUE>)
	       (<VERB? HIT CUT MUNG KICK>
		<COND (<OR <VERB? KICK>
			   <EQUAL? ,PRSI <> ,HANDS ,FEET>>
		       <BEST-KARATE>
		       <RTRUE>)
		      (<PRSI? LUMP AXE SPADE>
		       <HURT-BOX>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would affect the box">
		<RTRUE>)
	       (<AND <VERB? LOCK>
		     <T? ,PRSI>>
		<COND (<T? .L>
		       <ITS-ALREADY "locked">
		       <RTRUE>)
		      (<PRSI? TKEY>
		       <TELL ,DONT "need the key to do that." CR>
		       <RTRUE>)
		      (<OR <PRSI? PADLOCK>
			   <AND <PRSI? HANDS>
				<IN? ,PADLOCK ,PLAYER>>>
		       <COND (<IS? ,PRSO ,OPENED>
			      <SET L <PERFORM ,V?CLOSE ,PRSO>>
		       	      <CRLF>)>
		       <COND (<NOT <IN? ,PADLOCK ,PRSO>>
			      <SET L <PERFORM ,V?PUT ,PADLOCK ,PRSO>>
			      <CRLF>)>
		       <SET L <PERFORM ,V?CLOSE ,PADLOCK>>
		       <RTRUE>)
		      (<PRSI? HANDS>
		       <TELL ,DONT "have the " D ,PADLOCK ,PERIOD>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would lock the box">
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<PRSO-TOO-BIG>
		<RTRUE>)
	       (T
		<RFALSE>)>>
			      
<ROUTINE HURT-BOX ()
	 <TELL "You'd probably damage the box's contents" ,IF-YOU-DID>
	 <RTRUE>>

<ROUTINE BOX-NOT-LOCKED ()
	 <TELL "The box isn't locked." CR>
	 <RTRUE>>

<ROUTINE OPEN-BOX ("AUX" OBJ NXT (CNT 0) 1ST)
	 <SET OBJ <FIRST? ,BOX>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RETURN>)>
		 <SET NXT <NEXT? .OBJ>>
		 <COND (<IS? .OBJ ,TAKEABLE>
			<UNMAKE .OBJ ,NODESC>
		 	<MOVE .OBJ ,AT-ZERO>
			<SET 1ST .OBJ>
			<INC CNT>)>
		 <SET OBJ .NXT>>
	 
	 <COND (<ZERO? .CNT>
		<TELL "You swing open the lid of the box">)
	       (T
		<COND (<EQUAL? .CNT 1>
		       <TELL CTHE .1ST>)
	       	      (T
		       <TELL "Everything">)>
	 	<TELL " slides off the lid of the box as you swing it open">)>
	 
	 <MAKE ,BOX ,OPENED>
	 <MAKE ,BOX ,CONTAINER>
	 <UNMAKE ,BOX ,SURFACE>	 
	 <MOVE-ALL ,IN-BOX ,BOX>
	 <TELL ", revealing ">
	 <PRINT-CONTENTS ,BOX>
	 <TELL " inside." CR>
	 <RTRUE>>
		 
"Holds contents of box when box is closed."

<OBJECT IN-BOX
	(FLAGS NODESC CONTAINER OPENED)>	 

<OBJECT PADLOCK
	(LOC BOX)
	(DESC "padlock")
	(FLAGS NODESC LOCKED TRYTAKE NOALL CONTAINER OPENED OPENABLE)
	(SYNONYM PADLOCK LOCK HUNK)
	(ADJECTIVE FORMIDABLE HARDENED HARD STEEL METAL)
	(ACTION PADLOCK-F)>

<ROUTINE PADLOCK-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<PRSO? TKEY>
			      <MOVE ,PRSO ,PRSI>
			      <TELL "You slide the " D ,PRSO>)
			     (<G? <GETP ,PRSO ,P?SIZE> 1>
			      <TELL "You'd never fit " THEO>)
			     (<IN? ,TKEY ,PRSI>
			      <YOUD-HAVE-TO "take out" ,TKEY>
			      <RTRUE>)
			     (T
			      <TELL CTHEO " doesn't fit">)>
		       <TELL " into the " D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The ">
		<COND (<NOT <IS? ,PRSO ,LOCKED>>
		       <TELL "open ">)>
		<TELL D ,PRSO " is a formidable hunk of hardened steel." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNLOCK PICK>
		<COND (<NOT <IS? ,PRSO ,LOCKED>>
		       <TELL CTHEO " isn't locked." CR>
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS ,TKEY>
		       <COND (<OR <PRSI? TKEY>
				  <IN? ,TKEY ,PADLOCK>>
			      <OPEN-PADLOCK>
			      <RTRUE>)>
		       <HOW?>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would open the padlock">
		<RTRUE>)
	       (<VERB? CLOSE LOCK>
		<COND (<IS? ,PRSO ,LOCKED>
		       <ITS-ALREADY "closed">
		       <RTRUE>)
		      (<AND <T? ,PRSI>
			    <NOT <PRSI? HANDS>>>
		       <TELL ,DONT "need " THEI
			     " to close the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<MAKE ,PRSO ,LOCKED>
		<TELL "You snap the " D ,PRSO " shut." CR>
		<COND (<AND <IN? ,PRSO ,BOX>
			    <NOT <IS? ,BOX ,OPENED>>>
		       <UNMAKE ,PRSO ,TAKEABLE>
		       <MAKE ,PRSO ,NODESC>
		       <MAKE ,PRSO ,NOALL>
		       <TELL CR "The box is locked again." CR>)>
		<RTRUE>)
	       (<AND <VERB? TAKE PULL MOVE LOOSEN PUSH PUSH-TO RAISE
			    LOWER SHAKE KICK RELEASE TAKE-OFF>
		     <BOX-LOCKED?>>
		<TELL CTHEO " is firmly locked onto the box." CR>
		<RTRUE>)		     
	       (<VERB? LOOK-INSIDE REACH-IN>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<ROUTINE OPEN-PADLOCK ()
	 <UNMAKE ,PADLOCK ,LOCKED>
	 <MAKE ,PADLOCK ,TAKEABLE>
	 <UNMAKE ,PADLOCK ,NOALL>
	 <COND (<IN? ,TKEY ,PADLOCK>
		<TELL CTHE ,PADLOCK>)
	       (T
		<MOVE ,TKEY ,PADLOCK>
		<TELL "You slip the key into the "
		      D ,PADLOCK ". It">)>
	 <TELL " unlocks with a smart little snap." CR>
	 <COND (<NOT <IS? ,PADLOCK ,TOUCHED>>
	        <MAKE ,PADLOCK ,TOUCHED>
		<UPDATE-SCORE>)>
	 <RTRUE>>

<OBJECT PANEL
	(LOC IN-BOX)
	(DESC "control panel")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 10)
	(SYNONYM PANEL CONTROLS)
	(ADJECTIVE CONTROL)
	(ACTION PANEL-F)>

<ROUTINE PANEL-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <PERFORM ,PRSA ,PRSO ,BOX>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<TELL CTHEO
" is covered with a bewildering array of " D ,METERS
", clustered around a heavy-duty " D ,BREAKER ,PERIOD>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER LOOK-BEHIND OPEN OPEN-WITH>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL CTHEO " is built into the box. " ,CANT
		      "budge it." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT METERS
	(LOC PANEL)
	(DESC "instruments")
	(FLAGS NODESC VOWEL TRYTAKE NOALL READABLE PLURAL)
	(SYNONYM ARRAY INSTRUMEN)
	(ADJECTIVE BEWILDERING)
	(ACTION METERS-F)>

<ROUTINE METERS-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ SEARCH>
		<TELL CTHEO " on the " D ,PANEL " blink and twitch in response to invisible impulses. Their purpose is obscure." CR>
		<RTRUE>)
	       (<VERB? LAMP-ON LAMP-OFF>
		<HOW?>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER LOOK-BEHIND OPEN OPEN-WITH>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<FIRMLY-ATTACHED ,PRSO ,PANEL>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT BREAKER
	(LOC PANEL)
	(DESC "circuit breaker")
	(FLAGS NODESC TRYTAKE NOALL LOCKED)
	(SYNONYM BREAKER HANDLE)
	(ADJECTIVE CIRCUIT SWITCH BROAD)
	(ACTION BREAKER-F)>

"BORING = opened more than once,
 SHADOWY = delay for message, OPENED = breaker opened."

<ROUTINE BREAKER-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The heavy-duty " D ,PRSO  
" looks like something out of a Frankenstein movie. Its broad handle is ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "open." CR>
		       <RTRUE>)>
		<TELL "closed." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF OPEN OPEN-WITH RAISE PULL LOOSEN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<MAKE ,PRSO ,OPENED>
		<TELL "You lift the handle of the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON CLOSE LOWER PUSH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <UNMAKE ,PRSO ,OPENED>
		       <MAKE ,PRSO ,BORING>
		       <TELL "You close the handle of the " D ,PRSO ,PERIOD>
		       <COND (<NOT <HEAR-BAKER?>>
			      <RTRUE>)>
	 	       <TELL CR 
"\"Hold on, " D ,ABLE ". X just woke up again.\"|
|
A sigh of relief. \"Sounds like a wet line somewhere.\"|
|
\"The kid's keepin' an eye on it, " D ,PITTS ". If it dies again">
		       <COND (<L? ,MINUTES 29>
			      <TELL " before the sequencer takes over">)>
		       <TELL ", we're gonna have to scrub.\"|
|
\"Roger, " D ,BAKER ". Lotta crossed fingers up here.\"" CR>
		       <UPDATE-SCORE>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)	    
	       (<VERB? TURN MOVE>
		<COND (<IS? ,PRSO ,OPENED>
		       <PERFORM ,V?LAMP-ON ,PRSO ,PRSI>
		       <RTRUE>)>
		<PERFORM ,V?LAMP-OFF ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO ,PANEL>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		          
<ROUTINE HEAR-BAKER? ()
	 <COND (<AND <EQUAL? ,TFREQ ,MAGICFREQ>
		     <IS? ,RDIAL ,SEEN>
		     <IS? ,ANTENNA ,OPENED>
		     <NOT <IS? ,WSWITCH ,OPENED>>
		     <NOT <IS? ,WTK ,CHILLY>>
		     <VISIBLE? ,WTK>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GROVES
	(DESC "general")
	(FLAGS NODESC LIVING PERSON)
	(SYNONYM GROVES GENERAL)
	(ADJECTIVE GENERAL)
	(ACTION GROVES-F)>

<ROUTINE GROVES-F ("OPTIONAL" (CONTEXT <>))
	 <SETG P-HIM-OBJECT ,GROVES>
	 <TELL ,CANT "see him from where you are now." CR>
	 <RFATAL>>

<OBJECT SBUNK
	(LOC S100)
	(DESC "shelter")
	(FLAGS NODESC)
	(SYNONYM  SHELTER SHELTERS BUNKER BUNKERS DUGOUT BAKER)
	(ADJECTIVE SQUARE EARTHEN)
	(ACTION SBUNK-F)>

"TOUCHED = I-SBUNK queued, Groves seen."

<ROUTINE SBUNK-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL "The square " D ,PRSO
" is built of heavy timber, covered with a thick layer of earth on the north side. ">
		<SEE-SBENTRY>
		<RTRUE>)
	       (<HANDLE-SBUNK?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-SBUNK? ()
	 <COND (<VERB? SEARCH LOOK-INSIDE>
		<TELL CTHEO
" appears to be crowded with men and " D ,MIKE
". But you can't see much detail from where you're standing." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<HEAR-SBUNK>
		<RTRUE>) 
	       (<OR <ENTERING?>
		    <VERB? CROSS>>
		<DO-WALK ,P?NE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,SBUNK>
		<RTRUE>)
	       (<OR <VERB? SMELL>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SBENTRY
	(LOC S100)
	(DESC "entrance")
	(FLAGS NODESC)
	(SYNONYM ENTRANCE ENTRY OPENING)
	(ACTION SBENTRY-F)>

<ROUTINE SBENTRY-F ()
	 <COND (<VERB? EXAMINE>
		<SEE-SBENTRY>
		<RTRUE>)
	       (<HANDLE-SBUNK?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SEE-SBENTRY ()
	 <TELL "Bright light spills across the " D ,GDESERT
	       " from the open south " D ,SBENTRY ,PERIOD>
	 <RTRUE>>

<OBJECT SHED
	(LOC S100)
	(DESC "shed")
	(FLAGS NODESC)
	(SYNONYM SHED BUILDING STRUCTURE)
	(ADJECTIVE STORAGE METAL)
	(ACTION SHED-F)>

<ROUTINE SHED-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-BEHIND>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <TOO-HIGH ,PRSI>
		       <RTRUE>)
		      (<VERB? PUT>
		       <NO-SHED-HOLE>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <VOICE-MUTTERS "Not a good idea" <>>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"It's a nondescript metal structure, just large enough to hide behind." CR>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
		<DO-WALK ,P?NE>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND>
		<PERFORM ,V?EXAMINE ,SBUNK>
		<RTRUE>)
	       (<VERB? HIDE>
		<TELL ,YOURE-ALREADY "behind the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? OPEN CLOSE LOOK-INSIDE REACH-IN SEARCH EMPTY>>
		<NO-SHED-HOLE>
		<RTRUE>)
	       (<VERB? ESCAPE>
		<RFALSE>)
	       (<OR <EXITING?>
		    <VERB? LEAP CLIMB-DOWN>>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? STAND-ON CLIMB-OVER CLIMB-UP CLIMB-ON SIT LIE-DOWN>
		<TOO-HIGH>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE NO-SHED-HOLE ()
	 <TELL ,CANT "see any " D ,CAVE-HOLE " here." CR>
	 <RTRUE>>

<OBJECT TKEY
	(LOC BBOX)
	(DESC "steel key")
	(FLAGS KEYBIT TAKEABLE)
	(SIZE 0)
	(MASS 1)
	(VALUE 1)
	(SYNONYM KEY)
	(ADJECTIVE STEEL METAL)
        (ACTION TKEY-F)>

<ROUTINE TKEY-F ()
	 <COND (<NOT <IS? ,TKEY ,SEEN>>
		<REFERRING>
		<RFATAL>)
	       (<AND <NOT <IS? ,TKEY ,TOUCHED>>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<RFALSE>)
	       (<AND <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		     <NOT <IS? ,PRSO ,TOUCHED>>>
		<COND (<IN? ,BINOS ,PLAYER>
		       <LOOK-THRU-BINOS>
		       <COND (<NOT <VERB? FOCUS-ON EXAMINE LOOK-ON WATCH
					  LOOK-THRU READ>>
			      <RFALSE>)>
		       <TELL CTHEO
" is in the " D ,PADLOCK " dangling from the open box's lid." CR>
		       <RTRUE>)>
		<NOT-WITHOUT-BINOS>
		<RTRUE>)
	       (<AND <VERB? TURN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IN? ,PRSO ,PADLOCK>
		       <PERFORM ,V?UNLOCK ,PADLOCK ,TKEY>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)	
	       (T
		<RFALSE>)>>
		
<OBJECT BBOX
      ; (LOC S100)
	(DESC "box")
	(FLAGS NODESC CONTAINER OPENED OPENABLE)
	(SYNONYM BOX COFFIN)
	(ADJECTIVE LONG WOODEN WOOD)
	(ACTION BBOX-F)>

<ROUTINE BBOX-F ()
	 <COND (<NOT <IS? ,BBOX ,SEEN>>
		<REFERRING>
		<RFATAL>)
	       (<AND <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		     <THIS-PRSO?>>
		<COND (<IN? ,BINOS ,PLAYER>
		       <LOOK-THRU-BINOS>
		       <COND (<NOT <VERB? FOCUS-ON LOOK-THRU EXAMINE
					  WATCH READ>>
			      <CANT-FROM-HERE>
			      <RTRUE>)>
		       <TELL CTHE ,BBOX
" is virtually identical to the one you saw under the " D ,TOWER>
		       <MENTION-TKEY>
		       <RTRUE>)>
		<NOT-WITHOUT-BINOS>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>	  
	
<ROUTINE LOOK-THRU-BINOS ()
	 <SETG BSEEN ,PRSO>
	 <TELL "[looking through the " D ,BINOS ,BRACKET>
	 <RTRUE>>

<ROUTINE NOT-WITHOUT-BINOS ()
	 <SETG P-THEM-OBJECT ,BINOS>
	 <TELL ,CANT "quite see " THEO
	       " without the " D ,BINOS ,PERIOD>
	 <RTRUE>>

<OBJECT AWINDOWS
	(LOC NEROOM)
	(DESC "windows")
	(FLAGS NODESC PLURAL)
	(SYNONYM WINDOWS WINDOW PANES PANE GLASS)
	(ACTION AWINDOWS-F)>

<ROUTINE AWINDOWS-F ()
	 <COND (<VERB? EXAMINE SEARCH>
		<TELL CTHEO " are closed and sealed with tape." CR>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH RAISE MOVE PULL PUSH PUSH-TO>
		     <THIS-PRSO?>>
		<TELL "The tape on the " D ,PRSO " prevents this." CR>
		<RTRUE>)
	       (<WINDOWS-F>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
		
<OBJECT WINDOWS
	(LOC LOCAL-GLOBALS)
	(DESC "windows")
	(FLAGS NODESC PLURAL)
	(SYNONYM WINDOWS WINDOW PANE PANES GLASS)
	(ACTION WINDOWS-F)>

<ROUTINE WINDOWS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<ITS-CLOSED>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-OUTSIDE LOOK-BEHIND USE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH RAISE PULL PUSH MOVE PUSH-TO>
		<TELL CTHEO 
" are stubborn and hard to move. You soon abandon the effort." CR>
		<RTRUE>)
	       (<VERB? UNLOCK>
		<TELL "They're not locked." CR>
		<RTRUE>)
	       (<VERB? CLOSE LOWER>
		<TELL CTHEO " are already closed." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON LEAP CLIMB-OVER CROSS REACH-IN>>
		<ITS-CLOSED>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<OBJECT WBENCH
	(LOC NEROOM)
	(DESC "workbench")
	(FLAGS SURFACE)
	(CAPACITY 25)
	(SYNONYM WORKBENCH BENCH TABLE SHELF)
	(DESCFCN DESCRIBE-WBENCH)
	(ACTION WBENCH-F)>

<ROUTINE DESCRIBE-WBENCH ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A " D ,WBENCH " covered with loose sheets of " D ,BPAPER 
" runs along the north wall. ">
	 <AND-OTHER-DEBRIS>
	 <RTRUE>>

<ROUTINE AND-OTHER-DEBRIS ()
	 <TELL ,YOU-SEE>
	 <PRINT-CONTENTS ,BPAPER>
	 <TELL " and other " D ,DEBRIS 
	       " scattered across the paper.">
	 <RTRUE>>

<ROUTINE WBENCH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON TAKE THROW>
		       <PERFORM ,PRSA ,PRSO ,BPAPER>
		       <RTRUE>)
		      (<VERB? PUT-UNDER PUT-BEHIND STAND-UNDER>
		       <TELL "There's no room under the " D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? SEARCH>
		<PERFORM ,V?LOOK-UNDER ,BPAPER>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " is covered with sheets of " D ,BPAPER>
		<LOOK-ON-BPAPER>
		<RTRUE>)
	       (<VERB? PUSH PULL MOVE PUSH-TO RAISE LOWER>
		<FIRMLY-ATTACHED ,WBENCH ,WALLS>
		<RTRUE>)
	       (<VERB? EMPTY>
		<PERFORM ,PRSA ,BPAPER>
		<RTRUE>)
	       (<HANDLE-BPAPER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BPAPER
	(LOC WBENCH)
	(DESC "brown paper")
	(FLAGS NODESC SURFACE TRYTAKE NOALL)
	(SYNONYM PAPER PAPERS)
	(ADJECTIVE BROWN WRAPPING)
	(CAPACITY 30)
	(ACTION BPAPER-F)>

<ROUTINE BPAPER-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-UNDER PUT-BEHIND STAND-UNDER>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " completely covers the " D ,WBENCH>
		<LOOK-ON-BPAPER>
		<RTRUE>)
	       (<VERB? TAKE SEARCH LOOK-INSIDE MOVE PULL RAISE LOOK-UNDER
		       LOOK-BEHIND>
		<COND (<IS? ,SDRIVER ,NODESC>
		       <UNMAKE ,SDRIVER ,NODESC>
		       <MOVE ,SDRIVER ,NEROOM>
		       <SETG P-IT-OBJECT ,SDRIVER>
		       <UNMAKE ,HANDS ,TOOL>
		       <TELL "As you lift the edge of the paper a "
D ,SDRIVER " rolls out from underneath and lands on your foot. Ouch!" CR>
		       <RTRUE>)>
		<TELL "You lift the paper again, but find nothing " 
		      <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<HANDLE-BPAPER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE LOOK-ON-BPAPER ()
	 <TELL ". On it you see ">
	 <PRINT-CONTENTS ,BPAPER>
	 <TELL " and other " D ,DEBRIS ,PERIOD>
	 <RTRUE>>

<ROUTINE HANDLE-BPAPER? ()
	 <COND ; (<VERB? LOOK-INSIDE SEARCH>
		  <AND-OTHER-DEBRIS>
		  <CRLF>
		  <RTRUE>)
	       (<VERB? SIT STAND-ON LIE-DOWN CLIMB-ON CLIMB-OVER RIDE
		       CROSS LEAP>
		<NOT-LIKELY ,WBENCH "would support your weight">
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT SDRIVER
	(DESC "screwdriver")
	(FLAGS NODESC TAKEABLE TOOL)
	(VALUE 1)
	(SIZE 3)
	(MASS 3)
	(SYNONYM SCREWDRIVER DRIVER)
	(ADJECTIVE SCREW)
	(ACTION SDRIVER-F)>

"NODESC = not found."

<ROUTINE SDRIVER-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL "It's just an ordinary " D ,PRSO ". Really." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT WBITS
	(LOC BPAPER)
	(DESC "bits of wire")
	(FLAGS TRYTAKE NOALL PLURAL)
	(SYNONYM BITS WIRE WIRES)
	(ACTION AJUNK-F)>

<OBJECT DEBRIS
	(LOC BPAPER)
	(DESC "debris")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM DEBRIS JUNK)
	(ACTION AJUNK-F)>

<ROUTINE AJUNK-F ()
	 <COND (<AND <THIS-PRSO?>
		     <VERB? EXAMINE TAKE LOOK-INSIDE SEARCH LOOK-UNDER
			    LOOK-BEHIND PUSH MOVE PULL RAISE>>
		<TELL "You sift through the " D ,PRSO
		      " on the " D ,WBENCH
		      ", but find nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT XSNAKE
	(LOC NEROOM)
	(DESC "snake")
	(FDESC "A rattlesnake is coiled only a few feet away.")
	(FLAGS NODESC)>	

<OBJECT SNAKE
	(LOC LOCAL-GLOBALS)
	(DESC "rattlesnake")
	(FLAGS NODESC LIVING TRYTAKE NOALL PERSON SEEN)
	(SYNONYM SNAKE RATTLESNAKE RATTLER DIAMONDBACK REPTILE EYES)
	(ADJECTIVE RATTLE)
	(ACTION SNAKE-F)>

"NODESC = undiscovered, CHILLY = seen by Meep, SEEN = delay, LIVING = here."
	        
<ROUTINE SNAKE-F ()
	 <COND (<NOT <IS? ,SNAKE ,LIVING>>
		<TELL CTHE ,SNAKE " isn't here anymore." CR>
		<RFATAL>)
	       (<AND <HERE? IN-CLOSET>
		     <NOT <IS? ,CLOSET-DOOR ,OPENED>>>
		<TELL "Luckily, the " D ,SNAKE " is on the other side of the "
		      D ,CLOSET-DOOR ,PERIOD>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <TELL "You raise your arm to throw " THEO ,PERIOD>
		       <RTRUE>)
		      (<VERB? GIVE SHOW FEED>
		       <SNAKE-RESPONSE "offer">
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"All you can see are those tiny black eyes, glaring." CR>
		<RTRUE>)
	       (<VERB? KILL HIT MUNG CUT RIP KICK KNOCK BITE STAND-ON
		       EAT TASTE>
		<TELL "You draw closer to the " D ,PRSO ", ">
		<COND (<OR <VERB? KICK STAND-ON>
			   <PRSI? FEET>>
		       <TELL D ,FEET>)
		      (<VERB? BITE EAT TASTE>
		       <TELL "teeth">)
		      (<OR <VERB? KNOCK>
			   <EQUAL? ,PRSI <> ,HANDS>>
		       <TELL D ,HANDS>)
		      (T
		       <TELL D ,PRSI>)>
		<TELL " poised to strike." CR>
		<RTRUE>)
	       (<VERB? TAKE SHAKE TOUCH SWING SQUEEZE RAISE MOVE
		       PULL PUSH PUSH-TO UNTANGLE UNFOLD>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?RATTLE>
		       <TELL CTHEO " doesn't need your help." CR>
		       <RTRUE>)>
		<TELL "You reach out to ">
		<COND (<VERB? TOUCH SHAKE SQUEEZE>
		       <PRINTB ,P-PRSA-WORD>)
		      (T
		       <TELL "grasp">)>
		<TELL " the angry reptile." CR>
		<RTRUE>)
	       (<VERB? KISS RAPE>
		<VOICE-MUTTERS "You asked for it">
		<RTRUE>)
	       (<VERB? WAVE-AT POINT-AT>
		<SNAKE-RESPONSE "gesture">
		<RTRUE>)
	       (<AND <VERB? TELL>
		     <T? ,P-CONT>>
		<SNAKE-RESPONSE "voice">
		<RFATAL>)
	       (<VERB? ASK-ABOUT ASK-FOR QUESTION WHO WHAT WHERE>
		<SNAKE-RESPONSE "question">
		<RTRUE>)
	       (<VERB? YELL ALARM TELL-ABOUT REPLY THANK HELLO SAY
		       GOODBYE>
		<SNAKE-RESPONSE "voice">
		<RTRUE>)
	       (<VERB? LISTEN>
		<HEAR-SNAKE>
		<RTRUE>)
	       (<VERB? WATCH>
		<I-SNAKE <>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SNAKE-RESPONSE (STR)
	 <TELL "Your " .STR " elicits a brief, angry rattle." CR>
	 <RTRUE>>

<OBJECT WTK
	(LOC TUN2)
	(DESC "walkie-talkie")
	(FLAGS TAKEABLE SURFACE FERRIC)
	(CAPACITY 0)
	(FDESC
"Some careless technician has left a walkie-talkie lying in the dirt.")
	(SYNONYM WALKIE\-TALKIE TALKIE RADIO RECEIVER)
	(ADJECTIVE WALKIE PORTABLE FM DRIPPING WET WATERY)
	(VALUE 1)
	(SIZE 5)
	(MASS 5)
	(GENERIC GENERIC-RADIO-F)
	(ACTION WTK-F)>

"SHADOWY = test voice not yet heard, CHILLY = soaked."

<ROUTINE WTK-F ()
	 <COND (<AND <ADJ-USED? ,W?DRIPPING ,W?WET ,W?WATERY>
		     <NOT <IS? ,WTK ,CHILLY>>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <NO-GOOD-SURFACE>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? LISTEN>
		     <NOT <IS? ,WSWITCH ,OPENED>>
		     <NOT <IS? ,PRSO ,CHILLY>>>
		<MAKE ,PRSO ,SEEN>
		<TELL CTHEO <PICK-NEXT ,HISSES> ,PERIOD>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO>
		<COND (<IS? ,PRSO ,CHILLY>
		       <TELL " is dripping wet. It">)>
		<TELL " has a " D ,WSWITCH ", a " D ,INTNUM "ed " D ,SLIDER 
", a telescoping " D ,ANTENNA " (now ">
		<COND (<IS? ,ANTENNA ,OPENED>
		       <TELL "rais">)
		      (T
		       <TELL "lower">)>
		<TELL "ed) and a large " D ,WBUTTON ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON LAMP-OFF>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<PERFORM ,PRSA ,WSWITCH>
		<RTRUE>)
	       (<AND <VERB? TURN-TO TUNE-TO>
		     <PRSI? INTNUM>>
		<PERFORM ,PRSA ,SLIDER ,PRSI>
		<RTRUE>)
	       (<VERB? REPAIR>
		<NOT-LIKELY ,PRSI "could repair the walkie-talkie">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ANTENNA
	(LOC WTK)
	(DESC "antenna")
	(FLAGS NODESC VOWEL TRYTAKE NOALL)
	(SYNONYM ANTENNA)
	(ADJECTIVE TELESCOPING)
	(ACTION ANTENNA-F)>

"OPENED = antenna raised."

<ROUTINE ANTENNA-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " is ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "pulled out to its full length." CR>
		       <RTRUE>)
		      (T
		       <TELL "pushed down into the " D ,WTK ,PERIOD>)>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH RAISE PULL UNFOLD UNPLUG>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL CTHEO 
" is already pulled out as far as it can go." CR>
		       <RTRUE>)>
		<MAKE ,PRSO ,OPENED>
		<TELL "You pull the " D ,PRSO
		      " out of the " D ,WTK
		      ", extending it to its full length." CR>
		<RTRUE>)
	       (<VERB? CLOSE LOWER FOLD PUSH PLUG>
		<COND (<IS? ,PRSO ,OPENED>
		       <UNMAKE ,PRSO ,OPENED>
		       <TELL "You push the " D ,PRSO
			     " back into the " D ,WTK ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO
" is already pushed in as far as it can go." CR>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO ,WTK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SLIDER
	(LOC WTK)
	(DESC "slider")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM SLIDER FREQUENCY NUMBERS)
	(ADJECTIVE TUNING NUMBERED)
	(ACTION SLIDER-F)>

"SEEN = point given for correct setting."

<GLOBAL TFREQ:NUMBER 42>

<ROUTINE SLIDER-F ("AUX" OLD (F <>))
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<PRSO-CALIBRATED>
		<COND (<IS? ,WTK ,FLIPPED>
		       <TELL ", all printed backwards">)>
		<NOW-SET-TO>
		<TELL N ,TFREQ ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN-TO PUSH-TO TUNE-TO POINT-AT>
		<COND (<IS? ,PRSO ,FLIPPED>
		       <SET F T>)>
		<COND (<PRSI? INTNUM>
		       <COND (<RANGE-ERROR? ,TFREQ>
			      <RTRUE>)>
		       <SETG P-IT-OBJECT ,WTK>
		       <SETG TFREQ ,P-NUMBER>
		       <TILL-POINTS>
		       <COND (<AND <IS? ,RDIAL ,SEEN>
				   <EQUAL? ,TFREQ ,MAGICFREQ>   
				   <NOT <IS? ,PRSO ,SEEN>>>
			      <MAKE ,PRSO ,SEEN>
			      <UPDATE-SCORE 3>)>
		       <RTRUE>)
		      (<PRSI? RIGHT>
		       <COND (<OR <AND <ZERO? .F>
				       <EQUAL? ,TFREQ 80>>
				  <AND <T? .F>
				       <EQUAL? ,TFREQ 20>>>
			      <FAR-AS-IT-GOES>
			      <RTRUE>)>
		       <SET OLD <COND (<ZERO? .F> <+ ,TFREQ 5>)
				      (T <- ,TFREQ 5>)>>
		       <COND (<AND <ZERO? .F>
				   <G? .OLD 79>>
			      <SET OLD 80>)
			     (<AND <T? .F>
				   <L? .OLD 20>>
			      <SET OLD 20>)>
		       <SETG TFREQ .OLD>
		       <MOVE-TO-RL "right">
		       <RTRUE>)
		      (<PRSI? LEFT>
		       <COND (<OR <AND <ZERO? .F>
				       <EQUAL? ,TFREQ 20>>
				  <AND <T? .F>
				       <EQUAL? ,TFREQ 80>>>
			      <FAR-AS-IT-GOES>
			      <RTRUE>)>
		       <SET OLD <COND (<ZERO? .F> <- ,TFREQ 5>)
				      (T <+ ,TFREQ 5>)>>
		       <COND (<AND <ZERO? .F>
				   <L? .OLD 20>>
			      <SET OLD 20>)
			     (<AND <T? .F>
				   <G? .OLD 79>>
			      <SET OLD 80>)>
		       <SETG TFREQ .OLD>
		       <MOVE-TO-RL "left">
		       <RTRUE>)>
		<HOW-TO-USE-TUNER>
		<RTRUE>)
	       (<VERB? SPIN TURN MOVE PUSH SWING PLAY SHAKE>
		<SET OLD ,TFREQ>
		<REPEAT ()
			<SETG TFREQ <+ <RANDOM 59> 21>>
			<COND (<NOT <EQUAL? .OLD ,TFREQ>>
			       <RETURN>)>>
		<FIDDLE>
		<RTRUE>)
	       (<HANDLE-TUNER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FAR-AS-IT-GOES ()
	 <TELL CTHEO " won't move any more in " D ,RIGHT ,PERIOD>
	 <RTRUE>>

<ROUTINE MOVE-TO-RL (STR)
	 <TELL "You move " THEO " a little bit to the " .STR ,PERIOD>
	 <RTRUE>>

<OBJECT RDIAL
	(LOC RADIO)
	(DESC "dial")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM DIAL KNOB FREQUENCY NUMBERS)
	(ADJECTIVE RADIO TUNING NUMBERED OVERSIZE OVERSIZED BIG LARGE HUGE)
	(ACTION RDIAL-F)>

"TOUCHED = dial moved, SEEN = point given."

<GLOBAL MAGICFREQ:NUMBER 0>
<GLOBAL RFREQ:NUMBER 27>

<ROUTINE RDIAL-F ("AUX" OLD)
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<PRSO-CALIBRATED>
		<NOW-SET-TO>
		<COND (<AND <NOT <IS? ,PRSO ,TOUCHED>>
			    <NOT <IS? ,PRSO ,SEEN>>>
		       <MAKE ,PRSO ,SEEN>
		       <REPEAT ()
			       <SETG MAGICFREQ <+ <RANDOM 59> 21>>
			       <COND (<NOT <EQUAL? ,MAGICFREQ ,TFREQ>>
				      <RETURN>)>>
		       <SETG RFREQ ,MAGICFREQ>
		       <TELL N ,RFREQ ,PERIOD>
		       <UPDATE-SCORE 3>
		       <RTRUE>)>
		<TELL N ,RFREQ ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN-TO TUNE-TO POINT-AT PUSH-TO>
		<COND (<PRSI? INTNUM>
		       <COND (<RANGE-ERROR? ,RFREQ>
			      <RTRUE>)>
		       <MAKE ,PRSO ,TOUCHED>
		       <SETG P-IT-OBJECT ,RADIO>
		       <SETG RFREQ ,P-NUMBER>
		       <TILL-POINTS>
		       <RTRUE>)
		      (<PRSI? RIGHT>
		       <COND (<EQUAL? ,RFREQ 80>
			      <FAR-AS-IT-GOES>
			      <RTRUE>)>
		       <MAKE ,PRSO ,TOUCHED>
		       <SET OLD <+ ,RFREQ 5>>
		       <COND (<G? .OLD 79>
			      <SET OLD 80>)>
		       <SETG RFREQ .OLD>
		       <MOVE-TO-RL "right">
		       <RTRUE>)
		      (<PRSI? LEFT>
		       <COND (<EQUAL? ,RFREQ 20>
			      <FAR-AS-IT-GOES>
			      <RTRUE>)>
		       <MAKE ,PRSO ,TOUCHED>
		       <SET OLD <- ,RFREQ 5>>
		       <COND (<L? .OLD 20>
			      <SET OLD 20>)>
		       <SETG RFREQ .OLD>
		       <MOVE-TO-RL "left">
		       <RTRUE>)>
		<HOW-TO-USE-TUNER>
		<RTRUE>)
	       (<VERB? SPIN TURN MOVE PUSH SWING PLAY SHAKE>
		<MAKE ,PRSO ,TOUCHED>
		<SET OLD ,RFREQ>
		<REPEAT ()
			<SETG RFREQ <+ <RANDOM 59> 21>>
			<COND (<NOT <EQUAL? .OLD ,RFREQ>>
			       <RETURN>)>>
		<FIDDLE>
		<RTRUE>)
	       (<HANDLE-TUNER?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TILL-POINTS ()
	 <TELL "You move the " D ,PRSO 
" until it points to the " D ,INTNUM " " N ,P-NUMBER ,PERIOD>
	 <RTRUE>>

<ROUTINE PRSO-CALIBRATED ()
	 <TELL CTHEO " is calibrated with " D ,INTNUM "s from 20 to 80">
	 <RTRUE>> 
	       
<ROUTINE NOW-SET-TO ()
	 <TELL ". Right now it's set to ">
	 <RTRUE>>

<ROUTINE RANGE-ERROR? (F)
	 <COND (<L? ,P-NUMBER 20>
		<TELL "The lowest " D ,INTNUM " on the " D ,PRSO
		      " is 20." CR>
		<RTRUE>)
	       (<G? ,P-NUMBER 80>
		<TELL "The highest " D ,INTNUM " on the " D ,PRSO
		      " is 80." CR>
	        <RTRUE>)
	       (<EQUAL? ,P-NUMBER .F>
		<TELL CTHEO " is already set to " N ,P-NUMBER ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FIDDLE ()
	 <TELL "You fiddle aimlessly with the " D ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE HANDLE-TUNER? ()
	 <COND (<OR <VERB? USE>
		    <EQUAL? ,P-PRSA-WORD ,W?ADJUST>>
		<HOW-TO-USE-TUNER>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN PULL UNPLUG UNSCREW UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO <LOC ,PRSO>>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE HOW-TO-USE-TUNER ()
	 <TELL "[To adjust " THEO 
", simply move it to the desired " D ,INTNUM "; for example, ">
	 <COND (<PRSO? SLIDER>
		<TELL "MOVE THE SLIDER">)
	       (T
		<TELL "TURN THE DIAL">)>
	 <TELL " TO 67.]" CR>
	 <RTRUE>>

<OBJECT WSWITCH
	(LOC WTK)
	(DESC "rocker switch")
	(FLAGS NODESC TRYTAKE NOALL OPENED)
	(SYNONYM SWITCH)
	(ADJECTIVE ROCKER)
	(ACTION WSWITCH-F)>

"OPENED = switch off."
		
<ROUTINE WSWITCH-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " is marked ">
		<COND (<IS? ,WTK ,FLIPPED>
		       <TELL "REWOP">)
		      (T
		       <TELL "POWER">)>
		<TELL ", and is turned ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "off." CR>
		       <RTRUE>)
		      (T
		       <TELL "on." CR>)>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <FLIP-WSWITCH>
		       <RTRUE>)>
		<TELL CTHEO " is already on." CR>
		<RTRUE>)
	       (<VERB? LAMP-OFF OPEN KILL>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL CTHEO " is already off." CR>
		       <RTRUE>)>
		<FLIP-WSWITCH>
		<RTRUE>)
	       (<AND <VERB? USE MOVE PUSH TOUCH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<FLIP-WSWITCH>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM PULL>
		<FIRMLY-ATTACHED ,PRSO ,WTK>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE FLIP-WSWITCH ()
	 <SETG P-IT-OBJECT ,WTK>
	 <TELL "You turn o">
	 <COND (<IS? ,WSWITCH ,OPENED>
		<UNMAKE ,WSWITCH ,OPENED>
		<TELL "n the " D ,WSWITCH ,PERIOD>
		<RTRUE>)>
	 <MAKE ,WSWITCH ,OPENED>
	 <TELL "ff the " D ,WSWITCH ,PCR CTHE ,WTK " falls silent." CR>
	 <RTRUE>>

<OBJECT WBUTTON
	(LOC WTK)
	(DESC "orange button")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM BUTTON)
	(ADJECTIVE ORANGE LARGE BIG)
	(GENERIC GENERIC-BUTTON-F)
	(ACTION WBUTTON-F)>

"SEEN = button pushed."

<ROUTINE WBUTTON-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " is marked ">
		<COND (<IS? ,WTK ,FLIPPED>
		       <TELL "KLAT OT HSUP">)
		      (T
		       <TELL "PUSH TO TALK">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? PUSH LOWER USE SQUEEZE TOUCH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,SEEN>
		       <SAY-SURE>
		       <TELL "touch that " D ,PRSO " again?">
		       <COND (<YES?>
			      <CRLF>
			      <TOUCH-WBUTTON>
			      <CRLF>
			      <VOICE-MUTTERS "Masochist" <>>
			      <RTRUE>)>
		       <NO-DETECTION>
		       <RTRUE>)>
		<TELL "You squeeze the " D ,PRSO>
		<COND (<IS? ,WSWITCH ,OPENED>
		       <TELL ". Nothing happens; so you release it." CR>
		       <RTRUE>)>
		<PRINT ,PCR>
		<MAKE ,PRSO ,SEEN>
		<TOUCH-WBUTTON>
		<RTRUE>)
	       (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM PULL>
		<COND (<AND <VERB? LOOSEN>
			    <EQUAL? ,P-PRSA-WORD ,W?PUSH>>
		       <COND (<EQUAL? ,PRSI <> HANDS>
			      <PERFORM ,V?PUSH ,PRSO>
			      <RTRUE>)>
		       <MAKE ,WTK ,SEEN>
		       <TELL CTHE ,WTK " buzzes and clicks. " CTHEO 
			     " is obviously useless." CR>
		       <RTRUE>)>
		<FIRMLY-ATTACHED ,PRSO ,WTK>
		<RTRUE>)
	       (<VERB? REPAIR>
		<NOT-LIKELY ,PRSI "could repair the button">
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE TOUCH-WBUTTON ()
	 <ITALICIZE "Zap!">
	 <TELL " A painful electric shock shoots up your arm">
         <COND (<IN? ,WTK ,PLAYER>
		<TELL ,PTHE D ,WTK " falls from your grasp and ">
	        <LANDS-AT-YOUR-FEET ,WTK>
		<RTRUE>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<OBJECT JEEPARTS
	(LOC LOCAL-GLOBALS)
	(DESC "that")
	(FLAGS NODESC CONTAINER SURFACE NOARTICLE)
	(SYNONYM HOOD WHEEL WHEELS TIRES TIRE IGNITION STEERING)
	(ADJECTIVE STEERING)
	(ACTION USELESS)>

<OBJECT JEEP
	(LOC LOCAL-GLOBALS)
	(DESC "jeep")
	(FLAGS NODESC CONTAINER SURFACE)
	(SYNONYM JEEP CAR VEHICLE AUTOMOBILE AUTO)
	(ACTION JEEP-F)>

<ROUTINE JEEP-F ("AUX" (IN <>))
	 <COND (<HERE? IN-JEEP>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON EMPTY-INTO>
		       <COND (<ZERO? .IN>
			      <MOVE ,PRSO ,IN-JEEP>
			      <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
			      <TELL "You drop " THEO
				    " into the jeep." CR>
			      <RTRUE>)>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)>
		<TELL
"The body of the jeep is caked with mud; it's obviously been used a lot lately. The door facing you is ">
		<COND (<IS? ,JDOOR ,OPENED>
		       <TELL "still open." CR>
		       <RTRUE>)>
		<TELL "closed." CR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER>
		     <T? .IN>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<VERB? THROUGH STAND-UNDER>
		<COND (<T? .IN>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<TELL 
"Better not. You might get your vacation clothes dirty." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-OVER CLIMB-ON CLIMB-UP>>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? RIDE USE>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<YOUD-HAVE-TO "start" ,JEEP>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<COND (<ZERO? .IN>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<EQUAL? ,PRSI <> ,HANDS>
		       <HOW?>
		       <RTRUE>)
		      (<PRSI? TKEY>
		       <TELL 
"You test the key in the jeep's ignition. No; it's much too small." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would start the jeep">
		<RTRUE>)
	       (<VERB? LAMP-OFF KILL>
		<TELL CTHEO " isn't running." CR>
		<RTRUE>)
	       (<VERB? LOCK UNLOCK>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<AND <VERB? OPEN OPEN-WITH CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<PERFORM ,PRSA ,JDOOR>
		<RTRUE>)
	       (<VERB? REPAIR>
		<TELL 
"There's not much you could fix with just " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SEAT
	(LOC LOCAL-GLOBALS)
	(DESC "seat")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM SEAT)
	(ADJECTIVE FRONT)
	(ACTION SEAT-F)>

<ROUTINE SEAT-F ("AUX" (IN <>))
	 <COND (<HERE? IN-JEEP>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <COND (<ZERO? .IN>
			      <MOVE ,PRSO ,IN-JEEP>
			      <TELL "You drop " THEO
				    " into the jeep." CR>
			      <RTRUE>)>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT-UNDER PUT-BEHIND>
		       <COND (<ZERO? .IN>
			      <CANT-FROM-HERE>
			      <RTRUE>)>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<COND (<ZERO? .IN>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? SIT CLIMB-ON SIT CLIMB-OVER CLIMB-UP>>
		<COND (<ZERO? .IN>
		       <DO-WALK ,P?IN>
		       <RTRUE>)>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<COND (<ZERO? .IN>
		       <NOT-IN>
		       <RTRUE>)>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? STAND-ON LIE-DOWN>
		<COND (<ZERO? .IN>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<AND <VERB? LOOK-UNDER LOOK-BEHIND>
		     <ZERO? .IN>>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT JDOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(FLAGS NODESC DOORLIKE OPENABLE)
	(SYNONYM DOOR DOORS DOORWAY DOORWAYS ENTRY ENTRANCE
	 	 EXIT PORTAL)
	(ADJECTIVE JEEP CAR VEHICLE)
	(ACTION JDOOR-F)>

<ROUTINE JDOOR-F ("AUX" (IN <>))
	 <COND (<HERE? IN-JEEP>
		<SET IN T>)>
	 <COND (<ONLY-ONE-DOOR?>
		<RFATAL>)
	       (<OR <ENTERING?>
		    <VERB? USE>>
		<DO-WALK <COND (<ZERO? .IN> ,P?IN) (T ,P?OUT)>>
		<RTRUE>)
	       (<EXITING?>
		<COND (<ZERO? .IN>
		       <NOT-IN ,JEEP>
		       <RTRUE>)>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? CLIMB-OVER CLIMB-ON CLIMB-UP>
		<TELL "You climb gracelessly over the door of the jeep."
		      CR CR>
		<GOTO <COND (<HERE? N75> ,IN-JEEP) (T ,N75)>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WALLET
	(LOC IN-JEEP)
	(DESC "wallet")
	(FDESC
"Whoever was driving this jeep left it in an awful hurry. There's a wallet on the floor at your feet.")
	(FLAGS TAKEABLE CONTAINER OPENABLE)
	(VALUE 0)
	(SIZE 3)
	(MASS 3)
	(CAPACITY 1)
	(SYNONYM WALLET BILLFOLD)
	(ADJECTIVE LEATHER)
	(ACTION WALLET-F)>

<ROUTINE WALLET-F ()
	 <COND (<AND <VERB? PUT>
		     <THIS-PRSO?>
		     <PRSI? POCKET>
		     <IS? ,PRSO ,OPENED>>
		<UNMAKE ,PRSO ,OPENED>
		<TELL "[closing the " D ,PRSO " first" ,BRACKET>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<OBJECT PHOTO
	(LOC WALLET)
	(DESC "snapshot")
	(FLAGS TAKEABLE READABLE SURFACE PERSON)
	(CAPACITY 0)
	(SIZE 0)
	(VALUE 0)
	(MASS 1)
	(SYNONYM SNAPSHOT PHOTOGRAPH PHOTO PICTURE IMAGE BOY CHILD KID WAND)
	(GENERIC GENERIC-PHOTO-F)
	(ACTION PHOTO-F)>

<ROUTINE GENERIC-PHOTO-F (TABLE)
	 <RETURN ,PHOTO>>

<ROUTINE PHOTO-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<OR <NOUN-USED? ,W?BOY ,W?CHILD ,W?KID>
		    <NOUN-USED? ,W?WAND>>
		<COND (<VERB? EXAMINE>
		       <TELL "The boy in the " D ,PRSO
" seems familiar. Maybe it's the wand he's holding." CR>
		       <RTRUE>)
		      (<OR <VERB? LOOK-BEHIND LOOK-UNDER LISTEN SMELL>
			   <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		       <TELL ,CANT "do that to an image in a " 
			     D ,PRSO ,PERIOD>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <NO-GOOD-SURFACE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ LOOK-INSIDE SEARCH>
		<TELL "The black-and-white " D ,PRSO
		      " shows a boy staring at the camera." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
	        <TELL "The boy just stares back at you." CR>
	        <RFATAL>)
	       (<AND <VERB? TURN SPIN>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL "There's nothing on the other side." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RADIO
	(LOC IN-JEEP)
	(DESC "jeep's radio")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(CAPACITY 0)
	(SYNONYM RADIO CONTROLS BOLTS)
	(ADJECTIVE JEEP\'S JEEP CAR\'S CAR)
	(GENERIC GENERIC-RADIO-F)
	(ACTION RADIO-F)>

<ROUTINE GENERIC-RADIO-F (TABLE)
	 <COND (<EQUAL? ,P-IT-OBJECT ,WTK ,RADIO>
		<RETURN ,P-IT-OBJECT>)
	       (T
		<RETURN ,RADIO>)>>

<ROUTINE RADIO-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<RADIO-BOLTED>
		<TELL 
" This is probably just as well, because it's big and awkward, probably too heavy to carry. Among its many controls are an oversized dial and a " 
D ,RSWITCH ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE PULL PUSH PUSH-TO MOVE LOOSEN UNSCREW
		       UNSCREW-FROM>
		<TELL "Forget it. ">
		<RADIO-BOLTED>
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON LAMP-OFF>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<PERFORM ,PRSA ,RSWITCH ,PRSI>
		<RTRUE>)
	       (<AND <VERB? TURN-TO TUNE-TO>
		     <PRSI? INTNUM>>
		<PERFORM ,PRSA ,RDIAL ,PRSI>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE RADIO-BOLTED ()
	 <TELL "The radio is firmly bolted to the floor of the jeep.">
	 <RTRUE>>

<OBJECT RSWITCH
	(LOC RADIO)
	(DESC "toggle switch")
	(FLAGS NODESC TRYTAKE NOALL OPENED)
	(SYNONYM SWITCH)
	(ADJECTIVE TOGGLE POWER ON\-OFF)
	(ACTION RSWITCH-F)>

"OPENED = switch off."
	       
<ROUTINE RSWITCH-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ>
		<TELL CTHEO " on the " D ,RADIO
		      " is marked POWER, and is turned ">
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "off." CR>
		       <RTRUE>)>
		<TELL "on." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON CLOSE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <FLIP-RSWITCH>
		       <RTRUE>)>
		<TELL CTHEO " is already on." CR>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF OPEN OPEN-WITH KILL>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL CTHEO " is already off." CR>
		       <RTRUE>)>
		<FLIP-RSWITCH>
		<RTRUE>)
	       (<AND <VERB? USE TURN MOVE PUSH TOUCH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<FLIP-RSWITCH>
		<RTRUE>)
	       (<VERB? TAKE PULL LOOSEN UNSCREW UNSCREW-FROM>
		<FIRMLY-ATTACHED ,PRSO ,RADIO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FLIP-RSWITCH ()
	 <SETG P-IT-OBJECT ,RADIO>
	 <TELL "You turn o">
	 <COND (<IS? ,RSWITCH ,OPENED>
		<UNMAKE ,RSWITCH ,OPENED>
		<TELL "n the " D ,RSWITCH ".|
|
Nothing " <PICK-NEXT ,YAWNS> " happens." CR>
		<RTRUE>)>
	 <MAKE ,RSWITCH ,OPENED>
	 <TELL "ff the " D ,RSWITCH ,PERIOD>
	 <RTRUE>>
		       
<OBJECT NBUNKERS
	(LOC LOCAL-GLOBALS)
	(DESC "shelters")
	(FLAGS NODESC PLURAL)
	(SYNONYM SHELTERS SHELTER BUNKER BUNKERS BUILDING BUILDINGS
	 	 CLUSTER GROUP BUNCH
	         SEARCHLIG SPOTLIGHT LIGHT LIGHTS GLARE BEAM)
	(ACTION NBUNKERS-F)>

"SEEN = examined."

<ROUTINE NBUNKERS-F ()
	 <COND (<VERB? EXAMINE WATCH>
		<MAKE ,PRSO ,SEEN>
		<TELL "The area around the " D ,PRSO
" is brightly illuminated by light spilling from the " D ,SLIGHT
"s. Anyone looking this way will probably see you if you get much closer." CR>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<HERE? N75>
		       <DO-WALK ,P?NW>
		       <RTRUE>)>
		<YOUD-HAVE-TO "get out of" ,JEEP>
		<RTRUE>)
	       (<OR <VERB? SMELL LISTEN>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENDGAME ("AUX" (W <>) (ST 0) CNT TBL)
	 <COND (<HEAR-BAKER?>
		<SET W T>
		<KSCRUB T>)>
	 <CRLF>
	 <COND (<EQUAL? <GETB 0 30> 5>
		<INC ST>
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)
	       (T
		<TELL "\"">)>
	 <TELL "Congratulations.">
	 <SEE-NO-ONE .ST>
	 <COND (<T? .W>
		<PRINT ,Z-MINUS>
	        <COND (<L? ,SECONDS 30>
		       <TELL "thirty">)
		      (<L? ,SECONDS 45>
		       <TELL "fifteen">)
		      (T
		       <TELL "ten">)>
		<TELL " seconds,\" crackles the " D ,WTK ,PERIOD>)>
	 <CRLF>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "You should be proud of " D ,ME ".">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL " Where is that voice coming from? ">
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "This gadget would've blown New Mexico right off the map if you hadn't stopped it. Imagine the embarrassment.">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <COND (<T? .W>
		<TELL CR CR "A burst of static. \"">
	        <COND (<L? ,SECONDS 30>
		       <TELL "Minus fifteen">)
		      (<L? ,SECONDS 45>
		       <TELL "Minus ten">)
		      (T
		       <TELL "Seven. Six. Five">)>
		<TELL " seconds.\"">)>
	 <ARTICULATES>
	 <TELL "It's not as scary the second time" ,PCR>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "Of course, there's the problem of causality,">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL " continues the voice. ">
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "If Harry doesn't get his A-bomb, the future that created ">
	 <COND (<ZERO? .ST>
		<ITALICIZE "you">)
	       (T
		<HLIGHT ,H-NORMAL>
		<TELL "you">
		<HLIGHT ,H-ITALIC>)>
	 <TELL " cannot occur. And you can't sabotage the test if you're never born, can you?">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <CRLF> <CRLF>
	 <COND (<T? .W>
		<TELL CTHE ,WTK " is fading away. \"">
	        <COND (<L? ,SECONDS 30>
		       <TELL "Minus ten seconds. Nine, eight, seven">)
		      (<L? ,SECONDS 45>
		       <TELL "Five seconds. Four">)
		      (T
		       <TELL "Three. Two">)>
		<TELL ".\"" CR CR>)>
	 <TELL "The voice chuckles amiably. ">
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)>
	 <TELL "Not to worry, though. Nature doesn't know the word 'paradox.' Gotta bleed off that quantum steam somehow. Why, I wouldn't be surprised to see a good-sized ">
	 <COND (<ZERO? .ST>
		<ITALICIZE "bang">)
	       (T
		<HLIGHT ,H-NORMAL>
		<TELL "bang">
		<HLIGHT ,H-ITALIC>)>
	 <TELL 
" every time they shoot off one of these gizmos. Just enough fireworks to keep the historians happy.">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
		<TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <CARRIAGE-RETURNS>
	 	 
	 <DEQUEUE I-TRINITY>
	 <DEQUEUE I-DOG>
	 <DEQUEUE I-FLARE>
	 <DEQUEUE I-TMEEP>
	 <DEQUEUE I-OPPIE>
	 
	 <EXIT-MEEP>
	 <UNMAKE ,MEEP ,TOLD>
	 <MAKE ,MEEP ,NODESC>
	 
	 <REMOVE-ALL ,PLAYER>
	 <MOVE ,POCKET ,PLAYER>
	 
	 <REMOVE-ALL ,POCKET>
	 <MOVE ,CREDIT-CARD ,POCKET>
	 <MOVE ,COIN ,POCKET>
	 <MAKE ,COIN ,TAKEABLE>
       
	 <MOVE ,WRISTWATCH ,PLAYER>
	 <MAKE ,WRISTWATCH ,WORN>

       ; "UnTOUCH all rooms."

	 <UNMAKE ,PAL-GATE ,TOUCHED>
	 <UNMAKE ,BROAD-WALK ,TOUCHED>
	 <UNMAKE ,LION-GATE ,TOUCHED>
	 <UNMAKE ,LAN-GATE ,TOUCHED>
	 <UNMAKE ,LAN-WALK ,TOUCHED>
	 <UNMAKE ,AT-TERRACE ,TOUCHED>
	 <UNMAKE ,FLOWER-WALK ,TOUCHED>
	 <UNMAKE ,WABE ,TOUCHED>
	 <UNMAKE ,ROUND-POND ,TOUCHED>
	 
       ; "Reinitialize objects"

         <MOVE ,BALL ,BEDS>
         <UNMAKE ,BALL ,NODESC>
	 <UNMAKE ,BALL ,TOUCHED>

	 <MOVE ,PRAM ,LION-GATE>
	 <UNMAKE ,PRAM ,OPENED>
	 <UNMAKE ,PRAM ,NODESC>
	 <PUTP ,PRAM ,P?DESCFCN ,DESCRIBE-PRAM>

	 <REMOVE ,BAD-CRANE>
	 <REMOVE ,OCRANE>
	 <REMOVE ,CRANE>
	 <UNMAKE ,CRANE ,LIGHTED>
	 <MAKE ,CRANE ,NODESC>

	 <MOVE ,GNOMON ,DIAL>
	 <MAKE ,GNOMON ,NODESC>
	 <MAKE ,GNOMON ,NOALL>
	 <UNMAKE ,GNOMON ,BORING>

	 <REMOVE ,BAG>
	 <UNMAKE ,BAG ,TOUCHED>
	 <SETG CCNT 5>
	 <SETG APPETITE 0>

	 <UNMAKE ,BIKES ,SEEN>

	 <REMOVE ,RUBY>
	 <UNMAKE ,RUBY ,TOUCHED>
	 <MAKE ,RUBY ,CHILLY>
	 <UNMAKE ,RUBY ,SEEN>
	 <UNMAKE ,RUBY ,TOLD>
	 <PUTP ,RUBY ,P?ACTION ,RUBY-F>
	 <SETG RUBYROOM <>>
	 <PUTP ,RUBY ,P?FDESC "A ruby is lying at your feet.">
	 
	 <REMOVE ,GROVES>

	 <UNMAKE ,NOTICE ,TOUCHED>
	 
	 <UNMAKE ,GRASS ,TOUCHED>
	 <UNMAKE ,GRASS ,SEEN>
	 <UNMAKE ,GRASS ,CHILLY>
	 
	 <MOVE ,PARASOL ,JWOMAN>
	 <UNMAKE ,PARASOL ,TOUCHED>
	 <MAKE ,PARASOL ,NODESC>
	 <MAKE ,PARASOL ,OPENED>
	 <UNMAKE ,PARASOL ,SEEN>
	 
	 <MAKE ,TREE ,NODESC>
	 
	 <UNMAKE ,WWIND ,SEEN>
	 <MAKE ,EWIND ,SEEN>
	 <UNMAKE ,EWIND ,TOUCHED>

	 <MOVE ,JWOMAN ,LAN-GATE>
	 <UNMAKE ,JWOMAN ,CHILLY>
	 <UNMAKE ,JWOMAN ,TOUCHED>
	 <MAKE ,JWOMAN ,NODESC>
	 <UNMAKE ,JWOMAN ,SEEN>
	 
	 <SETG LAYAWAY 3>
	 <UNMAKE ,BWOMAN ,SEEN>
	 <MAKE ,BWOMAN ,NODESC>
	 <PUTP ,BWOMAN ,P?FDESC "An aged woman is selling crumbs nearby.">
	 <MOVE ,GBAG ,BWOMAN>
	 
	 <SET CNT 0> ; "Unflip everything."
	 <REPEAT ()
		 <SET TBL <GET ,FLIPPERS .CNT>>
		 <COND (<ZERO? .TBL>
			<RETURN>)>
		 <UNMAKE .TBL ,FLIPPED>
		 <INC CNT>>

	 <SET CNT <GET ,BWOMAN-SUBJECTS 0>>
	 <REPEAT ()
		 <SET TBL <GET ,BWOMAN-SUBJECTS .CNT>>
		 <UNMAKE <GET .TBL 0> ,TOLD>
		 <COND (<DLESS? CNT 1>
			<RETURN>)>>
	 <UNMAKE ,SIRENS ,TOLD>
	 <UNMAKE ,RUBY ,TOLD>
	 
	 <REMOVE ,SCOIN>
	 <UNMAKE ,SCOIN ,TOUCHED>
	 
	 <MAKE ,HANDS ,TOOL>

	 <MAKE ,AT-TERRACE ,NOALL>
	 <MOVE ,BOY ,AT-TERRACE>
	 <UNMAKE ,BOY ,CHILLY>
	 <MOVE ,WAND ,BOY>
	 <MOVE ,SDISH ,AT-TERRACE>
	 <SETG BACTION 0>
	 	 
	 <SETG OSIGN 0>
	 <SETG HOURS 15>
	 <SETG MINUTES 30>
	 <SETG SECONDS 0>
	 <SETG FREEZE? <>>
	 <BOOT-SCREEN <>>
	 <RTRUE>>
	 
<ROUTINE BOOT-SCREEN ("OPTIONAL" (INTRO? T))
	 <QUEUE I-CRANE-APPEARS -1>
	 <QUEUE I-BWOMAN -1>
	 <QUEUE I-AIR-RAID -1>
	 <QUEUE I-BOY -1>
	 <PCLEAR>
	 <SETG HERE ,PAL-GATE>
	 <MOVE ,PLAYER ,HERE>
	 <SETG WINNER ,PLAYER>
	 <SETG LIT? T>
	 <COND (<T? .INTRO?>
		<TELL CR
"Sharp words between the superpowers. Tanks in East Berlin. And now, reports the BBC, rumors of a satellite blackout. It's enough to spoil your continental breakfast.|
|
But the world will have to wait. This is the last day of your $599 "
D ,LONDON " Getaway Package, and you're determined to soak up as much of that authentic English ambience as you can. So you've left the tour bus behind, ditched the camera and escaped to Hyde Park for a contemplative stroll through the " 
D ,GARDENS ,PCR>)>
	 <V-LOOK>
	 <COND (<T? ,TR?>
		<SETG DO-WINDOW <GET ,QUOTES ,EMILY>>)>
	 <RTRUE>>

<OBJECT BHOUSE
	(LOC W100)
	(DESC "blockhouse")
	(FLAGS NODESC)
	(SYNONYM BLOCKHOUSE HOUSE BUILDING STRUCTURE ROOF)
	(ADJECTIVE BLOCK STERN WINDOWLESS MILITARY)
	(ACTION BHOUSE-F)>

<ROUTINE BHOUSE-F ()
	 <COND (<OR <VERB? EXAMINE LOOK-INSIDE SEARCH>
		    <ENTERING?>>
	        <TELL CTHEO
" doesn't have any " D ,WINDOWS " or " D ,SBENTRY 
"s you can see from here." CR>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
		<DO-WALK ,P?SW>
		<RTRUE>)
	       (<VERB? LOOK-ON>
		<PERFORM ,V?EXAMINE ,SLIGHT>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER STAND-ON CLIMB-UP>
		<TOO-HIGH>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN LEAP>>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT SLIGHT
	(LOC W100)
	(DESC "searchlight")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM SEARCHLIG SPOTLIGHT LIGHT BEAM GLARE)
	(ADJECTIVE POWERFUL SEARCHLIG SPOTLIGHT)
	(ACTION SLIGHT-F)>

"SEEN = motion noticed."

<ROUTINE SLIGHT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO
"'s powerful beam slices over your head, towards a point on the northeast "
D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE WATCH>
		<TELL "The glare makes your eyes hurt." CR>
		<RTRUE>)
	       (<AND <VERB? THROW THROW-OVER>
		     <THIS-PRSI?>>
		<TELL "You pitch " THEO>
		<COND (<VERB? THROW-OVER>
		       <TELL " over ">)
		      (T
		       <TELL " at ">)>
		<TELL THEI>
		<COND (<PRSO? CREDIT-CARD PHOTO SHROUD MARKER BAG EBAG
			      MEEP LEM>
		       <TELL ", but it falls short and ">
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)
		      (<VERB? THROW-OVER>
		       <VANISH>
		       <TELL ". It disappears behind the " D ,BHOUSE ,PERIOD>
		       <RTRUE>)
		      (<G? <GETP ,PRSO ,P?MASS> 2>
		       <TELL ,PCR>
		       <ITALICIZE "Ping!">
		       <TELL " The powerful beam of the " D ,PRSI
			     " flickers and dies">
		       <COND (<HEAR-BAKER?>
			      <TELL ". \"Damn!\" curses the " D ,WTK>)>
		       <TELL ,PERIOD>
		       <COND (<IN? ,DOG ,W100>
			      <TELL CR 
"As your eyes adjust to the gloom, you hear a deep, menacing growl. You turn and find " D ,ME 
" one inch away from the longest set of choppers you've ever seen." CR>
			      <DOG-ALERT>
			      <RTRUE>)>
		       <HINGE-SQUEAK>
		       <RTRUE>)>
		<VANISH>
		<TELL
". It skitters off the rim and slides harmlessly" ,OUTASITE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHE ,SLIGHT " is out of your reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE AKC ()
	 <TELL 
" a commotion worthy of an American Kennel Club convention." CR>
	 <RTRUE>>

<ROUTINE HOLD-IT ()
	 <TELL CR 
"\"Hold it!\" The shout doesn't say anything about a gun. But you raise "
D ,HANDS "s over your head, just to be safe." CR>
	 <RTRUE>>

<ROUTINE KINDA-SPY ()
	 <TELL CR "The figure near the " D ,BHOUSE 
" studies you in the " D ,SLIGHT 
"'s glare. \"You... you some kinda spy or somethin'?\""
CR>
	 <RTRUE>>

<ROUTINE POLICE-CONVERGE ()
	 <TELL CR "A faint rumble begins to drift ">
	 <COND (<HERE? IN-SHACK>
		<TELL 
"in from outside. You crawl over to the exit, peek around the "
D ,CORNER " and ">)
	       (T
		<TELL "across the " D ,GDESERT 
		      ". You peer between the girders to ">)>
	 <TELL "scan the " D ,HORIZON ".|
|
Headlights. ">
	 <ITALICIZE "Lots">
	 <TELL " of them, converging on the " D ,TOWER 
	       " from several " D ,INTDIR
	       "s at once, and just minutes away!|
|
White with panic, you ">
	 <COND (<HERE? IN-SHACK TOWER-PLAT ON-TOWER>
		<COND (<HERE? IN-SHACK>
		       <TELL "leap out of the shack and ">)>
		<TELL "scramble down the " D ,TLADDER
		      " as fast as you can. But your ">
		<COND (<IS? ,RBOOT ,WORN>
		       <COND (<IS? ,GBOOT ,WORN>
			      <TELL "boots slip">)
			     (T
			      <TELL D ,RBOOT " slips">)>)
		      (<IS? ,GBOOT ,WORN>
		       <TELL D ,GBOOT " slips">)
		      (T
		       <TELL "vacation sneakers slip">)>
		<TELL 
" out from under you about ten rungs from the bottom; and you regain consciousness ">)
	       (T
		<COND (<HERE? AT-ZERO>
		       <TELL "slam the box shut and ">)>
		<TELL "crawl off to hide in the " D ,GDESERT
". But you bowl headfirst into a Joshua tree, and your ">
		<COND (<IS? ,SHROUD ,WORN>
		       <TELL D ,SHROUD " snags">)
		      (T
		       <TELL "vacation shorts snag">)>
		<TELL " on a prickly pear bush ">)>
	 <TELL 
"just as seventeen jeeps screech to a halt around the " D ,TOWER ,PERIOD>
	 <SURROUNDED>
	 <RTRUE>>

<ROUTINE SURROUNDED ()
	 <TELL CR
"Within moments you're surrounded by a dozen MPs, armed and trigger-happy. ">
	 <EXCUSES>
	 <RTRUE>> 

<ROUTINE EXCUSES ()
	 <TELL 
"They answer your polite explanations with curt accusations, punctuated by a few well-placed kicks.|
|
Eventually you're dragged off to meet somebody they call the Lieutenant, who'll deal with you, you're promised, right after a very important test is concluded. But the Lieutenant never appears. Minutes later, he's obliterated by a multigigaton atomic blast, along with ">
	 <MUCH-OF>
	 <RTRUE>>

<ROUTINE MUCH-OF ()
	 <TELL "much of the state of New Mexico.">
	 <JIGS-UP>
	 <RTRUE>>

<OBJECT MAP
	 (LOC NROOM)
	 (DESC "map")
	 (FDESC "A large map is hanging on the wall.")
	 (FLAGS TRYTAKE NOALL READABLE)
	 (SYNONYM MAP CHART)
	 (ADJECTIVE LARGE BIG)
	 (ACTION MAP-F)>

<ROUTINE MAP-F ()
	 <COND (<VERB? EXAMINE LOOK-ON READ>
		<TELL "[This is the map included in your ">
		<ITALICIZE "Trinity">
		<TELL " package.]" CR>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<FIRMLY-ATTACHED ,MAP ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FLARE
	(LOC GLOBAL-OBJECTS)
	(DESC "flare")
	(FLAGS NODESC)
	(SYNONYM FLARE ROCKET)
	(ADJECTIVE ROCKET)
	(ACTION FLARE-F)>

"NODESC = not yet seen, CHILLY = seen more than once."

<ROUTINE FLARE-F ()
	 <COND (<IS? ,FLARE ,NODESC>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (T
		<TELL ,CANT "see the " D ,FLARE " anymore." CR>
		<RFATAL>)>>

<OBJECT FRAME
	(LOC WZERO)
	(DESC "framework")
	(FLAGS NODESC)
	(SYNONYM FRAMEWORK FRAME GIRDER GIRDERS STEEL)
	(ADJECTIVE STEEL METAL)
	(ACTION FRAME-F)>

<ROUTINE FRAME-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-ON>
		<TELL CTHEO 
" is a boxlike affair of steel girders, about fifty feet high. The enormous "
D ,JUMBO " hanging inside fills much of its open interior." CR>
		<RTRUE>)
	       (<HANDLE-JUMBO?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-JUMBO? ()
	 <COND (<VERB? STAND-UNDER>
	  	<TELL "There isn't enough room between the "
		      D ,JUMBO " and the ground to do that." CR>
	  	<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-UP CLIMB-OVER STAND-ON SIT
			   LIE-DOWN>>
		<TELL 
"It doesn't look as if there's any way to climb onto " THEO ,PERIOD>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <VERB? KNOCK HIT>>
		<TELL "You hear a faint ring of steel." CR>
		<RTRUE>)
	       (T
	  	<RFALSE>)>>

<OBJECT JUMBO
	(LOC WZERO)
	(DESC "barrel")
	(FLAGS NODESC TRYTAKE NOALL CONTAINER)
	(SYNONYM BARREL VESSEL JUG JUMBO)
	(ADJECTIVE BIG LARGE HUGE ENORMOUS GIANT GIGANTIC)
	(ACTION JUMBO-F)>

<ROUTINE JUMBO-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <JUMBO-CLOSED>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH LOOK-ON>
		<TELL
"Why would anyone hang a giant " D ,PRSO
" in the middle of nowhere like this? There don't seem to be any "
D ,HOPENING "s, " D ,WINDOWS
" or markings of any kind; as far as you can tell, the thing is utterly useless." CR>
		<RTRUE>)
	       (<VERB? ENTER THROUGH LOOK-INSIDE OPEN REACH-IN EMPTY
		       CLOSE OPEN-WITH>
		<JUMBO-CLOSED>
		<RTRUE>)
	       (<HANDLE-JUMBO?>
		<RTRUE>)
	       (T
		<RFALSE>)>>		
		
<ROUTINE JUMBO-CLOSED ()
	 <TELL "If there's any way into this oversized " D ,JUMBO
	       ", you sure can't find it." CR>
	 <RTRUE>>

<OBJECT SWALL
	(LOC LOCAL-GLOBALS)
	(DESC "stone wall")
	(FLAGS NODESC)
	(SYNONYM WALL)
	(ADJECTIVE STONE ROCK)
	(ACTION SWALL-F)>

<ROUTINE SWALL-F ("AUX" (IN <>))
	 <COND (<HERE? NWYARD NEYARD SWYARD SEYARD>
		<SET IN T>)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<VERB? PUT-BEHIND THROW-OVER>
		       <MOVE ,PRSO <GETP ,HERE ,P?WALL-SIDE>>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL CTHEO " falls somewhere behind the " 
			     D ,PRSI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
" is three or four feet high. It completely surrounds the " D ,RANCH ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<COND (<T? .IN>
		       <V-LOOK>
		       <RTRUE>)>
		<PERFORM ,V?EXAMINE ,RANCH>
		<RTRUE>)
	       (<ENTERING?>
		<COND (<T? .IN>
		       <TELL ,YOURE-ALREADY "within the " D ,PRSO ,PERIOD>
		       <RTRUE>)
		      (<HERE? NWRANCH>
		       <DO-WALK ,P?SE>
		       <RTRUE>)
		      (<HERE? SWRANCH>
		       <DO-WALK ,P?NE>
		       <RTRUE>)
		      (<HERE? SERANCH>
		       <DO-WALK ,P?NW>
		       <RTRUE>)
		      (<HERE? ERANCH>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)>
		<TELL "There aren't any " D ,SBENTRY "s here." CR>
		<RTRUE>)
	       (<EXITING?>
		<COND (<T? .IN>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? CLIMB-ON CLIMB-OVER LEAP>
		<SET IN <GETP ,HERE ,P?WALL-SIDE>>
		<COND (<ZERO? .IN>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<HERE? NERANCH NEYARD>
		       <TELL "You ">)
		      (T
		       <TELL "Despite the presence of the ">
		       <COND (<HERE? ERANCH ON-PORCH>
			      <TELL D ,RAMP>)
			     (T
			      <TELL D ,NWGATE>)>
		       <TELL ", you ">)>
		<TELL "clamber over the " D ,PRSO ,PCR>
		<GOTO .IN>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<VERB? STAND-ON RIDE CLIMB-UP SIT LIE-DOWN>
		<TELL CTHEO " is too narrow for such gymnastics." CR>
		<RTRUE>)
	       (<VERB? FOLLOW CROSS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
			     
<OBJECT NWGATE
	(LOC LOCAL-GLOBALS)
	(DESC "iron gate")
	(FLAGS NODESC DOORLIKE OPENABLE FERRIC VOWEL)
	(SYNONYM GATE)
	(ADJECTIVE IRON METAL)>

<OBJECT SWGATE
	(LOC LOCAL-GLOBALS)
	(DESC "iron gate")
	(FLAGS NODESC DOORLIKE OPENABLE FERRIC VOWEL)
	(SYNONYM GATE)
	(ADJECTIVE IRON METAL)>

<OBJECT SEGATE
	(LOC LOCAL-GLOBALS)
	(DESC "iron gate")
	(FLAGS NODESC DOORLIKE OPENABLE FERRIC VOWEL OPENED)
	(SYNONYM GATE)
	(ADJECTIVE IRON METAL)>
	
<OBJECT ILINES
	(LOC LOCAL-GLOBALS)
	(DESC "instrument lines")
	(FLAGS NODESC VOWEL PLURAL TRYTAKE NOALL)
	(SYNONYM LINES LINE WIRES WIRE CABLES CABLE POLES)
	(ADJECTIVE INSTRUMEN WIRE\-LADEN)
      ; (ACTION ILINES-F)>

; <ROUTINE ILINES-F ()
	 <RFALSE>>

<ROUTINE RELEASE ("AUX" V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL "Release " N .V ; " for Internal Testing" >
	 <RTRUE>>

<OBJECT BIKES
	(LOC LAN-WALK)
	(DESC "bicyclists")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM BIKES BIKE BICYCLE BICYCLES BICYCLIST RIDERS COUPLE)
	(ADJECTIVE YOUNG)
	(ACTION BIKES-F)>

<ROUTINE BIKES-F ()
	 <COND (<NOT <IS? ,BIKES ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)>
	 <TELL ,CANT "see the " D ,BIKES " anymore." CR>
	 <RFATAL>>

<OBJECT NANNIES
	(LOC LOCAL-GLOBALS)
	(DESC "nannies")
	(FLAGS NODESC TRYTAKE NOALL PLURAL PERSON LIVING)
	(SYNONYM NANNIES NANNY NURSEMAID LADIES WOMEN BABYSITTE NURSE NURSES)
	(ACTION NANNIES-F)>

<ROUTINE NANNIES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <TOO-HAUGHTY>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE WATCH>
		<TELL CTHEO>
		<COND (<ZERO? ,RAID?>
		       <TELL " stare back at you haughtily." CR>
		       <RTRUE>)>
		<TELL " are scattering in every " D ,INTDIR ,PERIOD>
		<RTRUE>) 
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TOO-HAUGHTY>
		<RFATAL>)
	       (<TOUCH-T?>
		<TELL "The very idea!" CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "There are almost as many " D ,PRSO
		      " as there are " D ,CHILDREN ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCH-T? ()
	 <COND (<VERB? KISS TOUCH CLIMB-ON CLIMB-OVER SQUEEZE TASTE EAT
		       BITE RAPE PLAY KNOCK KICK KILL HIT SUCK TAKE SMELL>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOO-HAUGHTY ()
	 <TELL CTHE ,NANNIES " are much too ">
	 <COND (<ZERO? ,RAID?>
		<TELL "haughty ">)
	       (T
		<TELL "frightened ">)>
	 <TELL "to acknowledge your presence." CR>
	 <RTRUE>>

<OBJECT CHILDREN
	(LOC LOCAL-GLOBALS)
	(DESC "children")
	(FLAGS NODESC TRYTAKE NOALL PERSON LIVING PLURAL)
	(SYNONYM CHILDREN KIDS CHILD KID)
	(ACTION CHILDREN-F)>
	       
<ROUTINE CHILDREN-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE WATCH>
		<COND (<ZERO? ,RAID?>
		       <TELL "It makes you smile to watch them play." CR>
		       <RTRUE>)>
		<TELL CTHEO " are as frightened as their " 
		      D ,NANNIES ,PERIOD>
		<RTRUE>)>
	 <RETURN <HANDLE-CHARGES?>>>

<OBJECT TOURISTS
	(LOC LOCAL-GLOBALS)
	(DESC "tourists")
	(FLAGS NODESC TRYTAKE NOALL PLURAL PERSON LIVING)
	(SYNONYM TOURISTS CROWD PEOPLE PASSERSBY MEN MOB)
	(ADJECTIVE PASSING)
	(ACTION TOURISTS-F)>

<ROUTINE TOURISTS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <T-SNOBS>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE WATCH>
		<COND (<ZERO? ,RAID?>
		       <TELL CTHEO " look a lot like you do." CR>
		       <RTRUE>)>
		<TELL "The terrified " D ,PRSO " are stumbling in every " 
		      D ,INTDIR ,PERIOD>
		<RTRUE>) 
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<T-SNOBS>  
		<RFATAL>)
	       (<TOUCH-T?>
		<TELL 
"A tourist whacks you over the head with a Japanese camera">
		<COND (<T? ,RAID?>
		       <TELL " as she runs past">)>
		<TELL ". Ouch!" CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "Far too many." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE T-SNOBS ()
	 <COND (<ZERO? ,RAID?>
		<TELL CTHE ,TOURISTS
" shy away from you. They certainly aren't very friendly." CR>
		<RTRUE>)>
	 <TOO-BUSY-RUNNING>
	 <RTRUE>>

<OBJECT BABIES
	(LOC LOCAL-GLOBALS)
	(DESC "babies")
	(FLAGS NODESC PERSON PLURAL TRYTAKE NOALL)
	(SYNONYM BABIES BABES BABY INFANTS INFANT)
	(ACTION BABIES-F)>

<ROUTINE BABIES-F ()
	 <COND (<VERB? LISTEN>
		<TELL "This is supposed to be a vacation." CR>
		<RTRUE>)
	       (<HANDLE-BABES?>
		<RTRUE>)>
	 <RETURN <HANDLE-CHARGES?>>>

<ROUTINE HANDLE-CHARGES? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <EARSHOT>
		       <RTRUE>)>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<EARSHOT>
		<RFATAL>)
	       (<TOUCH-T?>
		<TELL "A nanny whacks you over the head with her "
		      D ,PARASOL>
		<COND (<T? ,RAID?>
		       <TELL " as she runs past">)>
		<TELL ". Ouch!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EARSHOT ()
	 <COND (<ZERO? ,RAID?>
	        <TELL "The suspicious " D ,NANNIES 
		      " quickly pull the " D ,CHILDREN
		      " out of earshot." CR>
		<RTRUE>)>
	 <TOO-BUSY-RUNNING>
	 <RTRUE>>

<ROUTINE TOO-BUSY-RUNNING ()
	 <TELL "Everybody's too busy running to heed you." CR>
	 <RTRUE>>

<ROUTINE HANDLE-BABES? ()
	 <COND (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		    <ENTERING?>>
		<TELL "The ">
		<COND (<T? ,RAID?>
		       <TELL "frightened ">)
		      (T
		       <TELL "suspicious ">)>
		<TELL D ,NANNIES " won't let you near." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GTREES
	(LOC LOCAL-GLOBALS)
	(DESC "trees")
	(FLAGS NODESC TRYTAKE NOALL PLURAL)
	(SYNONYM TREES TREE)
	(ACTION GTREES-F)>

<ROUTINE GTREES-F ()
	 <COND (<VERB? EXAMINE WATCH LOOK-INSIDE SEARCH>
		<TELL "The surrounding trees sway in the brisk ">
		<SAY-WIND>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " hiss and groan in the ">
		<SAY-WIND>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? CLIMB-ON CLIMB-UP ENTER CLIMB-OVER SIT LIE-DOWN
			    THROUGH RIDE>
		     <THIS-PRSO?>>
		<TELL "Tree-climbing is strictly prohibited in the "
		      D ,GARDENS "; except for " D ,CHILDREN
		      ", of course." CR>
		<RTRUE>)
	       (<VERB? EXIT LEAVE CLIMB-DOWN LEAP>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<COND (<HERE? WABE>
		       <TELL ,YOURE-ALREADY "under the " D ,PRSO ,PERIOD>
		       <RTRUE>)>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BENCH
	(LOC BROAD-WALK)
	(DESC "bench")
	(FLAGS NODESC TRYTAKE NOALL SURFACE)
	(SYNONYM BENCH SEAT)
	(ACTION BENCH-F)>

<ROUTINE BENCH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT EMPTY-INTO>
		       <PERFORM ,V?GIVE ,PRSO ,BWOMAN>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<TELL CTHE ,BWOMAN " is sitting on it." CR>
		<RTRUE>)
	       (<VERB? SIT ENTER USE LIE-DOWN CLIMB-ON CLIMB-OVER
		       STAND-ON CLIMB-UP RIDE TAKE>
		<TELL "\"No room!\" cries the " D ,BWOMAN
		      ", pushing you away." CR>
		<RTRUE>)
	       (<VERB? EMPTY>
		<NO-TOUCHIN>
		<RTRUE>)
	       (<VERB? EXIT TAKE-OFF LEAVE ESCAPE>
		<NOT-IN>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
	       
<OBJECT LAMP
	(LOC TUN1)
	(DESC "lantern")
	(FDESC "A lantern is lying in the dirt at your feet.")
	(FLAGS TAKEABLE CONTAINER)
	(SYNONYM LANTERN LIGHT LAMP TORCH BULB GLOW
	         BEAM SWITCH BATTERY BATTERIES)
	(ADJECTIVE LIGHT LIGHT\'S GLOWING HERMETICA SEALED TORCH\'S
	 	   LAMP\'S DIM YELLOW BROKEN BUSTED WATERPROOF LANTERN\'S)
	(GENERIC GENERIC-BULB-F)
	(SIZE 5)
	(MASS 4)
	(VALUE 1)
	(ACTION LAMP-F)>

"LIGHTED = lamp lit, SHADOWY = switch on, CHILLY = broken."

<ROUTINE GENERIC-BULB-F (TBL)
	 <COND (<EQUAL? ,P-IT-OBJECT ,WATT ,LAMP ,SHARD>
		<RETURN ,P-IT-OBJECT>)
	       (<EQUAL? ,W?BULB ,P-NAM ,P-XNAM>
		<RETURN ,WATT>)	       
	       (<VISIBLE? ,LAMP>
		<RETURN ,LAMP>)
	       (<HERE? IN-SHACK>
		<RETURN ,WATT>)
	       (<VISIBLE? ,SHARD>
		<RETURN ,SHARD>)
	       (T
		<RFALSE>)>>	 

<GLOBAL BEAM:NUMBER 30> "Flashlight life."

<ROUTINE LAMP-F ()
	 <COND (<AND <NOT <IS? ,LAMP ,LIGHTED>>
		     <OR <NOUN-USED? ,W?GLOW ,W?BEAM>
			 <ADJ-USED? ,W?GLOWING ,W?DIM>>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<AND <NOT <IS? ,LAMP ,CHILLY>>
		     <ADJ-USED? ,W?BROKEN ,W?BUSTED>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<NOUN-USED? ,W?BATTERIES ,W?BATTERY>
		<TELL ,CANT "access the " D ,LAMP
		      "'s batteries. They're sealed inside." CR>
		<RTRUE>)
	       (<NOUN-USED? ,W?SWITCH>
	        <COND (<THIS-PRSI?>
		       T)
		      (<VERB? EXAMINE LOOK-ON READ>
		       <TELL CTHEO "'s switch ">
		       <SWITCH-STATE>
		       <PRINT ,PERIOD>
		       <RTRUE>)
	       	      (<AND <VERB? PUSH SQUEEZE CLOSE>
		     	    <EQUAL? ,PRSI <> ,HANDS>>
		       <TURN-ON-LAMP>
		       <RTRUE>)
	       	      (<AND <VERB? PULL RELEASE OPEN>
		     	    <EQUAL? ,PRSI <> ,HANDS>>
		       <TURN-OFF-LAMP>
		       <RTRUE>)
	       	      (<VERB? USE TURN TOUCH>
		       <COND (<IS? ,PRSO ,SHADOWY>
		       	      <TURN-OFF-LAMP>
		       	      <RTRUE>)>
		       <TURN-ON-LAMP>
		       <RTRUE>)
	       	      (<VERB? TAKE LOOSEN UNSCREW UNSCREW-FROM SHAKE>
		       <TELL "The switch is ">
		       <ATTACHED-TO>
		       <RTRUE>)>)>
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? THROW>
			    <G? <GETP ,PRSO ,P?MASS> 3>>
		       <MUNG-LAMP>
		       <TELL CR CTHEO>
		       <LANDS-AT-YOUR-FEET>
		       <RTRUE>)
		      (<VERB? PUT>
		       <LAMP-SEALED>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL "The ">
		<COND (<IS? ,PRSO ,CHILLY>
		       <TELL "broken ">)
		      (T
		       <TELL "waterproof ">)>
		<TELL D ,PRSO " is more than a foot long. Its switch ">
		<SWITCH-STATE>
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL "; the beam is ">
		       <COND (<L? ,BEAM 5>
			      <TELL "almost out">)
			     (<L? ,BEAM 10>
			      <TELL "very dim">)
			     (T
			      <TELL "rather dim">)>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? LAMP-ON LIGHT-WITH>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TURN-ON-LAMP>
		<RTRUE>)
	       (<VERB? CLOSE>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<VERB? LAMP-OFF>		
		<TURN-OFF-LAMP>
		<RTRUE>)
	       (<AND <VERB? MUNG HIT CUT>
		     <PRSI? HANDS FEET AXE GNOMON PARASOL LUMP>>
		<MUNG-LAMP>
		<RTRUE>)
	       (<VERB? KICK>
		<MUNG-LAMP>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNSCREW LOOK-INSIDE REACH-IN
		       EMPTY EMPTY-INTO>
		<LAMP-SEALED>
		<RTRUE>)
	       (<VERB? POINT-AT SHINE-AT>
		<COND (<IS? ,PRSO ,LIGHTED>
		       <TELL "You aim the " D ,PRSO " towards " THEI 
		             ", but its dim beam reveals nothing "
		             <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO " isn't on." CR>
		<RTRUE>) 
	       (T
		<RFALSE>)>>

<ROUTINE LAMP-SEALED ()
	 <TELL CTHE ,LAMP " is hermetically sealed. It can't be opened." CR>
	 <RTRUE>>

<ROUTINE SWITCH-STATE ()
	 <TELL "is turned ">
	 <COND (<IS? ,PRSO ,SHADOWY>
		<TELL "on">)
	       (T
		<TELL "off">)>
	 <RTRUE>>
	
<ROUTINE MUNG-LAMP ()
	 <COND (<IS? ,LAMP ,CHILLY>
		<TELL "This has little effect on the broken "
		      D ,LAMP ,PERIOD>
		<RTRUE>)>
	 <MAKE ,LAMP ,CHILLY>
	 <SETG BEAM 0>
	 <TELL CTHE ,LAMP " snaps with a loud ">
	 <COND (<IS? ,LAMP ,LIGHTED>
		<ITALICIZE "crack">
		<TELL " and goes out." CR>		       
		<KILL-LAMP>
		<RTRUE>)>
	 <ITALICIZE "crack.">
	 <CRLF>
	 <RTRUE>>

<ROUTINE TURN-OFF-LAMP ()
	 <COND (<IS? ,LAMP ,SHADOWY>
	        <COND (<T? ,BEAM>
		       <DEQUEUE I-HARDHAT>)>
		<UNMAKE ,LAMP ,SHADOWY>
		<TELL "You turn off the " D ,LAMP "'s switch." CR>
		<KILL-LAMP>
		<RTRUE>)>
	 <TELL CTHE ,LAMP "'s switch is already off." CR>
	 <RTRUE>>

<ROUTINE TURN-ON-LAMP ()
	 <COND (<IS? ,LAMP ,SHADOWY>
		<TELL CTHE ,LAMP "'s switch is already turned on." CR>
		<RTRUE>)>
	 <MAKE ,LAMP ,SHADOWY>
	 <ITALICIZE "Click.">
	 <TELL " The ">
	 <COND (<OR <ZERO? ,BEAM>
		    <IS? ,LAMP ,CHILLY>>
		<COND (<T? ,BEAM>
		       <TELL "broken ">)>
		<TELL D ,LAMP " doesn't respond." CR>
		<RTRUE>)>
	 <QUEUE I-HARDHAT -1>
	 <MAKE ,LAMP ,LIGHTED>
	 <TELL D ,LAMP " emits a warm, yellow beam." CR>
	 <COND (<ZERO? ,LIT?>
		<SETG LIT? T>
		<SETG OLD-HERE <>>
		<CRLF>
		<V-LOOK>)>
	 <RTRUE>>

<ROUTINE KILL-LAMP ()
	 <UNMAKE ,LAMP ,LIGHTED>
	 <DEQUEUE I-HARDHAT>
	 <SAY-IF-HERE-LIT>
	 <RTRUE>>

<OBJECT FEATHERS
	(DESC "feathers")
	(FLAGS NODESC PLURAL TRYTAKE NOALL)
	(SYNONYM FEATHERS FEATHER PILE)
	(ADJECTIVE ROADRUNNER BIRD LITTLE GRAY GREY)
	(ACTION FEATHERS-F)>

<ROUTINE FEATHERS-F ()
	 <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>
	 <GONE-NOW ,FEATHERS>
	 <RFATAL>>

<OBJECT SPOT
	(LOC LOCAL-GLOBALS)
	(DESC "searchlight")
	(FLAGS NODESC)
	(SYNONYM SEARCHLIG SPOTLIGHT LIGHT LIGHTS BEAM GLARE)
	(ADJECTIVE SPOT SPOTS SEARCH SEARCHLIG SPOTLIGHT)
	(ACTION SPOT-F)>

"SEEN = turned on tower."

<ROUTINE SPOT-F ()
	 <COND (<NOT <IS? ,SPOT ,SEEN>>
		<NONE-AT-MOMENT>
		<RFATAL>)
	       (<VERB? EXAMINE WATCH LOOK-INSIDE>
		<TELL "The distant " D ,PRSO " bathes the ">
		<COND (<HERE? IN-SHACK>
		       <TELL D ,SHACK>)
		      (TY
		       <TELL D ,TOWER>)>
		<TELL " in a raw white glare." CR>
		<RTRUE>)
	       (<VERB? SEARCH FOLLOW FIND>
		<COND (<HERE? IN-SHACK>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<TELL CTHEO 
" seems to originate from a point on the southwest " D ,HORIZON ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT VOICES
	(LOC LOCAL-GLOBALS)
	(DESC "voices")
	(FLAGS NODESC PLURAL)
	(SYNONYM VOICE VOICES PEOPLE MEN MAN PERSONNEL SOUND SOUNDS)
	(ADJECTIVE MEN\'S MAN\'S)
	(ACTION VOICES-F)>

"SEEN = within earshot."

<ROUTINE VOICES-F ()
	 <COND (<NOT <IS? ,VOICES ,SEEN>>
		<CANT-SEE-ANY>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "You pause, listening intently." CR>
		<RTRUE>)
	       (<VERB? WALK-TO FOLLOW FIND>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TCRATER
	(LOC LOCAL-GLOBALS)
	(DESC "depression")
	(FLAGS NODESC)
	(SYNONYM DEPRESSION CRATER HOLE)
	(ADJECTIVE SHALLOW)
	(ACTION TCRATER-F)>

<ROUTINE TCRATER-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-DOWN>
		<TELL "The explosion that created this " D ,PRSO
" seems to have obliterated all evidence of its cause." CR>  
		<RTRUE>)
	       (<VERB? SEARCH LOOK-INSIDE ENTER THROUGH WALK-TO
		       CLIMB-DOWN STAND-ON CLIMB-OVER>
		<TELL "A cursory exploration of the " D ,PRSO
" turns up nothing but scorched rubble. You soon abandon your search and return to the paved road." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "It smells scorched." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GMAP
	(LOC IN-COTTAGE)
	(DESC "map")
	(FDESC "A crudely drawn map hangs upon the wall.")
	(FLAGS TRYTAKE NOALL READABLE)
	(SYNONYM MAP DIAGRAM BOX BOXES LINE LINES SQUIGGLE SQUIGGLES
	 	 PATTERN ERASURES ERASURE ADDITIONS ADDITION NETWORK)
	(ADJECTIVE CRUDE SCRAWLED HASTY)
	(ACTION GMAP-F)>

<GLOBAL MAPCNT:NUMBER 0>
<GLOBAL OLDCNT:NUMBER 0>

<ROUTINE GMAP-F ()
	 <COND (<NOT <IS? ,EMERALD ,NODESC>>
		<GONE-NOW ,GMAP>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-ON READ SEARCH>
		<TELL 
"The map shows a network of boxes connected by lines and arrows, with many erasures and scrawled additions. Something about the pattern is maddeningly familiar; but you ">
		<COND (<IS? ,PRSO ,SEEN>
		       <TELL "still ">)>
		<TELL 
"can't put your finger on where you've seen it before." CR>
		<COND (<NOT <IS? ,PRSO ,SEEN>>
		       <MAKE ,PRSO ,SEEN>)
		      (<NOT <EQUAL? ,OLDCNT ,MAPCNT>>
		       <TELL CR
"As you ponder over the map, you discover a number of hasty squiggles that you didn't notice the first time you looked." CR>)>
		<SETG OLDCNT ,MAPCNT>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,MAP ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
 
<OBJECT PEDESTAL
	(LOC IN-COTTAGE)
	(DESC "pedestal")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 50)
	(SYNONYM PEDESTAL)
	(ADJECTIVE SAGGING WOOD WOODEN)
	(DESCFCN DESCRIBE-PEDESTAL)
	(ACTION PEDESTAL-F)>

<ROUTINE DESCRIBE-PEDESTAL ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "The biggest book you've ever seen lies open on a "
	       D ,PEDESTAL " in the " D ,CORNER ".">
	 <RTRUE>>

<ROUTINE PEDESTAL-F ()
	 <COND (<VERB? EXAMINE SEARCH>
		<TELL CTHEO " sags under the weight of the heavy book." CR>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER PUT-UNDER>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL CTHE ,PEDESTAL " can't be budged." CR>
		<RTRUE>)
	       (<AND <THIS-PRSI?>
		     <VERB? PUT PUT-ON>>
		<TELL "The giant book completely covers the " D ,PRSI ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT TOME
	(LOC PEDESTAL)
	(DESC "book")
	(FLAGS NODESC TRYTAKE NOALL READABLE CONTAINER OPENED)
	(SIZE 50)
	(MASS 50)
	(SYNONYM TOME BOOK BINDING COVER COVERS VOLUME SPINE TITLE)
	(ADJECTIVE BIG LARGE HUGE GIANT GIGANTIC FINE RICH LEATHER)
	(ACTION TOME-F)>
	 
<ROUTINE TOME-F ()
	 <COND (<AND <NOUN-USED? ,W?TITLE ,W?COVER ,W?COVERS>
		     <VERB? EXAMINE LOOK-ON READ>>
		<TELEPHONE>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL 
"The open book is so wide, it's impossible to touch both edges with your arms outstretched. Its thousands of " D ,PAGES
" form a two-foot heap on either side of the spine; the rich binding probably required the cooperation of twenty calves." CR>
		<RTRUE>)
	       (<VERB? READ LOOK-ON LOOK-INSIDE SEARCH>
		<READ-TOME>
		<RTRUE>)
	       (<VERB? CUT RIP MUNG KICK HIT>
		<AND-RUIN>
		<RTRUE>)
	       (<HANDLE-BOOK?>
		<RTRUE>)
	       (<OR <VERB? LOOK-UNDER PUT-UNDER>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL "It'd take a dozen muscular librarians to budge ">
		<ITALICIZE "this">
		<TELL " volume." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PAGES
	(LOC TOME)
	(DESC "vellum leaves")
	(FLAGS NODESC TRYTAKE NOALL PLURAL SURFACE)
	(CAPACITY 25)
	(SYNONYM PAGES PAGE LEAVES LEAF
	 	 CALLIGRAPHY WORDS TEXT WRITING INCANTATIONS)
	(ADJECTIVE VELLUM)
	(ACTION PAGES-F)>
		      
<ROUTINE PAGES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON READ LOOK-INSIDE SEARCH>
		<READ-TOME>
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "There are 69,105 leaves here." CR>
		<RTRUE>)
	       (<VERB? LOOK-UNDER LOOK-BEHIND SEARCH>
		<TELL "You discover nothing " <PICK-NEXT ,YAWNS> 
		      " among the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? TURN RAISE MOVE PUSH>
		<TELL "You flip aimlessly through the " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? TAKE TAKE-OFF PULL CUT RIP MUNG LOOSEN
		       KICK HIT WRAP-AROUND>
		<AND-RUIN>
		<RTRUE>)
	       (<HANDLE-BOOK?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE AND-RUIN ()
	 <TELL "And ruin this magnificent volume? For shame." CR>
	 <RTRUE>>

<ROUTINE HANDLE-BOOK? ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? TOUCH KISS SQUEEZE>
		<TELL CTHE ,PAGES " feel smooth and creamy." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "The dusty " D ,PAGES " make you sneeze." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH UNFOLD>
		<TELL CTHE ,TOME " is already open." CR>
		<RTRUE>)
	       (<VERB? CLOSE FOLD>
		<TELEPHONE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TELEPHONE ()
	 <TELL 
"You try to fold the " D ,PRSO " shut, but it's like trying to move a pallet of Cleveland telephone directories." CR>
	 <RTRUE>>

<GLOBAL STUDY 0>

<ROUTINE READ-TOME ()
	 <INC STUDY>
	 <TELL
"It's hard to divine the purpose of the calligraphy. Every page begins with a descriptive heading (\"" <PICK-NEXT ,HEADINGS>
",\" for instance) followed by a list of imperatives (prayers? formulae?), each preceded by an arrow-shaped glyph.|
|
The writing ends abruptly on the page you found open, under the heading \"">
	 <COND (<PROB 50>
		<COND (<PROB 50>
		       <TELL "In which ">)
		      (T
		       <TELL "How ">)>)>
	 <TELL "Wabewalker ">
	 <COND (<EQUAL? ,STUDY 1>
		<TELL "happens upon a ">)
	       (T
		<TELL <PICK-NEXT ,PONDERINGS>>
		<COND (<G? ,STUDY 8>
		       <TELL "with great devotion ">)
		      (<G? ,STUDY 5>
		       <TELL "intently ">)
		      (<G? ,STUDY 2>
		       <TELL "yet again ">)>
		<TELL "over the ">)>
	 <TELL "Book of Hours">
	 <COND (<EQUAL? ,STUDY 1>
		<TELL ", and begins to study it">)>
	 <TELL ".\" The last few incantations read:|
|
">
	 <PRINT-LINE ,INSAVE-C>
	 <PRINT-LINE ,INSAVE-B>
	 <PRINT-LINE ,INSAVE-A>
	 <RTRUE>>

<ROUTINE PRINT-LINE (TBL "AUX" (PTR 1) LEN CHR)
	 <SET LEN <GETB .TBL 0>>
	 <COND (<T? .LEN>
		<TELL ">">
		<REPEAT ()
			<SET CHR <GETB .TBL .PTR>>
			<COND (<AND <G? .CHR 31>
				    <L? .CHR 123>>
			       <PRINTC .CHR>)>
			<COND (<IGRTR? PTR .LEN>
			       <RETURN>)>>
		<CRLF>)>
	 <RTRUE>>

<GLOBAL PONDERINGS:TABLE
	<LTABLE 2 "puzzles " "ponders " "pores ">>

<GLOBAL HEADINGS:TABLE
	<LTABLE 2
"In which Wabewalker meets a Keeper of Birds"
"Of the Red Stone's theft by a Runner of Roads"
"How Wabewalker enters the first of Seven Portals"
"In which Wabewalker chances upon a Hovel"
"Wabewalker's encounter with a Magpie"
"Wabewalker heeds the Magpie's words">>	     

<OBJECT CINDERS
	(DESC "pile of cinders")
	(FLAGS TRYTAKE NOALL SURFACE)
	(CAPACITY 50)
	(SYNONYM ASHES CINDERS ASH CINDER PILE HEAP BOOK TOME VOLUME
	 	 PEDESTAL LEAVES PAGES PAGE)
	(ADJECTIVE BLACK)
	(DESCFCN DESCRIBE-CINDERS)
	(ACTION CINDERS-F)>
	
<ROUTINE DESCRIBE-CINDERS ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <ALL-THATS-LEFT>
	 <RTRUE>>

<ROUTINE ALL-THATS-LEFT ()
	 <TELL 
"All that's left of the book and " D ,PEDESTAL " is a " D ,CINDERS ".">
	 <RTRUE>>

<ROUTINE CINDERS-F ()
	 <COND (<OR <NOUN-USED? ,W?BOOK ,W?TOME ,W?VOLUME>
		    <NOUN-USED? ,W?PEDESTAL>>
		<ALL-THATS-LEFT>
		<CRLF>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER DIG PICK>
		<TELL "You poke halfheartedly through the " D ,PRSO
		      ", but find nothing " <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<VERB? TOUCH KISS SQUEEZE>
		<TELL "The cinders feel cool and crisp." CR>
		<RTRUE>)
	       (<VERB? KICK HIT BLOW-INTO>
		<TELL "Cinders scatter all over the place." CR>
		<RTRUE>)
	       (<VERB? COUNT>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL "Cool, useless cinders fall between your fingers." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<OBJECT SINK
	(LOC IN-BATH)
	(DESC "sink")
	(FLAGS NODESC CONTAINER OPENED TRYTAKE NOALL)
	(CAPACITY 10)
	(SYNONYM SINK BASIN WASHBASIN PLUMBING PIPES DRAIN BOWL MILDEW)
	(ADJECTIVE PORCELAIN CHINA OLD\-FASHIONED BROKEN FAUCETLESS)
	(ACTION SINK-F)>

<ROUTINE SINK-F ()
	 <COND (<THIS-PRSI?>
		<COND (<AND <VERB? PUT PUT-ON>
			    <EQUAL? <GETP ,PRSO ,P?SIZE> 0 1>>
		       <VANISH>
		       <TELL CTHEO " slips down the drain and disappears." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH>
		<TELL 
"The porcelain is stained with big, disgusting patches of brown and green mildew">
		<COND (<FIRST? ,PRSO>
		       <TELL ". " ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " lying in the bowl">)>
		<TELL ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-DOWN>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		 	
<OBJECT CUPBOARD
	(LOC SWROOM)
	(DESC "cupboard")
	(FLAGS NODESC CONTAINER OPENED SURFACE TRYTAKE NOALL)
	(CAPACITY 10)
	(SYNONYM CUPBOARD SHELF SHELVES)
	(ACTION CUPBOARD-F)>

<ROUTINE CUPBOARD-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<TELL "It's an open " D ,PRSO ", with no doors." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-OVER SIT STAND-ON LIE-DOWN>>
		<TELL CTHEO " isn't big enough for such nonsense." CR>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		     
<OBJECT KNIFE
	(LOC CUPBOARD)
	(DESC "steak knife")
	(FLAGS SHARPENED TAKEABLE)
	(SYNONYM KNIFE BLADE)
	(ADJECTIVE STEAK)
	(VALUE 1)
	(SIZE 2)
	(MASS 2)
        (ACTION KNIFE-F)>
	 
<ROUTINE KNIFE-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL "The blade is still reasonably sharp." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT RSPEAKER
	(LOC LOCAL-GLOBALS)
	(DESC "loudspeaker")
	(FLAGS NODESC)
	(SYNONYM LOUDSPEAKER SPEAKER VOICE SOUND RUSSIAN)>
		        
<OBJECT GIBINOS
	(LOC LOCAL-GLOBALS)
	(DESC "GI's binoculars")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM BINOCULAR GLASSES PAIR BINOCS)
	(ADJECTIVE GI\'S)
	(ACTION GIBINOS-F)>

<ROUTINE GIBINOS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHEO " are trained on the road leading south." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>		    
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<OBJECT CEMETERY
	(LOC BONEYARD)
	(DESC "cemetery")
	(FLAGS NODESC)
	(SYNONYM CEMETERY GRAVEYARD BONEYARD)
	(ACTION HERE-F)>

<OBJECT OSS
	(LOC OSSUARY)
	(DESC "ossuary")
	(FLAGS NODESC VOWEL)
	(SYNONYM OSSUARY)
	(ACTION HERE-F)>

<OBJECT PITTS
	(LOC GLOBAL-OBJECTS)
	(DESC "Pittsburg")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM PITTSBURG)
	(ACTION PITTS-F)>

<ROUTINE PITTS-F ()
	 <COND (<DO-SHELTER? ,W100>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT ABLE
	(LOC GLOBAL-OBJECTS)
	(DESC "Able")
	(FLAGS NODESC VOWEL NOARTICLE)
	(SYNONYM ABLE)
	(ACTION ABLE-F)>

<ROUTINE ABLE-F ()
	 <COND (<DO-SHELTER? ,N75>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT BAKER
	(LOC GLOBAL-OBJECTS)
	(DESC "Baker")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM BAKER)
	(ACTION BAKER-F)>

<ROUTINE BAKER-F ()
	 <COND (<DO-SHELTER? ,S100>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE DO-SHELTER? (X)
	 <COND (<HERE? .X>
		<COND (<HERE-F>
		       <RTRUE>)>
		<RFALSE>)
	       (<ENTERING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<TELL "You're not there." CR>
		<RTRUE>)
	       (<VERB? FIND>
		<RFALSE>)
	       (T
		<CANT-FROM-HERE>
		<RTRUE>)>>

<OBJECT MEADOW
	(LOC IN-MEADOW)
	(DESC "meadow")
	(FLAGS NODESC)
	(SYNONYM MEADOW FIELD CLEARING)
	(ADJECTIVE GOLDEN GOLD)
	(ACTION HERE-F)>

<OBJECT TUBE
	(LOC NSAND)
	(DESC "extension")
	(FLAGS SURFACE CONTAINER NODESC VOWEL)
	(SYNONYM EXTENSION)
	(ADJECTIVE SQUARE WOOD WOODEN PLYWOOD)
	(ACTION TUBE-F)>

<ROUTINE TUBE-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <TUBE-CLOSED>
		       <RTRUE>)
		      (<VERB? PUT-ON THROW-OVER>
		       <PRSI-TOP-TOO-HIGH>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO 
" looks like a drinking straw made of plywood, six feet square and miles long. Its purpose is obscure, but it probably connects the " 
D ,MIKE " in the " D ,SCHOOL " to some remote part of the " D ,LAGOON ,PERIOD>
		<RTRUE>)
	       (<VERB? OPEN CLOSE REACH-IN ENTER THROUGH LOOK-INSIDE
		       SEARCH EMPTY>
		<TUBE-CLOSED>
		<RTRUE>)
	       (<VERB? CLIMB-ON STAND-ON CLIMB-OVER SIT LIE-DOWN
		       CLIMB-UP>
		<TOO-HIGH>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (T
		<RFALSE>)>>	       
	       
<ROUTINE TUBE-CLOSED ()
	 <TELL CTHE ,TUBE " has no visible openings." CR>
	 <RTRUE>>

<OBJECT JEEPS
	(LOC S100)
	(DESC "jeeps")
	(FLAGS NODESC PLURAL)
	(SYNONYM JEEPS CARS VEHICLES JEEP CAR VEHICLE)
	(ACTION TRENCHES-F)>

<OBJECT TRENCHES
	(LOC S100)
	(DESC "trenches")
	(FLAGS NODESC PLURAL)
	(SYNONYM TRENCHES TRENCH)
	(ACTION TRENCHES-F)>

<ROUTINE TRENCHES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " are near the " D ,SBUNK "'s " 
		      D ,SBENTRY ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH LOOK-UNDER LOOK-BEHIND>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? WALK-TO>
		<DO-WALK ,P?NE>
		<RTRUE>)
	       (<OR <VERB? HIDE>
		    <ENTERING?>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <PRSO? JEEPS>>
		<TELL "You hear the mutter of idling engines." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PIPES
	(LOC SWROOM)
	(DESC "stove pipes")
	(FLAGS NODESC CONTAINER OPENED PLURAL TRYTAKE NOALL)
	(CAPACITY 10)
	(SYNONYM PIPES PIPE)
	(ADJECTIVE DISCONNEC STOVE)
	(ACTION PIPES-F)>

<ROUTINE PIPES-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT EMPTY-INTO>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <TELL CTHEI " are too narrow." CR>
			      <RTRUE>)>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<FIRMLY-ATTACHED ,PRSO ,WALLS>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT MALLARDS
	(LOC LOCAL-GLOBALS)
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM SQUIRREL SQUIRRELS MALLARD MALLARDS DUCK DUCKS
	 	 CHIPMUNK CHIPMUNKS LOG INHABITANT ANIMALS RAVENS)
	(ACTION MALLARDS-F)>

<ROUTINE MALLARDS-F ()
	 <COND (<VERB? FOLLOW WALK-TO>
		<DO-WALK P?EAST>
		<RTRUE>)>
	 <TELL ,CANT "see them anymore." CR>
	 <RFATAL>>

<OBJECT FOG
	(LOC LOCAL-GLOBALS)
	(DESC "fog")
	(FLAGS NODESC)
	(SYNONYM FOG MIST)
	(ADJECTIVE THICK DENSE PALE)
	(ACTION FOG-F)>

<ROUTINE FOG-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? TOUCH SMELL REACH-IN>
		<TELL CTHEO " is damp and chilly." CR>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <EXITING?>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT SHADOW
	(LOC GLOBAL-OBJECTS)
	(DESC "shadow")
	(FLAGS NODESC)
	(SYNONYM SHADOW)
	(ACTION SHADOW-F)>

<ROUTINE SHADOW-F ()
	 <COND (<NOT <IS? ,HERE ,SHADOWY>>
		T)
	       (<VERB? WAIT-FOR>
		<RFALSE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-UNDER WALK-AROUND>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN>
		<RTRUE>)>
	 <NONE-AT-MOMENT>
	 <RFATAL>>
	       
<OBJECT PTREES
	(LOC ESAND)
	(DESC "palm trees")
	(FLAGS NODESC PLURAL)
	(SYNONYM TREES TREE PALMS)
	(ADJECTIVE PALM)
	(ACTION PTREES-F)>

<ROUTINE PTREES-F ()
	 <COND (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<RFALSE>)
	       (<ENTERING?>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)>
	 <YOU-DONT-NEED ,PTREES>
	 <RFATAL>>
		
<OBJECT MOOR
	(LOC ON-MOOR)
	(DESC "moor")
	(FLAGS NODESC)
	(SYNONYM MOOR MOORS)
	(ACTION HERE-F)>

<OBJECT TAPE
	(LOC NEROOM)
	(DESC "tape")
	(FLAGS NODESC TRYTAKE NOALL)
	(SYNONYM TAPE)
	(ACTION USELESS)>

<OBJECT SJUNK
	(LOC S100)
	(DESC "that")
	(FLAGS NODESC TRYTAKE NOALL NOARTICLE)
	(SYNONYM TECHNICIA RACKS MICROPHON MIKE STOOL EQUIPMENT)
	(ACTION SJUNK-F)>

<ROUTINE SJUNK-F ()
	 <COND (<NOT <IS? ,TKEY ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)>
	 <USELESS>
	 <RFATAL>>
	 
<OBJECT VERTEX
	(LOC LOCAL-GLOBALS)
	(DESC "vertex")
	(FLAGS NODESC)
	(SYNONYM VERTEX TOP)
	(ACTION VERTEX-F)>

<ROUTINE VERTEX-F ()
	 <COND (<HERE? ON-GNOMON>
		<COND (<HERE-F>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <ENTERING?>
		    <VERB? CLIMB-UP STAND-ON>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<FARAWAY?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE FARAWAY? ()
	 <COND (<INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? CLIMB-DOWN>>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BEACH
	(LOC LOCAL-GLOBALS)
	(DESC "shore")
	(FLAGS NODESC)
	(SYNONYM BEACH SHORE SHORELINE SIDE EDGE SAND CURVE)
	(ADJECTIVE FINE EDGE CURVE)
	(ACTION BEACH-F)>

<ROUTINE BEACH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON> 
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? STAND-ON>>
		<ALREADY-IN ,PRSO T>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? FOLLOW CROSS CLIMB-OVER CLIMB-UP CLIMB-DOWN>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? SIT LIE-DOWN>
		<VOICE-MUTTERS "This is no time for catching rays">
		<RTRUE>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER DIG SEARCH REACH-IN 
		       MOVE PUSH PULL>
		<TELL "Sifting through the sand reveals nothing "
		      <PICK-NEXT ,YAWNS> ,PERIOD>
		<RTRUE>)
	       (<VERB? KICK HIT SHAKE SQUEEZE>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<VERB? COUNT>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT OPSHORE
	(LOC LOCAL-GLOBALS)
	(DESC "opposite shore")
	(FLAGS NODESC VOWEL)
	(SYNONYM SHORE CURVE SHORELINE BEACH EDGE SIDE)
	(ADJECTIVE CURVE FAR OPPOSITE)
	(GENERIC GENERIC-SHORE-F)
	(ACTION OPSHORE-F)>

<ROUTINE GENERIC-SHORE-F (TBL)
	 <RETURN ,BEACH>>
		       
<ROUTINE OPSHORE-F ()
	 <COND (<ENTERING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<FARAWAY?>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GGRASS
	(LOC GLOBAL-OBJECTS)
	(DESC "grass")
	(FLAGS NODESC TRYTAKE NOALL SURFACE CONTAINER OPENED)
	(SYNONYM GRASS LAWN)
	(ACTION GGRASS-F)>

<ROUTINE GGRASS-F ()
	 <COND (<OR <IS? ,HERE ,INDOORS>
		    <IS? ,HERE ,NOGRASS>
		    <IS? ,HERE ,CHILLY>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<GROUND-F>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <YOU-DONT-NEED ,GGRASS>
	 <RFATAL>>
	
<OBJECT FATMAN
	(LOC ON-BIRD)
	(DESC "falling object")
	(FLAGS NODESC)
	(SYNONYM OBJECT THING BOMB MAN)
	(ADJECTIVE FALLING FAT)
	(ACTION FATMAN-F)>
     
<ROUTINE FATMAN-F ()
	 <COND (<NOT <IS? ,FATMAN ,SEEN>>
		<REFERRING>
		<RFATAL>)
	       (<VERB? EXAMINE WATCH>
		<VOICE-MUTTERS "Meet Fat Man" <>>
		<RTRUE>)>
	 <YOU-DONT-NEED ,FATMAN>
	 <RFATAL>>
		     
<ROUTINE TOO-NARROW ()
	 <TELL "[Screen too narrow.]" CR>
	 <RTRUE>>

<ROUTINE V-$CREDITS ("AUX" X)
	 <COND (<L? <GETB 0 33> 79>
		<TOO-NARROW>
		<RTRUE>)>
	 <CLEAR -1>
	 <SPLIT 23>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 
	 <CURSET 2 25>
	 <BIG-TRINITY>
	 <HLIGHT ,H-NORMAL>
	 <CURSET 3 32>
	 <TELL "by Brian Moriarty">
 	 
	 <CURSET 5 37>
	 <TELL "Testing">
	 <CURSET 6 4>
	 <TELL 
"Gary Brennan    Amy Briggs    Suzanne Frank    Max Buxton    Liz Cyr-Jones">
	 
	 <CURSET 8 13>
	 <TELL "Packaging">
	 <CURSET 8 33>
	 <TELL "Project Manager">
	 <CURSET 8 58>
	 <TELL "Copywriter">
	 
	 <CURSET 9 10>
	 <TELL "Carl Genatossio">
	 <CURSET 9 35>
	 <TELL "Jon Palace">
	 <CURSET 9 55>
	 <TELL "Elizabeth Langosy">
	 
	 <CURSET 11 12>
	 <TELL "Illustrator">
	 <CURSET 11 35>
	 <TELL "Photography">
	 <CURSET 11 58>
	 <TELL "Inner Cover">
	 
	 <CURSET 12 11>
	 <TELL "Richard Howell">
	 <CURSET 12 35>
	 <TELL "Steve Grohe">
	 <CURSET 12 56>
	 <TELL "Charles Freeman">

	 <CURSET 14 14>
	 <TELL "Sundial">
	 <CURSET 14 35>
	 <TELL "Map & Crane">
	 <CURSET 14 53>
	 <TELL "Production Coordinator">
	 
	 <CURSET 15 9>
	 <TELL "Geoff Hodgkinson       Meredith Lightbown        Angela Raup">
	 <CURSET 17 28>
	 <TELL "Microcomputer Interpreters">
	 <CURSET 18 19>
	 <TELL "Duncan Blanchard    Ed Black    Linde Simpson">
	 <CURSET 19 12>
	 <TELL "Andy Kaluzniacki    Paul Gross    Mike Morton    Richard Lay">
	 <CURSET 21 18>
	 <TELL "Interactive Fiction Plus(TM) Development System">
	 <CURSET 22 21>
	 <TELL "Marc Blank    Dave Lebling    Stu Galley">
	 <SCREEN ,S-TEXT>
	 <SET X <INPUT 1>>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <V-LOOK>
	 <RTRUE>>

<ROUTINE BIG-TRINITY ()
	 <HLIGHT ,H-BOLD>
	 <TELL "T    R    I    N    I    T    Y">
	 <RTRUE>>

<OBJECT PLUTONIUM
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM PLUTONIUM)
	(ACTION PLUTONIUM-F)>

<ROUTINE PLUTONIUM-F ()
	 <CANT-SEE-ANY>
	 <RFATAL>>