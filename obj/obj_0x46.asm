;===============================================================================
; Objeto 0x46 - Ventilador horizontal na Carnival Night
; ->>>
;===============================================================================
; Offset_0x02805C:
		move.l	#CNz_Fan_Mappings, Obj_Map(A0)	; Offset_0x0281E8, $000C
		move.w	#$43E8, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.w	#$000F, D0
		addq.w	#$04, D0
		lsl.w	#$04, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		addi.w	#$0030, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		andi.w	#$0070, D1
		addi.w	#$0018, D1
		move.w	D1, Obj_Control_Var_02(A0)				 ; $0032
		add.w	D1, D1
		move.w	D1, Obj_Control_Var_04(A0)				 ; $0034
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bmi.s	Offset_0x0280C4
		move.l	#Offset_0x028134, (A0)
		bra.w	Offset_0x028134
Offset_0x0280C4:
		andi.w	#$0070, D0
		move.w	D0, D1
		lsr.w	#$04, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		addi.b	#$10, D1
		move.b	D1, Obj_Width(A0)				 ; $0007
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x0280EA
		move.l	#Offset_0x028102, (A0)
		bra.w	Offset_0x028102
Offset_0x0280EA:
		move.l	#Offset_0x0280F0, (A0)
Offset_0x0280F0:
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$0E).w, D0			 ; $FFFFFE6C
		subi.w	#$0030, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
Offset_0x028102:
		moveq	#$00, D6
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x028162
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x028162
		tst.w	D6
		beq.s	Offset_0x02812A
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$1F, D0
		bne.s	Offset_0x02812A
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02812A:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Offset_0x028134:
		moveq	#$00, D6
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x028162
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x028162
		tst.w	D6
		beq.s	Offset_0x02815C
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$1F, D0
		bne.s	Offset_0x02815C
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02815C:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x028162:
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		cmp.w	Obj_Control_Var_04(A0), D0				 ; $0034
		bcc.s	Offset_0x0281E6
		moveq	#$00, D1
		move.b	(Oscillate_Data_Buffer+$16).w, D1			 ; $FFFFFE74
		add.w	Obj_Y(A1), D1					 ; $0014
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		sub.w	Obj_Y(A0), D1					 ; $0014
		bcs.s	Offset_0x0281E6
		cmp.w	Obj_Control_Var_08(A0), D1				 ; $0038
		bcc.s	Offset_0x0281E6
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.w	Offset_0x0281E6
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x0281E6
		sub.w	Obj_Control_Var_06(A0), D1				 ; $0036
		bcs.s	Offset_0x0281A8
		not.w	D1
		add.w	D1, D1
Offset_0x0281A8:
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		neg.w	D1
		asr.w	#$04, D1
		add.w	D1, Obj_Y(A1)					 ; $0014
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		moveq	#$01, D6
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
		tst.b	Obj_Flip_Angle(A1)				 ; $0027
		bne.s	Offset_0x0281E6
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$7F, Obj_Control_Var_00(A1)			 ; $0030
		move.b	#$08, Obj_Control_Var_01(A1)			 ; $0031
Offset_0x0281E6:
		rts
;-------------------------------------------------------------------------------
CNz_Fan_Mappings:							   ; Offset_0x0281E8
		dc.w	Offset_0x0281F8-CNz_Fan_Mappings
		dc.w	Offset_0x028206-CNz_Fan_Mappings
		dc.w	Offset_0x028220-CNz_Fan_Mappings
		dc.w	Offset_0x028246-CNz_Fan_Mappings
		dc.w	Offset_0x028246-CNz_Fan_Mappings
		dc.w	Offset_0x028246-CNz_Fan_Mappings
		dc.w	Offset_0x028246-CNz_Fan_Mappings
		dc.w	Offset_0x028246-CNz_Fan_Mappings
Offset_0x0281F8:
		dc.w	$0002
		dc.w	$F00C, $FF1C, $FFF0
		dc.w	$F80D, $0000, $FFF0
Offset_0x028206:
		dc.w	$0004
		dc.w	$F00C, $FF1C, $FFE0
		dc.w	$F80D, $0000, $FFE0
		dc.w	$F00C, $FF1C, $0000
		dc.w	$F80D, $0000, $0000
Offset_0x028220:
		dc.w	$0006
		dc.w	$F00C, $FF1C, $FFD0
		dc.w	$F80D, $0000, $FFD0
		dc.w	$F00C, $FF1C, $FFF0
		dc.w	$F80D, $0000, $FFF0
		dc.w	$F00C, $FF1C, $0010
		dc.w	$F80D, $0000, $0010
Offset_0x028246:
		dc.w	$0008
		dc.w	$F00C, $FF1C, $FFC0
		dc.w	$F80D, $0000, $FFC0
		dc.w	$F00C, $FF1C, $FFE0
		dc.w	$F80D, $0000, $FFE0
		dc.w	$F00C, $FF1C, $0000
		dc.w	$F80D, $0000, $0000
		dc.w	$F00C, $FF1C, $0020
		dc.w	$F80D, $0000, $0020
;===============================================================================
; Objeto 0x46 - Ventilador horizontal na Carnival Night
; <<<-
;===============================================================================