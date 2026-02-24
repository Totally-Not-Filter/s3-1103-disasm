;===============================================================================
; Objeto 0xBF - Cubo de gelo que cobre itens (monitores, molas...)	na Icecap
; ->>>
;===============================================================================
; Offset_0x04798A:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		move.l	#Offset_0x0479A2, (A0)
		lea		Ice_Cube_Setup_Data(PC), A1			   ; Offset_0x047A72
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x0479A2:
		move.b	(Obj_Player_One+Obj_Ani_Number).w, Obj_Control_Var_0A(A0) ; $FFFFB020, $003A
		move.b	(Obj_Player_Two+Obj_Ani_Number).w, Obj_Control_Var_0B(A0) ; $FFFFB06A, $003B
		moveq	#$23, D1
		moveq	#$10, D2
		moveq	#$10, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		bsr.w	Offset_0x0479C8
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x0479C8:
		move.b	Obj_Status(A0), D0				 ; $002A
		btst	#$03, D0
		beq.s	Offset_0x0479DE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmpi.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
		beq.s	Offset_0x0479F0
Offset_0x0479DE:
		btst	#$04, D0
		beq.s	Offset_0x047A36
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		cmpi.b	#$02, Obj_Control_Var_0B(A0)			 ; $003B
		bne.s	Offset_0x047A36
Offset_0x0479F0:
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$FD00, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		lea		Offset_0x047A86(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
		jsr		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
Offset_0x047A36:
		rts
;-------------------------------------------------------------------------------
Offset_0x047A38:
		lea		Ice_Cube_Setup_Data_2(PC), A1		   ; Offset_0x047A7E
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Animate_Raw_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB2
		move.l	#Offset_0x047184, Obj_Child_Data(A0)			 ; $0030
		cmpi.b	#$0C, Obj_Subtype(A0)					 ; $002C
		bcs.s	Offset_0x047A5E
		move.l	#Offset_0x04718E, Obj_Child_Data(A0)			 ; $0030
Offset_0x047A5E:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.b	#$03, D0
		move.b	D0, Obj_Ani_Frame(A0)					 ; $0023
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Ice_Cube_Setup_Data:						   ; Offset_0x047A72
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0080
		dc.b	$18, $10, $03, $2E
;-------------------------------------------------------------------------------
Ice_Cube_Setup_Data_2:						   ; Offset_0x047A7E
		dc.w	$C3B6, $0280
		dc.b	$20, $20, $12, $00
;-------------------------------------------------------------------------------
Offset_0x047A86:
		dc.w	$000B
		dc.l	Offset_0x047A38
		dc.b	$00, $F8
		dc.l	Offset_0x047A38
		dc.b	$00, $08
		dc.l	Offset_0x047A38
		dc.b	$F0, $F8
		dc.l	Offset_0x047A38
		dc.b	$10, $F8
		dc.l	Offset_0x047A38
		dc.b	$F0, $08
		dc.l	Offset_0x047A38
		dc.b	$10, $08
		dc.l	Offset_0x047A38
		dc.b	$00, $00
		dc.l	Offset_0x047A38
		dc.b	$00, $00
		dc.l	Offset_0x047A38
		dc.b	$00, $00
		dc.l	Offset_0x047A38
		dc.b	$00, $00
		dc.l	Offset_0x047A38
		dc.b	$00, $00
		dc.l	Offset_0x047A38
		dc.b	$00, $00
;===============================================================================
; Objeto 0xBF - Cubo de gelo que cobre itens (monitores, molas...)	na Icecap
; <<<-
;===============================================================================