;===============================================================================
; Objeto 0xAB - Inimigo Star Pointer na Icecap
; ->>>
;===============================================================================
; Offset_0x0482D2:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		lea		Star_Pointer_Setup_Data(PC), A1		   ; Offset_0x048416
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x048318, (A0)
		bclr	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0482F4
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x0482F4:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$0006, D0
		move.w	Offset_0x048310(PC, D0), D4
		jsr		(Set_Velocity_X_Track_Player_One)	   ; Offset_0x042E4C
		lea		Offset_0x048428(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x048310:
		dc.w	$FFC0, $FFA0, $FF80, $FF00
;-------------------------------------------------------------------------------
Offset_0x048318:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcc.s	Offset_0x048336
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x048332
		subq.w	#$02, D0
Offset_0x048332:
		tst.w	D0
		beq.s	Offset_0x04833A
Offset_0x048336:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
Offset_0x04833A:
		move.l	#Offset_0x04834A, (A0)
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04834A:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x048354:
		lea		Star_Pointer_Setup_Data_2(PC), A1	   ; Offset_0x048422
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.b	#$08, Obj_Width_2(A0)					 ; $001F
		move.l	#Offset_0x04837C, (A0)
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$01, D0
		move.b	Offset_0x048378(PC, D0), Obj_Control_Var_0C(A0)	 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x048378:
		dc.b	$00, $40, $80, $C0
;-------------------------------------------------------------------------------
Offset_0x04837C:
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.s	Offset_0x0483DC
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x048398
		addq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bra.w	Offset_0x04839C
Offset_0x048398:
		subq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x04839C:
		bne.s	Offset_0x0483DC
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0483DC
		move.l	#Offset_0x0483E6, (A0)
		move.l	#Offset_0x0483FA, Obj_Child(A0)			 ; $0034
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		asl.w	#$01, D0
		move.l	#Run_Object_Hit_Wall_Right_A0, Obj_Child_Data(A0) ; Offset_0x042424, $0030
		move.w	#$0008, Obj_Height_3(A0)				 ; $0044
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		bpl.s	Offset_0x0483DC
		move.l	#Run_Object_Hit_Wall_Left_A0, Obj_Child_Data(A0) ; Offset_0x04243A, $0030
		move.w	#$FFF8, Obj_Height_3(A0)				 ; $0044
Offset_0x0483DC:
		moveq	#$04, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x0483E6:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.l	Obj_Child_Data(A0), A1					 ; $0030
		move.w	Obj_Height_3(A0), D3					 ; $0044
		jsr		(A1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x0483FA:
		move.l	#Offset_0x04840A, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04840A:
		lea		Offset_0x048430(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Star_Pointer_Setup_Data:					   ; Offset_0x048416
		dc.l	Star_Pointer_Mappings		   ; Offset_0x10EF66
		dc.w	$2548, $0280
		dc.b	$08, $08, $00, $0B
;-------------------------------------------------------------------------------
Star_Pointer_Setup_Data_2:					   ; Offset_0x048422
		dc.w	$0280
		dc.b	$08, $08, $01, $8B
;-------------------------------------------------------------------------------
Offset_0x048428:
		dc.w	$0003
		dc.l	Offset_0x048354
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x048430:
		dc.b	$03, $01, $02, $03, $F4, $00
;===============================================================================
; Objeto 0xAB - Inimigo Star Pointer na Icecap
; <<<-
;===============================================================================