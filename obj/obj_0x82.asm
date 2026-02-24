;===============================================================================
; Objeto 0x82 - Inimigo rinoceronte na Angel Island (rhinobot)
; ->>>
;===============================================================================
; Offset_0x043C2A:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x043C4A(PC, D0), D1
		jsr		Offset_0x043C4A(PC, D1)
		lea		Rhinobot_PLC_Data(PC), A2			   ; Offset_0x043EF8
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		Check_Delete_Touch_Slotted(PC)		   ; Offset_0x042C1E
;-------------------------------------------------------------------------------
Offset_0x043C4A:
		dc.w	Offset_0x043C52-Offset_0x043C4A
		dc.w	Offset_0x043C98-Offset_0x043C4A
		dc.w	Offset_0x043CBE-Offset_0x043C4A
		dc.w	Offset_0x043CC2-Offset_0x043C4A
;-------------------------------------------------------------------------------
Offset_0x043C52:
		lea		Rhinobot_Setup_Data(PC), A1			   ; Offset_0x043EC4
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		move.b	#$08, Obj_Width_2(A0)					 ; $001F
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.w	#$FFF0, D0
		move.w	#$FD00, D1
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x043C86
		neg.w	D0
		neg.w	D1
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x043C86:
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		move.w	D1, Obj_Control_Var_0E(A0)				 ; $003E
		move.l	#Offset_0x043D06, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x043C98:
		lea		Offset_0x043D58(PC), A3
		bsr.w	Offset_0x043E6A
		lea		Offset_0x043D3A(PC), A3
		bsr.w	Offset_0x043E90
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D0, Obj_Speed_X(A0)				 ; $0018
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x043DBE
		bra.w	Offset_0x043DE2
;-------------------------------------------------------------------------------
Offset_0x043CBE:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x043CC2:
		lea		Offset_0x043DAE(PC), A3
		bsr.w	Offset_0x043E90
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x043CD0:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x043CEE(PC, D0), D1
		jsr		Offset_0x043CEE(PC, D1)
		lea		Rhinobot_PLC_Data(PC), A2			   ; Offset_0x043EF8
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		Child_Display_Or_Delete_Remember(PC)   ; Offset_0x04248E
;-------------------------------------------------------------------------------
Offset_0x043CEE:
		dc.w	Offset_0x043CF2-Offset_0x043CEE
		dc.w	Offset_0x043D02-Offset_0x043CEE
;-------------------------------------------------------------------------------
Offset_0x043CF2:
		lea		Rhinobot_Setup_Data_2(PC), A1		   ; Offset_0x043ED6
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		move.l	#Go_Delete_Slotted_3, Obj_Child(A0) ; Offset_0x042C42, $0034
Offset_0x043D02:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x043D06:
		bchg	#02, Obj_Control_Var_08(A0)				 ; $0038
		move.l	#Offset_0x043D1E, Obj_Child(A0)			 ; $0034
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		neg.w	Obj_Control_Var_0E(A0)					 ; $003E
		rts
;-------------------------------------------------------------------------------
Offset_0x043D1E:
		bchg	#03, Obj_Control_Var_08(A0)				 ; $0038
		bchg	#00, Obj_Flags(A0)				 ; $0004
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x043D06, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x043D3A:
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043D4E
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x043D4E:
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		bra.s	Offset_0x043D1E
;-------------------------------------------------------------------------------
Offset_0x043D58:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x043D94, Obj_Child(A0)			 ; $0034
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#Grab_Sfx, D0					   ; $4A
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x043EF0(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x043D92
		move.l	#Offset_0x043F10, Obj_Child_Data(A1)			 ; $0030
Offset_0x043D92:
		rts
;-------------------------------------------------------------------------------
Offset_0x043D94:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0400, D0
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043DA8
		neg.w	D0
Offset_0x043DA8:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x043DAE:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bra.w	Offset_0x043D3A
;-------------------------------------------------------------------------------
Offset_0x043DBE:
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		beq.s	Offset_0x043DDC
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043DD4
		cmp.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		bge.s	Offset_0x043DDC
		rts
Offset_0x043DD4:
		cmp.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		ble.s	Offset_0x043DDC
		rts
Offset_0x043DDC:
		move.l	Obj_Child(A0), A1				 ; $0034
		jmp		(A1)
;-------------------------------------------------------------------------------
Offset_0x043DE2:
		moveq	#$00, D1
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043E1A
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043E02
		cmpi.w	#$0080, Obj_Speed_X(A0)					 ; $0018
		bgt.s	Offset_0x043E44
		moveq	#$01, D1
		bra.w	Offset_0x043E44
Offset_0x043E02:
		moveq	#$01, D1
		cmpi.w	#$0280, Obj_Speed_X(A0)					 ; $0018
		bgt.s	Offset_0x043E44
		moveq	#$02, D1
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043E4A
		bra.w	Offset_0x043E44
Offset_0x043E1A:
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043E30
		cmpi.w	#$FF80, Obj_Speed_X(A0)					 ; $0018
		ble.s	Offset_0x043E44
		moveq	#$01, D1
		bra.w	Offset_0x043E44
Offset_0x043E30:
		moveq	#$01, D1
		cmpi.w	#$FD80, Obj_Speed_X(A0)					 ; $0018
		ble.s	Offset_0x043E44
		moveq	#$02, D1
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x043E4A
Offset_0x043E44:
		move.b	D1, Obj_Map_Id(A0)				 ; $0022
		rts
Offset_0x043E4A:
		move.b	D1, Obj_Map_Id(A0)				 ; $0022
		moveq	#Grab_Sfx, D0					   ; $4A
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x043EE8(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x043E68
		move.l	#Offset_0x043F00, Obj_Child_Data(A1)			 ; $0030
Offset_0x043E68:
		rts
Offset_0x043E6A:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0020, D3
		bhi.s	Offset_0x043E88
		cmpi.w	#$0060, D2
		bhi.s	Offset_0x043E88
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043E84
		subq.w	#$02, D0
Offset_0x043E84:
		tst.w	D0
		bne.s	Offset_0x043E8A
Offset_0x043E88:
		rts
Offset_0x043E8A:
		jsr		(A3)
		addq.w	#$04, A7
		rts
Offset_0x043E90:
		moveq	#$04, D0
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043E9C
		neg.w	D0
Offset_0x043E9C:
		move.w	Obj_X(A0), D3					 ; $0010
		add.w	D0, D3
		move.l	A3, -(A7)
		jsr		(ObjHitFloor_D3).l			   ; Offset_0x009D88
		move.l	(A7)+, A3
		cmpi.w	#$FFFF, D1
		blt.s	Offset_0x043EBE
		cmpi.w	#$000C, D1
		bge.s	Offset_0x043EBE
		add.w	D1, Obj_Y(A0)					 ; $0014
		rts
Offset_0x043EBE:
		jsr		(A3)
		addq.w	#$04, A7
		rts
;-------------------------------------------------------------------------------
Rhinobot_Setup_Data:						   ; Offset_0x043EC4
		dc.w	$0001, $2500, $0015, $0000
		dc.l	Rhinobot_Mappings			   ; Offset_0x10E548
		dc.w	$0280
		dc.b	$14, $10, $00, $0B
;-------------------------------------------------------------------------------
Rhinobot_Setup_Data_2:						   ; Offset_0x043ED6
		dc.w	$0001, $044A, $0006, $0002
		dc.l	Rhinobot_Mappings			   ; Offset_0x10E548
		dc.w	$0200
		dc.b	$0C, $08, $04, $00
;-------------------------------------------------------------------------------
Offset_0x043EE8:
		dc.w	$0000
		dc.l	Offset_0x043CD0
		dc.b	$0C, $08
;-------------------------------------------------------------------------------
Offset_0x043EF0:
		dc.w	$0000
		dc.l	Offset_0x043CD0
		dc.b	$10, $08
;-------------------------------------------------------------------------------
Rhinobot_PLC_Data:							   ; Offset_0x043EF8
		dc.l	Art_Rhinobot				   ; Offset_0x1135C6
		dc.l	Rhinobot_Dyn_Script			   ; Offset_0x10E50E
;-------------------------------------------------------------------------------
Offset_0x043F00:
		dc.b	$02, $04, $04, $05, $06, $07, $04, $05
		dc.b	$06, $07, $04, $05, $06, $07, $F4, $00
;-------------------------------------------------------------------------------
Offset_0x043F10:
		dc.b	$02, $04, $04, $05, $06, $07, $04, $05
		dc.b	$06, $07, $F4, $00
;===============================================================================
; Objeto 0x82 - Inimigo rinoceronte na Angel Island (rhinobot)
; <<<-
;===============================================================================