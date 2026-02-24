;===============================================================================
; Objeto 0x8B - Inimigo Flybot 767 na Launch Base
; ->>>
;===============================================================================
; Offset_0x048DF8:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048E1A(PC, D0), D1
		jsr		Offset_0x048E1A(PC, D1)
		lea		Flybot_767_PLC_Data(PC), A2			   ; Offset_0x048F78
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		(Check_Delete_Touch_Slotted).l		   ; Offset_0x042C1E
;-------------------------------------------------------------------------------
Offset_0x048E1A:
		dc.w	Offset_0x048E26-Offset_0x048E1A
		dc.w	Offset_0x048E5C-Offset_0x048E1A
		dc.w	Offset_0x048EA6-Offset_0x048E1A
		dc.w	Offset_0x048ED0-Offset_0x048E1A
		dc.w	Offset_0x048EFC-Offset_0x048E1A
		dc.w	Offset_0x048F5A-Offset_0x048E1A
;-------------------------------------------------------------------------------
Offset_0x048E26:
		lea		Flybot_767_Setup_Data(PC), A1		   ; Offset_0x048F66
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		move.l	#Offset_0x048F80, Obj_Child_Data(A0)			 ; $0030
		jsr		Find_Player(PC)				   ; Offset_0x042634
		move.w	#$FF00, D4
		jsr		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
Offset_0x048E42:
		move.w	#$0080, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0008, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x048E5C:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcc.s	Offset_0x048E78
		cmpi.b	#$06, Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x048E7C
Offset_0x048E78:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
Offset_0x048E7C:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Y(A0), Obj_Height_3(A0)		  ; $0014, $0044
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		move.l	#Offset_0x048F8C, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x048EB0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048EA6:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x048EB0:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048F95, Obj_Child_Data(A0)			 ; $0030
		asl.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x048ED0:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x048EE4
		jsr		Find_Player(PC)				   ; Offset_0x042634
		tst.w	D1
		beq.s	Offset_0x048EE8
Offset_0x048EE4:
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
Offset_0x048EE8:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048FA1, Obj_Child_Data(A0)			 ; $0030
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x048EFC:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Height_3(A0), D0					 ; $0044
		bcs.s	Offset_0x048F12
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
Offset_0x048F12:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048F80, Obj_Child_Data(A0)			 ; $0030
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048F5E, Obj_Child(A0)			 ; $0034
		asr.w	Obj_Speed_X(A0)					 ; $0018
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		scc		D1
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bpl.s	Offset_0x048F48
		not.b	D1
Offset_0x048F48:
		tst.b	D1
		beq.s	Offset_0x048F56
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x048F56:
		bra.w	Offset_0x048E42
;-------------------------------------------------------------------------------
Offset_0x048F5A:
		jmp		Swing_Up_And_Down_Animate_Raw_Wait(PC) ; Offset_0x042F78
;-------------------------------------------------------------------------------
Offset_0x048F5E:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Flybot_767_Setup_Data:						   ; Offset_0x048F66
		dc.w	$0002
		dc.w	$2500, $000C, $0000
		dc.l	Flybot_767_Mappings			   ; Offset_0x10D62E
		dc.w	$0280
		dc.b	$10, $10, $00, $1A
;-------------------------------------------------------------------------------
Flybot_767_PLC_Data:						   ; Offset_0x048F78
		dc.l	Art_Flybot_767				   ; Offset_0x122D46
		dc.l	Flybot_767_Dyn_Script		   ; Offset_0x10D7C0
;-------------------------------------------------------------------------------
Offset_0x048F80:
		dc.b	$05, $00, $01, $02, $03, $04, $05, $06
		dc.b	$07, $08, $09, $FC
;-------------------------------------------------------------------------------
Offset_0x048F8C:
		dc.b	$03, $0A, $0A, $0B, $0C, $0D, $0E, $0F
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x048F95:
		dc.b	$03, $10, $10, $11, $12, $13, $F8, $08
		dc.b	$03, $13, $13, $FC
;-------------------------------------------------------------------------------
Offset_0x048FA1:
		dc.b	$03, $0A, $0A, $14, $F8, $06, $03, $14
		dc.b	$14, $FC, $00
;===============================================================================
; Objeto 0x8B - Inimigo Flybot 767 na Launch Base
; <<<-
;===============================================================================