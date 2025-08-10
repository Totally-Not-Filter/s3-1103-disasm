;********************************************************
;*		$$$SNG81.S	( SOUND DATA FILE )	*
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
MELO81A		equ	0
MELO81B		equ	0
MELO81C		equ	0
BASS81A		equ	0
BASS81B		equ	0
BASS81C		equ	0
BACK811A	equ	0
BACK811B	equ	0
BACK811C	equ	0
BACK812A	equ	0
BACK812B	equ	0
BACK812C	equ	0
BACK813A	equ	0
BACK813B	equ	0
BACK813C	equ	0

;========== TEMPO =============
TP81	EQU	2		; tempo for S81
DL81	EQU	0		; dlay counter for S81
;<<<<<<<< S81 FM BIAS >>>>>>>>
FB81	EQU	0f4H
;-----------------------------
FB81M	EQU	FB81		; fm melo
FB81B	EQU	FB81		; fm bass	
FB81K1	EQU	FB81		; fm back 1
FB81k2	EQU	FB81		; fm back 2
FB81k3	EQU	FB81		; fm back 3
FB81k4	EQU	FB81		; fm back 4
PB81M	EQU	FB81		; psg 1
PB81B	EQU	FB81		; psg 2
PB81K	EQU	FB81		; psg 3
;<<<<<<<< S81 VOLM >>>>>>>>>	 
FA81D	equ	FV_DR		; rythm
FA81M	EQU	FV_ML		; fm melo      ( FV_ML ==> show   glfeq.lib )
FA81B	EQU	FV_BS		; fm bass
FA81K1	EQU	FV_BK1    	; fm back 1
FA81K2	EQU	FV_BK2    	; fm back 2
FA81k3	EQU	FV_BK3    	; fm back 3
FA81K4	EQU	FV_BK4		; fm back 4
PA81M	EQU	PV_ML		; psg 1
PA81B	EQU	PV_BS+3		; psg 2
PA81K	EQU	PV_BK		; psg 3
;<<<<<<<<< S81 VIBR >>>>>>>>
PV81M	EQU	7		; melo
PV81B	EQU	0		; bass
PV81K	EQU	0		; back
;<<<<<<<<< S81 ENVE >>>>>>>>
PE81M	EQU	4		; melo
PE81B	EQU	0		; bass
PE81K	EQU	0		; back


;********************************  
;*                                 
;********************************  
S81::
	DW	TIMB81				; VOICE TOP ADDR.

	DB	6,2,TP81,DL81			; FM CHIAN,PSG,CHIAN

	DEFW	TAB81D				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	TAB810
	DEFB	FB81M,FA81M

	DEFW	TAB811
	DEFB	FB81B,FA81B

	DEFW	TAB812
	DEFB	FB81K1,FA81K1

	DEFW	TAB813
	DEFB	FB81K2,FA81K2

	DEFW	TAB814
	DEFB	FB81K3,FA81K3

	DEFW	TAB810P
	DEFB	PB81M,PA81M,PV81M,PE81M

	DEFW	TAB811P
	DEFB	PB81B,PA81B,PV81B,PE81B

;	DEFW	TAB812P
;	DEFB	PB81K,PA81K,PV81K,PE81K

;<<<<<<<  CH0  >>>>>>>>>>>
TAB810::
	DB	TIMER
	DW	0084H
	DB	0E6H
	db	FEV,MELO81A
T810A:
	db	FEV,MELO81B
T810B:
	db	FEV,MELO81C
T810C:
	
;<<<<<<<<  CH1  >>>>>>>>>>>
TAB811::
	db	FEV,BASS81A
T811A:
	db	FEV,BASS81B
T811B:
	db	FEV,BASS81C
T811C:

;<<<<<<<  CH4  >>>>>>>>>>>
TAB812::
	db	FEV,BACK811A
T812A:
	db	FEV,BACK811B
T812B:
	db	FEV,BACK811C
T812C:
;<<<<<<<  CH5  >>>>>>>>>>>>
TAB813::
	db	FEV,BACK812A
T813A:
	db	FEV,BACK812B
T813B:
	db	FEV,BACK812C
T813C:
;<<<<<<  CH6  >>>>>>>>>>>>>>
TAB814::
	db	FEV,BACK813A
T814A:
	db	FEV,BACK813B
T814B:
	db	FEV,BACK813C
T814C:
	DB	CMEND

;<<<<<<<  psg 1 >>>>>>>>>>>>
TAB810P::
T810PA:
T810PB:
T810PC:
;<<<<<<<  psg 2 >>>>>>>>>>>>
TAB811P::
T811PA:
T811PB:
T811PC:
	DB	CMEND

;<<<<<<<<<<<<< RYTHM >>>>>>>>>>>>>>>>>
TAB81D::
T81DA:
T81DB:
T81DC:
	DB	HB,L8,HS,SH,H
	DB	CMJUMP
	DW	TAB81D



TIMB81::
	;---------------<: melo 1 >---------------
fev8100::
	CNF	4,5			; Algo, Feed Back
	MD	2,7,2,7,2,3,2,3		; multiple,ditune
	RSAR	0,31,0,22,0,31,0,31	; key scale,attack rate
	D1R	0,15,0,15		; decay
	D2R	0,9,0,9 		; sustin rate
	RRL	6,0,6,3,6,0,6,3		; release rate,sustine lavel
	TL	15h,00h,14H,00H		; total level
	;---------------<: melo 2 >---------------
fev8101::
	CNF	4,5			; Algo, Feed Back
	MD	6,2,6,2,3,2,3,2		; multiple,ditune
	RSAR	0,31,0,21,0,31,0,20	; key scale,attack rate
	D1R	16,16,18,9		; decay
	D2R	3,3,3,3			; sustin rate
	RRL	15,4,15,4,15,4,15,4	; release rate,sustine lavel
	TL	15h,10h,14H,00H		; total level


	if	check
	include		voice1.s

S82::
	DW	TIMB81				; VOICE TOP ADDR.

	DB	6,2,TP81,DL81			; FM CHIAN,PSG,CHIAN

	DEFW	T81DB			; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T810B
	DEFB	FB81M,FA81M


	DEFW	T811B
	DEFB	FB81B,FA81B

	DEFW	T812B
	DEFB	FB81K1,FA81K1

	DEFW	T813B
	DEFB	FB81K2,FA81K2

	DEFW	T814B
	DEFB	FB81K3,FA81K3

	DEFW	T810PB
	DEFB	PB81M,PA81M,PV81M,PE81M

	DEFW	T811PB
	DEFB	PB81B,PA81B,PV81B,PE81B

;	DEFW	TAB812PB
;	DEFB	PB81K,PA81K,PV81K,PE81K


S83::
	DW	TIMB81				; VOICE TOP ADDR.

	DB	6,2,TP81,DL81			; FM CHIAN,PSG,CHIAN

	DEFW	T81DC				; rythm table pointer
	DEFB	0,0				; bias,volm

	DEFW	T810C
	DEFB	FB81M,FA81M


	DEFW	T811C
	DEFB	FB81B,FA81B

	DEFW	T812C
	DEFB	FB81K1,FA81K1

	DEFW	T813C
	DEFB	FB81K2,FA81K2

	DEFW	T814C
	DEFB	FB81K3,FA81K3

	DEFW	T810PC
	DEFB	PB81M,PA81M,PV81M,PE81M

	DEFW	T811PC
	DEFB	PB81B,PA81B,PV81B,PE81B

;	DEFW	T812PC
;	DEFB	PB81K,PA81K,PV81K,PE81K

	endif

