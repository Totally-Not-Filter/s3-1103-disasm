;===============================================================================
; Objeto 0xC4 - Mini chefe na Marble Garden
; ->>>
;===============================================================================
; Offset_0x045262:
		lea		Offset_0x04529A(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045286(PC, D0), D1
		jsr		Offset_0x045286(PC, D1)
		bsr.w	Offset_0x0456FC
		bsr.w	Offset_0x04573C
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x045286:
		dc.w	Offset_0x0452A2-Offset_0x045286
		dc.w	Offset_0x0452FC-Offset_0x045286
		dc.w	Offset_0x0451D4-Offset_0x045286
		dc.w	Offset_0x0451FC-Offset_0x045286
		dc.w	Offset_0x045230-Offset_0x045286
		dc.w	Offset_0x045372-Offset_0x045286
		dc.w	Offset_0x0453E0-Offset_0x045286
		dc.w	Offset_0x045434-Offset_0x045286
		dc.w	Offset_0x045456-Offset_0x045286
		dc.w	Offset_0x04547C-Offset_0x045286
;-------------------------------------------------------------------------------
Offset_0x04529A:
		dc.w	$0D20, $0EC0, $2B80, $3080
;-------------------------------------------------------------------------------
Offset_0x0452A2:
		lea		Tunnelbot_Setup_Data(PC), A1		   ; Offset_0x0457C4
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$28, Obj_Height_2(A0)					 ; $001E
		move.w	#$2E00, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.w	#$0E10, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$2E00, Obj_Control_Var_0A(A0)			 ; $003A
		move.l	#Offset_0x04530E, Obj_Child(A0)			 ; $0034
		jsr		(Swing_Setup).l				   ; Offset_0x03669A
		move.w	#$0078, Obj_Height_3(A0)				 ; $0044
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x0457FA(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		PLC_Tunnelbot(PC), A1		   ; Offset_0x045856
		jmp		(LoadPLC_Direct).l					 ; Offset_0x001502
;-------------------------------------------------------------------------------
Offset_0x0452FC:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Update_Sonic_Level_Limits_X_Y).l		   ; Offset_0x0433B8
;-------------------------------------------------------------------------------
Offset_0x04530E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045841, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x045326, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045326:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045847, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x04533E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04533E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		st		(Earthquake_Flag).w					 ; $FFFFEECC
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045358, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045358:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		clr.w	(Earthquake_Flag).w					 ; $FFFFEECC
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045376, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045372:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045376:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Flags(A0)				 ; $0004
		st		(Earthquake_Flag).w					 ; $FFFFEECC
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045404, Obj_Child(A0)			 ; $0034
		move.w	(Camera_X).w, Obj_X(A0)		  ; $FFFFEE78, $0010
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$000E, D0
		move.w	Offset_0x0453D0(PC, D0), D1
		add.w	D1, Obj_X(A0)					 ; $0010
		subi.w	#$0040, Obj_Y(A0)				 ; $0014
		tst.b	(Boss_Data_Buffer+$01).w			 ; $FFFFFA81
		beq.s	Offset_0x0453CE
		move.w	D0, D3
		lea		Offset_0x045830(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		cmpi.w	#$0008, D3
		bcc.s	Offset_0x0453CE
		bset	#$00, Obj_Flags(A1)				 ; $0004
Offset_0x0453CE:
		rts
;-------------------------------------------------------------------------------
Offset_0x0453D0:
		dc.w	$0030, $0048, $0060, $0078, $00C8, $00E0, $00F8, $0110
;-------------------------------------------------------------------------------
Offset_0x0453E0:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		moveq	#$02, D0
		move.b	(Vint_runcount+$03).w, D1		  ; $FFFFFE0F
		btst	#$00, D1
		beq.s	Offset_0x0453F2
		moveq	#-$01, D0
Offset_0x0453F2:
		add.w	D0, Obj_Y(A0)					 ; $0014
		andi.b	#$07, D1
		bne.s	Offset_0x045400
		bsr.w	Offset_0x04570C
Offset_0x045400:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045404:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		clr.w	(Earthquake_Flag).w					 ; $FFFFEECC
		tst.b	(Boss_Data_Buffer+$01).w			 ; $FFFFFA81
		bne.s	Offset_0x045424
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045440, Obj_Child(A0)			 ; $0034
		rts
Offset_0x045424:
		move.w	#$0017, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045462, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045434:
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045440:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045462, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045456:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		subq.w	#$01, Obj_Y(A0)					 ; $0014
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045462:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045490, Obj_Child(A0)			 ; $0034
		jmp		(Swing_Setup).l				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x04547C:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045490:
		bclr	#$01, Obj_Flags(A0)				 ; $0004
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0454A6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0454A6:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04533E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0454B6:
		jsr		(Obj_Load_End_Level_Art).l			   ; Offset_0x043302
		lea		Offset_0x045810(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0454C6:
		move.l	#Offset_0x0454D4, (A0)
		move.b	#$9E, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x0454D4:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0454EA
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x0454EA:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0454F0:
		lea		Tunnelbot_Debris_Setup_Data(PC), A1	   ; Offset_0x0457D0
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.b	#$03, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x04551E
		tst.b	D0
		bne.s	Offset_0x04551E
		lea		Tunnelbot_Spires_Setup_Data(PC), A1	   ; Offset_0x0457DC
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
Offset_0x04551E:
		move.l	#Delete_Sprite_Timed_Or_Move_Light_Gravity, (A0) ; Offset_0x042956
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x04552E:
		lea		Tunnelbot_Moving_Spike_Platform_Setup_Data(PC), A1 ; Offset_0x0457EE
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x045570, (A0)
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$0030, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x045550
		addi.w	#$00E0, D0
Offset_0x045550:
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		addi.w	#$00F0, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		clr.b	Obj_Routine(A0)					 ; $0005
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x045570:
		btst	#$04, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x04560C
		move.w	Obj_X(A0), -(A7)				 ; $0010
		bsr.w	Offset_0x045640
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		swap	D6
		andi.w	#$0003, D6
		beq.s	Offset_0x0455F0
		move.b	D6, D0
		andi.b	#$01, D0
		beq.s	Offset_0x0455CC
		bclr	#$05, Obj_Status(A0)					 ; $002A
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0028, D0
		bmi.s	Offset_0x0455CC
		jsr		(Hurt_Player_A1).l			   ; Offset_0x01A71C
Offset_0x0455CC:
		andi.b	#$02, D6
		beq.s	Offset_0x0455F0
		bclr	#$06, Obj_Status(A0)					 ; $002A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0028, D0
		bmi.s	Offset_0x0455F0
		jsr		(Hurt_Player_A1).l			   ; Offset_0x01A71C
Offset_0x0455F0:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x045606
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x045606:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x04560C:
		jsr		Displace_Player_Offset(PC)			   ; Offset_0x04315A
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x045616:
		lea		Tunnelbot_Setup_Data_2(PC), A1		   ; Offset_0x0457E8
		jsr		(SetupObjectAttributes3)			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		move.b	Offset_0x04563A(PC, D0), Obj_Map_Id(A0)			 ; $0022
		moveq	#$04, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x04563A:
		dc.b	$04, $03, $05, $06, $06, $00
;-------------------------------------------------------------------------------
Offset_0x045640:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04564E(PC, D0), D1
		jmp		Offset_0x04564E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x04564E:
		dc.w	Offset_0x045658-Offset_0x04564E
		dc.w	Offset_0x045672-Offset_0x04564E
		dc.w	Offset_0x0456B2-Offset_0x04564E
		dc.w	Offset_0x0456D2-Offset_0x04564E
		dc.w	Offset_0x0456E2-Offset_0x04564E
;-------------------------------------------------------------------------------
Offset_0x045658:
		subq.w	#$04, Obj_Y(A0)					 ; $0014
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x0451D2
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x045672:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x0451D2
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0100, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x04568E
		neg.w	D0
Offset_0x04568E:
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$00DF, Obj_Timer(A0)					 ; $002E
		move.w	#$0100, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0010, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0456B2:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x0451D2
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x0456D2:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x0451D2
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0456E2:
		move.w	Obj_Y(A0), D0					 ; $0014
		addq.w	#$02, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcs.w	Offset_0x0451D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0456FC:
		subq.w	#$01, Obj_Height_3(A0)					 ; $0044
		bne.s	Offset_0x04570A
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x04570A:
		rts
;-------------------------------------------------------------------------------
Offset_0x04570C:
		lea		Offset_0x045808(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x04573A
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$01FF, D0
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		subi.w	#$0040, D1
		add.w	D0, D1
		move.w	D1, Obj_X(A1)					 ; $0010
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		subi.w	#$0020, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x04573A:
		rts
;-------------------------------------------------------------------------------
Offset_0x04573C:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x04578C
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x04578E
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x045762
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
		bset	#$06, Obj_Status(A0)					 ; $002A
Offset_0x045762:
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x04576E
		addq.w	#$06, D0
Offset_0x04576E:
		lea		Offset_0x0457B2(PC), A1
		lea		Offset_0x0457B8(PC, D0), A2
		jsr		Move_0x06_Bytes_A2_A1(PC)			   ; Offset_0x043260
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x04578C
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x04578C:
		rts
Offset_0x04578E:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0454B6, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62).l, A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0457B2:
		dc.w	(Palette_Row_1_Offset+$18)				 ; $ED38
		dc.w	(Palette_Row_1_Offset+$1A)				 ; $ED3A
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x0457B8:
		dc.w	$0CAA, $0866, $0644, $0EEE, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Tunnelbot_Setup_Data:						   ; Offset_0x0457C4
		dc.l	Tunnelbot_Mappings			   ; Offset_0x10E918
		dc.w	$254F, $0280
		dc.b	$28, $0C, $00, $10
;-------------------------------------------------------------------------------
Tunnelbot_Debris_Setup_Data:				   ; Offset_0x0457D0
		dc.l	Drill_Mobile_Debris_Mappings		   ; Offset_0x11074E
		dc.w	$4570, $0200
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Tunnelbot_Spires_Setup_Data:				   ; Offset_0x0457DC
		dc.l	Tunnelbot_Spires_Mappings			   ; Offset_0x04584C
		dc.w	$4500, $0200
		dc.b	$04, $10, $00, $84
;-------------------------------------------------------------------------------
Tunnelbot_Setup_Data_2:						   ; Offset_0x0457E8
		dc.w	$0280
		dc.b	$0C, $0C, $00, $00
;-------------------------------------------------------------------------------
Tunnelbot_Moving_Spike_Platform_Setup_Data:			   ; Offset_0x0457EE
		dc.l	Moving_Spike_Platform_Mappings		   ; Offset_0x02ABA8
		dc.w	$4001, $0280
		dc.b	$18, $30, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0457FA:
		dc.w	$0001
		dc.l	Offset_0x0454C6
		dc.b	$E4, $EA
		dc.l	Offset_0x0454C6
		dc.b	$1C, $EA
;-------------------------------------------------------------------------------
Offset_0x045808:
		dc.w	$0000
		dc.l	Offset_0x0454F0
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x045810:
		dc.w	$0004
		dc.l	Offset_0x045616
		dc.b	$00, $00
		dc.l	Offset_0x045616
		dc.b	$E4, $00
		dc.l	Offset_0x045616
		dc.b	$1C, $00
		dc.l	Offset_0x045616
		dc.b	$E4, $EA
		dc.l	Offset_0x045616
		dc.b	$1C, $EA
;-------------------------------------------------------------------------------
Offset_0x045830:
		dc.w	$0000
		dc.l	Offset_0x04552E
		dc.b	$00, $00
;-------------------------------------------------------------------------------
; Offset_0x045838:
		dc.b	$00, $05, $01, $05, $02, $05, $03, $05
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x045841:
		dc.b	$05, $04, $00, $01, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x045847:
		dc.b	$00, $00, $01, $02, $FC
;-------------------------------------------------------------------------------
Tunnelbot_Spires_Mappings:					   ; Offset_0x04584C
		dc.w	Offset_0x04584E-Tunnelbot_Spires_Mappings
Offset_0x04584E:
		dc.w	$0001
		dc.w	$F003, $0000, $FFFC
;-------------------------------------------------------------------------------
PLC_Tunnelbot:						   ; Offset_0x045856
		dc.w	(((PLC_TB_00_End-PLC_TB_00)/$06)-$01) ; Auto Detecção do número de itens na lista por Esrael Neto
PLC_TB_00:
		dc.l	Art_Boss_Explosion			   ; Offset_0x124504
		dc.w	$9520
		dc.l	Art_Spire					   ; Offset_0x1174CC
		dc.w	$A000
PLC_TB_00_End:
;===============================================================================
; Objeto 0xC4 - Mini chefe na Marble Garden
; <<<-
;===============================================================================