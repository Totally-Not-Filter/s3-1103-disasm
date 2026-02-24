;===============================================================================
; Objeto 0x66 - Gotejador na Endless Mine
; ->>>
;===============================================================================
; Offset_0x02DF26:
		move.l	#Dripper_Mappings, Obj_Map(A0)	; Offset_0x02E080, $000C
		move.w	#$6300, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Width_2(A0)					 ; $001F
		move.b	#$04, Obj_Height_2(A0)					 ; $001E
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02DF78
		move.w	#$C300, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.l	#DisplaySprite, (A0)		   ; Offset_0x011148
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02DF78:
		move.l	#Offset_0x02DF7E, (A0)
Offset_0x02DF7E:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		add.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$7F, D0
		bne.s	Offset_0x02DFB6
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02DFB6
		moveq	#$2C, D0
Offset_0x02DF98:
		move.w	$00(A0, D0), $00(A1, D0)
		subq.w	#$02, D0
		bcc.s	Offset_0x02DF98
		move.l	#Offset_0x02DFBC, (A1)
		move.w	#$4300, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		moveq	#$00, D0
Offset_0x02DFB6:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02DFBC:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x02DFF6
		move.l	#Offset_0x02E062, (A0)
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		asr.w	Obj_Speed_Y(A0)					 ; $001A
		asr.w	Obj_Speed_Y(A0)					 ; $001A
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bsr.s	Offset_0x02E020
		bsr.s	Offset_0x02E020
		bsr.s	Offset_0x02E020
Offset_0x02DFF6:
		cmpi.w	#$FF00, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		bne.s	Offset_0x02E006
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x02E006:
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$0060, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bge.s	Offset_0x02E01A
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02E01A:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02E020:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02E060
		moveq	#$2C, D0
Offset_0x02E02C:
		move.w	$00(A0, D0), $00(A1, D0)
		subq.w	#$02, D0
		bcc.s	Offset_0x02E02C
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	D0, D1
		andi.w	#$01FF, D0
		subi.w	#$0100, D0
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		rol.w	#$04, D1
		andi.w	#$000F, D1
		addi.w	#$001A, D1
		move.b	D1, Obj_Control_Var_0C(A1)				 ; $003C
		subi.w	#$0010, Obj_Speed_Y(A0)					 ; $001A
		moveq	#$00, D0
Offset_0x02E060:
		rts
;-------------------------------------------------------------------------------
Offset_0x02E062:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		subq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bne.s	Offset_0x02E07A
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02E07A:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Dripper_Mappings:							   ; Offset_0x02E080
		dc.w	Offset_0x02E088-Dripper_Mappings
		dc.w	Offset_0x02E090-Dripper_Mappings
		dc.w	Offset_0x02E098-Dripper_Mappings
		dc.w	Offset_0x02E0A0-Dripper_Mappings
Offset_0x02E088:
		dc.w	$0001
		dc.w	$FC04, $0000, $FFF8
Offset_0x02E090:
		dc.w	$0001
		dc.w	$FC00, $0002, $FFFC
Offset_0x02E098:
		dc.w	$0001
		dc.w	$FC00, $0003, $FFFC
Offset_0x02E0A0:
		dc.w	$0001
		dc.w	$FC00, $0004, $FFFC
;===============================================================================
; Objeto 0x66 - Gotejador na Endless Mine
; <<<-
;===============================================================================