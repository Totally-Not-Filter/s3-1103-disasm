;===============================================================================
; Objeto 0x06 - Cipó que desliza na diagonal ao ser agarrado na Angel Island
; ->>>
;===============================================================================
; Offset_0x017A8E:
		move.l	A0, A1
		move.l	#Offset_0x017B48, (A1)
		bsr.w	Offset_0x017B20
		move.b	#$21, Obj_Map_Id(A1)					 ; $0022
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		andi.w	#$007F, D1
		lsl.w	#$04, D1
		add.w	D2, D1
		move.w	D1, Obj_Control_Var_16(A0)				 ; $0046
		moveq	#$03, D1
		addq.w	#$01, D1
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x017B1E
		move.w	A1, Obj_Parent_Ref(A0)					 ; $003E
		move.l	#Offset_0x017D94, (A1)
		move.w	A0, Obj_Control_Var_0C(A1)				 ; $003C
		bra.s	Offset_0x017AF0
;-------------------------------------------------------------------------------
Offset_0x017AD8:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x017B1E
		move.l	#Offset_0x017E28, (A1)
		move.w	A2, Obj_Control_Var_0C(A1)				 ; $003C
		move.w	A1, Obj_Control_Var_0E(A2)				 ; $003E
Offset_0x017AF0:
		move.l	A1, A2
		bsr.s	Offset_0x017B20
		move.w	D2, Obj_X(A1)					 ; $0010
		move.w	D3, Obj_Y(A1)					 ; $0014
		addi.w	#$0010, D3
		addq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		move.w	Obj_Control_Var_06(A0), Obj_Control_Var_06(A1) ; $0036, $0036
		dbra	D1, Offset_0x017AD8
		move.l	#Offset_0x017E88, (A1)
		move.b	#$20, Obj_Map_Id(A1)					 ; $0022
		move.w	A1, Obj_Control_Var_10(A0)				 ; $0040
Offset_0x017B1E:
		bra.s	Offset_0x017B48
Offset_0x017B20:
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$08, Obj_Width(A1)				 ; $0007
		move.b	#$08, Obj_Height(A1)					 ; $0006
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.l	#Ride_Vine_Mappings, Obj_Map(A1) ; Offset_0x018482, $000C
		move.w	#$0422, Obj_Art_VRAM(A1)				 ; $000A
		rts
Offset_0x017B48:
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		tst.w	Obj_Control_Var_02(A1)					 ; $0032
		beq.s	Offset_0x017B68
		move.l	#Offset_0x017B6C, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	#$0001, Obj_Timer(A1)					 ; $002E
		move.w	#$0000, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x017B68:
		bra.w	Offset_0x017D58
;-------------------------------------------------------------------------------
Offset_0x017B6C:
		addi.l	#$00080000, Obj_X(A0)					 ; $0010
		addi.l	#$00020000, Obj_Y(A0)					 ; $0014
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_Control_Var_16(A0), D0				 ; $0046
		bcs.w	Offset_0x017C0E
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x017BE2
		move.l	#Offset_0x017C12, (A0)
		move.w	#$0800, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Animated_Still_Sprite_Mappings, Obj_Map(A0) ; Offset_0x02322A, $000C
		move.w	#$62F0, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		lea		Obj_Control_Var_02(A1), A2				 ; $0032
		tst.b	(A2)
		beq.s	Offset_0x017BD6
		move.b	#$81, (A2)
Offset_0x017BD6:
		addq.w	#$01, A2
		tst.b	(A2)
		beq.s	Offset_0x017BE0
		move.b	#$81, (A2)
Offset_0x017BE0:
		bra.s	Offset_0x017C0E
Offset_0x017BE2:
		move.l	#Offset_0x017C34, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.l	#Offset_0x017DFC, (A1)
		move.w	#$0000, Obj_Control_Var_0A(A1)			 ; $003A
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	#$0001, Obj_Control_Var_00(A1)			 ; $0030
		move.w	#$0000, Obj_Angle(A0)					 ; $0026
		move.w	#$0400, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x017C0E:
		bra.w	Offset_0x017D58
;-------------------------------------------------------------------------------
Offset_0x017C12:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x017C24
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x017C24:
		lea		(Decoration2_AnimateData).l, A1 ; Offset_0x023218
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		bra.w	Offset_0x017D58
;-------------------------------------------------------------------------------
Offset_0x017C34:
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.b	Obj_Angle(A0), D1				 ; $0026
		ext.w	D1
		bpl.s	Offset_0x017C46
		neg.w	D1
Offset_0x017C46:
		add.w	D1, D1
		sub.w	D1, D0
		sub.w	D0, Obj_Angle(A0)				 ; $0026
		tst.w	Obj_Control_Var_02(A1)					 ; $0032
		bne.s	Offset_0x017C88
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$08, D0
		cmpi.b	#$10, D0
		bcc.s	Offset_0x017C88
		move.l	#Offset_0x017C8C, (A0)
		move.w	#$0000, Obj_Control_Var_12(A0)			 ; $0042
		move.w	#$FD00, Obj_Height_3(A0)				 ; $0044
		move.w	#$1000, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0000, Obj_Timer(A0)					 ; $002E
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	#$0002, Obj_Control_Var_00(A1)			 ; $0030
Offset_0x017C88:
		bra.w	Offset_0x017D58
;-------------------------------------------------------------------------------
Offset_0x017C8C:
		moveq	#$00, D2
		move.b	Obj_Control_Var_08(A0), D2				 ; $0038
		move.w	Obj_Height_3(A0), D0					 ; $0044
		move.w	#$0000, D1
		tst.w	Obj_Timer(A0)					 ; $002E
		bne.s	Offset_0x017CE4
		add.w	D2, D0
		move.w	D0, Obj_Height_3(A0)					 ; $0044
		add.w	D0, Obj_Control_Var_12(A0)				 ; $0042
		cmp.b	Obj_Control_Var_12(A0), D1				 ; $0042
		bgt.s	Offset_0x017D0E
		asr.w	#$04, D0
		sub.w	D0, Obj_Height_3(A0)					 ; $0044
		move.w	#$0001, Obj_Timer(A0)					 ; $002E
		cmpi.w	#$0C00, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x017CCC
		subi.w	#$0040, Obj_Control_Var_08(A0)			 ; $0038
		bra.s	Offset_0x017D0E
Offset_0x017CCC:
		move.l	#Offset_0x017D2A, (A0)
		move.w	#$0000, Obj_Control_Var_08(A0)			 ; $0038
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	#$0000, Obj_Control_Var_00(A1)			 ; $0030
		bra.s	Offset_0x017D0E
Offset_0x017CE4:
		sub.w	D2, D0
		move.w	D0, Obj_Height_3(A0)					 ; $0044
		add.w	D0, Obj_Control_Var_12(A0)				 ; $0042
		cmp.b	Obj_Control_Var_12(A0), D1				 ; $0042
		ble.s	Offset_0x017D0E
		asr.w	#$04, D0
		sub.w	D0, Obj_Height_3(A0)					 ; $0044
		move.w	#$0000, Obj_Timer(A0)					 ; $002E
		cmpi.w	#$0C00, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x017CCC
		subi.w	#$0040, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x017D0E:
		move.w	Obj_Control_Var_12(A0), D0				 ; $0042
		move.w	D0, Obj_Angle(A0)				 ; $0026
		asr.w	#$03, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_Control_Var_0A(A0), Obj_Control_Var_0A(A1) ; $003A, $003A
		bra.w	Offset_0x017D58
;-------------------------------------------------------------------------------
Offset_0x017D2A:
		move.b	Obj_Control_Var_08(A0), D0				 ; $0038
		addi.w	#$0200, Obj_Control_Var_08(A0)			 ; $0038
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$02, D0
		cmpi.w	#$0400, D0
		bne.s	Offset_0x017D46
		move.w	#$03FF, D0
Offset_0x017D46:
		move.w	D0, Obj_Angle(A0)				 ; $0026
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_Control_Var_0A(A0), Obj_Control_Var_0A(A1) ; $003A, $003A
Offset_0x017D58:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x017D72
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x017D72:
		move.w	Obj_Control_Var_06(A0), D2				 ; $0036
		subq.w	#$01, D2
		bcs.s	Offset_0x017D8E
		move.w	Obj_Control_Var_0E(A0), A2				 ; $003E
Offset_0x017D7E:
		move.l	A2, A1
		move.w	Obj_Control_Var_0E(A1), A2				 ; $003E
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
		dbra	D2, Offset_0x017D7E
Offset_0x017D8E:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x017D94:
		tst.w	Obj_Timer(A0)					 ; $002E
		bne.s	Offset_0x017DBC
		move.b	Obj_Control_Var_08(A0), D0				 ; $0038
		addi.w	#$0200, Obj_Control_Var_08(A0)			 ; $0038
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$02, D0
		cmpi.w	#$0400, D0
		bne.s	Offset_0x017DB6
		move.w	#$03FF, D0
Offset_0x017DB6:
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		bra.s	Offset_0x017DD2
Offset_0x017DBC:
		move.b	Obj_Control_Var_08(A0), D0				 ; $0038
		addi.w	#$0100, Obj_Control_Var_08(A0)			 ; $0038
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$03, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
Offset_0x017DD2:
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	D0, Obj_Angle(A0)				 ; $0026
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$04, D0
		lsr.b	#$03, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x017DFC:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$04, D0
		lsr.b	#$03, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x017E28:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_Control_Var_0A(A1), Obj_Control_Var_0A(A0) ; $003A, $003A
		move.w	Obj_Angle(A1), D0				 ; $0026
		add.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	D0, Obj_Angle(A0)				 ; $0026
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$04, D0
		lsr.b	#$03, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		bsr.w	Offset_0x017E54
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x017E54:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.b	Obj_Angle(A1), D0				 ; $0026
		addq.b	#$04, D0
		andi.b	#$F8, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		neg.w	D0
		addi.w	#$0008, D0
		addi.w	#$0008, D1
		asr.w	#$04, D0
		asr.w	#$04, D1
		add.w	Obj_X(A1), D0					 ; $0010
		move.w	D0, Obj_X(A0)					 ; $0010
		add.w	Obj_Y(A1), D1					 ; $0014
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x017E88:
		move.w	Obj_X(A0), D4					 ; $0010
		move.w	Obj_Y(A0), D5					 ; $0014
		bsr.w	Offset_0x017E54
		cmp.w	Obj_X(A0), D4					 ; $0010
		beq.s	Offset_0x017E9E
		move.w	D4, Obj_Control_Var_12(A0)				 ; $0042
Offset_0x017E9E:
		cmp.w	Obj_Y(A0), D5					 ; $0014
		beq.s	Offset_0x017EA8
		move.w	D5, Obj_Height_3(A0)					 ; $0044
Offset_0x017EA8:
		lea		Obj_Control_Var_02(A0), A2				 ; $0032
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
		bsr.s	Offset_0x017ECA
		tst.w	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x017EC2
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		bne.s	Offset_0x017EC8
Offset_0x017EC2:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x017EC8:
		rts
Offset_0x017ECA:
		tst.b	(A2)
		beq.w	Offset_0x018088
		bmi.w	Offset_0x017F6C
		tst.b	Obj_Flags(A1)					 ; $0004
		bpl.w	Offset_0x017F7E
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.w	Offset_0x017F7E
		andi.b	#$70, D0
		beq.w	Offset_0x017F8C
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		cmpi.w	#$0001, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x017F44
		move.w	Obj_X(A0), D1					 ; $0010
		sub.w	Obj_Control_Var_12(A0), D1				 ; $0042
		asl.w	#$07, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	Obj_Y(A0), D1					 ; $0014
		sub.w	Obj_Height_3(A0), D1					 ; $0044
		asl.w	#$07, D1
		move.w	D1, Obj_Speed_Y(A1)				 ; $001A
		move.b	#$3C, $0002(A2)
		btst	#$0A, D0
		beq.s	Offset_0x017F2A
		move.w	#$FE00, Obj_Speed_X(A1)					 ; $0018
Offset_0x017F2A:
		btst	#$0B, D0
		beq.s	Offset_0x017F36
		move.w	#$0200, Obj_Speed_X(A1)					 ; $0018
Offset_0x017F36:
		addi.w	#$FC80, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		rts
Offset_0x017F44:
		move.b	#$3C, $0002(A2)
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		move.b	Obj_Angle(A3), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$03, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		asl.w	#$03, D0
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		rts
Offset_0x017F6C:
		move.w	#$0300, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0200, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x017F7E:
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		rts
Offset_0x017F8C:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		bne.s	Offset_0x017FE4
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0014, Obj_Y(A1)				 ; $0014
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		moveq	#$00, D0
		move.b	Obj_Angle(A3), D0				 ; $0026
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x017FB8
		neg.b	D0
Offset_0x017FB8:
		addq.b	#$08, D0
		lsr.w	#$04, D0
		move.b	Offset_0x017FD4(PC, D0), Obj_Map_Id(A1)			 ; $0022
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		move.l	A2, -(A7)
		jsr		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
		move.l	(A7)+, A2
		rts
;-------------------------------------------------------------------------------
Offset_0x017FD4:
		dc.b	$EF, $EE, $ED, $ED, $ED, $ED, $ED, $EE
		dc.b	$EF, $F0, $F1, $F1, $F1, $F1, $F1, $F0
;-------------------------------------------------------------------------------
Offset_0x017FE4:
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		moveq	#$00, D0
		move.b	Obj_Angle(A3), D0				 ; $0026
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x017FF8
		neg.b	D0
Offset_0x017FF8:
		addi.b	#$10, D0
		lsr.w	#$05, D0
		add.w	D0, D0
		move.b	Offset_0x018068(PC, D0), Obj_Map_Id(A1)			 ; $0022
		andi.w	#$FFFE, D0
		move.b	Offset_0x018078(PC, D0), D2
		move.b	Offset_0x018078+$01(PC, D0), D3
		ext.w	D2
		ext.w	D3
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x018020
		neg.w	D2
Offset_0x018020:
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		move.b	Obj_Angle(A3), D0				 ; $0026
		addq.b	#$04, D0
		andi.b	#$F8, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		neg.w	D0
		addi.w	#$0008, D0
		addi.w	#$0008, D1
		asr.w	#$04, D0
		asr.w	#$04, D1
		add.w	Obj_X(A3), D0					 ; $0010
		add.w	D2, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		add.w	Obj_Y(A3), D1					 ; $0014
		add.w	D3, D1
		move.w	D1, Obj_Y(A1)					 ; $0014
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		move.l	A2, -(A7)
		jsr		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
		move.l	(A7)+, A2
		rts
;-------------------------------------------------------------------------------
Offset_0x018068:
		dc.b	$E5, $E5, $EC, $EC, $EB, $EB, $EA, $EA
		dc.b	$E9, $E9, $E8, $E8, $E7, $E7, $E6, $E6
;-------------------------------------------------------------------------------
Offset_0x018078:
		dc.b	$00, $18, $EE, $13, $E8, $00, $EE, $ED
		dc.b	$00, $E8, $12, $ED, $18, $00, $12, $13
;-------------------------------------------------------------------------------
Offset_0x018088:
		tst.b	$0002(A2)
		beq.s	Offset_0x018096
		subq.b	#$01, $0002(A2)
		bne.w	Offset_0x0180FC
Offset_0x018096:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.w	Offset_0x0180FC
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		cmpi.w	#$0018, D1
		bcc.w	Offset_0x0180FC
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x0180FC
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x0180FC
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x0180FC
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0014, Obj_Y(A1)				 ; $0014
		move.b	#$23, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$03, Obj_Timer(A1)				 ; $002E
		move.b	#$01, (A2)
Offset_0x0180FC:
		rts
;===============================================================================
; Objeto 0x06 - Cipó que desliza na diagonal ao ser agarrado na Angel Island
; <<<-
;===============================================================================