;********************************************************
;*		$$$SE.S		( SOUND S.E FILE )	*
;*  			ORG. M5SE13.S               	*
;*		'SOUND-SORCE'                           *
;*		 for Mega Drive (Z80)			*
;*			VER  1.31/1989.12.10		*
;*				BY        T.Uwabo       *
;********************************************************

	.XLIST
	include m5eq13.lib
	include m5mcr13.lib
	include m5tb13.lib
	include m5setb13.src
	.LIST

;-----------------------------------------------------------------------------
;================== S.E ======================= 
;	S90	
;	S91	
;	S92	
;	S93	
;	S94	
;	S95	
;	S96	
;	S97	
;	S98	
;	S99	
;	S9A	
; 	S9B	
;	S9C	
;	S9D	
;	S9E	
;	S9F	

;	SA0	
;	SA1	
;	SA2	
;	SA3	
;	SA4	
;	SA5	
;	SA6	
;	SA7	
;	SA8	
;	SA9	
;	SAA	
; 	A9B	
;	SAC	
;	SAD	
;	SAE	
;	SAF	

;	SB0	
;	SB1	
;	SB2	
;	SB3	
;	SB4	
;	SB5	
;	SB6	
;	SB7	
;	SB8	
;	SB9	
;	SBA	
; 	B9B	
;	SBC	
;	SBD	
;	SBE	
;	SBF	

	;--------------------------------
	;*;	S90	SHOT1 (fair way)
	;--------------------------------
S90::
	DW	TIMB90	;,S90		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB900,0F4H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB900::
	DB	FEV,0
T900:
	DB	9ah,3
	DB	090h,0dh
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB90::
fev900::
	CNF	2,31
	MD	4,0,1,3,3,1,3,1
	RSAR	0,14,0,15,0,14,0,15
	D1R	0,16,16,20
	D2R	0,0,0,16
	RRL	15,6,15,4,15,5,15,6
	TL	20,0,17,0

	;--------------------------------
	;*	S91	SHOT2 (laff)
	;--------------------------------
S91::
	DW	TIMB91	;,S91		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB910,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB910:
	DB	FEV,0
T910:
	DB	99h,2
	DB	9bh,0dh
;	DB	0A0H,18H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB91::
fev910::
	CNF	2,31
	MD	6,7,15,3,8,4,6,1
	RSAR	0,14,0,19,0,15,0,15
	D1R	0,0,0,20
	D2R	0,0,0,10
	RRL	15,6,15,4,15,5,15,11
	TL	0,0,31,0

	if	0
	CNF	0,14
	MD	7,9,3,4,11,6,1,7
	RSAR	0,12,0,31,0,15,0,18
	D1R	0,0,0,16
	D2R	22,21,18,19
	RRL	15,1,15,1,15,1,15,1
	TL	16,16,6,0
	endif
	
	;--------------------------------
	;*	S92	SHOT3 (banker)
	;--------------------------------
S92::
	DW	TIMB92	;,S92		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB920,000H,000H 	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB920:
	DB	FEV,0
T920:
	DB	96H,28H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB92::
fev920::
	CNF	0,6
	MD	0,0,0,4,0,3,0,7
	RSAR	0,18,0,16,0,24,0,16
	D1R	0,16,23,31
	D2R	11,0,0,16
	RRL	15,6,15,3,15,3,15,3
	TL	0,8,0,0

	;--------------------------------
	;*	S93	SHOT4 (pat)
	;--------------------------------
S93::
	DW	TIMB93	;,S93		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB930,000H,000H 	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB930:
	DB	FEV,0
T930:
	DB	087H,18H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB93::
fev930::
	CNF	4,6
	MD	13,4,8,10,7,3,4,7
	RSAR	0,31,0,31,0,31,0,31
	D1R	26,28,21,21
	D2R	21,21,20,20
	RRL	15,5,15,8,15,3,15,6
	TL	18H,10H,20H,0
	
	;--------------------------------
	;*	S94	trubble1 (tree)
	;--------------------------------
S94::
	DW	TIMB94	;,S94		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB940,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB940:
	DB	FEV,0
T940:
	DB	0B0H,18H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB94::
fev940::
	CNF	1,6 
	MD	12,6,6,4,1,3,2,7
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,16,31,19
	D2R	22,16,16,24
	RRL	15,1,15,1,15,1,15,5
	TL	30H,32H,30H,0
	
	;--------------------------------
	;*	S95	trubble2 (hayasi)
	;--------------------------------
S95::
	DW	TIMB95	;,S95		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB950,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB950:
	DB	FEV,0
T950:
	DB	9DH,6
	DB	97H,60H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB95::
fev950::
	CNF	3,6
	MD	0,3,0,1,4,2,6,5
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,16,5,21
	D2R	0,0,0,17
	RRL	15,1,3,1,15,1,15,2
	TL	0,0,0,0

	;--------------------------------
	;*	S96	trubble3 (banker in)
	;--------------------------------
S96::
	DW	TIMB96	;,S96		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB960,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB960:
	DB	FEV,0
T960:
	DB	95H,2,95H,32H
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB96::
fev960::
	CNF	4,6
	MD	0,3,0,4,4,4,1,5
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,19,0,21
	D2R	31,31,0,26
	RRL	15,7,15,7,15,0,15,5
	TL	2,0,40H,0
	
	;--------------------------------
	;*	S97	trubble4 (water)
	;--------------------------------
S97::
	DW	TIMB97	;,S97		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	0A0H,5,TAB970,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB970:
	DB	FEV,0
T970:
	DB	0ABH,0EDH,4
	DB	0B6H,0E0H,40H

	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB97::
fev970::
	CNF	6,6
	MD	3,6,0,3,0,3,0,4
	RSAR	0,22,0,16,0,16,0,16
	D1R	21,12,16,16
	D2R	0,12,0,16
	RRL	15,1,15,4,15,5,15,2
	TL	0,0,0,8

	;--------------------------------
	;*	S98	cupin
	;--------------------------------
S98::
	DW	TIMB98	;,S98		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,5,TAB980,000H,000H	; flag,chian,table pointer,bias,volm
	HD	80H,6,TAB981,000H,018H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB981:
	DB	NL,2
TAB980:
	DB	FEV,0
T980:
	DB	0a5h,1Bh
	db	CMVADD,16
	DB	0a5h,10
	db	CMVADD,8
	DB	0a5h,015H
	db	CMVADD,12H
	DB	0a5h,18h
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB98::
fev980::
	CNF	2,14
	MD	7,3,9,3,9,1,4,1
	RSAR	0,29,0,31,0,31,0,31
	D1R	16,18,20,20
	D2R	24,24,16,18
	RRL	15,6,15,4,15,5,15,13
	TL	30H,30H,20H,0

	;--------------------------------
	;*;	S99	command
	;--------------------------------
S99::
	DW	TIMB99	;,S99		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,80H,TAB990,0F4H,000H ; flag,chian,table pointer,bias,volm
	HD	080H,0A0H,TAB990P,0F4H,2 ; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TAB990:
;	DB	FEV,1
T990:
	DB	EV,2
	DB	CN3,4
	DB	CMEND
TAB990P:
	DB	EV,2
	DB	NL,2
	DB	CN3,4
	DB	CMEND
;----------------- VOICE DATA ---------------
TIMB99::
	IF	0
fev990::
	DEFB	03CH,0C0H		;FBC,LR
	DEFB	067H,043H,032H,072H	;MD
	DEFB	01FH,01FH,01FH,01FH	;RSAR
	DEFB	000H,000H,000H,000H	;DIR
	DEFB	016H,015H,012H,014H	;D2R
	DEFB	011H,013H,015H,017H	;RRL
	DEFB	01EH,002H,005H,002H	;TL
fev991::
	DEFB	038H,0C0H		;FBC,LR
	DEFB	067H,043H,032H,072H	;MD
	DEFB	01FH,01FH,01FH,01FH	;RSAR
	DEFB	000H,000H,000H,000H	;DIR
	DEFB	016H,015H,012H,014H	;D2R
	DEFB	011H,013H,015H,017H	;RRL
	DEFB	01EH,040H,040H,002H	;TL
	
		ENDIF
	;--------------------------------
	;*;	S9A	bound ( fair way , laff )
	;--------------------------------
S9A::
	DW	TIMB9A	;,S9A		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB9A0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TAB9A0:
	DB	FEV,0
T9A0:
	DB	94H,8
	DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMB9A::
fev9A0::
	CNF	4,9*2
	MD	6,6,5,6,4,3,2,7
	RSAR	0,20,0,17,0,19,0,16
	D1R	19,19,21,24
	D2R	23,25,18,20
	RRL	15,2,14,3,15,4,15,5
	TL	8,16,24,0

	;--------------------------------
	;*;	S9B	wow ( fair way , laff )
	;--------------------------------
S9B::
	DW	TIMB9B	;,S9B		; VOICE TOP ADDR.

	db	1,1			; base,use chian no
	HD	80H,5,TAB9B0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TAB9B0:
T9B0:
	DB	FEV,0
	DB	EXCOM,WOW,0,0
	DB	CMCALL
	DW	SUB9B0
	DB	EXCOM,WOW,11,1
	DB	CMCALL
	DW	SUB9B0
	DB	EXCOM,WOW,11,2
	DB	CMCALL
	DW	SUB9B0
	DB	EXCOM,WOW,1,3
	DB	CMCALL
	DW	SUB9B0
	DB	EXCOM,WOW,11,4
	DB	CMCALL
	DW	SUB9B0
	db	CMJUMP
	DW	T9B0

SUB9B0:
	DB	C3,20H,D3,E3,F3,G3,A3,B3,40H
	DB	CMRET
;----------------- VOICE DATA ---------------
TIMB9B::
fev9B0::
	CNF	4,9*2
	MD	4,6,4,6,4,3,2,4
	RSAR	0,31,0,31,0,31,0,31
	D1R	08,08,08,08
	D2R	00,00,00,00
	RRL	15,2,14,3,15,4,15,5
	TL	8,0,24,0

