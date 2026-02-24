;===============================================================================
; Objeto 0xC2 - Pilha de neve na Icecap
; ->>>
;===============================================================================
; Offset_0x047B4E:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lea		Offset_0x047B64(PC, D0), A2
		move.l	(A2)+, (A0)
		move.l	(A2)+, A1
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x047B64:
		dc.l	Offset_0x047B7C
		dc.l	Snow_Pile_Setup_Data		   ; Offset_0x047CCC
		dc.l	Offset_0x047BE6
		dc.l	Snow_Pile_Setup_Data_2		   ; Offset_0x047CD8
		dc.l	Offset_0x047C22
		dc.l	Snow_Pile_Setup_Data_3		   ; Offset_0x047CE4
;-------------------------------------------------------------------------------
Offset_0x047B7C:
		lea		Offset_0x047B9E(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x047B9A
		tst.w	D0
		beq.s	Offset_0x047B90
		bsr.w	Offset_0x047BA6
Offset_0x047B90:
		swap	D0
		tst.w	D0
		beq.s	Offset_0x047B9A
		bsr.w	Offset_0x047BA6
Offset_0x047B9A:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047B9E:
		dc.w	$FFD8, $0050, $FFE8, $0020
;-------------------------------------------------------------------------------
Offset_0x047BA6:
		move.w	D0, A3
		cmpi.b	#$09, Obj_Ani_Number(A3)				 ; $0020
		beq.s	Offset_0x047BD0
		btst	#$01, Obj_Status(A3)					 ; $002A
		bne.s	Offset_0x047BCE
		move.w	Obj_Speed_X(A3), D2				 ; $0018
		move.w	D2, D3
		bpl.s	Offset_0x047BC2
		neg.w	D2
Offset_0x047BC2:
		cmpi.w	#$0600, D2
		bcc.s	Offset_0x047BD0
		asr.w	#$01, D3
		move.w	D3, Obj_Inertia(A3)				 ; $001C
Offset_0x047BCE:
		rts
Offset_0x047BD0:
		move.w	A3, Obj_Height_3(A0)					 ; $0044
		lea		Offset_0x047CF8(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jsr		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
		addq.w	#$04, A7
		rts
;-------------------------------------------------------------------------------
Offset_0x047BE6:
		lea		Offset_0x047C02(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x047BFE
		tst.w	D0
		beq.s	Offset_0x047BFE
		lea		Offset_0x047D1E(PC), A2
		bsr.w	Offset_0x047C0A
Offset_0x047BFE:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047C02:
		dc.w	$FFF8, $0010, $FFF0, $0020
;-------------------------------------------------------------------------------
Offset_0x047C0A:
		move.w	D0, A1
		move.w	#$0800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x047C22:
		lea		Offset_0x047C3C(PC), A1
		jsr		Check_Player_In_Range(PC)			   ; Offset_0x043104
		tst.l	D0
		beq.s	Offset_0x047C38
		tst.w	D0
		beq.s	Offset_0x047C38
		lea		Offset_0x047D2C(PC), A2
		bsr.s	Offset_0x047C0A
Offset_0x047C38:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047C3C:
		dc.w	$FFF8, $0010, $FFF0, $0020
;-------------------------------------------------------------------------------
Offset_0x047C44:
		lea		Snow_Pile_Setup_Data_4(PC), A1		   ; Offset_0x047CF0
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x047C62, (A0)
		move.l	#Offset_0x047C6C, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x047C7C
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
Offset_0x047C62:
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------

Offset_0x047C6C:
		move.l	#Offset_0x047C74, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x047C74:
		jsr		Move_Light_Gravity(PC)		   ; Offset_0x0426C2
		jmp		Delete_Sprite_Check_X_Y(PC)			   ; Offset_0x042AD0
Offset_0x047C7C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Height_3(A1), A2					 ; $0044
		lea		Offset_0x047CB4(PC), A3
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, Obj_Timer(A0)				 ; $002E
		add.w	D0, D0
		move.l	(A3, D0), Obj_Speed_X(A0)			 ; $0018
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x047CB2
		bset	#$00, Obj_Flags(A0)				 ; $0004
		bset	#$00, Obj_Flags(A1)				 ; $0004
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x047CB2:
		rts
;-------------------------------------------------------------------------------
Offset_0x047CB4:
		dc.w	$FD00, $FE00, $FC00, $FD00, $FC00, $FD80, $FD80, $FE00
		dc.w	$FE00, $FE80, $FE00, $FF00
;-------------------------------------------------------------------------------
Snow_Pile_Setup_Data:						   ; Offset_0x047CCC
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$437D, $0080
		dc.b	$18, $08, $20, $00
;-------------------------------------------------------------------------------
Snow_Pile_Setup_Data_2:						   ; Offset_0x047CD8
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$437D, $0080
		dc.b	$08, $10, $21, $00
;-------------------------------------------------------------------------------
Snow_Pile_Setup_Data_3:						   ; Offset_0x047CE4
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$437D, $0080
		dc.b	$10, $10, $22, $00
;-------------------------------------------------------------------------------
Snow_Pile_Setup_Data_4:						   ; Offset_0x047CF0
		dc.w	$43B6, $0080
		dc.b	$08, $08, $09, $00
;-------------------------------------------------------------------------------
Offset_0x047CF8:
		dc.w	$0005
		dc.l	Offset_0x047C44
		dc.b	$F8, $F8
		dc.l	Offset_0x047C44
		dc.b	$08, $F8
		dc.l	Offset_0x047C44
		dc.b	$E8, $00
		dc.l	Offset_0x047C44
		dc.b	$F8, $00
		dc.l	Offset_0x047C44
		dc.b	$08, $00
		dc.l	Offset_0x047C44
		dc.b	$18, $00
;-------------------------------------------------------------------------------
Offset_0x047D1E:
		dc.w	$0001
		dc.l	Offset_0x047C44
		dc.b	$00, $F8
		dc.l	Offset_0x047C44
		dc.b	$00, $08
;-------------------------------------------------------------------------------
Offset_0x047D2C:
		dc.w	$0003
		dc.l	Offset_0x047C44
		dc.b	$F8, $F8
		dc.l	Offset_0x047C44
		dc.b	$00, $08
		dc.l	Offset_0x047C44
		dc.b	$08, $F8
		dc.l	Offset_0x047C44
		dc.b	$08, $08
;===============================================================================
; Objeto 0xC2 - Pilha de neve na Icecap
; <<<-
;===============================================================================