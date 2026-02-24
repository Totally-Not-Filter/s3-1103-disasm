;===============================================================================
; Objeto 0x88 - Inimigo Ribot na Launch Base
; ->>>
;===============================================================================
; Offset_0x048756:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04876E(PC, D0), D1
		jsr		Offset_0x04876E(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04876E:
		dc.w	Offset_0x048772-Offset_0x04876E
		dc.w	Offset_0x0487BA-Offset_0x04876E
;-------------------------------------------------------------------------------
Offset_0x048772:
		lea		Ribot_Setup_Data(PC), A1			   ; Offset_0x048A2C
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.b	Obj_Subtype(A0), D0				 ; $002C
		subq.b	#$02, D0
		beq.s	Offset_0x04879A
		bpl.s	Offset_0x0487AA
		move.l	#Offset_0x048A88, Obj_Child_Data(A0)			 ; $0030
		lea		Offset_0x048A44(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x04879A:
		move.l	#Offset_0x048A88, Obj_Child_Data(A0)			 ; $0030
		lea		Offset_0x048A52(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x0487AA:
		move.l	#Offset_0x048A8E, Obj_Child_Data(A0)			 ; $0030
		lea		Offset_0x048A60(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0487BA:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0487D8
		andi.b	#$FC, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#$00, D0
		bchg	#03, Obj_Control_Var_08(A0)				 ; $0038
		beq.s	Offset_0x0487D4
		moveq	#$01, D0
Offset_0x0487D4:
		bset	D0, Obj_Control_Var_08(A0)				 ; $0038
Offset_0x0487D8:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x0487DC:
		moveq	#$00, D2
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Subtype(A1), D2				 ; $002C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0487F8(PC, D0), D1
		jsr		Offset_0x0487F8(PC, D1)
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x0487F8:
		dc.w	Offset_0x048802-Offset_0x0487F8
		dc.w	Offset_0x048826-Offset_0x0487F8
		dc.w	Offset_0x048892-Offset_0x0487F8
		dc.w	Offset_0x0488F8-Offset_0x0487F8
		dc.w	Offset_0x048924-Offset_0x0487F8
;-------------------------------------------------------------------------------
Offset_0x048802:
		lea		Ribot_Setup_Data_2(PC), A1			   ; Offset_0x048A38
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		move.b	#$F0, Obj_Control_Var_13(A0)			 ; $0043
		move.w	Obj_X(A0), Obj_Control_Var_0E(A0)		  ; $0010, $003E
		move.w	Obj_Y(A0), Obj_Control_Var_10(A0)		  ; $0014, $0040
		bra.w	Offset_0x0489FC
;-------------------------------------------------------------------------------
Offset_0x048826:
		move.w	Offset_0x04882E(PC, D2), D3
		jmp		Offset_0x04882E(PC, D3)
;-------------------------------------------------------------------------------
Offset_0x04882E:
		dc.w	Offset_0x048834-Offset_0x04882E
		dc.w	Offset_0x048856-Offset_0x04882E
		dc.w	Offset_0x048888-Offset_0x04882E
;-------------------------------------------------------------------------------
Offset_0x048834:
		moveq	#$00, D0
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x04883E
		moveq	#$01, D0
Offset_0x04883E:
		btst	D0, Obj_Control_Var_08(A1)				 ; $0038
		bne.s	Offset_0x048846
		rts
Offset_0x048846:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0488C0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048856:
		moveq	#$00, D0
		move.w	#$0400, D1
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x048866
		moveq	#$01, D0
		neg.w	D1
Offset_0x048866:
		btst	D0, Obj_Control_Var_08(A1)				 ; $0038
		bne.s	Offset_0x04886E
		rts
Offset_0x04886E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0488D4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048888:
		addq.b	#$02, Obj_Control_Var_0C(A0)			 ; $003C
		moveq	#$02, D2
		jmp		Move_Sprite_Circular_Simple_Offset(PC) ; Offset_0x04270A
;-------------------------------------------------------------------------------
Offset_0x048892:
		move.w	Offset_0x04889A(PC, D2), D3
		jmp		Offset_0x04889A(PC, D3)
;-------------------------------------------------------------------------------
Offset_0x04889A:
		dc.w	Offset_0x0488A0-Offset_0x04889A
		dc.w	Offset_0x0488EE-Offset_0x04889A
		dc.w	Offset_0x0488A0-Offset_0x04889A
;-------------------------------------------------------------------------------
Offset_0x0488A0:
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Control_Var_10(A0), D0				 ; $0040
		cmpi.w	#$0080, D0
		bcc.s	Offset_0x0488D4
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x0488EC
		jmp		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x0488C0:
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		cmpi.w	#$0100, D0
		bcs.s	Offset_0x0488D4
		asr.w	#$02, D0
		neg.w	D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		rts
Offset_0x0488D4:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04890A, Obj_Child(A0)			 ; $0034
		clr.w	Obj_Speed_Y(A0)					 ; $001A
Offset_0x0488EC:
		rts
;-------------------------------------------------------------------------------
Offset_0x0488EE:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0488F8:
		move.w	Offset_0x048900(PC, D2), D3
		jmp		Offset_0x048900(PC, D3)
;-------------------------------------------------------------------------------
Offset_0x048900:
		dc.w	Offset_0x048906-Offset_0x048900
		dc.w	Offset_0x048906-Offset_0x048900
		dc.w	Offset_0x048906-Offset_0x048900
;-------------------------------------------------------------------------------
Offset_0x048906:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04890A:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		neg.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048944, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048924:
		move.w	Offset_0x04892C(PC, D2), D3
		jmp		Offset_0x04892C(PC, D3)
;-------------------------------------------------------------------------------
Offset_0x04892C:
		dc.w	Offset_0x048932-Offset_0x04892C
		dc.w	Offset_0x048962-Offset_0x04892C
		dc.w	Offset_0x048932-Offset_0x04892C
;-------------------------------------------------------------------------------
Offset_0x048932:
		move.w	Obj_Y(A0), D0					 ; $0014
		subq.w	#$02, D0
		cmp.w	Obj_Control_Var_10(A0), D0				 ; $0040
		bls.s	Offset_0x048944
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
Offset_0x048944:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Control_Var_0E(A0), Obj_X(A0)		  ; $003E, $0010
		move.w	Obj_Control_Var_10(A0), Obj_Y(A0)		  ; $0040, $0014
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$02, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x048962:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04896C:
		lea		Ribot_Setup_Data_3(PC), A1			   ; Offset_0x048A3E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x04898A, (A0)
		move.w	Obj_X(A0), Obj_Control_Var_0E(A0)		  ; $0010, $003E
		move.w	Obj_Y(A0), Obj_Control_Var_10(A0)		  ; $0014, $0040
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x04898A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_X(A1), D2					 ; $0010
		move.w	Obj_Y(A1), D3					 ; $0014
		sub.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		sub.w	Obj_Control_Var_10(A0), D3				 ; $0040
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0489B0(PC, D0), D1
		jsr		Offset_0x0489B0(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0489B0:
		dc.w	Offset_0x0489B6-Offset_0x0489B0
		dc.w	Offset_0x0489D0-Offset_0x0489B0
		dc.w	Offset_0x0489E6-Offset_0x0489B0
;-------------------------------------------------------------------------------
Offset_0x0489B6:
		asr.w	#$02, D2
		neg.w	D2
		add.w	Obj_X(A1), D2					 ; $0010
		move.w	D2, Obj_X(A0)					 ; $0010
		asr.w	#$02, D3
		neg.w	D3
		add.w	Obj_Y(A1), D3					 ; $0014
		move.w	D3, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0489D0:
		asr.w	#$01, D2
		add.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		move.w	D2, Obj_X(A0)					 ; $0010
		asr.w	#$01, D3
		add.w	Obj_Control_Var_10(A0), D3				 ; $0040
		move.w	D3, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0489E6:
		asr.w	#$02, D2
		add.w	Obj_Control_Var_0E(A0), D2				 ; $003E
		move.w	D2, Obj_X(A0)					 ; $0010
		asr.w	#$02, D3
		add.w	Obj_Control_Var_10(A0), D3				 ; $0040
		move.w	D3, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0489FC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Subtype(A1), D0				 ; $002C
		subq.b	#$02, D0
		beq.s	Offset_0x048A12
		bpl.s	Offset_0x048A24
		lea		Offset_0x048A68(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
Offset_0x048A12:
		lea		Offset_0x048A70(PC), A2
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x048A20
		lea		Offset_0x048A78(PC), A2
Offset_0x048A20:
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
Offset_0x048A24:
		lea		Offset_0x048A80(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Ribot_Setup_Data:							   ; Offset_0x048A2C
		dc.l	Ribot_Mappings				   ; Offset_0x10D486
		dc.w	$2547, $0280
		dc.b	$10, $0C, $00, $0B
;-------------------------------------------------------------------------------
Ribot_Setup_Data_2:							   ; Offset_0x048A38
		dc.w	$0200
		dc.b	$08, $08, $07, $97
;-------------------------------------------------------------------------------
Ribot_Setup_Data_3:							   ; Offset_0x048A3E
		dc.w	$0200
		dc.b	$04, $04, $06, $00
;-------------------------------------------------------------------------------
Offset_0x048A44:
		dc.w	$0001
		dc.l	Offset_0x0487DC
		dc.b	$F4, $0C
		dc.l	Offset_0x0487DC
		dc.b	$0C, $0C
;-------------------------------------------------------------------------------
Offset_0x048A52:
		dc.w	$0001
		dc.l	Offset_0x0487DC
		dc.b	$E8, $00
		dc.l	Offset_0x0487DC
		dc.b	$18, $00
;-------------------------------------------------------------------------------
Offset_0x048A60:
		dc.w	$0000
		dc.l	Offset_0x0487DC
		dc.b	$00, $F0
;-------------------------------------------------------------------------------
Offset_0x048A68:
		dc.w	$0002
		dc.l	Offset_0x04896C
		dc.b	$00, $F4
;-------------------------------------------------------------------------------
Offset_0x048A70:
		dc.w	$0002
		dc.l	Offset_0x04896C
		dc.b	$0C, $00
;-------------------------------------------------------------------------------
Offset_0x048A78:
		dc.w	$0002
		dc.l	Offset_0x04896C
		dc.b	$F4, $00
;-------------------------------------------------------------------------------
Offset_0x048A80:
		dc.w	$0002
		dc.l	Offset_0x04896C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x048A88:
		dc.b	$07, $00, $01, $02, $01, $FC
;-------------------------------------------------------------------------------
Offset_0x048A8E:
		dc.b	$07, $03, $04, $05, $04, $FC
;===============================================================================
; Objeto 0x88 - Inimigo Ribot na Launch Base
; <<<-
;===============================================================================