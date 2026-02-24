;===============================================================================
; Objeto 0x27 - Atributo invisível das lavas na Hill Top / Metropolis
; ->>>			Sonic 2 left over
;===============================================================================
Offset_0x0141EE:
		dc.b	$96, $94, $95, $00
;-------------------------------------------------------------------------------
Obj_0x27_Lava_Attributes:					   ; Offset_0x0141F2
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	Offset_0x0141EE(PC, D0), Obj_Col_Flags(A0)		 ; $0028
		move.l	#Lava_Attributes_Mappings_No_Display, Obj_Map(A0) ; Offset_0x014278, $000C
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014214
		move.l	#Lava_Attributes_Mappings, Obj_Map(A0) ; Offset_0x014280, $000C
Offset_0x014214:
		move.w	#$86BC, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$84, Obj_Flags(A0)				 ; $0004
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$80, Obj_Height(A0)					 ; $0006
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), Obj_Map_Id(A0)			  ; $002C, $0022
		move.l	#Offset_0x01423E, (A0)
Offset_0x01423E:
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		bne.s	Offset_0x014258
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
Offset_0x014258:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014264
		jsr		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014264:
		rts
Offset_0x014266:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x014272
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x014272:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Lava_Attributes_Mappings_No_Display:				   ; Offset_0x014278
		dc.w	Offset_0x01427E-Lava_Attributes_Mappings_No_Display
		dc.w	Offset_0x01427E-Lava_Attributes_Mappings_No_Display
		dc.w	Offset_0x01427E-Lava_Attributes_Mappings_No_Display
Offset_0x01427E:
		dc.w	$0000
;-------------------------------------------------------------------------------
Lava_Attributes_Mappings:					   ; Offset_0x014280
		dc.w	Offset_0x014286-Lava_Attributes_Mappings
		dc.w	Offset_0x0142A0-Lava_Attributes_Mappings
		dc.w	Offset_0x0142BA-Lava_Attributes_Mappings
Offset_0x014286:
		dc.w	$0004
		dc.w	$E005, $0034, $FFE0
		dc.w	$E005, $0034, $0010
		dc.w	$1005, $0034, $FFE0
		dc.w	$1005, $0034, $0010
Offset_0x0142A0:
		dc.w	$0004
		dc.w	$E005, $0034, $FFC0
		dc.w	$E005, $0034, $0030
		dc.w	$1005, $0034, $FFC0
		dc.w	$1005, $0034, $0030
Offset_0x0142BA:
		dc.w	$0004
		dc.w	$E005, $0034, $FF80
		dc.w	$E005, $0034, $0070
		dc.w	$1005, $0034, $FF80
		dc.w	$1005, $0034, $0070
;===============================================================================
; Objeto 0x27 - Atributo invisível das lavas na Hill Top / Metropolis
; <<<-			Sonic 2 left over
;===============================================================================