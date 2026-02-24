;-------------------------------------------------------------------------------
; Objeto de controle do caminho para o chefe na Marble Garden 2
; ->>>
;-------------------------------------------------------------------------------
Obj_MGz_2_Move_Bg_Knuckles_Path:					   ; Offset_0x032A6A
		moveq	#$04, D0
		move.w	#$0400, D1
		move.w	#$38A0, D2
		move.w	#$0220, D3
		move.w	#$6000, D4
		bra.s	Offset_0x032A94
;-------------------------------------------------------------------------------
Obj_MGz_2_Move_Bg_Sonic_Path:				   ; Offset_0x032A7E
		moveq	#$08, D0
		move.w	#$0A80, D1
		move.w	#$36D0, D2
		move.w	#$01D0, D3
		move.w	#$6000, D4
		st		Obj_Control_Var_08(A0)					 ; $0038
;-------------------------------------------------------------------------------
Offset_0x032A94:
		cmp.w	(Background_Events).w, D0			 ; $FFFFEED2
		beq.s	Offset_0x032AA0
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x032AA0:
		cmp.w	(Obj_Player_One+Obj_Y).w, D1		 ; $FFFFB014
		bcc.s	Offset_0x032AAC
		cmp.w	(Obj_Player_One+Obj_X).w, D2		 ; $FFFFB010
		bcs.s	Offset_0x032AAE
Offset_0x032AAC:
		rts
Offset_0x032AAE:
		move.w	D3, Obj_Timer(A0)				 ; $002E
		move.w	D4, Obj_Control_Var_02(A0)				 ; $0032
		move.w	(Screen_Pos_Buffer_X).w, D0			 ; $FFFFEE80
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Level_Limits_Min_X).w			 ; $FFFFEE0C
		move.l	#Offset_0x032AC8, (A0)
Offset_0x032AC8:
		move.w	(Background_Events+$02).w, D0		 ; $FFFFEED4
		cmp.w	Obj_Timer(A0), D0				 ; $002E
		bcs.s	Offset_0x032ADE
		move.w	#$000E, (Earthquake_Flag).w			 ; $FFFFEECC
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x032ADE:
		move.w	(Obj_Player_One+Obj_X).w, D2		 ; $FFFFB010
		move.w	(Obj_Player_One+Obj_Y).w, D3		 ; $FFFFB014
		tst.b	Obj_Control_Var_09(A0)					 ; $0039
		beq.s	Offset_0x032AF2
		move.w	D0, D1
		addq.w	#$01, D1
		bra.s	Offset_0x032B1E
Offset_0x032AF2:
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		bne.s	Offset_0x032B06
		cmpi.w	#$0200, D3
		bcc.s	Offset_0x032B10
		cmpi.w	#$3CB0, D2
		bcs.s	Offset_0x032B0C
		bra.s	Offset_0x032B10
Offset_0x032B06:
		cmpi.w	#$3D50, D2
		bcs.s	Offset_0x032B10
Offset_0x032B0C:
		st		Obj_Control_Var_09(A0)					 ; $0039
Offset_0x032B10:
		move.l	Obj_Control_Var_04(A0), D1				 ; $0034
		add.l	Obj_Control_Var_00(A0), D1				 ; $0030
		move.l	D1, Obj_Control_Var_04(A0)				 ; $0034
		swap	D1
Offset_0x032B1E:
		move.w	D1, (Background_Events+$02).w		 ; $FFFFEED4
		sub.w	D0, D1
		sub.w	D1, (Obj_Player_One+Obj_Y).w		 ; $FFFFB014
		sub.w	D1, (Obj_Player_Two+Obj_Y).w		 ; $FFFFB05E
		rts
;-------------------------------------------------------------------------------
; Objeto de controle do caminho para o chefe na Marble Garden 2
; <<<-
;-------------------------------------------------------------------------------