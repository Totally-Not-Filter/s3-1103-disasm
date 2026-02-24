;-------------------------------------------------------------------------------
; Árvore não usada na Angel Island
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x0234AA
		move.l	#Tree_Mappings, Obj_Map(A0)		; Offset_0x0234F0, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		lea		Offset_0x0234EA(PC, D0), A1
		move.w	(A1)+, Obj_Art_VRAM(A0)					 ; $000A
		move.w	(A1)+, Obj_Priority(A0)					 ; $0008
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0234E4, (A0)
Offset_0x0234E4:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x0234EA:
		dc.b	$44, $3F, $03, $00
		dc.b	$08, $40
;-------------------------------------------------------------------------------
Tree_Mappings:						   ; Offset_0x0234F0
		dc.w	Offset_0x0234F2-Tree_Mappings
Offset_0x0234F2:
		dc.w	$0004
		dc.w	$C007, $0000, $FFF8
		dc.w	$E007, $0000, $FFF8
		dc.w	$0007, $0000, $FFF8
		dc.w	$2007, $0000, $FFF8
;-------------------------------------------------------------------------------
; Árvore não usada na Angel Island
; <<<-
;-------------------------------------------------------------------------------