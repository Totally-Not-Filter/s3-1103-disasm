;********************************************************
;*		$$$SNG8F.S	( SOUND DATA FILE )	*
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
MELO8FA		equ	0
MELO8FB		equ	0
MELO8FC		equ	0
BASS8FA		equ	0
BASS8FB		equ	0
BASS8FC		equ	0
BACK8F1A	equ	0
BACK8F1B	equ	0
BACK8F1C	equ	0
BACK8F2A	equ	0
BACK8F2B	equ	0
BACK8F2C	equ	0
BACK8F3A	equ	0
BACK8F3B	equ	0
BACK8F3C	equ	0

;========== TEMPO =============
TP8F	EQU	2		; tempo for S8F
DL8F	EQU	0		; dlay counter for S8F
;<<<<<<<< S8F FM BIAS >>>>>>>>
FB8F	EQU	0F4H
;-----------------------------
FB8FM	EQU	FB8F		; fm melo
FB8FB	EQU	LOW FB8F+12	; fm bass	
FB8FK1	EQU	FB8F		; fm back 1
FB8Fk2	EQU	FB8F		; fm back 2
FB8Fk3	EQU	FB8F		; fm back 3
FB8Fk4	EQU	FB8F		; fm back 4
PB8FM	EQU	FB8F		; psg 1
PB8FB	EQU	FB8F		; psg 2
PB8FK	EQU	FB8F		; psg 3
;<<<<<<<< S8F VOLM >>>>>>>>>	 
FA8FM	EQU	FV_ML		; fm melo      ( FV_ML ==> show   btfeq.lib )
FA8FB	EQU	FV_BS		; fm bass
FA8FK1	EQU	FV_BK1		; fm back 1
FA8FK2	EQU	FV_BK2		; fm back 2
FA8FK3	EQU	FV_BK3		; fm back 3
FA8FK4	EQU	FV_BK4		; fm back 4
PA8FM	EQU	PV_ML		; psg 1
PA8FB	EQU	PV_BS		; psg 2
PA8FK	EQU	PV_BK		; psg 3
;<<<<<<<<< S8F VIBR >>>>>>>>
PV8FM	EQU	1		; melo
PV8FB	EQU	0		; bass
PV8FK	EQU	0		; back
;<<<<<<<<< S8F ENVE >>>>>>>>
PE8FM	EQU	1		; melo
PE8FB	EQU	2		; bass
PE8FK	EQU	3		; back

;********************************  
;*                                 
;********************************  

S8F::
	DW	TIMB8F				; VOICE TOP ADDR.

	DB	6,2,TP8F,DL8F			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB8FD				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB8F0
	DEFB	FB8FM,FA8FM

	DEFW	TAB8F1
	DEFB	FB8FB,FA8FB

	DEFW	TAB8F2
	DEFB	FB8FK1,FA8FK1

	DEFW	TAB8F3
	DEFB	FB8FK2,FA8FK2

	DEFW	TAB8F4
	DEFB	FB8FK3,FA8FK3

	DEFW	TAB8F0P
	DEFB	PB8FM,PA8FM,PV8FM,PE8FM

	DEFW	TAB8F1P
	DEFB	PB8FB,PA8FB,PV8FB,PE8FB

;	DEFW	TAB8F2P
;	DEFB	PB8FK,PA8FK,PV8FK,PE8FK

;<<<<<<<  CH0  >>>>>>>>>>>
TAB8F0::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO8FA
T8F0A:
	db	FEV,MELO8FB
T8F0B:
	db	FEV,MELO8FC
T8F0C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB8F1::
	db	FEV,BASS8FA
T8F1A:
	db	FEV,BASS8FB
T8F1B:
	db	FEV,BASS8FC
T8F1C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB8F2::
	db	FEV,BACK8F1A
T8F2A:
	db	FEV,BACK8F1B
T8F2B:
	db	FEV,BACK8F1C
T8F2C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB8F3::
	db	FEV,BACK8F2A
T8F3A:
	db	FEV,BACK8F2B
T8F3B:
	db	FEV,BACK8F2C
T8F3C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB8F4::
	db	FEV,BACK8F3A
T8F4A:
	db	FEV,BACK8F3B
T8F4B:
	db	FEV,BACK8F3C
T8F4C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB8F0P::
T8F0PA:
T8F0PB:
T8F0PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB8F1P::
T8F1PA:
T8F1PB:
T8F1PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB8FD::
T8FDA:
T8FDB:
T8FDC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB8FD


TIMB8F::
	;---------------<: bass 1 >---------------
fev8F00::
	CNF	2,2
	MD	4,9,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	22,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	00h,10h,20H,00H
	;---------------<: bass 2 >---------------
fev8F01::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
fev8F02::
	;---------------<: bass 3 >---------------
	CNF	0,2
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;---------------<: bass 4 >---------------
fev8F03::
	CNF	2,3*2+1
	MD	4,0,2,0,8,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	16,15,9,8
	D2R	7,0,0,0
	RRL	15,3,15,0,15,0,15,4
	TL	20h,20h,20H,00H
	;--------------< robo voice >-----------
fev8F04::
	CNF	5,6
	MD	5,0,3,0,7,0,2,0
	RSAR	0,25,0,32,0,21,0,15
	D1R	12,9,16,6
	D2R	31,0,16,0
	RRL	15,1,15,3,15,3,15,3
	TL	10H,00H,00H,00H
	;---------------<:violin  >---------------
fev8F05::
	;	‚c‚Q‚q‚ª‚o‚n‚h‚m‚s	; BACK
	CNF	2,2
	MD	4,0,4,0,2,0,4,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	31,31,31,31
	D2R	17,17,13,15
	RRL	11,5,10,5,10,0,10,2
	TL	60H,00H,22H,00
	;---------------<:piano  >---------------
fev8F06::
	CNF	3,6
	MD	4,6,1,0,10,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	15,1,22,11
	D2R	11,7,31,0
	RRL	15,5,15,5,10,3,10,3
	TL	20H,18H,13h,00
	;---------------<: glass flute  >---------------
fev8F07::
	CNF	1,10
	MD	8,0,6,0,4,0,2,1
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,9,9,2
	D2R	0,0,0,0
	RRL	11,8,10,5,10,3,10,3
	TL	10H,28H,29H,00
	;-----------< flute >------------
fev8F08::
	CNF	4,0
	MD	12,0,4,3,8,0,4,3
	RSAR	0,22,0,16,0,22,0,16
	D1R	0,5,0,3
	D2R	0,0,0,0
	RRL	15,0,15,7,15,7,15,7
	TL	3dH,00H,40H,00H
	;---------------<: flute  >---------------
fev8F09::
	CNF	2,4
	MD	8,15,6,8,8,1,4,1
	RSAR	0,31,0,31,0,5,0,10
	D1R	4,16,7,6
	D2R	15,0,0,0
	RRL	15,3,10,5,10,5,10,2
	TL	30H,28H,2cH,00


	if	check
	include		voice1.s
S90::
	DW	TIMB8F				; VOICE TOP ADDR.

	DB	6,2,TP8F,DL8F			; FM CHIAN,PSG,CHIAN

	DEFW	T8FDB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8F0B
	DEFB	FB8FM,FA8FM


	DEFW	T8F1B
	DEFB	FB8FB,FA8FB

	DEFW	T8F2B
	DEFB	FB8FK1,FA8FK1

	DEFW	T8F3B
	DEFB	FB8FK2,FA8FK2

	DEFW	T8F4B
	DEFB	FB8FK3,FA8FK3

	DEFW	T8F0PB
	DEFB	PB8FM,PA8FM,PV8FM,PE8FM

	DEFW	T8F1PB
	DEFB	PB8FB,PA8FB,PV8FB,PE8FB

;	DEFW	TAB8F2PB
;	DEFB	PB8FK,PA8FK,PV8FK,PE8FK


S91::
	DW	TIMB8F				; VOICE TOP ADDR.

	DB	6,2,TP8F,DL8F			; FM CHIAN,PSG,CHIAN

	DEFW	T8FDC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T8F0C
	DEFB	FB8FM,FA8FM


	DEFW	T8F1C
	DEFB	FB8FB,FA8FB

	DEFW	T8F2C
	DEFB	FB8FK1,FA8FK1

	DEFW	T8F3C
	DEFB	FB8FK2,FA8FK2

	DEFW	T8F4C
	DEFB	FB8FK3,FA8FK3

	DEFW	T8F0PC
	DEFB	PB8FM,PA8FM,PV8FM,PE8FM

	DEFW	T8F1PC
	DEFB	PB8FB,PA8FB,PV8FB,PE8FB

;	DEFW	T8F2PC
;	DEFB	PB8FK,PA8FK,PV8FK,PE8FK

	endif
