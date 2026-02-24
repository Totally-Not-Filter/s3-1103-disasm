;===============================================================================
; Objeto 0x50 - Poste vertical que faz o jogador girar no Loop da Marble Garden
; ->>>
;===============================================================================
; Offset_0x029F86:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$04, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.l	#Offset_0x029F98, (A0)
Offset_0x029F98:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		bsr.s	Offset_0x029FC4
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
; Offset_0x029FAE:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_06(A0), A2				 ; $0036
		addq.b	#$01, D6
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		bsr.s	Offset_0x029FC4
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x029FC4:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x02A09C
		tst.b	Obj_Flags(A2)					 ; $0004
		beq.s	Offset_0x029FFE
		subq.b	#$01, Obj_Flags(A2)				 ; $0004
		bne.s	Offset_0x029FDE
		bclr	#$00, Obj_Player_Control(A1)			 ; $002E
Offset_0x029FDE:
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		addi.w	#$0038, Obj_Speed_Y(A1)					 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Y(A1)					 ; $0014
		rts
Offset_0x029FFE:
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		addi.w	#$0024, D1
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		add.w	D1, D1
		cmp.w	D1, D0
		bcc.w	Offset_0x02A09A
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x02A09A
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x02A09A
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x02A09A
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02A09A
		move.b	Obj_Angle(A1), D0				 ; $0026
		andi.b	#$7F, D0
		cmpi.w	#$0040, D0
		bne.s	Offset_0x02A09A
		move.l	Obj_Y(A1), (A2)					 ; $0014
		move.w	(A2), D0
		sub.w	Obj_Y(A0), D0					 ; $0014
		move.w	D0, (A2)
		bsr.w	Offset_0x029F2E
		move.b	#$C0, Obj_Angle(A1)				 ; $0026
		bclr	#$00, Obj_Flags(A1)				 ; $0004
		move.b	#$80, Obj_Routine(A2)					 ; $0005
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x02A088
		move.b	#$40, Obj_Angle(A1)				 ; $0026
		bset	#$00, Obj_Flags(A1)				 ; $0004
		move.b	#$00, Obj_Routine(A2)					 ; $0005
Offset_0x02A088:
		bset	#$01, Obj_Flags(A1)				 ; $0004
		bset	#$06, Obj_Player_Control(A1)			 ; $002E
		bset	#$01, Obj_Player_Control(A1)			 ; $002E
Offset_0x02A09A:
		rts
Offset_0x02A09C:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x02A148
		andi.w	#$0070, D5
		beq.s	Offset_0x02A0EA
		move.b	#$08, Obj_Flags(A2)				 ; $0004
		bset	#$00, Obj_Player_Control(A1)			 ; $002E
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Player_Jump(A1)				 ; $0040
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$00, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x02A148
		neg.w	Obj_Speed_X(A1)					 ; $0018
		bclr	#$00, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x02A148
Offset_0x02A0EA:
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x02A100
		neg.w	D0
		cmpi.w	#$0400, D0
		bcc.s	Offset_0x02A10C
		move.w	#$FC00, Obj_Inertia(A1)					 ; $001C
		bra.s	Offset_0x02A10C
Offset_0x02A100:
		cmpi.w	#$0400, D0
		bcc.s	Offset_0x02A10C
		move.w	#$0400, Obj_Inertia(A1)					 ; $001C
Offset_0x02A10C:
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcs.s	Offset_0x02A18C
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x02A136
		neg.w	D0
		cmpi.w	#$1000, D0
		bcs.s	Offset_0x02A148
		move.w	#$F000, Obj_Inertia(A1)					 ; $001C
		move.w	#$1000, Obj_Speed_Y(A1)					 ; $001A
		bra.s	Offset_0x02A148
Offset_0x02A136:
		cmpi.w	#$1000, D0
		bcs.s	Offset_0x02A148
		move.w	#$1000, Obj_Inertia(A1)					 ; $001C
		move.w	#$1000, Obj_Speed_Y(A1)					 ; $001A
Offset_0x02A148:
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A156
		addi.b	#$80, Obj_Angle(A1)				 ; $0026
Offset_0x02A156:
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		bclr	#$06, Obj_Player_Control(A1)			 ; $002E
		bclr	#$01, Obj_Player_Control(A1)			 ; $002E
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		rts
Offset_0x02A18C:
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		lsl.l	#$06, D0
		move.l	D0, D1
		add.l	D0, D0
		add.l	D1, D0
		add.l	D0, (A2)
		moveq	#$00, D0
		moveq	#$00, D2
		move.w	(A2), D0
		mulu.w	#$0155, D0
		lsr.l	#$08, D0
		move.w	D0, D2
		add.b	Obj_Routine(A2), D0				 ; $0005
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D3
		asr.w	#$03, D1
		add.w	Obj_X(A0), D1					 ; $0010
		moveq	#$00, D0
		move.b	Obj_Height_2(A1), D0					 ; $001E
		muls.w	D3, D0
		asr.w	#$08, D0
		add.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		move.w	(A2), D0
		add.w	Obj_Y(A0), D0					 ; $0014
		move.w	D0, Obj_Y(A1)					 ; $0014
		moveq	#$00, D0
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#$80, D2
		bcc.s	Offset_0x02A1EA
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x02A1EA:
		subi.b	#$40, D2
		neg.b	D2
		andi.w	#$00FF, D2
		divu.w	#$000B, D2
		move.b	Offset_0x02A20C(PC, D2), Obj_Map_Id(A1)			 ; $0022
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		jmp		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
;-------------------------------------------------------------------------------
; Offset_0x02A20A:
		rts
;-------------------------------------------------------------------------------
Offset_0x02A20C:
		dc.b	$E3, $E3, $E4, $E4, $D9, $D9, $DA, $DA
		dc.b	$DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE
		dc.b	$DF, $DF, $E0, $E0, $E1, $E1, $E2, $E2
;===============================================================================
; Objeto 0x50 - Poste vertical que faz o jogador girar no Loop da Marble Garden
; <<<-
;===============================================================================