;===============================================================================
; Objeto Miles no modo 2 jogadores
; ->>>
;===============================================================================
; Offset_0x00CC0A:
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00CC38
		lea		(Sonic_Max_Speed).w, A4				 ; $FFFFF760
		lea		(Distance_From_Top).w, A5			 ; $FFFFEE2C
		lea		(Obj_P1_Dust_Water_Splash).w, A6			 ; $FFFFCC54
		move.b	(Obj_Player_Two+Obj_Player_Selected).w, D0	 ; $FFFFB082
		cmp.b	Obj_Player_Selected(A0), D0				 ; $0038
		bne.s	Offset_0x00CC2C
		bchg	#03, Obj_Flags(A0)				 ; $0004
Offset_0x00CC2C:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x00CC54
		jmp		(Debug_Mode).l				   ; Offset_0x04B1B2
Offset_0x00CC38:
		lea		(Miles_Max_Speed).w, A4				 ; $FFFFFEC0
		lea		(Distance_From_Top_P2).w, A5		 ; $FFFFEE2E
		lea		(Obj_P2_Dust_Water_Splash).w, A6			 ; $FFFFCC9E
		move.b	(Obj_Player_One+Obj_Player_Selected).w, D0	 ; $FFFFB038
		cmp.b	Obj_Player_Selected(A0), D0				 ; $0038
		bne.s	Offset_0x00CC54
		bchg	#04, Obj_Flags(A0)				 ; $0004
Offset_0x00CC54:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x00CC62(PC, D0), D1
		jmp		Offset_0x00CC62(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00CC62:
		dc.w	Offset_0x00CC6E-Offset_0x00CC62
		dc.w	Offset_0x00CD7C-Offset_0x00CC62
		dc.w	Miles_Hurt-Offset_0x00CC62			   ; Offset_0x00E86E
		dc.w	Miles_Death-Offset_0x00CC62			   ; Offset_0x00E90A
		dc.w	Miles_ResetLevel-Offset_0x00CC62	   ; Offset_0x00E922
		dc.w	Miles_Respawning-Offset_0x00CC62	   ; Offset_0x00E936
;-------------------------------------------------------------------------------
Offset_0x00CC6E:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$0B, Obj_Height_2(A0)					 ; $001E
		move.b	#$05, Obj_Width_2(A0)					 ; $001F
		move.b	#$0B, Obj_Height_3(A0)					 ; $0044
		move.b	#$05, Obj_Width_3(A0)					 ; $0045
		move.l	#Miles_2P_Mappings, Obj_Map(A0) ; Offset_0x102F1C, $000C
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.b	#$84, Obj_Flags(A0)				 ; $0004
		move.b	#$01, Obj_Player_Selected(A0)			 ; $0038
		lea		(Player_Start_Speed_Array), A1		   ; Offset_0x1F7000
		moveq	#$00, D0
		move.b	Obj_Player_Selected(A0), D0				 ; $0038
		lsl.w	#$03, D0
		lea		(A1, D0), A1
		move.w	(A1)+, (A4)
		move.w	(A1)+, $0002(A4)
		move.w	(A1)+, Obj_Flags(A4)					 ; $0004
		tst.b	(Saved_Level_Flag).w				 ; $FFFFFE30
		bne.w	Offset_0x00CD58
		move.b	#$0C, Obj_Player_Top_Solid(A0)			 ; $0046
		move.b	#$0D, Obj_Player_LRB_Solid(A0)			 ; $0047
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00CD20
		move.w	#$0680, Obj_Art_VRAM(A0)				 ; $000A
		cmpi.b	#$12, (Current_Zone).w					 ; $FFFFFE10
		bne.s	Offset_0x00CCFA
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00CCFA:
		move.w	Obj_X(A0), (Saved_Obj_X_P1).w		  ; $0010, $FFFFFE32
		move.w	Obj_Y(A0), (Saved_Obj_Y_P1).w		  ; $0014, $FFFFFE34
		move.w	Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P1).w ; $000A, $FFFFFE3C
		move.w	Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P1).w ; $0046, $FFFFFE3E
		move.l	#Obj_Miles_Tails_2P, (Obj_Super_Sonic_Stars_RAM).w ; Offset_0x00F2AE, $FFFFCBC0
		move.w	A0, (Obj_Super_Sonic_Stars_RAM+Obj_Control_Var_00).w ; $FFFFCBF0
		bra.s	Offset_0x00CD58
Offset_0x00CD20:
		move.w	#$06A0, Obj_Art_VRAM(A0)				 ; $000A
		cmpi.b	#EMz_Id, (Current_Zone).w			; $12, $FFFFFE10
		bne.s	Offset_0x00CD34
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00CD34:
		move.w	Obj_X(A0), (Saved_Obj_X_P2).w		  ; $0010, $FFFFFEE2
		move.w	Obj_Y(A0), (Saved_Obj_Y_P2).w		  ; $0014, $FFFFFEE4
		move.w	Obj_Art_VRAM(A0), (Saved_Obj_Art_VRAM_P2).w ; $000A, $FFFFFEEC
		move.w	Obj_Player_Top_Solid(A0), (Saved_Top_Solid_P2).w ; $0046, $FFFFFEEE
		move.l	#Obj_Miles_Tails_2P, (Obj_Miles_Tails_RAM).w ; Offset_0x00F2AE, $FFFFCC0A
		move.w	A0, (Obj_Miles_Tails_RAM+Obj_Control_Var_00).w ; $FFFFCC3A
Offset_0x00CD58:
		move.b	#$00, Obj_P_Flips_Remaining(A0)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A0)			 ; $0031
		move.b	#$1E, Obj_Subtype(A0)					 ; $002C
		move.w	#$0000, (Miles_CPU_Routine).w		 ; $FFFFF708
		move.w	#$0258, (Miles_CPU_Ctrl_Auto_Timer).w		 ; $FFFFF702
		move.w	#$0000, (Miles_CPU_Respawn_Timer).w			 ; $FFFFF704
;-------------------------------------------------------------------------------
Offset_0x00CD7C:
		tst.w	(Debug_Mode_Active).w				 ; $FFFFFFFA
		beq.s	Offset_0x00CD9C
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00CD9C
		btst	#$04, (Control_Ports_Buffer_Data+$01).w		 ; $FFFFF605
		beq.s	Offset_0x00CD9C
		move.w	#$0001, (Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		clr.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		rts
Offset_0x00CD9C:
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		bne.s	Offset_0x00CDBC
		move.w	(Control_Ports_Logical_Data).w, (Control_Ports_Logical_Data_2).w ; $FFFFF602, $FFFFF66A
		tst.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		bne.s	Offset_0x00CDC8
		move.w	(Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data_2).w ; $FFFFF604, $FFFFF66A
		move.w	(Control_Ports_Buffer_Data).w, (Control_Ports_Logical_Data).w ; $FFFFF604, $FFFFF602
		bra.s	Offset_0x00CDC8
Offset_0x00CDBC:
		tst.b	(Control_Locked_Flag_P2).w			 ; $FFFFF7CF
		bne.s	Offset_0x00CDC8
		move.w	(Control_Ports_Buffer_Data+$02).w, (Control_Ports_Logical_Data_2).w ; $FFFFF606, $FFFFF66A
Offset_0x00CDC8:
		bsr.w	Miles_Display				   ; Offset_0x00D304
		btst	#$00, Obj_Player_Control(A0)			 ; $002E
		bne.s	Offset_0x00CDE6
		moveq	#$00, D0
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.w	#$0006, D0
		move.w	Offset_0x00CE36(PC, D0), D1
		jsr		Offset_0x00CE36(PC, D1)
Offset_0x00CDE6:
		cmpi.w	#$FF00, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		bne.s	Offset_0x00CDF6
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x00CDF6:
		move.w	(Screen_Wrap_X).w, D0				 ; $FFFFEEA8
		and.w	D0, Obj_X(A0)					 ; $0010
		addi.w	#$0400, Obj_X(A0)				 ; $0010
		bsr.w	Sonic_RecordPos			; Offset_0x00ACA2
		move.b	(Primary_Angle).w, Obj_Player_Next_Tilt(A0) ; $FFFFF768, $003A
		move.b	(Secondary_Angle).w, Obj_Player_Tilt(A0) ; $FFFFF76A, $003B
		btst	#$01, Obj_Player_Control(A0)			 ; $002E
		bne.s	Offset_0x00CE24
		bsr.w	Miles_Animate_Sprite_2P		   ; Offset_0x00EDD0
		bsr.w	Load_Miles_Dynamic_PLC_2P			   ; Offset_0x00F150
Offset_0x00CE24:
		move.b	Obj_Player_Control(A0), D0				 ; $002E
		andi.b	#$A0, D0
		bne.s	Offset_0x00CE34
		jsr		(Touch_Response_2P).l			 ; Offset_0x00A168
Offset_0x00CE34:
		rts
;-------------------------------------------------------------------------------
Offset_0x00CE36:
		dc.w	Offset_0x00CE3E-Offset_0x00CE36
		dc.w	Offset_0x00CE62-Offset_0x00CE36
		dc.w	Offset_0x00CF2C-Offset_0x00CE36
		dc.w	Offset_0x00CF4E-Offset_0x00CE36
;-------------------------------------------------------------------------------
Offset_0x00CE3E:
		bsr.w	Offset_0x00CFE2
		bsr.w	Miles_Jump					   ; Offset_0x00E238
		bsr.w	Miles_SlopeResist			   ; Offset_0x00E4DC
		bsr.w	Miles_Move					   ; Offset_0x00DCD4
		bsr.w	Offset_0x00CF7C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		bsr.w	Miles_SlopeRepel			   ; Offset_0x00E54E
		rts
;-------------------------------------------------------------------------------
Offset_0x00CE62:
		tst.b	(Level_Boundaries_Flag).w			 ; $FFFFF668
		bne.s	Offset_0x00CE96
		bsr.w	Miles_JumpHeight			   ; Offset_0x00E2F8
		bsr.w	Miles_ChgJumpDir			   ; Offset_0x00E0EC
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00CE84
		subi.w	#$0028, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00CE84:
		bsr.w	Miles_JumpAngle				   ; Offset_0x00E590
		movem.l A4-A6, -(A7)
		bsr.w	Miles_Floor					   ; Offset_0x00E5F0
		movem.l (A7)+, A4-A6
		rts
Offset_0x00CE96:
		bsr.w	Offset_0x00CEB6
		bsr.w	Miles_ChgJumpDir			   ; Offset_0x00E0EC
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Miles_JumpAngle				   ; Offset_0x00E590
		movem.l A4-A6, -(A7)
		bsr.w	Miles_Floor					   ; Offset_0x00E5F0
		movem.l (A7)+, A4-A6
		rts
Offset_0x00CEB6:
		cmpi.b	#$01, (Level_Boundaries_Flag).w		 ; $FFFFF668
		bne.s	Offset_0x00CEF6
		move.b	(Control_Ports_Logical_Data_2+$01).w, D0	 ; $FFFFF66B
		andi.b	#$30, D0
		beq.s	Offset_0x00CED0
		subi.w	#$0040, Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x00CEE0
Offset_0x00CED0:
		move.b	(Control_Ports_Logical_Data_2).w, D0		 ; $FFFFF66A
		andi.b	#$40, D0
		beq.s	Offset_0x00CEE0
		subi.w	#$0010, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00CEE0:
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		cmpi.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		bge.s	Offset_0x00CEF4
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00CEF4:
		rts
Offset_0x00CEF6:
		move.b	(Control_Ports_Logical_Data_2+$01).w, D0	 ; $FFFFF66B
		andi.b	#$30, D0
		beq.s	Offset_0x00CF0E
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x00CF24
		subi.w	#$0300, Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x00CF24
Offset_0x00CF0E:
		move.b	(Control_Ports_Logical_Data_2).w, D0		 ; $FFFFF66A
		andi.b	#$40, D0
		beq.s	Offset_0x00CF24
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x00CF24
		subi.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00CF24:
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x00CF2C:
		tst.b	Obj_Player_Spdsh_Flag(A0)				 ; $003D
		bne.s	Offset_0x00CF36
		bsr.w	Miles_Jump					   ; Offset_0x00E238
Offset_0x00CF36:
		bsr.w	Miles_RollRepel				   ; Offset_0x00E512
		bsr.w	Miles_RollSpeed				   ; Offset_0x00DFC6
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		bsr.w	Miles_SlopeRepel			   ; Offset_0x00E54E
		rts
;-------------------------------------------------------------------------------
Offset_0x00CF4E:
		bsr.w	Miles_JumpHeight			   ; Offset_0x00E2F8
		bsr.w	Miles_ChgJumpDir			   ; Offset_0x00E0EC
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00CF6A
		subi.w	#$0028, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00CF6A:
		bsr.w	Miles_JumpAngle				   ; Offset_0x00E590
		movem.l A4-A6, -(A7)
		bsr.w	Miles_Floor					   ; Offset_0x00E5F0
		movem.l (A7)+, A4-A6
		rts
Offset_0x00CF7C:
		tst.b	Obj_Player_Status(A0)					 ; $002F
		bmi.s	Offset_0x00CFA2
		move.w	Obj_Inertia(A0), D0				 ; $001C
		bpl.s	Offset_0x00CF8A
		neg.w	D0
Offset_0x00CF8A:
		cmpi.w	#$0080, D0
		bcs.s	Offset_0x00CFA2
		move.b	(Control_Ports_Logical_Data_2).w, D0		 ; $FFFFF66A
		andi.b	#$0C, D0
		bne.s	Offset_0x00CFA2
		btst	#$01, (Control_Ports_Logical_Data_2).w		 ; $FFFFF66A
		bne.s	Offset_0x00CFA4
Offset_0x00CFA2:
		rts
Offset_0x00CFA4:
		btst	#$02, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00CFAE
		rts
Offset_0x00CFAE:
		bset	#$02, Obj_Status(A0)					 ; $002A
		move.b	#$07, Obj_Height_2(A0)					 ; $001E
		move.b	#$03, Obj_Width_2(A0)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		tst.w	Obj_Inertia(A0)					 ; $001C
		bne.s	Offset_0x00CFE0
		move.w	#$0200, Obj_Inertia(A0)					 ; $001C
Offset_0x00CFE0:
		rts
Offset_0x00CFE2:
		tst.b	Obj_Player_Spdsh_Flag(A0)				 ; $003D
		bne.s	Offset_0x00D032
		cmpi.b	#$08, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x00D030
		move.b	(Control_Ports_Logical_Data_2+$01).w, D0	 ; $FFFFF66B
		andi.b	#$70, D0
		beq.w	Offset_0x00D030
		move.b	#$09, Obj_Ani_Number(A0)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		addq.l	#$04, A7
		move.b	#$01, Obj_Player_Spdsh_Flag(A0)			 ; $003D
		move.w	#$0000, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		cmpi.b	#$0C, Obj_Subtype(A0)					 ; $002C
		bcs.s	Offset_0x00D028
		move.b	#$02, Obj_Ani_Number(A6)				 ; $0020
Offset_0x00D028:
		bsr.w	Miles_LevelBoundaries		   ; Offset_0x00E17C
		bsr.w	Player_AnglePos				   ; Offset_0x009144
Offset_0x00D030:
		rts
Offset_0x00D032:
		move.b	(Control_Ports_Logical_Data_2).w, D0		 ; $FFFFF66A
		btst	#$01, D0
		bne.w	Offset_0x00D0C2
		move.b	#$07, Obj_Height_2(A0)					 ; $001E
		move.b	#$03, Obj_Width_2(A0)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		move.b	#$00, Obj_Player_Spdsh_Flag(A0)			 ; $003D
		moveq	#$00, D0
		move.b	Obj_Player_Spdsh_Cnt(A0), D0			 ; $003E
		add.w	D0, D0
		move.w	Miles_Spindash_Speed_2P(PC, D0), Obj_Inertia(A0) ; Offset_0x00D0B0, $001C
		move.w	Obj_Inertia(A0), D0				 ; $001C
		subi.w	#$0800, D0
		add.w	D0, D0
		andi.w	#$1F00, D0
		neg.w	D0
		addi.w	#$2000, D0
		lea		(Camera_X_Scroll_Delay).w, A1		 ; $FFFFEE24
		cmpa.w	#Obj_Player_One, A0				 ; $B000
		beq.s	Offset_0x00D08A
		lea		(Camera_X_Scroll_Delay_2P).w, A1			 ; $FFFFEE28
Offset_0x00D08A:
		move.w	D0, (A1)
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00D098
		neg.w	Obj_Inertia(A0)					 ; $001C
Offset_0x00D098:
		bset	#$02, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Ani_Number(A6)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x00D10A
;-------------------------------------------------------------------------------
Miles_Spindash_Speed_2P:					   ; Offset_0x00D0B0
		dc.w	$0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
		dc.w	$0C00
;-------------------------------------------------------------------------------
Offset_0x00D0C2:
		tst.w	Obj_Player_Spdsh_Cnt(A0)				 ; $003E
		beq.s	Offset_0x00D0DA
		move.w	Obj_Player_Spdsh_Cnt(A0), D0			 ; $003E
		lsr.w	#$05, D0
		sub.w	D0, Obj_Player_Spdsh_Cnt(A0)			 ; $003E
		bcc.s	Offset_0x00D0DA
		move.w	#$0000, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
Offset_0x00D0DA:
		move.b	(Control_Ports_Logical_Data_2+$01).w, D0	 ; $FFFFF66B
		andi.b	#$70, D0
		beq.w	Offset_0x00D10A
		move.w	#$0900, Obj_Ani_Number(A0)				 ; $0020
		move.w	#Rolling_Sfx, D0				 ; $003C
		jsr		(PlaySound).l					; Offset_0x001176
		addi.w	#$0200, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		cmpi.w	#$0800, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		bcs.s	Offset_0x00D10A
		move.w	#$0800, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
Offset_0x00D10A:
		addq.l	#$04, A7
		cmpi.w	#$0060, (A5)
		beq.s	Offset_0x00D118
		bcc.s	Offset_0x00D116
		addq.w	#$04, (A5)
Offset_0x00D116:
		subq.w	#$02, (A5)
Offset_0x00D118:
		bsr.w	Player_AnglePos				   ; Offset_0x009144
		rts
;===============================================================================
; Objeto Miles no modo 2 jogadores
; <<<-
;===============================================================================