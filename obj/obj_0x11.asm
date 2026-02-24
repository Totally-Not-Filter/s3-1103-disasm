;===============================================================================
; Objeto 0x11 - Plataforma na Launch Base
; ->>>
;===============================================================================
Offset_0x01BCF4:
		dc.b	$20, $08, $00, $00, $20, $08, $01, $00
;-------------------------------------------------------------------------------
Obj_0x11_LBz_Platform:						   ; Offset_0x01BCFC
		move.l	#LBz_Platform_Mappings, Obj_Map(A0) ; Offset_0x01C1F8, $000C
		move.w	#$43C3, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x01BD2E
		andi.w	#$007F, D0
		lsl.w	#$04, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		moveq	#$17, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
Offset_0x01BD2E:
		lsr.w	#$02, D0
		andi.w	#$001C, D0
		lea		Offset_0x01BCF4(PC, D0), A2
		move.b	(A2)+, Obj_Width(A0)					 ; $0007
		move.b	(A2)+, Obj_Height(A0)					 ; $0006
		move.b	(A2)+, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_X(A0), Obj_Control_Var_02(A0)		  ; $0010, $0032
		move.w	Obj_Y(A0), Obj_Control_Var_04(A0)		  ; $0014, $0034
		move.b	Obj_Status(A0), Obj_Timer(A0)			  ; $002A, $002E
		move.w	#$0280, Obj_Control_Var_12(A0)			 ; $0042
		move.w	Obj_X(A0), Obj_Height_3(A0)		  ; $0010, $0044
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		subq.w	#$08, D0
		bcs.s	Offset_0x01BD9E
		cmpi.w	#$0004, D0
		bcc.s	Offset_0x01BD92
		lsl.w	#$02, D0
		lea		(Oscillate_Data_Buffer+$2C).w, A2			 ; $FFFFFE8A
		lea		(A2, D0), A2
		tst.w	(A2)
		bpl.s	Offset_0x01BD9E
		bchg	#00, Obj_Timer(A0)				 ; $002E
		bra.s	Offset_0x01BD9E
Offset_0x01BD92:
		move.w	#$0380, Obj_Control_Var_12(A0)			 ; $0042
		addi.w	#$0100, Obj_Height_3(A0)				 ; $0044
Offset_0x01BD9E:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$0F, D0
		add.b	D0, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
		move.l	#Offset_0x01BDB2, (A0)
Offset_0x01BDB2:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x01BE18(PC, D0), D1
		jsr		Offset_0x01BE18(PC, D1)
		move.w	(A7)+, D4
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01BDDC
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		move.w	#$0009, D3
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
Offset_0x01BDDC:
		move.w	Obj_Height_3(A0), D0					 ; $0044
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmp.w	Obj_Control_Var_12(A0), D0				 ; $0042
		bhi.w	Offset_0x01BDF6
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01BDF6:
		tst.b	Obj_Control_Var_0D(A0)					 ; $003D
		beq.s	Offset_0x01BE06
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x01BE06:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01BE12
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01BE12:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x01BE18:
		dc.w	Offset_0x01BE50-Offset_0x01BE18
		dc.w	Offset_0x01BE88-Offset_0x01BE18
		dc.w	Offset_0x01BE94-Offset_0x01BE18
		dc.w	Offset_0x01BEB6-Offset_0x01BE18
		dc.w	Offset_0x01BEC2-Offset_0x01BE18
		dc.w	Offset_0x01BEE4-Offset_0x01BE18
		dc.w	Offset_0x01BEFE-Offset_0x01BE18
		dc.w	Offset_0x01BF1C-Offset_0x01BE18
		dc.w	Offset_0x01C138-Offset_0x01BE18
		dc.w	Offset_0x01C14A-Offset_0x01BE18
		dc.w	Offset_0x01C15A-Offset_0x01BE18
		dc.w	Offset_0x01C16A-Offset_0x01BE18
		dc.w	Offset_0x01BF6C-Offset_0x01BE18
		dc.w	Offset_0x01BFC8-Offset_0x01BE18
		dc.w	Offset_0x01BFF2-Offset_0x01BE18
;-------------------------------------------------------------------------------
Offset_0x01BE36:
		dc.w	Offset_0x01BE50-Offset_0x01BE36
		dc.w	Offset_0x01BE88-Offset_0x01BE36
		dc.w	Offset_0x01BE94-Offset_0x01BE36
		dc.w	Offset_0x01BEB6-Offset_0x01BE36
		dc.w	Offset_0x01BEC2-Offset_0x01BE36
		dc.w	Offset_0x01BEE4-Offset_0x01BE36
		dc.w	Offset_0x01BEFE-Offset_0x01BE36
		dc.w	Offset_0x01C0A4-Offset_0x01BE36
		dc.w	Offset_0x01C138-Offset_0x01BE36
		dc.w	Offset_0x01C14A-Offset_0x01BE36
		dc.w	Offset_0x01C15A-Offset_0x01BE36
		dc.w	Offset_0x01C16A-Offset_0x01BE36
		dc.w	Offset_0x01BF6C-Offset_0x01BE36
;-------------------------------------------------------------------------------
Offset_0x01BE50:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x01BE66
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x01BE72
		subq.b	#$04, Obj_Control_Var_0A(A0)			 ; $003A
		bra.s	Offset_0x01BE72
Offset_0x01BE66:
		cmpi.b	#$40, Obj_Control_Var_0A(A0)			 ; $003A
		beq.s	Offset_0x01BE72
		addq.b	#$04, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x01BE72:
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$06, D0
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x01BE88:
		move.w	#$0040, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$0A).w, D0			 ; $FFFFFE68
		bra.s	Offset_0x01BE9E
;-------------------------------------------------------------------------------
Offset_0x01BE94:
		move.w	#$0080, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
Offset_0x01BE9E:
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01BEAA
		neg.w	D0
		add.w	D1, D0
Offset_0x01BEAA:
		move.w	Obj_Control_Var_00(A0), D1				 ; $0030
		add.w	D0, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x01BEB6:
		move.w	#$0040, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$0A).w, D0			 ; $FFFFFE68
		bra.s	Offset_0x01BECC
;-------------------------------------------------------------------------------
Offset_0x01BEC2:
		move.w	#$0080, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
Offset_0x01BECC:
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01BED8
		neg.w	D0
		add.w	D1, D0
Offset_0x01BED8:
		move.w	Obj_Control_Var_04(A0), D1				 ; $0034
		sub.w	D0, D1
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x01BEE4:
		move.w	#$0080, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
		bsr.s	Offset_0x01BE9E
		move.w	#$0040, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
		lsr.b	#$01, D0
		bra.s	Offset_0x01BECC
;-------------------------------------------------------------------------------
Offset_0x01BEFE:
		move.w	#$0080, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
		neg.w	D0
		add.w	D1, D0
		bsr.s	Offset_0x01BE9E
		move.w	#$0040, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$1E).w, D0			 ; $FFFFFE7C
		lsr.b	#$01, D0
		bra.s	Offset_0x01BECC
;-------------------------------------------------------------------------------
Offset_0x01BF1C:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x01BF3C
		move.w	Obj_Control_Var_08(A0), D2				 ; $0038
		move.w	Obj_Control_Var_06(A0), D1				 ; $0036
		beq.s	Offset_0x01BF6A
		subq.w	#$04, D1
		bcc.s	Offset_0x01BF36
		moveq	#$00, D1
Offset_0x01BF36:
		move.w	D1, Obj_Control_Var_06(A0)				 ; $0036
		bra.s	Offset_0x01BF50
Offset_0x01BF3C:
		move.w	Obj_Control_Var_08(A0), D2				 ; $0038
		move.w	Obj_Control_Var_06(A0), D1				 ; $0036
		addq.w	#$02, D1
		cmp.w	D2, D1
		bcs.s	Offset_0x01BF4C
		move.w	D2, D1
Offset_0x01BF4C:
		move.w	D1, Obj_Control_Var_06(A0)				 ; $0036
Offset_0x01BF50:
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		sub.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	D0, Obj_Control_Var_00(A0)				 ; $0030
		lsr.w	#$01, D1
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		sub.w	D1, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x01BF6A:
		rts
;-------------------------------------------------------------------------------
Offset_0x01BF6C:
		move.w	#$007F, D2
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		bne.s	Offset_0x01BF92
		move.w	Obj_Control_Var_10(A0), D1				 ; $0040
		addq.w	#$04, D1
		move.w	D1, Obj_Control_Var_10(A0)				 ; $0040
		add.w	D1, Obj_Control_Var_06(A0)				 ; $0036
		cmp.b	Obj_Control_Var_06(A0), D2				 ; $0036
		bhi.s	Offset_0x01BFAC
		move.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bra.s	Offset_0x01BFAC
Offset_0x01BF92:
		move.w	Obj_Control_Var_10(A0), D1				 ; $0040
		subq.w	#$04, D1
		move.w	D1, Obj_Control_Var_10(A0)				 ; $0040
		add.w	D1, Obj_Control_Var_06(A0)				 ; $0036
		cmp.b	Obj_Control_Var_06(A0), D2				 ; $0036
		bls.s	Offset_0x01BFAC
		move.b	#$00, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x01BFAC:
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01BFBE
		neg.w	D0
		add.w	D2, D0
Offset_0x01BFBE:
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x01BFC8:
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		bne.s	Offset_0x01BFE0
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x01BFDE
		move.w	#$001E, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x01BFDE:
		rts
Offset_0x01BFE0:
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.s	Offset_0x01BFDE
		move.w	#$0020, Obj_Control_Var_0A(A0)			 ; $003A
		addq.b	#$02, Obj_Subtype(A0)					 ; $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x01BFF2:
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x01C020
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.s	Offset_0x01C020
		bclr	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C00C
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01C054
Offset_0x01C00C:
		bclr	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C01A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x01C054
Offset_0x01C01A:
		move.l	#Offset_0x01C06E, (A0)
Offset_0x01C020:
		move.l	Obj_Y(A0), D3					 ; $0014
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D3
		move.l	D3, Obj_Y(A0)					 ; $0014
		addi.w	#$0038, Obj_Speed_Y(A0)					 ; $001A
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$0120, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x01C052
		move.w	#$7F00, Obj_X(A0)				 ; $0010
		move.w	#$7F00, Obj_Height_3(A0)				 ; $0044
Offset_0x01C052:
		rts
Offset_0x01C054:
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x01C06E:
		move.l	Obj_Y(A0), D3					 ; $0014
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D3
		move.l	D3, Obj_Y(A0)					 ; $0014
		addi.w	#$0038, Obj_Speed_Y(A0)					 ; $001A
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$0120, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x01C0A0
		move.w	#$7F00, Obj_X(A0)				 ; $0010
		move.w	#$7F00, Obj_Height_3(A0)				 ; $0044
Offset_0x01C0A0:
		bra.w	Offset_0x01BDDC
;-------------------------------------------------------------------------------
Offset_0x01C0A4:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		bne.s	Offset_0x01C0C2
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x01C0C0
		move.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
Offset_0x01C0C0:
		rts
Offset_0x01C0C2:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		moveq	#$08, D1
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		subi.w	#$0080, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x01C0DE
		neg.w	D1
		add.w	D1, Obj_Speed_Y(A0)				 ; $001A
Offset_0x01C0DE:
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bpl.s	Offset_0x01C0F6
		sub.w	D1, Obj_Y(A0)					 ; $0014
		clr.b	Obj_Control_Var_0C(A0)					 ; $003C
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x01C0F6:
		btst	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C116
		move.l	A0, -(A7)
		lea		(Obj_Player_One).w, A0				 ; $FFFFB000
		jsr		(Offset_0x009C92).l
		tst.w	D1
		bpl.s	Offset_0x01C114
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
Offset_0x01C114:
		move.l	(A7)+, A0
Offset_0x01C116:
		btst	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01C136
		move.l	A0, -(A7)
		lea		(Obj_Player_Two).w, A0				 ; $FFFFB04A
		jsr		(Offset_0x009C92).l
		tst.w	D1
		bpl.s	Offset_0x01C134
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
Offset_0x01C134:
		move.l	(A7)+, A0
Offset_0x01C136:
		rts
;-------------------------------------------------------------------------------
Offset_0x01C138:
		move.w	#$0010, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$2A).w, D0			 ; $FFFFFE88
		lsr.w	#$01, D0
		move.w	(Oscillate_Data_Buffer+$2C).w, D3			 ; $FFFFFE8A
		bra.s	Offset_0x01C178
;-------------------------------------------------------------------------------
Offset_0x01C14A:
		move.w	#$0030, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$2E).w, D0			 ; $FFFFFE8C
		move.w	(Oscillate_Data_Buffer+$30).w, D3			 ; $FFFFFE8E
		bra.s	Offset_0x01C178
;-------------------------------------------------------------------------------
Offset_0x01C15A:
		move.w	#$0050, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$32).w, D0			 ; $FFFFFE90
		move.w	(Oscillate_Data_Buffer+$34).w, D3			 ; $FFFFFE92
		bra.s	Offset_0x01C178
;-------------------------------------------------------------------------------
Offset_0x01C16A:
		move.w	#$0070, D1
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$36).w, D0			 ; $FFFFFE94
		move.w	(Oscillate_Data_Buffer+$38).w, D3			 ; $FFFFFE96
;-------------------------------------------------------------------------------
Offset_0x01C178:
		tst.w	D3
		bne.s	Offset_0x01C186
		addq.b	#$01, Obj_Timer(A0)				 ; $002E
		andi.b	#$03, Obj_Timer(A0)				 ; $002E
Offset_0x01C186:
		move.b	Obj_Timer(A0), D2				 ; $002E
		andi.b	#$03, D2
		bne.s	Offset_0x01C1A6
		sub.w	D1, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		neg.w	D1
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
Offset_0x01C1A6:
		subq.b	#$01, D2
		bne.s	Offset_0x01C1C4
		subq.w	#$01, D1
		sub.w	D1, D0
		neg.w	D0
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		addq.w	#$01, D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		rts
Offset_0x01C1C4:
		subq.b	#$01, D2
		bne.s	Offset_0x01C1E2
		subq.w	#$01, D1
		sub.w	D1, D0
		neg.w	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		addq.w	#$01, D1
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
Offset_0x01C1E2:
		sub.w	D1, D0
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		neg.w	D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
LBz_Platform_Mappings:						   ; Offset_0x01C1F8
		dc.w	Offset_0x01C1FE-LBz_Platform_Mappings
		dc.w	Offset_0x01C20C-LBz_Platform_Mappings
		dc.w	Offset_0x01C21A-LBz_Platform_Mappings
Offset_0x01C1FE:
		dc.w	$0002
		dc.w	$F80D, $0000, $FFE0
		dc.w	$F80D, $0800, $0000
Offset_0x01C20C:
		dc.w	$0002
		dc.w	$F80D, $0008, $FFE0
		dc.w	$F80D, $0800, $0000
Offset_0x01C21A:
		dc.w	$0002
		dc.w	$040C, $0000, $FFE0
		dc.w	$040C, $0800, $0000
;===============================================================================
; Objeto 0x11 - Plataforma na Launch Base
; <<<-
;===============================================================================