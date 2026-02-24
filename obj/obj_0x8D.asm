;===============================================================================
; Objeto 0x8D - Chefe da Carnival Night 1
; ->>>
;===============================================================================
; Offset_0x03B9A0:
		lea		Offset_0x03B9FA(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		move.l	#Offset_0x03BA02, (A0)
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.b	#$19, Obj_Angle(A0)				 ; $0026
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	#$0240, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$4760, Obj_Inertia(A0)					 ; $001C
		move.w	#$47E0, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.l	#Offset_0x03BA08,  Obj_Child(A0)		 ; $0034
		moveq	#$6E, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Graviton_Mobile_Palette(PC), A1		   ; Offset_0x03C25C
		jmp		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03B9FA:
		dc.w	$0180, $0300, $4780, $4900
;-------------------------------------------------------------------------------
Offset_0x03BA02:
		jmp		(Update_Sonic_Level_Limits_X_Y_Play_Music).l ; Offset_0x0433DE
;-------------------------------------------------------------------------------
Offset_0x03BA08:
		move.l	#Offset_0x03BA10, (A0)
Offset_0x03BA0E:
		rts
;-------------------------------------------------------------------------------
Offset_0x03BA10:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03BA2A(PC, D0), D1
		jsr		Offset_0x03BA2A(PC, D1)
		bsr.w	Offset_0x03C04A
		bsr.w	Offset_0x03C0AE
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03BA2A:
		dc.w	Offset_0x03BA3A-Offset_0x03BA2A
		dc.w	Offset_0x03BA88-Offset_0x03BA2A
		dc.w	Offset_0x03BAB0-Offset_0x03BA2A
		dc.w	Offset_0x03BAEE-Offset_0x03BA2A
		dc.w	Offset_0x03BB0E-Offset_0x03BA2A
		dc.w	Offset_0x03BB60-Offset_0x03BA2A
		dc.w	Offset_0x03BBB0-Offset_0x03BA2A
		dc.w	Offset_0x03BBDA-Offset_0x03BA2A
;-------------------------------------------------------------------------------
Offset_0x03BA3A:
		lea		Graviton_Mobile_Setup_Data(PC), A1	   ; Offset_0x03C198
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		move.w	Obj_Y(A0), Obj_Control_Var_0A(A0)		  ; $0014, $003A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BA9A, Obj_Child(A0)			 ; $0034
		move.w	#$FF00, Obj_Speed_X(A0)					 ; $0018
		jsr		Swing_Setup(PC)				   ; Offset_0x03669A
		lea		(CNz_Iz_Robotnik_Ship_Data).l, A2		 ; Offset_0x03658E
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03BA78
		move.b	#$09, Obj_Subtype(A1)					 ; $002C
Offset_0x03BA78:
		lea		Offset_0x03C1E0(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x03C1E8(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x03BA88:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03BA96:
		jsr		Swing_Setup(PC)				   ; Offset_0x03669A
Offset_0x03BA9A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$00B4, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BADC, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03BAB0:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		addi.w	#$0010, D2
		cmpi.w	#$0020, D2
		bcs.s	Offset_0x03BAD8
		move.w	#$0100, D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		bne.s	Offset_0x03BAD4
		neg.w	D1
		bclr	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03BAD4:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
Offset_0x03BAD8:
		jmp		Swing_Up_And_Down_Wait(PC)			   ; Offset_0x042FD8
;-------------------------------------------------------------------------------
Offset_0x03BADC:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		clr.w	Obj_Speed_X(A0)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x03BAEE:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03BB02
		rts
Offset_0x03BB02:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_X(A0)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x03BB0E:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Height_3(A0), A1					 ; $0044
		cmp.w	Obj_X(A1), D0					 ; $0010
		beq.s	Offset_0x03BB44
		bhi.s	Offset_0x03BB36
		addq.w	#$01, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		bset	#$00, Obj_Flags(A0)				 ; $0004
		rts
Offset_0x03BB36:
		subq.w	#$01, D0
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
Offset_0x03BB44:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BB64, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03BB60:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03BB64:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$00FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BB80, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03C1F8(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03BB80:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$00FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BB9C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03BB9C:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03BBB0:
		move.w	Obj_Y(A0), D0					 ; $0014
		addq.w	#$01, D0
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Y(A1), D1					 ; $0014
		subi.w	#$0014, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x03BBCC
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x03BBCC:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03BBDA:
		move.w	Obj_Y(A0), D0					 ; $0014
		subq.w	#$01, D0
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bls.s	Offset_0x03BBEC
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x03BBEC:
		move.w	Obj_Control_Var_0A(A0), Obj_Y(A0)		  ; $003A, $0014
		bra.w	Offset_0x03BA96
;-------------------------------------------------------------------------------
Offset_0x03BBF6:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BC20, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		lea		Offset_0x03C214(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03BC20:
		move.l	#Offset_0x03BC46, (A0)
		st		(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		move.w	#$48F0, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03BC46:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x03BC5A
		move.w	(Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.w	Offset_0x03BA0E
Offset_0x03BC5A:
		clr.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		jsr		Restore_PlayerControl(PC)			  ; Offset_0x0432EE
		move.w	#$0000, (Target_Camera_Min_Y).w		 ; $FFFFFA96
		lea		(Level_Resize_Min_Y).l, A2			   ; Offset_0x042628
		jsr		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
		move.w	#$4A70, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jsr		(Load_Child_Object_Simple_A2)		   ; Offset_0x041F5A
		jmp		(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03BC8C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03BCA2(PC, D0), D1
		jsr		Offset_0x03BCA2(PC, D1)
		bsr.w	Offset_0x03C13A
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03BCA2:
		dc.w	Offset_0x03BCAE-Offset_0x03BCA2
		dc.w	Offset_0x03BCC6-Offset_0x03BCA2
		dc.w	Offset_0x03BCFA-Offset_0x03BCA2
		dc.w	Offset_0x03BD3E-Offset_0x03BCA2
		dc.w	Offset_0x03BD54-Offset_0x03BCA2
		dc.w	Offset_0x03BD74-Offset_0x03BCA2
;-------------------------------------------------------------------------------
Offset_0x03BCAE:
		lea		Graviton_Mobile_Setup_Data_3(PC), A1   ; Offset_0x03C1B0
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x03C231, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03BCC6:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03BCD8
		rts
Offset_0x03BCD8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03BD0C, Obj_Child(A0)			 ; $0034
		jsr		Find_Player(PC)				   ; Offset_0x042634
		move.w	#$0100, D1
		tst.w	D0
		bne.s	Offset_0x03BCF4
		neg.w	D1
Offset_0x03BCF4:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x03BCFA:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x03BA0E
		jmp		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x03BD0C:
		moveq	#Floor_Thump_Sfx, D0					   ; $68
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		cmpi.w	#$0080, D0
		bcs.s	Offset_0x03BD28
		asr.w	#$01, D0
		neg.w	D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x03BD28:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	A0, Obj_Height_3(A1)					 ; $0044
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03BD3E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03BD4C
		rts
Offset_0x03BD4C:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03BD54:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03BD64
		jmp		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
Offset_0x03BD64:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
		bra.w	Offset_0x03BF0A
;-------------------------------------------------------------------------------
Offset_0x03BD74:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03BD82
		rts
Offset_0x03BD82:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03BD8A:
		lea		Graviton_Mobile_Setup_Data_4(PC), A1   ; Offset_0x03C1BC
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03BDA4
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03BDA4:
		moveq	#$08, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03BDAA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03BDD2(PC, D0), D1
		jsr		Offset_0x03BDD2(PC, D1)
		lea		(Graviton_Mobile_Magnetic_Angle_X_Lookup_Data).l, A1 ; Offset_0x10DAA2
		jsr		Move_Sprite_Angle_X_Lookup_Offset(PC)  ; Offset_0x04282C
		bsr.w	Offset_0x03BFEA
		bsr.w	Offset_0x03C002
		bsr.w	Offset_0x03C162
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03BDD2:
		dc.w	Offset_0x03BDE0-Offset_0x03BDD2
		dc.w	Offset_0x03BDFC-Offset_0x03BDD2
		dc.w	Offset_0x03BE2C-Offset_0x03BDD2
		dc.w	Offset_0x03BE6A-Offset_0x03BDD2
		dc.w	Offset_0x03BE9E-Offset_0x03BDD2
		dc.w	Offset_0x03BED0-Offset_0x03BDD2
		dc.w	Offset_0x03BEEE-Offset_0x03BDD2
;-------------------------------------------------------------------------------
Offset_0x03BDE0:
		lea		Graviton_Mobile_Setup_Data_6(PC), A1   ; Offset_0x03C1C8
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.b	#$05, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.l	#Offset_0x03C222, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03BDFC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03BE0A
		rts
Offset_0x03BE0A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BE5E, Obj_Child(A0)			 ; $0034
		move.b	Obj_Control_Var_0C(A0), Obj_Control_Var_0A(A0) ; $003C, $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x03BE2C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03BE48
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x03BE48:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		lea		Offset_0x03C1F0(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.b	Obj_Subtype(A0), Obj_Subtype(A1)		  ; $002C, $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x03BE5E:
		addq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03BE6A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03BE82
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		jmp		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
Offset_0x03BE82:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BEAE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03BE9E:
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03BEAE:
		cmpi.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		beq.s	Offset_0x03BEC2
		subq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		rts
Offset_0x03BEC2:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03BED0:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		addq.b	#$01, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		cmp.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		beq.s	Offset_0x03BEE6
		rts
Offset_0x03BEE6:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03BEEE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03BEFE
		jmp		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
Offset_0x03BEFE:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x03BF0A:
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		rts
;-------------------------------------------------------------------------------
Offset_0x03BF14:
		lea		Graviton_Mobile_Setup_Data_7(PC), A1   ; Offset_0x03C1D4
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03C240, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03BF58, Obj_Child(A0)			 ; $0034
		btst	#$01, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03BF3E
		move.l	#Offset_0x03BF3E, (A0)
		bra.w	Offset_0x03C030
Offset_0x03BF3E:
		move.l	#Offset_0x03BF48, (A0)
		bra.w	Offset_0x03C030
;-------------------------------------------------------------------------------
Offset_0x03BF48:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		bsr.w	Offset_0x03C030
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03BF58:
		move.b	#$09, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		addq.b	#$01, D0
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		andi.b	#$03, D0
		andi.b	#$FC, Obj_Flags(A0)				 ; $0004
		or.b	D0, Obj_Flags(A0)				 ; $0004
		rts
;-------------------------------------------------------------------------------
; Offset_0x03BF78:	Left over ???
		lea		Graviton_Mobile_Setup_Data_7(PC), A1   ; Offset_0x03C1D4
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03BF58, Obj_Child(A0)			 ; $0034
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x03BFA0
		move.l	#Offset_0x03C24F, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03BFA8, (A0)
		bra.w	Offset_0x03C030
Offset_0x03BFA0:
		move.l	#Offset_0x03C246, Obj_Child_Data(A0)			 ; $0030
Offset_0x03BFA8:
		move.l	#Offset_0x03BFB2, (A0)
		bra.w	Offset_0x03C030
;-------------------------------------------------------------------------------
Offset_0x03BFB2:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		bsr.w	Offset_0x03C030
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03BFC2:
		lea		Graviton_Mobile_Setup_Data_5(PC), A1   ; Offset_0x03C1C2
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$01, D0
		addi.b	#$0B, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$00, D0
		jsr		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03BFEA:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		addi.b	#$40, D0
		bpl.s	Offset_0x03C000
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
Offset_0x03C000:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C002:
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x03C024
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		lea		Offset_0x03C026(PC), A1
		moveq	#$04, D6
Offset_0x03C014:
		cmp.b	(A1)+, D0
		bcs.s	Offset_0x03C020
		addq.w	#$01, A1
		dbra.w	D6, Offset_0x03C014
		rts
Offset_0x03C020:
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
Offset_0x03C024:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C026:
		dc.b	$30, $01, $58, $08, $A8, $02, $D0, $08
		dc.b	$FF, $01
;-------------------------------------------------------------------------------
Offset_0x03C030:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03C046
		rts
Offset_0x03C046:
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x03C04A:
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03C054
		rts
Offset_0x03C054:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x03C060
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
Offset_0x03C060:
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		spl		D1
		bpl.s	Offset_0x03C06E
		neg.w	D0
Offset_0x03C06E:
		andi.w	#$FFC0, D0
		cmpi.w	#$01C0, D0
		bcs.s	Offset_0x03C07C
		move.w	#$01C0, D0
Offset_0x03C07C:
		lsr.w	#$04, D0
		move.l	Offset_0x03C08E(PC, D0), D2
		tst.b	D1
		bne.s	Offset_0x03C088
		neg.l	D2
Offset_0x03C088:
		add.l	D2, Obj_X(A1)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x03C08E:
		dc.l	$00028000, $00020000, $0001C000, $00018000
		dc.l	$00014000, $00010000, $0000C000, $00008000
;-------------------------------------------------------------------------------
Offset_0x03C0AE:
		tst.l	(A0)
		beq.s	Offset_0x03C102
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03C102
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x03C104
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03C0D2
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x03C0D2:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03C0E4
		addq.w	#$08, D0
Offset_0x03C0E4:
		lea		Offset_0x03C122(PC), A1
		lea		Offset_0x03C12A(PC, D0), A2
		jsr		Move_0x08_Bytes_A2_A1(PC)			   ; Offset_0x04325C
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03C102
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03C102:
		rts
Offset_0x03C104:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$003C, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03BBF6, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x03C122:
		dc.w	(Palette_Row_1_Offset+$12)				 ; $ED32
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03C12A:
		dc.w	$0060, $0020, $0020, $0640, $0888, $0EEE, $0EEE, $0AAA
;-------------------------------------------------------------------------------
Offset_0x03C13A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03C14A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
Offset_0x03C14A:
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C154
		rts
Offset_0x03C154:
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		lea		Offset_0x03C206(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03C162:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03C172
		clr.b	Obj_Col_Flags(A0)				 ; $0028
Offset_0x03C172:
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C17C
		rts
Offset_0x03C17C:
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data:					   ; Offset_0x03C198
		dc.l	Graviton_Mobile_Mappings			   ; Offset_0x10D97E
		dc.w	$2430, $0280
		dc.b	$40, $14, $00, $0F
;-------------------------------------------------------------------------------
; Graviton_Mobile_Setup_Data_2: ; Left over ???		   ; Offset_0x03C1A4
		dc.l	Robotnik_Ship_Mappings		   ; Offset_0x10D020
		dc.w	$852E, $0280
		dc.b	$20, $20, $05, $00
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data_3:				   ; Offset_0x03C1B0
		dc.l	Graviton_Mobile_Mappings			   ; Offset_0x10D97E
		dc.w	$2430, $0280
		dc.b	$10, $10, $04, $8B
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data_4:				   ; Offset_0x03C1BC
		dc.w	$0280
		dc.b	$08, $10, $0A, $00
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data_5:				   ; Offset_0x03C1C2
		dc.w	$0280
		dc.b	$14, $14, $00, $00
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data_6:				   ; Offset_0x03C1C8
		dc.l	Graviton_Mobile_Mappings			   ; Offset_0x10D97E
		dc.w	$2430, $0200
		dc.b	$08, $10, $01, $9E
;-------------------------------------------------------------------------------
Graviton_Mobile_Setup_Data_7:				   ; Offset_0x03C1D4
		dc.l	Graviton_Mobile_Mappings			   ; Offset_0x10D97E
		dc.w	$2430, $0080
		dc.b	$10, $40, $06, $AB
;-------------------------------------------------------------------------------
Offset_0x03C1E0:
		dc.w	$0000
		dc.l	Offset_0x03BC8C
		dc.b	$00, $14
;-------------------------------------------------------------------------------
Offset_0x03C1E8:
		dc.w	$0003
		dc.l	Offset_0x03BDAA
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x03C1F0:
		dc.w	$0000
		dc.l	Offset_0x03BF14
		dc.b	$00, $4C
;-------------------------------------------------------------------------------
Offset_0x03C1F8:
		dc.w	$0001
		dc.l	Offset_0x03BF14
		dc.b	$F4, $54
		dc.l	Offset_0x03BF14
		dc.b	$0C, $54
;-------------------------------------------------------------------------------
Offset_0x03C206:
		dc.w	$0001
		dc.l	Offset_0x03BD8A
		dc.b	$F8, $00
		dc.l	Offset_0x03BD8A
		dc.b	$08, $00
;-------------------------------------------------------------------------------
Offset_0x03C214:
		dc.w	$0001
		dc.l	Offset_0x03BFC2
		dc.b	$EC, $00
		dc.l	Offset_0x03BFC2
		dc.b	$14, $00
;-------------------------------------------------------------------------------
Offset_0x03C222:
		dc.b	$01, $00, $03, $00, $01, $00, $03, $00
		dc.b	$01, $04, $03, $00, $01, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x03C231:
		dc.b	$04, $00, $05, $00, $04, $00, $05, $00
		dc.b	$04, $04, $05, $00, $04, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x03C240:
		dc.b	$00, $09, $06, $09, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x03C246:
		dc.b	$09, $1F, $06, $00, $09, $02, $07, $00
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x03C24F:
		dc.b	$09, $24, $06, $00, $09, $02, $07, $00
		dc.b	$FC
;-------------------------------------------------------------------------------
; Offset_0x03C258:	; Left over ???
		dc.b	$07, $00, $01, $FC
;-------------------------------------------------------------------------------
Graviton_Mobile_Palette:					   ; Offset_0x03C25C
		dc.w	$0000, $0EEE, $006E, $004A, $0028, $00EE, $0088, $00E0
		dc.w	$00A0, $0060, $0020, $0020, $0EA8, $0A60, $0640, $0044
;===============================================================================
; Objeto 0x8D - Chefe da Carnival Night 1
; <<<-
;===============================================================================