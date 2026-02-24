;===============================================================================
; Objeto 0x4E - Malha giratória vertical na Carnival Night
; ->>>
;===============================================================================
; Offset_0x029B5E:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		moveq	#$01, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x029B7C
		neg.w	D1
Offset_0x029B7C:
		move.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.l	#Offset_0x029B86, (A0)
Offset_0x029B86:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		bsr.s	Offset_0x029BF2
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$3F, D0
		bne.s	Offset_0x029BD6
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$0040, D0
		cmpi.w	#$01C0, D0
		bcc.s	Offset_0x029BD6
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		addi.w	#$0040, D0
		move.w	Obj_Control_Var_0A(A0), D1				 ; $003A
		addi.w	#$0080, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x029BD6
		moveq	#Wave_Hover_Sfx, D0				  ; -$7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x029BD6:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
; Offset_0x029BDC:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_04(A0), A2				 ; $0034
		addq.b	#$01, D6
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		bsr.s	Offset_0x029BF2
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x029BF2:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x029CA0
		tst.b	$0001(A2)
		beq.s	Offset_0x029C06
		subq.b	#$01, $0001(A2)
		rts
Offset_0x029C06:
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		addi.w	#$0044, D1
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		add.w	D1, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x029C9E
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcc.s	Offset_0x029C9E
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x029C9E
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x029C9E
		subi.w	#$0010, D0
		bcc.s	Offset_0x029C48
		sub.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x029C48:
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x029C5E
		move.b	#$01, $0001(A2)
		bset	#$00, Obj_Timer(A1)				 ; $002E
Offset_0x029C5E:
		bsr.w	Offset_0x029F2E
		move.b	#$80, (A2)
		move.b	#$C0, Obj_Angle(A1)				 ; $0026
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x029C80
		move.b	#$40, Obj_Angle(A1)				 ; $0026
		move.b	#$00, (A2)
Offset_0x029C80:
		bclr	#$00, Obj_Status(A1)					 ; $002A
		bclr	#$00, Obj_Flags(A1)				 ; $0004
		bclr	#$01, Obj_Flags(A1)				 ; $0004
		bset	#$06, Obj_Timer(A1)				 ; $002E
		bset	#$01, Obj_Timer(A1)				 ; $002E
Offset_0x029C9E:
		rts
Offset_0x029CA0:
		tst.b	$0001(A2)
		bne.w	Offset_0x029DDE
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x029D0E
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x029CB6
		neg.w	D0
Offset_0x029CB6:
		cmpi.w	#$0300, D0
		bcc.s	Offset_0x029CCC
		move.b	#$01, $0001(A2)
		bset	#$00, Obj_Timer(A1)				 ; $002E
		bra.w	Offset_0x029DDE
Offset_0x029CCC:
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029CFC
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$00, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x029D0E
		neg.w	Obj_Speed_X(A1)					 ; $0018
		bclr	#$00, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x029D0E
Offset_0x029CFC:
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcs.s	Offset_0x029D50
Offset_0x029D0E:
		move.b	#$00, Obj_Angle(A1)				 ; $0026
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		bclr	#$06, Obj_Timer(A1)				 ; $002E
		bclr	#$01, Obj_Timer(A1)				 ; $002E
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, $0001(A2)
		rts
Offset_0x029D50:
		move.w	Obj_Speed_Y(A0), D1				 ; $001A
		bpl.s	Offset_0x029D5C
		cmpi.w	#$0010, D0
		bls.s	Offset_0x029D60
Offset_0x029D5C:
		add.w	D1, Obj_Y(A1)					 ; $0014
Offset_0x029D60:
		subi.w	#$0010, D0
		bcc.s	Offset_0x029D6A
		sub.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x029D6A:
		moveq	#$00, D0
		move.b	(A2), D0
		addq.b	#$04, (A2)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D3
		asr.w	#$02, D1
		add.w	Obj_X(A0), D1					 ; $0010
		moveq	#$00, D0
		move.b	Obj_Height_2(A1), D0					 ; $001E
		muls.w	D3, D0
		asr.w	#$08, D0
		add.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		moveq	#$00, D0
		move.b	(A2), D0
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#$80, D0
		bcs.s	Offset_0x029DA4
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x029DA4:
		addi.b	#$40, D0
		neg.b	D0
		andi.w	#$00FF, D0
		divu.w	#$000B, D0
		move.b	Offset_0x029DC6(PC, D0), Obj_Map_Id(A1)			 ; $0022
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		jmp		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
;-------------------------------------------------------------------------------
; Offset_0x029DC4:
		rts
;-------------------------------------------------------------------------------
Offset_0x029DC6:
		dc.b	$E3, $E3, $E4, $E4, $D9, $D9, $DA, $DA
		dc.b	$DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE
		dc.b	$DF, $DF, $E0, $E0, $E1, $E1, $E2, $E2
;-------------------------------------------------------------------------------
Offset_0x029DDE:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x029E62
		andi.w	#$0070, D5
		beq.s	Offset_0x029E1E
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$00, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x029E62
		neg.w	Obj_Speed_X(A1)					 ; $0018
		bclr	#$00, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x029E62
Offset_0x029E1E:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x029E62
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcs.s	Offset_0x029EAA
		bne.s	Offset_0x029E62
		move.b	(A2), D0
		andi.b	#$7F, D0
		bne.s	Offset_0x029EBA
		move.w	#$FF00, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		tst.b	(A2)
		bmi.s	Offset_0x029E56
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x029E56:
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x029E62:
		move.b	#$00, Obj_Angle(A1)				 ; $0026
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		bclr	#$06, Obj_Timer(A1)				 ; $002E
		bclr	#$01, Obj_Timer(A1)				 ; $002E
		bclr	#$00, Obj_Timer(A1)				 ; $002E
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, $0001(A2)
		rts
Offset_0x029EAA:
		move.w	Obj_Speed_Y(A0), D1				 ; $001A
		bpl.s	Offset_0x029EB6
		cmpi.w	#$0010, D0
		bls.s	Offset_0x029EBA
Offset_0x029EB6:
		add.w	D1, Obj_Y(A1)					 ; $0014
Offset_0x029EBA:
		moveq	#$00, D0
		move.b	(A2), D0
		addq.b	#$04, (A2)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D3
		asr.w	#$02, D1
		add.w	Obj_X(A0), D1					 ; $0010
		moveq	#$00, D0
		move.b	Obj_Height_2(A1), D0					 ; $001E
		muls.w	D3, D0
		asr.w	#$08, D0
		add.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		moveq	#$00, D0
		move.b	(A2), D0
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#$80, D0
		bcs.s	Offset_0x029EF4
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x029EF4:
		addi.b	#$40, D0
		neg.b	D0
		andi.w	#$00FF, D0
		divu.w	#$000B, D0
		move.b	Offset_0x029F16(PC, D0), Obj_Map_Id(A1)			 ; $0022
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		jmp		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
;-------------------------------------------------------------------------------
; Offset_0x029F14:
		rts
;-------------------------------------------------------------------------------
Offset_0x029F16:
		dc.b	$E3, $E3, $E4, $E4, $D9, $D9, $DA, $DA
		dc.b	$DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE
		dc.b	$DF, $DF, $E0, $E0, $E1, $E1, $E2, $E2
;-------------------------------------------------------------------------------
Offset_0x029F2E:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029F3E
		move.w	Obj_Player_Last(A1), A3					 ; $0042
		bclr	D6, Obj_Status(A3)				 ; $002A
Offset_0x029F3E:
		move.w	A0, Obj_Player_Last(A1)					 ; $0042
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029F74
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.l	A0, -(A7)
		move.l	A1, A0
		move.w	A0, D1
		subi.w	#Obj_Player_One, D1				 ; $B000
		bne.s	Offset_0x029F6C
		cmpi.w	#Miles_Alone, (Player_Selected_Flag).w	; $0002, $FFFFFF08
		beq.s	Offset_0x029F6C
		jsr		(Sonic_ResetOnFloor).l		   ; Offset_0x00BF76
		bra.s	Offset_0x029F72
Offset_0x029F6C:
		jsr		(Miles_ResetOnFloor).l		   ; Offset_0x00E7EE
Offset_0x029F72:
		move.l	(A7)+, A0
Offset_0x029F74:
		bset	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$01, Obj_Status(A1)					 ; $002A
		bset	D6, Obj_Status(A0)				 ; $002A
		rts
;===============================================================================
; Objeto 0x4E - Malha giratória vertical na Carnival Night
; <<<-
;===============================================================================