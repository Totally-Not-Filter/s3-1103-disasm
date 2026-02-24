;===============================================================================
; Objeto 0x36 - Barra que se quebra quando o jogador se aguarra na Hydrocity
; ->>>
;===============================================================================
Offset_0x0143A6:
		dc.b	$14, $2C, $20, $00, $24, $4C, $30, $01
		dc.b	$34, $6C, $40, $02
;-------------------------------------------------------------------------------
Obj_0x36_Hz_Breakable_Bar:					   ; Offset_0x0143B2
		move.l	#Hz_Breakable_Bar_Mappings, Obj_Map(A0) ; Offset_0x01488E, $000C
		move.w	#$43CA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		andi.b	#$0F, D0
		mulu.w	#$003C, D0
		move.w	D0, Obj_Control_Var_00(A0)				 ; $0030
		andi.w	#$0030, D1
		lsr.w	#$02, D1
		lea		Offset_0x0143A6(PC, D1), A1
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x01441A
		moveq	#$00, D0
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	#$04, Obj_Height(A0)					 ; $0006
		move.b	(A1)+, D0
		addq.b	#$04, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.l	#Offset_0x0145F0, (A0)
		bra.w	Offset_0x0145F0
Offset_0x01441A:
		moveq	#$00, D0
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.b	#$04, Obj_Width(A0)				 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x01443C, (A0)
;-------------------------------------------------------------------------------
Offset_0x01443C:
		lea		Obj_Control_Var_02(A0), A2				 ; $0032
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x014452
		tst.w	(A2)
		beq.s	Offset_0x014452
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		beq.w	Offset_0x014578
Offset_0x014452:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Control_Ports_Buffer_Data).w, D1			 ; $FFFFF604
		moveq	#$00, D2
		bsr.s	Offset_0x014478
		addq.w	#$01, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	(Control_Ports_Buffer_Data+$02).w, D1		 ; $FFFFF606
		moveq	#$01, D2
		bsr.s	Offset_0x014478
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		bne.w	Offset_0x014578
		bra.w	MarkObjGone					   ; Offset_0x011AF2
Offset_0x014478:
		tst.b	(A2)
		beq.s	Offset_0x0144DA
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Control_Var_06(A0), D0				 ; $0036
		btst	#$08, D1
		beq.s	Offset_0x014498
		subq.w	#$01, Obj_Y(A1)					 ; $0014
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcs.s	Offset_0x014498
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x014498:
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		btst	#$09, D1
		beq.s	Offset_0x0144B0
		addq.w	#$01, Obj_Y(A1)					 ; $0014
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcc.s	Offset_0x0144B0
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x0144B0:
		andi.w	#$0070, D1
		beq.w	Offset_0x014576
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		bclr	D2, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		andi.b	#$FE, Obj_Timer(A1)				 ; $002E
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0144D8
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x0144D8:
		rts
Offset_0x0144DA:
		tst.b	$0002(A2)
		beq.s	Offset_0x0144E6
		subq.b	#$01, $0002(A2)
		rts
Offset_0x0144E6:
		moveq	#$00, D1
		move.b	Obj_Height(A0), D1				 ; $0006
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	D1, D0
		move.w	Obj_Y(A1), D2					 ; $0014
		cmp.w	D0, D2
		bcs.s	Offset_0x014576
		add.w	D1, D0
		add.w	D1, D0
		cmp.w	D0, D2
		bcc.s	Offset_0x014576
		move.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0014, D0
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x014576
		addi.w	#$0010, D0
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x014576
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x014576
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x014576
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Control_Var_06(A0), D0				 ; $0036
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcs.s	Offset_0x01453A
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x01453A:
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcc.s	Offset_0x014548
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x014548:
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0014, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		bclr	#$00, Obj_Status(A1)					 ; $002A
		move.b	#$11, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		bset	D2, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		move.b	#$01, (A2)
Offset_0x014576:
		rts
Offset_0x014578:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x014584
		andi.b	#$FE, (Obj_Player_One+Obj_Timer).w			 ; $FFFFB02E
Offset_0x014584:
		tst.b	Obj_Control_Var_03(A0)					 ; $0033
		beq.s	Offset_0x014590
		andi.b	#$FE, (Obj_Player_Two+Obj_Player_Control).w	 ; $FFFFB078
Offset_0x014590:
		clr.b	(Wind_Tunnels_Flag).w				 ; $FFFFF7C7
		clr.w	Obj_Control_Var_02(A0)					 ; $0032
		move.l	#Offset_0x0145CA, (A0)
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0400, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		lea		(Offset_0x014794).l, A4
		lea		(Offset_0x01477C).l, A2
		moveq	#$00, D1
		move.b	Obj_Height(A0), D1				 ; $0006
		lsr.w	#$02, D1
		subq.w	#$01, D1
		bsr.w	Offset_0x014814
Offset_0x0145CA:
		tst.b	Obj_Control_Var_0F(A0)					 ; $003F
		beq.s	Offset_0x0145D6
		subq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
		bra.s	Offset_0x0145E2
Offset_0x0145D6:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
Offset_0x0145E2:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x014266
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0145F0:
		lea		Obj_Control_Var_02(A0), A2				 ; $0032
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x014606
		tst.w	(A2)
		beq.s	Offset_0x014606
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		beq.w	Offset_0x014726
Offset_0x014606:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Control_Ports_Buffer_Data).w, D1			 ; $FFFFF604
		moveq	#$00, D2
		bsr.s	Offset_0x01462C
		addq.w	#$01, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	(Control_Ports_Buffer_Data+$02).w, D1		 ; $FFFFF606
		moveq	#$01, D2
		bsr.s	Offset_0x01462C
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		bne.w	Offset_0x014726
		bra.w	MarkObjGone					   ; Offset_0x011AF2
Offset_0x01462C:
		tst.b	(A2)
		beq.s	Offset_0x01468E
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_Control_Var_06(A0), D0				 ; $0036
		btst	#$0A, D1
		beq.s	Offset_0x01464C
		subq.w	#$01, Obj_X(A1)					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x01464C
		move.w	D0, Obj_X(A1)					 ; $0010
Offset_0x01464C:
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		btst	#$0B, D1
		beq.s	Offset_0x014664
		addq.w	#$01, Obj_X(A1)					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x014664
		move.w	D0, Obj_X(A1)					 ; $0010
Offset_0x014664:
		andi.w	#$0070, D1
		beq.w	Offset_0x014724
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		bclr	D2, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		andi.b	#$FE, Obj_Timer(A1)				 ; $002E
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x01468C
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x01468C:
		rts
Offset_0x01468E:
		tst.b	$0002(A2)
		beq.s	Offset_0x01469A
		subq.b	#$01, $0002(A2)
		rts
Offset_0x01469A:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	D1, D0
		move.w	Obj_X(A1), D2					 ; $0010
		cmp.w	D0, D2
		bcs.s	Offset_0x014724
		add.w	D1, D0
		add.w	D1, D0
		cmp.w	D0, D2
		bcc.s	Offset_0x014724
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$0014, D0
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcc.s	Offset_0x014724
		addi.w	#$0010, D0
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcs.s	Offset_0x014724
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x014724
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x014724
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_Control_Var_06(A0), D0				 ; $0036
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x0146EE
		move.w	D0, Obj_X(A1)					 ; $0010
Offset_0x0146EE:
		add.w	Obj_Control_Var_08(A0), D0				 ; $0038
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x0146FC
		move.w	D0, Obj_X(A1)					 ; $0010
Offset_0x0146FC:
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$0014, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.b	#$14, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		bset	D2, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		move.b	#$01, (A2)
Offset_0x014724:
		rts
Offset_0x014726:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x014732
		andi.b	#$FE, (Obj_Player_One+Obj_Timer).w			 ; $FFFFB02E
Offset_0x014732:
		tst.b	Obj_Control_Var_03(A0)					 ; $0033
		beq.s	Offset_0x01473E
		andi.b	#$FE, (Obj_Player_Two+Obj_Player_Control).w	 ; $FFFFB078
Offset_0x01473E:
		clr.b	(Wind_Tunnels_Flag).w				 ; $FFFFF7C7
		clr.w	Obj_Control_Var_02(A0)					 ; $0032
		move.l	#Offset_0x0145CA, (A0)
		move.b	#$07, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		lea		(Offset_0x0147D4).l, A4
		lea		(Offset_0x01477C).l, A2
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		lsr.w	#$02, D1
		subq.w	#$01, D1
		bsr.w	Offset_0x014814
		bra.w	Offset_0x0145CA
;-------------------------------------------------------------------------------
Offset_0x01477C:
		dc.b	$07, $05, $02, $00, $01, $03, $04, $06
		dc.b	$07, $05, $02, $00, $01, $03, $04, $06
		dc.b	$08, $09, $0A, $0B, $0C, $0D, $0E, $0F
;-------------------------------------------------------------------------------
Offset_0x014794:
		dc.w	$0000, $FFE4, $0000, $FFEC, $0000, $FFF4, $0000, $FFFC
		dc.w	$0000, $0004, $0000, $000C, $0000, $0014, $0000, $001C
		dc.w	$0000, $0024, $0000, $FFDC, $0000, $002C, $0000, $FFD4
		dc.w	$0000, $0034, $0000, $FFCC, $0000, $003C, $0000, $FFC4
;-------------------------------------------------------------------------------
Offset_0x0147D4:
		dc.w	$FFE4, $0000, $FFEC, $0000, $FFF4, $0000, $FFFC, $0000
		dc.w	$0004, $0000, $000C, $0000, $0014, $0000, $001C, $0000
		dc.w	$0024, $0000, $FFDC, $0000, $002C, $0000, $FFD4, $0000
		dc.w	$0034, $0000, $FFCC, $0000, $003C, $0000, $FFC4, $0000
;-------------------------------------------------------------------------------
Offset_0x014814:
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		move.w	Obj_Priority(A0), D4					 ; $0008
		move.l	A0, A1
		bra.s	Offset_0x01482C
;-------------------------------------------------------------------------------
Offset_0x014824:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x014886
Offset_0x01482C:
		move.l	(A0), (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	(A4)+, D0
		add.w	D2, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	(A4)+, D0
		add.w	D3, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	D4, Obj_Priority(A1)					 ; $0008
		move.b	#$04, Obj_Width(A1)				 ; $0007
		move.b	#$04, Obj_Height(A1)					 ; $0006
		move.b	Obj_Map_Id(A0), Obj_Map_Id(A1)			  ; $0022, $0022
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
		move.b	(A2)+, Obj_Control_Var_0F(A1)			 ; $003F
		dbra	D1, Offset_0x014824
Offset_0x014886:
		moveq	#Smash_Sfx, D0					   ; $62
		jmp		(PlaySound).l					; Offset_0x001176
;-------------------------------------------------------------------------------
Hz_Breakable_Bar_Mappings:					   ; Offset_0x01488E
		dc.w	Offset_0x01489E-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x0148AC-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x0148C0-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x0148DA-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x0148E2-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x0148F0-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x014904-Hz_Breakable_Bar_Mappings
		dc.w	Offset_0x01491E-Hz_Breakable_Bar_Mappings
Offset_0x01489E:
		dc.w	$0002
		dc.w	$E003, $0000, $FFFA
		dc.w	$0003, $1000, $FFFA
Offset_0x0148AC:
		dc.w	$0003
		dc.w	$D003, $0000, $FFFA
		dc.w	$F003, $0001, $FFFA
		dc.w	$1003, $1000, $FFFA
Offset_0x0148C0:
		dc.w	$0004
		dc.w	$C003, $0000, $FFFA
		dc.w	$E003, $0001, $FFFA
		dc.w	$0003, $0001, $FFFA
		dc.w	$2003, $1000, $FFFA
Offset_0x0148DA:
		dc.w	$0001
		dc.w	$FC00, $0001, $FFFC
Offset_0x0148E2:
		dc.w	$0002
		dc.w	$FA0C, $0005, $FFE0
		dc.w	$FA0C, $0805, $0000
Offset_0x0148F0:
		dc.w	$0003
		dc.w	$FA0C, $0005, $FFD0
		dc.w	$FA0C, $0006, $FFF0
		dc.w	$FA0C, $0805, $0010
Offset_0x014904:
		dc.w	$0004
		dc.w	$FA0C, $0005, $FFC0
		dc.w	$FA0C, $0006, $FFE0
		dc.w	$FA0C, $0006, $0000
		dc.w	$FA0C, $0805, $0020
Offset_0x01491E:
		dc.w	$0001
		dc.w	$FC00, $0006, $FFFC
;===============================================================================
; Objeto 0x36 - Barra que se quebra quando o jogador se aguarra na Hydrocity
; <<<-
;===============================================================================