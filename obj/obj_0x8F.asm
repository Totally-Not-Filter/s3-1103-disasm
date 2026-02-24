;===============================================================================
; Objeto 0x8F - Mini chefe da Flying Battery
; ->>>
;===============================================================================
; Offset_0x03C27C:
		lea		Offset_0x03C2AC(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C2A2(PC, D0), D1
		jsr		Offset_0x03C2A2(PC, D1)
		bsr.w	Offset_0x03CAF0
		bsr.w	Offset_0x03CCFE
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03C2A2:
		dc.w	Offset_0x03C2B4-Offset_0x03C2A2
		dc.w	Offset_0x03C300-Offset_0x03C2A2
		dc.w	Offset_0x03C320-Offset_0x03C2A2
		dc.w	Offset_0x03C348-Offset_0x03C2A2
		dc.w	Offset_0x03C35C-Offset_0x03C2A2
;-------------------------------------------------------------------------------
Offset_0x03C2AC:
		dc.w	$0440, $0600, $2D00, $2F00
;-------------------------------------------------------------------------------
Offset_0x03C2B4:
		lea		Gapsule_Setup_Data(PC), A1			   ; Offset_0x03CDA6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	(Sonic_Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE1A, $FFFFFA98
		move.w	#$0540, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$2E20, Obj_Control_Var_0A(A0)			 ; $003A
		move.l	#Offset_0x03C306, Obj_Child(A0)			 ; $0034
		moveq	#$5E, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Gapsule_Palette(PC), A1		   ; Offset_0x03CE5E
		jsr		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
		lea		Offset_0x03CDF4(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03C300:
		jmp		(Update_Sonic_Level_Limits_X_Y)		   ; Offset_0x0433B8
;-------------------------------------------------------------------------------
Offset_0x03C306:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		addi.w	#$0040, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		rts
;-------------------------------------------------------------------------------
Offset_0x03C320:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03C32A
		rts
Offset_0x03C32A:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03C34C, Obj_Child(A0)			 ; $0034
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03C346:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C348:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C34C:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(Play_Music).l					 ; Offset_0x001176
		rts
;-------------------------------------------------------------------------------
Offset_0x03C35C:
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03C346
		lea		Offset_0x03CE26(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03C36C:
		jsr		(Obj_Load_End_Level_Art)			   ; Offset_0x043302
		lea		Offset_0x03CE2E(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		lea		Offset_0x03CE34(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x0439B2(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03C38A:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C3A2(PC, D0), D1
		jsr		Offset_0x03C3A2(PC, D1)
		bsr.w	Offset_0x03CB00
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x03C3A2:
		dc.w	Offset_0x03C3A6-Offset_0x03C3A2
		dc.w	Offset_0x03C3B6-Offset_0x03C3A2
;-------------------------------------------------------------------------------
Offset_0x03C3A6:
		lea		Gapsule_Setup_Data_8(PC), A1		   ; Offset_0x03CDD6
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Y(A0), Obj_Control_Var_0E(A0)		  ; $0014, $003E
		rts
;-------------------------------------------------------------------------------
Offset_0x03C3B6:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03C3F0
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		btst	#$03, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x03C3E2
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C3E2
		bclr	#$00, Obj_Control_Var_08(A1)			 ; $0038
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x03C3E2:
		bset	#$00, Obj_Control_Var_08(A1)			 ; $0038
		addq.w	#$04, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x03C3F0:
		move.l	#Offset_0x03C410, (A0)
		move.l	#Egg_Prison_Mappings, Obj_Map(A0) ; Offset_0x043A34, $000C
		move.w	#$844E, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$05, Obj_Map_Id(A0)					 ; $0022
		addq.w	#$08, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03C410:
		bsr.w	Offset_0x03CB00
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x03C41A:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C42C(PC, D0), D1
		jsr		Offset_0x03C42C(PC, D1)
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03C42C:
		dc.w	Offset_0x03C434-Offset_0x03C42C
		dc.w	Offset_0x03C43C-Offset_0x03C42C
		dc.w	Offset_0x03C460-Offset_0x03C42C
		dc.w	Offset_0x03C46C-Offset_0x03C42C
;-------------------------------------------------------------------------------
Offset_0x03C434:
		lea		Gapsule_Setup_Data_6(PC), A1		   ; Offset_0x03CDCA
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x03C43C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C44A
		rts
Offset_0x03C44A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C464, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C460:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C464:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03C46C:
		btst	#$02, (Vint_runcount+$03).w		  ; $FFFFFE0F
		jsr		Find_Player_Eight_Way(PC)			   ; Offset_0x042DC2
		addi.w	#$0009, D4
		move.b	D4, Obj_Map_Id(A0)				 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x03C480:
		lea		Gapsule_Setup_Data_7(PC), A1		   ; Offset_0x03CDD0
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03C4B2, (A0)
		move.w	#$0EEE, (Palette_Row_1_Offset+$1E).w		 ; $FFFFED3E
		lea		(Gapsule_Palette_Rotation_Script).l, A1	 ; Offset_0x03CE7E
		lea		(Palette_Rotation_Data).w, A2		 ; $FFFFFADE
		move.l	(A1)+, (A2)+
		move.l	(A1)+, (A2)+
		clr.w	(A2)
		move.l	#Go_Delete_Object_A0, (Palette_Rotation_Custom).w ; Offset_0x042D3E, $FFFFFADA
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03C4B2:
		jsr		Run_Palette_Rotation_Script(PC)		   ; Offset_0x043196
;-------------------------------------------------------------------------------
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03C4BC:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C4CE(PC, D0), D1
		jsr		Offset_0x03C4CE(PC, D1)
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03C4CE:
		dc.w	Offset_0x03C4D6-Offset_0x03C4CE
		dc.w	Offset_0x03C4EC-Offset_0x03C4CE
		dc.w	Offset_0x03C50C-Offset_0x03C4CE
		dc.w	Offset_0x03C51E-Offset_0x03C4CE
;-------------------------------------------------------------------------------
Offset_0x03C4D6:
		lea		Gapsule_Setup_Data_2(PC), A1		   ; Offset_0x03CDB2
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$01, D0
		addq.b	#$01, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x03C4EC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C4FA
		rts
Offset_0x03C4FA:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03C516, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x03CB10
;-------------------------------------------------------------------------------
Offset_0x03C50C:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C516:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03C51E:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C520:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C538(PC, D0), D1
		jsr		Offset_0x03C538(PC, D1)
		bsr.w	Offset_0x03CD86
		jmp		(DisplaySprite)				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03C538:
		dc.w	Offset_0x03C54E-Offset_0x03C538
		dc.w	Offset_0x03C57C-Offset_0x03C538
		dc.w	Offset_0x03C59A-Offset_0x03C538
		dc.w	Offset_0x03C5BC-Offset_0x03C538
		dc.w	Offset_0x03C59A-Offset_0x03C538
		dc.w	Offset_0x03C640-Offset_0x03C538
		dc.w	Offset_0x03C6D8-Offset_0x03C538
		dc.w	Offset_0x03C59A-Offset_0x03C538
		dc.w	Offset_0x03C718-Offset_0x03C538
		dc.w	Offset_0x03C724-Offset_0x03C538
		dc.w	Offset_0x03C59A-Offset_0x03C538
;-------------------------------------------------------------------------------
Offset_0x03C54E:
		lea		Gapsule_Setup_Data_3(PC), A1		   ; Offset_0x03CDB8
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	#$FEC0, D0
		subi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03C570
		neg.w	D0
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
Offset_0x03C570:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FF30, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03C57C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C58A
		rts
Offset_0x03C58A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03C59E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C59A:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C59E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C5C6, Obj_Child(A0)			 ; $0034
		lea		Offset_0x03CE20(PC), A2
		jmp		(Load_Child_Object_Link_List_Repeat_A2).l ; Offset_0x041EA0
;-------------------------------------------------------------------------------
Offset_0x03C5BC:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C5C6:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C5E2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C5E2:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C648, Obj_Child(A0)			 ; $0034
		move.b	#$A0, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03C63E
		move.b	#$60, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$FE, Obj_Control_Var_10(A0)			 ; $0040
Offset_0x03C63E:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C640:
		bsr.w	Offset_0x03CB5C
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C648:
		move.w	#$00F0, Obj_Timer(A0)					 ; $002E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03C684
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03C346
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Control_Var_08(A1)			 ; $0038
		rts
Offset_0x03C684:
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03C346
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		tst.b	Obj_Control_Var_10(A2)					 ; $0040
		bne.w	Offset_0x03C346
		move.w	Obj_X(A2), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcc.s	Offset_0x03C6AE
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03C6B8
		rts
Offset_0x03C6AE:
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.w	Offset_0x03C346
Offset_0x03C6B8:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03C6D8:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03C6E4
		bra.w	Offset_0x03CB9A
Offset_0x03C6E4:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C700, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C700:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$02, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03C718:
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x03C5E2
		rts
;-------------------------------------------------------------------------------
Offset_0x03C724:
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03C72E
		rts
Offset_0x03C72E:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C744, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C744:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03C752:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C764
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03C764:
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03C77C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03C792(PC, D0), D1
		jsr		Offset_0x03C792(PC, D1)
		bsr.w	Offset_0x03CD86
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03C792:
		dc.w	Offset_0x03C7B2-Offset_0x03C792
		dc.w	Offset_0x03C802-Offset_0x03C792
		dc.w	Offset_0x03C856-Offset_0x03C792
		dc.w	Offset_0x03C88A-Offset_0x03C792
		dc.w	Offset_0x03C8D2-Offset_0x03C792
		dc.w	Offset_0x03C8E6-Offset_0x03C792
		dc.w	Offset_0x03C948-Offset_0x03C792
		dc.w	Offset_0x03C96E-Offset_0x03C792
		dc.w	Offset_0x03C99E-Offset_0x03C792
		dc.w	Offset_0x03C9AA-Offset_0x03C792
		dc.w	Offset_0x03C9BA-Offset_0x03C792
		dc.w	Offset_0x03C9D6-Offset_0x03C792
		dc.w	Offset_0x03CA04-Offset_0x03C792
		dc.w	Offset_0x03CA2A-Offset_0x03C792
		dc.w	Offset_0x03CA66-Offset_0x03C792
		dc.w	Offset_0x03CA9E-Offset_0x03C792
;-------------------------------------------------------------------------------
Offset_0x03C7B2:
		addq.b	#$02, Obj_Subtype(A0)					 ; $002C
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03C7CC
		lea		Gapsule_Setup_Data_4(PC), A1		   ; Offset_0x03CDBE
		move.w	#$0004, Obj_Control_Var_0E(A0)			 ; $003E
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
Offset_0x03C7CC:
		lea		Gapsule_Setup_Data_5(PC), A1		   ; Offset_0x03CDC4
		move.w	#$0003, Obj_Control_Var_0E(A0)			 ; $003E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.b	#$86, Obj_Col_Flags(A0)					 ; $0028
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	A1, Obj_Height_3(A0)					 ; $0044
		move.w	A1, Obj_Child_Data(A1)					 ; $0030
		move.w	A0, Obj_Control_Var_02(A1)				 ; $0032
		rts
;-------------------------------------------------------------------------------
Offset_0x03C802:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C814
		rts
Offset_0x03C814:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bsr.w	Offset_0x03CB3C
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C860, Obj_Child(A0)			 ; $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Data(A1), Obj_Child_Data(A0)	  ; $0030, $0030
		move.w	Obj_Control_Var_02(A1), Obj_Control_Var_02(A0) ; $0032, $0032
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x03C854
		bset	#$00, Obj_Flags(A0)				 ; $0004
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03C854:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C856:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C860:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03C888
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
Offset_0x03C888:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C88A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C898
		rts
Offset_0x03C898:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
		move.b	Obj_Control_Var_10(A1), Obj_Control_Var_10(A0) ; $0040, $0040
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.b	D0, D0
		move.b	D0, Obj_Control_Var_0B(A0)				 ; $003B
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x03C8D2:
		subq.b	#$01, Obj_Control_Var_0B(A0)			 ; $003B
		bpl.s	Offset_0x03C8DE
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
Offset_0x03C8DE:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03C8E6:
		bsr.w	Offset_0x03CB5C
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C908
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C91C
		rts
Offset_0x03C908:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
Offset_0x03C91C:
		move.b	#$18, Obj_Routine(A0)					 ; $0005
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03C946
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_X(A1), Obj_Child_Data(A0)			  ; $0010, $0030
		move.w	Obj_Y(A1), Obj_Control_Var_02(A0)		  ; $0014, $0032
Offset_0x03C946:
		rts
;-------------------------------------------------------------------------------
Offset_0x03C948:
		bsr.w	Offset_0x03CB9A
		beq.s	Offset_0x03C966
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03C966
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$03, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x03C966:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03C96E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03C982
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
Offset_0x03C982:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C9A2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03C99E:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03C9A2:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03C9AA:
		move.b	#$14, D4
		bsr.w	Offset_0x03CBC4
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03C9BA:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03C9C8
		rts
Offset_0x03C9C8:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03C9D6:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03C898
		bsr.w	Offset_0x03CC32
		beq.s	Offset_0x03C9FC
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03C9FC
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$02, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x03C9FC:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03CA04:
		bsr.w	Offset_0x03CC5C
		beq.s	Offset_0x03CA22
		move.b	#$1A, Obj_Routine(A0)					 ; $0005
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03CA22
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$03, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x03CA22:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03CA2A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03CA3E
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
Offset_0x03CA3E:
		move.b	#$1C, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CA80, Obj_Child(A0)			 ; $0034
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.w	Offset_0x03C346
		bra.w	Offset_0x03CC86
;-------------------------------------------------------------------------------
Offset_0x03CA66:
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03CA76
		bsr.w	Offset_0x03CCA4
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x03CA76:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03CA80:
		move.b	#$1E, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CAA2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03CA96:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03CA9E:
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x03CAA2:
		move.b	#$1C, Obj_Routine(A0)					 ; $0005
		neg.w	Obj_Speed_X(A0)					 ; $0018
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CA96, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03CAC0:
		move.l	#Offset_0x03CACE, (A0)
		lea		Gapsule_Setup_Data_A(PC), A1		   ; Offset_0x03CDE8
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x03CACE:
		bsr.w	Offset_0x03CAF0
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.s	Offset_0x03CAEA
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03CAEA:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x03CAF0:
		moveq	#$23, D1
		moveq	#$20, D2
		moveq	#$1C, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object)				   ; Offset_0x013556
Offset_0x03CB00:
		moveq	#$13, D1
		moveq	#$10, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
Offset_0x03CB10:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03CB2A(PC, D0), Obj_Timer(A0)			 ; $002E
		add.w	D0, D0
		lea		Offset_0x03CB30(PC, D0), A1
		move.w	(A1)+, D1
		move.w	(A1)+, $00(A0, D1)
		rts
;-------------------------------------------------------------------------------
Offset_0x03CB2A:
		dc.w	$0020, $0020, $0040
;-------------------------------------------------------------------------------
Offset_0x03CB30:
		dc.w	$0018, $FFC0, $0018, $0040, $001A, $0040
;-------------------------------------------------------------------------------
Offset_0x03CB3C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03CB50-$02(PC, D0), D0
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03CB50:
		dc.w	$FF40, $FE80, $FDC0, $FD00, $FC40, $FAD0
;-------------------------------------------------------------------------------
Offset_0x03CB5C:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		moveq	#$00, D1
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03CB6C
		addq.w	#$02, D1
Offset_0x03CB6C:
		move.b	Obj_Control_Var_10(A0), D2				 ; $0040
		bmi.s	Offset_0x03CB7E
		move.b	Offset_0x03CB96(PC, D1), D3
		cmp.b	D3, D0
		bcc.s	Offset_0x03CB88
		bra.w	Offset_0x03CB8A
Offset_0x03CB7E:
		addq.w	#$01, D1
		move.b	Offset_0x03CB96(PC, D1), D3
		cmp.b	D3, D0
		bhi.s	Offset_0x03CB8A
Offset_0x03CB88:
		neg.b	D2
Offset_0x03CB8A:
		move.b	D2, Obj_Control_Var_10(A0)				 ; $0040
		add.b	D2, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x03CB96:
		dc.b	$B0, $80, $80, $50
;-------------------------------------------------------------------------------
Offset_0x03CB9A:
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x03CBB4
		addq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#-$40, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bhi.s	Offset_0x03CBC0
Offset_0x03CBAE:
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
Offset_0x03CBB4:
		subq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#$40, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcc.s	Offset_0x03CBAE
Offset_0x03CBC0:
		moveq	#$00, D0
		rts
Offset_0x03CBC4:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Control_Var_10(A1), D2				 ; $0040
		move.b	D2, Obj_Control_Var_10(A0)				 ; $0040
		lsr.w	#$01, D1
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x03CBF2
		move.b	Offset_0x03CC28-$01(PC, D1), D3
		sub.b	D2, D0
		cmp.b	D3, D0
		bls.s	Offset_0x03CBFC
		bra.w	Offset_0x03CC22
Offset_0x03CBF2:
		move.b	Offset_0x03CC2C(PC, D1), D3
		add.b	D2, D0
		cmp.b	D3, D0
		bcs.s	Offset_0x03CC22
Offset_0x03CBFC:
		move.b	D3, D0
		move.b	D4, Obj_Routine(A0)				 ; $0005
		addq.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03CC22
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		bset	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bset	#$06, Obj_Control_Var_0A(A1)			 ; $003A
Offset_0x03CC22:
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x03CC28:
		dc.b	$A0, $88, $60, $48
;-------------------------------------------------------------------------------
Offset_0x03CC2C:
		dc.b	$38, $60, $78, $90, $B8, $CC
;-------------------------------------------------------------------------------
Offset_0x03CC32:
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x03CC4C
		addq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#-$60, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bhi.s	Offset_0x03CC58
Offset_0x03CC46:
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
Offset_0x03CC4C:
		subq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#$60, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcc.s	Offset_0x03CC46
Offset_0x03CC58:
		moveq	#$00, D0
		rts
;-------------------------------------------------------------------------------
Offset_0x03CC5C:
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x03CC76
		subq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#-$80, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcs.s	Offset_0x03CC82
Offset_0x03CC70:
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
Offset_0x03CC76:
		addq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#-$80, D0
		cmp.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bcs.s	Offset_0x03CC70
Offset_0x03CC82:
		moveq	#$00, D0
		rts
;-------------------------------------------------------------------------------
Offset_0x03CC86:
		move.w	Obj_Child_Data(A0), D0					 ; $0030
		sub.w	Obj_X(A0), D0					 ; $0010
		lsl.w	#$03, D0
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		sub.w	Obj_Y(A0), D0					 ; $0014
		lsl.w	#$03, D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03CCA4:
		move.w	Obj_Control_Var_02(A0), A1				 ; $0032
		move.w	Obj_Child_Data(A0), A2					 ; $0030
		moveq	#$00, D2
		move.b	Obj_Subtype(A0), D2				 ; $002C
		lsr.w	#$01, D2
		moveq	#$00, D0
		move.w	Obj_X(A1), D0					 ; $0010
		move.w	Obj_X(A2), D3					 ; $0010
		sub.w	D3, D0
		smi		D1
		bpl.s	Offset_0x03CCC6
		neg.w	D0
Offset_0x03CCC6:
		divu.w	#$0005, D0
		mulu.w	D2, D0
		tst.b	D1
		beq.s	Offset_0x03CCD2
		neg.w	D0
Offset_0x03CCD2:
		add.w	D0, D3
		move.w	D3, Obj_X(A0)					 ; $0010
		moveq	#$00, D0
		move.w	Obj_Y(A1), D0					 ; $0014
		move.w	Obj_Y(A2), D3					 ; $0014
		sub.w	D3, D0
		smi		D1
		bpl.s	Offset_0x03CCEA
		neg.w	D0
Offset_0x03CCEA:
		divu.w	#$0005, D0
		mulu.w	D2, D0
		tst.b	D1
		beq.s	Offset_0x03CCF6
		neg.w	D0
Offset_0x03CCF6:
		add.w	D0, D3
		move.w	D3, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03CCFE:
		btst	#$06, Obj_Control_Var_0A(A0)			 ; $003A
		beq.s	Offset_0x03CD44
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03CD20
		subq.b	#$01, Obj_Boss_Hit(A0)					 ; $0029
		beq.s	Offset_0x03CD46
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03CD20:
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03CD2C
		addq.w	#$08, D0
Offset_0x03CD2C:
		lea		Offset_0x03CD6E(PC), A1
		lea		Offset_0x03CD76(PC, D0), A2
		jsr		Move_0x08_Bytes_A2_A1(PC)			   ; Offset_0x04325C
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03CD44
		bclr	#$06, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x03CD44:
		rts
Offset_0x03CD46:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03C36C, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03CD6E:
		dc.w	(Palette_Row_1_Offset+$04)				 ; $ED24
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1E)				 ; $ED3E
;-------------------------------------------------------------------------------
Offset_0x03CD76:
		dc.w	$0222, $0644, $0020, $0020, $0AAA, $0AAA, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Offset_0x03CD86:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03CD94
		rts
Offset_0x03CD94:
		move.l	#Offset_0x03C752, (A0)
		bset	#$07, Obj_Status(A0)					 ; $002A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		rts
;-------------------------------------------------------------------------------
Gapsule_Setup_Data:							   ; Offset_0x03CDA6
		dc.l	Gapsule_Mappings			   ; Offset_0x10DAE2
		dc.w	$A52E, $0200
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_2:						   ; Offset_0x03CDB2
		dc.w	$0100
		dc.b	$08, $08, $01, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_3:						   ; Offset_0x03CDB8
		dc.w	$0300
		dc.b	$18, $10, $05, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_4:						   ; Offset_0x03CDBE
		dc.w	$0280
		dc.b	$08, $08, $06, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_5:						   ; Offset_0x03CDC4
		dc.w	$0200
		dc.b	$18, $18, $07, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_6:						   ; Offset_0x03CDCA
		dc.w	$0100
		dc.b	$10, $08, $08, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_7:						   ; Offset_0x03CDD0
		dc.w	$0180
		dc.b	$10, $08, $11, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_8:						   ; Offset_0x03CDD6
		dc.w	$0280
		dc.b	$10, $08, $04, $00
;-------------------------------------------------------------------------------
; Gapsule_Setup_Data_9:							 ; Offset_0x03CDDC
		dc.l	Egg_Prison_Mappings			   ; Offset_0x043A34
		dc.w	$84D7, $0100
		dc.b	$08, $08, $00, $00
;-------------------------------------------------------------------------------
Gapsule_Setup_Data_A:						   ; Offset_0x03CDE8
		dc.l	Egg_Prison_Mappings			   ; Offset_0x043A34
		dc.w	$844E, $0200
		dc.b	$20, $20, $01, $00
;-------------------------------------------------------------------------------
Offset_0x03CDF4:
		dc.w	$0006
		dc.l	Offset_0x03C4BC
		dc.b	$F0, $F8
		dc.l	Offset_0x03C4BC
		dc.b	$10, $F8
		dc.l	Offset_0x03C4BC
		dc.b	$00, $F8
		dc.l	Offset_0x03C38A
		dc.b	$00, $D8
		dc.l	Offset_0x03C41A
		dc.b	$00, $F8
		dc.l	Offset_0x03C520
		dc.b	$00, $00
		dc.l	Offset_0x03C520
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03CE20:
		dc.w	$0004
		dc.l	Offset_0x03C77C
;-------------------------------------------------------------------------------
Offset_0x03CE26:
		dc.w	$0000
		dc.l	Offset_0x03C480
		dc.b	$00, $F8
;-------------------------------------------------------------------------------
Offset_0x03CE2E:
		dc.w	$0000
		dc.l	Offset_0x03CAC0
;-------------------------------------------------------------------------------
Offset_0x03CE34:
		dc.w	$0004
		dc.l	Offset_0x043700
		dc.b	$00, $FC
		dc.l	Offset_0x043700
		dc.b	$10, $FC
		dc.l	Offset_0x043700
		dc.b	$F0, $FC
		dc.l	Offset_0x043700
		dc.b	$1C, $FC
		dc.l	Offset_0x043700
		dc.b	$E4, $FC
;-------------------------------------------------------------------------------
; Offset_0x03CE54:
		dc.b	$03, $09, $0A, $0B, $0C, $0D, $0E, $0F
		dc.b	$10, $FC
;-------------------------------------------------------------------------------
Gapsule_Palette:							   ; Offset_0x03CE5E
		dc.w	$0000, $0EEE, $0222, $0A88, $0644, $00EE, $0088, $0008
		dc.w	$00AE, $008E, $046A, $0020, $0ECC, $0CAA, $0866, $0044
;-------------------------------------------------------------------------------
Gapsule_Palette_Rotation_Script:					   ; Offset_0x03CE7E
		dc.w	$0004, $0000
		dc.l	Offset_0x03CE88
		dc.w	$0000
Offset_0x03CE88
		dc.w   (Palette_Row_1_Offset+$1E)				 ; $ED3E
		dc.w	$0006, $0EEE
		dc.w	$0000, $0644
		dc.w	$0003, $FFF4
;===============================================================================
; Objeto 0x8F - Mini chefe da Flying Battery
; <<<-
;===============================================================================