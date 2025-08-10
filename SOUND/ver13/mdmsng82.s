;********************************************************
;*		srcSNG82.S	( SOUND DATA FILE )	*
;*  			ORG. M5SNG113.S               	*
;*		'MoDeM BOOT ROM'                        *
;*		 for Mega Drive (Z80)			*
;*			VER  1.3/1989.5.25		*
;*				BY        T.Uwabo       *
;********************************************************
	.XLIST
	include m5eq13.lib
	include m5mcr13.lib
	include m5tb13.lib
	.LIST

;-------------- voice assign ------
BASS820	equ	1
BACK820	equ	0

;========== TEMPO =============
TP82	EQU	2		; tempo for S82
DL82	EQU	1AH		; dlay counter for S82
;<<<<<<<< S82 FM BIAS >>>>>>>>
FB82	EQU	0F5H
;-----------------------------
FB82M	EQU	LOW FB82+12	; fm melo
FB82B	EQU	LOW FB82+24	; fm bass	
FB82K1	EQU	LOW FB82+12	; fm back 1
FB82k2	EQU	LOW FB82+12	; fm back 2
FB82k3	EQU	LOW FB82+12	; fm back 3
FB82k4	EQU	FB82		; fm back 4
PB82M	EQU	FB82		; psg 1
PB82B	EQU	FB82		; psg 2
PB82K	EQU	FB82		; psg 3
;<<<<<<<< S82 VOLM >>>>>>>>>	 
FA82M	EQU	FV_ML-1		; fm melo      ( FV_ML ==> show   mdmeq.lib )
FA82B	EQU	FV_BS+1		; fm bass
FA82K1	EQU	FV_BK1+5		; fm back 1
FA82K2	EQU	FV_BK2+5		; fm back 2
FA82K3	EQU	FV_BK3+5		; fm back 3
FA82K4	EQU	FV_BK4		; fm back 4
PA82M	EQU	PV_ML+1		; psg 1
PA82B	EQU	PV_BS+1		; psg 2
PA82K	EQU	PV_BK+1		; psg 3
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
;*
;*********************************  

S82::
	DW	TIMB82				; VOICE TOP ADDR.

	DB	6,3,TP82,DL82			; FM CHIAN,PSG,CHIAN
						;  BASE TEMPO,delay counter
	DEFW	TAB82D				; rythm table pointer
	DEFB	0,0				; bias,volm

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

	DEFW	TAB822P				; PSG ch3 table pointe
	DEFB	PB82K,PA82K,PV82K,PE82K 	; bias,volm           

;<<<<<<<<<<< MELO >>>>>>>>>
TAB820::
	DB	FEV,BACK820
	DB	EXCOM,CMINT,40H
;	DB	EXCOM,TIMER,0,0,0CBH
	DB	TIMER,0,0,0CBH
TAB820P::
T8200:
	db	cmcall
	dw	sub820
;	DB	EXCOM,TIMER_ADD,0,0,1
	DB	TIMER_ADD,0,0,1
	db	cmrept,0,16
	DW	T8200
T8201:
	db	cmcall
	dw	sub820
	DB	CMJUMP
	DW	T8201


	IF	0
	db	cmcall
	dw	sub820
T8200:
	db	cmcall
	dw	sub820
	DB	TEMPO_CHG,2
	db	cmrept,0,4
	DW	T8200

	DB	EXCOM,SNG_BIAS,1
	DB	EXCOM,WRITE_DATA
	DW	RCUNT
	DB	2,3,3
T8201:
	db	cmcall
	dw	sub820
	DB	TEMPO_CHG,2
	db	cmrept,0,8
	DW	T8201
T8202:
	db	cmcall
	dw	sub820
	DB	CMJUMP
	DW	T8202

	ENDIF

sub820:
	db	DN4,L4,EN4,FN4,GN3
	db	GS3,LF2,DN4,L4
	db	CN4,DN4,DS4,FN4
	db	DS4,L2+L8,DN4,L8,AN3,L8_3,BN3,CN4
	db	cmret

;<<<<<<<<<<< BASS >>>>>>>>>
TAB821::
	DB	FEV,BASS820

	db	FN1,LF8,L16,LF8,L16,LF8,L16,LF8,L16
	db	EN1,LF8,L16,LF8,L16,LF8,L16,LF8,L16
	db	DS1,LF8,L16,LF8,L16,LF8,L16,LF8,L16
	db	DN1,LF8,L16,LF8,L16,LF8,L16,LF8,L16

	DB	CMJUMP
	DW	TAB821

;<<<<<<<<<<< BACK 1 >>>>>>>>>
TAB822::
	DB	FEV,BACK820
TAB821P::

T8220:
	db	FN2,L4,CN3,DN3,FN2
	db	EN2,GS2,DN3,EN2
	db	DS2,CN3,AS2,GN2
	db	DN2,AN2,CN3,DN3

	DB	CMJUMP
	DW	T8220

;<<<<<<<<<<< BACK 2 >>>>>>>>>
TAB823::
	DB	FEV,BACK820

	db	DN4,L8,L4,L4,L4,L8
	db	L8,L4,L4,L4,L8
	db	CN4,CN4,L4,L4,L4,L8
	db	L8,L4,L4,L4,L8

	DB	CMJUMP
	DW	TAB823

;<<<<<<<<<<< BACK 3 >>>>>>>>>
TAB824::
	DB	FEV,BACK820
TAB822P::

T8240:
	db	DN4,L4,EN4,FN4,GN4
	db	DN4,L1
	db	CN4,L4,DN4,DS4,FN4
	db	DS4,L1

	db	AN3,L2+L8,L8,L8,L8
	db	GS3,L2+L8,L8,L8,L8
	db	GN3,L2+L8,L8,L8,L8
	db	FS3,L2+L8,L8,L8,L8

	DB	CMJUMP
	DW	T8240

;<<<<<<<<<<< psg  1 >>>>>>>>>
;<<<<<<<<<<< psg  2 >>>>>>>>>
;<<<<<<<<<<< psg  3 >>>>>>>>>
;<<<<<<<<< RYTHM >>>>>>>>
TAB82D::
	db	B,L8,H,NL,H,S,H,NL,B
	db	B,L8,H,NL,H,S,H,NL,H

	DB	CMJUMP
	DW	TAB82D

TIMB82::
fev8200::
	;---------------<: VIBE 1 >---------------
	CNF	4,5
	MD	12,3,4,0,4,0,1,0
	RSAR	1,24,1,24,1,26,1,26
	D1R	14,10,14,8
	D2R	0,0,0,0
	RRL	15,15,15,15,15,15,15,15
	TL	50,00,57,00H
	;---------------<: bass 2 >---------------
fev8201::
	CNF	0,1
	MD	10,0,0,7,0,3,0,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	18,14,10,10
	D2R	0,4,4,3
	RRL	15,2,15,2,15,2,15,2
	TL	36,45,19,00H

