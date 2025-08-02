;********************************************************
;*		$$$SNG8C.S	( SOUND DATA FILE )	*
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
MELO8CA		equ	0
MELO8CB		equ	0
MELO8CC		equ	0
BASS8CA		equ	0
BASS8CB		equ	0
BASS8CC		equ	0
BACK8C1A	equ	0
BACK8C1B	equ	0
BACK8C1C	equ	0
BACK8C2A	equ	0
BACK8C2B	equ	0
BACK8C2C	equ	0
BACK8C3A	equ	0
BACK8C3B	equ	0
BACK8C3C	equ	0

;========== TEMPO =============
TP8C	EQU	2		; tempo for S8C
DL8C	EQU	0		; dlay counter for S8C
;<<<<<<<< S8C FM BIAS >>>>>>>>
FB8C	EQU	0F5H
;-----------------------------
FB8CM	EQU	FB8C		; fm melo
FB8CB	EQU	LOW FB8C+12	; fm bass	
FB8CK1	EQU	FB8C		; fm back 1
FB8Ck2	EQU	FB8C		; fm back 2
FB8Ck3	EQU	FB8C		; fm back 3
FB8Ck4	EQU	FB8C		; fm back 4
PB8CM	EQU	FB8C		; psg 1
PB8CB	EQU	FB8C		; psg 2
PB8CK	EQU	FB8C		; psg 3
;<<<<<<<< S8C VOLM >>>>>>>>>	 
FA8CM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8CB	EQU	FV_BS		; fm bass
FA8CK1	EQU	FV_BK1		; fm back 1
FA8CK2	EQU	FV_BK2		; fm back 2
FA8CK3	EQU	FV_BK3		; fm back 3
FA8CK4	EQU	FV_BK4		; fm back 4
PA8CM	EQU	PV_ML		; psg 1
PA8CB	EQU	PV_BS		; psg 2
PA8CK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8C VIBR >>>>>>>>
PV8CM	EQU	1		; melo
PV8CB	EQU	0		; bass
PV8CK	EQU	0		; back
;<<<<<<<<< S8C ENVE >>>>>>>>
PE8CM	EQU	1		; melo
PE8CB	EQU	2		; bass
PE8CK	EQU	3		; back

;********************************
;*
;********************************
;********************************  
;*                                 
;********************************  

S8C::
	DW	TIMB8C				; VOICE TOP ADDR.

	DB	6,2,TP8C,DL8C			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8CD				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8C0
	DEFB	FB8CM,FA8CM

	DEFW	TAB8C1
	DEFB	FB8CB,FA8CB

	DEFW	TAB8C2
	DEFB	FB8CK1,FA8CK1

	DEFW	TAB8C3
	DEFB	FB8CK2,FA8CK2

	DEFW	TAB8C4
	DEFB	FB8CK3,FA8CK3

	DEFW	TAB8C0P
	DEFB	PB8CM,PA8CM,PV8CM,PE8CM

	DEFW	TAB8C1P
	DEFB	PB8CB,PA8CB,PV8CB,PE8CB

;	DEFW	TAB8C2P
;	DEFB	PB8CK,PA8CK,PV8CK,PE8CK

;<<<<<<<  CH0  >>>>>>>>>>>
TAB8C0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8CA
T8C0A:
	db	FEV,MELO8CB
T8C0B:
	db	FEV,MELO8CC
T8C0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8C1::
	db	FEV,BASS8CA
T8C1A:
	db	FEV,BASS8CB
T8C1B:
	db	FEV,BASS8CC
T8C1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8C2::
	db	FEV,BACK8C1A
T8C2A:
	db	FEV,BACK8C1B
T8C2B:
	db	FEV,BACK8C1C
T8C2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8C3::
	db	FEV,BACK8C2A
T8C3A:
	db	FEV,BACK8C2B
T8C3B:
	db	FEV,BACK8C2C
T8C3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8C4::
	db	FEV,BACK8C3A
T8C4A:
	db	FEV,BACK8C3B
T8C4B:
	db	FEV,BACK8C3C
T8C4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8C0P::
T8C0PA:
T8C0PB:
T8C0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8C1P::
T8C1PA:
T8C1PB:
T8C1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8CD::
T8CDA:
T8CDB:
T8CDC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8CD


TIMB8C::
	;---------------<: bass 1 >---------------
fev8C00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8C01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8C02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8C03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8C04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8C05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8C06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8C07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8C08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8C09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8D::
	DW	TIMB8C				; VOICE TOP ADDR.

	DB	6,2,TP8C,DL8C			; FM CHIAN,PSG,CHIAN

	DEFW	T8CDB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8C0B
	DEFB	FB8CM,FA8CM


	DEFW	T8C1B
	DEFB	FB8CB,FA8CB

	DEFW	T8C2B
	DEFB	FB8CK1,FA8CK1

	DEFW	T8C3B
	DEFB	FB8CK2,FA8CK2

	DEFW	T8C4B
	DEFB	FB8CK3,FA8CK3

	DEFW	T8C0PB
	DEFB	PB8CM,PA8CM,PV8CM,PE8CM

	DEFW	T8C1PB
	DEFB	PB8CB,PA8CB,PV8CB,PE8CB

;	DEFW	TAB8C2PB
;	DEFB	PB8CK,PA8CK,PV8CK,PE8CK


S8E::
	DW	TIMB8C				; VOICE TOP ADDR.

	DB	6,2,TP8C,DL8C			; FM CHIAN,PSG,CHIAN

	DEFW	T8CDC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8C0C
	DEFB	FB8CM,FA8CM


	DEFW	T8C1C
	DEFB	FB8CB,FA8CB

	DEFW	T8C2C
	DEFB	FB8CK1,FA8CK1

	DEFW	T8C3C
	DEFB	FB8CK2,FA8CK2

	DEFW	T8C4C
	DEFB	FB8CK3,FA8CK3

	DEFW	T8C0PC
	DEFB	PB8CM,PA8CM,PV8CM,PE8CM

	DEFW	T8C1PC
	DEFB	PB8CB,PA8CB,PV8CB,PE8CB

;	DEFW	T8C2PC
;	DEFB	PB8CK,PA8CK,PV8CK,PE8CK

	endif
