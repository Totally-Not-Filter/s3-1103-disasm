;===============================================================================
; Objeto 0x48 - Tubos de propulsão na Carnival Night
; ->>>
;===============================================================================
; Offset_0x028278:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x02828E
		add.b	D0, D0
		move.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.l	#Offset_0x02833C, (A0)
		bra.w	Offset_0x02833C
Offset_0x02828E:
		move.l	#Offset_0x028294, (A0)
Offset_0x028294:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x0282AA
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x0282AA
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x0282AA:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x0282BC
		neg.w	D0
Offset_0x0282BC:
		addi.w	#$0050, D0
		cmpi.w	#$00A0, D0
		bcc.s	Offset_0x02833A
		move.w	Obj_Y(A1), D1					 ; $0014
		addi.w	#$0020, D1
		sub.w	Obj_Y(A0), D1					 ; $0014
		bcs.s	Offset_0x02833A
		cmpi.w	#$0040, D1
		bcc.s	Offset_0x02833A
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x02833A
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x02833A
		subi.w	#$0050, D0
		bcc.s	Offset_0x02830A
		not.w	D0
		move.w	#$1000, Obj_Inertia(A1)					 ; $001C
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028302
		neg.w	Obj_Inertia(A1)					 ; $001C
Offset_0x028302:
		move.w	Obj_Inertia(A1), Obj_Speed_X(A1)		  ; $001C, $0018
		rts
Offset_0x02830A:
		add.w	D0, D0
		addi.w	#$0060, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02831A
		neg.w	D0
Offset_0x02831A:
		neg.b	D0
		asr.w	#$04, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		bne.s	Offset_0x028330
		moveq	#Tunnel_Booster_Sfx, D0					  ; -$7E
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x028330:
		addq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		andi.w	#$001F, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x02833A:
		rts
Offset_0x02833C:
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x028358
		addq.w	#$01, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x028358
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x028358:
		move.b	(A2), D0
		bne.w	Offset_0x0283DA
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0018, D0
		cmpi.w	#$0030, D0
		bcc.s	Offset_0x0283D8
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0030, D1
		cmpi.w	#$0050, D1
		bcc.s	Offset_0x0283D8
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x0283D8
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x0283D8
		subi.w	#$0050, D1
		neg.w	D1
		cmpi.w	#$0040, D1
		bcs.s	Offset_0x0283B2
		move.b	#$01, (A2)
		move.b	Obj_Control_Var_04(A0), $0002(A2)		 ; $0034
		move.w	D0, -(A7)
		moveq	#Transporter_Sfx, D0					  ; -$7F
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	(A7)+, D0
Offset_0x0283B2:
		asr.w	#$03, D1
		sub.w	D1, Obj_Y(A1)					 ; $0014
		moveq	#$01, D2
		cmpi.w	#$0018, D0
		beq.s	Offset_0x0283C8
		bcs.s	Offset_0x0283C4
		neg.w	D2
Offset_0x0283C4:
		add.w	D2, Obj_X(A1)					 ; $0010
Offset_0x0283C8:
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$0F, Obj_Ani_Number(A1)				 ; $0020
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
Offset_0x0283D8:
		rts
Offset_0x0283DA:
		subq.b	#$01, D0
		bne.s	Offset_0x02841E
		subq.b	#$01, $0002(A2)
		beq.s	Offset_0x028412
		subi.w	#$0008, Obj_Y(A1)				 ; $0014
		moveq	#$01, D2
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		beq.s	Offset_0x0283FE
		bcs.s	Offset_0x0283FA
		neg.w	D2
Offset_0x0283FA:
		add.w	D2, Obj_X(A1)					 ; $0010
Offset_0x0283FE:
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		rts
Offset_0x028412:
		move.w	#$F800, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$00, (A2)
		rts
Offset_0x02841E:
		rts
;===============================================================================
; Objeto 0x48 - Tubos de propulsão na Carnival Night
; <<<-
;===============================================================================