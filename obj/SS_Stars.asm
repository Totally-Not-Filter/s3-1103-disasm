;===============================================================================
; Objeto Estrelas do Super Sonic
; ->>>
;===============================================================================
; Offset_0x0102AA:
		move.l	#Super_Sonic_Stars_Mappings, Obj_Map(A0) ; Offset_0x01036A, $000C
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$18, Obj_Height(A0)					 ; $0006
		move.w	#$079C, Obj_Art_VRAM(A0)				 ; $000A
		btst	#$07, (Obj_Player_One+Obj_Art_VRAM).w		 ; $FFFFB00A
		beq.s	Offset_0x0102DE
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x0102DE:
		move.l	#Offset_0x0102E4, (A0)
Offset_0x0102E4:
		tst.b	(Super_Sonic_flag).w				 ; $FFFFFE19
		beq.s	Offset_0x010364
		tst.b	Obj_P_Invunerblt_Time(A0)				 ; $0034
		beq.s	Offset_0x010334
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x01031C
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$06, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x01031C
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$00, Obj_P_Invunerblt_Time(A0)			 ; $0034
		move.b	#$01, Obj_P_Invcbility_Time(A0)			 ; $0035
		rts
Offset_0x01031C:
		tst.b	Obj_P_Invcbility_Time(A0)				 ; $0035
		bne.s	Offset_0x01032E
Offset_0x010322:
		move.w	(Obj_Player_One+Obj_X).w, Obj_X(A0)	  ; $FFFFB010, $0010
		move.w	(Obj_Player_One+Obj_Y).w, Obj_Y(A0)	  ; $FFFFB014, $0014
Offset_0x01032E:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x010334:
		tst.b	(Obj_Player_One+Obj_Timer).w		 ; $FFFFB02E
		bne.s	Offset_0x010356
		move.w	(Obj_Player_One+Obj_Inertia).w, D0			 ; $FFFFB01C
		bpl.s	Offset_0x010342
		neg.w	D0
Offset_0x010342:
		cmpi.w	#$0800, D0
		bcs.s	Offset_0x010356
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$01, Obj_P_Invunerblt_Time(A0)			 ; $0034
		bra.s	Offset_0x010322
Offset_0x010356:
		move.b	#$00, Obj_P_Invunerblt_Time(A0)			 ; $0034
		move.b	#$00, Obj_P_Invcbility_Time(A0)			 ; $0035
		rts
Offset_0x010364:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Super_Sonic_Stars_Mappings:					   ; Offset_0x01036A
		dc.w	Offset_0x010376-Super_Sonic_Stars_Mappings
		dc.w	Offset_0x010390-Super_Sonic_Stars_Mappings
		dc.w	Offset_0x0103AA-Super_Sonic_Stars_Mappings
		dc.w	Offset_0x010390-Super_Sonic_Stars_Mappings
		dc.w	Offset_0x010376-Super_Sonic_Stars_Mappings
		dc.w	Offset_0x0103C4-Super_Sonic_Stars_Mappings
Offset_0x010376:
		dc.w	$0004
		dc.w	$F800, $0000, $FFF8
		dc.w	$F800, $0800, $0000
		dc.w	$0000, $1000, $FFF8
		dc.w	$0000, $1800, $0000
Offset_0x010390:
		dc.w	$0004
		dc.w	$F005, $0001, $FFF0
		dc.w	$F005, $0801, $0000
		dc.w	$0005, $1001, $FFF0
		dc.w	$0005, $1801, $0000
Offset_0x0103AA:
		dc.w	$0004
		dc.w	$E80A, $0005, $FFE8
		dc.w	$E80A, $0805, $0000
		dc.w	$000A, $1005, $FFE8
		dc.w	$000A, $1805, $0000
Offset_0x0103C4:
		dc.w	$0000
;===============================================================================
; Objeto Estrelas do Super Sonic
; <<<-
;===============================================================================