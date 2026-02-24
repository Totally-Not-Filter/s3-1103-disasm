;===============================================================================
; Objeto 0x31 - Atributo dos cilindros giratórios horizontais na Launch Base
; ->>>
;===============================================================================
; Offset_0x02350C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, Obj_Control_Var_02(A0)				 ; $0032
		neg.w	D0
		move.w	D0, Obj_Control_Var_00(A0)				 ; $0030
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.l	#Offset_0x023528, (A0)
Offset_0x023528:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		(Sonic_LBz_Cylinder_Angle).w, A2			 ; $FFFFF7B2
		moveq	#$03, D6
		bsr.s	Offset_0x023546
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		(Miles_LBz_Cylinder_Angle).w, A2			 ; $FFFFF7B3
		addq.b	#$01, D6
		bsr.s	Offset_0x023546
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x023546:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x0235BC
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_Control_Var_00(A0), D0				 ; $0030
		blt.s	Offset_0x0235BA
		cmp.w	Obj_Control_Var_02(A0), D0				 ; $0032
		bge.s	Offset_0x0235BA
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0053, D0
		cmpi.w	#$00A6, D0
		bcc.s	Offset_0x0235BA
		cmpi.w	#$0093, D0
		bcc.s	Offset_0x023580
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x0235BA
Offset_0x023580:
		cmpi.b	#$06, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x0235BA
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.s	Offset_0x0235BA
		cmpi.w	#$0008, D0
		bcc.s	Offset_0x023598
		move.b	#$81, (A2)
Offset_0x023598:
		cmpi.w	#$009E, D0
		bcs.s	Offset_0x0235A2
		move.b	#$01, (A2)
Offset_0x0235A2:
		jsr		(Ride_Object_Set_Ride).l		   ; Offset_0x013C80
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		tst.w	Obj_Inertia(A1)					 ; $001C
		bne.s	Offset_0x0235BA
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
Offset_0x0235BA:
		rts
Offset_0x0235BC:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0235D8
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_Control_Var_00(A0), D0				 ; $0030
		blt.s	Offset_0x0235D8
		cmp.w	Obj_Control_Var_02(A0), D0				 ; $0032
		blt.s	Offset_0x023610
Offset_0x0235D8:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$00, Obj_Subtype(A1)					 ; $002C
		move.b	#$04, Obj_Flags_2(A1)					 ; $002D
		bset	#$01, Obj_Status(A1)					 ; $002A
		rts
;-------------------------------------------------------------------------------
; Offset_0x0235F6:
		move.b	(A2), D0
		addi.b	#$20, D0
		cmpi.b	#$40, D0
		bcc.s	Offset_0x023608
		asr.w	Obj_Speed_Y(A1)					 ; $001A
		bra.s	Offset_0x0235D8
Offset_0x023608:
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bra.s	Offset_0x0235D8
Offset_0x023610:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x0235BA
		move.b	(A2), D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		moveq	#$00, D2
		move.b	Obj_Height_2(A1), D2					 ; $001E
		lsl.w	#$08, D2
		addi.w	#$4000, D2
		muls.w	D2, D1
		swap	D1
		add.w	Obj_Y(A0), D1					 ; $0014
		move.w	D1, Obj_Y(A1)					 ; $0014
		move.b	(A2), D0
		addi.b	#$80, D0
		move.b	D0, Obj_Flip_Angle(A1)					 ; $0027
		addq.b	#$02, (A2)
		tst.w	Obj_Inertia(A1)					 ; $001C
		bne.s	Offset_0x023650
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
Offset_0x023650:
		bset	#$07, Obj_Art_VRAM(A1)					 ; $000A
		tst.b	D0
		bpl.s	Offset_0x023660
		bclr	#$07, Obj_Art_VRAM(A1)					 ; $000A
Offset_0x023660:
		rts
;===============================================================================
; Objeto 0x31 - Atributo dos cilindros giratórios horizontais na Launch Base
; <<<-
;===============================================================================