;===============================================================================
; Objeto 0x93 - Inimigo Madmole na Mushroom Valley
; ->>>
;===============================================================================
; Offset_0x0495CC:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0495E8(PC, D0), D1
		jsr		Offset_0x0495E8(PC, D1)
		bsr.w	Offset_0x049860
		jmp		MarkObjectGone(PC)		; Offset_0x042A58
;-------------------------------------------------------------------------------
Offset_0x0495E8:
		dc.w	Offset_0x0495F0-Offset_0x0495E8
		dc.w	Offset_0x0495FA-Offset_0x0495E8
		dc.w	Offset_0x04961C-Offset_0x0495E8
		dc.w	Offset_0x04963C-Offset_0x0495E8
;-------------------------------------------------------------------------------
Offset_0x0495F0:
		lea		Madmole_Setup_Data(PC), A1			   ; Offset_0x049972
		jmp		(SetupObjectAttributes).l				 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x0495FA:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$00A0, D2
		bcs.s	Offset_0x049606
		rts
Offset_0x049606:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x04998A(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04961C:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x049626
		rts
Offset_0x049626:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$003C, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x049642, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04963C:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x049642:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x04964A:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04965E(PC, D0), D1
		jsr		Offset_0x04965E(PC, D1)
		jmp		(Child_Display_Touch_Or_Delete).l		   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x04965E:
		dc.w	Offset_0x049668-Offset_0x04965E
		dc.w	Offset_0x049680-Offset_0x04965E
		dc.w	Offset_0x0496A0-Offset_0x04965E
		dc.w	Offset_0x0496C4-Offset_0x04965E
		dc.w	Offset_0x04970C-Offset_0x04965E
;-------------------------------------------------------------------------------
Offset_0x049668:
		lea		Madmole_Setup_Data_2(PC), A1		   ; Offset_0x04997E
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x049680:
		bsr.w	Offset_0x049870
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x049692
		rts
Offset_0x049692:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x0496A0:
		bsr.w	Offset_0x049870
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x0496AC
		rts
Offset_0x0496AC:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0499A2, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0496CA, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0496C4:
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x0496CA:
		move.l	#Offset_0x0499A7, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0496F0, Obj_Child(A0)			 ; $0034
		lea		Offset_0x049992(PC), A2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0496EA
		lea		Offset_0x04999A(PC), A2
Offset_0x0496EA:
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0496F0:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0100, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x049718, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04970C:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x049718:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x049728:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04973A(PC, D0), D1
		jsr		Offset_0x04973A(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x04973A:
		dc.w	Offset_0x049744-Offset_0x04973A
		dc.w	Offset_0x049766-Offset_0x04973A
		dc.w	Offset_0x049776-Offset_0x04973A
		dc.w	SpeedToPos_Animate_Raw-Offset_0x04973A ; Offset_0x042F66
		dc.w	Offset_0x04979A-Offset_0x04973A
;-------------------------------------------------------------------------------
Offset_0x049744:
		lea		Madmole_Setup_Data_3(PC), A1		   ; Offset_0x049984
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x0499B1, Obj_Child_Data(A0)			 ; $0030
		bra.w	Offset_0x049888
;-------------------------------------------------------------------------------
Offset_0x049766:
		bsr.w	Offset_0x0498D0
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x049776:
		bsr.w	Offset_0x049924
		jsr		(Move_Light_Gravity).l		   ; Offset_0x0426C2
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x04978C
		jsr		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
Offset_0x04978C:
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x049792:
		move.w	#$FB00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x04979A:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bclr	#$00, Obj_Flags(A1)				 ; $0004
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x0497B0
		bset	#$00, Obj_Flags(A1)				 ; $0004
Offset_0x0497B0:
		tst.b	Obj_Timer(A1)					 ; $002E
		beq.s	Offset_0x049830
		moveq	#$08, D1
		move.w	Obj_X(A0), D0					 ; $0010
		btst	#$00, Obj_Flags(A1)				 ; $0004
		bne.s	Offset_0x0497C6
		neg.w	D1
Offset_0x0497C6:
		add.w	D1, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0008, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		jsr		(Move_Light_Gravity).l		   ; Offset_0x0426C2
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x0497F2
		move.w	#$0018, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		bra.w	Offset_0x0497FC
Offset_0x0497F2:
		move.w	#$FFE8, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
Offset_0x0497FC:
		tst.w	D1
		bmi.s	Offset_0x049812
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x04980C
		jsr		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
Offset_0x04980C:
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
Offset_0x049812:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		neg.w	D0
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		asr.w	#$01, D0
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x049826:
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Timer(A1)					 ; $002E
Offset_0x049830:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x049838:
		cmpi.w	#$0A00, Obj_Speed_Y(A0)					 ; $001A
		bge.s	Offset_0x049848
		move.w	#$FB00, Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x049848:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$FD00, Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		bra.s	Offset_0x049826
Offset_0x049860:
		moveq	#$1F, D1
		moveq	#$04, D2
		moveq	#$05, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
Offset_0x049870:
		jsr		(Find_Player).l				   ; Offset_0x042634
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		beq.s	Offset_0x049886
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x049886:
		rts
;-------------------------------------------------------------------------------
Offset_0x049888:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		moveq	#$00, D2
		tst.b	D0
		bpl.s	Offset_0x0498A4
		addq.w	#$04, D2
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x049792, Obj_Child(A0)			 ; $0034
Offset_0x0498A4:
		lea		Offset_0x0498C8(PC, D2), A1
		move.w	(A1)+, D0
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x0498BE
		neg.w	D0
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x0498BE:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0498C8:
		dc.w	$FA00, $0000, $FC80, $0200
;-------------------------------------------------------------------------------
Offset_0x0498D0:
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		beq.w	Offset_0x04991C
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		andi.w	#$0003, D0
		add.w	D0, D0
		lea		Offset_0x04991E-$02(PC, D0), A1
		move.w	(A1)+, A2
		tst.b	Obj_Timer(A2)					 ; $002E
		bne.s	Offset_0x04991C
		move.w	A2, Obj_Height_3(A0)					 ; $0044
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		lsl.w	#$01, D0
		move.w	D0, Obj_Speed_X(A2)				 ; $0018
		move.w	D0, Obj_Inertia(A2)				 ; $001C
		move.w	#$FE00, Obj_Speed_Y(A2)					 ; $001A
		bset	#$01, Obj_Status(A2)					 ; $002A
		move.b	#$1A, Obj_Ani_Number(A2)				 ; $0020
		clr.b	Obj_Control_Var_0D(A2)					 ; $003D
Offset_0x04991C:
		rts
;-------------------------------------------------------------------------------
Offset_0x04991E:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	Obj_Player_One					 ; $B000
;-------------------------------------------------------------------------------
Offset_0x049924:
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		beq.w	Offset_0x049970
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		andi.w	#$0003, D0
		add.w	D0, D0
		lea		Offset_0x04991E-$02(PC, D0), A1
		move.w	(A1)+, A2
		tst.b	Obj_Timer(A2)					 ; $002E
		bne.s	Offset_0x049970
		move.w	A2, Obj_Height_3(A0)					 ; $0044
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x049838, Obj_Child(A0)			 ; $0034
		bset	#$01, Obj_Status(A2)					 ; $002A
		move.b	#$01, Obj_Timer(A2)				 ; $002E
		move.b	#$1A, Obj_Ani_Number(A2)				 ; $0020
		clr.b	Obj_Control_Var_0D(A2)					 ; $003D
Offset_0x049970:
		rts
;-------------------------------------------------------------------------------
Madmole_Setup_Data:							   ; Offset_0x049972
		dc.l	Madmole_Mappings			   ; Offset_0x10E36A
		dc.w	$0536, $0280
		dc.b	$18, $04, $0D, $00
;-------------------------------------------------------------------------------
Madmole_Setup_Data_2:						   ; Offset_0x04997E
		dc.w	$0280
		dc.b	$0C, $0C, $00, $0B
;-------------------------------------------------------------------------------
Madmole_Setup_Data_3:						   ; Offset_0x049984
		dc.w	$0280
		dc.b	$08, $08, $05, $D8
;-------------------------------------------------------------------------------
Offset_0x04998A:
		dc.w	$0000
		dc.l	Offset_0x04964A
		dc.w	$0010
;-------------------------------------------------------------------------------
Offset_0x049992:
		dc.w	$0000
		dc.l	Offset_0x049728
		dc.b	$F2, $F4
;-------------------------------------------------------------------------------
Offset_0x04999A:
		dc.w	$0000
		dc.l	Offset_0x049728
		dc.b	$0E, $F4
;-------------------------------------------------------------------------------
Offset_0x0499A2:
		dc.b	$02, $00, $01, $02, $F4
;-------------------------------------------------------------------------------
Offset_0x0499A7:
		dc.b	$02, $03, $03, $04, $04, $04, $04, $04
		dc.b	$04, $F4
;-------------------------------------------------------------------------------
Offset_0x0499B1:
		dc.b	$02, $05, $06, $07, $08, $09, $0A, $0B
		dc.b	$0C, $FC, $00
;===============================================================================
; Objeto 0x93 - Inimigo Madmole na Mushroom Valley
; <<<-
;===============================================================================