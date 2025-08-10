;********************************************************
;*		$$$SNG83.S	( SOUND DATA FILE )	*
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
MELO83A		equ	0
MELO83B		equ	0
MELO83C		equ	0
BASS83A		equ	0
BASS83B		equ	0
BASS83C		equ	0
BACK831A	equ	0
BACK831B	equ	0
BACK831C	equ	0
BACK832A	equ	0
BACK832B	equ	0
BACK832C	equ	0
BACK833A	equ	0
BACK833B	equ	0
BACK833C	equ	0

;========== TEMPO =============
TP83	EQU	2		; tempo for S83
DL83	EQU	0		; dlay counter for S83
;<<<<<<<< S83 FM BIAS >>>>>>>>
FB83	EQU	0F4H
;-----------------------------
FB83M	EQU	FB83		; fm melo
FB83B	EQU	FB83		; fm bass	
FB83K1	EQU	FB83		; fm back 1
FB83k2	EQU	FB83		; fm back 2
FB83k3	EQU	FB83		; fm back 3
FB83k4	EQU	FB83		; fm back 4
PB83M	EQU	FB83		; psg 1
PB83B	EQU	FB83		; psg 2
PB83K	EQU	FB83		; psg 3
;<<<<<<<< S83 VOLM >>>>>>>>>	 
FA83D	EQU	FV_DR    	; fm rythm
FA83M	EQU	FV_ML    	; fm melo      ( FV_ML ==> show   glfeq.lib )
FA83B	EQU	FV_BS+10H	; fm bass
FA83K1	EQU	FV_BK1+08H	; fm back 1
FA83K2	EQU	FV_BK2+08H	; fm back 2
FA83K3	EQU	FV_BK3+08H	; fm back 3
FA83K4	EQU	FV_BK4		; fm back 4
PA83M	EQU	PV_ML		; psg 1
PA83B	EQU	PV_BS		; psg 2
PA83K	EQU	PV_BK		; psg 3
;<<<<<<<<< S83 VIBR >>>>>>>>
PV83M	EQU	0		; melo
PV83B	EQU	0		; bass
PV83K	EQU	0		; back
;<<<<<<<<< S83 ENVE >>>>>>>>
PE83M	EQU	0		; melo
PE83B	EQU	0		; bass
PE83K	EQU	0		; back

;********************************  
;*                                 
;********************************  

S83::
	DW	TIMB83				; VOICE TOP ADDR.

	DB	6,2,TP83,DL83			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB83D				; rythm table pointer
	DEFB	0,FA83D				; bias,volm

	DEFW	TAB830
	DEFB	FB83M,FA83M

	DEFW	TAB831
	DEFB	FB83B,FA83B

	DEFW	TAB832
	DEFB	FB83K1,FA83K1

	DEFW	TAB833
	DEFB	FB83K2,FA83K2

	DEFW	TAB834
	DEFB	FB83K3,FA83K3

	DEFW	TAB830P
	DEFB	PB83M,PA83M,PV83M,PE83M

	DEFW	TAB831P
	DEFB	PB83B,PA83B,PV83B,PE83B

;	DEFW	TAB832P
;	DEFB	PB83K,PA83K,PV83K,PE83K

;<<<<<<<  CH0  >>>>>>>>>>>
TAB830::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO83A
T830A:
	db	FEV,MELO83B
T830B:
	db	FEV,MELO83C
T830C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB831::
	db	FEV,BASS83A
T831A:
	db	FEV,BASS83B
T831B:
	db	FEV,BASS83C
T831C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB832::
	db	FEV,BACK831A
T832A:
	db	FEV,BACK831B
T832B:
	db	FEV,BACK831C
T832C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB833::
	db	FEV,BACK832A
T833A:
	db	FEV,BACK832B
T833B:
	db	FEV,BACK832C
T833C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB834::
	db	FEV,BACK833A
T834A:
	db	FEV,BACK833B
T834B:
	db	FEV,BACK833C
T834C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB830P::
T830PA:
T830PB:
T830PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB831P::
T831PA:
T831PB:
T831PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB83D::
T83DA:
T83DB:
T83DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB83D


TIMB83::
	;---------------<@93 >---------------
fev8300::
	CNF	4,6
	MD	3,3,1,4,14,7,4,7
	RSAR	1,27,2,31,1,31,0,31
	D1R	4,7,7,8
	D2R	0,0,0,0
	RRL	15,15,15,15,15,14,15,15
	TL	35,16,41,23
	;---------------<@70      >---------------
fev8301::
	CNF	0,7
	MD	10,3,0,3,0,3,0,3
	RSAR	0,31,0,31,1,31,1,31
	D1R	18,14,10,10
	D2R	0,4,4,3
	RRL	15,2,15,2,15,2,15,2
	TL	36,45,14,0
fev8302::
	;---------------<@73      >---------------
	CNF	6,7
	MD	2,4,2,4,2,3,2,6
	RSAR	0,31,0,31,1,31,1,31
	D1R	21,14,15,15
	D2R	21,11,23,10
	RRL	15,15,15,15,15,5,15,6
	TL	0,0,0,0
	;---------------<@91      >---------------
fev8303::
	CNF	4,7
	MD	2,3,2,3,1,7,2,4
	RSAR	0,31,0,24,0,31,0,30
	D1R	7,31,7,31
	D2R	0,0,0,0
	RRL	15,1,15,0,15,1,15,0
	TL	30,16,12,16
	;--------------<@90         >-----------
fev8304::
	CNF	4,5
	MD	2,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,18
	D1R	0,10,0,10
	D2R	0,0,0,0
	RRL	15,0,15,1,15,0,15,1
	TL	22,16,23,16
	;---------------<@80  >---------------
fev8305::
	CNF	4,0
	MD	2,7,2,4,2,3,2,3
	RSAR	0,18,0,18,0,18,0,18
	D1R	0,0,0,0
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	35,0,35,0



	if	check
	include		voice1.s

S84::
	DW	TIMB83				; VOICE TOP ADDR.

	DB	6,2,TP83,DL83			; FM CHIAN,PSG,CHIAN

	DEFW	T83DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T830B
	DEFB	FB83M,FA83M


	DEFW	T831B
	DEFB	FB83B,FA83B

	DEFW	T832B
	DEFB	FB83K1,FA83K1

	DEFW	T833B
	DEFB	FB83K2,FA83K2

	DEFW	T834B
	DEFB	FB83K3,FA83K3

	DEFW	T830PB
	DEFB	PB83M,PA83M,PV83M,PE83M

	DEFW	T831PB
	DEFB	PB83B,PA83B,PV83B,PE83B

;	DEFW	TAB832PB
;	DEFB	PB83K,PA83K,PV83K,PE83K


S85::
	DW	TIMB83				; VOICE TOP ADDR.

	DB	6,2,TP83,DL83			; FM CHIAN,PSG,CHIAN

	DEFW	T83DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T830C
	DEFB	FB83M,FA83M


	DEFW	T831C
	DEFB	FB83B,FA83B

	DEFW	T832C
	DEFB	FB83K1,FA83K1

	DEFW	T833C
	DEFB	FB83K2,FA83K2

	DEFW	T834C
	DEFB	FB83K3,FA83K3

	DEFW	T830PC
	DEFB	PB83M,PA83M,PV83M,PE83M

	DEFW	T831PC
	DEFB	PB83B,PA83B,PV83B,PE83B

;	DEFW	T832PC
;	DEFB	PB83K,PA83K,PV83K,PE83K

	endif

