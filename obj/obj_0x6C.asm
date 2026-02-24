;===============================================================================
; Objeto 0x6C - Ponte na Hydrocity / Lava Reef / Icecap
; ->>>
;===============================================================================
; Offset_0x02E504:
		move.l	#Offset_0x02E64E, (A0)
		move.l	#Bridge_Mappings, Obj_Map(A0)	; Offset_0x02EE60, $000C
		move.w	#$4038, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		cmpi.b	#Iz_Id, (Current_Zone).w			; $05, $FFFFFE10
		bne.s	Offset_0x02E54C
		move.l	#Offset_0x02E6F0, (A0)
		move.l	#Iz_Bridge_Mappings, Obj_Map(A0) ; Offset_0x02EE28, $000C
		move.w	#$43B6, Obj_Art_VRAM(A0)				 ; $000A
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x02E54C
		move.l	#Offset_0x02E7B4, (A0)
		andi.b	#$7F, Obj_Subtype(A0)					 ; $002C
Offset_0x02E54C:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x02E55E
		move.l	#Offset_0x02E624, (A0)
		andi.b	#$7F, Obj_Subtype(A0)					 ; $002C
Offset_0x02E55E:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, Obj_Control_Var_0C(A0)				 ; $003C
		move.w	Obj_X(A0), D3					 ; $0010
		lea		Obj_Subtype(A0), A2				 ; $002C
		moveq	#$00, D1
		move.b	(A2), D1
		move.w	D1, D0
		lsr.w	#$01, D0
		lsl.w	#$04, D0
		sub.w	D0, D3
		swap	D1
		move.w	#$0008, D1
		bsr.s	Offset_0x02E5C4
		move.w	Obj_Control_Var_00(A1), D0				 ; $0030
		subq.w	#$08, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.l	A1, Obj_Control_Var_00(A0)				 ; $0030
		swap	D1
		subq.w	#$08, D1
		bls.s	Offset_0x02E5C0
		move.w	D1, D4
		bsr.s	Offset_0x02E5C4
		move.l	A1, Obj_Control_Var_04(A0)				 ; $0034
		move.w	D4, D0
		add.w	D0, D0
		add.w	D4, D0
		move.w	$18(A1, D0), D0
		subq.w	#$08, D0
		move.w	D0, Obj_X(A1)					 ; $0010
Offset_0x02E5C0:
		bra.w	Offset_0x02E64E
Offset_0x02E5C4:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x02E622
		move.l	#Offset_0x02E6EA, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.w	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.b	#$40, Obj_Width(A1)				 ; $0007
		move.b	#$08, Obj_Height(A1)					 ; $0006
		move.w	D1, Obj_Sub_Y(A1)				 ; $0016
		subq.b	#$01, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
Offset_0x02E612:
		move.w	D3, (A2)+
		move.w	D2, (A2)+
		move.w	#$0000, (A2)+
		addi.w	#$0010, D3
		dbra	D1, Offset_0x02E612
Offset_0x02E622:
		rts
;-------------------------------------------------------------------------------
Offset_0x02E624:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		tst.b	(A3)
		beq.s	Offset_0x02E64E
		move.l	#Offset_0x02E77A, (A0)
		move.b	#$0E, Obj_Control_Var_04(A0)			 ; $0034
		move.l	#Offset_0x02E752, D4
		bra.w	Offset_0x02E836
Offset_0x02E64E:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x02E664
		tst.b	Obj_Control_Var_0E(A0)					 ; $003E
		beq.s	Offset_0x02E690
		subq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
		bra.s	Offset_0x02E68C
Offset_0x02E664:
		andi.b	#$10, D0
		beq.s	Offset_0x02E680
		move.b	Obj_Control_Var_0F(A0), D0				 ; $003F
		sub.b	Obj_Control_Var_0B(A0), D0				 ; $003B
		beq.s	Offset_0x02E680
		bcc.s	Offset_0x02E67C
		addq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
		bra.s	Offset_0x02E680
Offset_0x02E67C:
		subq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
Offset_0x02E680:
		cmpi.b	#$40, Obj_Control_Var_0E(A0)			 ; $003E
		beq.s	Offset_0x02E68C
		addq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
Offset_0x02E68C:
		bsr.w	Offset_0x02EB30
Offset_0x02E690:
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		lsl.w	#$03, D1
		move.w	D1, D2
		addq.w	#$08, D1
		add.w	D2, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Offset_0x02E8F6
Offset_0x02E6A8:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.s	Offset_0x02E6BC
		rts
Offset_0x02E6BC:
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
		cmpi.b	#$08, Obj_Subtype(A0)					 ; $002C
		bls.s	Offset_0x02E6D8
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x02E6D8:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x02E6E4
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x02E6E4:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x02E6EA:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02E6F0:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x02E706
		tst.b	Obj_Control_Var_0E(A0)					 ; $003E
		beq.s	Offset_0x02E732
		subq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
		bra.s	Offset_0x02E72E
Offset_0x02E706:
		andi.b	#$10, D0
		beq.s	Offset_0x02E722
		move.b	Obj_Control_Var_0F(A0), D0				 ; $003F
		sub.b	Obj_Control_Var_0B(A0), D0				 ; $003B
		beq.s	Offset_0x02E722
		bcc.s	Offset_0x02E71E
		addq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
		bra.s	Offset_0x02E722
Offset_0x02E71E:
		subq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
Offset_0x02E722:
		cmpi.b	#$40, Obj_Control_Var_0E(A0)			 ; $003E
		beq.s	Offset_0x02E72E
		addq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
Offset_0x02E72E:
		bsr.w	Offset_0x02EB30
Offset_0x02E732:
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		lsl.w	#$03, D1
		move.w	D1, D2
		addq.w	#$08, D1
		add.w	D2, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Offset_0x02E8F6
		bsr.w	Offset_0x02EA80
		bra.w	Offset_0x02E6A8
;-------------------------------------------------------------------------------
Offset_0x02E752:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x02E762
		subq.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02E762:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02E774
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02E774:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x02E77A:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x02E786
		subq.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		rts
Offset_0x02E786:
		bclr	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02E79A
		bclr	#$03, (Obj_Player_One+Obj_Status).w			 ; $FFFFB02A
		bset	#$01, (Obj_Player_One+Obj_Status).w			 ; $FFFFB02A
Offset_0x02E79A:
		bclr	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02E7AE
		bclr	#$03, (Obj_Player_Two+Obj_Status).w			 ; $FFFFB074
		bset	#$01, (Obj_Player_Two+Obj_Status).w			 ; $FFFFB074
Offset_0x02E7AE:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x02E7B4:
		bsr.w	Offset_0x02EBE2
		move.l	#Offset_0x02E7BE, (A0)
Offset_0x02E7BE:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x02E7D4
		tst.b	Obj_Control_Var_0E(A0)					 ; $003E
		beq.s	Offset_0x02E816
		subq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
		bra.s	Offset_0x02E812
Offset_0x02E7D4:
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		lsl.w	#$03, D1
		move.w	D1, D2
		addq.w	#$08, D1
		add.w	D2, D2
		bsr.w	Offset_0x02EA46
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$10, D0
		beq.s	Offset_0x02E806
		move.b	Obj_Control_Var_0F(A0), D0				 ; $003F
		sub.b	Obj_Control_Var_0B(A0), D0				 ; $003B
		beq.s	Offset_0x02E806
		bcc.s	Offset_0x02E802
		addq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
		bra.s	Offset_0x02E806
Offset_0x02E802:
		subq.b	#$01, Obj_Control_Var_0F(A0)			 ; $003F
Offset_0x02E806:
		cmpi.b	#$40, Obj_Control_Var_0E(A0)			 ; $003E
		beq.s	Offset_0x02E812
		addq.b	#$04, Obj_Control_Var_0E(A0)			 ; $003E
Offset_0x02E812:
		bsr.w	Offset_0x02EBE2
Offset_0x02E816:
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		lsl.w	#$03, D1
		move.w	D1, D2
		addq.w	#$08, D1
		add.w	D2, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Offset_0x02E998
		bsr.w	Offset_0x02EA80
		bra.w	Offset_0x02E6A8
Offset_0x02E836:
		move.l	Obj_Control_Var_00(A0), A3				 ; $0030
		bsr.s	Offset_0x02E84C
		cmpi.b	#$08, Obj_Subtype(A0)					 ; $002C
		bls.s	Offset_0x02E84A
		move.l	Obj_Control_Var_04(A0), A3				 ; $0034
		bsr.s	Offset_0x02E84C
Offset_0x02E84A:
		rts
Offset_0x02E84C:
		lea		(Offset_0x02E8E6).l, A4
		lea		Obj_Speed_X(A3), A2				 ; $0018
		move.w	Obj_Sub_Y(A3), D6				 ; $0016
		subq.w	#$01, D6
		bclr	#$06, Obj_Flags(A3)				 ; $0004
		move.l	A3, A1
		bra.s	Offset_0x02E86E
;-------------------------------------------------------------------------------
Offset_0x02E866:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x02E8D2
Offset_0x02E86E:
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
		bne.s	Offset_0x02E8D2
		move.l	#Obj_Dissipate, (A1)		   ; Offset_0x013E86
		move.w	Obj_X(A5), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A5), Obj_Y(A1)			  ; $0014, $0014
		move.b	-1(A4), Obj_Ani_Time(A1)			  ; $0024
		dbra	D6, Offset_0x02E866
Offset_0x02E8D2:
		move.w	#$0000, Obj_Speed_X(A3)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A3)					 ; $001A
		moveq	#Bridge_Collapse_Sfx, D0				  ; -$69
		jmp		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x02E8E6:
		dc.b	$08, $10, $0C, $0E, $06, $0A, $04, $02
		dc.b	$08, $10, $0C, $0E, $06, $0A, $04, $02
;-------------------------------------------------------------------------------
Offset_0x02E8F6:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		moveq	#$3B, D5
		movem.l D1-D4, -(A7)
		bsr.s	Offset_0x02E910
		movem.l (A7)+, D1-D4
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		subq.b	#$01, D6
		moveq	#$3F, D5
Offset_0x02E910:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x02E974
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02E930
		moveq	#$00, D0
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x02E930
		cmp.w	D2, D0
		bcs.s	Offset_0x02E93E
Offset_0x02E930:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		moveq	#$00, D4
		rts
Offset_0x02E93E:
		lsr.w	#$04, D0
		move.b	D0, $00(A0, D5)
		move.l	Obj_Control_Var_00(A0), A2				 ; $0030
		cmpi.w	#$0008, D0
		bcs.s	Offset_0x02E956
		move.l	Obj_Control_Var_04(A0), A2				 ; $0034
		subi.w	#$0008, D0
Offset_0x02E956:
		add.w	D0, D0
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		move.w	$1A(A2, D0), D0
		subq.w	#$08, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		sub.w	D1, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		moveq	#$00, D4
		rts
Offset_0x02E974:
		move.w	D1, -(A7)
		jsr		(Offset_0x013C08).l
		move.w	(A7)+, D1
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x02E996
		moveq	#$00, D0
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		lsr.w	#$04, D0
		move.b	D0,(A0, D5)
Offset_0x02E996:
		rts
Offset_0x02E998:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		moveq	#$3B, D5
		movem.l D1-D4, -(A7)
		bsr.s	Offset_0x02E9B2
		movem.l (A7)+, D1-D4
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		subq.b	#$01, D6
		moveq	#$3F, D5
Offset_0x02E9B2:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x02EA12
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02E9D2
		moveq	#$00, D0
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x02E9D2
		cmp.w	D2, D0
		bcs.s	Offset_0x02E9E0
Offset_0x02E9D2:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		moveq	#$00, D4
		rts
Offset_0x02E9E0:
		lsr.w	#$04, D0
		move.l	Obj_Control_Var_00(A0), A2				 ; $0030
		cmpi.w	#$0008, D0
		bcs.s	Offset_0x02E9F4
		move.l	Obj_Control_Var_04(A0), A2				 ; $0034
		subi.w	#$0008, D0
Offset_0x02E9F4:
		add.w	D0, D0
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		move.w	$1A(A2, D0), D0
		subq.w	#$08, D0
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		sub.w	D1, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		moveq	#$00, D4
		rts
Offset_0x02EA12:
		bsr.s	Offset_0x02EA16
		rts
Offset_0x02EA16:
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x02EA44
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x02EA44
		cmp.w	D2, D0
		bcc.s	Offset_0x02EA44
		lsr.w	#$04, D0
		move.w	D0, D3
		add.w	D0, D0
		add.w	D0, D3
		neg.w	D3
		addq.w	#$08, D3
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	D3, D0
		jmp		(Offset_0x013C4A).l
Offset_0x02EA44:
		rts
Offset_0x02EA46:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		moveq	#$3B, D5
		bsr.s	Offset_0x02EA58
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		subq.b	#$01, D6
		moveq	#$3F, D5
Offset_0x02EA58:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x02EA7E
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x02EA7E
		moveq	#$00, D0
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x02EA7E
		cmp.w	D2, D0
		bcc.s	Offset_0x02EA7E
		lsr.w	#$04, D0
		move.b	D0,(A0, D5)
Offset_0x02EA7E:
		rts
Offset_0x02EA80:
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		lea		$001D(A1), A1
		move.l	Obj_Control_Var_04(A0), A2				 ; $0034
		lea		$001D(A2), A2
		moveq	#-$02, D3
		moveq	#-$02, D4
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.w	#$0008, D0
		beq.s	Offset_0x02EAAC
		tst.w	(Obj_Player_One+Obj_Speed_X).w		 ; $FFFFB018
		beq.s	Offset_0x02EAAC
		move.b	Obj_Control_Var_0F(A0), D0				 ; $003F
		bsr.w	Offset_0x02EAFC
Offset_0x02EAAC:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.w	#$0010, D0
		beq.s	Offset_0x02EAC4
		tst.w	(Obj_Player_Two+Obj_Speed_X).w		 ; $FFFFB062
		beq.s	Offset_0x02EAC4
		move.b	Obj_Control_Var_0B(A0), D0				 ; $003B
		bsr.w	Offset_0x02EAFC
Offset_0x02EAC4:
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		lea		$004D(A1), A2
		lea		$001D(A1), A1
		moveq	#$00, D1
		move.b	Obj_Subtype(A0), D1				 ; $002C
		subq.b	#$01, D1
Offset_0x02EAD8:
		tst.b	(A1)
		beq.s	Offset_0x02EAE8
		addq.b	#$01, (A1)
		cmpi.b	#$0C, (A1)
		bcs.s	Offset_0x02EAE8
		move.b	#$00, (A1)
Offset_0x02EAE8:
		addq.w	#$06, A1
		cmpa.w	A2, A1
		bne.s	Offset_0x02EAF6
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		lea		$001D(A1), A1
Offset_0x02EAF6:
		dbra	D1, Offset_0x02EAD8
		rts
Offset_0x02EAFC:
		cmpi.b	#$08, D0
		bcc.s	Offset_0x02EB18
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		add.w	D0, D0
		tst.b	(A1, D0)
		bne.s	Offset_0x02EB16
		move.b	#$01,(A1, D0)
Offset_0x02EB16:
		rts
Offset_0x02EB18:
		subq.w	#$08, D0
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		add.w	D0, D0
		tst.b	$00(A2, D0)
		bne.s	Offset_0x02EB2E
		move.b	#$01, $00(A2, D0)
Offset_0x02EB2E:
		rts
Offset_0x02EB30:
		move.b	Obj_Control_Var_0E(A0), D0				 ; $003E
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D0, D4
		lea		(Bridge_Bend_Data_2).l, A4		 ; Offset_0x02ED28
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$04, D0
		moveq	#$00, D3
		move.b	Obj_Control_Var_0F(A0), D3				 ; $003F
		move.w	D3, D2
		add.w	D0, D3
		moveq	#$00, D5
		lea		(Bridge_Bend_Data-$80).l, A5			 ; Offset_0x02EC18
		move.b	(A5, D3), D5
		andi.w	#$000F, D3
		lsl.w	#$04, D3
		lea		(A4, D3), A3
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		lea		Obj_Size(A1), A2				 ; $004A
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EB76:
		moveq	#$00, D0
		move.b	(A3)+, D0
		addq.w	#$01, D0
		mulu.w	D5, D0
		mulu.w	D4, D0
		swap	D0
		add.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		move.w	D0, (A1)
		addq.w	#$06, A1
		cmpa.w	A2, A1
		bne.s	Offset_0x02EB96
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EB96:
		dbra	D2, Offset_0x02EB76
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		moveq	#$00, D3
		move.b	Obj_Control_Var_0F(A0), D3				 ; $003F
		addq.b	#$01, D3
		sub.b	D0, D3
		neg.b	D3
		bmi.s	Offset_0x02EBE0
		move.w	D3, D2
		lsl.w	#$04, D3
		lea		(A4, D3), A3
		adda.w	D2, A3
		subq.w	#$01, D2
		bcs.s	Offset_0x02EBE0
Offset_0x02EBBC:
		moveq	#$00, D0
		move.b	-(A3), D0
		addq.w	#$01, D0
		mulu.w	D5, D0
		mulu.w	D4, D0
		swap	D0
		add.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		move.w	D0, (A1)
		addq.w	#$06, A1
		cmpa.w	A2, A1
		bne.s	Offset_0x02EBDC
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EBDC:
		dbra	D2, Offset_0x02EBBC
Offset_0x02EBE0:
		rts
Offset_0x02EBE2:
		move.b	Obj_Control_Var_0E(A0), D0				 ; $003E
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D0, D4
		lea		(Bridge_Bend_Data_2).l, A4		 ; Offset_0x02ED28
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$04, D0
		moveq	#$00, D3
		move.b	Obj_Control_Var_0F(A0), D3				 ; $003F
		move.w	D3, D2
		add.w	D0, D3
		moveq	#$00, D5
		lea		(Bridge_Bend_Data-$80).l, A5			 ; Offset_0x02EC18
		move.b	(A5, D3), D5
		andi.w	#$000F, D3
		lsl.w	#$04, D3
		lea		(A4, D3), A3
		move.w	Obj_Control_Var_0C(A0), D6				 ; $003C
		move.l	Obj_Control_Var_00(A0), A1				 ; $0030
		lea		Obj_Size(A1), A2				 ; $004A
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EC2C:
		moveq	#$00, D0
		move.b	(A3)+, D0
		addq.w	#$01, D0
		mulu.w	D5, D0
		mulu.w	D4, D0
		swap	D0
		add.w	D6, D0
		addq.w	#$03, D6
		move.w	D0, (A1)
		addq.w	#$06, A1
		cmpa.w	A2, A1
		bne.s	Offset_0x02EC4C
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EC4C:
		dbra	D2, Offset_0x02EC2C
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		moveq	#$00, D3
		move.b	Obj_Control_Var_0F(A0), D3				 ; $003F
		addq.b	#$01, D3
		sub.b	D0, D3
		neg.b	D3
		bmi.s	Offset_0x02EC96
		move.w	D3, D2
		lsl.w	#$04, D3
		lea		$00(A4, D3), A3
		adda.w	D2, A3
		subq.w	#$01, D2
		bcs.s	Offset_0x02EC96
Offset_0x02EC72:
		moveq	#$00, D0
		move.b	-(A3), D0
		addq.w	#$01, D0
		mulu.w	D5, D0
		mulu.w	D4, D0
		swap	D0
		add.w	D6, D0
		addq.w	#$03, D6
		move.w	D0, (A1)
		addq.w	#$06, A1
		cmpa.w	A2, A1
		bne.s	Offset_0x02EC92
		move.l	Obj_Control_Var_04(A0), A1				 ; $0034
		lea		Obj_Speed_Y(A1), A1				 ; $001A
Offset_0x02EC92:
		dbra	D2, Offset_0x02EC72
Offset_0x02EC96:
		rts
;-------------------------------------------------------------------------------
Bridge_Bend_Data:							   ; Offset_0x02EC98
		dc.b	$02, $04, $06, $08, $08, $06, $04, $02
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $08, $06, $04
		dc.b	$02, $00, $00, $00, $00, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0A, $08, $06
		dc.b	$04, $02, $00, $00, $00, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0A, $08
		dc.b	$06, $04, $02, $00, $00, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0C, $0A
		dc.b	$08, $06, $04, $02, $00, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0E, $0C
		dc.b	$0A, $08, $06, $04, $02, $00, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0E, $0E
		dc.b	$0C, $0A, $08, $06, $04, $02, $00, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0E, $10
		dc.b	$0E, $0C, $0A, $08, $06, $04, $02, $00
		dc.b	$02, $04, $06, $08, $0A, $0C, $0E, $10
		dc.b	$10, $0E, $0C, $0A, $08, $06, $04, $02
;-------------------------------------------------------------------------------
Bridge_Bend_Data_2:							   ; Offset_0x02ED28
		dc.b	$FF, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$B5, $FF, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$7E, $DB, $FF, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$61, $B5, $EC, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$4A, $93, $CD, $F3, $FF, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$3E, $7E, $B0, $DB, $F6, $FF, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$38, $6D, $9D, $C5, $E4, $F8, $FF, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$31, $61, $8E, $B5, $D4, $EC, $FB, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$2B, $56, $7E, $A2, $C1, $DB, $EE, $FB
		dc.b	$FF, $00, $00, $00, $00, $00, $00, $00
		dc.b	$25, $4A, $73, $93, $B0, $CD, $E1, $F3
		dc.b	$FC, $FF, $00, $00, $00, $00, $00, $00
		dc.b	$1F, $44, $67, $88, $A7, $BD, $D4, $E7
		dc.b	$F4, $FD, $FF, $00, $00, $00, $00, $00
		dc.b	$1F, $3E, $5C, $7E, $98, $B0, $C9, $DB
		dc.b	$EA, $F6, $FD, $FF, $00, $00, $00, $00
		dc.b	$19, $38, $56, $73, $8E, $A7, $BD, $D1
		dc.b	$E1, $EE, $F8, $FE, $FF, $00, $00, $00
		dc.b	$19, $38, $50, $6D, $83, $9D, $B0, $C5
		dc.b	$D8, $E4, $F1, $F8, $FE, $FF, $00, $00
		dc.b	$19, $31, $4A, $67, $7E, $93, $A7, $BD
		dc.b	$CD, $DB, $E7, $F3, $F9, $FE, $FF, $00
		dc.b	$19, $31, $4A, $61, $78, $8E, $A2, $B5
		dc.b	$C5, $D4, $E1, $EC, $F4, $FB, $FE, $FF
;-------------------------------------------------------------------------------
Iz_Bridge_Mappings:							   ; Offset_0x02EE28
		dc.w	Offset_0x02EE40-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE40-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE40-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE48-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE48-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE48-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE50-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE50-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE50-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE58-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE58-Iz_Bridge_Mappings
		dc.w	Offset_0x02EE58-Iz_Bridge_Mappings
Offset_0x02EE40:
		dc.w	$0001
		dc.w	$F805, $007E, $FFF8
Offset_0x02EE48:
		dc.w	$0001
		dc.w	$F805, $0082, $FFF8
Offset_0x02EE50:
		dc.w	$0001
		dc.w	$F905, $0086, $FFF9
Offset_0x02EE58:
		dc.w	$0001
		dc.w	$F805, $008A, $FFF8
;-------------------------------------------------------------------------------
Bridge_Mappings:							   ; Offset_0x02EE60
		dc.w	Offset_0x02EE64-Bridge_Mappings
		dc.w	Offset_0x02EE6C-Bridge_Mappings
Offset_0x02EE64:
		dc.w	$0001
		dc.w	$F805, $0004, $FFF8
Offset_0x02EE6C:
		dc.w	$0001
		dc.w	$F805, $0000, $FFF8
;===============================================================================
; Objeto 0x6C - Ponte na Hydrocity / Lava Reef / Icecap
; <<<-
;===============================================================================