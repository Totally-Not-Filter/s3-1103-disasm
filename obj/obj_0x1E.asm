;===============================================================================
; Objeto 0x1E - Objeto em que o jogador pula e é lançado para cima girando
; ->>>
;===============================================================================
; Offset_0x01F5FC:
		move.l	#Spin_Launcher_Mappings, Obj_Map(A0) ; Offset_0x01F864, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x01F628, (A0)
Offset_0x01F628:
		move.w	#$002B, D1
		move.w	#$0010, D2
		move.w	Obj_X(A0), D4					 ; $0010
		lea		(Offset_0x01F838).l, A2
		lea		Obj_Timer(A0), A4				 ; $002E
		tst.b	(A4)
		beq.s	Offset_0x01F646
		subq.b	#$01, (A4)
		bra.s	Offset_0x01F662
Offset_0x01F646:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		movem.l D1-D4, -(A7)
		jsr		(Offset_0x013624).l
		cmpi.w	#$FFFE, D4
		bne.s	Offset_0x01F65E
		bsr.s	Offset_0x01F6BA
Offset_0x01F65E:
		movem.l (A7)+, D1-D4
Offset_0x01F662:
		addq.w	#$01, A4
		tst.b	(A4)
		beq.s	Offset_0x01F66C
		subq.b	#$01, (A4)
		bra.s	Offset_0x01F680
Offset_0x01F66C:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		jsr		(Offset_0x013624).l
		cmpi.w	#$FFFE, D4
		bne.s	Offset_0x01F680
		bsr.s	Offset_0x01F6BA
Offset_0x01F680:
		move.b	Obj_Status(A0), D6				 ; $002A
		andi.b	#$18, D6
		beq.s	Offset_0x01F6B4
		move.b	D6, D0
		andi.b	#$08, D0
		beq.s	Offset_0x01F6A0
		lea		Obj_Timer(A0), A4				 ; $002E
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		bsr.w	Offset_0x01F784
Offset_0x01F6A0:
		andi.b	#$10, D6
		beq.s	Offset_0x01F6B4
		lea		$002F(A0), A4
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		bsr.w	Offset_0x01F784
Offset_0x01F6B4:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01F6BA:
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01F722
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0018, D0
		cmpi.w	#$0030, D0
		bcc.s	Offset_0x01F720
		move.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$F600, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$10, (A4)
Offset_0x01F720:
		rts
Offset_0x01F722:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		neg.w	D0
		addi.w	#$0018, D0
		cmpi.w	#$0030, D0
		bcc.s	Offset_0x01F720
		move.w	Obj_X(A0), D0					 ; $0010
		subi.w	#$0010, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$F600, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$10, (A4)
		rts
Offset_0x01F784:
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01F7E0
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x01F720
		move.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$20, (A4)
		rts
Offset_0x01F7E0:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		neg.w	D0
		cmpi.w	#$0020, D0
		bcc.w	Offset_0x01F720
		move.w	Obj_X(A0), D0					 ; $0010
		subi.w	#$0010, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$20, (A4)
		rts
;-------------------------------------------------------------------------------
Offset_0x01F838:
		dc.b	$11, $11, $11, $11, $11, $11, $11, $12
		dc.b	$13, $14, $15, $16, $17, $18, $19, $1A
		dc.b	$1B, $1C, $1D, $1E, $1F, $20, $21, $21
		dc.b	$21, $21, $21, $21, $21, $21, $21, $21
		dc.b	$21, $21, $21, $21, $21, $21, $21, $21
		dc.b	$21, $21, $21, $21
;-------------------------------------------------------------------------------
Spin_Launcher_Mappings:						   ; Offset_0x01F864
		dc.w	Offset_0x01F866-Spin_Launcher_Mappings
Offset_0x01F866:
		dc.w	$0007
		dc.w	$E004, $000C, $FFF0
		dc.w	$E00D, $000E, $0000
		dc.w	$E80C, $0016, $FFE0
		dc.w	$F00D, $001A, $FFE0
		dc.w	$F00D, $0022, $0000
		dc.w	$000D, $101A, $FFE0
		dc.w	$000D, $1022, $0000
;===============================================================================
; Objeto 0x1E - Objeto em que o jogador pula e é lançado para cima girando
; <<<-
;===============================================================================