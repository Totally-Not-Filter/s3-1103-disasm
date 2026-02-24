;===============================================================================
; Objeto 0x3D - Molas na Flying Battery 2
; ->>>
;===============================================================================
; Offset_0x019EA2:
		bsr.w	Obj07_Springs				; Offset_0x01921A
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$03, D0
		andi.w	#$000E, D0
		move.w	Offset_0x019EB8(PC, D0), D1
		jmp		Offset_0x019EB8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x019EB8:
		dc.w	Offset_0x019EC2-Offset_0x019EB8
		dc.w	Offset_0x019EDE-Offset_0x019EB8
		dc.w	Offset_0x019EFA-Offset_0x019EB8
		dc.w	Offset_0x019F16-Offset_0x019EB8
		dc.w	Offset_0x019F46-Offset_0x019EB8
;-------------------------------------------------------------------------------
Offset_0x019EC2:
		move.l	#Offset_0x019EC8, (A0)
Offset_0x019EC8:
		bsr.w	Offset_0x019F76
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x0193E8
;-------------------------------------------------------------------------------
Offset_0x019EDE:
		move.l	#Offset_0x019EE4, (A0)
Offset_0x019EE4:
		bsr.w	Offset_0x019F76
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		bra.w	Offset_0x019534
;-------------------------------------------------------------------------------
Offset_0x019EFA:
		move.l	#Offset_0x019F00, (A0)
Offset_0x019F00:
		bsr.w	Offset_0x019F76
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x019804
;-------------------------------------------------------------------------------
Offset_0x019F16:
		move.l	#Offset_0x019F1C, (A0)
Offset_0x019F1C:
		bsr.w	Offset_0x019F76
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	D0, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x019F32
		neg.w	D0
Offset_0x019F32:
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x01994E
;-------------------------------------------------------------------------------
Offset_0x019F46:
		move.l	#Offset_0x019F4C, (A0)
Offset_0x019F4C:
		bsr.w	Offset_0x019F76
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	D0, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x019F62
		neg.w	D0
Offset_0x019F62:
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x019A90
Offset_0x019F76:
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x019F92
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.s	Offset_0x019FD4
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x019FD4
		moveq	#Spike_Move_Sfx, D0				   ; $58
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x019FD4
Offset_0x019F92:
		tst.w	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x019FB4
		subi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		bcc.s	Offset_0x019FD4
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0000, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003C, Obj_Control_Var_0A(A0)			 ; $003A
		bra.s	Offset_0x019FD4
Offset_0x019FB4:
		addi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		cmpi.w	#$2000, Obj_Control_Var_06(A0)			 ; $0036
		bcs.s	Offset_0x019FD4
		move.w	#$2000, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0001, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003C, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x019FD4:
		rts
;===============================================================================
; Objeto 0x3D - Molas na Flying Battery 2
; <<<-
;===============================================================================