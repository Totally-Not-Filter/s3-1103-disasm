;===============================================================================
; Objeto 0xA0 - Inimigo Clamer na Carnival Night
; ->>>
;===============================================================================
; Offset_0x045C7A:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045C9A(PC, D0), D1
		jsr		Offset_0x045C9A(PC, D1)
		lea		Clamer_PLC_Data(PC), A2		   ; Offset_0x045E1A
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		Check_Delete_Touch_Slotted(PC)		   ; Offset_0x042C1E
;-------------------------------------------------------------------------------
Offset_0x045C9A:
		dc.w	Offset_0x045CA2-Offset_0x045C9A
		dc.w	Offset_0x045CB2-Offset_0x045C9A
		dc.w	Offset_0x045D14-Offset_0x045C9A
		dc.w	Offset_0x045D2A-Offset_0x045C9A
;-------------------------------------------------------------------------------
Offset_0x045CA2:
		lea		Clamer_Setup_Data(PC), A1			   ; Offset_0x045DD6
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		lea		Offset_0x045DFA(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x045CB2:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x045CDA
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcc.s	Offset_0x045CD2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x045CCE
		subq.w	#$02, D0
Offset_0x045CCE:
		tst.w	D0
		beq.s	Offset_0x045CFC
Offset_0x045CD2:
		lea		Offset_0x045E22(PC), A1
		jmp		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
Offset_0x045CDA:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x045D1C, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		rts
Offset_0x045CFC:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045D1C, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
Offset_0x045D12:
		rts
;-------------------------------------------------------------------------------
Offset_0x045D14:
		lea		Offset_0x045E2B(PC), A1
		jmp		Animate_Raw_A1(PC)			   ; Offset_0x042092
;-------------------------------------------------------------------------------
Offset_0x045D1C:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$0A, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x045D2A:
		lea		Offset_0x045E37(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.w	Offset_0x045D12
		cmpi.b	#$08, Obj_Map_Id(A0)					 ; $0022
		bne.w	Offset_0x045D12
		lea		Offset_0x045E02(PC), A2
		jmp		Load_Child_Object_Complex_Adjusted_A2(PC) ; Offset_0x041EE0
;-------------------------------------------------------------------------------
Offset_0x045D4A:
		lea		Clamer_Setup_Data_2(PC), A1			   ; Offset_0x045DE8
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Flags(A1), Obj_Flags(A0)			  ; $0004, $0004
		clr.w	Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Offset_0x045D68, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x045D68:
		bsr.w	Check_Player_Collision		   ; Offset_0x0430D4
		beq.s	Offset_0x045D78
		move.l	#Offset_0x045D7C, (A0)
		bsr.w	Offset_0x045D8C
Offset_0x045D78:
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x045D7C:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x045D84
		rts
Offset_0x045D84:
		move.l	#Offset_0x045D68, (A0)
		rts
Offset_0x045D8C:
		move.w	#$0800, D0
		bclr	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x045DA6
		neg.w	D0
		bset	#$00, Obj_Status(A1)					 ; $002A
Offset_0x045DA6:
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		move.w	D0, Obj_Inertia(A1)				 ; $001C
		move.w	#$F800, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		addq.w	#$06, Obj_Y(A1)					 ; $0014
		move.b	#$10, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		moveq	#Spring_Sfx, D0					  ; -$2E
		jmp		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
Clamer_Setup_Data:							   ; Offset_0x045DD6
		dc.w	$0001, $A500, $0012, $0000
		dc.l	Clamer_Mappings				   ; Offset_0x10EA62
		dc.w	$0280
		dc.b	$14, $10, $00, $0A
;-------------------------------------------------------------------------------
Clamer_Setup_Data_2:						   ; Offset_0x045DE8
		dc.w	$0280
		dc.b	$08, $04, $0B, $D7
;-------------------------------------------------------------------------------
Clamer_Setup_Data_3:						   ; Offset_0x045DEE
		dc.l	Clamer_Mappings				   ; Offset_0x10EA62
		dc.w	$A570, $0200
		dc.b	$08, $08, $09, $98
;-------------------------------------------------------------------------------
Offset_0x045DFA:
		dc.w	$0000
		dc.l	Offset_0x045D4A
		dc.b	$00, $F8
;-------------------------------------------------------------------------------
Offset_0x045E02:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Clamer_Setup_Data_3			   ; Offset_0x045DEE
		dc.l	$00000000
		dc.l	SpeedToPos					   ; Offset_0x01111E
		dc.b	$F0, $02, $FE, $00
		dc.w	$0000
;-------------------------------------------------------------------------------
Clamer_PLC_Data:							   ; Offset_0x045E1A
		dc.l	Art_Clamer					   ; Offset_0x11B15C
		dc.l	Clamer_Dyn_Script			   ; Offset_0x10EA1E
;-------------------------------------------------------------------------------
Offset_0x045E22:
		dc.b	$01, $01, $00, $5F, $01, $01, $02, $01
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x045E2B:
		dc.b	$00, $00, $01, $02, $03, $04, $03, $02
		dc.b	$01, $0A, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x045E37:
		dc.b	$00, $02, $05, $02, $06, $02, $07, $2F
		dc.b	$08, $05, $07, $1F, $06, $02, $05, $02
		dc.b	$00, $1F, $F4
;===============================================================================
; Objeto 0xA0 - Inimigo Clamer na Carnival Night
; <<<-
;===============================================================================