;===============================================================================
; Objeto 0x03 - Parte interna da árvore na Angel Island
; ->>>
;===============================================================================
; Offset_0x014E88:
		move.b	#$D0, Obj_Width(A0)				 ; $0007
		move.l	#Offset_0x014E94, (A0)
Offset_0x014E94:
		bsr.s	Offset_0x014EF8
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x014EF2
		tst.w	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x014EF2
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x014EBA
		move.w	#$1300, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		move.w	#$4000, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		bra.s	Offset_0x014EF2
Offset_0x014EBA:
		cmpi.w	#$1300, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		beq.s	Offset_0x014ED6
		cmpi.w	#$2D00, (Obj_Player_One+Obj_X).w			 ; $FFFFB010
		bcs.s	Offset_0x014ED2
		move.w	#$1300, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		bra.s	Offset_0x014ED6
Offset_0x014ED2:
		subq.w	#$04, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
Offset_0x014ED6:
		cmpi.w	#$4000, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		beq.s	Offset_0x014EF2
		cmpi.w	#$2D00, (Obj_Player_One+Obj_X).w			 ; $FFFFB010
		bcc.s	Offset_0x014EEE
		move.w	#$4000, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		bra.s	Offset_0x014EF2
Offset_0x014EEE:
		addq.w	#$04, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
Offset_0x014EF2:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x014EF8:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		moveq	#$03, D6
		bsr.s	Offset_0x014F10
		rts
;-------------------------------------------------------------------------------
; Offset_0x014F06:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_04(A0), A2				 ; $0034
		addq.b	#$01, D6
Offset_0x014F10:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.w	Offset_0x014F92
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.w	Offset_0x014F90
		move.w	Obj_X(A1), D0					 ; $0010
		addi.w	#$0010, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x014F90
		cmpi.w	#$0040, D0
		bge.s	Offset_0x014F90
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmpi.w	#$FFA6, D0
		blt.s	Offset_0x014F90
		cmpi.w	#$00A0, D0
		bgt.s	Offset_0x014F90
		cmpi.w	#$0600, Obj_Speed_X(A1)					 ; $0018
		blt.s	Offset_0x014F90
		tst.b	Obj_Player_Control(A1)					 ; $002E
		bne.s	Offset_0x014F90
		bsr.w	Ride_Object_Set_Ride		   ; Offset_0x013C80
		move.l	#$00000000, (A2)
		bset	#$06, Obj_Player_Control(A1)			 ; $002E
		bset	#$01, Obj_Player_Control(A1)			 ; $002E
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x014F7E
		move.l	#Obj_AIz_Tree_Reveal_Control, (A1)	   ; Offset_0x03064C
Offset_0x014F7E:
		move.w	#$2C60, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		move.w	#$2C60, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		move.w	#$003C, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x014F90:
		rts
Offset_0x014F92:
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x014F9A
		neg.w	D0
Offset_0x014F9A:
		cmpi.w	#$0600, D0
		bcs.s	Offset_0x014FFE
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x014FBC
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0090, D0
		bmi.s	Offset_0x014FBC
		cmpi.w	#$0130, D0
		bls.s	Offset_0x015010
Offset_0x014FBC:
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$00, Obj_P_Flips_Remaining(A1)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A1)			 ; $0031
		bclr	#$06, Obj_Player_Control(A1)			 ; $002E
		bclr	#$01, Obj_Player_Control(A1)			 ; $002E
		rts
Offset_0x014FFE:
		cmpi.w	#$0400, (A2)
		bcc.s	Offset_0x014FBC
		move.l	D6, -(A7)
		move.l	A1, -(A7)
		bsr.s	Offset_0x015010
		move.l	(A7)+, A1
		move.l	(A7)+, D6
		bra.s	Offset_0x014FBC
Offset_0x015010:
		btst	#$03, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x014F90
		move.w	Obj_Inertia(A1), D0				 ; $001C
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, (A2)
		bmi.s	Offset_0x014FBC
		cmpi.w	#$0400, (A2)
		bcs.s	Offset_0x015038
		move.w	#$1300, (Sonic_Level_Limits_Min_X).w		 ; $FFFFEE14
		move.w	#$4000, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
Offset_0x015038:
		move.w	Obj_X(A1), D2					 ; $0010
		move.w	(A2), D0
		lsr.w	#$01, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$7000, D0
		swap	D0
		add.w	Obj_X(A0), D0					 ; $0010
		move.w	D0, Obj_X(A1)					 ; $0010
		sub.w	D2, D0
		asl.w	#$08, D0
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		move.w	Obj_Y(A1), D2					 ; $0014
		move.w	(A2), D0
		lsr.w	#$02, D0
		neg.w	D0
		addi.w	#$0090, D0
		add.w	Obj_Y(A0), D0					 ; $0014
		move.w	D0, Obj_Y(A1)					 ; $0014
		sub.w	D2, D0
		asl.w	#$08, D0
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		moveq	#$00, D0
		move.w	(A2), D0
		lsr.w	#$01, D0
		divu.w	#$000B, D0
		move.b	Offset_0x015096(PC, D0), Obj_Map_Id(A1)			 ; $0022
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		jmp		(Load_Sonic_Dynamic_PLC_D0).l			   ; Offset_0x00C7F0
;-------------------------------------------------------------------------------
Offset_0x015096:
		dc.b	$D6, $D7, $D8, $E4, $D9, $D9, $DA, $DA
		dc.b	$DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE
		dc.b	$DF, $DF, $E0, $E0, $E1, $E1, $E2, $E2
		dc.b	$E3, $E3, $E4, $E4, $D9, $D9, $DA, $DA
		dc.b	$DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE
		dc.b	$DF, $DF, $E0, $E0, $E1, $E1, $E2, $E2
		dc.b	$D8, $D8, $D7, $D7, $D6, $D6, $DB, $DB
		dc.b	$DC, $DC, $DD, $DD, $DE, $DE, $DF, $DF
		dc.b	$E0, $E0, $E1, $E1, $E2, $E2, $E3, $E3
		dc.b	$E4, $E4, $D9, $D9, $DA, $DA, $DB, $DB
		dc.b	$DC, $DC, $DD, $DD, $DE, $DE, $DF, $DF
		dc.b	$E0, $E0, $E1, $E1, $E2, $E2
;===============================================================================
; Objeto 0x03 - Parte interna da árvore na Angel Island
; <<<-
;===============================================================================