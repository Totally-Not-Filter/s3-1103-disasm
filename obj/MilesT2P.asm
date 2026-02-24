;===============================================================================
; Objeto Cauda do Miles no modo 2 jogadores
; ->>>
;===============================================================================
; Offset_0x00F2AE:
		move.l	#Miles_Tails_2P_Mappings, Obj_Map(A0) ; Offset_0x1030DA, $000C
		move.w	#$06B0, Obj_Art_VRAM(A0)				 ; $000A
		cmpa.w	#$CC0A, A0
		beq.s	Offset_0x00F2C8
		move.w	#$0690, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00F2C8:
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x00F2E0, (A0)
Offset_0x00F2E0:
		move.w	Obj_P_Flips_Remaining(A0), A2			 ; $0030
		move.b	Obj_Angle(A2), Obj_Angle(A0)			  ; $0026, $0026
		move.b	Obj_Status(A2), Obj_Status(A0)			  ; $002A, $002A
		move.b	Obj_Flags(A2), Obj_Flags(A0)			  ; $0004, $0004
		move.w	Obj_X(A2), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A0)			  ; $0014, $0014
		move.w	Obj_Priority(A2), Obj_Priority(A0)		  ; $0008, $0008
		andi.w	#$7FFF, Obj_Art_VRAM(A0)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x00F31A
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00F31A:
		moveq	#$00, D0
		move.b	Obj_Ani_Number(A2), D0					 ; $0020
		btst	#$05, Obj_Status(A2)					 ; $002A
		beq.s	Offset_0x00F330
		cmpi.b	#$05, D0
		beq.s	Offset_0x00F330
		moveq	#$04, D0
Offset_0x00F330:
		cmp.b	Obj_P_Invunerblt_Time(A0), D0			 ; $0034
		beq.s	Offset_0x00F340
		move.b	D0, Obj_P_Invunerblt_Time(A0)			 ; $0034
		move.b	Offset_0x00F354(PC, D0), Obj_Ani_Number(A0)		 ; $0020
Offset_0x00F340:
		lea		(Miles_Tails_2P_Animate_Data).l, A1		 ; Offset_0x00F376
		bsr.w	Miles_Animate_Sprite_2P_A1			   ; Offset_0x00EDD6
		bsr.w	Load_Miles_Tails_Dynamic_PLC_2P		   ; Offset_0x00F122
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x00F354:
		dc.b	$00, $00, $03, $03, $00, $01, $01, $01
		dc.b	$01, $00, $01, $01, $01, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Miles_Tails_2P_Animate_Data:				   ; Offset_0x00F376
		dc.w	Miles_Tails_2P_Ani_00-Miles_Tails_2P_Animate_Data ; Offset_0x00F37E
		dc.w	Miles_Tails_2P_Ani_01-Miles_Tails_2P_Animate_Data ; Offset_0x00F381
		dc.w	Miles_Tails_2P_Ani_01-Miles_Tails_2P_Animate_Data ; Offset_0x00F381
		dc.w	Miles_Tails_2P_Ani_02-Miles_Tails_2P_Animate_Data ; Offset_0x00F386
Miles_Tails_2P_Ani_00:						   ; Offset_0x00F37E
		dc.b	$20, $00, $FF
Miles_Tails_2P_Ani_01:						   ; Offset_0x00F381
		dc.b	$07, $01, $02, $03, $FF
Miles_Tails_2P_Ani_02:						   ; Offset_0x00F386
		dc.b	$FC, $04, $05, $06, $FF, $00
;===============================================================================
; Objeto Cauda do Miles no modo 2 jogadores
; <<<-
;===============================================================================