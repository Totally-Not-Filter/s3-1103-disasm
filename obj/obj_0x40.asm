;===============================================================================
; Objeto 0x40 - Bloco na Hydrocity
; ->>>
;===============================================================================
Offset_0x014AAE:
		dc.b	$10, $10, $20, $10, $30, $10, $40, $10
;-------------------------------------------------------------------------------
Obj_0x40_Hz_Block:							   ; Offset_0x014AB6
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		lea		Offset_0x014AAE(PC, D0), A1
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.l	#Hz_Block_Mappings, Obj_Map(A0) ; Offset_0x014B0E, $000C
		move.w	#$43D4, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x014AEE, (A0)
;-------------------------------------------------------------------------------
Offset_0x014AEE:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Solid_Object_2				   ; Offset_0x0135B6
		bra.w	MarkObjGone					   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Hz_Block_Mappings:							   ; Offset_0x014B0E
		dc.w	Offset_0x014B16-Hz_Block_Mappings
		dc.w	Offset_0x014B1E-Hz_Block_Mappings
		dc.w	Offset_0x014B2C-Hz_Block_Mappings
		dc.w	Offset_0x014B40-Hz_Block_Mappings
Offset_0x014B16:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x014B1E:
		dc.w	$0002
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0000, $0000
Offset_0x014B2C:
		dc.w	$0003
		dc.w	$F00F, $0000, $FFD0
		dc.w	$F00F, $0000, $FFF0
		dc.w	$F00F, $0000, $0010
Offset_0x014B40:
		dc.w	$0004
		dc.w	$F00F, $0000, $FFC0
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0000, $0000
		dc.w	$F00F, $0000, $0020
;===============================================================================
; Objeto 0x40 - Bloco na Hydrocity
; <<<-
;===============================================================================