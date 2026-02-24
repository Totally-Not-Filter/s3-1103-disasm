;===============================================================================
; Objeto 0x91 - Inimigo Iwamodock (pedra que explode) na Lava Reef
; ->>>
;===============================================================================
; Offset_0x04A29C:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04A2B6(PC, D0), D1
		jsr		Offset_0x04A2B6(PC, D1)
		jmp		(Delete_Sprite_Clear_Respaw_Flag_Check_X) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04A2B6:
		dc.w	Offset_0x04A2BC-Offset_0x04A2B6
		dc.w	Offset_0x04A2C6-Offset_0x04A2B6
		dc.w	Offset_0x04A2EC-Offset_0x04A2B6
;-------------------------------------------------------------------------------
Offset_0x04A2BC:
		lea		Iwamodock_Setup_Data(PC), A1		   ; Offset_0x04A334
		jmp		(SetupObjectAttributes).l				 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x04A2C6:
		jsr		(Find_Player).l				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcs.s	Offset_0x04A2D4
		rts
Offset_0x04A2D4:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04A3A0, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x04A2F2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04A2EC:
		jmp		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x04A2F2:
		move.l	#Obj_Explosion, (A0)			  ; Offset_0x013D7C
		clr.b	Obj_Routine(A0)					 ; $0005
		lea		Offset_0x04A346(PC), A2
		jmp		(SetupChildObject_Complex).l		   ; Offset_0x041DEA
;-------------------------------------------------------------------------------
Offset_0x04A306:
		move.l	Obj_Control_Var_0E(A0), A1				 ; $003E
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Offset_0x043B32, (A0)
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$02, D0
		addq.b	#$06, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(Delete_Sprite_Clear_Respaw_Flag_Check_X_Y).l ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x04A328:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Iwamodock_Setup_Data:						   ; Offset_0x04A334
		dc.l	Iwamodock_Mappings			   ; Offset_0x10E46E
		dc.w	$0536, $0280
		dc.b	$0C, $0C, $00, $1A
;-------------------------------------------------------------------------------
Iwamodock_Setup_Data_2:						   ; Offset_0x04A340
		dc.w	$0280
		dc.b	$08, $04, $00, $18
;-------------------------------------------------------------------------------
Offset_0x04A346:
		dc.w	$0003
		dc.l	Offset_0x04A306
		dc.l	Iwamodock_Setup_Data_2		   ; Offset_0x04A340
		dc.l	Offset_0x04A3FB
		dc.l	Offset_0x04A328
		dc.b	$FC, $04
		dc.w	$FE00, $FF00
		dc.l	Offset_0x04A306
		dc.l	Iwamodock_Setup_Data_2		   ; Offset_0x04A340
		dc.l	Offset_0x04A3FB
		dc.l	Offset_0x04A328
		dc.b	$04, $04
		dc.w	$0200, $FF00
		dc.l	Offset_0x04A306
		dc.l	Iwamodock_Setup_Data_2		   ; Offset_0x04A340
		dc.l	Offset_0x04A3F7
		dc.l	Offset_0x04A328
		dc.b	$F8, $F8
		dc.w	$FF00, $FE00
		dc.l	Offset_0x04A306
		dc.l	Iwamodock_Setup_Data_2		   ; Offset_0x04A340
		dc.l	Offset_0x04A3F7
		dc.l	Offset_0x04A328
		dc.b	$08, $F8
		dc.w	$0100, $FE00
;-------------------------------------------------------------------------------
Offset_0x04A3A0:
		dc.b	$00, $07, $01, $07, $02, $07, $03, $2F
		dc.b	$04, $05, $03, $05, $04, $04, $03, $04
		dc.b	$04, $03, $03, $03, $04, $02, $03, $02
		dc.b	$04, $01, $03, $01, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $04, $00, $03, $00
		dc.b	$04, $00, $03, $00, $05, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x04A3F7:
		dc.b	$00, $06, $08, $FC
;-------------------------------------------------------------------------------
Offset_0x04A3FB:
		dc.b	$00, $07, $09, $FC, $00
;===============================================================================
; Objeto 0x91 - Inimigo Iwamodock (pedra que explode) na Lava Reef
; <<<-
;===============================================================================