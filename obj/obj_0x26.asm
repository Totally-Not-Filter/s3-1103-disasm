;===============================================================================
; Objeto 0x26 - Objeto de controle de giro autom�tico nos t�neis
; ->>>
;===============================================================================
; Offset_0x013FA8:
		move.l	#Layer_Switch_Mappings, Obj_Map(A0) ; Offset_0x012E98, $000C
		move.w	#$06BC, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$80, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		btst	#$02, D0
		beq.s	Offset_0x014022
		andi.w	#$0007, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		andi.w	#$0003, D0
		add.w	D0, D0
		move.w	Offset_0x01401A(PC, D0), Obj_Control_Var_02(A0)	 ; $0032
		move.w	Obj_Y(A0), D1					 ; $0014
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmp.w	Obj_Y(A1), D1					 ; $0014
		bcc.s	Offset_0x014000
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x014000:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmp.w	Obj_Y(A1), D1					 ; $0014
		bcc.s	Offset_0x014010
		move.b	#$01, Obj_Control_Var_05(A0)			 ; $0035
Offset_0x014010:
		move.l	#Offset_0x01413A, (A0)
		bra.w	Offset_0x01413A
;-------------------------------------------------------------------------------
Offset_0x01401A:
		dc.w	$0020, $0040, $0080, $0100
;-------------------------------------------------------------------------------
Offset_0x014022:
		andi.w	#$0003, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		add.w	D0, D0
		move.w	Offset_0x01401A(PC, D0), Obj_Control_Var_02(A0)	 ; $0032
		move.w	Obj_X(A0), D1					 ; $0010
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmp.w	Obj_X(A1), D1					 ; $0010
		bcc.s	Offset_0x014046
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x014046:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmp.w	Obj_X(A1), D1					 ; $0010
		bcc.s	Offset_0x014056
		move.b	#$01, Obj_Control_Var_05(A0)			 ; $0035
Offset_0x014056:
		move.l	#Offset_0x01405C, (A0)
Offset_0x01405C:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x0140FC
		move.w	Obj_X(A0), D1					 ; $0010
		lea		Obj_Control_Var_04(A0), A2				 ; $0034
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01407E
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.w	#$0004, (Miles_CPU_Routine).w		 ; $FFFFF708
		beq.s	Offset_0x0140FC
Offset_0x01407E:
		tst.b	(A2)+
		bne.s	Offset_0x0140C0
		cmp.w	Obj_X(A1), D1					 ; $0010
		bhi.s	Offset_0x0140FC
		move.b	#$01, -1(A2)
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		sub.w	D4, D2
		add.w	D4, D3
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		bcs.s	Offset_0x0140FC
		cmp.w	D3, D4
		bcc.s	Offset_0x0140FC
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x0140B8
		move.b	#$01, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.s	Offset_0x01410A
Offset_0x0140B8:
		move.b	#$00, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.s	Offset_0x0140FC
Offset_0x0140C0:
		cmp.w	Obj_X(A1), D1					 ; $0010
		bls.s	Offset_0x0140FC
		move.b	#$00, -1(A2)
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		sub.w	D4, D2
		add.w	D4, D3
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		bcs.s	Offset_0x0140FC
		cmp.w	D3, D4
		bcc.s	Offset_0x0140FC
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0140F6
		move.b	#$01, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.s	Offset_0x01410A
Offset_0x0140F6:
		move.b	#$00, Obj_Player_Spdsh_Flag(A1)			 ; $003D
Offset_0x0140FC:
		tst.w	(Debug_Mode_Active).w				 ; $FFFFFFFA
		beq.w	MarkObjGone_3				   ; Offset_0x011B3E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01410A:
		btst	#$02, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x014114
		rts
Offset_0x014114:
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		addq.w	#$05, Obj_Y(A1)					 ; $0014
		moveq	#Rolling_Sfx, D0				   ; $3C
		jsr		(PlaySound).l					; Offset_0x001176
		rts
Offset_0x01413A:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x0141E0
		move.w	Obj_Y(A0), D1					 ; $0014
		lea		Obj_Control_Var_04(A0), A2				 ; $0034
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01415E
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.w	#$0004, (Miles_CPU_Routine).w		 ; $FFFFF708
		beq.w	Offset_0x0141E0
Offset_0x01415E:
		tst.b	(A2)+
		bne.s	Offset_0x0141A2
		cmp.w	Obj_Y(A1), D1					 ; $0014
		bhi.s	Offset_0x0141E0
		move.b	#$01, -1(A2)
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	D2, D3
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		sub.w	D4, D2
		add.w	D4, D3
		move.w	Obj_X(A1), D4					 ; $0010
		cmp.w	D2, D4
		bcs.s	Offset_0x0141E0
		cmp.w	D3, D4
		bcc.s	Offset_0x0141E0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x01419A
		move.b	#$01, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.w	Offset_0x01410A
Offset_0x01419A:
		move.b	#$00, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.s	Offset_0x0141E0
Offset_0x0141A2:
		cmp.w	Obj_Y(A1), D1					 ; $0014
		bls.s	Offset_0x0141E0
		move.b	#$00, -1(A2)
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	D2, D3
		move.w	Obj_Control_Var_02(A0), D4				 ; $0032
		sub.w	D4, D2
		add.w	D4, D3
		move.w	Obj_X(A1), D4					 ; $0010
		cmp.w	D2, D4
		bcs.s	Offset_0x0141E0
		cmp.w	D3, D4
		bcc.s	Offset_0x0141E0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0141DA
		move.b	#$01, Obj_Player_Spdsh_Flag(A1)			 ; $003D
		bra.w	Offset_0x01410A
Offset_0x0141DA:
		move.b	#$00, Obj_Player_Spdsh_Flag(A1)			 ; $003D
Offset_0x0141E0:
		tst.w	(Debug_Mode_Active).w				 ; $FFFFFFFA
		beq.w	MarkObjGone_3				   ; Offset_0x011B3E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;===============================================================================
; Objeto 0x26 - Objeto de controle de giro autom�tico nos t�neis
; <<<-
;===============================================================================