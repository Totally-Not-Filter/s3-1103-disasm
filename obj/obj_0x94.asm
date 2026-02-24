;===============================================================================
; Objeto 0x93 - Inimigo Mushmeanie na Mushroom Valley
; ->>>
;===============================================================================
; Offset_0x0499BC:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0499D4(PC, D0), D1
		jsr		Offset_0x0499D4(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0499D4:
		dc.w	Offset_0x0499DE-Offset_0x0499D4
		dc.w	Offset_0x0499F8-Offset_0x0499D4
		dc.w	Offset_0x049A1E-Offset_0x0499D4
		dc.w	Offset_0x049A4C-Offset_0x0499D4
		dc.w	Offset_0x049AA4-Offset_0x0499D4
;-------------------------------------------------------------------------------
Offset_0x0499DE:
		lea		Mushmeanie_Setup_Data(PC), A1		   ; Offset_0x049AF6
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$12, Obj_Height_2(A0)					 ; $001E
		lea		Offset_0x049B0A(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x0499F8:
		jsr		(Find_Player).l				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcs.s	Offset_0x049A06
		rts
Offset_0x049A06:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x049B12, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x049A30, Obj_Child(A0)			 ; $0034
Offset_0x049A1C:
		rts
;-------------------------------------------------------------------------------
Offset_0x049A1E:
		jsr		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
		tst.w	D2
		bne.s	Offset_0x049A2A
		rts
Offset_0x049A2A:
		subq.w	#$03, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x049A30:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$FD00, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x049A8C, Obj_Child(A0)			 ; $0034
		move.w	#$FF00, D4
		jmp		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
;-------------------------------------------------------------------------------
Offset_0x049A4C:
		jsr		(Move_Light_Gravity).l		   ; Offset_0x0426C2
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x049A64
		moveq	#$08, D3
		jsr		(Object_HitWall_Right).l		   ; Offset_0x009EEE
		bra.w	Offset_0x049A6C
Offset_0x049A64:
		moveq	#-$08, D3
		jsr		(Object_HitWall_Left).l		   ; Offset_0x00A138
Offset_0x049A6C:
		tst.w	D1
		bpl.s	Offset_0x049A7E
		add.w	D1, Obj_X(A0)					 ; $0010
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x049A7E:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.w	Offset_0x049A1C
		jmp		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
;-------------------------------------------------------------------------------
Offset_0x049A8C:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x049B19, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x049A30, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x049AA4:
		jsr		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
		tst.w	D2
		bne.s	Offset_0x049AB0
		rts
Offset_0x049AB0:
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		move.w	Offset_0x049AC0(PC, D0), D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x049AC0:
		dc.w	$FFFD, $0003, $0003, $FFFD, $FFFD, $FFFD
;-------------------------------------------------------------------------------
Offset_0x049ACC:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x049AE6(PC, D0), D1
		jsr		Offset_0x049AE6(PC, D1)
		jmp		(Child_Display_Touch_Or_Delete).l		   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x049AE6:
		dc.w	Offset_0x049AEA-Offset_0x049AE6
		dc.w	Offset_0x049AF4-Offset_0x049AE6
;-------------------------------------------------------------------------------
Offset_0x049AEA:
		lea		Mushmeanie_Setup_Data_2(PC), A1		   ; Offset_0x049B02
		jmp		(SetupObjectAttributes2).l			; Offset_0x041D76
;-------------------------------------------------------------------------------
Offset_0x049AF4:
		rts
;-------------------------------------------------------------------------------
Mushmeanie_Setup_Data:						   ; Offset_0x049AF6
		dc.l	Mushmeanie_Mappings			   ; Offset_0x10E330
		dc.w	$A55E, $0280
		dc.b	$08, $08, $01, $07
;-------------------------------------------------------------------------------
Mushmeanie_Setup_Data_2:					   ; Offset_0x049B02
		dc.w	$C55E, $0200
		dc.b	$0C, $08, $00, $1A
;-------------------------------------------------------------------------------
Offset_0x049B0A:
		dc.w	$0000
		dc.l	Offset_0x049ACC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x049B12:
		dc.b	$01, $02, $02, $02, $03, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x049B19:
		dc.b	$03, $02, $02, $02, $01, $02, $02, $02
		dc.b	$03, $00, $F4
;===============================================================================
; Objeto 0x93 - Inimigo Mushmeanie na Mushroom Valley
; <<<-
;===============================================================================