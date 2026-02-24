;===============================================================================
; Objeto 0x69 - Tubo azul em espiral na Hidrocity
; ->>>
;===============================================================================
Offset_0x02EE74:
		dc.b	$02, $04, $04, $04, $04, $04, $0C, $00
;-------------------------------------------------------------------------------
Offset_0x02EE7C:
		dc.b	$02, $04, $06, $06, $06, $06, $08, $08
		dc.b	$08, $08, $0A, $0A, $00, $00
;-------------------------------------------------------------------------------
Offset_0x02EE8A:
		dc.b	$02, $04, $06, $06, $06, $06, $08, $08
		dc.b	$08, $08, $0A, $00
;-------------------------------------------------------------------------------
Offset_0x02EE96:
		dc.b	$02, $04, $06, $06, $06, $06, $08, $08
		dc.b	$08, $08, $08, $08, $08, $08, $08, $08
		dc.b	$08, $08, $0E, $00
;-------------------------------------------------------------------------------
Offset_0x02EEAA:
		dc.w	$0840, $0120
		dc.l	Offset_0x02EE74
		dc.w	$1540, $0620
		dc.l	Offset_0x02EE7C
		dc.w	$1740, $03A0
		dc.l	Offset_0x02EE7C
		dc.w	$1CC0, $0620
		dc.l	Offset_0x02EE74
		dc.w	$1FC0, $02A0
		dc.l	Offset_0x02EE8A
		dc.w	$24C0, $0220
		dc.l	Offset_0x02EE96
		dc.w	$26C0, $0120
		dc.l	Offset_0x02EE74
		dc.w	$3040, $0620
		dc.l	Offset_0x02EE7C
;-------------------------------------------------------------------------------
Obj_0x69_Hz_Curved_Twisting_Pipe:					   ; Offset_0x02EEEA
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$007F, D0
		lsl.w	#$03, D0
		lea		Offset_0x02EEAA(PC, D0), A1
		move.w	(A1)+, Obj_Control_Var_00(A0)			 ; $0030
		move.w	(A1)+, Obj_Control_Var_02(A0)			 ; $0032
		move.l	(A1)+, Obj_Control_Var_10(A0)			 ; $0040
		move.l	#Offset_0x02EF0A, (A0)
Offset_0x02EF0A:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_04(A0), A4				 ; $0034
		bsr.s	Offset_0x02EF30
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_0A(A0), A4				 ; $003A
		bsr.s	Offset_0x02EF30
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		add.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		beq.s	Offset_0x02EF2A
		rts
Offset_0x02EF2A:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x02EF30:
		moveq	#$00, D0
		move.b	(A4), D0
		move.w	Offset_0x02EF60(PC, D0), D0
		jsr		Offset_0x02EF60(PC, D0)
		tst.b	(A4)
		beq.s	Offset_0x02EF5E
		bsr.w	Offset_0x02F076
		moveq	#$00, D0
		move.w	$0002(A4), D0
		divu.w	#$0060, D0
		move.l	Obj_Control_Var_10(A0), A2				 ; $0040
		move.b	(A2, D0), (A4)
		bne.s	Offset_0x02EF5E
		move.b	#$00, Obj_Timer(A1)				 ; $002E
Offset_0x02EF5E:
		rts
;-------------------------------------------------------------------------------
Offset_0x02EF60:
		dc.w	Offset_0x02EF70-Offset_0x02EF60
		dc.w	Offset_0x02F0CA-Offset_0x02EF60
		dc.w	Offset_0x02F124-Offset_0x02EF60
		dc.w	Offset_0x02F15C-Offset_0x02EF60
		dc.w	Offset_0x02F18C-Offset_0x02EF60
		dc.w	Offset_0x02F1CC-Offset_0x02EF60
		dc.w	Offset_0x02F1FC-Offset_0x02EF60
		dc.w	Offset_0x02F22C-Offset_0x02EF60
;-------------------------------------------------------------------------------
Offset_0x02EF70:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x02F004
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.w	Offset_0x02F006
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0008, D0
		cmpi.w	#$0010, D0
		bcc.s	Offset_0x02F004
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		cmpi.w	#$0030, D1
		bcc.s	Offset_0x02F004
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x02F004
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02EFC0
		tst.w	Obj_Inertia(A1)					 ; $001C
		bpl.s	Offset_0x02F004
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bpl.s	Offset_0x02F004
		neg.w	Obj_Inertia(A1)					 ; $001C
		bra.s	Offset_0x02EFC6
Offset_0x02EFC0:
		tst.w	Obj_Inertia(A1)					 ; $001C
		bmi.s	Offset_0x02F004
Offset_0x02EFC6:
		addq.b	#$02, (A4)
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.b	#$28, Obj_Angle(A1)				 ; $0026
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Control_Var_02(A0), D1				 ; $0032
		move.w	D1, $0002(A4)
Offset_0x02F004:
		rts
Offset_0x02F006:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x02F004
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0010, D1
		cmpi.w	#$0010, D1
		bcc.s	Offset_0x02F004
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x02F004
		tst.w	Obj_Inertia(A1)					 ; $001C
		bpl.s	Offset_0x02F004
		addq.b	#$02, (A4)
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.b	#$28, Obj_Angle(A1)				 ; $0026
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Control_Var_02(A0), D1				 ; $0032
		move.w	D1, $0002(A4)
		rts
Offset_0x02F076:
		move.b	Obj_Angle(A1), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	Obj_Inertia(A1), D1				 ; $001C
		asr.l	#$08, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		muls.w	Obj_Inertia(A1), D0				 ; $001C
		asr.l	#$08, D0
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		move.b	Obj_Angle(A1), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$0050, D0
		asr.l	#$08, D0
		tst.w	Obj_Inertia(A1)					 ; $001C
		bmi.s	Offset_0x02F0BE
		tst.w	D0
		bpl.s	Offset_0x02F0B0
		asr.l	#$02, D0
Offset_0x02F0B0:
		cmpi.w	#$1800, Obj_Inertia(A1)					 ; $001C
		bge.s	Offset_0x02F0C8
		add.w	D0, Obj_Inertia(A1)				 ; $001C
		rts
Offset_0x02F0BE:
		tst.w	D0
		bmi.s	Offset_0x02F0C4
		asr.l	#$02, D0
Offset_0x02F0C4:
		add.w	D0, Obj_Inertia(A1)				 ; $001C
Offset_0x02F0C8:
		rts
;-------------------------------------------------------------------------------
Offset_0x02F0CA:
		move.w	$0002(A4), D0
		subi.w	#$0016, D0
		bcc.s	Offset_0x02F0F0
		tst.w	Obj_Inertia(A1)					 ; $001C
		bpl.s	Offset_0x02F0EE
		move.b	#$00, (A4)
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		move.b	#$70, Obj_Angle(A1)				 ; $0026
		bra.w	Offset_0x02F076
Offset_0x02F0EE:
		moveq	#$00, D0
Offset_0x02F0F0:
		mulu.w	#$00DD, D0
		lsr.w	#$08, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$D800, D0
		swap	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F124:
		move.w	$0002(A4), D0
		mulu.w	#$00AA, D0
		asr.w	#$08, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$D800, D0
		swap	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F15C:
		move.w	$0002(A4), D0
		subi.w	#$00C0, D0
		muls.w	#$00AA, D0
		asr.l	#$08, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F18C:
		move.w	$0002(A4), D0
		subi.w	#$0180, D0
		mulu.w	#$00AA, D0
		asr.w	#$08, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$D800, D0
		swap	D0
		addi.w	#$0100, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F1CC:
		move.w	$0002(A4), D0
		subi.w	#$0240, D0
		muls.w	#$00AA, D0
		asr.l	#$08, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F1FC:
		move.w	$0002(A4), D0
		subi.w	#$0240, D0
		muls.w	#$00AA, D0
		asr.l	#$08, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x02F22C:
		move.w	$0002(A4), D0
		subi.w	#$0540, D0
		muls.w	#$00AA, D0
		asr.l	#$08, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	$0002(A4), D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, $0002(A4)
		rts
;===============================================================================
; Objeto 0x69 - Tubo azul em espiral na Hidrocity
; <<<-
;===============================================================================