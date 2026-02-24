;===============================================================================
; Objeto 0x4C - Espiral na Carnival Night
; ->>>
;===============================================================================
; Offset_0x029408:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_00(A0), A4				 ; $0030
		bsr.s	Offset_0x02942E
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_0A(A0), A4				 ; $003A
		bsr.s	Offset_0x02942E
		move.b	Obj_Control_Var_00(A0), D0				 ; $0030
		add.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		beq.s	Offset_0x029428
		rts
Offset_0x029428:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x02942E:
		moveq	#$00, D0
		move.b	(A4), D0
		move.w	Offset_0x02943A(PC, D0), D0
		jmp		Offset_0x02943A(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x02943A:
		dc.w	Offset_0x029442-Offset_0x02943A
		dc.w	Offset_0x0294CE-Offset_0x02943A
		dc.w	Offset_0x02950A-Offset_0x02943A
		dc.w	Offset_0x02954E-Offset_0x02943A
;-------------------------------------------------------------------------------
Offset_0x029442:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x0294CC
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0040, D0
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x0294CC
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0010, D1
		cmpi.w	#$0020, D1
		bcc.s	Offset_0x0294CC
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x0294CC
		addq.b	#$02, (A4)
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	$0001(A4)
		moveq	#$30, D1
		cmpi.w	#$0040, D0
		bcc.s	Offset_0x0294B4
		neg.w	D1
		move.b	#$80, $0001(A4)
Offset_0x0294B4:
		add.w	Obj_X(A0), D1					 ; $0010
		move.w	D1, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x0294CC:
		rts
;-------------------------------------------------------------------------------
Offset_0x0294CE:
		move.b	$0001(A4), D0
		addq.b	#$08, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$03, D1
		move.w	D1, D0
		asr.w	#$01, D1
		add.w	D1, D0
		add.w	Obj_X(A0), D0					 ; $0010
		move.w	D0, Obj_X(A1)					 ; $0010
		moveq	#$00, D0
		btst	#$00, (Ring_count+$01).w			 ; $FFFFFE21
		beq.s	Offset_0x0294FA
		move.w	#$0080, D0
Offset_0x0294FA:
		cmp.b	$0001(A4), D0
		bne.s	Offset_0x029508
		addq.b	#$02, (A4)
		move.w	#$00C0, $0002(A4)
Offset_0x029508:
		rts
;-------------------------------------------------------------------------------
Offset_0x02950A:
		move.b	$0001(A4), D0
		addi.b	#$0C, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$03, D1
		move.w	D1, D0
		asr.w	#$01, D1
		add.w	D1, D0
		add.w	Obj_X(A0), D0					 ; $0010
		move.w	D0, Obj_X(A1)					 ; $0010
		addq.w	#$02, Obj_Y(A1)					 ; $0014
		subq.w	#$01, $0002(A4)
		bne.s	Offset_0x02954C
		moveq	#$00, D0
		move.w	Obj_X(A0), D1					 ; $0010
		sub.w	Obj_X(A1), D1					 ; $0010
		bcc.s	Offset_0x029542
		moveq	#$01, D0
Offset_0x029542:
		add.b	Obj_Subtype(A0), D0				 ; $002C
		bsr.w	Offset_0x0295B2
		addq.b	#$02, (A4)
Offset_0x02954C:
		rts
;-------------------------------------------------------------------------------
Offset_0x02954E:
		subq.b	#$01, $0002(A4)
		bpl.s	Offset_0x02957A
		move.l	$0006(A4), A2
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
		move.l	A2, $0006(A4)
		subq.w	#$04, $0004(A4)
		beq.s	Offset_0x0295A0
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	#$0C00, D2
		bra.w	Offset_0x0295E2
Offset_0x02957A:
		move.l	Obj_X(A1), D2					 ; $0010
		move.l	Obj_Y(A1), D3					 ; $0014
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D2
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D3
		move.l	D2, Obj_X(A1)					 ; $0010
		move.l	D3, Obj_Y(A1)					 ; $0014
		rts
Offset_0x0295A0:
		andi.w	#$0FFF, Obj_Y(A1)				 ; $0014
		clr.b	(A4)
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		bra.s	Offset_0x02957A
Offset_0x0295B2:
		andi.w	#$000F, D0
		add.w	D0, D0
		lea		(Offset_0x029660).l, A2
		adda.w	(A2, D0), A2
		move.w	(A2)+, $0004(A4)
		subq.w	#$04, $0004(A4)
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
		move.l	A2, $0006(A4)
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	#$0C00, D2
Offset_0x0295E2:
		moveq	#$00, D0
		move.w	D2, D3
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		bge.s	Offset_0x0295F2
		neg.w	D0
		neg.w	D2
Offset_0x0295F2:
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		bge.s	Offset_0x029600
		neg.w	D1
		neg.w	D3
Offset_0x029600:
		cmp.w	D0, D1
		bcs.s	Offset_0x029632
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		swap	D1
		divs.w	D3, D1
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		beq.s	Offset_0x02961E
		swap	D0
		divs.w	D1, D0
Offset_0x02961E:
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		move.w	D3, Obj_Speed_Y(A1)				 ; $001A
		tst.w	D1
		bpl.s	Offset_0x02962C
		neg.w	D1
Offset_0x02962C:
		move.w	D1, $0002(A4)
		rts
Offset_0x029632:
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		swap	D0
		divs.w	D2, D0
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		beq.s	Offset_0x02964C
		swap	D1
		divs.w	D0, D1
Offset_0x02964C:
		move.w	D1, Obj_Speed_Y(A1)				 ; $001A
		move.w	D2, Obj_Speed_X(A1)				 ; $0018
		tst.w	D0
		bpl.s	Offset_0x02965A
		neg.w	D0
Offset_0x02965A:
		move.w	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x029660:
		dc.w	Offset_0x029668-Offset_0x029660
		dc.w	Offset_0x029676-Offset_0x029660
		dc.w	Offset_0x029684-Offset_0x029660
		dc.w	Offset_0x029692-Offset_0x029660
Offset_0x029668:
		dc.w	$000C
		dc.w	$1390, $02D0, $1230, $02D0, $1230, $0300
Offset_0x029676:
		dc.w	$000C
		dc.w	$13F0, $02D0, $1560, $02D0, $1560, $0280
Offset_0x029684:
		dc.w	$000C
		dc.w	$2090, $0650, $2030, $0650, $2030, $0680
Offset_0x029692:
		dc.w	$000C
		dc.w	$20F0, $0650, $21E0, $0650, $21E0, $0600
;===============================================================================
; Objeto 0x4C - Espiral na Carnival Night
; <<<-
;===============================================================================