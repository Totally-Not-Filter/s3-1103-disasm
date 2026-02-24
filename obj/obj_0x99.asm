;===============================================================================
; Objeto 0x99 - Inimigo Jaws na Hydrocity
; ->>>
;===============================================================================
; Offset_0x04465C:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		lea		Jawz_Setup_Data(PC), A1		   ; Offset_0x0446C0
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x044678, (A0)
		move.w	#$FE00, D4
		jmp		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
;-------------------------------------------------------------------------------
Offset_0x044678:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		lea		Offset_0x0446CC(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		moveq	#$00, D0
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		bne.s	Offset_0x044692
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
Offset_0x044692:
		add.w	D0, D0
		move.w	Offset_0x0446BA-$02(PC, D0), A1
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x0446B6
		cmpi.b	#$09, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x0446B6
		lea		(Offset_0x0397A8).l, A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
Offset_0x0446B6:
		jmp		Enemy_Defeat_Score(PC)		   ; Offset_0x043018
;-------------------------------------------------------------------------------
Offset_0x0446BA:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	Obj_Player_One					 ; $B000
;-------------------------------------------------------------------------------
Jawz_Setup_Data:							   ; Offset_0x0446C0
		dc.l	Jawz_Mappings				   ; Offset_0x10E304
		dc.w	$A539, $0280
		dc.b	$1C, $0C, $00, $D7
;-------------------------------------------------------------------------------
Offset_0x0446CC:
		dc.b	$00, $00, $01, $FC
;===============================================================================
; Objeto 0x99 - Inimigo Jaws na Hydrocity
; <<<-
;===============================================================================