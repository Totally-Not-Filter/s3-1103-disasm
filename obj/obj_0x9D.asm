;===============================================================================
; Objeto 0x9D - Inimigo Mega Chopper na Hydrocity
; ->>>
;===============================================================================
; Offset_0x044CC8:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x044CEA(PC, D0), D1
		jsr		Offset_0x044CEA(PC, D1)
		btst	#$07, Obj_Status(A0)					 ; $002A
		bne.w	Enemy_Defeat_Score			   ; Offset_0x043018
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x044CEA:
		dc.w	Offset_0x044CF2-Offset_0x044CEA
		dc.w	Offset_0x044D04-Offset_0x044CEA
		dc.w	Offset_0x044D7C-Offset_0x044CEA
		dc.w	Offset_0x044DBA-Offset_0x044CEA
;-------------------------------------------------------------------------------
Offset_0x044CF2:
		lea		Mega_Chopper_Setup_Data(PC), A1		   ; Offset_0x044F80
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x044F8C, Obj_Child_Data(A0)			 ; $0030
Offset_0x044D02:
		rts
;-------------------------------------------------------------------------------
Offset_0x044D04:
		bsr.w	Offset_0x044E68
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jsr		Find_Player(PC)				   ; Offset_0x042634
		move.b	(Vint_runcount+$03).w, D4		  ; $FFFFFE0F
		andi.b	#$07, D4
		bne.s	Offset_0x044D26
		moveq	#$01, D4
		tst.w	D1
		bne.s	Offset_0x044D22
		neg.w	D4
Offset_0x044D22:
		add.w	D4, Obj_Y(A0)					 ; $0014
Offset_0x044D26:
		move.w	Obj_Y(A0), D4					 ; $0014
		move.w	(Water_Level_Move).w, D5			 ; $FFFFF646
		addq.w	#$08, D5
		cmp.w	D5, D4
		bhi.s	Offset_0x044D3C
		btst	#$06, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x044D54
Offset_0x044D3C:
		move.w	#$0200, D0
		move.w	#$0008, D1
		jsr		(Chase_Object_X_Only).l		   ; Offset_0x042EC4
		jsr		Change_Flip_X_With_Velocity(PC)		   ; Offset_0x04268A
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x044D54:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0200, D4
		bset	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		bne.s	Offset_0x044D70
		neg.w	D4
		bclr	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x044D70:
		move.w	D4, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x044D7C:
		bsr.w	Offset_0x044E68
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x044DAA
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		bcs.s	Offset_0x044DAA
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		addi.w	#$FFE0, D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		beq.s	Offset_0x044DAE
		bmi.s	Offset_0x044DAE
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x044DAA:
		jmp		Move_Light_Gravity(PC)		   ; Offset_0x0426C2
Offset_0x044DAE:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x044DBA:
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		btst	#$02, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x044DCE
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
Offset_0x044DCE:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		beq.s	Offset_0x044E42
		cmpi.b	#$09, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x044E42
		jsr		Check_Left_Right_Controller_Shake(PC)  ; Offset_0x04309C
		bne.s	Offset_0x044E42
		move.w	Obj_X(A1), D0					 ; $0010
		move.b	Obj_Control_Var_12(A0), D1				 ; $0042
		ext.w	D1
		move.b	Obj_Control_Var_08(A0), D2				 ; $0038
		andi.b	#$01, D2
		move.b	Obj_Flags(A1), D3				 ; $0004
		andi.b	#$01, D3
		eor.b	D2, D3
		beq.s	Offset_0x044E16
		bchg	#00, Obj_Flags(A0)				 ; $0004
		bchg	#00, Obj_Control_Var_08(A0)				 ; $0038
		neg.b	Obj_Control_Var_12(A0)					 ; $0042
Offset_0x044E16:
		add.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Y(A1), D0					 ; $0014
		move.b	Obj_Control_Var_13(A0), D1				 ; $0043
		ext.w	D1
		bpl.s	Offset_0x044E34
		cmpi.b	#$08, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x044E34
		addi.w	#$0010, D1
Offset_0x044E34:
		add.w	D1, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		bsr.w	Offset_0x044F12
		beq.w	Offset_0x044D02
Offset_0x044E42:
		move.l	#ObjectFall_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB6
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0200, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x044E5C
		neg.w	D0
Offset_0x044E5C:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		rts
Offset_0x044E68:
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		beq.w	Offset_0x044D02
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		andi.w	#$0003, D0
		lsl.w	#$02, D0
		lea		Offset_0x044EFE-$04(PC, D0), A2
		move.w	(A2)+, A1
		move.w	Obj_Y(A0), D1					 ; $0014
		sub.w	Obj_Y(A1), D1					 ; $0014
		cmpi.w	#$FFF0, D1
		blt.w	Offset_0x044D02
		cmpi.w	#$0010, D1
		bge.w	Offset_0x044D02
		move.w	A1, Obj_Height_3(A0)					 ; $0044
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x044F0A
		move.w	(A2)+, A3
		move.w	A3, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	(A3), Obj_Control_Var_0A(A0)			 ; $003A
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.w	#$003C, Obj_Timer(A0)					 ; $002E
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		move.b	D0, Obj_Control_Var_12(A0)				 ; $0042
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		bpl.s	Offset_0x044EDC
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x044EDC:
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Y(A1), D0					 ; $0014
		move.b	D0, Obj_Control_Var_13(A0)				 ; $0043
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x044EFC
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x044EFC:
		rts
;-------------------------------------------------------------------------------
Offset_0x044EFE:
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Control_Ports_Buffer_Data				 ; $F604
		dc.w	Obj_Player_Two					 ; $B04A
		dc.w	Control_Ports_Buffer_Data+$02			 ; $F606
		dc.w	Obj_Player_One					 ; $B000
		dc.w	Control_Ports_Buffer_Data				 ; $F604
;-------------------------------------------------------------------------------
Offset_0x044F0A:
		bset	#$07, Obj_Status(A0)					 ; $002A
		rts
Offset_0x044F12:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x044F5A
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		ori.b	#$01, (Update_HUD_rings).w			   ; $FFFFFE1D
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		move.w	(Ring_count).w, D0			 ; $FFFFFE20
		subq.w	#$01, D0
		bmi.s	Offset_0x044F6C
		beq.s	Offset_0x044F44
		cmpi.w	#$000A, (Ring_count).w		 ; $FFFFFE20
		beq.s	Offset_0x044F44
		cmpi.w	#$0064, (Ring_count).w		 ; $FFFFFE20
		bne.s	Offset_0x044F4A
Offset_0x044F44:
		ori.b	#$80, (Update_HUD_rings).w			   ; $FFFFFE1D
Offset_0x044F4A:
		move.w	D0, (Ring_count).w			 ; $FFFFFE20
		moveq	#Ring_Left_Speaker_Sfx, D0				   ; $33
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x044F56:
		moveq	#$00, D0
		rts
Offset_0x044F5A:
		bclr	#$07, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x044F56
		andi.b	#$FE, (Update_HUD_rings).w			   ; $FFFFFE1D
		moveq	#$00, D0
		rts
Offset_0x044F6C:
		move.l	A0, A2
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.l	A1, A0
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
		move.l	A2, A0
		moveq	#$01, D0
		rts
;-------------------------------------------------------------------------------
Mega_Chopper_Setup_Data:					   ; Offset_0x044F80
		dc.l	Mega_Chopper_Mappings		   ; Offset_0x10DEBA
		dc.w	$A54D, $0280
		dc.b	$20, $20, $00, $D7
;-------------------------------------------------------------------------------
Offset_0x044F8C:
		dc.b	$02, $00, $01, $FC
;===============================================================================
; Objeto 0x9D - Inimigo Mega Chopper na Hydrocity
; <<<-
;===============================================================================