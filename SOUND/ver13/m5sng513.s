;********************************************************
;*		$$$SNG85.S	( SOUND DATA FILE )	*
;*  			ORG. M5SNG1.31.S               	*
;*		'SOUND-SORCE'                           *
;*		 for Mega Drive (Z80)			*
;*			VER  1.31/1989.12.10		*
;*				BY        T.Uwabo       *
;********************************************************

	.XLIST
	include m5eq13.lib
	include m5mcr13.lib
	include m5tb13.lib
	.LIST

;-------------- voice assign ------
MELO85A		equ	0
MELO85B		equ	0
MELO85C		equ	0
BASS85A		equ	0
BASS85B		equ	0
BASS85C		equ	0
BACK851A	equ	0
BACK851B	equ	0
BACK851C	equ	0
BACK852A	equ	0
BACK852B	equ	0
BACK852C	equ	0
BACK853A	equ	0
BACK853B	equ	0
BACK853C	equ	0

;========== TEMPO =============
TP85	EQU	2		; tempo for S85
DL85	EQU	0		; dlay counter for S85
;<<<<<<<< S85 FM BIAS >>>>>>>>
FB85	EQU	0F4H
;-----------------------------
FB85M	EQU	FB85		; fm code
FB85B	EQU	FB85		; fm code	
FB85K1	EQU	FB85		; fm code
FB85k2	EQU	FB85		; fm bass
FB85k3	EQU	FB85		; fm back 3
FB85k4	EQU	FB85		; fm back 4
PB85M	EQU	FB85		; psg 1
PB85B	EQU	FB85		; psg 2
PB85K	EQU	FB85		; psg 3
;<<<<<<<< S85 VOLM >>>>>>>>>	 
FA85D	EQU	FV_DR		; fm rythm
FA85M	EQU	FV_ML		; fm code      ( FV_ML ==> show   glfeq.lib )
FA85B	EQU	FV_ML		; fm code
FA85K1	EQU	FV_ML		; fm code
FA85K2	EQU	FV_BS+8		; fm baaa
FA85K3	EQU	FV_BK3		; fm back 3
FA85K4	EQU	FV_BK4		; fm back 4
PA85M	EQU	PV_ML		; psg 1
PA85B	EQU	PV_BS		; psg 2
PA85K	EQU	PV_BK		; psg 3
;<<<<<<<<< S85 VIBR >>>>>>>>
PV85M	EQU	0		; melo
PV85B	EQU	0		; bass
PV85K	EQU	0		; back
;<<<<<<<<< S85 ENVE >>>>>>>>
PE85M	EQU	0		; melo
PE85B	EQU	0		; bass
PE85K	EQU	0		; back

;********************************
;*
;********************************

S85::
	DW	TIMB85				; VOICE TOP ADDR.

	DB	6,2,TP85,DL85			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB85D				; rythm table pointer
	DEFB	0,FA85D				; bias,volm

	DEFW	TAB850
	DEFB	FB85M,FA85M

	DEFW	TAB851
	DEFB	FB85B,FA85B

	DEFW	TAB852
	DEFB	FB85K1,FA85K1

	DEFW	TAB853
	DEFB	FB85K2,FA85K2

	DEFW	TAB854
	DEFB	FB85K3,FA85K3

	DEFW	TAB850P
	DEFB	PB85M,PA85M,PV85M,PE85M

	DEFW	TAB851P
	DEFB	PB85B,PA85B,PV85B,PE85B

;	DEFW	TAB852P
;	DEFB	PB85K,PA85K,PV85K,PE85K

;<<<<<<<  CH0  >>>>>>>>>>>
TAB850::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO85A
T850A:
	db	FEV,MELO85B
T850B:
	db	FEV,MELO85C
T850C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB851::
	db	FEV,BASS85A
T851A:
	db	FEV,BASS85B
T851B:
	db	FEV,BASS85C
T851C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB852::
	db	FEV,BACK851A
T852A:
	db	FEV,BACK851B
T852B:
	db	FEV,BACK851C
T852C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB853::
	db	FEV,BACK852A
T853A:
	db	FEV,BACK852B
T853B:
	db	FEV,BACK852C
T853C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB854::
	db	FEV,BACK853A
T854A:
	db	FEV,BACK853B
T854B:
	db	FEV,BACK853C
T854C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB850P::
T850PA:
T850PB:
T850PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB851P::
T851PA:
T851PB:
T851PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB85D::
T85DA:
T85DB:
T85DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB85D

TIMB85::
	;---------------<: bass 1 >---------------
fev8500::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8501::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8502::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8503::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8504::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8505::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8506::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8507::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8508::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8509::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S86::
	DW	TIMB85				; VOICE TOP ADDR.

	DB	6,2,TP85,DL85			; FM CHIAN,PSG,CHIAN

	DEFW	T85DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T850B
	DEFB	FB85M,FA85M


	DEFW	T851B
	DEFB	FB85B,FA85B

	DEFW	T852B
	DEFB	FB85K1,FA85K1

	DEFW	T853B
	DEFB	FB85K2,FA85K2

	DEFW	T854B
	DEFB	FB85K3,FA85K3

	DEFW	T850PB
	DEFB	PB85M,PA85M,PV85M,PE85M

	DEFW	T851PB
	DEFB	PB85B,PA85B,PV85B,PE85B

;	DEFW	TAB852PB
;	DEFB	PB85K,PA85K,PV85K,PE85K


S87::
	DW	TIMB85				; VOICE TOP ADDR.

	DB	6,2,TP85,DL85			; FM CHIAN,PSG,CHIAN

	DEFW	T85DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T850C
	DEFB	FB85M,FA85M


	DEFW	T851C
	DEFB	FB85B,FA85B

	DEFW	T852C
	DEFB	FB85K1,FA85K1

	DEFW	T853C
	DEFB	FB85K2,FA85K2

	DEFW	T854C
	DEFB	FB85K3,FA85K3

	DEFW	T850PC
	DEFB	PB85M,PA85M,PV85M,PE85M

	DEFW	T851PC
	DEFB	PB85B,PA85B,PV85B,PE85B

;	DEFW	T852PC
;	DEFB	PB85K,PA85K,PV85K,PE85K

	endif
