;===============================================================================
; Objeto 0x8E - Mini chefe da Carnival Night 1
; ->>>
;===============================================================================
; Offset_0x03B01A:
		move.w	#$31E0, D0
		cmp.w	(Camera_X).w, D0					 ; $FFFFEE78
		bls.s	Offset_0x03B026
		rts
Offset_0x03B026:
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	#$01A0, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		addi.w	#$0080, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		move.w	#$02A0, (Sonic_Level_Limits_Max_Y).w		 ; $FFFFEE1A
		move.w	#$02A0, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03B07E, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#$5D, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Bowling_Spin_Palette(PC), A1		   ; Offset_0x03B980
		jmp		(Pal_Load_Line_1).l			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03B07E:
		move.l	#Offset_0x03B08E, (A0)
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x03B08C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03B08E:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03B0B2(PC, D0), D1
		jsr		Offset_0x03B0B2(PC, D1)
		bsr.w	Offset_0x03B788
		jsr		(Run_Palette_Rotation_Script)		   ; Offset_0x043196
		bsr.w	Offset_0x03B662
		bsr.w	Offset_0x03B6BA
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03B0B2:
		dc.w	Offset_0x03B0C2-Offset_0x03B0B2
		dc.w	Offset_0x03B0F8-Offset_0x03B0B2
		dc.w	Offset_0x03B124-Offset_0x03B0B2
		dc.w	Offset_0x03B124-Offset_0x03B0B2
		dc.w	Offset_0x03B178-Offset_0x03B0B2
		dc.w	Offset_0x03B19E-Offset_0x03B0B2
		dc.w	Offset_0x03B1C4-Offset_0x03B0B2
		dc.w	Offset_0x03B1C8-Offset_0x03B0B2
;-------------------------------------------------------------------------------
Offset_0x03B0C2:
		lea		Bowling_Spin_Setup_Data(PC), A1		   ; Offset_0x03B8A8
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$04, Obj_Width_3(A0)					 ; $0045
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$011F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03B102, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03B8D2(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03B0F8:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03B102:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0090, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03B132, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03B648
;-------------------------------------------------------------------------------
Offset_0x03B124:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03B132:
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
Offset_0x03B13E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03B16C, Obj_Child(A0)			 ; $0034
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		lea		(Bowling_Spin_Palette_Rotation_Script).l, A1 ; Offset_0x10FD6E
		lea		(Palette_Rotation_Data).w, A2		 ; $FFFFFADE
		move.l	(A1)+, (A2)+
		move.l	(A1)+, (A2)+
		clr.w	(A2)
		move.l	#Offset_0x03B776, (Palette_Rotation_Custom).w ; $FFFFFADA
		rts
;-------------------------------------------------------------------------------
Offset_0x03B16C:
		neg.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$013F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03B178:
		jmp		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x03B17C:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03B16C, Obj_Child(A0)			 ; $0034
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		move.b	#$7F, Obj_Control_Var_0B(A0)			 ; $003B
		lea		Offset_0x03B8F6(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03B19E:
		subq.b	#$01, Obj_Control_Var_0B(A0)			 ; $003B
		beq.s	Offset_0x03B1A6
		rts
Offset_0x03B1A6:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x03B92F, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03B13E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03B1C4:
		jmp		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x03B1C8:
		addq.w	#$01, Obj_Y(A0)					 ; $0014
		subq.b	#$01, Obj_Control_Var_13(A0)			 ; $0043
		bmi.s	Offset_0x03B1D4
		rts
Offset_0x03B1D4:
		move.b	Obj_Control_Var_12(A0), Obj_Routine(A0)	  ; $0042, $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03B1DC:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		st		(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03B20E, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		lea		Offset_0x03B91A(PC), A2
		jmp		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
; Offset_0x03B20A:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03B20E:
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		jsr		After_Boss_Clean_Up(PC)		   ; Offset_0x041ACA
		jmp		Go_Delete_Object_A0_2(PC)			   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03B220:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03B232(PC, D0), D1
		jsr		Offset_0x03B232(PC, D1)
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03B232:
		dc.w	Offset_0x03B23A-Offset_0x03B232
		dc.w	Offset_0x03B250-Offset_0x03B232
		dc.w	Offset_0x03B278-Offset_0x03B232
		dc.w	Offset_0x03B29C-Offset_0x03B232
;-------------------------------------------------------------------------------
Offset_0x03B23A:
		lea		Bowling_Spin_Setup_Data_2(PC), A1	   ; Offset_0x03B8B4
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.b	#$10, Obj_Width_2(A0)					 ; $001F
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		rts
;-------------------------------------------------------------------------------
Offset_0x03B250:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03B260
		jmp		Refresh_Child_Position(PC)			   ; Offset_0x042016
Offset_0x03B260:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03B93E, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03B280, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03B278:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
;-------------------------------------------------------------------------------
Offset_0x03B280:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03B944, Obj_Child_Data(A0)			 ; $0030
		move.w	#$0200, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03B29C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x03B41A
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		moveq	#$13, D1
		moveq	#$0C, D2
		moveq	#$08, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x03B2FA
		moveq	#$10, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		tst.w	D1
		bmi.w	Offset_0x03B396
		move.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$3380, D0
		bcc.w	Offset_0x03B3D6
		move.w	Obj_Y(A0), D1					 ; $0014
		bsr.w	Offset_0x03B824
		bne.w	Offset_0x03B3D6
		bra.w	Offset_0x03B324
Offset_0x03B2FA:
		moveq	#-$10, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
		tst.w	D1
		bmi.w	Offset_0x03B396
		move.w	Obj_X(A0), D0					 ; $0010
		subi.w	#$0010, D0
		cmpi.w	#$3200, D0
		bcs.w	Offset_0x03B3D6
		move.w	Obj_Y(A0), D1					 ; $0014
		bsr.w	Offset_0x03B824
		bne.w	Offset_0x03B3D6
Offset_0x03B324:
		bsr.w	Offset_0x03B7AA
		bne.w	Offset_0x03B414
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x03B368
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bmi.w	Offset_0x03B3DC
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Y(A0), D1					 ; $0014
		addq.w	#$08, D1
		move.w	(Camera_Y).w, D2					 ; $FFFFEE7C
		addi.w	#$00E0, D2
		cmp.w	D2, D1
		bcc.w	Offset_0x03B414
		cmpi.w	#$0380, D1
		bhi.w	Offset_0x03B414
		bsr.w	Offset_0x03B824
		bne.w	Offset_0x03B414
		rts
Offset_0x03B368:
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bmi.s	Offset_0x03B3DC
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Y(A0), D1					 ; $0014
		subq.w	#$08, D1
		cmp.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		bls.w	Offset_0x03B414
		cmpi.w	#$0240, D1
		bls.w	Offset_0x03B414
		bsr.w	Offset_0x03B824
		bne.w	Offset_0x03B414
		rts
Offset_0x03B396:
		lea		Offset_0x03B90A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03B3AC
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x03B3AC
		bset	#$00, Obj_Flags(A1)				 ; $0004
Offset_0x03B3AC:
		moveq	#$10, D0
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x03B3B6
		neg.w	D0
Offset_0x03B3B6:
		add.w	Obj_X(A0), D0					 ; $0010
		cmpi.w	#$3200, D0
		bls.s	Offset_0x03B3D4
		cmpi.w	#$3380, D0
		bcc.s	Offset_0x03B3D4
		move.w	D0, (Background_Events).w			 ; $FFFFEED2
		move.w	Obj_Y(A0), (Background_Events+$02).w  ; $0014, $FFFFEED4
		bsr.w	Offset_0x03B430
Offset_0x03B3D4:
		rts
Offset_0x03B3D6:
		neg.w	Obj_Speed_X(A0)					 ; $0018
		rts
Offset_0x03B3DC:
		move.w	Obj_X(A0), D0					 ; $0010
		moveq	#$08, D1
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x03B3EA
		neg.w	D1
Offset_0x03B3EA:
		add.w	Obj_Y(A0), D1					 ; $0014
		cmpi.w	#$3200, D0
		bls.s	Offset_0x03B3D4
		cmpi.w	#$3380, D0
		bcc.s	Offset_0x03B3D4
		cmpi.w	#$0300, D1
		bcs.s	Offset_0x03B3D4
		cmpi.w	#$3380, D1
		bcc.s	Offset_0x03B3D4
		move.w	D0, (Background_Events).w			 ; $FFFFEED2
		move.w	D1, (Background_Events+$02).w		 ; $FFFFEED4
		bsr.w	Offset_0x03B430
		rts
Offset_0x03B414:
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x03B41A:
		lea		Offset_0x03B912(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.b	#$06, Obj_Subtype(A1)					 ; $002C
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
Offset_0x03B430:
		lea		Offset_0x03B912(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03B460
		move.b	#$06, Obj_Subtype(A1)					 ; $002C
		move.w	(Background_Events).w, D0			 ; $FFFFEED2
		andi.w	#$FFE0, D0
		addi.w	#$0010, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	(Background_Events+$02).w, D0		 ; $FFFFEED4
		andi.w	#$FFE0, D0
		addi.w	#$0010, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x03B460:
		rts
;-------------------------------------------------------------------------------
Offset_0x03B462:
		move.l	#Offset_0x03B47C, (A0)
		move.b	#$1A, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$70, Obj_Boss_Hit(A0)					 ; $0029
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03B47C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03B4F0
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03B4E2
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03B4D6
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03B4C2
		move.b	#$10, Obj_Control_Var_0A(A0)			 ; $003A
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03B4C2
		move.b	Obj_Col_Flags(A1), Obj_Ani_Time_2(A1)	  ; $0028, $0025
		clr.b	Obj_Col_Flags(A1)				 ; $0028
		subq.b	#$01, Obj_Boss_Hit(A1)					 ; $0029
Offset_0x03B4C2:
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bpl.w	Offset_0x03B08C
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03B4D6:
		move.b	#$70, Obj_Boss_Hit(A0)					 ; $0029
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x03B4E2:
		move.l	#Offset_0x03B4F6, (A0)
		move.b	#$A9, Obj_Col_Flags(A0)					 ; $0028
		rts
Offset_0x03B4F0:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03B4F6:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03B4F0
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		beq.w	Offset_0x03B462
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
;-------------------------------------------------------------------------------
Offset_0x03B516:
		move.l	#Offset_0x03B524, (A0)
		move.b	#$AA, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x03B524:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
;-------------------------------------------------------------------------------
Offset_0x03B52E:
		lea		Bowling_Spin_Setup_Data_3(PC), A1	   ; Offset_0x03B8BA
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.l	#Offset_0x03B562, Obj_Child(A0)			 ; $0034
		move.l	#Offset_0x03B949, Obj_Child_Data(A0)			 ; $0030
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03B560
		move.l	#Offset_0x03B952, Obj_Child_Data(A0)			 ; $0030
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
Offset_0x03B560:
		rts
;-------------------------------------------------------------------------------
Offset_0x03B562:
		move.l	#Offset_0x03B578, (A0)
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03B578:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x03B588:
		lea		Bowling_Spin_Setup_Data_3(PC), A1	   ; Offset_0x03B8BA
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03B5B2, (A0)
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		move.l	Offset_0x03B5A6(PC, D0), Obj_Child_Data(A0)		 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03B5A6:
		dc.l	Offset_0x03B95B
		dc.l	Offset_0x03B964
		dc.l	Offset_0x03B96F
;-------------------------------------------------------------------------------
Offset_0x03B5B2:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		beq.w	Offset_0x03B4F0
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x03B5CC:
		lea		Bowling_Spin_Setup_Data_4(PC), A1	   ; Offset_0x03B8C0
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Animate_Raw_Multi_Delay_Touch, (A0)   ; Offset_0x042FAA
		move.w	#$3208, Obj_X(A0)				 ; $0010
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03B5EE
		move.w	#$3378, Obj_X(A0)				 ; $0010
Offset_0x03B5EE:
		move.l	#Offset_0x03B978, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03B600:
		lea		Bowling_Spin_Setup_Data_5(PC), A1	   ; Offset_0x03B8C6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03B62C(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		lsr.w	#$01, D0
		move.b	Offset_0x03B63E(PC, D0), Obj_Map_Id(A0)			 ; $0022
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03B62C:
		dc.w	$F000, $1000, $0014, $001C, $0024, $002C, $0034, $003C
		dc.w	$0048
;-------------------------------------------------------------------------------
Offset_0x03B63E:
		dc.b	$12, $13, $14, $14, $14, $14, $14, $14
		dc.b	$15, $00
;-------------------------------------------------------------------------------
Offset_0x03B648:
		move.w	#$0060, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0008, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03B662:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03B6B8
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03B6A6
		addq.b	#$01, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$10, Obj_Control_Var_0A(A0)			 ; $003A
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03B6A6
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03B920, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03B17C, Obj_Child(A0)			 ; $0034
		lea		(Bowling_Spin_Open_Palette_Rotation_Script).l, A1 ; Offset_0x10FE18
		lea		(Palette_Rotation_Data).w, A2		 ; $FFFFFADE
		move.l	(A1)+, (A2)+
		move.l	(A1)+, (A2)+
Offset_0x03B6A6:
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bpl.s	Offset_0x03B6B8
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03B6B8:
		rts
;-------------------------------------------------------------------------------
Offset_0x03B6BA:
		tst.b	Obj_Height_3(A0)				 ; $0044
		beq.s	Offset_0x03B702
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03B6E0
		subq.b	#$01, Obj_Width_3(A0)					 ; $0045
		beq.s	Offset_0x03B704
		bset	#$06, Obj_Status(A0)					 ; $002A
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x03B6E0:
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03B6EE
		addi.w	#$000A, D0
Offset_0x03B6EE:
		bsr.w	Offset_0x03B73A
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03B702
		bclr	#$06, Obj_Status(A0)					 ; $002A
		clr.b	Obj_Height_3(A0)				 ; $0044
Offset_0x03B702:
		rts
Offset_0x03B704:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03B1DC, Obj_Child(A0)			 ; $0034
		move.w	#$0020, (Palette_Row_1_Offset+$14).w		 ; $FFFFED34
		lea		Offset_0x03B912(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.w	#$1000, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		jmp		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
Offset_0x03B73A:
		lea		Offset_0x03B758(PC), A1
		lea		Offset_0x03B762(PC, D0), A2
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		rts
;-------------------------------------------------------------------------------
Offset_0x03B758:
		dc.w	(Palette_Row_1_Offset+$04)				 ; $ED24
		dc.w	(Palette_Row_1_Offset+$06)				 ; $ED26
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$0E)				 ; $ED2E
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03B762:
		dc.w	$06E0, $0280, $0040, $0028, $0642, $0888, $0AAA, $0CCC
		dc.w	$0888, $0AAA
;-------------------------------------------------------------------------------
Offset_0x03B776:
		lea		(Bowling_Spin_Sparks_Palette_Rotation_Script), A2 ; Offset_0x10FDC6
		move.l	(A2)+, (A1)+
		move.l	(A2)+, (A1)+
		lea		Offset_0x03B8E0(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03B788:
		move.w	(Background_Events+$04).w, D0		 ; $FFFFEED6
		cmp.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x03B7A8
		move.w	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.b	Obj_Routine(A0), Obj_Control_Var_12(A0)	  ; $0005, $0042
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.b	#$1F, Obj_Control_Var_13(A0)			 ; $0043
Offset_0x03B7A8:
		rts
;-------------------------------------------------------------------------------
Offset_0x03B7AA:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x03B7B8
		bne.s	Offset_0x03B81E
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
Offset_0x03B7B8:
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bpl.s	Offset_0x03B820
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x03B820
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$000C, D1
		move.w	Obj_X(A1), D2					 ; $0010
		subi.w	#$0010, D2
		cmp.w	D2, D0
		bcs.s	Offset_0x03B820
		addi.w	#$0020, D2
		cmp.w	D2, D0
		bcc.s	Offset_0x03B820
		move.w	Obj_Y(A1), D2					 ; $0014
		subi.w	#$0010, D2
		cmp.w	D2, D1
		bcs.s	Offset_0x03B820
		addi.w	#$0020, D2
		cmp.w	D2, D1
		bcc.s	Offset_0x03B820
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bmi.s	Offset_0x03B80A
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x03B814
		bra.w	Offset_0x03B810
Offset_0x03B80A:
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x03B814
Offset_0x03B810:
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03B814:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x03B820
		moveq	#$01, D0
Offset_0x03B81E:
		rts
Offset_0x03B820:
		moveq	#$00, D0
		rts
;-------------------------------------------------------------------------------
Offset_0x03B824:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		lea		Offset_0x03B890(PC), A2
		move.w	Obj_X(A1), D2					 ; $0010
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcs.s	Offset_0x03B84C
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcc.s	Offset_0x03B84C
		move.w	Obj_Y(A1), D2					 ; $0014
		add.w	(A2)+, D2
		cmp.w	D2, D1
		bcs.s	Offset_0x03B84C
		add.w	(A2)+, D2
		cmp.w	D2, D1
		bcs.s	Offset_0x03B880
Offset_0x03B84C:
		lea		Offset_0x03B898(PC), A2
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03B85C
		lea		Offset_0x03B8A0(PC), A2
Offset_0x03B85C:
		move.w	Obj_X(A1), D2					 ; $0010
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcs.s	Offset_0x03B87C
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcc.s	Offset_0x03B87C
		move.w	Obj_Y(A1), D2					 ; $0014
		add.w	(A2)+, D2
		cmp.w	D2, D1
		bcs.s	Offset_0x03B87C
		add.w	(A2)+, D2
		cmp.w	D2, D1
		bcs.s	Offset_0x03B880
Offset_0x03B87C:
		moveq	#$00, D2
		rts
Offset_0x03B880:
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03B88C
		st		Obj_Height_3(A1)				 ; $0044
Offset_0x03B88C:
		moveq	#$01, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x03B890:
		dc.w	$FFE8, $0030, $FFF0, $0020
;-------------------------------------------------------------------------------
Offset_0x03B898:
		dc.w	$FFF4, $0018, $0010, $0018
;-------------------------------------------------------------------------------
Offset_0x03B8A0:
		dc.w	$FFF4, $0018, $0010, $0038
;-------------------------------------------------------------------------------
Bowling_Spin_Setup_Data:					   ; Offset_0x03B8A8
		dc.l	Bowling_Spin_Mappings		   ; Offset_0x10FE4C
		dc.w	$A507, $0280
		dc.b	$18, $30, $00, $0C
;-------------------------------------------------------------------------------
Bowling_Spin_Setup_Data_2:					   ; Offset_0x03B8B4
		dc.w	$0200
		dc.b	$18, $08, $07, $AA
;-------------------------------------------------------------------------------
Bowling_Spin_Setup_Data_3:					   ; Offset_0x03B8BA
		dc.w	$0200
		dc.b	$0C, $18, $0A, $92
;-------------------------------------------------------------------------------
Bowling_Spin_Setup_Data_4:					   ; Offset_0x03B8C0
		dc.w	$0100
		dc.b	$08, $08, $0C, $00
;-------------------------------------------------------------------------------
Bowling_Spin_Setup_Data_5:					   ; Offset_0x03B8C6
		dc.l	Bowling_Spin_Mappings		   ; Offset_0x10FE4C
		dc.w	$A507, $0100
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x03B8D2:
		dc.w	$0001
		dc.l	Offset_0x03B220
		dc.b	$00, $2C
		dc.l	Offset_0x03B462
		dc.b	$00, $1C
;-------------------------------------------------------------------------------
Offset_0x03B8E0:
		dc.w	$0001
		dc.l	Offset_0x03B52E
		dc.b	$EC, $18
		dc.l	Offset_0x03B52E
		dc.b	$14, $18
;-------------------------------------------------------------------------------
; Offset_0x03B8EE:
		dc.w	$0000
		dc.l	Offset_0x03B516
		dc.b	$00, $FC
;-------------------------------------------------------------------------------
Offset_0x03B8F6:
		dc.w	$0002
		dc.l	Offset_0x03B588
		dc.b	$FC, $28
		dc.l	Offset_0x03B588
		dc.b	$04, $2C
		dc.l	Offset_0x03B588
		dc.b	$FC, $3C
;-------------------------------------------------------------------------------
Offset_0x03B90A:
		dc.w	$0000
		dc.l	Offset_0x03B5CC
		dc.b	$00, $FC
;-------------------------------------------------------------------------------
Offset_0x03B912:
		dc.w	$0000
		dc.l	Obj_Explosions				   ; Offset_0x041BCA
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03B91A:
		dc.w	$0008
		dc.l	Offset_0x03B600
;-------------------------------------------------------------------------------
Offset_0x03B920:
		dc.b	$00, $03, $01, $03, $02, $03, $03, $03
		dc.b	$04, $03, $05, $03, $06, $03, $F4
;-------------------------------------------------------------------------------
Offset_0x03B92F:
		dc.b	$06, $03, $05, $03, $04, $03, $03, $03
		dc.b	$02, $03, $01, $03, $00, $03, $F4
;-------------------------------------------------------------------------------
Offset_0x03B93E:
		dc.b	$07, $08, $07, $08, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x03B944:
		dc.b	$00, $07, $08, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x03B949:
		dc.b	$0A, $00, $11, $02, $0B, $00, $11, $02
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x03B952:
		dc.b	$0F, $00, $11, $02, $10, $00, $11, $02
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x03B95B:
		dc.b	$0A, $00, $11, $07, $0B, $00, $11, $07
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x03B964:
		dc.b	$11, $00, $0F, $00, $11, $07, $10, $00
		dc.b	$11, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x03B96F:
		dc.b	$0A, $00, $11, $07, $0B, $00, $11, $0B
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x03B978:
		dc.b	$0C, $00, $0D, $01, $0E, $01, $F4, $00
;-------------------------------------------------------------------------------
Bowling_Spin_Palette:						   ; Offset_0x03B980
		dc.w	$0000, $0EEE, $06E0, $0280, $0040, $00EE, $0088, $0028
		dc.w	$008E, $000E, $0020, $0020, $0EAA, $0A64, $0642, $0044
;===============================================================================
; Objeto 0x8E - Mini chefe da Carnival Night 1
; <<<-
;===============================================================================