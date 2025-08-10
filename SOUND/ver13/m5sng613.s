;********************************************************
;*		$$$SNG86.S	( SOUND DATA FILE )	*
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
MELO86A		equ	0
MELO86B		equ	0
MELO86C		equ	0
BASS86A		equ	0
BASS86B		equ	0
BASS86C		equ	0
BACK861A	equ	0
BACK861B	equ	0
BACK861C	equ	0
BACK862A	equ	0
BACK862B	equ	0
BACK862C	equ	0
BACK863A	equ	0
BACK863B	equ	0
BACK863C	equ	0

;========== TEMPO =============
TP86	EQU	2		; tempo for S86
DL86	EQU	0		; dlay counter for S86
;<<<<<<<< S86 FM BIAS >>>>>>>>
FB86	EQU	0F5H
;-----------------------------
FB86M	EQU	FB86		; fm melo
FB86B	EQU	LOW FB86+12	; fm bass	
FB86K1	EQU	FB86		; fm back 1
FB86k2	EQU	FB86		; fm back 2
FB86k3	EQU	FB86		; fm back 3
FB86k4	EQU	FB86		; fm back 4
PB86M	EQU	FB86		; psg 1
PB86B	EQU	FB86		; psg 2
PB86K	EQU	FB86		; psg 3
;<<<<<<<< S86 VOLM >>>>>>>>>	 
FA86M	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA86B	EQU	FV_BS		; fm bass
FA86K1	EQU	FV_BK1		; fm back 1
FA86K2	EQU	FV_BK2		; fm back 2
FA86K3	EQU	FV_BK3		; fm back 3
FA86K4	EQU	FV_BK4		; fm back 4
PA86M	EQU	PV_ML		; psg 1
PA86B	EQU	PV_BS		; psg 2
PA86K	EQU	PV_BK		; psg 3
;<<<<<<<<< S86 VIBR >>>>>>>>
PV86M	EQU	1		; melo
PV86B	EQU	0		; bass
PV86K	EQU	0		; back
;<<<<<<<<< S86 ENVE >>>>>>>>
PE86M	EQU	1		; melo
PE86B	EQU	2		; bass
PE86K	EQU	3		; back

;********************************
;*
;********************************
;********************************  
;*                                 
;********************************  

S86::
	DW	TIMB86				; VOICE TOP ADDR.

	DB	6,2,TP86,DL86			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB86D				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB860
	DEFB	FB86M,FA86M

	DEFW	TAB861
	DEFB	FB86B,FA86B

	DEFW	TAB862
	DEFB	FB86K1,FA86K1

	DEFW	TAB863
	DEFB	FB86K2,FA86K2

	DEFW	TAB864
	DEFB	FB86K3,FA86K3

	DEFW	TAB860P
	DEFB	PB86M,PA86M,PV86M,PE86M

	DEFW	TAB861P
	DEFB	PB86B,PA86B,PV86B,PE86B

;	DEFW	TAB862P
;	DEFB	PB86K,PA86K,PV86K,PE86K

;<<<<<<<  CH0  >>>>>>>>>>>
TAB860::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO86A
T860A:
	db	FEV,MELO86B
T860B:
	db	FEV,MELO86C
T860C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB861::
	db	FEV,BASS86A
T861A:
	db	FEV,BASS86B
T861B:
	db	FEV,BASS86C
T861C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB862::
	db	FEV,BACK861A
T862A:
	db	FEV,BACK861B
T862B:
	db	FEV,BACK861C
T862C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB863::
	db	FEV,BACK862A
T863A:
	db	FEV,BACK862B
T863B:
	db	FEV,BACK862C
T863C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB864::
	db	FEV,BACK863A
T864A:
	db	FEV,BACK863B
T864B:
	db	FEV,BACK863C
T864C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB860P::
T860PA:
T860PB:
T860PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB861P::
T861PA:
T861PB:
T861PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB86D::
T86DA:
T86DB:
T86DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB86D

TIMB86::
	;---------------<: bass 1 >---------------
fev8600::
	CNF	2,2
	TL	00h,10h,20H,00H
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	;---------------<: bass 2 >---------------
fev8601::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8602::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8603::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8604::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8605::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8606::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8607::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8608::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8609::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S87::
	DW	TIMB86				; VOICE TOP ADDR.

	DB	6,2,TP86,DL86			; FM CHIAN,PSG,CHIAN

	DEFW	T86DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T860B
	DEFB	FB86M,FA86M


	DEFW	T861B
	DEFB	FB86B,FA86B

	DEFW	T862B
	DEFB	FB86K1,FA86K1

	DEFW	T863B
	DEFB	FB86K2,FA86K2

	DEFW	T864B
	DEFB	FB86K3,FA86K3

	DEFW	T860PB
	DEFB	PB86M,PA86M,PV86M,PE86M

	DEFW	T861PB
	DEFB	PB86B,PA86B,PV86B,PE86B

;	DEFW	TAB862PB
;	DEFB	PB86K,PA86K,PV86K,PE86K


S88::
	DW	TIMB86				; VOICE TOP ADDR.

	DB	6,2,TP86,DL86			; FM CHIAN,PSG,CHIAN

	DEFW	T86DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T860C
	DEFB	FB86M,FA86M


	DEFW	T861C
	DEFB	FB86B,FA86B

	DEFW	T862C
	DEFB	FB86K1,FA86K1

	DEFW	T863C
	DEFB	FB86K2,FA86K2

	DEFW	T864C
	DEFB	FB86K3,FA86K3

	DEFW	T860PC
	DEFB	PB86M,PA86M,PV86M,PE86M

	DEFW	T861PC
	DEFB	PB86B,PA86B,PV86B,PE86B

;	DEFW	T862PC
;	DEFB	PB86K,PA86K,PV86K,PE86K

	endif
