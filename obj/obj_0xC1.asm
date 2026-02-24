;===============================================================================
; Objeto 0xC1 - Bola cravada (espinhos) de gelo na Icecap
; ->>>
;===============================================================================
; Offset_0x047AD0:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		lea		Offset_0x047B30(PC), A1
		move.l	#Delete_Sprite_Clear_Respaw_Flag_Check_X, (A0) ; Offset_0x042B3C
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x047AEE
		lea		Offset_0x047B3C(PC), A1
		move.l	#Offset_0x047AF2, (A0)
Offset_0x047AEE:
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x047AF2:
		moveq	#$00, D0
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		bne.s	Offset_0x047AFE
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
Offset_0x047AFE:
		add.w	D0, D0
		move.w	Offset_0x047B2A-$02(PC, D0), A1
		move.l	A0, A2
		move.l	A1, A0
		jsr		(Hurt_Player).l					 ; Offset_0x00A3FA
		move.l	A2, A0
		lea		Offset_0x047B48(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		jsr		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
		moveq	#Ice_Spike_Sfx, D0			   ; -$6E
		jsr		(Play_Music).l					 ; Offset_0x001176
		jmp		(DisplaySprite).l				 ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x047B2A:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	Obj_Player_One					 ; $B000
;-------------------------------------------------------------------------------
Offset_0x047B30:
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0280
		dc.b	$10, $18, $05, $82
;-------------------------------------------------------------------------------
Offset_0x047B3C:
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0280
		dc.b	$10, $10, $04, $D7
;-------------------------------------------------------------------------------
Offset_0x047B48:
		dc.w	$000B
		dc.l	Offset_0x047862
;===============================================================================
; Objeto 0xC1 - Bola cravada (espinhos) de gelo na Icecap
; <<<-
;===============================================================================