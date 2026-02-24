;===============================================================================
; Flickies (p�ssaros, esquilos) que aparecem ao destruir iminigos
; ->>>
;===============================================================================
; Offset_0x0238DA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0238E8(PC, D0), D1
		jmp		Offset_0x0238E8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0238E8:
		dc.w	Offset_0x023A1A-Offset_0x0238E8
		dc.w	Offset_0x023B42-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023BDE-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023BDE-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023BDE-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023B9E-Offset_0x0238E8
		dc.w	Offset_0x023C64-Offset_0x0238E8
		dc.w	Offset_0x023C86-Offset_0x0238E8
		dc.w	Offset_0x023C86-Offset_0x0238E8
		dc.w	Offset_0x023CA6-Offset_0x0238E8
		dc.w	Offset_0x023CE2-Offset_0x0238E8
		dc.w	Offset_0x023D3E-Offset_0x0238E8
		dc.w	Offset_0x023D5E-Offset_0x0238E8
		dc.w	Offset_0x023D3E-Offset_0x0238E8
		dc.w	Offset_0x023D5E-Offset_0x0238E8
		dc.w	Offset_0x023D3E-Offset_0x0238E8
		dc.w	Offset_0x023D9E-Offset_0x0238E8
		dc.w	Offset_0x023CFE-Offset_0x0238E8
;-------------------------------------------------------------------------------
Flickies_Type_Select:						   ; Offset_0x02391C
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$09, $07
		dc.b	$09, $07
		dc.b	$09, $07
		dc.b	$09, $07
		dc.b	$08, $03
		dc.b	$08, $03
		dc.b	$02, $03
		dc.b	$08, $01
		dc.b	$0B, $05
		dc.b	$00, $07
		dc.b	$04, $01
		dc.b	$02, $05
		dc.b	$0A, $01
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$06, $05
		dc.b	$09, $07
		dc.b	$09, $07
		dc.b	$09, $07
;-------------------------------------------------------------------------------
Offset_0x02394C:
		dc.w	$FE00, $FC00
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.w	$FE00, $FD00
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.w	$FE80, $FD00
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.w	$FEC0, $FE80
		dc.l	Flickies_Mappings_03		   ; Offset_0x023EE2
		dc.w	$FE40, $FD00
		dc.l	Flickies_Mappings_02		   ; Offset_0x023EC4
		dc.w	$FD00, $FC00
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.w	$FD80, $FC80
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
		dc.w	$FD80, $FD00
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.w	$FE00, $FC80
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
		dc.w	$FD40, $FD00
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
		dc.w	$FEC0, $FE00
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
		dc.w	$FE00, $FD00
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
;-------------------------------------------------------------------------------
Offset_0x0239AC:
		dc.w	$FBC0, $FC00, $FBC0, $FC00, $FBC0, $FC00, $FD00, $FC00
		dc.w	$FD00, $FC00, $FE80, $FD00, $FE80, $FD00, $FEC0, $FE80
		dc.w	$FE40, $FD00, $FE00, $FD00, $FD80, $FC80
;-------------------------------------------------------------------------------
Offset_0x0239D8:
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.l	Flickies_Mappings_04		   ; Offset_0x023F00
		dc.l	Flickies_Mappings_03		   ; Offset_0x023EE2
		dc.l	Flickies_Mappings_02		   ; Offset_0x023EC4
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
;-------------------------------------------------------------------------------
Offset_0x023A04:
		dc.w	$05A5, $05A5, $05A5, $0553, $0553, $0573, $0573, $0585
		dc.w	$0593, $0565, $05B3
;-------------------------------------------------------------------------------
Offset_0x023A1A:
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.w	Offset_0x023A86
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		move.b	D0, Obj_Routine(A0)				 ; $0005
		subi.w	#$0014, D0
		move.w	Offset_0x023A04(PC, D0), Obj_Art_VRAM(A0)		 ; $000A
		add.w	D0, D0
		move.l	Offset_0x0239D8(PC, D0), Obj_Map(A0)			 ; $000C
		lea		Offset_0x0239AC(PC), A1
		move.w	(A1, D0), Obj_Control_Var_02(A0)		 ; $0032
		move.w	(A1, D0), Obj_Speed_X(A0)			 ; $0018
		move.w	$02(A1, D0), Obj_Control_Var_04(A0)		 ; $0034
		move.w	$02(A1, D0), Obj_Speed_Y(A0)			 ; $001A
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x023A86:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	#$0580, Obj_Art_VRAM(A0)				 ; $000A
		andi.w	#$0001, D0
		beq.s	Offset_0x023AA2
		move.w	#$0592, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x023AA2:
		moveq	#$00, D1
		move.b	(Current_Zone).w, D1					 ; $FFFFFE10
		add.w	D1, D1
		add.w	D0, D1
		lea		Flickies_Type_Select(PC), A1		   ; Offset_0x02391C
		move.b	(A1, D1), D0
		move.b	D0, Obj_Control_Var_00(A0)				 ; $0030
		lsl.w	#$03, D0
		lea		Offset_0x02394C(PC), A1
		adda.w	D0, A1
		move.w	(A1)+, Obj_Control_Var_02(A0)			 ; $0032
		move.w	(A1)+, Obj_Control_Var_04(A0)			 ; $0034
		move.l	(A1)+, Obj_Map(A0)				 ; $000C
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		bne.s	Offset_0x023B2C
		jsr		(AllocateObject).l			 ; Offset_0x011DD8
		bne.s	Offset_0x023B26
		move.l	#Obj_Enemy_Points, (A1)		   ; Offset_0x023E42
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		lsr.w	#$01, D0
		move.b	D0, Obj_Map_Id(A1)				 ; $0022
Offset_0x023B26:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x023B2C:
		move.b	#$1C, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_X(A0)					 ; $0018
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Flickies_DeleteObject:						   ; Offset_0x023B3C
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x023B42:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Flickies_DeleteObject		   ; Offset_0x023B3C
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023B98
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023B98
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A0)	  ; $0018, $0032
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Control_Var_00(A0), D0				 ; $0030
		add.b	D0, D0
		addq.b	#$04, D0
		move.b	D0, Obj_Routine(A0)				 ; $0005
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x023B98
		btst	#$04, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x023B98
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x023B98:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x023B9E:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023BCA
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023BCA
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
Offset_0x023BCA:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x023C46
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Flickies_DeleteObject		   ; Offset_0x023B3C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x023BDE:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023C1C
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023C1C
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x023C1C
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x023C1C
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x023C1C:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x023C32
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x023C32:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x023C46
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Flickies_DeleteObject		   ; Offset_0x023B3C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x023C46:
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		bcs.s	Offset_0x023C5E
		subi.w	#$0180, D0
		bpl.s	Offset_0x023C5E
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Flickies_DeleteObject		   ; Offset_0x023B3C
Offset_0x023C5E:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x023C64:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Flickies_DeleteObject		   ; Offset_0x023B3C
		subq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bne.w	Offset_0x023C80
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
Offset_0x023C80:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x023C86:
		bsr.w	Offset_0x023E34
		bcc.s	Offset_0x023CA2
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A0)	  ; $0018, $0032
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bra.w	Offset_0x023BDE
Offset_0x023CA2:
		bra.w	Offset_0x023C46
;-------------------------------------------------------------------------------
Offset_0x023CA6:
		bsr.w	Offset_0x023E34
		bpl.s	Offset_0x023CDE
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Control_Var_02(A0)					 ; $0032
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		bsr.w	Offset_0x023DF4
		bsr.w	Offset_0x023E1C
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x023CDE
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x023CDE:
		bra.w	Offset_0x023C46
;-------------------------------------------------------------------------------
Offset_0x023CE2:
		bsr.w	Offset_0x023E34
		bpl.s	Offset_0x023D3A
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A0)	  ; $0018, $0032
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bra.w	Offset_0x023B9E
;-------------------------------------------------------------------------------
Offset_0x023CFE:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023D3A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023D3A
		not.b	Obj_Flags_2(A0)					 ; $002D
		bne.s	Offset_0x023D30
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x023D30:
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
Offset_0x023D3A:
		bra.w	Offset_0x023C46
;-------------------------------------------------------------------------------
Offset_0x023D3E:
		bsr.w	Offset_0x023E34
		bpl.s	Offset_0x023D5A
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Control_Var_02(A0)					 ; $0032
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		bsr.w	Offset_0x023DF4
		bsr.w	Offset_0x023E1C
Offset_0x023D5A:
		bra.w	Offset_0x023C46
;-------------------------------------------------------------------------------
Offset_0x023D5E:
		bsr.w	Offset_0x023E34
		bpl.s	Offset_0x023D9A
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023D9A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023D9A
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
Offset_0x023D9A:
		bra.w	Offset_0x023C46
;-------------------------------------------------------------------------------
Offset_0x023D9E:
		bsr.w	Offset_0x023E34
		bpl.s	Offset_0x023DF0
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023DDA
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023DDA
		not.b	Obj_Flags_2(A0)					 ; $002D
		bne.s	Offset_0x023DD0
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x023DD0:
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
Offset_0x023DDA:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x023DF0
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x023DF0:
		bra.w	Offset_0x023C46
Offset_0x023DF4:
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x023E1A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x023E1A
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_04(A0), Obj_Speed_Y(A0)	  ; $001A, $0034
Offset_0x023E1A:
		rts
Offset_0x023E1C:
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		bcc.s	Offset_0x023E32
		bclr	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x023E32:
		rts
Offset_0x023E34:
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		sub.w	Obj_X(A0), D0					 ; $0010
		subi.w	#$00B8, D0
		rts
;===============================================================================
; Flickies (p�ssaros, esquilos) que aparecem ao destruir iminigos
; <<<-
;===============================================================================