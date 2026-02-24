;===============================================================================
; Objeto 0x5C - Base da plataforma em forma de pião giratória na Marble Garden.
; ->>>
;===============================================================================
; Offset_0x02BED2:
		move.l	#Blue_Spinning_Platform_Mappings, Obj_Map(A0) ; Offset_0x02BEA8, $000C
		move.w	#$43FF, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0010, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$0C00, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02BF12
		neg.w	D0
Offset_0x02BF12:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x02BF2E
		move.l	#Obj_0x5B_MGz_Blue_Spinning_Platform, (A1) ; Offset_0x02B19A
		move.b	#$01, Obj_Subtype(A1)					 ; $002C
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
Offset_0x02BF2E:
		move.l	#Offset_0x02BF34, (A0)
Offset_0x02BF34:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addq.w	#$04, Obj_Ani_Time(A1)					 ; $0024
		cmpi.b	#$04, Obj_Control_Var_10(A1)			 ; $0040
		beq.s	Offset_0x02BF58
		cmpi.b	#$04, Obj_Control_Var_12(A1)			 ; $0042
		bne.s	Offset_0x02BF5E
Offset_0x02BF58:
		move.l	#Offset_0x02BF64, (A0)
Offset_0x02BF5E:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02BF64:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		addq.w	#$01, Obj_Y(A0)					 ; $0014
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x02BF7E
		move.l	#Offset_0x02BFB8, (A0)
		move.w	#$7F00, Obj_X(A0)				 ; $0010
Offset_0x02BF7E:
		cmpi.w	#$0004, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x02BF9A
		bcs.s	Offset_0x02BFB8
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addq.w	#$04, Obj_Ani_Time(A1)					 ; $0024
		bra.s	Offset_0x02BFB8
Offset_0x02BF9A:
		move.w	Obj_Speed_X(A0), D1				 ; $0018
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	D1, Obj_Inertia(A1)				 ; $001C
		move.b	#$01, Obj_Control_Var_04(A1)			 ; $0034
		bclr	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Subtype(A1)					 ; $002C
Offset_0x02BFB8:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;===============================================================================
; Objeto 0x5C - Base da plataforma em forma de pião giratória na Marble Garden.
; <<<-
;===============================================================================