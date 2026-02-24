;===============================================================================
; Objeto 0x2A - Chão quebrável nas fases
; ->>>
;===============================================================================
; Offset_0x0211D6:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.l	#Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x0216FC, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$28, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x02168C, Obj_Control_Var_0C(A0)		 ; $003C
		cmpi.w	#AIz_Act_2, (Current_ZoneAndAct).w		; $0001, $FFFFFE10
		bne.s	Offset_0x021220
		move.l	#AIz_2_Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x021770, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$2C, Obj_Height(A0)					 ; $0006
Offset_0x021220:
		cmpi.b	#CNz_Id, (Current_Zone).w			; $03, $FFFFFE10
		bne.s	Offset_0x02124A
		move.l	#CNz_Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x0217E4, $000C
		move.w	#$4430, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0216BC, Obj_Control_Var_0C(A0)		 ; $003C
Offset_0x02124A:
		cmpi.b	#Iz_Id, (Current_Zone).w			; $05, $FFFFFE10
		bne.s	Offset_0x02129E
		move.l	#Iz_Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x02187C, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$24, Obj_Height(A0)					 ; $0006
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.b	#$0F, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		andi.b	#$10, D1
		bne.s	Offset_0x02128A
		move.l	#Offset_0x0214B0, (A0)
		bra.w	Offset_0x0214B0
Offset_0x02128A:
		move.l	#Offset_0x021660, Obj_Control_Var_0C(A0)			   ; $003C
		move.w	#$43B6, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Height(A0)					 ; $0006
Offset_0x02129E:
		cmpi.b	#LBz_Id, (Current_Zone).w			; $06, $FFFFFE10
		bne.s	Offset_0x0212C8
		move.l	#LBz_Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x021A84, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0216BC, Obj_Control_Var_0C(A0)		 ; $003C
Offset_0x0212C8:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0212D8
		move.l	#Offset_0x0213F4, (A0)
		bra.w	Offset_0x0213F4
Offset_0x0212D8:
		move.l	#Offset_0x0212DE, (A0)
Offset_0x0212DE:
		move.w	(Enemy_Hit_Chain_Count).w, Obj_Control_Var_08(A0) ; $FFFFF7D0, $0038
		move.b	(Obj_Player_One+Obj_Ani_Number).w, Obj_Control_Var_04(A0) ; $FFFFB020, $0034
		move.b	(Obj_Player_Two+Obj_Ani_Number).w, Obj_Control_Var_06(A0) ; $FFFFB06A, $0036
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.w	#$0018, D0
		bne.s	Offset_0x02131E
Offset_0x021318:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02131E:
		cmpi.b	#$18, D0
		bne.s	Offset_0x02134C
		cmpi.b	#$02, Obj_Control_Var_04(A0)			 ; $0034
		beq.s	Offset_0x021334
		cmpi.b	#$02, Obj_Control_Var_06(A0)			 ; $0036
		bne.s	Offset_0x021318
Offset_0x021334:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		bsr.s	Offset_0x021364
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		bsr.s	Offset_0x021364
		bra.w	Offset_0x0213B4
Offset_0x02134C:
		move.b	D0, D1
		andi.b	#$08, D1
		beq.s	Offset_0x02139C
		cmpi.b	#$02, Obj_Control_Var_04(A0)			 ; $0034
		bne.s	Offset_0x021318
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x02136A
		bra.s	Offset_0x0213B4
Offset_0x021364:
		cmpi.b	#$02, D0
		bne.s	Offset_0x021388
Offset_0x02136A:
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$FD00, Obj_Speed_Y(A1)					 ; $001A
Offset_0x021388:
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		rts
Offset_0x02139C:
		andi.b	#$10, D0
		beq.w	Offset_0x021318
		cmpi.b	#$02, Obj_Control_Var_06(A0)			 ; $0036
		bne.w	Offset_0x021318
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x02136A
Offset_0x0213B4:
		move.w	Obj_Control_Var_08(A0), (Enemy_Hit_Chain_Count).w ; $0038, $FFFFF7D0
		andi.b	#$E7, Obj_Status(A0)					 ; $002A
		move.l	Obj_Control_Var_0C(A0), A4				 ; $003C
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x0213D4, (A0)
		jsr		(Offset_0x017372).l
Offset_0x0213D4:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x0213EE
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0213EE:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x0213F4:
		move.w	(Obj_Player_One+Obj_Speed_Y).w, Obj_Control_Var_00(A0) ; $FFFFB01A, $0030
		move.w	(Obj_Player_Two+Obj_Speed_Y).w, Obj_Control_Var_02(A0) ; $FFFFB064, $0032
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		swap	D6
		andi.w	#$000C, D6
		bne.s	Offset_0x02142C
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02142C:
		move.b	D6, D0
		andi.b	#$04, D0
		beq.s	Offset_0x021450
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Control_Var_00(A0), Obj_Speed_Y(A1)	  ; $0030, $001A
		andi.b	#$08, D6
		beq.s	Offset_0x021468
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Control_Var_02(A0), Obj_Speed_Y(A1)	  ; $0032, $001A
		bra.s	Offset_0x021468
Offset_0x021450:
		andi.b	#$08, D6
		beq.s	Offset_0x021462
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Control_Var_02(A0), Obj_Speed_Y(A1)	  ; $0032, $001A
		bra.s	Offset_0x021468
Offset_0x021462:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x021468:
		btst	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x021480
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
Offset_0x021480:
		btst	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x021498
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
Offset_0x021498:
		move.l	Obj_Control_Var_0C(A0), A4				 ; $003C
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x0213D4, (A0)
		jsr		(Offset_0x017372).l
		bra.w	Offset_0x0213D4
Offset_0x0214B0:
		move.w	(Enemy_Hit_Chain_Count).w, Obj_Control_Var_08(A0) ; $FFFFF7D0, $0038
		move.b	(Obj_Player_One+Obj_Ani_Number).w, Obj_Control_Var_04(A0) ; $FFFFB020, $0034
		move.b	(Obj_Player_Two+Obj_Ani_Number).w, Obj_Control_Var_06(A0) ; $FFFFB06A, $0036
		lea		(Offset_0x021670).l, A2
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_4).l			   ; Offset_0x0136C6
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x0214F2
Offset_0x0214EC:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x0214F2:
		cmpi.b	#$18, D0
		bne.s	Offset_0x021556
		cmpi.b	#$02, Obj_Control_Var_04(A0)			 ; $0034
		bne.s	Offset_0x02150E
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x02153E
		cmpi.b	#$0E, (Obj_Player_One+Obj_Player_Top_Solid).w ; $FFFFB046
		beq.s	Offset_0x02153E
Offset_0x02150E:
		move.b	#$0C, (Obj_Player_One+Obj_Player_Top_Solid).w ; $FFFFB046
		move.b	#$0D, (Obj_Player_One+Obj_Player_LRB_Solid).w ; $FFFFB047
		cmpi.b	#$02, Obj_Control_Var_06(A0)			 ; $0036
		bne.s	Offset_0x021530
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x02153E
		cmpi.b	#$0E, (Obj_Player_Two+Obj_Player_Top_Solid).w ; $FFFFB090
		beq.s	Offset_0x02153E
Offset_0x021530:
		move.b	#$0C, (Obj_Player_Two+Obj_Player_Top_Solid).w ; $FFFFB090
		move.b	#$0D, (Obj_Player_Two+Obj_Player_LRB_Solid).w ; $FFFFB091
		bra.s	Offset_0x0214EC
Offset_0x02153E:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		bsr.s	Offset_0x02158C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		bsr.s	Offset_0x02158C
		bra.w	Offset_0x0215F2
Offset_0x021556:
		move.b	D0, D1
		andi.b	#$08, D1
		beq.s	Offset_0x0215BE
		cmpi.b	#$02, Obj_Control_Var_04(A0)			 ; $0034
		bne.s	Offset_0x021574
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x021584
		cmpi.b	#$0E, (Obj_Player_One+Obj_Player_Top_Solid).w ; $FFFFB046
		beq.s	Offset_0x021584
Offset_0x021574:
		move.b	#$0C, (Obj_Player_One+Obj_Player_Top_Solid).w ; $FFFFB046
		move.b	#$0D, (Obj_Player_One+Obj_Player_LRB_Solid).w ; $FFFFB047
		bra.w	Offset_0x0214EC
Offset_0x021584:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x021592
		bra.s	Offset_0x0215F2
Offset_0x02158C:
		cmpi.b	#$02, D0
		bne.s	Offset_0x0215AA
Offset_0x021592:
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
Offset_0x0215AA:
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		rts
Offset_0x0215BE:
		andi.b	#$10, D0
		beq.w	Offset_0x0214EC
		cmpi.b	#$02, Obj_Control_Var_06(A0)			 ; $0036
		bne.s	Offset_0x0215DC
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x0215EC
		cmpi.b	#$0E, (Obj_Player_Two+Obj_Player_Top_Solid).w ; $FFFFB090
		beq.s	Offset_0x0215EC
Offset_0x0215DC:
		move.b	#$0C, (Obj_Player_Two+Obj_Player_Top_Solid).w ; $FFFFB090
		move.b	#$0D, (Obj_Player_Two+Obj_Player_LRB_Solid).w ; $FFFFB091
		bra.w	Offset_0x0214EC
Offset_0x0215EC:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x021592
Offset_0x0215F2:
		move.w	Obj_Control_Var_08(A0), (Enemy_Hit_Chain_Count).w ; $0038, $FFFFF7D0
		andi.b	#$E7, Obj_Status(A0)					 ; $002A
		lea		(Offset_0x021628).l, A4
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.l	D0, D1
		add.w	D0, D0
		add.w	D0, D0
		lea		(A4, D0), A4
		move.l	#Offset_0x0213D4, (A0)
		jsr		(Offset_0x017372).l
		bra.w	Offset_0x0213D4
;-------------------------------------------------------------------------------
Offset_0x021628:
		dc.w	$FEC0, $F600, $0140, $F600, $FEE0, $F700, $0120, $F700
		dc.w	$FF00, $F800, $0100, $F800, $FF20, $F900, $00E0, $F900
		dc.w	$FF40, $FA00, $00C0, $FA00, $FF60, $FA80, $00A0, $FA80
		dc.w	$FF80, $FB00, $0080, $FB00
;-------------------------------------------------------------------------------
Offset_0x021660:
		dc.w	$FE00, $FE00, $0200, $FE00, $FF00, $FF00, $0100, $FF00
;-------------------------------------------------------------------------------
Offset_0x021670:
		dc.b	$23, $23, $22, $22, $21, $21, $20, $1F
		dc.b	$1F, $1E, $1E, $1D, $1D, $1C, $1B, $1B
		dc.b	$1A, $1A, $19, $19, $17, $16, $15, $15
		dc.b	$14, $14, $13, $13
;-------------------------------------------------------------------------------
Offset_0x02168C:
		dc.w	$FF00, $FE00, $0100, $FE00, $FF20, $FE40, $00E0, $FE40
		dc.w	$FF40, $FE80, $00C0, $FE80, $FF60, $FEC0, $00A0, $FEC0
		dc.w	$FF80, $FF00, $0080, $FF00, $FFA0, $FF40, $0060, $FF40
;-------------------------------------------------------------------------------
Offset_0x0216BC:
		dc.w	$FC00, $FC00, $FE00, $FC00, $0200, $FC00, $0400, $FC00
		dc.w	$FC40, $FC40, $FE40, $FC40, $01C0, $FC40, $03C0, $FC40
		dc.w	$FC80, $FC80, $FE80, $FC80, $0180, $FC80, $0380, $FC80
		dc.w	$FCC0, $FCC0, $FEC0, $FCC0, $0140, $FCC0, $0340, $FCC0
;-------------------------------------------------------------------------------
Breakable_Floor_Mappings:					   ; Offset_0x0216FC
		dc.w	Offset_0x021700-Breakable_Floor_Mappings
		dc.w	Offset_0x021726-Breakable_Floor_Mappings
Offset_0x021700:
		dc.w	$0006
		dc.w	$D00C, $0034, $FFF0
		dc.w	$D80D, $001C, $FFF0
		dc.w	$E80D, $0824, $FFF0
		dc.w	$F80D, $0824, $FFF0
		dc.w	$080D, $0824, $FFF0
		dc.w	$180D, $002C, $FFF0
Offset_0x021726:
		dc.w	$000C
		dc.w	$D004, $0034, $FFF0
		dc.w	$D004, $0036, $0000
		dc.w	$D805, $001C, $FFF0
		dc.w	$D805, $0020, $0000
		dc.w	$E805, $0828, $FFF0
		dc.w	$E805, $0824, $0000
		dc.w	$F805, $0828, $FFF0
		dc.w	$F805, $0824, $0000
		dc.w	$0805, $0828, $FFF0
		dc.w	$0805, $0824, $0000
		dc.w	$1805, $002C, $FFF0
		dc.w	$1805, $0030, $0000
;-------------------------------------------------------------------------------
AIz_2_Breakable_Floor_Mappings:				   ; Offset_0x021770
		dc.w	Offset_0x021774-AIz_2_Breakable_Floor_Mappings
		dc.w	Offset_0x02179A-AIz_2_Breakable_Floor_Mappings
Offset_0x021774:
		dc.w	$0006
		dc.w	$CC0D, $0800, $FFF0
		dc.w	$DC0D, $000E, $FFF0
		dc.w	$EC0D, $0016, $FFF0
		dc.w	$FC0D, $0816, $FFF0
		dc.w	$0C0D, $0016, $FFF0
		dc.w	$1C0D, $0816, $FFF0
Offset_0x02179A:
		dc.w	$000C
		dc.w	$CC05, $0804, $FFF0
		dc.w	$CC05, $0800, $0000
		dc.w	$DC05, $000E, $FFF0
		dc.w	$DC05, $0012, $0000
		dc.w	$EC05, $0016, $FFF0
		dc.w	$EC05, $001A, $0000
		dc.w	$FC05, $081A, $FFF0
		dc.w	$FC05, $0816, $0000
		dc.w	$0C05, $0016, $FFF0
		dc.w	$0C05, $001A, $0000
		dc.w	$1C05, $081A, $FFF0
		dc.w	$1C05, $0816, $0000
;-------------------------------------------------------------------------------
CNz_Breakable_Floor_Mappings:				   ; Offset_0x0217E4
		dc.w	Offset_0x0217E8-CNz_Breakable_Floor_Mappings
		dc.w	Offset_0x02181A-CNz_Breakable_Floor_Mappings
Offset_0x0217E8:
		dc.w	$0008
		dc.w	$E00D, $0000, $FFE0
		dc.w	$E00D, $0800, $0000
		dc.w	$F00D, $0008, $FFE0
		dc.w	$F00D, $0808, $0000
		dc.w	$000D, $0008, $FFE0
		dc.w	$000D, $0808, $0000
		dc.w	$100D, $0010, $FFE0
		dc.w	$100D, $0810, $0000
Offset_0x02181A:
		dc.w	$0010
		dc.w	$E005, $0000, $FFE0
		dc.w	$E005, $0004, $FFF0
		dc.w	$E005, $0804, $0000
		dc.w	$E005, $0800, $0010
		dc.w	$F005, $0008, $FFE0
		dc.w	$F005, $000C, $FFF0
		dc.w	$F005, $080C, $0000
		dc.w	$F005, $0808, $0010
		dc.w	$0005, $0008, $FFE0
		dc.w	$0005, $000C, $FFF0
		dc.w	$0005, $080C, $0000
		dc.w	$0005, $0808, $0010
		dc.w	$1005, $0010, $FFE0
		dc.w	$1005, $0014, $FFF0
		dc.w	$1005, $0814, $0000
		dc.w	$1005, $0810, $0010
;-------------------------------------------------------------------------------
Iz_Breakable_Floor_Mappings:				   ; Offset_0x02187C
		dc.w	Offset_0x021894-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x0218C0-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021916-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x02193C-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021986-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x0219A6-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x0219E4-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x0219FE-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021A30-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021A44-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021A6A-Iz_Breakable_Floor_Mappings
		dc.w	Offset_0x021A6A-Iz_Breakable_Floor_Mappings
Offset_0x021894:
		dc.w	$0007
		dc.w	$D80D, $00AC, $FFF0
		dc.w	$E80D, $0018, $FFF0
		dc.w	$F80D, $0028, $FFF0
		dc.w	$080D, $0028, $FFF0
		dc.w	$180D, $0028, $FFF0
		dc.w	$280D, $0038, $FFF0
		dc.w	$380C, $0048, $FFF0
Offset_0x0218C0:
		dc.w	$000E
		dc.w	$D805, $00AC, $FFF0
		dc.w	$D805, $00B0, $0000
		dc.w	$E805, $0018, $FFF0
		dc.w	$E805, $001C, $0000
		dc.w	$F805, $0028, $FFF0
		dc.w	$F805, $002C, $0000
		dc.w	$0805, $0028, $FFF0
		dc.w	$0805, $002C, $0000
		dc.w	$1805, $0028, $FFF0
		dc.w	$1805, $002C, $0000
		dc.w	$2805, $0038, $FFF0
		dc.w	$2805, $003C, $0000
		dc.w	$3804, $0048, $FFF0
		dc.w	$3804, $004A, $0000
Offset_0x021916:
		dc.w	$0006
		dc.w	$E00D, $0018, $FFF0
		dc.w	$F00D, $0028, $FFF0
		dc.w	$000D, $0028, $FFF0
		dc.w	$100D, $0028, $FFF0
		dc.w	$200D, $0038, $FFF0
		dc.w	$300C, $0048, $FFF0
Offset_0x02193C:
		dc.w	$000C
		dc.w	$E005, $0018, $FFF0
		dc.w	$E005, $001C, $0000
		dc.w	$F005, $0028, $FFF0
		dc.w	$F005, $002C, $0000
		dc.w	$0005, $0028, $FFF0
		dc.w	$0005, $002C, $0000
		dc.w	$1005, $0028, $FFF0
		dc.w	$1005, $002C, $0000
		dc.w	$2005, $0038, $FFF0
		dc.w	$2005, $003C, $0000
		dc.w	$3004, $0048, $FFF0
		dc.w	$3004, $004A, $0000
Offset_0x021986:
		dc.w	$0005
		dc.w	$E80D, $0028, $FFF0
		dc.w	$F80D, $0028, $FFF0
		dc.w	$080D, $0028, $FFF0
		dc.w	$180D, $0038, $FFF0
		dc.w	$280C, $0048, $FFF0
Offset_0x0219A6:
		dc.w	$000A
		dc.w	$E805, $0028, $FFF0
		dc.w	$E805, $002C, $0000
		dc.w	$F805, $0028, $FFF0
		dc.w	$F805, $002C, $0000
		dc.w	$0805, $0028, $FFF0
		dc.w	$0805, $002C, $0000
		dc.w	$1805, $0038, $FFF0
		dc.w	$1805, $003C, $0000
		dc.w	$2804, $0048, $FFF0
		dc.w	$2804, $004A, $0000
Offset_0x0219E4:
		dc.w	$0004
		dc.w	$F00D, $0028, $FFF0
		dc.w	$000D, $0028, $FFF0
		dc.w	$100D, $0038, $FFF0
		dc.w	$200C, $0048, $FFF0
Offset_0x0219FE:
		dc.w	$0008
		dc.w	$F005, $0028, $FFF0
		dc.w	$F005, $002C, $0000
		dc.w	$0005, $0028, $FFF0
		dc.w	$0005, $002C, $0000
		dc.w	$1005, $0038, $FFF0
		dc.w	$1005, $003C, $0000
		dc.w	$2004, $0048, $FFF0
		dc.w	$2004, $004A, $0000
Offset_0x021A30:
		dc.w	$0003
		dc.w	$F80D, $0028, $FFF0
		dc.w	$080D, $0038, $FFF0
		dc.w	$180C, $0048, $FFF0
Offset_0x021A44:
		dc.w	$0006
		dc.w	$F805, $0028, $FFF0
		dc.w	$F805, $002C, $0000
		dc.w	$0805, $0038, $FFF0
		dc.w	$0805, $003C, $0000
		dc.w	$1804, $0048, $FFF0
		dc.w	$1804, $004A, $0000
Offset_0x021A6A:
		dc.w	$0004
		dc.w	$F005, $0013, $FFF0
		dc.w	$F005, $0013, $0000
		dc.w	$0005, $0013, $FFF0
		dc.w	$0005, $0013, $0000
;-------------------------------------------------------------------------------
LBz_Breakable_Floor_Mappings:				   ; Offset_0x021A84
		dc.w	Offset_0x021A88-LBz_Breakable_Floor_Mappings
		dc.w	Offset_0x021ABA-LBz_Breakable_Floor_Mappings
Offset_0x021A88:
		dc.w	$0008
		dc.w	$E00D, $0000, $FFE0
		dc.w	$E00D, $0000, $0000
		dc.w	$F00D, $0018, $FFE0
		dc.w	$F00D, $0020, $0000
		dc.w	$000D, $0038, $FFE0
		dc.w	$000D, $0040, $0000
		dc.w	$100D, $0040, $FFE0
		dc.w	$100D, $0038, $0000
Offset_0x021ABA:
		dc.w	$0010
		dc.w	$E005, $0000, $FFE0
		dc.w	$E005, $0004, $FFF0
		dc.w	$E005, $0000, $0000
		dc.w	$E005, $0004, $0010
		dc.w	$F005, $0018, $FFE0
		dc.w	$F005, $001C, $FFF0
		dc.w	$F005, $0020, $0000
		dc.w	$F005, $0024, $0010
		dc.w	$0005, $0038, $FFE0
		dc.w	$0005, $003C, $FFF0
		dc.w	$0005, $0040, $0000
		dc.w	$0005, $0044, $0010
		dc.w	$1005, $0040, $FFE0
		dc.w	$1005, $0044, $FFF0
		dc.w	$1005, $0038, $0000
		dc.w	$1005, $003C, $0010
;===============================================================================
; Objeto 0x2A - Chão quebrável nas fases
; <<<-
;===============================================================================