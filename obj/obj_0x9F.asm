;===============================================================================
; Objeto 0x9F - Inimigo Catakiller Junior na Angel Island
; ->>>
;===============================================================================
; Offset_0x044490:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0444A8(PC, D0), D1
		jsr		Offset_0x0444A8(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0444A8:
		dc.w	Offset_0x0444B2-Offset_0x0444A8
		dc.w	Offset_0x0444D8-Offset_0x0444A8
		dc.w	Offset_0x0444D8-Offset_0x0444A8
		dc.w	Offset_0x044508-Offset_0x0444A8
		dc.w	Offset_0x04452A-Offset_0x0444A8
;-------------------------------------------------------------------------------
Offset_0x0444B2:
		lea		Catakiller_Jr_Setup_Data(PC), A1	   ; Offset_0x04460C
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	#$FF00, Obj_Speed_X(A0)					 ; $0018
		lea		Offset_0x044642(PC), A2
		jsr		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
Offset_0x0444C8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$03, Obj_Control_Var_09(A0)			 ; $0039
		jmp		Offset_0x04A096(PC) ; Código no objeto 0x90 - Fireworm
;-------------------------------------------------------------------------------
Offset_0x0444D8:
		jsr		Swing_Up_And_Down_Count(PC)			   ; Offset_0x0423B6
		bne.s	Offset_0x0444E8
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bra.w	Offset_0x0445E8
Offset_0x0444E8:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0100, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0008, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x044508:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		tst.w	D3
		beq.s	Offset_0x044520
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x044520:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bra.w	Offset_0x0445E8
;-------------------------------------------------------------------------------
Offset_0x04452A:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		tst.w	D3
		bne.s	Offset_0x0444C8
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bra.w	Offset_0x0445E8
;-------------------------------------------------------------------------------
Offset_0x04453C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x044552(PC, D0), D1
		jsr		Offset_0x044552(PC, D1)
		moveq	#$00, D0
		jmp		(Child_Display_Touch_Or_Flicker_Move).l  ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x044552:
		dc.w	Offset_0x04455C-Offset_0x044552
		dc.w	Offset_0x044588-Offset_0x044552
		dc.w	Offset_0x0444D8-Offset_0x044552
		dc.w	Offset_0x044508-Offset_0x044552
		dc.w	Offset_0x04452A-Offset_0x044552
;-------------------------------------------------------------------------------
Offset_0x04455C:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x044576(PC, D0), D1
		lea		Offset_0x044576(PC, D1), A1
		lsr.w	#$01, D0
		move.b	Offset_0x044582(PC, D0), Obj_Timer_2(A0)		 ; $002F
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x044576:
		dc.w	Catakiller_Jr_Setup_Data_2-Offset_0x044576 ; Offset_0x044618
		dc.w	Catakiller_Jr_Setup_Data_2-Offset_0x044576 ; Offset_0x044618
		dc.w	Catakiller_Jr_Setup_Data_2-Offset_0x044576 ; Offset_0x044618
		dc.w	Catakiller_Jr_Setup_Data_3-Offset_0x044576 ; Offset_0x044624
		dc.w	Catakiller_Jr_Setup_Data_4-Offset_0x044576 ; Offset_0x044630
		dc.w	Catakiller_Jr_Setup_Data_4-Offset_0x044576 ; Offset_0x044630
;-------------------------------------------------------------------------------
Offset_0x044582:
		dc.b	$0B, $17, $23, $2F, $37, $3F
;-------------------------------------------------------------------------------
Offset_0x044588:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x044590
		rts
Offset_0x044590:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		moveq	#$40, D1
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		addq.w	#$02, D0
		lsl.w	#$02, D0
		sub.w	D0, D1
		move.w	D1, Obj_Timer(A0)				 ; $002E
		move.l	#Offset_0x0445FE, Obj_Child(A0)			 ; $0034
		move.w	#$FF00, Obj_Speed_X(A0)					 ; $0018
		bra.w	Offset_0x0444C8
;-------------------------------------------------------------------------------
Offset_0x0445BA:
		lea		Offset_0x04463C(PC), A1
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0445D6, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		jmp		(Child_Display_Or_Delete).l			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0445D6:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		lea		Offset_0x044652(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		jmp		(Child_Display_Or_Delete).l			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0445E8:
		cmpi.l	#Offset_0x04453C, (A0)
		bne.s	Offset_0x0445FC
		cmpi.b	#$06, Obj_Subtype(A0)					 ; $002C
		bcc.s	Offset_0x0445FC
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x0445FC:
		rts
;-------------------------------------------------------------------------------
Offset_0x0445FE:
		move.w	#$001A, Obj_Timer(A0)					 ; $002E
		lea		Offset_0x04464A(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Catakiller_Jr_Setup_Data:					   ; Offset_0x04460C
		dc.l	Catakiller_Jr_Mappings		   ; Offset_0x10E9BE
		dc.w	$A55F, $0280
		dc.b	$08, $08, $00, $17
;-------------------------------------------------------------------------------
Catakiller_Jr_Setup_Data_2:					   ; Offset_0x044618
		dc.l	Catakiller_Jr_Mappings		   ; Offset_0x10E9BE
		dc.w	$A55F, $0280
		dc.b	$08, $0C, $01, $97
;-------------------------------------------------------------------------------
Catakiller_Jr_Setup_Data_3:					   ; Offset_0x044624
		dc.l	Catakiller_Jr_Mappings		   ; Offset_0x10E9BE
		dc.w	$A55F, $0280
		dc.b	$08, $08, $02, $97
;-------------------------------------------------------------------------------
Catakiller_Jr_Setup_Data_4:					   ; Offset_0x044630
		dc.l	Monkey_Dude_Mappings		   ; Offset_0x10E716
		dc.w	$A548, $0280
		dc.b	$04, $04, $03, $98
;-------------------------------------------------------------------------------
Offset_0x04463C:
		dc.w	$0200
		dc.b	$10, $10, $03, $00
;-------------------------------------------------------------------------------
Offset_0x044642:
		dc.w	$0005
		dc.l	Offset_0x04453C
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x04464A:
		dc.w	$0000
		dc.l	Offset_0x0445BA
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x044652:
		dc.b	$03, $02, $03, $02, $04, $03, $05, $04
		dc.b	$F4, $00
;===============================================================================
; Objeto 0x9F - Inimigo Catakiller Junior na Angel Island
; <<<-
;===============================================================================