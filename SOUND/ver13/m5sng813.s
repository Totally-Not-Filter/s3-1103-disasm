;********************************************************
;*		$$$SNG88.S	( SOUND DATA FILE )	*
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
MELO88A		equ	0
MELO88B		equ	0
MELO88C		equ	0
BASS88A		equ	0
BASS88B		equ	0
BASS88C		equ	0
BACK881A	equ	0
BACK881B	equ	0
BACK881C	equ	0
BACK882A	equ	0
BACK882B	equ	0
BACK882C	equ	0
BACK883A	equ	0
BACK883B	equ	0
BACK883C	equ	0

;========== TEMPO =============
TP88	EQU	2		; tempo for S88
DL88	EQU	0		; dlay counter for S88
;<<<<<<<< S88 FM BIAS >>>>>>>>
FB88	EQU	0F5H
;-----------------------------
FB88M	EQU	FB88		; fm melo
FB88B	EQU	LOW FB88+12	; fm bass	
FB88K1	EQU	FB88		; fm back 1
FB88k2	EQU	FB88		; fm back 2
FB88k3	EQU	FB88		; fm back 3
FB88k4	EQU	FB88		; fm back 4
PB88M	EQU	FB88		; psg 1
PB88B	EQU	FB88		; psg 2
PB88K	EQU	FB88		; psg 3
;<<<<<<<< S88 VOLM >>>>>>>>>	 
FA88M	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA88B	EQU	FV_BS		; fm bass
FA88K1	EQU	FV_BK1		; fm back 1
FA88K2	EQU	FV_BK2		; fm back 2
FA88K3	EQU	FV_BK3		; fm back 3
FA88K4	EQU	FV_BK4		; fm back 4
PA88M	EQU	PV_ML		; psg 1
PA88B	EQU	PV_BS		; psg 2
PA88K	EQU	PV_BK		; psg 3
;<<<<<<<<< S88 VIBR >>>>>>>>
PV88M	EQU	1		; melo
PV88B	EQU	0		; bass
PV88K	EQU	0		; back
;<<<<<<<<< S88 ENVE >>>>>>>>
PE88M	EQU	1		; melo
PE88B	EQU	2		; bass
PE88K	EQU	3		; back

;********************************  
;*                                 
;********************************  

S88::
	DW	TIMB88				; VOICE TOP ADDR.

	DB	6,2,TP88,DL88			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB88D				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB880
	DEFB	FB88M,FA88M

	DEFW	TAB881
	DEFB	FB88B,FA88B

	DEFW	TAB882
	DEFB	FB88K1,FA88K1

	DEFW	TAB883
	DEFB	FB88K2,FA88K2

	DEFW	TAB884
	DEFB	FB88K3,FA88K3

	DEFW	TAB880P
	DEFB	PB88M,PA88M,PV88M,PE88M

	DEFW	TAB881P
	DEFB	PB88B,PA88B,PV88B,PE88B

;	DEFW	TAB882P
;	DEFB	PB88K,PA88K,PV88K,PE88K


;<<<<<<<  CH0  >>>>>>>>>>>
TAB880::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO88A
T880A:
	db	FEV,MELO88B
T880B:
	db	FEV,MELO88C
T880C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB881::
	db	FEV,BASS88A
T881A:
	db	FEV,BASS88B
T881B:
	db	FEV,BASS88C
T881C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB882::
	db	FEV,BACK881A
T882A:
	db	FEV,BACK881B
T882B:
	db	FEV,BACK881C
T882C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB883::
	db	FEV,BACK882A
T883A:
	db	FEV,BACK882B
T883B:
	db	FEV,BACK882C
T883C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB884::
	db	FEV,BACK883A
T884A:
	db	FEV,BACK883B
T884B:
	db	FEV,BACK883C
T884C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB880P::
T880PA:
T880PB:
T880PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB881P::
T881PA:
T881PB:
T881PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB88D::
T88DA:
T88DB:
T88DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB88D

TIMB88::
	;---------------<: bass 1 >---------------
fev8800::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8801::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8802::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8803::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8804::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8805::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8806::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8807::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8808::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8809::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00


	if	check
	include		voice1.s
S89::
	DW	TIMB88				; VOICE TOP ADDR.

	DB	6,2,TP88,DL88			; FM CHIAN,PSG,CHIAN

	DEFW	T88DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T880B
	DEFB	FB88M,FA88M


	DEFW	T881B
	DEFB	FB88B,FA88B

	DEFW	T882B
	DEFB	FB88K1,FA88K1

	DEFW	T883B
	DEFB	FB88K2,FA88K2

	DEFW	T884B
	DEFB	FB88K3,FA88K3

	DEFW	T880PB
	DEFB	PB88M,PA88M,PV88M,PE88M

	DEFW	T881PB
	DEFB	PB88B,PA88B,PV88B,PE88B

;	DEFW	TAB882PB
;	DEFB	PB88K,PA88K,PV88K,PE88K


S8A::
	DW	TIMB88				; VOICE TOP ADDR.

	DB	6,2,TP88,DL88			; FM CHIAN,PSG,CHIAN

	DEFW	T88DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T880C
	DEFB	FB88M,FA88M


	DEFW	T881C
	DEFB	FB88B,FA88B

	DEFW	T882C
	DEFB	FB88K1,FA88K1

	DEFW	T883C
	DEFB	FB88K2,FA88K2

	DEFW	T884C
	DEFB	FB88K3,FA88K3

	DEFW	T880PC
	DEFB	PB88M,PA88M,PV88M,PE88M

	DEFW	T881PC
	DEFB	PB88B,PA88B,PV88B,PE88B

;	DEFW	T882PC
;	DEFB	PB88K,PA88K,PV88K,PE88K

	endif
