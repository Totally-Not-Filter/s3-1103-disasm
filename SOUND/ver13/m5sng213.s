;********************************************************
;*		$$$SNG82.S	( SOUND DATA FILE )	*
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
MELO82A		equ	0
MELO82B		equ	0
MELO82C		equ	0
BASS82A		equ	1
BASS82B		equ	1
BASS82C		equ	1
BACK821A	equ	2
BACK821B	equ	3
BACK821C	equ	3
BACK822A	equ	2
BACK822B	equ	3
BACK822C	equ	3
BACK823A	equ	2
BACK823B	equ	3
BACK823C	equ	3

;========== TEMPO =============
TP82	EQU	2		; tempo for S82
DL82	EQU	0		; dlay counter for S82
;<<<<<<<< S82 FM BIAS >>>>>>>>
FB82	EQU	0f4H
;-----------------------------
FB82M	EQU	FB82		; fm melo
FB82B	EQU	FB82		; fm bass	
FB82K1	EQU	LOW FB82+12		; fm back 1
FB82k2	EQU	LOW FB82+12		; fm back 2
FB82k3	EQU	LOW FB82+12		; fm back 3
FB82k4	EQU	FB82		; fm back 4
PB82M	EQU	FB82		; psg 1
PB82B	EQU	FB82		; psg 2
PB82K	EQU	FB82		; psg 3
;<<<<<<<< S82 VOLM >>>>>>>>>	 
FA82D	EQU	FV_DR
FA82M	EQU	FV_ML   	; fm melo      ( FV_ML ==> show   glfeq.lib )
FA82B	EQU	FV_BS    	; fm bass
FA82K1	EQU	FV_BK1    	; fm back 1
FA82K2	EQU	FV_BK2    	; fm back 2
FA82K3	EQU	FV_BK3    	; fm back 3
FA82K4	EQU	FV_BK4		; fm back 4
PA82M	EQU	PV_ML		; psg 1
PA82B	EQU	PV_BS		; psg 2
PA82K	EQU	PV_BK		; psg 3
;<<<<<<<<< S82 VIBR >>>>>>>>
PV82M	EQU	0		; melo
PV82B	EQU	0		; bass
PV82K	EQU	0		; back
;<<<<<<<<< S82 ENVE >>>>>>>>
PE82M	EQU	0		; melo
PE82B	EQU	0		; bass
PE82K	EQU	0		; back

;********************************  
;*                                 
;********************************  

S82::
	DW	TIMB82				; VOICE TOP ADDR.

	DB	6,2,TP82,DL82			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB82D				; rythm table pointer
	DEFB	0,FA82D				; bias,volm

	DEFW	TAB820				; FM ch1 table pointer
	DEFB	FB82M,FA82M			; bias,volm           

	DEFW	TAB821				; FM ch2 table pointer
	DEFB	FB82B,FA82B     		; bias,volm           

	DEFW	TAB822				; FM ch3 table pointer
	DEFB	FB82K1,FA82K1   		; bias,volm           

	DEFW	TAB823				; FM ch4 table pointer
	DEFB	FB82K2,FA82K2   		; bias,volm           

	DEFW	TAB824				; FM ch5 table pointer
	DEFB	FB82K3,FA82K3   		; bias,volm           

	DEFW	TAB820P				; PSG ch1 table pointer
	DEFB	PB82M,PA82M,PV82M,PE82M 	; bias,volm           

	DEFW	TAB821P				; PSG ch2 table pointe
	DEFB	PB82B,PA82B,PV82B,PE82B 	; bias,volm           

;	DEFW	TAB822P				; PSG ch3 table pointe
;	DEFB	PB82K,PA82K,PV82K,PE82K 	; bias,volm           


;<<<<<<<<<<< melo >>>>>>>>>
TAB820::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO82A
T820A:
	db	FEV,MELO82B
T820B:
	db	FEV,MELO82C
T820C:
;<<<<<<<<<<< bass >>>>>>>>>
TAB821::
	db	FEV,BASS82A
T821A:
	db	FEV,BASS82B
T821B:
	db	FEV,BASS82C
T821C:

;<<<<<<<<<<< BACK 1 >>>>>>>>>
TAB822::
	db	FEV,BACK821A
T822A:
	db	FEV,BACK821B
T822B:
	db	FEV,BACK821C
T822C:

;<<<<<<<<<<< BACK 2 >>>>>>>>>
TAB823::
	db	FEV,BACK822A
T823A:
	db	FEV,BACK822B
T823B:
	db	FEV,BACK822C
T823C:

;<<<<<<<<<<< BACK 3 >>>>>>>>>
TAB824::
	db	FEV,BACK823A
T824A:
	db	FEV,BACK823B
T824B:
	db	FEV,BACK823C
T824C:
	DB	CMEND

;<<<<<<<<<<< psg  1 >>>>>>>>>
TAB820P::
T820PA:
T820PB:
T820PC:
;<<<<<<<<<<< psg  2 >>>>>>>>>
TAB821P::
T821PA:
T821PB:
T821PC:
	DB	CMEND
;<<<<<<<<< RYTHM >>>>>>>>
TAB82D::
T82DA:
T82DB:
T82DC:
	DB	CMEND

TIMB82::
	;---------------<: bass 1 >---------------
	;---------------<=@98 >---------------
	; TOM
fev8200::
	CNF	6,7			; Algo, Feed Back
	MD	0,6,0,3,0,3,0,3         ; ditune,multiple
	RSAR	0,25,0,31,0,31,0,31     ; key scale,attack ratoe
	D1R	21,17,17,12             ; decay
	D2R	16,10,6,9               ; sustin rate
	RRL	15,4,15,5,15,10,15,8    ; rerese rate,sustine lavel
	TL	0,2,3,0                 ; total level


	;---------------<@30 BASS>---------------
fev8201::
	CNF	0,4
	MD	6,6,5,6,0,6,0,6
	RSAR	3,31,3,31,2,31,2,31
	D1R	7,6,9,6
	D2R	7,6,6,8
	RRL	15,2,15,1,15,1,15,5
	TL	28,58,22,8
fev8202::
	;---------------<@67 MELO 1>---------------
	CNF	3,7
	MD	6,0,6,3,3,6,2,3
	RSAR	3,31,1,20,3,16,2,15
	D1R	9,7,11,4
	D2R	3,0,0,0
	RRL	15,14,15,15,15,2,15,0
	TL	40,41,28,0
	;---------------<@198 BASS 2 >---------------
fev8203::
	CNF	4,7
	MD	2,5,6,3,3,6,2,5
	RSAR	3,31,1,25,3,15,2,10
	D1R	10,10,1,5
	D2R	20,20,10,20
	RRL	15,10,15,10,15,5,15,5
	TL	30,5,40,2
	;--------------< @21 MELO 2 >-----------
fev8204::
	CNF	2,7
	MD	2,3,6,5,2,3,2,4
	RSAR	2,13,0,21,1,15,1,18
	D1R	6,8,7,4
	D2R	2,0,0,0
	RRL	4,1,4,1,2,4,2,4
	TL	25,32,42,0
	;---------------<@199 MELO 3  >---------------
fev8205::
	CNF	0,7
	MD	4,2,2,6,4,7,2,3
	RSAR	0,16,0,16,0,21,0,31
	D1R	14,14,9,9
	D2R	4,4,4,4
	RRL	15,5,15,5,15,10,15,3
	TL	28,40,20,0
	;---------------<@131  >---------------
fev8206::
	CNF	0,7
	MD	10,6,10,3,1,7,0,3
	RSAR	0,20,0,20,0,16,0,14
	D1R	5,8,2,8
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	40,51,29,0
	;---------------<@90  >---------------
fev8207::
	CNF	4,5
	MD	2,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,18
	D1R	0,10,0,10
	D2R	0,0,0,0
	RRL	15,0,15,1,15,0,15,1
	TL	22,16,23,16
	;-----------< @88   >------------
fev8208::
	CNF	5,5
	MD	1,4,1,4,2,4,2,4
	RSAR	0,20,0,20,0,20,0,20
	D1R	10,10,10,10
	D2R	0,0,2,0
	RRL	15,1,15,2,15,3,15,2
	TL	33,16,16,16
	;---------------<@79  >---------------
fev8209::
	CNF	6,2
	MD	5,3,3,3,0,3,0,3
	RSAR	0,31,0,31,0,31,0,31
	D1R	12,11,10,8
	D2R	4,2,3,5
	RRL	5,1,7,15,7,0,5,2
	TL	28,0,0,0
	;---------------<psg like >---------------
fev820a::
	CNF	4,0
	MD	5,3,3,3,0,3,0,3
	RSAR	0,31,0,24,0,31,0,26
	D1R	10,28,10,28
	D2R	0,3,0,5
	RRL	15,4,15,3,15,3,15,4
	TL	64,16,64,0


	IF	CHECK

	include		voice1.s

S83::
	DW	TIMB82				; VOICE TOP ADDR.

	DB	6,2,TP82,DL82			; FM CHIAN,PSG,CHIAN

	DEFW	T82DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T820B
	DEFB	FB82M,FA82M


	DEFW	T821B
	DEFB	FB82B,FA82B

	DEFW	T822B
	DEFB	FB82K1,FA82K1

	DEFW	T823B
	DEFB	FB82K2,FA82K2

	DEFW	T824B
	DEFB	FB82K3,FA82K3

	DEFW	T820PB
	DEFB	PB82M,PA82M,PV82M,PE82M

	DEFW	T821PB
	DEFB	PB82B,PA82B,PV82B,PE82B

;	DEFW	TAB822PB
;	DEFB	PB82K,PA82K,PV82K,PE82K


S84::
	DW	TIMB82				; VOICE TOP ADDR.

	DB	6,2,TP82,DL82			; FM CHIAN,PSG,CHIAN

	DEFW	T82DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T820C
	DEFB	FB82M,FA82M


	DEFW	T821C
	DEFB	FB82B,FA82B

	DEFW	T822C
	DEFB	FB82K1,FA82K1

	DEFW	T823C
	DEFB	FB82K2,FA82K2

	DEFW	T824C
	DEFB	FB82K3,FA82K3

	DEFW	T820PC
	DEFB	PB82M,PA82M,PV82M,PE82M

	DEFW	T821PC
	DEFB	PB82B,PA82B,PV82B,PE82B

;	DEFW	T822PC
;	DEFB	PB82K,PA82K,PV82K,PE82K


	ENDIF








