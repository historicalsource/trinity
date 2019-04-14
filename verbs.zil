"VERBS for TRINITY: (C)1986 Infocom, Inc. All Rights Reserved."

; <ROUTINE V-$CHEAT ("AUX" X)
	 <COND (<PRSO? INTNUM>
		<COND (<ZERO? ,P-NUMBER>
		       <GET-THING ,OCRANE>
		       <GET-THING ,PARASOL>
		       <GET-THING ,GNOMON>
		       <UNMAKE ,PARASOL ,OPENED>
		       <DEQUEUE I-MEEP>
	 	       <DEQUEUE I-AIR-RAID>
	 	       <DEQUEUE I-BWOMAN>
	 	       <DEQUEUE I-BOY>
	 	       <DEQUEUE I-CRANE-APPEARS>
		       <SET X <GO-INTO-LWDOOR>>
		       <RFATAL>)
		      (<EQUAL? ,P-NUMBER 1>
		       <SET TR? T>
		       <ENDGAME>
		       <RTRUE>)
		      (<EQUAL? ,P-NUMBER 2>
		       <REMOVE ,COIN>
		       <MOVE ,SCOIN ,POCKET>
		       <GO-TO-SHACK>
		       <GET-THING ,WTK>
		       <GET-THING ,BAG>
		       <GET-THING ,LAMP>
		       <SETG BEAM 10>
		       <SETG CCNT 4>
		       <GET-THING ,CAGE>
		       <EXIT-MAGPIE>
		       <MOVE ,LEM ,CAGE>
		       <QUEUE I-LEM -1>
		       <GET-THING ,RBOOT>
		       <MAKE ,RBOOT ,WORN>
		       <GET-THING ,GBOOT>
		       <MAKE ,GBOOT ,WORN>
		       <MAKE ,GBOOT ,CHILLY>
		       <MAKE ,TS6-DOOR ,OPENED>
		       <MEEP-TO-ZERO>
		       <GOTO ,IN-SHACK>
		       <RTRUE>)>)>
	 <DONT-UNDERSTAND>
	 <RTRUE>>

; <ROUTINE GET-THING (OBJ)
	 <COND (<NOT <GOT? .OBJ>>
		<MOVE .OBJ ,PLAYER>
	        <MAKE .OBJ ,TOUCHED>
	        <UNMAKE .OBJ ,NODESC>
	        <UNMAKE .OBJ ,NOALL>
		<COND (<GETP .OBJ ,P?VALUE>
		       <PUTP .OBJ ,P?VALUE 0>
		       <INC SCORE>)>)>
	 <RTRUE>>

; <ROUTINE V-$IT ()
	 <TELL "[IT = ">
	 <SAY-IT ,P-IT-OBJECT>
	 <TELL ", THEM = ">
	 <SAY-IT ,P-THEM-OBJECT>
	 <TELL ", HIM = ">
	 <SAY-IT ,P-HIM-OBJECT>
	 <TELL ", HER = ">
	 <SAY-IT ,P-HER-OBJECT>
	 <TELL "]" CR>>

; <ROUTINE SAY-IT (OBJ "AUX" (CNT 0))
	 <REPEAT ()
		 <COND (<EQUAL? .CNT 12>
			<RETURN>)
		       (<EQUAL? .OBJ <GET ,IT-DIRS .CNT>>
			<TELL "INTDIR">
			<RTRUE>)>
		 <SET CNT <+ .CNT 1>>>
	 <COND (<EQUAL? .OBJ ,ROOMS>
		<TELL "ROOMS">)
	       (<T? .OBJ>
		<TELL D .OBJ>)
	       (T
		<TELL "<>">)>>
	 
; <GLOBAL IT-DIRS:TABLE
	<PTABLE P?NORTH P?NE P?EAST P?SE P?SOUTH P?SW P?WEST P?NW
		P?UP P?DOWN P?IN P?OUT>>

; <ROUTINE SAY-WORD (WORD)
	 <COND (<ZERO? .WORD>
		<TELL "<>">)
	       (T
		<PRINTB .WORD>)>
	 <RTRUE>>

<ROUTINE V-$REFRESH ()
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <RTRUE>>

<GLOBAL VERBOSITY:NUMBER 1> "0 = super, 1 = brief, 2 = verbose."

<ROUTINE V-VERBOSE ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <SETG VERBOSITY 2>
	 <TELL "[Maximum verbosity.]" CR CR>
	 <V-LOOK>
	 <RTRUE>>

<ROUTINE V-BRIEF ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <SETG VERBOSITY 1>
	 <TELL "[Brief descriptions.]" CR>
	 <RTRUE>>

<ROUTINE V-SUPER-BRIEF\ ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <SETG VERBOSITY 0>
	 <TELL "[Super-brief descriptions.]" CR>
	 <RTRUE>>

; <ROUTINE V-EXITS ("AUX" DIRS STR (NUM 0) (BIT 1) (X 0) (INDEX 0) (1ST? T))
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)>
	 <SET DIRS <GETP ,HERE ,P?EXITS>>
	 <COND (<ZERO? .DIRS>
		<TELL "[There are no visible exits.]" CR>
		<RTRUE>)>
	 <REPEAT ()
		 <COND (<EQUAL? .BIT ,D-TOP>
			<RETURN>)
		       (<T? <BAND .DIRS .BIT>>
			<INC NUM>)>
		 <SET BIT <* .BIT 2>>> 
	 <TELL "[Visible exit">
	 <COND (<G? .NUM 1>
		<TELL "s">)>
	 <TELL ": ">
	 <SET BIT 1>
	 <REPEAT ()
		 <COND (<EQUAL? .BIT ,D-TOP>
			<RETURN>)
		       (<T? <BAND .DIRS .BIT>>
			<INC X>
			<SET STR <GET ,EXITAB .INDEX>>
			<COND (<T? .1ST?>
			       <SET 1ST? <>>
			       <TELL .STR>)
		              (T
			       <COND (<EQUAL? .X .NUM>
			              <TELL " and " .STR>
				      <RETURN>)
			             (T
			              <TELL ", " .STR>)>)>)>
		 <INC INDEX>
		 <SET BIT <* .BIT 2>>>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE V-DIAGNOSE ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <TELL 
"You feel much as you'd expect, considering what you've been through." CR>
	 <RTRUE>>

<OBJECT WEARING>

<ROUTINE V-INVENTORY ("AUX" (P? <>) (WORN? <>) OBJ NXT OLDIT)
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 
	 <SET OLDIT ,P-IT-OBJECT>
	 <SET P? <FIRST? ,POCKET>>
	 <REMOVE ,POCKET>
	 
       ; "Move all worn objects to WEARING for separate sentence."

	 <SET OBJ <FIRST? ,PLAYER>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RETURN>)>
		 <SET NXT <NEXT? .OBJ>>
		 <COND (<IS? .OBJ ,WORN>
			<SET WORN? T>
			<MOVE .OBJ ,WEARING>)>
		 <SET OBJ .NXT>>
	 	 
	 <SET OBJ <FIRST? ,PLAYER>>
	 <TELL "You're ">
	 <COND (<T? .OBJ>
		<TELL "holding ">
		<PRINT-CONTENTS ,PLAYER>
		<REPEAT ()
		 	<COND (<AND <SEE-INSIDE? .OBJ>
			     	    <SEE-ANYTHING-IN? .OBJ>>
			       <TELL ". ">
			       <COND (<IS? .OBJ ,SURFACE>
				      <TELL "On ">)
				     (T
				      <TELL "Inside ">)>
			       <TELL THE .OBJ " you see ">
			       <PRINT-CONTENTS .OBJ>)>
			<SET OBJ <NEXT? .OBJ>>
			<COND (<ZERO? .OBJ>
			       <RETURN>)>>
		<TELL ". You">
		<COND (<T? .WORN?>
		       <TELL "'re wearing ">
		       <PRINT-CONTENTS ,WEARING>
		       <COND (<T? .P?>
			      <TELL ", and you have ">)
			     (T
			      <TELL ". Your ">)>)
		      (<T? .P?>
		       <TELL " also have ">)
		      (T
		       <TELL "r ">)>)
	       (T
		<TELL "not holding anything, ">
		<COND (<T? .WORN?>
		       <TELL "but you're wearing ">
		       <PRINT-CONTENTS ,WEARING>
		       <TELL ". You">
		       <COND (<T? .P?>
			      <TELL " also have ">)
			     (T
			      <TELL "r ">)>)
		      (<T? .P?>
		       <TELL "but you have ">)
		      (T
		       <TELL "and your ">)>)>
	 <COND (<T? .P?>
		<PRINT-CONTENTS ,POCKET>
		<TELL " in " D ,POCKET>)
	       (T
		<TELL "pocket is empty">)>
	 <TELL ,PERIOD>
	 <MOVE-ALL ,WEARING ,PLAYER>
	 <MOVE ,POCKET ,PLAYER>	 
	 <SETG P-IT-OBJECT .OLDIT>
	 <RTRUE>>

<ROUTINE SAY-SURE ()
	 <TELL "Are you sure you want to ">
	 <RTRUE>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <V-SCORE>
	 <COND (<T? .ASK?>
		<CRLF>
		<SAY-SURE>
		<TELL "leave the story now?">
		<COND (<YES?>
		       <CRLF>
		       <QUIT>
		       <RTRUE>)>
		<TELL CR "[Continuing.]" CR>
		<RTRUE>)>
	 <CRLF>
	 <QUIT>
	 <RTRUE>>
		      
<ROUTINE V-RESTART ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <V-SCORE>
	 <CRLF>
	 <SAY-SURE>
	 <TELL "restart the story?">
	 <COND (<YES?>
		<RESTART>
		<FAILED "RESTART">)>
	 <RTRUE>>

<OBJECT THE-END
	(LOC ROOMS)
	(DESC "The End")
	(FLAGS LIGHTED LOCATION)>

<GLOBAL YES-INBUF:TABLE <ITABLE BYTE 12>>
<GLOBAL YES-LEXV:TABLE  <ITABLE BYTE 10>>

<ROUTINE YES? ("AUX" WORD)
	 <CRLF>
	 <REPEAT ()
		 <TELL CR "[Please type YES or NO.] >">
	         <PUTB ,YES-LEXV 0 4>
		 <READ ,YES-INBUF ,YES-LEXV>
	         <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>
	         <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		        T)
	               (<T? .WORD>
			<COND (<OR <EQUAL? .WORD ,W?Y ,W?YES ,W?YUP>
				   <EQUAL? .WORD ,W?OKAY ,W?OK ,W?AYE>
				   <EQUAL? .WORD ,W?SURE ,W?AFFIRMATIVE
					    ,W?POSITIVE>
				   <EQUAL? .WORD ,W?POSITIVELY>>
		               <RTRUE>)
	                      (<OR <EQUAL? .WORD ,W?N ,W?NO ,W?NOPE>
				   <EQUAL? .WORD ,W?NAY ,W?NAW ,W?NEGATIVE>>
		               <RFALSE>)>)>>>

<ROUTINE V-RESTORE ("AUX" X)
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <SETG OLD-HERE <>>
	 <SETG OLD-LEN 0>
	 <SET X <RESTORE>>
	 <COND (<ZERO? .X>
		<FAILED "RESTORE">)>
	 <RTRUE>>

<ROUTINE V-SAVE ("AUX" X)
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <PCLEAR>
	 <SETG OLD-HERE <>>
	 <SETG OLD-LEN 0>
	 <PUTB ,OOPS-INBUF 1 0> ; "Retrofix #50"
	 <SET X <SAVE>>
	 <COND (<ZERO? .X>
	        <FAILED "SAVE">
		<RFATAL>)
	       (<EQUAL? .X 1>
		<COMPLETED "SAVE">
		<RFATAL>)>
	 <COMPLETED "RESTORE">
	 <CRLF>
	 <V-LOOK>
	 <RFATAL>>

<ROUTINE COMPLETED (STR)
	 <TELL CR "[" .STR " completed.]" CR>
	 <INIT-STATUS-LINE>	 	 
	 <COND (<ZERO? ,VERBOSITY>
		<CRLF>)>
	 <RTRUE>>

<ROUTINE FAILED (STR)
	 <TELL CR "[" .STR " failed.]" CR>
	 <INIT-STATUS-LINE>
	 <COND (<ZERO? ,VERBOSITY>
		<CRLF>)>
	 <RTRUE>>



<ROUTINE V-SCORE ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <TELL "[Your score is " N ,SCORE " point">
	 <COND (<NOT <1? ,SCORE>>
	        <TELL "s">)>
	 <TELL " out of 100, in " N ,MOVES " move">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
	        <TELL "s">)>
	 <TELL ". This gives you the rank of ">
	 <ITALICIZE <COND (<L? ,SCORE 15> "Tourist.")
	       		  (<L? ,SCORE 50> "Explorer.")
	       		  (<L? ,SCORE 100> "Historian.")
	       		  (T "Tourist.")>>
	 <TELL "]" CR>
	 <RTRUE>>

<GLOBAL DO-SCORE?:NUMBER 0> "0 = not offered, 1 = on, 2 = off."

<ROUTINE V-NOTIFY ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (<L? ,DO-SCORE? 2>
		<SETG DO-SCORE? 2>)
	       (T
		<SETG DO-SCORE? 1>)>
	 <TELL "[Score notification o">
	 <COND (<EQUAL? ,DO-SCORE? 2>
		<TELL "ff">)
	       (T
		<TELL "n">)>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE UPDATE-SCORE ("OPTIONAL" (PTS 1) (CR T))
	 <SETG SCORE <+ ,SCORE .PTS>>
	 <COND (<EQUAL? ,DO-SCORE? 2>
	        <RTRUE>)
	       (<T? .CR>
		<CRLF>)>
	 <HLIGHT ,H-BOLD>
	 <TELL "[Your score just went up by " N .PTS " point">
	 <COND (<NOT <EQUAL? .PTS 1>>
		<TELL "s">)>
	 <TELL ,PTHE "total is now " N ,SCORE " out of 100.]">
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <HLIGHT ,H-NORMAL>
	 <SOUND 1>
	 <COND (<ZERO? ,DO-SCORE?>
		<SETG DO-SCORE? 1>
		<TELL CR
"[NOTE: You can turn score notification on or off at any time with the NOTIFY command.]" CR>)>
	 <RTRUE>>
	 
<ROUTINE V-TIME ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <COND (<HERE? PLAYGROUND>
		<PERFORM ,V?READ ,CCLOCK>
		<RTRUE>)
	       (<VISIBLE? ,WRISTWATCH>
		<PERFORM ,V?READ ,WRISTWATCH>
		<RTRUE>)
	       (T
		<TELL "There aren't any clocks visible." CR>)>
	 <RTRUE>>

<ROUTINE V-SCRIPT ()
         <COND (<WRONG-WINNER?>
	       	<RFATAL>)>
	 <TELL "[Scripting on.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <TRANSCRIPT "begin">	 
	 <RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 <COND (<WRONG-WINNER?>
	        <RFATAL>)>
	 <TRANSCRIPT "end">
	 <DIROUT ,D-PRINTER-OFF>
	 <TELL "[Scripting off.]" CR>
	 <RTRUE>>

<ROUTINE TRANSCRIPT (STR)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL CR "Here " .STR "s a transcript of interaction with" CR>
	 <V-VERSION>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <HLIGHT ,H-BOLD>
	 <TELL CR "TRINITY" CR>
	 <FANTASY>
	 <CRLF>
	 <COPYRIGHT>
	 <CRLF>
	 <TRADEMARK>
	 <CRLF>
	 <V-$ID>
	 <RELEASE>
	 <TELL " / Serial Number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>
	 <RTRUE>>
 
<ROUTINE FANTASY ()
	 <HLIGHT ,H-NORMAL>
	 <TELL "An Interactive Fantasy">
	 <RTRUE>>
		
<ROUTINE COPYRIGHT ()
	 <TELL "Copyright (C)1986 Infocom, Inc. All rights reserved.">
	 <RTRUE>>

<ROUTINE TRADEMARK ()
	 <ITALICIZE "Trinity">
	 <TELL " is a trademark of Infocom, Inc.">
	 <RTRUE>>

<ROUTINE V-$ID ()
	 <TELL "Interpreter ">
	 <PRINTN <GETB 0 30>>
	 <TELL " Version ">
	 <PRINTC <GETB 0 31>>
	 <CRLF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
         <COND (<WRONG-WINNER?>
		<RFATAL>)
	     ; (<T? ,PRSO>
	        <COND (<AND <PRSO? INTNUM>
		            <EQUAL? ,P-NUMBER 80>>
	               <TELL N ,SERIAL CR>
		       <RTRUE>)
	              (T 
		       <DONT-UNDERSTAND>)>
		<RTRUE>)>
	 <V-$ID>
	 <TELL CR "[Verifying.]" CR>
	 <COND (<VERIFY> 
		<TELL CR "[Disk correct.]" CR>
		<RTRUE>)>
	 <FAILED "$VERIFY">
	 <RTRUE>>

; <ROUTINE V-$RECORD ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (T
		<DIROUT 4>
	        <RTRUE>)>>

; <ROUTINE V-$UNRECORD ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (T
		<DIROUT -4>
	        <RTRUE>)>>

<ROUTINE V-$COMMAND ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (T
		<DIRIN 1>
	        <RTRUE>)>>

; <ROUTINE V-$RANDOM ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (<NOT <PRSO? INTNUM>>
		<TELL "[Illegal #RANDOM.]" CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>)>
	 <RTRUE>>

; <GLOBAL DEBUG?:FLAG <>>

; <ROUTINE V-$DEBUG ()
	 <COND (<AND <NOT <ZIL?>>
		     <NOT <EQUAL? <GETB 0 56> 80>>>
		<DONT-UNDERSTAND>
		<RTRUE>)>
	 <TELL "[Debug ">
	 <COND (<T? ,DEBUG?>
		<SETG DEBUG? <>>
		<TELL "off">)
	       (T
		<SETG DEBUG? T>
		<TELL "on">)>
	 <TELL ".]" CR>
	 <RTRUE>>

<ROUTINE V-USE ()
	 <COND (<IS? ,PRSO ,PERSON>
		<TELL CTHEO " might resent that." CR>
		<RTRUE>)
	       (T
		<HOW?>)>
	 <RTRUE>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">
	 <RTRUE>>

<ROUTINE V-BLOW-INTO ()
	 <COND (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?USE ,PRSO>)
	       (T
		<HACK-HACK "Blowing">)>
	 <RTRUE>>
		
<ROUTINE V-LIGHT-WITH ()
	 <COND (<PRSI? SHARD LAMP>
		<COND (<PRSI? PRSO>
		       <IMPOSSIBLE>
		       <RTRUE>)>
		<PERFORM ,V?SHINE-AT ,PRSI ,PRSO>
		<RTRUE>)>
	 <V-BURN-WITH>
	 <RTRUE>>

<ROUTINE V-BURN-WITH ()
         <COND (<PRSI? SHARD>
		<TELL CTHEI " is phosphorescent. It couldn't possibly ">
		<PRINTB ,P-PRSA-WORD>
		<TELL " anything." CR>
		<RTRUE>)>
	 <TELL "With " A ,PRSI "? " <PICK-NEXT ,YUKS> ,PERIOD>
	 <RTRUE>>

<ROUTINE V-BUY ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE-ANY ,PRSO>
		<RFATAL>)
	       (<HELD? ,PRSO>
		<ALREADY-HAVE-PRSO>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,BUYABLE>>
		<TELL ,CANT "possibly buy " THEO ,PERIOD>
		<RTRUE>)	       
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <IN? ,PRSO ,POCKET>>
		<TELL "It's in " D ,POCKET ,PERIOD>
		<RTRUE>)
	       (<T? ,PRSI>
		<TELL "You couldn't buy " THEO " with " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (T
		<NO-MONEY>)>
	 <RTRUE>>

<ROUTINE V-BUY-FROM ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE-ANY ,PRSO>
		<RFATAL>)
	       (<NOT <PRSI? BWOMAN>>
	        <TELL "It" <PICK-NEXT ,LIKELIES>
		      " that " THEI " could sell you anything." CR>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,BUYABLE>>
		<TELL ,CANT "possibly buy " A ,PRSO " from " THEI ,PERIOD>
		<RTRUE>)
	       (<HELD? ,PRSO>
		<ALREADY-HAVE-PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <IN? ,PRSO ,POCKET>>
		<TELL "It's in " D ,POCKET ,PERIOD>
		<RTRUE>)
	       (T
		<NO-MONEY>)>
	 <RTRUE>>

<ROUTINE ALREADY-HAVE-PRSO ()
	 <TELL "You already have " A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE NO-MONEY ()
	 <TELL ,DONT "have ">
	 <COND (<VERB? CHARGE>
		<TELL "a " D ,CREDIT-CARD>)
	       (T
		<TELL "any money">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-CHARGE ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE-ANY ,PRSO>
		<RFATAL>)
	       (<NOT <IS? ,PRSO ,BUYABLE>>
		<TELL ,CANT "possibly charge " THEO ,PERIOD>
		<RTRUE>)
	       (<HELD? ,PRSO>
		<ALREADY-HAVE-PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <IN? ,PRSO ,POCKET>>
		<TELL "It's in " D ,POCKET ,PERIOD>
		<RTRUE>)
	       (<PRSI? ROOMS>
		<COND (<HELD? ,CREDIT-CARD>
		       <TELL "[with the " D ,CREDIT-CARD ,BRACKET>
		       <NOT-ACCEPTED>)
		      (<AND <IN? ,CREDIT-CARD ,POCKET>
			    <EQUAL? ,WINNER ,PLAYER>>
		       <TELL "You must display your " D ,CREDIT-CARD
			     ,PERIOD>)
		      (T
		       <NO-MONEY>)>)
	       (T
		<COND (<PRSI? CREDIT-CARD>
		       <NOT-ACCEPTED>)
		      (T
		       <TELL "You couldn't charge " THEO 
		             " with " A ,PRSI ,PERIOD>)>)>
	 <RTRUE>>
		
<ROUTINE NOT-ACCEPTED ()
         <TELL "Your " D ,CREDIT-CARD " wouldn't be accepted here." CR>
	 <RTRUE>>

<ROUTINE V-CLEAN ()
	 <COND (<AND <PRSO? HANDS>
		     <IN? ,HONEY ,PLAYER>>
		<HONEY-STICKS>
		<RTRUE>)>
	 <HACK-HACK "Cleaning">
	 <RTRUE>>

<ROUTINE V-CLEAN-OFF ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <PRINT ,CANT>
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL THEO " on " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP>
		<PERFORM ,V?DIVE ,PRSO>
		<RTRUE>)
	       (<PRSO? ROOMS>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?TAKE>
		<NOT-LIKELY ,PRSO "is looking for a fight">)
	       (T
		<PRINT ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<TELL " onto that." CR>)>
	 <RTRUE>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<PRSO? ROOMS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<TELL ,CANT "climb over that." CR>)>
	 <RTRUE>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ROOMS>
		<COND (<AND <HERE? LAN-GATE>
			    <EQUAL? ,P-PRSA-WORD ,W?JUMP ,W?LEAP>>
		       <CANT-REACH <FIRST? ,TREE>>
		       <RTRUE>)>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (T
		<IMPOSSIBLE>)>
	 <RTRUE>>

<ROUTINE V-OPEN-WITH ()
	 <COND (<NOT <IS? ,PRSO ,OPENABLE>>
		<CANT-OPEN-PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,OPENED>
		<ITS-ALREADY "open">
		<RTRUE>)>
	 <TELL ,CANT>
	 <PRINTB ,P-PRSA-WORD>
	 <TELL " " THEO " with " THEI ,PERIOD>
	 <RTRUE>>	       

<ROUTINE CANT-OPEN-PRSO ()
	 <TELL "You couldn't possibly open " A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-OPEN () 
	 <COND (<NOT <IS? ,PRSO ,OPENABLE>>
		<CANT-OPEN-PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,OPENED>
		<ITS-ALREADY "open">
		<RTRUE>)
	       (<IS? ,PRSO ,LOCKED>
		<OBJECT-IS-LOCKED>
		<RTRUE>)
               (T
		<YOU-OPEN>
		<COND (<IS? ,PRSO ,CONTAINER>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
			          <IS? ,PRSO ,TRANSPARENT>>
		              <RTRUE>)
		           ; (<AND <SET F <FIRST? ,PRSO>>
			           <NOT <NEXT? .F>>
			           <SET STR <GETP .F ,P?FDESC>>>
		              <TELL CR .STR CR>)
		             (T
		              <CRLF>
			      <TELL ,YOU-SEE>
			      <PRINT-CONTENTS ,PRSO>
		              <TELL " inside." CR>)>)>)>
	 <RTRUE>>

<ROUTINE YOU-OPEN ("OPTIONAL" (THING <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <THIS-IS-IT .THING>
	 <MAKE .THING ,OPENED>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You open ">)
	       (T
		<TELL CTHE ,WINNER " opens ">)>
	 <TELL THE .THING ,PERIOD>>

<ROUTINE V-CLOSE ()
	 <COND (<IS? ,PRSO ,OPENABLE>
		<COND (<IS? ,PRSO ,OPENED>
		       <YOU-CLOSE>
		       <RTRUE>)
		      (T
		       <ITS-ALREADY "closed">)>
		<RTRUE>)
	       (T
		<CANT-CLOSE-THAT>)>
	 <RTRUE>>

<ROUTINE YOU-CLOSE ("OPTIONAL" (THING <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <THIS-IS-IT .THING>
	 <UNMAKE .THING ,OPENED>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You close ">)
	       (T
		<TELL CTHE ,WINNER " closes ">)>
	 <TELL THE .THING ,PERIOD>>

<ROUTINE CANT-CLOSE-THAT ("OPTIONAL" (THING <>))
	 <TELL ,CANT "close ">
	 <COND (<T? .THING>
		<TELL A .THING>)
	       (<T? ,PRSO>
		<TELL A ,PRSO>)
	       (T
		<TELL D ,NOT-HERE-OBJECT>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-COUNT ()
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL "Your mind wanders, and you lose count." CR>
		<RTRUE>)
	       (T
		<TELL "You only see one." CR>)>
	 <RTRUE>>

<ROUTINE V-COVER ()
	 <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-HOLD-OVER ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-CROSS ()
	 <TELL ,CANT "cross that." CR>
	 <RTRUE>>

<ROUTINE V-CUT ()
	 <COND (<PRSI? AXE>
	        <AXE-HURT>
		<RTRUE>)>
	 <TELL "You couldn't possibly cut " THEO 
	       " with " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE AXE-HURT ()
	 <TELL "Better not. The axe might ">
	 <COND (<IS? ,PRSO ,LIVING>
		<TELL "hurt ">)
	       (T
		<TELL "ruin ">)>
	 <TELL THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-RIP ()
	 <COND (<PRSI? AXE>
	        <AXE-HURT>
		<RTRUE>)>
	 <TELL "You couldn't possibly rip " THEO>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL " with " THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-DETONATE ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-DIG ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-SDIG ()
	 <PERFORM ,V?DIG ,PRSI ,PRSO>
	 <RFATAL>>

<ROUTINE V-DRINK ("OPTIONAL" (FROM? <>))
	 <TELL ,CANT "drink ">
	 <COND (<T? .FROM?>
		<TELL "from ">)>
	 <TELL D ,NOT-HERE-OBJECT ,PERIOD>	
	 <RTRUE>>

<ROUTINE V-DRINK-FROM ()
	 <V-DRINK T>
	 <RTRUE>>

<ROUTINE V-DRIVE ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? N75 S100>
		       <CANT-FROM-HERE>
		       <RTRUE>)
		      (<HERE? IN-JEEP>
		       <HOW?>
		       <RTRUE>)
		      (T
		       <TELL "There's nothing here to drive." CR>)>
		<RTRUE>)
	       (<PRSO? JEEP>
		<HOW?>
		<RTRUE>)
	       (T
	      	<TELL ,CANT "drive " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<SAY-DROPPED>)>
	 <RTRUE>>

<ROUTINE SAY-DROPPED ()
	 <COND (<OR <T? ,P-MULT?>
		    <PROB 50>>
		<TELL "Dropped." CR>
		<RTRUE>)>
	 <TELL "You ">
	 <COND (<PROB 50>
		<TELL "drop ">)
	       (T
		<TELL "put down ">)>
	 <TELL THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE IDROP ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<OR <ZERO? .L>
		    <PRSO? WINNER ME>>
		<IMPOSSIBLE>
		<RFALSE>)
	       (<NOT <EQUAL? .L ,PLAYER>>
		<TELL "You'd have to take " THEO>
		<COND (<IS? .L ,SURFACE>
		       <TELL " off ">)
		      (T
		       <TELL " out of ">)>
		<TELL THE .L " first." CR>
		<RFALSE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,PLAYER>>
		<TAKE-OFF-PRSO-FIRST>)>
	 <COND (<OR <T? ,SUITED?>
		    <HERE? IN-WATER IN-CIST UNDER-WATER IN-SKY ON-BIRD>
		    <AND <HERE? PROM>
		         <T? ,IN-DISH?>>
		    <AND <HERE? IN-ORBIT ON-SAT IN-SKY>
			 <ZERO? ,SUITED?>>>
		<TELL CTHEO>
		<SPACE>
		<LANDS-AT-YOUR-FEET>
		<RFALSE>)>
	 <MOVE ,PRSO ,HERE>
	 <RTRUE>>

<ROUTINE PRSO-SLIDES-OFF-PRSI ()
	 <TELL CTHEO " slide">
	 <COND (<NOT <IS? ,PRSO ,PLURAL>>
		<TELL "s">)>
	 <TELL " off " THEI " and ">
	 <LANDS-AT-YOUR-FEET>
	 <RTRUE>>

<ROUTINE LANDS-AT-YOUR-FEET ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <COND (<T? ,SUITED?>
		<COND (<NOT <IN? .OBJ ,PLAYER>>
		       <MOVE .OBJ ,PLAYER>)>
		<BOUNCES-IN-FILM .OBJ>
		<RTRUE>)
	       (<HERE? IN-WATER>
		<VANISH .OBJ>
		<COND (<OR <EQUAL? .OBJ ; ,CRANE ,OCRANE ,BAD-CRANE>
			   <EQUAL? .OBJ ,BAG ,EBAG>
			   <AND <EQUAL? .OBJ ,PARASOL>
				<IS? .OBJ ,OPENED>>>
		       <TELL "float">
		       <COND (<NOT <IS? .OBJ ,PLURAL>>
			      <TELL "s">)>
		       <TELL " away across ">)
		      (T
		       <TELL "disappear">
		       <COND (<NOT <IS? .OBJ ,PLURAL>>
			      <TELL "s">)>
		       <TELL " into ">)>
		<TELL THE ,LWATER ,PERIOD>
		<RTRUE>)
	       (<HERE? IN-CIST>
		<COND (<OR <EQUAL? .OBJ ,CRANE ,OCRANE ,BAD-CRANE>
			   <EQUAL? .OBJ ,BAG>
			   <AND <EQUAL? .OBJ ,EBAG>
				<NOT <FIRST? ,EBAG>>>>
		       <MOVE .OBJ ,HERE>
		       <TELL "floats quietly on the water." CR>
		       <RTRUE>)
		      (T
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <MOVE .OBJ ,UNDER-WATER>
		       <TELL "disappear">
		       <COND (<NOT <IS? .OBJ ,PLURAL>>
			      <TELL "s">)>
		       <TELL " beneath the dark water." CR>)>
		<RTRUE>)
	       (<HERE? UNDER-WATER>
		<MOVE .OBJ ,HERE>
		<COND (<OR <EQUAL? .OBJ ,CRANE ,OCRANE ,BAD-CRANE>
			   <EQUAL? .OBJ ,CREDIT-CARD ,BAG ,EBAG>>
		       <TELL "slowly ">)>
		<TELL "sink">
		<COND (<NOT <IS? .OBJ ,PLURAL>>
		       <TELL "s">)>
		<TELL " to the bottom." CR>
		<RTRUE>)
	       (<AND <HERE? PROM>
		     <T? ,IN-DISH?>>
		<VANISH .OBJ>
		<TELL "disappear">
		<COND (<NOT <IS? .OBJ ,PLURAL>>
		       <TELL "s">)>
		<TELL " into the " D ,SOAPY-WATER ,PERIOD>
		<RTRUE>)
	       (<HERE? IN-ORBIT ON-SAT>
		<VANISH .OBJ>
		<TELL "drift">
		<COND (<NOT <IS? .OBJ ,PLURAL>>
		       <TELL "s">)>
	        <TELL " slowly" ,OUTASITE>
		<RTRUE>)
	       (<HERE? IN-SKY ON-BIRD>
		<COND (<HERE? IN-SKY>
		       <MOVE .OBJ ,SPILE>)
		      (T
		       <REMOVE .OBJ>)>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		<TELL "instantly fall">
		<COND (<NOT <IS? .OBJ ,PLURAL>>
		       <TELL "s">)>
		<TELL ,OUTASITE>
		<RTRUE>)
	       (T
		<MOVE .OBJ ,HERE>
		<TELL "land">
		<COND (<NOT <IS? .OBJ ,PLURAL>>
		       <TELL "s">)>
		<TELL " at your feet." CR>)>
	 <RTRUE>>

<ROUTINE BOUNCES-IN-FILM (OBJ)
	 <TELL "bounce">
	 <COND (<NOT <IS? .OBJ ,PLURAL>>
		<TELL "s">)>
	 <TELL " around inside the " D ,FILM " until you catch it." CR>
	 <RTRUE>>

<ROUTINE V-EAT ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<NOT-LIKELY ,PRSO "would agree with you">)
	       (T
		<TELL "\"It" <PICK-NEXT ,LIKELIES>
		      " that " THEO " would agree with me.\"" CR>)>
	 <RTRUE>>

<ROUTINE V-ENTER () ; ("AUX" VEH)
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<IS? ,PRSO ,CLOTHING>
		<TELL "[Presumably, you mean WEAR " THEO
		      "." ,BRACKET>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	     ; (<SET VEH <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?ENTER .VEH>)
	       (T
		<IMPOSSIBLE>)>
	 <RTRUE>>

<ROUTINE V-ESCAPE ()
	 <V-WALK-AROUND>
	 <RTRUE>>

<ROUTINE PRE-DUMB-EXAMINE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<LOOK-INTDIR?>
		<RTRUE>)>
	 <TELL "[Presumably, you mean LOOK AT " THEO
", not LOOK INSIDE or LOOK ON or LOOK UNDER or LOOK BEHIND " THEO>
	 <PRINTC 46>
	<PRINT ,BRACKET>
	<PERFORM ,V?EXAMINE ,PRSO>
	<RTRUE>>

<ROUTINE V-DUMB-EXAMINE ()
	 <V-EXAMINE>
	 <RTRUE>>

<ROUTINE LOOK-INTDIR? ("AUX" (PTR 7) TBL X)
	 <COND (<PRSO? RIGHT LEFT>
		T)
	       (<NOT <PRSO? INTDIR>>		   
		<RFALSE>)
	       (T
		<SET X <GET ,DIRTABLES 0>>
		<COND (<OR <NOT <IS? ,HERE ,SHADOWY>>
			   <ZERO? ,FLIP?>>
		       <SET TBL <GET ,DIRTABLES 1>>)
		      (T
		       <SET TBL <GET ,DIRTABLES 2>>)>
		<REPEAT ()
			<COND (<EQUAL? ,P-DIRECTION <GET .X .PTR>>
			       <SET X <GETP ,HERE <GET .TBL .PTR>>>
			       <COND (<T? .X>
				      <SEE-DIR .X>
				      <RTRUE>)>
			       <RETURN>)
			      (<DLESS? PTR 0>
			       <RETURN>)>>)>
	 <SET X <GETP ,HERE ,P?SEE-ALL>>
	 <COND (<T? .X>
		<SEE-DIR .X>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <TELL " in " D ,RIGHT ,PERIOD>
	 <RTRUE>>
		 	       
<ROUTINE SEE-DIR (X)
	 <THIS-IS-IT .X>
	 <TELL ,YOU-SEE>
	 <COND (<AND <NOT <IS? .X ,NOARTICLE>>
		     <NOT <IS? .X ,PLURAL>>>
		<TELL "the ">)>
	 <TELL D .X " that way." CR>
	 <RTRUE>>

<GLOBAL DIRTABLES:TABLE
	<PTABLE
	 <PTABLE P?SW P?SE P?NW P?NE P?WEST P?SOUTH P?EAST P?NORTH>
	 <PTABLE P?SEE-SW P?SEE-SE P?SEE-NW P?SEE-NE 
		 P?SEE-W P?SEE-S P?SEE-E P?SEE-N>
	 <PTABLE P?SEE-SE P?SEE-SW P?SEE-NE P?SEE-NW 
		 P?SEE-E P?SEE-S P?SEE-W P?SEE-N>>>
	 
<ROUTINE PRE-EXAMINE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<IS? ,PRSO ,OPENABLE>
	        <TELL "It looks as if " THEO>
		<IS-ARE>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
	        <PRINT ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,SURFACE>
	      	<TELL ,YOU-SEE>
		<PRINT-CONTENTS ,PRSO>
		<TELL " on " THEO>
	        <PRINT ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<OR <IS? ,PRSO ,OPENED>
			   <IS? ,PRSO ,TRANSPARENT>>
		       <V-LOOK-INSIDE>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (<LOOK-INTDIR?>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,PERSON>
		     <SEE-ANYTHING-IN? ,PRSO>>
	        <TELL CTHEO " has ">
		<PRINT-CONTENTS ,PRSO>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<NOTHING-INTERESTING>
		<TELL " about " THEO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE NOTHING-INTERESTING ()
	 <COND (<PROB 50>
		<TELL ,YOU-SEE "no">)
	       (T
		<TELL ,DONT "see any">)>
	 <TELL "thing " <PICK-NEXT ,YAWNS>>
	 <RTRUE>>

<GLOBAL YAWNS:TABLE
	<LTABLE 2 "unusual" "interesting" "extraordinary" "special">>

<ROUTINE PRE-WATCH ()
	 <COND (<PRE-EXAMINE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-WATCH ()
         <COND (<IS? ,PRSO ,PERSON>
		<TELL CTHEO>
		<ISNT-ARENT>
		<TELL "doing anything " <PICK-NEXT ,YAWNS>>)
	       (T
		<TELL "Nothing " <PICK-NEXT ,YAWNS> " is happening">)>
         <PRINT ,PERIOD>
	 <RTRUE>>		

<ROUTINE V-EXIT ("AUX" L)
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?OUT>
		<RTRUE>)>
	 <SET L <LOC ,PRSO>>
	 <COND (<ZERO? .L>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<AND <IS? .L ,CONTAINER>
		     <VISIBLE? ,PRSO>>
		<TELL "[from " D .L ,BRACKET>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>
	 <RTRUE>>

<ROUTINE V-FILL ()
	 <HOW?>
       ; <COND (<ZERO? ,PRSI>
	        <TELL "There's nothing to fill it with." CR>
		<RTRUE>)
	       (T 
		<HOW?>)>
	 <RTRUE>>

<ROUTINE V-FIND ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<ZERO? .L>
		<DO-IT-YOURSELF>
		<RTRUE>)
	       (<PRSO? ME HANDS>
	        <TELL "You're right here." CR>
		<RTRUE>)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You're holding it." CR>
		<RTRUE>)
	       (<OR <IN? ,PRSO ,HERE>
		    <AND <IN? ,PRSO ,LOCAL-GLOBALS>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<ITS-RIGHT-HERE>
		<RTRUE>)
	       (<AND <OR <IS? .L ,PERSON>
			 <IS? .L ,LIVING>>
		     <VISIBLE? .L>>
	        <TELL CTHE .L " has it." CR>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <SAY-ITS>
		<COND (<IS? .L ,SURFACE>
		       <TELL "on ">)
		      (T
		       <TELL "in ">)>
		<TELL THE .L ,PERIOD>
		<RTRUE>)
	       (T
		<DO-IT-YOURSELF>)>
         <RTRUE>>

<ROUTINE DO-IT-YOURSELF ()
         <TELL "You'll have to do that " D ,ME ,PERIOD>
	 <RTRUE>>

<ROUTINE ITS-RIGHT-HERE ()
	 <SAY-ITS>
	 <TELL "right here in front of you." CR>
	 <RTRUE>>

<ROUTINE SAY-ITS ()
         <COND (<IS? ,PRSO ,PLURAL>
		<TELL "They're ">
		<RTRUE>)
	       (<IS? ,PRSO ,FEMALE>
		<TELL "She's ">
		<RTRUE>)
	       (<PRSO? BOY GIANT CHARON>
		<TELL "He's ">
		<RTRUE>)>
	 <TELL "It's ">
	 <RTRUE>>

<ROUTINE V-FLUSH ()
	 <IMPOSSIBLE>
	 <RTRUE>>
	 
<ROUTINE V-FLY ()
	 <TELL ,CANT "possibly do that." CR>
	 <RTRUE>>

<ROUTINE V-FOLD ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-UNFOLD ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-UNTANGLE ()
       	 <TELL CTHEO " isn't tangled." CR>
	 <RTRUE>>

<ROUTINE V-FOLLOW ()
	 <COND (<ZERO? ,PRSO>
		<CANT-SEE-ANY>
		<RFATAL>)>
         <TELL "But ">
	 <COND (<PRSO? ME>
		<TELL "you're right here." CR>
		<RTRUE>)
	       (T
		<TELL THEO>
		<COND (<IS? ,PRSO ,PLURAL>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
	 	<COND (<OR <VISIBLE? ,PRSO>
		    	   <IN? ,PRSO ,GLOBAL-OBJECTS>>
		       <TELL " right here">)
	       	      (T
		       <TELL "n't visible at the moment">)>)>
         <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE PRE-FEED ()
	 <COND (<PRE-GIVE T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-FEED ()
         <COND (<PRSI? ME>
		<TELL "You ">)
	       (T
		<TELL CTHEI " ">)>
	 <TELL "can't eat that." CR>
	 <RTRUE>>

<ROUTINE V-SFEED ()
	 <PERFORM ,V?FEED ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-GIVE ("OPTIONAL" (FEED? <>))
	 <COND (<OR <ZERO? ,PRSO>
		    <ZERO? ,PRSI>>
		<REFERRING>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSO ,PRSI>
		    <IN? ,PRSI ,GLOBAL-OBJECTS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,LIVING>>
		<PRINT ,CANT>
		<COND (<T? .FEED?>
		       <TELL "feed ">)
		      (T
		       <TELL "give ">)>
		<TELL "anything to " A ,PRSI ,PERIOD>
	        <RTRUE>)
	       (<AND <PRSI? ME>
		     <IN? ,PRSO ,PLAYER>>
	      	<ALREADY-HAVE-PRSO>
		<RTRUE>)
	       (<AND <NOT <PRSI? ME>>
		     <DONT-HAVE? ,PRSO>>
		<RTRUE>)
	       (<PRSO? HONEY>
		<HONEY-STICKS>
		<RTRUE>)
	     ; (<AND <PRSO? BAG>
		     <SAID-CRUMBS?>>
		<TAKE-CRUMBS>
		<RTRUE>)
	       (<CRANE-LIT?>
		<RTRUE>)
	       (<CRUMBS-GONE?>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,PLAYER>>
		<TAKE-OFF-PRSO-FIRST>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE CRUMBS-GONE? ()
	 <COND (<NOT <SAID-CRUMBS?>>
		<RFALSE>)
	       (<PRSO? BAG>
		<TAKE-CRUMBS>
		<RTRUE>)
	       (<PRSO? EBAG SOGGY>
		<TELL "The crumbs are all gone." CR>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-GIVE ()
	 <COND (<PRSI? ME>
		<NOBODY-TO-ASK>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<TELL CTHEI " shows little interest in your offer." CR>
		<RTRUE>)>
	  <NOT-LIKELY ,PRSI "would accept your offer">
	  <RTRUE>>

<ROUTINE V-SELL ()
	 <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
		<NOT-LIKELY ,WINNER "is interested in selling anything">
		<RTRUE>)
	       (<PRSI? PRSO ME WINNER>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,PERSON>>
		<NOT-LIKELY ,PRSI "would buy anything">
		<RTRUE>)>
	 <NOT-A "salesperson">
	 <RTRUE>>

<ROUTINE V-SSELL ()
	 <PERFORM ,V?SELL ,PRSI ,PRSO>
	 <RTRUE>>
		       		       
<ROUTINE PRE-SHOW ()
	 <COND (<OR <ZERO? ,PRSO>
		    <ZERO? ,PRSI>>
		<REFERRING>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSO ,PRSI>
		    <IN? ,PRSI ,GLOBAL-OBJECTS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,LIVING>>
		<TELL ,CANT "show things to " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (<AND <PRSI? ME>
		     <IN? ,PRSO ,PLAYER>>
	        <ALREADY-HAVE-PRSO>
		<RTRUE>)
	       (<AND <NOT <PRSI? ME>>
		     <DONT-HAVE? ,PRSO>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOW ()
	 <TELL CTHEI " glances at " THEO ", but makes no comment." CR>
	 <RTRUE>>

<ROUTINE V-REFUSE ()
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<WASTE-OF-TIME>
		<RTRUE>)>
         <TELL "How could you turn down such a tempting " D ,PRSO "?" CR>
	 <RTRUE>>

<ROUTINE V-HIDE ()
	 <TELL "There aren't any good hiding places here." CR>
	 <RTRUE>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">
	 <RTRUE>>

<ROUTINE V-BOUNCE ()
	 <COND (<PRSO? ROOMS>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-KILL ()
	 <COND (<NOT <IS? ,PRSO ,LIVING>>
		<TELL ,CANT "possibly attack " A ,PRSO>
		<COND (<AND <T? ,PRSI>
			    <NOT <PRSI? HANDS>>>
		       <TELL ", even with " A ,PRSI>)>
	        <PRINT ,PERIOD>
		<RTRUE>)>
	 <V-HIT>
	 <RTRUE>> 

<ROUTINE V-HIT ()
         <TELL "Attacking " THEO>
	 <COND (<AND <T? ,PRSI>
		     <NOT <PRSI? HANDS>>>
		<TELL " with " A ,PRSI>)>
	 <WONT-HELP>
	 <RTRUE>>

<ROUTINE V-KNOCK ()
	 <COND (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
	        <TELL "There's no answer." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)>
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-LAMP-OFF ()
	 <V-LAMP-ON T>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ("OPTIONAL" (OFF? <>))
	 <TELL "You couldn't turn that ">
	 <COND (<T? .OFF?>
		<TELL "off">)
	       (T
		<TELL "on">)>
	 <COND (<NOT <EQUAL? ,PRSI <> ,HANDS>>
		<TELL ", " D ,PRSI " or no " D ,PRSI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LEAP ()
	 <COND (<NOT <PRSO? ROOMS>>
	        <TELL "That'd be a cute trick." CR>
		<RTRUE>)
	       (T
		<WASTE-OF-TIME>)>
	 <RTRUE>>

<ROUTINE V-LEAVE ()
	 <COND (<OR <PRSO? ROOMS>
		    <NOT <IS? ,PRSO ,TAKEABLE>>>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<NOT <DONT-HAVE? ,PRSO>>
		<PERFORM ,V?DROP ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-SLEEP ()
         <V-LIE-DOWN>
	 <RTRUE>>

<ROUTINE V-LIE-DOWN ()
       	 <TELL "This is no time for resting." CR>
	 <RTRUE>>

<ROUTINE V-LISTEN ("AUX" (OBJ <>))
	 <COND (<AND <HERE? IN-ORBIT>
		     <ZERO? ,SUITED?>>
		<DONT-PROPAGATE>
		<RTRUE>)
	       (<PRSO? ROOMS SOUND SKY>
		<COND (<T? ,RAID?>
		       <PERFORM ,V?LISTEN ,SIRENS>
		       <RTRUE>)>
		<SET OBJ <GETP ,HERE ,P?HEAR>>
		<COND (<ZERO? .OBJ>
		       <COND (<IN? ,BEE ,HERE>
			      <PERFORM ,V?LISTEN ,BEE>
			      <RTRUE>)
			     (<HERE? SBOG NBOG>
			      <HEAR-DRIPPING>
			      <RTRUE>)
			     (<AND <VISIBLE? ,WTK>
				   <NOT <IS? ,WSWITCH ,OPENED>>>
			      <PERFORM ,V?LISTEN ,WTK>
			      <RTRUE>)
			     (T
			      <TELL ,DONT "hear anything "
				    <PICK-NEXT ,YAWNS> ,PERIOD>
			      <RTRUE>)>)
		      (T
		       <PERFORM ,V?LISTEN .OBJ>
		       <RTRUE>)>)
	       (T
		<TELL "At the moment, " THEO>
		<IS-ARE>
		<TELL "silent." CR>)>
	 <RTRUE>>

<ROUTINE V-LOCK ()
	 <COND (<OR <IS? ,PRSO ,OPENABLE>
		    <IS? ,PRSO ,CONTAINER>>
		<COND (<IS? ,PRSO ,OPENED>
		       <YOUD-HAVE-TO "close" ,PRSO>
		       <RTRUE>)
		      (<IS? ,PRSO ,LOCKED>
		       <TELL CTHEO>
		       <IS-ARE>
		       <TELL "already locked." CR>
		       <RTRUE>)
	       	      (T
		       <THING-WONT-LOCK ,PRSI ,PRSO>)>)
	       (T
		<CANT-LOCK>)>
	 <RTRUE>>

<ROUTINE V-UNLOCK ()
	 <COND (<OR <IS? ,PRSO ,OPENABLE>
		    <IS? ,PRSO ,CONTAINER>>
		<COND (<OR <IS? ,PRSO ,OPENED>
		           <NOT <IS? ,PRSO ,LOCKED>>>
		       <TELL CTHEO>
		       <ISNT-ARENT>
		       <TELL "locked." CR>
		       <RTRUE>)
	       	      (T
		       <THING-WONT-LOCK ,PRSI ,PRSO T>)>)
	       (T
		<CANT-LOCK T>)>
	 <RTRUE>>

<ROUTINE CANT-LOCK ("OPTIONAL" (UN? <>))
	 <PRINT ,CANT>
	 <COND (<T? .UN?>
		<TELL "un">)>
	 <TELL "lock " A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE THING-WONT-LOCK (THING CLOSED-THING "OPTIONAL" (UN? <>))
	 <TELL CTHE .THING " won't ">
	 <COND (<T? .UN?>
		<TELL "un">)>
	 <TELL "lock " THE .CLOSED-THING ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SCREW ()
	 <TELL ,CANT "screw " THEO " into " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-SCREW-WITH ()
	 <NOT-LIKELY ,PRSI "could help you do that">
	 <RTRUE>>

<ROUTINE V-UNSCREW ()
	 <TELL ,CANT "unscrew " THEO>
	 <COND (<NOT <PRSI? HANDS>>
		<TELL ", with or without " THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-UNSCREW-FROM ()
	 <COND (<PRSO? PRSI>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<COND (<IS? ,PRSI ,LIVING>
		       <TELL CTHEI " doesn't have " THEO ,PERIOD>
		       <RTRUE>)>
		<TELL CTHEO>
		<ISNT-ARENT>
		<COND (<IS? ,PRSI ,SURFACE>
		       <TELL "on ">)
		      (T
		       <TELL "in ">)>
		<TELL THEI ,PERIOD>
		<RTRUE>)
	       (<IN? ,SDRIVER ,PLAYER>
		<TELL "[with the " D ,SDRIVER ,BRACKET>
		<PERFORM ,V?UNSCREW ,PRSO ,SDRIVER>
		<RTRUE>)>
	 <TELL ,CANT "unscrew " THEO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-UNTIE ()
	 <PRINT ,CANT>
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS>
		<MENTION-PRAM>)>
	 <RTRUE>>

<ROUTINE MENTION-PRAM ()
	 <COND (<AND <NOT <HERE? DEATH THE-END>>
		     <IN? ,PRAM ,PLAYER>>
		<SETG P-IT-OBJECT ,PRAM>
		<TELL CR CTHE ,PRAM " rolls to a stop." CR>)>
	 <RTRUE>>

<ROUTINE V-LOOK-ON ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<IS? ,PRSO ,SURFACE>
		<TELL ,YOU-SEE>
		<PRINT-CONTENTS ,PRSO>
		<TELL " on " THEO ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,READABLE>
		<TELL CTHEO " is undecipherable." CR>
		<RTRUE>)>
	 <NOTHING-INTERESTING>
	 <TELL " on " THEO ,PERIOD>
	 <RTRUE>>	       

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (T
		<TELL "There's nothing behind " THEO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>)
	       (<PRSO? ROOMS>
		<COND (<HERE? OSSUARY>
		       <PERFORM ,V?EXAMINE ,BONES>
		       <RTRUE>)
		      (<HERE? CLIFF-EDGE>
		       <LOOK-DOWN-TCLIFF>
		       <RTRUE>)
		      (<HERE? ON-CIST IN-CIST UNDER-WATER>
		       <LOOK-IN-RWATER>
		       <RTRUE>)
		      (<HERE? IN-MILL>
		       <TELL ,YOU-SEE THE ,RESERVOIR " down below." CR>
		       <RTRUE>)
		      (<HERE? IN-JEEP>
		       <V-LOOK>
		       <RTRUE>)
		      (<HERE? TOWER-PLAT ON-TOWER>
		       <LOOK-AT-ZERO>
		       <RTRUE>)
		      (<HERE? IN-SHACK>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<HERE? ON-PLATFORM>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<AND <IS? ,HERE ,CHILLY>
			    <NOT <HERE? ICE-CAVE ON-GNOMON HALFWAY>>
			    <NOT <IS? ,RODENTS ,TOUCHED>>>
		       <PERFORM ,V?EXAMINE ,RATS>
		       <RTRUE>)>
		<PERFORM ,V?EXAMINE
			 <COND (<IS? ,HERE ,INDOORS> ,FLOOR)
			       (T ,GROUND)>>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-LOOK-UP ("AUX" (X <>))
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<PRSO? ROOMS>
		<SET X <GETP ,HERE ,P?OVERHEAD>>
		<COND (<T? .X>
		       <PERFORM ,V?EXAMINE .X>
		       <RTRUE>)>
		<NOTHING-INTERESTING>
		<PRINT ,PERIOD>
		<RTRUE>)>
	 <TELL ,CANT "look up " A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<NOT-A "surgeon">
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<NOT-A "veterinarian">
		<RTRUE>)
	     ; (<IS? ,PRSO ,OPENABLE>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND ; (<EQUAL? ,PRSO <LOC ,WINNER>>
		         <V-LOOK>
		         <RTRUE>)
		      (<AND <NOT <IS? ,PRSO ,OPENED>>
			    <NOT <IS? ,PRSO ,TRANSPARENT>>>
		       <ITS-CLOSED ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " in " THEO ,PERIOD>)>
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,CANT "look inside " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-LOOK-OUTSIDE ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)
	       (<PRSO? ROOMS>
		<COND (<HERE? TUN1 TUN2 TUN3 IN-CLOSET UNDER-WATER
			      WABE IHOUSE ARBOR-TOP NORTH-ARBOR SOUTH-ARBOR>
		       <CANT-SEE-MUCH>
		       <RTRUE>)
		      (<IS? ,HERE ,INDOORS>
		       <NOTHING-INTERESTING>
		       <TELL " outside." CR>
		       <RTRUE>)>
		<TELL ,YOURE-ALREADY "outside." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <CANT-SEE-MUCH>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,CANT "look out of " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-SLOOK-THRU ()
	 <PERFORM ,V?LOOK-THRU ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-LOOK-THRU ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<AND <T? ,PRSI>
		     <NOT <IS? ,PRSI ,TRANSPARENT>>>
		<TELL ,CANT "look through that." CR>
		<RTRUE>)
	       (T
		<NOTHING-INTERESTING>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	     ; (<IN? ,PRSO ,PLAYER>
		<TELL ,YOURE-ALREADY>
		<COND (<IS? ,PRSO ,WORN>
		       <TELL "wear">)
		      (T
		       <TELL "hold">)>
		<TELL "ing that." CR>
		<RTRUE>)
	       (T
		<NOTHING-INTERESTING>
		<TELL " under " THEO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-WEDGE ()
	 <PERFORM ,V?LOOSEN ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-LOOSEN ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-LOWER ()
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (T
		<V-RAISE>)>
	 <RTRUE>>

<ROUTINE V-MAKE ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-MELT ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-MOVE ()
	 <COND (<PRSO? ROOMS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<IS? ,PRSO ,TAKEABLE>
		<TELL "Moving " THEO " would" <PICK-NEXT ,HO-HUM> 
		      ,PERIOD>
		<RTRUE>)
	       (T
		<TELL ,CANT "possibly move " THEO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to destroy">
	 <RTRUE>>

<ROUTINE V-PAY ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>
	       
<ROUTINE V-PLAY ()
	 <COND (<PRSO? ROOMS>
		<WASTE-OF-TIME>)
	       (T
		<HACK-HACK "Playing with">)>
	 <RTRUE>>

<ROUTINE V-PICK ()
	 <COND (<IS? ,PRSO ,OPENABLE>
		<NOT-A "locksmith">)
	       (T
		<IMPOSSIBLE>)>
	 <RTRUE>>

<ROUTINE V-POINT ("AUX" (M <>) (F <>))
	 <COND (<VISIBLE? ,MEEP>
		<SET M T>)
	       (<VISIBLE? ,FLIPPER>
		<SET F T>)>
	 <COND (<PRSO? MEEP FLIPPER>
		T)
	       (<OR <PRSI? FLIPPER>
		    <AND <ZERO? ,PRSI>
			 <T? .F>>>
		<SHOW-TO-FLIPPER ,PRSO>
		<RTRUE>)
	       (<OR <PRSI? MEEP>
		    <AND <ZERO? ,PRSI>
			 <T? .M>>>
	        <SHOW-TO-MEEP ,PRSO>
		<RTRUE>)>
	 <COND (<T? ,PRSI>
		<COND (<IS? ,PRSI ,PERSON>
		       <TELL CTHEI>
		       <COND (<PRSO? PRSI>
			      <TELL " looks confused." CR>
			      <RTRUE>)>
		       <TELL " glances at " THEO ", but doesn't respond." CR>
		       <RTRUE>)>
		<NOT-LIKELY ,PRSI "would respond">
		<RTRUE>)>
	 <TELL "You point at " THEO ", but nothing "
		<PICK-NEXT ,YAWNS> " happens." CR>
	 <RTRUE>>

<ROUTINE V-SSHINE-AT ()
	 <PERFORM ,V?SHINE-AT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHINE-AT ()
	 <TELL ,CANT "illuminate anything with " A ,PRSO ,PERIOD>
	 <RTRUE>>		

<ROUTINE V-SPOINT-AT ()
	 <PERFORM ,V?POINT-AT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-POINT-AT ()
	 <COND (<AND <IN? ,FLIPPER ,HERE>
		     <NOT <PRSI? FLIPPER>>>
		<SHOW-TO-FLIPPER ,PRSI>
		<RTRUE>)>
	 <TELL "You ">
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL THEO " at " THEI ", but nothing " <PICK-NEXT ,YAWNS>
	       " happens." CR>
	 <RTRUE>>

<ROUTINE V-POP ()
	 <PRINT ,CANT>
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE V-POUR ()
	 <COND (<PRSO? HANDS>
		<TELL "[To do that, just DROP EVERYTHING.]" CR>
		<RFATAL>)
	       (<PRSO? POCKET>
		<YOUD-HAVE-TO "take off" ,CLOTHES>
		<RTRUE>)
	       (<IS? ,PRSO ,SURFACE>
		<EMPTY-PRSO ,GROUND>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<IS? ,PRSO ,OPENED>
		       <EMPTY-PRSO ,GROUND>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (T
		<TELL ,CANT "empty that." CR>)>	
	 <RTRUE>>

<ROUTINE V-POUR-FROM ()
	 <COND (<PRSI? HANDS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<PRSI? POCKET>
		<YOUD-HAVE-TO "take off" ,CLOTHES>
		<RTRUE>)
	       (<AND <NOT <IS? ,PRSI ,CONTAINER>>
		     <NOT <IS? ,PRSI ,SURFACE>>>
		<PRINT ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<TELL " things from " A ,PRSI ,PERIOD>
		<RTRUE>)
	       (<AND <IS? ,PRSI ,CONTAINER>
		     <NOT <IS? ,PRSI ,OPENED>>>
		<ITS-CLOSED ,PRSI>
		<RTRUE>)
	       (<IN? ,PRSO ,PRSI>
		<COND (<IS? ,PRSO ,TAKEABLE>
		       <TELL CTHEO>
		       <SPACE>
		       <LANDS-AT-YOUR-FEET>		
		       <RTRUE>)>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<TELL CTHEO " isn't in " THEI ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-EMPTY-INTO ()
	 <COND (<PRSI? HANDS ME>
		<V-EMPTY ,PLAYER>
		<RTRUE>)
	       (<PRSI? GROUND FLOOR>
		<V-EMPTY ,PRSI>
		<RTRUE>)
	       (<IS? ,PRSI ,SURFACE>
		<V-EMPTY ,PRSI>
		<RTRUE>)
	       (<IS? ,PRSI ,CONTAINER>
		<COND (<IS? ,PRSI ,OPENED>
		       <V-EMPTY ,PRSI>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSI>
		<RTRUE>)
	       (T
		<TELL ,CANT "empty " THEO " into " THEI ,PERIOD>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-EMPTY ("OPTIONAL" (DEST <>))
	 <COND (<ZERO? .DEST>
		<SET DEST ,PLAYER>)>
	 <COND (<IS? ,PRSO ,SURFACE>
		<EMPTY-PRSO .DEST>
		<RTRUE>)
	       (<IS? ,PRSO ,CONTAINER>
		<COND (<IS? ,PRSO ,OPENED>
		       <EMPTY-PRSO .DEST>
		       <RTRUE>)>
		<ITS-CLOSED ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,CANT "possibly empty " THEO ,PERIOD>)>
	 <RTRUE>>
		
<ROUTINE EMPTY-PRSO (DEST "AUX" OBJ NXT X)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<ZERO? .OBJ>
		<TELL "There's nothing ">
		<COND (<IS? ,PRSO ,SURFACE>
		       <TELL "on ">)
		      (T
		       <TELL "in ">)>
		<TELL THEO ,PERIOD>
		<RTRUE>)>
	 <SETG P-MULT? T>	
	 <REPEAT ()
		 <COND (<NOT <IS? .OBJ ,NOARTICLE>>
			<TELL "The ">)>
		 <TELL D .OBJ ": ">
		 <COND (<EQUAL? .DEST ,PLAYER>
			<SET X <PERFORM ,V?TAKE .OBJ ,PRSO>>
			<COND (<EQUAL? .X ,M-FATAL>
			       <RETURN>)>)
		       (<EQUAL? .DEST ,GROUND ,FLOOR>
			<COND (<IS? ,PRSO ,PLURAL>
			       <TELL "They ">)
			      (T
			       <TELL "It ">)>
			<LANDS-AT-YOUR-FEET>)
		       (<G? <- <+ <WEIGHT .DEST> <WEIGHT .OBJ>>
		       	       <GETP .DEST ,P?SIZE>>
		    	    <GETP .DEST ,P?CAPACITY>>
			<TELL "There isn't enough room ">
			<COND (<IS? .DEST ,CONTAINER>
		       	       <TELL "in ">)
		      	      (T
		       	       <TELL "on ">)>
			<TELL THE .DEST ,PERIOD>)
		       (T
			<MOVE .OBJ .DEST>
			<TELL "Done." CR>)>
		 <SET OBJ .NXT>
		 <COND (<ZERO? .OBJ>
			<RETURN>)>>
	 <SETG P-MULT? <>>
	 <RTRUE>>

<ROUTINE V-PULL ()
	 <HACK-HACK "Pulling on">
	 <RTRUE>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing around">
	 <RTRUE>>

<ROUTINE V-PUSH-TO ()
	 <COND (<AND <PRSO? HANDS>
		     <T? ,PRSI>>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)>
	 <TELL ,CANT "push " THEO " around like that." CR>
	 <RTRUE>>

<ROUTINE PRE-POCKET ()
	 <COND (<WRONG-WINNER?>
		<RTRUE>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<IN? ,PRSO ,POCKET>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already in " D ,POCKET ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	 
<ROUTINE V-POCKET ()
	 <PERFORM ,V?PUT ,PRSO ,POCKET>
	 <RTRUE>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSO? CLOTHES>
		<INAPPROPRIATE>
		<RTRUE>)
	       (<PRSO? PRSI>
		<COND (<AND <PRSO? BAG>
			    <CRUMBS? <GET ,P-NAMW 0>>>
		       <TELL "They're already in the bag." CR>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)
	       (<PRSI? INTDIR RIGHT LEFT>
		<TELL "[You must specify an object.]" CR>
		<RTRUE>)
	       (<PRSI? HANDS>
		<NOT-LIKELY ,PRSO "would fit very well">
		<RTRUE>)
	       (<EQUAL? ,FEET ,PRSO ,PRSI>
		<COND (<OR <EQUAL? ,GBOOT ,PRSO ,PRSI>
			   <EQUAL? ,RBOOT ,PRSO ,PRSI>>
		       <RFALSE>)>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (<IN? ,PRSI ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<PRSO? HANDS>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)
	       (<IN? ,PRSO ,PRSI>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already ">
		<COND (<IS? ,PRSI ,SURFACE>
		       <TELL "o">)
		      (T
		       <TELL "i">)>
		<TELL "n " THEI ,PERIOD>
		<RTRUE>)
	     ; (<AND <PRSO? BAG>
		     <SAID-CRUMBS?>>
		<TAKE-CRUMBS>
		<RTRUE>)
	       (<CRUMBS-GONE?>
		<RTRUE>)
	       (<PRSO? HONEY>
		<HONEY-STICKS>
		<RTRUE>)
	       (<AND <PRSO? ICE>
		     <VERB? THROW THROW-OVER>>
		<SHATTER-ICE>
		<RTRUE>)
	       (<CRANE-LIT?>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSO ,PRSI>
		    <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <IS? ,PRSO ,TAKEABLE>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? ,PRSI>>
		<CANT-SEE-ANY ,PRSI>
		<RTRUE>)
	       (<AND <IS? ,PRSO ,WORN>
		     <IN? ,PRSO ,PLAYER>
		     <NOT <PRSI? ME>>>
		<TAKE-OFF-PRSO-FIRST>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE CRANE-LIT? ()
	 <COND (<AND <PRSO? CRANE>
		     <IS? ,PRSO ,LIGHTED>>
		<TELL "You hesitate as the " D ,PRSO
		      " glows brighter." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TAKE-OFF-PRSO-FIRST ()
	 <UNMAKE ,PRSO ,WORN>
	 <TELL "[taking off " THEO " first" ,BRACKET>         
	 <RTRUE>>

<ROUTINE PRE-PUT-ON ()
	 <COND (<PRE-PUT>
		<RTRUE>)
	       (<NOT <IS? ,PRSI ,SURFACE>>
		<NO-GOOD-SURFACE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-GOOD-SURFACE ()
	 <TELL "There's no good " D ,CSURFACE " on " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-PUT-ON () 
	 <COND (<PRSI? ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)>
	 <V-PUT>
	 <RTRUE>>

<ROUTINE V-PUT ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<OR <ZERO? .L>
		    <AND <T? ,PRSI>
		     	 <NOT <IS? ,PRSI ,SURFACE>>
		     	 <NOT <IS? ,PRSI ,CONTAINER>>			 
			 <NOT <IS? ,PRSI ,OPENED>>
		     	 <NOT <IS? ,PRSI ,OPENABLE>>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <NOT <IS? ,PRSI ,OPENED>>
		     <NOT <IS? ,PRSI ,SURFACE>>>
		<THIS-IS-IT ,PRSI>
		<TELL CTHEI>
		<ISNT-ARENT ,PRSI>
		<TELL "open." CR>
		<RTRUE>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There isn't enough room ">
		<COND (<IS? ,PRSI ,CONTAINER>
		       <TELL "in ">)
		      (T
		       <TELL "on ">)>
		<TELL THEI ,PERIOD>
		<RTRUE>)
	       (<NOT <EQUAL? .L ,PLAYER>>
		<TELL "Maybe you should take " THEO>
		<COND (<IS? .L ,SURFACE>
		       <TELL " off ">)
		      (T
		       <TELL " out of ">)>
		<TELL THE .L " first." CR>
		<RTRUE>)>
	 <MOVE ,PRSO ,PRSI>
	 <MAKE ,PRSO ,TOUCHED>
	 <COND (<T? ,P-MULT?>
		<TELL "Done." CR>)
	       (T
		<TELL "You put " THEO>
		<COND (<IS? ,PRSI ,CONTAINER>
		       <TELL " in ">)
		      (T
		       <TELL " on ">)>
		<TELL THEI ,PERIOD>)>
	  <COND (<AND <PRSI? POCKET>
		      <EQUAL? ,PRSO ,LEM ,SKINK>>
		 <TELL CR CTHEO
" squirms uncomfortably for a moment, then lies still." CR>)>
	  <RTRUE>>

<ROUTINE V-PLUG ()
	 <PRINT ,CANT>
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL THEO " into ">
	 <COND (<T? ,PRSI>
		<TELL THEI>)
	       (T
		<TELL "anything">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>
	
<ROUTINE V-UNPLUG ()
	 <TELL CTHEO>
	 <ISNT-ARENT>
	 <TELL "connected to ">
	 <COND (<T? ,PRSI>
		<TELL THEI>)
	       (T
		<TELL "anything">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>
	 <RTRUE>>

<ROUTINE V-PUT-UNDER ()
         <TELL ,CANT "put anything under that." CR>
	 <RTRUE>>
	       
<ROUTINE V-RAPE ()
	 <TELL "What a wholesome idea." CR>
	 <RTRUE>>

<ROUTINE V-RAISE ()
	 <COND (<PRSO? ROOMS>
		<V-STAND>
		<RTRUE>)
	       (T
		<HACK-HACK "Toying in this way with">)>
	 <RTRUE>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <IS? ,PRSO ,PERSON>
		    <IS? ,PRSO ,LIVING>>
		<NOT-A "surgeon">
		<RTRUE>)
	       (<IS? ,PRSO ,DOORLIKE>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "You reach into " THEO
			     ", but experience nothing "
			     <PICK-NEXT ,YAWNS> ,PERIOD>
		       <RTRUE>)>
		<ITS-CLOSED>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,CONTAINER>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,OPENED>>
		<TELL "It's not open." CR>
		<RTRUE>)
	       (<OR <ZERO? .OBJ>
		    <NOT <IS? .OBJ ,TAKEABLE>>>
		<TELL "It's empty." CR>
		<RTRUE>)
	       (T
		<SETG P-IT-OBJECT .OBJ>
		<TELL "You reach into " THEO " and feel something." CR>)>
	 <RTRUE>>

<ROUTINE V-READ ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<NOT <IS? ,PRSO ,READABLE>>
		<HOW-READ>
		<TELL "?" CR>
		<RTRUE>)
	       (T
		<TELL "There's nothing written on it." CR>)>
	 <RTRUE>>

<ROUTINE V-READ-TO ()
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RFATAL>)
	       (<NOT <IS? ,PRSO ,READABLE>>
		<HOW-READ>
		<TELL " to " A ,PRSI "?" CR>
		<RTRUE>)
	       (<EQUAL? ,WINNER ,PLAYER>
		<NOT-LIKELY ,PRSI "would appreciate your reading">
		<RTRUE>)
	       (T
		<TELL "Maybe you ought to do it." CR>)>
	 <RTRUE>>

<ROUTINE HOW-READ ()
	 <TELL "How can you read " A ,PRSO>
	 <RTRUE>>

<ROUTINE V-RELEASE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<IN? ,PRSO ,CAGE>
		<COND (<IS? ,CAGE ,OPENED>
		       <TELL CTHE ,CAGE " isn't closed." CR>
		       <RTRUE>)>
		<PERFORM ,V?OPEN ,CAGE>
		<RTRUE>)
	       (<AND <PRSO? LEM>
		     <IN? ,PRSO ,FISSURE>>
		<HOW?>
		<RTRUE>)
	       (T
		<COND (<PRSO? ME>
		       <TELL "You aren't ">)
	              (T
		       <TELL CTHEO>
		       <ISNT-ARENT>)>
	        <TELL "confined by anything." CR>)>
	 <RTRUE>>
		
<ROUTINE V-REPLACE ()
	 <COND (<PRSO? ME>
		<TELL "Easily done." CR>
		<RTRUE>)
	       (T
		<TELL CTHEO " doesn't need replacement." CR>)>
	 <RTRUE>>

<ROUTINE V-REPAIR ()
	 <COND (<PRSO? ME>
		<TELL "You aren't ">)
	       (T
		<TELL CTHEO>
		<ISNT-ARENT>)>
	 <TELL "in need of repair." CR>
	 <RTRUE>>

<ROUTINE V-HELP ()
	 <TELL 
"[If you're really stuck, maps and InvisiClues(TM) Hint Booklets are available at most Infocom dealers, or use the order form included in your ">
	 <ITALICIZE "Trinity">
	 <TELL " package.]" CR>
	 <RTRUE>>

<ROUTINE V-RESCUE ()
	 <COND (<PRSO? ME>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <V-HELP>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)>
	 <TELL CTHEO>
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL " do">)
	       (T
		<TELL " does">)>
	 <TELL "n't need any help." CR>
	 <RTRUE>>

<ROUTINE V-RIDE ()
	 <COND (<IS? ,PRSO ,LIVING>
		<NOT-LIKELY ,PRSO "wants to play piggyback">
		<RTRUE>)
	       (T
		<TELL ,CANT "ride that." CR>)>
	 <RTRUE>>

<ROUTINE V-TOUCH ()
	 <HACK-HACK "Fiddling with">
	 <RTRUE>>

<ROUTINE V-STOUCH-TO ()
	 <PERFORM ,V?TOUCH-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TOUCH-TO ()
	 <COND (<PRSO? HANDS>
		<PERFORM ,V?TOUCH ,PRSI>
		<RTRUE>)>
	 <TELL "You ">
	 <PRINTB ,P-PRSA-WORD>
	 <TELL " " THEO " next to " THEI
	       ", but nothing " <PICK-NEXT ,YAWNS> " happens." CR>
	 <RTRUE>>	 

<ROUTINE V-TUNE-TO ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-BOW ()
	 <HACK-HACK "Paying respect to">
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <COND (<IS? ,PRSO ,CONTAINER>
		<COND (<AND <NOT <IS? ,PRSO ,OPENED>>
			    <NOT <IS? ,PRSO ,TRANSPARENT>>>
		       <YOUD-HAVE-TO "open" ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL ,YOU-SEE>
		       <PRINT-CONTENTS ,PRSO>
		       <TELL " inside " THEO ,PERIOD>)>
		<RTRUE>)
	       (<IS? ,PRSO ,SURFACE>
		<TELL ,YOU-SEE>
		<PRINT-CONTENTS ,PRSO>
		<TELL " on " THEO ,PERIOD>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>) 
	       (T
		<NOTHING-INTERESTING>
		<PRINT ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<IS? ,PRSO ,PERSON>
		<PERFORM ,V?ALARM ,PRSO>)
	       (<AND <NOT <IS? ,PRSO ,TAKEABLE>>
		     <NOT <IS? ,PRSO ,TRYTAKE>>>
		<HACK-HACK "Shaking">)
	       (T
		<WASTE-OF-TIME>)>
	 <RTRUE>>

<ROUTINE V-SHOOT ()
	 <TELL ,DONT "have any weapons." CR>
	 <RTRUE>>

<ROUTINE V-SIT ()
	 <COND (<EQUAL? ,PRSO <> ,ROOMS>
		<COND (<HERE? IN-JEEP>
		       <TELL "You're already sitting." CR>
		       <RTRUE>)
		      (<HERE? N75>
		       <YOUD-HAVE-TO "get into" ,JEEP>
		       <RTRUE>)
		      (<HERE? BROAD-WALK>
		       <PERFORM ,V?SIT ,BENCH>
		       <RTRUE>)>
		<NO-SWIM>
		<RTRUE>)>
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-SMELL ("AUX" (OBJ <>))
	 <COND (<AND <HERE? IN-ORBIT>
		     <ZERO? ,SUITED?>>
		<DONT-PROPAGATE>
		<RTRUE>)
	       (<PRSO? ROOMS SKY>
		<SET OBJ <GETP ,HERE ,P?ODOR>>
		<COND (<ZERO? .OBJ>
		       <TELL ,DONT "smell anything " <PICK-NEXT ,YAWNS>
			     ,PERIOD>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?SMELL .OBJ>
		       <RTRUE>)>)
	       (T
		<TELL "It smells just like " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? IN-CLOSET>
		       <TELL "There's barely enough room." CR>
		       <RTRUE>)
		      (T
		       <TELL "You begin to feel a little dizzy." CR>)>
		<RTRUE>)
	       (T
		<TELL ,CANT "spin that." CR>)>
	 <RTRUE>>

<ROUTINE V-SQUEEZE ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-DUCK ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<T? ,IN-PRAM?>
		<PERFORM ,V?STAND-ON ,PRAM>
		<RTRUE>)
	       (<HERE? IN-JEEP>
		<YOUD-HAVE-TO "get out of" ,JEEP>
		<RTRUE>)
	       (T
		<ALREADY-STANDING>)>
	 <RTRUE>>

<ROUTINE ALREADY-STANDING ()
	 <TELL ,YOURE-ALREADY "standing." CR>
	 <RTRUE>>

<ROUTINE V-STAND-ON ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE V-STAND-UNDER ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (<ZERO? ,PRSI>
		<WASTE-OF-TIME>
		<RTRUE>)
	       (T
		<PERFORM ,V?KILL ,PRSI ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-SWIM ()
	 <COND (<PRSO? ROOMS>
		<COND (<AND <T? ,IN-DISH?>
			    <HERE? PROM>>    
		       <PERFORM ,V?SWIM ,DISH>
		       <RTRUE>)
		      (<GLOBAL-IN? ,STREAM ,HERE>
		       <PERFORM ,V?SWIM ,STREAM>
		       <RTRUE>)
		      (<HERE? LONG-WATER ROUND-POND ON-CIST>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<HERE? IN-WATER IN-CIST UNDER-WATER>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? DOCKSIDE AT-BEND ON-MOOR>
		       <PERFORM ,V?SWIM ,STYX>
		       <RTRUE>)
		      (<HERE? SSAND WSAND ESAND NSAND>
		       <PERFORM ,V?SWIM ,LAGOON>
		       <RTRUE>)>
		<NO-SWIM>
		<RTRUE>)
	       (<AND <PRSO? INTDIR>
		     <T? ,P-DIRECTION>
		     <EQUAL? ,WINNER ,PLAYER>>
		<COND (<OR <HERE? IN-WATER UNDER-WATER>
		           <AND <HERE? ON-CIST>
				<EQUAL? ,P-DIRECTION ,P?NORTH ,P?IN>>
			   <AND <HERE? IN-CIST>
				<EQUAL? ,P-DIRECTION ,P?SOUTH ,P?OUT>>
			   <AND <HERE? LONG-WATER>
				<EQUAL? ,P-DIRECTION ,P?EAST ,P?IN>>
			   <AND <HERE? SSAND>
				<EQUAL? ,P-DIRECTION ,P?SOUTH ,P?SE ,P?SW>>
			   <AND <HERE? ESAND>
				<EQUAL? ,P-DIRECTION ,P?EAST ,P?SE ,P?NE>>
			   <AND <HERE? WSAND>
				<EQUAL? ,P-DIRECTION ,P?WEST ,P?NW ,P?SW>>
			   <AND <HERE? NSAND>
				<EQUAL? ,P-DIRECTION ,P?NORTH ,P?NE ,P?NW>>>
		       <DO-WALK ,P-DIRECTION>
		       <RTRUE>)>	      
		<PRINT ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<TELL " that way from here." CR>
		<RTRUE>)
	       (T
		<IMPOSSIBLE>)> 
	 <RTRUE>>

<ROUTINE NO-SWIM ()
	 <TELL "There's no place to ">
	 <PRINTB ,P-PRSA-WORD>
	 <TELL " here." CR>
	 <RTRUE>>

<ROUTINE V-DIVE ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? HALFWAY ON-GNOMON>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)
		      (<HERE? LONG-WATER ROUND-POND ON-CIST>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<HERE? IN-WATER IN-CIST UNDER-WATER>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<HERE? SSAND WSAND ESAND NSAND>
		       <PERFORM ,V?SWIM ,LAGOON>
		       <RTRUE>)>
		<NO-SWIM>
		<RTRUE>)
	       (<AND <PRSO? INTDIR>
		     <T? ,P-DIRECTION>
		     <EQUAL? ,WINNER ,PLAYER>>
		<COND (<OR <HERE? IN-WATER UNDER-WATER>
		           <AND <HERE? ON-CIST>
				<EQUAL? ,P-DIRECTION ,P?NORTH ,P?IN>>
			   <AND <HERE? LONG-WATER>
			        <EQUAL? ,P-DIRECTION ,P?EAST ,P?IN>>>
		      <DO-WALK ,P-DIRECTION>
		      <RTRUE>)>
		<PRINT ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<TELL " that way from here." CR>
		<RTRUE>)
	       (T
		<IMPOSSIBLE>)> 
	 <RTRUE>>

<ROUTINE V-SGET-FOR ()
	 <PERFORM ,V?TAKE ,PRSI>
	 <RTRUE>>

<ROUTINE V-GET-FOR ()
	 <PERFORM ,V?TAKE ,PRSO>
	 <RTRUE>>

<ROUTINE V-TAKE-WITH ()
	 <HOW?>
	 <RTRUE>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<PRSO? CLOTHES FEET>
		<INAPPROPRIATE>
		<RTRUE>)
	       (<IS? ,PRSO ,TAKEABLE>
		<COND (<AND <IN? ,PRSO ,WINNER>
		            <IS? ,PRSO ,WORN>>
		       <UNMAKE ,PRSO ,WORN>
		       <TELL "You take off " THEO ,PERIOD>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>)>
		<RTRUE>)
	       (<IS? ,PRSO ,VEHBIT>
		<PERFORM ,V?EXIT ,PRSO>
		<RTRUE>)
	       (T
		<IMPOSSIBLE>)>
	 <RTRUE>>

<ROUTINE V-TASTE ()
	 <PERFORM ,V?EAT ,PRSO>
	 <RTRUE>>

<ROUTINE V-ADJUST ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?ADJUST>
		<TELL CTHEO " doesn't need adjustment." CR>
		<RTRUE>)
	       (T 
		<TELL ,CANT " focus " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-FOCUS-ON ()
	 <COND (<ZERO? ,PRSI>
		<COND (<PRSO? BINOS>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<IN? ,BINOS ,PLAYER>
		     ; <TELL "[with the " D ,BINOS ,BRACKET>
		       <PERFORM ,V?LOOK-THRU ,PRSO ,BINOS>
		       <RTRUE>)
		      (T
		       <HOW?>)>
		<RTRUE>)
	       (T
		<COND (<PRSO? BINOS>
		       <PERFORM ,V?LOOK-THRU ,PRSI ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL ,CANT "focus " THEO 
			     " on " THEI ,PERIOD>)>)>
	 <RTRUE>>       

"*** CHARACTER INTERACTION DEFAULTS ***"

<ROUTINE SILLY-SPEAK? ()
	 <COND (<EQUAL? ,PRSO <> ,ROOMS>
		<RFALSE>)
	       (<NOT <IS? ,PRSO ,PERSON>>
		<NOT-LIKELY ,PRSO "would respond">
	 	<PCLEAR>
		<RTRUE>)
	       (<PRSO? ME PRSI WINNER>
		<WASTE-OF-TIME>
		<PCLEAR>
		<RTRUE>)
	       (T
		<THIS-IS-IT ,PRSO>
		<RFALSE>)>>

<ROUTINE NO-RESPONSE ()
	 <TELL CTHEO " doesn't respond." CR>
	 <PCLEAR>
	 <RTRUE>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<EQUAL? ,WINNER ,PRSI>
		<WASTE-OF-TIME>
		<RFATAL>)
	       (<PRSO? ME>
		<TALK-TO-SELF>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-REPLY ("AUX" WHO)
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)>
	 <NO-RESPONSE>
	 <RTRUE>>
		       
<ROUTINE V-QUESTION ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TO-DO-THING-USE "ask about" "ASK CHARACTER ABOUT">
		<RFATAL>)>
	 <NO-RESPONSE>
	 <RTRUE>>
		        
<ROUTINE V-ALARM ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)>
	 <COND (<PRSO? ROOMS ME>
		<TELL ,YOURE-ALREADY "wide awake." CR>
		<RTRUE>)
	       (<PRSO? DSKINK DLEM DMEEP>
		<THIS-IS-NOT "The Greatest Story Ever Told">
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already wide awake." CR>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-YELL ()
	 <COND (<PRSO? ROOMS>
		<COND (<HERE? S100>
		       <PERFORM ,V?YELL ,GIS>
		       <RTRUE>)
		      (<HERE? W100>
		       <WAKE-DOG>
		       <RTRUE>)>
		<TELL "You begin to get a sore throat." CR>
		<RTRUE>)>
	 <NOT-LIKELY ,PRSO "would respond">
	 <RTRUE>>

<ROUTINE V-SAY ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
	        <COND (<ANYONE-HERE?>
		       <WAY-TO-TALK>
		       <RTRUE>)>
		<TALK-TO-SELF>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-GOODBYE ()
	 <V-HELLO>
	 <RTRUE>>

<ROUTINE V-HELLO ()
         <COND (<SILLY-SPEAK?>
	        <RFATAL>)
	       (<PRSO? ROOMS>
		<TALK-TO-SELF>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>
	 
<ROUTINE V-WAVE-AT ()
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-ASK-FOR ("AUX" WHO)
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<OR <EQUAL? ,WINNER ,PRSI>
		    <NOT <IS? ,PRSI ,TAKEABLE>>>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-TELL ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<PRSO? ME>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TALK-TO-SELF>
		       <RTRUE>)>
		<NO-RESPONSE>
		<RTRUE>)
	       (T
		<SETG QCONTEXT ,PRSO>
		<SETG QCONTEXT-ROOM <LOC ,PRSO>>
	        <COND (<T? ,P-CONT>
		       <SETG WINNER ,PRSO>
		       <THIS-IS-IT ,PRSO>
		       <RTRUE>)>
		<NO-RESPONSE>)>
	 <RTRUE>>

<ROUTINE V-TELL-ABOUT ()
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-THANK ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)
	       (<EQUAL? ,WINNER ,PLAYER>
		<COND (<PRSO? ME>
		       <TELL "Self-congratulations">
		       <WONT-HELP>
		       <RTRUE>)>
		<TELL "There's no need to thank " THEO ,PERIOD>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-WHO ()
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-WHERE ()
	 <V-WHAT>
	 <RTRUE>>

<ROUTINE V-WHAT ()
	 <COND (<SILLY-SPEAK?>
		<RFATAL>)>
	 <NO-RESPONSE>
	 <RTRUE>>

<ROUTINE V-THROUGH ()
	 <COND (<PRSO? ROOMS>
		<DO-WALK ,P?IN>
		<RTRUE>)
	     ; (<IS? ,PRSO ,OPENABLE>
	        <DO-WALK <OTHER-SIDE ,PRSO>>
		<RTRUE>)
	     ; (<IS? ,PRSO ,VEHBIT>
	        <PERFORM ,V?ENTER ; ,V?BOARD ,PRSO>
	        <RTRUE>)
	     ; (<IN? ,PRSO ,WINNER>
	        <TELL "That would involve quite a contortion." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,LIVING>
		<V-RAPE>
		<RTRUE>)
	     ; (<NOT <IS? ,PRSO ,TAKEABLE>>
	        <TELL "You hit your head against " THEO
		      " as you attempt this feat." CR>
		<RTRUE>)>
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW ,PRSI ,PRSO>
	 <RTRUE>>
		
<ROUTINE PRE-THROW-OVER ()
	 <COND (<PRE-THROW>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE V-THROW-OVER ()
	 <WASTE-OF-TIME>
	 <RTRUE>>

<ROUTINE PRE-THROW ()
	 <COND (<CRUMBS-GONE?>
		<RTRUE>)
	       (<PRSO? BAG>
		<TELL "Better not. The bread crumbs might fall out." CR>
		<RTRUE>)
	       (<OR <PRSO? CRANE OCRANE BAD-CRANE SOGGY>
		    <AND <PRSO? EBAG>
			 <NOT <FIRST? ,PRSO>>>>
		<NOT-LIKELY ,PRSO "would go very far">
		<RTRUE>)
	       (<PRE-PUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<TELL "Thrown" ,PCR CTHEO " lands on the ">
		<COND (<IS? ,HERE ,INDOORS>
		       <TELL D ,FLOOR>)
		      (T
		       <TELL D ,GROUND>)>
		<TELL " nearby." CR>)>
	 <RTRUE>>
	 
<ROUTINE V-TIE ()
	 <TELL ,CANT "possibly tie " THEO>
	 <COND (<T? ,PRSI>
		<TELL " to " THEI>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE V-TIE-UP ()
	 <TELL ,CANT "tie anything with that." CR>
	 <RTRUE>>

<ROUTINE V-TURN ()
	 <COND (<AND <NOT <IS? ,PRSO ,TAKEABLE>>
		     <NOT <IS? ,PRSO ,TRYTAKE>>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<HACK-HACK "Turning">)>
	 <RTRUE>>

<ROUTINE V-TURN-TO ()
	 <COND (<VISIBLE? ,PRSO>
		<PERFORM ,V?WATCH ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,DONT "see " THEO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE DO-WALK (DIR1 "OPTIONAL" (DIR2 <>) (DIR3 <>) "AUX" X)
	 <SETG P-WALK-DIR .DIR1>
	 <SET X <PERFORM ,V?WALK .DIR1>>
	 <COND (<AND <T? .DIR2>
		     <NOT <EQUAL? .X <> ,M-FATAL>>>
		<CRLF>
		<SETG P-WALK-DIR .DIR2>
		<SET X <PERFORM ,V?WALK .DIR2>>
		<COND (<AND <T? .DIR3>
		            <NOT <EQUAL? .X <> ,M-FATAL>>>
		       <CRLF>
		       <SETG P-WALK-DIR .DIR3>
		       <SET X <PERFORM ,V?WALK .DIR3>>)>)>
	 <RETURN .X>>

<GLOBAL FLIP?:FLAG <>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<AND <T? ,FLIP?>
		     <T? ,P-WALK-DIR>
		     <IS? ,HERE ,SHADOWY>>
		<SETG PRSO <COND (<PRSO? P?EAST> ,P?WEST)
		      		 (<PRSO? P?WEST> ,P?EAST)
		      		 (<PRSO? P?SE> ,P?SW)
		      		 (<PRSO? P?SW> ,P?SE)
		      		 (<PRSO? P?NE> ,P?NW)
		      		 (<PRSO? P?NW> ,P?NE)
				 (T ,PRSO)>>)>
	 <COND (<ZERO? ,P-WALK-DIR>
		<COND (<T? ,PRSO>
		       <TELL "[Presumably, you mean WALK TO " THEO 
			     "." ,BRACKET>
		       <PERFORM ,V?WALK-TO ,PRSO>)
		      (T
		       <V-WALK-AROUND>)>
		<RTRUE>)>
	 <SET PT <GETPT ,HERE ,PRSO>>
	 <COND (<T? .PT>
		<SET PTS <PTSIZE .PT>>
		<COND (<EQUAL? .PTS ,UEXIT>
		       <SET RM <GET-REXIT-ROOM .PT>>
		       <FLY-TO? .RM>
		       <GOTO .RM>
		       <RTRUE>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <SET RM <APPLY <GET .PT ,FEXITFCN>>>
		       <COND (<ZERO? .RM>
			      <RFATAL>)
			     (T
			      <GOTO .RM>
			      <RTRUE>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GET-REXIT-ROOM .PT>>
			      <RTRUE>)>
		       <SET STR <GET .PT ,CEXITSTR>>
		       <COND (<T? .STR>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <SET OBJ <GET-DOOR-OBJ .PT>>
		       <SET STR <GET .PT ,DEXITSTR>>
		       <COND (<IS? .OBJ ,OPENED>
			      <GOTO <GET-REXIT-ROOM .PT>>
			      <RTRUE>)
			     (<T? .STR>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <ITS-CLOSED .OBJ>
			      <RFATAL>)>)>)
	       (<AND <EQUAL? ,P-WALK-DIR ,P?OUT>
		     <NOT <IS? ,HERE ,INDOORS>>>
		<TELL ,YOURE-ALREADY "outside." CR>
		<RFATAL>)
	       (<AND <EQUAL? ,P-WALK-DIR ,P?IN>
		     <IS? ,HERE ,INDOORS>>
		<TELL ,YOURE-ALREADY "inside." CR>
		<RFATAL>)
	       (T
		<CANT-GO>
		<RFATAL>)>>

<GLOBAL MDELAY:NUMBER 0>

<ROUTINE FLY-TO? (DEST "AUX" (N 0))
	 <COND (<OR <ZERO? ,TR?>
		    <ZERO? .DEST>
		    <NOT <IS? ,HERE ,DESERT>>		    
		    <NOT <IN? .DEST ,ROOMS>>
		    <NOT <IS? .DEST ,DESERT>>>
		<SETG MDELAY 0>
		<RFALSE>)
	       (<AND <IS? ,RBOOT ,WORN>
		     <IS? ,RBOOT ,CHILLY>
		     <IS? ,GBOOT ,WORN>
	             <IS? ,GBOOT ,CHILLY>>
	        <SETG MDELAY 2>
	        <COND (<NOT <IS? ,FEET ,TOUCHED>>
		       <MAKE ,FEET ,TOUCHED>
		       <QUEUE I-WHOOSH 1>
		       <TELL "You put one boot forward" ,PCR>
		       <ITALICIZE "Whoosh!">
		       <TELL " The " D ,GDESERT
			     " streaks past in a dizzy rush of color" ,PCR>
		       <RTRUE>)
		      (<NOT <IS? ,FEET ,CHILLY>>
		       <MAKE ,FEET ,CHILLY>
		       <ITALICIZE "Whoosh!">
		       <TELL " ">)>
		<TELL <PICK-NEXT ,FDEFAULTS> ,PCR>
		<RTRUE>)>
	 <SETG MDELAY 0>
	 <TELL "You ">
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?RUN ,W?JOG>
		<COND (<IS? ,HERE ,BORING>
		       <SET N 19>)
		      (T
		       <SET N 9>)>
		<PRINTB ,P-PRSA-WORD>
		<TELL " for a few ">)
	       (T
	        <COND (<IS? ,HERE ,BORING>
		       <SET N 29>)
		      (T
		       <SET N 19>)>
	        <TELL <PICK-NEXT ,WALK-TYPES>>
		<COND (<PROB 50>
		       <TELL "along ">)>
		<TELL "for several ">)>
	 <TELL "minutes." CR>
	 <DO-MOVES .N>
	 <CRLF>
	 <RTRUE>>

<GLOBAL WALK-TYPES:TABLE
	<LTABLE 2 "amble " "walk " "trudge ">>

<ROUTINE AIMLESS (DEST "AUX" (N 0))
	 <COND (<FLY-TO? .DEST>
		<RTRUE>)>
	 <TELL "You ">
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?RUN ,W?JOG>
		<PRINTB ,P-PRSA-WORD>
		<PRINTC 32>
		<SET N 19>)
	       (T
		<COND (<PROB 50>
		       <TELL "wander ">)
		      (T
		       <TELL <PICK-NEXT ,WALK-TYPES>>)>
		<SET N 29>)>
	 <COND (<PROB 50>
		<TELL "uncertain">)
	       (T
		<TELL "aimless">)>
	 <TELL "ly across the " D ,GDESERT ,PERIOD>
	 <DO-MOVES .N>
	 <RTRUE>>

<GLOBAL FDEFAULTS:TABLE
	<LTABLE 2
	 "The desert streaks past"
	 "The ground blurs beneath your feet"
	 "You streak across the desert"
	 "You zoom over the landscape">>

<ROUTINE IFENCE-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,IFENCE>
	 <RFALSE>>

<ROUTINE VICTORIA-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,VICTORIA>
	 <RFALSE>>

<ROUTINE THICKET-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,THICKET>
	 <RFALSE>>

<ROUTINE GFENCE-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,GFENCE>
	 <RFALSE>>

<ROUTINE CLIFF-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,CLIFF>
	 <RFALSE>>

<ROUTINE HEDGE-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,HEDGE>
	 <RFALSE>>

<ROUTINE LANDSLIDE-BLOCKS ()
	 <COND (<ZERO? ,LIT?>
		<TELL "A rock wall">
		<BLOCKS-YOUR-PATH>
		<RFALSE>)>
	 <BLOCKS-YOUR-PATH ,LANDSLIDE>
	 <RFALSE>>

<ROUTINE ESHED-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,ESHED>
	 <RFALSE>>

<ROUTINE BUILDING-BLOCKS ()
	 <COND (<T? ,IN-SAND?>
		<EXIT-SPILE>)>
	 <BLOCKS-YOUR-PATH ,SCHOOL>
	 <RFALSE>>

<ROUTINE SWALL-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,SWALL>
	 <RFALSE>>

<ROUTINE RESERVOIR-BLOCKS ()
	 <BLOCKS-YOUR-PATH ,RESERVOIR>
	 <RFALSE>>

<ROUTINE BLOCKS-YOUR-PATH ("OPTIONAL" (OBJ <>))
	 <COND (<T? .OBJ>
		<THIS-IS-IT .OBJ>
		<TELL CTHE .OBJ>)>
	 <TELL " blocks your path." CR>
	 <RTRUE>>	 

<ROUTINE V-WALK-AROUND ()
	 <PCLEAR>
	 <TELL "[Which way do you want to go?]" CR>
	 <RTRUE>>

<ROUTINE V-WALK-TO ()
	 <COND (<PRSO? INTDIR>
		<DO-WALK ,P-DIRECTION>
		<RTRUE>)
	       (<PRSO? RIGHT LEFT>
		<MORE-SPECIFIC>
		<RTRUE>)
	       (T
		<V-FOLLOW>)>
	 <RTRUE>>

<ROUTINE V-WAIT ("OPTIONAL" (N 3) "AUX" (X <>))
	 <COND (<WRONG-WINNER?>
		<RFATAL>)>
	 <TELL "Time passes." CR>
	 <REPEAT ()
		 <COND (<OR <T? .X>
			    <L? .N 1>>
			<RTRUE>)
		       (<CLOCKER>
			<SET X T>
			<SETG CLOCK-WAIT? T>)>
		 <DEC N>>
	 <RTRUE>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<WRONG-WINNER?>
		<RFATAL>)
	       (<PRSO? INTNUM>
		<COND (<ZERO? ,P-NUMBER>
		       <SETG CLOCK-WAIT? T>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<G? ,P-NUMBER 120>
		       <SETG CLOCK-WAIT? T>
		       <TELL "[That's too long to WAIT.]" CR>
		       <RTRUE>)>
		<V-WAIT <- ,P-NUMBER 1>>
		<RTRUE>)
	       (<VISIBLE? ,PRSO>
		<TELL CTHEO>
		<IS-ARE>
		<TELL "already here." CR>
		<RTRUE>)>
	 <TELL "You may be waiting quite a while." CR>
	 <RTRUE>>

<ROUTINE V-WEAR ()
	 <COND (<OR <AND <IN? ,PRSO ,WINNER>
		         <IS? ,PRSO ,WORN>>
		    <PRSO? CLOTHES POCKET>>
		<TELL ,YOURE-ALREADY "wearing " THEO ,PERIOD>
		<RTRUE>)
	       (<NOT <IS? ,PRSO ,CLOTHING>>
		<TELL ,CANT "wear " THEO ,PERIOD>
		<RTRUE>)
	       (<DONT-HAVE? ,PRSO>
		<RTRUE>)
	       (T
		<MAKE ,PRSO ,WORN>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "You put ">)
		      (T
		       <TELL CTHE ,WINNER " obligingly puts ">)>
		<TELL "on " THEO ,PERIOD>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-WIND ()
	 <TELL ,CANT "wind " A ,PRSO ,PERIOD>
	 <RTRUE>>

<ROUTINE PRE-TAKE ("OPTIONAL" (L <>) "AUX" WHO)
	 <COND (<AND <PRSO? BREATH>
		     <ZERO? ,PRSI>>
		<RFALSE>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <SET L <LOC ,PRSO>>
	 <COND (<EQUAL? .L ,WINNER>
		<COND (<CRUMBS-GONE?>
		       <RTRUE>)
		      (<EQUAL? ,WINNER ,PLAYER>
		       <TELL "You're ">)
		      (T
		       <TELL CTHE ,WINNER>
		       <IS-ARE ,WINNER>)>
		<TELL "already ">
		<COND (<IS? ,PRSO ,WORN>
		       <TELL "wear">)
		      (T
		       <TELL "hold">)>
		<TELL "ing " THEO ,PERIOD>
		<RTRUE>)
	       (<AND <T? .L>
		     <IS? .L ,CONTAINER>
		     <IS? .L ,OPENABLE>
		     <NOT <IS? .L ,OPENED>>>
		<COND (<EQUAL? ,WINNER ,PLAYER>
		       <PRINT ,CANT>)
		      (T
		       <TELL CTHE ,WINNER " can't ">)>
		<TELL "reach into " THE .L ". It's closed." CR>
		<RTRUE>)
	       (<T? ,PRSI>
		<COND (<PRSO? PRSI>
		       <COND (<OR <EQUAL? <GET ,P-NAMW 0> <GET ,P-NAMW 1>>
				  <EQUAL? <GET ,P-ADJW 0> <GET ,P-ADJW 1>>>
			      <IMPOSSIBLE>
			      <RTRUE>)>)			    
		      (<PRSI? ME>
		       <COND (<EQUAL? ,WINNER ,PLAYER>
			      <NOBODY-TO-ASK>
			      <RTRUE>)
			     (<NOT <EQUAL? .L ,PLAYER>>
			      <TELL ,DONT "have " THEO ,PERIOD>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <PRSI? CRYPT>
			    <EQUAL? .L ,LID>>
		       <PERFORM ,PRSA ,PRSO ,LID>
		       <RTRUE>)
		      (<AND <PRSO? GNOMON>
			    <PRSI? DIAL-HOLE BDIAL-HOLE>
			    <IS? ,PRSO ,NODESC>>
		       <PERFORM ,V?UNSCREW ,PRSO>
		       <RTRUE>)
		      (<AND <PRSI? DIAL-HOLE>
			    <PRSO? GNOMON>
			    <IS? ,PRSO ,NODESC>>
		       <PERFORM ,V?UNSCREW ,PRSO>
		       <RTRUE>)
		      (<NOT <EQUAL? .L ,PRSI>>
		       <TELL CTHEO>
		       <ISNT-ARENT>
		       <COND (<IS? ,PRSI ,SURFACE>
			      <TELL "on ">)
			      (T
			       <TELL "in ">)>
		       <TELL THEI ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	     ; (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL ,YOURE-ALREADY "in it." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-TAKE ("AUX" L)
	 <SET L <ITAKE>>
	 <COND (<T? .L>
		<COND (<T? ,P-MULT?>
		       <TELL "Taken." CR>)
		      (<OR <IS? .L ,CONTAINER>
			   <IS? .L ,SURFACE>
			   <IS? .L ,PERSON>
			   <IS? .L ,LIVING>>
		       <TELL "You take " THEO>
		       <COND (<IS? .L ,CONTAINER>
			      <TELL " out of ">)
			     (<IS? .L ,SURFACE>
			      <TELL " off ">)   
			     (T
			      <TELL " from ">)>
			<TELL THE .L ,PERIOD>)
		       (<PROB 50>
			<TELL "Taken." CR>)
		       (T
			<TELL "You ">
		       	<COND (<EQUAL? ,P-PRSA-WORD
				       ,W?GRAB ,W?SEIZE ,W?SNATCH>
			       <PRINTB ,P-PRSA-WORD>
			       <PRINTC 32>)
			      (<PROB 50>
			       <TELL "pick up ">)
			      (T
			       <TELL "take ">)>
			 <TELL THEO ,PERIOD>)>
		<SET L <GETP ,PRSO ,P?VALUE>>
		<COND (<T? .L>
		       <PUTP ,PRSO ,P?VALUE 0>
		       <UPDATE-SCORE .L>)>)>
	 <RTRUE>>

<CONSTANT FUMBLE-NUMBER 7>
<CONSTANT LOAD-ALLOWED 25>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" L)
	 <COND (<OR <ZERO? ,PRSO>
		    <ZERO? <LOC ,PRSO>>>
		<CANT-SEE-ANY>
		<RFALSE>)>
	 <SET L <LOC ,PRSO>>
	 <THIS-IS-IT ,PRSO>
	 <COND (<NOT <IS? ,PRSO ,TAKEABLE>>
		<COND (<T? .VB>
		       <IMPOSSIBLE>)>
		<RFALSE>)
	       (<AND <IS? .L ,CONTAINER>
		     <IS? .L ,OPENABLE>
		     <NOT <IS? .L ,OPENED>>>
		<COND (<T? .VB>
		       <YOUD-HAVE-TO "open" .L>)>
		<RFALSE>)
	       (<AND <NOT <IN? .L ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
	        <COND (<T? .VB>
		       <COND (<FIRST? ,WINNER>
			      <TELL "Your load is">)
			     (T
			      <TELL CTHEO " is">)>
		       <TELL " too heavy." CR>)>
		<RFALSE>)
	       (<G? <CCOUNT ,WINNER> ,FUMBLE-NUMBER>
		<COND (<T? .VB>
		       <TELL "You're holding too much already." CR>)>
		<RFALSE>)
	       (T
	      	<MAKE ,PRSO ,TOUCHED>
		<UNMAKE ,PRSO ,NODESC>
		<UNMAKE ,PRSO ,NOALL>
		<MOVE ,PRSO ,WINNER>		
		<RETURN .L>)>>  "So that .L an be analyzed."

"Count # objects being carried by THING."

<ROUTINE CCOUNT (THING "AUX" OBJ (CNT 0))
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RETURN>)
		       (<AND <NOT <IS? .OBJ ,WORN>>
			     <NOT <EQUAL? .OBJ ,POCKET>>>
			<INC CNT>)>
		 <SET OBJ <NEXT? .OBJ>>>
	 <RETURN .CNT>>

"Return total weight of objects in THING."

<ROUTINE WEIGHT (THING "AUX" OBJ (WT 0))
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RETURN>)
		       (<NOT <EQUAL? .OBJ ,POCKET>>
			<COND (<AND <EQUAL? .THING ,WINNER>
				    <IS? .OBJ ,WORN>>
			       <INC WT>)
			      (T
			       <SET WT <+ .WT <WEIGHT .OBJ>>>)>)>
		 <SET OBJ <NEXT? .OBJ>>>
	 <SET OBJ <GETP .THING ,P?MASS>>
	 <COND (<T? .OBJ>
		<SET WT <+ .WT .OBJ>>)>
	 <RETURN .WT>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" (V? <>) ACT ; STR)
         <COND (<OR <T? .LOOK?>
		    <EQUAL? ,VERBOSITY 2>>
		<SET V? T>)>
	 <COND (<ZERO? ,LIT?>
		<TELL "It's completely dark." CR>
		<RFALSE>)
	       (<NOT <IS? ,HERE ,TOUCHED>>
		<MAKE ,HERE ,TOUCHED>
	        <INC MAPCNT>
		<SET V? T>)>
         <COND (<IN? ,HERE ,ROOMS>
	        <HLIGHT ,H-BOLD>
	        <SAY-HERE>
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<HLIGHT ,H-NORMAL>)>
	 <COND (<OR <T? .LOOK?>
		    <T? ,VERBOSITY>>
	        <SET ACT <GETP ,HERE ,P?ACTION>>
	      ; <SET STR <GETP ,HERE ,P?LDESC>>
		<COND (<AND <T? .V?>
			    <T? .ACT>>
		       <COND (<T? ,VERBOSITY>
			      <CRLF>)>
		       <APPLY .ACT ,M-LOOK>)
		    ; (<AND <T? .V?>
			    <T? .STR>>
		       <COND (<T? ,VERBOSITY>
			      <CRLF>)>
		       <TELL .STR CR>)>)>
	 <RETURN ,LIT?>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 2>
<CONSTANT NEXIT 3>
<CONSTANT FEXIT 4>
<CONSTANT CEXIT 5>
<CONSTANT DEXIT 6>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 4>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 2>

<GLOBAL DROOM:OBJECT <>>

<ROUTINE GOTO (WHERE "OPTIONAL" (LOOK? T) "AUX" X)
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>>
	 <COND (<IS? ,HERE ,BORING>
		<SETG DROOM <>>)
	       (T
		<SETG DROOM ,HERE>)>
	 <SETG HERE .WHERE>
	 <MOVE ,PLAYER .WHERE>
	 <SETG LIT? <IS-LIT?>>
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERING>>
	 <COND (<NOT <EQUAL? ,HERE .WHERE>>
		<RTRUE>)
	       (<T? .LOOK?>
		<COND (<DESCRIBE-ROOM>
		       <COND (<T? ,VERBOSITY>
		       	      <DESCRIBE-OBJECTS>)>
		       <MENTION-PRAM>)>)>
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTERED>>
	 <RESET-THEM>
	 <RTRUE>>

<ROUTINE RESET-THEM ()
	 <COND (<NOT <VISIBLE? ,P-IT-OBJECT>>
		<SETG P-IT-OBJECT ,NOT-HERE-OBJECT>)>
	 <COND (<NOT <VISIBLE? ,P-THEM-OBJECT>>
		<SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>)>
	 <COND (<NOT <VISIBLE? ,P-HIM-OBJECT>>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>)>
	 <COND (<NOT <VISIBLE? ,P-HER-OBJECT>>
		<SETG P-HER-OBJECT ,NOT-HERE-OBJECT>)>
	 <RTRUE>>

; <ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T) 
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RFALSE>)>
		 <SET T <GETPT ,HERE .P>>
		 <COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
			     <EQUAL? <GET-DOOR-OBJ .T> .DOBJ>>
			<RETURN .P>)>>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR>
	 <SPACE>
	 <TELL THEO " would" <PICK-NEXT ,HO-HUM> ,PERIOD>
	 <RTRUE>>

<GLOBAL HO-HUM:TABLE
	<LTABLE 2 
	 "n't do anything useful"
	 " accomplish nothing"
	 " have no desirable effect"
	 "n't be very productive"
	 " serve no purpose"
	 " be pointless">>

<ROUTINE IMPOSSIBLE ()
	 <TELL <PICK-NEXT ,YUKS> ,PERIOD>
	 <RTRUE>> 
	 
<GLOBAL YUKS:TABLE
	<LTABLE 2
	 "That's impossible"
	 "What a ridiculous concept"
	 "You can't be serious">>

<ROUTINE TOO-DARK ()
	 <TELL "It's too dark ">
	 <COND (<HERE? UNDER-WATER>
		<TELL "and murky ">)>
	 <TELL "to see." CR>
	 <RTRUE>>

<ROUTINE CANT-GO ()
	 <COND (<IS? ,HERE ,INDOORS>
		<TELL "There's no exit ">)
	       (T
		<TELL ,CANT "go ">)>
	 <TELL "that way." CR>
	 <RTRUE>>

<ROUTINE ITS-ALREADY (STR)
	 <TELL "It's already " .STR ,PERIOD>
	 <RTRUE>>

<ROUTINE REFERRING ()
	 <TELL "[To what are you referring?]" CR>
	 <RTRUE>>

<ROUTINE MORE-SPECIFIC ()
	 <TELL "[You must be more specific.]" CR>
	 <RTRUE>>

<ROUTINE WASTE-OF-TIME ()
	 <TELL <PICK-NEXT ,POINTLESS> ,PERIOD>
	 <RTRUE>>

<GLOBAL POINTLESS:TABLE
	<LTABLE 2
	 "There's no point in doing that"
	 "That would be pointless"
	 "That's a pointless thing to do">>

<ROUTINE LOOKS-PUZZLED (WHO)
	 <TELL CTHE .WHO " ">
	 <COND (<PROB 50>
		<TELL "looks ">)
	       (T
		<TELL "appears ">)>
	 <TELL <PICK-NEXT ,PUZZLES> ". \"">
	 <RTRUE>>

<GLOBAL PUZZLES:TABLE
	<LTABLE 2 "puzzled" "bewildered" "confused" "perplexed">>

<ROUTINE V-INHALE ()
	 <COND (<NOT <PRSO? BREATH ROOMS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <HERE? IN-ORBIT ON-SAT>
		     <ZERO? ,SUITED?>>
		<CLUTCH-THROAT>
		<RTRUE>)
	       (<T? ,BREATH-HELD?>
		<TELL ,YOURE-ALREADY "holding " D ,BREATH ,PERIOD>
		<RTRUE>)
	       (T
		<SETG BREATH-HELD? 4>
		<QUEUE I-HOLD-BREATH -1>
		<TELL "You take a deep breath." CR>)>
	 <RTRUE>>

<ROUTINE CLUTCH-THROAT ()
	 <TELL 
"You gasp and clutch your throat in the surrounding vacuum." CR>
	 <RTRUE>>

<ROUTINE V-EXHALE ()
	 <COND (<NOT <PRSO? BREATH ROOMS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<ZERO? ,BREATH-HELD?>
		<TELL "You'd have to inhale first." CR>
		<RTRUE>)
	       (<AND <HERE? IN-ORBIT ON-SAT>
		     <ZERO? ,SUITED?>>
		<DEQUEUE I-HOLD-BREATH>
		<SETG BREATH-HELD? 0>
		<CLUTCH-THROAT>
		<RTRUE>)
	       (<HERE? UNDER-WATER>
		<NOT-RECOMMENDED>
		<RTRUE>)
	       (T
		<SETG BREATH-HELD? 0>
		<DEQUEUE I-HOLD-BREATH>
		<TELL "You begin to breathe normally." CR>)>
	 <RTRUE>>

<ROUTINE NOT-RECOMMENDED ()
	 <TELL "Not recommended here." CR>
	 <RTRUE>>

<ROUTINE V-SURFACE ()
	 <COND (<HERE? UNDER-WATER>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (T
		<TELL "You're not underwater." CR>)>
	 <RTRUE>>

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP-AROUND ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-WRAP-AROUND ()
	 <TELL "You couldn't possibly ">
	 <PRINTB ,P-PRSA-WORD>
	 <SPACE>
	 <TELL THEO " around " THEI ,PERIOD>
	 <RTRUE>>

<ROUTINE V-DRESS ()
	 <COND (<PRSO? ROOMS>
		<TELL ,YOURE-ALREADY "dressed." CR>
		<RTRUE>)
	       (<IS? ,PRSO ,PERSON>
	       	<TELL CTHEO " is already dressed." CR>
		<RTRUE>)
	       (T
		<TELL ,CANT "dress " A ,PRSO ,PERIOD>)>
	 <RTRUE>>

<ROUTINE V-UNDRESS ()
	 <COND (<OR <PRSO? ROOMS>
		    <IS? ,PRSO ,PERSON>>
		<INAPPROPRIATE>
		<RTRUE>)
	       (T
		<PRINT ,CANT>
		<PRINTB ,P-PRSA-WORD>
		<SPACE>
		<TELL A ,PRSO ,PERIOD>)>
	 <RTRUE>>
		 
<ROUTINE V-WISH ()
	 <COND (<OR <T? ,TR?>
		    <NOT <IS? ,HERE ,WINDY>>>
		<VOICE-MUTTERS "Fool" <>>
		<RTRUE>)>
	 <TELL "[Sigh.]" CR>
	 <RTRUE>>

<ROUTINE V-HEEL ()
	 <IMPOSSIBLE>
	 <RTRUE>>

<ROUTINE V-PISS ()
	 <CRUDITY>
	 <RFATAL>>

<ROUTINE V-SUCK ()
	 <CRUDITY>
	 <RFATAL>>

<ROUTINE CRUDITY ()
	 <COND (<OR <T? ,TR?>
		    <NOT <IS? ,HERE ,WINDY>>>
		<VOICE-MUTTERS "Charming" <>>
		<RTRUE>)>
	 <TELL "[Yes, this story does recognize crudity.]" CR>
	 <RTRUE>>

<ROUTINE V-BANDAGE ()
	 <COND (<IN? ,BANDAGE ,PLAYER>
		<WASTE-OF-TIME>
		<RTRUE>)>
	 <HOW?>
	 <RTRUE>>


	 