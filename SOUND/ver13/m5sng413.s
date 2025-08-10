;********************************************************
;*		$$$SNG84.S	( SOUND DATA FILE )	*
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
MELO84A		equ	0
MELO84B		equ	0
MELO84C		equ	0
BASS84A		equ	0
BASS84B		equ	0
BASS84C		equ	0
BACK841A	equ	0
BACK841B	equ	0
BACK841C	equ	0
BACK842A	equ	0
BACK842B	equ	0
BACK842C	equ	0
BACK843A	equ	0
BACK843B	equ	0
BACK843C	equ	0

;========== TEMPO =============
TP84	EQU	2		; tempo for S84
DL84	EQU	0		; dlay counter for S84
;<<<<<<<< S84 FM BIAS >>>>>>>>
FB84	EQU	0F4H
;-----------------------------
FB84M	EQU	FB84		; fm melo
FB84B	EQU	FB84		; fm bass	
FB84K1	EQU	FB84		; fm back 1
FB84k2	EQU	FB84		; fm back 2
FB84k3	EQU	FB84		; fm back 3
FB84k4	EQU	FB84		; fm back 4
PB84M	EQU	FB84		; psg 1
PB84B	EQU	FB84		; psg 2
PB84K	EQU	FB84		; psg 3
;<<<<<<<< S84 VOLM >>>>>>>>>	 
FA84D	EQU	FV_DR		; fm rythm
FA84M	EQU	FV_ML      	; fm melo      ( FV_ML ==> show   glfeq.lib )
FA84B	EQU	FV_BS    	; fm bass
FA84K1	EQU	FV_BK1-8    	; fm back 1
FA84K2	EQU	FV_BK2-8   	; fm back 2
FA84K3	EQU	FV_BK3-8    	; fm back 3
FA84K4	EQU	FV_BK4-8	; fm back 4
PA84M	EQU	PV_ML  		; psg 1
PA84B	EQU	PV_BS		; psg 2
PA84K	EQU	PV_BK		; psg 3
;<<<<<<<<< S84 VIBR >>>>>>>>
PV84M	EQU	8		; melo
PV84B	EQU	0		; bass
PV84K	EQU	0		; back
;<<<<<<<<< S84 ENVE >>>>>>>>
PE84M	EQU	0		; melo
PE84B	EQU	2		; bass
PE84K	EQU	3		; back

;********************************  
;*                                 
;********************************  

S84::
	DW	TIMB84				; VOICE TOP ADDR.

	DB	6,2,TP84,DL84			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB84D				; rythm table pointer
	DEFB	0,FA84D				; bias,volm

	DEFW	TAB840
	DEFB	FB84M,FA84M

	DEFW	TAB841
	DEFB	FB84B,FA84B

	DEFW	TAB842
	DEFB	FB84K1,FA84K1

	DEFW	TAB843
	DEFB	FB84K2,FA84K2

	DEFW	TAB844
	DEFB	FB84K3,FA84K3

	DEFW	TAB840P
	DEFB	PB84M,PA84M,PV84M,PE84M

	DEFW	TAB841P
	DEFB	PB84B,PA84B,PV84B,PE84B

;	DEFW	TAB842P
;	DEFB	PB84K,PA84K,PV84K,PE84K


;<<<<<<<  CH0  >>>>>>>>>>>
TAB840::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO84A
T840A:
	db	FEV,MELO84B
T840B:
	db	FEV,MELO84C
T840C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB841::
	db	FEV,BASS84A
T841A:
	db	FEV,BASS84B
T841B:
	db	FEV,BASS84C
T841C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB842::
	db	FEV,BACK841A
T842A:
	db	FEV,BACK841B
T842B:
	db	FEV,BACK841C
T842C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB843::
	db	FEV,BACK842A
T843A:
	db	FEV,BACK842B
T843B:
	db	FEV,BACK842C
T843C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB844::
	db	FEV,BACK843A
T844A:
	db	FEV,BACK843B
T844B:
	db	FEV,BACK843C
T844C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB840P::
T840PA:
T840PB:
T840PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB841P::
T841PA:
T841PB:
T841PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB84D::
T84DA:
T84DB:
T84DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB84D


TIMB84::
	;---------------<: bass 1 >---------------
fev8400::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8401::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8402::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8403::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8404::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8405::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8406::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8407::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8408::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8409::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S85::
	DW	TIMB84				; VOICE TOP ADDR.

	DB	6,2,TP84,DL84			; FM CHIAN,PSG,CHIAN

	DEFW	T84DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T840B
	DEFB	FB84M,FA84M


	DEFW	T841B
	DEFB	FB84B,FA84B

	DEFW	T842B
	DEFB	FB84K1,FA84K1

	DEFW	T843B
	DEFB	FB84K2,FA84K2

	DEFW	T844B
	DEFB	FB84K3,FA84K3

	DEFW	T840PB
	DEFB	PB84M,PA84M,PV84M,PE84M

	DEFW	T841PB
	DEFB	PB84B,PA84B,PV84B,PE84B

;	DEFW	TAB842PB
;	DEFB	PB84K,PA84K,PV84K,PE84K


S86::
	DW	TIMB84				; VOICE TOP ADDR.

	DB	6,2,TP84,DL84			; FM CHIAN,PSG,CHIAN

	DEFW	T84DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T840C
	DEFB	FB84M,FA84M


	DEFW	T841C
	DEFB	FB84B,FA84B

	DEFW	T842C
	DEFB	FB84K1,FA84K1

	DEFW	T843C
	DEFB	FB84K2,FA84K2

	DEFW	T844C
	DEFB	FB84K3,FA84K3

	DEFW	T840PC
	DEFB	PB84M,PA84M,PV84M,PE84M

	DEFW	T841PC
	DEFB	PB84B,PA84B,PV84B,PE84B

;	DEFW	T842PC
;	DEFB	PB84K,PA84K,PV84K,PE84K

	endif
