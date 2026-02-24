;===============================================================================
; Objeto 0xBB - Congelador na Icecap
; ->>>
;===============================================================================
; Offset_0x046CF2:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		move.l	#Offset_0x046D08, (A0)
		lea		Freezer_Setup_Data(PC), A1			   ; Offset_0x0470E6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x046D08:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x046D2C
		move.l	#Offset_0x046D30, (A0)
		clr.w	Obj_Timer(A0)					 ; $002E
		clr.w	Obj_Child_Data(A0)				 ; $0030
		clr.b	Obj_Control_Var_09(A0)					 ; $0039
		moveq	#Frost_Puff_Sfx, D0				  ; -$6F
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x046D2C:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x046D30:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x046D78
		subq.w	#$01, Obj_Child_Data(A0)				 ; $0030
		bpl.s	Offset_0x046D5C
		moveq	#$00, D0
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		bchg	#01, D0
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		move.w	Offset_0x046D90(PC, D0), Obj_Child_Data(A0)		 ; $0030
		move.w	Offset_0x046D94(PC, D0), D0
		jsr		Offset_0x046D94(PC, D0)
Offset_0x046D5C:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x046D74
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x046D74
		move.w	#$0001, Obj_Timer(A0)					 ; $002E
		bsr.w	Offset_0x046DBA
Offset_0x046D74:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
Offset_0x046D78:
		move.l	#Offset_0x046D08, (A0)
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#Stop_SFx, D0					  ; -$1D
		jsr		(Play_Music).l					 ; Offset_0x001176
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x046D90:
		dc.w	$0040, $0040
;-------------------------------------------------------------------------------
Offset_0x046D94:
		dc.w	Offset_0x046D98-Offset_0x046D94
		dc.w	Offset_0x046DA0-Offset_0x046D94
;-------------------------------------------------------------------------------
Offset_0x046D98:
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x046DA0:
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x047122(PC), A2
		btst	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x046DB6
		lea		Offset_0x04712A(PC), A2
Offset_0x046DB6:
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x046DBA:
		lea		Offset_0x047112(PC), A2
		btst	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x046DCA
		lea		Offset_0x04711A(PC), A2
Offset_0x046DCA:
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x046DCE:
		lea		Freezer_Setup_Data_2(PC), A1		   ; Offset_0x0470F2
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x046DDE, (A0)
Offset_0x046DDC:
		rts
;-------------------------------------------------------------------------------
Offset_0x046DDE:
		bsr.w	Offset_0x046F80
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		subq.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bpl.w	Offset_0x046DDC
		move.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x046DFA:
		move.l	#Offset_0x046E0E, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		lea		Freezer_Setup_Data(PC), A1			   ; Offset_0x0470E6
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x046E0E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x046E3E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x046E22
		rts
Offset_0x046E22:
		move.l	#Offset_0x046E2A, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x046E2A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x046E3E
		lea		Offset_0x04709A(PC), A1
		bra.w	Offset_0x047030
Offset_0x046E3E:
		move.l	#Offset_0x046E54, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x046E54:
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		lea		Offset_0x04709A(PC), A1
		bra.w	Offset_0x047030
;-------------------------------------------------------------------------------
Offset_0x046E60:
		lea		Freezer_Setup_Data_3(PC), A1		   ; Offset_0x0470FA
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x046EBE, (A0)
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_X(A1), D0					 ; $0010
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x046E94
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x046E94:
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		move.w	#$0200, D1
		cmp.w	Obj_X(A2), D0					 ; $0010
		bcc.s	Offset_0x046EA4
		neg.w	D1
Offset_0x046EA4:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x046EFA, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x046EBE:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x046ED8
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.l	#Offset_0x046ED8, (A0)
Offset_0x046ED8:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x046EFA
		bsr.w	Offset_0x0470A2
		bne.s	Offset_0x046F24
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x046EFA:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.l	A0, A2
		move.l	A1, A0
		jsr		(Hurt_Player).l				   ; Offset_0x00A3FA
		cmpi.b	#$18, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x046F22
		move.w	#$0200, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x046F1E
		neg.w	D0
Offset_0x046F1E:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x046F22:
		move.l	A2, A0
Offset_0x046F24:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Timer(A1)					 ; $002E
		move.b	#$78, Obj_Child(A1)				 ; $0034
		lea		Offset_0x04713A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x046F46:
		lea		Freezer_Setup_Data_4(PC), A1		   ; Offset_0x047106
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Animate_Raw_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB2
		move.l	#Offset_0x04718E, Obj_Child_Data(A0)			 ; $0030
		cmpi.b	#$08, Obj_Subtype(A0)					 ; $002C
		bcc.s	Offset_0x046F6C
		move.l	#Offset_0x047184, Obj_Child_Data(A0)			 ; $0030
Offset_0x046F6C:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.b	#$03, D0
		move.b	D0, Obj_Ani_Frame(A0)					 ; $0023
		moveq	#$0C, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x046F80:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x046FD8
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		moveq	#$00, D0
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		addq.b	#$04, D0
		cmpi.b	#$48, D0
		bcc.s	Offset_0x046FDA
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		lea		Offset_0x046FE4(PC, D0), A1
		move.b	(A1)+, Obj_Control_Var_13(A0)			 ; $0043
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		move.b	(A1)+, D2
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		and.b	D2, D0
		move.w	D2, D3
		lsr.b	#$01, D3
		sub.b	D3, D0
		move.b	D0, Obj_Control_Var_12(A0)				 ; $0042
		swap	D0
		and.b	D2, D0
		sub.b	D3, D0
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x046FD4
		neg.b	Obj_Control_Var_13(A0)					 ; $0043
Offset_0x046FD4:
		add.b	D0, Obj_Control_Var_13(A0)				 ; $0043
Offset_0x046FD8:
		rts
Offset_0x046FDA:
		jsr		(DeleteObject).l				   ; Offset_0x011138
		addq.w	#$04, A7
		rts
;-------------------------------------------------------------------------------
Offset_0x046FE4:
		dc.b	$10, $16, $03, $00
		dc.b	$10, $16, $03, $00
		dc.b	$14, $16, $03, $00
		dc.b	$18, $16, $03, $00
		dc.b	$1C, $16, $07, $00
		dc.b	$22, $17, $07, $00
		dc.b	$26, $17, $07, $00
		dc.b	$2E, $17, $07, $00
		dc.b	$32, $17, $07, $00
		dc.b	$3C, $18, $07, $00
		dc.b	$40, $18, $0F, $00
		dc.b	$4D, $19, $0F, $00
		dc.b	$52, $19, $0F, $00
		dc.b	$4B, $19, $0F, $00
		dc.b	$44, $19, $0F, $00
		dc.b	$42, $19, $0F, $00
		dc.b	$3E, $18, $0F, $00
		dc.b	$3B, $17, $0F, $00
		dc.b	$38, $16, $0F, $00
;-------------------------------------------------------------------------------
Offset_0x047030:
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x047098
		tst.w	D0
		beq.s	Offset_0x047042
		move.w	D0, A4
		bsr.w	Offset_0x04704A
Offset_0x047042:
		swap	D0
		tst.w	D0
		beq.s	Offset_0x047098
		move.w	D0, A4
Offset_0x04704A:
		tst.b	Obj_Timer(A4)					 ; $002E
		bne.s	Offset_0x047098
		btst	#$01, Obj_Timer_2(A4)					 ; $002F
		bne.s	Offset_0x047098
		tst.b	Obj_Child(A4)					 ; $0034
		bne.s	Offset_0x047098
		cmpi.b	#$04, Obj_Routine(A4)					 ; $0005
		bcc.s	Offset_0x047098
		move.b	#$81, Obj_Timer(A4)				 ; $002E
		move.b	#$1A, Obj_Ani_Number(A4)				 ; $0020
		bset	#$01, Obj_Status(A4)					 ; $002A
		clr.b	Obj_Control_Var_0D(A4)					 ; $003D
		clr.w	Obj_Speed_X(A4)					 ; $0018
		clr.w	Obj_Speed_Y(A4)					 ; $001A
		clr.w	Obj_Inertia(A4)					 ; $001C
		move.l	D0, D4
		lea		Offset_0x047132(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.l	D4, D0
		move.w	A4, Obj_Height_3(A1)					 ; $0044
Offset_0x047098:
		rts
;-------------------------------------------------------------------------------
Offset_0x04709A:
		dc.w	$FFF0, $0020, $FFD8, $0050
;-------------------------------------------------------------------------------
Offset_0x0470A2:
		lea		(Obj_Player_One).w, A3				 ; $FFFFB000
		cmpa.w	Obj_Height_3(A0), A3					 ; $0044
		bne.s	Offset_0x0470B0
		lea		(Obj_Player_Two).w, A3				 ; $FFFFB04A
Offset_0x0470B0:
		tst.w	Obj_Speed_Y(A3)					 ; $001A
		bmi.s	Offset_0x0470DA
		cmpi.b	#$02, Obj_Ani_Number(A3)				 ; $0020
		beq.s	Offset_0x0470C6
		cmpi.b	#$09, Obj_Ani_Number(A3)				 ; $0020
		bne.s	Offset_0x0470DA
Offset_0x0470C6:
		lea		Offset_0x0470DE(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x0470D8
		neg.w	Obj_Speed_Y(A3)					 ; $001A
		moveq	#$01, D0
Offset_0x0470D8:
		rts
Offset_0x0470DA:
		moveq	#$00, D0
		rts
;-------------------------------------------------------------------------------
Offset_0x0470DE:
		dc.w	$FFE4, $0038, $FFE8, $0030
;-------------------------------------------------------------------------------
Freezer_Setup_Data:							   ; Offset_0x0470E6
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$23B6, $0280
		dc.b	$10, $0C, $06, $9A
;-------------------------------------------------------------------------------
Freezer_Setup_Data_2:						   ; Offset_0x0470F2
		dc.w	$43B6, $0080
		dc.b	$0C, $0C, $16, $00
;-------------------------------------------------------------------------------
Freezer_Setup_Data_3:						   ; Offset_0x0470FA
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0080
		dc.b	$14, $10, $02, $00
;-------------------------------------------------------------------------------
Freezer_Setup_Data_4:						   ; Offset_0x047106
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0080
		dc.b	$04, $04, $0C, $00
;-------------------------------------------------------------------------------
Offset_0x047112:
		dc.w	$0000
		dc.l	Offset_0x046DCE
		dc.b	$00, $0C
;-------------------------------------------------------------------------------
Offset_0x04711A:
		dc.w	$0000
		dc.l	Offset_0x046DCE
		dc.b	$00, $F4
;-------------------------------------------------------------------------------
Offset_0x047122:
		dc.w	$0000
		dc.l	Offset_0x046DFA
		dc.b	$00, $30
;-------------------------------------------------------------------------------
Offset_0x04712A:
		dc.w	$0000
		dc.l	Offset_0x046DFA
		dc.b	$00, $D0
;-------------------------------------------------------------------------------
Offset_0x047132:
		dc.w	$0000
		dc.l	Offset_0x046E60
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x04713A:
		dc.w	$000B
		dc.l	Offset_0x046F46
		dc.b	$F4, $F8
		dc.l	Offset_0x046F46
		dc.b	$FC, $F8
		dc.l	Offset_0x046F46
		dc.b	$04, $F8
		dc.l	Offset_0x046F46
		dc.b	$0C, $F8
		dc.l	Offset_0x046F46
		dc.b	$F4, $00
		dc.l	Offset_0x046F46
		dc.b	$FC, $00
		dc.l	Offset_0x046F46
		dc.b	$04, $00
		dc.l	Offset_0x046F46
		dc.b	$0C, $00
		dc.l	Offset_0x046F46
		dc.b	$F4, $08
		dc.l	Offset_0x046F46
		dc.b	$FC, $08
		dc.l	Offset_0x046F46
		dc.b	$04, $08
		dc.l	Offset_0x046F46
		dc.b	$0C, $08
;-------------------------------------------------------------------------------
Offset_0x047184: ; Usado por este objeto (0xBB) e pelo objeto 0xBF
		dc.b	$00, $27, $23, $27, $13, $27, $24, $27
		dc.b	$14, $FC
;-------------------------------------------------------------------------------
Offset_0x04718E:  ; Usado por este objeto (0xBB) e pelo objetos 0xBE e 0xBF
		dc.b	$00, $27, $0C, $27, $0D, $27, $0E, $FC
;-------------------------------------------------------------------------------
Offset_0x047196: ; Usado pelo objeto 0xBE
		dc.b	$00, $27, $0F, $27, $10, $27, $11, $FC
;===============================================================================
; Objeto 0xBB - Congelador na Icecap
; <<<-
;===============================================================================