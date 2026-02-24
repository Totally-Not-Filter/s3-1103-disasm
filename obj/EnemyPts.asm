;===============================================================================
; Pontos obtidos ao destruir alguns objetos
; ->>>
;===============================================================================
; Offset_0x023E42:
		move.l	#Enemy_Points_Mappings, Obj_Map(A0) ; Offset_0x023F1E, $000C
		move.w	#$85E4, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.w	#$FD00, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x023E6E, (A0)
Offset_0x023E6E:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bpl.w	Flickies_DeleteObject		   ; Offset_0x023B3C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;===============================================================================
; Pontos obtidos ao destruir alguns objetos
; <<<-
;===============================================================================