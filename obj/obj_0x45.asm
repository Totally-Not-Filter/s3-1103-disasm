;===============================================================================
; Objeto 0x45 - Lâmpada na Carnival Night
; ->>>
;===============================================================================
; Offset_0x027FDA:
		move.l	#Light_Bulb_Mappings, Obj_Map(A0) ; Offset_0x028030, $000C
		move.w	#$4404, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		tst.b	(Water_Level_Flag).w				 ; $FFFFF730
		bne.s	Offset_0x02800E
		move.l	#Offset_0x02802A, (A0)
		bra.s	Offset_0x02802A
Offset_0x02800E:
		move.l	#Offset_0x028014, (A0)
Offset_0x028014:
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x02802A
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x02802A, (A0)
Offset_0x02802A:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Light_Bulb_Mappings:						   ; Offset_0x028030
		dc.w	Offset_0x028034-Light_Bulb_Mappings
		dc.w	Offset_0x02804E-Light_Bulb_Mappings
Offset_0x028034:
		dc.w	$0004
		dc.w	$E807, $0000, $FFF0
		dc.w	$E807, $0800, $0000
		dc.w	$0805, $0008, $FFF0
		dc.w	$0805, $0808, $0000
Offset_0x02804E:
		dc.w	$0002
		dc.w	$0006, $000C, $FFF0
		dc.w	$0006, $080C, $0000
;===============================================================================
; Objeto 0x45 - Lâmpada na Carnival Night
; <<<-
;===============================================================================