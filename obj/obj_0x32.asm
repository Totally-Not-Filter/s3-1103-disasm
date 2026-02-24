;===============================================================================
; Objeto 0x32 - Ponte ap�s derrotar o chefe no final da Angel Island 2
; ->>>
;===============================================================================
; Offset_0x02235C:
		move.l	#Draw_Bridge_Mappings, Obj_Map(A0) ; Offset_0x02277E, $000C
		move.w	#$C2F0, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$60, Obj_Height(A0)					 ; $0006
		ori.b	#$80, Obj_Status(A0)					 ; $002A
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		subi.w	#$0068, Obj_Y(A0)				 ; $0014
		move.b	#$C0, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#-$10, D4
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0223B8
		addi.w	#$00D0, Obj_Y(A0)				 ; $0014
		move.b	#$40, Obj_Control_Var_08(A0)			 ; $0038
		neg.w	D4
Offset_0x0223B8:
		move.w	#$0200, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0223C6
		neg.w	D1
Offset_0x0223C6:
		move.w	D1, Obj_Control_Var_04(A0)				 ; $0034
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x022498
		move.l	#Offset_0x0225B2, (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.b	#$40, Obj_Width(A1)				 ; $0007
		move.b	#$40, Obj_Height(A1)					 ; $0006
		move.w	Obj_Control_Var_00(A0), D2				 ; $0030
		move.w	Obj_Control_Var_02(A0), D3				 ; $0032
		moveq	#$08, D1
		move.w	D1, Obj_Sub_Y(A1)				 ; $0016
		subq.w	#$01, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x022418:
		add.w	D4, D3
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		move.w	#$0001, (A2)+
		dbra	D1, Offset_0x022418
		move.w	Obj_Control_Var_00(A1), Obj_X(A1)		  ; $0030, $0010
		move.w	Obj_Control_Var_02(A1), Obj_Y(A1)		  ; $0032, $0014
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x022498
		move.l	#Offset_0x0225B2, (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.b	#$40, Obj_Width(A1)				 ; $0007
		move.b	#$40, Obj_Height(A1)					 ; $0006
		moveq	#$04, D1
		move.w	D1, Obj_Sub_Y(A1)				 ; $0016
		subq.w	#$01, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x02247A:
		add.w	D4, D3
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		move.w	#$0001, (A2)+
		dbra	D1, Offset_0x02247A
		move.w	Obj_Speed_X(A1), Obj_X(A1)		  ; $0018, $0010
		move.w	Obj_Speed_Y(A1), Obj_Y(A1)		  ; $001A, $0014
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
Offset_0x022498:
		move.l	#Offset_0x02249E, (A0)
Offset_0x02249E:
		tst.b	(Boss_Defeated_Flag).w				 ; $FFFFFAA3
		beq.s	Offset_0x0224E2
		tst.b	Obj_Control_Var_06(A0)					 ; $0036
		bne.s	Offset_0x0224E2
		move.b	#$01, Obj_Control_Var_06(A0)			 ; $0036
		moveq	#Draw_Bridge_Move_Sfx, D0				   ; $5C
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#$0068, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0224C6
		neg.w	D1
Offset_0x0224C6:
		move.w	Obj_Control_Var_00(A0), Obj_X(A0)		  ; $0030, $0010
		move.w	Obj_Control_Var_02(A0), Obj_Y(A0)		  ; $0032, $0014
		add.w	D1, Obj_X(A0)					 ; $0010
		move.b	#$60, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
Offset_0x0224E2:
		tst.b	Obj_Control_Var_06(A0)					 ; $0036
		beq.s	Offset_0x022514
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x0224F6
		cmpi.b	#$80, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x02250C
Offset_0x0224F6:
		move.b	#$00, Obj_Control_Var_06(A0)			 ; $0036
		moveq	#Draw_Bridge_Move_Sfx, D0				   ; $5C
		jsr		(PlaySound).l					; Offset_0x001176
		move.l	#Offset_0x02251A, (A0)
		bra.s	Offset_0x022514
Offset_0x02250C:
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		add.w	D0, Obj_Control_Var_08(A0)				 ; $0038
Offset_0x022514:
		bsr.w	Offset_0x0225B8
		bra.s	Offset_0x022536
;-------------------------------------------------------------------------------
Offset_0x02251A:
		tst.b	(Knuckles_Control_Lock_Flag).w		 ; $FFFFFAA9
		beq.s	Offset_0x022536
		move.l	#Offset_0x022684, (A0)
		move.b	#$0E, Obj_Control_Var_04(A0)			 ; $0034
		move.l	#Offset_0x02265C, D4
		bra.w	Offset_0x0226BE
Offset_0x022536:
		move.w	#$0013, D1
		move.w	#$0060, D2
		move.w	#$0061, D3
		move.b	Obj_Control_Var_08(A0), D0				 ; $0038
		beq.s	Offset_0x022554
		cmpi.b	#$40, D0
		beq.s	Offset_0x022560
		cmpi.b	#$C0, D0
		beq.s	Offset_0x022560
Offset_0x022554:
		move.w	#$006B, D1
		move.w	#$0008, D2
		move.w	#$0008, D3
Offset_0x022560:
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_2).l			   ; Offset_0x0135B6
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x022584
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x022584:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x022592
		move.w	D0, A1
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x022592:
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		beq.s	Offset_0x0225A0
		move.w	D0, A1
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x0225A0:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x0225AC
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x0225AC:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0225B2:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0225B8:
		tst.b	Obj_Control_Var_06(A0)					 ; $0036
		beq.w	Offset_0x02265A
		moveq	#$00, D0
		moveq	#$00, D1
		move.b	Obj_Control_Var_08(A0), D0				 ; $0038
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	Obj_Control_Var_00(A0), D3				 ; $0030
		moveq	#$00, D6
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_Sub_Y(A1), D6				 ; $0016
		subq.w	#$01, D6
		bcs.s	Offset_0x02265A
		swap	D0
		swap	D1
		asr.l	#$04, D0
		asr.l	#$04, D1
		move.l	D0, D4
		move.l	D1, D5
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x0225F4:
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
		dbra	D6, Offset_0x0225F4
		move.w	Obj_Control_Var_00(A1), Obj_X(A1)		  ; $0030, $0010
		move.w	Obj_Control_Var_02(A1), Obj_Y(A1)		  ; $0032, $0014
		moveq	#$00, D6
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_Sub_Y(A1), D6				 ; $0016
		subq.w	#$01, D6
		bcs.s	Offset_0x02265A
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x022630:
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
		dbra	D6, Offset_0x022630
		move.w	Obj_Speed_X(A1), Obj_X(A1)		  ; $0018, $0010
		move.w	Obj_Speed_Y(A1), Obj_Y(A1)		  ; $001A, $0014
Offset_0x02265A:
		rts
;-------------------------------------------------------------------------------
Offset_0x02265C:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x02266C
		subq.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02266C:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02267E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02267E:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x022684:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x022690
		subq.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		rts
Offset_0x022690:
		bclr	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0226A4
		bclr	#$03, (Obj_Player_One+Obj_Status).w			 ; $FFFFB02A
		bset	#$01, (Obj_Player_One+Obj_Status).w			 ; $FFFFB02A
Offset_0x0226A4:
		bclr	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0226B8
		bclr	#$03, (Obj_Player_Two+Obj_Status).w			 ; $FFFFB074
		bset	#$01, (Obj_Player_Two+Obj_Status).w			 ; $FFFFB074
Offset_0x0226B8:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x0226BE:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x0226C8
		move.w	D0, A3
		bsr.s	Offset_0x0226D4
Offset_0x0226C8:
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		beq.s	Offset_0x0226D2
		move.w	D0, A3
		bsr.s	Offset_0x0226D4
Offset_0x0226D2:
		rts
Offset_0x0226D4:
		lea		(Offset_0x02276E).l, A4
		lea		Obj_Speed_X(A3), A2				 ; $0018
		move.w	Obj_Sub_Y(A3), D6				 ; $0016
		subq.w	#$01, D6
		bclr	#$06, Obj_Flags(A3)				 ; $0004
		move.l	A3, A1
		bra.s	Offset_0x0226F6
;-------------------------------------------------------------------------------
Offset_0x0226EE:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x02275A
Offset_0x0226F6:
		move.l	D4, (A1)
		move.l	Obj_Map(A3), Obj_Map(A1)		  ; $000C, $000C
		move.b	Obj_Flags(A3), Obj_Flags(A1)			  ; $0004, $0004
		move.w	Obj_Art_VRAM(A3), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	Obj_Priority(A3), Obj_Priority(A1)		  ; $0008, $0008
		move.b	Obj_Width(A3), Obj_Width(A1)			  ; $0007, $0007
		move.b	Obj_Height(A3), Obj_Height(A1)			  ; $0006, $0006
		move.w	Obj_Priority(A3), Obj_Priority(A1)		  ; $0008, $0008
		move.w	(A2)+, Obj_X(A1)				 ; $0010
		move.w	(A2)+, Obj_Y(A1)				 ; $0014
		move.w	(A2)+, D0
		move.b	D0, Obj_Map_Id(A1)				 ; $0022
		move.b	(A4)+, Obj_Control_Var_04(A1)			 ; $0034
		move.l	A1, A5
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x02275A
		move.l	#Obj_Dissipate, (A1)		   ; Offset_0x013E86
		move.w	Obj_X(A5), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A5), Obj_Y(A1)			  ; $0014, $0014
		move.b	-1(A4), Obj_Ani_Time(A1)			  ; $0024
		dbra	D6, Offset_0x0226EE
Offset_0x02275A:
		move.w	#$0000, Obj_Speed_X(A3)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A3)					 ; $001A
		moveq	#Bridge_Collapse_Sfx, D0				  ; -$69
		jmp		(PlaySound).l					; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x02276E:
		dc.b	$08, $10, $0C, $0E, $06, $0A, $04, $02
		dc.b	$08, $10, $0C, $0E, $06, $0A, $04, $02
;-------------------------------------------------------------------------------
Draw_Bridge_Mappings:						   ; Offset_0x02277E
		dc.w	Offset_0x022782-Draw_Bridge_Mappings
		dc.w	Offset_0x022784-Draw_Bridge_Mappings
Offset_0x022782:
		dc.w	$0000
Offset_0x022784:
		dc.w	$0001
		dc.w	$F805, $0122, $FFF8
;===============================================================================
; Objeto 0x32 - Ponte ap�s derrotar o chefe no final da Angel Island 2
; <<<-
;===============================================================================