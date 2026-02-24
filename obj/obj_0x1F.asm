;===============================================================================
; Objeto 0x1F - Gancho que o jogador se pendura e desce ou sobe
; ->>>
;===============================================================================
; Offset_0x01F892:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$80, Obj_Height(A0)					 ; $0006
		move.w	Obj_Y(A0), Obj_Control_Var_0C(A0)		  ; $0014, $003C
		move.l	#Hook_Mappings, Obj_Map(A0)		; Offset_0x01FA5E, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$007F, D0
		lsl.w	#$03, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.w	#$0002, Obj_Control_Var_0A(A0)			 ; $003A
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x01F8F2
		move.w	Obj_Timer(A0), D0				 ; $002E
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.b	#$01, Obj_Control_Var_06(A0)			 ; $0036
		add.w	D0, Obj_Y(A0)					 ; $0014
		lsr.w	#$04, D0
		addq.w	#$01, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
Offset_0x01F8F2:
		move.l	#Offset_0x01F8F8, (A0)
Offset_0x01F8F8:
		tst.b	Obj_Control_Var_06(A0)					 ; $0036
		beq.s	Offset_0x01F906
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		bne.s	Offset_0x01F91C
		bra.s	Offset_0x01F90C
Offset_0x01F906:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x01F91C
Offset_0x01F90C:
		move.w	Obj_Control_Var_08(A0), D2				 ; $0038
		cmp.w	Obj_Timer(A0), D2				 ; $002E
		beq.s	Offset_0x01F940
		add.w	Obj_Control_Var_0A(A0), D2				 ; $003A
		bra.s	Offset_0x01F926
Offset_0x01F91C:
		move.w	Obj_Control_Var_08(A0), D2				 ; $0038
		beq.s	Offset_0x01F940
		sub.w	Obj_Control_Var_0A(A0), D2				 ; $003A
Offset_0x01F926:
		move.w	D2, Obj_Control_Var_08(A0)				 ; $0038
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		add.w	D2, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	D2, D0
		beq.s	Offset_0x01F93C
		lsr.w	#$04, D0
		addq.w	#$01, D0
Offset_0x01F93C:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
Offset_0x01F940:
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
		bsr.w	Offset_0x01F964
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.w	#$01, A2
		move.w	(Control_Ports_Buffer_Data+$02).w, D0		 ; $FFFFF606
		bsr.w	Offset_0x01F964
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01F964:
		tst.b	(A2)
		beq.w	Offset_0x01F9DC
		tst.b	Obj_Flags(A1)					 ; $0004
		bpl.s	Offset_0x01F9C0
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x01F9C0
		andi.b	#$70, D0
		beq.w	Offset_0x01F9CE
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$12, $0002(A2)
		andi.w	#$0F00, D0
		beq.w	Offset_0x01F99A
		move.b	#$3C, $0002(A2)
Offset_0x01F99A:
		btst	#$0A, D0
		beq.s	Offset_0x01F9A6
		move.w	#$FE00, Obj_Speed_X(A1)					 ; $0018
Offset_0x01F9A6:
		btst	#$0B, D0
		beq.s	Offset_0x01F9B2
		move.w	#$0200, Obj_Speed_X(A1)					 ; $0018
Offset_0x01F9B2:
		move.w	#$FC80, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		rts
Offset_0x01F9C0:
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A2)
		move.b	#$3C, $0002(A2)
		rts
Offset_0x01F9CE:
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0094, Obj_Y(A1)				 ; $0014
		rts
Offset_0x01F9DC:
		tst.b	$0002(A2)
		beq.s	Offset_0x01F9EA
		subq.b	#$01, $0002(A2)
		bne.w	Offset_0x01FA5C
Offset_0x01F9EA:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.w	Offset_0x01FA5C
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		subi.w	#$0088, D1
		cmpi.w	#$0018, D1
		bcc.w	Offset_0x01FA5C
		tst.b	Obj_Timer(A1)					 ; $002E
		bmi.s	Offset_0x01FA5C
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x01FA5C
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x01FA5C
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0094, Obj_Y(A1)				 ; $0014
		move.b	#$14, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		move.b	#$01, (A2)
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01FA5C:
		rts
;-------------------------------------------------------------------------------
Hook_Mappings:						   ; Offset_0x01FA5E
		dc.w	Offset_0x01FA7C-Hook_Mappings
		dc.w	Offset_0x01FA90-Hook_Mappings
		dc.w	Offset_0x01FAAA-Hook_Mappings
		dc.w	Offset_0x01FACA-Hook_Mappings
		dc.w	Offset_0x01FAF0-Hook_Mappings
		dc.w	Offset_0x01FB1C-Hook_Mappings
		dc.w	Offset_0x01FB4E-Hook_Mappings
		dc.w	Offset_0x01FB86-Hook_Mappings
		dc.w	Offset_0x01FBC4-Hook_Mappings
		dc.w	Offset_0x01FC08-Hook_Mappings
		dc.w	Offset_0x01FC52-Hook_Mappings
		dc.w	Offset_0x01FCA2-Hook_Mappings
		dc.w	Offset_0x01FCF8-Hook_Mappings
		dc.w	Offset_0x01FD54-Hook_Mappings
		dc.w	Offset_0x01FD54-Hook_Mappings
Offset_0x01FA7C:
		dc.w	$0003
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FA90:
		dc.w	$0004
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FAAA:
		dc.w	$0005
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FACA:
		dc.w	$0006
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FAF0:
		dc.w	$0007
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FB1C:
		dc.w	$0008
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FB4E:
		dc.w	$0009
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FB86:
		dc.w	$000A
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FBC4:
		dc.w	$000B
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FC08:
		dc.w	$000C
		dc.w	$C005, $003A, $FFF8
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FC52:
		dc.w	$000D
		dc.w	$B005, $003A, $FFF8
		dc.w	$C005, $003A, $FFF8
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FCA2:
		dc.w	$000E
		dc.w	$A005, $003A, $FFF8
		dc.w	$B005, $003A, $FFF8
		dc.w	$C005, $003A, $FFF8
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FCF8:
		dc.w	$000F
		dc.w	$9005, $003A, $FFF8
		dc.w	$A005, $003A, $FFF8
		dc.w	$B005, $003A, $FFF8
		dc.w	$C005, $003A, $FFF8
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
Offset_0x01FD54:
		dc.w	$0010
		dc.w	$8005, $003A, $FFF8
		dc.w	$9005, $003A, $FFF8
		dc.w	$A005, $003A, $FFF8
		dc.w	$B005, $003A, $FFF8
		dc.w	$C005, $003A, $FFF8
		dc.w	$D005, $003A, $FFF8
		dc.w	$E005, $003A, $FFF8
		dc.w	$F005, $003A, $FFF8
		dc.w	$0005, $003A, $FFF8
		dc.w	$1005, $003A, $FFF8
		dc.w	$2005, $003A, $FFF8
		dc.w	$3005, $003A, $FFF8
		dc.w	$4005, $003A, $FFF8
		dc.w	$5005, $003A, $FFF8
		dc.w	$6005, $E149, $FFF8
		dc.w	$7005, $E14E, $FFF8
;===============================================================================
; Objeto 0x1F - Gancho que o jogador se pendura e desce ou sobe
; <<<-
;===============================================================================