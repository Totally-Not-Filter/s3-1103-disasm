;-------------------------------------------------------------------------------
; Barreira invisível na Launch Base
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x0336A6:
		cmpi.w	#$3D80, (Screen_Pos_Buffer_X).w		 ; $FFFFEE80
		bcs.s	Offset_0x0336B4
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x0336B4:
		move.w	#$3BC0, D4
		move.w	D4, Obj_X(A0)					 ; $0010
		move.w	#$0100, Obj_Y(A0)				 ; $0014
		move.b	#$40, Obj_Width(A0)				 ; $0007
		bset	#$07, Obj_Status(A0)					 ; $002A
		moveq	#$4B, D1
		move.w	#$0100, D2
		move.w	#$0100, D3
		jmp		(Solid_Object_2).l			   ; Offset_0x0135B6
;-------------------------------------------------------------------------------
; Barreira invisível na Launch Base
; <<<-
;-------------------------------------------------------------------------------