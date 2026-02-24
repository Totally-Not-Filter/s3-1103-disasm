;===============================================================================
; Objeto 0x8C - Robotnik atirando bolas pretas na Lauch Base 2
; ->>>
;===============================================================================
; Offset_0x03FE88:
		lea		Offset_0x03FEB6(PC), A1
		jsr		(Check_Camera_In_Range).l		   ; Offset_0x043392
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03FEA8(PC, D0), D1
		jsr		Offset_0x03FEA8(PC, D1)
		bsr.w	Offset_0x0404E2
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03FEA8:
		dc.w	Offset_0x03FEBE-Offset_0x03FEA8
		dc.w	Offset_0x03FF34-Offset_0x03FEA8
		dc.w	Offset_0x03FF50-Offset_0x03FEA8
		dc.w	Offset_0x03FF62-Offset_0x03FEA8
		dc.w	Offset_0x03FF9A-Offset_0x03FEA8
		dc.w	Offset_0x03FFC0-Offset_0x03FEA8
		dc.w	Offset_0x03FFE4-Offset_0x03FEA8
;-------------------------------------------------------------------------------
Offset_0x03FEB6:
		dc.w	$0480, $0660, $3900, $3A20
;-------------------------------------------------------------------------------
Offset_0x03FEBE:
		lea		Ball_Shooter_Setup_Data(PC), A1		   ; Offset_0x0405D2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$01, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.b	#$19, Obj_Angle(A0)				 ; $0026
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	#$05A0, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$3A20, Obj_Inertia(A0)					 ; $001C
		move.w	#$3A20, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.l	#Offset_0x03FF3A, Obj_Child(A0)			 ; $0034
		lea		Offset_0x040632(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		moveq	#$77, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		(Art_Ball_Shooter).l, A1		   ; Offset_0x1224EC
		move.w	#$84A0, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		lea		Ball_Shooter_Palette(PC), A1		   ; Offset_0x0406E4
		jmp		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03FF34:
		jmp		(Update_Sonic_Level_Limits_X_Y_Play_Music) ; Offset_0x0433DE
;-------------------------------------------------------------------------------
Offset_0x03FF3A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		lea		Offset_0x040670(PC), A2
		jsr		Load_Child_Object_Link_List_Repeat_A2(PC) ; Offset_0x041EA0
		lea		Offset_0x040640(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03FF50:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03FF5A
		rts
Offset_0x03FF5A:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
Offset_0x03FF60:
		rts
;-------------------------------------------------------------------------------
Offset_0x03FF62:
		move.w	(Sonic_Level_Limits_Min_X).w, D0			 ; $FFFFEE14
		subq.w	#$01, D0
		cmpi.w	#$39F0, D0
		bls.s	Offset_0x03FF78
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		rts
Offset_0x03FF78:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$FFC0, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$00DF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03FFA4, Obj_Child(A0)			 ; $0034
		lea		Offset_0x040648(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03FF9A:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03FFA4:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03FFAA:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03FFC4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03FFC0:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03FFC4:
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03FFDA, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03FFDA:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bra.w	Offset_0x04041E
;-------------------------------------------------------------------------------
Offset_0x03FFE4:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03FFAA
		rts
;-------------------------------------------------------------------------------
Offset_0x03FFEE:
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x040004:
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		Restore_LevelMusic(PC)			 ; Offset_0x0432CA
		move.l	#Go_Delete_Object_A0_2, (A0)		   ; Offset_0x042D4C
		rts
;-------------------------------------------------------------------------------
Offset_0x04001A:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x040048(PC, D0), D1
		jsr		Offset_0x040048(PC, D1)
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		btst	#$07, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x040044
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x040044
		bsr.w	Offset_0x0400F0
Offset_0x040044:
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x040048:
		dc.w	Offset_0x040050-Offset_0x040048
		dc.w	SpeedToPos_Wait-Offset_0x040048		   ; Offset_0x042FCE
		dc.w	Offset_0x040088-Offset_0x040048
		dc.w	Offset_0x0400B0-Offset_0x040048
;-------------------------------------------------------------------------------
Offset_0x040050:
		lea		Ball_Shooter_Setup_Data_7(PC), A1	   ; Offset_0x040610
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0406DA, Obj_Child_Data(A0)			 ; $0030
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x040078, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x040442
;-------------------------------------------------------------------------------
Offset_0x040078:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x040098, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x040088:
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x040098:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0400F0, Obj_Child(A0)			 ; $0034
		move.w	Obj_Angle(A0), D0				 ; $0026
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0400B0:
		move.w	#$0010, D3
		jsr		Run_Object_Hit_Wall_Right_A0(PC)	   ; Offset_0x042424
		jsr		Run_Object_Hit_Floor_D3_A0(PC)		   ; Offset_0x0423F8
		tst.b	D3
		beq.s	Offset_0x0400C6
		addi.w	#$0010, Obj_Speed_X(A0)					 ; $0018
Offset_0x0400C6:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		addi.w	#$0200, D0
		cmpi.w	#$0400, D0
		bcs.w	Offset_0x03FF60
		move.w	(Vint_runcount+$02).w, D0		  ; $FFFFFE0E
		andi.w	#$0003, D0
		bne.w	Offset_0x03FF60
		lea		Offset_0x04067E(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0400F0:
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		bset	#$07, Obj_Status(A0)					 ; $002A
		lea		Offset_0x040686(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x040104:
		lea		Ball_Shooter_Setup_Data_8(PC), A1	   ; Offset_0x040616
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x04013E, (A0)
		move.l	#Offset_0x0406DE, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bne.s	Offset_0x040132
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x040132:
		subi.w	#$0010, D0
		add.w	D0, D0
		neg.w	D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
Offset_0x04013E:
		addq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.w	Offset_0x03FF60
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x040156:
		lea		Ball_Shooter_Setup_Data_9(PC), A1	   ; Offset_0x04061E
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		bra.w	Offset_0x04047C
;-------------------------------------------------------------------------------
Offset_0x040168:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04017E(PC, D0), D1
		jsr		Offset_0x04017E(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x04017E:
		dc.w	Offset_0x040184-Offset_0x04017E
		dc.w	Offset_0x04019C-Offset_0x04017E
		dc.w	Offset_0x0401C2-Offset_0x04017E
;-------------------------------------------------------------------------------
Offset_0x040184:
		lea		Ball_Shooter_Setup_Data_5(PC), A1	   ; Offset_0x040602
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		addq.w	#$02, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x04019C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0401B0
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
Offset_0x0401B0:
		move.w	Obj_Timer(A0), D0				 ; $002E
		addq.w	#$01, Obj_Timer(A0)				 ; $002E
		andi.w	#$0003, D0
		sub.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0401C2:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0401D0
		rts
Offset_0x0401D0:
		lea		Offset_0x04065C(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0401D8:
		lea		Ball_Shooter_Setup_Data_6(PC), A1	   ; Offset_0x040608
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0401FE(PC, D0), Obj_Speed_X(A0)		 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0401FE:
		dc.w	$FF00, $0200, $FE00
;-------------------------------------------------------------------------------
Offset_0x040204:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x040222(PC, D0), D1
		jsr		Offset_0x040222(PC, D1)
		lea		Offset_0x03FF60(PC), A2
		bsr.w	Offset_0x0404CE
		bra.w	Offset_0x04058A
;-------------------------------------------------------------------------------
Offset_0x040222:
		dc.w	Offset_0x04022C-Offset_0x040222
		dc.w	Offset_0x040254-Offset_0x040222
		dc.w	Offset_0x040266-Offset_0x040222
		dc.w	Offset_0x04028A-Offset_0x040222
		dc.w	Offset_0x040296-Offset_0x040222
;-------------------------------------------------------------------------------
Offset_0x04022C:
		lea		Ball_Shooter_Setup_Data_A(PC), A1	   ; Offset_0x040626
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$80, Obj_Control_Var_0C(A0)			 ; $003C
		subi.w	#$0018, Obj_X(A0)				 ; $0010
		addi.w	#$0030, Obj_Y(A0)				 ; $0014
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x040252
		move.l	#Offset_0x0402B2, (A0)
Offset_0x040252:
		rts
;-------------------------------------------------------------------------------
Offset_0x040254:
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x04025E
		rts
Offset_0x04025E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x040266:
		addq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		cmpi.b	#$C0, Obj_Control_Var_0C(A0)			 ; $003C
		bcc.s	Offset_0x040274
		rts
Offset_0x040274:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0080, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04028E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04028A:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04028E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x040296:
		subq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		cmpi.b	#$80, Obj_Control_Var_0C(A0)			 ; $003C
		bls.s	Offset_0x0402A4
		rts
Offset_0x0402A4:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0402B2:
		lea		Offset_0x0402BE(PC), A2
		bsr.w	Offset_0x0404CE
		bra.w	Offset_0x04058A
;-------------------------------------------------------------------------------
Offset_0x0402BE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
		moveq	#$04, D2
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x0402CE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0402E2(PC, D0), D1
		jsr		Offset_0x0402E2(PC, D1)
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x0402E2:
		dc.w	Offset_0x0402E8-Offset_0x0402E2
		dc.w	SpeedToPos_Animate_Raw_Wait-Offset_0x0402E2 ; Offset_0x042F7C
		dc.w	Offset_0x040330-Offset_0x0402E2
;-------------------------------------------------------------------------------
Offset_0x0402E8:
		lea		Ball_Shooter_Setup_Data_2(PC), A1	   ; Offset_0x0405DE
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	#$FE80, Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x0406D0, Obj_Child_Data(A0)			 ; $0030
		move.w	#$0015, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04030E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04030E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0029, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x040338, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x040330:
		jsr		Move_Light_Gravity(PC)		   ; Offset_0x0426C2
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x040338:
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$00, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x040350:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x040368(PC, D0), D1
		jsr		Offset_0x040368(PC, D1)
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x040368:
		dc.w	Offset_0x040370-Offset_0x040368
		dc.w	Offset_0x040378-Offset_0x040368
		dc.w	Offset_0x04039C-Offset_0x040368
		dc.w	Offset_0x0403CA-Offset_0x040368
;-------------------------------------------------------------------------------
Offset_0x040370:
		lea		Ball_Shooter_Setup_Data_3(PC), A1	   ; Offset_0x0405EA
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x040378:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x040386
		rts
Offset_0x040386:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x0406D6, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x04039C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$06, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0403B4
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0403BC
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
Offset_0x0403B4:
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		rts
Offset_0x0403BC:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x0403CA:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x0403D8
		rts
Offset_0x0403D8:
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x0403DE:
		lea		Ball_Shooter_Setup_Data_4(PC), A1	   ; Offset_0x0405F6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x0403EE, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x0403EE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x040414
		tst.l	(A1)
		beq.s	Offset_0x040414
		moveq	#$12, D1
		moveq	#$14, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x040414:
		jsr		Displace_Player_Offset(PC)			   ; Offset_0x04315A
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x04041E:
		lea		Offset_0x040676(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		addq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		andi.w	#$0007, D0
		move.b	Offset_0x04043A(PC, D0), Obj_Subtype(A1)		 ; $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x04043A:
		dc.b	$00, $02, $01, $02, $00, $01, $02, $01
;-------------------------------------------------------------------------------
Offset_0x040442:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		lea		Offset_0x040464(PC, D0), A1
		move.w	(A1)+, D0
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	(A1)+, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x040464:
		dc.w	$FFF0, $0050, $FA00, $FE00, $FFF0, $0050, $FC00, $FF00
		dc.w	$FFF0, $0080, $FC00, $0000
;-------------------------------------------------------------------------------
Offset_0x04047C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		move.w	D0, D2
		cmpi.b	#$08, D0
		bcs.s	Offset_0x040498
		move.b	#$0B, Obj_Map_Id(A0)					 ; $0022
		subi.w	#$0008, D2
		move.w	D2, D1
Offset_0x040498:
		add.w	D0, D0
		lea		Offset_0x0404AE(PC, D0), A1
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		lsr.w	#$01, D1
		or.b	D1, Obj_Flags(A0)				 ; $0004
		rts
;-------------------------------------------------------------------------------
Offset_0x0404AE:
		dc.w	$FD00, $FD00, $0300, $FD00, $FD00, $FE00, $0300, $FE00
		dc.w	$FC00, $FC00, $0400, $FC00, $FC00, $FD00, $0400, $FD00
;-------------------------------------------------------------------------------
Offset_0x0404CE:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		(A2)
		moveq	#$12, D1
		moveq	#$07, D2
		moveq	#$07, D3
		move.w	(A7)+, D4
		jmp		(Platform_Object).l			   ; Offset_0x013AF6
;-------------------------------------------------------------------------------
Offset_0x0404E2:
		tst.l	(A0)
		beq.s	Offset_0x040538
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x040538
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x04053A
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x040506
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x040506:
		bset	#$06, Obj_Status(A0)					 ; $002A
		lea		(Palette_Row_1_Offset+$16).w, A1			 ; $FFFFED36
		move.w	#$0222, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x040520
		move.w	#$0EEE, D0
Offset_0x040520:
		move.w	D0, (A1)
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x040538
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.w	#$0222, (A1)
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x040538:
		rts
Offset_0x04053A:
		move.l	#Offset_0x03FFEE, (A0)
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$A425, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x040004, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.b	#$04, Obj_Subtype(A1)					 ; $002C
		move.w	#$0000, (Target_Camera_Min_Y).w		 ; $FFFFFA96
		lea		Level_Resize_Min_Y(PC), A2			   ; Offset_0x042628
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		lea		Level_Resize_Max_X(PC), A2			   ; Offset_0x04261C
		jmp		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
Offset_0x04058A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x04059C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x04059C:
		move.l	#ObjectFall_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB6
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.w	#$A425, Obj_Art_VRAM(A0)				 ; $000A
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0405CA(PC, D0), Obj_Speed_X(A0)		 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		jsr		Displace_Player_Offset(PC)			   ; Offset_0x04315A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0405CA:
		dc.w	$0300, $0200, $FE00, $FD00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data:					   ; Offset_0x0405D2
		dc.l	Knuckles_LBz_Pillar_Mappings		   ; Offset_0x10D86A
		dc.w	$2425, $0280
		dc.b	$20, $10, $00, $22
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_2:					   ; Offset_0x0405DE
		dc.l	Ball_Shooter_Mappings		   ; Offset_0x10D192
		dc.w	$04D7, $0280
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_3:					   ; Offset_0x0405EA
		dc.l	Robotnik_Ship_Mappings		   ; Offset_0x10D020
		dc.w	$852E, $0300
		dc.b	$10, $08, $04, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_4:					   ; Offset_0x0405F6
		dc.l	Knuckles_LBz_Pillar_Mappings		   ; Offset_0x10D86A
		dc.w	$2425, $0300
		dc.b	$08, $20, $0C, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_5:					   ; Offset_0x040602
		dc.w	$0280
		dc.b	$08, $18, $02, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_6:					   ; Offset_0x040608
		dc.w	$A425, $0200
		dc.b	$08, $08, $0D, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_7:					   ; Offset_0x040610
		dc.w	$0280
		dc.b	$10, $10, $05, $9A
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_8:					   ; Offset_0x040616
		dc.w	$0425, $0200
		dc.b	$08, $08, $07, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_9:					   ; Offset_0x04061E
		dc.w	$A425, $0200
		dc.b	$08, $08, $0A, $00
;-------------------------------------------------------------------------------
Ball_Shooter_Setup_Data_A:					   ; Offset_0x040626
		dc.l	Knuckles_LBz_Pillar_Mappings		   ; Offset_0x10D86A
		dc.w	$4425, $0280
		dc.b	$08, $08, $0E, $00
;-------------------------------------------------------------------------------
Offset_0x040632:
		dc.w	$0001
		dc.l	Offset_0x040350
		dc.b	$00, $E8
		dc.l	Offset_0x0403DE
		dc.b	$E4, $E8
;-------------------------------------------------------------------------------
Offset_0x040640:
		dc.w	$0000
		dc.l	Offset_0x0402CE
		dc.b	$60, $D8
;-------------------------------------------------------------------------------
Offset_0x040648:
		dc.w	$0002
		dc.l	Offset_0x040168
		dc.b	$E8, $28
		dc.l	Offset_0x040168
		dc.b	$18, $28
		dc.l	Offset_0x040168
		dc.b	$00, $28
;-------------------------------------------------------------------------------
Offset_0x04065C:
		dc.w	$0002
		dc.l	Offset_0x0401D8
		dc.b	$00, $E8
		dc.l	Offset_0x0401D8
		dc.b	$00, $F8
		dc.l	Offset_0x0401D8
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x040670:
		dc.w	$0003
		dc.l	Offset_0x040204
;-------------------------------------------------------------------------------
Offset_0x040676:
		dc.w	$0000
		dc.l	Offset_0x04001A
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x04067E:
		dc.w	$0000
		dc.l	Offset_0x040104
		dc.b	$00, $10
;-------------------------------------------------------------------------------
Offset_0x040686:
		dc.w	$000B
		dc.l	Offset_0x040156
		dc.b	$F8, $F8
		dc.l	Offset_0x040156
		dc.b	$08, $F8
		dc.l	Offset_0x040156
		dc.b	$F8, $08
		dc.l	Offset_0x040156
		dc.b	$08, $08
		dc.l	Offset_0x040156
		dc.b	$F0, $F0
		dc.l	Offset_0x040156
		dc.b	$10, $F0
		dc.l	Offset_0x040156
		dc.b	$F0, $10
		dc.l	Offset_0x040156
		dc.b	$10, $10
		dc.l	Offset_0x040104
		dc.b	$F8, $06
		dc.l	Offset_0x040104
		dc.b	$06, $08
		dc.l	Offset_0x040104
		dc.b	$F8, $FA
		dc.l	Offset_0x040104
		dc.b	$06, $F8
;-------------------------------------------------------------------------------
Offset_0x0406D0:
		dc.b	$07, $00, $01, $02, $01, $FC
;-------------------------------------------------------------------------------
Offset_0x0406D6:
		dc.b	$07, $00, $01, $FC
;-------------------------------------------------------------------------------
Offset_0x0406DA:
		dc.b	$00, $05, $06, $FC
;-------------------------------------------------------------------------------
Offset_0x0406DE:
		dc.b	$05, $07, $07, $08, $09, $F4
;-------------------------------------------------------------------------------
Ball_Shooter_Palette:						   ; Offset_0x0406E4
		dc.w	$00EE, $0EEE, $0000, $0000, $0000, $00EE, $0088, $0224
		dc.w	$06AE, $004C, $0228, $0222, $0EAA, $0A64, $0642, $0044
;===============================================================================
; Objeto 0x8C - Robotnik atirando bolas pretas na Lauch Base 2
; <<<-
;===============================================================================