;===============================================================================
; Objeto 0x38 - Ventiladores na Crome Gadget
; ->>>
;===============================================================================
; Offset_0x026960:
		move.l	#Fan_Mappings_2P, Obj_Map(A0)	; Offset_0x026A50, $000C
		move.w	#$6300, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Height(A0)					 ; $0006
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		addq.w	#$08, D0
		lsl.w	#$04, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		addi.w	#$0030, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.l	#Offset_0x0269A4, (A0)
Offset_0x0269A4:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x0269CC
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x0269CC
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x0269C6
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x0269C6:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0269CC:
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.w	Offset_0x026A4E
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x026A4E
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0014, D0
		cmpi.w	#$0028, D0
		bcc.s	Offset_0x026A4E
		moveq	#$00, D1
		move.b	(Oscillate_Data_Buffer+$16).w, D1			 ; $FFFFFE74
		add.w	Obj_Y(A1), D1					 ; $0014
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		sub.w	Obj_Y(A0), D1					 ; $0014
		bcs.s	Offset_0x026A4E
		cmp.w	Obj_Control_Var_08(A0), D1				 ; $0038
		bcc.s	Offset_0x026A4E
		sub.w	Obj_Control_Var_06(A0), D1				 ; $0036
		bcs.s	Offset_0x026A12
		not.w	D1
		add.w	D1, D1
Offset_0x026A12:
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		neg.w	D1
		asr.w	#$06, D1
		add.w	D1, Obj_Y(A1)					 ; $0014
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
		tst.b	Obj_Flip_Angle(A1)				 ; $0027
		bne.s	Offset_0x026A4E
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$7F, Obj_Control_Var_00(A1)			 ; $0030
		move.b	#$08, Obj_Control_Var_01(A1)			 ; $0031
Offset_0x026A4E:
		rts
;-------------------------------------------------------------------------------
Fan_Mappings_2P:							   ; Offset_0x026A50
		dc.w	Offset_0x026A56-Fan_Mappings_2P
		dc.w	Offset_0x026A64-Fan_Mappings_2P
		dc.w	Offset_0x026A72-Fan_Mappings_2P
Offset_0x026A56:
		dc.w	$0002
		dc.w	$F40C, $0000, $FFF0
		dc.w	$FC0C, $0000, $FFF0
Offset_0x026A64:
		dc.w	$0002
		dc.w	$F40C, $0008, $FFF0
		dc.w	$FC0C, $0004, $FFF0
Offset_0x026A72:
		dc.w	$0002
		dc.w	$F40C, $0004, $FFF0
		dc.w	$FC0C, $0008, $FFF0
;===============================================================================
; Objeto 0x38 - Ventiladores na Crome Gadget
; <<<-
;===============================================================================