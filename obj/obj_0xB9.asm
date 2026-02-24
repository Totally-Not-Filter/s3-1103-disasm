;===============================================================================
; Objeto 0xB9 - Plataforma na Icecap
; ->>>
;===============================================================================
; Offset_0x04663E:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
Obj_0xB9_Iz_Platform_2:						   ; Offset_0x046644
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04666E(PC, D0), D1
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		Offset_0x04666E(PC, D1)
		moveq	#$2B, D1
		moveq	#$14, D2
		moveq	#$14, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		bsr.w	Obj_0xB9_Sub_0x046A94		   ; Offset_0x046A94
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x04666E:
		dc.w	Offset_0x046682-Offset_0x04666E
		dc.w	Offset_0x0466BA-Offset_0x04666E
		dc.w	Offset_0x0466DA-Offset_0x04666E
		dc.w	Offset_0x0466F6-Offset_0x04666E
		dc.w	Offset_0x04673A-Offset_0x04666E
		dc.w	Offset_0x0467FC-Offset_0x04666E
		dc.w	Offset_0x046856-Offset_0x04666E
		dc.w	Offset_0x046858-Offset_0x04666E
		dc.w	Offset_0x046872-Offset_0x04666E
		dc.w	Offset_0x04688E-Offset_0x04666E
;-------------------------------------------------------------------------------
Offset_0x046682:
		lea		Platform_Setup_Data(PC), A1			   ; Offset_0x046AA6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	A0, (Obj_Knuckles_Mem_Address).w			 ; $FFFFFAA4
		move.b	#$20, Obj_Width_2(A0)					 ; $001F
		move.b	#$12, Obj_Height_2(A0)					 ; $001E
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$01, D0
		move.b	Offset_0x0466B6(PC, D0), Obj_Routine(A0)		 ; $0005
		tst.w	D0
		bne.w	Offset_0x046738
		lea		Offset_0x046AFA(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0466B6:
		dc.b	$02, $06, $0C, $0E
;-------------------------------------------------------------------------------
Offset_0x0466BA:
		btst	#$03, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x0466C4
		rts
Offset_0x0466C4:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0466EE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0466DA:
		moveq	#$01, D0
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x0466E6
		neg.w	D0
Offset_0x0466E6:
		add.w	D0, Obj_X(A0)					 ; $0010
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0466EE:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0466F6:
		btst	#$05, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x046708
		move.b	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
		andi.b	#$0C, D0
		bne.s	Offset_0x04670E
Offset_0x046708:
		clr.b	Obj_Control_Var_09(A0)					 ; $0039
		rts
Offset_0x04670E:
		addq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		cmpi.b	#$10, Obj_Control_Var_09(A0)			 ; $0039
		bcs.w	Offset_0x046738
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		jsr		Find_Player(PC)				   ; Offset_0x042634
		move.w	#$0080, D1
		tst.w	D0
		beq.s	Offset_0x046734
		neg.w	D1
Offset_0x046734:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
Offset_0x046738:
		rts
;-------------------------------------------------------------------------------
Offset_0x04673A:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		cmpi.w	#$0008, D1
		bge.s	Offset_0x046792
		move.b	D3, Obj_Angle(A0)				 ; $0026
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	D3, D0
		bpl.s	Offset_0x04675A
		neg.b	D0
Offset_0x04675A:
		andi.b	#$F8, D0
		beq.s	Offset_0x046770
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		add.w	D3, D3
		ext.w	D3
		asr.w	#$01, D3
		add.w	D3, D0
		bsr.w	Obj_0xB9_Sub_0x046A2A		   ; Offset_0x046A2A
Offset_0x046770:
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x046784
		moveq	#$1C, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		tst.w	D1
		bmi.s	Offset_0x04679E
		rts
Offset_0x046784:
		moveq	#-$1C, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
		tst.w	D1
		bmi.s	Offset_0x04679E
		rts
Offset_0x046792:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bsr.w	Offset_0x046A56
		rts
Offset_0x04679E:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		add.w	D1, Obj_X(A0)					 ; $0010
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.w	Offset_0x046738
		lea		Offset_0x046AEE(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x0467D8
		move.l	#Obj07_Springs, (A1)		; Offset_0x01921A
		move.w	#$5D6A, Obj_X(A1)				 ; $0010
		move.w	#$027A, Obj_Y(A1)				 ; $0014
		move.b	#$00, Obj_Subtype(A1)					 ; $002C
Offset_0x0467D8:
		jmp		Displace_Player_Offset_Delete_Object(PC) ; Offset_0x043388
;-------------------------------------------------------------------------------
; Offset_0x0467DC:
		dc.w	$0000, $0008, $0010, $0018, $0020, $0028, $0030, $0038
		dc.w	$FFC8, $FFD0, $FFD8, $FFE0, $FFE8, $FFF0, $FFF8, $0000
;-------------------------------------------------------------------------------
Offset_0x0467FC:
		bsr.w	Offset_0x046A3C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bmi.s	Offset_0x04683E
		tst.w	Obj_Speed_X(A0)					 ; $0018
		beq.s	Offset_0x04683C
		bmi.s	Offset_0x046828
		moveq	#$20, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		tst.w	D1
		bmi.s	Offset_0x046834
		bra.w	Offset_0x04683C
Offset_0x046828:
		moveq	#-$20, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
		tst.w	D1
		bpl.s	Offset_0x04683C
Offset_0x046834:
		add.w	D1, Obj_X(A0)					 ; $0010
		clr.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x04683C:
		rts
Offset_0x04683E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		btst	#$06, D3
		beq.s	Offset_0x046850
		neg.w	D0
Offset_0x046850:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x046856:
		rts
;-------------------------------------------------------------------------------
Offset_0x046858:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x046864
		rts
Offset_0x046864:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Y(A0), Obj_Control_Var_0A(A0)		  ; $0014, $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x046872:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x046882
		addq.w	#$01, Obj_Y(A0)					 ; $0014
		rts
Offset_0x046882:
		move.b	#$12, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x04688E:
		addi.w	#$FFE0, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bls.s	Offset_0x0468A6
		rts
Offset_0x0468A6:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Control_Var_0A(A0), Obj_Y(A0)		  ; $003A, $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0468B4:
		lea		Platform_Setup_Data_3(PC), A1		   ; Offset_0x046AD6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Animate_Raw_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB2
		move.l	#Offset_0x046B02, Obj_Child_Data(A0)			 ; $0030
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0468E0(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$08, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x0468E0:
		dc.b	$EC, $F7, $14, $F4, $14, $00, $0C, $0C
		dc.b	$F8, $09, $FC, $FA
;===============================================================================
; Objeto 0xB9 - Plataforma na Icecap
; <<<-
;===============================================================================