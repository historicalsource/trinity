"PEOPLE for TRINITY: (C)1986 Infocom, Inc. All rights reserved."

"*** JAPANESE WOMAN ***"

<OBJECT JWOMAN
	(LOC LAN-GATE)
	(DESC "old woman")
	(FDESC "An old woman is standing under the tree.")
	(FLAGS NODESC FEMALE VOWEL PERSON LIVING)
	(SYNONYM WOMAN LADY CRONE MADAM MADAME MATRON DAME FACE)
	(ADJECTIVE OLD AGED ANCIENT JAP JAPANESE ORIENTAL YELLOW)
	(ACTION JWOMAN-F)>

"CHILLY = gone."

<ROUTINE JWOMAN-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<IS? ,JWOMAN ,CHILLY>
		<SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
		<COND (<VERB? FOLLOW FIND WHERE>
		       <TELL "You'd never find her in this crowd." CR>)
		      (T
		       <GONE-NOW ,JWOMAN>)>
		<RFATAL>)>
	 <MAKE ,JWOMAN ,TOUCHED>
	 <COND (<NOT <VERB? EXAMINE SEARCH>>
		<TELL "You begin to ">
		<COND (<AND <THIS-PRSO?>
		     	    <INTBL? ,PRSA ,TALKVERBS ,NTVERBS>>
		       <TELL "address the " D ,JWOMAN
			     ", but suddenly fall silent">)
		      (T
		       <TELL "approach the " D ,JWOMAN
			     ", but stop in your tracks">)>
		<TELL ,PCR>)>
	 <TELL "Her face is wrong.|
|
You look a little closer and shudder to " D ,ME ,PTHE
"entire left side of her head is scarred with deep red lesions, twisting her oriental features into a hideous mask. She must have been in an accident or something." CR>
	 <DEQUEUE I-BLOW>
	 <I-BLOW>
	 <RFATAL>>
	        
"*** BIRD WOMAN ***"

<OBJECT BWOMAN
	(LOC BROAD-WALK)
	(DESC "bird woman")
	(FDESC "An aged woman is selling crumbs nearby.")
	(FLAGS NODESC LIVING PERSON FEMALE)
	(SYNONYM WOMAN LADY CRONE MADAM MADAME DAME)
	(ADJECTIVE BIRD AGED OLD ANCIENT)
	(ACTION BWOMAN-F)>

"NODESC = unseen, SEEN = just referenced."
	      
<ROUTINE DIN-DROWNS ()
	 <TELL "The din of ">
	 <COND (<ZERO? ,RAID?>
		<TELL "cooing " D ,PIGEONS>)
	       (T
		<TELL D ,SIRENS>)>
	 <TELL " drowns out your words." CR>
	 <RTRUE>>

<ROUTINE BWOMAN-F ("OPTIONAL" (CONTEXT <>) "AUX" (Y <>) CNT TBL X)
	 <COND (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<T? ,RAID?>
		       <DIN-DROWNS>
		       <RTRUE>)
		      (<VERB? TELL-ABOUT>
		       <COND (<PRSO? ME>
			      <ASK-BWOMAN-ABOUT ,PRSI>
			      <RTRUE>)>
		       <BWOMAN-SNORTS>
		       <RTRUE>)
		      (<VERB? ASK-ABOUT>
		       <COND (<PRSO? ME>
		       	      <TELL "\"Why not tell me about "
			     	    THEI " " D ,ME "?\" scoffs the "
		                    D ,BWOMAN ,PERIOD>
		              <RTRUE>)>
		       <BWOMAN-SNORTS>
		       <RTRUE>)
		      (<VERB? ASK-FOR>
		       <COND (<PRSO? ME>
			      <TELL 
"\"I won't beg from the likes o' you,\" sniffs the " D ,BWOMAN ,PERIOD>
			      <RTRUE>)>
		       <BWOMAN-SNORTS>
		       <RTRUE>)
		      (<VERB? WHAT WHO WHERE>
		       <ASK-BWOMAN-ABOUT ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? SGIVE SSELL SSHOW>
			    <PRSI? GBAG>>
		       <COND (<PRSO? ME>
			      <NOT-A-FARTHING>
			      <RTRUE>)>
		       <BWOMAN-SNORTS>
		       <RTRUE>)
		      (<AND <VERB? GIVE SELL SHOW>
			    <PRSO? GBAG>>
		       <COND (<PRSI? ME>
			      <NOT-A-FARTHING>
			      <RTRUE>)>
		       <BWOMAN-SNORTS>
		       <RTRUE>)>
		<DIN-DROWNS>
		<RTRUE>)
	       (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <BAD-COO>
		       <RTRUE>)
		      (<VERB? GIVE SHOW>
		       <MAKE ,BWOMAN ,SEEN>
		       <COND (<T? ,RAID?>
			      <TELL "She's too frightened to respond." CR>
			      <RTRUE>)
			     (<PRSO? COIN>
			      <REMOVE ,COIN>
			      <MOVE ,GBAG ,LOCAL-GLOBALS>
			      <UNMAKE ,COIN ,TAKEABLE>
			      <MOVE ,SCOIN ,BWOMAN>
			      <SETG P-IT-OBJECT ,SCOIN>
			      <MOVE ,BAG ,BWOMAN>
			      <TELL "\"Bless yer,\" coos the " D ,BWOMAN
", taking your money with a practiced snatch. \"Twenty p's the change.\" She holds out a " 
D ,BAG " and a " D ,SCOIN " for you." CR>
			      <COND (<ZERO? ,TR?>
				     <UPDATE-SCORE>)>
			      <RTRUE>)
			     (<PRSO? SCOIN>
			      <NOT-A-FARTHING>
			      <RTRUE>)
			     (<PRSO? CREDIT-CARD>
			      <TELL
"\"I ain't Harrod's, dearie. Thirty p.\"" CR>
			      <RTRUE>)
			     (<VERB? SHOW>
			      <RFALSE>)>
		       <TELL CTHEI 
" shakes her head. \"Keep it, dearie.\"" CR>
		      <RTRUE>)>
		<RFALSE>)
	       (<VERB? ASK-ABOUT>
		<COND (<T? ,RAID?>
		       <DIN-DROWNS>
		       <RTRUE>)>
		<ASK-BWOMAN-ABOUT ,PRSI>
		<RTRUE>)			     
	       (<VERB? EXAMINE>
		<COND (<ZERO? ,RAID?>
		       <TELL 
"You get the feeling that she's been selling crumbs on this same bench, year after year, since well before you were born. Her face is lined with care for her feathered charges, who perch on her round shoulders without fear." CR>
		       <RTRUE>)>
		<TELL
"She's obviously terrified by all the sirens and commotion." CR>
		<RTRUE>)
	       (<VERB? ASK-FOR>
		<COND (<T? ,RAID?>
		       <DIN-DROWNS>
		       <RTRUE>)>
		<MAKE ,BWOMAN ,SEEN>
		<COND (<PRSI? GBAG BAG EBAG>
		       <TELL "\"A rare bargain at thirty p.\"" CR>
		       <RTRUE>)
		      (<IS? ,PRSI ,TAKEABLE>
		       <TELL "\"I ain't got no " D ,PRSI ", ducky.\"" CR>
		       <RTRUE>)>
		<TELL "\"I couldn't give you that!\" laughs the "
		       D ,PRSO ,PERIOD>
		<RTRUE>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<BAD-COO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BAD-COO ()
	 <TELL 
"A threatening coo from the " D ,PIGEONS ,CHANGES>
	 <RTRUE>>

<ROUTINE NOT-A-FARTHING ()
	 <TELL "\"Thirty p, not a farthing less.\"" CR>
	 <RTRUE>>

<ROUTINE BWOMAN-SNORTS ("AUX" (Q <>))
	 <MAKE ,BWOMAN ,SEEN>
	 <COND (<PROB 50>
		<SET Q T>
		<TELL CTHE ,BWOMAN " snorts ruefully. ">)>
	 <TELL "\"You're daft!\"">
	 <COND (<OR <T? .Q>
		    <PROB 50>>
		<CRLF>
		<RTRUE>)>
	 <TELL " snorts the " D ,BWOMAN ,PERIOD>
	 <RTRUE>>

<ROUTINE ASK-BWOMAN-ABOUT (OBJ "AUX" (Q <>) CNT TBL X V)
	 <MAKE ,BWOMAN ,SEEN>
	 <COND (<EQUAL? .OBJ ,GTRINITY ,PLUTONIUM>
		<COND (<L? <GETB 0 33> 79>
		       <TELL CTHE ,BWOMAN " just smiles." CR>
		       <RTRUE>)>
		<V-$CREDITS>
		<RTRUE>)
	       (<IS? .OBJ ,TOLD>
		<TELL CTHE ,BWOMAN
" scowls. \"Pay attention, ducky! I told ye once already.\"" CR>
		<RTRUE>)>
	 
       ; "Check list of interesting subjects."

	 <SET V <VISIBLE? .OBJ>>
	 <SET CNT <GET ,BWOMAN-SUBJECTS 0>>
	 <REPEAT ()
		 <SET TBL <GET ,BWOMAN-SUBJECTS .CNT>>
		 <SET X <GET .TBL 0>>
		 <COND (<EQUAL? .X .OBJ>
			<COND (<AND <ZERO? .V>
				    <IS? .OBJ ,TAKEABLE>>
			       T)
			      (T
			       <MAKE .OBJ ,TOLD>
			       <TELL "\"" <GET .TBL 1>>
			       <COND (<PROB 50>
			       	      <TELL ".\"" CR>
			       	      <RTRUE>)>
			       <TELL ",\" replies the " D ,BWOMAN ,PERIOD>
		               <RTRUE>)>)>
		 <COND (<DLESS? CNT 1>
			<RETURN>)>>
	 
       ; "Default for other items she might know about."

	 <COND (<EQUAL? .OBJ ,WRISTWATCH>
		<TELL CTHE ,BWOMAN>
		<COND (<EQUAL? ,W?TIME <GET ,P-NAMW 1> <GET ,P-OFW 1>>
		       <TELL " sighs. \"Time.\"" CR>
		       <RTRUE>)>
		<TELL " sniffs. \"Looks cheap.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,RUBY>
		<MAKE .OBJ ,TOLD>
		<TELL CTHE ,BWOMAN>
		<COND (<EQUAL? ,RUBYROOM ,BROAD-WALK>
		       <TELL 
" gives you a sad smile. \"Not to worry, dear,\" she sighs. \"Ye'll get it back by and by.\"" CR>
		       <RTRUE>)>
		<TELL 
" peers at you closely. \"'Ave ye seen one?\" she whispers. \"Wouldn't let it out o' my sight if I was you.\"" CR>
		<RTRUE>)
	       (<EQUAL? .OBJ ,MEEP>
		<MAKE .OBJ ,TOLD>
		<TELL CTHE ,BWOMAN>
		<COND (<EQUAL? ,RUBYROOM ,BROAD-WALK>
		       <TELL " giggles. \"Fast, ain't he?\"" CR>
		       <RTRUE>)>
		<TELL 
" gives you a sharp look, but doesn't reply." CR>
		<RTRUE>)
	       (<OR <T? .V>
		    <IN? .OBJ ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? .OBJ ,BROAD-WALK>>
		<MAKE .OBJ ,TOLD>
		<COND (<PROB 50>
		       <SET Q T>
		       <TELL CTHE ,BWOMAN " shrugs. ">)>
	 	<TELL "\"">
		<COND (<PROB 50>
		       <TELL "You know as much as I do">)
		      (T
		       <TELL "Don't know nothin' you don't">)>
		<COND (<PROB 50>
		       <TELL ", hon">)>
		<COND (<OR <T? .Q>
		    	   <PROB 50>>
		       <TELL ".\"" CR>
		       <RTRUE>)>
	 	<TELL ",\" shrugs the " D ,BWOMAN ,PERIOD>
		<RTRUE>)>
	 
       ; "Default for all other cases."
	 
	 <COND (<PROB 50>
		<SET Q T>
		<TELL CTHE ,BWOMAN " scowls. ">)>
	 <TELL "\"Don't know what you're talkin' 'bout, ducky">
	 <COND (<OR <T? .Q>
		    <PROB 50>>
		<TELL ".\"" CR>
		<RTRUE>)>
	 <TELL ",\" scowls the " D ,BWOMAN ,PERIOD>
	 <RTRUE>>	 

<GLOBAL BWOMAN-SUBJECTS:TABLE
	<PLTABLE
	 <PTABLE LCITY
"Lived 'ere all me life">
	 <PTABLE LONDON
"Lived 'ere all me life">
	 <PTABLE BALL
"Football! Sorry, hon, I'm too old to play">
	 <PTABLE GRPOND
"It's just east o' here">
	 <PTABLE LWATER
"A short walk east">
	 <PTABLE VICTORIA
"Princess Louise carved it all herself, she did">
	 <PTABLE GBAG
"Lovely bread crumbs, only thirty p a bag">
	 <PTABLE BAG
"Lovely bread crumbs, only thirty p a bag">
	 <PTABLE GNOMON
"A lovely bit o' metal! And so useful. Hold onto it, ducky">
	 <PTABLE PIGEONS
"'Ave ye ever seen such beauties? So loyal. And so, so hungry">
	 <PTABLE SCOIN
"That's yer change, ducky. Twenty p out of fifty">
	 <PTABLE CREDIT-CARD
"I ain't Harrod's, dearie. Thirty p">
	 <PTABLE PRAM
"All prams lead to Kensington Gardens, they say">
	 <PTABLE BOY
"Lots o' boys around here, dearie">
	 <PTABLE GRASS
"Humph!\" she sniffs. \"Never touch the stuff">
	 <PTABLE CRANE
"Tidy bit o' foldin', that">
	 <PTABLE OCRANE
"Looks a bit ragged to me">
	 <PTABLE BAD-CRANE
"Looks a bit crumpled to me">
	 <PTABLE PARASOL
"Ain't seen one like it in a long while">
	 <PTABLE MEMORIAL
"Ghastly, ain't he? Everyone laughs">
	 <PTABLE BWOMAN
"Me?\" The woman laughs and gestures at the pigeons. \"Here's all there is to know about me">
	 <PTABLE GOON
"Shh!\" The old woman shudders. \"Ye musn't speak o' such things">>> 

"*** GOON ***"

<OBJECT GOON
	(DESC "corpse")
	(FLAGS SURFACE TRYTAKE)
	(CAPACITY 20)
	(SYNONYM CORPSE CADAVER STIFF BODY SORCERER DEITY WABEWALKER
	 	 REMAINS)
        (ADJECTIVE ANCIENT SHRUNKEN DECOMPOSED)
	(ACTION GOON-F)>

<ROUTINE GOON-F ("OPTIONAL" (CONTEXT <>) "AUX" R G)
	 <COND (<THIS-PRSI?>
		<COND (<VERB? PUT-ON PUT WRAP-AROUND>
		       <COND (<PRSO? BANDAGE SHROUD>
			      <MOVE ,PRSO ,PRSI>
			      <MAKE ,PRSO ,NODESC>
			      <TELL "You awkwardly wrap the " D ,PRSO
				    " around the " D ,PRSI>
			      <COND (<PRSO? BANDAGE>
				     <UNMAKE ,GOON-MOUTH ,OPENED>
				     <TELL "'s head and jaw">)>
			      <TELL ", as before." CR>
			      <RTRUE>)
			     (<VERB? WRAP-AROUND>
			      <RFALSE>)
			     (<PRSO? RBOOT GBOOT>
			      <MOVE ,PRSO ,PRSI>
			      <MAKE ,PRSO ,NODESC>
			      <TELL "You awkwardly force the " D ,PRSO
				    " back onto the " D ,PRSI "'s foot." CR>
			      <RTRUE>)>
		       <WASTE-OF-TIME>
		       <RTRUE>)>
		<RFALSE>)>
	 <SETG P-IT-OBJECT ,GOON>
	 <COND (<VERB? EXAMINE SEARCH>
		<TELL "The solemn dignity of the " D ,CRYPT
" makes you suspect that the remains may be those of some great missionary or explorer. The shrunken">
		<COND (<IS? ,SHROUD ,NODESC>
		       <TELL " body is wrapped in a gray " D ,SHROUD>)
		      (T
		       <TELL ", unclothed body is badly decomposed">)>
		<TELL ", and its wrinkled " D ,GOON-MOUTH " is ">
		<COND (<IS? ,BANDAGE ,NODESC>
		     ; <SETG P-IT-OBJECT ,BANDAGE>
		       <TELL "held shut with a " D ,BANDAGE
			     " wrapped around its head">)
		      (T
		       <TELL "hanging wide open">)>
		<SET R <IN? ,RBOOT ,PRSO>>
		<SET G <IN? ,GBOOT ,PRSO>>
		<COND (<AND <T? .R>
			    <T? .G>>
		     ; <SETG P-IT-OBJECT ,RBOOT>
		       <TELL 
,PA "pair of boots, one red and one green, completes the ghastly wardrobe">)
		      (<T? .R>
		       <ONE-CLAD ,RBOOT>)
		      (<T? .G>
		       <ONE-CLAD ,GBOOT>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? KILL MUNG KICK BITE CUT RIP>
		<NOT-LIKELY ,GOON "would react">
		<RTRUE>)
	       (<HANDLE-CORPSE?>
		<RTRUE>)
	       (<VERB? DRESS>
		<COND (<IS? ,SHROUD ,NODESC>
		       <ITS-ALREADY "wrapped in the shroud">
		       <RTRUE>)
		      (<GOT? ,SHROUD>
		       <PERFORM ,V?PUT-ON ,SHROUD ,PRSO>
		       <RTRUE>)>
		<HOW?>
		<RTRUE>)
	       (<VERB? UNDRESS>
		<COND (<IS? ,SHROUD ,NODESC>
		       <PERFORM ,V?TAKE ,SHROUD>
		       <RTRUE>)>
		<TELL "You've already done that." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL "You struggle briefly with " THEO
		      ", but it's just too awkward." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ONE-CLAD (BOOT)
       ; <SETG P-IT-OBJECT .BOOT>
	 <TELL ". One foot is clad in a " D .BOOT>
	 <RTRUE>>

<OBJECT GOON-MOUTH
	(LOC GOON)
	(DESC "mouth")
	(FLAGS NODESC CONTAINER OPENABLE)
	(SYNONYM MOUTH JAW JAWS JAWBONE HEAD)
	(ADJECTIVE CORPSE\'S)
	(CAPACITY 1)
	(ACTION GOON-MOUTH-F)>

<ROUTINE GOON-MOUTH-F ()
	 <COND (<THIS-PRSI?>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<MAKE ,BCOIN ,NOALL>
		<TELL "The">
		<OPEN-CLOSED ,PRSO>
		<TELL " is blue and wrinkled">
		<COND (<AND <IS? ,PRSO ,OPENED>
			    <SEE-ANYTHING-IN? ,PRSO>>
		       <TELL ". Inside it you can see ">
		       <PRINT-CONTENTS ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "It falls open again horribly." CR>
		       <RTRUE>)>
		<ITS-ALREADY "closed">
		<RTRUE>)
	       (<VERB? OPEN>
		<COND (<IS? ,PRSO ,OPENED>
		       <ITS-ALREADY "open">
		       <RTRUE>)>
		<BANDAGE-STOPS-YOU>
		<RTRUE>)
	       (<VERB? MOVE PULL PUSH LOOSEN>
		<COND (<IS? ,PRSO ,OPENED>
		       <TELL "It's quite loose." CR>
		       <RTRUE>)>
		<BANDAGE-STOPS-YOU>
		<RTRUE>)
	       (<HANDLE-CORPSE?>
		<RTRUE>)
	       (T
		<RFALSE>)>>
   
<ROUTINE BANDAGE-STOPS-YOU ()
	 <SETG P-IT-OBJECT ,BANDAGE>
	 <TELL CTHE ,P-IT-OBJECT " is holding it tightly shut." CR>
	 <RTRUE>>

<ROUTINE HANDLE-CORPSE? ()
	 <COND (<VERB? SMELL>
		<SMELLS-OF-DEATH>
		<RTRUE>)
	       (<AND <VERB? TOUCH SHAKE SQUEEZE KNOCK>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<TELL CTHEO " feels cold and dry." CR>
		<RTRUE>)
	       (<VERB? KISS RAPE BLOW-INTO>
		<VOICE-MUTTERS "Sicko" <>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"*** CHARON ***"

<OBJECT CHARON
	(LOC DORY)
	(DESC "oarsman")
	(FLAGS NODESC LIVING VOWEL CONTAINER SURFACE)
	(SYNONYM BOATMAN OARSMAN MAN CHARON HAND PALM)
	(ADJECTIVE DARK OARS HIS)
	(ACTION CHARON-F)>

"TOUCHED = oarsman seen, CHILLY = referred to by name, NOALL = seen wardrobe."

<ROUTINE CHARON-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<AND <NOUN-USED? ,W?HAND ,W?PALM>
		     <NOT <ADJ-USED? ,W?HIS>>>
		<TELL "[" D ,HANDS ,BRACKET>
		<COND (<THIS-PRSO?>
		       <PERFORM ,PRSA ,HANDS ,PRSI>
		       <RTRUE>)>
		<PERFORM ,PRSA ,PRSO ,HANDS>
		<RTRUE>)
	       (<AND <NOT <IS? ,CHARON ,CHILLY>>
		     <NOUN-USED? ,W?CHARON>>
		<MAKE ,CHARON ,CHILLY>
		<VOICE-MUTTERS "So educated">)>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? THROW THROW-OVER>
		       <DEMEANOR>
		       <RTRUE>)
		      (<VERB? GIVE SHOW>
		       <COND (<ZERO? ,IN-DORY?>
			      <YOUD-HAVE-TO "get in" ,DORY>
			      <RTRUE>)>
		       <TELL CTHEI>
		       <COND (<VERB? SHOW>
			      <COND (<IS? ,PRSO ,WORN>
				     <TELL " glances at " THEO 
" you're wearing, but shows no interest." CR>
				     <RTRUE>)>
			      <TELL " confiscates ">)
			     (T
			      <TELL " accepts ">)>
		       <TELL THEO>
		       <COND (<PRSO? BCOIN>
			      <STYX-TRIP>
			      <RTRUE>)
			     (<PRSO? CREDIT-CARD>
			      <VANISH>
			      <TELL 
" and checks it against a list of delinquent accounts">
			      <SOLEMNLY>
			      <TELL 
", rips the card in half and throws the pieces in the river." CR>
			      <RTRUE>)
			     (<PRSO? SCOIN>
			      <VANISH>
			      <TELL 
", peers at it carefully and compares it to a " D ,BCOIN 
" given to him by one of the " D ,SHADES ,PTHE "difference is obvious">
			      <SOLEMNLY>
			      <TELL 
" and tosses your coin into the river." CR>
			      <RTRUE>)>
		       <MOVE ,PRSO ,HERE>
		       <TELL 
", glances at it briefly and tosses it onto the " D ,BEACH ,PERIOD>
		       <RTRUE>)
		      (<VERB? PUT PUT-ON EMPTY-INTO>
		       <COND (<NOUN-USED? ,W?HAND ,W?PALM>
			      <PERFORM ,V?GIVE ,PRSO ,PRSI>
			      <RTRUE>)>
		       <IMPOSSIBLE>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<MAKE ,PRSO ,TOUCHED>
		<TELL CTHEO
"'s face and form are concealed under a hooded cloak. His bent posture suggests great age, but he handles his vessel with a firm, confident hand that commands respect." CR>
		<RTRUE>)
	       (<VERB? WATCH>
		<I-STYX <>>
		<RTRUE>)
	       (<VERB? WAVE-AT>
		<TELL CTHEI " doesn't respond to your gesture." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO>
		<COND (<OR <T? ,IN-DORY?>
			   <AND <HERE? DOCKSIDE>
				<EQUAL? ,STICKS 3 4 5>>
			   <AND <HERE? ON-BEACH>
				<EQUAL? ,STICKS 10>>>
		       <TELL " pretends not">)
		      (T
		       <TELL " is probably too far away">)>
		<TELL " to hear you." CR>
		<RFATAL>)
	       (<OR <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		    <INTBL? ,PRSA ,HURTVERBS ,NHVERBS>>
		<COND (<ZERO? ,IN-DORY?>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<DEMEANOR>
		<RTRUE>)
	     ; (<AND <VERB? TOUCH SQUEEZE SHAKE PUSH PULL MOVE TURN PUSH-TO
		       	    REACH-IN TAKE>
		     <EQUAL? ,PRSI <> ,HANDS>>
		<COND (<ZERO? ,IN-DORY?>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<TELL "Your hand reaches into a cold vapor." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SOLEMNLY ()
	 <TELL ". He shakes his head solemnly">
	 <RTRUE>>

<ROUTINE DEMEANOR ()
	 <TELL
"Something about the " D ,CHARON "'s demeanor" ,CHANGES>
	 <RTRUE>>

<ROUTINE STYX-TRIP ()
	 <TELL " and nods at you solemnly." CR>
	 <VANISH>
	 <EXIT-DORY>	       
	 <COND (<EQUAL? ,STICKS 3 4>
		<I-STYX>)>
	 <SETG STICKS 10>
	 <MOVE ,DORY ,ON-BEACH>
	 <MAKE ,DORY ,TOUCHED>
	 <REMOVE ,SHADES>
	 <TELL CR CTHEI 
" pushes away from the beach.|
|
Planes of mist close in around the dory, drawing it deeper into the gloom. The only sound is the rhythmic slurp of the oar as it plies the dark, oily water.">
	 <CARRIAGE-RETURNS>
	 <TELL 
"A vague outline emerges beyond the helm. It slowly resolves into a spit of sand, damp and cheerless in the surrounding murk" ,PCR CTHEI
" swings the dory around and lands it with barely a jolt. ">
	 <ONE-BY-ONE>
	 <TELL ". Something in the " D ,PRSI
"'s gaze compels you to follow them" ,PCR>
	 <GOTO ,ON-BEACH>
	 <RTRUE>>

"*** GIRL ***"

<OBJECT GIRL
	(DESC "girl")
	(FLAGS NODESC PERSON LIVING FEMALE SHADOWY TRYTAKE NOALL)
	(SYNONYM GIRL CHILD KID)
	(ADJECTIVE SMALL LITTLE YOUNG JAP JAPANESE FEMALE)
	(DESCFCN DESCRIBE-GIRL)
	(GENERIC GENERIC-JAPS-F)
	(CONTFCN IN-GIRL)
	(ACTION GIRL-F)>

"CHILLY = brolly given, SEEN = just referenced, SHADOWY = fear delay,
 TOUCHED = said origami, NODESC = not seen."

<ROUTINE IN-GIRL ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL CTHE ,GIRL>
		<COND (<EQUAL? ,MINUTES 0 1>
		       <TELL " urgently">)
		      (<PROB 50>
		       <TELL " playfully">)>
		<COND (<PROB 50>
		       <TELL " snatches ">)
		      (T
		       <TELL " pulls ">)>
		<THE-PRINT <COND (<THIS-PRSI?>
				  ,PRSI)
				 (T
				  ,PRSO)>>
		<TELL " out of your reach." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DESCRIBE-GIRL ("OPTIONAL" (CONTEXT <>) "AUX" (X <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "The little girl is ">
		<COND (<HERE? PLAYGROUND>
		       <TELL "standing nearby">)
		      (<IS? ,GIRL ,CHILLY>
		       <TELL "in the " D ,CORNER>)
		      (T
		       <TELL "standing in the exit">)>
		<COND (<FIRST? ,GIRL>
		       <TELL ", clutching ">
		       <PRINT-CONTENTS ,GIRL>)>
		<TELL ".">
		<RTRUE>)
	       (T
		<RFALSE>)>>
		      
<ROUTINE GIRL-F ("OPTIONAL" (CONTEXT <>) "AUX" X)
	 <UNMAKE ,GIRL ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE>
		       <SET X <FIRST? ,PRSI>>
		       <TELL CTHEI>
		       <COND (<PRSO? PARASOL>
			      <MOVE ,PRSO ,PRSI>
			      <MAKE ,PRSI ,CHILLY>
			      <TELL	       
"'s mouth opens into a little \"o\" at the magnificence of your gift. She humbly ">
			      <COND (<T? .X>
				     <MOVE .X ,PLAYER>
				     <TELL "exchanges " THE .X " for ">)
				    (T
				     <TELL "accepts ">)>
			      <TELL THE ,PRSO ", smiles shyly and ">
			      <MOVE ,PRSI ,IN-SHELTER>
			      <COND (<HERE? IN-SHELTER>
				     <TELL "joins you in ">)
				    (T
				     <TELL "descends into ">)>
			      <TELL THE ,SHELTER " with her prize." CR>
			      <COND (<EQUAL? .X ,CRANE>
				     <START-MCRANE>)>
			      <RTRUE>)
			     (<PRSO? BAD-CRANE OCRANE>
			      <REMOVE ,PRSO>
			      <UNMAKE ,BAD-CRANE ,CHILLY>
			      <UNMAKE ,OCRANE ,CHILLY>
			      <COND (<NOT <IS? ,PRSI ,TOUCHED>>
				     <EYES-BRIGHTEN>
				     <TELL ", ">
				     <COND (<EQUAL? .X <> ,PARASOL>
					    <TELL "accepting ">)
					   (T
					    <MOVE .X ,PLAYER>
					    <TELL "exchanging " THE .X 
						  " for ">)>)    
				    (<EQUAL? .X <> ,PARASOL>
				     <TELL " accepts ">)
				    (T
				     <MOVE .X ,PLAYER>
				     <TELL " exchanges " THE .X " for ">)>
			      <TELL THEO 
" with a gracious bow. Her fingers explore the creases in the paper, bending them this way and that. Then, with a few deft maneuvers, she refolds the sheet to its original shape and ">
			      <COND (<IN? ,PARASOL ,PRSI>
				     <MOVE ,CRANE ,PLAYER>
				     <TELL "hands it back to you." CR>
				     <START-MCRANE>
				     <RTRUE>)>
			      <MOVE ,CRANE ,PRSI>
			      <TELL "holds it up for you to see." CR>
			      <RTRUE>)
			     (<NOT <IN? ,PARASOL ,PRSI>>
			      <COND (<VISIBLE? ,PARASOL>
				     <BROLLY-INTEREST>
				     <TELL ". Nevertheless, she">)>
			      <TELL " politely ">
			      <COND (<EQUAL? .X ,CRANE>
				     <TELL "accepts " THEO
", looks it over briefly and hands it back to you, keeping the "
D .X " for herself." CR>
				     <RTRUE>)
				    (<T? .X>
				     <MOVE .X ,PLAYER>
				     <TELL "exchanges " THE .X " for ">)
				    (T
				     <TELL "accepts ">)>
			      <MOVE ,PRSO ,PRSI>
			      <TELL THEO ", and toys with it absently." CR>
			      <RTRUE>)>
		       <TELL " toys with " THEO
			     " for a moment, but quickly tires of ">
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "them">)
			     (T
			      <TELL "it">)>
		       <TELL " and hands it back to you">
		       <SEE-TWINKLE?>
		       <RTRUE>)			       
		      (<VERB? SHOW>
		       <TELL CTHEI>
		       <COND (<PRSO? PARASOL>
			      <TELL " stares at the " D ,PARASOL
				    " with undisguised longing." CR>
			      <RTRUE>)
			     (<PRSO? BAD-CRANE OCRANE>
			      <EYES-BRIGHTEN>
			      <PRINT ,PERIOD>
			      <RTRUE>)
			     (<NOT <IN? ,PARASOL ,PRSI>>
			      <BROLLY-BETTER>			      
			      <RTRUE>)>
		       <TELL " glances at " THEO
			     ", but exhibits only polite interest">
		       <SEE-TWINKLE?>
		       <RTRUE>)
		      (<AND <VERB? FEED>
			    <PRSO? BAG>>
		       <TELL CTHEI " makes a face." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <MOVE ,PRSO ,HERE>
			      <TELL CTHEI " dodges the flying " D ,PRSO
			     	    " and looks up at you reproachfully" ,PCR
			     	    CTHEO " lands at her feet." CR>
			      <RTRUE>)>
		       <TELL "She catches ">
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "them">)
			     (T
			      <TELL "it">)>
		       <TELL " with a playful laugh">
		       <COND (<OR <PRSO? PARASOL OCRANE BAD-CRANE>
				  <IN? ,PARASOL ,PRSI>>
			      <TELL ,PCR>
			      <PERFORM ,V?GIVE ,PRSO ,PRSI>
			      <RTRUE>)>
		       <TELL " and tosses it back">
		       <COND (<VISIBLE? ,PARASOL>
			      <TELL 
", her eyes hardly leaving the " D ,PARASOL>)>
		       <PRINT ,PERIOD>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE SEARCH>
		<TELL CTHEO " is a cute four or five years old">
		<COND (<SEE-ANYTHING-IN? ,PRSO>
		       <TELL ". She's holding ">
		       <PRINT-CONTENTS ,PRSO>)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? FOLLOW FIND WALK-TO>
		<COND (<OR <NOT <HERE? PLAYGROUND IN-SHELTER>>
			   <IS? ,PRSO ,NODESC>>
		       <REFERRING>
		       <RFATAL>)
		      (<IN? ,PRSO ,HERE>
		       <TELL "She's right here." CR>
		       <RTRUE>)
		      (<HERE? PLAYGROUND>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<DO-WALK ,P?WEST>
		<RTRUE>)
	       (<VERB? WATCH>
		<I-GIRL <>>
		<RTRUE>)>
	 <MAKE ,GIRL ,SEEN>
	 <COND (<VERB? WAVE-AT POINT-AT BOW>
		<TELL CTHEO>
		<COND (<EQUAL? ,MINUTES 1>
		       <TELL " desperately ">)
		      (<PROB 50>
		       <TELL " cheerfully ">)
		      (T
		       <TELL " giggles, then clumsily ">)>
		<TELL "mimics your action." CR>
		<RTRUE>)
	       (<VERB? TAKE TOUCH>
		<GIRL-SHIES>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHEO <PICK-NEXT ,GIRL-HUHS> ,PERIOD>
		<RFATAL>)
	       (<INTBL? ,PRSA ,HURTVERBS ,NHVERBS>
		<TELL "Imagine doing that to a defenseless little girl!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GIRL-SHIES ()
	 <TELL CTHE ,GIRL " backs shyly away." CR>
	 <RTRUE>>

<ROUTINE START-MCRANE ()
	 <SETG P-IT-OBJECT ,CRANE>
	 <MAKE ,CRANE ,LIGHTED>
	 <MAKE ,CRANE ,SEEN>
	 <QUEUE I-NEWCRANE -1>
	 <UPDATE-SCORE 3>
	 <TELL CR "The edges of the " D ,CRANE
	       " begin to flicker faintly." CR>
	 <RTRUE>>

<ROUTINE EYES-BRIGHTEN ()
	 <MAKE ,GIRL ,TOUCHED>
	 <TELL 
"'s eyes brighten with surprise when she sees the " D ,PRSO ". \"">
	 <HLIGHT ,H-ITALIC>
	 <TELL "Origami">
	 <HLIGHT ,H-NORMAL>
	 <TELL ",\" she squeaks">
	 <RTRUE>>

<ROUTINE SEE-TWINKLE? ()
	 <COND (<AND <PRSO? CRANE>
		     <IS? ,PRSO ,LIGHTED>>
		<TELL ". She didn't seem to notice the weird twinkling">)>
	 <PRINT ,PERIOD>
	 <RTRUE>>

<ROUTINE BROLLY-BETTER ()
	 <COND (<VISIBLE? ,PARASOL>
	        <SETG P-IT-OBJECT ,PARASOL>
		<BROLLY-INTEREST>)
	       (<VERB? GIVE>
		<TELL " is too timid to take " THEO>)
	       (T
		<TELL " gives " THEO " a timid glance">)>
	 <PRINT ,PERIOD>
	 <RTRUE>> 

<ROUTINE BROLLY-INTEREST ()
	 <TELL " isn't as interested in " THEO
	       " as she is in that " D ,PARASOL>
	 <RTRUE>>

<GLOBAL GIRL-HUHS:TABLE
	<LTABLE 2
	 " blinks uncomprehendingly"
	 " looks at you blankly"
	 " grins at your funny words"
	 " says something in Japanese">>

"*** BOY/GIANT ***"

<OBJECT BOY
	(LOC AT-TERRACE)
	(DESC "boy")
	(FLAGS PERSON LIVING TRYTAKE NOALL)
	(SYNONYM BOY CHILD KID)
	(ADJECTIVE YOUNG)
	(DESCFCN DESCRIBE-BOY)
	(GENERIC GENERIC-KID-F)
	(ACTION BOY-F)>
	 
<ROUTINE GENERIC-KID-F (TBL)
	 <COND (<IS? ,HERE ,WINDY>
		<RETURN ,BOY>)
	       (<EQUAL? ,W?BOY ,P-NAM ,P-XNAM>
		<RETURN ,GIANT>)
	       (T
		<RFALSE>)>>

"SEEN = Pope quote shown, CHILLY = gone."

<ROUTINE DESCRIBE-BOY ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<TELL "A ">
		<COND (<HERE? PROM>
		       <TELL "rather large ">)
		      (T
		       <TELL "young ">)>
		<TELL "boy sits nearby, listening to a pair of " D ,PHONES
" and idly blowing " D ,SBUBBLE "s. There's a dish full of " 
D ,SOAPY-WATER " by his side">
		<COND (<T? ,IN-DISH?>
		       <TELL ", in which you're now standing">)>
		<PRINTC 46>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BOY-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <TELL			
"The boy is too preoccupied with his music to notice your offer." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<AND <VERB? FOLLOW WHERE>
		     <IS? ,PRSO ,CHILLY>>
		<TELL "You'd never find him in this crowd." CR>
		<RTRUE>)
	       (<VERB? EXAMINE WATCH>
		<I-BOY <>>
		<RTRUE>)
	       (<HANDLE-BOY?>
		<RTRUE>)
	       (<VERB? ALARM TOUCH KICK KNOCK KISS SQUEEZE HIT
		       TOUCH-TO MOVE PUSH PULL RAISE TAKE SHAKE>
		<ANNOY-BOY>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL CTHE ,BOY " doesn't respond" ,AS-IF 
		      "he can't hear you." CR>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE HANDLE-BOY? ()
	 <COND (<VERB? WAVE-AT YELL>
		<TELL CTHEO " does his best to ignore you." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<HEAR-GIANT-MUSIC>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL
"The boy is old enough to use deodorant, but obviously doesn't." CR>
		<RTRUE>)
	       (<VERB? RAPE UNDRESS>
		<RAPE-SCOUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT GIANT
	(LOC PROM)
	(DESC "boy")
	(FLAGS LIVING PERSON TRYTAKE NOALL)
	(SYNONYM GIANT BOY KID CHILD)
	(ADJECTIVE YOUNG GIANT BIG LARGE HUGE)
	(DESCFCN DESCRIBE-BOY)
	(GENERIC GENERIC-KID-F)
	(ACTION GIANT-F)>

<ROUTINE GIANT-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <BOY-NO-HEED>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <REMOVE ,PRSO>
		       <TELL CTHEO " hits the " D ,PRSI
", slides off harmlessly and disappears in the dish." CR CR>
		       <HURT-GIANT>
		       <RTRUE>)
		      (<VERB? PUT-ON>
		       <PRSO-SLIDES-OFF-PRSI>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"The boy measures approximately forty feet from head to toe, and probably weighs several tons. He's wearing a pair of stereo " D ,PHONES ,PERIOD>
		<RTRUE>)
	       (<HANDLE-BOY?>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<BOY-NO-HEED>		
		<RFATAL>)
	       (<INTBL? ,PRSA ,MOVEVERBS ,NMVERBS>
		<TELL "Forget it. This kid is ">
		<ITALICIZE "big.">
		<CRLF>
		<RTRUE>)
	       (<VERB? TOUCH KICK CUT RIP KILL KNOCK SHAKE SQUEEZE BITE>
		<HURT-GIANT>
		<RFATAL>)
	       (<VERB? WALK-TO CLIMB-ON STAND-ON SIT CLIMB-UP CLIMB-OVER
		       RIDE>
		<COND (<T? ,IN-DISH?>
		       <EXIT-DISH-FIRST>
		       <RTRUE>)>
		<TELL CTHEO 
" picks you off his clothes like an insect, and tosses you absently over his shoulder">
		<THROW-TO-CHASM>
		<RFATAL>)
	       (T
		<RFALSE>)>>

<ROUTINE BOY-NO-HEED ()
	 <SAY-BOY-BOPS>
	 <TELL ", but pays no attention." CR>
	 <RTRUE>>
								        
<ROUTINE HURT-GIANT ()
	 <TELL CTHE ,GIANT
" brushes at you absently, like a mosquito">
	 <THROW-TO-CHASM>
	 <RTRUE>>

<ROUTINE EXIT-DISH-FIRST ()
	 <TELL "You'd have to get out of the dish to do that." CR>
	 <RTRUE>>

<ROUTINE THROW-TO-CHASM ()
	 <TELL ,PCR>
	 <SETG IN-DISH? <>>
	 <SETG HERE ,AT-CHASM>
	 <MOVE ,PLAYER ,HERE>
	 <COND (<ZERO? ,SUITED?>
		<DROP-ALL>)>
	 <V-LOOK>
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
	 <TELL CR "You painfully regain your footing." CR>
	 <RTRUE>>
		       
<ROUTINE HEAR-GIANT-MUSIC ()
	 <TELL 
"You hear faint, rhythmic music coming from the " D ,PHONES ,PERIOD>
	 <RTRUE>>

<ROUTINE RAPE-SCOUT ()
	 <TELL 
"There's a name for people who do things like that to boys." CR>
	 <RTRUE>>

"*** ROADRUNNER ***"

<ROUTINE GENERIC-BIRD-F (TBL "AUX" (PTR 6) OBJ)
	 <COND (<EQUAL? ,W?ROADRUNNER ,P-NAM ,P-XNAM>
		<COND (<OR <EQUAL? ,P-ADJ ,W?DEAD ,W?DROWNED>
			   <EQUAL? ,P-XADJ ,W?DEAD ,W?DROWNED>>
		       <RETURN ,DMEEP>)>
		<RETURN ,MEEP>)>
	 <REPEAT ()
		 <SET OBJ <GET ,ALLBIRDS .PTR>>
		 <COND (<OR <EQUAL? ,P-IT-OBJECT .OBJ>
			    <VISIBLE? .OBJ>>
			<RETURN>)
		       (<DLESS? PTR 0>
			<RFALSE>)>>
	 <RETURN .OBJ>> 

<GLOBAL ALLBIRDS:TABLE
	<PTABLE MCRANE BAD-CRANE OCRANE CRANE DMEEP MAGPIE MEEP>>

<OBJECT MEEP
	(DESC "roadrunner")
	(FLAGS NODESC LIVING TRYTAKE PERSON NOALL)
	(SYNONYM BIRD ROADRUNNER)
	(VALUE 0)
	(SIZE 5)
	(MASS 5)
	(GENERIC GENERIC-BIRD-F)
	(DESCFCN DESCRIBE-MEEP)
	(CONTFCN 0)
	(ACTION MEEP-F)>

"CHILLY = perched on box."

<ROUTINE DESCRIBE-MEEP ("OPTIONAL" (CONTEXT <>))
	 <COND (<EQUAL? .CONTEXT ,M-OBJDESC>
		<MAKE ,MEEP ,SEEN>
		<TELL ,CTHEMEEP>
		<COND (<T? ,APPETITE>
		       <SAY-PECKS <>>   		       
		       <RTRUE>)>
		<TELL <PICK-NEXT <GET ,MEEP-TABLE 3>>>
		<PRINTC 46>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		
<ROUTINE OPEN-FOR-MEEP (X)
	 <TELL "You'd have to open " THE .X
	       " for the " D ,MEEP " first." CR>
	 <RTRUE>>

<ROUTINE AFTER-YOU ()
	 <TELL ,CTHEMEEP 
"cocks its head as if to say, \"After you.\"" CR>
	 <RTRUE>>

<ROUTINE MEEP-F ("OPTIONAL" (CONTEXT <>) "AUX" L X)
	 <SET X <FIRST? ,MEEP>>
	 <COND (<EQUAL? .CONTEXT ,M-WINNER>
		<COND (<OR <VERB? TAKE>
			   <AND <VERB? GET-FOR>
				<PRSI? ME>>>
		       <SET L <LOC ,PRSO>>
		       <COND (<ZERO? .L>
			      <PERPLEXED ,MEEP>
			      <RFATAL>)
			     (<EQUAL? .L ,MEEP>
			      <TELL ,CTHEMEEP "already has " THEO ,PERIOD>
			      <RFATAL>)
			     (<OR <NOT <IS? ,PRSO ,TAKEABLE>>
				  <G? <GETP ,PRSO ,P?SIZE> 3>>
			      <SOUR-LOOK>
			      <RFATAL>)
			     (<AND <IN? ,MEEP ,CAGE>
				   <NOT <IS? ,CAGE ,OPENED>>>
			      <OPEN-FOR-MEEP ,CAGE>
			      <RFATAL>)
			     (<EQUAL? .L ,PLAYER>
			      <TELL ,CTHEMEEP
"couldn't reach " THEO " while you're holding it." CR>
			      <RFATAL>)
			     (<AND <IS? .L ,CONTAINER>
				   <NOT <IS? .L ,OPENED>>>
			      <OPEN-FOR-MEEP .L>
			      <RFATAL>)
			     (<IN? .L ,PLAYER>
			      <TELL "You probably ought to take " THEO>
			      <COND (<IS? .L ,SURFACE>
				     <TELL " off ">)
				    (T
				     <TELL " out of ">)>
			      <TELL THE .L " first." CR>
			      <RFATAL>)
			     (<MEEP-GETS-TKEY? ,PRSO>
			      <RFATAL>)>
		       <MOVE ,PRSO ,HERE>
		       <UNMAKE ,PRSO ,NODESC>
		       <TELL ,CTHEMEEP "nods brightly, ">
		       <COND (<T? .X>
			      <MOVE .X <LOC ,MEEP>>
			      <TELL "drops " THE .X ", ">)>
		       <TELL "picks up " THEO " and deposits ">
		       <COND (<IS? ,PRSO ,PLURAL>
			      <TELL "them ">)
			     (T
			      <TELL "it ">)>
		       <TELL "at your feet." CR>
		       <RFATAL>)
		      (<AND <VERB? SGET-FOR>
			    <PRSO? ME>>
		       <PERFORM ,V?TAKE ,PRSI>
		       <RFATAL>)
		      (<OR <VERB? DROP THROW THROW-OVER PUT-UNDER
				  PUT-BEHIND PUT-ON POCKET>
			   <AND <VERB? GIVE FEED>
			    	<PRSI? ME>>>
		       <MOVE ,PRSO <LOC ,MEEP>>
		       <UNMAKE ,PRSO ,NODESC>
		       <TELL ,CTHEMEEP "drops " THEO>
		       <COND (<IN? ,MEEP ,HERE>
			      <TELL " at your feet">)>
		       <COND (<NOT <VERB? DROP GIVE FEED>>
			      <TELL " and looks at you expectantly">)>
		       <PRINT ,PERIOD>
		       <RFATAL>)
		      (<AND <VERB? SGIVE SFEED>
			    <PRSO? ME>>
		       <PERFORM ,V?DROP ,PRSI>
		       <RFATAL>)	       
		      (<VERB? EXAMINE WATCH LOOK-ON LOOK-UNDER LOOK-BEHIND
			      LOOK-DOWN LOOK-UP LOOK-OUTSIDE LOOK SEARCH
			      COUNT READ>
		       <COND (<PRSO? MEEP>
			      <PERPLEXED ,PRSO>
			      <RFATAL>)>
		       <TELL ,CTHEMEEP>
		       <COND (<PRSO? BAG>
			      <TELL "hops with excitement." CR>
			      <RFATAL>)>
		       <TELL "peers ">
		       <COND (<VERB? LOOK-UNDER>
			      <TELL "under ">)
			     (<VERB? LOOK-BEHIND>
			      <TELL "behind ">)
			     (T
			      <TELL "at ">)>
		       <TELL THEO " as best it can." CR>
		       <RFATAL>)
		      (<VERB? WALK WALK-TO>
		       <COND (<AND <PRSO? TKEY BBOX SBUNK>
				   <MEEP-GETS-TKEY? ,TKEY>>
			      <RFATAL>)>
		       <AFTER-YOU>
		       <RFATAL>)
		      (<VERB? ENTER THROUGH STAND-UNDER>
		       <COND (<AND <PRSO? SBUNK>
				   <MEEP-GETS-TKEY? ,TKEY>>
			      <RFATAL>)>
		       <AFTER-YOU>
		       <RFATAL>)
		      (<VERB? CROSS CLIMB-OVER CLIMB-DOWN CLIMB-UP CLIMB-ON
			      STAND-ON FOLLOW FLY WALK-AROUND EXIT LEAVE RIDE>
		       <AFTER-YOU>
		       <RFATAL>)
		      (<VERB? EAT TASTE DRINK DRINK-FROM SUCK KISS PISS
			      RAPE>
		       <TELL ,CTHEMEEP>
		       <COND (<NOT <VERB? EAT TASTE>>
			      T)
			     (<T? ,APPETITE>
			      <TELL "is already eating." CR>
			      <RFATAL>)
			     (<PRSO? BAG>
			      <TELL "hops with excitement at the idea." CR>
			      <RFATAL>)>
		       <TELL "gives you a distasteful look." CR>
		       <RFATAL>)
		      (<VERB? LISTEN SMELL INHALE>
		       <TELL ,CTHEMEEP>
		       <COND (<VERB? LISTEN>
			      <TELL "listens ">)
			     (T
			      <TELL "sniffs the air ">)>
		       <TELL "carefully, then gives you a quizzical look." CR>
		       <RFATAL>)
		      (<ADDRESS-MEEP?>
		       <RFATAL>)>
		<MEEP-COCKS>
		<RFATAL>)
	       (<THIS-PRSI?>
		<COND (<VERB? GIVE>
		       <COND (<IN? ,PRSI ,TS6>
			      <CANT-FROM-HERE>
			      <RTRUE>)
			     (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <SOUR-LOOK>
			      <RTRUE>)
			     (<PRSO? BAG>
			      <GIVE-PRSO-TO-MEEP>
			      <RTRUE>)>
		       <TELL ,CTHEMEEP>
		       <COND (<T? .X>
			      <MOVE .X <LOC ,PRSI>>
			      <TELL "drops " THE .X " and ">)>
		       <MOVE ,PRSO ,PRSI>
		       <TELL "snatches " THEO
			     " away from you with its beak." CR>
		       <RTRUE>)
		      (<VERB? FEED>
		       <COND (<IN? ,PRSI ,TS6>
			      <CANT-FROM-HERE>
			      <RTRUE>)
			     (<NOT <PRSO? BAG>>
			      <NOT-LIKELY ,PRSI 
				   "would find that very appetizing">
			      <RTRUE>)>
		       <GIVE-PRSO-TO-MEEP>
		       <RTRUE>)
		      (<VERB? SHOW>
		       <TELL ,CTHEMEEP>
		       <COND (<PRSO? BAG>
			      <TELL "hops with excitement">)
			     (<PRSO? RUBY EMERALD MARKER KNIFE SDRIVER SCOIN
				     WTK WALLET PHOTO>
			      <TELL "nods slyly">)
			     (<PROB 50>
			      <TELL "glances at " THEO
				    ", but shows little interest." CR>
			      <RTRUE>)
			     (T
			      <TELL "cocks its head">)>
		       <TELL " when you show it " THEO ,PERIOD>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <MOVE ,PRSO ,HERE>
		       <TELL ,CTHEMEEP>
		       <COND (<G? <GETP ,PRSO ,P?SIZE> 3>
			      <TELL "dodges " THEO
				    " and gives you a hurt look." CR>
			      <RTRUE>)
			     (<T? .X>
			      <MOVE .X <LOC ,PRSI>>
			      <TELL "drops " THE .X ", ">)>
		       <TELL "retrieves " THEO 
			     " and drops it at your feet." CR>
		       <RTRUE>)>				    
		<RFALSE>)
	       (<AND <VERB? TELL>
		     <T? ,P-CONT>>
		<COND (<IN? ,PRSO ,TS6>
		       <MEEP-COCKS>
		       <RFATAL>)
		      (<T? ,APPETITE>
		       <TELL ,CTHEMEEP>
		       <BUSY-EATING>
		       <RFATAL>)>
		<RFALSE>)	       
	       (<VERB? TELL-ABOUT ASK-ABOUT ASK-FOR>
		<COND (<PRSI? PRSO ME>
		       <PERPLEXED ,PRSO>
		       <RTRUE>)>
		<SHOW-TO-MEEP ,PRSI>
		<RFATAL>)
	       (<ADDRESS-MEEP?>
		<RFATAL>)
	       (<VERB? WATCH>
		<UNMAKE ,PRSO ,SEEN>
		<I-TMEEP <>>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL ,CTHEMEEP 
"resembles a gray pheasant, lean and streamlined, with bright eyes and a long tail splashed with color">
		<COND (<T? .X>
		       <TELL ". It's holding " A .X " in its beak">)
		      (<T? ,APPETITE>
		       <TELL 
". Right now it's pecking crumbs out of the bag with great contentment">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<AND <VERB? FOLLOW>
		     <NOT <VISIBLE? ,PRSO>>>
		<V-WALK-AROUND>
		<RTRUE>)
	       (<VERB? TOUCH KISS>
		<TELL ,CTHEMEEP "rubs its head against your leg." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ADDRESS-MEEP? ()
	 <COND (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<TELL "The bird ">
		<COND (<PROB 50>
		       <TELL "chatter">)
		      (T
		       <TELL "cluck">)>
		<TELL "s something in precise Roadrunner." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE MEEP-COCKS ()
	 <PCLEAR>
	 <TELL ,CTHEMEEP <PICK-NEXT <GET ,MEEP-TABLE 5>>
	       ", but " <PICK-NEXT <GET ,MEEP-TABLE 6>> ,PERIOD>
	 <RTRUE>>

<ROUTINE GIVE-PRSO-TO-MEEP ("AUX" L)
	 <SET L <LOC ,PRSI>>
	 <MOVE ,PRSO .L>
	 <TELL "You put the " D ,PRSO " ">
	 <COND (<EQUAL? .L ,HERE>
		<TELL "on the ">
		<COND (<IS? ,HERE ,INDOORS>
		       <TELL D ,FLOOR>)
		      (T
		       <TELL D ,GROUND>)>)
	       (T
		<COND (<IS? .L ,SURFACE>
		       <TELL "o">)
		      (T
		       <TELL "i">)>
		<TELL "n " THE .L>)>
	 <TELL " beside the " D ,PRSI ,PERIOD>
	 <RTRUE>>

<ROUTINE SOUR-LOOK ()
	 <TELL ,CTHEMEEP
"gives you a sour look. It obviously couldn't hold ">
	 <COND (<IS? ,PRSO ,PLURAL>
		<TELL "all of ">)>
	 <TELL THEO " in its beak." CR>
	 <RTRUE>>

<ROUTINE MEEP-GETS-TKEY? (OBJ "AUX" X)
	 <COND (<AND <EQUAL? .OBJ ,TKEY>
		     <IS? .OBJ ,SEEN>
		     <NOT <IS? .OBJ ,TOUCHED>>
		     <IN? ,MEEP ,S100>>
		<MAKE .OBJ ,TOUCHED>
		<UNMAKE .OBJ ,NODESC>
		<MOVE .OBJ ,S100>
		<SETG P-IT-OBJECT .OBJ>
		<SET X <FIRST? ,MEEP>>
		<TELL ,CTHEMEEP>
		<COND (<T? .X>
		       <MOVE .X <LOC ,MEEP>>
		       <TELL "drops " THE .X " and ">)>
		<TELL "nods brightly.|
|
You hold " D ,BREATH 
" as a gray torpedo scoots under the jeeps and disappears into the " D ,SBUNK
,PTHE "busy technicians fail to notice the fearless creature plucking the key from its "
D ,PADLOCK ,PCR "Triumphantly, the " D ,MEEP 
" prances back to your side and deposits the key at your feet." CR>
		<UPDATE-SCORE 3>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PERPLEXED (OBJ)
	 <TELL CTHE .OBJ " looks perplexed." CR>
	 <RTRUE>>

<ROUTINE BUSY-EATING ()
	 <TELL "is busy eating right now." CR>
	 <RTRUE>>

<ROUTINE SHOW-TO-MEEP (OBJ "AUX" X)
	 <MAKE ,MEEP ,SEEN>
	 <COND (<EQUAL? .OBJ ,INTDIR ,RIGHT ,LEFT>
		<COND (<AND <EQUAL? ,P-DIRECTION ,P?NE>
			    <HERE? S100>
			    <IS? ,TKEY ,SEEN>
			    <NOT <IS? ,TKEY ,TOUCHED>>>
		       <SET OBJ ,TKEY>)
		      (T
		       <LOOKS-INTDIR ,MEEP>
		       <RTRUE>)>)
	       (<OR <ZERO? .OBJ>
		    <NOT <VISIBLE? .OBJ>>>
		<PERPLEXED ,MEEP>
		<RTRUE>)>
	 <COND (<MEEP-GETS-TKEY? .OBJ>
		<RTRUE>)>
	 <TELL ,CTHEMEEP>
	 <COND (<IN? .OBJ ,MEEP>
		<MOVE .OBJ <LOC ,MEEP>>
		<TELL "drops " THE .OBJ>
		<COND (<IN? ,MEEP ,HERE>
		       <TELL " at your feet">)>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<T? ,APPETITE>
		<BUSY-EATING>
		<RTRUE>)
	       (<AND <IN? ,MEEP ,HERE>
		     <IN? .OBJ ,HERE>
		     <IS? .OBJ ,TAKEABLE>
		     <L? <GETP .OBJ ,P?SIZE> 4>>
		<SET X <FIRST? ,MEEP>>
		<COND (<T? .X>
		       <MOVE .X ,HERE>
		       <TELL "drops " THE .X ", ">)>
		<TELL "picks up " THE .OBJ " and drops it at your feet." CR>
		<RTRUE>)>
	 <TELL "glances at " THE .OBJ 
", turns back to you and cocks its head as if to say, \"So?\"" CR>
	 <RTRUE>>

"*** DOG ***"

<OBJECT DOG
	(LOC W100)
	(DESC "German shepherd")
	(FDESC 
"A great, big German shepherd is curled up against the blockhouse.")
	(FLAGS LIVING PERSON TRYTAKE NOALL)
	(SYNONYM DOG WATCHDOG SHEPHERD MUTT POOCH CANINE ANIMAL
	 	 HELLHOUND ALEXIS WOLF)
	(ADJECTIVE GERMAN GREAT BIG LARGE HUGE ENORMOUS HELL)
	(ACTION DOG-F)>

"SEEN = referenced, TOUCHED = spoken to/heard talkie once,
 BORING = pecked once, WINDY = bird on head."

<ROUTINE DOG-F ()
	 <COND (<OR <NOUN-USED? ,W?HELLHOUND ,W?ALEXIS ,W?WOLF>
		    <ADJ-USED? ,W?HELL>>
		<V-WISH>
		<RFATAL>)>
	 <MAKE ,DOG ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? SHOW>
		       <TELL "The sleeping animal exhibits no interest." CR>
		       <RTRUE>)
		      (<VERB? GIVE FEED>
		       <MOVE ,PRSO ,W100>
		       <UNMAKE ,PRSI ,SEEN>
		       <TELL "You deposit " THEO 
			     " under the sleeping dog's nose." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER>
		       <MOVE ,PRSO ,HERE>
		       <TELL "You toss " THE ,PRSO>
		       <COND (<VERB? THROW-OVER>
			      <TELL " over ">)
			     (T
			      <TELL " at ">)>
		       <TELL 
"the sleeping dog. Luckily, your pitching arm is no better than your sense of diplomacy, and " THE ,PRSO
" falls short of its target by several feet." CR>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH>
		<TELL 
"You're looking at a hundred and ten pounds of hard, flea-bitten muscle, leashed to the " D ,BHOUSE 
" with a chain of the type used to moor ocean liners. Good thing it's sleeping." CR>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <ALMOST-WAKE-DOG>
		       <RFATAL>)>
		<WAKE-DOG>
		<RFATAL>)
	       (<VERB? TOUCH SQUEEZE SHAKE KISS ADJUST
		       RAISE PUSH PULL>
		<COND (<NOT <IS? ,PRSO ,TOUCHED>>
		       <ALMOST-WAKE-DOG T>
		       <RTRUE>)>
		<WAKE-DOG T>
		<RTRUE>)
	       (<VERB? HIT CUT RIP KILL KICK>
		<TELL 
"Boldly, fearlessly, you march up to the dozing shepherd and draw back ">
		<COND (<VERB? KICK>
		       <TELL D ,FEET>)
		      (<ZERO? ,PRSI>
		       <TELL D ,HANDS>)
		      (T
		       <TELL THEI>)>
		<TELL " to deal the sleeping monster a mighty blow">
		<COND (<AND <NOT <EQUAL? ,PRSI <> ,HANDS ,FEET>>
			    <L? <GETP ,PRSI ,P?SIZE> 3>>
		       <TELL
" (or as mighty a blow as you can expect from " A ,PRSI ")">)>
		<TELL
". But the dog snorts a bit in its sleep, and you bravely scurry backwards several dozen yards." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL CTHEO " slobbers gently in its sleep." CR>
		<RTRUE>)
	       (<VERB? SMELL>
		<TELL CTHEO " could use a bath. Any volunteers?" CR>
		<RTRUE>)
	       (<VERB? RAPE>
		<VOICE-MUTTERS "Okay, sicko">
		<WAKE-DOG T>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<TELL
"A second look at the sleeping brute" ,CHANGES>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ALMOST-WAKE-DOG ("OPTIONAL" (TOUCH <>))
	 <MAKE ,PRSO ,TOUCHED>
	 <TELL CTHE ,DOG " curls its lip and rumbles">
	 <COND (<T? .TOUCH>
		<AT-YOUR-TOUCH>)
	       (T
		<AT-YOUR-VOICE>)>
	 <TELL "But you didn't wake it up... this time." CR>
	 <RTRUE>>

<ROUTINE AT-YOUR-TOUCH ()
	 <TELL " at your touch. ">
	 <RTRUE>>

<ROUTINE WAKE-DOG ("OPTIONAL" (TOUCH <>))
	 <TELL CTHE ,DOG " lifts a heavy eyelid">
	 <COND (<T? .TOUCH>
		<AT-YOUR-TOUCH>)
	       (T
		<AT-YOUR-VOICE>)>
	 <TELL 
"It peers at you for a moment, yawns and drifts back to sleep.|
|
You wipe the sweat from your brow" ,PCR>
	 <ITALICIZE "Click.">
	 <TELL 
" A set of long, white fangs snaps together, an inch shy of your left leg. Looks as if sleepytime is over." CR>
	 <DOG-ALERT>
	 <RTRUE>>

<ROUTINE DOG-ALERT ()
	 <TELL CR
"\"Nice puppy,\" you mumble.|
|
The 110-pound \"puppy\" strains against its chain, opens its toothy maw and starts">
	 <AKC>
	 <COND (<HEAR-BAKER?>
		<HEAR-BARKING>)>
	 <TELL CR 
"You stumble backwards to hide as the " D ,SLIGHT 
" sweeps across the road." CR>
	 <HOLD-IT>
	 <KINDA-SPY>
	 <SURROUNDED>
	 <RTRUE>>

"*** BARROW WIGHT ***"

<OBJECT WIGHT
	(LOC IN-BARROW)
	(DESC "barrow wight")
	(FLAGS NODESC PERSON LIVING)
	(SYNONYM WIGHT CREATURE MONSTER BEING FORM HUMANOID EYE NERVE)
	(ADJECTIVE BARROW UNDEAD HUMAN STOOPED MALIGNANT DANGLING)
	(DESCFCN DESCRIBE-WIGHT)
	(CONTFCN IN-WIGHT)
	(ACTION WIGHT-F)>

"SEEN = just seen, NODESC = never seen, CHILLY = passed."

<ROUTINE IN-WIGHT ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-CONT>>
		<RFALSE>)
	       (<INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>
		<VERY-CLOSE>
		<RTRUE>)
	       (T
		<RFALSE>)>>	 

<ROUTINE VERY-CLOSE ()
	 <TELL
"You'd have to get uncomfortably close to the " D ,WIGHT " to do that." CR>
	 <RTRUE>>

<ROUTINE DESCRIBE-WIGHT ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <EQUAL? .CONTEXT ,M-OBJDESC>>
		<RFALSE>)>
	 <TELL "A " D ,WIGHT " is ">
	 <COND (<PROB 50>
		<COND (<PROB 50>
		       <TELL "lurking in">)
		      (T
		       <TELL "skulking about in">)>)
	       (T
		<COND (<PROB 50>
		       <TELL "eyeing you from">)
		      (T
		       <TELL "slavering noisily in">)>)>
	 <TELL " the darkness close at hand">
	 <WIGHT-HAS>
	 <PRINTC 46>
	 <RTRUE>>

<ROUTINE WIGHT-HAS ()
	 <COND (<SEE-ANYTHING-IN? ,WIGHT>
		<TELL ". It's clutching ">
		<PRINT-CONTENTS ,WIGHT>
		<TELL " in one of its long, sharp claws">)>
	 <RTRUE>>

<ROUTINE WIGHT-F ("OPTIONAL" (CONTEXT <>))
	 <MAKE ,WIGHT ,SEEN>
	 <COND (<THIS-PRSI?>
		<COND (<VERB? SHOW POINT-AT SHINE-AT>
		       <COND (<AND <VERB? SHINE-AT>
				   <NOT <PRSO? SHARD LAMP>>>
			      <RFALSE>)>
		       <TELL CTHEI>
		       <COND (<IS? ,PRSO ,LIGHTED>
			      <TELL			       
" winces with pain, and covers its eye with an open claw." CR>
			      <RTRUE>)>
		       <TELL " scowls at " THEO 
			     " with profound disinterest." CR>
		       <RTRUE>)
		      (<VERB? GIVE FEED>
		       <TELL CTHEI>
		       <COND (<IS? ,PRSO ,LIGHTED>
			      <TELL		       
" growls and backs away as you approach it with " THEO ,PERIOD>
		       	      <RTRUE>)
			     (<PRSO? GARLIC ICE SKINK>
			      <VANISH>
			      <TELL " crams " THEO 
				    " into its mouth and belches." CR>
			      <RTRUE>)>
		       <MOVE ,PRSO ,OSSUARY>
		       <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
		       <TELL " clutches " THEO			     
" in its claws, glares at it briefly and flings it off into the darkness with a snarl." CR>
		       <RTRUE>)
		      (<VERB? THROW THROW-OVER PUSH-TO>
		       <COND (<DONT-HAVE? ,PRSO>
			      <YOUD-HAVE-TO "be holding" ,PRSO>
			      <RTRUE>)>
		       <TELL CTHEI " dodges " THEO>
		       <COND (<IS? ,PRSO ,LIGHTED>
			      <MOVE ,PRSO ,HERE>
			      <TELL
" and kicks it back to you with a fearful screech." CR>
			      <COND (<PRSO? LAMP>
				     <MAKE ,PRSO ,CHILLY>
				     <UNMAKE ,PRSO ,LIGHTED>
				     <SETG BEAM 0>
				     <DEQUEUE I-HARDHAT>
				     <TELL CR "You hear a faint ">
				     <ITALICIZE "pop">
				     <TELL " as the " D ,PRSO
				           " strikes the ground." CR>
				     <SAY-IF-HERE-LIT>)>
			      <RTRUE>)>
		       <TELL ", snatches it up ">
		       <THROWS-BACK ,PRSO>
		       <RTRUE>)>
		<RFALSE>)
	       (<VERB? EXAMINE WATCH SEARCH>
		<TELL "One of the " D ,PRSO
"'s eyes dangles from its socket on a moist pink nerve. The other glares back at you from the darkness of the " D ,TUNNEL>
		<WIGHT-HAS>
		<PRINT ,PERIOD>
		<RTRUE>)
	       (<VERB? WAVE-AT BOW>
		<TELL CTHEO 
" responds to your gesture with a contemptuous snarl." CR>
		<RTRUE>)
	       (<VERB? TOUCH KNOCK KICK SQUEEZE MOVE PUSH SHAKE
		       ADJUST SWING>
		<VERY-CLOSE>
	        <RTRUE>)
	       (<VERB? HIT KILL>
		<COND (<EQUAL? ,PRSI <> ,HANDS ,FEET>
		       <VERY-CLOSE>
		       <RTRUE>)
		      (<IS? ,PRSI ,LIGHTED>
		       <TELL CTHEO 
" backs out of your reach, snarling with fear." CR>
		       <RTRUE>)>
		<TELL CTHEO " grapples " THEI " away from you ">
		<THROWS-BACK ,PRSI>
		<RTRUE>)
	       (<INTBL? ,PRSA ,TALKVERBS ,NTVERBS>
		<WIGHT-RESPONDS>
		<RFATAL>)
	       (<VERB? KISS RAPE>
		<TELL "Your gesture brings a tear to the " D ,PRSO
"'s eye as it recalls the tender moments of its former human existence. Then it breaks your neck with a practiced swipe of its claw.">
		<JIGS-UP>
		<RFATAL>)
	       (<VERB? SMELL>
		<TELL CTHEO " smells as if it's been dead a long time." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE WIGHT-RESPONDS ()
	 <TELL CTHE ,WIGHT " snarls in reply." CR>
	 <RTRUE>>

<ROUTINE THROWS-BACK (OBJ)
	 <MOVE .OBJ ,HERE>
	 <TELL 
"and flings it back at you with a roar. You leap back as it skitters"
,AGROUND ,PERIOD>
	 <RTRUE>>

"*** OPPIE & COMPANY ***"

<OBJECT OPPIE-THINGS
	(LOC OPPIE)
	(DESC "that")
	(FLAGS NODESC NOARTICLE)
	(SYNONYM PIPE HAT)
	(ADJECTIVE PORKPIE MAN\'S HIS)
	(ACTION USELESS)>

<OBJECT OPPIE
	(LOC S100)
	(DESC "thin man")
	(FLAGS NODESC PERSON)
	(FDESC
"A thin man is standing just inside the bunker's entrance.")
	(SYNONYM MAN MISTER PERSON MALE OPPENHEIM OPPIE SIR)
	(ADJECTIVE ROBERT MISTER MR DR DOCTOR
	 	   DOC J JULIUS THIN SKINNY GAUNT)
	(GENERIC GENERIC-GI-F)
	(ACTION OPPIE-F)>

"NODESC = NOT visible, SEEN = appeared once, CHILLY = used name,
 BORING = quote seen."

<ROUTINE GENERIC-GI-F (TBL)
	 <COND (<IS? ,OPPIE ,NODESC>
		<RETURN ,GIS>)>
	 <RETURN ,OPPIE>>

<ROUTINE GONE-NOW (OBJ)
	 <SETG P-IT-OBJECT ,NOT-HERE-OBJECT>
	 <TELL CTHE .OBJ " you saw here before is gone now." CR>
	 <RTRUE>>

<ROUTINE OPPIE-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<NOT <IS? ,OPPIE ,SEEN>>
		<CANT-SEE-ANY>
		<RFATAL>)
	       (<IS? ,OPPIE ,NODESC>
		<SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
		<GONE-NOW ,OPPIE>
		<RFATAL>)
	       (<AND <NOT <IS? ,OPPIE ,CHILLY>>
		     <OR <NOUN-USED? ,W?OPPIE ,W?OPPENHEIM>
			 <ADJ-USED? ,W?J ,W?ROBERT ,W?DR>
			 <ADJ-USED? ,W?DOCTOR ,W?DOC ,W?JULIUS>>>
		<MAKE ,OPPIE ,CHILLY>
		<VOICE-MUTTERS "Indeed">)>
	 <COND (<VERB? WATCH>
		<I-OPPIE <>>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL CTHEO " near the " D ,SHELTER 
" is drawn and haggard; it looks as if he hasn't slept in days." CR>
		<COND (<NOT <IS? ,OPPIE ,BORING>>
		       <MAKE ,OPPIE ,BORING>
		       <SETG DO-WINDOW <GET ,QUOTES ,WHITMAN>>
		       <RFATAL>)>
		<RTRUE>)>
	 <RETURN <HANDLE-GIS?>>> 
	       
<OBJECT GIS
	(LOC S100)
	(DESC "GIs")
	(FLAGS NODESC LIVING PERSON PLURAL)
	(SYNONYM GIS GI DRIVERS DRIVER SOLDIER SOLDIERS TROOP TROOPS 
	 	 MAN MISTER MEN)
	(ADJECTIVE MILITARY NERVOUS YOUNG NERVOUS\-LOOKING)
	(GENERIC GENERIC-GI-F)
	(ACTION GIS-F)>

"SEEN = spoken to once."

<ROUTINE GIS-F ("OPTIONAL" (CONTEXT <>))
	 <COND (<VERB? EXAMINE WATCH>
		<TELL CTHEO " in the ">
		<COND (<L? ,MINUTES 28>
		       <TELL D ,JEEPS>)
		      (T
		       <TELL D ,TRENCHES>)>
		<TELL
" are obviously under a lot of strain. Their ">
		<COND (<L? ,MINUTES 28>
		       <TELL 
"fingers drum impatiently on their steering wheels, and their ">)>
		<TELL "eyes dart back and forth between the " 
D ,SBUNK " and the " D ,HORIZON ". One of them is training a " D ,BINOS
" on the road leading south." CR>
		<RTRUE>)>
	 <RETURN <HANDLE-GIS?>>>
		
<ROUTINE HANDLE-GIS? ()
	 <COND (<THIS-PRSI?>
		<COND (<VERB? GIVE SHOW FEED>
		       <CANT-FROM-HERE>
		       <RTRUE>)>
		<RFALSE>)
	       (<OR <VERB? SMELL SEARCH LOOK-BEHIND LOOK-UNDER>
		    <INTBL? ,PRSA ,TOUCHVERBS ,NTOUCHES>>
		<CANT-FROM-HERE>
		<RTRUE>)
	       (<ENTERING?>
		<DO-WALK ,P?NE>
		<RTRUE>)
	       (<NOT <INTBL? ,PRSA ,TALKVERBS ,NTVERBS>>
		<RFALSE>)>
	 <COND (<PRSO? GIS>
		<TELL "One of the " D ,PRSO>)
	       (T
		<TELL CTHEO>)>
	 <COND (<NOT <IS? ,GIS ,SEEN>>
		<MAKE ,GIS ,SEEN>
		<TELL " starts">
	        <AT-YOUR-VOICE>
	 	<TELL "\"Who said that?\" he cries.|
|
The ">
		<COND (<PRSO? GIS>
		       <TELL "other ">)
		      (T
		       <TELL "surrounding ">)>
		<TELL D ,GIS
" snap to alert attention, peering into the gloom. Nobody moves for a long moment. Then, one by one, they begin to relax... all but the closest GI, who stares in the " D ,INTDIR 
" of the shed nervously." CR>
		<RFATAL>)>
	  <TELL " points in your " D ,INTDIR>
	  <AT-YOUR-VOICE>
	  <TELL "\"The shed!\" he cries." CR>
	  <SURROUNDED>
	  <RFATAL>>

<ROUTINE AT-YOUR-VOICE ()
	 <TELL " at the sound of your voice. ">
	 <RTRUE>>