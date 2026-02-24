;===============================================================================
; Objeto 0x4F - Atributos da Lama na Marble Garden / Areia movediça na Azure Lake
; ->>>
;===============================================================================
; Offset_0x028E12:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		move.b	D0, Obj_Width(A0)				 ; $0007
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.b	#$30, Obj_Control_Var_08(A0)			 ; $0038
		move.b	#$30, Obj_Control_Var_0A(A0)			 ; $003A
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.l	#Offset_0x028F26, (A0)
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		bne.w	Offset_0x028F26
		move.l	#Offset_0x028E48, (A0)
Offset_0x028E48:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x028EFC
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$03, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028E84
		cmpi.b	#$30, Obj_Control_Var_08(A0)			 ; $0038
		bcc.s	Offset_0x028E68
		addq.b	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x028E68:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x028E8E
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x028E48, (A2)
		bne.s	Offset_0x028E8E
		move.b	Obj_Control_Var_08(A2), Obj_Control_Var_08(A0) ; $0038, $0038
		bra.s	Offset_0x028E8E
Offset_0x028E84:
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x028F02
		subq.b	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x028E8E:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Control_Var_08(A0), D3				 ; $0038
		moveq	#$03, D6
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object_A1).l		   ; Offset_0x013B0C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		btst	#$04, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028EDA
		cmpi.b	#$30, Obj_Control_Var_0A(A0)			 ; $003A
		bcc.s	Offset_0x028EBE
		addq.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028EBE:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x028EE4
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x028E48, (A2)
		bne.s	Offset_0x028EE4
		move.b	Obj_Control_Var_0A(A2), Obj_Control_Var_0A(A0) ; $003A, $003A
		bra.s	Offset_0x028EE4
Offset_0x028EDA:
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x028F0A
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028EE4:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Control_Var_0A(A0), D3				 ; $003A
		moveq	#$04, D6
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object_A1).l		   ; Offset_0x013B0C
Offset_0x028EFC:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x028F02:
		move.b	#$30, Obj_Control_Var_08(A0)			 ; $0038
		bra.s	Offset_0x028F10
Offset_0x028F0A:
		move.b	#$30, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028F10:
		not.b	D1
		and.b	D1, Obj_Status(A0)				 ; $002A
		move.l	A0, -(A7)
		move.l	A0, A2
		move.l	A1, A0
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
		move.l	(A7)+, A0
		rts
Offset_0x028F26:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x028FDE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$03, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028F62
		cmpi.b	#$30, Obj_Control_Var_08(A0)			 ; $0038
		bcc.s	Offset_0x028F46
		addq.b	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x028F46:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x028F6C
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x028E48, (A2)
		bne.s	Offset_0x028F6C
		move.b	Obj_Control_Var_08(A2), Obj_Control_Var_08(A0) ; $0038, $0038
		bra.s	Offset_0x028F6C
Offset_0x028F62:
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x028FE0
		subq.b	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x028F6C:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Control_Var_08(A0), D3				 ; $0038
		lsr.w	#$01, D3
		moveq	#$03, D6
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object_A1).l		   ; Offset_0x013B0C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		btst	#$04, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028FBA
		cmpi.b	#$30, Obj_Control_Var_0A(A0)			 ; $003A
		bcc.s	Offset_0x028F9E
		addq.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028F9E:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x028FC4
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x028E48, (A2)
		bne.s	Offset_0x028FC4
		move.b	Obj_Control_Var_0A(A2), Obj_Control_Var_0A(A0) ; $003A, $003A
		bra.s	Offset_0x028FC4
Offset_0x028FBA:
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x028FE8
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028FC4:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Control_Var_0A(A0), D3				 ; $003A
		lsr.w	#$01, D3
		moveq	#$04, D6
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object_A1).l		   ; Offset_0x013B0C
Offset_0x028FDE:
		rts
Offset_0x028FE0:
		move.b	#$30, Obj_Control_Var_08(A0)			 ; $0038
		bra.s	Offset_0x028FEE
Offset_0x028FE8:
		move.b	#$30, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x028FEE:
		not.b	D1
		and.b	D1, Obj_Status(A0)				 ; $002A
		move.l	A0, -(A7)
		move.l	A0, A2
		move.l	A1, A0
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
		move.l	(A7)+, A0
		rts
;===============================================================================
; Objeto 0x4F - Atributos da Lama na Marble Garden / Areia movediça na Azure Lake
; <<<-
;===============================================================================