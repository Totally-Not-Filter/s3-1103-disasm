;===============================================================================
; Objeto 0x12 - Elevador / Plataforma não usada move para cima/baixo dependendo
; ->>>			de um valor na memória na Lauch Base
;===============================================================================
Offset_0x01C69A:
		dc.b	$10, $18, $20, $38, $40, $68
;-------------------------------------------------------------------------------
Obj_0x12_LBz_Elevator:						   ; Offset_0x01C6A0
		move.l	#LBz_Elevator_Mappings, Obj_Map(A0)	 ; Offset_0x01C868, $000C
		move.w	#$43C3, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$30, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.w	#$8000, Obj_Sub_Y(A0)					 ; $0016
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$04, D0
		andi.w	#$000F, D0
		move.b	Offset_0x01C69A(PC, D0), D0
		lsl.w	#$03, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		sub.w	D0, Obj_Y(A0)					 ; $0014
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C700
		add.w	D0, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x01C700:
		move.l	#Offset_0x01C706, (A0)
Offset_0x01C706:
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	Offset_0x01C73C(PC, D0), D1
		jsr		Offset_0x01C73C(PC, D1)
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01C736
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
Offset_0x01C736:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01C73C:
		dc.w	Offset_0x01C744-Offset_0x01C73C
		dc.w	Offset_0x01C762-Offset_0x01C73C
		dc.w	Offset_0x01C78E-Offset_0x01C73C
		dc.w	Offset_0x01C7AC-Offset_0x01C73C
;-------------------------------------------------------------------------------
Offset_0x01C744:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x01C760
		move.w	#$8000, Obj_Sub_Y(A0)					 ; $0016
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01C760:
		rts
;-------------------------------------------------------------------------------
Offset_0x01C762:
		bsr.w	Offset_0x01C7D8
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bne.s	Offset_0x01C78C
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		sub.w	D0, Obj_Y(A0)					 ; $0014
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01C78C
		add.w	D0, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x01C78C:
		rts
;-------------------------------------------------------------------------------
Offset_0x01C78E:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		bne.s	Offset_0x01C7AA
		move.w	#$8000, Obj_Sub_Y(A0)					 ; $0016
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01C7AA:
		rts
;-------------------------------------------------------------------------------
Offset_0x01C7AC:
		bsr.w	Offset_0x01C7D8
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bne.s	Offset_0x01C7D6
		clr.w	Obj_Control_Var_06(A0)					 ; $0036
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		sub.w	D0, Obj_Y(A0)					 ; $0014
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C7D6
		add.w	D0, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x01C7D6:
		rts
Offset_0x01C7D8:
		move.w	Obj_Y(A0), D2					 ; $0014
		moveq	#$08, D1
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x01C826
		add.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bhi.s	Offset_0x01C866
		beq.s	Offset_0x01C816
		sub.w	D0, D2
		neg.w	D2
		add.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		neg.w	Obj_Sub_Y(A0)					 ; $0016
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x01C866
Offset_0x01C816:
		neg.w	Obj_Sub_Y(A0)					 ; $0016
		add.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x01C866
Offset_0x01C826:
		sub.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x01C866
		beq.s	Offset_0x01C858
		sub.w	D0, D2
		neg.w	D2
		add.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		neg.w	Obj_Sub_Y(A0)					 ; $0016
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x01C866
Offset_0x01C858:
		neg.w	Obj_Sub_Y(A0)					 ; $0016
		sub.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x01C866:
		rts
;-------------------------------------------------------------------------------
LBz_Elevator_Mappings:						   ; Offset_0x01C868
		dc.w	Offset_0x01C86A-LBz_Elevator_Mappings
Offset_0x01C86A:
		dc.w	$0006
		dc.w	$F80D, $0010, $FFD0
		dc.w	$F805, $0014, $FFF0
		dc.w	$F805, $0014, $0000
		dc.w	$F80D, $0810, $0010
		dc.w	$0805, $0018, $FFF0
		dc.w	$0805, $0818, $0000
;===============================================================================
; Objeto 0x12 - Elevador / Plataforma não usada move para cima/baixo dependendo
; <<<-			de um valor na memória na Lauch Base
;===============================================================================