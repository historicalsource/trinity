"MACROS for TRINITY: (C)1986 Infocom, Inc. All rights reserved."

<SETG C-ENABLED? 0>

<SETG C-ENABLED 1>

<SETG C-DISABLED 0>

<TELL-TOKENS (CR CRLF)       <CRLF>
	     (N NUM) *       <PRINTN .X>
	     (C CHAR CHR) *  <PRINTC .X>
	     (D DESC) *      <PRINTD .X>
	     (A AN) *	     <PRINTA .X>
	     THE *	     <THE-PRINT .X>
	     CTHE *	     <CTHE-PRINT .X>
	     THEO	     <THE-PRINT>
	     CTHEO	     <CTHE-PRINT>
	     CTHEI	     <CTHEI-PRINT>
	     THEI	     <THEI-PRINT>>

; <DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A>
				 <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<=? .P "THEO">
					<MAPRET '<THE-PRINT>>)
				       (<=? .P "CTHEO">
					<MAPRET '<CTHE-PRINT>>)
				     ; (<=? .P "V">
					<MAPRET '<VPRINT>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<=? .P "HE/SHE">
					       <MAPRET
						 <FORM HE/SHE-PRINT .O>>)
					      (<=? .P "HIM/HER">
					       <MAPRET
						 <FORM HIM/HER-PRINT .O>>)
					      (<=? .P "HIS/HER">
					       <MAPRET
						 <FORM HIM/HER-PRINT .O T>>)
					      (<=? .P "THE">
					       <MAPRET
						 <FORM THE-PRINT .O>>)
					      (<=? .P "CTHE">
					       <MAPRET
						 <FORM CTHE-PRINT .O>>)
					      (<OR <=? .P "A">
						   <=? .P "AN">>
					       <MAPRET <FORM PRINTA .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<AND <TYPE? .E FORM>
				      <==? <NTH .E 1> QUOTE>>
				 <MAPRET <FORM PRINTD <FORM GVAL <NTH .E 2>>>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE
				 <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC HERE? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (LL (T)) (L .LL) ATM)
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1>
					<ERROR .X>)
				       (<LENGTH? .OO 2>
					<NTH .OO 2>)
				       (ELSE
					<CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS>
			       <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L <REST <PUTREST
				      .L
				      (<COND (<TYPE? .ATM ATOM>
					      <CHTYPE <COND (<==? .X PRSA>
							     <PARSE
							      <STRING "V?"
							       <SPNAME .ATM>>>)
							    (T .ATM)> GVAL>)
					     (ELSE .ATM)>)>>>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .LL> 4>
			       <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !<REST .LL>>)>>>
		<SET LL (T)>
		<SET L .LL>>>

; <DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

; <DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

; <DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

; <DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1>
					<NTH .O 1>)
				       (<==? .X FSET?>
				        <FORM OR !.O>)
				       (ELSE
					<FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM>
				   .ATM)
				  (ELSE
				   <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

<DEFMAC ZIL? ()
	<FORM ZERO? '<GETB 0 18>>>

<DEFMAC ENABLE ('INT)
	<FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT)
	<FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC GET-REXIT-ROOM ('PT)
	<FORM GET .PT ',REXIT>>

<DEFMAC GET-DOOR-OBJ ('PT)
	<FORM GET .PT ',DEXITOBJ>>

<DEFMAC GET/B ('TBL 'PTR)
	<FORM GET .TBL .PTR>>

<DEFMAC RMGL-SIZE ('TBL)
	<FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>>

<DEFMAC MAKE ('OBJ 'FLAG)
	<FORM FSET .OBJ .FLAG>>

<DEFMAC UNMAKE ('OBJ 'FLAG)
	<FORM FCLEAR .OBJ .FLAG>>

<DEFMAC IS? ('OBJ 'FLAG)
	<FORM FSET? .OBJ .FLAG>>

<DEFMAC T? ('TERM)
	<FORM NOT <FORM ZERO? .TERM>>>

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0>
		    <FORM - 0 .NUM>)
	           (T
		    .NUM)>>

<DEFMAC QUOTE? ()
	<FORM COND (<FORM NOT <FORM EQUAL?
				    <CHTYPE WINNER GVAL>
				    <CHTYPE PLAYER GVAL>>>
		    <FORM PRINTC 34>)>> 

<DEFMAC SPACE ()
	<FORM PRINTC 32>>

<DEFMAC THIS-PRSO? ()
	<FORM ZERO? <CHTYPE NOW-PRSI? GVAL>>>

<DEFMAC THIS-PRSI? ()
	<FORM NOT <FORM ZERO? <CHTYPE NOW-PRSI? GVAL>>>>