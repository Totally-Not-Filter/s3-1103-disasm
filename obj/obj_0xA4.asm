;===============================================================================
; Objeto 0xA4 - Mini chefe na Marble Garden (Cutscenes)
; ->>>
;===============================================================================
; Offset_0x04515C:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045178(PC, D0), D1
		jsr		Offset_0x045178(PC, D1)
		bsr.w	Offset_0x04573C
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x045178:
		dc.w	Offset_0x045182-Offset_0x045178
		dc.w	Offset_0x0451A4-Offset_0x045178
		dc.w	Offset_0x0451D4-Offset_0x045178
		dc.w	Offset_0x0451FC-Offset_0x045178
		dc.w	Offset_0x045230-Offset_0x045178
;-------------------------------------------------------------------------------
Offset_0x045182:
		lea		Tunnelbot_Setup_Data(PC), A1		   ; Offset_0x0457C4
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$FE, Obj_Boss_Hit(A0)					 ; $0029
		move.b	#$28, Obj_Height_2(A0)					 ; $001E
		jsr		(Swing_Setup).l				   ; Offset_0x03669A
		lea		Offset_0x0457FA(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0451A4:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcc.w	Offset_0x0451D2
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045841, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0451E4, Obj_Child(A0)			 ; $0034
Offset_0x0451D2:
		rts
;-------------------------------------------------------------------------------
Offset_0x0451D4:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
;-------------------------------------------------------------------------------
Offset_0x0451E4:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045847, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x045216, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0451FC:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		subq.w	#$01, Obj_Y(A0)					 ; $0014
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bpl.s	Offset_0x045214
		move.l	Obj_Child(A0), A1				 ; $0034
		jsr		(A1)
Offset_0x045214:
		rts
;-------------------------------------------------------------------------------
Offset_0x045216:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		st		(Earthquake_Flag).w					 ; $FFFFEECC
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045254, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045230:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		moveq	#-$02, D0
		move.b	(Vint_runcount+$03).w, D1		  ; $FFFFFE0F
		btst	#$00, D1
		beq.s	Offset_0x045242
		moveq	#$01, D0
Offset_0x045242:
		add.w	D0, Obj_Y(A0)					 ; $0014
		andi.b	#$07, D1
		bne.s	Offset_0x045250
		bsr.w	Offset_0x04570C
Offset_0x045250:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045254:
		clr.w	(Earthquake_Flag).w					 ; $FFFFEECC
		st		(Level_Trigger_Array+$08).w			 ; $FFFFF7E8
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;===============================================================================
; Objeto 0xA4 - Mini chefe na Marble Garden (Cutscenes)
; <<<-
;===============================================================================