;===============================================================================
; Objeto 0x3F - Espinhos nas esteiras na Hydrocity
; ->>>
;===============================================================================
; Offset_0x027346:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lsl.w	#$02, D0
		lea		Offset_0x027184(PC), A1
		lea		(A1, D0), A1
		move.w	(A1)+, Obj_Control_Var_06(A0)			 ; $0036
		move.w	(A1)+, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Spikes_On_Conveyor_Belt_Mappings, Obj_Map(A0) ; Offset_0x027548, $000C
		move.w	#$243E, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.b	#$8B, Obj_Col_Flags(A0)					 ; $0028
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0273B2
		addi.w	#$0018, Obj_Y(A0)				 ; $0014
		move.l	#Offset_0x027416, (A0)
		bra.w	Offset_0x027416
Offset_0x0273B2:
		subi.w	#$0018, Obj_Y(A0)				 ; $0014
		move.w	#$0040, Obj_Angle(A0)					 ; $0026
		move.l	#Offset_0x0273C4, (A0)
Offset_0x0273C4:
		addq.w	#$02, Obj_X(A0)					 ; $0010
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_Control_Var_08(A0), D0				 ; $0038
		bne.s	Offset_0x0273DE
		move.l	#Offset_0x0273E2, (A0)
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
Offset_0x0273DE:
		bra.w	Offset_0x02746A
;-------------------------------------------------------------------------------
Offset_0x0273E2:
		subq.w	#$02, Obj_Angle(A0)				 ; $0026
		andi.w	#$007E, Obj_Angle(A0)					 ; $0026
		move.w	Obj_Angle(A0), D0				 ; $0026
		bne.s	Offset_0x0273F8
		move.l	#Offset_0x027416, (A0)
Offset_0x0273F8:
		lea		Offset_0x0274A8(PC), A1
		move.w	(A1, D0), D1
		move.w	$20(A1, D0), D2
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		add.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	D2, Obj_Y(A0)					 ; $0014
		bra.s	Offset_0x02746A
Offset_0x027416:
		subq.w	#$02, Obj_X(A0)					 ; $0010
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_Control_Var_06(A0), D0				 ; $0036
		bne.s	Offset_0x027430
		move.l	#Offset_0x027432, (A0)
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
Offset_0x027430:
		bra.s	Offset_0x02746A
;-------------------------------------------------------------------------------
Offset_0x027432:
		subq.w	#$02, Obj_Angle(A0)				 ; $0026
		andi.w	#$007E, Obj_Angle(A0)					 ; $0026
		move.w	Obj_Angle(A0), D0				 ; $0026
		cmpi.w	#$0040, Obj_Angle(A0)					 ; $0026
		bne.s	Offset_0x02744E
		move.l	#Offset_0x0273C4, (A0)
Offset_0x02744E:
		lea		Offset_0x0274A8(PC), A1
		move.w	(A1, D0), D1
		move.w	$20(A1, D0), D2
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		add.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	D2, Obj_Y(A0)					 ; $0014
Offset_0x02746A:
		move.w	(Camera_X_Left).w, D1				 ; $FFFFF7DA
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		andi.w	#$FF80, D0
		subi.w	#$0280, D0
		cmp.w	D0, D1
		bcs.s	Offset_0x027496
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		andi.w	#$FF80, D0
		cmp.w	D0, D1
		bhi.s	Offset_0x027496
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x027496:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x0274A2
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x0274A2:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0274A8:
		dc.w	$0000, $0002, $0004, $0006, $0009, $000B, $000D, $000F
		dc.w	$0010, $0012, $0013, $0015, $0016, $0016, $0017, $0017
		dc.w	$0018, $0017, $0017, $0016, $0016, $0015, $0013, $0012
		dc.w	$0010, $000F, $000D, $000B, $0009, $0006, $0004, $0002
		dc.w	$0000, $FFFD, $FFFB, $FFF9, $FFF6, $FFF4, $FFF2, $FFF0
		dc.w	$FFEF, $FFED, $FFEC, $FFEA, $FFE9, $FFE9, $FFE8, $FFE8
		dc.w	$FFE8, $FFE8, $FFE8, $FFE9, $FFE9, $FFEA, $FFEC, $FFED
		dc.w	$FFEF, $FFF0, $FFF2, $FFF4, $FFF6, $FFF9, $FFFB, $FFFD
		dc.w	$0000, $0002, $0004, $0006, $0009, $000B, $000D, $000F
		dc.w	$0010, $0012, $0013, $0015, $0016, $0016, $0017, $0017
;-------------------------------------------------------------------------------
Spikes_On_Conveyor_Belt_Mappings:					   ; Offset_0x027548
		dc.w	Offset_0x02754A-Spikes_On_Conveyor_Belt_Mappings
Offset_0x02754A:
		dc.w	$0001
		dc.w	$F40A, $0000, $FFF4
;===============================================================================
; Objeto 0x3F - Espinhos nas esteiras na Hydrocity
; <<<-
;===============================================================================