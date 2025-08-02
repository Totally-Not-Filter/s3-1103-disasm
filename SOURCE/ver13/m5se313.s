;********************************************************
;*		$$$SE3.S	( SOUND S.E FILE )	*
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
	;
	;--------------------------------
SB0::
	DW	TIMBB0			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB00,0F4H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB00::
		DB	FEV,0
	TB00:
		DB	9ah,3
		DB	090h,0dh
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB0::
		CNF	2,31
		MD	4,0,1,3,3,1,3,1
		RSAR	0,14,0,15,0,14,0,15
		D1R	0,16,16,20
		D2R	0,0,0,16
		RRL	15,6,15,4,15,5,15,6
		TL	20,0,17,0

	;--------------------------------
	;
	;--------------------------------
SB1::
	DW	TIMBB1			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB10,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB10:
		DB	FEV,0
	TB10:
		DB	99h,2
		DB	9bh,0dh
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB1::
		CNF	2,31
		MD	6,7,15,3,8,4,6,1
		RSAR	0,14,0,19,0,15,0,15
		D1R	0,0,0,20
		D2R	0,0,0,10
		RRL	15,6,15,4,15,5,15,11
		TL	0,0,31,0

	;--------------------------------
	;
	;--------------------------------
SB2::
	DW	TIMBB2			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB20,000H,000H 	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB20:
		DB	FEV,0
	TB20:
		DB	96H,28H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB2::
		CNF	0,6
		MD	0,0,0,4,0,3,0,7
		RSAR	0,18,0,16,0,24,0,16
		D1R	0,16,23,31
		D2R	11,0,0,16
		RRL	15,6,15,3,15,3,15,3
		TL	0,8,0,0

	;--------------------------------
	;
	;--------------------------------
SB3::
	DW	TIMBB3			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB30,000H,000H 	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB30:
		DB	FEV,0
	TB30:
		DB	087H,18H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB3::
		CNF	4,6
		MD	13,4,8,10,7,3,4,7
		RSAR	0,31,0,31,0,31,0,31
		D1R	26,28,21,21
		D2R	21,21,20,20
		RRL	15,5,15,8,15,3,15,6
		TL	18H,10H,20H,0
	
	;--------------------------------
	;
	;--------------------------------
SB4::
	DW	TIMBB4			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB40,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB40:
		DB	FEV,0
	TB40:
		DB	0B0H,18H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB4::
		CNF	1,6 
		MD	12,6,6,4,1,3,2,7
		RSAR	0,31,0,31,0,31,0,31
		D1R	16,16,31,19
		D2R	22,16,16,24
		RRL	15,1,15,1,15,1,15,5
		TL	30H,32H,30H,0
	
	;--------------------------------
	;
	;--------------------------------
SB5::
	DW	TIMBB5			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB50,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB50:
		DB	FEV,0
	TB50:
		DB	9DH,6
		DB	97H,60H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB5::
		CNF	3,6
		MD	0,3,0,1,4,2,6,5
		RSAR	0,31,0,31,0,31,0,31
		D1R	16,16,5,21
		D2R	0,0,0,17
		RRL	15,1,3,1,15,1,15,2
		TL	0,0,0,0

	;--------------------------------
	;
	;--------------------------------
SB6::
	DW	TIMBB6			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB60,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB60:
		DB	FEV,0
	TB60:
		DB	95H,2,95H,32H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB6::
		CNF	4,6
		MD	0,3,0,4,4,4,1,5
		RSAR	0,31,0,31,0,31,0,31
		D1R	16,19,0,21
		D2R	31,31,0,26
		RRL	15,7,15,7,15,0,15,5
		TL	2,0,40H,0
	
	;--------------------------------
	;
	;--------------------------------
SB7::
	DW	TIMBB7			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	0A0H,5,TABB70,000H,000H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB70:
		DB	FEV,0
	TB70:
		DB	0ABH,0EDH,4
		DB	0B6H,0E0H,40H
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB7::
		CNF	6,6
		MD	3,6,0,3,0,3,0,4
		RSAR	0,22,0,16,0,16,0,16
		D1R	21,12,16,16
		D2R	0,12,0,16
		RRL	15,1,15,4,15,5,15,2
		TL	0,0,0,8

	;--------------------------------
	;
	;--------------------------------
SB8::
	DW	TIMBB8			; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,5,TABB80,000H,000H	; flag,chian,table pointer,bias,volm
	HD	80H,6,TABB81,000H,018H	; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB81:
		DB	NL,2
	TABB80:
		DB	FEV,0
	TB80:
		DB	0a5h,1Bh
		db	CMVADD,16
		DB	0a5h,10
		db	CMVADD,8
		DB	0a5h,015H
		db	CMVADD,12H
		DB	0a5h,18h
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBB8::
		CNF	2,14
		MD	7,3,9,3,9,1,4,1
		RSAR	0,29,0,31,0,31,0,31
		D1R	16,18,20,20
		D2R	24,24,16,18
		RRL	15,6,15,4,15,5,15,13
		TL	30H,30H,20H,0

	;--------------------------------
	;
	;--------------------------------
SB9::
	DW	TIMBB9			; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,80H,TABB90,0F4H,000H ; flag,chian,table pointer,bias,volm
	HD	080H,0A0H,TABB90P,0F4H,2 ; flag,chian,table pointer,bias,volm

;----------------- TABLE DATA -------------------
TABB90:
	;	DB	FEV,1
	TB90:
		DB	EV,2
		DB	CN3,4
		DB	CMEND
	TABB90P:
		DB	EV,2
		DB	NL,2
		DB	CN3,4
		DB	CMEND
;----------------- VOICE DATA ---------------
TIMBB9::



	;--------------------------------
	;
	;--------------------------------
SBA::
	DW	TIMBBA			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBA0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBA0:
		DB	FEV,0
	TBA0:
		DB	94H,8
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBBA::
		CNF	4,9*2
		MD	6,6,5,6,4,3,2,7
		RSAR	0,20,0,17,0,19,0,16
		D1R	19,19,21,24
		D2R	23,25,18,20
		RRL	15,2,14,3,15,4,15,5
		TL	8,16,24,0

	;--------------------------------
	;
	;--------------------------------
SBB::
	DW	TIMBBB			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBB0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBB0:
	TBB0:
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
		DW	TBB0

	SUB9B0:
		DB	C3,20H,D3,E3,F3,G3,A3,B3,40H
		DB	CMRET
;----------------- VOICE DATA ---------------
TIMBBB::
		CNF	4,9*2
		MD	4,6,4,6,4,3,2,4
		RSAR	0,31,0,31,0,31,0,31
		D1R	08,08,08,08
		D2R	00,00,00,00
		RRL	15,2,14,3,15,4,15,5
		TL	8,0,24,0


	;--------------------------------
	;
	;--------------------------------
SBC::
	DW	TIMBBC			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBC0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBC0:
		DB	FEV,0
	TBC0:
		DB	94H,8
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBBC::
		CNF	4,9*2
		MD	6,6,5,6,4,3,2,7
		RSAR	0,20,0,17,0,19,0,16
		D1R	19,19,21,24
		D2R	23,25,18,20
		RRL	15,2,14,3,15,4,15,5
		TL	8,16,24,0

	;--------------------------------
	;
	;--------------------------------
SBD::
	DW	TIMBBD			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBD0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBD0:
		DB	FEV,0
	TBD0:
		DB	94H,8
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBBD::
		CNF	4,9*2
		MD	6,6,5,6,4,3,2,7
		RSAR	0,20,0,17,0,19,0,16
		D1R	19,19,21,24
		D2R	23,25,18,20
		RRL	15,2,14,3,15,4,15,5
		TL	8,16,24,0

	;--------------------------------
	;
	;--------------------------------
SBE::
	DW	TIMBBE			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBE0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBE0:
		DB	FEV,0
	TBE0:
		DB	94H,8
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBBE::
		CNF	4,9*2
		MD	6,6,5,6,4,3,2,7
		RSAR	0,20,0,17,0,19,0,16
		D1R	19,19,21,24
		D2R	23,25,18,20
		RRL	15,2,14,3,15,4,15,5
		TL	8,16,24,0

	;--------------------------------
	;
	;--------------------------------
SBF::
	DW	TIMBBF			; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABBF0,000H,000H	; flag,chian,table pointer,bias,volm
;----------------- TABLE DATA -------------------
TABBF0:
		DB	FEV,0
	TBF0:
		DB	94H,8
		DB	CMEND
	
;----------------- VOICE DATA ---------------
TIMBBF::
		CNF	4,9*2
		MD	6,6,5,6,4,3,2,7
		RSAR	0,20,0,17,0,19,0,16
		D1R	19,19,21,24
		D2R	23,25,18,20
		RRL	15,2,14,3,15,4,15,5
		TL	8,16,24,0

