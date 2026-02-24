;===============================================================================
; Objeto 0xAF - Chefe na Marble Garden
; ->>>
;===============================================================================
; Offset_0x039920:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039958, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Subtype(A0)					 ; $002C
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		moveq	#$6D, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Pal_MGz_Boss(PC), A1		   ; Offset_0x03AFFA
		jmp		(Pal_Load_Line_1).l			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x039958:
		move.l	#Offset_0x039968, (A0)
		moveq	#Boss_Snd, D0					   ; $19
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x039966:
		rts
;-------------------------------------------------------------------------------
Offset_0x039968:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x039980(PC, D0), D1
		jsr		Offset_0x039980(PC, D1)
		bsr.w	Offset_0x03AC88
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x039980:
		dc.w	Offset_0x03999A-Offset_0x039980
		dc.w	Offset_0x0399E4-Offset_0x039980
		dc.w	Offset_0x0399F4-Offset_0x039980
		dc.w	Offset_0x039A4E-Offset_0x039980
		dc.w	Offset_0x039A82-Offset_0x039980
		dc.w	Offset_0x039AB4-Offset_0x039980
		dc.w	Offset_0x039AF2-Offset_0x039980
		dc.w	Offset_0x039B06-Offset_0x039980
		dc.w	Offset_0x039AB4-Offset_0x039980
		dc.w	Offset_0x039B3A-Offset_0x039980
		dc.w	Offset_0x039AB4-Offset_0x039980
		dc.w	Offset_0x039BA4-Offset_0x039980
		dc.w	Offset_0x039C72-Offset_0x039980
;-------------------------------------------------------------------------------
Offset_0x03999A:
		lea		Drill_Mobile_Setup_Data(PC), A1		   ; Offset_0x03ADF6
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$FF, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$30, Obj_Width_2(A0)					 ; $001F
		move.b	#$24, Obj_Height_2(A0)					 ; $001E
		move.w	#$000C, Obj_Angle(A0)					 ; $0026
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$F800, Obj_Speed_Y(A0)					 ; $001A
		lea		MGz_Robotnik_Ship_Data(PC), A2		   ; Offset_0x036586
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		bne.s	Offset_0x0399DA
		move.b	#$09, Obj_Subtype(A1)					 ; $002C
Offset_0x0399DA:
		lea		Offset_0x03AE46(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0399E4:
		tst.l	(PLC_Data_Buffer).w					 ; $FFFFF680
		bne.w	Offset_0x039966
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0399F4:
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		addi.w	#$0040, D0
		cmpi.w	#$00C0, D0
		bge.s	Offset_0x039A3E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		btst	#$07, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x039A38
		move.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		addi.w	#$0120, D1
		cmp.w	Obj_Y(A0), D1					 ; $0014
		bcs.s	Offset_0x039A38
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x03AE70(PC), A2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x039A32
		lea		Offset_0x03AE78(PC), A2
Offset_0x039A32:
		jsr		(SetupChildObject_Repeat).l		   ; Offset_0x041E4E
Offset_0x039A38:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x039A3E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$05, Obj_Control_Var_09(A0)			 ; $0039
		jmp		Swing_Setup(PC)				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x039A4E:
		btst	#$06, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x039A62
		jsr		(Swing_Up_And_Down_Count)			   ; Offset_0x0423B6
		tst.b	Obj_Control_Var_09(A0)					 ; $0039
		bpl.s	Offset_0x039A7C
Offset_0x039A62:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039BD0, Obj_Child(A0)			 ; $0034
Offset_0x039A7C:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x039A82:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x039AA8
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		subq.w	#$02, Obj_Angle(A0)				 ; $0026
		bne.s	Offset_0x039AA8
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039AC6, Obj_Child(A0)			 ; $0034
Offset_0x039AA8:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x039AB4:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039AC6:
		move.l	#Offset_0x039ADC, Obj_Child(A0)			 ; $0034
Offset_0x039ACE:
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x039ADC:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039AF8, Obj_Child(A0)			 ; $0034
		rts
Offset_0x039AF2:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039AF8:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x039B06:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x039B10
		rts
Offset_0x039B10:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039B2C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039B2C:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x039B3A:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x039B5E
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		addq.w	#$02, Obj_Angle(A0)				 ; $0026
		cmpi.w	#$000C, Obj_Angle(A0)					 ; $0026
		bcc.s	Offset_0x039B60
Offset_0x039B5E:
		rts
Offset_0x039B60:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039B76, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039B76:
		move.l	#Offset_0x039B82, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x039ACE
;-------------------------------------------------------------------------------
Offset_0x039B82:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039BD0, Obj_Child(A0)			 ; $0034
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x039BA4:
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bmi.s	Offset_0x039BB4
		jmp		(SpeedToPos_Wait).l			   ; Offset_0x042FCE
Offset_0x039BB4:
		move.b	#$18, Obj_Routine(A0)					 ; $0005
		lea		Offset_0x03AE70(PC), A2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x039BCA
		lea		Offset_0x03AE78(PC), A2
Offset_0x039BCA:
		jmp		(SetupChildObject_Repeat).l		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x039BD0:
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		lea		(Marble_Garden_1_Tiles).l, A1			   ; Offset_0x15D0A4
		move.w	#$0000, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		lea		(Marble_Garden_2_Tiles_2).l, A1		   ; Offset_0x1632A8
		move.w	#$4FC0, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		moveq	#$14, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		(Art_Spiker).l, A1			   ; Offset_0x11A308
		move.w	#$A600, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		lea		(Art_Mantis).l, A1			   ; Offset_0x11A51A
		move.w	#$A9E0, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		lea		(PLC_MGz_After_Boss).l, A1			   ; Offset_0x041B90
		jsr		(LoadPLC_Direct).l					 ; Offset_0x001502
		lea		(Palette_MGZ).l, A1		   ; Offset_0x1E9D14
		jsr		(Pal_Load_Line_1).l			   ; Offset_0x04314C
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x039C60
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		move.w	#$6000, (Target_Camera_Max_X).w		 ; $FFFFFA92
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
Offset_0x039C60:
		lea		(Level_Resize_Min_X).l, A2			   ; Offset_0x042622
		move.w	#$0000, (Target_Camera_Min_X).w		 ; $FFFFFA94
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x039C72:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;===============================================================================
; Objeto 0xAF - Chefe na Marble Garden
; <<<-
;===============================================================================