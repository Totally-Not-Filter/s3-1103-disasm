;===============================================================================
; Painel de fim de fase
; ->>>
;===============================================================================
; Offset_0x041812:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04182E(PC, D0), D1
		jsr		Offset_0x04182E(PC, D1)
		lea		Offset_0x041AAA(PC), A2
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x04182E:
		dc.w	Offset_0x041838-Offset_0x04182E
		dc.w	Offset_0x04187A-Offset_0x04182E
		dc.w	Offset_0x0418CC-Offset_0x04182E
		dc.w	Offset_0x0418FE-Offset_0x04182E
		dc.w	Offset_0x041906-Offset_0x04182E
;-------------------------------------------------------------------------------
Offset_0x041838:
		lea		Offset_0x041A6C(PC), A1
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		move.w	A0, (Obj_End_Panel_Mem_Address).w			 ; $FFFFFAA6
		move.b	#$18, Obj_Width_2(A0)					 ; $001F
		move.b	#$1E, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x041AB2, Obj_Control_Var_00(A0)		 ; $0030
		cmpi.b	#$06, (Current_Zone).w					 ; $FFFFFE10
		bne.s	Offset_0x041866
		move.w	#$3EC0, Obj_X(A0)				 ; $0010
Offset_0x041866:
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		subi.w	#$0020, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		lea		Offset_0x041A96(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04187A:
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		andi.b	#$03, D0
		bne.s	Offset_0x04188C
		lea		Offset_0x041A9E(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
Offset_0x04188C:
		bsr.w	Offset_0x0419C0
		addi.w	#$000C, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x041A2E
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x0418CA
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x0418CA
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
Offset_0x0418CA:
		rts
;-------------------------------------------------------------------------------
Offset_0x0418CC:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x0418E2
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	(Player_Selected_Flag+$01).w, Obj_Map_Id(A0) ; $FFFFFF09, $0022
Offset_0x0418E2:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x0418FC
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x0418FC:
		rts
;-------------------------------------------------------------------------------
Offset_0x0418FE:
		move.b	#$08, D0
		jmp		Set_End_Pose_And_Load_Level_Results(PC) ; Offset_0x04381E
;-------------------------------------------------------------------------------
Offset_0x041906:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.s	Offset_0x04191A
		rts
Offset_0x04191A:
		lea		PLC_Spikes_Springs(PC), A1			   ; Offset_0x04192C
		jsr		(LoadPLC_Direct).l					 ; Offset_0x001502
		jsr		Remove_From_Tracking_Slot(PC)		   ; Offset_0x042BFA
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
PLC_Spikes_Springs:							   ; Offset_0x04192C
		dc.w	(((PLC_SpSp_End-PLC_SpSp)/$06)-$01) ; Auto Detecção do número de itens na lista por Esrael Neto
PLC_SpSp:
		dc.l	Art_Spikes_Springs			   ; Offset_0x108E64
		dc.w	$9280
PLC_SpSp_End:
;-------------------------------------------------------------------------------
Offset_0x041934:
		lea		Offset_0x041A8A(PC), A1
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x04196E, (A0)
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$001F, D0
		subi.w	#$0010, D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_X(A0), Obj_Control_Var_0A(A0)		  ; $0010, $003A
		move.w	#$1000, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Control_Var_04(A0) ; Offset_0x042D3E, $0034
Offset_0x04196E:
		move.w	#$0400, D0
		move.w	Obj_X(A0), D1					 ; $0010
		cmp.w	Obj_Control_Var_0A(A0), D1				 ; $003A
		bcs.s	Offset_0x04197E
		neg.w	D0
Offset_0x04197E:
		move.w	#$0080, D1
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		bpl.s	Offset_0x04198C
		move.w	#$0180, D1
Offset_0x04198C:
		move.w	D1, Obj_Priority(A0)					 ; $0008
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		lea		Offset_0x041AC4(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0419A8:
		move.l	#Offset_0x0419B6, (A0)
		lea		Offset_0x041A7E(PC), A1
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x0419B6:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		jmp		(Child_Display_Or_Delete).l			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0419C0:
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x041A20
		lea		Offset_0x041A26(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x041A24
		tst.w	D0
		beq.s	Offset_0x0419DA
		bsr.w	Offset_0x0419E0
Offset_0x0419DA:
		swap	D0
		tst.w	D0
		beq.s	Offset_0x041A24
Offset_0x0419E0:
		move.w	D0, A1
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x041A24
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bpl.s	Offset_0x041A24
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		bne.s	Offset_0x041A02
		moveq	#$08, D0
Offset_0x041A02:
		lsl.w	#$04, D0
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		lea		Offset_0x041AA4(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		moveq	#$0A, D0
		move.l	A1, A3
		jmp		(Add_Points).l					 ; Offset_0x007AEC
Offset_0x041A20:
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
Offset_0x041A24:
		rts
;-------------------------------------------------------------------------------
Offset_0x041A26:
		dc.w	$FFE0, $0040, $FFE8, $0030
;-------------------------------------------------------------------------------
Offset_0x041A2E:
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x041A50
		addi.w	#$0128, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x041A66
		moveq	#$20, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		tst.w	D1
		bmi.s	Offset_0x041A66
		rts
Offset_0x041A50:
		addi.w	#$0018, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bhi.s	Offset_0x041A66
		moveq	#-$20, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
		tst.w	D1
		bpl.s	Offset_0x041A6A
Offset_0x041A66:
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x041A6A:
		rts
;-------------------------------------------------------------------------------
Offset_0x041A6C:
		dc.w	$0000, $0494, $000C, $0000
		dc.l	End_Panel_Mappings			   ; Offset_0x110E26
		dc.w	$0100
		dc.b	$18, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x041A7E:
		dc.l	End_Panel_Stars_Mappings			   ; Offset_0x110E84
		dc.w	$069E, $0100
		dc.b	$04, $08, $00, $00
;-------------------------------------------------------------------------------
Offset_0x041A8A:
		dc.l	Rings_Mappings				   ; Offset_0x010DE2
		dc.w	$26BC, $0080
		dc.b	$08, $08, $04, $00
;-------------------------------------------------------------------------------
Offset_0x041A96:
		dc.w	$0000
		dc.l	Offset_0x0419A8
		dc.w	$0018
;-------------------------------------------------------------------------------
Offset_0x041A9E:
		dc.w	$0000
		dc.l	Offset_0x041934
;-------------------------------------------------------------------------------
Offset_0x041AA4:
		dc.w	$0000
		dc.l	Obj_Enemy_Points			   ; Offset_0x023E42
;-------------------------------------------------------------------------------
Offset_0x041AAA:
		dc.l	Art_End_Panel_Dynamic		   ; Offset_0x12616A
		dc.l	End_Panel_Dyn_Script		   ; Offset_0x110DF4
;-------------------------------------------------------------------------------
Offset_0x041AB2:
		dc.b	$01, $00, $04, $05, $06, $01, $04, $05
		dc.b	$06, $02, $04, $05, $06, $03, $04, $05
		dc.b	$06, $FC
;-------------------------------------------------------------------------------
Offset_0x041AC4:
		dc.b	$01, $04, $05, $06, $07, $FC
;===============================================================================
; Painel de fim de fase
; <<<-
;===============================================================================