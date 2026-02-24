;===============================================================================
; Objeto 0x38 - Ventiladores na Hydrocity
; ->>>
;===============================================================================
; Offset_0x026408:
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		bne.w	Obj_0x38_CGz_Fan_2P			   ; Offset_0x026960
		move.l	A0, A1
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x02648A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x0264D4
		move.l	#Offset_0x02669C, (A0)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_X(A0), Obj_Control_Var_10(A0)		  ; $0010, $0040
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$001C, Obj_Y(A0)				 ; $0014
		move.l	#Water_Stream_Block_Mappings, Obj_Map(A0) ; Offset_0x025C16, $000C
		move.w	#$43D4, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$0030, D0
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.b	Obj_Subtype(A0), Obj_Subtype(A1)		  ; $002C, $002C
		bclr	#$05, Obj_Subtype(A1)					 ; $002C
		bset	#$04, Obj_Subtype(A1)					 ; $002C
Offset_0x02648A:
		move.l	#Fan_Mappings, Obj_Map(A1)		; Offset_0x0267EE, $000C
		move.w	#$240B, Obj_Art_VRAM(A1)				 ; $000A
		ori.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$0C, Obj_Height(A1)					 ; $0006
		move.w	Obj_X(A1), Obj_Control_Var_10(A1)		  ; $0010, $0040
		move.b	Obj_Subtype(A1), D0				 ; $002C
		andi.w	#$000F, D0
		addq.w	#$08, D0
		lsl.w	#$04, D0
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		addi.w	#$0030, D0
		move.w	D0, Obj_Control_Var_08(A1)				 ; $0038
		move.l	#Offset_0x0264D6, (A1)
Offset_0x0264D4:
		rts
;-------------------------------------------------------------------------------
Offset_0x0264D6:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		btst	#$05, D0
		beq.s	Offset_0x0264F4
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.w	Offset_0x0265E2
		bclr	#$05, Obj_Subtype(A0)					 ; $002C
		bset	#$04, Obj_Subtype(A0)					 ; $002C
Offset_0x0264F4:
		tst.b	Obj_Control_Var_12(A0)					 ; $0042
		bne.s	Offset_0x02652A
		btst	#$04, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x02654A
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x026522
		move.w	#$0000, Obj_Control_Var_04(A0)			 ; $0034
		move.w	#$0078, Obj_Control_Var_00(A0)			 ; $0030
		bchg	#00, Obj_Control_Var_02(A0)				 ; $0032
		beq.s	Offset_0x026522
		move.w	#$00B4, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x026522:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		beq.w	Offset_0x02654A
Offset_0x02652A:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.w	Offset_0x0265E2
		cmpi.w	#$0400, Obj_Control_Var_04(A0)			 ; $0034
		bcc.w	Offset_0x0265E2
		addi.w	#$002A, Obj_Control_Var_04(A0)			 ; $0034
		move.b	Obj_Control_Var_04(A0), Obj_Ani_Time(A0)  ; $0034, $0024
		bra.s	Offset_0x026568
Offset_0x02654A:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x0265EC
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x0265EC
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.w	Offset_0x02657A
		move.b	#$00, Obj_Ani_Time(A0)					 ; $0024
Offset_0x026568:
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$05, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x02657A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x02657A:
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0265E2
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$03, D0
		bne.s	Offset_0x0265E2
		jsr		(AllocateObject).l			 ; Offset_0x011DD8
		bne.s	Offset_0x0265E2
		move.l	#Offset_0x026680, (A1)
		move.l	#Sonic_Underwater_Mappings, Obj_Map(A1) ; Offset_0x025872, $000C
		move.w	#$045C, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.b	#$04, Obj_Width(A1)				 ; $0007
		move.b	#$04, Obj_Width(A1)				 ; $0007
		move.w	#$0300, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$000F, D0
		subq.w	#$08, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	#$F800, Obj_Speed_Y(A1)					 ; $001A
Offset_0x0265E2:
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
Offset_0x0265EC:
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.w	Offset_0x026676
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x026676
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0018, D0
		cmpi.w	#$0030, D0
		bcc.s	Offset_0x026676
		moveq	#$00, D1
		move.b	(Oscillate_Data_Buffer+$16).w, D1			 ; $FFFFFE74
		add.w	Obj_Y(A1), D1					 ; $0014
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		sub.w	Obj_Y(A0), D1					 ; $0014
		bcs.s	Offset_0x026676
		cmp.w	Obj_Control_Var_08(A0), D1				 ; $0038
		bcc.s	Offset_0x026676
		sub.w	Obj_Control_Var_06(A0), D1				 ; $0036
		bcs.s	Offset_0x026632
		not.w	D1
		add.w	D1, D1
Offset_0x026632:
		add.w	Obj_Control_Var_06(A0), D1				 ; $0036
		neg.w	D1
		asr.w	#$06, D1
		add.w	D1, Obj_Y(A1)					 ; $0014
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x026678
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
		tst.b	Obj_Flip_Angle(A1)				 ; $0027
		bne.s	Offset_0x026676
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$7F, Obj_Control_Var_00(A1)			 ; $0030
		move.b	#$08, Obj_Control_Var_01(A1)			 ; $0031
Offset_0x026676:
		rts
Offset_0x026678:
		move.b	#$0F, Obj_Ani_Number(A1)				 ; $0020
		rts
;-------------------------------------------------------------------------------
Offset_0x026680:
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x026696
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x026696:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x02669C:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		sub.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x0266D2
		cmpi.w	#$0020, D0
		blt.s	Offset_0x0266F4
		tst.b	Obj_Control_Var_12(A1)					 ; $0042
		bne.s	Offset_0x0266C2
		move.b	#$01, Obj_Control_Var_12(A1)			 ; $0042
		move.w	#$0000, Obj_Control_Var_04(A1)			 ; $0034
Offset_0x0266C2:
		move.w	Obj_Control_Var_0A(A0), D1				 ; $003A
		cmp.w	Obj_Control_Var_00(A0), D1				 ; $0030
		beq.s	Offset_0x0266F4
		addq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x0266F4
Offset_0x0266D2:
		cmpi.w	#$FFD0, D0
		bge.s	Offset_0x0266F4
		tst.b	Obj_Control_Var_12(A1)					 ; $0042
		beq.s	Offset_0x0266EA
		move.b	#$00, Obj_Control_Var_12(A1)			 ; $0042
		move.b	#$00, Obj_Ani_Time(A1)					 ; $0024
Offset_0x0266EA:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x0266F4
		subq.w	#$08, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x0266F4:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x026702
		neg.w	D0
Offset_0x026702:
		add.w	Obj_Control_Var_10(A0), D0				 ; $0040
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	D0, Obj_X(A1)					 ; $0010
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;===============================================================================
; Objeto 0x38 - Ventiladores na Hydrocity
; <<<-
;===============================================================================