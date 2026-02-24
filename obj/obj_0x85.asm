;===============================================================================
; Objeto 0x85 - Mini chefe na Launch Base
; ->>>
;===============================================================================
; Offset_0x03EC12:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03EC28(PC, D0), D1
		jsr		Offset_0x03EC28(PC, D1)
		bsr.w	Offset_0x03EFB8
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03EC28:
		dc.w	Offset_0x03EC34-Offset_0x03EC28
		dc.w	Offset_0x03EC76-Offset_0x03EC28
		dc.w	Offset_0x03EC96-Offset_0x03EC28
		dc.w	Offset_0x03ECDC-Offset_0x03EC28
		dc.w	Offset_0x03ECF8-Offset_0x03EC28
		dc.w	Offset_0x03ED24-Offset_0x03EC28
;-------------------------------------------------------------------------------
Offset_0x03EC34:
		lea		Twin_Hammer_Setup_Data(PC), A1		   ; Offset_0x03F0B6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$06, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03EC7A, Obj_Child(A0)			 ; $0034
		lea		Twin_Hammer_Pallete(PC), A1			   ; Offset_0x03F0FA
		jsr		Pal_Load_Line_1(PC)			   ; Offset_0x04314C
		lea		Offset_0x03F0CE(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x03F0D6(PC), A2
		jsr		Load_Child_Object_Link_List_Repeat_A2(PC) ; Offset_0x041EA0
		lea		Offset_0x03F0DC(PC), A2
		jmp		Load_Child_Object_Link_List_Repeat_A2(PC) ; Offset_0x041EA0
;-------------------------------------------------------------------------------
Offset_0x03EC76:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03EC7A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03ECA0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03EC96:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03ECA0:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		lea		(Offset_0x03F0E2).l, A1
		lea		(Boss_Data_Buffer+$02).w, A2		 ; $FFFFFA82
		moveq	#$05, D6
Offset_0x03ECB8:
		move.b	(A1)+, (A2)+
		dbra	D6, Offset_0x03ECB8
		move.l	#(Boss_Data_Buffer+$02), Obj_Child_Data(A0) ; $FFFFFA82, $0030
		move.b	#$10, Obj_Ani_Time(A0)					 ; $0024
		move.l	#Offset_0x03ECE4, Obj_Child(A0)			 ; $0034
Offset_0x03ECD4:
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03ECDC:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03ECE4:
		lea		(Boss_Data_Buffer+$02).w, A1		 ; $FFFFFA82
		subq.b	#$01, (A1)
		cmpi.b	#$02, (A1)
		bhi.s	Offset_0x03ECD4
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
Offset_0x03ECF8:
		move.w	(Vint_runcount+$02).w, D0		  ; $FFFFFE0E
		andi.w	#$0003, D0
		bne.s	Offset_0x03ED1C
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		Find_Other_Object(PC)		   ; Offset_0x04269E
		move.w	Offset_0x03ED20(PC, D0), Obj_Speed_X(A0)		 ; $0018
		move.w	Offset_0x03ED20(PC, D1), Obj_Speed_Y(A0)		 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x03ED1C:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x03ED20:
		dc.w	$FF00, $0100
;-------------------------------------------------------------------------------
Offset_0x03ED24:
		rts
;-------------------------------------------------------------------------------
Offset_0x03ED26:
		jmp		(Obj_Load_End_Level_Art)			   ; Offset_0x043302
;-------------------------------------------------------------------------------
Offset_0x03ED2C:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03ED42(PC, D0), D1
		jsr		Offset_0x03ED42(PC, D1)
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03ED42:
		dc.w	Offset_0x03ED48-Offset_0x03ED42
		dc.w	Offset_0x03ED5A-Offset_0x03ED42
		dc.w	Offset_0x03ED78-Offset_0x03ED42
;-------------------------------------------------------------------------------
Offset_0x03ED48:
		lea		Twin_Hammer_Setup_Data_2(PC), A1	   ; Offset_0x03F0C2
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03F0E8, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03ED5A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03ED68
		rts
Offset_0x03ED68:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x03F0E8, Obj_Child_Data(A0)			  ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x03ED78:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x03ED7C:
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03ED82:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x03ED9E(PC, D0), D1
		jsr		Offset_0x03ED9E(PC, D1)
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03ED9A
		jmp		Offset_0x03F02E(PC)
Offset_0x03ED9A:
		jmp		Offset_0x03F064(PC)
;-------------------------------------------------------------------------------
Offset_0x03ED9E:
		dc.w	Offset_0x03EDAA-Offset_0x03ED9E
		dc.w	Offset_0x03EDE4-Offset_0x03ED9E
		dc.w	Offset_0x03EE0E-Offset_0x03ED9E
		dc.w	Offset_0x03EE68-Offset_0x03ED9E
		dc.w	Offset_0x03EE92-Offset_0x03ED9E
		dc.w	Offset_0x03EF0E-Offset_0x03ED9E
;-------------------------------------------------------------------------------
Offset_0x03EDAA:
		lea		Twin_Hammer_Setup_Data_3(PC), A1	   ; Offset_0x03F0C8
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	#$0100, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03EDFA, Obj_Child(A0)			 ; $0034
		move.b	#$04, Obj_Control_Var_0D(A0)			 ; $003D
		move.w	#$0005, Obj_Control_Var_0E(A0)			 ; $003E
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03EDE0
		move.w	#$0004, Obj_Control_Var_0E(A0)			 ; $003E
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03EDE0:
		bra.w	Offset_0x03EF2A
;-------------------------------------------------------------------------------
Offset_0x03EDE4:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03EDEE
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
Offset_0x03EDEE:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03EDFA:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bsr.w	Offset_0x03EF84
		move.l	#Offset_0x03EE36, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03EE0E:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03EE2C
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jsr		(Move_Sprite_Circular_Simple).l		   ; Offset_0x0426E2
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x03EE2C:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		(Move_Sprite_Circular_Simple).l		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03EE36:
		bsr.w	Offset_0x03EF9E
		move.l	#Offset_0x03EEA6, Obj_Child(A0)			 ; $0034
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03EE60
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
		rts
Offset_0x03EE60:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03EE68:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jsr		(Move_Sprite_Circular_Simple).l		   ; Offset_0x0426E2
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03EE8A
		rts
Offset_0x03EE8A:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03EE92:
		move.b	Obj_Control_Var_0D(A0), D0				 ; $003D
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03EEA6:
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		neg.b	Obj_Control_Var_0D(A0)					 ; $003D
		bsr.w	Offset_0x03EDFA
		cmpi.b	#$0A, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x03EED6
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03EDFA, Obj_Child(A0)			 ; $0034
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03EED6:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		moveq	#$00, D1
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03EEEA
		addq.w	#$08, D1
Offset_0x03EEEA:
		tst.b	Obj_Control_Var_0D(A0)					 ; $003D
		bpl.s	Offset_0x03EEF2
		addq.w	#$04, D1
Offset_0x03EEF2:
		move.l	Offset_0x03EEFE(PC, D1), A1
		move.b	(A1, D0), Obj_Control_Var_0C(A0)		 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x03EEFE:
		dc.l	Offset_0x03EF6C
		dc.l	Offset_0x03EF72
		dc.l	Offset_0x03EF78
		dc.l	Offset_0x03EF7E
;-------------------------------------------------------------------------------
Offset_0x03EF0E:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03EF1A:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03EF2A:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03EF5A(PC, D0), Obj_Priority(A0)		 ; $0008
		lsr.w	#$01, D0
		move.b	Offset_0x03EF66(PC, D0), Obj_Map_Id(A0)			 ; $0022
		move.b	Offset_0x03EF6C(PC, D0), Obj_Control_Var_0C(A0)	 ; $003C
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x03EF52
		move.b	Offset_0x03EF78(PC, D0), Obj_Control_Var_0C(A0)	 ; $003C
Offset_0x03EF52:
		move.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		jmp		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
;-------------------------------------------------------------------------------
Offset_0x03EF5A:
		dc.w	$0300, $0380, $0300, $0380, $0300, $0280
;-------------------------------------------------------------------------------
Offset_0x03EF66:
		dc.b	$07, $08, $07, $08, $07, $06
;-------------------------------------------------------------------------------
Offset_0x03EF6C:
		dc.b	$55, $00, $D5, $AA, $80, $68
;-------------------------------------------------------------------------------
Offset_0x03EF72:
		dc.b	$2A, $7A, $B0, $DA, $00, $18
;-------------------------------------------------------------------------------
Offset_0x03EF78:
		dc.b	$D5, $80, $55, $2A, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x03EF7E:
		dc.b	$AA, $00, $2A, $55, $80, $8C
;-------------------------------------------------------------------------------
Offset_0x03EF84:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03EF92(PC, D0), Obj_Timer(A0)			 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03EF92:
		dc.w	$0000, $0014, $0009, $0009, $0009, $0005
;-------------------------------------------------------------------------------
Offset_0x03EF9E:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03EFAC(PC, D0), Obj_Timer(A0)			 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03EFAC:
		dc.w	$0034, $0014, $0009, $0009, $0009, $0003
;-------------------------------------------------------------------------------
Offset_0x03EFB8:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03F00E
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x03F010
		cmpi.b	#$03, Obj_Boss_Hit(A0)					 ; $0029
		bne.s	Offset_0x03EFD2
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03EFD2:
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03EFF2
		move.b	Obj_Routine(A0), Obj_Control_Var_0A(A0)	  ; $0005, $003A
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03EFF2:
		jsr		Hit_Boss_Flash(PC)			   ; Offset_0x04297A
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03F00E
		move.b	Obj_Control_Var_0A(A0), Obj_Routine(A0)	  ; $003A, $0005
		move.w	#$0EEE, (Palette_Row_1_Offset+$02).w		 ; $FFFFED22
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03F00E:
		rts
Offset_0x03F010:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03ED26, Obj_Child(A0)			 ; $0034
		lea		(Offset_0x041D62).l, A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03F02E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03F04E
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03F04A
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03F04E
Offset_0x03F04A:
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
Offset_0x03F04E:
		move.w	Obj_Height_3(A0), D0					 ; $0044
		beq.s	Offset_0x03F05C
		move.w	D0, A1
		bset	#$07, Obj_Status(A1)					 ; $002A
Offset_0x03F05C:
		bsr.w	Offset_0x03F070
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x03F064:
		btst	#$07, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x03F04E
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
Offset_0x03F070:
		move.l	#Offset_0x03EF1A, (A0)
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	#$0080, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		lea		Offset_0x03F09E(PC, D0), A1
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x03F09E:
		dc.w	$0100, $FF00, $FE00, $FE00, $0300, $FE00, $0200, $FF00
		dc.w	$FF00, $FE00, $FF80, $FF00
;-------------------------------------------------------------------------------
Twin_Hammer_Setup_Data:						   ; Offset_0x03F0B6
		dc.l	Twin_Hammer_Mappings		   ; Offset_0x10D290
		dc.w	$241C, $0280
		dc.b	$20, $20, $00, $06
;-------------------------------------------------------------------------------
Twin_Hammer_Setup_Data_2:					   ; Offset_0x03F0C2
		dc.w	$0200
		dc.b	$20, $20, $03, $00
;-------------------------------------------------------------------------------
Twin_Hammer_Setup_Data_3:					   ; Offset_0x03F0C8
		dc.w	$0180
		dc.b	$08, $08, $06, $98
;-------------------------------------------------------------------------------
Offset_0x03F0CE:
		dc.w	$0000
		dc.l	Offset_0x03ED2C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03F0D6:
		dc.w	$0005
		dc.l	Offset_0x03ED82
;-------------------------------------------------------------------------------
Offset_0x03F0DC:
		dc.w	$0005
		dc.l	Offset_0x03ED7C
;-------------------------------------------------------------------------------
Offset_0x03F0E2:
		dc.b	$0F, $00, $01, $00, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03F0E8:
		dc.b	$07, $03, $04, $05, $F8
;-------------------------------------------------------------------------------
; Offset_0x03F0ED:
		dc.b	$06, $3F, $05, $05, $05, $F8
;-------------------------------------------------------------------------------
; Offset_0x03F0F3:
		dc.b	$06, $07, $05, $04, $03, $04, $FC
;-------------------------------------------------------------------------------
Twin_Hammer_Pallete:						   ; Offset_0x03F0FA
		dc.w	$0000, $0EEE, $0CCC, $0888, $0666, $00EE, $0088, $0224
		dc.w	$00CE, $00AE, $004A, $0222, $0AAA, $0864, $0642, $0044
;===============================================================================
; Objeto 0x85 - Mini chefe na Launch Base
; <<<-
;===============================================================================