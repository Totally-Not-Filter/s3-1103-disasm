;********************************************************
;*		$$$SNG89.S	( SOUND DATA FILE )	*
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
MELO89A		equ	0
MELO89B		equ	0
MELO89C		equ	0
BASS89A		equ	0
BASS89B		equ	0
BASS89C		equ	0
BACK891A	equ	0
BACK891B	equ	0
BACK891C	equ	0
BACK892A	equ	0
BACK892B	equ	0
BACK892C	equ	0
BACK893A	equ	0
BACK893B	equ	0
BACK893C	equ	0

;========== TEMPO =============
TP89	EQU	2		; tempo for S89
DL89	EQU	0		; dlay counter for S89
;<<<<<<<< S89 FM BIAS >>>>>>>>
FB89	EQU	0F5H
;-----------------------------
FB89M	EQU	FB89		; fm melo
FB89B	EQU	LOW FB89+12	; fm bass	
FB89K1	EQU	FB89		; fm back 1
FB89k2	EQU	FB89		; fm back 2
FB89k3	EQU	FB89		; fm back 3
FB89k4	EQU	FB89		; fm back 4
PB89M	EQU	FB89		; psg 1
PB89B	EQU	FB89		; psg 2
PB89K	EQU	FB89		; psg 3
;<<<<<<<< S89 VOLM >>>>>>>>>	 
FA89M	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA89B	EQU	FV_BS		; fm bass
FA89K1	EQU	FV_BK1		; fm back 1
FA89K2	EQU	FV_BK2		; fm back 2
FA89K3	EQU	FV_BK3		; fm back 3
FA89K4	EQU	FV_BK4		; fm back 4
PA89M	EQU	PV_ML		; psg 1
PA89B	EQU	PV_BS		; psg 2
PA89K	EQU	PV_BK		; psg 3
;<<<<<<<<< S89 VIBR >>>>>>>>
PV89M	EQU	1		; melo
PV89B	EQU	0		; bass
PV89K	EQU	0		; back
;<<<<<<<<< S89 ENVE >>>>>>>>
PE89M	EQU	1		; melo
PE89B	EQU	2		; bass
PE89K	EQU	3		; back

;********************************  
;*                                 
;********************************  

S89::
	DW	TIMB89				; VOICE TOP ADDR.

	DB	6,2,TP89,DL89			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB89D				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB890
	DEFB	FB89M,FA89M

	DEFW	TAB891
	DEFB	FB89B,FA89B

	DEFW	TAB892
	DEFB	FB89K1,FA89K1

	DEFW	TAB893
	DEFB	FB89K2,FA89K2

	DEFW	TAB894
	DEFB	FB89K3,FA89K3

	DEFW	TAB890P
	DEFB	PB89M,PA89M,PV89M,PE89M

	DEFW	TAB891P
	DEFB	PB89B,PA89B,PV89B,PE89B

;	DEFW	TAB892P
;	DEFB	PB89K,PA89K,PV89K,PE89K


;<<<<<<<  CH0  >>>>>>>>>>>
TAB890::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO89A
T890A:
	db	FEV,MELO89B
T890B:
	db	FEV,MELO89C
T890C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB891::
	db	FEV,BASS89A
T891A:
	db	FEV,BASS89B
T891B:
	db	FEV,BASS89C
T891C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB892::
	db	FEV,BACK891A
T892A:
	db	FEV,BACK891B
T892B:
	db	FEV,BACK891C
T892C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB893::
	db	FEV,BACK892A
T893A:
	db	FEV,BACK892B
T893B:
	db	FEV,BACK892C
T893C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB894::
	db	FEV,BACK893A
T894A:
	db	FEV,BACK893B
T894B:
	db	FEV,BACK893C
T894C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB890P::
T890PA:
T890PB:
T890PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB891P::
T891PA:
T891PB:
T891PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB89D::
T89DA:
T89DB:
T89DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB89D

TIMB89::
	;---------------<: bass 1 >---------------
fev8900::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8901::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8902::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8903::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8904::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8905::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8906::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8907::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8908::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8909::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00

	if	check
	include		voice1.s
S8A::
	DW	TIMB89				; VOICE TOP ADDR.

	DB	6,2,TP89,DL89			; FM CHIAN,PSG,CHIAN

	DEFW	T89DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T890B
	DEFB	FB89M,FA89M


	DEFW	T891B
	DEFB	FB89B,FA89B

	DEFW	T892B
	DEFB	FB89K1,FA89K1

	DEFW	T893B
	DEFB	FB89K2,FA89K2

	DEFW	T894B
	DEFB	FB89K3,FA89K3

	DEFW	T890PB
	DEFB	PB89M,PA89M,PV89M,PE89M

	DEFW	T891PB
	DEFB	PB89B,PA89B,PV89B,PE89B

;	DEFW	TAB892PB
;	DEFB	PB89K,PA89K,PV89K,PE89K


S8B::
	DW	TIMB89				; VOICE TOP ADDR.

	DB	6,2,TP89,DL89			; FM CHIAN,PSG,CHIAN

	DEFW	T89DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T890C
	DEFB	FB89M,FA89M


	DEFW	T891C
	DEFB	FB89B,FA89B

	DEFW	T892C
	DEFB	FB89K1,FA89K1

	DEFW	T893C
	DEFB	FB89K2,FA89K2

	DEFW	T894C
	DEFB	FB89K3,FA89K3

	DEFW	T890PC
	DEFB	PB89M,PA89M,PV89M,PE89M

	DEFW	T891PC
	DEFB	PB89B,PA89B,PV89B,PE89B

;	DEFW	T892PC
;	DEFB	PB89K,PA89K,PV89K,PE89K

	endif
