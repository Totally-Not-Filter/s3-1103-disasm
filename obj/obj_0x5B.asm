;===============================================================================
; Objeto 0x5B - Plataforma em forma de pião giratória na Marble Garden.
; ->>>
;===============================================================================
; Offset_0x02B19A:
		move.l	#Blue_Spinning_Platform_Mappings, Obj_Map(A0) ; Offset_0x02BEA8, $000C
		move.w	#$235F, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.b	#$1F, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		move.b	#$1F, Obj_Height_3(A0)					 ; $0044
		move.b	#$18, Obj_Width_3(A0)					 ; $0045
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$0C, Obj_Player_Top_Solid(A0)			 ; $0046
		move.b	#$0D, Obj_Player_LRB_Solid(A0)			 ; $0047
		move.l	#Offset_0x02B1F6, (A0)
Offset_0x02B1F6:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_10(A0), A4				 ; $0040
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		moveq	#$03, D6
		bsr.w	Offset_0x02B488
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_12(A0), A4				 ; $0042
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		moveq	#$04, D6
		bsr.w	Offset_0x02B488
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.w	Offset_0x02B2FE
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.w	Offset_0x02B2AA
		cmpi.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		bge.s	Offset_0x02B23A
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
Offset_0x02B23A:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		subi.w	#$0013, Obj_Y(A0)				 ; $0014
		move.l	A1, -(A7)
		jsr		(Offset_0x02B7AE).l
		move.l	(A7)+, A1
		addi.w	#$0013, Obj_Y(A0)				 ; $0014
		tst.b	Obj_Flags_2(A0)					 ; $002D
		beq.s	Offset_0x02B26C
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		bclr	#$01, Obj_Status(A0)					 ; $002A
		bra.w	Offset_0x02B2FE
Offset_0x02B26C:
		btst	#$01, Obj_Status(A0)					 ; $002A
		bne.w	Offset_0x02B2FE
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		bpl.s	Offset_0x02B27E
		neg.w	D0
Offset_0x02B27E:
		cmpi.w	#$0040, D0
		bcs.s	Offset_0x02B2FE
		move.w	#$0800, D1
		cmpi.w	#$0100, D0
		bcs.s	Offset_0x02B292
		move.w	#$0C00, D1
Offset_0x02B292:
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x02B29A
		neg.w	D1
Offset_0x02B29A:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		move.w	D1, Obj_Inertia(A0)				 ; $001C
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x02B2FE
Offset_0x02B2AA:
		tst.b	Obj_Control_Var_05(A0)					 ; $0035
		beq.s	Offset_0x02B2BA
		bsr.w	Offset_0x02BDAC
		addq.w	#$04, Obj_Ani_Time(A0)					 ; $0024
		bra.s	Offset_0x02B2FE
Offset_0x02B2BA:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	Obj_Inertia(A0), D1				 ; $001C
		asr.l	#$08, D1
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		muls.w	Obj_Inertia(A0), D0				 ; $001C
		asr.l	#$08, D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		bsr.s	Offset_0x02B358
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		tst.b	Obj_Flags_2(A0)					 ; $002D
		bne.s	Offset_0x02B2EA
		bsr.w	Offset_0x02B40A
Offset_0x02B2EA:
		addq.w	#$04, Obj_Ani_Time(A0)					 ; $0024
		tst.w	Obj_Inertia(A0)					 ; $001C
		bne.s	Offset_0x02B2FA
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x02B2FA:
		bsr.w	Offset_0x02BBAA
Offset_0x02B2FE:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_10(A0), A4				 ; $0040
		moveq	#$03, D6
		bsr.w	Offset_0x02B746
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_12(A0), A4				 ; $0042
		moveq	#$04, D6
		bsr.w	Offset_0x02B746
		move.w	Obj_Ani_Time(A0), D0					 ; $0024
		asr.w	#$03, D0
		andi.w	#$0001, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02B32E:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		addq.w	#$04, Obj_Ani_Time(A0)					 ; $0024
		move.w	Obj_Ani_Time(A0), D0					 ; $0024
		asr.w	#$03, D0
		andi.w	#$0001, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x02B352
		move.w	#$7F00, Obj_X(A0)				 ; $0010
Offset_0x02B352:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02B358:
		move.b	#$40, D1
		tst.w	Obj_Inertia(A0)					 ; $001C
		beq.s	Offset_0x02B3D2
		bmi.s	Offset_0x02B366
		neg.w	D1
Offset_0x02B366:
		move.b	Obj_Angle(A0), D0				 ; $0026
		add.b	D1, D0
		move.w	D0, -(A7)
		move.b	#$13, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		subi.w	#$000C, Obj_Y(A0)				 ; $0014
		jsr		(Player_WalkSpeed).l			   ; Offset_0x009B1A
		addi.w	#$000C, Obj_Y(A0)				 ; $0014
		move.w	(A7)+, D0
		tst.w	D1
		bpl.s	Offset_0x02B3D2
		asl.w	#$08, D1
		addi.b	#$20, D0
		andi.b	#$C0, D0
		beq.s	Offset_0x02B404
		cmpi.b	#$40, D0
		beq.s	Offset_0x02B3DA
		cmpi.b	#$80, D0
		beq.s	Offset_0x02B3D4
		addi.b	#$30, D3
		cmpi.b	#$60, D3
		bcs.s	Offset_0x02B3D2
		add.w	D1, Obj_Speed_X(A0)				 ; $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0000, Obj_Inertia(A0)					 ; $001C
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02B3D2
		bset	#$05, Obj_Status(A0)					 ; $002A
Offset_0x02B3D2:
		rts
Offset_0x02B3D4:
		sub.w	D1, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x02B3DA:
		addi.b	#$30, D3
		cmpi.b	#$60, D3
		bcs.s	Offset_0x02B3D2
		sub.w	D1, Obj_Speed_X(A0)				 ; $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0000, Obj_Inertia(A0)					 ; $001C
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02B3D2
		bset	#$05, Obj_Status(A0)					 ; $002A
		rts
Offset_0x02B404:
		add.w	D1, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x02B40A:
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$0A, Obj_Width_2(A0)					 ; $001F
		moveq	#$03, D0
		move.b	D0, (Primary_Angle).w				 ; $FFFFF768
		move.b	D0, (Secondary_Angle).w				 ; $FFFFF76A
		jsr		(Player_Check_Floor).l		   ; Offset_0x009BD4
		tst.b	D3
		bpl.s	Offset_0x02B436
		cmpi.b	#$E2, D3
		bcc.s	Offset_0x02B440
		move.b	#$E2, D3
		bra.s	Offset_0x02B440
Offset_0x02B436:
		cmpi.b	#$1E, D3
		bls.s	Offset_0x02B440
		move.b	#$1E, D3
Offset_0x02B440:
		move.b	D3, Obj_Angle(A0)				 ; $0026
		tst.w	D1
		beq.s	Offset_0x02B454
		bpl.s	Offset_0x02B456
		cmpi.w	#$FFF2, D1
		blt.s	Offset_0x02B454
		add.w	D1, Obj_Y(A0)					 ; $0014
Offset_0x02B454:
		rts
Offset_0x02B456:
		move.b	Obj_Speed_X(A0), D0				 ; $0018
		bpl.s	Offset_0x02B45E
		neg.b	D0
Offset_0x02B45E:
		addq.b	#$04, D0
		cmpi.b	#$0E, D0
		bcs.s	Offset_0x02B46A
		move.b	#$0E, D0
Offset_0x02B46A:
		cmp.b	D0, D1
		bgt.s	Offset_0x02B474
		add.w	D1, Obj_Y(A0)					 ; $0014
		rts
Offset_0x02B474:
		bset	#$01, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
		rts
Offset_0x02B488:
		moveq	#$00, D0
		move.b	(A4), D0
		move.w	Offset_0x02B494(PC, D0), D0
		jmp		Offset_0x02B494(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x02B494:
		dc.w	Offset_0x02B49A-Offset_0x02B494
		dc.w	Offset_0x02B4E2-Offset_0x02B494
		dc.w	Offset_0x02B552-Offset_0x02B494
;-------------------------------------------------------------------------------
Offset_0x02B49A:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_A1).l			   ; Offset_0x013574
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.s	Offset_0x02B4C0
		rts
Offset_0x02B4C0:
		tst.b	Obj_Control_Var_07(A1)					 ; $0037
		bmi.s	Offset_0x02B4E0
		addq.b	#$02, (A4)
		move.b	#$00, $0001(A4)
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x02B4DE
		move.b	#$01, $0001(A4)
Offset_0x02B4DE:
		bra.s	Offset_0x02B500
Offset_0x02B4E0:
		rts
;-------------------------------------------------------------------------------
Offset_0x02B4E2:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_A1).l			   ; Offset_0x013574
Offset_0x02B500:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.s	Offset_0x02B508
		clr.b	(A4)
Offset_0x02B508:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		tst.b	$0001(A4)
		beq.s	Offset_0x02B51A
		addi.w	#$000F, D0
Offset_0x02B51A:
		cmpi.w	#$0010, D0
		bcc.s	Offset_0x02B550
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.b	Obj_Height_3(A1), D0					 ; $0044
		addi.b	#$18, D0
		move.b	D0, Obj_Height_2(A1)					 ; $001E
		bset	#$00, Obj_Timer(A1)				 ; $002E
		move.b	#$80, Obj_Control_Var_07(A1)			 ; $0037
		bclr	D6, Obj_Status(A0)				 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		addq.b	#$02, (A4)
Offset_0x02B550:
		rts
;-------------------------------------------------------------------------------
Offset_0x02B552:
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.w	Offset_0x02B6FA
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x02B59A
		move.w	D5, D0
		andi.w	#$0070, D0
		beq.w	Offset_0x02B5B0
		move.w	#$F980, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$01, Obj_Control_Var_10(A1)			 ; $0040
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.w	#Jump_Sfx, D0					 ; $0070
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02B59A:
		bclr	#$00, Obj_Timer(A1)				 ; $002E
		move.b	#$00, Obj_Control_Var_07(A1)			 ; $0037
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	(A4)
Offset_0x02B5AE:
		rts
Offset_0x02B5B0:
		move.l	A0, -(A7)
		move.l	A1, A0
		move.b	Obj_Height_3(A0), D0					 ; $0044
		addi.b	#$18, D0
		move.b	D0, Obj_Height_2(A0)					 ; $001E
		move.w	D5, D3
		cmpi.b	#$10, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x02B5D0
		jsr		(Offset_0x02BA48).l
Offset_0x02B5D0:
		jsr		(Sonic_LevelBoundaries).l		   ; Offset_0x00B560
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.l	(A7)+, A0
		cmpi.b	#$10, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x02B606
		move.w	Obj_Speed_X(A1), Obj_Speed_X(A0)		  ; $0018, $0018
		move.w	Obj_Speed_Y(A1), Obj_Speed_Y(A0)		  ; $001A, $001A
		addi.w	#$0038, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
		rts
Offset_0x02B606:
		bclr	#$06, Obj_Control_Var_07(A1)			 ; $0037
		beq.s	Offset_0x02B61A
		move.w	#$0000, Obj_Inertia(A0)					 ; $001C
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x02B61A:
		bclr	#$05, Obj_Control_Var_07(A1)			 ; $0037
		beq.s	Offset_0x02B628
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
Offset_0x02B628:
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
		move.w	Obj_Player_Top_Solid(A1), Obj_Player_Top_Solid(A0) ; $0046, $0046
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.w	Offset_0x02B5AE
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		beq.w	Offset_0x02B6D0
		bcc.w	Offset_0x02B690
		cmpi.w	#$FE00, Obj_Speed_X(A0)					 ; $0018
		ble.s	Offset_0x02B66A
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x02B66A:
		add.w	D0, Obj_Ani_Time(A0)					 ; $0024
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		bpl.s	Offset_0x02B688
		asr.w	#$04, D0
		subi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		cmpi.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		ble.s	Offset_0x02B688
		add.w	D0, Obj_Speed_Y(A0)				 ; $001A
Offset_0x02B688:
		bset	#$01, Obj_Status(A0)					 ; $002A
		rts
Offset_0x02B690:
		cmpi.w	#$0200, Obj_Speed_X(A0)					 ; $0018
		bge.s	Offset_0x02B6A8
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x02B6A8:
		add.w	D0, Obj_Ani_Time(A0)					 ; $0024
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		bmi.s	Offset_0x02B6C8
		neg.w	D0
		asr.w	#$04, D0
		subi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		cmpi.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		ble.s	Offset_0x02B6C8
		add.w	D0, Obj_Speed_Y(A0)				 ; $001A
Offset_0x02B6C8:
		bset	#$01, Obj_Status(A0)					 ; $002A
		rts
Offset_0x02B6D0:
		moveq	#$01, D0
		tst.w	Obj_Speed_X(A0)					 ; $0018
		beq.s	Offset_0x02B6E0
		bmi.s	Offset_0x02B6DC
		neg.w	D0
Offset_0x02B6DC:
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x02B6E0:
		add.w	D0, Obj_Ani_Time(A0)					 ; $0024
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bpl.s	Offset_0x02B6EE
		clr.w	Obj_Speed_Y(A0)					 ; $001A
Offset_0x02B6EE:
		rts
;-------------------------------------------------------------------------------
; Offset_0x02B6F0:
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x02B6FA:
		move.l	#Offset_0x02B32E, (A0)
		cmpi.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		bne.s	Offset_0x02B71E
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Timer(A2)				 ; $002E
		move.b	#$00, Obj_Control_Var_07(A2)			 ; $0037
		bset	#$01, Obj_Status(A2)					 ; $002A
Offset_0x02B71E:
		cmpi.b	#$04, Obj_Control_Var_12(A0)			 ; $0042
		bne.s	Offset_0x02B73C
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$00, Obj_Timer(A2)				 ; $002E
		move.b	#$00, Obj_Control_Var_07(A2)			 ; $0037
		bset	#$01, Obj_Status(A2)					 ; $002A
Offset_0x02B73C:
		clr.w	Obj_Control_Var_10(A0)					 ; $0040
		clr.w	Obj_Control_Var_12(A0)					 ; $0042
		rts
Offset_0x02B746:
		btst	#$03, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02B776
		cmpi.b	#$04, (A4)
		bcs.s	Offset_0x02B774
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$000C, D0
		moveq	#$00, D1
		move.b	Obj_Height_3(A1), D1					 ; $0044
		sub.w	D1, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.b	#$00, Obj_Flags_2(A0)					 ; $002D
Offset_0x02B774:
		rts
Offset_0x02B776:
		cmpi.b	#$04, (A4)
		bcs.s	Offset_0x02B7AC
		move.w	Obj_Control_Var_12(A1), A2				 ; $0042
		cmpi.l	#Offset_0x028E48, (A2)
		bne.s	Offset_0x02B78C
		bsr.w	Offset_0x02B6FA
Offset_0x02B78C:
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A1), D0					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Height_3(A1), D1					 ; $0044
		add.w	D1, D0
		addi.w	#$000D, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.b	#$01, Obj_Flags_2(A0)					 ; $002D
Offset_0x02B7AC:
		rts
;-------------------------------------------------------------------------------
Offset_0x02B7AE:
		move.l	(Primary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B4, $FFFFF796
		cmpi.b	#$0C, Obj_Player_Top_Solid(A0)			 ; $0046
		beq.s	Offset_0x02B7C2
		move.l	(Secondary_Collision_Ptr).w, (Current_Collision_Ptr).w ; $FFFFF7B8, $FFFFF796
Offset_0x02B7C2:
		move.b	Obj_Player_LRB_Solid(A0), D5			 ; $0047
		move.w	Obj_Speed_X(A0), D1				 ; $0018
		move.w	Obj_Speed_Y(A0), D2				 ; $001A
		jsr		(CalcAngle).l					 ; Offset_0x001DB8
		subi.b	#$20, D0
		andi.b	#$C0, D0
		cmpi.b	#$40, D0
		beq.w	Offset_0x02B8B2
		cmpi.b	#$80, D0
		beq.w	Offset_0x02B93C
		cmpi.b	#$C0, D0
		beq.w	Offset_0x02B9BE
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		jsr		(Offset_0x00A054).l
		tst.w	D1
		bpl.s	Offset_0x02B814
		sub.w	D1, Obj_X(A0)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x02B814:
		jsr		(Offset_0x009E66).l
		tst.w	D1
		bpl.s	Offset_0x02B828
		add.w	D1, Obj_X(A0)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x02B828:
		move.b	#$1F, Obj_Height_2(A0)					 ; $001E
		move.b	#$0A, Obj_Width_2(A0)					 ; $001F
		jsr		(Player_Check_Floor).l		   ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x02B8B0
		move.b	Obj_Speed_Y(A0), D2				 ; $001A
		addq.b	#$08, D2
		neg.b	D2
		cmp.b	D2, D1
		bge.s	Offset_0x02B84E
		cmp.b	D2, D0
		blt.s	Offset_0x02B8B0
Offset_0x02B84E:
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	D3, Obj_Angle(A0)				 ; $0026
		bclr	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Flags_2(A0)					 ; $002D
		move.b	D3, D0
		addi.b	#$20, D0
		andi.b	#$40, D0
		bne.s	Offset_0x02B88E
		move.b	D3, D0
		addi.b	#$10, D0
		andi.b	#$20, D0
		beq.s	Offset_0x02B880
		asr.w	Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x02B8A2
Offset_0x02B880:
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Speed_X(A0), Obj_Inertia(A0)		  ; $0018, $001C
		rts
Offset_0x02B88E:
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		cmpi.w	#$0FC0, Obj_Speed_Y(A0)					 ; $001A
		ble.s	Offset_0x02B8A2
		move.w	#$0FC0, Obj_Speed_Y(A0)					 ; $001A
Offset_0x02B8A2:
		move.w	Obj_Speed_Y(A0), Obj_Inertia(A0)		  ; $001A, $001C
		tst.b	D3
		bpl.s	Offset_0x02B8B0
		neg.w	Obj_Inertia(A0)					 ; $001C
Offset_0x02B8B0:
		rts
Offset_0x02B8B2:
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		jsr		(Offset_0x00A054).l
		tst.w	D1
		bpl.s	Offset_0x02B8E2
		sub.w	D1, Obj_X(A0)					 ; $0010
		addi.b	#$30, D3
		cmpi.b	#$60, D3
		bcs.s	Offset_0x02B8E2
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.w	Obj_Speed_Y(A0), Obj_Inertia(A0)		  ; $001A, $001C
Offset_0x02B8E2:
		move.b	#$1F, Obj_Height_2(A0)					 ; $001E
		move.b	#$0A, Obj_Width_2(A0)					 ; $001F
		jsr		(Player_DontRunOnWalls).l		   ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x02B90A
		sub.w	D1, Obj_Y(A0)					 ; $0014
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bpl.s	Offset_0x02B908
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
Offset_0x02B908:
		rts
Offset_0x02B90A:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x02B93A
		jsr		(Player_Check_Floor).l		   ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x02B93A
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	D3, Obj_Angle(A0)				 ; $0026
		bclr	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Flags_2(A0)					 ; $002D
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Speed_X(A0), Obj_Inertia(A0)		  ; $0018, $001C
Offset_0x02B93A:
		rts
Offset_0x02B93C:
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		jsr		(Offset_0x00A054).l
		tst.w	D1
		bpl.s	Offset_0x02B95C
		sub.w	D1, Obj_X(A0)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x02B95C:
		jsr		(Offset_0x009E66).l
		tst.w	D1
		bpl.s	Offset_0x02B970
		add.w	D1, Obj_X(A0)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
Offset_0x02B970:
		move.b	#$1F, Obj_Height_2(A0)					 ; $001E
		move.b	#$0A, Obj_Width_2(A0)					 ; $001F
		jsr		(Player_DontRunOnWalls).l		   ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x02B9BC
		sub.w	D1, Obj_Y(A0)					 ; $0014
		move.b	D3, D0
		addi.b	#$20, D0
		andi.b	#$40, D0
		bne.s	Offset_0x02B99E
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x02B99E:
		move.b	D3, Obj_Angle(A0)				 ; $0026
		bclr	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Flags_2(A0)					 ; $002D
		move.w	Obj_Speed_Y(A0), Obj_Inertia(A0)		  ; $001A, $001C
		tst.b	D3
		bpl.s	Offset_0x02B9BC
		neg.w	Obj_Inertia(A0)					 ; $001C
Offset_0x02B9BC:
		rts
Offset_0x02B9BE:
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		jsr		(Offset_0x009E66).l
		tst.w	D1
		bpl.s	Offset_0x02B9EE
		add.w	D1, Obj_X(A0)					 ; $0010
		addi.b	#$30, D3
		cmpi.b	#$60, D3
		bcs.s	Offset_0x02B9EE
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.w	Obj_Speed_Y(A0), Obj_Inertia(A0)		  ; $001A, $001C
Offset_0x02B9EE:
		move.b	#$1F, Obj_Height_2(A0)					 ; $001E
		move.b	#$0A, Obj_Width_2(A0)					 ; $001F
		jsr		(Player_DontRunOnWalls).l		   ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x02BA16
		sub.w	D1, Obj_Y(A0)					 ; $0014
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bpl.s	Offset_0x02BA14
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
Offset_0x02BA14:
		rts
Offset_0x02BA16:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x02BA46
		jsr		(Player_Check_Floor).l		   ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x02BA46
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	D3, Obj_Angle(A0)				 ; $0026
		bclr	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Flags_2(A0)					 ; $002D
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Speed_X(A0), Obj_Inertia(A0)		  ; $0018, $001C
Offset_0x02BA46:
		rts
;-------------------------------------------------------------------------------
Offset_0x02BA48:
		move.w	(Sonic_Max_Speed).w, D6				 ; $FFFFF760
		move.w	(Sonic_Acceleration).w, D5			 ; $FFFFF762
		move.w	(Sonic_Deceleration).w, D4			 ; $FFFFF764
		btst	#$0A, D3
		beq.s	Offset_0x02BA5E
		bsr.w	Offset_0x02BAA0
Offset_0x02BA5E:
		btst	#$0B, D3
		beq.s	Offset_0x02BA68
		bsr.w	Offset_0x02BB28
Offset_0x02BA68:
		move.w	D3, D0
		andi.w	#$0C00, D0
		bne.s	Offset_0x02BA92
		move.w	Obj_Inertia(A0), D0				 ; $001C
		beq.s	Offset_0x02BA92
		bmi.s	Offset_0x02BA86
		sub.w	D5, D0
		bcc.s	Offset_0x02BA80
		move.w	#$0000, D0
Offset_0x02BA80:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		bra.s	Offset_0x02BA92
Offset_0x02BA86:
		add.w	D5, D0
		bcc.s	Offset_0x02BA8E
		move.w	#$0000, D0
Offset_0x02BA8E:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
Offset_0x02BA92:
		move.w	Obj_Inertia(A0), Obj_Speed_X(A0)		  ; $001C, $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x02BAA0:
		move.w	Obj_Inertia(A0), D0				 ; $001C
		beq.s	Offset_0x02BAA8
		bpl.s	Offset_0x02BADA
Offset_0x02BAA8:
		bset	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02BABC
		bclr	#$05, Obj_Status(A0)					 ; $002A
		move.b	#$01, Obj_Ani_Flag(A0)					 ; $0021
Offset_0x02BABC:
		sub.w	D5, D0
		move.w	D6, D1
		neg.w	D1
		cmp.w	D1, D0
		bgt.s	Offset_0x02BACE
		add.w	D5, D0
		cmp.w	D1, D0
		ble.s	Offset_0x02BACE
		move.w	D1, D0
Offset_0x02BACE:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		move.b	#$00, Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x02BADA:
		sub.w	D4, D0
		bcc.s	Offset_0x02BAE2
		move.w	#$FF80, D0
Offset_0x02BAE2:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		move.b	Obj_Angle(A0), D0				 ; $0026
		addi.b	#$20, D0
		andi.b	#$C0, D0
		bne.s	Offset_0x02BB26
		cmpi.w	#$0400, D0
		blt.s	Offset_0x02BB26
		move.b	#$0D, Obj_Ani_Number(A0)				 ; $0020
		bclr	#$00, Obj_Status(A0)					 ; $002A
		move.w	#Skidding_Sfx, D0				 ; $0036
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.l	A0, A2
		suba.w	#Obj_Player_One, A2				 ; $B000
		adda.w	#Obj_P1_Dust_Water_Splash, A2			 ; $CC54
		move.b	#$06, Obj_Routine(A2)					 ; $0005
		move.b	#$15, Obj_Map_Id(A2)					 ; $0022
Offset_0x02BB26:
		rts
Offset_0x02BB28:
		move.w	Obj_Inertia(A0), D0				 ; $001C
		bmi.s	Offset_0x02BB5C
		bclr	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02BB42
		bclr	#$05, Obj_Status(A0)					 ; $002A
		move.b	#$01, Obj_Ani_Flag(A0)					 ; $0021
Offset_0x02BB42:
		add.w	D5, D0
		cmp.w	D6, D0
		blt.s	Offset_0x02BB50
		sub.w	D5, D0
		cmp.w	D6, D0
		bge.s	Offset_0x02BB50
		move.w	D6, D0
Offset_0x02BB50:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		move.b	#$00, Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x02BB5C:
		add.w	D4, D0
		bcc.s	Offset_0x02BB64
		move.w	#$0080, D0
Offset_0x02BB64:
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		move.b	Obj_Angle(A0), D0				 ; $0026
		addi.b	#$20, D0
		andi.b	#$C0, D0
		bne.s	Offset_0x02BBA8
		cmpi.w	#$FC00, D0
		bgt.s	Offset_0x02BBA8
		move.b	#$0D, Obj_Ani_Number(A0)				 ; $0020
		bset	#$00, Obj_Status(A0)					 ; $002A
		move.w	#Skidding_Sfx, D0				 ; $0036
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.l	A0, A2
		suba.w	#Obj_Player_One, A2				 ; $B000
		adda.w	#Obj_P1_Dust_Water_Splash, A2			 ; $CC54
		move.b	#$06, Obj_Routine(A2)					 ; $0005
		move.b	#$15, Obj_Map_Id(A2)					 ; $0022
Offset_0x02BBA8:
		rts
Offset_0x02BBAA:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x02BC0C
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x02BC0C
		lea		(Offset_0x02BCC8).l, A1
		tst.b	(Current_Act).w					  ; $FFFFFE11
		beq.s	Offset_0x02BBC8
		lea		(Offset_0x02BD3A).l, A1
Offset_0x02BBC8:
		move.w	(A1)+, D6
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
Offset_0x02BBD2:
		move.w	(A1), D0
		sub.w	D2, D0
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x02BC04
		move.w	$0002(A1), D1
		sub.w	D3, D1
		addi.w	#$0010, D1
		cmpi.w	#$0020, D1
		bcc.s	Offset_0x02BC04
		move.w	Obj_Inertia(A0), D0				 ; $001C
		move.b	Obj_Flags(A1), D2				 ; $0004
		andi.b	#$7F, D2
		beq.s	Offset_0x02BC00
		neg.w	D0
Offset_0x02BC00:
		tst.w	D0
		bpl.s	Offset_0x02BC0E
Offset_0x02BC04:
		adda.w	#$0010, A1
		dbra	D6, Offset_0x02BBD2
Offset_0x02BC0C:
		rts
Offset_0x02BC0E:
		move.b	#$01, Obj_Control_Var_05(A0)			 ; $0035
		move.w	Obj_Flags(A1), Obj_Control_Var_0E(A0)	  ; $0004, $003E
		addq.w	#$06, A1
		move.w	(A1)+, D4
		move.w	D4, Obj_Control_Var_00(A0)				 ; $0030
		move.w	(A1)+, D5
		move.w	D5, D0
		move.b	Obj_Control_Var_0F(A0), D1				 ; $003F
		andi.b	#$7F, D1
		beq.s	Offset_0x02BC32
		sub.w	(A1), D0
Offset_0x02BC32:
		move.w	D0, Obj_Control_Var_02(A0)				 ; $0032
		move.l	A1, Obj_Control_Var_06(A0)				 ; $0036
		move.w	Obj_Inertia(A0), D2				 ; $001C
		bpl.s	Offset_0x02BC42
		neg.w	D2
Offset_0x02BC42:
		tst.w	D2
		bne.s	Offset_0x02BC4A
		move.w	#$0800, D2
Offset_0x02BC4A:
		moveq	#$00, D0
		move.w	D2, D3
		move.w	D4, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		bge.s	Offset_0x02BC5A
		neg.w	D0
		neg.w	D2
Offset_0x02BC5A:
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A0), D1					 ; $0014
		bge.s	Offset_0x02BC68
		neg.w	D1
		neg.w	D3
Offset_0x02BC68:
		cmp.w	D0, D1
		bcs.s	Offset_0x02BC9A
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A0), D1					 ; $0014
		swap	D1
		divs.w	D3, D1
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		beq.s	Offset_0x02BC86
		swap	D0
		divs.w	D1, D0
Offset_0x02BC86:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	D3, Obj_Speed_Y(A0)				 ; $001A
		tst.w	D1
		bpl.s	Offset_0x02BC94
		neg.w	D1
Offset_0x02BC94:
		move.w	D1, Obj_Control_Var_0A(A0)				 ; $003A
		rts
Offset_0x02BC9A:
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		swap	D0
		divs.w	D2, D0
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A0), D1					 ; $0014
		beq.s	Offset_0x02BCB4
		swap	D1
		divs.w	D0, D1
Offset_0x02BCB4:
		move.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.w	D2, Obj_Speed_X(A0)				 ; $0018
		tst.w	D0
		bpl.s	Offset_0x02BCC2
		neg.w	D0
Offset_0x02BCC2:
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x02BCC8:
		dc.w	$0006
		dc.w	$1BA0, $00C6, $0000, $1C40, $00E6, $0280, $1CE0, $0385
		dc.w	$1BA0, $03C4, $8001, $1C40, $03A6, $02C0, $1BA0, $00C6
		dc.w	$1CE0, $0385, $0101, $1C40, $0366, $0280, $1BA0, $00C6
		dc.w	$2720, $0846, $0000, $27C0, $0866, $0200, $2860, $0A86
		dc.w	$2860, $0846, $0180, $27C0, $0866, $0200, $2720, $0A86
		dc.w	$2720, $0A86, $0081, $27C0, $0A66, $0200, $2860, $0846
		dc.w	$2860, $0A86, $0101, $27C0, $0A66, $0200, $2720, $0846
;-------------------------------------------------------------------------------
Offset_0x02BD3A:
		dc.w	$0006
		dc.w	$1760, $0546, $8180, $16C0, $0566, $0140, $1760, $06C5
		dc.w	$1760, $06C5, $8181, $16C0, $06A6, $0140, $1760, $0546
		dc.w	$1620, $06C4, $0081, $16C0, $06C6, $0180, $1760, $0546
		dc.w	$2AA0, $0444, $8000, $2B40, $0466, $02C0, $2AA0, $0744
		dc.w	$2BE0, $0446, $8180, $2B40, $0466, $02C0, $2BE0, $0746
		dc.w	$2AA0, $0744, $8001, $2B40, $0726, $02C0, $2AA0, $0444
		dc.w	$2BE0, $0746, $8181, $2B40, $0726, $02C0, $2BE0, $0446
;-------------------------------------------------------------------------------
Offset_0x02BDAC:
		cmpi.b	#$02, Obj_Control_Var_05(A0)			 ; $0035
		beq.s	Offset_0x02BE24
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bpl.s	Offset_0x02BDEC
		cmpi.b	#$03, Obj_Control_Var_05(A0)			 ; $0035
		beq.s	Offset_0x02BE12
		move.w	#$0000, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$02, Obj_Control_Var_05(A0)			 ; $0035
		move.l	Obj_Control_Var_06(A0), A1				 ; $0036
		move.w	(A1)+, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.b	Obj_Control_Var_0F(A0), D1				 ; $003F
		andi.b	#$7F, D1
		beq.s	Offset_0x02BDE6
		move.w	D0, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x02BDE6:
		move.l	A1, Obj_Control_Var_06(A0)				 ; $0036
		bra.s	Offset_0x02BE24
Offset_0x02BDEC:
		move.l	Obj_X(A0), D2					 ; $0010
		move.l	Obj_Y(A0), D3					 ; $0014
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D2
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D3
		move.l	D2, Obj_X(A0)					 ; $0010
		move.l	D3, Obj_Y(A0)					 ; $0014
		rts
Offset_0x02BE12:
		tst.b	Obj_Control_Var_0E(A0)					 ; $003E
		bpl.s	Offset_0x02BE1C
		neg.w	Obj_Inertia(A0)					 ; $001C
Offset_0x02BE1C:
		move.b	#$00, Obj_Control_Var_05(A0)			 ; $0035
		rts
Offset_0x02BE24:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		add.w	D0, D0
		tst.b	Obj_Control_Var_0F(A0)					 ; $003F
		bpl.s	Offset_0x02BE32
		neg.w	D0
Offset_0x02BE32:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$5800, D0
		swap	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		add.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		move.w	D0, Obj_Y(A0)					 ; $0014
		moveq	#$02, D1
		move.w	Obj_Inertia(A0), D0				 ; $001C
		bpl.s	Offset_0x02BE5C
		neg.w	D0
Offset_0x02BE5C:
		cmpi.w	#$0C00, D0
		bne.s	Offset_0x02BE64
		moveq	#$03, D1
Offset_0x02BE64:
		move.b	Obj_Control_Var_0F(A0), D0				 ; $003F
		andi.b	#$7F, D0
		beq.s	Offset_0x02BE76
		sub.w	D1, Obj_Control_Var_0C(A0)				 ; $003C
		bgt.s	Offset_0x02BEA6
		bra.s	Offset_0x02BE84
Offset_0x02BE76:
		add.w	D1, Obj_Control_Var_0C(A0)				 ; $003C
		move.w	Obj_Timer(A0), D0				 ; $002E
		cmp.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bhi.s	Offset_0x02BEA6
Offset_0x02BE84:
		move.b	#$03, Obj_Control_Var_05(A0)			 ; $0035
		move.l	Obj_Control_Var_06(A0), A2				 ; $0036
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	Obj_Inertia(A0), D2				 ; $001C
		bpl.s	Offset_0x02BE9A
		neg.w	D2
Offset_0x02BE9A:
		tst.w	D2
		bne.s	Offset_0x02BEA2
		move.w	#$0800, D2
Offset_0x02BEA2:
		bra.w	Offset_0x02BC4A
Offset_0x02BEA6:
		rts
;-------------------------------------------------------------------------------
Blue_Spinning_Platform_Mappings:					   ; Offset_0x02BEA8
		dc.w	Offset_0x02BEAE-Blue_Spinning_Platform_Mappings
		dc.w	Offset_0x02BEBC-Blue_Spinning_Platform_Mappings
		dc.w	Offset_0x02BECA-Blue_Spinning_Platform_Mappings
Offset_0x02BEAE:
		dc.w	$0002
		dc.w	$F40A, $0000, $FFE8
		dc.w	$F40A, $0009, $0000
Offset_0x02BEBC:
		dc.w	$0002
		dc.w	$F40A, $0012, $FFE8
		dc.w	$F40A, $001B, $0000
Offset_0x02BECA:
		dc.w	$0001
		dc.w	$0809, $0000, $FFF4
;===============================================================================
; Objeto 0x5B - Plataforma em forma de pião giratória na Marble Garden.
; <<<-
;===============================================================================