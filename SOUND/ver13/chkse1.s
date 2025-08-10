;********************************************************
;*		chkSE1.S	( SOUND S.E FILE )	*
;*  			ORG. M5SE13.S               	*
;*		'COMMAND CHECK'                         *
;*		 for Mega Drive (Z80)			*
;*			VER  1.3/1989.7.2		*
;*				BY        T.Uwabo       *
;********************************************************

;;;;;		back se check
;------------- back se ::: d0h  (s8b)
	.xLIST
	include m5eq13.lib
	include M5tb13.lib
	include m5mcr13.lib
	include chksetb1.src
	.LIST

	public	backsetb_adr

;	org	setop_adr

;-----------------------------------------------------------------------------
;================== S.E ======================= 
;	S90	2ch using ( 2,80ch / nomal mode)  LRPAN
;	S91	2ch using ( 2,80ch / nomal mode)  TEMPO_CHG FEV,SONG
;	S92	2ch using ( 2,80ch / nomal mode)  SET_TFLG
;	S93	2ch using ( 2,80ch / nomal mode)  CMTREND
;	S94	2ch using ( 2,80ch / nomal mode)  AUTOPAN 1
;	S95	2ch using ( 2,80ch / nomal mode)  AUTOPAN 2
;	S96	2ch using ( 2,80ch / nomal mode)  AUTOPAN 3
;	S97	2ch using ( 2,80ch / nomal mode)  PFVADD
;	S98	2ch using ( 2,80ch / nomal mode)  CMVADD
;	S99	2ch using ( 2,80ch / nomal mode)  CMTAB
;	S9A	2ch using ( 2,80ch / nomal mode)  CMGATE
;	S9B	2ch using ( 2,80ch / nomal mode)  LFO,PMS,AMS
;	S9C	2ch using ( 2,80ch / nomal mode)  PVADD
;	S9D	2ch using ( 2,80ch / nomal mode)  REGSET
;	S9E	2ch using ( 2,80ch / nomal mode)  FMWRITE
;	S9F	2ch using ( 2,80ch / nomal mode)  FVR
;	SA0	2ch using ( 2,80ch / nomal mode)  PFVR
;	SA1	2ch using ( 2,80ch / nomal mode)  CMNOIS
;	SA2	2ch using ( 2,80ch / nomal mode)  VR
;	SA3	2ch using ( 2,80ch / nomal mode)  EV
;	SA4	2ch using ( 2,80ch / nomal mode)  CMREPT,CMCALL,CMRET
;	SA5	2ch using ( 2,80ch / nomal mode)  CMBASE
;	SA6	2ch using ( 2,80ch / nomal mode)  CMBIAS,CMPORT,CMFREQ
;	SA7	2ch using ( 2,80ch / nomal mode)  DT
;	SA8	2ch using ( 2,80ch / nomal mode)  EXCOM,CMINT
;						  EXCOM,TIMER
;						  EXCOM,TIMER_ADD
;	SA9	2ch using ( 2,80ch / nomal mode)  EXCOM,KEYSET,EXCOM,S_PSE
;						  EXCOM,SNG_BASE
;	SAA	2ch using ( 2,80ch / nomal mode)  WOW
;--------------- bck s.e ---------------
;	SAB	2CH using (2,6 s.e mode)
;	SAC	2CH using (80h,c0H noise 7)
;--------------- NOMAL
;	SAD	1CH using (ch 5 )		EXCOM,SSG
;	SAE	FM 2CH 				DT
;	SAF	psg 2CH				DT


	;--------------------------------
	;*;	S90	2ch using ( 2,80ch / nomal mode)  LRPAN
	;--------------------------------
S90::
	DW	TIMB00			; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB900,00H,000H	 ; flag,ch,table,bias volm 
	HD	80H,80h,TAB900,000H,000H	 ; flag,ch,table,bias volm 
;----------------- TABLE DATA -------------------
TAB900::
	DB	FEV,80H,82H,DT,2,2,2,3
	DB	LRPAN,LSET,9ah,20H
	DB	LRPAN,RSET,D3,10h
	DB	LRPAN,LRSET,C2,10H,CMEND
	;--------------------------------
	;*;	S91	2ch using ( 2,80ch / nomal mode)  TEMPO_CHG
	;--------------------------------
S91::
	DW	TIMB00	;,S91		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,5,TAB910,000H,000H	 ; flag,ch,table,bias volm
	HD	80H,80H,TAB910,000H,000H	 ; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB910::
	Db	FEV,0
	DB	0D0H,020h
TAB911::
	Db	FEV,2
	DB	TEMPO_CHG,0FFH,C3,L1,CMJUMP
	DW	TAB911

	;--------------------------------
	;*;	S92	2ch using ( 2,80ch / nomal mode)  SET_TFLG
	;--------------------------------
S92::
	DW	TIMB00	;,S92		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB920,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB920,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB920::
	DB	FEV,0
	DB	SET_TFLG,80H,09aH,020h
	DB	SET_TFLG,10H,D3,020h,C2,20h,CMEND
	
	;--------------------------------
	;*;	S93	2ch using ( 2,80ch / nomal mode)  CMTREND
	;--------------------------------
S93::
	DW	TIMB00	;,S93		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB930,000H,000H	; flag,ch,table,bias volm
	HD	80H,5,TAB931,000H,000H ; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB930::
	DB	FEV,1
	DB	0D0H,020h,CMTREND
TAB931:
	DB	FEV,1
	DB	0D0H,020h,CMEND
	;--------------------------------
	;*;	S94	2ch using ( 2,80ch / nomal mode)  AUTOPAN 1
	;--------------------------------
S94::
	DW	TIMB00	;,S94		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,5,TAB940,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB940,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB940::
	DB	FEV,2
	DB	AUTOPAN,1,0,0,5,4
				;    <pan no>,<pan tb no>,<point strt no>
				;    < point limit>,<length data>
T940:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T940
	DB	AUTOPAN,1,1,0,3,5
T941:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T941
	DB	CMEND
;----------------------------
SUB940:
	DB	C0,020h,D0,E0,F0,G0,A0,B0,C1,40H,NL,10H
	DB	CMRET

	;--------------------------------
	;*;	S95	2ch using ( 2,80ch / nomal mode)  AUTOPAN 2
	;--------------------------------
S95::
	DW	TIMB00	;,S95		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB950,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB950,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB950::
	DB	FEV,2
	DB	AUTOPAN,2,0,0,5,4
				;    <pan no>,<pan tb no>,<point strt no>
				;    < point limit>,<length data>
T950:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T950
	DB	AUTOPAN,2,1,0,3,5
T951:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T951
	DB	CMEND
	
	;--------------------------------
	;*;	S96	2ch using ( 2,80ch / nomal mode)  AUTOPAN 3
	;--------------------------------
S96::
	DW	TIMB00	;,S96		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB960,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB960,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB960::
	DB	FEV,2
	DB	AUTOPAN,3,0,0,5,4
				;    <pan no>,<pan tb no>,<point strt no>
				;    < point limit>,<length data>
T960:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T960
	DB	AUTOPAN,3,1,0,3,5
T961:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,5
	DW	T961
	DB	CMEND

	;--------------------------------
	;*;	S97	2ch using ( 2,80ch / nomal mode)  PFVADD
	;--------------------------------
S97::
	DW	TIMB00	;,S97		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	080H,2,TAB970,000H,000H	; flag,ch,table,bias volm
	HD	080H,80H,TAB970,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB970::
	DB	FEV,0
T970:
	DB	0C0H,020h,PFVADD,1,8,CMBIAS,1
	DB	CMREPT,0,8
	DW	T970
	DB	CMEND
	;--------------------------------
	;*;	S98	2ch using ( 2,80ch / nomal mode)  CMVADD
	;--------------------------------
S98::
	DW	TIMB00	;,S98		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB980,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB980,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB980:
	DB	FEV,0
T980:
	DB	0B0H,020h,CMVADD,8,CMBIAS,1
	DB	CMREPT,0,8
	DW	T980
	DB	CMEND
	
	;--------------------------------
	;*;	S99	2ch using ( 2,80ch / nomal mode)  CMTAB
	;--------------------------------
S99::
	DW	TIMB00	;,S99		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB990,0f4H,000H	; flag,ch,table,bias volm
	HD	080H,80H,TAB990,0f4h,2	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB990:
	DB	FEV,0,EV,3
	DB	0D0H,020h,CMTAB,20H
	DB	0D1H,020h,CMTAB,0D0H,20H
	DB	CMEND
	;--------------------------------
	;*;	S9A	2ch using ( 2,80ch / nomal mode)  CMGATE
	;--------------------------------
S9A::
	DW	TIMB00	;,S9A		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TAB9A0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9A0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9A0:
	DB	FEV,0
	DB	CMGATE,10H,94H,8
	DB	95H,20H,96H,18H
	DB	CMGATE,0H
	db	94H,70h,TIE,70H,TIE,70H


	DB	CMEND

	;--------------------------------
	;*;	S9B	2ch using ( 2,80ch / nomal mode)  LFO,PMS,AMS
	;--------------------------------
S9B::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB9B0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9B0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9B0::
	DB	FEV,3
T9B00::
	DB	LFO,0AH,0
	DB	CMCALL
	DW	SUB940
	DB	LFO,0AH,3FH
	DB	CMCALL
	DW	SUB940
	DB	LFO,0FH,4
	DB	CMCALL
	DW	SUB940
	DB	CMJUMP
	DW	T9B00
	;--------------------------------
	;*;	S9C	2ch using ( 2,80ch / nomal mode)  PVADD
	;--------------------------------
S9C::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB9C0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9C0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9C0::
	db	FEV,0
T9C1:
	DB	94H,10H,PVADD,1
	DB	CMREPT,0,8
	DW	T9C1
	DB	CMEND
	;--------------------------------
	;*;	S9D	2ch using ( 2,80ch / nomal mode)  REGSET
	;--------------------------------
S9D::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB9D0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9D0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9D0::
	DB	FEV,0
T9D00::
	DB	94H,10H,REGSET,0B4H,0
	DB	94H,10H,REGSET,0B4H,40H
	DB	95H,10H
	DB	CMEND

	;--------------------------------
	;*;	S9E	2ch using ( 2,80ch / nomal mode)  FMWRITE
	;--------------------------------
S9E::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB9E0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9E0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9E0::
	DB	FEV,2
T9E00::
	DB	94H,10H,FMWRITE,42H,0
	DB	94H,10H
	DB	CMEND
	;--------------------------------
	;*;	S9F	2ch using ( 2,80ch / nomal mode)  FVR
	;--------------------------------
S9F::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.

	db	1,2			; base,use chian no
	HD	80H,2,TAB9F0,000H,000H	; flag,ch,table,bias volm
	HD	80H,80H,TAB9F0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TAB9F0::
	DB	FEV,0,FVR,6,1,2,50
T9F00::
	DB	94H,7fH,TIE,7FH,NL,10H
	DB	FVR,1,1,2,250
	DB	94H,7FH
	DB	VR,0
	DB	94H,30H
	DB	VR,80H
	DB	94H,30H
	DB	CMEND

	;--------------------------------
	;*;	SA0	2ch using ( 2,80ch / nomal mode)  PFVR
	;--------------------------------

SA0::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABA00,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA00,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA00::
	DB	FEV,2,PFVR,5,2
	DB	CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SA1	2ch using ( 2,80ch / nomal mode)  CMNOIS
	;--------------------------------
SA1::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TABA10,000H,000H	; flag,ch,table,bias volm
	HD	88H,0C0H,TABA11,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------

TABA10::
	DB	FEV,0
	DB	94H,10H
	DB	CMEND
TABA11::
	DB	EV,4,CMNOIS,NOIS0
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS1
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS2
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS3
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS4
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS5
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS6
	DB	0,10H,10H
	DB	EV,4,CMNOIS,NOIS7
	DB	0,10H,10H
	DB	CMEND

	;--------------------------------
	;*;	SA2	2ch using ( 2,80ch / nomal mode)  VR
	;--------------------------------
SA2::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TABA20,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA20,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA20::
	DB	FEV,2
	DB	VR,1
	DB	CMCALL
	DW	SUB940
	DB	VR,2
	DB	CMCALL
	DW	SUB940
	DB	VR,3
	DB	CMCALL
	DW	SUB940
	DB	VR,0
	DB	CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SA3	2ch using ( 2,80ch / nomal mode)  EV
	;--------------------------------
SA3::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2		; base,use chian no
	HD	80H,2,TABA30,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA30,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA30::
	DB	FEV,2
	DB	EV,4
	DB	CMCALL
	DW	SUB940
	DB	EV,5
	DB	CMCALL
	DW	SUB940
	DB	EV,6
	DB	CMCALL
	DW	SUB940
	DB	EV,0
	DB	CMCALL
	DW	SUB940
	DB	CMEND


	;--------------------------------
	;*;	SA4	2ch using ( 2,80ch / nomal mode)  CMREPT,CMCALL,CMRET
	;--------------------------------
SA4::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2H,TABA40,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA40,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA40::
	DB	FEV,3
TA40:
	DB	CMCALL
	DW	SUB940
	DB	CMREPT,0,2
	DW	TA40
	DB	CMBIAS,1
	DB	CMREPT,1,2
	DW	TA40
	DB	CMEND

	;--------------------------------
	;*;	SA5	2ch using ( 2,80ch / nomal mode)  CMBASE
	;--------------------------------
SA5::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABA50,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA50,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA50::
	DB	FEV,2
	DB	CMBASE,1
	DB	CMCALL
	DW	SUB940
	DB	CMBASE,2
	DB	CMCALL
	DW	SUB940
	DB	CMBASE,3
	DB	CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SA6	2ch using ( 2,80ch / nomal mode)  CMBIAS,CMPORT,CMFREQ
	;--------------------------------
SA6::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABA60,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA60,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA60::
	DB	FEV,3
	DB	CMPORT,ON
	DB	C3,1,20H
	DB	CMPORT,OFF
	DB	C3,20H
	DB	CMFREQ,ON,12H,00H,20H
	DB	CMPORT,ON,12H,00H,1,20H
	DB	CMFREQ,OFF,C3,08H,20H
	DB	CMPORT,OFF
	DB	CMCALL
	DW	SUB940
	DB	CMBIAS,12
	DB	CMCALL
	DW	SUB940
	DB	CMEND
	
	

	;--------------------------------
	;*;	SA7	2ch using ( 2,80ch / nomal mode)  DT
	;--------------------------------
SA7::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABA70,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA70,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA70::
	DB	FEV,2
	DB	CMCALL
	DW	SUB940
	DB	DT,2,0,2,3
	DB	CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SA8	2ch using ( 2,80ch / nomal mode)  EXCOM,CMINT
	;--------------------------------
SA8::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2H,TABA80,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA80,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA80::
	DB	FEV,2
	DB	EXCOM,CMINT,0
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,CMINT,40H,EXCOM,TIMER,0,2,80H  ; TIMER B USE
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,CMINT,80H,EXCOM,TIMER,0,1,40H  ; TIMER A/B USE
	DB	CMCALL
	DW	SUB940
	db	CMEND
	;--------------------------------
	;*	SA9	2ch using ( 2,80ch / nomal mode) 
	;		 EXCOM,KEYSET,EXCOM,S_PSE
	;--------------------------------
SA9::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,2,TABA90,000H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABA90,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA90::
	DB	FEV,2
	DB	EV,2,FVR,0,1,4,20
	DB	EXCOM,S_PSE,ON,CMCALL
	DW	SUB940
	DB	EXCOM,S_PSE,OFF,CMCALL
	DW	SUB940
	DB	EXCOM,SNG_BASE,4,CMCALL
	DW	SUB940
	DB	EXCOM,KEYSET,82H
	DB	CMEND

	;--------------------------------
	;*;	SAA	2ch using ( 2,80ch / nomal mode)  EXCOM,WOW
	;--------------------------------
SAa::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABAa0,003H,000H	; flag,ch,table,bias volm
	HD	80H,080H,TABAa0,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAa0::
	DB	FEV,2
	DB	EV,4,FVR,0,1,4,20
	DB	CMCALL
	DW	SUB940
	DB	WOW,1,8,CMCALL
	DW	SUB940
	DB	WOW,11,1,CMCALL
	DW	SUB940
	DB	WOW,11,3,CMCALL
	DW	SUB940
	DB	WOW,11,4,CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SAB	2CH using (2,6 s.e mode)
	;--------------------------------
SAb::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,02H,TABAB0,003H,000H	; flag,ch,table,bias volm
	HD	80H,06H,TABAB0,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAb0::
	DB	FEV,4,FVR,1,1,4,20
TAB0:
	DB	94H,10H
	DB	CMJUMP
	DW	TAB0

	;--------------------------------
	;*;	SAC	2CH using (80h,c0H noise 7)
	;--------------------------------
SAc::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	88H,080H,TABAc0,000H,000H	; flag,ch,table,bias volm
	HD	88H,0C0H,TABAc1,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAc0::
	DB	FEV,4
TAC0:
	DB	0,80H,10H,0,40H,10H
	DB	CMJUMP
	DW	TAC0
TABAc1::
	DB	EV,4,CMNOIS,NOIS7
TAC1:
	DB	0,10H,10H
	DB	CMJUMP
	DW	TAC1


	;--------------------------------
	;	SAD	1CH using (ch 5 )		EXCOM,SSG
	;--------------------------------
SAD::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,05H,TABAd0,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAd0::
	DB	FEV,2
TAD0:
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,SSG,4,0,0,4
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,SSG,4,0,0,4
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,SSG,4,0,0,4
	DB	CMCALL
	DW	SUB940
	DB	EXCOM,SSG,0,0,0,0
	DB	CMREPT,0,4
	DW	TAD0
	DB	CMEND

	;--------------------------------
	;*;	SAE	FM 2CH 				DT
	;--------------------------------
SAE::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,05H,TABAe0,000H,000H	; flag,ch,table,bias volm
	HD	80H,05H,TABAe1,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAE1::
	DB	FDT,8
TABAe0::
	DB	EV,4,CMCALL
	DW	SUB940
	DB	CMEND

	;--------------------------------
	;*;	SAF	psg 2CH				DT
	;--------------------------------
SAf::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,080H,TABAf0,000H,000H	; flag,ch,table,bias volm
	HD	80H,0A0H,TABAf1,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABAf1::
	DB	FDT,2
TABAf0::
	DB	FEV,5,FVR,1,1,4,20
	DB	CMCALL
	DW	SUB940
	DB	CMEND
	if	0
	;--------------------------------
	;*
	;--------------------------------
Sb0::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,080H,TABb00,000H,000H	; flag,ch,table,bias volm
	HD	88H,0C0H,TABb01,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABb00::
	DB	EV,4,FVR,0,1,4,20
TB00:
	DB	94H,10H,0A0H,10H,CMJUMP
	DW	TB00

TABB01:
	DB	CMNOIS,NOIS7
TB01:
	DB	0,10H,10H,00,20H,10H,CMJUMP
	DW	TB01

	;--------------------------------
	;*
	;--------------------------------
Sb1::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,080H,TABb10,000H,000H	; flag,ch,table,bias volm
	HD	80H,0C0H,TABb10,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABb10::
	DB	EV,4,FVR,0,1,4,20
TB10:
	DB	94H,10H,0A0H,10H,CMJUMP
	DW	TB10

	;--------------------------------
	;*
	;--------------------------------
Sb2::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,0A0H,TABb20,000H,000H	; flag,ch,table,bias volm
	HD	88H,0C0H,TABb21,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABb20::
	DB	EV,4,FVR,0,1,4,20
TB20:
	DB	94H,10H,0A0H,10H,CMJUMP
	DW	TB20

TABB21:
	DB	CMNOIS,NOIS7
TB210:
	DB	0,20H,10H,0,28H,10H,CMJUMP
	DW	TB210

	;--------------------------------
	;*
	;--------------------------------
SB3::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB30,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABB30::
	DB	FEV,1,FVR,0,1,4,20
	DB	AUTOPAN,1,0,1,4,3
				;    <pan no>,<pan tb no>,<point strt no>
				;    < point limit>,<length data>
TB30:
	DB	CN3,20H,DN3,EN3,FN3,GN3,AN3,BN3
	DB	CMJUMP
	DW	TB30

	;--------------------------------
	;*
	;--------------------------------
SB4::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,1			; base,use chian no
	HD	80H,5,TABB40,000H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABB40::
	DB	FEV,2,FVR,0,1,4,20
	DB	AUTOPAN,1,0,2,3,2
				;    <pan no>,<pan tb no>,<point strt no>
				;    < point limit>,<length data>
	db	NL,L1
TB40:
T843I_1:
	db	CN4,L16,L16,CN5,CN5,FN4,FN4,GN4,GN4,GN4,GN4
	db	  CN4,CN4,FN4,FN4,GN4,GN4
	DB	CMREPT,0,4
	DW	T843I_1
	DB	CMJUMP
	DW	TB40

	;--------------------------------
	;*
	;--------------------------------
SA0::
	DW	TIMB00	;,S9B		; VOICE TOP ADDR.
	db	1,2			; base,use chian no
	HD	80H,080H,TABA00,000H,000H	; flag,ch,table,bias volm
	HD	80H,0A0H,TABA00,003H,000H	; flag,ch,table,bias volm

;----------------- TABLE DATA -------------------
TABA00::
	DB	EV,4,FVR,0,1,4,20
	DB	94H,10H
	DB	CMEND









	ENDIF











TIMB00:
	CNF	7,6
	MD	0,0,0,4,0,3,0,7
	RSAR	0,18,0,16,0,24,0,16
	D1R	0,00,00,00
	D2R	00,0,0,00
	RRL	15,6,15,3,15,3,15,3
	TL	0,8,0,0
TIMB01::
	CNF	4,6
	MD	0,0,0,4,0,3,0,7
	RSAR	0,18,0,16,0,24,0,16
	D1R	0,00,23,00
	D2R	00,0,0,00
	RRL	0,6,0,3,0,3,0,3
	TL	0,8,0,0
fev8402::
	;---------------<: CELE >---------------
	CNF	4,5
	MD	12,3,4,0,4,0,1,0
	RSAR	1,24,1,24,1,26,1,26
	D1R	14,10,14,8
	D2R	0,0,0,0
	RRL	15,15,15,15,15,15,15,15
	TL	50,0,57,0

fev8403::
	;---------------<:  >---------------
	CNF	4,5
	MD	12,3,4,0,4,0,4,0
	RSAR	1,24,1,24,1,26,1,26
	D1R	14,10,14,8
	D2R	80H,80H,80H,80H
	RRL	15,15,15,15,15,15,15,15
	TL	50,0,09,0
fev8404::
	;---------------<:  >---------------
	CNF	4,5
	MD	12,3,4,4,4,4,4,4
	RSAR	1,24,1,24,1,26,1,26
	D1R	0,10,0,8
	D2R	80H,80H,80H,80H
	RRL	15,15,15,15,15,15,15,15
	TL	50,0,09,0
fev8405::
	;---------------<:  >---------------  (FOR SSG ENVE)
	CNF	2,4
	MD	12,3,0,4,0,4,0,4
	RSAR	0,31,0,31,0,31,0,31
	D1R	12,0,0,0
	D2R	16,0,0,0
	RRL	15,15,15,15,15,15,15,15
	TL	16,48,57,0

SB0::

