;===============================================================================
; Objeto 0x9E - Inimigo Pointdexter na Hydrocity
; ->>>
;===============================================================================
; Offset_0x044F90:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x044FA8(PC, D0), D1
		jsr		Offset_0x044FA8(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x044FA8:
		dc.w	Offset_0x044FAC-Offset_0x044FA8
		dc.w	Offset_0x044FFA-Offset_0x044FA8
;-------------------------------------------------------------------------------
Offset_0x044FAC:
		lea		Pointdexter_Setup_Data(PC), A1		   ; Offset_0x045034
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x045040, Obj_Child_Data(A0)			 ; $0030
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		add.w	D0, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.l	#Offset_0x045022, Obj_Child(A0)			 ; $0034
		move.w	#$FFC0, D4
		jsr		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
		move.w	#$0020, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0001, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x044FFA:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		move.b	#$0A, Obj_Col_Flags(A0)					 ; $0028
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x045020
		move.b	#$86, Obj_Col_Flags(A0)					 ; $0028
Offset_0x045020:
		rts
;-------------------------------------------------------------------------------
Offset_0x045022:
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
		move.w	Obj_Control_Var_0A(A0), Obj_Timer(A0)	  ; $003A, $002E
		rts
;-------------------------------------------------------------------------------
Pointdexter_Setup_Data:						   ; Offset_0x045034
		dc.l	Pointdexter_Mappings		   ; Offset_0x10DE0C
		dc.w	$A559, $0280
		dc.b	$14, $0C, $00, $00
;-------------------------------------------------------------------------------
Offset_0x045040:
		dc.b	$00, $7F, $01, $04, $02, $7F, $01, $04
		dc.b	$FC, $00
;===============================================================================
; Objeto 0x9E - Inimigo Pointdexter na Hydrocity
; <<<-
;===============================================================================