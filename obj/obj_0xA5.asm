;===============================================================================
; Objeto 0xA5 - Inimigo Spiker na Marble Garden
; ->>>
;===============================================================================
; Offset_0x045864:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$0A, D0
		bsr.w	Offset_0x045A94
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045882(PC, D0), D1
		jsr		Offset_0x045882(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x045882:
		dc.w	Offset_0x04588E-Offset_0x045882
		dc.w	Offset_0x04589E-Offset_0x045882
		dc.w	Offset_0x0458C0-Offset_0x045882
		dc.w	Offset_0x0458D6-Offset_0x045882
		dc.w	Offset_0x0458FE-Offset_0x045882
		dc.w	Offset_0x04590E-Offset_0x045882
;-------------------------------------------------------------------------------
Offset_0x04588E:
		lea		Spiker_Setup_Data(PC), A1			   ; Offset_0x045AC0
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		lea		Offset_0x045AE4(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04589E:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x0458AA
		rts
Offset_0x0458AA:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0458C8, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0458C0:
		subq.w	#$01, Obj_Y(A0)					 ; $0014
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0458C8:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0458D6:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x0458E2
		rts
Offset_0x0458E2:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045906, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0458FE:
		addq.w	#$01, Obj_Y(A0)					 ; $0014
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045906:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x04590E:
		lea		Offset_0x045B10(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x045942
		cmpi.b	#$04, Obj_Ani_Frame(A0)					 ; $0023
		bne.s	Offset_0x045942
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	#$FA00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.b	#$02, Obj_Routine(A1)					 ; $0005
Offset_0x045942:
		rts
;-------------------------------------------------------------------------------
Offset_0x045944:
		move.b	Obj_Control_Var_0A(A0), Obj_Routine(A0)	  ; $003A, $0005
		move.b	#$0A, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x045952:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045968(PC, D0), D1
		jsr		Offset_0x045968(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x045968:
		dc.w	Offset_0x045970-Offset_0x045968
		dc.w	Offset_0x045986-Offset_0x045968
		dc.w	Offset_0x04599C-Offset_0x045968
		dc.w	Offset_0x0459D8-Offset_0x045968
;-------------------------------------------------------------------------------
Offset_0x045970:
		lea		Spiker_Setup_Data_2(PC), A1			   ; Offset_0x045ACC
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x045984
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x045984:
		rts
;-------------------------------------------------------------------------------
Offset_0x045986:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x045994
		rts
Offset_0x045994:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x04599C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0459D0
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x0459BE
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0459BA
		subq.w	#$02, D0
Offset_0x0459BA:
		tst.w	D0
		beq.s	Offset_0x0459C0
Offset_0x0459BE:
		rts
Offset_0x0459C0:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0459F6, Obj_Child(A0)			 ; $0034
		rts
Offset_0x0459D0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0459D8:
		lea		Offset_0x045B19(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x0459F4
		cmpi.b	#$04, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x0459F4
		lea		Offset_0x045AF8(PC), A2
		jsr		Load_Child_Object_Complex_Adjusted_A2(PC) ; Offset_0x041EE0
Offset_0x0459F4:
		rts
;-------------------------------------------------------------------------------
Offset_0x0459F6:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0459FE:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045A14(PC, D0), D1
		jsr		Offset_0x045A14(PC, D1)
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x045A14:
		dc.w	Offset_0x045A1A-Offset_0x045A14
		dc.w	Offset_0x045A22-Offset_0x045A14
		dc.w	Offset_0x045A62-Offset_0x045A14
;-------------------------------------------------------------------------------
Offset_0x045A1A:
		lea		Spiker_Setup_Data_3(PC), A1			   ; Offset_0x045AD2
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x045A22:
		jsr		Check_Player_Collision(PC)			   ; Offset_0x0430D4
		bne.s	Offset_0x045A2A
		rts
Offset_0x045A2A:
		bsr.w	Offset_0x045A74
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045A66, Obj_Child(A0)			 ; $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$03, Obj_Control_Var_08(A1)			 ; $0038
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		clr.b	Obj_Col_Flags(A1)				 ; $0028
		move.w	Obj_Height_3(A0), Obj_Height_3(A1)		  ; $0044, $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x045A62:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045A66:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$CA, Obj_Col_Flags(A0)					 ; $0028
		rts
Offset_0x045A74:
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		addq.w	#$06, Obj_Y(A1)					 ; $0014
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		moveq	#Spring_Sfx, D0					  ; -$2E
		jmp		(Play_Music).l					 ; Offset_0x001176;
;-------------------------------------------------------------------------------
Offset_0x045A94:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x045A9E
		rts
Offset_0x045A9E:
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		move.b	Obj_Routine(A0), Obj_Control_Var_0A(A0)	  ; $0005, $003A
		move.b	D0, Obj_Routine(A0)				 ; $0005
		move.l	#Offset_0x045944, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Spiker_Setup_Data:							   ; Offset_0x045AC0
		dc.l	Spiker_Mappings				   ; Offset_0x10EC6A
		dc.w	$2530, $0280
		dc.b	$20, $10, $00, $0A
;-------------------------------------------------------------------------------
Spiker_Setup_Data_2:						   ; Offset_0x045ACC
		dc.w	$0280
		dc.b	$20, $04, $03, $00
;-------------------------------------------------------------------------------
Spiker_Setup_Data_3:						   ; Offset_0x045AD2
		dc.w	$0200
		dc.b	$20, $04, $07, $CA
;-------------------------------------------------------------------------------
Spiker_Setup_Data_4:						   ; Offset_0x045AD8
		dc.l	Spiker_Mappings				   ; Offset_0x10EC6A
		dc.w	$0530, $0280
		dc.b	$04, $04, $05, $98
;-------------------------------------------------------------------------------
Offset_0x045AE4:
		dc.w	$0002
		dc.l	Offset_0x045952
		dc.b	$F0, $0C
		dc.l	Offset_0x045952
		dc.b	$10, $0C
		dc.l	Offset_0x0459FE
		dc.b	$00, $F4
;-------------------------------------------------------------------------------
Offset_0x045AF8:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Spiker_Setup_Data_4			   ; Offset_0x045AD8
		dc.l	Offset_0x045B22
		dc.l	Move_Light_Gravity_Animate_Raw		   ; Offset_0x042F70
		dc.b	$04, $00
		dc.w	$0200, $FE00
;-------------------------------------------------------------------------------
Offset_0x045B10:
		dc.b	$01, $00, $02, $01, $01, $00, $00, $05
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x045B19
		dc.b	$03, $01, $03, $0F, $04, $07, $03, $3F
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x045B22:
		dc.b	$01, $05, $06, $FC
;===============================================================================
; Objeto 0xA5 - Inimigo Spiker na Marble Garden
; <<<-
;===============================================================================