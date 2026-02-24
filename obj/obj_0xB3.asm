;===============================================================================
; Objeto 0xB3 - Mini chefe na Icecap
; ->>>
;===============================================================================
; Offset_0x03DCB0:
		lea		Offset_0x03DD10(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		move.l	#Offset_0x03DD18, (A0)
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.b	#$18, Obj_Angle(A0)				 ; $0026
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	#$02B8, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$0720, Obj_Inertia(A0)					 ; $001C
		move.w	#$0720, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.l	#Offset_0x03DD1E, Obj_Child(A0)			 ; $0034
		moveq	#$5F, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Big_Icedus_Palette(PC), A1			   ; Offset_0x03E46C
		jmp		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03DD10:
		dc.w	$0200, $0380, $0690, $0720
;-------------------------------------------------------------------------------
Offset_0x03DD18:
		jmp		(Update_Sonic_Level_Limits_X_Y_Play_Music) ; Offset_0x0433DE
;-------------------------------------------------------------------------------
Offset_0x03DD1E:
		move.l	#Offset_0x03DD26, (A0)
Offset_0x03DD24:
		rts
;-------------------------------------------------------------------------------
Offset_0x03DD26:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03DD3C(PC, D0), D1
		jsr		Offset_0x03DD3C(PC, D1)
		bsr.w	Offset_0x03E366
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03DD3C:
		dc.w	Offset_0x03DD50-Offset_0x03DD3C
		dc.w	Offset_0x03DD88-Offset_0x03DD3C
		dc.w	Offset_0x03DDAE-Offset_0x03DD3C
		dc.w	Offset_0x03DDD8-Offset_0x03DD3C
		dc.w	Offset_0x03DE12-Offset_0x03DD3C
		dc.w	Offset_0x03DE42-Offset_0x03DD3C
		dc.w	Offset_0x03DDD8-Offset_0x03DD3C
		dc.w	Offset_0x03DE94-Offset_0x03DD3C
		dc.w	Offset_0x03DEBE-Offset_0x03DD3C
		dc.w	Offset_0x03DD88-Offset_0x03DD3C
;-------------------------------------------------------------------------------
Offset_0x03DD50:
		lea		Big_Icedus_Setup_Data(PC), A1		   ; Offset_0x03E3F2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.w	#$0200, Obj_Control_Var_0E(A0)			 ; $003E
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DD92, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03E43C(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		lea		Offset_0x03E416(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03DD88:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DD92:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DDB2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DDAE:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DDB2:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DDE0, Obj_Child(A0)			 ; $0034
		lea		(Big_Icedus_Palette_Rotation_Script).l, A1 ; Offset_0x1101A4
Offset_0x03DDCC:
		lea		(Palette_Rotation_Data).w, A2		 ; $FFFFFADE
		move.l	(A1)+, (A2)+
		move.l	(A1)+, (A2)+
		clr.w	(A2)
		rts
;-------------------------------------------------------------------------------
Offset_0x03DDD8:
		jsr		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DDE0:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DDF6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DDF6:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0300, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DE20, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DE12:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DE20:
		bsr.w	Offset_0x03E2E0
Offset_0x03DE24:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$0300, Obj_Speed_Y(A0)					 ; $001A
		neg.w	Obj_Control_Var_0E(A0)					 ; $003E
		move.w	Obj_Control_Var_0E(A0), Obj_Speed_X(A0)	  ; $003E, $0018
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03DE42:
		jsr		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03DE58
		addi.w	#$FFF0, Obj_Speed_Y(A0)					 ; $001A
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x03DE58:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DE76, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
; Offset_0x03DE6E:
		jsr		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DE76:
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bpl.s	Offset_0x03DE24
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		cmpi.w	#$07C0, Obj_X(A0)				 ; $0010
		scs		Obj_Control_Var_13(A0)					 ; $0043
		rts
;-------------------------------------------------------------------------------
Offset_0x03DE94:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03DEA0
		jmp		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
Offset_0x03DEA0:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x03DEC2, (Palette_Rotation_Custom).w ; $FFFFFADA
		lea		(Big_Icedus_Palette_Rotation_Script_2).l, A1 ; Offset_0x110210
		bra.w	Offset_0x03DDCC
;-------------------------------------------------------------------------------
Offset_0x03DEBE:
		jmp		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
;-------------------------------------------------------------------------------
Offset_0x03DEC2:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		move.w	#$0222, (Palette_Row_1_Offset+$14).w		 ; $FFFFED34
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		clr.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$0017, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DEE8, Obj_Child(A0)				   ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DEE8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$00FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DDB2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DEFE:
		jsr		(Obj_Load_End_Level_Art).l			   ; Offset_0x043302
		lea		Offset_0x03E442(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03DF0C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03DF24(PC, D0), D1
		jsr		Offset_0x03DF24(PC, D1)
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		jmp		Child_Display_Or_Flicker_Move_2(PC)	   ; Offset_0x04250E
;-------------------------------------------------------------------------------
Offset_0x03DF24:
		dc.w	Offset_0x03DF2C-Offset_0x03DF24
		dc.w	Offset_0x03DF38-Offset_0x03DF24
		dc.w	Offset_0x03DF58-Offset_0x03DF24
		dc.w	Offset_0x03DF74-Offset_0x03DF24
;-------------------------------------------------------------------------------
Offset_0x03DF2C:
		lea		Big_Icedus_Setup_Data_2(PC), A1		   ; Offset_0x03E3FE
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		bra.w	Offset_0x03E14E
;-------------------------------------------------------------------------------
Offset_0x03DF38:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03DF46
		rts
Offset_0x03DF46:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03DF6C, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03E164
;-------------------------------------------------------------------------------
Offset_0x03DF58:
		move.b	Obj_Speed_X(A0), D0				 ; $0018
		add.b	D0, Obj_Control_Var_12(A0)				 ; $0042
		move.b	Obj_Speed_X+$01(A0), D0				 ; $0019
		add.b	D0, Obj_Control_Var_13(A0)				 ; $0043
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DF6C:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03DF74:
		rts
;-------------------------------------------------------------------------------
Offset_0x03DF76:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03DF8A(PC, D0), D1
		jsr		Offset_0x03DF8A(PC, D1)
		moveq	#$00, D0
		jmp		Child_Display_Touch_Or_Flicker_Move_2(PC) ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03DF8A:
		dc.w	Offset_0x03DFA2-Offset_0x03DF8A
		dc.w	Offset_0x03DFAE-Offset_0x03DF8A
		dc.w	Offset_0x03DFD8-Offset_0x03DF8A
		dc.w	Offset_0x03E012-Offset_0x03DF8A
		dc.w	Offset_0x03E02A-Offset_0x03DF8A
		dc.w	Offset_0x03E042-Offset_0x03DF8A
		dc.w	Offset_0x03E062-Offset_0x03DF8A
		dc.w	Offset_0x03E0AC-Offset_0x03DF8A
		dc.w	Offset_0x03E012-Offset_0x03DF8A
		dc.w	Offset_0x03E0F8-Offset_0x03DF8A
		dc.w	Offset_0x03E012-Offset_0x03DF8A
		dc.w	Offset_0x03E128-Offset_0x03DF8A
;-------------------------------------------------------------------------------
Offset_0x03DFA2:
		lea		Big_Icedus_Setup_Data_3(PC), A1		   ; Offset_0x03E404
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		bra.w	Offset_0x03E190
;-------------------------------------------------------------------------------
Offset_0x03DFAE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03DFBC
		rts
Offset_0x03DFBC:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$FFC0, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DFF2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03DFD8:
		moveq	#$01, D0
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x03DFE4
		neg.w	D0
Offset_0x03DFE4:
		add.w	D0, Obj_X(A0)					 ; $0010
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03DFF2:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		bsr.w	Offset_0x03E1D6
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E01C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E012:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E01C:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	#$8B, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x03E02A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03E03A
		bra.w	Offset_0x03E232
Offset_0x03E03A:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03E042:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		tst.b	Obj_Control_Var_13(A1)					 ; $0043
		bne.s	Offset_0x03E050
		moveq	#-$80, D0
Offset_0x03E050:
		cmp.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		beq.s	Offset_0x03E05A
		bra.w	Offset_0x03E232
Offset_0x03E05A:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03E062:
		addq.b	#$04, Obj_Control_Var_0C(A0)			 ; $003C
		lea		(Big_Icedus_Angle_Lookup).l, A2			 ; Offset_0x11027C
		jsr		Move_Sprite_At_Angle_Lookup(PC)		   ; Offset_0x042742
		moveq	#$00, D0
		bsr.w	Offset_0x03E24A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03E09C
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.w	Offset_0x03DD24
		moveq	#$00, D0
		tst.b	Obj_Control_Var_13(A1)					 ; $0043
		bne.s	Offset_0x03E094
		moveq	#-$80, D0
Offset_0x03E094:
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bne.w	Offset_0x03DD24
Offset_0x03E09C:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bra.w	Offset_0x03E2FC
;-------------------------------------------------------------------------------
Offset_0x03E0AC:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		cmp.b	Obj_Control_Var_12(A0), D0				 ; $0042
		beq.s	Offset_0x03E0CA
		addq.b	#$04, Obj_Control_Var_0C(A0)			 ; $003C
		lea		(Big_Icedus_Angle_Lookup).l, A2		   ; Offset_0x11027C
		jsr		Move_Sprite_At_Angle_Lookup(PC)		   ; Offset_0x042742
		moveq	#$00, D0
		bra.w	Offset_0x03E24A
Offset_0x03E0CA:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E0E0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E0E0:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E0FC, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03E35C
Offset_0x03E0F8:
;-------------------------------------------------------------------------------
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03E0FC:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		move.w	#$0400, Obj_Speed_Y(A0)					 ; $001A
		clr.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$0045, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03E11C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03E11C:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x03E128:
		rts
;-------------------------------------------------------------------------------
Offset_0x03E12A:
		lea		Big_Icedus_Setup_Data_4(PC), A1		   ; Offset_0x03E410
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$0B, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$08, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
Offset_0x03E14E:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		move.b	Offset_0x03E15E(PC, D0), Obj_Map_Id(A0)			 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x03E15E:
		dc.b	$01, $09, $03, $02, $0A, $04
;-------------------------------------------------------------------------------
Offset_0x03E164:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03E178(PC, D0), Obj_Speed_X(A0)		 ; $0018
		move.w	Offset_0x03E184(PC, D0), Obj_Timer(A0)			 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03E178:
		dc.w	$FFFF, $01FF, $0001, $FFFF, $01FF, $0001
;-------------------------------------------------------------------------------
Offset_0x03E184:
		dc.w	$0002, $0002, $0003, $0006, $0006, $0008
;-------------------------------------------------------------------------------
Offset_0x03E190:
		move.w	#$0390, Obj_Y(A0)				 ; $0014
Offset_0x03E196:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03E1C6(PC, D0), D2
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$0007, D0
		subq.w	#$03, D0
		add.w	D0, D2
		move.w	#$0720, Obj_X(A0)				 ; $0010
		add.w	D2, Obj_X(A0)					 ; $0010
		swap	D0
		andi.w	#$0007, D0
		subq.w	#$03, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03E1C6:
		dc.w	$FFE0, $0020, $0060, $00A0, $00E0, $0120, $0160, $01A0
;-------------------------------------------------------------------------------
Offset_0x03E1D6:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$04, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Y(A0), D1					 ; $0014
		movem.w D0/D1, -(A7)
		lea		(Big_Icedus_Angle_Lookup).l, A2			 ; Offset_0x11027C
		jsr		Move_Sprite_At_Angle_Lookup(PC)		   ; Offset_0x042742
		moveq	#$00, D0
		moveq	#$00, D1
		moveq	#$00, D2
		moveq	#$00, D3
		movem.w (A7)+, D0/D1
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	D1, Obj_Y(A0)					 ; $0014
		swap	D0
		swap	D1
		swap	D2
		swap	D3
		sub.l	D0, D2
		sub.l	D1, D3
		lsl.l	#$03, D2
		lsl.l	#$03, D3
		swap	D2
		swap	D3
		move.w	D2, Obj_Speed_X(A0)				 ; $0018
		move.w	D3, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x03E232:
		addq.b	#$04, Obj_Control_Var_0C(A0)			 ; $003C
		lea		(Big_Icedus_Angle_Lookup).l, A2			 ; Offset_0x11027C
		jsr		Move_Sprite_At_Angle_Lookup(PC)		   ; Offset_0x042742
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		addq.b	#$01, D0
		move.b	D0, Obj_Control_Var_0D(A0)				 ; $003D
Offset_0x03E24A:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		tst.w	D1
		bpl.s	Offset_0x03E256
		neg.w	D1
Offset_0x03E256:
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	Obj_Y(A1), D4					 ; $0014
		sub.w	D4, D2
		scs		D3
		bcc.s	Offset_0x03E266
		neg.w	D2
Offset_0x03E266:
		mulu.w	D1, D2
		lsr.l	#$08, D2
		cmpi.b	#$40, Obj_Control_Var_0D(A0)			 ; $003D
		bcs.s	Offset_0x03E27C
		cmpi.b	#$C0, Obj_Control_Var_0D(A0)			 ; $003D
		bcc.s	Offset_0x03E27C
		not.b	D3
Offset_0x03E27C:
		tst.b	D3
		beq.s	Offset_0x03E282
		neg.w	D2
Offset_0x03E282:
		add.w	D2, D4
		move.w	D4, Obj_Y(A0)					 ; $0014
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		spl		D3
		cmpi.b	#$40, Obj_Control_Var_0C(A0)			 ; $003C
		bcs.s	Offset_0x03E2A0
		cmpi.b	#$C0, Obj_Control_Var_0C(A0)			 ; $003C
		bcc.s	Offset_0x03E2A0
		not.b	D3
Offset_0x03E2A0:
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$20, D0
		bcs.s	Offset_0x03E2CE
		cmpi.b	#$60, D0
		bcs.s	Offset_0x03E2BE
		cmpi.b	#$A0, D0
		bcs.s	Offset_0x03E2CE
		cmpi.b	#$E0, D0
		bcc.s	Offset_0x03E2CE
Offset_0x03E2BE:
		move.b	#$05, Obj_Map_Id(A0)					 ; $0022
		tst.b	D3
		bne.s	Offset_0x03E2CE
		move.b	#$08, Obj_Map_Id(A0)					 ; $0022
Offset_0x03E2CE:
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		tst.b	D3
		bne.s	Offset_0x03E2DE
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
Offset_0x03E2DE:
		rts
;-------------------------------------------------------------------------------
Offset_0x03E2E0:
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		addq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		andi.w	#$0007, D0
		move.b	Offset_0x03E2F4(PC, D0), Obj_Control_Var_09(A0)	 ; $0039
		rts
;-------------------------------------------------------------------------------
Offset_0x03E2F4:
		dc.b	$01, $00, $01, $01, $00, $01, $00, $00
;-------------------------------------------------------------------------------
Offset_0x03E2FC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		lsr.w	#$01, D1
		tst.b	Obj_Control_Var_13(A1)					 ; $0043
		bne.s	Offset_0x03E312
		addq.w	#$08, D1
Offset_0x03E312:
		move.b	Offset_0x03E32C(PC, D1), Obj_Control_Var_12(A0)	 ; $0042
		add.w	D0, D0
		move.l	Offset_0x03E33C(PC, D0), Obj_Speed_X(A0)		 ; $0018
		tst.b	Obj_Control_Var_13(A1)					 ; $0043
		bne.s	Offset_0x03E32A
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03E32A:
		rts
;-------------------------------------------------------------------------------
Offset_0x03E32C:
		dc.b	$60, $5C, $58, $54, $50, $4C, $48, $44
		dc.b	$E0, $DC, $D8, $D4, $D0, $CC, $C8, $C4
;-------------------------------------------------------------------------------
Offset_0x03E33C:
		dc.w	$FD00, $FC00, $FE00, $FC00, $FF00, $FC00, $0000, $FC00
		dc.w	$0100, $FC00, $0200, $FC00, $0300, $FC00, $0400, $FC00
;-------------------------------------------------------------------------------
Offset_0x03E35C:
		move.w	#$0278, Obj_Y(A0)				 ; $0014
		bra.w	Offset_0x03E196
;-------------------------------------------------------------------------------
Offset_0x03E366:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03E3B0
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x03E3B2
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03E386
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03E386:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03E39A
		addi.w	#$0004, D0
Offset_0x03E39A:
		bsr.w	Offset_0x03E3D4
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03E3B0
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03E3B0:
		rts
Offset_0x03E3B2:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03DEFE, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62).l, A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03E3D4:
		lea		Offset_0x03E3E6(PC), A1
		lea		Offset_0x03E3EA(PC, D0), A2
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		rts
;-------------------------------------------------------------------------------
Offset_0x03E3E6:
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
;-------------------------------------------------------------------------------
Offset_0x03E3EA:
		dc.w	$0222, $0020, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Big_Icedus_Setup_Data:						   ; Offset_0x03E3F2
		dc.l	Big_Icedus_Mappings			   ; Offset_0x1102BC
		dc.w	$A4D7, $0280
		dc.b	$18, $18, $00, $06
;-------------------------------------------------------------------------------
Big_Icedus_Setup_Data_2:					   ; Offset_0x03E3FE
		dc.w	$0280
		dc.b	$10, $0C, $01, $00
;-------------------------------------------------------------------------------
Big_Icedus_Setup_Data_3:					   ; Offset_0x03E404
		dc.l	Big_Icedus_Mappings			   ; Offset_0x1102BC
		dc.w	$44D7, $0280
		dc.b	$0C, $0C, $06, $00
;-------------------------------------------------------------------------------
Big_Icedus_Setup_Data_4:					   ; Offset_0x03E410
		dc.w	$0180
		dc.b	$0C, $0C, $0B, $00
;-------------------------------------------------------------------------------
Offset_0x03E416:
		dc.w	$0005
		dc.l	Offset_0x03DF0C
		dc.b	$F2, $F5
		dc.l	Offset_0x03DF0C
		dc.b	$0E, $F5
		dc.l	Offset_0x03DF0C
		dc.b	$00, $12
		dc.l	Offset_0x03DF0C
		dc.b	$F2, $F5
		dc.l	Offset_0x03DF0C
		dc.b	$0E, $F5
		dc.l	Offset_0x03DF0C
		dc.b	$00, $0E
;-------------------------------------------------------------------------------
Offset_0x03E43C:
		dc.w	$0007
		dc.l	Offset_0x03DF76
;-------------------------------------------------------------------------------
Offset_0x03E442:
		dc.w	$0003
		dc.l	Offset_0x03E12A
		dc.b	$F4, $F4
		dc.l	Offset_0x03E12A
		dc.b	$0C, $F4
		dc.l	Offset_0x03E12A
		dc.b	$F4, $0C
		dc.l	Offset_0x03E12A
		dc.b	$0C, $0C
;-------------------------------------------------------------------------------
; Offset_0x03E45C:
		dc.b	$00, $03, $01, $03, $02, $03, $03, $03
		dc.b	$04, $03, $05, $03, $06, $03, $F4, $00
;-------------------------------------------------------------------------------
Big_Icedus_Palette:							   ; Offset_0x03E46C
		dc.w	$0000, $0EEE, $0ECC, $086C, $062A, $00EE, $0088, $00AE
		dc.w	$006C, $006A, $0222, $0020, $0A88, $0866, $0644, $0044
;===============================================================================
; Objeto 0xB3 - Mini chefe na Icecap
; <<<-
;===============================================================================