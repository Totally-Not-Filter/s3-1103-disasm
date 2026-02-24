;===============================================================================
; Objeto 0xB6 - Robotnik atirando laser antes do chefe final na Flying Battery
; ->>>
;===============================================================================
; Offset_0x03CE96:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03CEAC(PC, D0), D1
		jsr		Offset_0x03CEAC(PC, D1)
		bsr.w	Offset_0x03D3D6
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03CEAC:
		dc.w	Offset_0x03CEB8-Offset_0x03CEAC
		dc.w	Offset_0x03CF14-Offset_0x03CEAC
		dc.w	Offset_0x03CF40-Offset_0x03CEAC
		dc.w	Offset_0x03CF82-Offset_0x03CEAC
		dc.w	Offset_0x03CFA2-Offset_0x03CEAC
		dc.w	Offset_0x03D006-Offset_0x03CEAC
;-------------------------------------------------------------------------------
Offset_0x03CEB8:
		lea		Barrier_Eggman_Setup_Data(PC), A1	   ; Offset_0x03D43A
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$7F, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$06, Obj_Control_Var_09(A0)			 ; $0039
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	#$0240, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CF2A, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#$6A, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		Barrier_Eggman_Palette(PC), A1		   ; Offset_0x03D4BE
		jsr		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
		lea		Offset_0x03D46C(PC), A2
		jsr		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
		lea		Offset_0x03D474(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03CF14:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		Find_Other_Object(PC)		   ; Offset_0x04269E
		cmpi.w	#$0018, D2
		bcc.s	Offset_0x03CF26
		bsr.w	Offset_0x03CF70
Offset_0x03CF26:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03CF2A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03CF3E:
		rts
;-------------------------------------------------------------------------------
Offset_0x03CF40:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		Find_Other_Object(PC)		   ; Offset_0x04269E
		cmpi.w	#$0018, D2
		bcs.s	Offset_0x03CF56
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03CF56
		rts
Offset_0x03CF56:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CF8C, Obj_Child(A0)			 ; $0034
Offset_0x03CF70:
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x03CF3E
		lea		Offset_0x03D482(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x03CF82:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03CF8C:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CFB8, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03CFA2:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03CFA6:
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x03CFEA
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03CFB8:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		lea		Offset_0x03D48A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03CFD0:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		(Find_Other_Object).l			   ; Offset_0x04269E
		move.w	#$0100, D1
		tst.w	D0
		bne.s	Offset_0x03CFE4
		neg.w	D1
Offset_0x03CFE4:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		rts
Offset_0x03CFEA:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D064, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D006:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03D04E
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		andi.b	#$1F, D0
		bne.s	Offset_0x03D01A
		bsr.s	Offset_0x03CFD0
Offset_0x03D01A:
		move.w	#$0100, D0
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_X(A1), D1					 ; $0010
		move.w	Obj_X(A0), D2					 ; $0010
		addi.w	#$0020, D1
		cmp.w	D1, D2
		bcs.s	Offset_0x03D044
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_X(A1), D1					 ; $0010
		subi.w	#$0020, D1
		cmp.w	D1, D2
		bcs.s	Offset_0x03D048
		neg.w	D0
Offset_0x03D044:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x03D048:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x03D04E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03CFA6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D064:
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D07A, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D07A:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		move.l	#MarkObjGone, (A0)			   ; Offset_0x011AF2
		rts
;-------------------------------------------------------------------------------
Offset_0x03D08C:
		lea		Barrier_Eggman_Setup_Data_2(PC), A1	   ; Offset_0x03D446
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03D09E, (A0)
		bra.w	Offset_0x03D390
;-------------------------------------------------------------------------------
Offset_0x03D09E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03D0DE
		btst	#$01, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03D0D8
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03D0D8
		move.l	#Offset_0x03D0E6, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D0F6, Obj_Child(A0)			 ; $0034
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
Offset_0x03D0D8:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03D0DE:
		move.l	#MarkObjGone, (A0)			   ; Offset_0x011AF2
		rts
;-------------------------------------------------------------------------------
Offset_0x03D0E6:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03D0F6:
		move.l	#Offset_0x03D09E, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$03, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03D108:
		lea		Barrier_Eggman_Setup_Data_3(PC), A1	   ; Offset_0x03D44C
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03D124, (A0)
		addi.w	#$00CC, Obj_X(A0)				 ; $0010
		addi.w	#$007C, Obj_Y(A0)				 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03D124:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03D136
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03D136:
		move.l	#MarkObjGone, (A0)			   ; Offset_0x011AF2
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		lea		(Offset_0x041D62).l, A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03D152:
		lea		Barrier_Eggman_Setup_Data_6(PC), A1	   ; Offset_0x03D460
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03D176, (A0)
		addi.w	#$00D8, Obj_X(A0)				 ; $0010
		addi.w	#$0074, Obj_Y(A0)				 ; $0014
		move.l	#Offset_0x03D492, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03D176:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03D18C
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
Offset_0x03D18C:
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03D1A0
		move.l	#Offset_0x03D1A6, (A0)
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x03D1A0:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03D1A6:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03D1E2
		move.l	#Offset_0x03D1E8, (A0)
		subq.w	#$04, Obj_Y(A0)					 ; $0014
		move.w	#$0200, Obj_Speed_X(A0)					 ; $0018
		move.l	#Ball_Shooter_Mappings, Obj_Map(A0) ; Offset_0x10D192, $000C
		move.w	#$04D7, Obj_Art_VRAM(A0)				 ; $000A
		clr.b	Obj_Map_Id(A0)					 ; $0022
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03D1E2:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03D1E8:
		lea		Offset_0x03D4B7(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x03D1FC:
		lea		Barrier_Eggman_Setup_Data_4(PC), A1	   ; Offset_0x03D452
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03D234, (A0)
		move.w	#$00B0, D0
		move.b	Obj_Subtype(A0), D1				 ; $002C
		bne.s	Offset_0x03D216
		neg.w	D0
Offset_0x03D216:
		add.w	D0, Obj_X(A0)					 ; $0010
		addi.w	#$0060, Obj_Y(A0)				 ; $0014
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$44, D0
		tst.b	D1
		beq.s	Offset_0x03D22C
		moveq	#$46, D0
Offset_0x03D22C:
		move.w	$00(A1, D0), Obj_Height_3(A0)			 ; $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x03D234:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03D26E
		move.w	Obj_X(A0), -(A7)				 ; $0010
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		moveq	#$13, D1
		moveq	#$50, D2
		move.w	#$0060, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.w	Offset_0x03CF3E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03D26E:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03D274:
		lea		Barrier_Eggman_Setup_Data_5(PC), A1	   ; Offset_0x03D458
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03D294, (A0)
		move.l	#Offset_0x03D49F, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03D2B6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D294:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jsr		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
		tst.w	D2
		bpl.s	Offset_0x03D2B2
		cmpi.b	#$60, Obj_Timer_2(A0)					 ; $002F
		bne.s	Offset_0x03D2B2
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x03D2B2:
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03D2B6:
		move.l	#Offset_0x03D2E0, (A0)
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x03D4A4, Obj_Child_Data(A0)			 ; $0030
		addi.w	#$003C, Obj_Y(A0)				 ; $0014
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D31C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D2E0:
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		cmpi.b	#$08, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x03D2F2
		move.b	#$AC, Obj_Col_Flags(A0)					 ; $0028
Offset_0x03D2F2:
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		cmpi.b	#$04, Obj_Routine(A2)					 ; $0005
		beq.s	Offset_0x03D30A
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		cmpi.b	#$04, Obj_Routine(A2)					 ; $0005
		bne.s	Offset_0x03D310
Offset_0x03D30A:
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03D310:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03D31C:
		move.l	#Offset_0x03D342, Obj_Child(A0)			 ; $0034
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		st		(Earthquake_Flag).w					 ; $FFFFEECC
		lea		(Offset_0x041D62).l, A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03D340
		addi.w	#$0060, Obj_Y(A1)				 ; $0014
Offset_0x03D340:
		rts
;-------------------------------------------------------------------------------
Offset_0x03D342:
		move.l	#Offset_0x03D4B0, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03D36E, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03D36C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$00, Obj_Control_Var_08(A1)			 ; $0038
Offset_0x03D36C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03D36E:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03D384, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03D384:
		clr.w	(Earthquake_Flag).w					 ; $FFFFEECC
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
Offset_0x03D390:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		cmpi.w	#$0004, D0
		bcc.s	Offset_0x03D3B2
		moveq	#$44, D1
		tst.b	D0
		beq.s	Offset_0x03D3A8
		moveq	#$46, D1
Offset_0x03D3A8:
		move.w	A0, $00(A1, D1)
		bset	#$01, Obj_Flags(A0)				 ; $0004
Offset_0x03D3B2:
		add.w	D0, D0
		lea		Offset_0x03D3C6(PC, D0), A1
		move.w	(A1)+, D0
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	(A1)+, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03D3C6:
		dc.w	$FF50, $0018, $00B0, $0018, $FF50, $00A8, $00B0, $00A8
;-------------------------------------------------------------------------------
Offset_0x03D3D6:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03D426
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03D3F0
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03D3F0:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03D402
		addq.w	#$04, D0
Offset_0x03D402:
		lea		Offset_0x03D428(PC), A1
		lea		Offset_0x03D42E(PC, D0), A2
		jsr		Move_0x06_Bytes_A2_A1(PC)			   ; Offset_0x043260
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03D426
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
		move.b	#$7F, Obj_Boss_Hit(A0)					 ; $0029
Offset_0x03D426:
		rts
;-------------------------------------------------------------------------------
Offset_0x03D428:
		dc.w	(Palette_Row_1_Offset+$18)				 ; $ED38
		dc.w	(Palette_Row_1_Offset+$1A)				 ; $ED3A
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03D42E:
		dc.w	$0866, $0644, $0020, $0EEE, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data:					   ; Offset_0x03D43A
		dc.l	Barrier_Eggman_Mappings		   ; Ofsset_0x110776
		dc.w	$252E, $0280
		dc.b	$20, $20, $00, $1C
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data_2:				   ; Offset_0x03D446
		dc.w	$0080
		dc.b	$08, $08, $01, $00
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data_3:				   ; Offset_0x03D44C
		dc.w	$0280
		dc.b	$0C, $14, $02, $00
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data_4:				   ; Offset_0x03D452
		dc.w	$0080
		dc.b	$08, $60, $04, $00
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data_5:				   ; Offset_0x03D458
		dc.w	$A52E, $0080
		dc.b	$18, $04, $05, $00
;-------------------------------------------------------------------------------
Barrier_Eggman_Setup_Data_6:				   ; Offset_0x03D460
		dc.l	Robotnik_Stand_Mappings		   ; Offset_0x1108C8
		dc.w	$8466, $0280
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Offset_0x03D46C:
		dc.w	$0003
		dc.l	Offset_0x03D08C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03D474:
		dc.w	$0001
		dc.l	Offset_0x03D108
		dc.b	$00, $00
		dc.l	Offset_0x03D152
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03D482:
		dc.w	$0001
		dc.l	Offset_0x03D1FC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03D48A:
		dc.w	$0000
		dc.l	Offset_0x03D274
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x03D492:
		dc.b	$00, $07, $01, $17, $00, $07, $01, $0F
		dc.b	$00, $3F, $01, $07, $FC
;-------------------------------------------------------------------------------
Offset_0x03D49F:
		dc.b	$0B, $80, $05, $0A, $FC
;-------------------------------------------------------------------------------
Offset_0x03D4A4:
		dc.b	$00, $06, $06, $0A, $07, $0A, $F8, $08
		dc.b	$00, $08, $0A, $FC
;-------------------------------------------------------------------------------
Offset_0x03D4B0:
		dc.b	$00, $07, $07, $0A, $06, $0A, $F4
;-------------------------------------------------------------------------------
Offset_0x03D4B7:
		dc.b	$07, $00, $01, $02, $01, $FC, $00
;-------------------------------------------------------------------------------
Barrier_Eggman_Palette:						   ; Offset_0x03D4BE
		dc.w	$0000, $0EEE, $0EE0, $0E60, $0A20, $00EE, $0088, $004C
		dc.w	$000C, $0008, $0CAA, $0A88, $0866, $0644, $0020, $0044
;===============================================================================
; Objeto 0xB6 - Robotnik atirando laser antes do chefe final na Flying Battery
; <<<-
;===============================================================================