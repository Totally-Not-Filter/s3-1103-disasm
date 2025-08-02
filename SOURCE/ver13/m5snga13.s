;********************************************************
;*		$$$SNG8A.S	( SOUND DATA FILE )	*
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
MELO8AA		equ	0
MELO8AB		equ	0
MELO8AC		equ	0
BASS8AA		equ	0
BASS8AB		equ	0
BASS8AC		equ	0
BACK8A1A	equ	0
BACK8A1B	equ	0
BACK8A1C	equ	0
BACK8A2A	equ	0
BACK8A2B	equ	0
BACK8A2C	equ	0
BACK8A3A	equ	0
BACK8A3B	equ	0
BACK8A3C	equ	0

;========== TEMPO =============
TP8A	EQU	2		; tempo for S8A
DL8A	EQU	0		; dlay counter for S8A
;<<<<<<<< S8A FM BIAS >>>>>>>>
FB8A	EQU	0F5H
;-----------------------------
FB8AM	EQU	FB8A		; fm melo
FB8AB	EQU	LOW FB8A+12	; fm bass	
FB8AK1	EQU	FB8A		; fm back 1
FB8Ak2	EQU	FB8A		; fm back 2
FB8Ak3	EQU	FB8A		; fm back 3
FB8Ak4	EQU	FB8A		; fm back 4
PB8AM	EQU	FB8A		; psg 1
PB8AB	EQU	FB8A		; psg 2
PB8AK	EQU	FB8A		; psg 3
;<<<<<<<< S8A VOLM >>>>>>>>>	 
FA8AM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8AB	EQU	FV_BS		; fm bass
FA8AK1	EQU	FV_BK1		; fm back 1
FA8AK2	EQU	FV_BK2		; fm back 2
FA8AK3	EQU	FV_BK3		; fm back 3
FA8AK4	EQU	FV_BK4		; fm back 4
PA8AM	EQU	PV_ML		; psg 1
PA8AB	EQU	PV_BS		; psg 2
PA8AK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8A VIBR >>>>>>>>
PV8AM	EQU	1		; melo
PV8AB	EQU	0		; bass
PV8AK	EQU	0		; back
;<<<<<<<<< S8A ENVE >>>>>>>>
PE8AM	EQU	1		; melo
PE8AB	EQU	2		; bass
PE8AK	EQU	3		; back

;********************************  
;*                                 
;********************************  

S8A::
	DW	TIMB8A				; VOICE TOP ADDR.

	DB	6,2,TP8A,DL8A			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8AD				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8A0
	DEFB	FB8AM,FA8AM

	DEFW	TAB8A1
	DEFB	FB8AB,FA8AB

	DEFW	TAB8A2
	DEFB	FB8AK1,FA8AK1

	DEFW	TAB8A3
	DEFB	FB8AK2,FA8AK2

	DEFW	TAB8A4
	DEFB	FB8AK3,FA8AK3

	DEFW	TAB8A0P
	DEFB	PB8AM,PA8AM,PV8AM,PE8AM

	DEFW	TAB8A1P
	DEFB	PB8AB,PA8AB,PV8AB,PE8AB

;	DEFW	TAB8A2P
;	DEFB	PB8AK,PA8AK,PV8AK,PE8AK


;<<<<<<<  CH0  >>>>>>>>>>>
TAB8A0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8AA
T8A0A:
	db	FEV,MELO8AB
T8A0B:
	db	FEV,MELO8AC
T8A0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8A1::
	db	FEV,BASS8AA
T8A1A:
	db	FEV,BASS8AB
T8A1B:
	db	FEV,BASS8AC
T8A1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8A2::
	db	FEV,BACK8A1A
T8A2A:
	db	FEV,BACK8A1B
T8A2B:
	db	FEV,BACK8A1C
T8A2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8A3::
	db	FEV,BACK8A2A
T8A3A:
	db	FEV,BACK8A2B
T8A3B:
	db	FEV,BACK8A2C
T8A3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8A4::
	db	FEV,BACK8A3A
T8A4A:
	db	FEV,BACK8A3B
T8A4B:
	db	FEV,BACK8A3C
T8A4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8A0P::
T8A0PA:
T8A0PB:
T8A0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8A1P::
T8A1PA:
T8A1PB:
T8A1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8AD::
T8ADA:
T8ADB:
T8ADC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8AD

TIMB8A::
	;---------------<: bass 1 >---------------
fev8A00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8A01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8A02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8A03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8A04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8A05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8A06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8A07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8A08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8A09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8B::
	DW	TIMB8A				; VOICE TOP ADDR.

	DB	6,2,TP8A,DL8A			; FM CHIAN,PSG,CHIAN

	DEFW	T8ADB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8A0B
	DEFB	FB8AM,FA8AM


	DEFW	T8A1B
	DEFB	FB8AB,FA8AB

	DEFW	T8A2B
	DEFB	FB8AK1,FA8AK1

	DEFW	T8A3B
	DEFB	FB8AK2,FA8AK2

	DEFW	T8A4B
	DEFB	FB8AK3,FA8AK3

	DEFW	T8A0PB
	DEFB	PB8AM,PA8AM,PV8AM,PE8AM

	DEFW	T8A1PB
	DEFB	PB8AB,PA8AB,PV8AB,PE8AB

;	DEFW	TAB8A2PB
;	DEFB	PB8AK,PA8AK,PV8AK,PE8AK


S8C::
	DW	TIMB8A				; VOICE TOP ADDR.

	DB	6,2,TP8A,DL8A			; FM CHIAN,PSG,CHIAN

	DEFW	T8ADC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8A0C
	DEFB	FB8AM,FA8AM


	DEFW	T8A1C
	DEFB	FB8AB,FA8AB

	DEFW	T8A2C
	DEFB	FB8AK1,FA8AK1

	DEFW	T8A3C
	DEFB	FB8AK2,FA8AK2

	DEFW	T8A4C
	DEFB	FB8AK3,FA8AK3

	DEFW	T8A0PC
	DEFB	PB8AM,PA8AM,PV8AM,PE8AM

	DEFW	T8A1PC
	DEFB	PB8AB,PA8AB,PV8AB,PE8AB

;	DEFW	T8A2PC
;	DEFB	PB8AK,PA8AK,PV8AK,PE8AK

	endif
