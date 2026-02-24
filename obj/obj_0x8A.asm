;===============================================================================
; Objeto 0x8A - Inimigo Corkey na Launch Base
; ->>>
;===============================================================================
; Offset_0x048BCE:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048BE6(PC, D0), D1
		jsr		Offset_0x048BE6(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x048BE6:
		dc.w	Offset_0x048BEC-Offset_0x048BE6
		dc.w	Offset_0x048C42-Offset_0x048BE6
		dc.w	Offset_0x048C72-Offset_0x048BE6
;-------------------------------------------------------------------------------
Offset_0x048BEC:
		lea		Corkey_Setup_Data(PC), A1			   ; Offset_0x048D86
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		moveq	#-$01, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x048C02
		neg.w	D0
Offset_0x048C02:
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, Obj_Timer_2(A0)				 ; $002F
		move.l	#Offset_0x048C62, Obj_Child(A0)			 ; $0034
		add.b	D0, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
		lea		Offset_0x048DA0(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x048C26:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$003F, D0
		move.w	D0, D1
		andi.w	#$0030, D1
		bne.s	Offset_0x048C3C
		ori.w	#$0030, D0
Offset_0x048C3C:
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		rts
;-------------------------------------------------------------------------------
Offset_0x048C42:
		subq.w	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		bmi.s	Offset_0x048C54
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D0, Obj_X(A0)					 ; $0010
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x048C54:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x048C62:
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		clr.b	Obj_Timer(A0)					 ; $002E
		move.b	Obj_Subtype(A0), Obj_Timer_2(A0)		  ; $002C, $002F
		rts
;-------------------------------------------------------------------------------
Offset_0x048C72:
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x048C7C
		rts
Offset_0x048C7C:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		bra.s	Offset_0x048C26
;-------------------------------------------------------------------------------
Offset_0x048C84:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048C96(PC, D0), D1
		jsr		Offset_0x048C96(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x048C96:
		dc.w	Offset_0x048C9E-Offset_0x048C96
		dc.w	Offset_0x048CA8-Offset_0x048C96
		dc.w	Offset_0x048CD0-Offset_0x048C96
		dc.w	Offset_0x048D4A-Offset_0x048C96
;-------------------------------------------------------------------------------
Offset_0x048C9E:
		lea		Corkey_Setup_Data_2(PC), A1			   ; Offset_0x048D92
		jmp		(SetupObjectAttributes3).l			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x048CA8:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x048CCE
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048D2E, Obj_Child(A0)			 ; $0034
		move.l	#Offset_0x048DC0, Obj_Child_Data(A0)			 ; $0030
Offset_0x048CCE:
		rts
;-------------------------------------------------------------------------------
Offset_0x048CD0:
		jsr		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
		tst.w	D2
		bpl.s	Offset_0x048CF0
		cmpi.b	#$04, Obj_Timer_2(A0)					 ; $002F
		beq.s	Offset_0x048CF2
		cmpi.b	#$05, Obj_Timer_2(A0)					 ; $002F
		beq.s	Offset_0x048D06
		cmpi.b	#$06, Obj_Timer_2(A0)					 ; $002F
		beq.s	Offset_0x048D1A
Offset_0x048CF0:
		rts
Offset_0x048CF2:
		lea		Offset_0x048DA8(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.l	#Offset_0x048DC5, Obj_Child_Data(A1)			 ; $0030
		rts
Offset_0x048D06:
		lea		Offset_0x048DB0(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.l	#Offset_0x048DCE, Obj_Child_Data(A1)			 ; $0030
		rts
Offset_0x048D1A:
		lea		Offset_0x048DB8(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.l	#Offset_0x048DD7, Obj_Child_Data(A1)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x048D2E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048D4E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048D4A:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x048D4E:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x048D66:
		lea		Corkey_Setup_Data_3(PC), A1			   ; Offset_0x048D98
		jsr		(SetupObjectAttributes2).l			; Offset_0x041D76
		move.l	#Offset_0x048D7E, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
Offset_0x048D7E:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Corkey_Setup_Data:							   ; Offset_0x048D86
		dc.l	Corkey_Mappings				   ; Offset_0x10D590
		dc.w	$2558, $0280
		dc.b	$10, $0C, $00, $0B
;-------------------------------------------------------------------------------
Corkey_Setup_Data_2:						   ; Offset_0x048D92
		dc.w	$0280
		dc.b	$08, $04, $01, $00
;-------------------------------------------------------------------------------
Corkey_Setup_Data_3:						   ; Offset_0x048D98
		dc.w	$0558, $0280
		dc.b	$04, $50, $00, $A0
;-------------------------------------------------------------------------------
Offset_0x048DA0:
		dc.w	$0000
		dc.l	Offset_0x048C84
		dc.b	$00, $0C
;-------------------------------------------------------------------------------
Offset_0x048DA8:
		dc.w	$0000
		dc.l	Offset_0x048D66
		dc.b	$FC, $54
;-------------------------------------------------------------------------------
Offset_0x048DB0:
		dc.w	$0000
		dc.l	Offset_0x048D66
		dc.b	$04, $54
;-------------------------------------------------------------------------------
Offset_0x048DB8:
		dc.w	$0000
		dc.l	Offset_0x048D66
		dc.b	$00, $54
;-------------------------------------------------------------------------------
Offset_0x048DC0:
		dc.b	$07, $10, $01, $03, $FC
;-------------------------------------------------------------------------------
Offset_0x048DC5:
		dc.b	$06, $00, $06, $00, $07, $04, $05, $00
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x048DCE:
		dc.b	$05, $00, $05, $00, $07, $04, $06, $00
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x048DD7:
		dc.b	$04, $00, $05, $00, $07, $00, $04, $00
		dc.b	$05, $00, $07, $00, $04, $00, $05, $00
		dc.b	$07, $00, $04, $00, $05, $00, $07, $00
		dc.b	$04, $00, $05, $00, $07, $00, $06, $03
		dc.b	$F4
;===============================================================================
; Objeto 0x8A - Inimigo Corkey na Launch Base
; <<<-
;===============================================================================