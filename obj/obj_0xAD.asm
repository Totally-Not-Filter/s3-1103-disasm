;===============================================================================
; Objeto 0xAD - Mini chefe da Hydrocity 1
; ->>>
;===============================================================================
; Offset_0x037E2C:
		lea		Offset_0x037E54(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		move.l	#Offset_0x037E5C, (A0)
		move.w	#$0300, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		moveq	#$5B, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Offset_0x038A1E(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x037E54:
		dc.w	$0300, $0400, $3500, $3700
;-------------------------------------------------------------------------------
Offset_0x037E5C:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x037E80
		move.w	#$0638, D0
		cmp.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		bhi.s	Offset_0x037E80
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.w	D0, (Sonic_Level_Limits_Min_Y).w			 ; $FFFFEE18
		move.w	D0, (Sonic_Level_Limits_Max_Y).w			 ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w			 ; $FFFFEE12
Offset_0x037E80:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$3680, D0
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		move.w	D1, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		cmp.w	D1, D0
		bhi.s	Offset_0x037EA4
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
Offset_0x037EA4:
		cmpi.b	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x037EAE
		rts
Offset_0x037EAE:
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	Obj_Y(A0), Obj_Height_3(A0)		  ; $0014, $0044
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037EEC, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		lea		Pal_Hz_Big_Shaker(PC), A1			   ; Offset_0x038AF4
		jmp		(Pal_Load_Line_1).l			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x037EEC:
		move.l	#Offset_0x037EFC, (A0)
		moveq	#Boss_Snd, D0					   ; $19
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x037EFA:
		rts
;-------------------------------------------------------------------------------
Offset_0x037EFC:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x037F14(PC, D0), D1
		jsr		Offset_0x037F14(PC, D1)
		bsr.w	Offset_0x0388F4
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x037F14:
		dc.w	Offset_0x037F2C-Offset_0x037F14
		dc.w	Offset_0x037F66-Offset_0x037F14
		dc.w	Offset_0x037F8C-Offset_0x037F14
		dc.w	Offset_0x037F66-Offset_0x037F14
		dc.w	Offset_0x037F8C-Offset_0x037F14
		dc.w	Offset_0x037FF8-Offset_0x037F14
		dc.w	Offset_0x038044-Offset_0x037F14
		dc.w	Offset_0x03807A-Offset_0x037F14
		dc.w	Offset_0x038092-Offset_0x037F14
		dc.w	Offset_0x0380DC-Offset_0x037F14
		dc.w	Offset_0x037F8C-Offset_0x037F14
		dc.w	Offset_0x038190-Offset_0x037F14
;-------------------------------------------------------------------------------
Offset_0x037F2C:
		lea		Big_Shaker_Setup_Data(PC), A1		   ; Offset_0x0389A0
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$28, Obj_Height_2(A0)					 ; $001E
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0100, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00DF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037F72, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0389FE(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x037F66:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x037F72:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037F92, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037F8C:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x037F92:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0037, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037FAE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037FAE:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037FC4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037FC4:
		bsr.w	Offset_0x03877E
Offset_0x037FC8:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		moveq	#Rolling_Sfx, D0				   ; $3C
		jsr		(PlaySound).l					; Offset_0x001176
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0400, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0047, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03801A, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037FF8:
		btst	#$07, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03800E
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		bcs.s	Offset_0x03800E
		bsr.w	Offset_0x038762
Offset_0x03800E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x03801A:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Control_Var_10(A0), Obj_Speed_X(A0)	  ; $0040, $0018
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03805A, Obj_Child(A0)			 ; $0034
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x038044:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		add.w	D1, Obj_Y(A0)					 ; $0014
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03805A:
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		clr.w	Obj_Speed_X(A0)					 ; $0018
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x038072
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		rts
Offset_0x038072:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03807A:
		bsr.w	Offset_0x03874C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Height_3(A0), D0					 ; $0044
		bls.w	Offset_0x037FC8
		rts
;-------------------------------------------------------------------------------
Offset_0x038092:
		bsr.w	Offset_0x03874C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Height_3(A0), D0					 ; $0044
		addi.w	#$0108, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x0380AC
		rts
Offset_0x0380AC:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	#$0180, D0
		tst.w	Obj_Control_Var_10(A0)					 ; $0040
		bpl.s	Offset_0x0380C8
		neg.w	D0
Offset_0x0380C8:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0380EE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0380DC:
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0380EE:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		moveq	#Door_Close_Sfx, D0				  ; -$56
		jsr		(PlaySound).l					; Offset_0x001176
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038116, Obj_Child(A0)			 ; $0034
		clr.w	Obj_Speed_X(A0)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x038116:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$017F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03812C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03812C:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038142, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x038142:
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038142, Obj_Child(A0)			 ; $0034
		move.l	#Offset_0x038160, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x038160:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$FFE0, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03817C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03817C:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x038190:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Height_3(A0), D0					 ; $0044
		bls.w	Offset_0x037FC4
		rts
;-------------------------------------------------------------------------------
Offset_0x0381A4:
		jsr		(Obj_Load_End_Level_Art).l			   ; Offset_0x043302
		lea		Offset_0x038A48(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0381B4:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0381CA(PC, D0), D1
		jsr		Offset_0x0381CA(PC, D1)
		moveq	#$20, D0
		jmp		(Child_Display_Touch_Or_Flicker_Move).l  ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x0381CA:
		dc.w	Offset_0x0381D8-Offset_0x0381CA
		dc.w	Offset_0x0381F2-Offset_0x0381CA
		dc.w	Offset_0x03824C-Offset_0x0381CA
		dc.w	Offset_0x03826C-Offset_0x0381CA
		dc.w	Offset_0x03827A-Offset_0x0381CA
		dc.w	Offset_0x0382F6-Offset_0x0381CA
		dc.w	Offset_0x038310-Offset_0x0381CA
;-------------------------------------------------------------------------------
Offset_0x0381D8:
		lea		Big_Shaker_Setup_Data_2(PC), A1		   ; Offset_0x0389AC
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x038A26(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0381F2:
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.w	Offset_0x037EFA
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$8B, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038256, Obj_Child(A0)			 ; $0034
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x038244(PC, D0), Obj_Control_Var_0C(A0)	 ; $003C
		cmpi.b	#$04, D0
		bcs.s	Offset_0x038242
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.b	#$06, Obj_Routine(A0)					 ; $0005
Offset_0x038242:
		rts
;-------------------------------------------------------------------------------
Offset_0x038244:
		dc.w	$0000, $8080, $8000, $0080
;-------------------------------------------------------------------------------
Offset_0x03824C:
		bsr.w	Offset_0x0387C6
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x038256:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038284, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03826C:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x038272:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03827A:
		bsr.w	Offset_0x0387C6
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x038284:
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03829A, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03829A:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		move.l	#Offset_0x038308, Obj_Child(A0)			 ; $0034
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0382B6:
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0382CC, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0382CC:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		cmpi.b	#$04, Obj_Subtype(A0)					 ; $002C
		bcs.s	Offset_0x0382E0
		move.b	#$04, Obj_Routine(A0)					 ; $0005
Offset_0x0382E0:
		move.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038272, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0382F6:
		bsr.w	Offset_0x0387C6
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x037EFA
Offset_0x038308:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x038310:
		bsr.w	Offset_0x0387C6
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$01, D0
		move.b	Offset_0x03834A(PC, D0), D1
		cmp.b	Obj_Control_Var_0C(A0), D1				 ; $003C
		beq.s	Offset_0x038328
		rts
Offset_0x038328:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	#$02, Obj_Control_Var_10(A0)			 ; $0040
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0382B6, Obj_Child(A0)			 ; $0034
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03834A:
		dc.b	$80, $00, $C0, $40
;-------------------------------------------------------------------------------
Offset_0x03834E:
		lea		Offset_0x0389B8(PC), A1
		jsr		(SetupObjectAttributes2)			; Offset_0x041D76
		move.l	#Offset_0x038360, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x038360:
		bsr.w	Offset_0x038854
Offset_0x038364:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03838A
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x037EFA
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.w	Offset_0x037EFA
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
Offset_0x03838A:
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x038390:
		lea		Offset_0x0389C0(PC), A1
		jsr		(SetupObjectAttributes2).l			; Offset_0x041D76
		move.l	#Offset_0x0383A2, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x0383A2:
		jsr		(Refresh_Child_Position).l			   ; Offset_0x042016
		bra.s	Offset_0x038364
;-------------------------------------------------------------------------------
Offset_0x0383AA:
		lea		Offset_0x0389E0(PC), A1
		jsr		(SetupSlottedObjectAttributes).l		; Offset_0x04298C
		move.w	(Water_Level_Move).w, Obj_Y(A0)		  ; $FFFFF646, $0014
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0383CC
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
Offset_0x0383CC:
		move.l	#Offset_0x0383D6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0383D6:
		move.l	#Offset_0x0383E6, (A0)
		move.l	#Go_Delete_Slotted_3, Obj_Child(A0) ; Offset_0x042C42, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0383E6:
		lea		Offset_0x038AD9(PC), A1
		jsr		(Animate_Raw_A1).l			   ; Offset_0x042092
		lea		Big_Shaker_Splash_PLC_Data(PC), A2	   ; Offset_0x038A82
		jsr		(LoadDynamicPLC).l		  ; Offset_0x042A0A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x038400:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x038418(PC, D0), D1
		jsr		Offset_0x038418(PC, D1)
		bsr.w	Offset_0x038614
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x038418:
		dc.w	Offset_0x038422-Offset_0x038418
		dc.w	Offset_0x03843C-Offset_0x038418
		dc.w	Offset_0x03846A-Offset_0x038418
		dc.w	Offset_0x038498-Offset_0x038418
		dc.w	Offset_0x0384D0-Offset_0x038418
;-------------------------------------------------------------------------------
Offset_0x038422:
		lea		Offset_0x0389C8(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		addi.w	#$0148, Obj_Y(A0)				 ; $0014
		clr.w	Obj_Control_Var_12(A0)					 ; $0042
		clr.w	Obj_Height_3(A0)				 ; $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x03843C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.w	Offset_0x037EFA
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x038A8A, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x038474, Obj_Child(A0)			 ; $0034
		lea		Offset_0x038A42(PC), A2
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x03846A:
		lea		Offset_0x038A8A(PC), A1
		jmp		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
;-------------------------------------------------------------------------------
Offset_0x038474:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		moveq	#Fan_Big_Sfx, D0				   ; $5E
		jsr		(PlaySound).l					; Offset_0x001176
		move.l	#Offset_0x038A8A, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0384DA, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Boss_Hit(A0)				 ; $0029
		rts
;-------------------------------------------------------------------------------
Offset_0x038498:
		bsr.w	Offset_0x03866C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0384B2
		lea		Offset_0x038AAF(PC), A1
		jmp		(Animate_Raw_A1)			   ; Offset_0x042092
Offset_0x0384B2:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x0384DA, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x03863A
		jmp		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x0384D0:
		lea		Offset_0x038AB4(PC), A1
		jmp		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
;-------------------------------------------------------------------------------
Offset_0x0384DA:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$16, Obj_Map_Id(A0)					 ; $0022
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0384EE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03850A
		lea		Offset_0x038A62(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		jsr		(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
Offset_0x03850A:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x038510:
		lea		Offset_0x0389D4(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x03856C, (A0)
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$00FF, D0
		ext.w	D0
		add.w	D0, Obj_X(A0)					 ; $0010
		swap	D0
		andi.w	#$003F, D0
		subq.w	#$08, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		andi.w	#$0003, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		lsl.w	#$02, D0
		move.l	Offset_0x03855C(PC, D0), Obj_Child_Data(A0)		 ; $0030
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x038586, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03855C:
		dc.l	Offset_0x038AE4
		dc.l	Offset_0x038AE8
		dc.l	Offset_0x038AEC
		dc.l	Offset_0x038AF0
;-------------------------------------------------------------------------------
Offset_0x03856C:
		move.w	Obj_Child_Ref(A0), A3					 ; $0046
		bsr.w	Offset_0x03865E
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		jmp		(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x038586:
		move.l	#Offset_0x038598, (A0)
		move.l	Obj_Child_Data(A0), A1					 ; $0030
		move.b	$0001(A1), Obj_Map_Id(A0)				 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x038598:
		move.w	Obj_Child_Ref(A0), A3					 ; $0046
		btst	#$03, Obj_Control_Var_08(A3)			 ; $0038
		bne.s	Offset_0x0385AE
		bsr.w	Offset_0x03865E
		jmp		(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
Offset_0x0385AE:
		move.l	#Offset_0x03856C, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0385C4:
		lea		Offset_0x0389F2(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$1B, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$20, D0
		jmp		(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x0385EC:
		lea		Offset_0x0389F8(PC), A1
		jsr		(SetupObjectAttributes3)			; Offset_0x041D7A
		move.l	#ObjectFall_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB6
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addi.b	#$1F, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$1C, D0
		jmp		(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x038614:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x037EFA
		move.l	#Offset_0x0384EE, (A0)
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.w	Offset_0x037EFA
		bra.w	Offset_0x03863A
Offset_0x03863A:
		move.w	Obj_Control_Var_12(A0), D0				 ; $0042
		beq.s	Offset_0x038644
		bsr.w	Offset_0x03864A
Offset_0x038644:
		move.w	Obj_Height_3(A0), D0					 ; $0044
		beq.s	Offset_0x03865C
Offset_0x03864A:
		move.w	D0, A2
		bset	#$01, Obj_Status(A2)					 ; $002A
		clr.b	Obj_Timer(A2)					 ; $002E
		move.w	#$0100, Obj_Priority(A2)				 ; $0008
Offset_0x03865C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03865E:
		movea.l	A0, A1
		movea.l	A0, A2
		movea.l	A3, A0
		bsr.w	Offset_0x0386DC
		movea.l	A1, A0
		rts
;-------------------------------------------------------------------------------
Offset_0x03866C:
		clr.l	Obj_Control_Var_12(A0)					 ; $0042
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$0020, D0
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		cmp.w	Obj_Y(A2), D0					 ; $0014
		bhi.s	Offset_0x038694
		move.w	A2, Obj_Control_Var_12(A0)				 ; $0042
		bsr.w	Offset_0x0386DC
		tst.b	Obj_Timer(A2)					 ; $002E
		bne.s	Offset_0x038694
		bsr.w	Offset_0x0386AC
Offset_0x038694:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		cmp.w	Obj_Y(A2), D0					 ; $0014
		bhi.s	Offset_0x0386CE
		move.w	A2, Obj_Height_3(A0)					 ; $0044
		bsr.w	Offset_0x0386DC
		tst.b	Obj_Timer(A2)					 ; $002E
		bne.s	Offset_0x0386CE
Offset_0x0386AC:
		bset	#$01, Obj_Status(A2)					 ; $002A
		move.b	#$01, Obj_Timer(A2)				 ; $002E
		move.b	#$18, Obj_Ani_Number(A2)				 ; $0020
		clr.b	Obj_Control_Var_0D(A2)					 ; $003D
		clr.w	Obj_Speed_X(A2)					 ; $0018
		clr.w	Obj_Speed_Y(A2)					 ; $001A
		clr.w	Obj_Inertia(A2)					 ; $001C
Offset_0x0386CE:
		rts
;-------------------------------------------------------------------------------
; Offset_0x0386D0:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	$0000
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	$0000
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Obj_Player_Two					 ; $B04A
;-------------------------------------------------------------------------------
Offset_0x0386DC:
		move.w	Obj_X(A2), D0					 ; $0010
		move.w	Obj_Speed_X(A2), D1				 ; $0018
		move.w	#$0040, D2
		sub.w	Obj_X(A0), D0					 ; $0010
		scs		D3
		bcc.s	Offset_0x0386F2
		neg.w	D0
Offset_0x0386F2:
		cmpi.w	#$0003, D0
		bhi.s	Offset_0x038700
		tst.w	D1
		bpl.s	Offset_0x03870E
		bra.w	Offset_0x03870C
Offset_0x038700:
		cmpi.w	#$0070, D0
		bls.s	Offset_0x038708
		moveq	#$00, D1
Offset_0x038708:
		tst.b	D3
		bne.s	Offset_0x03870E
Offset_0x03870C:
		neg.w	D2
Offset_0x03870E:
		add.w	D2, D1
		move.w	#$0100, Obj_Priority(A2)				 ; $0008
		move.w	D1, Obj_Speed_X(A2)				 ; $0018
		bpl.s	Offset_0x038722
		move.w	#$0300, Obj_Priority(A2)				 ; $0008
Offset_0x038722:
		ext.l	D1
		lsl.l	#$08, D1
		add.l	D1, Obj_X(A2)					 ; $0010
		move.l	#$00008000, D4
		move.w	Obj_Y(A2), D5					 ; $0014
		sub.w	Obj_Y(A0), D5					 ; $0014
		cmpi.w	#$FFF0, D5
		blt.s	Offset_0x038746
		cmpi.w	#$0010, D5
		ble.s	Offset_0x03874A
		neg.l	D4
Offset_0x038746:
		add.l	D4, Obj_Y(A2)					 ; $0014
Offset_0x03874A:
		rts
;-------------------------------------------------------------------------------
Offset_0x03874C:
		btst	#$07, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x037EFA
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		bcs.w	Offset_0x037EFA
Offset_0x038762:
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#Water_Splash_Sfx, D0					   ; $39
		jsr		(PlaySound).l					; Offset_0x001176
		clr.w	(Slotted_Objects_Bits).w			 ; $FFFFFA9A
		lea		Offset_0x038A2E(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x03877E:
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		addq.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
		andi.w	#$000E, D0
		lea		Offset_0x0387B6(PC, D0), A1
		move.b	(A1)+, D0
		bne.s	Offset_0x038796
		move.w	#$0100, D0
Offset_0x038796:
		move.w	#$0400, D2
		cmpi.w	#$00A0, D0
		bcs.s	Offset_0x0387A2
		neg.w	D2
Offset_0x0387A2:
		move.w	D2, Obj_Control_Var_10(A0)				 ; $0040
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		add.w	D0, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		move.b	(A1)+, Obj_Control_Var_09(A0)			 ; $0039
		rts
;-------------------------------------------------------------------------------
Offset_0x0387B6:
		dc.b	$40, $01, $00, $01, $40, $00, $40, $01
		dc.b	$00, $00, $00, $01, $40, $00, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0387C6:
		move.b	Obj_Control_Var_10(A0), D2				 ; $0040
		add.b	D2, Obj_Control_Var_0C(A0)				 ; $003C
		bsr.w	Offset_0x03880C
		add.b	D2, Obj_Control_Var_0D(A0)				 ; $003D
		bsr.w	Offset_0x038840
		moveq	#$00, D0
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		lsr.w	#$04, D0
		move.b	Offset_0x0387FC(PC, D0), Obj_Map_Id(A0)			 ; $0022
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		cmpi.b	#$08, D0
		bcs.s	Offset_0x0387FA
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
Offset_0x0387FA:
		rts
;-------------------------------------------------------------------------------
Offset_0x0387FC:
		dc.b	$01, $02, $03, $04, $05, $06, $07, $08
		dc.b	$09, $0A, $0B, $1A, $1A, $1A, $0C, $0D
;-------------------------------------------------------------------------------
Offset_0x03880C:
		moveq	#$00, D0
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		bsr.w	Offset_0x038822
		move.w	Obj_X(A2), D0					 ; $0010
		add.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
Offset_0x038822:
		cmpi.b	#$80, D0
		bcs.s	Offset_0x03882E
		moveq	#-$01, D1
		sub.b	D0, D1
		move.b	D1, D0
Offset_0x03882E:
		lea		(Big_Shaker_Rocket_Twist_Lookup).l, A1   ; Offset_0x10F858
		move.b	(A1, D0), D1
		ext.w	D1
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		rts
;-------------------------------------------------------------------------------
Offset_0x038840:
		moveq	#$00, D0
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		bsr.s	Offset_0x038822
		move.w	Obj_Y(A2), D0					 ; $0014
		add.w	D1, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x038854:
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Control_Var_0D(A2), D0				 ; $003D
		lsr.w	#$03, D0
		andi.w	#$FFFE, D0
		move.w	Offset_0x0388A4(PC, D0), Obj_Priority(A0)		 ; $0008
		lea		Offset_0x0388C4(PC, D0), A1
		move.b	(A1)+, D1
		ext.w	D1
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x038882
		neg.w	D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x038882:
		move.b	(A1)+, D2
		ext.w	D2
		move.w	Obj_X(A2), D3					 ; $0010
		add.w	D1, D3
		move.w	D3, Obj_X(A0)					 ; $0010
		move.w	Obj_Y(A2), D3					 ; $0014
		add.w	D2, D3
		move.w	D3, Obj_Y(A0)					 ; $0014
		lsr.w	#$01, D0
		move.b	Offset_0x0388E4(PC, D0), Obj_Map_Id(A0)			 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x0388A4:
		dc.b	$02, $80, $02, $00, $02, $00, $02, $00
		dc.b	$02, $00, $01, $80, $01, $80, $01, $80
		dc.b	$01, $80, $01, $80, $01, $80, $02, $80
		dc.b	$02, $80, $02, $80, $02, $80, $02, $80
;-------------------------------------------------------------------------------
Offset_0x0388C4:
		dc.b	$03, $03, $00, $00, $06, $06, $0C, $0C
		dc.b	$12, $12, $0C, $0C, $08, $08, $00, $00
		dc.b	$03, $03, $00, $00, $00, $00, $00, $00
		dc.b	$FA, $FA, $F6, $F6, $00, $00, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0388E4:
		dc.b	$0E, $0F, $10, $11, $12, $11, $10, $0F
		dc.b	$0E, $1A, $1A, $1A, $0E, $0E, $1A, $1A
;-------------------------------------------------------------------------------
Offset_0x0388F4:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x038950
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x038952
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x038914
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x038914:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x038928
		addi.w	#$000E, D0
Offset_0x038928:
		lea		Offset_0x038976(PC), A1
		lea		Offset_0x038984(PC, D0), A2
		jsr		(Move_0x0E_Bytes_A2_A1).l		   ; Offset_0x043250
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x038950
		bclr	#$06, Obj_Status(A0)					 ; $002A
		cmpi.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x038950
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x038950:
		rts
Offset_0x038952:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0381A4, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62).l, A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x038976:
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$0E)				 ; $ED2E
		dc.w	(Palette_Row_1_Offset+$12)				 ; $ED32
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1A)				 ; $ED3A
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x038984:
		dc.w	$0004, $004E, $000A, $0006, $0020, $0EAA, $0442, $0AAA
		dc.w	$0AAA, $0888, $0AAA, $0EEE, $0888, $0AAA
;-------------------------------------------------------------------------------
Big_Shaker_Setup_Data:						   ; Offset_0x0389A0
		dc.l	Big_Shaker_Mappings			   ; Offset_0x10F958
		dc.w	$A304, $0280
		dc.b	$20, $20, $00, $0F
;-------------------------------------------------------------------------------
Big_Shaker_Setup_Data_2:					   ; Offset_0x0389AC
		dc.l	Big_Shaker_Mappings			   ; Offset_0x10F958
		dc.w	$A304, $0200
		dc.b	$10, $10, $01, $8B
;-------------------------------------------------------------------------------
Offset_0x0389B8:
		dc.w	$8304, $0280
		dc.b	$10, $10, $15, $00
;-------------------------------------------------------------------------------
Offset_0x0389C0:
		dc.w	$8304, $0280
		dc.b	$10, $10, $15, $92
;-------------------------------------------------------------------------------
Offset_0x0389C8:
		dc.l	Big_Shaker_Mappings			   ; Offset_0x10F958
		dc.w	$A304, $0280
		dc.b	$10, $28, $16, $00
;-------------------------------------------------------------------------------
Offset_0x0389D4:
		dc.l	Sonic_Underwater_Mappings			   ; Offset_0x025872
		dc.w	$A45C, $0280
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0389E0:
		dc.w	$0002, $83FC, $0010, $0000
		dc.l	Big_Shaker_Splash_Mappings			   ; Offset_0x10FB9C
		dc.w	$0080
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0389F2:
		dc.w	$0280
		dc.b	$0C, $0C, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0389F8:
		dc.w	$0280
		dc.b	$14, $24, $00, $00
;-------------------------------------------------------------------------------
Offset_0x0389FE:
		dc.w	$0004
		dc.l	Offset_0x0381B4
		dc.b	$18, $18
		dc.l	Offset_0x0381B4
		dc.b	$E8, $E8
		dc.l	Offset_0x0381B4
		dc.b	$E8, $18
		dc.l	Offset_0x0381B4
		dc.b	$18, $E8
		dc.l	Offset_0x038390
		dc.b	$00, $24
;-------------------------------------------------------------------------------
Offset_0x038A1E:
		dc.w	$0000
		dc.l	Offset_0x038400
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x038A26:
		dc.w	$0000
		dc.l	Offset_0x03834E
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x038A2E:
		dc.w	$0002
		dc.l	Offset_0x0383AA
		dc.b	$00, $00
		dc.l	Offset_0x0383AA
		dc.b	$F0, $00
		dc.l	Offset_0x0383AA
		dc.b	$10, $00
;-------------------------------------------------------------------------------
Offset_0x038A42:
		dc.w	$001D
		dc.l	Offset_0x038510
;-------------------------------------------------------------------------------
Offset_0x038A48:
		dc.w	$0003
		dc.l	Offset_0x0385C4
		dc.b	$F4, $F4
		dc.l	Offset_0x0385C4
		dc.b	$F4, $0C
		dc.l	Offset_0x0385C4
		dc.b	$0C, $F4
		dc.l	Offset_0x0385C4
		dc.b	$0C, $0C
;-------------------------------------------------------------------------------
Offset_0x038A62:
		dc.w	$0004
		dc.l	Offset_0x0385EC
		dc.b	$00, $DC
		dc.l	Offset_0x0385EC
		dc.b	$F8, $00
		dc.l	Offset_0x0385EC
		dc.b	$08, $00
		dc.l	Offset_0x0385EC
		dc.b	$F4, $30
		dc.l	Offset_0x0385EC
		dc.b	$0C, $30
;-------------------------------------------------------------------------------
Big_Shaker_Splash_PLC_Data:					   ; Offset_0x038A82
		dc.l	Art_Dust_Water_Splash		   ; Offset_0x081220
		dc.l	Big_Shaker_Splash_Dyn_Script		   ; Offset_0x10FBF6
;-------------------------------------------------------------------------------
Offset_0x038A8A:
		dc.b	$16, $07, $17, $07, $18, $07, $16, $06
		dc.b	$17, $06, $18, $06, $16, $05, $17, $05
		dc.b	$18, $05, $16, $04, $17, $04, $18, $04
		dc.b	$16, $03, $17, $03, $18, $03, $16, $02
		dc.b	$17, $02, $18, $02, $F4
;-------------------------------------------------------------------------------
Offset_0x038AAF:
		dc.b	$01, $16, $17, $18, $FC
;-------------------------------------------------------------------------------
Offset_0x038AB4:
		dc.b	$16, $02, $17, $02, $18, $02, $16, $03
		dc.b	$17, $03, $18, $03, $16, $04, $17, $04
		dc.b	$18, $04, $16, $05, $17, $05, $18, $05
		dc.b	$16, $06, $17, $06, $18, $06, $16, $07
		dc.b	$17, $07, $18, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x038AD9:
		dc.b	$03, $00, $01, $02, $03, $04, $05, $06
		dc.b	$07, $08, $F4
;-------------------------------------------------------------------------------
Offset_0x038AE4:
		dc.b	$00, $00, $16, $FC
;-------------------------------------------------------------------------------
Offset_0x038AE8:
		dc.b	$00, $01, $16, $FC
;-------------------------------------------------------------------------------
Offset_0x038AEC:
		dc.b	$00, $02, $16, $FC
;-------------------------------------------------------------------------------
Offset_0x038AF0:
		dc.b	$00, $03, $16, $FC
;-------------------------------------------------------------------------------
Pal_Hz_Big_Shaker:							   ; Offset_0x038AF4
		dc.w	$00E0, $0EEE, $00EE, $006E, $0004, $00EE, $0088, $0000
		dc.w	$004E, $000A, $0006, $0020, $0EAA, $0A64, $0442, $0044
;===============================================================================
; Objeto 0xAD - Mini chefe da Hydrocity 1
; <<<-
;===============================================================================