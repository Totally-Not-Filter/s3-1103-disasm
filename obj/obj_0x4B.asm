;===============================================================================
; Objeto 0x4B - Molas triangulares na Carnival Night
; ->>>
;===============================================================================
; Offset_0x028D2E:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, Obj_Control_Var_04(A0)				 ; $0034
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_02(A0)				 ; $0032
		move.l	#Offset_0x028D44, (A0)
Offset_0x028D44:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x028D56
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x028D56
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x028D56:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		cmp.w	Obj_Control_Var_02(A0), D0				 ; $0032
		bcc.s	Offset_0x028D82
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0014, D1
		cmpi.w	#$0028, D1
		bcc.s	Offset_0x028D82
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcs.s	Offset_0x028D84
Offset_0x028D82:
		rts
Offset_0x028D84:
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$F800, Obj_Speed_Y(A1)					 ; $001A
		bset	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x028DA8
		bclr	#$00, Obj_Status(A1)					 ; $002A
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x028DA8:
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x028DB4
		neg.w	Obj_Speed_Y(A1)					 ; $001A
Offset_0x028DB4:
		move.w	#$000F, Obj_Control_Var_02(A1)			 ; $0032
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		btst	#$02, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x028DCE
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
Offset_0x028DCE:
		tst.b	Obj_Flip_Angle(A1)				 ; $0027
		bne.s	Offset_0x028DF8
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$03, Obj_Control_Var_00(A1)			 ; $0030
		move.b	#$08, Obj_Control_Var_01(A1)			 ; $0031
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x028DF8
		neg.b	Obj_Flip_Angle(A1)				 ; $0027
Offset_0x028DF8:
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.w	#S2_Spring_Sfx, D0				 ; $00CC
		jmp		(PlaySound).l					; Offset_0x001176
;===============================================================================
; Objeto 0x4B - Molas triangulares na Carnival Night
; <<<-
;===============================================================================