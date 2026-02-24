;===============================================================================
; Objeto 0xB2 - Chefe na Icecap
; ->>>
;===============================================================================
; Offset_0x03E48C:
		lea		Offset_0x03E4E6(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		move.l	#Offset_0x03E4EE, (A0)
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.b	#$19, Obj_Angle(A0)				 ; $0026
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	#$05F8, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$4390, Obj_Inertia(A0)					 ; $001C
		move.w	#$4390, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.l	#Offset_0x03E4F2, Obj_Child(A0)			 ; $0034
		moveq	#$70, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Freezer_Mobile_Palette(PC), A1		   ; Offset_0x03EBE2
		jmp		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03E4E6:
		dc.w	$0520, $06C0, $4280, $4390
;-------------------------------------------------------------------------------
Offset_0x03E4EE:
		jmp		Update_Sonic_Level_Limits_X_Y_Play_Music(PC) ; Offset_0x0433DE
;-------------------------------------------------------------------------------
Offset_0x03E4F2:
		move.l	#Offset_0x03E4FA, (A0)
Offset_0x03E4F8:
		rts
;-------------------------------------------------------------------------------
Offset_0x03E4FA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03E510(PC, D0), D1
		jsr		Offset_0x03E510(PC, D1)
		bsr.w	Offset_0x03EA9C
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03E510:
		dc.w	Offset_0x03E518-Offset_0x03E510
		dc.w	Offset_0x03E554-Offset_0x03E510
		dc.w	Offset_0x03E57E-Offset_0x03E510
		dc.w	Offset_0x03E610-Offset_0x03E510
;-------------------------------------------------------------------------------
Offset_0x03E518:
		lea		Freezer_Mobile_Setup_Data(PC), A1	   ; Offset_0x03EB38
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00CF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E55E, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x03EB68).l, A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03E54C
		move.b	#$09, Obj_Subtype(A1)					 ; $002C
Offset_0x03E54C:
		lea		Offset_0x03EB70(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03E554:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E55E:
		move.w	#$7FFF, Obj_Height_3(A0)				 ; $0044
		bsr.w	Offset_0x03E960
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E5A2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E57E:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		subq.w	#$01, Obj_Height_3(A0)					 ; $0044
		bpl.s	Offset_0x03E598
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
		move.w	#$017F, Obj_Height_3(A0)				 ; $0044
Offset_0x03E598:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E5A2:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E5B8, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E5B8:
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.w	#$FF80, Obj_Speed_X(A0)					 ; $0018
		move.w	#$017F, Obj_Height_3(A0)				 ; $0044
		move.l	#Offset_0x03E5D4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E5D4:
		move.l	#Offset_0x03E5F2, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x03E97A
		cmpi.w	#$0002, Obj_Angle(A0)					 ; $0026
		bne.w	Offset_0x03E4F8
		lea		Offset_0x03EB84(PC), A2
		jmp		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03E5F2:
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E5D4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
; Offset_0x03E608:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03E610:
		subq.w	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bmi.s	Offset_0x03E620
		addi.l	#$00008000, Obj_Y(A0)					 ; $0014
		rts
Offset_0x03E620:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03E628:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E652, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x03EB9E(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03E652:
		move.l	#Offset_0x03E678, (A0)
		st		(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		move.w	#$44C0, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03E678:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x03E68C
		move.w	(Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE78, $FFFFEE14
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.w	Offset_0x03E4F8
Offset_0x03E68C:
		clr.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		jsr		Restore_PlayerControl(PC)			  ; Offset_0x0432EE
		move.w	(Target_Camera_Max_Y).w, (Level_Limits_Max_Y).w ; $FFFFFA98, $FFFFEE12
		move.w	#$47C0, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jsr		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
		jmp		(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03E6B2:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03E6CA(PC, D0), D1
		jsr		Offset_0x03E6CA(PC, D1)
		moveq	#$0C, D0
		jmp		Child_Display_Or_Flicker_Move(PC)	   ; Offset_0x0424E2
;-------------------------------------------------------------------------------
Offset_0x03E6CA:
		dc.w	Offset_0x03E6D0-Offset_0x03E6CA
		dc.w	Offset_0x03E6D8-Offset_0x03E6CA
		dc.w	Offset_0x03E700-Offset_0x03E6CA
;-------------------------------------------------------------------------------
Offset_0x03E6D0:
		lea		Freezer_Mobile_Setup_Data_2(PC), A1	   ; Offset_0x03EB44
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x03E6D8:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Control_Var_0B(A1)					 ; $003B
		bne.s	Offset_0x03E6E4
		rts
Offset_0x03E6E4:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
		move.w	#$000E, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E704, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E700:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E704:
		move.w	#$0017, Obj_Timer(A0)					 ; $002E
		move.w	#$0006, Obj_Angle(A0)					 ; $0026
		lea		Offset_0x03EB90(PC), A2
		jmp		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03E718:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03E73E(PC, D0), D1
		jsr		Offset_0x03E73E(PC, D1)
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Control_Var_0B(A1)					 ; $003B
		bne.w	Run_Flicker_Move			   ; Offset_0x0424F4
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03E73E:
		dc.w	Offset_0x03E748-Offset_0x03E73E
		dc.w	Offset_0x03E750-Offset_0x03E73E
		dc.w	Offset_0x03E774-Offset_0x03E73E
		dc.w	Offset_0x03E784-Offset_0x03E73E
		dc.w	Offset_0x03E7A8-Offset_0x03E73E
;-------------------------------------------------------------------------------
Offset_0x03E748:
		lea		Freezer_Mobile_Setup_Data_3(PC), A1	   ; Offset_0x03EB4A
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x03E750:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03E75E
		rts
Offset_0x03E75E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0024, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E77C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E774:
		addq.b	#$01, Obj_Control_Var_13(A0)			 ; $0043
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E77C:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03E784:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03E792
		rts
Offset_0x03E792:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0024, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E7B0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E7A8:
		subq.b	#$01, Obj_Control_Var_13(A0)			 ; $0043
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E7B0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03E7B8:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03E7F6(PC, D0), D1
		jsr		Offset_0x03E7F6(PC, D1)
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$23, D1
		moveq	#$04, D2
		moveq	#$0A, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		moveq	#$00, D0
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Control_Var_0B(A1)					 ; $003B
		bne.s	Offset_0x03E7EE
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03E7EE:
		jsr		Displace_Player_Offset(PC)			   ; Offset_0x04315A
		jmp		Run_Flicker_Move(PC)		   ; Offset_0x0424F4
;-------------------------------------------------------------------------------
Offset_0x03E7F6:
		dc.w	Offset_0x03E800-Offset_0x03E7F6
		dc.w	Offset_0x03E810-Offset_0x03E7F6
		dc.w	Offset_0x03E774-Offset_0x03E7F6
		dc.w	Offset_0x03E834-Offset_0x03E7F6
		dc.w	Offset_0x03E7A8-Offset_0x03E7F6
;-------------------------------------------------------------------------------
Offset_0x03E800:
		lea		Freezer_Mobile_Setup_Data_4(PC), A1	   ; Offset_0x03EB50
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		lea		Offset_0x03EB96(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03E810:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03E81E
		rts
Offset_0x03E81E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0042, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E77C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E834:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03E860
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03E85E
		move.w	Obj_Angle(A1), D0				 ; $0026
		cmpi.w	#$0002, D0
		beq.s	Offset_0x03E85E
		move.w	D0, Obj_Angle(A0)				 ; $0026
		lea		Offset_0x03EB8A(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
Offset_0x03E85E:
		rts
Offset_0x03E860:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0042, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E7B0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E876:
		lea		Freezer_Mobile_Setup_Data_5(PC), A1	   ; Offset_0x03EB56
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.l	#Offset_0x03E890, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03E9A8
;-------------------------------------------------------------------------------
Offset_0x03E890:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.l	#Offset_0x03E8B2, (A0)
		cmpi.w	#$0006, Obj_Angle(A1)					 ; $0026
		bne.s	Offset_0x03E8A8
		move.l	#Offset_0x03E8E0, (A0)
Offset_0x03E8A8:
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E8B2:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		cmpi.b	#$04, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x03E8D4
		cmpi.b	#$08, Obj_Ani_Frame(A0)					 ; $0023
		bhi.s	Offset_0x03E8D4
		lea		Offset_0x03E8D8(PC), A1
		jsr		(Offset_0x047030).l
Offset_0x03E8D4:
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x03E8D8:
		dc.w	$FFE8, $0030, $FFE8, $0030
;-------------------------------------------------------------------------------
Offset_0x03E8E0:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		cmpi.b	#$04, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x03E902
		cmpi.b	#$08, Obj_Ani_Frame(A0)					 ; $0023
		bhi.s	Offset_0x03E902
		lea		Offset_0x03E906(PC), A1
		jsr		(Offset_0x047030).l
Offset_0x03E902:
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x03E906:
		dc.w	$FFF0, $0020, $FFF0, $0020
;-------------------------------------------------------------------------------
Offset_0x03E90E:
		move.l	#Offset_0x03E91C, (A0)
		move.b	#$9B, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x03E91C:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03E932
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x03E932:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03E938:
		lea		Freezer_Mobile_Setup_Data_6(PC), A1	   ; Offset_0x03EB62
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$16, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$34, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
Offset_0x03E960:
		move.w	#$00C0, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0010, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
Offset_0x03E97A:
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		tst.b	Obj_Control_Var_0B(A0)					 ; $003B
		bne.s	Offset_0x03E9A0
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		andi.w	#$000F, D0
		lea		Offset_0x03EC02(PC), A1
		move.b	(A1, D0), Obj_Flip_Angle(A0)			 ; $0027
		addq.b	#$01, D0
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		rts
Offset_0x03E9A0:
		move.w	#$0002, Obj_Angle(A0)					 ; $0026
		rts
Offset_0x03E9A8:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		lea		Offset_0x03EA34(PC), A2
		move.w	(A2, D0), D2
		adda.w	D2, A2
		move.w	(A2, D1), Obj_Control_Var_12(A0)		 ; $0042
		lea		Offset_0x03EA6C(PC), A2
		move.w	(A2, D0), D2
		adda.w	D2, A2
		move.b	(A2, D1), D2
		or.b	D2, Obj_Flags(A0)				 ; $0004
		lea		Offset_0x03EA02(PC), A2
		move.w	(A2, D0), D2
		adda.w	D2, A2
		move.w	(A2, D1), Obj_Timer(A0)				 ; $002E
		cmpi.b	#$06, D0
		beq.s	Offset_0x03E9F8
		add.w	D1, D1
		move.l	Offset_0x03EA18(PC, D1), Obj_Child_Data(A0)		 ; $0030
		rts
Offset_0x03E9F8:
		move.l	#Offset_0x03EBCE, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03EA02:
		dc.w	$0008, $000A, $0008, $000E, $0011, $000E, $000B, $0008
		dc.w	$0005, $0002, $FFFF
;-------------------------------------------------------------------------------
Offset_0x03EA18:
		dc.l	Offset_0x03EBC1
		dc.l	Offset_0x03EBC1
		dc.l	Offset_0x03EBC1
		dc.l	Offset_0x03EBC1
		dc.l	Offset_0x03EBB2
		dc.l	Offset_0x03EBB2
		dc.l	Offset_0x03EBB2
;-------------------------------------------------------------------------------
Offset_0x03EA34:
		dc.w	Offset_0x03EA3C-Offset_0x03EA34
		dc.w	Offset_0x03EA4A-Offset_0x03EA34
		dc.w	Offset_0x03EA56-Offset_0x03EA34
		dc.w	Offset_0x03EA64-Offset_0x03EA34
Offset_0x03EA3C:
		dc.b	$B0, $14, $C0, $14, $B8, $04, $C0, $04
		dc.b	$CC, $0C, $DC, $08, $E4, $04
Offset_0x03EA4A:
		dc.b	$08, $40, $00, $3C, $F0, $40, $F8, $3C
		dc.b	$FC, $34, $FC, $28
Offset_0x03EA56:
		dc.b	$50, $14, $40, $14, $48, $04, $40, $04
		dc.b	$34, $0C, $24, $08, $1C, $04
Offset_0x03EA64:
		dc.b	$18, $FC, $14, $00, $10, $F8, $08, $FC
;-------------------------------------------------------------------------------
Offset_0x03EA6C:
		dc.w	Offset_0x03EA74-Offset_0x03EA6C
		dc.w	Offset_0x03EA82-Offset_0x03EA6C
		dc.w	Offset_0x03EA8E-Offset_0x03EA6C
		dc.w	Offset_0x03EA7A-Offset_0x03EA6C
Offset_0x03EA74:
		dc.w	$0200, $0200, $0000
Offset_0x03EA7A:
		dc.w	$0000, $0000, $0000, $0000
Offset_0x03EA82:
		dc.w	$0100, $0100, $0000, $0000, $0000, $0000
Offset_0x03EA8E:
		dc.w	$0300, $0300, $0100, $0100, $0100, $0100, $0100
;-------------------------------------------------------------------------------
Offset_0x03EA9C:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03EB04
		move.b	Obj_Boss_Hit(A0), D0					 ; $0029
		beq.s	Offset_0x03EB06
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03EAD2
		cmpi.b	#$02, D0
		bne.s	Offset_0x03EAC4
		st		Obj_Control_Var_0B(A0)					 ; $003B
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$007F, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x03EAC4:
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03EAD2:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03EAE6
		addi.w	#$0004, D0
Offset_0x03EAE6:
		bsr.w	Offset_0x03EB20
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03EB04
		bclr	#$06, Obj_Status(A0)					 ; $002A
		cmpi.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x03EB04
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03EB04:
		rts
Offset_0x03EB06:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E628, Obj_Child(A0)			 ; $0034
		rts
Offset_0x03EB20:
		lea		Offset_0x03EB2C(PC), A1
		lea		Offset_0x03EB30(PC, D0), A2
		jmp		Move_0x04_Bytes_A2_A1(PC)			   ; Offset_0x043264
;-------------------------------------------------------------------------------
Offset_0x03EB2C:
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03EB30:
		dc.w	$0020, $0644, $0EEE, $0AAA
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data:					   ; Offset_0x03EB38
		dc.l	Freezer_Mobile_Mappings		   ; Offset_0x10FC2C
		dc.w	$A2A6, $0280
		dc.b	$24, $24, $00, $0F
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data_2:				   ; Offset_0x03EB44
		dc.w	$0200
		dc.b	$14, $08, $03, $00
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data_3:				   ; Offset_0x03EB4A
		dc.w	$0280
		dc.b	$08, $0C, $01, $00
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data_4:				   ; Offset_0x03EB50
		dc.w	$0280
		dc.b	$18, $2C, $02, $00
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data_5:				   ; Offset_0x03EB56
		dc.l	Freezer_Mobile_Mappings		   ; Offset_0x10FC2C
		dc.w	$A2A6, $0080
		dc.b	$10, $10, $05, $00
;-------------------------------------------------------------------------------
Freezer_Mobile_Setup_Data_6:				   ; Offset_0x03EB62
		dc.w	$0180
		dc.b	$14, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x03EB68:
		dc.w	$0000
		dc.l	CNz_Iz_Robotnik_Ship		   ; Offset_0x0363EC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03EB70:
		dc.w	$0002
		dc.l	Offset_0x03E6B2
		dc.b	$18, $07
		dc.l	Offset_0x03E718
		dc.b	$00, $0B
		dc.l	Offset_0x03E7B8
		dc.b	$00, $2D
;-------------------------------------------------------------------------------
Offset_0x03EB84:
		dc.w	$0005
		dc.l	Offset_0x03E876
;-------------------------------------------------------------------------------
Offset_0x03EB8A:
		dc.w	$0006
		dc.l	Offset_0x03E876
;-------------------------------------------------------------------------------
Offset_0x03EB90:
		dc.w	$0003
		dc.l	Offset_0x03E876
;-------------------------------------------------------------------------------
Offset_0x03EB96:
		dc.w	$0000
		dc.l	Offset_0x03E90E
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x03EB9E:
		dc.w	$0002
		dc.l	Offset_0x03E938
		dc.b	$EC, $04
		dc.l	Offset_0x03E938
		dc.b	$0C, $04
		dc.l	Offset_0x03E938
		dc.b	$00, $1C
;-------------------------------------------------------------------------------
Offset_0x03EBB2:
		dc.b	$05, $01, $05, $01, $06, $01, $07, $02
		dc.b	$08, $03, $09, $04, $0A, $05, $F4
;-------------------------------------------------------------------------------
Offset_0x03EBC1:
		dc.b	$0B, $02, $0B, $02, $0C, $03, $0D, $04
		dc.b	$0E, $05, $0F, $06, $F4
;-------------------------------------------------------------------------------
Offset_0x03EBCE:
		dc.b	$10, $01, $10, $01, $11, $01, $12, $02
		dc.b	$13, $02, $14, $02, $15, $02, $F4
;-------------------------------------------------------------------------------
; Offset_0x03EBDD:
		dc.b	$05, $00, $01, $FC, $00
;-------------------------------------------------------------------------------
Freezer_Mobile_Palette:						   ; Offset_0x03EBE2
		dc.w	$0000, $0EEE, $0ECC, $0000, $0000, $00EE, $0088, $008C
		dc.w	$0048, $0000, $0020, $0CAA, $0A88, $0866, $0644, $0044
;-------------------------------------------------------------------------------
Offset_0x03EC02:
		dc.b	$00, $02, $04, $00, $02, $04, $00, $02
		dc.b	$04, $00, $02, $04, $00, $02, $04, $00
;===============================================================================
; Objeto 0xB2 - Chefe na Icecap
; <<<-
;===============================================================================