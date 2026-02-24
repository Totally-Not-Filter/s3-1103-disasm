;===============================================================================
; Objeto 0xA2 - Inimigo Batbot na Carnival Night
; ->>>
;===============================================================================
; Offset_0x046004:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04601C(PC, D0), D1
		jsr		Offset_0x04601C(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04601C:
		dc.w	Offset_0x046022-Offset_0x04601C
		dc.w	Offset_0x046032-Offset_0x04601C
		dc.w	Offset_0x04605A-Offset_0x04601C
;-------------------------------------------------------------------------------
Offset_0x046022:
		lea		Batbot_Setup_Data(PC), A1			   ; Offset_0x0460E2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		lea		Offset_0x0460FA(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x046032:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x04603E
		rts
Offset_0x04603E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0200, D0
		tst.w	D0
		bne.s	Offset_0x046054
		neg.w	D0
Offset_0x046054:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x04605A:
		lea		Offset_0x046108(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	#$0200, D0
		moveq	#$08, D1
		jsr		Chase_Object(PC)			   ; Offset_0x042E6C
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
;-------------------------------------------------------------------------------
Offset_0x046076:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04608C(PC, D0), D1
		jsr		Offset_0x04608C(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x04608C:
		dc.w	Offset_0x046092-Offset_0x04608C
		dc.w	Offset_0x04609A-Offset_0x04608C
		dc.w	Offset_0x0460B4-Offset_0x04608C
;-------------------------------------------------------------------------------
Offset_0x046092:
		lea		Batbot_Setup_Data_2(PC), A1			   ; Offset_0x0460EE
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x04609A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x0460A8
		rts
Offset_0x0460A8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x0460B4:
		lea		Offset_0x04610E(PC), A1
		jmp		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
;-------------------------------------------------------------------------------
Offset_0x0460BC:
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0460D2(PC, D0), D1
		jsr		Offset_0x0460D2(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0460D2:
		dc.w	Offset_0x0460D8-Offset_0x0460D2
		dc.w	Offset_0x04609A-Offset_0x0460D2
		dc.w	Offset_0x0460E0-Offset_0x0460D2
;-------------------------------------------------------------------------------
Offset_0x0460D8:
		lea		Batbot_Setup_Data_3(PC), A1			   ; Offset_0x0460F4
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x0460E0:
		rts
;-------------------------------------------------------------------------------
Batbot_Setup_Data:							   ; Offset_0x0460E2
		dc.l	Batbot_Mappings				   ; Offset_0x10EB82
		dc.w	$A552, $0280
		dc.b	$20, $08, $02, $0D
;-------------------------------------------------------------------------------
Batbot_Setup_Data_2:						   ; Offset_0x0460EE
		dc.w	$0200
		dc.b	$08, $08, $03, $00
;-------------------------------------------------------------------------------
Batbot_Setup_Data_3:						   ; Offset_0x0460F4
		dc.w	$0200
		dc.b	$04, $04, $05, $00
;-------------------------------------------------------------------------------
Offset_0x0460FA:
		dc.w	$0001
		dc.l	Offset_0x046076
		dc.b	$00, $10
		dc.l	Offset_0x0460BC
		dc.b	$00, $03
;-------------------------------------------------------------------------------
Offset_0x046108:
		dc.b	$02, $00, $01, $02, $01, $FC
;-------------------------------------------------------------------------------
Offset_0x04610E:
		dc.b	$03, $1D, $04, $02, $03, $01, $04, $02
		dc.b	$03, $0E, $04, $02, $FC, $00
;===============================================================================
; Objeto 0xA2 - Inimigo Batbot na Carnival Night
; <<<-
;===============================================================================