;********************************************************
;*		$$$SNG87.S	( SOUND DATA FILE )	*
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
MELO87A		equ	0
MELO87B		equ	0
MELO87C		equ	0
BASS87A		equ	0
BASS87B		equ	0
BASS87C		equ	0
BACK871A	equ	0
BACK871B	equ	0
BACK871C	equ	0
BACK872A	equ	0
BACK872B	equ	0
BACK872C	equ	0
BACK873A	equ	0
BACK873B	equ	0
BACK873C	equ	0

;========== TEMPO =============
TP87	EQU	2		; tempo for S87
DL87	EQU	0		; dlay counter for S87
;<<<<<<<< S87 FM BIAS >>>>>>>>
FB87	EQU	0F5H
;-----------------------------
FB87M	EQU	FB87		; fm melo
FB87B	EQU	LOW FB87+12	; fm bass	
FB87K1	EQU	FB87		; fm back 1
FB87k2	EQU	FB87		; fm back 2
FB87k3	EQU	FB87		; fm back 3
FB87k4	EQU	FB87		; fm back 4
PB87M	EQU	FB87		; psg 1
PB87B	EQU	FB87		; psg 2
PB87K	EQU	FB87		; psg 3
;<<<<<<<< S87 VOLM >>>>>>>>>	 
FA87M	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA87B	EQU	FV_BS		; fm bass
FA87K1	EQU	FV_BK1		; fm back 1
FA87K2	EQU	FV_BK2		; fm back 2
FA87K3	EQU	FV_BK3		; fm back 3
FA87K4	EQU	FV_BK4		; fm back 4
PA87M	EQU	PV_ML		; psg 1
PA87B	EQU	PV_BS		; psg 2
PA87K	EQU	PV_BK		; psg 3
;<<<<<<<<< S87 VIBR >>>>>>>>
PV87M	EQU	1		; melo
PV87B	EQU	0		; bass
PV87K	EQU	0		; back
;<<<<<<<<< S87 ENVE >>>>>>>>
PE87M	EQU	1		; melo
PE87B	EQU	2		; bass
PE87K	EQU	3		; back

;********************************
;*
;********************************
;********************************  
;*                                 
;********************************  

S87::
	DW	TIMB87				; VOICE TOP ADDR.

	DB	6,2,TP87,DL87			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB87D				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB870
	DEFB	FB87M,FA87M

	DEFW	TAB871
	DEFB	FB87B,FA87B

	DEFW	TAB872
	DEFB	FB87K1,FA87K1

	DEFW	TAB873
	DEFB	FB87K2,FA87K2

	DEFW	TAB874
	DEFB	FB87K3,FA87K3

	DEFW	TAB870P
	DEFB	PB87M,PA87M,PV87M,PE87M

	DEFW	TAB871P
	DEFB	PB87B,PA87B,PV87B,PE87B

;	DEFW	TAB872P
;	DEFB	PB87K,PA87K,PV87K,PE87K

;<<<<<<<  CH0  >>>>>>>>>>>
TAB870::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO87A
T870A:
	db	FEV,MELO87B
T870B:
	db	FEV,MELO87C
T870C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB871::
	db	FEV,BASS87A
T871A:
	db	FEV,BASS87B
T871B:
	db	FEV,BASS87C
T871C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB872::
	db	FEV,BACK871A
T872A:
	db	FEV,BACK871B
T872B:
	db	FEV,BACK871C
T872C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB873::
	db	FEV,BACK872A
T873A:
	db	FEV,BACK872B
T873B:
	db	FEV,BACK872C
T873C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB874::
	db	FEV,BACK873A
T874A:
	db	FEV,BACK873B
T874B:
	db	FEV,BACK873C
T874C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB870P::
T870PA:
T870PB:
T870PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB871P::
T871PA:
T871PB:
T871PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB87D::
T87DA:
T87DB:
T87DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB87D

TIMB87::
	;---------------<: bass 1 >---------------
fev8700::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8701::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8702::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8703::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8704::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8705::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8706::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8707::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8708::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8709::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00



	if	check
	include		voice1.s
S88::
	DW	TIMB87				; VOICE TOP ADDR.

	DB	6,2,TP87,DL87			; FM CHIAN,PSG,CHIAN

	DEFW	T87DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T870B
	DEFB	FB87M,FA87M


	DEFW	T871B
	DEFB	FB87B,FA87B

	DEFW	T872B
	DEFB	FB87K1,FA87K1

	DEFW	T873B
	DEFB	FB87K2,FA87K2

	DEFW	T874B
	DEFB	FB87K3,FA87K3

	DEFW	T870PB
	DEFB	PB87M,PA87M,PV87M,PE87M

	DEFW	T871PB
	DEFB	PB87B,PA87B,PV87B,PE87B

;	DEFW	TAB872PB
;	DEFB	PB87K,PA87K,PV87K,PE87K


S89::
	DW	TIMB87				; VOICE TOP ADDR.

	DB	6,2,TP87,DL87			; FM CHIAN,PSG,CHIAN

	DEFW	T87DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T870C
	DEFB	FB87M,FA87M


	DEFW	T871C
	DEFB	FB87B,FA87B

	DEFW	T872C
	DEFB	FB87K1,FA87K1

	DEFW	T873C
	DEFB	FB87K2,FA87K2

	DEFW	T874C
	DEFB	FB87K3,FA87K3

	DEFW	T870PC
	DEFB	PB87M,PA87M,PV87M,PE87M

	DEFW	T871PC
	DEFB	PB87B,PA87B,PV87B,PE87B

;	DEFW	T872PC
;	DEFB	PB87K,PA87K,PV87K,PE87K

	endif
