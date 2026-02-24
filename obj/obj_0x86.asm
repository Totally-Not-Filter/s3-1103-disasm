;===============================================================================
; Objeto 0x86 - Chefe na Launch Base
; ->>>
;===============================================================================
; Offset_0x03F11A:
		lea	Offset_0x03F174(PC), A1
		jsr	(Check_Camera_In_Range).l		   ; Offset_0x043392
		move.l	#Offset_0x03F17C, (A0)
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#Volume_Down, D0				  ; -$20
		jsr	(Play_Music).l					 ; Offset_0x001176
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.b	#$19, Obj_Angle(A0)				 ; $0026
		move.w	(Level_Limits_Max_Y).w, (Target_Camera_Max_Y).w ; $FFFFEE12, $FFFFFA98
		move.w	#$05A0, (Level_Limits_Max_Y).w		 ; $FFFFEE12
		move.w	#$1B60, Obj_Inertia(A0)					 ; $001C
		move.w	#$1B60, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.l	#Offset_0x03F180, Obj_Child(A0)			 ; $0034
		moveq	#$71, D0
		jsr	(LoadPLC).l				 ; Offset_0x0014D0
		lea	Beam_Rocket_Palette(PC), A1			   ; Offset_0x03FBA8
		jmp	Pal_Load_Line_1(PC)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x03F174:
		dc.w	$0440, $0620, $1A80, $1B60
;-------------------------------------------------------------------------------
Offset_0x03F17C:
		jmp	Update_Sonic_Level_Limits_X_Y_Play_Music(PC) ; Offset_0x0433DE
;-------------------------------------------------------------------------------
Offset_0x03F180:
		move.l	#Offset_0x03F188, (A0)
Offset_0x03F186:
		rts
;-------------------------------------------------------------------------------
Offset_0x03F188:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03F19E(PC, D0), D1
		jsr	Offset_0x03F19E(PC, D1)
		bsr.w	Offset_0x03F896
		jmp	Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03F19E:
		dc.w	Offset_0x03F1A8-Offset_0x03F19E
		dc.w	Offset_0x03F1F4-Offset_0x03F19E
		dc.w	Offset_0x03F23A-Offset_0x03F19E
		dc.w	Offset_0x03F23C-Offset_0x03F19E
		dc.w	Offset_0x03F252-Offset_0x03F19E
;-------------------------------------------------------------------------------
Offset_0x03F1A8:
		lea	Beam_Rocket_Setup_Data(PC), A1		   ; Offset_0x03FA56
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$01C0, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03F1FE, Obj_Child(A0)			 ; $0034
		lea	(LBz_Robotnik_Ship_Data), A2		   ; Offset_0x03656E
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		lea	Offset_0x03FAD8(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		lea	Offset_0x03FAFE(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		tst.b	(Boss_Data_Buffer+$01).w			 ; $FFFFFA81
		beq.w	Offset_0x03F186
		lea	Offset_0x03FB80(PC), A2
		jmp	SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x03F1F4:
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03F1FE:
		move.w	#$01E0, Obj_Timer(A0)					 ; $002E
		jsr	(PseudoRandomNumber).l			 ; Offset_0x001AFA
		swap	D0
		moveq	#$00, D1
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		btst	#$00, D0
		beq.s	Offset_0x03F222
		moveq	#$02, D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03F222:
		move.w	Offset_0x03F236(PC, D1), D1
		move.w	(Camera_X).w, D2					 ; $FFFFEE78
		add.w	D1, D2
		move.w	D2, Obj_X(A0)					 ; $0010
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03F236:
		dc.w	$0110, $0030
;-------------------------------------------------------------------------------
Offset_0x03F23A:
		rts
;-------------------------------------------------------------------------------
Offset_0x03F23C:
		subq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		bmi.s	Offset_0x03F244
		rts
Offset_0x03F244:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		rts
;-------------------------------------------------------------------------------
Offset_0x03F252:
		addq.w	#$08, Obj_Y(A0)					 ; $0014
		subq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		bmi.s	Offset_0x03F25E
		rts
Offset_0x03F25E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03F266:
		move.w	Obj_Y(A0), D0					 ; $0014
		addq.w	#$01, D0
		move.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		addi.w	#$0120, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x03F282
		move.w	D0, Obj_Y(A0)					 ; $0014
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F282:
		move.l	#Offset_0x03F2AC, (A0)
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		move.w	(Camera_X).w, D2					 ; $FFFFEE78
		addi.w	#$0040, D2
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D1, Obj_Y(A0)					 ; $0014
		move.w	#$0800, Obj_Speed_X(A0)					 ; $0018
		move.w	#$F800, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03F2AC:
		btst	#$03, Obj_Status(A0)					 ; $002A
		beq.w	Offset_0x03F186
		subi.w	#$0020, Obj_Speed_X(A0)					 ; $0018
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x03F2D4
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F2D4:
		move.l	#Offset_0x03F2F2, (A0)
		move.w	#$FF00, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F2F2:
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jsr	Set_Boss_Flag_Timed(PC)		   ; Offset_0x042968
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F302:
		move.w	Obj_Y(A0), D0					 ; $0014
		subq.w	#$01, D0
		move.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		subi.w	#$0040, D1
		cmp.w	D1, D0
		bcs.s	Offset_0x03F31E
		move.w	D0, Obj_Y(A0)					 ; $0014
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F31E:
		move.l	#Offset_0x03F342, (A0)
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	(Camera_X).w, D2					 ; $FFFFEE78
		addi.w	#$0040, D2
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03F342:
		move.w	Obj_Y(A0), D0					 ; $0014
		addq.w	#$01, D0
		move.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		addi.w	#$0040, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x03F35E
		move.w	D0, Obj_Y(A0)					 ; $0014
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F35E:
		move.l	#Offset_0x03F374, (A0)
		lea	(LBz_Robotnik_Ship_Data_2).l, A2		 ; Offset_0x03659E
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F374:
		move.w	Obj_X(A0), D0					 ; $0010
		addq.w	#$02, D0
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		addi.w	#$00A0, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x03F390
		move.w	D0, Obj_X(A0)					 ; $0010
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F390:
		move.w	D0, Obj_X(A0)					 ; $0010
		move.l	#Offset_0x03F3A8, (A0)
		lea	Offset_0x03FAF6(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F3A8:
		move.w	Obj_X(A0), D0					 ; $0010
		addq.w	#$02, D0
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		addi.w	#$01C0, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x03F3C4
		move.w	D0, Obj_X(A0)					 ; $0010
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F3C4:
		move.l	#Offset_0x03F3DC, (A0)
		bset	#$06, Obj_Status(A0)					 ; $002A
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F3DC:
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F3E6:
		lea	Beam_Rocket_Setup_Data_3(PC), A1	   ; Offset_0x03FA68
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03F3F6, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x03F3F6:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp	Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03F3FE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03F410(PC, D0), D1
		jsr	Offset_0x03F410(PC, D1)
		jmp	Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03F410:
		dc.w	Offset_0x03F416-Offset_0x03F410
		dc.w	Offset_0x03F42E-Offset_0x03F410
		dc.w	Offset_0x03F46E-Offset_0x03F410
;-------------------------------------------------------------------------------
Offset_0x03F416:
		lea	Beam_Rocket_Setup_Data_4(PC), A1	   ; Offset_0x03FA70
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x03F440, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03F42E:
		jsr	(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x03F186
		jmp	Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x03F440:
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		cmpi.w	#$0100, D0
		bcs.s	Offset_0x03F454
		asr.w	#$01, D0
		neg.w	D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x03F454:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		lea	(Offset_0x037136).l, A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		lea	(Offset_0x041D62).l, A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03F46E:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F474:
		lea	Beam_Rocket_Setup_Data_6(PC), A1	   ; Offset_0x03FA7E
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03F484, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x03F484:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03F49A
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F49A:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F4A0:
		lea	Beam_Rocket_Setup_Data_7(PC), A1	   ; Offset_0x03FA8A
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03F4BC, (A0)
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03F4BA
		move.b	#$22, Obj_Map_Id(A0)					 ; $0022
Offset_0x03F4BA:
		rts
;-------------------------------------------------------------------------------
Offset_0x03F4BC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$06, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03F4D2
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F4D2:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F4D8:
		lea	Beam_Rocket_Setup_Data_8(PC), A1	   ; Offset_0x03FA92
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03F4F6, (A0)
		move.l	#Offset_0x03F4F6, Obj_Child(A0)			 ; $0034
		lea	Offset_0x03FB52(PC), A2
		jmp	SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x03F4F6:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		bsr.w	Offset_0x03F9B2
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F504:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$06, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03F530
		move.l	Obj_Child(A0), (A0)				 ; $0034
		btst	#$05, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03F530
		subi.b	#$28, Obj_Control_Var_13(A0)			 ; $0043
		cmpi.b	#$04, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03F530
		bclr	#$05, Obj_Status(A1)					 ; $002A
Offset_0x03F530:
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
; Offset_0x03F536:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F53C:
		move.w	#$0001, Obj_Control_Var_0C(A0)			 ; $003C
		bra.s	Offset_0x03F4D8
;-------------------------------------------------------------------------------
Offset_0x03F544:
		lea	Beam_Rocket_Setup_Data_9(PC), A1	   ; Offset_0x03FA9E
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03F568, (A0)
		move.l	#Offset_0x03F568, Obj_Child(A0)			 ; $0034
		move.w	#$0002, Obj_Control_Var_0C(A0)			 ; $003C
		lea	Offset_0x03FB72(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03F568:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		bsr.w	Offset_0x03F9B2
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F576:
		lea	Beam_Rocket_Setup_Data_B(PC), A1	   ; Offset_0x03FAB2
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03F58E, (A0)
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		bsr.w	Offset_0x03FA0C
Offset_0x03F58E:
		jsr	(ObjectFall).l				   ; Offset_0x0110FE
		jsr	Set_Boss_Flag_Timed(PC)		   ; Offset_0x042968
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F59E:
		lea	Beam_Rocket_Setup_Data_C(PC), A1	   ; Offset_0x03FAB8
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03F5C2, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03F5C2
		move.b	#$08, Obj_Control_Var_09(A0)			 ; $0039
Offset_0x03F5C2:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$06, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03F5D4
		move.l	#Offset_0x03F5DE, (A0)
Offset_0x03F5D4:
		bsr.w	Offset_0x03F79A
		moveq	#$04, D0
		jmp	Child_Display_Or_Flicker_Move(PC)	   ; Offset_0x0424E2
;-------------------------------------------------------------------------------
Offset_0x03F5DE:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$06, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03F5F0
		move.l	#Offset_0x03F5C2, (A0)
Offset_0x03F5F0:
		moveq	#$04, D0
		jmp	Child_Display_Or_Flicker_Move(PC)	   ; Offset_0x0424E2
;-------------------------------------------------------------------------------
Offset_0x03F5F6:
		lea	Beam_Rocket_Setup_Data_D(PC), A1	   ; Offset_0x03FABE
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03F60C, (A0)
		move.w	#$0008, Obj_Control_Var_0A(A0)			 ; $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x03F60C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03F642
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.w	Offset_0x03F186
		move.w	Obj_Control_Var_0A(A0), Obj_Timer(A0)	  ; $003A, $002E
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bpl.s	Offset_0x03F63C
		move.l	#Offset_0x03F648, (A0)
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
Offset_0x03F63C:
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F642:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03F648:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03F662
		btst	#$00, Obj_Timer_2(A0)					 ; $002F
		bne.w	Offset_0x03F186
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03F662:
		move.l	#Offset_0x03F67E, (A0)
		move.l	#Offset_0x03FB8D, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03F68C, Obj_Child(A0)			 ; $0034
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F67E:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jsr	AnimateRaw(PC)				  ; Offset_0x04208E
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F68C:
		move.l	#Offset_0x03F6B4, (A0)
		move.b	#$11, Obj_Map_Id(A0)					 ; $0022
		moveq	#-$2C, D0
		move.w	#$F800, D1
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03F6AA
		neg.w	D0
		neg.w	D1
Offset_0x03F6AA:
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x03F6B4:
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.s	Offset_0x03F6D4
		lea	Offset_0x03FB6A(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		move.l	#Offset_0x03FB95, Obj_Child_Data(A1)			 ; $0030
		bsr.w	Offset_0x03F880
		bra.w	Offset_0x03F6E8
Offset_0x03F6D4:
		lea	Offset_0x03FB6A(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		move.l	#Offset_0x03FB9B, Obj_Child_Data(A1)			 ; $0030
		bsr.w	Offset_0x03F880
Offset_0x03F6E8:
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x03F6F4:
		lea	Beam_Rocket_Setup_Data_E(PC), A1	   ; Offset_0x03FAC6
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03F70E, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
Offset_0x03F70E:
		jsr	AnimateRaw(PC)				  ; Offset_0x04208E
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03F718:
		lea	Beam_Rocket_Setup_Data_A(PC), A1	   ; Offset_0x03FAAA
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03F730, (A0)
		move.l	#Offset_0x03FB88, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03F730:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jsr	AnimateRaw(PC)				  ; Offset_0x04208E
		jmp	Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03F73C:
		lea	Beam_Rocket_Setup_Data_F(PC), A1	   ; Offset_0x03FACC
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03F76E, (A0)
		move.l	#Offset_0x03FBA1, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x03F780, Obj_Child(A0)			 ; $0034
		move.b	#$EC, Obj_Control_Var_13(A0)			 ; $0043
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03F76C
		move.b	#$80, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x03F76C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03F76E:
		jsr	AnimateRaw(PC)				  ; Offset_0x04208E
		addq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#$03, D2
		jsr	Move_Sprite_Circular_Simple_Offset(PC) ; Offset_0x04270A
		jmp	Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x03F780:
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		addq.b	#$01, D0
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		andi.b	#$03, D0
		andi.b	#$FC, Obj_Flags(A0)				 ; $0004
		or.b	D0, Obj_Flags(A0)				 ; $0004
		rts
Offset_0x03F79A:
		moveq	#$00, D0
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03F7AC
		add.w	D0, D0
		bra.w	Offset_0x03F820
Offset_0x03F7AC:
		move.l	Obj_Child_Data(A0), A1					 ; $0030
		btst	#$00, Obj_Flags(A1)				 ; $0004
		sne		D2
		beq.s	Offset_0x03F7C4
		subq.b	#$01, D0
		bpl.s	Offset_0x03F7CE
		moveq	#$0B, D0
		bra.w	Offset_0x03F7CE
Offset_0x03F7C4:
		addq.b	#$01, D0
		cmpi.b	#$0C, D0
		bcs.s	Offset_0x03F7CE
		moveq	#$00, D0
Offset_0x03F7CE:
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		lea	Offset_0x03F846(PC), A2
		move.b	(A2, D0), D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
		bclr	#$07, D1
		bne.s	Offset_0x03F7EE
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		not.b	D2
Offset_0x03F7EE:
		bclr	#$03, Obj_Control_Var_08(A1)			 ; $0038
		cmpi.b	#$04, D1
		bne.s	Offset_0x03F814
		bset	#$03, Obj_Control_Var_08(A1)			 ; $0038
		tst.b	D2
		beq.s	Offset_0x03F814
		movem.l D0/D1, -(A7)
		lea	Offset_0x03FB5A(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		movem.l (A7)+, D0/D1
Offset_0x03F814:
		move.b	D1, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		move.w	Offset_0x03F852(PC, D0), Obj_Timer(A0)			 ; $002E
Offset_0x03F820:
		lea	Offset_0x03F86A(PC, D0), A1
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		move.b	(A1)+, D1
		ext.w	D1
		move.w	Obj_X(A2), D2					 ; $0010
		add.w	D1, D2
		move.w	D2, Obj_X(A0)					 ; $0010
		move.b	(A1)+, D1
		ext.w	D1
		move.w	Obj_Y(A2), D2					 ; $0014
		add.w	D1, D2
		move.w	D2, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03F846:
		dc.b	$83, $84, $85, $86, $87, $88, $07, $06
		dc.b	$05, $04, $03, $2D
;-------------------------------------------------------------------------------
Offset_0x03F852:
		dc.w	$0007, $005F, $0007, $0007, $0007, $0007, $0007, $0007
		dc.w	$0007, $005F, $0007, $0027
;-------------------------------------------------------------------------------
Offset_0x03F86A:
		dc.b	$27, $F8, $24, $F8, $24, $F8, $14, $F8
		dc.b	$0C, $F8, $00, $F8, $F4, $F8, $EC, $F8
		dc.b	$DC, $F8, $DC, $F8, $D9, $F8
;-------------------------------------------------------------------------------
Offset_0x03F880:
		jsr	(PseudoRandomNumber).l			 ; Offset_0x001AFA
		swap	D0
		andi.b	#$07, D0
		addi.b	#$18, D0
		move.b	D0, Obj_Control_Var_12(A1)				 ; $0042
		rts
;-------------------------------------------------------------------------------
Offset_0x03F896:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.w	Offset_0x03F934
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.w	Offset_0x03F936
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03F904
		move.b	Obj_Routine(A0), Obj_Control_Var_0A(A0)	  ; $0005, $003A
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr	(Play_Music).l					 ; Offset_0x001176
		cmpi.b	#$04, Obj_Boss_Hit(A0)					 ; $0029
		beq.s	Offset_0x03F8E2
		cmpi.b	#$02, Obj_Boss_Hit(A0)					 ; $0029
		bne.s	Offset_0x03F904
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03F8E2:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bset	D0, Obj_Control_Var_08(A0)				 ; $0038
		addq.w	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$0F, Obj_Control_Var_10(A0)			 ; $0040
		bset	#$05, Obj_Status(A0)					 ; $002A
		bsr.w	Offset_0x03F992
Offset_0x03F904:
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03F912
		addi.w	#$0004, D0
Offset_0x03F912:
		bsr.w	Offset_0x03F99A
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03F934
		move.b	Obj_Control_Var_0A(A0), Obj_Routine(A0)	  ; $003A, $0005
		move.w	#$0EEE, (Palette_Row_1_Offset+$02).w		 ; $FFFFED22
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
		bclr	#$06, Obj_Status(A0)					 ; $002A
Offset_0x03F934:
		rts
Offset_0x03F936:
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		move.b	#$05, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		moveq	#$64, D0
		jsr	(Add_Points_P1).l				 ; Offset_0x007AB0
		bset	#$06, Obj_Status(A0)					 ; $002A
		bset	#$07, Obj_Status(A0)					 ; $002A
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		bset	D0, Obj_Control_Var_08(A0)				 ; $0038
		lea	(Offset_0x041D62).l, A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		move.b	#$04, Obj_Subtype(A1)					 ; $002C
		tst.b	(Boss_Data_Buffer+$01).w			 ; $FFFFFA81
		bne.s	Offset_0x03F984
		move.l	#Offset_0x03F266, (A0)
		rts
Offset_0x03F984:
		move.l	#Offset_0x03F302, (A0)
		lea	Offset_0x03FAEE(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03F992:
		lea	Offset_0x03FAE0(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03F99A:
		lea	Offset_0x03F9A6(PC), A1
		lea	Offset_0x03F9AA(PC, D0), A2
		jmp	Move_0x04_Bytes_A2_A1(PC)			   ; Offset_0x043264
;-------------------------------------------------------------------------------
Offset_0x03F9A6:
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03F9AA:
		dc.w	$0026, $0020, $0EEE, $0EEE
;-------------------------------------------------------------------------------
Offset_0x03F9B2:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		btst	D0, Obj_Control_Var_08(A1)				 ; $0038
		beq.s	Offset_0x03F9FC
		move.l	#Go_Delete_Object_A0, (A0)			   ; Offset_0x042D3E
		move.l	#Offset_0x03FA4C, Obj_Control_Var_0E(A0)		 ; $003E
		lea	(Offset_0x03FB12).l, A2
		cmpi.w	#$0002, D0
		bne.s	Offset_0x03F9E8
		move.l	#Offset_0x03FA50, Obj_Control_Var_0E(A0)		 ; $003E
		lea	(Offset_0x03FB2C).l, A2
Offset_0x03F9E8:
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		lea	(Offset_0x041D62), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03F9FC:
		btst	#$06, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x03FA0A
		move.l	#Offset_0x03F504, (A0)
Offset_0x03FA0A:
		rts
Offset_0x03FA0C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		lsr.w	#$01, D1
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.l	Obj_Control_Var_0E(A1), A1				 ; $003E
		move.b	(A1, D1), Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		lea	Offset_0x03FA34(PC, D0), A1
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03FA34:
		dc.w	$FF00, $FE00, $0100, $FE00, $FE00, $FF00, $0200, $FF00
		dc.w	$FD00, $FD00, $0300, $FD00
;-------------------------------------------------------------------------------
Offset_0x03FA4C:
		dc.b	$23, $25, $24, $26
;-------------------------------------------------------------------------------
Offset_0x03FA50:
		dc.b	$27, $29, $28, $2A, $2B, $2C
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data:						   ; Offset_0x03FA56
		dc.l	Robotnik_Ship_Mappings		   ; Offset_0x10D020
		dc.w	$852E, $0280
		dc.b	$20, $20, $0C, $0F
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_2:					   ; Offset_0x03FA62
		dc.w	$0280
		dc.b	$20, $20, $05, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_3:					   ; Offset_0x03FA68
		dc.w	$A3AA, $0200
		dc.b	$10, $04, $15, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_4:					   ; Offset_0x03FA70
		dc.w	$A3AA, $0300
		dc.b	$0C, $10, $16, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_5:					   ; Offset_0x03FA78
		dc.w	$0200
		dc.b	$04, $04, $05, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_6:					   ; Offset_0x03FA7E
		dc.l	Beam_Rocket_Mappings		   ; Offset_0x03FBC8
		dc.w	$A3AA, $0200
		dc.b	$28, $08, $02, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_7:					   ; Offset_0x03FA8A
		dc.w	$A3AA, $0280
		dc.b	$10, $0C, $10, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_8:					   ; Offset_0x03FA92
		dc.l	Beam_Rocket_Mappings		   ; Offset_0x03FBC8
		dc.w	$A3AA, $0200
		dc.b	$20, $14, $00, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_9:					   ; Offset_0x03FA9E
		dc.l	Beam_Rocket_Mappings		   ; Offset_0x03FBC8
		dc.w	$A3AA, $0200
		dc.b	$28, $18, $01, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_A:					   ; Offset_0x03FAAA
		dc.w	$83AA, $0280
		dc.b	$0C, $18, $09, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_B:					   ; Offset_0x03FAB2
		dc.w	$0200
		dc.b	$10, $10, $2A, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_C:					   ; Offset_0x03FAB8
		dc.w	$0180
		dc.b	$0C, $0C, $03, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_D:					   ; Offset_0x03FABE
		dc.w	$83AA, $0100
		dc.b	$18, $08, $0F, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_E:					   ; Offset_0x03FAC6
		dc.w	$0100
		dc.b	$08, $08, $1C, $00
;-------------------------------------------------------------------------------
Beam_Rocket_Setup_Data_F:					   ; Offset_0x03FACC
		dc.l	Beam_Rocket_Mappings		   ; Offset_0x03FBC8
		dc.w	$A3AA, $0300
		dc.b	$0C, $0C, $0C, $00
;-------------------------------------------------------------------------------
Offset_0x03FAD8:
		dc.w	$0000
		dc.l	Offset_0x03F474
		dc.b	$00, $EC
;-------------------------------------------------------------------------------
Offset_0x03FAE0:
		dc.w	$0001
		dc.l	Offset_0x03F4A0
		dc.b	$F0, $00
		dc.l	Offset_0x03F4A0
		dc.b	$10, $00
;-------------------------------------------------------------------------------
Offset_0x03FAEE:
		dc.w	$0000
		dc.l	Offset_0x03F3E6
		dc.b	$00, $10
;-------------------------------------------------------------------------------
Offset_0x03FAF6:
		dc.w	$0000
		dc.l	Offset_0x03F3FE
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x03FAFE:
		dc.w	$0002
		dc.l	Offset_0x03F4D8
		dc.b	$00, $08
		dc.l	Offset_0x03F53C
		dc.b	$00, $30
		dc.l	Offset_0x03F544
		dc.b	$00, $5C
;-------------------------------------------------------------------------------
Offset_0x03FB12:
		dc.w	$0003
		dc.l	Offset_0x03F576
		dc.b	$F0, $FC
		dc.l	Offset_0x03F576
		dc.b	$10, $FC
		dc.l	Offset_0x03F576
		dc.b	$F0, $10
		dc.l	Offset_0x03F576
		dc.b	$10, $10
;-------------------------------------------------------------------------------
Offset_0x03FB2C:
		dc.w	$0005
		dc.l	Offset_0x03F576
		dc.b	$F0, $F8
		dc.l	Offset_0x03F576
		dc.b	$10, $F8
		dc.l	Offset_0x03F576
		dc.b	$F0, $10
		dc.l	Offset_0x03F576
		dc.b	$10, $10
		dc.l	Offset_0x03F576
		dc.b	$EC, $E0
		dc.l	Offset_0x03F576
		dc.b	$14, $E0
;-------------------------------------------------------------------------------
Offset_0x03FB52:
		dc.w	$0001
		dc.l	Offset_0x03F59E
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03FB5A:
		dc.w	$0000
		dc.l	Offset_0x03F5F6
		dc.b	$F8, $00
;-------------------------------------------------------------------------------
; Offset_0x03FB62:
		dc.w	$0000
		dc.l	Offset_0x03F5F6
		dc.b	$08, $00
;-------------------------------------------------------------------------------
Offset_0x03FB6A:
		dc.w	$0000
		dc.l	Offset_0x03F6F4
		dc.b	$20, $00
;-------------------------------------------------------------------------------
Offset_0x03FB72:
		dc.w	$0001
		dc.l	Offset_0x03F718
		dc.b	$EC, $30
		dc.l	Offset_0x03F718
		dc.b	$14, $30
;-------------------------------------------------------------------------------
Offset_0x03FB80:
		dc.w	$0001
		dc.l	Offset_0x03F73C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03FB88:
		dc.b	$02, $09, $0A, $0B, $FC
;-------------------------------------------------------------------------------
Offset_0x03FB8D:
		dc.b	$00, $17, $17, $18, $19, $1A, $1B, $F4
;-------------------------------------------------------------------------------
Offset_0x03FB95:
		dc.b	$00, $1C, $1C, $1D, $1E, $F4
;-------------------------------------------------------------------------------
Offset_0x03FB9B:
		dc.b	$00, $1F, $1F, $20, $21, $F4
;-------------------------------------------------------------------------------
Offset_0x03FBA1:
		dc.b	$01, $0C, $0D, $0E, $0D, $0C, $F4
;-------------------------------------------------------------------------------
Beam_Rocket_Palette:						   ; Offset_0x03FBA8
		dc.w	$0000, $0EEE, $008C, $004A, $0026, $00EE, $0088, $0000
		dc.w	$0000, $0ECC, $0CAA, $0A88, $0866, $0644, $0020, $0044
;-------------------------------------------------------------------------------
Beam_Rocket_Mappings:						   ; Offset_0x03FBC8
		dc.w	Offset_0x03FC80-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC9A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCC0-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCDA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCE2-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCEA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCF2-Beam_Rocket_Mappings
		dc.w	Offset_0x03FCFA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD02-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD0A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD18-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD26-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD34-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD3C-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD44-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD4C-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD54-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD62-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD70-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD78-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD80-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD88-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD96-Beam_Rocket_Mappings
		dc.w	Offset_0x03FD9E-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDA6-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDAE-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDB6-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDC4-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDD2-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDDA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDE2-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDEA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDF2-Beam_Rocket_Mappings
		dc.w	Offset_0x03FDFA-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE02-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE2A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE32-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE3A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE42-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE4A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE52-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE5A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE62-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE6A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE78-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE86-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC32-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC3A-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC42-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC50-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC58-Beam_Rocket_Mappings
		dc.w	Offset_0x03FC78-Beam_Rocket_Mappings
		dc.w	Offset_0x03FE10-Beam_Rocket_Mappings
Offset_0x03FC32:
		dc.w	$0001
		dc.w	$DC0D, $0000, $FFF0
Offset_0x03FC3A:
		dc.w	$0001
		dc.w	$DC0D, $0008, $FFF0
Offset_0x03FC42:
		dc.w	$0002
		dc.w	$DC0D, $0010, $FFE8
		dc.w	$DC01, $0018, $0008
Offset_0x03FC50:
		dc.w	$0001
		dc.w	$DC0D, $001A, $FFF0
Offset_0x03FC58:
		dc.w	$0005
		dc.w	$D40C, $0043, $FFF0
		dc.w	$DC05, $0047, $FFE8
		dc.w	$DC05, $004B, $0008
		dc.w	$DA00, $0051, $FFF8
		dc.w	$E404, $004F, $FFEC
Offset_0x03FC78:
		dc.w	$0001
		dc.w	$FC04, $0052, $FFFC
Offset_0x03FC80:
		dc.w	$0004
		dc.w	$EC0F, $0000, $FFE0
		dc.w	$0C0C, $0010, $FFE0
		dc.w	$EC0F, $0800, $0000
		dc.w	$0C0C, $0810, $0000
Offset_0x03FC9A:
		dc.w	$0006
		dc.w	$E80F, $0014, $FFE0
		dc.w	$F801, $0024, $FFD8
		dc.w	$080D, $0026, $FFE0
		dc.w	$E80F, $0814, $0000
		dc.w	$F801, $0824, $0020
		dc.w	$080D, $0826, $0000
Offset_0x03FCC0:
		dc.w	$0004
		dc.w	$F809, $002E, $FFD8
		dc.w	$0004, $0012, $FFF0
		dc.w	$0004, $0812, $0000
		dc.w	$F809, $082E, $0010
Offset_0x03FCDA:
		dc.w	$0001
		dc.w	$F805, $0034, $FFF8
Offset_0x03FCE2:
		dc.w	$0001
		dc.w	$F809, $0038, $FFF4
Offset_0x03FCEA:
		dc.w	$0001
		dc.w	$F809, $003E, $FFF4
Offset_0x03FCF2:
		dc.w	$0001
		dc.w	$F809, $0044, $FFF4
Offset_0x03FCFA:
		dc.w	$0001
		dc.w	$F809, $004A, $FFF4
Offset_0x03FD02:
		dc.w	$0001
		dc.w	$F809, $0050, $FFF4
Offset_0x03FD0A:
		dc.w	$0002
		dc.w	$E80A, $0056, $FFF4
		dc.w	$000A, $005F, $FFF4
Offset_0x03FD18:
		dc.w	$0002
		dc.w	$E80A, $0056, $FFF4
		dc.w	$000A, $0068, $FFF4
Offset_0x03FD26:
		dc.w	$0002
		dc.w	$E80A, $0856, $FFF4
		dc.w	$000A, $0071, $FFF4
Offset_0x03FD34:
		dc.w	$0001
		dc.w	$F805, $007A, $FFF8
Offset_0x03FD3C:
		dc.w	$0001
		dc.w	$F805, $007E, $FFF8
Offset_0x03FD44:
		dc.w	$0001
		dc.w	$F40A, $0082, $FFF4
Offset_0x03FD4C:
		dc.w	$0001
		dc.w	$F801, $008B, $FFFC
Offset_0x03FD54:
		dc.w	$0002
		dc.w	$F40D, $008D, $FFF0
		dc.w	$0404, $0095, $FFF8
Offset_0x03FD62:
		dc.w	$0002
		dc.w	$F809, $0097, $FFE8
		dc.w	$F809, $0897, $0000
Offset_0x03FD70:
		dc.w	$0001
		dc.w	$FC00, $009D, $FFFC
Offset_0x03FD78:
		dc.w	$0001
		dc.w	$FC00, $009E, $FFFC
Offset_0x03FD80:
		dc.w	$0001
		dc.w	$FC00, $009F, $FFFC
Offset_0x03FD88:
		dc.w	$0002
		dc.w	$FC04, $00A0, $FFF0
		dc.w	$FC04, $08A0, $0000
Offset_0x03FD96:
		dc.w	$0001
		dc.w	$F00B, $00A2, $FFF4
Offset_0x03FD9E:
		dc.w	$0001
		dc.w	$F801, $0097, $FFFC
Offset_0x03FDA6:
		dc.w	$0001
		dc.w	$F805, $0097, $FFF4
Offset_0x03FDAE:
		dc.w	$0001
		dc.w	$F809, $0097, $FFEC
Offset_0x03FDB6:
		dc.w	$0002
		dc.w	$F809, $0097, $FFE4
		dc.w	$F801, $0099, $FFFC
Offset_0x03FDC4:
		dc.w	$0002
		dc.w	$F809, $0097, $FFDC
		dc.w	$F805, $0099, $FFF4
Offset_0x03FDD2:
		dc.w	$0001
		dc.w	$FA00, $009D, $0000
Offset_0x03FDDA:
		dc.w	$0001
		dc.w	$FC00, $009E, $0000
Offset_0x03FDE2:
		dc.w	$0001
		dc.w	$FD00, $009F, $0000
Offset_0x03FDEA:
		dc.w	$0001
		dc.w	$FF00, $009D, $0000
Offset_0x03FDF2:
		dc.w	$0001
		dc.w	$FD00, $009E, $0000
Offset_0x03FDFA:
		dc.w	$0001
		dc.w	$FC00, $009F, $0000
Offset_0x03FE02:
		dc.w	$0002
		dc.w	$F40D, $088D, $FFF0
		dc.w	$0404, $0895, $FFF8
Offset_0x03FE10:
		dc.w	$0004
		dc.w	$EC0F, $0022, $FFE4
		dc.w	$EC0B, $0032, $0004
		dc.w	$0C0C, $003E, $FFEC
		dc.w	$0C00, $0042, $000C
Offset_0x03FE2A:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x03FE32:
		dc.w	$0001
		dc.w	$FC0C, $0010, $FFF0
Offset_0x03FE3A:
		dc.w	$0001
		dc.w	$F00F, $0800, $FFF0
Offset_0x03FE42:
		dc.w	$0001
		dc.w	$FC0C, $0810, $FFF0
Offset_0x03FE4A:
		dc.w	$0001
		dc.w	$F00F, $0014, $FFF0
Offset_0x03FE52:
		dc.w	$0001
		dc.w	$F80D, $0026, $FFF0
Offset_0x03FE5A:
		dc.w	$0001
		dc.w	$F00F, $0814, $FFF0
Offset_0x03FE62:
		dc.w	$0001
		dc.w	$F80D, $0826, $FFF0
Offset_0x03FE6A:
		dc.w	$0002
		dc.w	$F809, $002E, $FFEC
		dc.w	$0004, $0012, $0004
Offset_0x03FE78:
		dc.w	$0002
		dc.w	$0004, $0812, $FFEC
		dc.w	$F809, $082E, $FFFC
Offset_0x03FE86:
		dc.w	$0000
;===============================================================================
; Objeto 0x86 - Chefe na Launch Base
; <<<-
;===============================================================================