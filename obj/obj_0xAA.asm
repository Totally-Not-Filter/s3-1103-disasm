;===============================================================================
; Objeto 0xAA - Inimigo Penguinator na Icecap
; ->>>
;===============================================================================
; Offset_0x047F8A:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x047FAA(PC, D0), D1
		jsr		Offset_0x047FAA(PC, D1)
		lea		Penguinator_PLC_Data(PC), A2		   ; Offset_0x0482A6
		jsr		LoadDynamicPLC(PC)		  ; Offset_0x042A0A
		jmp		Check_Delete_Touch_Slotted(PC)		   ; Offset_0x042C1E
;-------------------------------------------------------------------------------
Offset_0x047FAA:
		dc.w	Offset_0x047FBA-Offset_0x047FAA
		dc.w	Offset_0x048016-Offset_0x047FAA
		dc.w	Offset_0x0480B0-Offset_0x047FAA
		dc.w	Offset_0x0480CA-Offset_0x047FAA
		dc.w	Offset_0x048118-Offset_0x047FAA
		dc.w	Offset_0x048166-Offset_0x047FAA
		dc.w	Offset_0x0481A0-Offset_0x047FAA
		dc.w	Offset_0x0481E8-Offset_0x047FAA
;-------------------------------------------------------------------------------
Offset_0x047FBA:
		lea		Penguinator_Setup_Data(PC), A1		   ; Offset_0x048280
		jsr		SetupSlottedObjectAttributes(PC)			; Offset_0x04298C
		bclr	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x047FD0
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x047FD0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$0F, Obj_Height_2(A0)					 ; $001E
		move.b	#$04, Obj_Width_2(A0)					 ; $001F
		bclr	#$05, Obj_Control_Var_08(A0)			 ; $0038
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		clr.w	Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0482AE, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0480A0, Obj_Child(A0)			 ; $0034
		moveq	#$02, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x048010
		neg.w	D0
Offset_0x048010:
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		rts
;-------------------------------------------------------------------------------
Offset_0x048016:
		jsr		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
		beq.s	Offset_0x048024
		cmpi.b	#$02, Obj_Timer(A0)				 ; $002E
		bls.s	Offset_0x04803C
Offset_0x048024:
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		move.w	Obj_Speed_X(A0), D1				 ; $0018
		add.w	D0, D1
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Hit_Floor_D3_A0(PC)		   ; Offset_0x0423F8
Offset_0x04803C:
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.b	D3
		beq.s	Offset_0x048058
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x048052
		bchg	#06, D3
Offset_0x048052:
		btst	#$06, D3
		beq.s	Offset_0x04808C
Offset_0x048058:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$FE00, D0
		move.w	#$0040, D1
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x048072
		neg.w	D0
		neg.w	D1
Offset_0x048072:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	D1, Obj_Control_Var_10(A0)				 ; $0040
		move.l	#Offset_0x0482B5, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0480B4, Obj_Child(A0)			 ; $0034
		rts
Offset_0x04808C:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.w	#$0040, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048058, Obj_Child(A0)			 ; $0034
Offset_0x0480A0:
		neg.w	Obj_Speed_X(A0)					 ; $0018
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		bchg	#00, Obj_Flags(A0)				 ; $0004
		rts
;-------------------------------------------------------------------------------
Offset_0x0480B0:
		jmp		SpeedToPos_Animate_Raw(PC)			   ; Offset_0x042F66
;-------------------------------------------------------------------------------
Offset_0x0480B4:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$0B, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x0480D2, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0480CA:
		jsr		Move_Light_Gravity(PC)		   ; Offset_0x0426C2
		jmp		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x0480D2:
		tst.b	D3
		move.b	D3, D4
		bpl.s	Offset_0x0480DA
		neg.b	D4
Offset_0x0480DA:
		andi.b	#$F8, D4
		beq.s	Offset_0x0480FE
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x0480EA
		bchg	#06, D3
Offset_0x0480EA:
		btst	#$06, D3
		bne.s	Offset_0x0480FE
		neg.w	Obj_Speed_X(A0)					 ; $0018
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x0480FE:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048140, Obj_Child(A0)			 ; $0034
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x048118:
		bsr.w	Offset_0x048234
		cmpi.w	#$FFFE, D1
		blt.w	Offset_0x0480A0
		cmpi.w	#$000C, D1
		bge.s	Offset_0x0480B4
		add.w	D1, Obj_Y(A0)					 ; $0014
		bsr.w	Offset_0x048248
		bsr.w	Offset_0x04826E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x048140:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		moveq	#$08, D0
		sub.b	Obj_Map_Id(A0), D0				 ; $0022
		move.b	D0, Obj_Ani_Frame(A0)					 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		move.l	#Offset_0x0482BA, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x048188, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x048166:
		bsr.w	Offset_0x048234
		cmpi.w	#$FFFE, D1
		blt.w	Offset_0x0480A0
		cmpi.w	#$000C, D1
		bge.w	Offset_0x0480B4
		add.w	D1, Obj_Y(A0)					 ; $0014
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x048188:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$0F, Obj_Height_2(A0)					 ; $001E
		subq.w	#$04, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0481A0:
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		add.w	Obj_Control_Var_10(A0), D0				 ; $0040
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		beq.s	Offset_0x0481C8
		bsr.w	Offset_0x048234
		cmpi.w	#$FFFE, D1
		blt.s	Offset_0x0481C8
		cmpi.w	#$000C, D1
		bge.s	Offset_0x0481C8
		add.w	D1, Obj_Y(A0)					 ; $0014
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x0481C8:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.l	#Offset_0x047FD0, Obj_Child(A0)			 ; $0034
		bchg	#00, Obj_Flags(A0)				 ; $0004
		rts
;-------------------------------------------------------------------------------
Offset_0x0481E8:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Obj_Snow_Dust: ; Usado também pelo objeto 0xBD		   ; Offset_0x0481EC
		lea		Snow_Dust_Setup_Data(PC), A1		   ; Offset_0x048292
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x048218
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		lsl.w	#$02, D0
		subq.w	#$01, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.l	#Offset_0x048218, Obj_Child(A0)			 ; $0034
Offset_0x048216:
		rts
Offset_0x048218:
		move.l	#Offset_0x048226, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
Offset_0x048226:
		lea		Offset_0x0482C3(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x048234:
		move.w	Obj_Speed_X(A0), D3				 ; $0018
		ext.l	D3
		lsl.l	#$08, D3
		add.l	Obj_X(A0), D3					 ; $0010
		swap	D3
		jmp		(ObjHitFloor_D3).l			   ; Offset_0x009D88
Offset_0x048248:
		moveq	#$04, D0
		tst.b	D3
		beq.s	Offset_0x048258
		lsr.b	#$03, D3
		andi.w	#$000F, D3
		move.b	Offset_0x04825E(PC, D3), D0
Offset_0x048258:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x04825E:
		dc.b	$04, $05, $06, $06, $07, $07, $08, $08
		dc.b	$08, $08, $07, $07, $06, $06, $05, $04
;-------------------------------------------------------------------------------
Offset_0x04826E:
		move.w	Obj_Timer(A0), D0				 ; $002E
		andi.w	#$0003, D0
		bne.s	Offset_0x048216
		lea		Offset_0x04829E(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Penguinator_Setup_Data:						   ; Offset_0x048280
		dc.w	$0003
		dc.w	$2500, $0012, $0000
		dc.l	Penguinator_Mappings		   ; Offset_0x10EE48
		dc.w	$0280
		dc.b	$14, $10, $00, $1A
;-------------------------------------------------------------------------------
Snow_Dust_Setup_Data:						   ; Offset_0x048292
		dc.l	Snow_Dust_Mappings			   ; Offset_0x10EEC6
		dc.w	$2558, $0000
		dc.b	$04, $18, $00, $00
;-------------------------------------------------------------------------------
Offset_0x04829E:
		dc.w	$0000
		dc.l	Obj_Snow_Dust				   ; Offset_0x0481EC
		dc.b	$00, $0C
;-------------------------------------------------------------------------------
Penguinator_PLC_Data:						   ; Offset_0x0482A6
		dc.l	Art_Penguinator				   ; Offset_0x1203EE
		dc.l	Penguinator_Dyn_Script		   ; Offset_0x10EE06
;-------------------------------------------------------------------------------
Offset_0x0482AE:
		dc.b	$07, $10, $00, $01, $00, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x0482B5:
		dc.b	$03, $03, $03, $04, $F4
;-------------------------------------------------------------------------------
Offset_0x0482BA:
		dc.b	$03, $08, $08, $07, $06, $05, $04, $03
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x0482C3:
		dc.b	$00, $00, $00, $01, $02, $03, $04, $05
		dc.b	$04, $03, $02, $01, $00, $F4, $00
;===============================================================================
; Objeto 0xAA - Inimigo Penguinator na Icecap
; <<<-
;===============================================================================