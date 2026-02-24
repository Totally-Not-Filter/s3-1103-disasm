;===============================================================================
; Objeto 0xAC - Mini chefe da Angel Island 1
; ->>>
;===============================================================================
; Offset_0x036AB4:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x036AC6(PC, D0), D1
		jsr		Offset_0x036AC6(PC, D1)
		bra.w	Boss_Hit_Check				   ; Offset_0x036FC0
;-------------------------------------------------------------------------------
Offset_0x036AC6:
		dc.w	Offset_0x036AD6-Offset_0x036AC6
		dc.w	Offset_0x036AFE-Offset_0x036AC6
		dc.w	Offset_0x036632-Offset_0x036AC6
		dc.w	Offset_0x036B3E-Offset_0x036AC6
		dc.w	Offset_0x0366B4-Offset_0x036AC6
		dc.w	Offset_0x036B9E-Offset_0x036AC6
		dc.w	Offset_0x036BEA-Offset_0x036AC6
		dc.w	Offset_0x036C3E-Offset_0x036AC6
;-------------------------------------------------------------------------------
Offset_0x036AD6:
		lea		AIz_Fire_Breath_Setup_Data(PC), A1	   ; Offset_0x03705C
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#$5A, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Pal_Fire_Breath(PC), A1		   ; Offset_0x0371DA
		jmp		(Pal_Load_Line_1).l			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x036AFE:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		move.w	#$10E0, D5
		cmp.w	D5, D0
		bcc.s	Offset_0x036B0C
		rts
Offset_0x036B0C:
		move.l	#Offset_0x036B18, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x036614
;-------------------------------------------------------------------------------
Offset_0x036B18:
		move.l	#Offset_0x036B50, Obj_Child(A0)			 ; $0034
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bsr.w	Offset_0x03665A
		lea		Offset_0x0370BA(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		lea		Offset_0x0370E4(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036B3E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x036B50:
		move.l	#Offset_0x036B62, Obj_Child(A0)			 ; $0034
		move.w	#$0014, Obj_Timer(A0)					 ; $002E
		bra.w	Offset_0x036690
;-------------------------------------------------------------------------------
Offset_0x036B62:
		move.l	#Offset_0x036B80, Obj_Child(A0)			 ; $0034
		move.w	#$001E, Obj_Timer(A0)					 ; $002E
		tst.b	(Boss_Data_Buffer+$01).w			 ; $FFFFFA81
		beq.w	Offset_0x036630
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x036B80:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	#$08, Obj_Control_Var_09(A0)			 ; $0039
		moveq	#Flame_Sfx, D0					   ; $53
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x037114(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036B9E:
		jsr		(Swing_Up_And_Down_Count).l			   ; Offset_0x0423B6
		beq.s	Offset_0x036BAA
		tst.w	D1
		bmi.s	Offset_0x036BB6
Offset_0x036BAA:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
Offset_0x036BB6:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x036BF6, Obj_Child(A0)			 ; $0034
		move.w	#$FF00, D0
		bchg	#02, Obj_Control_Var_08(A0)				 ; $0038
		beq.s	Offset_0x036BE0
		neg.w	D0
		move.l	#Offset_0x036B50, Obj_Child(A0)			 ; $0034
Offset_0x036BE0:
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x036BEA:
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x036BF6:
		move.l	#Offset_0x036C14, Obj_Child(A0)			 ; $0034
;-------------------------------------------------------------------------------
Offset_0x036BFE:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x036C14:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.b	#$04, Obj_Control_Var_09(A0)			 ; $0039
		move.l	#Offset_0x036C5E, Obj_Child(A0)			 ; $0034
		move.w	#$0100, D0
		bchg	#03, Obj_Control_Var_08(A0)				 ; $0038
		bne.s	Offset_0x036C36
		neg.w	D0
Offset_0x036C36:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		bra.w	Swing_Setup					   ; Offset_0x03669A
Offset_0x036C3E:
		jsr		(Swing_Up_And_Down_Count).l			   ; Offset_0x0423B6
		bne.s	Offset_0x036C52
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
Offset_0x036C52:
		move.l	Obj_Child(A0), A1				 ; $0034
		jsr		(A1)
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x036C5E:
		move.b	#$04, Obj_Control_Var_09(A0)			 ; $0039
		move.l	#Offset_0x036C78, Obj_Child(A0)			 ; $0034
		bchg	#00, Obj_Flags(A0)				 ; $0004
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x036C78:
		move.l	#Offset_0x036BB6, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x036BFE
;-------------------------------------------------------------------------------
Offset_0x036C84:
		jsr		(Obj_Load_End_Level_Art).l			   ; Offset_0x043302
		lea		Offset_0x03716A(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036C94:
		jsr		(Refresh_Child_Position_Adjusted)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x036CAE(PC, D0), D1
		jsr		Offset_0x036CAE(PC, D1)
		jmp		(Child_Display_Or_Delete_2)			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x036CAE:
		dc.w	Offset_0x0367EA-Offset_0x036CAE
		dc.w	Offset_0x036CBA-Offset_0x036CAE
		dc.w	Offset_0x036632-Offset_0x036CAE
		dc.w	Offset_0x036832-Offset_0x036CAE
		dc.w	Offset_0x036832-Offset_0x036CAE
		dc.w	Offset_0x036630-Offset_0x036CAE
;-------------------------------------------------------------------------------
Offset_0x036CBA:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x036CC8
		rts
Offset_0x036CC8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x036CDA, Obj_Control_Var_04(A0)		 ; $0034
		bra.w	Offset_0x036F1E
;-------------------------------------------------------------------------------
Offset_0x036CDA:
		move.l	#Offset_0x036CE6, Obj_Control_Var_04(A0)		 ; $0034
		bra.w	Offset_0x036822
;-------------------------------------------------------------------------------
Offset_0x036CE6:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x036D06, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x037194, Obj_Child_Data(A0)			 ; $0030
		lea		Offset_0x037106(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x036D06:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x036D18:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x036D2C(PC, D0), D1
		jsr		Offset_0x036D2C(PC, D1)
		jmp		(Child_Display_Touch_Or_Delete).l		   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x036D2C:
		dc.w	Offset_0x036D36-Offset_0x036D2C
		dc.w	Offset_0x036D5A-Offset_0x036D2C
		dc.w	Offset_0x036632-Offset_0x036D2C
		dc.w	Offset_0x036DA8-Offset_0x036D2C
		dc.w	Offset_0x036DC4-Offset_0x036D2C
;-------------------------------------------------------------------------------
Offset_0x036D36:
		bsr.w	Offset_0x0368F0
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.l	#Offset_0x0367C2, (A1)
		bne.s	Offset_0x036D4A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
Offset_0x036D4A:
		move.l	#Offset_0x036D6C, Obj_Control_Var_04(A0)		 ; $0034
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		rts
;-------------------------------------------------------------------------------
Offset_0x036D5A:
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x036D6C:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0008, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x036D82, Obj_Control_Var_04(A0)		 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x036D82:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x036DAE, Obj_Control_Var_04(A0)		 ; $0034
		bset	#$01, Obj_Flags(A0)				 ; $0004
		bsr.w	Offset_0x036F32
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		subi.w	#$0020, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x036DA8:
		jmp		(Run_Object_Wait_Timer_A0)			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x036DAE:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x036DD6, Obj_Control_Var_04(A0)		 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x036DC4:
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x036DD6:
		moveq	#Missile_Explosion_Sfx, D0				   ; $52
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x037136(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x036DEE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x036DFC(PC, D0), D1
		jmp		Offset_0x036DFC(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x036DFC:
		dc.w	Offset_0x036E02-Offset_0x036DFC
		dc.w	Offset_0x036632-Offset_0x036DFC
		dc.w	Offset_0x036E40-Offset_0x036DFC
;-------------------------------------------------------------------------------
Offset_0x036E02:
		lea		Offset_0x037090(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Col_Flags(A1)				 ; $0028
		bne.s	Offset_0x036E1A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
Offset_0x036E1A:
		move.l	#Offset_0x041D4A, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x036E30, Obj_Child(A0)			 ; $0034
		moveq	#$0C, D1
		bra.w	Offset_0x0369B8
;-------------------------------------------------------------------------------
Offset_0x036E30:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x036E40:
		jsr		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		beq.s	Offset_0x036E52
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
Offset_0x036E52:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------

Offset_0x036E58:
		lea		Offset_0x0370A8(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x036EDC, (A0)
		move.l	#Offset_0x036EE2, Obj_Control_Var_04(A0)		 ; $0034
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		move.w	Offset_0x036EA6(PC, D0), D2
		add.w	D2, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		move.w	Offset_0x036EB2(PC, D0), D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		move.w	Offset_0x036EBE(PC, D0), Obj_Speed_X(A0)		 ; $0018
		move.w	Offset_0x036EBE(PC, D0), Obj_Timer(A0)			 ; $002E
		lsr.w	#$01, D0
		move.b	Offset_0x036ED6(PC, D0), Obj_Map_Id(A0)			 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x036EA6:
		dc.w	$FFE0, $FF98, $FFF0, $FFA8, $FFF8, $FFB0
;-------------------------------------------------------------------------------
Offset_0x036EB2:
		dc.w	$0310, $0310, $031C, $031C, $0328, $0328
;-------------------------------------------------------------------------------
Offset_0x036EBE:
		dc.w	$0100, $0100, $00C0, $00C0, $0080, $0080, $0280, $0280
		dc.w	$0178, $0178, $0000, $0000
;-------------------------------------------------------------------------------
Offset_0x036ED6:
		dc.w	$0000, $0101, $0202
;-------------------------------------------------------------------------------
Offset_0x036EDC:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x036EE2:
		move.l	#Offset_0x036EEA, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x036EEA:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x036EF6:
		lea		Offset_0x0370B4(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$0E, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$08, D0
		jmp		(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
;-------------------------------------------------------------------------------

Offset_0x036F1E:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x036F2C(PC, D0), Obj_Timer(A0)			 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x036F2C:
		dc.w	$0000, $0010, $0020
;-------------------------------------------------------------------------------
Offset_0x036F32:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Subtype(A1), D0				 ; $002C
		move.w	Offset_0x036F86(PC, D0), Obj_Timer(A0)			 ; $002E
;-------------------------------------------------------------------------------
Offset_0x036F42:
		lsr.w	#$01, D0
		move.b	Obj_Control_Var_09(A1), D1				 ; $0039
		addq.b	#$04, D1
		move.b	D1, Obj_Control_Var_09(A1)				 ; $0039
		andi.w	#$000C, D1
		add.w	D1, D0
		lea		Offset_0x036F8C(PC), A2
		lea		Offset_0x036FAC(PC), A3
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x036F6C
		lea		Offset_0x036F9C(PC), A2
		lea		Offset_0x036FB6(PC), A3
Offset_0x036F6C:
		move.b	(A2, D0), D0
		add.w	D0, D0
		move.w	(A3, D0), D0
		add.w	(Camera_X).w, D0					 ; $FFFFEE78
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	#$0400, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x036F86:
		dc.w	$0000, $0020, $0040
;-------------------------------------------------------------------------------
Offset_0x036F8C:
		dc.b	$02, $03, $04, $00, $00, $02, $04, $00
		dc.b	$01, $03, $04, $00, $00, $01, $04, $00
;-------------------------------------------------------------------------------
Offset_0x036F9C:
		dc.b	$03, $02, $00, $00, $04, $03, $01, $00
		dc.b	$04, $02, $00, $00, $03, $02, $01, $00
;-------------------------------------------------------------------------------
Offset_0x036FAC:
		dc.w	$0024, $004C, $0074, $009C, $00C4
;-------------------------------------------------------------------------------
Offset_0x036FB6:
		dc.w	$007C, $00A4, $00CC, $00F4, $011C
;-------------------------------------------------------------------------------
Boss_Hit_Check:						   ; Offset_0x036FC0
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x037012
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x037014
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x036FE6
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
		bset	#$06, Obj_Status(A0)					 ; $002A
Offset_0x036FE6:
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x036FF2
		addq.w	#$08, D0
Offset_0x036FF2:
		lea		Boss_Hit_Flash_Palette_RAM_List(PC), A1 ; Offset_0x037044
		lea		Boss_Hit_Flash_Palette_Data(PC, D0), A2 ; Offset_0x03704C
		jsr		(Move_0x08_Bytes_A2_A1).l		   ; Offset_0x04325C
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x037012
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x037012:
		rts
;-------------------------------------------------------------------------------
Offset_0x037014:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x036C84, Obj_Control_Var_04(A0)		 ; $0034
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		lea		(Offset_0x041D62).l, A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Boss_Hit_Flash_Palette_RAM_List:					   ; Offset_0x037044
		dc.w	(Palette_Row_1_Offset+$0E)				 ; $ED2E
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Boss_Hit_Flash_Palette_Data:				   ; Offset_0x03704C
		dc.w	$0644, $0240, $0020, $0644, $0888, $0AAA, $0EEE, $0AAA
;-------------------------------------------------------------------------------
AIz_Fire_Breath_Setup_Data:					   ; Offset_0x03705C
		dc.l	Fire_Breath_Mappings		   ; Offset_0x10F488
		dc.w	$A3F1, $0200
		dc.b	$20, $20, $00, $0F
;-------------------------------------------------------------------------------
Offset_0x037068:
		dc.w	$83F1, $0180
		dc.b	$28, $10, $02, $9C
;-------------------------------------------------------------------------------
Offset_0x037070:
		dc.w	$A3F1, $0200
		dc.b	$04, $08, $06, $00
;-------------------------------------------------------------------------------
Offset_0x037078:
		dc.w	$A3F1, $0280
		dc.b	$08, $08, $03, $00
;-------------------------------------------------------------------------------
Offset_0x037080:
		dc.w	$83F1, $0200
		dc.b	$08, $08, $07, $00
;-------------------------------------------------------------------------------
Offset_0x037088:
		dc.w	$83F1, $0280
		dc.b	$08, $10, $0C, $98
;-------------------------------------------------------------------------------
Offset_0x037090:
		dc.l	Boss_Explosion_Mappings		   ; Offset_0x10E5C0
		dc.w	$84A9, $0080
		dc.b	$0C, $0C, $00, $97
;-------------------------------------------------------------------------------
Offset_0x03709C:
		dc.l	Fire_Breath_Flame_Mappings			   ; Offset_0x10E5FC
		dc.w	$8459, $0100
		dc.b	$10, $10, $00, $8B
;-------------------------------------------------------------------------------
Offset_0x0370A8:
		dc.l	Small_Fire_Breath_Mappings			   ; Offset_0x10F5A2
		dc.w	$244B, $0380
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0370B4:
		dc.w	$0200
		dc.b	$10, $14, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0370BA:
		dc.w	$0001
		dc.l	Offset_0x03675A
		dc.w	$0020
		dc.l	Offset_0x0367A0
		dc.w	$DC08
;-------------------------------------------------------------------------------
Offset_0x0370C8:
		dc.w	$0005
		dc.l	Offset_0x036E58
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x0370D0:
		dc.w	$0002
		dc.l	Offset_0x0367C2
		dc.w	$00E0
		dc.l	Offset_0x0367C2
		dc.w	$09E4
		dc.l	Offset_0x0367C2
		dc.w	$12E8
;-------------------------------------------------------------------------------
Offset_0x0370E4:
		dc.w	$0002
		dc.l	Offset_0x036C94
		dc.w	$00E0
		dc.l	Offset_0x036C94
		dc.w	$09E4
		dc.l	Offset_0x036C94
		dc.w	$12E8
;-------------------------------------------------------------------------------
Offset_0x0370F8:
		dc.w	$0001
		dc.l	Offset_0x0368A0
		dc.w	$0004
		dc.l	Offset_0x0368DA
		dc.w	$0004
;-------------------------------------------------------------------------------
Offset_0x037106:
		dc.w	$0001
		dc.l	Offset_0x0368A0
		dc.w	$0004
		dc.l	Offset_0x036D18
		dc.w	$0004
;-------------------------------------------------------------------------------
Offset_0x037114:
		dc.w	$0003
		dc.l	Obj_Fire_Breath_Flame		   ; Offset_0x03698A
		dc.w	$9C04
		dc.l	Obj_Fire_Breath_Flame		   ; Offset_0x03698A
		dc.w	$AC04
		dc.l	Obj_Fire_Breath_Flame		   ; Offset_0x03698A
		dc.w	$BC04
		dc.l	Obj_Fire_Breath_Flame		   ; Offset_0x03698A
		dc.w	$D403
;-------------------------------------------------------------------------------
Offset_0x03712E:
		dc.w	$0000
		dc.l	Offset_0x036A24
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x037136:
		dc.w	$0006
		dc.l	Offset_0x036DEE
		dc.w	$00DC
		dc.l	Offset_0x036DEE
		dc.w	$08E4
		dc.l	Offset_0x036DEE
		dc.w	$F8E4
		dc.l	Offset_0x036DEE
		dc.w	$04EC
		dc.l	Offset_0x036DEE
		dc.w	$FCEC
		dc.l	Offset_0x036DEE
		dc.w	$04FC
		dc.l	Offset_0x036DEE
		dc.w	$FCFC
;-------------------------------------------------------------------------------
Offset_0x037162:
		dc.w	$0000
		dc.l	Offset_0x041CD4
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x03716A:
		dc.w	$0003
		dc.l	Offset_0x036EF6
		dc.w	$F0F8
		dc.l	Offset_0x036EF6
		dc.w	$0CF0
		dc.l	Offset_0x036EF6
		dc.w	$F014
		dc.l	Offset_0x036EF6
		dc.w	$100C
;-------------------------------------------------------------------------------
Offset_0x037184:
		dc.b	$01, $01, $02, $FC, $07, $03, $04, $05
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x03718D:
		dc.b	$03, $05, $04, $05, $05, $17, $F4
;-------------------------------------------------------------------------------
Offset_0x037194:
		dc.b	$05, $17, $05, $17, $04, $05, $03, $05
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x03719D:
		dc.b	$07, $01, $07, $01, $08, $01, $09, $03
		dc.b	$0A, $03, $0B, $03, $F4
;-------------------------------------------------------------------------------
Offset_0x0371AA:
		dc.b	$01, $0C, $0D, $FC, $00, $00, $00, $00
		dc.b	$01, $01, $02, $02, $03, $03, $04, $04
		dc.b	$05, $04, $F4
;-------------------------------------------------------------------------------
Offset_0x0371BD:
		dc.b	$00, $01, $00, $01, $F4
;-------------------------------------------------------------------------------
Offset_0x0371C2:
		dc.b	$02, $01, $02, $01, $03, $02, $04, $04
		dc.b	$05, $01, $F4
;-------------------------------------------------------------------------------
Offset_0x0371CD:
		dc.b	$00, $01, $00, $01, $01, $02, $02, $02
		dc.b	$03, $04, $04, $04, $F4
;-------------------------------------------------------------------------------
Pal_Fire_Breath:							   ; Offset_0x0371DA
		dc.w	$0000, $0EEE, $0E88, $0C66, $0A64, $00EE, $0088, $0642
		dc.w	$0020, $0000, $0240, $0020, $0ECC, $0A88, $0644, $0044
;===============================================================================
; Objeto 0xAC - Mini chefe da Angel Island 1
; <<<-
;===============================================================================