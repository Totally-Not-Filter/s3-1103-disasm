;===============================================================================
; Objeto 0x89 - Inimigo Orbinaut na Launch Base
; ->>>
;===============================================================================
; Offset_0x048A94:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048AAC(PC, D0), D1
		jsr		Offset_0x048AAC(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x048AAC:
		dc.w	Offset_0x048AB0-Offset_0x048AAC
		dc.w	Offset_0x048AD4-Offset_0x048AAC
;-------------------------------------------------------------------------------
Offset_0x048AB0:
		lea		Orbinaut_Setup_Data(PC), A1			   ; Offset_0x048B98
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	#$FF80, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x048AC6
		neg.w	D0
Offset_0x048AC6:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		lea		Offset_0x048BAA(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x048AD4:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x048AE2
		bsr.w	Offset_0x048B7A
		beq.w	Offset_0x048B96
Offset_0x048AE2:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x048AE8:
		lea		Offset_0x048BA4(PC), A1
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x048B18, (A0)
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.b	#$05, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$08, D0
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x048B10
		moveq	#-$08, D0
Offset_0x048B10:
		move.b	D0, Obj_Control_Var_10(A0)				 ; $0040
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x048B18:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		tst.b	Obj_Subtype(A1)					 ; $002C
		bne.s	Offset_0x048B28
		bsr.w	Offset_0x048B7A
		beq.s	Offset_0x048B30
Offset_0x048B28:
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x048B30:
		moveq	#$04, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		cmpi.b	#$80, Obj_Control_Var_0C(A0)			 ; $003C
		bne.s	Offset_0x048B4A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.b	#$04, Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x048B4E
Offset_0x048B4A:
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
Offset_0x048B4E:
		move.l	#Offset_0x048B6E, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	#$0001, Obj_Control_Var_10(A0)			 ; $0040
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bpl.s	Offset_0x048B6A
		move.w	#$FFFF, Obj_Control_Var_10(A0)			 ; $0040
Offset_0x048B6A:
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x048B6E:
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D0, Obj_X(A0)					 ; $0010
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
Offset_0x048B7A:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x048B92
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bne.s	Offset_0x048B96
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bne.s	Offset_0x048B96
Offset_0x048B92:
		moveq	#$00, D0
		rts
Offset_0x048B96:
		rts
;-------------------------------------------------------------------------------
Orbinaut_Setup_Data:						   ; Offset_0x048B98
		dc.l	Orbinaut_Mappings			   ; Offset_0x10D472
		dc.w	$256E, $0280
		dc.b	$08, $08, $00, $0B
;-------------------------------------------------------------------------------
Offset_0x048BA4:
		dc.w	$0280
		dc.b	$08, $08, $01, $8B
;-------------------------------------------------------------------------------
Offset_0x048BAA:
		dc.w	$0003
		dc.l	Offset_0x048AE8
		dc.b	$00, $10
		dc.l	Offset_0x048AE8
		dc.b	$10, $00
		dc.l	Offset_0x048AE8
		dc.b	$00, $F0
		dc.l	Offset_0x048AE8
		dc.b	$F0, $00
;-------------------------------------------------------------------------------
 ; Offset_0x048BC4: ; Left over ???
		dc.b	$00, $05, $01, $05, $02, $05, $03, $05
		dc.b	$FC, $00
;===============================================================================
; Objeto 0x89 - Inimigo Orbinaut na Launch Base
; <<<-
;===============================================================================