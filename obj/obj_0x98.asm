;===============================================================================
; Objeto 0x98 - Mini chefe na Sandopolis
; ->>>
;===============================================================================
; Offset_0x04107E:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x041094(PC, D0), D1
		jsr		Offset_0x041094(PC, D1)
		bsr.w	Offset_0x04166C
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x041094:
		dc.w	Offset_0x0410B0-Offset_0x041094
		dc.w	Offset_0x0410E4-Offset_0x041094
		dc.w	Offset_0x041118-Offset_0x041094
		dc.w	Offset_0x041142-Offset_0x041094
		dc.w	Offset_0x04117A-Offset_0x041094
		dc.w	Offset_0x0411A0-Offset_0x041094
		dc.w	Offset_0x0411E8-Offset_0x041094
		dc.w	Offset_0x041228-Offset_0x041094
		dc.w	Offset_0x041288-Offset_0x041094
		dc.w	Offset_0x0412C0-Offset_0x041094
		dc.w	Offset_0x0412E0-Offset_0x041094
		dc.w	Offset_0x041332-Offset_0x041094
		dc.w	Offset_0x041364-Offset_0x041094
		dc.w	Offset_0x0413BA-Offset_0x041094
;-------------------------------------------------------------------------------
Offset_0x0410B0:
		lea		Guardian_Setup_Data(PC), A1			   ; Offset_0x0416C2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$3C, Obj_Height_2(A0)					 ; $001E
		lea		(Guardian_Palette).l, A1		 ; Offset_0x041700
		lea		(Palette_Row_1_Offset).w, A2		 ; $FFFFED20
		moveq	#$07, D6
Offset_0x0410CA:
		move.l	(A1)+, (A2)+
		dbra	D6, Offset_0x0410CA
		lea		(Guardian_Palette_2).l, A1		 ; Offset_0x041720
		lea		(Palette_Row_1_Data_Target).w, A2			 ; $FFFFEDA0
		moveq	#$07, D6
Offset_0x0410DC:
		move.l	(A1)+, (A2)+
		dbra	D6, Offset_0x0410DC
		rts
;-------------------------------------------------------------------------------
Offset_0x0410E4:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		move.w	#$0770, D5
		cmp.w	D5, D0
		bcc.s	Offset_0x0410F2
		rts
Offset_0x0410F2:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04111C, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x041116:
		rts
;-------------------------------------------------------------------------------
Offset_0x041118:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04111C:
		moveq	#Mini_Boss_Snd, D0				   ; $18
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04113A, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0416F8(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04113A:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x041142:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcs.s	Offset_0x04114E
		rts
Offset_0x04114E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		beq.s	Offset_0x041164
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x041164:
		move.w	#$003E, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04117E, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0416E8(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04117A:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04117E:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0411AA, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0416E0(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x0411A0:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0411AA:
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0411BE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0411BE:
		move.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0411D4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0411D4:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041218, Obj_Child(A0)			 ; $0034
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0411E8:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		lea		Offset_0x04174B(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x041216
		bmi.s	Offset_0x041216
		move.b	Obj_Map_Id(A0), Obj_Control_Var_09(A0)	  ; $0022, $0039
		cmpi.b	#$07, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x041210
		move.w	#$FA00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x041210:
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x041216:
		rts
;-------------------------------------------------------------------------------
Offset_0x041218:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04123C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x041228:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x041116
		jmp		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x04123C:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Control_Var_0A(A0)			 ; $003A
		move.l	#Offset_0x041758, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0412A8, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04125A:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041758, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0412CC, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x041272:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$3C, Obj_Height_2(A0)					 ; $001E
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x041288:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x0412A6
		bmi.s	Offset_0x0412A6
		move.b	Obj_Map_Id(A0), Obj_Control_Var_09(A0)	  ; $0022, $0039
		move.b	Obj_Control_Var_0A(A0), Obj_Map_Id(A0)	  ; $003A, $0022
		lea		Offset_0x041658(PC), A1
		bsr.w	Offset_0x041634
Offset_0x0412A6:
		rts
;-------------------------------------------------------------------------------
Offset_0x0412A8:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04176B, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0412C4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0412C0:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x0412C4:
		lea		Offset_0x0416F0(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x0412CC:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x0412E0:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x041312
		jsr		Find_Player(PC)				   ; Offset_0x042634
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0412F4
		subq.w	#$02, D0
Offset_0x0412F4:
		tst.w	D0
		bne.s	Offset_0x0412FA
		rts
Offset_0x0412FA:
		move.b	#$16, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041740, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x04135C, Obj_Child(A0)			 ; $0034
		rts
Offset_0x041312:
		move.b	#$18, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041770, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x041398, Obj_Child(A0)			 ; $0034
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x041332:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		jsr		Animate_Raw_Multi_Delay_Flip_X(PC)	   ; Offset_0x0421CE
		tst.w	D2
		beq.s	Offset_0x04135A
		bmi.s	Offset_0x04135A
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$09, D0
		bne.s	Offset_0x04135A
		move.b	#$19, Obj_Map_Id(A0)					 ; $0022
Offset_0x04135A:
		rts
;-------------------------------------------------------------------------------
Offset_0x04135C:
		move.b	#$14, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x041364:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x041396
		bmi.s	Offset_0x041396
		move.b	Obj_Map_Id(A0), Obj_Control_Var_09(A0)	  ; $0022, $0039
		cmpi.b	#$07, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x041388
		move.w	#$FA00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x041388:
		move.b	Obj_Control_Var_0A(A0), Obj_Map_Id(A0)	  ; $003A, $0022
		lea		Offset_0x041658(PC), A1
		bsr.w	Offset_0x041634
Offset_0x041396:
		rts
;-------------------------------------------------------------------------------
Offset_0x041398:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04125A, Obj_Child(A0)			 ; $0034
		move.w	#$0080, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x0413B4
		neg.w	D0
Offset_0x0413B4:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x0413BA:
		rts
;-------------------------------------------------------------------------------
Offset_0x0413BC:
		lea		Guardian_Setup_Data_2(PC), A1		   ; Offset_0x0416CE
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0413CA, (A0)
Offset_0x0413CA:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$08, D0
		btst	#$06, Obj_Status(A1)					 ; $002A
		bne.w	Run_Flicker_Move			   ; Offset_0x0424F4
		bsr.w	Offset_0x041482
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x0413E2:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0413F8(PC, D0), D1
		jsr		Offset_0x0413F8(PC, D1)
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x0413F8:
		dc.w	Offset_0x0413FE-Offset_0x0413F8
		dc.w	Offset_0x041406-Offset_0x0413F8
		dc.w	AnimateRaw-Offset_0x0413F8			  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x0413FE:
		lea		Guardian_Setup_Data_4(PC), A1		   ; Offset_0x0416DA
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x041406:
		move.b	Obj_Boss_Hit(A0), D0					 ; $0029
		bne.s	Offset_0x04140E
		rts
Offset_0x04140E:
		andi.w	#$0003, D0
		add.w	D0, D0
		move.w	Offset_0x041446-$02(PC, D0), A2
		neg.w	Obj_Speed_X(A2)					 ; $0018
		neg.w	Obj_Speed_Y(A2)					 ; $001A
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041783, Obj_Child_Data(A0)			 ; $0030
		move.l	#DeleteObject, Obj_Child(A0)	; Offset_0x011138, $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$06, Obj_Status(A1)					 ; $002A
		move.w	A2, Obj_Height_3(A1)					 ; $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x041446:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	Obj_Player_One					 ; $B000
;-------------------------------------------------------------------------------
Offset_0x04144C:
		lea		Guardian_Setup_Data_3(PC), A1		   ; Offset_0x0416D4
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x04146C
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x04146C:
		move.l	#Delete_Sprite_Timed_Or_Speed, (A0)	   ; Offset_0x042942
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x041482:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0414E4(PC, D0), D1
		lea		Offset_0x0414E4(PC, D1), A1
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		moveq	#$00, D1
		move.b	Obj_Control_Var_09(A2), D1				 ; $0039
		andi.b	#$3F, D1
		lsl.w	#$02, D1
		adda.w	D1, A1
		move.b	(A1)+, D2
		ext.w	D2
		move.b	(A1)+, D3
		ext.w	D3
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x0414C4
		bset	#$00, Obj_Flags(A0)				 ; $0004
		neg.w	D2
Offset_0x0414C4:
		tst.b	(A1)
		beq.s	Offset_0x0414CE
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x0414CE:
		move.w	Obj_X(A2), D1					 ; $0010
		add.w	D2, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	Obj_Y(A2), D1					 ; $0014
		add.w	D3, D1
		move.w	D1, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0414E4:
		dc.w	Offset_0x0414F4-Offset_0x0414E4
		dc.w	Offset_0x04151C-Offset_0x0414E4
		dc.w	Offset_0x041544-Offset_0x0414E4
		dc.w	Offset_0x04156C-Offset_0x0414E4
		dc.w	Offset_0x041594-Offset_0x0414E4
		dc.w	Offset_0x0415BC-Offset_0x0414E4
		dc.w	Offset_0x0415E4-Offset_0x0414E4
		dc.w	Offset_0x04160C-Offset_0x0414E4
Offset_0x0414F4:
		dc.b	$00, $F8, $15, $00, $00, $F8, $15, $00
		dc.b	$00, $F8, $15, $00, $00, $F8, $15, $00
		dc.b	$00, $F8, $15, $00, $FF, $F7, $15, $00
		dc.b	$FE, $F6, $15, $00, $FD, $F5, $15, $00
		dc.b	$FC, $F4, $15, $00, $00, $F8, $16, $00
Offset_0x04151C:
		dc.b	$F4, $14, $06, $00, $F4, $14, $06, $00
		dc.b	$F4, $14, $06, $00, $F4, $14, $06, $00
		dc.b	$F5, $14, $06, $00, $EC, $0D, $07, $00
		dc.b	$E0, $00, $08, $00, $E4, $F6, $09, $00
		dc.b	$E0, $EC, $0A, $00, $F8, $14, $0B, $00
Offset_0x041544:
		dc.b	$00, $04, $17, $00, $00, $04, $17, $00
		dc.b	$00, $04, $17, $00, $00, $04, $17, $00
		dc.b	$01, $04, $17, $00, $FC, $02, $17, $00
		dc.b	$F8, $00, $17, $00, $F4, $FE, $17, $00
		dc.b	$F0, $F8, $17, $00, $00, $04, $17, $00
Offset_0x04156C:
		dc.b	$00, $28, $0C, $01, $FF, $28, $0C, $01
		dc.b	$F8, $20, $0C, $01, $F3, $1A, $0C, $01
		dc.b	$F2, $19, $0C, $01, $F3, $1A, $0C, $01
		dc.b	$F8, $20, $0C, $01, $FF, $28, $0C, $01
		dc.b	$00, $28, $0C, $01, $00, $28, $0F, $01
Offset_0x041594:
		dc.b	$00, $14, $0C, $00, $02, $14, $0C, $00
		dc.b	$FC, $10, $0D, $00, $FE, $0E, $0E, $00
		dc.b	$FE, $0E, $0E, $00, $FE, $0E, $0E, $00
		dc.b	$FC, $10, $0D, $00, $02, $14, $0C, $00
		dc.b	$00, $14, $0C, $00, $00, $14, $0F, $00
Offset_0x0415BC:
		dc.b	$F8, $1C, $17, $00, $FA, $1C, $17, $00
		dc.b	$F6, $14, $17, $00, $F2, $0E, $17, $00
		dc.b	$F2, $0E, $17, $00, $F2, $0E, $17, $00
		dc.b	$F6, $14, $17, $00, $FA, $1C, $17, $00
		dc.b	$F8, $1C, $17, $00, $FC, $1C, $17, $00
Offset_0x0415E4:
		dc.b	$FC, $34, $10, $00, $FB, $34, $10, $00
		dc.b	$F4, $2C, $10, $00, $EF, $26, $10, $00
		dc.b	$EE, $25, $10, $00, $EF, $26, $10, $00
		dc.b	$F4, $2C, $10, $00, $FB, $34, $10, $00
		dc.b	$FC, $34, $10, $00, $FC, $34, $11, $00
Offset_0x04160C:
		dc.b	$00, $14, $03, $00, $02, $14, $03, $00
		dc.b	$02, $14, $03, $00, $02, $14, $03, $00
		dc.b	$02, $14, $03, $00, $02, $14, $03, $00
		dc.b	$02, $14, $03, $00, $02, $14, $03, $00
		dc.b	$00, $14, $03, $00, $00, $14, $03, $00
;-------------------------------------------------------------------------------
Offset_0x041634:
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		adda.w	D0, A1
		move.b	(A1)+, D0
		ext.w	D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x04164A
		neg.w	D0
Offset_0x04164A:
		add.w	D0, Obj_X(A0)					 ; $0010
		move.b	(A1)+, D0
		ext.w	D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x041658:
		dc.b	$00, $00, $01, $00, $07, $08, $05, $06
		dc.b	$01, $01, $FF, $FF, $FB, $FA, $F9, $F8
		dc.b	$FF, $00, $00, $00
;-------------------------------------------------------------------------------
Offset_0x04166C:
		btst	#$06, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x041676
		rts
Offset_0x041676:
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x041272, Obj_Child(A0)			 ; $0034
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		moveq	#$00, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.b	D0, Obj_Ani_Frame(A0)					 ; $0023
		move.b	D0, Obj_Ani_Time(A0)					 ; $0024
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	#$0200, D0
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bmi.s	Offset_0x0416B6
		neg.w	D0
Offset_0x0416B6:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Guardian_Setup_Data:						   ; Offset_0x0416C2
		dc.l	Guardian_Mappings			   ; Offset_0x10E792
		dc.w	$2400, $0280
		dc.b	$24, $34, $00, $A8
;-------------------------------------------------------------------------------
Guardian_Setup_Data_2:						   ; Offset_0x0416CE
		dc.w	$0200
		dc.b	$14, $14, $00, $00
;-------------------------------------------------------------------------------
Guardian_Setup_Data_3:						   ; Offset_0x0416D4
		dc.w	$0200
		dc.b	$34, $34, $18, $00
;-------------------------------------------------------------------------------
Guardian_Setup_Data_4:						   ; Offset_0x0416DA
		dc.w	$0200
		dc.b	$0C, $10, $1A, $D7
;-------------------------------------------------------------------------------
Offset_0x0416E0:
		dc.w	$0007
		dc.l	Offset_0x0413BC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x0416E8:
		dc.w	$0000
		dc.l	Offset_0x04144C
		dc.b	$00, $40
;-------------------------------------------------------------------------------
Offset_0x0416F0:
		dc.w	$0000
		dc.l	Offset_0x0413E2
		dc.b	$F4, $E4
;-------------------------------------------------------------------------------
Offset_0x0416F8:
		dc.w	$0000
		dc.l	Obj_Fade_Selected_From_Black		   ; Offset_0x042EE8
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Guardian_Palette:							   ; Offset_0x041700
		dc.w	$0000, $0000, $0000, $0000, $0000, $00EE, $0088, $0000
		dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0222
;-------------------------------------------------------------------------------
Guardian_Palette_2:							   ; Offset_0x041720
		dc.w	$0000, $0EEE, $0AEE, $08AC, $068A, $00EE, $0088, $0000
		dc.w	$0000, $0000, $0000, $0020, $0468, $0244, $0022, $0222
;-------------------------------------------------------------------------------
Offset_0x041740:
		dc.b	$00, $09, $00, $1F, $09, $09, $49, $09
		dc.b	$00, $09, $F4
;-------------------------------------------------------------------------------
Offset_0x04174B:
		dc.b	$00, $09, $00, $09, $05, $04, $06, $04
		dc.b	$07, $04, $08, $01, $F4
;-------------------------------------------------------------------------------
Offset_0x041758:
		dc.b	$08, $04, $07, $04, $06, $04, $05, $04
		dc.b	$04, $04, $03, $09, $02, $09, $01, $09
		dc.b	$00, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x04176B:
		dc.b	$0F, $00, $19, $01, $F4
;-------------------------------------------------------------------------------
Offset_0x041770:
		dc.b	$00, $04, $01, $04, $02, $04, $03, $04
		dc.b	$04, $04, $05, $09, $06, $09, $07, $05
		dc.b	$08, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x041783:
		dc.b	$03, $12, $12, $13, $14, $F4, $00
;===============================================================================
; Objeto 0x98 - Mini chefe na Sandopolis
; <<<-
;===============================================================================