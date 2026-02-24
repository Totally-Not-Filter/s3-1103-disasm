;===============================================================================
; Objeto 0x21 - Passagem com feixes de laser
; ->>>
;===============================================================================
; Offset_0x01FF28:
		move.l	#Gate_Laser_Mappings, Obj_Map(A0) ; Offset_0x020036, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$1C, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Height(A0)					 ; $0006
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		andi.w	#$000F, D0
		lsl.w	#$03, D0
		add.w	Obj_Y(A0), D0					 ; $0014
		move.w	D0, Obj_Timer(A0)				 ; $002E
		lsr.b	#$01, D1
		andi.w	#$0078, D1
		addq.w	#$08, D1
		move.w	D1, Obj_Control_Var_02(A0)				 ; $0032
		move.l	#Offset_0x01FF76, (A0)
Offset_0x01FF76:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x01FFBA
		move.w	Obj_Control_Var_02(A0), Obj_Control_Var_00(A0) ; $0032, $0030
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01FFBA
		bsr.s	Offset_0x01FFC0
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01FFBA
		bsr.s	Offset_0x01FFC0
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
		move.b	#$02, Obj_Map_Id(A1)					 ; $0022
		move.b	#$98, Obj_Col_Flags(A1)					 ; $0028
		move.l	#Offset_0x020006, (A1)
		moveq	#Energy_Zap_Sfx, D0				  ; -$37
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01FFBA:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x01FFC0:
		move.l	#Offset_0x02000C, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Timer(A0), Obj_Timer(A1)			  ; $002E, $002E
		move.l	#Gate_Laser_Mappings, Obj_Map(A1) ; Offset_0x020036, $000C
		move.w	#$42EA, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$1C, Obj_Width(A1)				 ; $0007
		move.b	#$04, Obj_Height(A1)					 ; $0006
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		move.w	#$0180, Obj_Priority(A1)				 ; $0008
		rts
;-------------------------------------------------------------------------------
Offset_0x020006:
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x02000C:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x02001C
		bchg	#01, Obj_Flags(A0)				 ; $0004
Offset_0x02001C:
		move.w	Obj_Y(A0), D0					 ; $0014
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		cmp.w	Obj_Timer(A0), D0				 ; $002E
		bcs.s	Offset_0x020030
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x020030:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Gate_Laser_Mappings:						   ; Offset_0x020036
		dc.w	Offset_0x02003C-Gate_Laser_Mappings
		dc.w	Offset_0x02004A-Gate_Laser_Mappings
		dc.w	Offset_0x020052-Gate_Laser_Mappings
Offset_0x02003C:
		dc.w	$0002
		dc.w	$FC0C, $0036, $FFE4
		dc.w	$FC08, $0036, $0004
Offset_0x02004A:
		dc.w	$0001
		dc.w	$FC0C, $0036, $FFE4
Offset_0x020052:
		dc.w	$0001
		dc.w	$FC08, $0036, $0004
;===============================================================================
; Objeto 0x21 - Passagem com feixes de laser
; <<<-
;===============================================================================