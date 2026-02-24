;===============================================================================
; Objeto 0xA1 - Inimigo Sparkle (Blastoid in Sonic 3 Manual) na Carnival Night
; ->>>
;===============================================================================
; Offset_0x045E4A:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045E62(PC, D0), D1
		jsr		Offset_0x045E62(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x045E62:
		dc.w	Offset_0x045E6C-Offset_0x045E62
		dc.w	Offset_0x045E74-Offset_0x045E62
		dc.w	Offset_0x045E98-Offset_0x045E62
		dc.w	Offset_0x045EB8-Offset_0x045E62
		dc.w	Offset_0x045EB8-Offset_0x045E62
;-------------------------------------------------------------------------------
Offset_0x045E6C:
		lea		Sparkle_Setup_Data(PC), A1			   ; Offset_0x045FC8
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x045E74:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcs.s	Offset_0x045E80
		rts
Offset_0x045E80:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x045FF0, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x045E9C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x045E98:
		jmp		Animate_Raw_Get_Faster(PC)			   ; Offset_0x042248
;-------------------------------------------------------------------------------
Offset_0x045E9C:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0004, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045EBC, Obj_Child(A0)			 ; $0034
		lea		Offset_0x045FE0(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x045EB8:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x045EBC:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		moveq	#$68, D0
		bchg	#01, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x045ECE
		neg.w	D0
Offset_0x045ECE:
		add.w	D0, Obj_Y(A0)					 ; $0014
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x045EE8, Obj_Child(A0)			 ; $0034
		lea		Offset_0x045FE8(PC), A2
		jmp		SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
;-------------------------------------------------------------------------------
Offset_0x045EE8:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x045EF0:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045F02(PC, D0), D1
		jsr		Offset_0x045F02(PC, D1)
		jmp		Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x045F02:
		dc.w	Offset_0x045F06-Offset_0x045F02
		dc.w	Offset_0x045F2C-Offset_0x045F02
;-------------------------------------------------------------------------------
Offset_0x045F06:
		lea		Sparkle_Setup_Data_2(PC), A1		   ; Offset_0x045FD4
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$34, D0
		btst	#$01, Obj_Flags(A1)				 ; $0004
		bne.s	Offset_0x045F26
		neg.w	D0
Offset_0x045F26:
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x045F2C:
		lea		Offset_0x045FF5(PC), A1
		jmp		Animate_Raw_A1(PC)			   ; Offset_0x042092
;-------------------------------------------------------------------------------
Offset_0x045F34:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x045F46(PC, D0), D1
		jsr		Offset_0x045F46(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x045F46:
		dc.w	Offset_0x045F4C-Offset_0x045F46
		dc.w	Offset_0x045F7C-Offset_0x045F46
		dc.w	Offset_0x045FC2-Offset_0x045F46
;-------------------------------------------------------------------------------
Offset_0x045F4C:
		lea		Sparkle_Setup_Data_3(PC), A1		   ; Offset_0x045FDA
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	#$0600, D0
		btst	#$01, Obj_Flags(A1)				 ; $0004
		bne.s	Offset_0x045F66
		neg.w	D0
Offset_0x045F66:
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0600, D0
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x045F76
		neg.w	D0
Offset_0x045F76:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x045F7C:
		lea		Offset_0x046000(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		moveq	#$40, D0
		move.w	Obj_Speed_X(A0), D1				 ; $0018
		bmi.s	Offset_0x045F8E
		neg.w	D0
Offset_0x045F8E:
		add.w	D0, D1
		cmpi.w	#$FF00, D1
		blt.s	Offset_0x045F9C
		cmpi.w	#$0100, D1
		ble.s	Offset_0x045FB6
Offset_0x045F9C:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		moveq	#$40, D0
		move.w	Obj_Speed_Y(A0), D1				 ; $001A
		bmi.s	Offset_0x045FAA
		neg.w	D0
Offset_0x045FAA:
		add.w	D0, D1
		move.w	D1, Obj_Speed_Y(A0)				 ; $001A
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x045FB6:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x045FC2:
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Sparkle_Setup_Data:							   ; Offset_0x045FC8
		dc.l	Sparkle_Mappings			   ; Offset_0x10EAE0
		dc.w	$A524, $0280
		dc.b	$0C, $0C, $00, $0B
;-------------------------------------------------------------------------------
Sparkle_Setup_Data_2:						   ; Offset_0x045FD4
		dc.w	$0200
		dc.b	$0C, $40, $02, $AB
;-------------------------------------------------------------------------------
Sparkle_Setup_Data_3:						   ; Offset_0x045FDA
		dc.w	$0280
		dc.b	$08, $08, $06, $98
;-------------------------------------------------------------------------------
Offset_0x045FE0:
		dc.w	$0000
		dc.l	Offset_0x045EF0
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x045FE8:
		dc.w	$0001
		dc.l	Offset_0x045F34
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x045FF0:
		dc.b	$09, $10, $00, $01, $FC
;-------------------------------------------------------------------------------
Offset_0x045FF5:
		dc.b	$00, $02, $08, $03, $08, $04, $08, $05
		dc.b	$08, $02, $F4
;-------------------------------------------------------------------------------
Offset_0x046000:
		dc.b	$03, $06, $07, $FC
;===============================================================================
; Objeto 0xA1 - Inimigo Sparkle (Blastoid in Sonic 3 Manual) na Carnival Night
; <<<-
;===============================================================================