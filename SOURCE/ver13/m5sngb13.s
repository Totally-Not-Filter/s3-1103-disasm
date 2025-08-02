;********************************************************
;*		$$$SNG8B.S	( SOUND DATA FILE )	*
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
MELO8BA		equ	0
MELO8BB		equ	0
MELO8BC		equ	0
BASS8BA		equ	0
BASS8BB		equ	0
BASS8BC		equ	0
BACK8B1A	equ	0
BACK8B1B	equ	0
BACK8B1C	equ	0
BACK8B2A	equ	0
BACK8B2B	equ	0
BACK8B2C	equ	0
BACK8B3A	equ	0
BACK8B3B	equ	0
BACK8B3C	equ	0

;========== TEMPO =============
TP8B	EQU	2		; tempo for S8B
DL8B	EQU	0		; dlay counter for S8B
;<<<<<<<< S8B FM BIAS >>>>>>>>
FB8B	EQU	0F5H
;-----------------------------
FB8BM	EQU	FB8B		; fm melo
FB8BB	EQU	LOW FB8B+12	; fm bass	
FB8BK1	EQU	FB8B		; fm back 1
FB8Bk2	EQU	FB8B		; fm back 2
FB8Bk3	EQU	FB8B		; fm back 3
FB8Bk4	EQU	FB8B		; fm back 4
PB8BM	EQU	FB8B		; psg 1
PB8BB	EQU	FB8B		; psg 2
PB8BK	EQU	FB8B		; psg 3
;<<<<<<<< S8B VOLM >>>>>>>>>	 
FA8BM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8BB	EQU	FV_BS		; fm bass
FA8BK1	EQU	FV_BK1		; fm back 1
FA8BK2	EQU	FV_BK2		; fm back 2
FA8BK3	EQU	FV_BK3		; fm back 3
FA8BK4	EQU	FV_BK4		; fm back 4
PA8BM	EQU	PV_ML		; psg 1
PA8BB	EQU	PV_BS		; psg 2
PA8BK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8B VIBR >>>>>>>>
PV8BM	EQU	1		; melo
PV8BB	EQU	0		; bass
PV8BK	EQU	0		; back
;<<<<<<<<< S8B ENVE >>>>>>>>
PE8BM	EQU	1		; melo
PE8BB	EQU	2		; bass
PE8BK	EQU	3		; back

;********************************  
;*                                 
;********************************  

S8B::
	DW	TIMB8B				; VOICE TOP ADDR.

	DB	6,2,TP8B,DL8B			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8BD				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8B0
	DEFB	FB8BM,FA8BM

	DEFW	TAB8B1
	DEFB	FB8BB,FA8BB

	DEFW	TAB8B2
	DEFB	FB8BK1,FA8BK1

	DEFW	TAB8B3
	DEFB	FB8BK2,FA8BK2

	DEFW	TAB8B4
	DEFB	FB8BK3,FA8BK3

	DEFW	TAB8B0P
	DEFB	PB8BM,PA8BM,PV8BM,PE8BM

	DEFW	TAB8B1P
	DEFB	PB8BB,PA8BB,PV8BB,PE8BB

;	DEFW	TAB8B2P
;	DEFB	PB8BK,PA8BK,PV8BK,PE8BK


;<<<<<<<  CH0  >>>>>>>>>>>
TAB8B0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8BA
T8B0A:
	db	FEV,MELO8BB
T8B0B:
	db	FEV,MELO8BC
T8B0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8B1::
	db	FEV,BASS8BA
T8B1A:
	db	FEV,BASS8BB
T8B1B:
	db	FEV,BASS8BC
T8B1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8B2::
	db	FEV,BACK8B1A
T8B2A:
	db	FEV,BACK8B1B
T8B2B:
	db	FEV,BACK8B1C
T8B2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8B3::
	db	FEV,BACK8B2A
T8B3A:
	db	FEV,BACK8B2B
T8B3B:
	db	FEV,BACK8B2C
T8B3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8B4::
	db	FEV,BACK8B3A
T8B4A:
	db	FEV,BACK8B3B
T8B4B:
	db	FEV,BACK8B3C
T8B4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8B0P::
T8B0PA:
T8B0PB:
T8B0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8B1P::
T8B1PA:
T8B1PB:
T8B1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8BD::
T8BDA:
T8BDB:
T8BDC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8BD

TIMB8B::
	;---------------<: bass 1 >---------------
fev8B00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8B01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8B02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8B03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8B04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8B05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8B06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8B07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8B08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8B09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8C::
	DW	TIMB8B				; VOICE TOP ADDR.

	DB	6,2,TP8B,DL8B			; FM CHIAN,PSG,CHIAN

	DEFW	T8BDB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8B0B
	DEFB	FB8BM,FA8BM


	DEFW	T8B1B
	DEFB	FB8BB,FA8BB

	DEFW	T8B2B
	DEFB	FB8BK1,FA8BK1

	DEFW	T8B3B
	DEFB	FB8BK2,FA8BK2

	DEFW	T8B4B
	DEFB	FB8BK3,FA8BK3

	DEFW	T8B0PB
	DEFB	PB8BM,PA8BM,PV8BM,PE8BM

	DEFW	T8B1PB
	DEFB	PB8BB,PA8BB,PV8BB,PE8BB

;	DEFW	TAB8B2PB
;	DEFB	PB8BK,PA8BK,PV8BK,PE8BK


S8D::
	DW	TIMB8B				; VOICE TOP ADDR.

	DB	6,2,TP8B,DL8B			; FM CHIAN,PSG,CHIAN

	DEFW	T8BDC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8B0C
	DEFB	FB8BM,FA8BM


	DEFW	T8B1C
	DEFB	FB8BB,FA8BB

	DEFW	T8B2C
	DEFB	FB8BK1,FA8BK1

	DEFW	T8B3C
	DEFB	FB8BK2,FA8BK2

	DEFW	T8B4C
	DEFB	FB8BK3,FA8BK3

	DEFW	T8B0PC
	DEFB	PB8BM,PA8BM,PV8BM,PE8BM

	DEFW	T8B1PC
	DEFB	PB8BB,PA8BB,PV8BB,PE8BB

;	DEFW	T8B2PC
;	DEFB	PB8BK,PA8BK,PV8BK,PE8BK

	endif
