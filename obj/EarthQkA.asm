;===============================================================================
; Objeto de controle de colisão dos tiles da Marble Garden durante o terremoto
; ->>>
;===============================================================================
; Offset_0x0325CE:
		cmpi.w	#$0008, (Level_Events_Routine).w			 ; $FFFFEEC0
		bne.s	Offset_0x0325DC
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x0325DC:
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		move.w	Obj_Timer(A0), D0				 ; $002E
		add.w	(A1), D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.b	#$10, Obj_Width(A0)				 ; $0007
		bset	#$07, Obj_Status(A0)					 ; $002A
		moveq	#$1B, D1
		moveq	#$40, D2
		moveq	#$40, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object_2).l			   ; Offset_0x0135B6
;===============================================================================
; Objeto de controle de colisão dos tiles da Marble Garden durante o terremoto
; <<<-
;===============================================================================