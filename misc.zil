"MISC for TRINITY: (C)1986 Infocom, Inc. All Rights Reserved."

<DIRECTIONS NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

"*** ZCODE STARTS HERE ***"

<OBJECT DUMMY-OBJECT>

<GLOBAL WINNER:OBJECT 0>

<GLOBAL PTHE:STRING ". The "> 
<GLOBAL PA:STRING ". A ">
<GLOBAL CHANGES:STRING " changes your mind.|
">
<GLOBAL DONT:STRING "You don't ">
<GLOBAL AT-MOMENT:STRING " at the moment.">
<GLOBAL ARROW-ON:STRING "The arrow on the ring is already pointing ">
<GLOBAL RAZOR:STRING " divides the sky like a razor">
<GLOBAL ALLPRAMS:STRING "All prams lead to the Kensington Gardens.">

<GLOBAL TON:STRING " to the north">
<GLOBAL TOS:STRING " to the south">
<GLOBAL TOE:STRING " to the east">
<GLOBAL TOW:STRING " to the west">

<GLOBAL CTHELEM:STRING "The lemming ">
<GLOBAL CTHEMEEP:STRING "The roadrunner ">
<GLOBAL YOU-SEE:STRING "You see ">
<GLOBAL CANT:STRING "You can't ">
<GLOBAL YOURE-ALREADY:STRING "You're already ">
<GLOBAL ONE-SHADE:STRING "One of the shades ">
<GLOBAL INTO-DESERT:STRING "into the desert">
<GLOBAL Z-MINUS:STRING "|
\"Zero minus ">
<GLOBAL PERIOD:STRING ".|
">
<GLOBAL PCR:STRING ".|
|
">
<GLOBAL BRACKET:STRING "]|
|
">
<GLOBAL OUTASITE:STRING " out of sight.|
">
<GLOBAL ALLATONCE:STRING "All at once ">
<GLOBAL INRANCH:STRING ", into the ranch.|
">
<GLOBAL IF-YOU-DID " if you did that.|
">
<GLOBAL AGROUND:STRING " across the ground">
<GLOBAL AS-IF:STRING ". It looks as if ">

<CONSTANT S-TEXT 0>
<CONSTANT S-WINDOW 1>

<CONSTANT H-NORMAL 0>
<CONSTANT H-INVERSE 1>
<CONSTANT H-BOLD 2>
<CONSTANT H-ITALIC 4>

<CONSTANT D-SCREEN-ON 1>
<CONSTANT D-SCREEN-OFF -1>
<CONSTANT D-PRINTER-ON 2>
<CONSTANT D-PRINTER-OFF -2>
<CONSTANT D-TABLE-ON 3>
<CONSTANT D-TABLE-OFF -3>
<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<GLOBAL MIDSCREEN:NUMBER 0>

<ROUTINE GO () 
       	 <SETG MIDSCREEN </ <GETB 0 33> 2>>
	 <INC MIDSCREEN>
	 <COND (<L? ,MIDSCREEN 32>
		<CRLF>
		<TOO-NARROW>
		<QUIT>)>
	 
	 <PUTB ,INSAVE-A 0 0>
	 <PUTB ,INSAVE-B 0 0>
	 <PUTB ,INSAVE-C 0 0>
	 	 
	 <SETG RATS ,RODENTS>
	 <SETG WINNER ,PLAYER>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <CRLF>
	 
       ; <TELL "for ">
       ; <HLIGHT ,H-ITALIC>
       ; <TELL "Challenger">
       ; <HLIGHT ,H-NORMAL>
       ; <CARRIAGE-RETURNS 7>
	 
	 <COPYRIGHT>
	 <CRLF>
	 	 
       ; <TELL CR "[">
       ; <RELEASE>
       ; <TELL "]" CR>
	 
	 <GET-KEY>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <BOOT-SCREEN>
	 <DO-MAIN-LOOP>
	 <AGAIN>>

<ROUTINE GET-KEY ("AUX" X)
         <TELL CR "[Press any key to begin.]" CR>
	 <SET X <INPUT 1>>
	 <RTRUE>>

<ROUTINE DO-MAIN-LOOP ("AUX" X)
	 <REPEAT ()
		 <SET X <MAIN-LOOP>>>>

<GLOBAL P-MULT?:FLAG <>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL (V <>)
		          PTBL OBJ1 TMP X)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<NOT <HERE? QCONTEXT-ROOM>>
	    <SETG QCONTEXT <>>)>
     <SETG P-WON <PARSER>>
     <COND (<T? ,P-WON>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND <T? ,P-IT-OBJECT>
			<ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<ZERO? .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<ZERO? .OCNT>
			.OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT>
			       <SET OBJ <>>)
			      (T
			       <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T
			1)>>
	    <COND (<AND <ZERO? .OBJ>
			<EQUAL? .ICNT 1>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<VERB? WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<ZERO? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<ZERO? ,LIT?>
			  <PCLEAR>
			  <TOO-DARK>)
			 (T
			  <PCLEAR>
			  <TELL "[There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
			         <TELL "talk to">)
				(<OR <T? ,P-MERGED>
				     <T? ,P-OFLAG>>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <SET V <WORD-PRINT <GETB .TMP 2>
						    <GETB .TMP 3>>>)>
			  <TELL ".]" CR>
			  <SET V <>>)>)
		; (<AND <T? .PTBL>
			<G? .NUM 1>
			<VERB? COMPARE>>
		   <SET V <PERFORM ,PRSA ,OBJECT-PAIR>>)
		  (T
		   <SET X 0>
		   <SETG P-MULT? <>>
		   <COND (<G? .NUM 1>
			  <SETG P-MULT? T>)>
		   <SET TMP <>>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			   <COND (<G? .X 0>
				  <TELL "[The ">
				  <COND (<NOT <EQUAL? .X .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here.]" CR>)
				 (<ZERO? .TMP>
				  <REFERRING>)>
			   <RETURN>)
			  (T
			   <COND (<T? .PTBL>
				  <SET OBJ1 <GET ,P-PRSO .CNT>>)
				 (T
				  <SET OBJ1 <GET ,P-PRSI .CNT>>)>
	<COND (<OR <G? .NUM 1>
		   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL ,W?EVERYTHING>>
	       <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		      <INC X>
		      <AGAIN>)
		     (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <DONT-ALL? .OBJ1 .OBJ>>
		      <AGAIN>)
		     (<NOT <ACCESSIBLE? .OBJ1>>
		      <AGAIN>)
		     (<EQUAL? .OBJ1 ,PLAYER>
		      <AGAIN>)
		     (T
		      <COND (<EQUAL? .OBJ1 ,IT>
			     <COND (<NOT <IS? ,P-IT-OBJECT ,NOARTICLE>>
				    <TELL "The ">)>
			     <TELL D ,P-IT-OBJECT>)
			    (T
			     <COND (<NOT <IS? .OBJ1 ,NOARTICLE>>
				    <TELL "The ">)>
			     <TELL D .OBJ1>)>
		      <TELL ": ">)>)>
			   <SET TMP T>
			   <SETG PRSO <COND (<T? .PTBL> .OBJ1)
					    (T .OBJ)>>
			   <SETG PRSI <COND (<T? .PTBL> .OBJ)
					    (T .OBJ1)>>
		   <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
		   <COND (<EQUAL? .V ,M-FATAL>
			  <RETURN>)>)>>)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (<AND <T? ,P-WON>
		 <NOT <EQUAL? .V ,M-FATAL>>
		 <NOT <INTBL? ,PRSA ,GAME-VERBS ,NGVERBS>>>
	    <SET V <CLOCKER>>)>
     <SETG PRSA <>>
     <SETG PRSO <>>
     <SETG PRSI <>>
     <RFALSE>>

<CONSTANT NGVERBS 22> "Number of GAME-VERBS."

<GLOBAL GAME-VERBS:TABLE
	<PTABLE
	 V?INVENTORY ; V?WAIT ; V?WAIT-FOR V?TELL V?TIME V?SCORE
         V?SAVE V?RESTORE V?SCRIPT V?UNSCRIPT V?DIAGNOSE V?HELP
	 V?VERBOSE V?BRIEF V?SUPER-BRIEF V?VERSION V?QUIT V?$REFRESH
	 V?$VERIFY V?$ID V?NOTIFY V?$CREDITS V?$COMMAND V?$PRAMS
       ; "V?$UNRECORD V?$COMMAND V?$RANDOM"
       ; "V?$DEBUG V?$CHEAT">>

<ROUTINE DONT-ALL? (O I "AUX" L)
	 <SET L <LOC .O>>
	 <COND (<OR <ZERO? .L>
		    <EQUAL? .O .I>>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<EQUAL? .L ,WINNER ,MEEP ,WIGHT>
		       <RTRUE>)
		      (<IS? .O ,NOALL>
		       <RTRUE>)
		      (<AND <NOT <IS? .O ,TAKEABLE>>
			    <NOT <IS? .O ,TRYTAKE>>>
		       <RTRUE>)
		      (<AND <IS? .L ,CONTAINER>
			    <NOT <IS? .L ,OPENED>>>
		       <RTRUE>)
		      (<T? .I>
		       <COND (<NOT <EQUAL? .L .I>>
			      <RTRUE>)
			     (<SEE-INSIDE? .I>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (<OR <EQUAL? .L ,HERE>
		       	   <SEE-INSIDE? .L>>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<VERB? DROP PUT PUT-ON THROW THROW-OVER>
		<COND (<EQUAL? .O ,POCKET>
		       <RTRUE>)
		      (<EQUAL? .L ,POCKET>
		       <RTRUE>)
		      (<IS? .O ,WORN>
		       <RTRUE>)
		      (<EQUAL? .L ,WINNER>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (T
		<RFALSE>)>>

<ROUTINE ACCESSIBLE? (OBJ)
         <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<EQUAL? <META-LOC .OBJ> ,WINNER ,HERE ,GLOBAL-OBJECTS>
	        <RTRUE>)
	       (<VISIBLE? .OBJ>
	        <RTRUE>)
	       (T 
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L)
         <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT> 
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<EQUAL? .L ,HERE ,PLAYER ,WINNER>
	        <RTRUE>)
               (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
               (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <RTRUE>)
               (T
	        <RFALSE>)>>

<ROUTINE SEE-INSIDE? (THING)
	 <COND (<ZERO? .THING>
		<RFALSE>)
	       (<T? ,P-MOBY-FLAG>
		<RTRUE>)	       
	       (<IS? .THING ,SURFACE>
		<RTRUE>)
	       (<AND <OR <IS? .THING ,PERSON>
			 <IS? .THING ,LIVING>>
		     <NOT <EQUAL? .THING ,PLAYER>>>
		<RTRUE>)
	       (<AND <IS? .THING ,CONTAINER>
		     <OR <IS? .THING ,OPENED>
		         <IS? .THING ,TRANSPARENT>>>
		<RTRUE>)
	       (T
	    	<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)
		       (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE INIT-STATUS-LINE ()
	 <SETG OLD-HERE <>>
	 <SETG OLD-LEN 0>
	 <SETG DO-WINDOW <>>
	 <SPLIT 1>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 1 1>
	 <HLIGHT ,H-INVERSE>
	 <PRINT-SPACES <GETB 0 33>>
	 <BUFOUT T>
	 <HLIGHT ,H-NORMAL>
	 <SCREEN ,S-TEXT>
	 <RTRUE>>

<GLOBAL SL-TABLE:TABLE <ITABLE NONE 80>>
<GLOBAL OLD-HERE:OBJECT <>>
<GLOBAL OLD-LEN:NUMBER 0>

<ROUTINE DISPLAY-PLACE ()
	 <COND (<NOT <HERE? OLD-HERE>>
		<SETG OLD-HERE ,HERE>
		<SCREEN ,S-WINDOW>
		<BUFOUT <>>
		<HLIGHT ,H-NORMAL>
		<HLIGHT ,H-INVERSE>
		
	      ; <DIROUT ,D-SCREEN-OFF>	        ; "Screen off."
		<DIROUT ,D-TABLE-ON ,SL-TABLE>  ; "Table on."
		<SAY-HERE>
	        <DIROUT ,D-TABLE-OFF> 	        ; "Table off."
	      ; <DIROUT ,D-SCREEN-ON>		; "Screen on."
		
		<CURSET 1 <- ,MIDSCREEN </ ,OLD-LEN 2>>> ; "Erase old desc."
		<PRINT-SPACES ,OLD-LEN>
		
		<SETG OLD-LEN <GET ,SL-TABLE 0>> ; "Print new HERE desc."
		<CURSET 1 <- ,MIDSCREEN </ ,OLD-LEN 2>>>
		<SAY-HERE>
		
		<HLIGHT ,H-NORMAL>
		<BUFOUT T> ; "Back to main screen."
		<SCREEN ,S-TEXT>)>
	 <RTRUE>>
		
<ROUTINE PRINT-SPACES (N) 
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 0>
			<RTRUE>)
		       (T
			<SPACE>)>>
	 <RTRUE>>

<ROUTINE SAY-HERE ()
	 <COND (<ZERO? ,LIT?>
		<TELL "Darkness">)
	       (T
		<TELL D ,HERE>
	        <COND (<HERE? DEATH THE-END ON-SAT>
		       <RTRUE>)
		      (<HERE? HALFWAY>
		       <TELL ,STAIR-DIR>)>
		<COND (<T? ,SUITED?>
		       <TELL ", in a soap bubble">)
		      (<T? ,IN-PRAM?>
		       <TELL ", in the " D ,PRAM>)
		      (<T? ,IN-DISH?>
		       <TELL ", in the dish">)
		      (<T? ,IN-DORY?>
		       <TELL ", in the dory">)
		      (<T? ,IN-SAND?>
		       <TELL ", in a " D ,SPILE>)>)>
	 <RTRUE>>

<ROUTINE TELL-TIME ("AUX" H)
         <TELL " says it's ">
	 <SET H <COND (<G? ,HOURS 12>
		       <- ,HOURS 12>)
	       	      (<ZERO? ,HOURS>
		       12)
		      (T
		       ,HOURS)>>
	 <TELL N .H ":">
	 <COND (<L? ,MINUTES 10>
		<TELL "0">)>
         <TELL N ,MINUTES ":">
         <COND (<L? ,SECONDS 10>
		<TELL "0">)>
	 <TELL N ,SECONDS>
	 <COND (<G? ,HOURS 11>
		<TELL " pm">)
	       (T
		<TELL " am">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE CTHE-PRINT ("OPTIONAL" (O <>))
	 <COND (<ZERO? .O>
		<SET O ,PRSO>)>
	 <TELL "The " D .O>
	 <RTRUE>>

<ROUTINE THE-PRINT ("OPTIONAL" (O <>))
	 <COND (<ZERO? .O>
		<SET O ,PRSO>)>
	 <COND (<NOT <IS? .O ,NOARTICLE>>
		<TELL "the ">)>
	 <TELL D .O>
	 <RTRUE>>

<ROUTINE CTHEI-PRINT ()
	 <TELL "The " D ,PRSI>
	 <RTRUE>>

<ROUTINE THEI-PRINT ()
	 <COND (<NOT <IS? ,PRSI ,NOARTICLE>>
		<TELL "the ">)>
	 <TELL D ,PRSI>
	 <RTRUE>>

<ROUTINE PRINTA (O)
	 <COND (<NOT <IS? .O ,NOARTICLE>>
		<COND (<IS? .O ,PLURAL>
		       <COND (<IS? .O ,PERSON>
			      <TELL "the ">)>)
		      (<IS? .O ,VOWEL>
		       <PRINTI "an ">)
		      (T
		       <PRINTI "a ">)>)>
	 <TELL D .O>
	 <RTRUE>>

<OBJECT GLOBAL-OBJECTS
	(FLAGS LOCATION LIGHTED INDOORS PLACE FOODBIT
	       NODESC NOARTICLE VOWEL PLURAL NOALL FERRIC SEEN
	       TOUCHED SURFACE CONTAINER OPENABLE DOORLIKE DESERT 
	       OPENED TRANSPARENT LOCKED TAKEABLE TRYTAKE SHADOWY
	       BUYABLE CLOTHING WORN LIVING PERSON FEMALE WINDY
	       TOOL VEHBIT READABLE GREETED FLIPPED TOLD
	       SHARPENED MANUALLY WATERY NOGRASS KEYBIT)>

<GLOBAL MOVES:NUMBER 0>
<GLOBAL SCORE:NUMBER 0>

<OBJECT LOCAL-GLOBALS
	(LOC GLOBAL-OBJECTS)
	(SYNONYM ZZZP)
      ; (DESCFCN 0)
      ; (GLOBAL GLOBAL-OBJECTS)
      ; (FDESC "F")
      ; (LDESC "L")
      ; (CONTFCN 0)
      ; (SIZE 0)
      ; (CAPACITY 0)
      ; (VALUE 0)>

<OBJECT ROOMS
	(FLAGS NODESC NOARTICLE)
	(DESC "that")
	(IN TO ROOMS)>

<OBJECT INTNUM
	(LOC GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM INTNUM)>

<OBJECT IT
	(LOC GLOBAL-OBJECTS)
	(DESC "it")
	(FLAGS VOWEL NOARTICLE NODESC TOUCHED)
	(SYNONYM IT THAT ITSELF)>

<ROUTINE BE-SPECIFIC ()
	 <SETG INLEN 0>
	 <TELL "[Be specific: what do you want to ">
	 <RTRUE>>

<ROUTINE TO-DO-THING-USE (STR1 STR2)
	 <TELL "[To " .STR1 " something, use the command: " 
	       .STR2 " THING.]" CR>
	 <RTRUE>>

<ROUTINE CANT-USE (PTR "AUX" BUF) 
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<SETG INLEN 0>
	<TELL "[This story can't understand the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" when you use it that way.]" CR>
	<RTRUE>>

<ROUTINE DONT-UNDERSTAND ()
	<SETG INLEN 0>
	<TELL "[Please try to express that another way.]" CR>
	<RTRUE>>

<ROUTINE NOT-IN-SENTENCE (STR)
	 <SETG INLEN 0>
	 <TELL "[There aren't " .STR " in that sentence.]" CR>
	 <RTRUE>>

<OBJECT WALLS
	(LOC GLOBAL-OBJECTS)
	(DESC "wall")
	(FLAGS NODESC TOUCHED SURFACE)
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>
	 
<ROUTINE WALLS-F ()
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,WALLS>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT THROW THROW-OVER>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>)
	       (<OR <GETTING-INTO?>
		    <VERB? LOOK-BEHIND LOOK-UNDER>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <VERB? TOUCH KNOCK KISS>
		     <HERE? IHOUSE>>
		<FEEL-IHOUSE>
		<CRLF>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		    <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<TELL CTHEO>
		<TELL " isn't affected." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL "Talking to walls">
		<WONT-HELP>
		<RFATAL>)>
	 <YOU-DONT-NEED ,WALLS>
	 <RFATAL>>
		
<OBJECT CEILING
	(LOC GLOBAL-OBJECTS)
	(FLAGS NODESC TOUCHED)
	(DESC "ceiling")
	(SYNONYM CEILING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,CEILING>
		<RFATAL>)
	       (<VERB? LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (<HERE? ICE-CAVE>
		<COND (<VERB? EXAMINE SEARCH>
		       <PERFORM ,V?EXAMINE ,ICICLES>
		       <RTRUE>)
		      (<AND <VERB? THROW>
			    <PRSI? CEILING>>
		       <PERFORM ,V?THROW ,PRSO ,ICICLES>
		       <RTRUE>)
		      (<AND <VERB? HIT>
			    <PRSO? ICICLES>
			    <T? ,PRSI>>
		       <PERFORM ,V?HIT ,ICICLES ,PRSI>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<OBJECT HANDS
	(LOC GLOBAL-OBJECTS)
	(DESC "your hand")
	(FLAGS TOOL MANUALLY NODESC TOUCHED NOARTICLE CHILLY)
	(SYNONYM HAND HANDS PALM PALMS FINGER FINGERS THUMB THUMBS)
	(ADJECTIVE MY BARE)
	(MASS 5)
	(SIZE 5)
	(VALUE 0)
	(ACTION HANDS-F)>
       
"CHILLY = hands not scorched."

<ROUTINE HANDS-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? TIE>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON>
		<TELL "Your fingers are ">
		<COND (<IN? ,HONEY ,PLAYER>
		       <TELL "coated with honey." CR>
		       <RTRUE>)
		      (<QUEUED? I-BEE>
		       <TELL "swollen from the bee sting." CR>
		       <RTRUE>)>
		<TELL "still there." CR>		      
		<RTRUE>)
	       (<VERB? COUNT>
		<TELL "You have ">
		<COND (<NOUN-USED? ,W?FINGERS ,W?FINGER>
		       <TELL "ten">)
		      (T
		       <TELL "two">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <T? ,PRSI>>
		<PERFORM ,V?TOUCH ,PRSI>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FEET
	(LOC GLOBAL-OBJECTS)
	(DESC "your foot")
	(FLAGS CLOTHING WORN NODESC NOARTICLE SURFACE)
	(SYNONYM FOOT FEET TOE TOES SNEAKER SNEAKERS)
	(ADJECTIVE MY)
	(MASS 5)
	(SIZE 5)
	(VALUE 0)
	(ACTION FEET-F)>

"TOUCHED = flight described once, CHILLY = described twice."

<ROUTINE FEET-F ()
	 <COND (<THIS-PRSI?>
		<COND (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		       <COND (<AND <VERB? PUT-ON>
				   <PRSO? RBOOT GBOOT>>
			      <PERFORM ,V?WEAR ,PRSO>
			      <RTRUE>)>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? PUT-ON>
		<PERFORM ,V?STAND-ON ,PRSI>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ANKLE
	(LOC GLOBAL-OBJECTS)
	(DESC "your ankle")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM ANKLE LEG LEGS WOUND BITE SNAKEBITE VENOM)
	(ADJECTIVE MY)
	(ACTION ANKLE-F)>

"SURFACE = bitten."

<ROUTINE ANKLE-F ()
	 <COND (<AND <NOT <IS? ,ANKLE ,SURFACE>>
		     <OR <NOUN-USED? ,W?WOUND ,W?BITE ,W?SNAKEBITE>
			 <NOUN-USED? ,W?VENOM>>>
		<CANT-SEE-ANY>
		<RFATAL>)>
	 <COND (<AND <VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH WATCH>
		     <IS? ,PRSO ,SURFACE>>
		<TELL "You wince at the sight." CR>
		<RTRUE>)
	       (<VERB? SUCK KISS BLOW-INTO TASTE>
		<TELL ,CANT "bend over that far." CR>
		<RTRUE>)
	       (<AND <IS? ,ANKLE ,SURFACE>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<TELL "Ouch! It hurts." CR>
		<RTRUE>)
	       (<VERB? PUT-ON WRAP-AROUND>
		<COND (<THIS-PRSI?>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)
		      (<AND <THIS-PRSO?>
		     	    <NOT <VERB? WRAP-AROUND>>
			    <NOUN-USED? ,W?LEGS ,W?LEG>>
		       <PERFORM ,V?STAND-ON ,PRSI>)>
		<RFALSE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>> 
			
<OBJECT MOUTH
	(LOC GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH)
	(ADJECTIVE MY)
	(FLAGS NODESC NOARTICLE TOUCHED)
	(ACTION MOUTH-F)>

<ROUTINE MOUTH-F ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT PUT-ON THROW>
		       <COND (<PRSO? STREAM STYX SOAPY-WATER>
			      <PERFORM ,V?DRINK ,PRSO>
			      <RTRUE>)>
		       <PERFORM ,V?EAT ,PRSO>
                       <RTRUE>)
		      (<VERB? TOUCH-TO>
		       <PERFORM ,V?TASTE ,PRSO>
		       <RTRUE>)>)
	       (<VERB? REACH-IN>
		<TELL "How rude." CR>
		<RTRUE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<NO-NEED>
		<RTRUE>)
	       (<VERB? RAPE KICK KISS>
		<TELL "Good luck." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <YOU-DONT-NEED ,MOUTH>
	 <RFATAL>>

<OBJECT EYES
	(LOC GLOBAL-OBJECTS)
	(DESC "your eyes")
	(FLAGS NODESC NOARTICLE TOUCHED)
	(SYNONYM EYES)
	(ADJECTIVE MY)
	(ACTION EYES-F)>

<ROUTINE EYES-F ()
	 <COND (<THIS-PRSI?>
		T)
	       (<VERB? OPEN>
		<TELL "They are." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<V-SLEEP>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <YOU-DONT-NEED ,EYES>
	 <RFATAL>>
		
<OBJECT HEAD
	(LOC GLOBAL-OBJECTS)
	(DESC "your head")
	(FLAGS NODESC SURFACE TOUCHED NOARTICLE)
	(SYNONYM HEAD)
	(ADJECTIVE MY)
	(ACTION HEAD-F)>

<ROUTINE HEAD-F ()
	 <COND (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<IMPOSSIBLE>
		<RTRUE>)>
	 <YOU-DONT-NEED ,HEAD>
	 <RFATAL>>

<OBJECT PLAYER
	(SYNONYM PROTAGONIST)
	(DESC "yourself")
	(FLAGS NODESC NOARTICLE)
	(ACTION 0)
	(SIZE 0)
	(MASS 0)
	(CAPACITY 1000)>

<OBJECT ME
        (LOC GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF BODY)
	(ADJECTIVE MY)
	(DESC "yourself")
	(FLAGS PERSON LIVING TOUCHED NOARTICLE)
	(ACTION ME-F)>

<ROUTINE ME-F ("OPTIONAL" (CONTEXT <>) "AUX" OBJ NXT (ANY <>)) 
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <WASTE-OF-TIME>
		       <RTRUE>)
		      (<VERB? COVER>
		       <COND (<PRSO? GIRL>
			      <COND (<IS? ,PLANES ,SEEN>
				     <TELL 
"You try your best to shield the girl." CR>
				     <RTRUE>)>
			      <GIRL-SHIES>
			      <RTRUE>)>
		       <PERFORM ,V?STAND-ON ,PRSO>
		       <RTRUE>)
		      (<VERB? PUT-ON WRAP-AROUND>
		       <COND (<IS? ,PRSO ,CLOTHING>
			      <PERFORM ,V?WEAR ,PRSO>
			      <RTRUE>)>
		       <IMPOSSIBLE>
		       <RTRUE>)
		      (<VERB? PUT>
		       <PERFORM ,V?TASTE ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<TELL "Aside from your London vacation outfit, you're ">
		<SET OBJ <FIRST? ,PLAYER>>
		<REPEAT ()
			<COND (<ZERO? .OBJ>
			       <RETURN>)>
			<SET NXT <NEXT? .OBJ>>
			<COND (<IS? .OBJ ,WORN>
			       <SET ANY T>
			       <MOVE .OBJ ,WEARING>)>
			<SET OBJ .NXT>>
		<COND (<ZERO? .ANY>
		       <TELL "not wearing anything special." CR>
		       <RTRUE>)>
		<TELL "wearing ">
		<PRINT-CONTENTS ,WEARING>
		<PRINT ,PERIOD>
		<MOVE-ALL ,WEARING ,PLAYER>
		<RTRUE>)
	       (<VERB? LISTEN SMELL>
		<TELL ,CANT "help doing that." CR>
		<RTRUE>)
	       (<VERB? FIND FOLLOW>
	        <TELL "You're right here." CR>
		<RTRUE>)
	       (<VERB? RAPE SUCK KISS>
		<TELL "Desperate?" CR>
		<RTRUE>)
	       (<VERB? KILL>
		<TELL "You're indispensable." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<TELL "Punishing " D ,ME " that way">
		<WONT-HELP>
		<RTRUE>)
	       (<YOU-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT YOU
	(LOC GLOBAL-OBJECTS)
	(DESC "myself")
	(SYNONYM YOU YOURSELF)
	(FLAGS NODESC NOARTICLE)
	(ACTION YOU-F)>
	       
<ROUTINE YOU-F ()
	 <COND (<VERB? WHO WHAT WHERE>
		<TELL "Good question." CR>
		<RTRUE>)
	       (<VERB? UNDRESS>
		<INAPPROPRIATE>
		<RTRUE>)
	       (<OR <VERB? EAT TASTE DRINK DRINK-FROM>
		    <INTBL? ,PRSA ,HAVEVERBS ,NHAVES>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT CLOTHES
	(LOC GLOBAL-OBJECTS)
	(DESC "your clothes")
	(SYNONYM CLOTHES CLOTHING APPAREL OUTFIT SHORTS)
	(ADJECTIVE MY)
	(FLAGS WORN CLOTHING NODESC NOARTICLE)
	(ACTION CLOTHES-F)>

<ROUTINE CLOTHES-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<PERFORM ,V?EXAMINE ,ME>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-INSIDE ,POCKET>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? CLOTHES>>
		<TELL "[in " D ,POCKET ,BRACKET>
		<PERFORM ,V?PUT ,PRSO ,POCKET>
		<RTRUE>)
	       (<VERB? WEAR>
		<TELL ,YOURE-ALREADY "wearing them." CR>
		<RTRUE>)
	       (<VERB? TAKE-OFF DROP RAISE>
		<INAPPROPRIATE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE INAPPROPRIATE ()
	 <TELL "That would hardly be an appropriate thing to do." CR>
	 <RTRUE>>

<ROUTINE WONT-HELP ()
	 <TELL " isn't likely to help matters." CR>
	 <RTRUE>>

<OBJECT GLOBAL-ROOM
	(LOC GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM AREA PLACE)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<OR <ENTERING?>
		    <VERB? DROP EXIT>>
		<V-WALK-AROUND>
		<RFATAL>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the area reveals nothing new" ,PCR
"[If you want to go somewhere, simply indicate a " D ,INTDIR ".]" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
<ROUTINE OBJECT-IS-LOCKED ()
	 <TELL ,CANT "do that. It's locked." CR>
	 <RTRUE>>

<ROUTINE CANT-SEE-ANY ("OPTIONAL" (THING <>) (STRING? <>))
         <SETG CLOCK-WAIT? T>
	 <PCLEAR>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL ,CANT>
	 <COND (<VERB? LISTEN>
		<TELL "hear ">)
	       (<VERB? SMELL>
		<TELL "smell ">)
	       (T
		<TELL "see ">)>
	 <COND (<T? .STRING?>
		<TELL .THING>)
	       (<T? .THING>
		<COND (<NOT <IS? .THING ,NOARTICLE>>
		       <TELL "any ">)>
		<TELL D .THING>)
	       (T
		<TELL D ,NOT-HERE-OBJECT>)>
	 <TELL " here." CR>
	 <RTRUE>>

<ROUTINE HOW? ()
         <TELL "How do you ">
	 <COND (<PROB 50>
		<TELL "expect ">)
	       (T
		<TELL "intend ">)>
	 <TELL "to do that?" CR>
	 <RTRUE>>
	 			      
<ROUTINE NOT-LIKELY (THING STR)
	 <TELL "It" <PICK-NEXT ,LIKELIES> " that " THE .THING>
	 <SPACE>
	 <TELL .STR ,PERIOD>
	 <RTRUE>>

<GLOBAL LIKELIES:TABLE 
	<LTABLE 2
	 " isn't likely"
	 " seems doubtful"
	 " seems unlikely"
	 "'s unlikely"
	 "'s not likely"
	 "'s doubtful">>

<ROUTINE YOUD-HAVE-TO (STR THING)
	 <THIS-IS-IT .THING>
	 <TELL "You'd have to " .STR>
	 <SPACE>
	 <TELL THE .THING " to do that." CR>
	 <RTRUE>>

<OBJECT HER
	(LOC GLOBAL-OBJECTS)
	(SYNONYM SHE HER HERSELF)
	(DESC "her")
	(FLAGS NOARTICLE PERSON LIVING FEMALE)>

<OBJECT HIM
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HE HIM HIMSELF)
	(DESC "him")
	(FLAGS NOARTICLE PERSON LIVING)>

<OBJECT THEM
	(LOC GLOBAL-OBJECTS)
	(SYNONYM THEY THEM THEMSELVES)
	(DESC "them")
	(FLAGS NOARTICLE)>

<OBJECT INTDIR
	(LOC GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECTION)
	(ADJECTIVE NORTH EAST SOUTH WEST W NE NW SE SW UP DOWN)>

<OBJECT PLANET
	(LOC LOCAL-GLOBALS)
	(DESC "planet")
	(FLAGS NODESC)
	(SYNONYM PLANET)
	(ACTION PLANET-F)>

<ROUTINE PLANET-F ()
	 <COND (<VERB? EXAMINE LOOK-ON>
		<TELL CTHEO " below is dark with shadow." CR>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <VERB? LOOK-BEHIND LOOK-UNDER SEARCH>
		    <ENTERING?>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<EXITING?>
		<NOT-IN ,PRSO T>
		<RTRUE>)
	       (T
		<RFALSE>)>>	 

<OBJECT GROUND
	(LOC GLOBAL-OBJECTS)
	(DESC "ground")
	(SYNONYM SURFACE GROUND GROUNDS EARTH ICE)
        (FLAGS NODESC)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ("AUX" OBJ NXT)
	 <COND (<HERE? IN-ORBIT ON-SAT>
		<COND (<PLANET-F>
		       <RTRUE>)>
		<RFALSE>)
	       (<NOUN-USED? ,W?ICE>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT THROW THROW-OVER EMPTY-INTO>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-ON SEARCH>
		<SET OBJ <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<T? .OBJ>
			       <SET NXT <NEXT? .OBJ>>
			       <COND (<OR <IS? .OBJ ,NODESC>
					  <NOT <IS? .OBJ ,TAKEABLE>>>
				      <MOVE .OBJ ,C-OBJECT>)>
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>
		<TELL ,YOU-SEE>
		<PRINT-CONTENTS ,HERE>
		<TELL " on the ">
		<COND (<IS? ,HERE ,INDOORS>
		       <TELL D ,FLOOR>)
		      (T
		       <TELL D ,GROUND>)>
		<TELL ,PERIOD>
		<MOVE-ALL ,C-OBJECT ,HERE>
		<RTRUE>)
	       (<VERB? CROSS>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT FLOOR
	(LOC GLOBAL-OBJECTS)
	(DESC "floor")
	(SYNONYM FLOOR)
	(ACTION FLOOR-F)>

<ROUTINE FLOOR-F ()
	 <COND (<AND <NOT <IS? ,HERE ,INDOORS>>
		     <NOT <HERE? IN-JEEP>>>
		<CANT-SEE-ANY ,FLOOR>
		<RFATAL>)
	       (<GROUND-F>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT POCKET
	(LOC PLAYER)
	(DESC "your pocket")
	(SYNONYM POCKET POCKETS)
	(ADJECTIVE MY SIDE)
	(FLAGS NODESC NOARTICLE CONTAINER OPENED)
	(SIZE 0)
	(MASS 0)
	(CAPACITY 4)
	(CONTFCN IN-POCKET)
	(ACTION POCKET-F)>

<ROUTINE POCKET-F ("AUX" OBJ)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT>
		       <COND (<PRSO? CRANE>
			      <TELL CTHEO 
				    " would get crumpled" ,IF-YOU-DID>
			      <RTRUE>)
			     (<OR <PRSO? BAG>
				  <AND <PRSO? EBAG SOGGY>
				       <FIRST? ,PRSO>>>
			      <YOUD-HAVE-TO "empty" ,PRSO>
			      <RTRUE>)
			     (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <TELL CTHEO " is too big to fit in " 
				    D ,PRSI ,PERIOD>
			      <RTRUE>)>
		       <RFALSE>)>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<SET OBJ <FIRST? ,PRSO>>
		<COND (<T? .OBJ>
		       <TELL "You have ">
		       <PRINT-CONTENTS ,PRSO>)		      
		      (T
		       <TELL "There's nothing">)>
		<TELL " in " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<VERB? EMPTY>
		<TELL "[into " D ,HANDS "s" ,BRACKET>
		<RFALSE>)
	       (<VERB? OPEN OPEN-WITH CLOSE>
		<NO-NEED>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		<TELL ,CANT "do that to " D ,PRSO ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
  
<ROUTINE IN-POCKET ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<OR <INTBL? ,PRSA ,HAVEVERBS ,NHAVES>
		    <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>>
		<TELL "You'll have to take it out of " D ,POCKET " first." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NO-NEED ()
	 <TELL ,DONT "need to do that." CR>
	 <RTRUE>>

<ROUTINE ITALICIZE (STR "AUX" (PTR 2) (ST 0) LEN CHAR)
       ; <DIROUT ,D-SCREEN-OFF>
	 <COND (<EQUAL? <GETB 0 30> 5> ; "Atari ST?"
		<INC ST>)>
	 <DIROUT ,D-TABLE-ON ,SL-TABLE>
	 <TELL .STR>
	 <DIROUT ,D-TABLE-OFF>
       ; <DIROUT ,D-SCREEN-ON>
	 <SET LEN <GET ,SL-TABLE 0>>
         <INC LEN>
	 <COND (<L? .LEN 2>
		<RTRUE>)
	       (<BAND <GETB 0 1> 8>
	      ; <OR <ZIL?>
		    <BAND <GETB 0 1> 8>> ; "ITALICS BIT SET?"
		<HLIGHT ,H-ITALIC>
		<REPEAT ()
			<SET CHAR <GETB ,SL-TABLE .PTR>>
			<COND (<AND <ZERO? .ST>
				    <OR <EQUAL? .CHAR 32 46 44>
					<EQUAL? .CHAR 33 63 59>
					<EQUAL? .CHAR 58>>>
			       <HLIGHT ,H-NORMAL>
			       <PRINTC .CHAR>
			       <HLIGHT ,H-ITALIC>)
			      (T
			       <PRINTC .CHAR>)>
			<COND (<EQUAL? .PTR .LEN>
			       <RETURN>)>
			<INC PTR>>
		<HLIGHT ,H-NORMAL>
		<RTRUE>)>
	 <REPEAT ()				   ; "Caps if no italics."
		 <SET CHAR <GETB ,SL-TABLE .PTR>>
		 <COND (<AND <G? .CHAR 96>
			     <L? .CHAR 123>>
			<SET CHAR <- .CHAR 32>>)>
		 <PRINTC .CHAR>
		 <COND (<EQUAL? .PTR .LEN>
			<RETURN>)>
		 <INC PTR>>
	 <RTRUE>>
	       
<ROUTINE WRONG-WINNER? ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<RFALSE>)>
	 <TELL "[" ,CANT "tell characters to do that.]" CR>
	 <RTRUE>>

<ROUTINE NOT-IN ("OPTIONAL" (THING <>) (ON? <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <THIS-IS-IT .THING>
	 <TELL "You're not ">
	 <COND (<T? .ON?>
		<TELL "on ">)
	       (T
		<TELL "in ">)>
	 <TELL THE .THING ,PERIOD>
	 <RTRUE>>

<ROUTINE ALREADY-IN ("OPTIONAL" (THING <>) (ON? <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <THIS-IS-IT .THING>
	 <TELL ,YOURE-ALREADY>
	 <COND (<T? .ON?>
		<TELL "on ">)
	       (T
		<TELL "in ">)>
	 <TELL THE .THING ,PERIOD>
	 <RTRUE>>

; <ROUTINE ALREADY-OUTSIDE ("OPTIONAL" (THING <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <THIS-IS-IT .THING>
	 <TELL ,YOURE-ALREADY "outside " THE .THING ,PERIOD>>

<ROUTINE ALREADY-AT-TOP ("OPTIONAL" (OBJ <>))
	 <ALREADY-AT "top" .OBJ>
	 <RTRUE>>

<ROUTINE ALREADY-AT-BOTTOM ("OPTIONAL" (OBJ <>))
	 <ALREADY-AT "bottom" .OBJ>
	 <RTRUE>>

<ROUTINE ALREADY-AT (STR OBJ)
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <THIS-IS-IT .OBJ>
	 <TELL ,YOURE-ALREADY "at the " .STR " of " THE .OBJ ,PERIOD>
	 <RTRUE>>

<ROUTINE CANT-SEE-MUCH ()
	 <TELL "Little can be seen from where you're ">
	 <COND (<HERE? IN-ORBIT ON-SAT ON-BIRD>
		<TELL "float">)
	       (<HERE? IN-SKY>
		<TELL "fall">)
	       (T
		<TELL "stand">)>
	 <TELL "ing." CR>
	 <RTRUE>>

<ROUTINE CANT-SEE-FROM-HERE (THING)
	 <TELL ,CANT "see " THE .THING " from here." CR>
	 <RTRUE>>

<ROUTINE NOT-A (STR)
	 <TELL "You're a tourist, not a " .STR ,PERIOD>
	 <RTRUE>>

<ROUTINE OPEN-CLOSED (THING "OPTIONAL" (VOWEL <>))
	 <COND (<IS? .THING ,OPENED>
		<COND (<T? .VOWEL>
		       <TELL "n">)>
		<TELL " open ">)
	       (T
		<TELL " closed ">)>
	 <TELL D .THING>
	 <RTRUE>>

; <ROUTINE ON-OFF (THING)
	 <COND (<IS? .THING ,LIGHTED>
		<TELL "on">)
	       (T
		<TELL "off">)>
	 <RTRUE>>

<ROUTINE CANT-FROM-HERE ()
	 <TELL "You couldn't do that from " <PICK-NEXT ,COULDNTS> ,PERIOD>
	 <RTRUE>>

<GLOBAL COULDNTS:TABLE
	<LTABLE 2 "where you're standing" "here" "where you are" "here">>

<ROUTINE MORE-THAN-ONE (STR)
	 <TELL "[There's more than one " .STR
	       " here. Please specify which one you mean.]" CR>
	 <RTRUE>>

<ROUTINE GENERIC-DOOR-F (TABLE "AUX" (PTR 1) (DOOR <>) LEN X)
	 <COND (<OR <EQUAL? ,P-NAM ,W?DOORS ,W?DOORWAYS>
		    <EQUAL? ,P-XNAM ,W?DOORS ,W?DOORWAYS>>
		<MORE-THAN-ONE "door">
		<RETURN ,NOT-HERE-OBJECT>)>
	 <SET LEN <GET .TABLE 0>>
	 <COND (<L? .LEN 2>
		<RFALSE>)>
	 <COND (<VERB? CLOSE ENTER WALK-TO THROUGH USE CROSS EXIT FOLLOW
		       LOOK-INSIDE LOOK-OUTSIDE LOOK-BEHIND>
		<REPEAT ()
			<SET X <GET .TABLE .PTR>>
			<COND (<IS? .X ,OPENED>
			       <COND (<T? .DOOR>
				      <RFALSE>)>
			       <SET DOOR .X>)>
			<COND (<IGRTR? PTR .LEN>
			       <RETURN>)>>
		<RETURN .DOOR>)
	       (<VERB? OPEN>
		<REPEAT ()
			<SET X <GET .TABLE .PTR>>
			<COND (<NOT <IS? .X ,OPENED>>
			       <COND (<T? .DOOR>
				      <RFALSE>)>
			       <SET DOOR .X>)>
			<COND (<IGRTR? PTR .LEN>
			       <RETURN>)>>
		<RETURN .DOOR>)>
	 <RFALSE>>

; <OBJECT DUMMY-WINDOW
	(DESC "window")
	(FLAGS NODESC)
	(SYNONYM WINDOW WINDOWS PANE PANES)
	(GENERIC GENERIC-WINDOW-F)>

; <ROUTINE GENERIC-WINDOW-F (TABLE "AUX" LEN)
	 <COND (<EQUAL? ,P-NAM ,W?WINDOWS ,W?PANES>
		<MORE-THAN-ONE "window">
		<RETURN ,NOT-HERE-OBJECT>)>
	 <SET LEN <GET .TABLE 0>>
	 <COND (<ZERO? .LEN>
		<RFALSE>)
	       (<AND <T? ,P-IT-OBJECT>
		     <INTBL? ,P-IT-OBJECT .TABLE .LEN>>
		<RETURN ,P-IT-OBJECT>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-PLACE? (INSIDE "OPTIONAL" (N <>) (E <>) (S <>) (W <>)
			                  (OUT <>) "AUX" (CNT 0))
	 <COND (<T? .N>
		<INC CNT>)>
	 <COND (<T? .E>
	        <INC CNT>)>
	 <COND (<T? .S>
		<INC CNT>)>
	 <COND (<T? .W>
	        <INC CNT>)>
       ; <COND (<T? .OUT>
		<INC CNT>)>
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE LOOK-DOWN SEARCH>
		<COND (<EQUAL? ,HERE .INSIDE>
		       <V-LOOK>)
		      (T
		       <CANT-SEE-MUCH>)>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO THROUGH>
		<COND (<EQUAL? ,HERE .INSIDE>
		       <ALREADY-IN>)
		      (<EQUAL? ,HERE .N>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE .E>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE .S>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE .W>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE .OUT>
		       <DO-WALK ,P?IN>)
		      (T
		       <V-WALK-AROUND>)>
		<RTRUE>)
	       (<EXITING?>
		<COND (<NOT <EQUAL? ,HERE .INSIDE>>
		       <NOT-IN>)
		      (<G? .CNT 1>
		       <V-WALK-AROUND>)
		      (T
		       <DO-WALK ,P?OUT>)>
		<RTRUE>)
	       (<AND <THIS-PRSO?>
		     <INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>>
		<IMPOSSIBLE>
		<RTRUE>)
	       (<AND <NOT <EQUAL? ,HERE .INSIDE>>
		     <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE ALREADY-DOING-THAT ()
	 <TELL ,YOURE-ALREADY "doing that." CR>
	 <RTRUE>>

<ROUTINE CANT-REACH (OBJ)
	 <TELL CTHE .OBJ>
	 <IS-ARE .OBJ>
	 <TELL "high out of reach." CR>
	 <RTRUE>>

<ROUTINE TOO-HIGH ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <TELL CTHE .OBJ>
	 <IS-ARE .OBJ>
	 <TELL "too high." CR>
	 <RTRUE>>

<ROUTINE PRSO-TOO-BIG ()
	 <TELL CTHEO>
	 <IS-ARE>
	 <TELL "much too big." CR>
	 <RTRUE>>

<ROUTINE PRSO-WONT-FIT ()
	 <TELL CTHEO>
	 <IS-ARE>
	 <TELL "too big to fit in " THE ,PRSI ,PERIOD>
	 <RTRUE>>

<ROUTINE IS-ARE ("OPTIONAL" (THING <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <COND (<IS? .THING ,PLURAL>
		<TELL " are ">)
	       (T
		<TELL " is ">)>
	 <RTRUE>>

<ROUTINE ISNT-ARENT ("OPTIONAL" (THING <>))
	 <COND (<ZERO? .THING>
		<SET THING ,PRSO>)>
	 <COND (<IS? .THING ,PLURAL>
		<TELL " aren't ">)
	       (T
		<TELL " isn't ">)>
	 <RTRUE>>

<ROUTINE CARRIAGE-RETURNS ("OPTIONAL" (CNT 23))
	 <REPEAT ()
		 <COND (<ZERO? .CNT>
			<RTRUE>)>
		 <CRLF>
		 <DEC CNT>>
	 <RTRUE>>

<ROUTINE VANISH ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <REMOVE .OBJ>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <RTRUE>>

<ROUTINE DROP-ALL ("OPTIONAL" (L <>) "AUX" OBJ NXT)
	 <COND (<ZERO? .L>
		<SET L ,HERE>)>
	 <SET OBJ <FIRST? ,PLAYER>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RTRUE>)>
		 <SET NXT <NEXT? .OBJ>>
		 <COND (<AND <NOT <EQUAL? .OBJ ,POCKET ,HONEY>>
			     <NOT <IS? .OBJ ,WORN>>>
			<MOVE .OBJ .L>)>
		 <SET OBJ .NXT>>
	 <RTRUE>>

<OBJECT BREATH
	(LOC GLOBAL-OBJECTS)
	(DESC "your breath")
	(FLAGS TRYTAKE NOARTICLE NODESC)
	(SYNONYM BREATH)
	(ADJECTIVE MY DEEP)
	(ACTION BREATH-F)>

"CHILLY = garlic eaten."

<ROUTINE BREATH-F ()
	 <COND (<AND <VERB? TAKE SUCK>
		     <THIS-PRSO?>>
		<COND (<NOT <EQUAL? ,PRSI <> ,ROOMS>>
		       <IMPOSSIBLE>)
		      (<OR <VERB? SUCK>
			   <EQUAL? ,P-PRSA-WORD ,W?HOLD ,W?TAKE ,W?CATCH>
			   <EQUAL? ,P-PRSA-WORD ,W?GET ,W?GRAB>>
		       <V-INHALE>)
		      (T
		       <PRINT ,CANT>
		       <PRINTB ,P-PRSA-WORD>
		       <SPACE>
		       <TELL D ,BREATH>
		       <PRINT ,PERIOD>)>
		<RTRUE>)
	       (<VERB? RELEASE>
		<V-EXHALE>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL "It smells no worse than usual." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IS? ,HERE ,CHILLY>
		       <TELL "It puffs like steam in the cold air">)
		      (T
		       <TELL "It's not cold enough to see " D ,BREATH>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE TAKE-A-MOMENT-TO (OBJ "OPTIONAL" (STR <>))
	 <TELL "Perhaps you should take a moment to examine the ">
	 <COND (<T? .STR>
		<TELL .STR>)
	       (T
		<TELL D .OBJ>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE WHICH-WAY-IN ()
	 <WHICH-WAY "in">
	 <RFALSE>>

<ROUTINE WHICH-WAY-OUT ()
	 <WHICH-WAY "out">
	 <RFALSE>>

<ROUTINE WHICH-WAY-DOWN ()
	 <WHICH-WAY "down">
	 <RFALSE>>

<ROUTINE WHICH-WAY (STR)
	 <TELL "[Which way do you want to go " .STR "?]" CR>
	 <RTRUE>>

<ROUTINE SAY-EAST ()
	 <COND (<ZERO? ,FLIP?>
		<TELL "east">)
	       (T
	        <TELL "west">)>
	 <RTRUE>>

<ROUTINE SAY-WEST ()
	 <COND (<ZERO? ,FLIP?>
		<TELL "west">)
	       (T
		<TELL "east">)>
	 <RTRUE>>

<ROUTINE PRSO-WONT-BUDGE ()
	 <TELL CTHEO " won't budge." CR>
	 <RTRUE>>

<ROUTINE FIRMLY-ATTACHED (THING TO)
	 <THIS-IS-IT .THING>
	 <TELL CTHE .THING>
	 <IS-ARE .THING>
	 <ATTACHED-TO .TO>
	 <RTRUE>>

<ROUTINE ATTACHED-TO ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <TELL <PICK-NEXT <GET ,FIXTURES 0>> "ly "
	       <PICK-NEXT <GET ,FIXTURES 1>> " to " THE .OBJ ,PERIOD>
	 <RTRUE>>

<GLOBAL FIXTURES
	<PTABLE
	 <LTABLE 2 "firm" "permanent" "immovab" "secure">
	 <LTABLE 2 "attached" "affixed">>>

<ROUTINE NOUN-USED? (WORD1 "OPTIONAL" (WORD2 <>) (WORD3 <>) 
		           "AUX" O I OOF IOF)
	 <SET O <GET ,P-NAMW 0>>
	 <SET I <GET ,P-NAMW 1>>
	 <SET OOF <GET ,P-OFW 0>>
	 <SET IOF <GET ,P-OFW 1>>
	 <COND (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD1 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD1 .I .IOF>>>
		<RTRUE>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD2 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD2 .I .IOF>>>
		<RTRUE>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .WORD3 .O .OOF>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .WORD3 .I .IOF>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ADJ-USED? (WORD1 "OPTIONAL" (WORD2 <>) (WORD3 <>)
		    	  "AUX" O I)
	 <SET O <GET ,P-ADJW 0>>
	 <SET I <GET ,P-ADJW 1>>
	 <COND (<OR <AND <THIS-PRSO?>
			 <EQUAL? .O .WORD1>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .I .WORD1>>>
		<RTRUE>)
	       (<ZERO? .WORD2>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .O .WORD2>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .I .WORD2>>>
		<RTRUE>)
	       (<ZERO? .WORD3>
		<RFALSE>)
	       (<OR <AND <THIS-PRSO?>
			 <EQUAL? .O .WORD3>>
		    <AND <T? ,PRSI>
			 <THIS-PRSI?>
			 <EQUAL? .I .WORD3>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		   
<ROUTINE HERE-F ()
	 <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE SEARCH WATCH>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? LOOK-BEHIND LOOK-OUTSIDE>
		<CANT-SEE-MUCH>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO FIND>
		<ALREADY-IN>
		<RTRUE>)
	       (<OR <EXITING?>
		    <VERB? FOLLOW THROUGH CROSS CLIMB-OVER CLIMB-UP
			   CLIMB-DOWN CLIMB-ON>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE SAVE-HERE ()
	 <CRLF>
	 <HLIGHT ,H-BOLD>
	 <TELL "[This might be a good time to use the SAVE command.]" CR>
	 <HLIGHT ,H-NORMAL>
	 <RTRUE>> 

"WINDOW [table] [left-margin], where [table] is a global PLTABLE
 with the 1st element = width of window, followed by strings (0 for blank).
 If [left-margin] is not specified, window is centered."

<ROUTINE WINDOW (TABLE "OPTIONAL" (MARGIN 0)
		       "AUX" (Y 4) (I 2) WIDTH LINES STR PLINES)
	 
	 <SET LINES <GET .TABLE 0>>
	 <SET PLINES .LINES>
	 <SET WIDTH <GET .TABLE 1>>
	 <COND ; (<G? .WIDTH <GETB 0 33>>
		  <TELL "[Window too wide!]" CR>
		  <RTRUE>)
	       (<ZERO? .MARGIN>
		<SET MARGIN <- ,MIDSCREEN </ .WIDTH 2>>>)> ; "Center"
	 	 
	 <SPLIT <+ .LINES 4>> ; "Set up the window."
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <HLIGHT ,H-INVERSE>
	 
	 <CURSET .Y .MARGIN>
	 <PRINT-SPACES .WIDTH>
	 
	 <REPEAT ()
		 <INC Y>
		 <CURSET .Y .MARGIN>
		 <DEC LINES>
		 <COND (<ZERO? .LINES>
			<PRINT-SPACES .WIDTH>
			<RETURN>)>
		 <SET STR <GET .TABLE .I>>
		 <COND (<ZERO? .STR>
			<PRINT-SPACES .WIDTH>)
		       (T
			<PRINTC 32>
			<TELL .STR>
			<PRINTC 32>)>
		 <INC I>>
	 
	 <BUFOUT T>
	 <HLIGHT ,H-NORMAL>
	 <SCREEN ,S-TEXT>
	 <SPLIT 1>

       ; "Send window to printer."
	
	 <DIROUT ,D-SCREEN-OFF>
	 <SET I 2>
	 <CRLF>
	 <TELL "[">
	 <REPEAT ()
		 <DEC PLINES>
		 <COND (<ZERO? .PLINES>
			<RETURN>)>
		 <SET STR <GET .TABLE .I>>
		 <COND (<NOT <ZERO? .STR>>
			<COND (<NOT <EQUAL? .I 2>>
			       <PRINTC 32>)>
			<TELL .STR>
			<COND (<EQUAL? .PLINES 1>
			       <TELL "]">)>)>
		 <CRLF>
		 <INC I>>
	 <CRLF>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>
		 
<OBJECT SOUND
	(LOC GLOBAL-OBJECTS)
	(DESC "sound")
	(FLAGS NODESC)
	(SYNONYM SOUND SOUNDS)
	(ACTION SOUND-F)>

<ROUTINE SOUND-F ("AUX" X)
	 <SET X <GETP ,HERE ,P?HEAR>>
	 <COND (<T? .X>
		<COND (<ZERO? ,NOW-PRSI?>
		       <PERFORM ,PRSA .X ,PRSI>)
		      (T
		       <PERFORM ,PRSA ,PRSO .X>)>
		<RTRUE>)
	       (<OR <INTBL? ,PRSA ,SEEVERBS ,NSVERBS>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<IMPOSSIBLE>		       
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE CANT-SEE-NOW (OBJ)
	 <TELL ,CANT "see " THE .OBJ " at the moment." CR>
	 <RTRUE>>

<OBJECT WISH-OBJECT
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(FLAGS NODESC)
	(SYNONYM DARKNESS RAIN ADVICE LUCK FLIGHT FORESIGHT FREEDOM)
	(ACTION V-WISH)>

<OBJECT CORNER
	(LOC GLOBAL-OBJECTS)
	(DESC "corner")
	(FLAGS NODESC SURFACE)
	(SYNONYM CORNER CORNERS)
	(ACTION CORNER-F)>

<ROUTINE CORNER-F ()
	 <COND (<NOT <IS? ,HERE ,INDOORS>>
		<CANT-SEE-ANY ,CORNER>
		<RFATAL>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH LOOK-BEHIND LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (<ENTERING?>
		<TELL ,YOURE-ALREADY "close enough to the " D ,CORNER
		      ,PERIOD>
		<RTRUE>)
	       (<EXITING?>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<INTBL? ,PRSA ,PUTVERBS ,NUMPUTS>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PCLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<OBJECT RIGHT
	(LOC GLOBAL-OBJECTS)
	(DESC "that direction")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM RIGHT CLOCKWISE FORWARD AHEAD)
	(ACTION RL-F)>

<OBJECT LEFT
	(LOC GLOBAL-OBJECTS)
	(DESC "that direction")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM LEFT COUNTERCL BACKWARD BACKWARDS BACK)
	(ACTION RL-F)>

<ROUTINE RL-F ()
	 <COND (<OR <ENTERING?>
		    <VERB? EXIT LEAVE ESCAPE CLIMB-UP CLIMB-DOWN CLIMB-ON
			   CLIMB-OVER CROSS STAND-ON STAND-UNDER>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		       
<ROUTINE YOUD-FALL-OFF (OBJ)
	 <TELL "You'd ">
	 <COND (<PROB 50>
		<TELL "fall">)
	       (T
		<TELL "tumble">)>
	 <TELL " over the edge of " THE .OBJ
	       " if you went that way." CR>
	 <RTRUE>>

<ROUTINE YOUD-FALL ()
	 <TELL "You'd " <PICK-NEXT ,PLUMMETS> " if you went that way." CR>
	 <RFALSE>>

<GLOBAL PLUMMETS:TABLE
	<LTABLE 2
	  "have a long way to fall" "plummet to your death"
	  "tumble to an early grave" "fall over the edge">>

<ROUTINE USELESS ("AUX" OBJ)
	 <COND (<VERB? EXAMINE>
		<RFALSE>)
	       (<THIS-PRSO?>
		<SET OBJ ,PRSO>)
	       (T
		<SET OBJ ,PRSI>)>
	 <YOU-DONT-NEED .OBJ>
	 <RFATAL>>

<ROUTINE YOU-DONT-NEED (THING "OPTIONAL" (STRING? <>))
	 <TELL "[" ,DONT "need to refer to ">
	 <COND (<T? .STRING?>
		<TELL "the " .THING>)
	       (T
		<TELL THE .THING>)>
       ; <TELL " that way">
	 <TO-COMPLETE>
	 <RTRUE>>

<ROUTINE TO-COMPLETE ()
	 <TELL " to complete this story.]" CR>
	 <RTRUE>>

<ROUTINE VOICE-MUTTERS (STR "OPTIONAL" (CR T) "AUX" (X <>) (ST 0))
	 <COND (<AND <IS? ,HERE ,WINDY>
		     <ZERO? ,TR?>>
		<RFALSE>)>
	 <COND (<PROB 50>
		<SET X T>
		<TELL "A voice in your ear" <PICK-NEXT <GET ,MUTTERS 0>>
		      "s, ">)>
	 <COND (<EQUAL? <GETB 0 30> 5> ; "Atari ST?"
		<INC ST>
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)
	       (T
		<TELL "\"">)>
	 <TELL .STR>
	 <COND (<ZERO? .X>
		<TELL ",">
		<HLIGHT ,H-NORMAL>
		<COND (<ZERO? .ST>
		       <TELL "\"">)
		      (T
		       <ST-QUOTE>)>
		<TELL <PICK-NEXT <GET ,MUTTERS 0>> "s a voice in your ear.">)
	       (T
		<TELL ".">
		<HLIGHT ,H-NORMAL>
		<COND (<ZERO? .ST>
		       <TELL "\"">)
		      (T
		       <ST-QUOTE>)>)>
	 <CRLF>
	 <COND (<T? .CR>
		<CRLF>)>
	 <RTRUE>>

<ROUTINE THIS-IS-NOT (STR "AUX" (ST 0))
	 <COND (<EQUAL? <GETB 0 30> 5> ; "Atari ST?"
		<INC ST>
		<ST-QUOTE>
		<HLIGHT ,H-ITALIC>)
	       (T
		<TELL "\"">)>
	 <TELL "This isn't ">
	 <COND (<T? .ST>
		<HLIGHT ,H-NORMAL>)
	       (T
		<HLIGHT ,H-ITALIC>)>
	 <TELL .STR>
	 <COND (<T? .ST>
		<TELL ",">
		<HLIGHT ,H-ITALIC>)
	       (T
		<HLIGHT ,H-NORMAL>
		<TELL ",">)>
	 <TELL " you know,">
	 <HLIGHT ,H-NORMAL>
	 <COND (<ZERO? .ST>
	        <TELL "\"">)
	       (T
		<ST-QUOTE>)>
	 <TELL <PICK-NEXT <GET ,MUTTERS 0>> "s a voice in your ear." CR>
	 <RTRUE>>
	 
; <ROUTINE THIS-IS-NOT (STR)
	 <TELL "[Sorry. This is ">
	 <ITALICIZE "Trinity,">
	 <TELL " not ">
	 <ITALICIZE .STR>
	 <TELL "]" CR>
	 <RTRUE>>

<ROUTINE NO-DETECTION ()
	 <CRLF>
	 <VOICE-MUTTERS <PICK-NEXT <GET ,MUTTERS 1>> <>>
	 <RTRUE>>

<ROUTINE ST-QUOTE ()
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL "\"">
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<GLOBAL MUTTERS
	<PTABLE
	 <LTABLE 2 " remark" " mutter" " snigger" " grumble" " whisper"
		  " giggle" " sigh"  " intone" " snicker" " whisper">
	 <LTABLE 2 "Smart move" "Had me worried there" "Thanks" "Good idea"
		   "Well done" "Thanks again">>>
		    
<ROUTINE NONE-AT-MOMENT ()
	 <TELL ,CANT "see any at the moment." CR>
	 <RTRUE>>