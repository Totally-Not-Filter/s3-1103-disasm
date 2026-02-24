;===============================================================================
; Objeto 0xB4 - Chefe na Flying Battery
; ->>>
;===============================================================================
; Offset_0x03D4DE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03D4F4(PC, D0), D1
		jsr		Offset_0x03D4F4(PC, D1)
		bsr.w	Offset_0x03DB30
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03D4F4:
		dc.w	Offset_0x03D4FE-Offset_0x03D4F4
		dc.w	Offset_0x03D564-Offset_0x03D4F4
		dc.w	Offset_0x03D57E-Offset_0x03D4F4
		dc.w	Offset_0x03D5A8-Offset_0x03D4F4
		dc.w	Offset_0x03D618-Offset_0x03D4F4
;-------------------------------------------------------------------------------
Offset_0x03D4FE:
		lea		Hang_Mobile_Setup_Data(PC), A1		   ; Offset_0x03DBAA
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	#$3090, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		moveq	#$6F, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Pal_Hang_Mobile(PC), A1		   ; Offset_0x03DC90
		jsr		(Pal_Load_Line_1).l			   ; Offset_0x04314C
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D56E, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		(FBz_Robotnik_Ship_Data).l, A2			 ; Offset_0x036596
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03D55C
		move.b	#$0B, Obj_Subtype(A1)					 ; $002C
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
Offset_0x03D55C:
		lea		Offset_0x03DBF2(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03D564:
		move.w	(Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03D56E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		moveq	#Boss_Snd, D0					   ; $19
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03D57C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03D57E:
		move.w	(Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
		move.w	#$3090, D0
		cmp.w	(Camera_X).w, D0					 ; $FFFFEE78
		bls.s	Offset_0x03D590
		rts
Offset_0x03D590:
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
Offset_0x03D594:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.b	#$09, Obj_Control_Var_09(A0)			 ; $0039
		rts
;-------------------------------------------------------------------------------
Offset_0x03D5A8:
		bsr.w	Offset_0x03DACC
		jsr		Find_Player(PC)				   ; Offset_0x042634
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03D5F4
		cmpi.w	#$0018, D2
		bcc.s	Offset_0x03D5CC
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03D5CC
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03D5CC:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x03D5F4
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x03D5F6
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		bne.s	Offset_0x03D5F4
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03D5F4:
		rts
Offset_0x03D5F6:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$01FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D632, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D618:
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		lea		(Hang_Mobile_Angle_Y_Lookup_Data).l, A2  ; Offset_0x10F8D8
		jsr		Move_Sprite_Angle_Y_Lookup(PC)		   ; Offset_0x0427CE
		bsr.w	Offset_0x03DAE8
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03D632:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bra.w	Offset_0x03D594
;-------------------------------------------------------------------------------
Offset_0x03D63C:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x03D65E
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		lea		(Hang_Mobile_Angle_Y_Lookup_Data).l, A2  ; Offset_0x10F8D8
		jsr		Move_Sprite_Angle_Y_Lookup(PC)		   ; Offset_0x0427CE
		bsr.w	Offset_0x03DAE8
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03D65E:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D67A, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D67A:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D6A4, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x03DC1C(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03D6A4:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		st		(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D6C2, Obj_Child(A0)			 ; $0034
		jmp		(Restore_LevelMusic).l			 ; Offset_0x0432CA
;-------------------------------------------------------------------------------
Offset_0x03D6C2:
		move.l	#Offset_0x03D6DE, (A0)
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		move.w	#$3170, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03D6DE:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x03D6F2
		move.w	(Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.w	Offset_0x03D57C
Offset_0x03D6F2:
		clr.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		jsr		Restore_PlayerControl(PC)			  ; Offset_0x0432EE
		move.w	#$6000, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jsr		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
		jmp		(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03D712:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03D724(PC, D0), D1
		jsr		Offset_0x03D724(PC, D1)
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03D724:
		dc.w	Offset_0x03D72C-Offset_0x03D724
		dc.w	Offset_0x03D752-Offset_0x03D724
		dc.w	Offset_0x03D7B2-Offset_0x03D724
		dc.w	Offset_0x03D7CC-Offset_0x03D724
;-------------------------------------------------------------------------------
Offset_0x03D72C:
		lea		Hang_Mobile_Setup_Data_2(PC), A1	   ; Offset_0x03DBB6
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		lea		Offset_0x03DC06(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03D74C
		move.w	A0, Obj_Height_3(A1)					 ; $0044
		rts
Offset_0x03D74C:
		move.w	A0, Obj_Child_Ref(A1)					 ; $0046
		rts
;-------------------------------------------------------------------------------
Offset_0x03D752:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03D796
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03D768
		rts
Offset_0x03D768:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x03D780
		addq.w	#$08, D0
Offset_0x03D780:
		lea		Offset_0x03D7A2(PC, D0), A1
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D7B6, Obj_Child(A0)			 ; $0034
		rts
Offset_0x03D796:
		lea		Offset_0x03DC36(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		Go_Delete_Object_A0_2(PC)			   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03D7A2:
		dc.w	$0100, $0007, $0100, $0000, $FF00, $0000, $FF00, $0007
;-------------------------------------------------------------------------------
Offset_0x03D7B2:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03D7B6:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D7D6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D7CC:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03D7D6:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$03, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03D7E8:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03D7FC(PC, D0), D1
		jsr		Offset_0x03D7FC(PC, D1)
		moveq	#$00, D0
		jmp		Child_Display_Or_Flicker_Move_2(PC)	   ; Offset_0x04250E
;-------------------------------------------------------------------------------
Offset_0x03D7FC:
		dc.w	Offset_0x03D802-Offset_0x03D7FC
		dc.w	Offset_0x03D828-Offset_0x03D7FC
		dc.w	Offset_0x03D856-Offset_0x03D7FC
;-------------------------------------------------------------------------------
Offset_0x03D802:
		lea		Hang_Mobile_Setup_Data_3(PC), A1	   ; Offset_0x03DBBC
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x03D81A
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03D81A:
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		lea		Offset_0x03DC0E(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x03D828:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03D83A
		rts
Offset_0x03D83A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$01FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D872, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D856:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
		lea		(Hang_Mobile_Angle_Y_Lookup_Data_2).l, A2 ; Offset_0x10F918
		jsr		Move_Sprite_Angle_Y_Lookup(PC)		   ; Offset_0x0427CE
		bsr.w	Offset_0x03DB1A
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03D872:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03D87A:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03D88E(PC, D0), D1
		jsr		Offset_0x03D88E(PC, D1)
		moveq	#$08, D0
		jmp		Child_Display_Or_Flicker_Move(PC)	   ; Offset_0x0424E2
;-------------------------------------------------------------------------------
Offset_0x03D88E:
		dc.w	Offset_0x03D892-Offset_0x03D88E
		dc.w	Offset_0x03D8C6-Offset_0x03D88E
;-------------------------------------------------------------------------------
Offset_0x03D892:
		lea		Hang_Mobile_Setup_Data_3(PC), A1	   ; Offset_0x03DBBC
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#-$1C, D0
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x03D8B0
		bset	#$00, Obj_Flags(A0)				 ; $0004
		neg.w	D0
Offset_0x03D8B0:
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		move.b	D0, Obj_Control_Var_12(A0)				 ; $0042
		move.b	#$02, Obj_Control_Var_13(A0)			 ; $0043
		rts
;-------------------------------------------------------------------------------
Offset_0x03D8C6:
		jsr		Child_Get_Priority(PC)		   ; Offset_0x043230
		bra.w	Offset_0x03D9B8
;-------------------------------------------------------------------------------
Offset_0x03D8CE:
		lea		Hang_Mobile_Setup_Data_4(PC), A1	   ; Offset_0x03DBC2
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
Offset_0x03D8D6:
		move.l	#Offset_0x03D8E8, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03D8E8:
		jsr		Child_Get_Priority(PC)		   ; Offset_0x043230
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03D922
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03D918
		move.l	#Refresh_Child_Position_Wait, (A0)	   ; Offset_0x042F8A
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D8D6, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03DC16(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
Offset_0x03D918:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03D922:
		move.l	#Offset_0x03D93C, (A0)
		move.w	Obj_Control_Var_0E(A1), Obj_Child_Ref(A0) ; $003E, $0046
		subq.b	#$04, Obj_Control_Var_13(A0)			 ; $0043
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03D93C:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03D944:
		bsr.w	Offset_0x03DA3A
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.l	#Offset_0x03D958, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D958:
		move.l	#Refresh_Animate_Raw_Multi_Delay_Touch, (A0) ; Offset_0x042FA6
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D968:
		lea		Hang_Mobile_Setup_Data_5(PC), A1	   ; Offset_0x03DBC8
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$08, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$34, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03D990:
		lea		Hang_Mobile_Setup_Data_5(PC), A1	   ; Offset_0x03DBC8
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$0C, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$08, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03D9B8:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		move.w	Obj_X(A1), D0					 ; $0010
		move.b	Obj_Control_Var_12(A0), D1				 ; $0042
		ext.w	D1
		add.w	D0, D1
		move.w	Obj_X(A2), D2					 ; $0010
		sub.w	D2, D1
		moveq	#$10, D3
		moveq	#$00, D4
		move.b	Obj_Subtype(A0), D4				 ; $002C
		bsr.w	Offset_0x03DA0E
		move.w	Obj_Y(A1), D0					 ; $0014
		move.b	Obj_Control_Var_13(A0), D1				 ; $0043
		ext.w	D1
		add.w	D0, D1
		move.w	Obj_Y(A2), D2					 ; $0014
		sub.w	D2, D1
		moveq	#$14, D3
		bsr.w	Offset_0x03DA0E
		tst.b	Obj_Control_Var_0C(A2)					 ; $003C
		beq.s	Offset_0x03DA04
		bmi.s	Offset_0x03DA04
		move.w	Offset_0x03DA06(PC, D4), Obj_Priority(A0)		 ; $0008
Offset_0x03DA04:
		rts
;-------------------------------------------------------------------------------
Offset_0x03DA06:
		dc.w	$0200, $0180, $0100, $0080
;-------------------------------------------------------------------------------
Offset_0x03DA0E:
		move.w	Offset_0x03DA16(PC, D4), D5
		jmp		Offset_0x03DA16(PC, D5)
;-------------------------------------------------------------------------------
Offset_0x03DA16:
		dc.w	Offset_0x03DA1E-Offset_0x03DA16
		dc.w	Offset_0x03DA24-Offset_0x03DA16
		dc.w	Offset_0x03DA2A-Offset_0x03DA16
		dc.w	Offset_0x03DA32-Offset_0x03DA16
;-------------------------------------------------------------------------------
Offset_0x03DA1E:
		asr.w	#$02, D1
		bra.w	Offset_0x03DA32
;-------------------------------------------------------------------------------
Offset_0x03DA24:
		asr.w	#$01, D1
		bra.w	Offset_0x03DA32
;-------------------------------------------------------------------------------
Offset_0x03DA2A:
		asr.w	#$01, D1
		move.w	D1, D0
		asr.w	#$01, D1
		add.w	D0, D1
;-------------------------------------------------------------------------------
Offset_0x03DA32:
		add.w	D1, D2
		move.w	D2, $00(A0, D3)
		rts
Offset_0x03DA3A:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03DA60(PC, D0), Obj_Timer(A0)			 ; $002E
		move.w	Offset_0x03DA72(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		add.w	D0, D0
		move.l	Offset_0x03DA84(PC, D0), Obj_Child_Data(A0)		 ; $0030
		move.l	Offset_0x03DAA8(PC, D0), A1
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		jmp		Refresh_Child_Position(PC)			   ; Offset_0x042016
;-------------------------------------------------------------------------------
Offset_0x03DA60:
		dc.w	$0050, $004D, $004A, $0047, $0044, $0041, $003E, $003B
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x03DA72:
		dc.w	$0098, $08A4, $F8A4, $00B4, $00C4, $00D4, $00E4, $00F4
		dc.w	$00F0
;-------------------------------------------------------------------------------
Offset_0x03DA84:
		dc.l	Offset_0x03DC82
		dc.l	Offset_0x03DC82
		dc.l	Offset_0x03DC82
		dc.l	Offset_0x03DC73
		dc.l	Offset_0x03DC73
		dc.l	Offset_0x03DC73
		dc.l	Offset_0x03DC73
		dc.l	Offset_0x03DC73
		dc.l	Offset_0x03DC50
;-------------------------------------------------------------------------------
Offset_0x03DAA8:
		dc.l	Hang_Mobile_Flame_Setup_Data		   ; Offset_0x03DBE6
		dc.l	Hang_Mobile_Flame_Setup_Data		   ; Offset_0x03DBE6
		dc.l	Hang_Mobile_Flame_Setup_Data		   ; Offset_0x03DBE6
		dc.l	Hang_Mobile_Explosion_Setup_Data	   ; Offset_0x03DBDA
		dc.l	Hang_Mobile_Explosion_Setup_Data	   ; Offset_0x03DBDA
		dc.l	Hang_Mobile_Explosion_Setup_Data	   ; Offset_0x03DBDA
		dc.l	Hang_Mobile_Explosion_Setup_Data	   ; Offset_0x03DBDA
		dc.l	Hang_Mobile_Explosion_Setup_Data	   ; Offset_0x03DBDA
		dc.l	Hang_Mobile_Setup_Data_6			   ; Offset_0x03DBCE
;-------------------------------------------------------------------------------
Offset_0x03DACC:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		move.w	Obj_X(A1), D0					 ; $0010
		move.w	Obj_X(A2), D1					 ; $0010
		sub.w	D0, D1
		asr.w	#$01, D1
		add.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
Offset_0x03DAE8:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x03DB0C
		bmi.s	Offset_0x03DAFE
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		rts
Offset_0x03DAFE:
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.w	#$0380, Obj_Priority(A0)				 ; $0008
		rts
Offset_0x03DB0C:
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.w	#$0380, Obj_Priority(A0)				 ; $0008
		rts
;-------------------------------------------------------------------------------
Offset_0x03DB1A:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x03DB0C
		bmi.s	Offset_0x03DAFE
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		rts
;-------------------------------------------------------------------------------
Offset_0x03DB30:
		tst.l	(A0)
		beq.s	Offset_0x03DB84
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03DB84
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x03DB86
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03DB54
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03DB54:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03DB66
		addq.w	#$08, D0
Offset_0x03DB66:
		lea		Offset_0x03DB92(PC), A1
		lea		Offset_0x03DB9A(PC, D0), A2
		jsr		Move_0x08_Bytes_A2_A1(PC)			   ; Offset_0x04325C
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03DB84
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03DB84:
		rts
Offset_0x03DB86:
		move.l	#Offset_0x03D63C, (A0)
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		rts
;-------------------------------------------------------------------------------
Offset_0x03DB92:
		dc.w	(Palette_Row_1_Offset+$06)				 ; $ED26
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$12)				 ; $ED32
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03DB9A:
		dc.w	$002A, $0026, $0020, $0644, $0888, $0AAA, $0EEE, $0AAA
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data:						   ; Offset_0x03DBAA
		dc.l	Hang_Mobile_Mappings		   ; Offset_0x110370
		dc.w	$A3E0, $0280
		dc.b	$28, $18, $00, $16
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data_2:					   ; Offset_0x03DBB6
		dc.w	$0300
		dc.b	$10, $20, $01, $A3
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data_3:					   ; Offset_0x03DBBC
		dc.w	$0280
		dc.b	$08, $08, $02, $00
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data_4:					   ; Offset_0x03DBC2
		dc.w	$0200
		dc.b	$0C, $08, $03, $00
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data_5:					   ; Offset_0x03DBC8
		dc.w	$0100
		dc.b	$14, $10, $08, $00
;-------------------------------------------------------------------------------
Hang_Mobile_Setup_Data_6:					   ; Offset_0x03DBCE
		dc.l	Hang_Mobile_Mappings		   ; Offset_0x110370
		dc.w	$83E0, $0080
		dc.b	$04, $08, $04, $8B
;-------------------------------------------------------------------------------
Hang_Mobile_Explosion_Setup_Data:					   ; Offset_0x03DBDA
		dc.l	Boss_Explosion_Mappings		   ; Offset_0x10E5C0
		dc.w	$84A9, $0080
		dc.b	$10, $10, $00, $8B
;-------------------------------------------------------------------------------
Hang_Mobile_Flame_Setup_Data:				   ; Offset_0x03DBE6
		dc.l	Hang_Mobile_Flame_Mappings			   ; Offset_0x10E62E
		dc.w	$8454, $0080
		dc.b	$10, $10, $00, $8B
;-------------------------------------------------------------------------------
Offset_0x03DBF2:
		dc.w	$0002
		dc.l	Offset_0x03D712
		dc.b	$D0, $B8
		dc.l	Offset_0x03D712
		dc.b	$30, $B8
		dc.l	Offset_0x03D8CE
		dc.b	$00, $D8
;-------------------------------------------------------------------------------
Offset_0x03DC06:
		dc.w	$0000
		dc.l	Offset_0x03D7E8
		dc.b	$00, $20
;-------------------------------------------------------------------------------
Offset_0x03DC0E:
		dc.w	$0003
		dc.l	Offset_0x03D87A
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03DC16:
		dc.w	$0008
		dc.l	Offset_0x03D944
;-------------------------------------------------------------------------------
Offset_0x03DC1C:
		dc.w	$0003
		dc.l	Offset_0x03D968
		dc.b	$EC, $08
		dc.l	Offset_0x03D968
		dc.b	$14, $08
		dc.l	Offset_0x03D968
		dc.b	$F0, $20
		dc.l	Offset_0x03D968
		dc.b	$10, $20
;-------------------------------------------------------------------------------
Offset_0x03DC36:
		dc.w	$0003
		dc.l	Offset_0x03D990
		dc.b	$F8, $F0
		dc.l	Offset_0x03D990
		dc.b	$08, $F0
		dc.l	Offset_0x03D990
		dc.b	$F8, $10
		dc.l	Offset_0x03D990
		dc.b	$08, $10
;-------------------------------------------------------------------------------
Offset_0x03DC50:
		dc.b	$04, $03, $04, $03, $05, $03, $06, $03
		dc.b	$07, $03, $04, $03, $05, $03, $06, $03
		dc.b	$07, $03, $04, $03, $05, $03, $06, $03
		dc.b	$07, $03, $04, $03, $05, $03, $06, $03
		dc.b	$07, $03, $F4
;-------------------------------------------------------------------------------
Offset_0x03DC73:
		dc.b	$00, $02, $00, $02, $01, $02, $02, $03
		dc.b	$03, $04, $04, $05, $05, $06, $F4
;-------------------------------------------------------------------------------
Offset_0x03DC82:
		dc.b	$00, $02, $00, $02, $01, $03, $02, $04
		dc.b	$03, $05, $04, $06, $F4, $00
;-------------------------------------------------------------------------------
Pal_Hang_Mobile:							   ; Offset_0x03DC90
		dc.w	$0AA0, $0EEE, $006E, $002A, $0026, $00EE, $0088, $008C
		dc.w	$0048, $0020, $0ECC, $0CAA, $0A88, $0866, $0644, $0044
;===============================================================================
; Objeto 0xB4 - Chefe na Flying Battery
; <<<-
;===============================================================================