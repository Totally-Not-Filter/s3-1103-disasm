;===============================================================================
; Objeto 0x23 - ???
; ->>>
;===============================================================================
; Offset_0x02010E:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$80, Obj_Height(A0)					 ; $0006
		move.b	#$00, Obj_Priority(A0)					 ; $0008
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.l	#Offset_0x020138, (A0)
Offset_0x020138:
		move.w	Obj_X(A0), D1					 ; $0010
		move.w	D1, D2
		subi.w	#$0010, D1
		addi.w	#$0010, D2
		move.w	Obj_Y(A0), D3					 ; $0014
		move.w	D3, D4
		sub.w	Obj_Timer(A0), D3				 ; $002E
		add.w	Obj_Timer(A0), D4				 ; $002E
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x020166
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x020166
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x020166:
		move.w	Obj_X(A1), D0					 ; $0010
		cmp.w	D1, D0
		bcs.s	Offset_0x0201B6
		cmp.w	D2, D0
		bcc.s	Offset_0x0201B6
		move.w	Obj_Y(A1), D0					 ; $0014
		cmp.w	D3, D0
		bcs.s	Offset_0x0201B6
		cmp.w	D4, D0
		bcc.s	Offset_0x0201B6
		cmpi.b	#$1A, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x0201B6
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0400, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$1A, Obj_Ani_Number(A1)				 ; $0020
Offset_0x0201B6:
		rts
;===============================================================================
; Objeto 0x23 - ???
; <<<-
;===============================================================================