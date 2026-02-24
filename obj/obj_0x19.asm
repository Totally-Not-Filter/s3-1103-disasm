;===============================================================================
; Objeto 0x19 - Poste do elevador em forma de xícara na Launch Base
; ->>>
;===============================================================================
; Offset_0x01DF10:
		move.l	#Cup_Elevator_Mappings, Obj_Map(A0) ; Offset_0x01DF66, $000C
		move.w	#$440D, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$30, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x01DF5A
		move.b	#$60, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
Offset_0x01DF5A:
		move.l	#Offset_0x01DF60, (A0)
Offset_0x01DF60:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Cup_Elevator_Mappings:						   ; Offset_0x01DF66
		dc.w	Offset_0x01DF70-Cup_Elevator_Mappings
		dc.w	Offset_0x01DF7E-Cup_Elevator_Mappings
		dc.w	Offset_0x01DF86-Cup_Elevator_Mappings
		dc.w	Offset_0x01DF94-Cup_Elevator_Mappings
		dc.w	Offset_0x01DFA8-Cup_Elevator_Mappings
Offset_0x01DF70:
		dc.w	$0002
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0800, $0000
Offset_0x01DF7E:
		dc.w	$0001
		dc.w	$F805, $0010, $FFF8
Offset_0x01DF86:
		dc.w	$0002
		dc.w	$F406, $0014, $FFF0
		dc.w	$F406, $0814, $0000
Offset_0x01DF94:
		dc.w	$0003
		dc.w	$D007, $001A, $FFF8
		dc.w	$F007, $001A, $FFF8
		dc.w	$1007, $001A, $FFF8
Offset_0x01DFA8:
		dc.w	$0006
		dc.w	$A007, $001A, $FFF8
		dc.w	$C007, $001A, $FFF8
		dc.w	$E007, $001A, $FFF8
		dc.w	$0007, $001A, $FFF8
		dc.w	$2007, $001A, $FFF8
		dc.w	$4007, $001A, $FFF8
;===============================================================================
; Objeto 0x19 - Poste do elevador em forma de xícara na Launch Base
; <<<-
;===============================================================================