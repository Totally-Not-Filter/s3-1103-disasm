;===============================================================================
; Objeto 0xC3 - Trampolim na Icecap
; ->>>
;===============================================================================
; Offset_0x047D46:
		lea		Trampoline_Setup_Data(PC), A1		   ; Offset_0x047F68
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x047D62, (A0)
		move.w	Obj_Y(A0), Obj_Child_Data(A0)			  ; $0014, $0030
		lea		Offset_0x047F7C(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x047D62:
		bsr.w	Offset_0x047DFC
		bsr.w	Offset_0x047EC8
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047D6E:
		lea		Offset_0x047F74(PC), A1
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x047D9E, (A0)
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x047D88
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x047D88:
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0002, Obj_Sub_Y(A0)					 ; $0016
		bsr.w	Offset_0x047DA6
		move.b	#$08, Obj_Map_Id(A0)					 ; $0022
Offset_0x047D9E:
		bsr.w	Offset_0x047DDC
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
Offset_0x047DA6:
		lea		Obj_Speed_X(A0), A1				 ; $0018
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_Y(A0), D1					 ; $0014
		moveq	#$00, D2
		moveq	#$01, D3
Offset_0x047DB6:
		move.w	D0, D4
		move.w	Offset_0x047DD8(PC, D2), D5
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x047DC6
		neg.w	D5
Offset_0x047DC6:
		add.w	D5, D4
		move.w	D4, (A1)+
		move.w	D1, (A1)+
		move.w	#$0008, (A1)+
		addq.w	#$02, D2
		dbra	D3, Offset_0x047DB6
		rts
;-------------------------------------------------------------------------------
Offset_0x047DD8:
		dc.w	$000C, $0018
;-------------------------------------------------------------------------------
Offset_0x047DDC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		lea		Obj_Speed_Y(A0), A2				 ; $001A
		move.w	Obj_Y(A0), D0					 ; $0014
		move.w	Obj_Y(A1), D1					 ; $0014
		move.w	D1, D2
		sub.w	D0, D1
		asr.w	#$01, D1
		add.w	D0, D1
		move.w	D1, (A2)
		addq.w	#$06, A2
		move.w	D2, (A2)
		rts
Offset_0x047DFC:
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x047E82
		move.w	#$0080, D0
		move.w	Obj_Y(A0), D1					 ; $0014
		move.w	Obj_Speed_Y(A0), D2				 ; $001A
		move.b	Obj_Control_Var_09(A0), D3				 ; $0039
		sub.w	Obj_Control_Var_02(A0), D1				 ; $0032
		scs		Obj_Control_Var_09(A0)					 ; $0039
		bcs.s	Offset_0x047E24
		neg.w	D0
		bra.w	Offset_0x047E26
Offset_0x047E24:
		neg.w	D1
Offset_0x047E26:
		cmp.b	Obj_Control_Var_09(A0), D3				 ; $0039
		beq.s	Offset_0x047E56
		add.w	D0, D2
		add.w	D0, D2
		cmpi.w	#$FF80, D2
		bge.s	Offset_0x047E44
		cmpi.w	#$FC00, D2
		bgt.s	Offset_0x047E56
		bsr.w	Offset_0x047E84
		bra.w	Offset_0x047E56
Offset_0x047E44:
		cmpi.w	#$0080, D2
		bgt.s	Offset_0x047E56
		cmpi.w	#$0001, D1
		bhi.s	Offset_0x047E56
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x047E56:
		add.w	D0, D2
		move.w	#$F700, D3
		cmp.w	D3, D2
		bge.s	Offset_0x047E64
		bra.w	Offset_0x047E6A
Offset_0x047E64:
		neg.w	D3
		cmp.w	D3, D2
		ble.s	Offset_0x047E6C
Offset_0x047E6A:
		move.w	D3, D2
Offset_0x047E6C:
		move.w	D2, Obj_Speed_Y(A0)				 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		cmpi.w	#$0050, D1
		bcs.s	Offset_0x047E82
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x047E82:
		rts
Offset_0x047E84:
		move.b	Obj_Control_Var_0A(A0), D3				 ; $003A
		andi.b	#$18, D3
		beq.s	Offset_0x047EC6
		btst	#$03, D3
		beq.s	Offset_0x047E9C
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x047EA6
Offset_0x047E9C:
		btst	#$04, D3
		beq.s	Offset_0x047EC6
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
Offset_0x047EA6:
		move.w	D2, Obj_Speed_Y(A1)				 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.b	#$10, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$02, Obj_Routine(A1)					 ; $0005
Offset_0x047EC6:
		rts
Offset_0x047EC8:
		move.b	Obj_Status(A0), Obj_Control_Var_0A(A0)	  ; $002A, $003A
		move.w	(Obj_Player_One+Obj_Speed_Y).w, -(A7)		 ; $FFFFB01A
		move.w	(Obj_Player_Two+Obj_Speed_Y).w, -(A7)		 ; $FFFFB064
		moveq	#$23, D1
		moveq	#$14, D2
		moveq	#$0B, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		move.l	(A7)+, D0
		move.b	Obj_Status(A0), D1				 ; $002A
		move.b	Obj_Control_Var_0A(A0), D2				 ; $003A
		move.b	D1, Obj_Control_Var_0A(A0)				 ; $003A
		eor.b	D1, D2
		andi.b	#$18, D2
		beq.s	Offset_0x047F28
		bsr.w	Offset_0x047F4A
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	Obj_Control_Var_09(A0)					 ; $0039
		moveq	#$03, D4
		btst	D4, D2
		beq.s	Offset_0x047F18
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x047F2A
Offset_0x047F18:
		moveq	#$04, D4
		btst	D4, D2
		beq.s	Offset_0x047F28
		swap	D0
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x047F2A
Offset_0x047F28:
		rts
Offset_0x047F2A:
		move.w	Obj_Speed_Y(A0), D5				 ; $001A
		btst	D4, D1
		bne.s	Offset_0x047F3C
		tst.w	D0
		bpl.s	Offset_0x047F3C
		add.w	D5, Obj_Speed_Y(A1)				 ; $001A
		neg.w	D0
Offset_0x047F3C:
		add.w	D0, D5
		move.w	D5, D6
		asr.w	#$02, D6
		sub.w	D6, D5
		move.w	D5, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x047F4A:
		moveq	#$00, D5
		btst	#$03, D1
		beq.s	Offset_0x047F54
		addq.w	#$08, D5
Offset_0x047F54:
		btst	#$04, D1
		beq.s	Offset_0x047F5C
		addq.w	#$08, D5
Offset_0x047F5C:
		move.w	Obj_Child_Data(A0), D3					 ; $0030
		add.w	D5, D3
		move.w	D3, Obj_Control_Var_02(A0)				 ; $0032
		rts
;-------------------------------------------------------------------------------
Trampoline_Setup_Data:						   ; Offset_0x047F68
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$437D, $0280
		dc.b	$18, $0C, $1F, $00
;-------------------------------------------------------------------------------
Offset_0x047F74:
		dc.w	$43B6, $0280
		dc.b	$40, $40, $08, $00
;-------------------------------------------------------------------------------
Offset_0x047F7C:
		dc.w	$0001
		dc.l	Offset_0x047D6E
		dc.b	$C8, $00
		dc.l	Offset_0x047D6E
		dc.b	$38, $00
;===============================================================================
; Objeto 0xC3 - Trampolim na Icecap
; <<<-
;===============================================================================