;===============================================================================
; Objeto 0x3C - Porta automática
; ->>>
;===============================================================================
Offset_0x026EC8:
		dc.b	$10, $20
		dc.w	$43D4
		dc.b	$08, $20
		dc.w	$4416
;-------------------------------------------------------------------------------
Obj_0x3C_Automatic_Door:					   ; Offset_0x026ED0
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bmi.w	Offset_0x027032
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		add.w	D0, D0
		lea		Offset_0x026EC8(PC, D0), A1
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.w	(A1)+, Obj_Art_VRAM(A0)					 ; $000A
		move.l	#Automatic_Door_Mappings, Obj_Map(A0) ; Offset_0x027002, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	D2, D3
		subi.w	#$0200, D2
		addi.w	#$0018, D3
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x026F2A
		subi.w	#$FE18, D2
		addi.w	#$01E8, D3
Offset_0x026F2A:
		move.w	D2, Obj_Control_Var_04(A0)				 ; $0034
		move.w	D3, Obj_Control_Var_06(A0)				 ; $0036
		move.l	#Offset_0x026F38, (A0)
Offset_0x026F38:
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x026F54
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
		move.w	Obj_X(A0), D3					 ; $0010
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x026F66
		move.w	Obj_Control_Var_06(A0), D3				 ; $0036
		bra.s	Offset_0x026F66
Offset_0x026F54:
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Control_Var_06(A0), D3				 ; $0036
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x026F66
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
Offset_0x026F66:
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		move.w	D4, D5
		subi.w	#$0020, D4
		addi.w	#$0020, D5
		move.b	#$00, Obj_Control_Var_08(A0)			 ; $0038
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x026FD4
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x026FD4
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x026F9A
		cmpi.w	#$0040, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x026FB0
		addq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x026FA4
Offset_0x026F9A:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x026FB0
		subq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x026FA4:
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		sub.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x026FB0:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x026FD4:
		move.w	Obj_X(A1), D0					 ; $0010
		cmp.w	D2, D0
		blt.w	Offset_0x027000
		cmp.w	D3, D0
		bcc.w	Offset_0x027000
		move.w	Obj_Y(A1), D0					 ; $0014
		cmp.w	D4, D0
		bcs.w	Offset_0x027000
		cmp.w	D5, D0
		bcc.w	Offset_0x027000
		tst.b	Obj_Timer(A1)					 ; $002E
		bmi.s	Offset_0x027000
		move.b	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x027000:
		rts
;-------------------------------------------------------------------------------
Automatic_Door_Mappings:					   ; Offset_0x027002
		dc.w	Offset_0x027006-Automatic_Door_Mappings
		dc.w	Offset_0x027014-Automatic_Door_Mappings
Offset_0x027006:
		dc.w	$0002
		dc.w	$E00F, $0000, $FFF0
		dc.w	$000F, $0000, $FFF0
Offset_0x027014:
		dc.w	$0004
		dc.w	$E005, $0000, $FFF8
		dc.w	$F005, $0000, $FFF8
		dc.w	$0005, $0000, $FFF8
		dc.w	$1005, $0000, $FFF8
;-------------------------------------------------------------------------------
Offset_0x02702E:
		dc.b	$20, $08
		dc.w	$4416
;-------------------------------------------------------------------------------
Offset_0x027032:
		andi.w	#$007F, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		add.w	D0, D0
		lea		Offset_0x02702E(PC, D0), A1
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.w	(A1)+, Obj_Art_VRAM(A0)					 ; $000A
		move.l	#Automatic_Door_Horizontal_Mappings, Obj_Map(A0) ; Offset_0x027168, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_02(A0)		  ; $0010, $0032
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		subi.w	#$0100, D2
		addi.w	#$0018, D3
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x027086
		subi.w	#$FF18, D2
		addi.w	#$00E8, D3
Offset_0x027086:
		move.w	D2, Obj_Control_Var_04(A0)				 ; $0034
		move.w	D3, Obj_Control_Var_06(A0)				 ; $0036
		move.l	#Offset_0x027094, (A0)
Offset_0x027094:
		btst	#$01, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x0270B0
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
		move.w	Obj_Y(A0), D3					 ; $0014
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x0270C2
		move.w	Obj_Control_Var_06(A0), D3				 ; $0036
		bra.s	Offset_0x0270C2
Offset_0x0270B0:
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	Obj_Control_Var_06(A0), D3				 ; $0036
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x0270C2
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
Offset_0x0270C2:
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		move.w	D4, D5
		subi.w	#$0020, D4
		addi.w	#$0020, D5
		move.b	#$00, Obj_Control_Var_08(A0)			 ; $0038
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x02713A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x02713A
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x0270F6
		cmpi.w	#$0040, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x027116
		addq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x027100
Offset_0x0270F6:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x027116
		subq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x027100:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02710E
		neg.w	D0
Offset_0x02710E:
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
Offset_0x027116:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02713A:
		move.w	Obj_Y(A1), D0					 ; $0014
		cmp.w	D2, D0
		blt.w	Offset_0x027166
		cmp.w	D3, D0
		bcc.w	Offset_0x027166
		move.w	Obj_X(A1), D0					 ; $0010
		cmp.w	D4, D0
		bcs.w	Offset_0x027166
		cmp.w	D5, D0
		bcc.w	Offset_0x027166
		tst.b	Obj_Timer(A1)					 ; $002E
		bmi.s	Offset_0x027166
		move.b	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x027166:
		rts
;-------------------------------------------------------------------------------
Automatic_Door_Horizontal_Mappings:					   ; Offset_0x027168
		dc.w	Offset_0x02716A-Automatic_Door_Horizontal_Mappings
Offset_0x02716A:
		dc.w	$0004
		dc.w	$F805, $0000, $FFE0
		dc.w	$F805, $0000, $FFF0
		dc.w	$F805, $0000, $0000
		dc.w	$F805, $0000, $0010
;===============================================================================
; Objeto 0x3C - Porta automática
; <<<-
;===============================================================================