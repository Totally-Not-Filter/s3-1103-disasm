;===============================================================================
; Objeto 0x22 - Sirene na Lauch Base
; ->>>
;===============================================================================
; Offset_0x02005A:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$D7, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02007E, (A0)
Offset_0x02007E:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x020092
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x0200DE
		move.w	#$0000, (Animate_Counters+$04).w			 ; $FFFFF7F4
		bra.s	Offset_0x0200F2
Offset_0x020092:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x0200F2
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		move.w	#$0081, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$0001, (Animate_Counters+$04).w			 ; $FFFFF7F4
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x0200DC
		move.l	#Obj_0x8B_LBz_Flybot_767, (A1)		   ; Offset_0x048DF8
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		add.w	D0, D0
		andi.w	#$000C, D0
		move.l	Offset_0x0200FE(PC, D0), D0
		add.w	D0, Obj_Y(A1)					 ; $0014
		swap	D0
		add.w	D0, Obj_X(A1)					 ; $0010
Offset_0x0200DC:
		rts
Offset_0x0200DE:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		andi.b	#$1F, D0
		bne.s	Offset_0x0200F0
		moveq	#Buzzer_Sfx, D0					  ; -$65
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x0200F0:
		rts
Offset_0x0200F2:
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x0200FE:
		dc.w	$00C0, $FFC0, $00C0, $FF40, $FF40, $FFC0, $FF40, $FF40
;===============================================================================
; Objeto 0x22 - Sirene na Lauch Base
; <<<-
;===============================================================================