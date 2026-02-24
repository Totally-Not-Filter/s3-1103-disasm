;===============================================================================
; Objeto 0x4D - Postes diagonais que fazem o jogador girar na Carnival Night
; ->>>
;===============================================================================
; Offset_0x0296A0:
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0296B0
		move.l	#Offset_0x0298DC, (A0)
		bra.w	Offset_0x0298DC
Offset_0x0296B0:
		move.l	#Offset_0x0296B6, (A0)
Offset_0x0296B6:
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		bsr.s	Offset_0x0296D2
		addq.w	#$06, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.b	#$01, D6
		bsr.s	Offset_0x0296D2
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x0296D2:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x0297EA
		btst	#$03, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x029764
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		neg.w	D0
		add.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0040, D0
		cmpi.w	#$00A0, D0
		bcc.s	Offset_0x029762
		subi.w	#$0061, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		add.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		sub.w	D0, D1
		cmpi.w	#$0010, D1
		bcc.s	Offset_0x029762
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x029762
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x029762
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029732
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x029762
Offset_0x029732:
		move.l	Obj_X(A1), (A2)					 ; $0010
		move.w	(A2), D0
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0040, D0
		move.w	D0, (A2)
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		subi.w	#$0018, D0
		cmpi.w	#$0070, D0
		bcc.s	Offset_0x029758
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x029758:
		bsr.w	Offset_0x029B00
		move.b	#$20, Obj_Angle(A1)				 ; $0026
Offset_0x029762:
		rts
Offset_0x029764:
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		neg.w	D0
		add.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0030, D0
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x0297E8
		subi.w	#$0051, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		add.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		sub.w	D0, D1
		cmpi.w	#$0010, D1
		bcc.s	Offset_0x0297E8
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x0297E8
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x0297AC
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x0297E8
Offset_0x0297AC:
		move.w	Obj_Player_Last(A1), A3					 ; $0042
		cmpi.l	#Offset_0x0296B6, (A3)
		bne.s	Offset_0x0297E8
		move.l	Obj_X(A1), (A2)					 ; $0010
		move.w	(A2), D0
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0040, D0
		move.w	D0, (A2)
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		subi.w	#$0020, D0
		cmpi.w	#$0060, D0
		bcc.s	Offset_0x0297DE
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x0297DE:
		bsr.w	Offset_0x029B00
		move.b	#$20, Obj_Angle(A1)				 ; $0026
Offset_0x0297E8:
		rts
Offset_0x0297EA:
		tst.w	Obj_Flags(A2)					 ; $0004
		bne.s	Offset_0x029806
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x0297F8
		neg.w	D0
Offset_0x0297F8:
		cmpi.w	#$0118, D0
		bcc.s	Offset_0x029806
		bset	#$01, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x02982E
Offset_0x029806:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02982E
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		ext.l	D0
		lsl.l	#$06, D0
		move.l	D0, D1
		add.l	D0, D0
		add.l	D1, D0
		add.l	D0, (A2)
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		neg.w	D0
		add.w	(A2), D0
		cmpi.w	#$00A0, D0
		bcs.s	Offset_0x02984C
Offset_0x02982E:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$00, Obj_P_Flips_Remaining(A1)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A1)			 ; $0031
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		rts
Offset_0x02984C:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x0298DA
		move.w	D0, D2
		subi.b	#$10, D0
		bcc.s	Offset_0x029866
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		moveq	#$00, D0
Offset_0x029866:
		cmpi.b	#$80, D0
		bcs.s	Offset_0x029876
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		move.w	#$0080, D0
Offset_0x029876:
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#$34, D0
		bcc.s	Offset_0x029888
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x029888:
		tst.w	Obj_Flags(A2)					 ; $0004
		beq.s	Offset_0x029890
		moveq	#$00, D0
Offset_0x029890:
		add.w	D0, D0
		move.b	D0, Obj_Flip_Angle(A1)					 ; $0027
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D4
		asr.w	#$04, D1
		move.w	D1, D3
		add.w	D2, D1
		add.w	Obj_X(A0), D1					 ; $0010
		subi.w	#$0050, D1
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		muls.w	D4, D0
		asr.w	#$08, D0
		add.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		move.w	D2, D0
		subi.w	#$0051, D0
		move.w	Obj_Y(A0), D2					 ; $0014
		sub.w	D3, D2
		add.w	D0, D2
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		muls.w	D4, D1
		asr.w	#$08, D1
		sub.w	D1, D2
		move.w	D2, Obj_Y(A1)					 ; $0014
Offset_0x0298DA:
		rts
Offset_0x0298DC:
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		bsr.s	Offset_0x0298F8
		addq.w	#$06, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.b	#$01, D6
		bsr.s	Offset_0x0298F8
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x0298F8:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x029A0C
		btst	#$03, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x029988
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		add.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0060, D0
		cmpi.w	#$00A0, D0
		bcc.s	Offset_0x029986
		subi.w	#$003E, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		add.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		add.w	D0, D1
		cmpi.w	#$0010, D1
		bcc.s	Offset_0x029986
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x029986
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x029986
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029956
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x029986
Offset_0x029956:
		move.l	Obj_X(A1), (A2)					 ; $0010
		move.w	(A2), D0
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0060, D0
		move.w	D0, (A2)
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		subi.w	#$0018, D0
		cmpi.w	#$0070, D0
		bcc.s	Offset_0x02997C
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x02997C:
		bsr.w	Offset_0x029B00
		move.b	#$E0, Obj_Angle(A1)				 ; $0026
Offset_0x029986:
		rts
Offset_0x029988:
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		add.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0050, D0
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x029A0A
		subi.w	#$002E, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		add.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		add.w	D0, D1
		cmpi.w	#$0010, D1
		bcc.s	Offset_0x029A0A
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x029A0A
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x0299CE
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x029A0A
Offset_0x0299CE:
		move.w	Obj_Player_Last(A1), A3					 ; $0042
		cmpi.l	#Offset_0x0298DC, (A3)
		bne.s	Offset_0x029A0A
		move.l	Obj_X(A1), (A2)					 ; $0010
		move.w	(A2), D0
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0060, D0
		move.w	D0, (A2)
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		subi.w	#$0020, D0
		cmpi.w	#$0060, D0
		bcc.s	Offset_0x029A00
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x029A00:
		bsr.w	Offset_0x029B00
		move.b	#$E0, Obj_Angle(A1)				 ; $0026
Offset_0x029A0A:
		rts
Offset_0x029A0C:
		tst.w	Obj_Flags(A2)					 ; $0004
		bne.s	Offset_0x029A28
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x029A1A
		neg.w	D0
Offset_0x029A1A:
		cmpi.w	#$0118, D0
		bcc.s	Offset_0x029A28
		bset	#$01, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x029A4E
Offset_0x029A28:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x029A4E
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		ext.l	D0
		lsl.l	#$06, D0
		move.l	D0, D1
		add.l	D0, D0
		add.l	D1, D0
		add.l	D0, (A2)
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		add.w	(A2), D0
		cmpi.w	#$00A0, D0
		bcs.s	Offset_0x029A6C
Offset_0x029A4E:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$00, Obj_P_Flips_Remaining(A1)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A1)			 ; $0031
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		rts
Offset_0x029A6C:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x029AFE
		move.w	D0, D2
		subi.b	#$10, D0
		bcc.s	Offset_0x029A86
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		moveq	#$00, D0
Offset_0x029A86:
		cmpi.b	#$80, D0
		bcs.s	Offset_0x029A96
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		move.w	#$0080, D0
Offset_0x029A96:
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#$4C, D0
		bcs.s	Offset_0x029AA8
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x029AA8:
		tst.w	Obj_Flags(A2)					 ; $0004
		beq.s	Offset_0x029AB0
		moveq	#$00, D0
Offset_0x029AB0:
		neg.b	D0
		add.w	D0, D0
		move.b	D0, Obj_Flip_Angle(A1)					 ; $0027
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D4
		asr.w	#$04, D1
		move.w	D1, D3
		neg.w	D1
		add.w	D2, D1
		add.w	Obj_X(A0), D1					 ; $0010
		subi.w	#$0050, D1
		moveq	#$00, D0
		move.b	Obj_Width_2(A1), D0				 ; $001F
		muls.w	D4, D0
		asr.w	#$08, D0
		sub.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		move.w	D2, D0
		subi.w	#$004E, D0
		move.w	Obj_Y(A0), D2					 ; $0014
		sub.w	D3, D2
		sub.w	D0, D2
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		muls.w	D4, D1
		asr.w	#$08, D1
		sub.w	D1, D2
		move.w	D2, Obj_Y(A1)					 ; $0014
Offset_0x029AFE:
		rts
Offset_0x029B00:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029B10
		move.w	Obj_Player_Last(A1), A3					 ; $0042
		bclr	D6, Obj_Status(A3)				 ; $002A
Offset_0x029B10:
		move.w	A0, Obj_Player_Last(A1)					 ; $0042
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029B4C
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		move.l	A0, -(A7)
		move.l	A1, A0
		move.w	A0, D1
		subi.w	#Obj_Player_One, D1				 ; $B000
		bne.s	Offset_0x029B44
		cmpi.w	#Miles_Alone, (Player_Selected_Flag).w ; $0002, $FFFFFF08
		beq.s	Offset_0x029B44
		jsr		(Sonic_ResetOnFloor).l		   ; Offset_0x00BF76
		bra.s	Offset_0x029B4A
Offset_0x029B44:
		jsr		(Miles_ResetOnFloor).l		   ; Offset_0x00E7EE
Offset_0x029B4A:
		move.l	(A7)+, A0
Offset_0x029B4C:
		bset	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$01, Obj_Status(A1)					 ; $002A
		bset	D6, Obj_Status(A0)				 ; $002A
		rts
;===============================================================================
; Objeto 0x4D - Postes diagonais que fazem o jogador girar na Carnival Night
; <<<-
;===============================================================================