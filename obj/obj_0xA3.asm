;===============================================================================
; Objeto 0xA3 - Inimigo Bubbles na Marble Garden
; ->>>
;===============================================================================
; Offset_0x04504A:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04507E(PC, D0), D1
		jsr		Offset_0x04507E(PC, D1)
		move.b	#$12, Obj_Col_Flags(A0)					 ; $0028
		cmpi.b	#$04, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x045072
		move.b	#$86, Obj_Col_Flags(A0)					 ; $0028
Offset_0x045072:
		lea		Bubbles_PLC_Data(PC), A2			   ; Offset_0x045138
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		Check_Delete_Touch_Slotted(PC)		   ; Offset_0x042C1E
;-------------------------------------------------------------------------------
Offset_0x04507E:
		dc.w	Offset_0x045084-Offset_0x04507E
		dc.w	Offset_0x0450C0-Offset_0x04507E
		dc.w	Offset_0x0450FA-Offset_0x04507E
;-------------------------------------------------------------------------------
Offset_0x045084:
		lea		Bubbles_Setup_Data(PC), A1			   ; Offset_0x045126
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		move.w	#$FF80, Obj_Speed_X(A0)					 ; $0018
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x04509E
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x04509E:
		move.l	#Offset_0x04514F, Obj_Child_Data(A0)			 ; $0030
		move.w	#$0100, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0002, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0450C0:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		move.w	Obj_Speed_Y(A0), D4				 ; $001A
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bne.s	Offset_0x0450F4
		tst.w	D4
		bmi.s	Offset_0x0450F4
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045140, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x045116, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
Offset_0x0450F4:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x0450FA:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		tst.w	D3
		beq.s	Offset_0x045110
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x045110:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x045116:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04514F, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Bubbles_Setup_Data:							   ; Offset_0x045126
		dc.w	$0001
		dc.w	$A500, $0018, $0000
		dc.l	Bubbles_Mappings			   ; Offset_0x10EC1A
		dc.w	$0280
		dc.b	$14, $18, $00, $00
;-------------------------------------------------------------------------------
Bubbles_PLC_Data:							   ; Offset_0x045138
		dc.l	Art_Bubbles					   ; Offset_0x1198E8
		dc.l	Bubbles_Dyn_Script			   ; Offset_0x10EBF2
;-------------------------------------------------------------------------------
Offset_0x045140:
		dc.b	$00, $0F, $00, $77, $01, $03, $02, $03
		dc.b	$02, $03, $01, $03, $00, $77, $F4
;-------------------------------------------------------------------------------
Offset_0x04514F:
		dc.b	$00, $7F, $03, $03, $04, $6B, $04, $6B
		dc.b	$03, $03, $00, $7F, $FC
;===============================================================================
; Objeto 0xA3 - Inimigo Bubbles na Marble Garden
; <<<-
;===============================================================================