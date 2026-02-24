;===============================================================================
; Objeto 0x68 - Coluna azul giratória na Hidrocity
; ->>>
;===============================================================================
; Offset_0x0289B8:
		move.l	#Spinning_Column_Mappings, Obj_Map(A0) ; Offset_0x028BFC, $000C
		move.w	#$4040, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Timer(A0)		  ; $0010, $002E
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		add.w	D0, D0
		andi.w	#$0006, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		andi.w	#$00F0, D1
		move.w	D1, Obj_Control_Var_10(A0)				 ; $0040
		move.w	#$0001, Obj_Control_Var_12(A0)			 ; $0042
		cmpi.w	#$00E0, D1
		bne.s	Offset_0x028A12
		neg.w	Obj_Control_Var_12(A0)					 ; $0042
Offset_0x028A12:
		move.l	#Offset_0x028A18, (A0)
Offset_0x028A18:
		bsr.s	Offset_0x028A7C
		lea		Obj_Control_Var_02(A0), A2				 ; $0032
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		bsr.w	Offset_0x028AEE
		addq.w	#$04, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		bsr.w	Offset_0x028AEE
		move.w	#$001B, D1
		move.w	#$0020, D2
		move.w	#$0021, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x028A72
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		bcs.w	Offset_0x028A72
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x028A72:
		move.w	Obj_Timer(A0), D0				 ; $002E
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
Offset_0x028A7C:
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	Offset_0x028A88(PC, D0), D0
		jmp		Offset_0x028A88(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x028A88:
		dc.w	Offset_0x028A8E-Offset_0x028A88
		dc.w	Offset_0x028A90-Offset_0x028A88
		dc.w	Offset_0x028AD0-Offset_0x028A88
;-------------------------------------------------------------------------------
Offset_0x028A8E:
		rts
;-------------------------------------------------------------------------------
Offset_0x028A90:
		move.w	Obj_Control_Var_12(A0), D1				 ; $0042
		bmi.s	Offset_0x028AA8
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D1, D0
		cmpi.w	#$00E0, D0
		bne.s	Offset_0x028AA6
		neg.w	Obj_Control_Var_12(A0)					 ; $0042
Offset_0x028AA6:
		bra.s	Offset_0x028AB4
Offset_0x028AA8:
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D1, D0
		bne.s	Offset_0x028AB4
		neg.w	Obj_Control_Var_12(A0)					 ; $0042
Offset_0x028AB4:
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		subi.w	#$0070, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x028AC6
		neg.w	D0
Offset_0x028AC6:
		add.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x028AD0:
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x028AE4
		neg.w	D0
		addi.w	#$0080, D0
Offset_0x028AE4:
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x028AEE:
		move.b	(A2), D0
		bne.s	Offset_0x028B32
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x028B30
		move.b	#$00, $0001(A2)
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bpl.s	Offset_0x028B10
		neg.w	D0
		move.b	#$80, $0001(A2)
Offset_0x028B10:
		move.b	D0, $0002(A2)
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$01, (A2)
Offset_0x028B30:
		rts
Offset_0x028B32:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.w	Offset_0x028BF6
		tst.b	$0002(A2)
		beq.s	Offset_0x028B44
		subq.b	#$01, $0002(A2)
Offset_0x028B44:
		moveq	#$00, D0
		move.b	$0001(A2), D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		addi.w	#$0100, D0
		asr.w	#$02, D0
		move.b	D0, $0003(A2)
		moveq	#$00, D2
		move.w	$0002(A2), D2
		muls.w	D2, D1
		swap	D1
		add.w	Obj_X(A0), D1					 ; $0010
		move.w	D1, Obj_X(A1)					 ; $0010
		addq.b	#$02, $0001(A2)
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		move.b	Obj_Control_Var_05(A0), D0				 ; $0035
		cmp.b	$0003(A2), D0
		bls.s	Offset_0x028B86
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
Offset_0x028B86:
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		bpl.s	Offset_0x028B94
		neg.w	D0
Offset_0x028B94:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x028BA8
		cmpi.w	#$0480, D0
		bcs.s	Offset_0x028BA8
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
Offset_0x028BA8:
		andi.b	#$70, D5
		beq.s	Offset_0x028BFA
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$01, Obj_Control_Var_10(A1)			 ; $0040
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
		addi.w	#$F980, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$00, Obj_Timer(A1)				 ; $002E
Offset_0x028BF6:
		move.b	#$00, (A2)
Offset_0x028BFA:
		rts
;-------------------------------------------------------------------------------
Spinning_Column_Mappings:					   ; Offset_0x028BFC
		dc.w	Offset_0x028C02-Spinning_Column_Mappings
		dc.w	Offset_0x028C22-Spinning_Column_Mappings
		dc.w	Offset_0x028C42-Spinning_Column_Mappings
Offset_0x028C02:
		dc.w	$0005
		dc.w	$E00C, $2010, $FFF0
		dc.w	$E80D, $0000, $FFF0
		dc.w	$F80D, $0000, $FFF0
		dc.w	$080D, $0000, $FFF0
		dc.w	$180C, $2018, $FFF0
Offset_0x028C22:
		dc.w	$0005
		dc.w	$E00C, $2014, $FFF0
		dc.w	$E80D, $0008, $FFF0
		dc.w	$F80D, $0008, $FFF0
		dc.w	$080D, $0008, $FFF0
		dc.w	$180C, $201C, $FFF0
Offset_0x028C42:
		dc.w	$0005
		dc.w	$E00C, $2810, $FFF0
		dc.w	$E80D, $0800, $FFF0
		dc.w	$F80D, $0800, $FFF0
		dc.w	$080D, $0800, $FFF0
		dc.w	$180C, $2818, $FFF0
;===============================================================================
; Objeto 0x68 - Coluna azul giratória na Hidrocity
; <<<-
;===============================================================================