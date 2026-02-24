;===============================================================================
; Objeto 0x13 - Gatilho explosivo que muda a posição das pontes nas Launch Base
; ->>>
;===============================================================================
Offset_0x01C890:
		move.l	#LBz_Exploding_Trigger_Mappings, Obj_Map(A0) ; Offset_0x01C926, $000C
		move.w	#$4433, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$C6, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x01C8C2, (A0)
Offset_0x01C8C2:
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		beq.w	Offset_0x01C8F8
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		moveq	#$00, D3
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x01C8EA
		bsr.s	Offset_0x01C8FE
Offset_0x01C8EA:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x01C8F8
		bsr.s	Offset_0x01C8FE
Offset_0x01C8F8:
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
Offset_0x01C8FE:
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x01C924
		neg.w	Obj_Speed_X(A1)					 ; $0018
		neg.w	Obj_Speed_Y(A1)					 ; $001A
		bchg	D3, (A3)
		move.l	#Obj_Explosion, (A0)			  ; Offset_0x013D7C
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x01C924:
		rts
;-------------------------------------------------------------------------------
LBz_Exploding_Trigger_Mappings:				   ; Offset_0x01C926
		dc.w	Offset_0x01C928-LBz_Exploding_Trigger_Mappings
Offset_0x01C928:
		dc.w	$0001
		dc.w	$F40A, $0019, $FFF4
;===============================================================================
; Objeto 0x13 - Gatilho explosivo que muda a posição das pontes nas Launch Base
; <<<-
;===============================================================================