;===============================================================================
; Objeto 0x53 - Três plataformas giratórias na Marble Garden
; ->>>
;===============================================================================
; Offset_0x02A224:
		move.l	#Swinging_Platform_Mappings, Obj_Map(A0) ; Offset_0x02A36C, $000C
		move.w	#$435F, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02A2BC
		move.l	#Offset_0x02A30E, (A1)
		move.l	#Swinging_Platform_Mappings, Obj_Map(A1) ; Offset_0x02A36C, $000C
		move.w	#$435F, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$50, Obj_Width(A1)				 ; $0007
		move.b	#$50, Obj_Height(A1)					 ; $0006
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		btst	#$01, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02A2AC
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
Offset_0x02A2AC:
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.w	#$0004, Obj_Sub_Y(A1)					 ; $0016
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x02A2BC:
		moveq	#$01, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A2C8
		neg.w	D0
Offset_0x02A2C8:
		move.b	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.l	#Offset_0x02A2DA, (A0)
Offset_0x02A2DA:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		bsr.w	Offset_0x02A314
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Height(A0), D3				 ; $0006
		addq.w	#$01, D3
		move.w	(A7)+, D4
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Offset_0x02A30E:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02A314:
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	Obj_Control_Var_00(A0), D3				 ; $0030
		swap	D0
		swap	D1
		asr.l	#$04, D0
		asr.l	#$04, D1
		move.l	D0, D4
		move.l	D1, D5
		lea		Obj_Speed_X(A1), A2				 ; $0018
		move.w	Obj_Sub_Y(A1), D6				 ; $0016
		subq.w	#$01, D6
Offset_0x02A33C:
		movem.l D4/D5, -(A7)
		swap	D4
		swap	D5
		add.w	D2, D4
		add.w	D3, D5
		move.w	D5, (A2)+
		move.w	D4, (A2)+
		movem.l (A7)+, D4/D5
		add.l	D0, D4
		add.l	D1, D5
		addq.w	#$02, A2
		dbra	D6, Offset_0x02A33C
		swap	D4
		swap	D5
		add.w	D2, D4
		add.w	D3, D5
		move.w	D5, Obj_X(A0)					 ; $0010
		move.w	D4, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Swinging_Platform_Mappings:					   ; Offset_0x02A36C
		dc.w	Offset_0x02A372-Swinging_Platform_Mappings
		dc.w	Offset_0x02A37A-Swinging_Platform_Mappings
		dc.w	Offset_0x02A382-Swinging_Platform_Mappings
Offset_0x02A372:
		dc.w	$0001
		dc.w	$F805, $0098, $FFF8
Offset_0x02A37A:
		dc.w	$0001
		dc.w	$F805, $009C, $FFF8
Offset_0x02A382:
		dc.w	$0002
		dc.w	$F40A, $008F, $FFE8
		dc.w	$F40A, $088F, $0000
;===============================================================================
; Objeto 0x53 - Três plataformas giratórias na Marble Garden
; <<<-
;===============================================================================