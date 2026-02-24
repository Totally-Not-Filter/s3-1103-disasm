;===============================================================================
; Objeto 0x15 - Objeto usado para lançar o jogador em alta velocidade na
; ->>>			Launch Base
;===============================================================================
Offset_0x01D04C:
		dc.w	$1000, $0A00
;-------------------------------------------------------------------------------
Obj_0x15_LBz_Player_Launcher:				   ; Offset_0x01D050
		move.l	#Player_Launcher_Mappings, Obj_Map(A0) ; Offset_0x01D2CA, $000C
		move.w	#$43C3, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$0002, D0
		move.w	Offset_0x01D04C(PC, D0), Obj_Control_Var_04(A0)	 ; $0034
		move.l	#Offset_0x01D084, (A0)
Offset_0x01D084:
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	D0, D1
		subi.w	#$0010, D0
		addi.w	#$0010, D1
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		subi.w	#$0010, D2
		addi.w	#$0010, D3
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x01D0D8
		move.w	Obj_X(A1), D4					 ; $0010
		cmp.w	D0, D4
		bcs.w	Offset_0x01D0D8
		cmp.w	D1, D4
		bcc.w	Offset_0x01D0D8
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		bcs.w	Offset_0x01D0D8
		cmp.w	D3, D4
		bcc.w	Offset_0x01D0D8
		move.w	D0, -(A7)
		lea		Obj_Control_Var_08(A0), A2				 ; $0038
		bsr.w	Offset_0x01D112
		move.w	(A7)+, D0
Offset_0x01D0D8:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x01D10C
		move.w	Obj_X(A1), D4					 ; $0010
		cmp.w	D0, D4
		bcs.w	Offset_0x01D10C
		cmp.w	D1, D4
		bcc.w	Offset_0x01D10C
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		bcs.w	Offset_0x01D10C
		cmp.w	D3, D4
		bcc.w	Offset_0x01D10C
		lea		Obj_Control_Var_0A(A0), A2				 ; $003A
		bsr.w	Offset_0x01D112
Offset_0x01D10C:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01D112:
		tst.w	(A2)
		bne.s	Offset_0x01D140
		move.l	A1, -(A7)
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01D13E
		move.l	#Offset_0x01D1BC, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.w	A2, Obj_Control_Var_0C(A1)				 ; $003C
Offset_0x01D13E:
		move.l	(A7)+, A1
Offset_0x01D140:
		addq.w	#$01, (A2)
		cmpi.w	#$0004, (A2)
		beq.s	Offset_0x01D164
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x01D156
		neg.w	D0
Offset_0x01D156:
		tst.w	D0
		bpl.s	Offset_0x01D162
		asr.w	Obj_Inertia(A1)					 ; $001C
		asr.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x01D162:
		rts
Offset_0x01D164:
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01D172
		neg.w	D0
Offset_0x01D172:
		cmpi.w	#$1000, D0
		bge.s	Offset_0x01D1B4
		move.w	Obj_Control_Var_04(A0), Obj_Speed_X(A1)	  ; $0034, $0018
		bclr	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01D196
		bset	#$00, Obj_Status(A1)					 ; $002A
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x01D196:
		move.w	#$000F, Obj_Control_Var_02(A1)			 ; $0032
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
Offset_0x01D1B4:
		moveq	#Spring_Sfx, D0					  ; -$2E
		jmp		(PlaySound).l					; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x01D1BC:
		move.l	#Player_Launcher_Mappings, Obj_Map(A0) ; Offset_0x01D2CA, $000C
		move.w	#$43C3, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		addi.w	#$0010, Obj_Y(A0)				 ; $0014
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.b	#$80, Obj_Control_Var_10(A0)			 ; $0040
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0004, Obj_Sub_Y(A0)					 ; $0016
		move.l	#Offset_0x01D20C, (A0)
Offset_0x01D20C:
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	Offset_0x01D222(PC, D0), D1
		jsr		Offset_0x01D222(PC, D1)
		bsr.w	Offset_0x01D258
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01D222:
		dc.w	Offset_0x01D226-Offset_0x01D222
		dc.w	Offset_0x01D242-Offset_0x01D222
;-------------------------------------------------------------------------------
Offset_0x01D226:
		addi.b	#$10, Obj_Control_Var_10(A0)			 ; $0040
		cmpi.b	#$D0, Obj_Control_Var_10(A0)			 ; $0040
		bne.s	Offset_0x01D240
		move.w	Obj_Control_Var_0C(A0), A2				 ; $003C
		move.w	#$0000, (A2)
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01D240:
		rts
;-------------------------------------------------------------------------------
Offset_0x01D242:
		subi.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		cmpi.b	#$80, Obj_Control_Var_10(A0)			 ; $0040
		bne.s	Offset_0x01D256
		move.w	#$7F00, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x01D256:
		rts
Offset_0x01D258:
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x01D26A
		neg.b	D0
		addi.b	#$80, D0
Offset_0x01D26A:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	Obj_Control_Var_00(A0), D3				 ; $0030
		moveq	#$00, D6
		move.w	Obj_Sub_Y(A0), D6				 ; $0016
		subq.w	#$01, D6
		bcs.s	Offset_0x01D2C8
		swap	D0
		swap	D1
		asr.l	#$04, D0
		asr.l	#$04, D1
		moveq	#$00, D4
		moveq	#$00, D5
		add.l	D0, D4
		add.l	D1, D5
		lea		Obj_Speed_X(A0), A2				 ; $0018
Offset_0x01D296:
		movem.l D4/D5, -(A7)
		swap	D4
		swap	D5
		add.w	D2, D4
		add.w	D3, D5
		move.w	D5, (A2)+
		move.w	D4, (A2)+
		movem.l (A7)+, D4/D5
		add.l	D0, D4
		add.l	D1, D5
		addq.w	#$01, A2
		move.b	#$01, (A2)+
		dbra	D6, Offset_0x01D296
		swap	D4
		swap	D5
		add.w	D2, D4
		add.w	D3, D5
		move.w	D5, Obj_X(A0)					 ; $0010
		move.w	D4, Obj_Y(A0)					 ; $0014
Offset_0x01D2C8:
		rts
;-------------------------------------------------------------------------------
Player_Launcher_Mappings:					   ; Offset_0x01D2CA
		dc.w	Offset_0x01D2CE-Player_Launcher_Mappings
		dc.w	Offset_0x01D2E2-Player_Launcher_Mappings
Offset_0x01D2CE:
		dc.w	$0003
		dc.w	$F805, $0014, $FFE0
		dc.w	$F80D, $0018, $FFF0
		dc.w	$F805, $0814, $0010
Offset_0x01D2E2:
		dc.w	$0001
		dc.w	$F805, $0020, $FFF8
;===============================================================================
; Objeto 0x15 - Objeto usado para lançar o jogador em alta velocidade na
; <<<-			Launch Base
;===============================================================================