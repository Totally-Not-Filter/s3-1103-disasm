;===============================================================================
; Objeto Sonic, Knuckles no modo 2 jogadores
; ->>>
;===============================================================================
; Offset_0x00A552:
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00A580
		lea		(Sonic_Max_Speed).w, A4				 ; $FFFFF760
		lea		(Distance_From_Top).w, A5			 ; $FFFFEE2C
		lea		(Obj_P1_Dust_Water_Splash).w, A6			 ; $FFFFCC54
		move.b	(Obj_Player_Two+Obj_Player_Selected).w, D0	 ; $FFFFB082
		cmp.b	Obj_Player_Selected(A0), D0				 ; $0038
		bne.s	Offset_0x00A574
		bchg	#03, Obj_Flags(A0)				 ; $0004
Offset_0x00A574:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x00A59C
		jmp		(Debug_Mode).l				   ; Offset_0x04B1B2
Offset_0x00A580:
		lea		(Miles_Max_Speed).w, A4				 ; $FFFFFEC0
		lea		(Distance_From_Top_P2).w, A5		 ; $FFFFEE2E
		lea		(Obj_P2_Dust_Water_Splash).w, A6			 ; $FFFFCC9E
		move.b	(Obj_Player_One+Obj_Player_Selected).w, D0	 ; $FFFFB038
		cmp.b	Obj_Player_Selected(A0), D0				 ; $0038
		bne.s	Offset_0x00A59C
		bchg	#04, Obj_Flags(A0)				 ; $0004
Offset_0x00A59C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x00A5AA(PC, D0), D1
		jmp		Offset_0x00A5AA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00A5AA:
		dc.w	Offset_0x00A5B6-Offset_0x00A5AA
		dc.w	Offset_0x00A6D4-Offset_0x00A5AA
		dc.w	Sonic_Hurt-Offset_0x00A5AA			   ; Offset_0x00C03E
		dc.w	Sonic_Death-Offset_0x00A5AA			   ; Offset_0x00C0F4
		dc.w	Sonic_ResetLevel-Offset_0x00A5AA	   ; Offset_0x00C29C
		dc.w	Sonic_Animate-Offset_0x00A5AA		   ; Offset_0x00C2B0
;-------------------------------------------------------------------------------
Offset_0x00A5B6:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$0B, Obj_Height_2(A0)					 ; $001E
		move.b	#$05, Obj_Width_2(A0)					 ; $001F
		move.b	#$0B, Obj_Height_3(A0)					 ; $0044
		move.b	#$05, Obj_Width_3(A0)					 ; $0045
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		lea		(Player_Start_Speed_Array).l, A1		   ; Offset_0x1F7000
		moveq	#$00, D0
		move.b	Obj_Player_Selected(A0), D0				 ; $0038
		lsl.w	#$03, D0
		lea		(A1, D0), A1
		move.w	(A1)+, (A4)
		move.w	(A1)+, Acceleration(A4)					 ; $0002
		move.w	(A1)+, Deceleration(A4)					 ; $0004
		tst.b	(Saved_Level_Flag).w				 ; $FFFFFE30
		bne.w	Offset_0x00A6B2
		move.b	#$0C, Obj_Player_Top_Solid(A0)			 ; $0046
		move.b	#$0D, Obj_Player_LRB_Solid(A0)			 ; $0047
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00A66A
		move.w	#$0680, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Sonic_Mappings_2P, Obj_Map(A0) ; Offset_0x102C70, $000C
		tst.b	Obj_Player_Selected(A0)					 ; $0038
		beq.s	Offset_0x00A642
		move.l	#Knuckles_Mappings_2P, Obj_Map(A0)	 ; Offset_0x1032E0, $000C
		addi.w	#$2000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00A642:
		cmpi.b	#EMz_Id, (Current_Zone).w			; $12, $FFFFFE10
		bne.s	Offset_0x00A650
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00A650:
		move.w	Obj_X(A0), (Saved_Obj_X_P1).w		  ; $0010, $FFFFFE32
		move.w	Obj_Y(A0), (Saved_Obj_Y_P1).w		  ; $0014, $FFFFFE34
		move.w	Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P1).w		 ; $000A, $FFFFFE3C
		move.w	Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P1).w ; $0046, $FFFFFE3E
		bra.s	Offset_0x00A6B2
Offset_0x00A66A:
		move.w	#$06A0, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Sonic_Mappings_2P, Obj_Map(A0) ; Offset_0x102C70, $000C
		tst.b	Obj_Player_Selected(A0)					 ; $0038
		beq.s	Offset_0x00A68C
		move.l	#Knuckles_Mappings_2P, Obj_Map(A0)	 ; Offset_0x1032E0, $000C
		addi.w	#$2000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00A68C:
		cmpi.b	#EMz_Id, (Current_Zone).w			; $12, $FFFFFE10
		bne.s	Offset_0x00A69A
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00A69A:
		move.w	Obj_X(A0), (Saved_Obj_X_P2).w		  ; $0010, $FFFFFEE2
		move.w	Obj_Y(A0), (Saved_Obj_Y_P2).w		  ; $0014, $FFFFFEE4
		move.w	Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P2).w		 ; $000A, $FFFFFEEC
		move.w	Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P2).w ; $0046, $FFFFFEEE
Offset_0x00A6B2:
		move.b	#$00, Obj_P_Flips_Remaining(A0)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A0)			 ; $0031
		move.b	#$00, (Super_Sonic_flag).w			 ; $FFFFFE19
		move.b	#$1E, Obj_Subtype(A0)					 ; $002C
		bsr.w	ResetPlayerPositionArray			; Offset_0x00ACEC
		move.w	#$0000, (Dropdash_flag).w	   ; $FFFFFE5A
Offset_0x00A6D4:
		tst.w	(Debug_Mode_Active).w				 ; $FFFFFFFA
		beq.s	Offset_0x00A6F4
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00A6F4
		btst	#$04, (Control_Ports_Buffer_Data+$0001).w	 ; $FFFFF605
		beq.s	Offset_0x00A6F4
		move.w	#$0001, (Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		clr.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		rts
Offset_0x00A6F4:
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00A708
		tst.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		bne.s	Offset_0x00A714
		move.w	(Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data).w ; $FFFFF604, $FFFFF602
		bra.s	Offset_0x00A714
Offset_0x00A708:
		tst.b	(Control_Locked_Flag_P2).w			 ; $FFFFF7CF
		bne.s	Offset_0x00A714
		move.w	(Control_Ports_Buffer_Data+$0002).w, (Control_Ports_Logical_Data).w ; $FFFFF606, $FFFFF602
Offset_0x00A714:
		bsr.w	Sonic_Display				   ; Offset_0x00ABD2
		btst	#$00, Obj_Player_Control(A0)			 ; $002E
		bne.s	Offset_0x00A732
		moveq	#$00, D0
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.w	#$0006, D0
		move.w	Offset_0x00A782(PC, D0), D1
		jsr		Offset_0x00A782(PC, D1)
Offset_0x00A732:
		cmpi.w	#$FF00, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		bne.s	Offset_0x00A742
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x00A742:
		move.w	(Screen_Wrap_X).w, D0				 ; $FFFFEEA8
		and.w	D0, Obj_X(A0)					 ; $0010
		addi.w	#$0400, Obj_X(A0)				 ; $0010
		bsr.w	Sonic_RecordPos			; Offset_0x00ACA2
		move.b	(Primary_Angle).w, Obj_Player_Next_Tilt(A0) ; $FFFFF768, $003A
		move.b	(Secondary_Angle).w, Obj_Player_Tilt(A0)	; $FFFFF76A, $003B
		btst	#$01, Obj_Player_Control(A0)			 ; $002E
		bne.s	Offset_0x00A770
		bsr.w	Sonic_Or_Knuckles_Animate_Sprite_2P	   ; Offset_0x00C83E
		bsr.w	LoadSonicDynamicPLC_2P		; Offset_0x00CBA2
Offset_0x00A770:
		move.b	Obj_Player_Control(A0), D0				 ; $002E
		andi.b	#$A0, D0
		bne.s	Offset_0x00A780
		jsr		(Touch_Response_2P).l			 ; Offset_0x00A168
Offset_0x00A780:
		rts
;-------------------------------------------------------------------------------
Offset_0x00A782:
		dc.w	Offset_0x00A78A-Offset_0x00A782
		dc.w	Offset_0x00A7FC-Offset_0x00A782
		dc.w	Offset_0x00A82A-Offset_0x00A782
		dc.w	Offset_0x00A84C-Offset_0x00A782
;-------------------------------------------------------------------------------
Offset_0x00A78A:
		move.b	(Control_Ports_Logical_Data+$001).w, D0		 ; $FFFFF603
		andi.b	#$70, D0
		bne.s	Offset_0x00A7D8
		cmpi.b	#$0A, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x00A7FA
		cmpi.b	#$0B, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x00A7FA
		cmpi.b	#$05, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x00A7D8
		cmpi.b	#$1E, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x00A7D8
		bsr.w	Sonic_SlopeResist			   ; Offset_0x00BC36
		move.b	(Control_Ports_Logical_Data).w, D0			 ; $FFFFF602
		andi.b	#$7F, D0
		beq.s	Offset_0x00A7F2
		move.b	#$0A, Obj_Ani_Number(A0)				 ; $0020
		cmpi.b	#$AC, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x00A7F2
		move.b	#$0B, Obj_Ani_Number(A0)				 ; $0020
		bra.s	Offset_0x00A7F2
Offset_0x00A7D8:
		bsr.w	Offset_0x00A8E0
		bsr.w	Sonic_Jump					   ; Offset_0x00B61C
		bsr.w	Sonic_SlopeResist			   ; Offset_0x00BC36
		bsr.w	Sonic_Move					   ; Offset_0x00AF42
		bsr.w	Offset_0x00A87A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x00A7F2:
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		bsr.w	Sonic_SlopeRepel			   ; Offset_0x00BCBA
Offset_0x00A7FA:
		rts
;-------------------------------------------------------------------------------
Offset_0x00A7FC:
		bsr.w	Sonic_JumpHeight			   ; Offset_0x00B6FA
		bsr.w	Sonic_ChgJumpDir			   ; Offset_0x00B4D0
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00A818
		subi.w	#$0028, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00A818:
		bsr.w	Sonic_JumpAngle				   ; Offset_0x00BD1C
		movem.l A4-A6, -(A7)
		bsr.w	Sonic_Floor					   ; Offset_0x00BD7C
		movem.l (A7)+, A4-A6
		rts
;-------------------------------------------------------------------------------
Offset_0x00A82A:
		tst.b	Obj_Player_Spdsh_Flag(A0)				 ; $003D
		bne.s	Offset_0x00A834
		bsr.w	Sonic_Jump					   ; Offset_0x00B61C
Offset_0x00A834:
		bsr.w	Sonic_RollRepel				   ; Offset_0x00BC7E
		bsr.w	Sonic_RollSpeed				   ; Offset_0x00B3AC
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		bsr.w	Sonic_SlopeRepel			   ; Offset_0x00BCBA
		rts
;-------------------------------------------------------------------------------
Offset_0x00A84C:
		bsr.w	Sonic_JumpHeight			   ; Offset_0x00B6FA
		bsr.w	Sonic_ChgJumpDir			   ; Offset_0x00B4D0
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00A868
		subi.w	#$0028, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00A868:
		bsr.w	Sonic_JumpAngle				   ; Offset_0x00BD1C
		movem.l A4-A6, -(A7)
		bsr.w	Sonic_Floor					   ; Offset_0x00BD7C
		movem.l (A7)+, A4-A6
		rts
;-------------------------------------------------------------------------------
Offset_0x00A87A:
		tst.b	Obj_Player_Status(A0)					 ; $002F
		bmi.s	Offset_0x00A8A0
		move.w	Obj_Inertia(A0), D0				 ; $001C
		bpl.s	Offset_0x00A888
		neg.w	D0
Offset_0x00A888:
		cmpi.w	#$0080, D0
		bcs.s	Offset_0x00A8A0
		move.b	(Control_Ports_Logical_Data).w, D0			 ; $FFFFF602
		andi.b	#$0C, D0
		bne.s	Offset_0x00A8A0
		btst	#$01, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		bne.s	Offset_0x00A8A2
Offset_0x00A8A0:
		rts
Offset_0x00A8A2:
		btst	#$02, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00A8AC
		rts
Offset_0x00A8AC:
		bset	#$02, Obj_Status(A0)					 ; $002A
		move.b	#$07, Obj_Height_2(A0)					 ; $001E
		move.b	#$03, Obj_Width_2(A0)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		tst.w	Obj_Inertia(A0)					 ; $001C
		bne.s	Offset_0x00A8DE
		move.w	#$0200, Obj_Inertia(A0)					 ; $001C
Offset_0x00A8DE:
		rts
;-------------------------------------------------------------------------------
Offset_0x00A8E0:
		tst.b	Obj_Player_Spdsh_Flag(A0)				 ; $003D
		bne.s	Offset_0x00A92C
		cmpi.b	#$08, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x00A92A
		move.b	(Control_Ports_Logical_Data+$001).w, D0		 ; $FFFFF603
		andi.b	#$70, D0
		beq.w	Offset_0x00A92A
		move.b	#$09, Obj_Ani_Number(A0)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		addq.l	#$04, A7
		move.b	#$01, Obj_Player_Spdsh_Flag(A0)			 ; $003D
		move.w	#$0000, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		cmpi.b	#$0C, Obj_Subtype(A0)					 ; $002C
		bcs.s	Offset_0x00A926
		move.b	#$02, Obj_Ani_Number(A6)				 ; $0020
Offset_0x00A926:
		bsr.w	Player_AnglePos				   ; Offset_0x009144
Offset_0x00A92A:
		rts
Offset_0x00A92C:
		move.b	(Control_Ports_Logical_Data).w, D0			 ; $FFFFF602
		btst	#$01, D0
		bne.w	Offset_0x00A9DA
		move.b	#$07, Obj_Height_2(A0)					 ; $001E
		move.b	#$03, Obj_Width_2(A0)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		move.b	#$00, Obj_Player_Spdsh_Flag(A0)			 ; $003D
		moveq	#$00, D0
		move.b	Obj_Player_Spdsh_Cnt(A0), D0			 ; $003E
		add.w	D0, D0
		move.w	Sonic_Spindash_Speed_2P(PC, D0), Obj_Inertia(A0) ; Offset_0x00A9B6, $001C
		tst.b	(Super_Sonic_flag).w				 ; $FFFFFE19
		beq.s	Offset_0x00A96E
		move.w	Super_Sonic_Spindash_Speed_2P(PC, D0), Obj_Inertia(A0) ; Offset_0x00A9C8, $001C
Offset_0x00A96E:
		move.w	Obj_Inertia(A0), D0				 ; $001C
		subi.w	#$0800, D0
		add.w	D0, D0
		andi.w	#$1F00, D0
		neg.w	D0
		addi.w	#$2000, D0
		lea		(Camera_X_Scroll_Delay).w, A1		 ; $FFFFEE24
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		beq.s	Offset_0x00A990
		lea		(Camera_X_Scroll_Delay_2P).w, A1			 ; $FFFFEE28
Offset_0x00A990:
		move.w	D0, (A1)
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00A99E
		neg.w	Obj_Inertia(A0)					 ; $001C
Offset_0x00A99E:
		bset	#$02, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Ani_Number(A6)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x00AA22
;-------------------------------------------------------------------------------
Sonic_Spindash_Speed_2P:					   ; Offset_0x00A9B6
		dc.w	$0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
		dc.w	$0C00
;-------------------------------------------------------------------------------
Super_Sonic_Spindash_Speed_2P:				   ; Offset_0x00A9C8
		dc.w	$0B00, $0B80, $0C00, $0C80, $0D00, $0D80, $0E00, $0E80
		dc.w	$0F00
;-------------------------------------------------------------------------------
Offset_0x00A9DA:
		tst.w	Obj_Player_Spdsh_Cnt(A0)				 ; $003E
		beq.s	Offset_0x00A9F2
		move.w	Obj_Player_Spdsh_Cnt(A0), D0			 ; $003E
		lsr.w	#$05, D0
		sub.w	D0, Obj_Player_Spdsh_Cnt(A0)			 ; $003E
		bcc.s	Offset_0x00A9F2
		move.w	#$0000, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
Offset_0x00A9F2:
		move.b	(Control_Ports_Logical_Data+$001).w, D0		 ; $FFFFF603
		andi.b	#$70, D0
		beq.w	Offset_0x00AA22
		move.w	#$0900, Obj_Ani_Number(A0)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		addi.w	#$0200, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		cmpi.w	#$0800, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		bcs.s	Offset_0x00AA22
		move.w	#$0800, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
Offset_0x00AA22:
		addq.l	#$04, A7
		cmpi.w	#$0060, (A5)
		beq.s	Offset_0x00AA30
		bcc.s	Offset_0x00AA2E
		addq.w	#$04, (A5)
Offset_0x00AA2E:
		subq.w	#$02, (A5)
Offset_0x00AA30:
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		rts
;===============================================================================
; Objeto Sonic, Knuckles no modo 2 jogadores
; <<<-
;===============================================================================