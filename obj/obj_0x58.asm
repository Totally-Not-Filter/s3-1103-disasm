;===============================================================================
; Objeto 0x58 - Bola de espinhos girat�ria na Marble Garden.
; ->>>
;===============================================================================
; Offset_0x02A390:
		move.l	#Swinging_Spiked_Ball_Mappings, Obj_Map(A0) ; Offset_0x02A582, $000C
		move.w	#$235F, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.b	#$8F, Obj_Col_Flags(A0)					 ; $0028
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02A444
		move.l	#Offset_0x02A4C4, (A1)
		move.l	#Swinging_Spiked_Ball_Mappings, Obj_Map(A1) ; Offset_0x02A582, $000C
		move.w	#$235F, Obj_Art_VRAM(A1)				 ; $000A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.b	#$50, Obj_Width(A1)				 ; $0007
		move.b	#$50, Obj_Height(A1)					 ; $0006
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.w	#$0004, Obj_Sub_Y(A1)					 ; $0016
		lea		Obj_Speed_X(A1), A2				 ; $0018
		move.w	Obj_Sub_Y(A1), D0				 ; $0016
Offset_0x02A424:
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0000, (A2)+
		dbra	D0, Offset_0x02A424
		move.w	#$0001, -2(A2)
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x02A444:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x02A46A
		move.w	#$0002, -2(A2)
		move.b	#$02, Obj_Map_Id(A1)					 ; $0022
		move.w	#$8000, Obj_Control_Var_04(A0)			 ; $0034
		move.w	#$0100, Obj_Control_Var_06(A0)			 ; $0036
		move.l	#Offset_0x02A49A, (A0)
		bra.s	Offset_0x02A49A
Offset_0x02A46A:
		moveq	#$02, D0
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A476
		neg.w	D0
Offset_0x02A476:
		move.b	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.l	#Offset_0x02A480, (A0)
Offset_0x02A480:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		bsr.w	Offset_0x02A4CA
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		add.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_5_D0).l			   ; Offset_0x011BD0
Offset_0x02A49A:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		bsr.w	Offset_0x02A526
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		bpl.s	Offset_0x02A4B0
		addi.w	#$0010, Obj_Control_Var_06(A0)			 ; $0036
		bra.s	Offset_0x02A4B6
Offset_0x02A4B0:
		subi.w	#$0010, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x02A4B6:
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		add.w	D0, Obj_Control_Var_04(A0)				 ; $0034
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
Offset_0x02A4C4:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02A4CA:
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$00, Obj_Map_Id(A1)					 ; $0022
		move.w	#$0005, Obj_Sub_Y(A1)					 ; $0016
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		bpl.s	Offset_0x02A4F4
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		move.w	#$0004, Obj_Sub_Y(A1)					 ; $0016
Offset_0x02A4F4:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	Obj_Control_Var_00(A0), D3				 ; $0030
		swap	D1
		asr.l	#$04, D1
		move.l	D1, D5
		lea		Obj_Speed_X(A1), A2				 ; $0018
		moveq	#$03, D6
Offset_0x02A50A:
		move.l	D5, D4
		swap	D4
		add.w	D3, D4
		move.w	D4, (A2)+
		add.l	D1, D5
		addq.w	#$04, A2
		dbra	D6, Offset_0x02A50A
		add.l	D1, D5
		swap	D5
		add.w	D3, D5
		move.w	D5, Obj_X(A0)					 ; $0010
		rts
Offset_0x02A526:
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$00, Obj_Map_Id(A1)					 ; $0022
		move.w	#$0005, Obj_Sub_Y(A1)					 ; $0016
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		bpl.s	Offset_0x02A550
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$02, Obj_Map_Id(A1)					 ; $0022
		move.w	#$0004, Obj_Sub_Y(A1)					 ; $0016
Offset_0x02A550:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	Obj_Control_Var_02(A0), D3				 ; $0032
		swap	D1
		asr.l	#$04, D1
		move.l	D1, D5
		lea		Obj_Speed_Y(A1), A2				 ; $001A
		moveq	#$03, D6
Offset_0x02A566:
		move.l	D5, D4
		swap	D4
		add.w	D3, D4
		move.w	D4, (A2)+
		add.l	D1, D5
		addq.w	#$04, A2
		dbra	D6, Offset_0x02A566
		add.l	D1, D5
		swap	D5
		add.w	D3, D5
		move.w	D5, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Swinging_Spiked_Ball_Mappings:				   ; Offset_0x02A582
		dc.w	Offset_0x02A58A-Swinging_Spiked_Ball_Mappings
		dc.w	Offset_0x02A592-Swinging_Spiked_Ball_Mappings
		dc.w	Offset_0x02A59A-Swinging_Spiked_Ball_Mappings
		dc.w	Offset_0x02A5A2-Swinging_Spiked_Ball_Mappings
Offset_0x02A58A:
		dc.w	$0001
		dc.w	$F805, $007B, $FFF8
Offset_0x02A592:
		dc.w	$0001
		dc.w	$F807, $007F, $FFF8
Offset_0x02A59A:
		dc.w	$0001
		dc.w	$F80D, $0087, $FFE8
Offset_0x02A5A2:
		dc.w	$0004
		dc.w	$E00F, $005B, $FFE0
		dc.w	$E00F, $085B, $0000
		dc.w	$000F, $006B, $FFE0
		dc.w	$000F, $086B, $0000
;===============================================================================
; Objeto 0x58 - Bola de espinhos girat�ria na Marble Garden.
; <<<-
;===============================================================================