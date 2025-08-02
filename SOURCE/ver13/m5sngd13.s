;********************************************************
;*		$$$SNG8D.S	( SOUND DATA FILE )	*
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
MELO8DA		equ	0
MELO8DB		equ	0
MELO8DC		equ	0
BASS8DA		equ	0
BASS8DB		equ	0
BASS8DC		equ	0
BACK8D1A	equ	0
BACK8D1B	equ	0
BACK8D1C	equ	0
BACK8D2A	equ	0
BACK8D2B	equ	0
BACK8D2C	equ	0
BACK8D3A	equ	0
BACK8D3B	equ	0
BACK8D3C	equ	0

;========== TEMPO =============
TP8D	EQU	2		; tempo for S8D
DL8D	EQU	0		; dlay counter for S8D
;<<<<<<<< S8D FM BIAS >>>>>>>>
FB8D	EQU	0F5H
;-----------------------------
FB8DM	EQU	FB8D		; fm melo
FB8DB	EQU	LOW FB8D+12	; fm bass	
FB8DK1	EQU	FB8D		; fm back 1
FB8Dk2	EQU	FB8D		; fm back 2
FB8Dk3	EQU	FB8D		; fm back 3
FB8Dk4	EQU	FB8D		; fm back 4
PB8DM	EQU	FB8D		; psg 1
PB8DB	EQU	FB8D		; psg 2
PB8DK	EQU	FB8D		; psg 3
;<<<<<<<< S8D VOLM >>>>>>>>>	 
FA8DM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8DB	EQU	FV_BS		; fm bass
FA8DK1	EQU	FV_BK1		; fm back 1
FA8DK2	EQU	FV_BK2		; fm back 2
FA8DK3	EQU	FV_BK3		; fm back 3
FA8DK4	EQU	FV_BK4		; fm back 4
PA8DM	EQU	PV_ML		; psg 1
PA8DB	EQU	PV_BS		; psg 2
PA8DK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8D VIBR >>>>>>>>
PV8DM	EQU	1		; melo
PV8DB	EQU	0		; bass
PV8DK	EQU	0		; back
;<<<<<<<<< S8D ENVE >>>>>>>>
PE8DM	EQU	1		; melo
PE8DB	EQU	2		; bass
PE8DK	EQU	3		; back

;********************************  
;*                                 
;********************************  

S8D::
	DW	TIMB8D				; VOICE TOP ADDR.

	DB	6,2,TP8D,DL8D			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8DD				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8D0
	DEFB	FB8DM,FA8DM

	DEFW	TAB8D1
	DEFB	FB8DB,FA8DB

	DEFW	TAB8D2
	DEFB	FB8DK1,FA8DK1

	DEFW	TAB8D3
	DEFB	FB8DK2,FA8DK2

	DEFW	TAB8D4
	DEFB	FB8DK3,FA8DK3

	DEFW	TAB8D0P
	DEFB	PB8DM,PA8DM,PV8DM,PE8DM

	DEFW	TAB8D1P
	DEFB	PB8DB,PA8DB,PV8DB,PE8DB

;	DEFW	TAB8D2P
;	DEFB	PB8DK,PA8DK,PV8DK,PE8DK


;<<<<<<<  CH0  >>>>>>>>>>>
TAB8D0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8DA
T8D0A:
	db	FEV,MELO8DB
T8D0B:
	db	FEV,MELO8DC
T8D0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8D1::
	db	FEV,BASS8DA
T8D1A:
	db	FEV,BASS8DB
T8D1B:
	db	FEV,BASS8DC
T8D1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8D2::
	db	FEV,BACK8D1A
T8D2A:
	db	FEV,BACK8D1B
T8D2B:
	db	FEV,BACK8D1C
T8D2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8D3::
	db	FEV,BACK8D2A
T8D3A:
	db	FEV,BACK8D2B
T8D3B:
	db	FEV,BACK8D2C
T8D3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8D4::
	db	FEV,BACK8D3A
T8D4A:
	db	FEV,BACK8D3B
T8D4B:
	db	FEV,BACK8D3C
T8D4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8D0P::
T8D0PA:
T8D0PB:
T8D0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8D1P::
T8D1PA:
T8D1PB:
T8D1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8DD::
T8DDA:
T8DDB:
T8DDC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8DD


TIMB8D::
	;---------------<: bass 1 >---------------
fev8D00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8D01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8D02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8D03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8D04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8D05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8D06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8D07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8D08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8D09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8E::
	DW	TIMB8D				; VOICE TOP ADDR.

	DB	6,2,TP8D,DL8D			; FM CHIAN,PSG,CHIAN

	DEFW	T8DDB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8D0B
	DEFB	FB8DM,FA8DM


	DEFW	T8D1B
	DEFB	FB8DB,FA8DB

	DEFW	T8D2B
	DEFB	FB8DK1,FA8DK1

	DEFW	T8D3B
	DEFB	FB8DK2,FA8DK2

	DEFW	T8D4B
	DEFB	FB8DK3,FA8DK3

	DEFW	T8D0PB
	DEFB	PB8DM,PA8DM,PV8DM,PE8DM

	DEFW	T8D1PB
	DEFB	PB8DB,PA8DB,PV8DB,PE8DB

;	DEFW	TAB8D2PB
;	DEFB	PB8DK,PA8DK,PV8DK,PE8DK


S8F::
	DW	TIMB8D				; VOICE TOP ADDR.

	DB	6,2,TP8D,DL8D			; FM CHIAN,PSG,CHIAN

	DEFW	T8DDC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8D0C
	DEFB	FB8DM,FA8DM


	DEFW	T8D1C
	DEFB	FB8DB,FA8DB

	DEFW	T8D2C
	DEFB	FB8DK1,FA8DK1

	DEFW	T8D3C
	DEFB	FB8DK2,FA8DK2

	DEFW	T8D4C
	DEFB	FB8DK3,FA8DK3

	DEFW	T8D0PC
	DEFB	PB8DM,PA8DM,PV8DM,PE8DM

	DEFW	T8D1PC
	DEFB	PB8DB,PA8DB,PV8DB,PE8DB

;	DEFW	T8D2PC
;	DEFB	PB8DK,PA8DK,PV8DK,PE8DK

	endif
