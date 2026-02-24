;===============================================================================
; Objeto 0xB0 - Chefe na Marble Garden
; ->>>
;===============================================================================
; Offset_0x039C7E:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x039C96(PC, D0), D1
		jsr		Offset_0x039C96(PC, D1)
		bsr.w	Offset_0x03AC88
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x039C96:
		dc.w	Offset_0x039CB8-Offset_0x039C96
		dc.w	Offset_0x039D24-Offset_0x039C96
		dc.w	Offset_0x039D4E-Offset_0x039C96
		dc.w	Offset_0x039D72-Offset_0x039C96
		dc.w	Offset_0x039D92-Offset_0x039C96
		dc.w	Offset_0x039D24-Offset_0x039C96
		dc.w	Offset_0x039DEA-Offset_0x039C96
		dc.w	Offset_0x039E10-Offset_0x039C96
		dc.w	Offset_0x039E38-Offset_0x039C96
		dc.w	Offset_0x039D24-Offset_0x039C96
		dc.w	Offset_0x039E6A-Offset_0x039C96
		dc.w	Offset_0x039D24-Offset_0x039C96
		dc.w	Offset_0x039E38-Offset_0x039C96
		dc.w	Offset_0x039EE4-Offset_0x039C96
		dc.w	Offset_0x039F1E-Offset_0x039C96
		dc.w	Offset_0x039E10-Offset_0x039C96
		dc.w	Offset_0x039E38-Offset_0x039C96
;-------------------------------------------------------------------------------
Offset_0x039CB8:
		lea		Drill_Mobile_Setup_Data(PC), A1		   ; Offset_0x03ADF6
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.b	#$FF, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.b	#$1C, Obj_Height_2(A0)					 ; $001E
		move.w	#$000C, Obj_Angle(A0)					 ; $0026
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039D2A, Obj_Child(A0)			 ; $0034
		moveq	#$6D, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Pal_MGz_Boss(PC), A1		   ; Offset_0x03AFFA
		jsr		(Pal_Load_Line_1)			   ; Offset_0x04314C
		lea		(MGz_Robotnik_Ship_Data).l, A2		   ; Offset_0x036586
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.b	#$09, Obj_Subtype(A1)					 ; $002C
		lea		Offset_0x03AE46(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x039D24:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039D2A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		moveq	#Boss_Snd, D0					   ; $19
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039D5A, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039D4E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039D5A:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039D84, Obj_Child(A0)			 ; $0034
		jmp		Swing_Setup(PC)				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x039D72:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039D84:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x039D92:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x039DB6
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		subq.w	#$02, Obj_Angle(A0)				 ; $0026
		cmpi.w	#$0004, Obj_Angle(A0)					 ; $0026
		bls.s	Offset_0x039DB8
Offset_0x039DB6:
		rts
Offset_0x039DB8:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039DD4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039DD4:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$0400, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x039DF6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039DEA:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x039DF6:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039E16, Obj_Child(A0)			 ; $0034
		st		(Foreground_Events_Y_Counter).w		 ; $FFFFEEC4
		rts
;-------------------------------------------------------------------------------
Offset_0x039E10:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x039E16:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.b	#$FF, Obj_Boss_Hit(A0)					 ; $0029
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0017, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039E3E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039E38:
		jmp		(SpeedToPos_Wait).l			   ; Offset_0x042FCE
;-------------------------------------------------------------------------------
Offset_0x039E3E:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039E5C, Obj_Child(A0)			 ; $0034
		jmp		Swing_Setup(PC)				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x039E5C:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		rts
Offset_0x039E6A:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x039E88
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		subq.w	#$02, Obj_Angle(A0)				 ; $0026
		beq.s	Offset_0x039E8A
Offset_0x039E88:
		rts
Offset_0x039E8A:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039EA0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039EA0:
		move.b	#$18, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039EBC, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039EBC:
		move.b	#$1A, Obj_Routine(A0)					 ; $0005
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	#$3E80, Obj_X(A0)				 ; $0010
		move.w	#$0700, Obj_Y(A0)				 ; $0014
		move.w	#$FF80, Obj_Speed_X(A0)					 ; $0018
		jmp		Swing_Setup(PC)				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x039EE4:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		btst	#$06, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x039F08
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcc.s	Offset_0x039F08
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x039F08:
		move.b	#$1C, Obj_Routine(A0)					 ; $0005
		move.w	#$0200, Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x039F34, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x039F1E:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		cmpi.w	#$3E00, Obj_X(A0)				 ; $0010
		bcs.w	Offset_0x039966
Offset_0x039F34:
		move.b	#$1E, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039F5C, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03AEBC(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x039F5C:
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039F6E, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03ADA2
;-------------------------------------------------------------------------------
Offset_0x039F6E:
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039F82, Obj_Child(A0)			 ; $0034
Offset_0x039F82:
		move.b	#$20, Obj_Routine(A0)					 ; $0005
		move.w	#$00FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x039F34, Obj_Child(A0)			 ; $0034
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;===============================================================================
; Objeto 0xB0 - Chefe na Marble Garden
; <<<-
;===============================================================================