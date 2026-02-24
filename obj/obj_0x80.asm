;===============================================================================
; Objeto 0x80 - Primeira aparição do mini chefe na Angel Island 1
; ->>>
;===============================================================================
; Offset_0x0365AA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0365BC(PC, D0), D1
		jsr		Offset_0x0365BC(PC, D1)
		bra.w	Boss_Hit_Check				   ; Offset_0x036FC0
;-------------------------------------------------------------------------------
Offset_0x0365BC:
		dc.w	Offset_0x0365C6-Offset_0x0365BC
		dc.w	Offset_0x0365F4-Offset_0x0365BC
		dc.w	Offset_0x036632-Offset_0x0365BC
		dc.w	Offset_0x036670-Offset_0x0365BC
		dc.w	Offset_0x0366B4-Offset_0x0365BC
;-------------------------------------------------------------------------------
Offset_0x0365C6:
		lea		AIz_Fire_Breath_Setup_Data(PC), A1	   ; Offset_0x03705C
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$60, Obj_Boss_Hit(A0)					 ; $0029
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#$5A, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Pal_Fire_Breath(PC), A1		   ; Offset_0x0371DA
		jmp		(Pal_Load_Line_1).l			   ; Offset_0x04314C
Offset_0x0365F4:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		move.w	#$2F10, D5
		cmp.w	D5, D0
		bcc.s	Offset_0x036602
		rts
Offset_0x036602:
		move.l	#Offset_0x036638, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0370C8(PC), A2
		jsr		(SetupChildObject_Repeat).l		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x036614:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.w	D5, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D5, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x036630:
		rts
Offset_0x036632:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x036638:
		move.l	#Offset_0x036676, Obj_Child(A0)			 ; $0034
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		lea		Offset_0x0370BA(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		lea		Offset_0x0370D0(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03665A:
		move.w	#$0100, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00AF, Obj_Timer(A0)					 ; $002E
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(PlaySound).l					; Offset_0x001176
		rts
Offset_0x036670:
		jmp		(SpeedToPos_Touch_Wait).l		   ; Offset_0x042F98
;-------------------------------------------------------------------------------
Offset_0x036676:
		move.l	#Offset_0x0366C0, Obj_Child(A0)			 ; $0034
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.b	#$03, Obj_Control_Var_09(A0)			 ; $0039
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
;-------------------------------------------------------------------------------
Offset_0x036690:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
;-------------------------------------------------------------------------------
Swing_Setup:						   ; Offset_0x03669A
		move.w	#$00C0, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0010, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0366B4:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jmp		(SpeedToPos_Touch_Wait).l		   ; Offset_0x042F98
;-------------------------------------------------------------------------------
Offset_0x0366C0:
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bpl.s	Offset_0x0366CE
		move.l	#Offset_0x0366E6, Obj_Child(A0)			 ; $0034
Offset_0x0366CE:
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		moveq	#Flame_Sfx, D0					   ; $53
		jsr		(PlaySound).l					; Offset_0x001176
		lea		Offset_0x037114(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0366E6:
		move.w	#$0080, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0366FE, Obj_Child(A0)			 ; $0034
		lea		Offset_0x037162(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0366FE:
		move.l	#Offset_0x036738, (A0)
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#$0400, Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		cmpi.w	#$0000, (Current_ZoneAndAct).w				   ; $FFFFFE10
		bne.s	Offset_0x03672A
		move.w	#$0120, Obj_Timer(A0)					 ; $002E
Offset_0x03672A:
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		st		(Level_Events_Buffer_5).w			 ; $FFFFEEC6
		rts
;-------------------------------------------------------------------------------
Offset_0x036738:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03674A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03674A:
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		jmp		(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03675A:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		lea		Offset_0x037068(PC), A1
		jsr		(SetupObjectAttributes2)			; Offset_0x041D76
		move.l	#Offset_0x037184, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03677E, (A0)
		jmp		(Child_Display_Touch_Or_Delete_2).l	   ; Offset_0x0424BE
;-------------------------------------------------------------------------------
Offset_0x03677E:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03679A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
Offset_0x03679A:
		jmp		(Child_Display_Touch_Or_Delete_2).l	   ; Offset_0x0424BE
;-------------------------------------------------------------------------------
Offset_0x0367A0:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		move.l	#Offset_0x0367B6, (A0)
		lea		Offset_0x037070(PC), A1
		jmp		(SetupObjectAttributes2).l			; Offset_0x041D76
;-------------------------------------------------------------------------------
Offset_0x0367B6:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		jmp		(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x0367C2:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0367DC(PC, D0), D1
		jsr		Offset_0x0367DC(PC, D1)
		jmp		(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x0367DC:
		dc.w	Offset_0x0367EA-Offset_0x0367DC
		dc.w	Offset_0x0367F4-Offset_0x0367DC
		dc.w	Offset_0x036814-Offset_0x0367DC
		dc.w	Offset_0x036832-Offset_0x0367DC
		dc.w	Offset_0x036872-Offset_0x0367DC
		dc.w	Offset_0x036832-Offset_0x0367DC
		dc.w	Offset_0x036630-Offset_0x0367DC
;-------------------------------------------------------------------------------
Offset_0x0367EA:
		lea		Offset_0x037078(PC), A1
		jmp		(SetupObjectAttributes2).l			; Offset_0x041D76
;-------------------------------------------------------------------------------
Offset_0x0367F4:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x036802
		rts
Offset_0x036802:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03681A, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x036F1E
;-------------------------------------------------------------------------------
Offset_0x036814:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03681A:
		move.l	#Offset_0x036838, Obj_Child(A0)			 ; $0034
;-------------------------------------------------------------------------------
Offset_0x036822:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03718D, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x036832:
		jmp		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x036838:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	#$03, Obj_Control_Var_09(A0)			 ; $0039
		move.l	#Offset_0x03684C, Obj_Child(A0)			 ; $0034
Offset_0x03684C:
		move.w	#$001C, Obj_Timer(A0)					 ; $002E
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		cmpi.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		beq.s	Offset_0x036868
		lea		Offset_0x0370F8(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x036868:
		lea		Offset_0x037106(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036872:
		jsr		(Run_Object_Wait_Timer_A0)			   ; Offset_0x0423D2
		tst.b	Obj_Control_Var_09(A0)					 ; $0039
		bmi.s	Offset_0x036880
		rts
Offset_0x036880:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x037194, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x036898, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x036898:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0368A0:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0368BA(PC, D0), D1
		jsr		Offset_0x0368BA(PC, D1)
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0368BA:
		dc.w	Offset_0x0368BE-Offset_0x0368BA
		dc.w	Offset_0x036832-Offset_0x0368BA
;-------------------------------------------------------------------------------
Offset_0x0368BE:
		lea		Offset_0x037080(PC), A1
		jsr		(SetupObjectAttributes2).l			; Offset_0x041D76
		move.l	#Offset_0x03719D, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0368DA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0368E8(PC, D0), D1
		jmp		Offset_0x0368E8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0368E8:
		dc.w	Offset_0x0368F0-Offset_0x0368E8
		dc.w	Offset_0x036924-Offset_0x0368E8
		dc.w	Offset_0x036632-Offset_0x0368E8
		dc.w	Offset_0x036924-Offset_0x0368E8
;-------------------------------------------------------------------------------
Offset_0x0368F0:
		lea		Offset_0x037088(PC), A1
		jsr		(SetupObjectAttributes2).l			; Offset_0x041D76
		moveq	#Sfx_61, D0						   ; $61
		jsr		(PlaySound).l					; Offset_0x001176
		move.l	#Offset_0x0371AA, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x036930, Obj_Child(A0)			 ; $0034
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x036924:
		jsr		(SpeedToPos_Animate_Raw_Wait).l		   ; Offset_0x042F7C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x036930:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0008, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x036946, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x036946:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		moveq	#Missile_Throw_Sfx, D0					   ; $56
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		bset	#$01, Obj_Flags(A0)				 ; $0004
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Subtype(A1), D0				 ; $002C
		bsr.w	Offset_0x036F42
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		subi.w	#$0020, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Obj_Fire_Breath_Flame:						   ; Offset_0x03698A
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03699E(PC, D0), D1
		jmp		Offset_0x03699E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x03699E:
		dc.w	Offset_0x0369A4-Offset_0x03699E
		dc.w	Offset_0x036632-Offset_0x03699E
		dc.w	Offset_0x0369E6-Offset_0x03699E
;-------------------------------------------------------------------------------
Offset_0x0369A4:
		lea		Offset_0x03709C(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x0369CE, Obj_Child(A0)			 ; $0034
		moveq	#$06, D1
;-------------------------------------------------------------------------------
Offset_0x0369B8:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		sub.w	D0, D1
		add.b	D1, D1
		move.w	D1, Obj_Timer(A0)				 ; $002E
		rts
;-------------------------------------------------------------------------------
; Offset_0x0369C8:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0369CE:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0371BD, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0369F2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0369E6:
		jsr		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x0369F2:
		move.l	#Boss_Explosion_Mappings, Obj_Map(A0) ; Offset_0x10E5C0, $000C
		move.w	#$84A9, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Offset_0x0371C2, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		cmpi.b	#$06, Obj_Subtype(A0)					 ; $002C
		bne.w	Offset_0x036630
		lea		Offset_0x03712E(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036A24:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x036A38(PC, D0), D1
		jsr		Offset_0x036A38(PC, D1)
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x036A38:
		dc.w	Offset_0x036A3C-Offset_0x036A38
		dc.w	Offset_0x036A88-Offset_0x036A38
;-------------------------------------------------------------------------------
Offset_0x036A3C:
		bsr.w	Offset_0x0369A4
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x0371CD, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	A1, Obj_Child_Ref(A0)					 ; $0046
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		move.w	#$FFA0, D0
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x036A7C
		neg.w	D0
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x036A7C:
		move.w	Obj_X(A1), D1					 ; $0010
		add.w	D0, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x036A88:
		jsr		(Animate_Raw_Multi_Delay)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x036AA6
		bmi.s	Offset_0x036AA6
		move.w	Offset_0x036AA8(PC, D0), D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x036AA2
		neg.w	D0
Offset_0x036AA2:
		add.w	D0, Obj_X(A0)					 ; $0010
Offset_0x036AA6:
		rts
;-------------------------------------------------------------------------------
Offset_0x036AA8:
		dc.w	$0000, $0000, $0000, $0010, $0008, $0008
;===============================================================================
; Objeto 0x80 - Primeira aparição do mini chefe na Angel Island 1
; <<<-
;===============================================================================