;===============================================================================
; Objeto 0xA6 - Inimigo Mantis na Marble Garden
; ->>>
;===============================================================================
; Offset_0x045B26:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045B3E(PC, D0), D1
		jsr		Offset_0x045B3E(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x045B3E:
		dc.w	Offset_0x045B48-Offset_0x045B3E
		dc.w	Offset_0x045B5E-Offset_0x045B3E
		dc.w	Offset_0x045B8A-Offset_0x045B3E
		dc.w	Offset_0x045BC4-Offset_0x045B3E
		dc.w	Offset_0x045BE8-Offset_0x045B3E
;-------------------------------------------------------------------------------
Offset_0x045B48:
		lea		Mantis_Setup_Data(PC), A1			   ; Offset_0x045C50
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$29, Obj_Height_2(A0)					 ; $001E
		lea		Offset_0x045C62(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x045B5E:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		beq.s	Offset_0x045B72
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x045B72:
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x045B7A
		rts
Offset_0x045B7A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045BAE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045B8A:
		lea		Offset_0x045C6A(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x045BA6
		bmi.s	Offset_0x045BA6
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		move.w	Offset_0x045BA8(PC, D0), D0
		add.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x045BA6:
		rts
;-------------------------------------------------------------------------------
Offset_0x045BA8:
		dc.w	$0000, $FFFB, $FFED
;-------------------------------------------------------------------------------
Offset_0x045BAE:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$FA00, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x045BD4, Obj_Child(A0)			 ; $0034
Offset_0x045BC2:
		rts
;-------------------------------------------------------------------------------
Offset_0x045BC4:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x045BC2
		jmp		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x045BD4:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x045C0E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045BE8:
		lea		Offset_0x045C71(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x045C04
		bmi.s	Offset_0x045C04
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		move.w	Offset_0x045C06(PC, D0), D0
		add.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x045C04:
		rts
;-------------------------------------------------------------------------------
Offset_0x045C06:
		dc.w	$0000, $0012, $0006, $FFFF
;-------------------------------------------------------------------------------
Offset_0x045C0E:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x045C16:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045C2C(PC, D0), D1
		jsr		Offset_0x045C2C(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x045C2C:
		dc.w	Offset_0x045C30-Offset_0x045C2C
		dc.w	Offset_0x045C38-Offset_0x045C2C
;-------------------------------------------------------------------------------
Offset_0x045C30:
		lea		Mantis_Setup_Data_2(PC), A1			   ; Offset_0x045C5C
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x045C38:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	#$05, Obj_Map_Id(A0)					 ; $0022
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x045C4E
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
Offset_0x045C4E:
		rts
;-------------------------------------------------------------------------------
Mantis_Setup_Data:							   ; Offset_0x045C50
		dc.l	Mantis_Mappings				   ; Offset_0x10ECDE
		dc.w	$254F, $0280
		dc.b	$14, $1C, $00, $1A
;-------------------------------------------------------------------------------
Mantis_Setup_Data_2:						   ; Offset_0x045C5C
		dc.w	$0200
		dc.b	$04, $04, $05, $00
;-------------------------------------------------------------------------------
Offset_0x045C62:
		dc.w	$0000
		dc.l	Offset_0x045C16
		dc.b	$F7, $F5
;-------------------------------------------------------------------------------
Offset_0x045C6A:
		dc.b	$00, $00, $01, $02, $02, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x045C71:
		dc.b	$02, $00, $01, $02, $03, $02, $00, $1F
		dc.b	$F4
;===============================================================================
; Objeto 0xA6 - Inimigo Mantis na Marble Garden
; <<<-
;===============================================================================