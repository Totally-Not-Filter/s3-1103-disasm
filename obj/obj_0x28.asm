;===============================================================================
; Objeto 0x28 - Barreira invisível utilizada para bloquear passagens nas fases
; ->>>
;===============================================================================
; Offset_0x0142D4:
		move.l	#Invisible_Block_Mappings, Obj_Map(A0) ; Offset_0x014352, $000C
		move.w	#$86BC, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.w	#$00F0, D0
		addi.w	#$0010, D0
		lsr.w	#$01, D0
		move.b	D0, Obj_Width(A0)				 ; $0007
		andi.w	#$000F, D1
		addq.w	#$01, D1
		lsl.w	#$03, D1
		move.b	D1, Obj_Height(A0)				 ; $0006
		move.l	#Offset_0x014314, (A0)
Offset_0x014314:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Solid_Object_2				   ; Offset_0x0135B6
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014350
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014350:
		rts
;-------------------------------------------------------------------------------
Invisible_Block_Mappings:					   ; Offset_0x014352
		dc.w	Offset_0x014358-Invisible_Block_Mappings
		dc.w	Offset_0x014372-Invisible_Block_Mappings
		dc.w	Offset_0x01438C-Invisible_Block_Mappings
Offset_0x014358:
		dc.w	$0004
		dc.w	$F005, $001C, $FFF0
		dc.w	$F005, $001C, $0000
		dc.w	$0005, $001C, $FFF0
		dc.w	$0005, $001C, $0000
Offset_0x014372:
		dc.w	$0004
		dc.w	$E005, $001C, $FFC0
		dc.w	$E005, $001C, $0030
		dc.w	$1005, $001C, $FFC0
		dc.w	$1005, $001C, $0030
Offset_0x01438C:
		dc.w	$0004
		dc.w	$E005, $001C, $FF80
		dc.w	$E005, $001C, $0070
		dc.w	$1005, $001C, $FF80
		dc.w	$1005, $001C, $0070
;===============================================================================
; Objeto 0x28 - Barreira invisível utilizada para bloquear passagens nas fases
; <<<-
;===============================================================================