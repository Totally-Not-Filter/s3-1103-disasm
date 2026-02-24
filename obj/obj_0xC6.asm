;===============================================================================
; Objeto 0xC6 - Container de animais
; ->>>
;===============================================================================
; Offset_0x043490:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0434B4(PC, D0), D1
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		Offset_0x0434B4(PC, D1)
		moveq	#$2B, D1
		moveq	#$18, D2
		moveq	#$18, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		Display_Sprite_Check_X_2(PC)		   ; Offset_0x042D24
;-------------------------------------------------------------------------------
Offset_0x0434B4:
		dc.w	Offset_0x0434C6-Offset_0x0434B4
		dc.w	Offset_0x04351C-Offset_0x0434B4
		dc.w	Offset_0x04355A-Offset_0x0434B4
		dc.w	Offset_0x043562-Offset_0x0434B4
		dc.w	Offset_0x043564-Offset_0x0434B4
		dc.w	Offset_0x0435D8-Offset_0x0434B4
		dc.w	Offset_0x0435E0-Offset_0x0434B4
		dc.w	Offset_0x0435EA-Offset_0x0434B4
		dc.w	Offset_0x0435F2-Offset_0x0434B4
;-------------------------------------------------------------------------------
Offset_0x0434C6
		lea		Egg_Prison_Setup_Data(PC), A1		   ; Offset_0x04396A
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		btst	#$01, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x0434DE
		lea		Offset_0x043994(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x0434DE:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$00A0, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		subi.w	#$0040, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	#$0001, Obj_Control_Var_0A(A0)			 ; $003A
		jsr		(Swing_Setup).l				   ; Offset_0x03669A
		lea		Offset_0x04399C(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x0439A4(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04351C:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043558
		move.b	#$04, Obj_Routine(A0)					 ; $0005
;-------------------------------------------------------------------------------
Offset_0x04352A:
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		lea		Offset_0x0439B2(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x0439D2(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		(Offset_0x041D62), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.b	#$08, Obj_Subtype(A1)					 ; $002C
Offset_0x043558:
		rts
;-------------------------------------------------------------------------------
Offset_0x04355A:
		move.b	#$06, D0
		bra.w	Offset_0x0437D8
;-------------------------------------------------------------------------------
Offset_0x043562:
		rts
;-------------------------------------------------------------------------------
Offset_0x043564:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		move.w	Obj_Control_Var_0A(A0), D1				 ; $003A
		bmi.s	Offset_0x04357C
		addi.w	#$0110, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x043586
		bra.w	Offset_0x043588
Offset_0x04357C:
		addi.w	#$0030, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x043588
Offset_0x043586:
		neg.w	D1
Offset_0x043588:
		move.w	D1, Obj_Control_Var_0A(A0)				 ; $003A
		add.w	D1, Obj_X(A0)					 ; $0010
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		addi.w	#$0040, D0
		move.l	#$00004000, D1
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bhi.s	Offset_0x0435A6
		neg.l	D1
Offset_0x0435A6:
		add.l	D1, Obj_Y(A0)					 ; $0014
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0435CE
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		cmpi.b	#$02, (Current_Zone).w					 ; $FFFFFE10
		bne.s	Offset_0x0435C6
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
Offset_0x0435C6:
		move.w	A1, Obj_Height_3(A0)					 ; $0044
		bsr.w	Offset_0x04352A
Offset_0x0435CE:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x0435D8:
		move.b	#$0C, D0
		bsr.w	Offset_0x0437D8
;-------------------------------------------------------------------------------
Offset_0x0435E0:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x0435EA:
		move.b	#$10, D0
		bsr.w	Offset_0x04382C
;-------------------------------------------------------------------------------
Offset_0x0435F2:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x0435FC:
		move.l	#Offset_0x04360A, (A0)
		lea		Egg_Prison_Setup_Data_2(PC), A1		   ; Offset_0x043976
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x04360A:
		bsr.w	Offset_0x0438A2
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x04362C
		move.l	#Offset_0x043630, (A0)
		addq.w	#$08, Obj_Y(A0)					 ; $0014
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x04362C:
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x043630:
		bsr.w	Offset_0x0438A2
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x043638:
		move.l	#Offset_0x04364C, (A0)
		bset	#$01, Obj_Flags(A0)				 ; $0004
		lea		Egg_Prison_Setup_Data_2(PC), A1		   ; Offset_0x043976
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x04364C:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$06, D2
		bsr.w	Offset_0x0438A4
		lea		Offset_0x0436A0(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x04369C
		tst.w	D0
		beq.s	Offset_0x043676
		move.w	D0, A1
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bpl.s	Offset_0x043676
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x043688
Offset_0x043676:
		swap	D0
		move.w	D0, A1
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bpl.s	Offset_0x04369C
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x04369C
Offset_0x043688:
		move.l	#Offset_0x0436A8, (A0)
		subq.b	#$08, Obj_Control_Var_13(A0)			 ; $0043
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x04369C:
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x0436A0:
		dc.w	$FFE6, $0034, $FFE4, $0038
;-------------------------------------------------------------------------------
Offset_0x0436A8:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$05, D2
		bsr.w	Offset_0x0438A4
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x0436B6:
		lea		Egg_Prison_Setup_Data_3(PC), A1		   ; Offset_0x04397C
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		cmpi.w	#$0400, (Current_ZoneAndAct).w				   ; $FFFFFE10
		bne.s	Offset_0x0436CC
		move.w	#$044E, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x0436CC:
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		bsr.w	Offset_0x0438B2
		moveq	#$04, D0
		jsr		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0436E2:
		lea		Egg_Prison_Setup_Data_5(PC), A1		   ; Offset_0x04398E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0436F0, (A0)
Offset_0x0436F0:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		lea		Offset_0x043A2E(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x043700:
		lea		Egg_Prison_Setup_Data_4(PC), A1		   ; Offset_0x043988
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x04371E, (A0)
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		bsr.w	Offset_0x0438C8
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x04371E:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x043730
		move.l	#Offset_0x043734, (A0)
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
Offset_0x043730:
		jmp		MarkObjectGone(PC)		; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x043734:
		jsr		Move_Light_Gravity(PC)		   ; Offset_0x0426C2
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x043768
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_0E(A0), Obj_Speed_Y(A0)	  ; $003E, $001A
		jsr		Find_Player(PC)				   ; Offset_0x042634
		move.w	#$FE00, D1
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		beq.s	Offset_0x043760
		tst.w	D0
		beq.s	Offset_0x043760
		neg.w	D1
Offset_0x043760:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		bsr.w	Offset_0x043956
Offset_0x043768:
		moveq	#$00, D0
		btst	#$02, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.s	Offset_0x043774
		moveq	#$01, D0
Offset_0x043774:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		MarkObjectGone(PC)		; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x04377C:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x043792
		move.l	#Offset_0x043796, (A0)
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
Offset_0x043792:
		jmp		MarkObjectGone(PC)		; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x043796:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	#$0300, D0
		move.w	#$0100, D1
		moveq	#$10, D2
		move.w	#$0000, D3
		move.w	#$FFD0, D4
		sub.b	Obj_Subtype(A0), D4				 ; $002C
		bsr.w	Offset_0x04384A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x043956
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.s	Offset_0x0437D0
		move.l	#Offset_0x0437D2, (A0)
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x0437D0:
		bra.s	Offset_0x043768
;-------------------------------------------------------------------------------
Offset_0x0437D2:
		subq.w	#$02, Obj_X(A0)					 ; $0010
		bra.s	Offset_0x043768
;-------------------------------------------------------------------------------
Offset_0x0437D8:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x043558
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x043558
;-------------------------------------------------------------------------------
Offset_0x0437EE:
		move.b	#$1A, Obj_Ani_Number(A1)				 ; $0020
		move.b	D0, Obj_Routine(A0)				 ; $0005
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		clr.b	Obj_Control_Var_0D(A1)					 ; $003D
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		jsr		(AllocateObject).l			 ; Offset_0x011DD8
		bne.s	Offset_0x04381C
		move.l	#Obj_LevelResults, (A1)		  ; Offset_0x0247D0
Offset_0x04381C:
		rts
;-------------------------------------------------------------------------------
Set_End_Pose_And_Load_Level_Results:				   ; Offset_0x04381E
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x0437EE
		rts
;-------------------------------------------------------------------------------
Offset_0x04382C:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x043558
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x043558
		move.w	#$FF00, Obj_Speed_X(A0)					 ; $0018
		bra.s	Offset_0x0437EE
;-------------------------------------------------------------------------------
Offset_0x04384A:
		move.w	D2, D5
		move.w	Obj_X(A1), D6					 ; $0010
		add.w	D3, D6
		cmp.w	Obj_X(A0), D6					 ; $0010
		bcc.s	Offset_0x04385A
		neg.w	D2
Offset_0x04385A:
		move.w	Obj_Speed_X(A0), D6				 ; $0018
		add.w	D2, D6
		cmp.w	D0, D6
		bgt.s	Offset_0x04386E
		neg.w	D0
		cmp.w	D0, D6
		blt.s	Offset_0x04386E
		move.w	D6, Obj_Speed_X(A0)				 ; $0018
Offset_0x04386E:
		move.w	Obj_Y(A1), D6					 ; $0014
		add.w	D4, D6
		cmp.w	Obj_Y(A0), D6					 ; $0014
		bcc.s	Offset_0x04387C
		neg.w	D5
Offset_0x04387C:
		move.w	Obj_Speed_Y(A0), D6				 ; $001A
		add.w	D5, D6
		cmp.w	D1, D6
		bgt.s	Offset_0x043890
		neg.w	D1
		cmp.w	D1, D6
		blt.s	Offset_0x04386E
		move.w	D6, Obj_Speed_Y(A0)				 ; $001A
Offset_0x043890:
		rts
;-------------------------------------------------------------------------------
; Offset_0x043892:
		moveq	#$2B, D1
		moveq	#$18, D2
		moveq	#$18, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
;-------------------------------------------------------------------------------
Offset_0x0438A2:
		moveq	#$08, D2
Offset_0x0438A4:
		moveq	#$1B, D1
		moveq	#$09, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
;-------------------------------------------------------------------------------
Offset_0x0438B2:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		move.b	Offset_0x0438C2(PC, D0), Obj_Map_Id(A0)			 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x0438C2:
		dc.b	$02, $03, $0A, $04, $0B, $00
;-------------------------------------------------------------------------------
Offset_0x0438C8:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		andi.w	#$0006, D0
		move.w	Offset_0x04393E(PC, D0), D2
		move.w	D2, Obj_Speed_Y(A0)				 ; $001A
		move.w	D2, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x0438FC
		move.l	#Offset_0x04377C, (A0)
		moveq	#$00, D0
		addq.b	#$08, Obj_Control_Var_13(A0)			 ; $0043
		clr.w	Obj_Speed_Y(A0)					 ; $001A
Offset_0x0438FC:
		andi.w	#$0002, D0
		move.w	D0, D2
		cmpi.w	#$0400, (Current_ZoneAndAct).w				   ; $FFFFFE10
		bne.s	Offset_0x04390C
		addq.w	#$04, D2
Offset_0x04390C:
		move.w	Offset_0x043946(PC, D2), Obj_Art_VRAM(A0)		 ; $000A
		add.w	D0, D0
		move.l	Offset_0x04394E(PC, D0), Obj_Map(A0)			 ; $000C
		lsl.w	#$02, D1
		move.w	D1, Obj_Timer(A0)				 ; $002E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	#$0200, D1
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x043934
		neg.w	D1
Offset_0x043934:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		bsr.w	Offset_0x043956
		rts
;-------------------------------------------------------------------------------
Offset_0x04393E:
		dc.w	$FC80, $FD00, $FD80, $FE00
;-------------------------------------------------------------------------------
Offset_0x043946:
		dc.w	$8592, $8580, $8440, $842E
;-------------------------------------------------------------------------------
Offset_0x04394E:
		dc.l	Flickies_Mappings			   ; Offset_0x023E88
		dc.l	Flickies_Mappings_01		   ; Offset_0x023EA6
;-------------------------------------------------------------------------------
Offset_0x043956:
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x043968
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x043968:
		rts
;-------------------------------------------------------------------------------
Egg_Prison_Setup_Data:						   ; Offset_0x04396A
		dc.l	Egg_Prison_Mappings			   ; Offset_0x043A34
		dc.w	$84D7, $0200
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Egg_Prison_Setup_Data_2:					   ; Offset_0x043976
		dc.w	$0200
		dc.b	$10, $08, $05, $00
;-------------------------------------------------------------------------------
Egg_Prison_Setup_Data_3:					   ; Offset_0x04397C
		dc.l	Egg_Prison_Mappings			   ; Offset_0x043A34
		dc.w	$84D7, $0180
		dc.b	$0C, $0C, $00, $00
;-------------------------------------------------------------------------------
Egg_Prison_Setup_Data_4:					   ; Offset_0x043988
		dc.w	$0280
		dc.b	$08, $08, $02, $00
;-------------------------------------------------------------------------------
Egg_Prison_Setup_Data_5:					   ; Offset_0x04398E
		dc.w	$0200
		dc.b	$14, $04, $06, $00
;-------------------------------------------------------------------------------
Offset_0x043994:
		dc.w	$0000
		dc.l	Offset_0x0435FC
		dc.w	$00D8
;-------------------------------------------------------------------------------
Offset_0x04399C:
		dc.w	$0000
		dc.l	Offset_0x043638
		dc.w	$0028
;-------------------------------------------------------------------------------
Offset_0x0439A4:
		dc.w	$0001
		dc.l	Offset_0x0436E2
		dc.b	$EC, $DC
		dc.l	Offset_0x0436E2
		dc.b	$14, $DC
;-------------------------------------------------------------------------------
Offset_0x0439B2:
		dc.w	$0004
		dc.l	Offset_0x0436B6
		dc.b	$00, $F8
		dc.l	Offset_0x0436B6
		dc.b	$F0, $F8
		dc.l	Offset_0x0436B6
		dc.b	$10, $F8
		dc.l	Offset_0x0436B6
		dc.b	$E8, $F8
		dc.l	Offset_0x0436B6
		dc.b	$18, $F8
;-------------------------------------------------------------------------------
Offset_0x0439D2:
		dc.w	$000E
		dc.l	Offset_0x043700
		dc.b	$00, $FC
		dc.l	Offset_0x043700
		dc.b	$F8, $FC
		dc.l	Offset_0x043700
		dc.b	$08, $FC
		dc.l	Offset_0x043700
		dc.b	$10, $FC
		dc.l	Offset_0x043700
		dc.b	$F0, $FC
		dc.l	Offset_0x043700
		dc.b	$E8, $FC
		dc.l	Offset_0x043700
		dc.b	$18, $FC
		dc.l	Offset_0x043700
		dc.b	$FC, $FC
		dc.l	Offset_0x043700
		dc.b	$04, $FC
		dc.l	Offset_0x043700
		dc.b	$0C, $FC
		dc.l	Offset_0x043700
		dc.b	$F4, $FC
		dc.l	Offset_0x043700
		dc.b	$EC, $FC
		dc.l	Offset_0x043700
		dc.b	$14, $FC
		dc.l	Offset_0x043700
		dc.b	$1C, $FC
		dc.l	Offset_0x043700
		dc.b	$E4, $FC
;-------------------------------------------------------------------------------
Offset_0x043A2E:
		dc.b	$00, $06, $07, $08, $09, $FC
;-------------------------------------------------------------------------------
Egg_Prison_Mappings:						   ; Offset_0x043A34
		dc.w	Offset_0x043A4C-Egg_Prison_Mappings
		dc.w	Offset_0x043A8A-Egg_Prison_Mappings
		dc.w	Offset_0x043ABC-Egg_Prison_Mappings
		dc.w	Offset_0x043ACA-Egg_Prison_Mappings
		dc.w	Offset_0x043AD2-Egg_Prison_Mappings
		dc.w	Offset_0x043ADA-Egg_Prison_Mappings
		dc.w	Offset_0x043AE8-Egg_Prison_Mappings
		dc.w	Offset_0x043AF6-Egg_Prison_Mappings
		dc.w	Offset_0x043AFE-Egg_Prison_Mappings
		dc.w	Offset_0x043B06-Egg_Prison_Mappings
		dc.w	Offset_0x043B0E-Egg_Prison_Mappings
		dc.w	Offset_0x043B16-Egg_Prison_Mappings
Offset_0x043A4C:
		dc.w	$000A
		dc.w	$E00D, $000C, $FFE0
		dc.w	$E00D, $080C, $0000
		dc.w	$F002, $0014, $FFF8
		dc.w	$F002, $0814, $0000
		dc.w	$F006, $0017, $FFE8
		dc.w	$F006, $0817, $0008
		dc.w	$F002, $001D, $FFE0
		dc.w	$F002, $081D, $0018
		dc.w	$080E, $0000, $FFE0
		dc.w	$080E, $0800, $0000
Offset_0x043A8A:
		dc.w	$0008
		dc.w	$E00D, $0020, $FFE0
		dc.w	$F001, $0028, $FFF0
		dc.w	$000C, $002A, $FFE0
		dc.w	$E00D, $0820, $0000
		dc.w	$F001, $0828, $0008
		dc.w	$000C, $082A, $0000
		dc.w	$080E, $0000, $FFE0
		dc.w	$080E, $0800, $0000
Offset_0x043ABC:
		dc.w	$0002
		dc.w	$F801, $002E, $FFF8
		dc.w	$F801, $082E, $0000
Offset_0x043ACA:
		dc.w	$0001
		dc.w	$F805, $0030, $FFF8
Offset_0x043AD2:
		dc.w	$0001
		dc.w	$F801, $0034, $FFFC
Offset_0x043ADA:
		dc.w	$0002
		dc.w	$F805, $0036, $FFF0
		dc.w	$F805, $0836, $0000
Offset_0x043AE8:
		dc.w	$0002
		dc.w	$FC08, $003A, $FFEC
		dc.w	$FC04, $003D, $0004
Offset_0x043AF6:
		dc.w	$0001
		dc.w	$FC08, $003F, $FFF4
Offset_0x043AFE:
		dc.w	$0001
		dc.w	$FC00, $0042, $FFFC
Offset_0x043B06:
		dc.w	$0001
		dc.w	$FC08, $0043, $FFF4
Offset_0x043B0E:
		dc.w	$0001
		dc.w	$F805, $0830, $FFF8
Offset_0x043B16:
		dc.w	$0001
		dc.w	$F801, $0834, $FFFC
;===============================================================================
; Objeto 0xC6 - Container de animais
; <<<-
;===============================================================================