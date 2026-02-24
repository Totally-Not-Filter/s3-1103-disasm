;===============================================================================
; Objeto 0x47 - Barril giratório na Carnival Night
; ->>>
;===============================================================================
Offset_0x028420:
		dc.b	$04, $E0, $06, $F0, $08, $70, $09, $C0
		dc.b	$0A, $E0, $0C, $00, $0C, $F0, $0D, $E0
;-------------------------------------------------------------------------------
Obj_0x47_CNz_Barrel:						   ; Offset_0x028430
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		lsr.b	#$03, D1
		andi.w	#$000E, D1
		move.w	Offset_0x028420(PC, D1), D1
		move.w	D1, Obj_Control_Var_0E(A0)				 ; $003E
		add.w	D0, D0
		andi.w	#$001E, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.l	#Barrel_Mappings, Obj_Map(A0)	; Offset_0x0288E8, $000C
		move.w	#$438E, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Timer(A0)		  ; $0010, $002E
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.b	#$0F, D0
		subi.b	#$0A, D0
		andi.b	#$03, D0
		move.b	D0, Obj_Height_3(A0)					 ; $0044
		andi.w	#$00F0, D1
		lsl.w	#$02, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0284A6
		neg.w	D1
Offset_0x0284A6:
		move.w	D1, Obj_Control_Var_16(A0)				 ; $0046
		move.l	#Offset_0x0284B0, (A0)
Offset_0x0284B0:
		bsr.s	Offset_0x028506
		lea		Obj_Control_Var_02(A0), A2				 ; $0032
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		bsr.w	Offset_0x0287E4
		addq.w	#$04, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		bsr.w	Offset_0x0287E4
		move.w	#$002B, D1
		move.w	#$0020, D2
		move.w	#$0021, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x028500
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x028500:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x028506:
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	Offset_0x028512(PC, D0), D0
		jmp		Offset_0x028512(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x028512:
		dc.w	Offset_0x02852C-Offset_0x028512
		dc.w	Offset_0x028614-Offset_0x028512
		dc.w	Offset_0x028632-Offset_0x028512
		dc.w	Offset_0x028650-Offset_0x028512
		dc.w	Offset_0x028674-Offset_0x028512
		dc.w	Offset_0x028692-Offset_0x028512
		dc.w	Offset_0x0286B0-Offset_0x028512
		dc.w	Offset_0x0286CE-Offset_0x028512
		dc.w	Offset_0x0286F2-Offset_0x028512
		dc.w	Offset_0x028710-Offset_0x028512
		dc.w	Offset_0x028710-Offset_0x028512
		dc.w	Offset_0x028710-Offset_0x028512
		dc.w	Offset_0x028710-Offset_0x028512
;-------------------------------------------------------------------------------
Offset_0x02852C:
		move.w	Obj_Control_Var_0C(A0), D1				 ; $003C
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		cmp.w	D1, D0
		beq.s	Offset_0x028578
		move.w	D0, Obj_Control_Var_0C(A0)				 ; $003C
		sub.w	D1, D0
		bcs.s	Offset_0x028578
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		bpl.s	Offset_0x02854C
		neg.w	D0
Offset_0x02854C:
		cmpi.w	#$0200, D0
		bcc.s	Offset_0x028578
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Control_Var_00(A0), D0				 ; $0030
		addi.w	#$0040, D0
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x028578
		addi.w	#$0400, Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		cmp.w	Obj_Speed_Y(A0), D0				 ; $001A
		bgt.s	Offset_0x028578
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
Offset_0x028578:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		moveq	#$00, D5
		btst	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02858C
		move.b	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
Offset_0x02858C:
		btst	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x028598
		or.b	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
Offset_0x028598:
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Control_Var_00(A0), D0				 ; $0030
		beq.s	Offset_0x0285FE
		bcc.s	Offset_0x0285D0
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		cmp.w	Obj_Speed_Y(A0), D0				 ; $001A
		ble.s	Offset_0x028612
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x0285C8
		btst	#$01, D5
		beq.s	Offset_0x0285CE
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x0285CE
Offset_0x0285C8:
		addi.w	#$0010, Obj_Speed_Y(A0)					 ; $001A
Offset_0x0285CE:
		bra.s	Offset_0x028612
Offset_0x0285D0:
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		neg.w	D0
		cmp.w	Obj_Speed_Y(A0), D0				 ; $001A
		bge.s	Offset_0x028612
		subi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bpl.s	Offset_0x0285F6
		btst	#$00, D5
		beq.s	Offset_0x0285FC
		subi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x0285FC
Offset_0x0285F6:
		subi.w	#$0010, Obj_Speed_Y(A0)					 ; $001A
Offset_0x0285FC:
		bra.s	Offset_0x028612
Offset_0x0285FE:
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		bpl.s	Offset_0x028606
		neg.w	D0
Offset_0x028606:
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x028612
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
Offset_0x028612:
		rts
;-------------------------------------------------------------------------------
Offset_0x028614:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$03, D0
		add.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x028632:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D0
		add.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x028650:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D0
		move.w	D0, D1
		asr.w	#$01, D0
		add.w	D1, D0
		add.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x028674:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		add.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x028692:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$03, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x0286B0:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x0286CE:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D0
		move.w	D0, D1
		asr.w	#$01, D0
		add.w	D1, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x0286F2:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		add.w	D0, Obj_Angle(A0)				 ; $0026
		rts

;-------------------------------------------------------------------------------
Offset_0x028710:
		move.w	Obj_Control_Var_16(A0), D0				 ; $0046
		bpl.s	Offset_0x028752
		add.w	D0, Obj_Angle(A0)				 ; $0026
		move.b	Obj_Angle(A0), D0				 ; $0026
		cmpi.b	#$80, D0
		bcc.s	Offset_0x02873A
		andi.b	#$7F, D0
		addi.b	#$80, D0
		move.b	D0, Obj_Angle(A0)				 ; $0026
		subq.b	#$01, Obj_Height_3(A0)					 ; $0044
		andi.b	#$03, Obj_Height_3(A0)					 ; $0044
Offset_0x02873A:
		move.w	#$0020, D2
		move.b	Obj_Angle(A0), D0				 ; $0026
		cmpi.b	#$80, D0
		bcc.s	Offset_0x02877A
		move.b	#$80, D0
		move.b	D0, Obj_Angle(A0)				 ; $0026
		bra.s	Offset_0x02877A
Offset_0x028752:
		add.w	D0, Obj_Angle(A0)				 ; $0026
		move.b	Obj_Angle(A0), D0				 ; $0026
		cmpi.b	#$80, D0
		bcc.s	Offset_0x028776
		andi.b	#$7F, D0
		addi.b	#$80, D0
		move.b	D0, Obj_Angle(A0)				 ; $0026
		addq.b	#$01, Obj_Height_3(A0)					 ; $0044
		andi.b	#$03, Obj_Height_3(A0)					 ; $0044
Offset_0x028776:
		move.w	#$0020, D2
Offset_0x02877A:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$03, D1
		move.b	Obj_Height_3(A0), D3					 ; $0044
		andi.b	#$03, D3
		bne.s	Offset_0x0287A0
		add.w	Obj_Timer(A0), D1				 ; $002E
		move.w	D1, Obj_X(A0)					 ; $0010
		neg.w	D2
		add.w	Obj_Control_Var_00(A0), D2				 ; $0030
		move.w	D2, Obj_Y(A0)					 ; $0014
		rts
Offset_0x0287A0:
		subq.b	#$01, D3
		bne.s	Offset_0x0287B6
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_Y(A0)					 ; $0014
		add.w	Obj_Timer(A0), D2				 ; $002E
		move.w	D2, Obj_X(A0)					 ; $0010
		rts
Offset_0x0287B6:
		subq.b	#$01, D3
		bne.s	Offset_0x0287CE
		neg.w	D1
		add.w	Obj_Timer(A0), D1				 ; $002E
		move.w	D1, Obj_X(A0)					 ; $0010
		add.w	Obj_Control_Var_00(A0), D2				 ; $0030
		move.w	D2, Obj_Y(A0)					 ; $0014
		rts
Offset_0x0287CE:
		neg.w	D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_Y(A0)					 ; $0014
		neg.w	D2
		add.w	Obj_Timer(A0), D2				 ; $002E
		move.w	D2, Obj_X(A0)					 ; $0010
		rts
Offset_0x0287E4:
		move.b	(A2), D0
		bne.s	Offset_0x028828
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x028826
		move.b	#$00, $0001(A2)
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		bpl.s	Offset_0x028806
		neg.w	D0
		move.b	#$80, $0001(A2)
Offset_0x028806:
		move.b	D0, $0002(A2)
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$01, (A2)
Offset_0x028826:
		rts
Offset_0x028828:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.w	Offset_0x0288E2
		moveq	#$00, D0
		move.b	$0001(A2), D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		addi.w	#$0100, D0
		asr.w	#$02, D0
		move.b	D0, $0003(A2)
		moveq	#$00, D2
		move.w	$0002(A2), D2
		muls.w	D2, D1
		swap	D1
		add.w	Obj_X(A0), D1					 ; $0010
		move.w	D1, Obj_X(A1)					 ; $0010
		addq.b	#$02, $0001(A2)
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		move.b	Obj_Control_Var_05(A0), D0				 ; $0035
		cmp.b	$0003(A2), D0
		bls.s	Offset_0x028872
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
Offset_0x028872:
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		bpl.s	Offset_0x028880
		neg.w	D0
Offset_0x028880:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x028894
		cmpi.w	#$0480, D0
		bcs.s	Offset_0x028894
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
Offset_0x028894:
		andi.b	#$70, D5
		beq.s	Offset_0x0288E6
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$01, Obj_Control_Var_10(A1)			 ; $0040
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
		addi.w	#$F980, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$00, Obj_Timer(A1)				 ; $002E
Offset_0x0288E2:
		move.b	#$00, (A2)
Offset_0x0288E6:
		rts
;-------------------------------------------------------------------------------
Barrel_Mappings:							   ; Offset_0x0288E8
		dc.w	Offset_0x0288F0-Barrel_Mappings
		dc.w	Offset_0x028922-Barrel_Mappings
		dc.w	Offset_0x028954-Barrel_Mappings
		dc.w	Offset_0x028986-Barrel_Mappings
Offset_0x0288F0:
		dc.w	$0008
		dc.w	$E00D, $0000, $FFE0
		dc.w	$E00D, $0008, $0000
		dc.w	$F00D, $1000, $FFE0
		dc.w	$F00D, $1008, $0000
		dc.w	$000D, $0000, $FFE0
		dc.w	$000D, $0008, $0000
		dc.w	$100D, $1000, $FFE0
		dc.w	$100D, $1008, $0000
Offset_0x028922:
		dc.w	$0008
		dc.w	$E00D, $0010, $FFE0
		dc.w	$E00D, $0018, $0000
		dc.w	$F00D, $1010, $FFE0
		dc.w	$F00D, $1018, $0000
		dc.w	$000D, $0010, $FFE0
		dc.w	$000D, $0018, $0000
		dc.w	$100D, $1010, $FFE0
		dc.w	$100D, $1018, $0000
Offset_0x028954:
		dc.w	$0008
		dc.w	$E00D, $0020, $FFE0
		dc.w	$E00D, $0028, $0000
		dc.w	$F00D, $1020, $FFE0
		dc.w	$F00D, $1028, $0000
		dc.w	$000D, $0020, $FFE0
		dc.w	$000D, $0028, $0000
		dc.w	$100D, $1020, $FFE0
		dc.w	$100D, $1028, $0000
Offset_0x028986:
		dc.w	$0008
		dc.w	$E00D, $0818, $FFE0
		dc.w	$E00D, $0810, $0000
		dc.w	$F00D, $1818, $FFE0
		dc.w	$F00D, $1810, $0000
		dc.w	$000D, $0818, $FFE0
		dc.w	$000D, $0810, $0000
		dc.w	$100D, $1818, $FFE0
		dc.w	$100D, $1810, $0000
;===============================================================================
; Objeto 0x47 - Barril giratório na Carnival Night
; <<<-
;===============================================================================