;===============================================================================
; Objeto 0x9C - Inimigo Turbo Spiker na Hydrocity
; ->>>
;===============================================================================
; Offset_0x044946:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04495E(PC, D0), D1
		jsr		Offset_0x04495E(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04495E:
		dc.w	Offset_0x04496E-Offset_0x04495E
		dc.w	Offset_0x0449CA-Offset_0x04495E
		dc.w	Offset_0x044A30-Offset_0x04495E
		dc.w	Offset_0x044A50-Offset_0x04495E
		dc.w	Offset_0x044A6E-Offset_0x04495E
		dc.w	Offset_0x044A7C-Offset_0x04495E
		dc.w	Offset_0x044AA2-Offset_0x04495E
		dc.w	Offset_0x044ABE-Offset_0x04495E
;-------------------------------------------------------------------------------
Offset_0x04496E:
		lea		Turbo_Spiker_Setup_Data(PC), A1		   ; Offset_0x044C26
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		bclr	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x04498C
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		lea		Offset_0x044C90(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x04498C:
		move.b	#$10, Obj_Width_2(A0)					 ; $001F
		move.b	#$0F, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x044C98, Obj_Child_Data(A0)			 ; $0030
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.l	#Offset_0x0449F4, Obj_Child(A0)			 ; $0034
		move.w	#$FF80, D4
		jsr		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
		lea		Offset_0x044C58(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0449CA:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcc.s	Offset_0x0449E2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0449DE
		subq.w	#$02, D0
Offset_0x0449DE:
		tst.w	D0
		beq.s	Offset_0x044A10
Offset_0x0449E2:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		Run_Object_Hit_Floor_D3_A0(PC)		   ; Offset_0x0423F8
;-------------------------------------------------------------------------------
Offset_0x0449F4:
		move.b	Obj_Routine(A0), D0				 ; $0005
		cmpi.b	#$04, D0
		beq.s	Offset_0x044A0E
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
Offset_0x044A0E:
		rts
Offset_0x044A10:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.w	#$0200, D0
		bchg	#00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x044A2A
		neg.w	D0
Offset_0x044A2A:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x044A30:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044A38
		rts
;-------------------------------------------------------------------------------
Offset_0x044A38:
		move.b	Obj_Control_Var_0A(A0), Obj_Routine(A0)	  ; $003A, $0005
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
		move.w	Obj_Control_Var_0C(A0), Obj_Timer(A0)	  ; $003C, $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x044A50:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044A58
		rts
Offset_0x044A58:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x044C9D, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x044A6E:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Hit_Floor_D3_A0(PC)		   ; Offset_0x0423F8
;-------------------------------------------------------------------------------
Offset_0x044A7C:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcs.s	Offset_0x044A88
		rts
Offset_0x044A88:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		lea		Offset_0x044C70(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x044AA2:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044AAA
		rts
Offset_0x044AAA:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x044ABE:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044AC6
		rts
Offset_0x044AC6:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x044ACE:
		lea		Turbo_Spiker_Setup_Data_2(PC), A1	   ; Offset_0x044C32
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x044AE0, (A0)
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x044AE0:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x044AF4
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
Offset_0x044AF4:
		move.l	#Offset_0x044B1E, (A0)
		move.w	#$0100, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x044B08
		neg.w	D0
Offset_0x044B08:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		lea		Offset_0x044C60(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x044B1E:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x044B28:
		lea		Turbo_Spiker_Setup_Data_3(PC), A1	   ; Offset_0x044C38
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x044B3A, (A0)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x044B3A:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x044B5E
		bsr.w	Offset_0x044B62
		bchg	#00, Obj_Control_Var_08(A0)				 ; $0038
		beq.w	Offset_0x044A0E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x044B5E:
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
Offset_0x044B62:
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		andi.b	#$03, D0
		bne.s	Offset_0x044B92
		lea		Offset_0x044C68(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x044B92
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$0007, D0
		subq.w	#$03, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		swap	D0
		andi.w	#$0007, D0
		subq.w	#$03, D0
		add.w	D0, Obj_Y(A1)					 ; $0014
Offset_0x044B92:
		rts
;-------------------------------------------------------------------------------
Offset_0x044B94:
		lea		Turbo_Spiker_Setup_Data_4(PC), A1	   ; Offset_0x044C3E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x044BB8, (A0)
		move.l	#Offset_0x044CA2, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x044BB8:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x044BC2:
		lea		Turbo_Spiker_Setup_Data_5(PC), A1	   ; Offset_0x044C44
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x044BD8, (A0)
		move.b	Obj_Subtype(A0), Obj_Timer_2(A0)		  ; $002C, $002F
		rts
;-------------------------------------------------------------------------------
Offset_0x044BD8:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044BE0
		rts
Offset_0x044BE0:
		move.l	#Offset_0x044BF8, (A0)
		move.l	#Offset_0x044CA9, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x044BF8:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x044C02:
		move.l	#Offset_0x044C10, (A0)
		lea		Turbo_Spiker_Setup_Data_6(PC), A1	   ; Offset_0x044C4C
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x044C10:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x044C20
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
Offset_0x044C20:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data:					   ; Offset_0x044C26
		dc.l	Turbo_Spiker_Mappings		   ; Offset_0x10E1AC
		dc.w	$2500, $0280
		dc.b	$20, $20, $00, $1A
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data_2:					   ; Offset_0x044C32
		dc.w	$0280
		dc.b	$08, $10, $03, $9A
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data_3:					   ; Offset_0x044C38
		dc.w	$0200
		dc.b	$04, $08, $04, $00
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data_4:					   ; Offset_0x044C3E
		dc.w	$0280
		dc.b	$04, $04, $05, $00
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data_5:					   ; Offset_0x044C44
		dc.w	$8500, $0200
		dc.b	$08, $08, $08, $00
;-------------------------------------------------------------------------------
Turbo_Spiker_Setup_Data_6:					   ; Offset_0x044C4C
		dc.l	Turbo_Spiker_Hidden_Mappings		   ; Offset_0x044CB2
		dc.w	$C001, $0180
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x044C58:
		dc.w	$0000
		dc.l	Offset_0x044ACE
		dc.b	$04, $00
;-------------------------------------------------------------------------------
Offset_0x044C60:
		dc.w	$0000
		dc.l	Offset_0x044B28
		dc.b	$FC, $14
;-------------------------------------------------------------------------------
Offset_0x044C68
		dc.w	$0000
		dc.l	Offset_0x044B94
		dc.b	$00, $04
;-------------------------------------------------------------------------------
Offset_0x044C70:
		dc.w	$0004
		dc.l	Offset_0x044BC2
		dc.b	$04, $F8
		dc.l	Offset_0x044BC2
		dc.b	$FA, $00
		dc.l	Offset_0x044BC2
		dc.b	$06, $00
		dc.l	Offset_0x044BC2
		dc.b	$F8, $00
		dc.l	Offset_0x044BC2
		dc.b	$08, $00
;-------------------------------------------------------------------------------
Offset_0x044C90:
		dc.w	$0000
		dc.l	Offset_0x044C02
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x044C98:
		dc.b	$05, $00, $01, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x044C9D:
		dc.b	$01, $00, $01, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x044CA2:
		dc.b	$00, $05, $05, $05, $06, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x044CA9:
		dc.b	$01, $08, $09, $0A, $0B, $0C, $0D, $F4, $00
;-------------------------------------------------------------------------------
Turbo_Spiker_Hidden_Mappings:				   ; Offset_0x044CB2
		dc.w	Offset_0x044CB4-Turbo_Spiker_Hidden_Mappings
Offset_0x044CB4:
		dc.w	$0003
		dc.w	$D00F, $0050, $FFF0
		dc.w	$F00F, $0050, $FFF0
		dc.w	$F003, $0050, $0010
;===============================================================================
; Objeto 0x9C - Inimigo Turbo Spiker na Hydrocity
; <<<-
;===============================================================================