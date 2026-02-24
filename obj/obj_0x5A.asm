;===============================================================================
; Objeto 0x5A - Polia com corda usada para puxar o jogador para cima na
; ->>>			Marble Garden.
;===============================================================================
; Offset_0x02ACD8:
		move.l	#Pulley_Mappings, Obj_Map(A0)	; Offset_0x02B0CA, $000C
		move.w	#$235F, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0000, (A2)+
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		move.w	D0, Obj_Control_Var_0C(A0)				 ; $003C
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02ADD2
		move.l	#Offset_0x02B0C0, (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.b	#$60, Obj_Width(A1)				 ; $0007
		move.b	#$C0, Obj_Height(A1)					 ; $0006
		move.w	#$0300, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_Sub_X(A1)		  ; $0010, $0012
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0078, Obj_X(A1)				 ; $0010
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AD84
		addi.w	#$00F0, Obj_X(A1)				 ; $0010
Offset_0x02AD84:
		addi.w	#$00D0, Obj_Y(A1)				 ; $0014
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.w	#$0008, Obj_Sub_Y(A1)					 ; $0016
		lea		Obj_Speed_X(A1), A2				 ; $0018
		moveq	#$07, D0
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		subi.w	#$000C, D2
		subi.w	#$0008, D3
		subi.w	#$0018, D2
		addi.w	#$0030, D3
Offset_0x02ADB4:
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		move.w	#$0005, (A2)+
		subi.w	#$0018, D2
		addi.w	#$0030, D3
		dbra	D0, Offset_0x02ADB4
		move.w	#$0006, -2(A2)
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
Offset_0x02ADD2:
		move.l	#Offset_0x02ADD8, (A0)
Offset_0x02ADD8:
		moveq	#$00, D4
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		bne.s	Offset_0x02AE00
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		cmp.w	Obj_Control_Var_10(A0), D0				 ; $0040
		beq.s	Offset_0x02AE66
		bcc.s	Offset_0x02ADF6
		addq.w	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$FF, D4
		bra.s	Offset_0x02AE3E
Offset_0x02ADF6:
		move.b	#$01, D4
		subq.w	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		bra.s	Offset_0x02AE3E
Offset_0x02AE00:
		tst.w	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x02AE1E
		tst.w	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x02AE66
		move.b	#$01, D4
		subq.w	#$04, Obj_Control_Var_0C(A0)			 ; $003C
		bcc.s	Offset_0x02AE3E
		move.w	#$0000, Obj_Control_Var_0C(A0)			 ; $003C
		bra.s	Offset_0x02AE3E
Offset_0x02AE1E:
		subq.w	#$01, Obj_Control_Var_04(A0)			 ; $0034
		cmpi.w	#$000C, Obj_Control_Var_04(A0)			 ; $0034
		bcs.s	Offset_0x02AE66
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		addq.w	#$08, D0
		cmp.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x02AE66
		addq.w	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$FF, D4
Offset_0x02AE3E:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x02AE54
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		add.b	D4, $001D(A0)
		andi.b	#$03, $001D(A0)
Offset_0x02AE54:
		tst.b	Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x02AE66
		tst.w	D4
		beq.s	Offset_0x02AE6C
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
		bra.s	Offset_0x02AE6C
Offset_0x02AE66:
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x02AE6C:
		bsr.w	Offset_0x02AFF4
		bsr.w	Offset_0x02AE7A
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02AE7A:
		lea		Obj_Control_Var_08(A0), A2				 ; $0038
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
		bsr.s	Offset_0x02AE92
		addq.w	#$01, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	(Control_Ports_Buffer_Data+$02).w, D0		 ; $FFFFF606
Offset_0x02AE92:
		tst.b	(A2)
		beq.w	Offset_0x02AF32
		tst.b	Obj_Flags(A1)					 ; $0004
		bpl.s	Offset_0x02AEF2
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x02AEF2
		andi.b	#$70, D0
		beq.w	Offset_0x02AF00
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		move.w	#$FC00, Obj_Speed_X(A1)					 ; $0018
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AECC
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x02AECC:
		move.w	#$FA00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		rts
Offset_0x02AEF2:
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		rts
Offset_0x02AF00:
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		subi.w	#$0026, D2
		addi.w	#$002E, D3
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		add.w	D0, D3
		lsr.w	#$01, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AF26
		addi.w	#$004C, D2
		neg.w	D0
Offset_0x02AF26:
		sub.w	D0, D2
		move.w	D2, Obj_X(A1)					 ; $0010
		move.w	D3, Obj_Y(A1)					 ; $0014
		rts
Offset_0x02AF32:
		tst.b	$0002(A2)
		beq.s	Offset_0x02AF40
		subq.b	#$01, $0002(A2)
		bne.w	Offset_0x02AFF2
Offset_0x02AF40:
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		subi.w	#$0026, D2
		addi.w	#$002E, D3
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		add.w	D0, D3
		lsr.w	#$01, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AF66
		addi.w	#$004C, D2
		neg.w	D0
Offset_0x02AF66:
		sub.w	D0, D2
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	D2, D0
		addi.w	#$000C, D0
		cmpi.w	#$0018, D0
		bcc.w	Offset_0x02AFF2
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	D3, D1
		addi.w	#$000C, D1
		cmpi.w	#$0018, D1
		bcc.w	Offset_0x02AFF2
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x02AFF2
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x02AFF2
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x02AFF2
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AFAE
		neg.w	D0
Offset_0x02AFAE:
		tst.w	D0
		bpl.s	Offset_0x02AFF2
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		move.w	D2, Obj_X(A1)					 ; $0010
		move.w	D3, Obj_Y(A1)					 ; $0014
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		bclr	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AFE0
		bset	#$00, Obj_Status(A1)					 ; $002A
Offset_0x02AFE0:
		move.w	#$0010, Obj_Control_Var_04(A0)			 ; $0034
		move.b	#$01, (A2)
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02AFF2:
		rts
Offset_0x02AFF4:
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02B05E
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		moveq	#$00, D0
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		addi.w	#$0018, D0
		divu.w	#$0030, D0
		move.w	D0, Obj_Sub_Y(A1)				 ; $0016
		move.w	D0, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		subi.w	#$000C, D2
		subi.w	#$0008, D3
		swap	D0
		cmpi.w	#$0008, D1
		bne.s	Offset_0x02B038
		move.w	#$0030, D0
		moveq	#$07, D1
		bra.s	Offset_0x02B03C
Offset_0x02B038:
		addq.w	#$01, Obj_Sub_Y(A1)				 ; $0016
Offset_0x02B03C:
		add.w	D0, D3
		lsr.w	#$01, D0
		sub.w	D0, D2
Offset_0x02B042:
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		move.w	#$0005, (A2)+
		subi.w	#$0018, D2
		addi.w	#$0030, D3
		dbra	D1, Offset_0x02B042
		move.w	#$0006, -2(A2)
		rts
Offset_0x02B05E:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		moveq	#$00, D0
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		addi.w	#$0018, D0
		divu.w	#$0030, D0
		move.w	D0, Obj_Sub_Y(A1)				 ; $0016
		move.w	D0, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		addi.w	#$000C, D2
		subi.w	#$0008, D3
		swap	D0
		cmpi.w	#$0008, D1
		bne.s	Offset_0x02B09A
		move.w	#$0030, D0
		moveq	#$07, D1
		bra.s	Offset_0x02B09E
Offset_0x02B09A:
		addq.w	#$01, Obj_Sub_Y(A1)				 ; $0016
Offset_0x02B09E:
		add.w	D0, D3
		lsr.w	#$01, D0
		add.w	D0, D2
Offset_0x02B0A4:
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		move.w	#$0005, (A2)+
		addi.w	#$0018, D2
		addi.w	#$0030, D3
		dbra	D1, Offset_0x02B0A4
		move.w	#$0006, -2(A2)
		rts
;-------------------------------------------------------------------------------
Offset_0x02B0C0:
		move.w	Obj_Sub_X(A0), D0				 ; $0012
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Pulley_Mappings:							   ; Offset_0x02B0CA
		dc.w	Offset_0x02B0D8-Pulley_Mappings
		dc.w	Offset_0x02B0FE-Pulley_Mappings
		dc.w	Offset_0x02B11E-Pulley_Mappings
		dc.w	Offset_0x02B144-Pulley_Mappings
		dc.w	Offset_0x02B164-Pulley_Mappings
		dc.w	Offset_0x02B172-Pulley_Mappings
		dc.w	Offset_0x02B186-Pulley_Mappings
Offset_0x02B0D8:
		dc.w	$0006
		dc.w	$F805, $003D, $FFF0
		dc.w	$F805, $083D, $0000
		dc.w	$E00F, $0024, $FFE0
		dc.w	$E00F, $0824, $0000
		dc.w	$000F, $1024, $FFE0
		dc.w	$000F, $1824, $0000
Offset_0x02B0FE:
		dc.w	$0005
		dc.w	$F40A, $0041, $FFF4
		dc.w	$E00F, $0024, $FFE0
		dc.w	$E00F, $0824, $0000
		dc.w	$000F, $1024, $FFE0
		dc.w	$000F, $1824, $0000
Offset_0x02B11E:
		dc.w	$0006
		dc.w	$F005, $004A, $FFF8
		dc.w	$0005, $104A, $FFF8
		dc.w	$E00F, $0024, $FFE0
		dc.w	$E00F, $0824, $0000
		dc.w	$000F, $1024, $FFE0
		dc.w	$000F, $1824, $0000
Offset_0x02B144:
		dc.w	$0005
		dc.w	$F40A, $0841, $FFF4
		dc.w	$E00F, $0024, $FFE0
		dc.w	$E00F, $0824, $0000
		dc.w	$000F, $1024, $FFE0
		dc.w	$000F, $1824, $0000
Offset_0x02B164:
		dc.w	$0002
		dc.w	$E408, $0034, $FFE8
		dc.w	$EC09, $0037, $FFE0
Offset_0x02B172:
		dc.w	$0003
		dc.w	$E805, $004E, $0000
		dc.w	$F805, $004E, $FFF8
		dc.w	$0805, $004E, $FFF0
Offset_0x02B186:
		dc.w	$0003
		dc.w	$040A, $0052, $FFEE
		dc.w	$E805, $004E, $0000
		dc.w	$F805, $004E, $FFF8
;===============================================================================
; Objeto 0x5A - Polia com corda usada para puxar o jogador para cima na
; <<<-			Marble Garden.
;===============================================================================