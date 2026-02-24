;===============================================================================
; Objeto 0xAE - Robotnik antes do Knuckles atirar a bomba na Launch Base 1
; ->>>
;===============================================================================
; Offset_0x048FAC:
		lea		Offset_0x048FDC(PC), A1
		jsr		Check_Camera_In_Range(PC)			   ; Offset_0x043392
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048FCC(PC, D0), D1
		jsr		Offset_0x048FCC(PC, D1)
		jsr		(Offset_0x04934C).l
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x048FCC:
		dc.w	Offset_0x048FE4-Offset_0x048FCC
		dc.w	Offset_0x049020-Offset_0x048FCC
		dc.w	Offset_0x049058-Offset_0x048FCC
		dc.w	Offset_0x049084-Offset_0x048FCC
		dc.w	Offset_0x0490A6-Offset_0x048FCC
		dc.w	Offset_0x0490CC-Offset_0x048FCC
		dc.w	Offset_0x0490FC-Offset_0x048FCC
		dc.w	Offset_0x04912E-Offset_0x048FCC
;-------------------------------------------------------------------------------
Offset_0x048FDC:
		dc.w	$0500, $05E0, $3820, $3AC0
;-------------------------------------------------------------------------------
Offset_0x048FE4:
		lea		Robotnik_Setup_Data(PC), A1			   ; Offset_0x049380
		jsr		(SetupObjectAttributes)				 ; Offset_0x041D72
		move.b	#$FF, Obj_Boss_Hit(A0)					 ; $0029
		jsr		(Swing_Setup)				   ; Offset_0x03669A
		move.w	#$3820, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		move.w	#$3AE8, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		moveq	#$60, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		(LBz_Robotnik_Ship_Data).l, A2		   ; Offset_0x03656E
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x049398(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x049020:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		Find_Other_Object(PC)		   ; Offset_0x04269E
		tst.w	D1
		beq.s	Offset_0x04904A
		cmpi.w	#$0070, D2
		bcc.s	Offset_0x049040
		cmpi.w	#$0060, D3
		bcc.s	Offset_0x049040
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x04904A
Offset_0x049040:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x04904A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x049058:
		cmpi.w	#$0300, Obj_Y(A0)				 ; $0014
		bcs.s	Offset_0x049066
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x049066:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.w	#$3EC0, Obj_X(A0)				 ; $0010
		move.w	#$01A0, Obj_Y(A0)				 ; $0014
		jmp		(Swing_Setup).l				   ; Offset_0x03669A
;-------------------------------------------------------------------------------
Offset_0x049084:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmpi.w	#$01C0, Obj_X(A1)				 ; $0010
		bcs.s	Offset_0x049098
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x04909A
Offset_0x049098:
		rts
Offset_0x04909A:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		st		(Boss_Attack_Started).w				 ; $FFFFFAA2
		rts
;-------------------------------------------------------------------------------
Offset_0x0490A6:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x0490B4
		tst.b	(Boss_Defeated_Flag).w				 ; $FFFFFAA3
		bne.s	Offset_0x0490B4
		rts
Offset_0x0490B4:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$3EA0, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x0490CC:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		cmpi.w	#$3E50, D0
		bcc.s	Offset_0x0490DA
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
Offset_0x0490DA:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcs.s	Offset_0x0490EE
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x0490EE:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0490FC:
		cmpi.w	#$012C, Obj_Y(A0)				 ; $0014
		bls.s	Offset_0x04910A
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x04910A:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0200, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		lea		(LBz_Robotnik_Ship_Data_2).l, A2		 ; Offset_0x03659E
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04912E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		cmpi.w	#$01B8, Obj_Y(A0)				 ; $0014
		bcc.s	Offset_0x04913E
		rts
Offset_0x04913E:
		move.l	#Offset_0x049152, (A0)
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		clr.b	(Boss_Attack_Started).w				 ; $FFFFFAA2
		clr.b	(Boss_Defeated_Flag).w				 ; $FFFFFAA3
		rts
;-------------------------------------------------------------------------------
Offset_0x049152:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(Offset_0x04934C).l
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x049162:
		move.l	#Offset_0x049172, (A0)
		lea		Offset_0x0493A0(PC), A2
		jmp		(SetupChildObject_Repeat).l		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x049172:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x049198
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04919C, Obj_Child(A0)			 ; $0034
		move.w	#$0160, Obj_Y(A0)				 ; $0014
Offset_0x049198:
		jmp		Refresh_Child_Position(PC)			   ; Offset_0x042016
;-------------------------------------------------------------------------------
Offset_0x04919C:
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x0493A8(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		Go_Delete_Object_A0_2(PC)			   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x0491AE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0491C2(PC, D0), D1
		jsr		Offset_0x0491C2(PC, D1)
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0491C2:
		dc.w	Offset_0x0491CE-Offset_0x0491C2
		dc.w	Offset_0x0491DC-Offset_0x0491C2
		dc.w	Offset_0x0491F4-Offset_0x0491C2
		dc.w	Offset_0x049202-Offset_0x0491C2
		dc.w	Offset_0x04924E-Offset_0x0491C2
		dc.w	Offset_0x049264-Offset_0x0491C2
;-------------------------------------------------------------------------------
Offset_0x0491CE:
		lea		Robotnik_Setup_Data_2(PC), A1		   ; Offset_0x04938C
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		bra.w	Offset_0x04927C
;-------------------------------------------------------------------------------
Offset_0x0491DC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x0491EC
		jmp		Refresh_Child_Position(PC)			   ; Offset_0x042016
Offset_0x0491EC:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0491F4:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x049200
		move.b	#$06, Obj_Routine(A0)					 ; $0005
Offset_0x049200:
		rts
;-------------------------------------------------------------------------------
Offset_0x049202:
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x049208:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		subi.w	#$000C, D0
		move.w	Offset_0x049246(PC, D0), Obj_Speed_Y(A0)		 ; $001A
		add.w	D0, D0
		move.l	Offset_0x049236(PC, D0), Obj_Child_Data(A0)		 ; $0030
		move.l	#Offset_0x04926A, Obj_Child(A0)			 ; $0034
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x049236:
		dc.l	Offset_0x0493BA
		dc.l	Offset_0x0493BA
		dc.l	Offset_0x0493BF
		dc.l	Offset_0x0493BF
;-------------------------------------------------------------------------------
Offset_0x049246:
		dc.w	$FFC0, $0040, $FFC0, $0040
;-------------------------------------------------------------------------------
Offset_0x04924E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x04925C
		rts
Offset_0x04925C:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x049264:
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x04926A:
		move.l	#Offset_0x049278, (A0)
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		rts
;-------------------------------------------------------------------------------
Offset_0x049278:
		jmp		MarkObjectGone(PC)		; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x04927C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0492C0(PC, D0), Obj_Timer(A0)			 ; $002E
		add.w	D0, D0
		move.l	Offset_0x0492D4(PC, D0), Obj_Child_Data(A0)		 ; $0030
		move.l	Offset_0x0492FC(PC, D0), Obj_Child(A0)			 ; $0034
		lea		Offset_0x049324(PC), A1
		adda.w	D0, A1
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		move.b	(A1)+, D1
		or.b	D1, Obj_Flags(A0)				 ; $0004
		move.b	(A1)+, D1
		move.b	D1, Obj_Control_Var_12(A0)				 ; $0042
		ext.w	D1
		add.w	D1, Obj_X(A0)					 ; $0010
		move.b	(A1)+, D1
		move.b	D1, Obj_Control_Var_13(A0)				 ; $0043
		ext.w	D1
		add.w	D1, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0492C0:
		dc.w	$0000, $0000, $0010, $0010, $0010, $0010, $0040, $0050
		dc.w	$0070, $0060
;-------------------------------------------------------------------------------
Offset_0x0492D4:
		dc.l	Offset_0x0493B0
		dc.l	Offset_0x0493B0
		dc.l	Offset_0x0493B5
		dc.l	Offset_0x0493B5
		dc.l	Offset_0x0493B5
		dc.l	Offset_0x0493B5
		dc.l	Offset_0x0493C4
		dc.l	Offset_0x0493C4
		dc.l	Offset_0x0493C8
		dc.l	Offset_0x0493C8
;-------------------------------------------------------------------------------
Offset_0x0492FC:
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Go_Delete_Object_A0			   ; Offset_0x042D3E
		dc.l	Offset_0x049208
		dc.l	Offset_0x049208
		dc.l	Offset_0x049208
		dc.l	Offset_0x049208
;-------------------------------------------------------------------------------
Offset_0x049324:
		dc.b	$06, $00, $F0, $00
		dc.b	$06, $02, $10, $00
		dc.b	$09, $00, $00, $14
		dc.b	$09, $01, $00, $0C
		dc.b	$09, $00, $00, $F4
		dc.b	$09, $01, $00, $EC
		dc.b	$00, $00, $F4, $F0
		dc.b	$00, $03, $0C, $10
		dc.b	$03, $00, $14, $F4
		dc.b	$03, $03, $EC, $0C
;-------------------------------------------------------------------------------
Offset_0x04934C:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x04937E
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x04936C
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#sfx_BossHit, D0
		jsr		(Play_Music).l					 ; Offset_0x001176
		bset	#$06, Obj_Status(A0)					 ; $002A
Offset_0x04936C:
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x04937E
		bclr	#$06, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x04937E:
		rts
;-------------------------------------------------------------------------------
Robotnik_Setup_Data:						   ; Offset_0x049380
		dc.l	Robotnik_Ship_Mappings		   ; Offset_0x10D020
		dc.w	$052E, $0100
		dc.b	$20, $20, $0A, $0F
;-------------------------------------------------------------------------------
Robotnik_Setup_Data_2:						   ; Offset_0x04938C
		dc.l	Twin_Hammer_Box_Mappings			   ; Offset_0x10D332
		dc.w	$4446, $0200
		dc.b	$14, $14, $00, $00
;-------------------------------------------------------------------------------
Offset_0x049398:
		dc.w	$0000
		dc.l	Offset_0x049162
		dc.b	$00, $34
;-------------------------------------------------------------------------------
Offset_0x0493A0:
		dc.w	$0009
		dc.l	Offset_0x0491AE
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x0493A8:
		dc.w	$0000
		dc.l	Obj_0x85_LBz_Twin_Hammer			   ; Offset_0x03EC12
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x0493B0:
		dc.b	$00, $06, $07, $08, $F4
;-------------------------------------------------------------------------------
Offset_0x0493B5:
		dc.b	$00, $09, $0A, $0B, $F4
;-------------------------------------------------------------------------------
Offset_0x0493BA:
		dc.b	$05, $00, $01, $02, $F4
;-------------------------------------------------------------------------------
Offset_0x0493BF:
		dc.b	$05, $03, $04, $05, $F4
;-------------------------------------------------------------------------------
Offset_0x0493C4:
		dc.b	$00, $00, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x0493C8:
		dc.b	$00, $03, $03, $F4
;===============================================================================
; Objeto 0xAE - Robotnik antes do Knuckles atirar a bomba na Launch Base 1
; <<<-
;===============================================================================