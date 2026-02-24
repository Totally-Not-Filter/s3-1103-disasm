;===============================================================================
; Objeto 0x3A - Mão usada para dar impulso ao jogador na Hydrocity
; ->>>
;===============================================================================
; Offset_0x026A80:
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.l	#Hand_Launcher_Mappings, Obj_Map(A0) ; Offset_0x026DB8, $000C
		move.w	#$23E4, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$40, Obj_Height(A0)					 ; $0006
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0050, Obj_Control_Var_00(A0)			 ; $0030
		bset	#$07, Obj_Status(A0)					 ; $002A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x026B02
		move.l	#Offset_0x026D8C, (A1)
		move.l	#Hand_Launcher_Mappings, Obj_Map(A1) ; Offset_0x026DB8, $000C
		move.w	#$23E4, Obj_Art_VRAM(A1)				 ; $000A
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.b	#$20, Obj_Width(A1)				 ; $0007
		move.b	#$30, Obj_Width(A1)				 ; $0007
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	A0, Obj_Control_Var_0C(A1)				 ; $003C
Offset_0x026B02:
		move.l	#Offset_0x026B08, (A0)
Offset_0x026B08:
		move.w	Obj_X(A0), D1					 ; $0010
		subi.w	#$0020, D1
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		sub.w	D1, D0
		cmpi.w	#$0040, D0
		bcs.s	Offset_0x026B28
		move.w	(Obj_Player_Two+Obj_X).w, D0		 ; $FFFFB05A
		sub.w	D1, D0
		cmpi.w	#$0040, D0
		bcc.s	Offset_0x026B86
Offset_0x026B28:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x026B60
		move.b	#$07, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		tst.w	Obj_Control_Var_06(A0)					 ; $0036
		beq.s	Offset_0x026B46
		subq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bra.s	Offset_0x026B80
Offset_0x026B46:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x026B52
		subq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x026B80
Offset_0x026B52:
		move.l	#Offset_0x026BB6, (A0)
		move.w	#$003B, Obj_Control_Var_06(A0)			 ; $0036
		bra.s	Offset_0x026B80
Offset_0x026B60:
		move.w	#$0013, Obj_Control_Var_06(A0)			 ; $0036
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		cmpi.w	#$0018, Obj_Control_Var_00(A0)			 ; $0030
		bls.s	Offset_0x026B80
		subq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x026B92
Offset_0x026B80:
		bsr.w	Offset_0x026C88
		bra.s	Offset_0x026B92
Offset_0x026B86:
		cmpi.w	#$0050, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x026B92
		addq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x026B92:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	#$0020, D1
		move.w	#$0011, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x026BB6:
		tst.w	Obj_Control_Var_06(A0)					 ; $0036
		beq.s	Offset_0x026BC6
		subq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bsr.w	Offset_0x026C88
		bra.s	Offset_0x026BF8
Offset_0x026BC6:
		cmpi.w	#$0050, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x026BDC
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
		move.l	#Offset_0x026B08, (A0)
		bra.s	Offset_0x026BF8
Offset_0x026BDC:
		cmpi.w	#$0018, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x026BF4
		bsr.w	Offset_0x026C24
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
Offset_0x026BF4:
		addq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x026BF8:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A0)					 ; $0014
		cmpi.w	#$0018, Obj_Control_Var_00(A0)			 ; $0030
		bhi.s	Offset_0x026C1E
		move.w	#$0020, D1
		move.w	#$0011, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
Offset_0x026C1E:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x026C24:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		bsr.w	Offset_0x026C34
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
Offset_0x026C34:
		bclr	D6, Obj_Control_Var_05(A0)				 ; $0035
		beq.s	Offset_0x026C74
		move.w	#$1000, Obj_Inertia(A1)					 ; $001C
		move.w	#$1000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x026C5C
		neg.w	Obj_Inertia(A1)					 ; $001C
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x026C5C:
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		rts
Offset_0x026C74:
		bclr	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x026C86
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x026C86:
		rts
Offset_0x026C88:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		move.b	(Control_Ports_Logical_Data+$01).w, D0		 ; $FFFFF603
		bsr.w	Offset_0x026CA0
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		move.b	(Control_Ports_Logical_Data_2+$01).w, D0	 ; $FFFFF66B
Offset_0x026CA0:
		btst	D6, Obj_Control_Var_05(A0)				 ; $0035
		beq.s	Offset_0x026CF6
		andi.b	#$70, D0
		beq.s	Offset_0x026D26
		bclr	D6, Obj_Control_Var_05(A0)				 ; $0035
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		move.w	#$0800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A1)					 ; $001A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x026CD6
		neg.w	Obj_Inertia(A1)					 ; $001C
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x026CD6:
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		tst.b	Obj_Control_Var_05(A0)					 ; $0035
		bne.s	Offset_0x026CF4
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x026CF4:
		rts
Offset_0x026CF6:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.w	Offset_0x026D8A
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x026D16
		move.w	Obj_X(A1), D0					 ; $0010
		addi.w	#$0008, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		cmpi.w	#$0010, D0
		bcc.s	Offset_0x026D8A
Offset_0x026D16:
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x026D8A
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x026D8A
		bset	D6, Obj_Control_Var_05(A0)				 ; $0035
Offset_0x026D26:
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		bclr	#$02, Obj_Status(A1)					 ; $002A
		cmpi.l	#Obj_Sonic, (A1)			   ; Offset_0x00AA36
		beq.s	Offset_0x026D4C
		move.b	#$0F, Obj_Height_2(A1)					 ; $001E
Offset_0x026D4C:
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		subq.w	#$02, Obj_X(A1)					 ; $0010
		move.w	#$1000, Obj_Inertia(A1)					 ; $001C
		bclr	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x026D84
		addq.w	#$04, Obj_X(A1)					 ; $0010
		neg.w	Obj_Inertia(A1)					 ; $001C
		bset	#$00, Obj_Status(A1)					 ; $002A
Offset_0x026D84:
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x026D8A:
		rts
;-------------------------------------------------------------------------------
Offset_0x026D8C:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		cmpi.w	#$0018, Obj_Control_Var_00(A1)			 ; $0030
		bls.s	Offset_0x026DA0
		rts
Offset_0x026DA0:
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$06, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x026DB2
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x026DB2:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Hand_Launcher_Mappings:						   ; Offset_0x026DB8
		dc.w	Offset_0x026DC8-Hand_Launcher_Mappings
		dc.w	Offset_0x026DEE-Hand_Launcher_Mappings
		dc.w	Offset_0x026E14-Hand_Launcher_Mappings
		dc.w	Offset_0x026E3A-Hand_Launcher_Mappings
		dc.w	Offset_0x026E60-Hand_Launcher_Mappings
		dc.w	Offset_0x026E86-Hand_Launcher_Mappings
		dc.w	Offset_0x026EAC-Hand_Launcher_Mappings
		dc.w	Offset_0x026EC0-Hand_Launcher_Mappings
Offset_0x026DC8:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0000, $FFE0
		dc.w	$F00C, $0004, $0000
		dc.w	$F80C, $0010, $FFF0
		dc.w	$0004, $0014, $FFF8
Offset_0x026DEE:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0008, $FFE0
		dc.w	$F00C, $000C, $0000
		dc.w	$F80C, $0010, $FFF0
		dc.w	$0004, $0014, $FFF8
Offset_0x026E14:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0804, $FFE0
		dc.w	$F00C, $0800, $0000
		dc.w	$F80C, $0010, $FFF0
		dc.w	$0004, $0014, $FFF8
Offset_0x026E3A:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0000, $FFE0
		dc.w	$F00C, $0004, $0000
		dc.w	$F80C, $0810, $FFF0
		dc.w	$0004, $0814, $FFF8
Offset_0x026E60:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0008, $FFE0
		dc.w	$F00C, $000C, $0000
		dc.w	$F80C, $0810, $FFF0
		dc.w	$0004, $0814, $FFF8
Offset_0x026E86:
		dc.w	$0006
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
		dc.w	$F00C, $0804, $FFE0
		dc.w	$F00C, $0800, $0000
		dc.w	$F80C, $0810, $FFF0
		dc.w	$0004, $0814, $FFF8
Offset_0x026EAC:
		dc.w	$0003
		dc.w	$BA0A, $0018, $FFF4
		dc.w	$D001, $0016, $FFFC
		dc.w	$E001, $0016, $FFFC
Offset_0x026EC0:
		dc.w	$0001
		dc.w	$C309, $0021, $FFF4
;===============================================================================
; Objeto 0x3A - Mão usada para dar impulso ao jogador na Hydrocity
; <<<-
;===============================================================================