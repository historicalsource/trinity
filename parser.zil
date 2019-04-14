"PARSER for TRINITY: (C)1986 Infocom, Inc. All rights reserved."

<SETG SIBREAKS ".,\"!?">

<GLOBAL PRSA:VERB 0>
<GLOBAL PRSI:OBJECT 0>
<GLOBAL PRSO:OBJECT 0>
<GLOBAL P-TABLE:NUMBER 0>
<GLOBAL P-SYNTAX:NUMBER 0>
<GLOBAL P-LEN:NUMBER 0>
<GLOBAL P-DIR:NUMBER 0>
<GLOBAL HERE:OBJECT 0>

<GLOBAL P-LEXV:TABLE <ITABLE BYTE 120>>
<GLOBAL P-INBUF:TABLE <ITABLE BYTE 100>>
<GLOBAL RESERVE-INBUF:TABLE <ITABLE BYTE 100>> ; "RETROFIX #36"

"Parse-cont variable"

<GLOBAL P-CONT:FLAG <>>

<GLOBAL P-IT-OBJECT:OBJECT <>>
<GLOBAL P-HER-OBJECT:OBJECT <>>
<GLOBAL P-HIM-OBJECT:OBJECT <>>
<GLOBAL P-THEM-OBJECT:OBJECT <>>

"Orphan flag"

<GLOBAL P-OFLAG:FLAG <>>

<GLOBAL P-MERGED <>>
<GLOBAL P-ACLAUSE <>>
<GLOBAL P-ANAM <>>
<GLOBAL P-AADJ <>>

"Byte offset to # of entries in LEXV"

<CONSTANT P-LEXWORDS 1>

"Word offset to start of LEXV entries"

<CONSTANT P-LEXSTART 1>

"Number of words per LEXV entry"

<CONSTANT P-LEXELEN 2>
<CONSTANT P-WORDLEN 4>

"Offset to parts of speech byte"

<CONSTANT P-PSOFF 6>

"Offset to first part of speech"

<CONSTANT P-P1OFF 7>

"First part of speech bit mask in PSOFF byte"

<CONSTANT P-P1BITS 3>
<CONSTANT P-ITBLLEN 9>

<GLOBAL P-ITBL:TABLE <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-OTBL:TABLE <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-VTBL:TABLE <TABLE 0 0 0 0>>
<GLOBAL P-OVTBL:TABLE <TABLE 0 0 0 0>>
<GLOBAL P-NCN 0>

<CONSTANT P-VERB 0>
<CONSTANT P-VERBN 1>
<CONSTANT P-PREP1 2>
<CONSTANT P-PREP1N 3>
<CONSTANT P-PREP2 4>

<CONSTANT P-NC1 6>
<CONSTANT P-NC1L 7>
<CONSTANT P-NC2 8>
<CONSTANT P-NC2L 9>

<GLOBAL QUOTE-FLAG:FLAG <>>

<GLOBAL P-WON:FLAG <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-BEG 1>
<CONSTANT M-ENTERING 2>
<CONSTANT M-LOOK 3>
<CONSTANT M-ENTERED 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6>
<CONSTANT M-CONT 7>
<CONSTANT M-WINNER 8>
<CONSTANT M-EXIT 9>

<GLOBAL P-WALK-DIR:DIRECTION <>>
<GLOBAL P-END-ON-PREP <>>

<GLOBAL AGAIN-LEXV:TABLE <ITABLE BYTE 120>>
<GLOBAL RESERVE-LEXV:TABLE <ITABLE BYTE 120>>
<GLOBAL RESERVE-PTR <>>

<GLOBAL OOPS-INBUF:TABLE <ITABLE BYTE 100>>
<GLOBAL OOPS-TABLE:TABLE <TABLE <> <> <> <>>>
<GLOBAL AGAIN-DIR:DIRECTION <>> ; "FIX #44"

<CONSTANT O-PTR 0>
<CONSTANT O-START 1>
<CONSTANT O-LENGTH 2>
<CONSTANT O-END 3>

<GLOBAL P-PRSA-WORD:WORD <>>
<GLOBAL P-DIR-WORD:WORD <>>

<GLOBAL INLEN:NUMBER 0> "For MAGPIE."

<GLOBAL DO-WINDOW <>>

" Grovel down the input finding the verb, prepositions, and noun clauses.
   If the input is <direction> or <walk> <direction>, fall out immediately
   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform
   all required orphaning, syntax checking, and noun clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>)
		       (LEN 0) (DIR <>) (NW 0) (LW 0) (CNT -1) OWINNER
		       OMERGED (TMP1 0))
	<REPEAT ()
		<SET CNT <+ .CNT 1>>
		<COND (<G? .CNT ,P-ITBLLEN>
		       <RETURN>)
		      (T
		       <COND (<ZERO? ,P-OFLAG>
			      <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>
		       <PUT ,P-ITBL .CNT 0>)>>
	<SETG P-NAM <>>
	<SETG P-ADJ <>>
	<SETG P-XNAM <>>
	<SETG P-XADJ <>>
	<SETG P-DIR-WORD <>>
	<COND (<ZERO? ,P-OFLAG>
	       <PUT ,P-NAMW 0 <>>
	       <PUT ,P-NAMW 1 <>>
	       <PUT ,P-ADJW 0 <>>
	       <PUT ,P-ADJW 1 <>>
	       <PUT ,P-OFW 0 <>>
	       <PUT ,P-OFW 1 <>>)>
	<SET OMERGED ,P-MERGED>
	<SETG P-MERGED <>>
	<SETG P-END-ON-PREP <>>
	<PUT ,P-PRSO ,P-MATCHLEN 0>
	<PUT ,P-PRSI ,P-MATCHLEN 0>
	<PUT ,P-BUTS ,P-MATCHLEN 0>
	<SET OWINNER ,WINNER>
	<COND (<AND <ZERO? ,QUOTE-FLAG>
		    <NOT <EQUAL? ,WINNER ,PLAYER>>>
	       <SETG WINNER ,PLAYER>
	       <SETG HERE <LOC ,WINNER>>
	     ; <COND (T ;<NOT <IS? <LOC ,WINNER> ,VEHBIT>>
		    ; <SETG LAST-PLAYER-LOC ,HERE>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT? <IS-LIT?>>)>
	<COND (<T? ,RESERVE-PTR>
	       <SET PTR ,RESERVE-PTR>
	       <STUFF ,P-LEXV ,RESERVE-LEXV>
	       <INBUF-STUFF ,P-INBUF ,RESERVE-INBUF> ; "FIX #36"
	       <COND (<AND <T? ,VERBOSITY>
			   <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG RESERVE-PTR <>>
	       <SETG P-CONT <>>)
	      (<T? ,P-CONT>
	       <SET PTR ,P-CONT>
	       <SETG P-CONT <>>
	       <COND (<AND <T? ,VERBOSITY>
			   <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>)
	      (T
	       <SETG WINNER ,PLAYER>
	       <SETG QUOTE-FLAG <>>
	       <SETG HERE <LOC ,WINNER>>
	     ; <COND (T ;<NOT <IS? <LOC ,WINNER> ,VEHBIT>>
		      <SETG LAST-PLAYER-LOC ,HERE>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT? <IS-LIT?>>
	       <DISPLAY-PLACE>
	       <COND (<T? ,DO-WINDOW>
		      <WINDOW ,DO-WINDOW>
		      <SETG DO-WINDOW <>>
		      <CRLF>)
		     (<T? ,VERBOSITY>
		      <CRLF>)>
	       <TELL ">">
	       <PUTB ,P-LEXV 0 59>
	       <READ ,P-INBUF ,P-LEXV>
	       <SAVE-INPUT>)>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
      ; <PUT ,P-LEXV <+ 1 <* ,P-LEN ,P-LEXELEN>> 0>
	<COND (<VISIBLE? ,MAGPIE>
	       <SETG INLEN ,P-LEN>)
	      (T
	       <SETG INLEN 0>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?QUOTE> ; "Quote first token?"
	       <SET PTR <+ .PTR ,P-LEXELEN>>	    ; "If so, ignore it."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THEN ,W?PLEASE ,W?SO>
	       <SET PTR <+ .PTR ,P-LEXELEN>> ; "Ignore boring 1st words."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<SET TMP1 <GET ,P-LEXV .PTR>>
	<COND (<AND <L? 1 ,P-LEN>
		    <EQUAL? <GET ,P-LEXV .PTR> ,W?GO> ; "GO first input word?"
		    <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		    <WT? .NW ,PS?VERB ;,P1?VERB>   ;" followed by verb?">
	       <SET PTR <+ .PTR ,P-LEXELEN>>	;"If so, ignore it."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN>
	       <TELL "[What?]" CR>
	       <RFALSE>)
	      (<EQUAL? <GET ,P-LEXV .PTR> ,W?OOPS>
	       <SETG INLEN 0>
	       <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			      ,W?PERIOD ,W?COMMA>
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <SETG P-LEN <- ,P-LEN 1>>)> ; "FIX #38"
	       <COND (<NOT <G? ,P-LEN 1>>
		      <TELL "[" ,CANT "use OOPS that way.]" CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <COND (<G? ,P-LEN 2> ; "FIX #39"
			     <TELL
"[Only the first word after OOPS is used.]" CR>)>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER> ;"Fixes OOPS w/chars"
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
			       <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN> 3>>
		      <STUFF ,P-LEXV ,AGAIN-LEXV>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL
"[There was no word to replace in that sentence.]" CR>
		      <RFALSE>)>)
	      (T
	       <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <SETG INLEN 0>
	       <COND (<OR <T? ,P-OFLAG>
			  <ZERO? ,P-WON>
			  <ZERO? <GETB ,OOPS-INBUF 1>>> ; "FIX #50"
		      <TELL "[" ,CANT "use AGAIN that way.]" CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <DONT-UNDERSTAND>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <STUFF ,RESERVE-LEXV ,P-LEXV>
		      <INBUF-STUFF ,RESERVE-INBUF ,P-INBUF> ; "FIX #36"
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	     ; <SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <SET CNT -1>
	       <SET DIR ,AGAIN-DIR> ; "FIX #44"
	       <REPEAT ()
		       <COND (<IGRTR? CNT ,P-ITBLLEN>
			      <RETURN>)
			     (T
			      <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <SETG P-NUMBER -1> ; "Fixed BM 2/28/86"
	       <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>> ; "FIX #37"
	       <SET LEN ; "FIX #43"
		    <* 2 <+ .PTR <* ,P-LEXELEN <GETB ,P-LEXV ,P-LEXWORDS>>>>>
	       <PUT ,OOPS-TABLE ,O-END <+ <GETB ,P-LEXV <- .LEN 1>>
					  <GETB ,P-LEXV <- .LEN 2>>>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       <SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <PUT ,P-ITBL ,P-VERBN 0>
	       <REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)
		      (<BUZZER-WORD? <SET WRD <GET ,P-LEXV .PTR>>>
		       <RFALSE>)
		      (<OR <T? .WRD>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <EQUAL? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ,ACT?ASK>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			    ; <SET VERB ,ACT?TELL>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?THEN ; ,W?PERIOD>
				 ; <NOT <EQUAL? .NW ,W?THEN ,W?PERIOD>>
				   <G? ,P-LEN 0> ; "FIX #40"
				   <ZERO? .VERB>
				   <ZERO? ,QUOTE-FLAG>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			      <PUT ,P-ITBL ,P-VERBN 0>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?PERIOD>
				   <OR <EQUAL? .LW ,W?DR ,W?MR ,W?MRS>
				       <EQUAL? .LW ,W?J>>>
			      <SETG P-NCN <- ,P-NCN 1>>
			      <CHANGE-LEXV .PTR .LW T>
			      <SET WRD .LW>
			      <SET LW 0>)>  ; "FIX #40"
		       <COND ; (<AND <EQUAL? .WRD ,W?PERIOD>
				     <EQUAL? .LW ,W?DR ,W?MR ,W?MRS>>
				<SET LW 0>)
			     (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE>
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND (<T? ,QUOTE-FLAG>
					    <SETG QUOTE-FLAG <>>)
					   (T
					    <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)
			     (<AND <SET VAL
					<WT? .WRD
					     ,PS?DIRECTION
					     ,P1?DIRECTION>>
				   <EQUAL? .VERB <> ,ACT?WALK ,ACT?GO>
				   <OR <EQUAL? .LEN 1>
				       <AND <EQUAL? .LEN 2>
					    <EQUAL? .VERB ,ACT?WALK ,ACT?GO>>
				       <AND <EQUAL? .NW ,W?THEN ,W?PERIOD
						    	,W?QUOTE>
					    <G? .LEN 1 ;2>>
				     ; <AND <EQUAL? .NW ,W?PERIOD>
					    <G? .LEN 1>>
				       <AND <T? ,QUOTE-FLAG>
					    <EQUAL? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <SETG P-DIR-WORD .WRD>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <CHANGE-LEXV <+ .PTR ,P-LEXELEN>
						  ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <SET VAL <WT? .WRD ,PS?VERB ,P1?VERB>>
				   <ZERO? .VERB>>
			      <SETG P-PRSA-WORD .WRD> ; "For RUN, etc."
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV
						    <SET TMP1
							 <+ <* .PTR 2> 2>>>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .TMP1 1>>>)
			     (<OR <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				  <EQUAL? .WRD ,W?A ,W?EVERYTHING>
				  <EQUAL? .WRD ,W?BOTH ,W?ALL>
				  <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?OBJECT>>
			      <COND (<AND <G? ,P-LEN 1> ; "1 IN RETROFIX #34"
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .VERB
						       ;,ACT?MAKE ,ACT?TAKE>>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD ,W?A>>
					  <NOT <EQUAL? .WRD ,W?ALL ,W?BOTH
							    ,W?EVERYTHING>>>
				   ; <COND (<EQUAL? .WRD ,W?BOTTOM>
					    <SET BOTTOM T>)>
				     <PUT ,P-OFW ,P-NCN .WRD> ; "Save OF-word"
				     <SET OF-FLAG T>)
				    (<AND <T? .VAL>
					  <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<EQUAL? ,P-NCN 2>
				     <TELL
"[There are too many nouns in that sentence.]" CR>
				     <RFALSE>)
				    (T
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <OR <SET PTR <CLAUSE .PTR .VAL .WRD>>
					 <RFALSE>>
				     <COND (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)

			     (<EQUAL? .WRD ,W?OF> ; "RETROFIX #34"
			      <COND (<OR <ZERO? .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <WT? .WRD ,PS?VERB ;,P1?VERB>>
			      <WAY-TO-TALK>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (<T? .DIR>
	       <SETG PRSA ,V?WALK>
	       <SETG P-WALK-DIR .DIR>
	       <SETG AGAIN-DIR .DIR> ; "FIX #44"
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <RTRUE>)>
	<SETG P-WALK-DIR <>>
	<SETG AGAIN-DIR <>> ; "FIX #44"
	<COND (<AND <T? ,P-OFLAG>
		    <ORPHAN-MERGE>>
	       <SETG WINNER .OWINNER>)
	    ; (T
	       <SETG BOTTOM? .BOTTOM>)>
      ; <COND (<ZERO? <GET ,P-ITBL ,P-VERB>>
	       <PUT ,P-ITBL ,P-VERB ,ACT?TELL>)> ; "Why was this here?"
	<COND (<AND <SYNTAX-CHECK>
		    <SNARF-OBJECTS>
		    <MANY-CHECK>
		  ; <TAKE-CHECK>
		    <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
		    <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>
	       <RTRUE>)>>

<ROUTINE CHANGE-LEXV (PTR WRD "OPTIONAL" (PTRS? <>) "AUX" X Y Z)
	 <COND (<T? .PTRS?>
		<SET X <+ 2 <* 2 <- .PTR ,P-LEXELEN>>>>
		<SET Y <GETB ,P-LEXV .X>>
		<SET Z <+ 2 <* 2 .PTR>>>
		<PUTB ,P-LEXV .Z .Y>
		<PUTB ,AGAIN-LEXV .Z .Y>
		<SET Y <GETB ,P-LEXV <+ 1 .X>>>
		<SET Z <+ 3 <* 2 .PTR>>>
		<PUTB ,P-LEXV .Z .Y>
		<PUTB ,AGAIN-LEXV .Z .Y>)>
	 <PUT ,P-LEXV .PTR .WRD>
	 <PUT ,AGAIN-LEXV .PTR .WRD>
	 <RTRUE>>

<OBJECT HELLO-OBJECT
	(LOC GLOBAL-OBJECTS)
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM HELLO GOODBYE HI BYE)
	(ACTION WAY-TO-TALK)>

<ROUTINE WAY-TO-TALK ("OPTIONAL" (Q? <>))
	 <PCLEAR>
	 <TELL "[Refer to your ">
	 <ITALICIZE "Trinity">
	 <TELL " manual for the correct way to address characters.]" CR>
	 <RFATAL>>

"Check whether word pointed at by PTR is the correct part of speech.
   The second argument is the part of speech (,PS?<part of speech>).  The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."

<ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)
	<COND (<BTST <SET TYP <GETB .PTR ,P-PSOFF>> .BIT>
	       <COND (<G? .B1 4>
		      <RTRUE>)
		     (T
		      <SET TYP <BAND .TYP ,P-P1BITS>>
		      <COND (<NOT <EQUAL? .TYP .B1>>
			     <SET OFFS <+ .OFFS 1>>)>
		      <GETB .PTR .OFFS>)>)>>

"Scan through a noun phrase, leaving a pointer to its starting location:"

<ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0))
	<SET OFF <* <- ,P-NCN 1> 2>>
	<COND (<T? .VAL>
	       <PUT ,P-ITBL <SET NUM <+ ,P-PREP1 .OFF>> .VAL>
	       <PUT ,P-ITBL <+ .NUM 1> .WRD>
	       <SET PTR <+ .PTR ,P-LEXELEN>>)
	      (T
	       <SETG P-LEN <+ ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN>
	       <SETG P-NCN <- ,P-NCN 1>>
	       <RETURN -1>)>
	<PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
	       <PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>)>
	<REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
		       <RETURN -1>)>
		<COND (<BUZZER-WORD? <SET WRD <GET ,P-LEXV .PTR>>>
		       <RFALSE>)
		      (<OR <T? .WRD>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN>
			      <SET NW 0>)
			     (T
			      <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		     ; <COND (<AND <EQUAL? .WRD ,W?OF>
				   <EQUAL? <GET ,P-ITBL ,P-VERB>
					   ,ACT?MAKE ,ACT?TAKE>>
			      <CHANGE-LEXV .PTR ,W?WITH>
			      <SET WRD ,W?WITH>)>
		       <COND (<AND <EQUAL? .WRD ,W?PERIOD>
				   <OR <EQUAL? .LW ,W?MR ,W?MRS ,W?MISS>
				       <EQUAL? .LW ,W?J>>>
			      <SET LW 0>)
			     (<EQUAL? .WRD ,W?AND ,W?COMMA>
			      <SET ANDFLG T>)
			     (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			    ; <OR <EQUAL? .WRD ,W?ALL ,W?BOTH ,W?ONE>
				  <EQUAL? .WRD ,W?EVERYTHING>>
			      <COND (<EQUAL? .NW ,W?OF>
				     <SETG P-LEN <- ,P-LEN 1>>
				     <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			     (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				  <AND <WT? .WRD ,PS?PREPOSITION>
				       <GET ,P-ITBL ,P-VERB>
				       <NOT .FIRST??>>>
			      <SETG P-LEN <+ ,P-LEN 1>>
			      <PUT ,P-ITBL
				   <+ .NUM 1>
				   <REST ,P-LEXV <* .PTR 2>>>
			      <RETURN <- .PTR ,P-LEXELEN>>)
			     ;"3/16/83: This clause used to be later."
			     (<AND <T? .ANDFLG>
				   <OR ;"3/25/83: next statement added."
				       <ZERO? <GET ,P-ITBL ,P-VERBN>>
				       ;"10/26/84: next stmt changed"
				       <VERB-DIR-ONLY? .WRD>>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?OBJECT>
			      <COND (<AND <G? ,P-LEN 0>
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .WRD ,W?ALL ; ,W?ONE
							    ,W?EVERYTHING>>>
				     <PUT ,P-OFW <- ,P-NCN 1> .WRD>)
				    (<AND <WT? .WRD ,PS?ADJECTIVE
					       ;,P1?ADJECTIVE>
					  <T? .NW>
					  <WT? .NW ,PS?OBJECT>>
				     T)
				    (<AND <ZERO? .ANDFLG>
					  <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
					  <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				     <PUT ,P-ITBL
					  <+ .NUM 1>
					  <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				     <RETURN .PTR>)
				    (T
				     <SET ANDFLG <>>)>)

       ; "Next clause replaced by following one to enable OLD WOMAN, HELLO"

			   ; (<AND <OR <T? ,P-MERGED>
				       <T? ,P-OFLAG>
				       <T? <GET ,P-ITBL ,P-VERB>>>
				   <OR <WT? .WRD ,PS?ADJECTIVE>
				       <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<OR <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?BUZZ-WORD>>
			      T)
			     (<AND <T? .ANDFLG>
				   <ZERO? <GET ,P-ITBL ,P-VERB>>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?PREPOSITION>
			      T)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET FIRST?? <>>
		<SET PTR <+ .PTR ,P-LEXELEN>>>>

<ROUTINE SPOKEN-TO (WHO)
	 <COND (<OR <NOT <EQUAL? .WHO ,QCONTEXT>>
		    <NOT <EQUAL? ,HERE ,QCONTEXT-ROOM>>>
		<SETG QCONTEXT .WHO>
		<SETG QCONTEXT-ROOM <LOC .WHO>>
		<THIS-IS-IT .WHO>
		<TELL "[spoken to " THE .WHO ,BRACKET>)>
	 <RTRUE>>

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<OR <EQUAL? .OBJ <> ,PLAYER ,NOT-HERE-OBJECT>
		    <EQUAL? .OBJ ,INTDIR ,INTNUM ,RIGHT>
		    <EQUAL? .OBJ ,LEFT>>
		<RTRUE>)
	       (<AND <VERB? WALK WALK-TO>
		     <EQUAL? .OBJ ,PRSO>>
		<RTRUE>)
	       (<EQUAL? .OBJ ,BWOMAN ,JWOMAN ,GIRL>
		<SETG P-HER-OBJECT .OBJ>
		<RTRUE>)
	       (<OR <EQUAL? .OBJ ,GIANT ,GOON ,CHARON>
		    <EQUAL? .OBJ ,BOY ,PHOTO>>
		<SETG P-HIM-OBJECT .OBJ>
		<RTRUE>)
	       (<IS? .OBJ ,PLURAL>
		<SETG P-THEM-OBJECT .OBJ>
		<RTRUE>)
	       (T
		<SETG P-IT-OBJECT .OBJ>
		<RTRUE>)>>

<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <BE-SPECIFIC>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<ZERO? .TMP>
		<TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <TELL "?]" CR>
	 <RTRUE>>

<GLOBAL NOW-PRSI?:FLAG <>>

<CONSTANT NSVERBS 20> "Number of SEEVERBS"

<GLOBAL SEEVERBS:TABLE
	<PTABLE V?EXAMINE V?LOOK V?LOOK-INSIDE V?LOOK-ON V?READ V?FIND
		V?SEARCH V?SHOW V?LOOK-UNDER V?LOOK-BEHIND V?LOOK-THRU
		V?LOOK-DOWN V?LOOK-UP V?READ-TO V?LOOK-OUTSIDE V?COUNT
		V?WATCH	V?FOCUS-ON V?ADJUST V?POINT>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>)
		    "AUX" (V <>) OA OO OI ONP (WHO <>) (TUCH <>))
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT>)
	<COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
		    <NOT <IS? ,WINNER ,PERSON>>>
	       <NOT-LIKELY ,WINNER "would respond">
	       <PCLEAR>
	       <RFATAL>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SET ONP ,NOW-PRSI?>
	<SET WHO <ANYONE-HERE?>>
	<SETG PRSA .A>
	<COND (<AND <ZERO? ,LIT?>
		    <INTBL? .A ,SEEVERBS ,NSVERBS>>
	       <TOO-DARK>
	       <RFATAL>)
	      (<NOT <EQUAL? .A ,V?WALK>>
	       <COND (<AND <EQUAL? ,WINNER ,PLAYER>
			   <VERB? WHO WHAT WHERE>>
		      <COND (<ZERO? .WHO>
			     <NOBODY-TO-ASK>
			     <RFATAL>)
			    (T
			     <SETG WINNER .WHO>
			     <SPOKEN-TO .WHO>)>)
		     (<AND <EQUAL? ,WINNER ,PLAYER>
			   <EQUAL? .O ,ME>
			   <VERB? TELL TELL-ABOUT ASK-ABOUT ASK-FOR
				  QUESTION REPLY THANK YELL HELLO GOODBYE
				  SAY ALARM>>
		      <COND (<ZERO? .WHO>
			     <TALK-TO-SELF>
			     <RFATAL>)
			    (T
			     <SETG WINNER .WHO>
			     <SPOKEN-TO .WHO>)>)>
	       <COND (<EQUAL? ,YOU .I .O>
		      <COND (<EQUAL? ,WINNER ,PLAYER>
			     <COND (<ZERO? .WHO>
				    <TALK-TO-SELF>
				    <RFATAL>)
				   (T
				    <SETG WINNER .WHO>
				    <SPOKEN-TO .WHO>)>)
			    (T
			     <SETG QCONTEXT ,WINNER>
			     <SETG QCONTEXT-ROOM <LOC ,WINNER>>
			     <SET WHO ,WINNER>)>
		      <COND (<EQUAL? .I ,YOU>
			     <SET I .WHO>)>
		      <COND (<EQUAL? .O ,YOU>
			     <SET O .WHO>)>)>
	       <COND (<AND <EQUAL? ,IT .I .O>
			   <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
		      <COND (<ZERO? .I>
			     <FAKE-ORPHAN>)
			    (T
			     <CANT-SEE-ANY ,P-IT-OBJECT>)>
		      <RFATAL>)>
	       <COND (<EQUAL? ,THEM .I .O>
		      <COND (<VISIBLE? ,P-THEM-OBJECT>
			     <COND (<EQUAL? ,THEM .O>
				    <SET O ,P-THEM-OBJECT>)>
			     <COND (<EQUAL? ,THEM .I>
				    <SET I ,P-THEM-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T
				    <CANT-SEE-ANY ,P-THEM-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HER .I .O>
		      <COND (<VISIBLE? ,P-HER-OBJECT>
			     <COND (<AND <EQUAL? ,P-HER-OBJECT ,WINNER>
					 <NO-OTHER? T>>
				    <RFATAL>)>
			     <COND (<EQUAL? ,HER .O>
				    <SET O ,P-HER-OBJECT>)>
			     <COND (<EQUAL? ,HER .I>
				    <SET I ,P-HER-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T
				    <CANT-SEE-ANY ,P-HER-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HIM .I .O>
		      <COND (<VISIBLE? ,P-HIM-OBJECT>
			     <COND (<AND <EQUAL? ,P-HIM-OBJECT ,WINNER>
					 <NO-OTHER?>>
				    <RFATAL>)>
			     <COND (<EQUAL? ,HIM .O>
				    <SET O ,P-HIM-OBJECT>)>
			     <COND (<EQUAL? ,HIM .I>
				    <SET I ,P-HIM-OBJECT>)>)
			    (T
			     <COND (<ZERO? .I>
				    <FAKE-ORPHAN>)
				   (T
				    <CANT-SEE-ANY ,P-HIM-OBJECT>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? .O ,IT>
		      <SET O ,P-IT-OBJECT>)>
	       <COND (<EQUAL? .I ,IT>
		      <SET I ,P-IT-OBJECT>)>)>

	<SETG PRSI .I>
	<SETG PRSO .O>

	<SET V <>>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>>
	       <SET V <APPLY ,NOT-HERE-OBJECT-F>>
	       <COND (<T? .V>
		      <SETG P-WON <>>)>)>
      ; <THIS-IS-IT ,PRSI>
	<THIS-IS-IT ,PRSO>
	<SET O ,PRSO>
	<SET I ,PRSI>

      ; <COND (<T? ,DEBUG?>
	       <TELL "[PRSO = ">
	       <SAY-IT .O>
	       <TELL ", PRSI = ">
	       <SAY-IT .I>
	     ; <TELL ", WINNER = ">
	     ; <SAY-IT ,WINNER>
	     ; <TELL "]|
[DIR-WORD = ">
	     ; <SAY-WORD ,P-DIR-WORD>
	       <TELL ", A-WORD = ">
	       <SAY-WORD ,P-PRSA-WORD>
	       <TELL ", O-NOUN = ">
	       <SAY-WORD <GET ,P-NAMW 0>>
	     ; <TELL ", O-ADJ = ">
	     ; <SAY-WORD <GET ,P-ADJW 0>>
	       <TELL ", I-NOUN = ">
	       <SAY-WORD <GET ,P-NAMW 1>>
	     ; <TELL ", I-ADJ = ">
	     ; <SAY-WORD <GET ,P-ADJW 1>>
	       <TELL ", P-MULT? = ">
	       <COND (<ZERO? ,P-MULT?> <TELL "<>">) (T <TELL "T">)>
	       <TELL "]" CR>)>

	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP ,WINNER ,P?ACTION> ,M-WINNER>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,PREACTIONS .A>>>)>

	<COND (<OR <INTBL? .A ,TOUCHVERBS ,NTOUCHES>
		   <INTBL? .A ,HURTVERBS ,NHVERBS>>
	       <SET TUCH T>)>

	<COND (<AND <ZERO? .V>
		    <T? ,IN-PRAM?>
		    <EQUAL? ,WINNER ,PLAYER>
		    <OR <AND <VERB? WALK>
			     <NOT <EQUAL? ,P-WALK-DIR ,P?OUT ,P?IN>>>
			<AND <NOT <EQUAL? .O <> ,PRAM ,POCKET>>
			     <LOC .O>
			     <NOT <IN? .O ,GLOBAL-OBJECTS>>
			     <ZERO? ,P-WALK-DIR>
			     <T? .TUCH>
			     <NOT <GOT? .O>>
			     <NOT <IN? .O ,PRAM>>
			     <NOT <IN? <LOC .O> ,PRAM>>>
			<AND <NOT <EQUAL? .I <> ,PRAM ,POCKET>>
			     <LOC .I>
			     <NOT <IN? .I ,GLOBAL-OBJECTS>>
			     <T? .TUCH>
			     <NOT <GOT? .I>>
			     <NOT <IN? .I ,PRAM>>
			     <NOT <IN? <LOC .I> ,PRAM>>>>>
		<CANT-WHILE-IN-PRAM>
		<SET V T>)>

	<COND (<AND <ZERO? .V>
		    <T? ,IN-DISH?>
		    <EQUAL? ,WINNER ,PLAYER>
		    <OR <AND <VERB? WALK>
			     <NOT <EQUAL? ,P-WALK-DIR ,P?OUT ,P?IN>>>
			<AND <NOT <EQUAL? .O <> ,DISH ,POCKET>>
			     <LOC .O>
			     <NOT <IN? .O ,GLOBAL-OBJECTS>>
			     <ZERO? ,P-WALK-DIR>
			     <T? .TUCH>
			     <NOT <GOT? .O>>
			     <NOT <IN? .O ,DISH>>>
			<AND <NOT <EQUAL? .I <> ,DISH ,POCKET>>
			     <LOC .I>
			     <NOT <IN? .I ,GLOBAL-OBJECTS>>
			     <T? .TUCH>
			     <NOT <GOT? .I>>
			     <NOT <IN? .I ,DISH>>>>>
	       <EXIT-DISH-FIRST>
	       <SET V T>)>

	<COND (<AND <ZERO? .V>
		    <T? ,SUITED?>
		    <EQUAL? ,WINNER ,PLAYER>
		    <OR <AND <T? .O>
			     <NOT <EQUAL? .O ,FILM ,LUMP ,POCKET>>
			     <LOC .O>
			     <NOT <IN? .O ,GLOBAL-OBJECTS>>
			     <ZERO? ,P-WALK-DIR>
			     <NOT <IN? .O ,LUMP>>
			     <T? .TUCH>
			     <NOT <GOT? .O>>>
			<AND <T? .I>
			     <NOT <EQUAL? .I ,FILM ,LUMP ,POCKET>>
			     <LOC .I>
			     <NOT <IN? .I ,GLOBAL-OBJECTS>>
			     <NOT <IN? .I ,LUMP>>
			     <OR <T? .TUCH>
				 <EQUAL? .A ,V?THROW ,V?THROW-OVER>>
			     <NOT <GOT? .I>>>>>
	       <CANT-REACH-THRU-FILM>
	       <SET V T>)>

	<COND (<AND <ZERO? .V>
		    <T? ,IN-DORY?>
		    <EQUAL? ,WINNER ,PLAYER>
		    <OR <AND <VERB? WALK>
			     <NOT <EQUAL? ,P-WALK-DIR ,P?OUT ,P?IN>>>
			<AND <NOT <EQUAL? .O <> ,DORY ,POCKET>>
			     <LOC .O>
			     <NOT <IN? .O ,GLOBAL-OBJECTS>>
			     <ZERO? ,P-WALK-DIR>
			     <T? .TUCH>
			     <NOT <GOT? .O>>
			     <NOT <IN? .O ,DORY>>
			     <NOT <IN? <LOC .O> ,DORY>>>
			<AND <NOT <EQUAL? .I <> ,DORY ,POCKET>>
			     <LOC .I>
			     <NOT <IN? .I ,GLOBAL-OBJECTS>>
			     <T? .TUCH>
			     <NOT <GOT? .I>>
			     <NOT <IN? .I ,DORY>>
			     <NOT <IN? <LOC .I> ,DORY>>>>>
		<TELL "You couldn't do that while you're in the dory." CR>
		<SET V T>)>

	<COND (<NOT <EQUAL? .A ,V?TELL-ABOUT ,V?ASK-ABOUT ,V?ASK-FOR>>
	       <SETG NOW-PRSI? T>
	       <COND (<AND <ZERO? .V>
		    	   <T? .I>
		    	   <NOT <EQUAL? .A ,V?WALK>>
		    	   <LOC .I>>
	       	      <SET V <GETP <LOC .I> ,P?CONTFCN>>
	       	      <COND (<T? .V>
		      	     <SET V <APPLY .V ,M-CONT>>)>)>
	       <SETG NOW-PRSI? <>>
	       <COND (<AND <ZERO? .V>
			   <T? .O>
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>>
		      <SET V <GETP <LOC .O> ,P?CONTFCN>>
		      <COND (<T? .V>
			     <SET V <APPLY .V ,M-CONT>>)>)>
	       <SETG NOW-PRSI? T>
	       <COND (<AND <ZERO? .V>
		    	   <T? .I>>
	       	      <SET V <APPLY <GETP .I ,P?ACTION>>>)>)>
	<SETG NOW-PRSI? <>>

      ; <COND (<AND <ZERO? .V>
		    <T? .O>
		    <NOT <EQUAL? .A ,V?WALK>>
		    <LOC .O>>
	       <SET V <GETP <LOC .O> ,P?CONTFCN>>
	       <COND (<T? .V>
		      <SET V <APPLY .V ,M-CONT>>)>)>
	<COND (<AND <ZERO? .V>
		    <T? .O>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <SET V <APPLY <GETP .O ,P?ACTION>>>
	     ; <COND (<T? .V>
		      <THIS-IS-IT .O>)>)>

	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,ACTIONS .A>>>)>

	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	<SETG NOW-PRSI? .ONP>
	<RETURN .V>>

<ROUTINE NO-OTHER? ("OPTIONAL" (FEMALE? <>) "AUX" OBJ)
	 <SET OBJ <FIRST? ,HERE>>
	 <REPEAT ()
		 <COND (<T? .OBJ>
			<COND (<AND <NOT <EQUAL? .OBJ ,WINNER>>
				    <IS? .OBJ ,PERSON>>
			       <COND (<T? .FEMALE?>
				      <COND (<IS? .OBJ ,FEMALE>
					     <RETURN>)>)
				     (<NOT <IS? .OBJ ,FEMALE>>
				      <RETURN>)>)>
			<SET OBJ <NEXT? .OBJ>>)
		       (T
			<RETURN>)>>
	 <COND (<ZERO? .OBJ>
		<LOOKS-PUZZLED ,WINNER>
		<TELL "To whom are you referring?\"" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOBODY-TO-ASK ()
	 <PCLEAR>
	 <TELL "[There's nobody here to ask.]" CR>
	 <RTRUE>>

<ROUTINE CANT-REACH-THRU-FILM ()
	 <TELL ,CANT "reach through the " D ,FILM ,PERIOD>
	 <RTRUE>>

<ROUTINE TALK-TO-SELF ()
	 <PCLEAR>
	 <TELL "[You must address characters directly.]" CR>
	 <RTRUE>>

<GLOBAL BUZZTABLE:TABLE
	<PTABLE
	 <PLTABLE <VOC "WHY" <>> <VOC "HOW" <>> <VOC "HOW\'S" <>>
		  <VOC "WHEN" <>> <VOC "WHEN\'S" <>> <VOC "WOULD" <>>
		  <VOC "COULD" <>> <VOC "SHOULD" <>>>
	 <PLTABLE <VOC "THAT\'S" <>> <VOC "IT\'S" <>> <VOC "I\'M" <>>
		  <VOC "DID" <>> <VOC "THEY\'RE" <>> <VOC "SHALL" <>>
		  <VOC "DO" <>> <VOC "HAVE" <>> <VOC "ANY" <>>
		  <VOC "I\'LL" <>> <VOC "WHICH" <>> <VOC "WE\'RE" <>>
		  <VOC "I\'VE" <>> <VOC "WON\'T" <>> <VOC "HAS" <>>
		  <VOC "YOU\'RE" <>> <VOC "HE\'S" <>> <VOC "SHE\'S" <>>
		  <VOC "WILL" <>> <VOC "WERE" <>>>
	 <PLTABLE <VOC "ZERO" <>> <VOC "EIGHT" <>> <VOC "NINE" <>>
		  <VOC "TEN" <>> <VOC "ELEVEN" <>> <VOC "TWELVE" <>>
		  <VOC "THIRTEEN" <>> <VOC "FOURTEEN" <>> <VOC "FIFTEEN" <>>
		  <VOC "SIXTEEN" <>> <VOC "SEVENTEEN" <>> <VOC "EIGHTEEN" <>>
		  <VOC "NINETEEN" <>> ; <VOC "TWENTY" <>> ; <VOC "THIRTY" <>>
		  <VOC "FORTY" <>> ; <VOC "FIFTY" <>> <VOC "SIXTY" <>>
		  <VOC "SEVENTY" <>> <VOC "EIGHTY" <>> <VOC "NINETY" <>>
		  <VOC "HUNDRED" <>> <VOC "THOUSAND" <>> <VOC "MILLION" <>>
		  <VOC "BILLION" <>>>
	 <PLTABLE <VOC "CURSE" <>> <VOC "GODDAMNED" <>> <VOC "CUSS" <>>
		  <VOC "DAMN" <>> <VOC "SHIT" <>> <VOC "FUCK" <>>
		  <VOC "SHITHEAD" <>> <VOC "BASTARD" <>> <VOC "ASS" <>>
		  <VOC "FUCKING" <>> <VOC "BITCH" <>> <VOC "DAMNED" <>>
		  <VOC "COCKSUCKER" <>> <VOC "FUCKED" <>>
		  <VOC "CUNT" <>> <VOC "ASSHOLE" <>>>
	 <PLTABLE <VOC "ZORK" <>> <VOC "XYZZY" <>> <VOC "GRUE" <>>
		  <VOC "PLUGH" <>> <VOC "OZMOO" <>> <VOC "GNUSTO" <>>
		  <VOC "SAILOR" <>> <VOC "GRUES" <>> <VOC "WISHBRINGER" <>>
		  <VOC "MAGICK" <>> <VOC "QUENDOR" <>>>
	 <PLTABLE <VOC "QUIETLY" <>> <VOC "SILENTLY" <>> <VOC "PRIVATELY" <>>
		  <VOC "CAREFULLY" <>> <VOC "SLOWLY" <>> <VOC "CLOSELY" <>>
		  <VOC "CAUTIOUSLY" <>> <VOC "WARILY" <>> <VOC "GENTLY" <>>
		  <VOC "QUICKLY" <>> <VOC "RAPIDLY" <>> <VOC "SWIFTLY" <>>
		  <VOC "SUDDENLY" <>> <VOC "BRIEFLY" <>> <VOC "HASTILY" <>>
		  <VOC "HURRIEDLY" <>> <VOC "RECKLESSLY" <>>
		  <VOC "CARELESSLY" <>>>>>

<ROUTINE BUZZER-WORD? (WORD "AUX" TBL)
	 <SET TBL <GET ,BUZZTABLE 0>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<TO-DO-THING-USE "ask about" "ASK CHARACTER ABOUT">
		<RTRUE>)>
	 <SET TBL <GET ,BUZZTABLE 1>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<WAY-TO-TALK T>
		<RTRUE>)>
	 <SET TBL <GET ,BUZZTABLE 2>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<TELL "[" ,DONT "need to use that " D ,INTNUM>
		<TO-COMPLETE>
		<RTRUE>)>
	 <SET TBL <GET ,BUZZTABLE 3>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<CRUDITY>
		<RTRUE>)>
	 <SET TBL <GET ,BUZZTABLE 4>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<V-WISH>
		<RTRUE>)>
	 <SET TBL <GET ,BUZZTABLE 5>>
	 <COND (<INTBL? .WORD <REST .TBL 2> <GET .TBL 0>>
		<TELL "[Adverbs (such as \"">
		<PRINTB .WORD>
		<TELL "\") aren't needed">
		<TO-COMPLETE>
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE VERB-DIR-ONLY? (WRD)
	 <COND (<AND <NOT <WT? .WRD ,PS?OBJECT>>
		     <NOT <WT? .WRD ,PS?ADJECTIVE>>
		     <OR <WT? .WRD ,PS?DIRECTION>
			 <WT? .WRD ,PS?VERB>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<BUZZ AGAIN G OOPS>

"For AGAIN purposes, put contents of one LEXV table into another."

<ROUTINE STUFF (DEST SRC "OPTIONAL" (MAX 29)
			 "AUX" (PTR ,P-LEXSTART) (CTR 1) BPTR)
	 <PUTB .DEST 0 <GETB .SRC 0>>
	 <PUTB .DEST 1 <GETB .SRC 1>>
	 <REPEAT ()
		 <PUT .DEST .PTR <GET .SRC .PTR>>
		 <SET BPTR <+ <* .PTR 2> 2>>
		 <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
		 <SET BPTR <+ <* .PTR 2> 3>>
		 <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
		 <SET PTR <+ .PTR ,P-LEXELEN>>
		 <COND (<IGRTR? CTR .MAX>
			<RETURN>)>>>

"Put contents of one INBUF into another."

<ROUTINE INBUF-STUFF (DEST SRC "AUX" CNT)
	 <SET CNT <- <GETB .SRC 0> 1>>
	 <REPEAT ()
		 <PUTB .DEST .CNT <GETB .SRC .CNT>>
		 <COND (<DLESS? CNT 0>
			<RTRUE>)>>>

"Put the word in the positions specified from P-INBUF to the end of
OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV."

<ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)
	 <SET TMP <GET ,OOPS-TABLE ,O-END>>
	 <COND (<T? .TMP>
		<SET DBEG .TMP>)
	       (T
		<SET DBEG <+ <GETB ,AGAIN-LEXV
				   <SET TMP <GET ,OOPS-TABLE ,O-LENGTH>>>
			     <GETB ,AGAIN-LEXV <+ .TMP 1>>>>)>
	 <PUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <REPEAT ()
		 <PUTB ,OOPS-INBUF <+ .DBEG .CTR>
				   <GETB ,P-INBUF <+ .BEG .CTR>>>
		 <INC CTR>
		 <COND (<EQUAL? .CTR .LEN>
			<RETURN>)>>
	 <PUTB ,AGAIN-LEXV .SLOT .DBEG>
	 <PUTB ,AGAIN-LEXV <- .SLOT 1> .LEN>
	 <RTRUE>>

<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>) (DOLLAR <>))
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<EQUAL? .CHR %<ASCII !\:>>
			       <SET TIM .SUM>
			       <SET SUM 0>)
			      (<G? .SUM 9999>
			       <RFALSE>)
			      (<EQUAL? .CHR ,CURRENCY-SYMBOL>
			       <SET DOLLAR T>)
			      (<OR <G? .CHR %<ASCII !\9>>
				   <L? .CHR %<ASCII !\0>>>
			       <RFALSE>)
			      (T
			       <SET SUM <+ <* .SUM 10>
					   <- .CHR %<ASCII !\0>>>>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <CHANGE-LEXV .PTR ,W?INTNUM>
	 <COND (<G? .SUM 9999>
		<RFALSE>)
	       (<T? .TIM>
		<COND (<G? .TIM 23>
		       <RFALSE>)>
		<SET SUM <+ .SUM <* .TIM 60>>>)>
	 <SETG P-DOLLAR-FLAG .DOLLAR>
	 <COND (<AND <T? .DOLLAR>
		     <G? .SUM 0>>
		<SETG P-AMOUNT .SUM>
		,W?MONEY)
	       (T
		<SETG P-NUMBER .SUM>
		<SETG P-DOLLAR-FLAG <>>
		,W?INTNUM)>>

<GLOBAL P-NUMBER:NUMBER -1>
<GLOBAL P-AMOUNT:NUMBER 0>
<GLOBAL P-DOLLAR-FLAG:FLAG <>>
<CONSTANT CURRENCY-SYMBOL %<ASCII !\$>>

<GLOBAL P-DIRECTION 0>

<ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD)
   <SETG P-OFLAG <>>
   <COND (<OR <EQUAL? <WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   ,PS?VERB ,P1?VERB>
		      <GET ,P-OTBL ,P-VERB>>
	      <WT? .WRD ,PS?ADJECTIVE>>
	  <SET ADJ T>) ; "FIX #45"
	 (<WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
	       ,PS?ADJECTIVE ;,P1?ADJECTIVE>
	  <SET ADJ T>)
	 (<AND <WT? .WRD ,PS?OBJECT ;,P1?OBJECT>
	       <ZERO? ,P-NCN>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <T? <SET VERB <GET ,P-ITBL ,P-VERB>>>
	       <ZERO? .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2>
	  <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP1>>
		     <ZERO? .TEMP>>
		 <COND (<T? .ADJ>
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>> ;"? DELETE?"
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> ;"? DELETE?"
			       <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>
			;<PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T
		 <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP2>>
		     <ZERO? .TEMP>>
		 <COND (<T? .ADJ>
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>> ;"? DELETE?"
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T
		 <RFALSE>)>)
	 (<T? ,P-ACLAUSE>
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (<T? .ADJ>
			<SET BEG <REST ,P-LEXV 2>>
			<SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (<T? .ADJ>
				       <ACLAUSE-WIN .ADJ>
				       <RETURN>)
				      (T
				       <SETG P-ACLAUSE <>> <RFALSE>)>)
			       (<AND <ZERO? .ADJ>
				     <OR <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE> ;"same as WT?"
					 <EQUAL? .WRD ,W?ALL ; ,W?ONE
						 ,W?EVERYTHING>>>
				<SET ADJ .WRD>)
			     ; (<EQUAL? .WRD ,W?ONE>
				<ACLAUSE-WIN .ADJ>
				<RETURN>)
			       (<BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <ACLAUSE-WIN .ADJ>)
				      (T
				       <NCLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<ZERO? .END>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   ;<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
   <REPEAT ()
	   <COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)
		 (T
		  <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>
   T>

<ROUTINE ACLAUSE-WIN (ADJ "AUX" X)
	<PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>
	<SET X <+ ,P-ACLAUSE 1>>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL ,P-ACLAUSE .X ,P-ACLAUSE .X .ADJ>
	<AND <T? <GET ,P-OTBL ,P-NC2>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

<ROUTINE NCLAUSE-WIN ()
	<CLAUSE-COPY ,P-ITBL ,P-OTBL ,P-NC1 ,P-NC1L
		     ,P-ACLAUSE <+ ,P-ACLAUSE 1>>
	<AND <T? <GET ,P-OTBL ,P-NC2>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

"Print undefined word in input. PTR points to the unknown word in P-LEXV"

<ROUTINE WORD-PRINT (CNT BUF)
	 ;<COND (<G? .CNT 6> <SET CNT 6>)>
	 <REPEAT ()
		 <COND (<DLESS? CNT 0>
			<RTRUE>)
		       (T
			<PRINTC <GETB ,P-INBUF .BUF>>
			<SET BUF <+ .BUF 1>>)>>>

<GLOBAL UNKNOWN-MSGS:TABLE
	<LTABLE 2
  <PTABLE "The word \""
	 "\" isn't in the vocabulary that you can use.">
  <PTABLE "You don't need to use the word \""
	 "\" to complete this story.">
  <PTABLE "This story doesn't recognize the word \""
	 ".\"">>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" BUF MSG)
	<PUT ,OOPS-TABLE ,O-PTR .PTR>
	<SET MSG <PICK-NEXT ,UNKNOWN-MSGS>>
	<TELL "[" <GET .MSG 0>>
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<SETG INLEN 0>
	<TELL <GET .MSG 1> "]" CR>
	<RTRUE>>

" Perform syntax matching operations, using P-ITBL as the source of
   the verb and adjectives for this input.  Returns false if no
   syntax matches, and does it's own orphaning.  If return is true,
   the syntax is saved in P-SYNTAX."

<GLOBAL P-SLOCBITS 0>

<CONSTANT P-SYNLEN 8>

<CONSTANT P-SBITS 0>

<CONSTANT P-SPREP1 1>

<CONSTANT P-SPREP2 2>

<CONSTANT P-SFWIM1 3>

<CONSTANT P-SFWIM2 4>

<CONSTANT P-SLOC1 5>

<CONSTANT P-SLOC2 6>

<CONSTANT P-SACTION 7>

<CONSTANT P-SONUMS 3>

<ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ (DRIVE1 <>) (DRIVE2 <>)
			     PREP VERB)
	<SET VERB <GET ,P-ITBL ,P-VERB>>
	<COND (<ZERO? .VERB>
	       <NOT-IN-SENTENCE "any verbs">
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
		<SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
		<COND (<G? ,P-NCN .NUM>
		       T) ;"Added 4/27/83"
		      (<AND <NOT <L? .NUM 1>>
			    <ZERO? ,P-NCN>
			    <OR <ZERO? <SET PREP <GET ,P-ITBL ,P-PREP1>>>
				<EQUAL? .PREP <GETB .SYN ,P-SPREP1>>>>
		       <SET DRIVE1 .SYN>)
		      (<EQUAL? <GETB .SYN ,P-SPREP1> <GET ,P-ITBL ,P-PREP1>>
		       <COND (<AND <EQUAL? .NUM 2>
				   <EQUAL? ,P-NCN 1>>
			      <SET DRIVE2 .SYN>)
			     (<EQUAL? <GETB .SYN ,P-SPREP2>
				      <GET ,P-ITBL ,P-PREP2>>
			      <SYNTAX-FOUND .SYN>
			      <RTRUE>)>)>
		<COND (<DLESS? LEN 1>
		       <COND (<OR <T? .DRIVE1>
				  <T? .DRIVE2>>
			      <RETURN>)
			     (T
			      <DONT-UNDERSTAND>
			      <RFALSE>)>)
		      (T
		       <SET SYN <REST .SYN ,P-SYNLEN>>)>>
	<COND (<AND <T? .DRIVE1>
		    <SET OBJ
			 <GWIM <GETB .DRIVE1 ,P-SFWIM1>
			       <GETB .DRIVE1 ,P-SLOC1>
			       <GETB .DRIVE1 ,P-SPREP1>>>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE1>)
	      (<AND <T? .DRIVE2>
		    <SET OBJ
			 <GWIM <GETB .DRIVE2 ,P-SFWIM2>
			       <GETB .DRIVE2 ,P-SLOC2>
			       <GETB .DRIVE2 ,P-SPREP2>>>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE2>)
	      (<EQUAL? .VERB ,ACT?FIND ; ,ACT?WHAT>
	       <TELL "You'll have to do that yourself." CR>
	       <RFALSE>)
	      (T
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <ORPHAN .DRIVE1 .DRIVE2>
		      <TELL "[Wh">)
		     (T
		      <TELL
"[Your command wasn't complete. Next time, type wh">)>
	       <COND (<EQUAL? .VERB ,ACT?WALK ,ACT?GO>
		      <TELL "ere">)
		     (<OR <AND <T? .DRIVE1>
			       <EQUAL? <GETB .DRIVE1 ,P-SFWIM1> ,PERSON>>
			  <AND <T? .DRIVE2>
			       <EQUAL? <GETB .DRIVE2 ,P-SFWIM2> ,PERSON>>>
		      <TELL "om">)
		     (T
		      <TELL "at">)>
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <TELL " do you want to ">)
		     (T
		      <TELL " you want " THE ,WINNER " to ">)>
	       <VERB-PRINT>
	       <COND (<T? .DRIVE2>
		      <CLAUSE-PRINT ,P-NC1 ,P-NC1L>)>
	       <SETG P-END-ON-PREP <>>
	       <PREP-PRINT <COND (<T? .DRIVE1>
				  <GETB .DRIVE1 ,P-SPREP1>)
				 (T
				  <GETB .DRIVE2 ,P-SPREP2>)>>
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <SETG P-OFLAG T>
		      <TELL "?]" CR>)
		     (T
		      <SETG P-OFLAG <>>
		      <TELL ".]" CR>)>
	       <RFALSE>)>>

<ROUTINE VERB-PRINT ("AUX" TMP)
	<SET TMP <GET ,P-ITBL ,P-VERBN>>	;"? ,P-OTBL?"
	<COND (<ZERO? .TMP>
	       <TELL "tell">)
	      (<ZERO? <GETB ,P-VTBL 2>>
	       <PRINTB <GET .TMP 0>>)
	      (T
	       <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
	       <PUTB ,P-VTBL 2 0>)>>

<ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))
	<COND (<ZERO? ,P-MERGED>
	       <PUT ,P-OCLAUSE ,P-MATCHLEN 0>)>
	<PUT ,P-OVTBL 0 <GET ,P-VTBL 0>>
	<PUTB ,P-OVTBL 2 <GETB ,P-VTBL 2>>
	<PUTB ,P-OVTBL 3 <GETB ,P-VTBL 3>>
	<REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN>
		       <RETURN>)
		      (T
		       <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>>
	<COND (<EQUAL? ,P-NCN 2>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL
			    ,P-NC2 ,P-NC2L ,P-NC2 ,P-NC2L>)>
	<COND (<NOT <L? ,P-NCN 1>>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL
			    ,P-NC1 ,P-NC1L ,P-NC1 ,P-NC1L>)>
	<COND (<T? .D1>
	       <PUT ,P-OTBL ,P-PREP1 <GETB .D1 ,P-SPREP1>>
	       <PUT ,P-OTBL ,P-NC1 1>)
	      (<T? .D2>
	       <PUT ,P-OTBL ,P-PREP2 <GETB .D2 ,P-SPREP2>>
	       <PUT ,P-OTBL ,P-NC2 1>)>>

<ROUTINE CLAUSE-PRINT (BPTR EPTR "OPTIONAL" (THE? T))
	<BUFFER-PRINT <GET ,P-ITBL .BPTR> <GET ,P-ITBL .EPTR> .THE?>>

<ROUTINE BUFFER-PRINT (BEG END CP "AUX" (NOSP <>) WRD (FIRST?? T) (PN <>))
	 <REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <RETURN>)
		      (T
		       <COND (<T? .NOSP>
			      <SET NOSP <>>)
			     (T
			      <TELL " ">)>
		       <SET WRD <GET .BEG 0>>
		       <COND (<OR <AND <EQUAL? .WRD ,W?HIM>
				       <NOT <VISIBLE? ,P-HIM-OBJECT>>>
				  <AND <EQUAL? .WRD ,W?HER>
				       <NOT <VISIBLE? ,P-HER-OBJECT>>>
				  <AND <EQUAL? .WRD ,W?THEM>
				       <NOT <VISIBLE? ,P-THEM-OBJECT>>>>
			      <SET PN T>)>
		       <COND (<EQUAL? .WRD ,W?PERIOD>
			      <SET NOSP T>)
			     (<AND <OR <WT? .WRD ,PS?BUZZ-WORD>
				       <WT? .WRD ,PS?PREPOSITION>>
				   <NOT <WT? .WRD ,PS?ADJECTIVE>>
				   <NOT <WT? .WRD ,PS?OBJECT>>>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ME>
			      <TELL D ,PLAYER>
			      <SET PN T>)
			     (<INTBL? .WRD ,CAPS ,NUMCAPS>
			      <CAPITALIZE .BEG>
			      <SET PN T>)
			     (T
			      <COND (<AND <T? .FIRST??>
					  <ZERO? .PN>
					  <T? .CP>>
				     <TELL "the ">)>
			      <COND (<OR <T? ,P-OFLAG>
					 <T? ,P-MERGED>>
				     <PRINTB .WRD>)
				    (<AND <EQUAL? .WRD ,W?IT>
					  <VISIBLE? ,P-IT-OBJECT>>
				     <TELL D ,P-IT-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?HER>
					  <ZERO? .PN>>
				     <TELL D ,P-HER-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?THEM>
					  <ZERO? .PN>>
				     <TELL D ,P-THEM-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?HIM>
					  <ZERO? .PN>>
				     <TELL D ,P-HIM-OBJECT>)
				    (T
				     <WORD-PRINT <GETB .BEG 2>
						 <GETB .BEG 3>>)>
			      <SET FIRST?? <>>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

"Check for words to be capitalized here."

<CONSTANT NUMCAPS 28> "Number of entries in CAPS."

<GLOBAL CAPS:TABLE
	<PTABLE <VOC "MR" <>> <VOC "MRS" <>> <VOC "MISS" <>>
		<VOC "DR" <>> <VOC "DOCTOR" <>> <VOC "TRINITY" <>>
		<VOC "KENSINGTON" <>> <VOC "INVERNESS" <>>
		<VOC "VICTORIA" <>> <VOC "ALBERT" <>>
		<VOC "VENUS" <>> <VOC "VENUS\'S" <>> <VOC "CHARON" <>>
		<VOC "STYX" <>> <VOC "ACHERON" <>>
		<VOC "GERMAN" <>> <VOC "RUSSIAN" <>> <VOC "JAPANESE" <>>
		<VOC "JAP" <>> <VOC "ORIENTAL" <>> <VOC "HIROSHIMA" <>>
		<VOC "NAGASAKI" <>> <VOC "LONDON" <>> <VOC "OPPENHEIM" <>>
		<VOC "OPPIE" <>> <VOC "J" <>> <VOC "ROBERT" <>>
		<VOC "JULIUS" <>> <VOC "I" <>> <VOC "N" <>> <VOC "S" <>>
		<VOC "E" <>> <VOC "W" <>> >>

<ROUTINE CAPITALIZE (PTR)
	 <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>>
		<PRINTB <GET .PTR 0>>)
	       (T
		<PRINTC <- <GETB ,P-INBUF <GETB .PTR 3>> 32>>
		<WORD-PRINT <- <GETB .PTR 2> 1> <+ <GETB .PTR 3> 1>>)>>

<ROUTINE PREP-PRINT (PREP "OPTIONAL" (SP? T) "AUX" WRD)
	<COND (<AND <T? .PREP>
		    <ZERO? ,P-END-ON-PREP>>
	       <COND (<T? .SP?>
		      <TELL " ">)>
	       <SET WRD <PREP-FIND .PREP>>
	       <PRINTB .WRD>
	     ; <COND (<EQUAL? .WRD ,W?AGAINST>
		      <TELL "against">)
		     (<EQUAL? .WRD ,W?THROUGH>
		      <TELL "through">)
		     (T
		      <PRINTB .WRD>)>
	       <COND (<AND <EQUAL? ,W?SIT <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <EQUAL? ,W?DOWN .WRD>>
		      <TELL " on">)>
	       <COND (<AND <EQUAL? ,W?GET <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <EQUAL? ,W?OUT .WRD>> ; "Will it ever work? --SWG"
		      <TELL " of">)>
	       <RTRUE>)>>

<ROUTINE CLAUSE-COPY (SRC DEST SRCBEG SRCEND DESTBEG DESTEND
		      "OPTIONAL" (INSRT <>) "AUX" BEG END)
	<SET BEG <GET .SRC .SRCBEG>>
	<SET END <GET .SRC .SRCEND>>
	<PUT .DEST .DESTBEG
	     <REST ,P-OCLAUSE
		   <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN> 2>>>
	<REPEAT ()
	 <COND (<EQUAL? .BEG .END>
		<PUT .DEST .DESTEND
		     <REST ,P-OCLAUSE
			   <+ 2 <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN>>>>
		<RETURN>)
	       (T
		<COND (<AND <T? .INSRT>
			    <EQUAL? ,P-ANAM <GET .BEG 0>>>
		       <CLAUSE-ADD .INSRT>)>
		<CLAUSE-ADD <GET .BEG 0>>)>
	 <SET BEG <REST .BEG ,P-WORDLEN>>>>

<ROUTINE CLAUSE-ADD (WRD "AUX" PTR)
	<SET PTR <+ <GET ,P-OCLAUSE ,P-MATCHLEN> 2>>
	<PUT ,P-OCLAUSE <- .PTR 1> .WRD>
	<PUT ,P-OCLAUSE .PTR 0>
	<PUT ,P-OCLAUSE ,P-MATCHLEN .PTR>>

<ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE)
	<SET SIZE <* <GET ,PREPOSITIONS 0> 2>>
	<REPEAT ()
		<COND (<IGRTR? CNT .SIZE>
		       <RFALSE>)
		      (<EQUAL? <GET ,PREPOSITIONS .CNT> .PREP>
		       <RETURN <GET ,PREPOSITIONS <- .CNT 1>>>)>>>

<ROUTINE SYNTAX-FOUND (SYN)
	<SETG P-SYNTAX .SYN>
	<SETG PRSA <GETB .SYN ,P-SACTION>>>

<GLOBAL P-GWIMBIT 0>

<ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)
	<COND (<EQUAL? .GBIT ,LOCATION>
	       <RETURN ,ROOMS>)
	      (<AND <T? ,P-IT-OBJECT>
		    <IS? ,P-IT-OBJECT .GBIT>>
	       <TELL "[" THE ,P-IT-OBJECT ,BRACKET>
	       <RETURN ,P-IT-OBJECT>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<EQUAL? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <COND (<AND <EQUAL? ,WINNER ,PLAYER>
				  <NOT <EQUAL? .OBJ ,HANDS ,SYMBOLS>>>
			     <TELL "[">
		      	     <COND (<PREP-PRINT .PREP <>>
			     	    <SPACE>)>
			     <COND (<AND <EQUAL? .OBJ ,BAG>
					 <SAID-CRUMBS?>>
				    <TELL "the crumbs">)
				   (T
				    <TELL THE .OBJ>)>
			     <PRINT ,BRACKET>)>
		      <RETURN .OBJ>)>)
	      (T
	       <SETG P-GWIMBIT 0>
	       <RFALSE>)>>

<ROUTINE SNARF-OBJECTS ("AUX" PTR)
	<COND (<T? <SET PTR <GET ,P-ITBL ,P-NC1>>>
	       <SETG P-PHR 0>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC1>>
	       <OR <SNARFEM .PTR <GET ,P-ITBL ,P-NC1L> ,P-PRSO>
		   <RFALSE>>
	       <OR <ZERO? <GET ,P-BUTS ,P-MATCHLEN>>
		   <SETG P-PRSO <BUT-MERGE ,P-PRSO>>>)>
	<COND (<T? <SET PTR <GET ,P-ITBL ,P-NC2>>>
	       <SETG P-PHR 1>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC2>>
	       <OR <SNARFEM .PTR <GET ,P-ITBL ,P-NC2L> ,P-PRSI>
		   <RFALSE>>
	       <COND (<T? <GET ,P-BUTS ,P-MATCHLEN>>
		      <COND (<EQUAL? <GET ,P-PRSI ,P-MATCHLEN> 1>
			     <SETG P-PRSO <BUT-MERGE ,P-PRSO>>)
			    (T
			     <SETG P-PRSI <BUT-MERGE ,P-PRSI>>)>)>)>
	<RTRUE>>

<ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<REPEAT ()
		 <COND (<DLESS? LEN 0>
			<RETURN>)>
		 <SET OBJ <GET .TBL .CNT>>
		 <COND (<INTBL? .OBJ <REST ,P-BUTS 2> <GET ,P-BUTS 0>>
		      ; <ZMEMQ <SET OBJ <GET .TBL .CNT>> ,P-BUTS>
			T)
		       (T
			<PUT ,P-MERGE <+ .MATCHES 1> .OBJ>
			<SET MATCHES <+ .MATCHES 1>>)>
		<SET CNT <+ .CNT 1>>>
	<PUT ,P-MERGE ,P-MATCHLEN .MATCHES>
	<SET NTBL ,P-MERGE>
	<SETG P-MERGE .TBL>
	.NTBL>

<GLOBAL P-NAM <>>

<GLOBAL P-XNAM <>>

<GLOBAL P-NAMW:TABLE <TABLE 0 0>>

<GLOBAL P-ADJ <>>

<GLOBAL P-XADJ <>>

<GLOBAL P-ADJW:TABLE <TABLE 0 0>>

<GLOBAL P-PHR 0>	"Which noun phrase is being parsed?"

<GLOBAL P-OFW:TABLE <TABLE 0 0>>

<GLOBAL P-PRSO:TABLE <ITABLE NONE 25>>

<GLOBAL P-PRSI:TABLE <ITABLE NONE 25>>

<GLOBAL P-BUTS:TABLE <ITABLE NONE 25>>

<GLOBAL P-MERGE:TABLE <ITABLE NONE 25>>

<GLOBAL P-OCLAUSE:TABLE <ITABLE NONE 25>>

<CONSTANT P-MATCHLEN 0>

<GLOBAL P-GETFLAGS 0>

<CONSTANT P-ALL 1>

<CONSTANT P-ONE 2>

<CONSTANT P-INHIBIT 4>

<GLOBAL P-AND <>>

<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL? <>)
				     ONEOBJ)
   ;"Next SETG 6/21/84 for WHICH retrofix"
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL? T>)>
   <SETG P-GETFLAGS 0>
   <PUT ,P-BUTS ,P-MATCHLEN 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (<T? .WAS-ALL?>
			 <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<==? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<EQUAL? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <OR <GET-OBJECT <OR .BUT .TBL>>
			     <RFALSE>>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<BUZZER-WORD? .WRD>
			 <RFALSE>)
			(<EQUAL? .WRD ,W?A ; ,W?ONE>
			 <COND (<ZERO? ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<EQUAL? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM .ONEOBJ>
				<OR <GET-OBJECT <OR .BUT .TBL>>
				    <RFALSE>>
				<AND <ZERO? .NW>
				     <RTRUE>>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 ;"Next SETG 6/21/84 for WHICH retrofix"
			 <SETG P-AND T>
			 <OR <GET-OBJECT <OR .BUT .TBL>>
			     <RFALSE>>
			 T)
			(<WT? .WRD ,PS?BUZZ-WORD>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<EQUAL? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			(<AND <WT? .WRD ,PS?ADJECTIVE>
			      <ZERO? ,P-ADJ>
			      <NOT <EQUAL? .NW ,W?OF>>> ; "FIX #41"
			 <SETG P-ADJ .WRD>)
			(<WT? .WRD ,PS?OBJECT ;,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SET ONEOBJ .WRD>)>)>
	   <COND (<NOT <EQUAL? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>

<CONSTANT SH 128>
<CONSTANT SC 64>
<CONSTANT SIR 32>
<CONSTANT SOG 16>
<CONSTANT STAKE 8>
<CONSTANT SMANY 4>
<CONSTANT SHAVE 2>

<ROUTINE GET-OBJECT (TBL
		    "OPTIONAL" (VRB T)
		    "AUX" BTS LEN XBITS TLEN (GCHECK <>) (OLEN 0) OBJ ADJ X)
 <SET XBITS ,P-SLOCBITS>
 <SET TLEN <GET .TBL ,P-MATCHLEN>>
 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT>
	<RTRUE>)>
 <SET ADJ ,P-ADJ>
 <COND (<AND <ZERO? ,P-NAM>
	     <T? ,P-ADJ>>
	<COND (<WT? ,P-ADJ ,PS?OBJECT>
	       <SETG P-NAM ,P-ADJ>
	       <SETG P-ADJ <>>)
	      (<SET BTS <WT? ,P-ADJ ,PS?DIRECTION ,P1?DIRECTION>>
	       <SETG P-ADJ <>>
	       <PUT .TBL ,P-MATCHLEN 1>
	       <PUT .TBL 1 ,INTDIR>
	       <SETG P-DIRECTION .BTS>
	       <RTRUE>)>)>
 <COND (<AND <ZERO? ,P-NAM>
	     <ZERO? ,P-ADJ>
	     <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
	     <ZERO? ,P-GWIMBIT>>
	<COND (<T? .VRB>
	       <NOT-IN-SENTENCE "enough nouns">)>
	<RFALSE>)>
 <COND (<OR <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
	    <ZERO? ,P-SLOCBITS>>
	<SETG P-SLOCBITS -1>)>
 <SETG P-TABLE .TBL>
 <PROG ()
  ;<COND (<T? ,DEBUG?>
	  <TELL "[GETOBJ: GCHECK=" N .GCHECK "]" CR>)>
  <COND (<T? .GCHECK>
       ; <COND (<T? ,DEBUG?>
		<TELL "[GETOBJ: calling GLOBAL-CHECK]" CR>)>
	 <GLOBAL-CHECK .TBL>)
	(T
	 <COND (<T? ,LIT?>
		<UNMAKE ,PLAYER ,TRANSPARENT>
		<DO-SL ,HERE ,SOG ,SIR>
		<MAKE ,PLAYER ,TRANSPARENT>)>
	 <DO-SL ,PLAYER ,SH ,SC>)>
  <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
  <COND (<BTST ,P-GETFLAGS ,P-ALL>)
	(<AND <BTST ,P-GETFLAGS ,P-ONE>
	      <T? .LEN>>
	 <COND (<NOT <EQUAL? .LEN 1>>
		<PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
		<TELL "[How about " THE <GET .TBL 1> "?]" CR>)>
	 <PUT .TBL ,P-MATCHLEN 1>)
	(<OR <G? .LEN 1>
	     <AND <ZERO? .LEN>
		  <NOT <EQUAL? ,P-SLOCBITS -1>>>>
	 <COND (<EQUAL? ,P-SLOCBITS -1>
		<SETG P-SLOCBITS .XBITS>
		<SET OLEN .LEN>
		<PUT .TBL ,P-MATCHLEN <- <GET .TBL ,P-MATCHLEN> .LEN>>
		<AGAIN>)
	       (T
		<PUT ,P-NAMW ,P-PHR ,P-NAM>
		<PUT ,P-ADJW ,P-PHR ,P-ADJ>
		<COND (<ZERO? .LEN>
		       <SET LEN .OLEN>)>
		<COND (<AND <T? ,P-NAM>
			    <SET OBJ <GET .TBL <+ .TLEN 1>>>
			    <SET OBJ <APPLY <GETP .OBJ ,P?GENERIC> .TBL>>>
		       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
			      <RFALSE>)>
		       <PUT .TBL 1 .OBJ>
		       <PUT .TBL ,P-MATCHLEN 1>
		       <SETG P-NAM <>>
		       <SETG P-ADJ <>>
		       <RTRUE>)
		      (<AND <T? .VRB>
			    <NOT <EQUAL? ,WINNER ,PLAYER>>>
		       <DONT-UNDERSTAND>
		       <RFALSE>)
		      (<AND <T? .VRB>
			    <T? ,P-NAM>>
		       <WHICH-PRINT .TLEN .LEN .TBL>
		       <SETG P-ACLAUSE
			     <COND (<EQUAL? .TBL ,P-PRSO>
				    ,P-NC1)
				   (T
				    ,P-NC2)>>
		       <SETG P-AADJ ,P-ADJ>
		       <SETG P-ANAM ,P-NAM>
		       <ORPHAN <> <>>
		       <SETG P-OFLAG T>)
		      (<T? .VRB>
		       <NOT-IN-SENTENCE "enough nouns">)>
		<SETG P-NAM <>>
		<SETG P-ADJ <>>
		<RFALSE>)>)
	(<AND <ZERO? .LEN>
	      <T? .GCHECK>>
	 <PUT ,P-NAMW ,P-PHR ,P-NAM>
	 <PUT ,P-ADJW ,P-PHR ,P-ADJ>
	 <COND (<T? .VRB>
		<SETG P-SLOCBITS .XBITS> ; "RETROFIX #33"
		<COND (<OR <T? ,LIT?>
			   <INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
			 ; <SPEAKING-VERB?>>
		       <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
		       <SETG P-XNAM ,P-NAM>
		       <SETG P-NAM <>>
		       <SETG P-XADJ ,P-ADJ>
		       <SETG P-ADJ <>>
		       <RTRUE>)
		      (T
		       <TOO-DARK>)>)>
	 <SETG P-NAM <>>
	 <SETG P-ADJ <>>
	 <RFALSE>)
	(<ZERO? .LEN>
	 <SET GCHECK T>
       ; <COND (<T? ,DEBUG?>
		<TELL "[GETOBJ: GCHECK set to " N .GCHECK "]" CR>)>
	 <AGAIN>)>
  <SET X <GET .TBL <+ .TLEN 1>>>
  <COND (<AND <T? ,P-ADJ>
	      <ZERO? ,P-NAM>
	      <T? .X>>
	 <TELL "[" THE .X ,BRACKET>)>
  <SETG P-SLOCBITS .XBITS>
  <PUT ,P-NAMW ,P-PHR ,P-NAM>
  <PUT ,P-ADJW ,P-PHR ,P-ADJ>
  <SETG P-NAM <>>
  <SETG P-ADJ <>>
  <RTRUE>>>

<GLOBAL P-MOBY-FOUND <>>

<GLOBAL P-MOBY-FLAG <>> ; "Needed only for ZIL"

<CONSTANT LAST-OBJECT 0>

<ROUTINE MOBY-FIND (TBL "AUX" (OBJ 1) LEN FOO NAM ADJ)
  <SET NAM ,P-NAM>
  <SET ADJ ,P-ADJ>
  <SETG P-NAM ,P-XNAM>
  <SETG P-ADJ ,P-XADJ>
  <PUT .TBL ,P-MATCHLEN 0>
  %<COND (<GASSIGNED? ZILCH>	;<NOT <ZERO? <GETB 0 18>>>	;"ZIP case"
	 '<PROG ()
	 <REPEAT ()
		 <COND (<AND ; <SET FOO <META-LOC .OBJ T>>
			     <NOT <IN? .OBJ ,ROOMS>>
			     <SET FOO <THIS-IT? .OBJ>>>
			<SET FOO <OBJ-FOUND .OBJ .TBL>>)>
		 <COND (<IGRTR? OBJ ,LAST-OBJECT>
			<RETURN>)>>>)
	(T		;"ZIL case"
	 '<PROG ()
	 <SETG P-SLOCBITS -1>
	 <SET FOO <FIRST? ,ROOMS>>
	 <REPEAT ()
		 <COND (<ZERO? .FOO>
			<RETURN>)
		       (T
			<SEARCH-LIST .FOO .TBL ,P-SRCALL T>
			<SET FOO <NEXT? .FOO>>)>>
	 <DO-SL ,LOCAL-GLOBALS 1 1 .TBL T>
	 <SEARCH-LIST ,ROOMS .TBL ,P-SRCTOP T>>)>
  <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
	 <SETG P-MOBY-FOUND <GET .TBL 1>>)>
  <SETG P-NAM .NAM>
  <SETG P-ADJ .ADJ>
  <RETURN .LEN>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <SET RLEN .LEN>
	 <TELL "Which">
	 <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>
		    <T? ,P-AND>>
		<TELL " ">
		<PRINTB ,P-NAM>)
	       (<EQUAL? .TBL ,P-PRSO>
		<CLAUSE-PRINT ,P-NC1 ,P-NC1L <>>)
	       (T
		<CLAUSE-PRINT ,P-NC2 ,P-NC2L <>>)>
	 <TELL " do you mean,">
	 <REPEAT ()
		 <SET TLEN <+ .TLEN 1>>
		 <SET OBJ <GET .TBL .TLEN>>
		 <TELL " " THE .OBJ>
		 <COND (<EQUAL? .LEN 2>
			<COND (<NOT <EQUAL? .RLEN 2>>
			       <TELL ",">)>
			<TELL " or">)
		       (<G? .LEN 2>
			<TELL ",">)>
		 <COND (<L? <SET LEN <- .LEN 1>> 1>
			<TELL "?" CR>
			<RETURN>)>>>

<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<COND (<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	       <SET RMGL <RMGL-SIZE .RMG>>
	     ; <COND (<T? ,DEBUG?>
		      <TELL "[GLBCHK: (LG) RMGL=" N .RMGL "]" CR>)>
	       <REPEAT ()
		       <SET OBJ <GET/B .RMG .CNT>>
		       <COND (<FIRST? .OBJ>
			      <SEARCH-LIST .OBJ .TBL ,P-SRCALL>)>
		       <COND (<THIS-IT? .OBJ>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<IGRTR? CNT .RMGL>
			      <RETURN>)>>)>
	<COND (<EQUAL? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	       <COND (<ZERO? <GET .TBL ,P-MATCHLEN>>
		      <COND (<VERB? EXAMINE LOOK-ON LOOK-INSIDE FIND FOLLOW
				    LEAVE SEARCH SMELL WALK-TO THROUGH
				    WAIT-FOR>
			     <DO-SL ,ROOMS 1 1>)>)>)>>

<ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BITS)
	<COND (<BTST ,P-SLOCBITS <+ .BIT1 .BIT2>>
	       <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCALL>)
	      (T
	       <COND (<BTST ,P-SLOCBITS .BIT1>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCTOP>)
		     (<BTST ,P-SLOCBITS .BIT2>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCBOT>)
		     (T
		      <RTRUE>)>)>>

<CONSTANT P-SRCBOT 2>

<CONSTANT P-SRCTOP 0>

<CONSTANT P-SRCALL 1>

<ROUTINE SEARCH-LIST (OBJ TBL LVL)
 ; <COND (<EQUAL? .OBJ ,GLOBAL-OBJECTS>
	  <SET GLOB T>)
	 (T
	  <SET GLOB <>>)>
 <SET OBJ <FIRST? .OBJ>>
 <COND (<T? .OBJ>
	<REPEAT ()
	      ; <COND (<AND <T? .GLOB>
			    <T? ,DEBUG?>>
		       <TELL "[SRCLST: OBJ=" D .OBJ "]" CR>)>
		<COND (<AND <NOT <EQUAL? .LVL ,P-SRCBOT>>
			    <GETPT .OBJ ,P?SYNONYM>
			    <THIS-IT? .OBJ>>
		       <OBJ-FOUND .OBJ .TBL>)>
		<COND (<AND <OR <NOT <EQUAL? .LVL ,P-SRCTOP>>
			      ; <IS? .OBJ ,SEARCHBIT>	; "Z0 deleted this"
				<IS? .OBJ ,SURFACE>
				<IS? .OBJ ,PERSON>>
			    <FIRST? .OBJ>
			    <SEE-INSIDE? .OBJ>
			  ; <OR <SEE-INSIDE? .OBJ>
				<IS? .OBJ ,SURFACE> ; "ADDED 3/26/85"
				<IS? .OBJ ,OPENED>
				<IS? .OBJ ,TRANSPARENT>
				<T? ,P-MOBY-FLAG> ; "Needed only for ZIL"
				<AND <IS? .OBJ ,PERSON>
				     <NOT <EQUAL? .OBJ ,PLAYER>>>>
			  ; <NOT <EQUAL? .OBJ ,PLAYER ,LOCAL-GLOBALS>>>
		       <SEARCH-LIST .OBJ .TBL
				    <COND (<OR <IS? .OBJ ,SURFACE>
					       <IS? .OBJ ,PERSON>>
					   ,P-SRCALL)
					; (<IS? .OBJ ,SEARCHBIT>
					   ,P-SRCALL)	;"Z0 deleted this"
					  (T
					   ,P-SRCTOP)>>)>
		<SET OBJ <NEXT? .OBJ>>
		<COND (<ZERO? .OBJ>
		       <RETURN>)>>)>>

<ROUTINE THIS-IT? (OBJ "AUX" SYNS)
	 <COND ; (<FSET? .OBJ ,INVISIBLE>
		  <RFALSE>)
	       (<AND <T? ,P-NAM>
		     <OR <NOT <SET SYNS <GETPT .OBJ ,P?SYNONYM>>>
			 <NOT <INTBL? ,P-NAM .SYNS </ <PTSIZE .SYNS> 2>>
			    ; <ZMEMQ ,P-NAM .SYNS
				     <- </ <PTSIZE .SYNS> 2> 1>>>>>
		<RFALSE>)
	       (<AND <T? ,P-ADJ>
		     <OR <NOT <SET SYNS <GETPT .OBJ ,P?ADJECTIVE>>>
			 <NOT <INTBL? ,P-ADJ .SYNS </ <PTSIZE .SYNS> 2>>
			    ; <ZMEMQ ,P-ADJ .SYNS <RMGL-SIZE .SYNS>>>>>
		<RFALSE>)
	       (<AND <T? ,P-GWIMBIT>
		     <NOT <FSET? .OBJ ,P-GWIMBIT>>>
		<RFALSE>)>
	 <RTRUE>>

<ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR)
	<SET PTR <GET .TBL ,P-MATCHLEN>>
	<PUT .TBL <+ .PTR 1> .OBJ>
	<PUT .TBL ,P-MATCHLEN <+ .PTR 1>>
	<RTRUE>>

<ROUTINE ITAKE-CHECK (TBL BITS "AUX" (PTR 1) LEN OBJ L GOT)
	 <SET LEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<ZERO? .LEN>
		<RTRUE>)
	       (<OR <BTST .BITS ,SHAVE>
		    <BTST .BITS ,STAKE>>
		<REPEAT ()
			<SET OBJ <GET .TBL .PTR>>
			<COND (<EQUAL? .OBJ ,IT>
			       <COND (<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
				      <MORE-SPECIFIC>
				      <RFALSE>)>
			       <SET OBJ ,P-IT-OBJECT>)
			      (<EQUAL? .OBJ ,THEM>
			       <COND (<NOT <ACCESSIBLE? ,P-THEM-OBJECT>>
				      <MORE-SPECIFIC>
				      <RFALSE>)>
			       <SET OBJ ,P-THEM-OBJECT>)
			      (<EQUAL? .OBJ ,HER>
			       <COND (<NOT <ACCESSIBLE? ,P-HER-OBJECT>>
				      <MORE-SPECIFIC>
				      <RFALSE>)>
			       <SET OBJ ,P-HER-OBJECT>)
			      (<EQUAL? .OBJ ,HIM>
			       <COND (<NOT <ACCESSIBLE? ,P-HIM-OBJECT>>
				      <MORE-SPECIFIC>
				      <RFALSE>)>
			       <SET OBJ ,P-HIM-OBJECT>)>
			<COND (<AND <NOT <EQUAL? .OBJ ,POCKET ,HANDS ,FEET>>
				    <NOT <EQUAL? .OBJ ,ME ,YOU ,ROOMS>>
				    <NOT <EQUAL? .OBJ ,INTDIR ,RIGHT ,LEFT>>
				    <NOT <HELD? .OBJ>>>
			       <SETG PRSO .OBJ>
			       <SET L <LOC .OBJ>>
			       <COND (<ZERO? .L>
				      <SET GOT <>>)
				     (<AND <IS? .OBJ ,TRYTAKE>
				      	   <NOT <IS? .OBJ ,TAKEABLE>>>
				      <SET GOT <>>)
				     (<NOT <EQUAL? ,WINNER ,PLAYER>>
				      <SET GOT <>>)
				     (<AND <IN? .L ,WINNER>
					   <ZERO? ,P-MULT?>
					   <BTST .BITS ,STAKE>
					   <ITAKE <>>>
				      <SET GOT T>)
				     (<AND <EQUAL? .L ,WINNER>
					   <BTST .BITS ,SHAVE>>
				      <SET GOT T>)
				     (T
				      <SET GOT <>>)>
			<COND (<AND <ZERO? .GOT>
				    <NOT <EQUAL? .L ,POCKET>>
				    <BTST .BITS ,SHAVE>>
			       <WINNER-NOT-HOLDING>
			       <COND (<AND <EQUAL? .LEN .PTR>
					   <T? ,P-MULT?>>
				      <TELL "all of those things">)
				     (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
				      <SETG P-IT-OBJECT .OBJ>
				      <TELL D .OBJ>)
				     (T
				      <THIS-IS-IT .OBJ>
				      <COND (<IS? .OBJ ,PLURAL>
					     <TELL "any ">)
					    (<NOT <IS? .OBJ ,NOARTICLE>>
					     <COND (<IS? .OBJ ,VOWEL>
						    <TELL "an ">)
						   (T
						    <TELL "a ">)>)>
				      <TELL D .OBJ>)>
			       <PRINT ,PERIOD>
			       <RFALSE>)
			      (<AND <T? .GOT>
				    <BTST .BITS ,STAKE>
				    <EQUAL? ,WINNER ,PLAYER>>
			       <TELL "[taking " THE .OBJ>
			       <COND (<T? .L>
				      <COND (<IS? .L ,CONTAINER>
					     <TELL " out of ">)
					    (<IS? .L ,SURFACE>
					     <TELL " off ">)
					    (T
					     <TELL " from ">)>
				      <TELL THE .L>)>
			       <TELL " first" ,BRACKET>)>)>
		<COND (<IGRTR? PTR .LEN>
		       <RTRUE>)>>)>
	 <RTRUE>>

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)
	<COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (<T? .LOSS>
	     ; <TELL "[" ,CANT "use more than one ">
	     ; <COND (<EQUAL? .LOSS 2>
		      <TELL "in">)>
	     ; <TELL "direct object with \"">
	       <TELL "[" ,CANT
"refer to more than one object at a time with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP>
		      <TELL "tell">)
		     (<OR <T? ,P-OFLAG>
			  <T? ,P-MERGED>>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL ".\"]" CR>
	       <RFALSE>)
	      (T
	       <RTRUE>)>>

<GLOBAL LIT?:FLAG T>
<GLOBAL ALWAYS-LIT?:FLAG <>>

<ROUTINE SAY-IF-HERE-LIT ()
	 <SETG LIT? <IS-LIT?>>
	 <COND (<ZERO? ,LIT?>
		<SETG OLD-HERE <>>
		<CRLF>
		<V-LOOK>)>
	 <RTRUE>>

<ROUTINE IS-LIT? ("OPTIONAL" (RM <>) (RMBIT T) "AUX" OHERE (LIT <>))
	<COND (<AND <T? ,ALWAYS-LIT?>
		    <EQUAL? ,WINNER ,PLAYER>>
	       <RTRUE>)
	      (<ZERO? .RM>
	       <SET RM ,HERE>)>
	<SETG P-GWIMBIT ,LIGHTED>
	<SET OHERE ,HERE>
	<SETG HERE .RM>
	<COND (<AND <T? .RMBIT>
		    <IS? .RM ,LIGHTED>>
	       <SET LIT T>)
	      (T
	       <PUT ,P-MERGE ,P-MATCHLEN 0>
	       <SETG P-TABLE ,P-MERGE>
	       <SETG P-SLOCBITS -1>
	       <COND (<EQUAL? .OHERE .RM>
		      <DO-SL ,WINNER 1 1>
		      <COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
				  <IN? ,PLAYER .RM>>
			     <DO-SL ,PLAYER 1 1>)>)>
	       <DO-SL .RM 1 1>
	       <COND (<G? <GET ,P-TABLE ,P-MATCHLEN> 0>
		      <SET LIT T>)>)>
	<SETG HERE .OHERE>
	<SETG P-GWIMBIT 0>
	<RETURN .LIT>>

"PICK-NEXT expects an LTABLE of strings, with an initial element of 2."

<ROUTINE PICK-NEXT (TBL "AUX" CNT STR)
	 <SET CNT <GET .TBL 1>>
	 <SET STR <GET .TBL .CNT>>
	 <INC CNT>
	 <COND (<G? .CNT <GET .TBL 0>>
		<SET CNT 2>)>
	 <PUT .TBL 1 .CNT>
	 <RETURN .STR>>

<ROUTINE DONT-HAVE? (OBJ "AUX" L O)
	 <SET L <LOC .OBJ>>
	 <COND (<ZERO? .L>
		T)
	       (<EQUAL? .L ,WINNER>
		<RFALSE>)
	       (<AND <IN? .L ,PLAYER>
		     <EQUAL? ,WINNER ,PLAYER>>
	      	<SET O ,PRSO>
		<SETG PRSO .OBJ>
		<COND (<ITAKE <>>
		       <TELL "[taking " THEO>
		       <COND (<IS? .L ,CONTAINER>
			      <TELL " out of ">)
			     (T
			      <TELL " off ">)>
		       <TELL THE .L " first" ,BRACKET>
		       <SETG PRSO .O>
		       <THIS-IS-IT ,PRSO>
		       <RFALSE>)
		      (T
		       <SETG PRSO .O>
		       <TELL "You'd have to take " THE .OBJ>
		       <SPACE>
		       <COND (<IS? .L ,SURFACE>
			      <TELL "off">)
			     (T
			      <TELL "out">)>
		       <TELL " of " THE .L " first." CR>
		       <RTRUE>)>)>
	 <WINNER-NOT-HOLDING>
	 <COND (<T? .OBJ>
		<COND (<IS? .OBJ ,PLURAL>
		       <TELL "any ">)>
		<TELL THE .OBJ>)
	       (T
		<TELL D ,NOT-HERE-OBJECT>)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE WINNER-NOT-HOLDING ()
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You're not holding ">
		<RTRUE>)>
	 <TELL CTHE ,WINNER " do">
	 <COND (<NOT <IS? ,WINNER ,PLURAL>>
		<TELL "es">)>
	 <TELL "n't have ">
	 <RTRUE>>

<CONSTANT NHAVES 16> "Number of HAVEVERBS."

<GLOBAL HAVEVERBS
	<PTABLE V?DROP V?PUT V?PUT-ON V?GIVE V?SHOW V?FEED V?THROW
		V?PUT-UNDER V?PUT-BEHIND V?THROW-OVER V?RELEASE V?TAKE-WITH
		V?TOUCH-TO V?OPEN V?OPEN-WITH V?CLOSE V?COVER>>

<CONSTANT NTVERBS 16> "Number of TALKVERBS."

<GLOBAL TALKVERBS:TABLE
	<PTABLE
	 V?TELL V?TELL-ABOUT V?ASK-ABOUT V?ASK-FOR V?WHAT V?WHERE V?WHO
	 V?ALARM V?HELLO V?GOODBYE V?SAY V?YELL V?THANK
	 V?QUESTION V?REPLY V?WAVE-AT>>

<CONSTANT NTOUCHES 79> "Number of TOUCHVERBS"

<GLOBAL TOUCHVERBS:TABLE
	<PTABLE
	 V?TAKE V?TAKE-OFF V?PUT V?PUT-ON V?PUT-UNDER V?PUT-BEHIND
	 V?COVER V?EMPTY-INTO V?REACH-IN V?TOUCH-TO V?TOUCH V?HIT V?KICK
	 V?MOVE V?PUSH V?PUSH-TO V?PULL V?LOWER V?RAISE V?LOOSEN
	 V?TURN-TO V?TUNE-TO V?ADJUST V?SPIN V?TURN V?SHAKE
	 V?SWING V?OPEN V?OPEN-WITH V?CLOSE V?LOCK V?UNLOCK V?SCREW V?UNSCREW
	 V?PLUG V?UNPLUG V?TIE V?UNTIE V?FOLD V?UNFOLD V?LAMP-ON V?LAMP-OFF
	 V?UNTANGLE V?WRAP-AROUND V?CUT V?RIP V?MUNG V?DIG V?FILL V?DEFLATE
	 V?BURN-WITH V?CLEAN V?CLEAN-OFF V?BLOW-INTO V?DETONATE V?POP V?SHOOT
	 V?WIND V?REPAIR V?REPLACE V?FLUSH V?PICK V?MELT V?SQUEEZE V?PLAY
	 V?DRIVE V?UNSCREW-FROM V?SCREW-WITH V?GIVE V?FEED V?STAND-ON
	 V?SIT V?LIE-DOWN V?EAT V?BITE V?TASTE V?DRINK V?DRINK-FROM
	 V?BANDAGE>>

<CONSTANT NHVERBS 18> "Number of HURTVERBS."

<GLOBAL HURTVERBS:TABLE
	<PTABLE
	 V?HIT V?KICK V?KILL V?MUNG V?KNOCK V?KICK V?SQUEEZE V?CUT V?RIP
	 V?BITE V?RAPE V?SUCK V?SHAKE V?UNDRESS V?DETONATE V?PUSH V?PUSH-TO
	 V?PULL>>

<CONSTANT NUMPUTS 7> "# PUTVERBS."

<GLOBAL PUTVERBS:TABLE
	<PTABLE V?PUT V?PUT-ON V?PUT-UNDER V?PUT-BEHIND V?THROW
		V?THROW-OVER V?EMPTY-INTO>>

<CONSTANT NMVERBS 23> "Number of MOVEVERBS."

<GLOBAL MOVEVERBS:TABLE
	<PTABLE
	 V?TAKE V?TAKE-OFF V?MOVE V?PULL V?PUSH V?PUSH-TO V?TURN V?RAISE
	 V?LOWER V?SPIN V?SHAKE V?PLAY V?OPEN V?OPEN-WITH V?CLOSE V?ADJUST
	 V?UNTANGLE
	 V?TURN-TO V?TUNE-TO V?POINT-AT V?SWING V?UNPLUG V?BOUNCE>>

<ROUTINE GETTING-INTO? ()
	 <COND (<OR <ENTERING?>
		    <VERB? CLIMB-ON CLIMB-UP CLIMB-OVER CROSS STAND-ON SIT
			   LIE-DOWN CLIMB-DOWN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ENTERING? ()
	 <COND (<VERB? WALK-TO ENTER THROUGH FOLLOW LEAP USE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE EXITING? ()
	 <COND (<VERB? EXIT LEAVE TAKE-OFF ESCAPE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ANYONE-HERE? ("AUX" OBJ)
	 <COND (<QCONTEXT-GOOD?>
		<RETURN ,QCONTEXT>)
	       (T
		<SET OBJ <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<ZERO? .OBJ>
			       <RFALSE>)
			      (<AND <IS? .OBJ ,PERSON>
				    <NOT <IS? .OBJ ,PLURAL>>
				    <NOT <EQUAL? .OBJ ,PLAYER ,WINNER>>>
			       <RETURN>)
			      (T
			       <SET OBJ <NEXT? .OBJ>>)>>
		<RETURN .OBJ>)>>

<GLOBAL QCONTEXT:OBJECT <>>
<GLOBAL QCONTEXT-ROOM:OBJECT <>>

<ROUTINE QCONTEXT-GOOD? ()
	 <COND (<AND <T? ,QCONTEXT>
		     <IS? ,QCONTEXT ,PERSON>
		     <EQUAL? ,HERE ,QCONTEXT-ROOM>
		     <VISIBLE? ,QCONTEXT>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT NOT-HERE-OBJECT
	(DESC "that")
	(FLAGS NOARTICLE)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ ; (X <>))
	 <COND (<AND <PRSO? NOT-HERE-OBJECT>
		     <PRSI? NOT-HERE-OBJECT>>
		<TELL "Those things aren't here." CR>
		<RTRUE>)
	       (<PRSO? NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>

	<COND (<T? .PRSO?>
		<COND (<VERB? ; "WALK-TO FOLLOW" FIND WHO WHAT WHERE BUY
			      WAIT-FOR CHARGE>
		       <SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<T? .OBJ>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RFATAL>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<VERB? TELL-ABOUT ASK-ABOUT ASK-FOR>
		       <SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<T? .OBJ>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RFATAL>)>)
			     (T
			      <RFALSE>)>)>)>

	 <TELL ,CANT>
	 <COND (<VERB? LISTEN>
		<TELL "hear">)
	       (<VERB? SMELL>
		<TELL "smell">)
	       (T
		<TELL "see">)>
	 <COND (<NOT <INTBL? ,P-XNAM ,CAPS ,NUMCAPS>>
		<TELL " any">)>
	 <NOT-HERE-PRINT .PRSO?>
	 <TELL " here." CR>
	 <PCLEAR>
	 <RFATAL>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	<SET M-F <MOBY-FIND .TBL>>
	<COND (<EQUAL? .M-F 1>
	       <COND (<T? .PRSO?>
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <G? .M-F 1>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>
				     .TBL>>>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (<T? .PRSO?>
		      <SETG PRSO .OBJ>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (<VERB? ASK-ABOUT TELL-ABOUT ASK-FOR WHO WHAT WHERE
		      FIND FOLLOW TELL>
	       <RFALSE>)
	      (<ZERO? .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT ("OPTIONAL" (PRSO? <>))
	 <COND (<OR <T? ,P-OFLAG>
		    <T? ,P-MERGED>>
		<COND (<T? ,P-XADJ>
		       <PRINTC 32>
		       <PRINTB ,P-XADJ>)>
		<COND (<T? ,P-XNAM>
		       <PRINTC 32>
		       <PRINTB ,P-XNAM>)>)
	       (<T? .PRSO?>
		<BUFFER-PRINT <GET ,P-ITBL ,P-NC1>
			      <GET ,P-ITBL ,P-NC1L> <>>)
	       (T
		<BUFFER-PRINT <GET ,P-ITBL ,P-NC2>
			      <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT C-OBJECT>

<ROUTINE PRINT-CONTENTS (THING "AUX" OBJ NXT (1ST? T) (IT? <>) (TWO? <>))
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		<COND (<ZERO? .OBJ>
		       <RETURN>)>
		<SET NXT <NEXT? .OBJ>>
		<COND (<OR <EQUAL? .OBJ ,WINNER>
			   <IS? .OBJ ,NODESC>>
		       <MOVE .OBJ ,C-OBJECT>)>
		<SET OBJ .NXT>>
	 <SET OBJ <FIRST? .THING>>
	 <COND (<ZERO? .OBJ>
		<TELL "nothing " <PICK-NEXT ,YAWNS>>)
	       (T
		<REPEAT ()
			<COND (<T? .OBJ>
			       <SET NXT <NEXT? .OBJ>>
			       <COND (<T? .1ST?>
				      <SET 1ST? <>>)
				     (T
				      <COND (<T? .NXT>
					     <TELL ", ">)
					    (T
					     <TELL " and ">)>)>
			       <TELL A .OBJ>
			       <COND (<IS? .OBJ ,LIGHTED>
				      <TELL " (providing light)">)>
			       <COND (<AND <ZERO? .IT?>
					   <ZERO? .TWO?>>
				      <SET IT? .OBJ>)
				     (T
				      <SET TWO? T>
				      <SET IT? <>>)>
			       <SET OBJ .NXT>)
			      (T
			       <COND (<AND <T? .IT?>
					   <ZERO? .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RETURN>)>>)>
	 <MOVE-ALL ,C-OBJECT .THING>
	 <RTRUE>>

<ROUTINE MOVE-ALL (FROM TO "AUX" OBJ NXT)
	 <SET OBJ <FIRST? .FROM>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RTRUE>)>
		 <SET NXT <NEXT? .OBJ>>
		 <MOVE .OBJ .TO>
		 <SET OBJ .NXT>>
	 <RTRUE>>

<ROUTINE REMOVE-ALL (THING "AUX" OBJ NXT)
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RTRUE>)>
		 <SET NXT <NEXT? .OBJ>>
		 <REMOVE .OBJ>
		 <SET OBJ .NXT>>
	 <RTRUE>>

<OBJECT X-OBJECT>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (THING <>)
			   "AUX" OBJ NXT STR (1ST? T) (TWO? <>) (IT? <>)
			   	 (ANY? <>))
	 <COND (<ZERO? .THING>
		<SET THING ,HERE>)>
	 <COND (<ZERO? ,LIT?>
		<TOO-DARK>
		<RTRUE>)>

      ; "Hide invisible objects"

	<SET OBJ <FIRST? .THING>>
	<COND (<ZERO? .OBJ>
	       <RTRUE>)>

	<REPEAT ()
		<COND (<ZERO? .OBJ>
		       <RETURN>)>
		<SET NXT <NEXT? .OBJ>>
		<COND (<OR <IS? .OBJ ,NODESC>
			   <EQUAL? .OBJ ,WINNER>>
		       <MOVE .OBJ ,DUMMY-OBJECT>)>
		<SET OBJ .NXT>>

      ; "If HERE, apply FDESCs and DESCFCNs and eliminate those objects"

	<COND (<EQUAL? .THING ,HERE>

	       <SET OBJ <FIRST? .THING>> ; "FDESCs"
	       <REPEAT ()
		       <COND (<ZERO? .OBJ>
			      <RETURN>)>
		       <SET NXT <NEXT? .OBJ>>
		       <SET STR <GETP .OBJ ,P?FDESC>>
		       <COND (<AND <T? .STR>
				   <NOT <IS? .OBJ ,TOUCHED>>>
			      <TELL CR .STR CR>
			      <THIS-IS-IT .OBJ>
			      <MOVE .OBJ ,DUMMY-OBJECT>)>
		       <SET OBJ .NXT>>

	      <SET OBJ <FIRST? .THING>> ; "DESCFCNs"
	      <REPEAT ()
		       <COND (<ZERO? .OBJ>
			      <RETURN>)>
		       <SET NXT <NEXT? .OBJ>>
		       <SET STR <GETP .OBJ ,P?DESCFCN>>
		       <COND (<T? .STR>
			      <CRLF>
			      <SET STR <APPLY .STR ,M-OBJDESC>>
			      <CRLF>
			      <THIS-IS-IT .OBJ>
			      <MOVE .OBJ ,DUMMY-OBJECT>)>
		       <SET OBJ .NXT>>)>

       ; "Print whatever's left in a nice sentence"

	<SET OBJ <FIRST? ,HERE>>
	<COND (<T? .OBJ>
	       <REPEAT ()
		       <COND (<T? .OBJ>
			      <SET NXT <NEXT? .OBJ>>
			      <COND (<T? .1ST?>
				     <SET 1ST? <>>
				   ; <CRLF>
				     <COND (<EQUAL? .THING ,HERE>
					    <CRLF>
					    <COND (<T? .NXT>
						   <TELL ,YOU-SEE>)
						  (<IS? .OBJ ,PLURAL>
						   <TELL "There are ">)
						  (T
						   <TELL "There's ">)>)>)
				    (T
				     <COND (<T? .NXT>
					    <TELL ", ">)
					   (T
					    <TELL " and ">)>)>
			      <TELL A .OBJ>
			      <COND (<IS? .OBJ ,LIGHTED>
				     <TELL " (providing light)">)>
			    ; <COND (<AND <IN? .OBJ ,PLAYER>
					  <IS? .OBJ ,WORN>>
				     <TELL " (being worn)">)>
			      <COND (<AND <SEE-INSIDE? .OBJ>
					  <SEE-ANYTHING-IN? .OBJ>>
				     <MOVE .OBJ ,X-OBJECT>)>
			      <COND (<AND <ZERO? .IT?>
					  <ZERO? .TWO?>>
				     <SET IT? .OBJ>)
				    (T
				     <SET TWO? T>
				     <SET IT? <>>)>
			      <SET OBJ .NXT>)
			     (T
			      <COND (<AND <T? .IT?>
					  <ZERO? .TWO?>>
				     <THIS-IS-IT .IT?>)>
			      <COND (<EQUAL? .THING ,HERE>
				     <TELL " here">)>
			      <PRINTC 46>
			      <SET ANY? T>
			      <RETURN>)>>)>
	<SET OBJ <FIRST? ,X-OBJECT>>
	<REPEAT ()
		<COND (<ZERO? .OBJ>
		       <RETURN>)
		      (<IS? .OBJ ,SURFACE>
		       <TELL " On ">)
		      (T
		       <TELL " Inside ">)>
		<SET ANY? T>
		<TELL THE .OBJ " you see ">
		<PRINT-CONTENTS .OBJ>
		<PRINTC 46>
		<SET OBJ <NEXT? .OBJ>>>
	<COND (<T? .ANY?>
	       <CRLF>)>
	<MOVE-ALL ,X-OBJECT .THING>
	<MOVE-ALL ,DUMMY-OBJECT .THING>
	<RTRUE>>

<ROUTINE SEE-ANYTHING-IN? (THING "AUX" OBJ)
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RFALSE>)
		       (<AND <NOT <IS? .OBJ ,NODESC>>
			     <NOT <EQUAL? .OBJ ,WINNER>>>
			<RTRUE>)
		       (T
			<SET OBJ <NEXT? .OBJ>>)>>
	 <RFALSE>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TBL)
	 <SET TBL <GETPT .OBJ2 ,P?GLOBAL>>
	 <COND (<ZERO? .TBL>
		<RFALSE>)
	       (<INTBL? .OBJ1 .TBL </ <PTSIZE .TBL> 2>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GOT? (OBJ)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <IN? .OBJ ,POCKET>>
		<RTRUE>)
	       (<HELD? .OBJ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HELD? (OBJ "AUX" L)
	 <COND (<ZERO? .OBJ>
		<RFALSE>)
	       (<AND <NOT <IS? .OBJ ,TAKEABLE>>
		     <NOT <IS? .OBJ ,TRYTAKE>>>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<EQUAL? .L <> ,ROOMS ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER>
		<RTRUE>)
	       (<AND <EQUAL? ,WINNER ,PLAYER>
		     <EQUAL? .L ,POCKET>>
		<RFALSE>)
	       (T
		<HELD? .L>)>>

<ROUTINE ITS-CLOSED ("OPTIONAL" (OBJ <>))
	 <COND (<ZERO? .OBJ>
		<SET OBJ ,PRSO>)>
	 <THIS-IS-IT .OBJ>
	 <TELL CTHE .OBJ>
	 <IS-ARE .OBJ>
	 <TELL "closed." CR>
	 <RTRUE>>

"Reprint a validated sentence."

<ROUTINE PRINT-SENTENCE ("AUX" (WPTR 1) (WLEN 4) (CPTR 5) (WCNT 1)
			       CNT WRD LEN PTR CHAR)
	 <REPEAT ()
		 <SET WRD <GET ,P-LEXV .WPTR>>
		 <COND (<EQUAL? .WRD ,W?QUOTE>
			T)
		       (<EQUAL? .WRD ,W?PERIOD ,W?\! ,W??>
			<RTRUE>)
		       (<OR <EQUAL? .WRD ,W?COMMA>
			    <AND <EQUAL? .WRD ,W?THEN>
			     	 <EQUAL? <GETB ,P-LEXV .WLEN> 1>>>
			<TELL ",">)
		       (T
			<COND (<NOT <EQUAL? .WCNT 1>>
			       <PRINTC 32>)>
			<SET LEN <GETB ,P-LEXV .WLEN>> ; "Length of word."
	 	 	<SET PTR <GETB ,P-LEXV .CPTR>> ; "Point to 1st char."

		      ; "Print word, cap 1st char if 1st word or proper noun."

		 	<SET CNT 1> ; "Init char count."
	 	 	<REPEAT ()
		 	 	<SET CHAR <GETB ,P-INBUF .PTR>>
		 	 	<COND (<AND <EQUAL? .CNT 1>
			     	     	    <OR <EQUAL? .WCNT 1>
						<EQUAL? .WRD ,W?NE ,W?NW>
						<EQUAL? .WRD ,W?SE ,W?SW>
						<INTBL? .WRD ,CAPS ,NUMCAPS>>>
				       <SET CHAR <- .CHAR 32>>)>
				<COND (<AND <G? .CHAR 31>
					    <L? .CHAR 123>>
				       <PRINTC .CHAR>)>
		 		<COND (<EQUAL? .CNT 1>
				       <COND (<EQUAL? .WRD ,W?NE ,W?SE>
			       		      <TELL "E">
					      <RETURN>)
			      		     (<EQUAL? .WRD ,W?NW ,W?SW>
			       		      <TELL "W">
					      <RETURN>)>)>
				<INC PTR>
		 		<COND (<IGRTR? CNT .LEN>
			       	       <RETURN>)>>
		      ; <COND (<EQUAL? .WRD ,W?L>
			       <TELL "ook">)
			      (<EQUAL? .WRD ,W?N>
			       <TELL "orth">)
			      (<EQUAL? .WRD ,W?S>
			       <TELL "outh">)
			      (<EQUAL? .WRD ,W?E>
			       <TELL "ast">)
			      (<EQUAL? .WRD ,W?W>
			       <TELL "est">)
			      (<EQUAL? .WRD ,W?I>
			       <TELL "nventory">)
			      (<EQUAL? .WRD ,W?Q>
			       <TELL "uitter">)
			      (<EQUAL? .WRD ,W?T>
			       <TELL "ime">)
			      (<EQUAL? .WRD ,W?U>
			       <TELL "p">)
			      (<EQUAL? .WRD ,W?D>
			       <TELL "own">)>)>
		 <COND (<IGRTR? WCNT ,INLEN>
			<RTRUE>)>
		 <SET WPTR <+ .WPTR 2>>
		 <SET WLEN <+ .WLEN 4>>
		 <SET CPTR <+ .CPTR 4>>>
	 <RTRUE>>

"Input save buffers; first byte hold length of string, zero if none."

<GLOBAL INSAVE-A:TABLE <ITABLE BYTE 81>>
<GLOBAL INSAVE-B:TABLE <ITABLE BYTE 81>>
<GLOBAL INSAVE-C:TABLE <ITABLE BYTE 81>>

<ROUTINE SAVE-INPUT ("AUX" (TOKENS 1) (LPTR 4) (EPTR 1) (SPTR 1) (PER <>)
			  	SAVLEN CNT WLEN WPTR X)
	 <SET SAVLEN <GETB ,P-LEXV 1>>
	 <COND (<ZERO? .SAVLEN>
		<RFALSE>)>

       ; "Rotate next table into position."

	 <SET X ,INSAVE-C>
	 <SETG INSAVE-C ,INSAVE-B>
	 <SETG INSAVE-B ,INSAVE-A>
	 <SETG INSAVE-A .X>

       ; "Copy last input line into INSAVE-A."

	 <REPEAT ()
		 <SET X <GET ,P-LEXV .EPTR>>
		 <COND (<EQUAL? .X ,W?COMMA>
			<SET PER <>>
			<PUTB ,INSAVE-A .SPTR 44>
			<COND (<IGRTR? SPTR 79>
			       <RETURN>)>)
		       (<EQUAL? .X ,W?QUOTE>
			T
		      ; <SET PER <>>
		      ; <PUTB ,INSAVE-A .SPTR 34>
		      ; <COND (<IGRTR? SPTR 79>
			       <RETURN>)>)
		       (<EQUAL? .X ,W?PERIOD ,W?? ,W?\!>
			<COND (<ZERO? .PER>
			       <SET PER T>
			       <PUTB ,INSAVE-A .SPTR
				     <COND (<EQUAL? .X ,W?PERIOD> 46)
					   (<EQUAL? .X ,W??> 63)
					   (T 33)>>
			       <COND (<IGRTR? SPTR 79>
				      <RETURN>)>)>)
		       (T ; "Move word to INSAVE-A."
			<COND (<AND <G? .TOKENS 1>
				    <L? .SPTR 80>>
			       <PUTB ,INSAVE-A .SPTR 32> ; "Add a space."
			       <INC SPTR>)>
			<SET WLEN <GETB ,P-LEXV .LPTR>>
			<SET PER <>>
			<SET WPTR <GETB ,P-LEXV <+ .LPTR 1>>> ; "Char ptr."
			<SET CNT 1> ; "Init # chars moved."
			<REPEAT ()
				<SET X <GETB ,P-INBUF .WPTR>>
				<COND (<AND <G? .X 96> ; "All caps."
					    <L? .X 123>>
				       <SET X <- .X 32>>)>
				<PUTB ,INSAVE-A .SPTR .X> ; "Move char."
				<INC WPTR> ; "Point to next char."
				<COND (<OR <IGRTR? SPTR 79> ; "Overflow?"
					   <IGRTR? CNT .WLEN>> ; "Word done?"
				       <RETURN>)>>)>
		 <SET LPTR <+ .LPTR 4>> ; "Update P-LEXV pointers."
		 <SET EPTR <+ .EPTR 2>>
		 <COND (<G? .SPTR 79> ; "Overflowed?"
			<SET SPTR 79> ; "Back up and exit."
			<RETURN>)
		       (<IGRTR? TOKENS .SAVLEN> ; "Exit if no more tokens."
			<RETURN>)>>
	 <PUTB ,INSAVE-A 0 <- .SPTR 1>> ; "Remember length of line."
	 <RTRUE>>
