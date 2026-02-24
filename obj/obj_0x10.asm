;===============================================================================
; Objeto 0x10 - Tubos transportadores na Launch Base
; ->>>
;===============================================================================
; Offset_0x020856:
		move.l	#Tube_Elevator_Mappings, Obj_Map(A0) ; Offset_0x020D4E, $000C
		move.w	#$2455, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$30, Obj_Height(A0)					 ; $0006
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Height_3(A0)		  ; $0010, $0044
		move.w	Obj_Y(A0), Obj_Control_Var_16(A0)		  ; $0014, $0046
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02089E
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x020916, (A0)
		bra.s	Offset_0x020916
Offset_0x02089E:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x0208EA
		move.l	#Offset_0x020998, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#Tube_Elevator_Mappings, Obj_Map(A1) ; Offset_0x020D4E, $000C
		move.w	#$2455, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		ori.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.b	#$06, Obj_Map_Id(A1)					 ; $0022
		move.w	A0, Obj_Control_Var_12(A1)				 ; $0042
Offset_0x0208EA:
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x0208F6, (A0)
Offset_0x0208F6:
		bsr.w	Offset_0x0209CE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_08(A0), A2				 ; $0038
		bsr.w	Offset_0x020C6A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.w	#$01, A2
		bsr.w	Offset_0x020C6A
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x020916:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x02093A
		tst.b	Obj_Timer(A1)					 ; $002E
		beq.s	Offset_0x02093A
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x0208F6, (A2)
		bne.s	Offset_0x02093A
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x02093A:
		lea		Obj_Timer(A0), A4				 ; $002E
		addq.b	#$02, $0001(A4)
		move.b	$0001(A4), D0
		cmpi.b	#$B0, D0
		bcs.s	Offset_0x020956
		cmpi.b	#$D0, D0
		bcc.s	Offset_0x020956
		addi.b	#$20, D0
Offset_0x020956:
		move.b	D0, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		cmpi.w	#$0100, D0
		bne.s	Offset_0x020968
		subq.w	#$01, D0
Offset_0x020968:
		asr.w	#$06, D0
		move.w	Obj_Control_Var_16(A0), D2				 ; $0046
		sub.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x020998:
		move.w	Obj_Control_Var_12(A0), A1				 ; $0042
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		tst.b	Obj_Flags(A1)					 ; $0004
		bpl.s	Offset_0x0209C2
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		move.b	Offset_0x0209C8(PC, D0), D0
		ext.w	D0
		add.w	Obj_X(A1), D0					 ; $0010
		move.w	D0, Obj_X(A0)					 ; $0010
Offset_0x0209C2:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x0209C8:
		dc.b	$00, $F8, $F8, $00, $08, $08
;-------------------------------------------------------------------------------
Offset_0x0209CE:
		lea		Obj_Timer(A0), A4				 ; $002E
		move.l	A0, A1
		moveq	#$00, D0
		move.b	(A4), D0
		move.w	Offset_0x0209E0(PC, D0), D0
		jmp		Offset_0x0209E0(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x0209E0:
		dc.w	Offset_0x0209EE-Offset_0x0209E0
		dc.w	Offset_0x020A5E-Offset_0x0209E0
		dc.w	Offset_0x020ACE-Offset_0x0209E0
		dc.w	Offset_0x020B54-Offset_0x0209E0
		dc.w	Offset_0x020B8E-Offset_0x0209E0
		dc.w	Offset_0x020BF4-Offset_0x0209E0
		dc.w	Offset_0x020C14-Offset_0x0209E0
;-------------------------------------------------------------------------------
Offset_0x0209EE:
		cmpi.w	#$0200, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0209FE
		cmpi.w	#$0202, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x020A0A
Offset_0x0209FE:
		addq.b	#$02, (A4)
		moveq	#Rolling_Sfx, D0				   ; $3C
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x020A5E
Offset_0x020A0A:
		addq.b	#$02, $0001(A4)
		move.b	$0001(A4), D0
		cmpi.b	#$B0, D0
		bcs.s	Offset_0x020A22
		cmpi.b	#$D0, D0
		bcc.s	Offset_0x020A22
		addi.b	#$20, D0
Offset_0x020A22:
		move.b	D0, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		cmpi.w	#$0100, D0
		bne.s	Offset_0x020A34
		subq.w	#$01, D0
Offset_0x020A34:
		asr.w	#$06, D0
		move.w	Obj_Control_Var_16(A0), D2				 ; $0046
		sub.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		move.w	#$0008, D2
		move.w	#$0020, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_Offset).l		   ; Offset_0x013720
		rts
;-------------------------------------------------------------------------------
Offset_0x020A5E:
		move.w	Obj_Map_Id(A0), D0				 ; $0022
		sub.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcc.s	Offset_0x020A6C
		addi.w	#$0600, D0
Offset_0x020A6C:
		move.w	D0, Obj_Map_Id(A0)				 ; $0022
		cmpi.w	#$0140, Obj_Control_Var_0C(A0)			 ; $003C
		bcc.s	Offset_0x020AB6
		addq.w	#$02, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x020A7C:
		move.b	$0001(A4), D0
		addq.b	#$02, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$06, D0
		move.w	Obj_Control_Var_16(A0), D2				 ; $0046
		sub.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		rts
Offset_0x020AB6:
		addq.b	#$02, (A4)
		move.w	#$0140, Obj_Control_Var_0C(A0)			 ; $003C
		clr.b	$0001(A4)
		bsr.w	Offset_0x02036A
		move.b	#$01, (Fast_Vertical_Scroll_Flag).w			 ; $FFFFEE39
		bra.s	Offset_0x020A7C
;-------------------------------------------------------------------------------
Offset_0x020ACE:
		move.w	Obj_Map_Id(A0), D0				 ; $0022
		sub.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcc.s	Offset_0x020ADC
		addi.w	#$0600, D0
Offset_0x020ADC:
		move.w	D0, Obj_Map_Id(A0)				 ; $0022
		subq.b	#$01, $0002(A4)
		bhi.w	Offset_0x020B2E
		move.l	$0006(A4), A2
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
		move.l	A2, $0006(A4)
		subq.w	#$04, $0004(A4)
		beq.s	Offset_0x020B0E
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	#$1000, D2
		bra.w	Offset_0x0203D0
Offset_0x020B0E:
		addq.b	#$02, (A4)
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_Y(A0), Obj_Control_Var_16(A0)		   ; $0014, $0046
		clr.b	$0001(A4)
		move.b	#$00, (Fast_Vertical_Scroll_Flag).w			 ; $FFFFEE39
		rts
Offset_0x020B2E:
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
;-------------------------------------------------------------------------------
Offset_0x020B54:
		move.w	Obj_Map_Id(A0), D0				 ; $0022
		sub.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcc.s	Offset_0x020B62
		addi.w	#$0600, D0
Offset_0x020B62:
		move.w	D0, Obj_Map_Id(A0)				 ; $0022
		cmpi.w	#$0004, Obj_Control_Var_0C(A0)			 ; $003C
		bne.s	Offset_0x020B8A
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x020B8E
		addq.b	#$02, (A4)
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x020B88
		move.w	D0, A2
		bclr	#$07, (A2)
		clr.w	Obj_Respaw_Ref(A0)				 ; $0048
Offset_0x020B88:
		bra.s	Offset_0x020B8E
Offset_0x020B8A:
		subq.w	#$04, Obj_Control_Var_0C(A0)			 ; $003C
;-------------------------------------------------------------------------------
Offset_0x020B8E:
		addq.b	#$02, $0001(A4)
		move.b	$0001(A4), D0
		cmpi.b	#$B0, D0
		bcs.s	Offset_0x020BA6
		cmpi.b	#$D0, D0
		bcc.s	Offset_0x020BA6
		addi.b	#$20, D0
Offset_0x020BA6:
		move.b	D0, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		cmpi.w	#$0100, D0
		bne.s	Offset_0x020BB8
		subq.w	#$01, D0
Offset_0x020BB8:
		asr.w	#$06, D0
		move.w	Obj_Control_Var_16(A0), D2				 ; $0046
		sub.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		move.w	#$0008, D2
		move.w	#$0020, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_Offset).l		   ; Offset_0x013720
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x020BF2
		addq.b	#$02, (A4)
		move.b	#$00, Obj_Ani_Time(A0)					 ; $0024
Offset_0x020BF2:
		rts
;-------------------------------------------------------------------------------
Offset_0x020BF4:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x020C14
		move.b	#$0F, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$06, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x020C14
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		addq.b	#$02, (A4)
;-------------------------------------------------------------------------------
Offset_0x020C14:
		addq.b	#$02, $0001(A4)
		move.b	$0001(A4), D0
		cmpi.b	#$B0, D0
		bcs.s	Offset_0x020C2C
		cmpi.b	#$D0, D0
		bcc.s	Offset_0x020C2C
		addi.b	#$20, D0
Offset_0x020C2C:
		move.b	D0, $0001(A4)
		jsr		(CalcSine).l					 ; Offset_0x001B20
		cmpi.w	#$0100, D0
		bne.s	Offset_0x020C3E
		subq.w	#$01, D0
Offset_0x020C3E:
		asr.w	#$06, D0
		move.w	Obj_Control_Var_16(A0), D2				 ; $0046
		sub.w	D0, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		rts
Offset_0x020C6A:
		move.b	(A2), D0
		bne.w	Offset_0x020D1A
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x020D18
		cmpa.w	#Obj_Player_Two, A1				 ; $B04A
		bne.s	Offset_0x020C8C
		btst	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x020C8C
		tst.b	-1(A2)
		bne.s	Offset_0x020CC8
Offset_0x020C8C:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addq.w	#$03, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x020CA2
		addi.w	#$000A, D0
Offset_0x020CA2:
		cmpi.w	#$0010, D0
		bcc.s	Offset_0x020D18
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0020, D1
		cmpi.w	#$0040, D1
		bcc.s	Offset_0x020D18
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x020D18
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x020D18
Offset_0x020CC8:
		addq.b	#$02, (A2)
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bclr	#$01, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0018, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		sub.w	D1, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x020D18:
		rts
Offset_0x020D1A:
		subq.b	#$02, D0
		bne.w	Offset_0x020D4C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0018, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		sub.w	D1, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		cmpi.b	#$08, Obj_Timer(A0)				 ; $002E
		bne.s	Offset_0x020D4A
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		addq.b	#$02, (A2)
Offset_0x020D4A:
		rts
Offset_0x020D4C:
		rts
;-------------------------------------------------------------------------------
Tube_Elevator_Mappings:						   ; Offset_0x020D4E
		dc.w	Offset_0x020D5C-Tube_Elevator_Mappings
		dc.w	Offset_0x020D9A-Tube_Elevator_Mappings
		dc.w	Offset_0x020DD8-Tube_Elevator_Mappings
		dc.w	Offset_0x020E04-Tube_Elevator_Mappings
		dc.w	Offset_0x020E42-Tube_Elevator_Mappings
		dc.w	Offset_0x020E6E-Tube_Elevator_Mappings
		dc.w	Offset_0x020EAC-Tube_Elevator_Mappings
Offset_0x020D5C:
		dc.w	$000A
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E809, $0009, $FFE8
		dc.w	$E809, $0809, $0000
		dc.w	$F809, $000F, $FFE8
		dc.w	$F809, $080F, $0000
		dc.w	$0809, $1009, $FFE8
		dc.w	$0809, $1809, $0000
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020D9A:
		dc.w	$000A
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E809, $0809, $0000
		dc.w	$E801, $0015, $FFF8
		dc.w	$F809, $0017, $0000
		dc.w	$F801, $001D, $FFF8
		dc.w	$0809, $1809, $0000
		dc.w	$0801, $1015, $FFF8
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020DD8:
		dc.w	$0007
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E805, $001F, $0008
		dc.w	$F805, $0023, $0008
		dc.w	$0805, $0027, $0008
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020E04:
		dc.w	$000A
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E801, $002B, $FFE8
		dc.w	$E801, $082B, $0010
		dc.w	$F801, $002D, $FFE8
		dc.w	$F801, $082C, $0010
		dc.w	$0801, $002C, $FFE8
		dc.w	$0801, $082C, $0010
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020E42:
		dc.w	$0007
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E805, $081F, $FFE8
		dc.w	$F805, $0823, $FFE8
		dc.w	$0805, $0827, $FFE8
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020E6E:
		dc.w	$000A
		dc.w	$D00A, $0000, $FFE8
		dc.w	$D00A, $0800, $0000
		dc.w	$E809, $0009, $FFE8
		dc.w	$E801, $0815, $0000
		dc.w	$F809, $0817, $FFE8
		dc.w	$F801, $081D, $0000
		dc.w	$0809, $1009, $FFE8
		dc.w	$0801, $1815, $0000
		dc.w	$180A, $1000, $FFE8
		dc.w	$180A, $1800, $0000
Offset_0x020EAC:
		dc.w	$0003
		dc.w	$E80D, $0037, $FFF0
		dc.w	$F80D, $0037, $FFF0
		dc.w	$080D, $0037, $FFF0
;===============================================================================
; Objeto 0x10 - Tubos transportadores na Launch Base
; <<<-
;===============================================================================