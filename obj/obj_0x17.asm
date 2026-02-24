;===============================================================================
; Objeto 0x17 - Gancho que o jogador se agarra na Launch Base
; ->>>
;===============================================================================
LBz_Hooked_Ride_Range:						   ; Offset_0x01D4C8
		dc.w	$0A08, $0C78
		dc.w	$1208, $14F8
		dc.w	$1A08, $1BB8
		dc.w	$1C48, $2078
		dc.w	$2688, $2878
		dc.w	$2988, $2DF8
		dc.w	$2F88, $3178
		dc.w	$0E68, $1098
		dc.w	$0CE8, $1498
		dc.w	$0E68, $1398
		dc.w	$20E8, $2418
		dc.w	$2B08, $2E98
		dc.w	$39E8, $3C98
;-------------------------------------------------------------------------------
Obj_0x17_LBz_Hooked_Ride:					   ; Offset_0x01D4FC
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_08(A0)		  ; $0010, $0038
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$007F, D0
		lsl.w	#$02, D0
		move.l	LBz_Hooked_Ride_Range(PC, D0), Obj_Control_Var_04(A0) ; Offset_0x01D4C8, $0034
		move.l	#Hooked_Ride_Mappings, Obj_Map(A0) ; Offset_0x01D8F8, $000C
		move.w	#$2433, Obj_Art_VRAM(A0)				 ; $000A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x01D5A2
		move.l	#Offset_0x01D6CA, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.w	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$20, Obj_Height(A1)					 ; $0006
		moveq	#$06, D1
		move.w	D1, Obj_Sub_Y(A1)				 ; $0016
		subq.b	#$01, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x01D588:
		move.w	Obj_X(A1), (A2)+				 ; $0010
		move.w	Obj_Y(A1), (A2)+				 ; $0014
		move.w	#$0001, (A2)+
		dbra	D1, Offset_0x01D588
		move.b	#$02, Obj_Map_Id(A1)					 ; $0022
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x01D5A2:
		move.l	#Offset_0x01D5A8, (A0)
Offset_0x01D5A8:
		bsr.w	Offset_0x01D7F6
		bsr.w	Offset_0x01D6D0
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x01D5C4
		cmpi.w	#$0028, Obj_Control_Var_0A(A0)			 ; $003A
		bne.s	Offset_0x01D5C4
		move.l	#Offset_0x01D618, (A0)
Offset_0x01D5C4:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x01D5DE
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01D5DE:
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x01D5F8
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01D5F8:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01D604
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01D604:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x01D612
		move.w	D0, A1
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x01D612:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x01D618:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01D63A
		subi.w	#$0020, Obj_Speed_X(A0)					 ; $0018
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x01D64C
		subi.w	#$0060, Obj_Speed_X(A0)					 ; $0018
		bra.s	Offset_0x01D64C
Offset_0x01D63A:
		addi.w	#$0020, Obj_Speed_X(A0)					 ; $0018
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x01D64C
		addi.w	#$0060, Obj_Speed_X(A0)					 ; $0018
Offset_0x01D64C:
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Control_Var_04(A0), D1				 ; $0034
		cmp.w	D1, D0
		bhi.s	Offset_0x01D66A
		move.w	D1, Obj_X(A0)					 ; $0010
		bsr.s	Offset_0x01D690
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x01D66A
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x01D66A:
		move.w	Obj_Control_Var_06(A0), D1				 ; $0036
		cmp.w	D1, D0
		bcs.s	Offset_0x01D684
		move.w	D1, Obj_X(A0)					 ; $0010
		bsr.s	Offset_0x01D690
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x01D684
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x01D684:
		bsr.w	Offset_0x01D7F6
		bsr.w	Offset_0x01D6D0
		bra.w	Offset_0x01D5C4
Offset_0x01D690:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bmi.s	Offset_0x01D6C8
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01D6A6
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.w	#$01, A2
Offset_0x01D6A6:
		tst.b	(A2)
		beq.s	Offset_0x01D6C8
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
Offset_0x01D6C8:
		rts
;-------------------------------------------------------------------------------
Offset_0x01D6CA:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x01D6D0:
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		lea		Obj_Control_Var_01(A0), A2				 ; $0031
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	(Control_Ports_Buffer_Data+$02).w, D0		 ; $FFFFF606
		bsr.s	Offset_0x01D6EC
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		subq.w	#$01, A2
		move.w	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
Offset_0x01D6EC:
		tst.b	(A2)
		beq.w	Offset_0x01D776
		tst.b	Obj_Flags(A1)					 ; $0004
		bpl.s	Offset_0x01D736
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x01D736
		andi.b	#$70, D0
		beq.w	Offset_0x01D744
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$12, $0002(A2)
		andi.w	#$0F00, D0
		beq.w	Offset_0x01D722
		move.b	#$3C, $0002(A2)
Offset_0x01D722:
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	#$FC80, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		rts
Offset_0x01D736:
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		rts
Offset_0x01D744:
		btst	#$0A, D0
		beq.s	Offset_0x01D750
		bset	#$00, Obj_Status(A1)					 ; $002A
Offset_0x01D750:
		btst	#$0B, D0
		beq.s	Offset_0x01D75C
		bclr	#$00, Obj_Status(A1)					 ; $002A
Offset_0x01D75C:
		move.b	Obj_Status(A1), Obj_Status(A0)			  ; $002A, $002A
		move.w	Obj_X(A3), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A3), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0024, Obj_Y(A1)				 ; $0014
		rts
Offset_0x01D776:
		tst.b	$0002(A2)
		beq.s	Offset_0x01D784
		subq.b	#$01, $0002(A2)
		bne.w	Offset_0x01D7F4
Offset_0x01D784:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.w	Offset_0x01D7F4
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		subi.w	#$0018, D1
		cmpi.w	#$0018, D1
		bcc.w	Offset_0x01D7F4
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x01D7F4
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x01D7F4
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x01D7F4
		move.b	Obj_Status(A1), Obj_Status(A0)			  ; $002A, $002A
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0024, Obj_Y(A1)				 ; $0014
		move.b	#$14, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$01, (A2)
Offset_0x01D7F4:
		rts
;-------------------------------------------------------------------------------
Offset_0x01D7F6:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x01D80A
		move.w	Obj_Control_Var_0A(A0), D2				 ; $003A
		cmpi.w	#$0028, D2
		beq.s	Offset_0x01D830
		addq.w	#$01, D2
		bra.s	Offset_0x01D82C
Offset_0x01D80A:
		move.w	Obj_Control_Var_0A(A0), D2				 ; $003A
		beq.s	Offset_0x01D814
		subq.w	#$01, D2
		bne.s	Offset_0x01D82C
Offset_0x01D814:
		clr.w	Obj_Angle(A0)					 ; $0026
		clr.b	Obj_Control_Var_10(A0)					 ; $0040
		clr.w	Obj_Control_Var_0E(A0)					 ; $003E
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x01D5A8, (A0)
Offset_0x01D82C:
		move.w	D2, Obj_Control_Var_0A(A0)				 ; $003A
Offset_0x01D830:
		mulu.w	#$0033, D2
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		bne.s	Offset_0x01D874
		tst.b	Obj_Control_Var_10(A0)					 ; $0040
		bne.s	Offset_0x01D85A
		move.w	Obj_Control_Var_0E(A0), D1				 ; $003E
		addi.w	#$0040, D1
		move.w	D1, Obj_Control_Var_0E(A0)				 ; $003E
		add.w	D1, Obj_Angle(A0)				 ; $0026
		bmi.s	Offset_0x01D872
		move.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		bra.s	Offset_0x01D872
Offset_0x01D85A:
		move.w	Obj_Control_Var_0E(A0), D1				 ; $003E
		subi.w	#$0040, D1
		move.w	D1, Obj_Control_Var_0E(A0)				 ; $003E
		add.w	D1, Obj_Angle(A0)				 ; $0026
		bpl.s	Offset_0x01D872
		move.b	#$00, Obj_Control_Var_10(A0)			 ; $0040
Offset_0x01D872:
		bra.s	Offset_0x01D8B4
Offset_0x01D874:
		neg.w	D0
		asl.w	#$02, D0
		sub.w	Obj_Angle(A0), D0				 ; $0026
		bge.s	Offset_0x01D88E
		cmpi.w	#$D000, Obj_Angle(A0)					 ; $0026
		ble.s	Offset_0x01D88E
		subi.w	#$0180, Obj_Angle(A0)					 ; $0026
		bra.s	Offset_0x01D89C
Offset_0x01D88E:
		cmpi.w	#$3000, Obj_Angle(A0)					 ; $0026
		bge.s	Offset_0x01D89C
		addi.w	#$0180, Obj_Angle(A0)					 ; $0026
Offset_0x01D89C:
		move.b	#$00, Obj_Control_Var_10(A0)			 ; $0040
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x01D8AE
		move.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
Offset_0x01D8AE:
		move.w	#$0000, Obj_Control_Var_0E(A0)			 ; $003E
Offset_0x01D8B4:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	D2, D0
		muls.w	D2, D1
		move.l	Obj_X(A0), D2					 ; $0010
		move.l	Obj_Y(A0), D3					 ; $0014
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		moveq	#$05, D4
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x01D8D4:
		swap	D2
		swap	D3
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		addq.w	#$02, A2
		swap	D2
		swap	D3
		add.l	D0, D2
		add.l	D1, D3
		dbra	D4, Offset_0x01D8D4
		move.w	Obj_Control_Var_06(A1), Obj_X(A1)		  ; $0036, $0010
		move.w	Obj_Control_Var_08(A1), Obj_Y(A1)		  ; $0038, $0014
		rts
;-------------------------------------------------------------------------------
Hooked_Ride_Mappings:						   ; Offset_0x01D8F8
		dc.w	Offset_0x01D8FE-Hooked_Ride_Mappings
		dc.w	Offset_0x01D906-Hooked_Ride_Mappings
		dc.w	Offset_0x01D90E-Hooked_Ride_Mappings
Offset_0x01D8FE:
		dc.w	$0001
		dc.w	$F005, $0000, $FFF8
Offset_0x01D906:
		dc.w	$0001
		dc.w	$FC00, $0004, $FFFC
Offset_0x01D90E:
		dc.w	$0001
		dc.w	$0005, $0005, $FFF8
;===============================================================================
; Objeto 0x17 - Gancho que o jogador se agarra na Launch Base
; <<<-
;===============================================================================