;===============================================================================
; Objeto 0x5F - Mola retrátil usada no modo 2 jogadores
; ->>>
;===============================================================================
Offset_0x019FD6:
		dc.b	$0C, $08, $00, $01, $0C, $08, $00, $00
		dc.b	$0C, $08, $00, $01, $08, $0C, $01, $00
		dc.b	$0C, $08, $02, $01, $0C, $08, $03, $01
		dc.b	$0C, $08, $02, $01, $0C, $08, $03, $01
;-------------------------------------------------------------------------------
Obj_0x5F_Retracting_Spring:					   ; Offset_0x019FF6
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01A0CC
		move.l	#Offset_0x01A38E, (A1)
		move.l	#Retracting_Spring_Mappings, Obj_Map(A1) ; Offset_0x01A408, $000C
		move.w	#$0391, Obj_Art_VRAM(A1)				 ; $000A
		cmpi.b	#EMz_Id, (Current_Zone).w			; $12, $FFFFFE10
		bne.s	Offset_0x01A024
		move.l	#EMz_Retracting_Spring_Mappings, Obj_Map(A1) ; Offset_0x01A410, $000C
Offset_0x01A024:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, Obj_Subtype(A1)				 ; $002C
		lsr.b	#$02, D0
		andi.w	#$001C, D0
		lea		Offset_0x019FD6(PC, D0), A2
		move.b	(A2)+, Obj_Width(A1)					 ; $0007
		move.b	(A2)+, Obj_Height(A1)					 ; $0006
		move.b	(A2)+, D0
		move.b	D0, Obj_Map_Id(A1)				 ; $0022
		bne.s	Offset_0x01A04C
		move.l	#Offset_0x01A3E8, (A1)
Offset_0x01A04C:
		andi.b	#$F0, Obj_Subtype(A0)					 ; $002C
		move.b	(A2)+, D1
		or.b	D1, Obj_Subtype(A0)				 ; $002C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		moveq	#$00, D2
		moveq	#$00, D3
		cmpi.b	#$01, D0
		bne.s	Offset_0x01A07E
		moveq	#$0C, D2
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01A07A
		neg.w	D2
Offset_0x01A07A:
		add.w	D2, Obj_X(A1)					 ; $0010
Offset_0x01A07E:
		cmpi.b	#$02, D0
		bne.s	Offset_0x01A08A
		moveq	#$0B, D3
		add.w	D3, Obj_Y(A1)					 ; $0014
Offset_0x01A08A:
		cmpi.b	#$03, D0
		bne.s	Offset_0x01A096
		moveq	#-$0B, D3
		add.w	D3, Obj_Y(A1)					 ; $0014
Offset_0x01A096:
		move.w	D2, Obj_Control_Var_00(A1)				 ; $0030
		move.w	D3, Obj_Control_Var_02(A1)				 ; $0032
		bclr	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01A0AC
		move.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x01A0AC:
		move.b	Obj_Status(A0), Obj_Status(A1)			  ; $002A, $002A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		ori.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.w	A0, Obj_Control_Var_0E(A1)				 ; $003E
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
Offset_0x01A0CC:
		bsr.w	Obj_0x07_Springs_2P			   ; Offset_0x019268
Offset_0x01A0D0:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$03, D0
		andi.w	#$000E, D0
		move.w	Offset_0x01A0E2(PC, D0), D1
		jmp		Offset_0x01A0E2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01A0E2:
		dc.w	Offset_0x01A0F2-Offset_0x01A0E2
		dc.w	Offset_0x01A10E-Offset_0x01A0E2
		dc.w	Offset_0x01A12A-Offset_0x01A0E2
		dc.w	Offset_0x01A146-Offset_0x01A0E2
		dc.w	Offset_0x01A162-Offset_0x01A0E2
		dc.w	Offset_0x01A17E-Offset_0x01A0E2
		dc.w	Offset_0x01A162-Offset_0x01A0E2
		dc.w	Offset_0x01A17E-Offset_0x01A0E2
;-------------------------------------------------------------------------------
Offset_0x01A0F2:
		move.l	#Offset_0x01A0F8, (A0)
Offset_0x01A0F8:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x01943A
;-------------------------------------------------------------------------------
Offset_0x01A10E:
		move.l	#Offset_0x01A114, (A0)
Offset_0x01A114:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		bra.w	Offset_0x0195C2
;-------------------------------------------------------------------------------
Offset_0x01A12A:
		move.l	#Offset_0x01A130, (A0)
Offset_0x01A130:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x019852
;-------------------------------------------------------------------------------
Offset_0x01A146:
		move.l	#Offset_0x01A14C, (A0)
Offset_0x01A14C:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x0195C2
;-------------------------------------------------------------------------------
Offset_0x01A162:
		move.l	#Offset_0x01A168, (A0)
Offset_0x01A168:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		bra.w	Offset_0x01943A
;-------------------------------------------------------------------------------
Offset_0x01A17E:
		move.l	#Offset_0x01A184, (A0)
Offset_0x01A184:
		bsr.w	Offset_0x01A19A
		moveq	#$00, D0
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_X(A0)					 ; $0010
		bra.w	Offset_0x019852
Offset_0x01A19A:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x01A200
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x01A1BC
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.s	Offset_0x01A1FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01A1FE
		moveq	#Spike_Move_Sfx, D0				   ; $58
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x01A1FE
Offset_0x01A1BC:
		tst.w	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x01A1DE
		subi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		bcc.s	Offset_0x01A1FE
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0000, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003C, Obj_Control_Var_0A(A0)			 ; $003A
		bra.s	Offset_0x01A1FE
Offset_0x01A1DE:
		addi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		cmpi.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		bcs.s	Offset_0x01A1FE
		move.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0001, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003C, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x01A1FE:
		rts
Offset_0x01A200:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.w	Offset_0x01A2CA
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x01A220
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.w	Offset_0x01A2C8
		move.w	#$0000, Obj_Control_Var_08(A0)			 ; $0038
		bra.w	Offset_0x01A2C8
Offset_0x01A220:
		tst.w	Obj_Control_Var_08(A0)					 ; $0038
		bne.w	Offset_0x01A2AE
		tst.w	Obj_Control_Var_06(A0)					 ; $0036
		beq.w	Offset_0x01A2C8
		subi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		bhi.w	Offset_0x01A2C8
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$F0, D0
		cmpi.b	#$E0, D0
		bne.s	Offset_0x01A27A
		addi.w	#$0016, Obj_Y(A0)				 ; $0014
		bchg	#01, Obj_Status(A0)				 ; $002A
		bchg	#01, Obj_Flags(A0)				 ; $0004
		andi.b	#$0F, Obj_Subtype(A0)					 ; $002C
		ori.b	#$F0, Obj_Subtype(A0)					 ; $002C
		move.l	#Offset_0x01A0D0, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		neg.w	Obj_Control_Var_02(A1)					 ; $0032
Offset_0x01A27A:
		cmpi.b	#$F0, D0
		bne.s	Offset_0x01A2AC
		subi.w	#$0016, Obj_Y(A0)				 ; $0014
		bchg	#01, Obj_Status(A0)				 ; $002A
		bchg	#01, Obj_Flags(A0)				 ; $0004
		andi.b	#$0F, Obj_Subtype(A0)					 ; $002C
		ori.b	#$E0, Obj_Subtype(A0)					 ; $002C
		move.l	#Offset_0x01A0D0, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		neg.w	Obj_Control_Var_02(A1)					 ; $0032
Offset_0x01A2AC:
		bra.s	Offset_0x01A2C8
Offset_0x01A2AE:
		addi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		cmpi.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		bcs.s	Offset_0x01A2C8
		move.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$00B4, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x01A2C8:
		rts
Offset_0x01A2CA:
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x01A2E2
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bne.w	Offset_0x01A38C
		move.w	#$0000, Obj_Control_Var_08(A0)			 ; $0038
		bra.w	Offset_0x01A38C
Offset_0x01A2E2:
		tst.w	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x01A302
		subi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		bcc.w	Offset_0x01A38C
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$00B4, Obj_Control_Var_0A(A0)			 ; $003A
		bra.w	Offset_0x01A38C
Offset_0x01A302:
		cmpi.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		beq.w	Offset_0x01A38C
		addi.w	#$0800, Obj_Control_Var_06(A0)			 ; $0036
		cmpi.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		bcs.s	Offset_0x01A38C
		move.w	#$1800, Obj_Control_Var_06(A0)			 ; $0036
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$F0, D0
		cmpi.b	#$E0, D0
		bne.s	Offset_0x01A35A
		addi.w	#$0016, Obj_Y(A0)				 ; $0014
		bchg	#01, Obj_Status(A0)				 ; $002A
		bchg	#01, Obj_Flags(A0)				 ; $0004
		andi.b	#$0F, Obj_Subtype(A0)					 ; $002C
		ori.b	#$F0, Obj_Subtype(A0)					 ; $002C
		move.l	#Offset_0x01A0D0, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		neg.w	Obj_Control_Var_02(A1)					 ; $0032
Offset_0x01A35A:
		cmpi.b	#$F0, D0
		bne.s	Offset_0x01A38C
		subi.w	#$0016, Obj_Y(A0)				 ; $0014
		bchg	#01, Obj_Status(A0)				 ; $002A
		bchg	#01, Obj_Flags(A0)				 ; $0004
		andi.b	#$0F, Obj_Subtype(A0)					 ; $002C
		ori.b	#$E0, Obj_Subtype(A0)					 ; $002C
		move.l	#Offset_0x01A0D0, (A0)
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		neg.w	Obj_Control_Var_02(A1)					 ; $0032
Offset_0x01A38C:
		rts
;-------------------------------------------------------------------------------
Offset_0x01A38E:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_X(A1), D2					 ; $0010
		move.w	Obj_Y(A1), D3					 ; $0014
		add.w	Obj_Control_Var_00(A0), D2				 ; $0030
		add.w	Obj_Control_Var_02(A0), D3				 ; $0032
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D3, Obj_Y(A0)					 ; $0014
		move.b	Obj_Subtype(A0), D1				 ; $002C
		bpl.s	Offset_0x01A3C4
		andi.w	#$000F, D1
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D1)
		beq.s	Offset_0x01A3C4
		move.w	#$0001, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x01A3C4:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$0007, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x01A3E8:
		move.b	Obj_Subtype(A0), D1				 ; $002C
		bpl.s	Offset_0x01A406
		andi.w	#$000F, D1
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D1)
		beq.s	Offset_0x01A406
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	#$0001, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x01A406:
		rts
;-------------------------------------------------------------------------------
Retracting_Spring_Mappings:					   ; Offset_0x01A408
		dc.w	Offset_0x01A418-Retracting_Spring_Mappings
		dc.w	Offset_0x01A41A-Retracting_Spring_Mappings
		dc.w	Offset_0x01A422-Retracting_Spring_Mappings
		dc.w	Offset_0x01A422-Retracting_Spring_Mappings
;-------------------------------------------------------------------------------
EMz_Retracting_Spring_Mappings:				   ; Offset_0x01A410
		dc.w	Offset_0x01A418-EMz_Retracting_Spring_Mappings
		dc.w	Offset_0x01A42A-EMz_Retracting_Spring_Mappings
		dc.w	Offset_0x01A422-EMz_Retracting_Spring_Mappings
		dc.w	Offset_0x01A422-EMz_Retracting_Spring_Mappings
Offset_0x01A418:
		dc.w	$0000
Offset_0x01A41A:
		dc.w	$0001
		dc.w	$F406, $082F, $FFF8
Offset_0x01A422:
		dc.w	$0001
		dc.w	$F809, $600D, $FFF4
Offset_0x01A42A:
		dc.w	$0001
		dc.w	$F40A, $4774, $FFF0
;===============================================================================
; Objeto 0x5F - Mola retrátil usada no modo 2 jogadores
; <<<-
;===============================================================================