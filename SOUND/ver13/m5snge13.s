;********************************************************
;*		$$$SNG8E.S	( SOUND DATA FILE )	*
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
MELO8EA		equ	0
MELO8EB		equ	0
MELO8EC		equ	0
BASS8EA		equ	0
BASS8EB		equ	0
BASS8EC		equ	0
BACK8E1A	equ	0
BACK8E1B	equ	0
BACK8E1C	equ	0
BACK8E2A	equ	0
BACK8E2B	equ	0
BACK8E2C	equ	0
BACK8E3A	equ	0
BACK8E3B	equ	0
BACK8E3C	equ	0

;========== TEMPO =============
TP8E	EQU	2		; tempo for S8E
DL8E	EQU	0		; dlay counter for S8E
;<<<<<<<< S8E FM BIAS >>>>>>>>
FB8E	EQU	0F5H
;-----------------------------
FB8EM	EQU	FB8E		; fm melo
FB8EB	EQU	LOW FB8E+12	; fm bass	
FB8EK1	EQU	FB8E		; fm back 1
FB8Ek2	EQU	FB8E		; fm back 2
FB8Ek3	EQU	FB8E		; fm back 3
FB8Ek4	EQU	FB8E		; fm back 4
PB8EM	EQU	FB8E		; psg 1
PB8EB	EQU	FB8E		; psg 2
PB8EK	EQU	FB8E		; psg 3
;<<<<<<<< S8E VOLM >>>>>>>>>	 
FA8EM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8EB	EQU	FV_BS		; fm bass
FA8EK1	EQU	FV_BK1		; fm back 1
FA8EK2	EQU	FV_BK2		; fm back 2
FA8EK3	EQU	FV_BK3		; fm back 3
FA8EK4	EQU	FV_BK4		; fm back 4
PA8EM	EQU	PV_ML		; psg 1
PA8EB	EQU	PV_BS		; psg 2
PA8EK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8E VIBR >>>>>>>>
PV8EM	EQU	1		; melo
PV8EB	EQU	0		; bass
PV8EK	EQU	0		; back
;<<<<<<<<< S8E ENVE >>>>>>>>
PE8EM	EQU	1		; melo
PE8EB	EQU	2		; bass
PE8EK	EQU	3		; back

;********************************
;*
;********************************

S8E::
	DW	TIMB8E				; VOICE TOP ADDR.

	DB	6,2,TP8E,DL8E			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8ED				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8E0
	DEFB	FB8EM,FA8EM

	DEFW	TAB8E1
	DEFB	FB8EB,FA8EB

	DEFW	TAB8E2
	DEFB	FB8EK1,FA8EK1

	DEFW	TAB8E3
	DEFB	FB8EK2,FA8EK2

	DEFW	TAB8E4
	DEFB	FB8EK3,FA8EK3

	DEFW	TAB8E0P
	DEFB	PB8EM,PA8EM,PV8EM,PE8EM

	DEFW	TAB8E1P
	DEFB	PB8EB,PA8EB,PV8EB,PE8EB

;	DEFW	TAB8E2P
;	DEFB	PB8EK,PA8EK,PV8EK,PE8EK


;<<<<<<<  CH0  >>>>>>>>>>>
TAB8E0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8EA
T8E0A:
	db	FEV,MELO8EB
T8E0B:
	db	FEV,MELO8EC
T8E0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8E1::
	db	FEV,BASS8EA
T8E1A:
	db	FEV,BASS8EB
T8E1B:
	db	FEV,BASS8EC
T8E1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8E2::
	db	FEV,BACK8E1A
T8E2A:
	db	FEV,BACK8E1B
T8E2B:
	db	FEV,BACK8E1C
T8E2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8E3::
	db	FEV,BACK8E2A
T8E3A:
	db	FEV,BACK8E2B
T8E3B:
	db	FEV,BACK8E2C
T8E3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8E4::
	db	FEV,BACK8E3A
T8E4A:
	db	FEV,BACK8E3B
T8E4B:
	db	FEV,BACK8E3C
T8E4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8E0P::
T8E0PA:
T8E0PB:
T8E0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8E1P::
T8E1PA:
T8E1PB:
T8E1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8ED::
T8EDA:
T8EDB:
T8EDC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8ED


TIMB8E::
	;---------------<: bass 1 >---------------
fev8E00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8E01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8E02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8E03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8E04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8E05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8E06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8E07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8E08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8E09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8F::
	DW	TIMB8E				; VOICE TOP ADDR.

	DB	6,2,TP8E,DL8E			; FM CHIAN,PSG,CHIAN

	DEFW	T8EDB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8E0B
	DEFB	FB8EM,FA8EM


	DEFW	T8E1B
	DEFB	FB8EB,FA8EB

	DEFW	T8E2B
	DEFB	FB8EK1,FA8EK1

	DEFW	T8E3B
	DEFB	FB8EK2,FA8EK2

	DEFW	T8E4B
	DEFB	FB8EK3,FA8EK3

	DEFW	T8E0PB
	DEFB	PB8EM,PA8EM,PV8EM,PE8EM

	DEFW	T8E1PB
	DEFB	PB8EB,PA8EB,PV8EB,PE8EB

;	DEFW	TAB8E2PB
;	DEFB	PB8EK,PA8EK,PV8EK,PE8EK


S90::
	DW	TIMB8E				; VOICE TOP ADDR.

	DB	6,2,TP8E,DL8E			; FM CHIAN,PSG,CHIAN

	DEFW	T8EDC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8E0C
	DEFB	FB8EM,FA8EM


	DEFW	T8E1C
	DEFB	FB8EB,FA8EB

	DEFW	T8E2C
	DEFB	FB8EK1,FA8EK1

	DEFW	T8E3C
	DEFB	FB8EK2,FA8EK2

	DEFW	T8E4C
	DEFB	FB8EK3,FA8EK3

	DEFW	T8E0PC
	DEFB	PB8EM,PA8EM,PV8EM,PE8EM

	DEFW	T8E1PC
	DEFB	PB8EB,PA8EB,PV8EB,PE8EB

;	DEFW	T8E2PC
;	DEFB	PB8EK,PA8EK,PV8EK,PE8EK

	endif
