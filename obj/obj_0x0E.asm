;===============================================================================
; Objeto 0x0E - Objeto para fazer o jogador girar ao final das rampas na AIz
; ->>>
;===============================================================================
; Offset_0x01BC3A:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01BC6C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x01BC6C
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.s	Offset_0x01BC5A
		rts
Offset_0x01BC5A:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01BC66
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01BC66:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x01BC6C:
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x01BCF2
		move.w	Obj_X(A1), D0					 ; $0010
		addi.w	#$0010, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x01BCF2
		cmpi.w	#$0020, D0
		bge.s	Offset_0x01BCF2
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmpi.w	#$FFEC, D0
		blt.s	Offset_0x01BCF2
		cmpi.w	#$0020, D0
		bgt.s	Offset_0x01BCF2
		cmpi.w	#$0400, Obj_Speed_X(A1)					 ; $0018
		blt.s	Offset_0x01BCF2
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x01BCF2
		move.w	#$F900, Obj_Speed_Y(A1)					 ; $001A
		addi.w	#$0400, Obj_Speed_X(A1)					 ; $0018
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$00, Obj_P_Flips_Remaining(A1)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A1)			 ; $0031
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x01BCF2
		neg.b	Obj_Flip_Angle(A1)				 ; $0027
		neg.w	Obj_Inertia(A1)					 ; $001C
Offset_0x01BCF2:
		rts
;===============================================================================
; Objeto 0x0E - Objeto para fazer o jogador girar ao final das rampas na AIz
; <<<-
;===============================================================================