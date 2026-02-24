;===============================================================================
; Objeto Cauda do Miles
; ->>>
;===============================================================================
; Offset_0x00F1A6:
		move.l	#Miles_Mappings, Obj_Map(A0)	; Offset_0x101FF4, $000C
		move.w	#$06B0, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x00F1CC, (A0)
Offset_0x00F1CC:
		move.w	Obj_P_Flips_Remaining(A0), A2			 ; $0030
		move.b	Obj_Angle(A2), Obj_Angle(A0)			  ; $0026, $0026
		move.b	Obj_Status(A2), Obj_Status(A0)			  ; $002A, $002A
		move.w	Obj_X(A2), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A0)			  ; $0014, $0014
		move.w	Obj_Priority(A2), Obj_Priority(A0)		  ; $0008, $0008
		andi.w	#$7FFF, Obj_Art_VRAM(A0)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x00F200
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x00F200:
		moveq	#$00, D0
		move.b	Obj_Ani_Number(A2), D0					 ; $0020
		btst	#$05, Obj_Status(A2)					 ; $002A
		beq.s	Offset_0x00F210
		moveq	#$04, D0
Offset_0x00F210:
		cmp.b	Obj_P_Invunerblt_Time(A0), D0			 ; $0034
		beq.s	Offset_0x00F220
		move.b	D0, Obj_P_Invunerblt_Time(A0)			 ; $0034
		move.b	Offset_0x00F234(PC, D0), Obj_Ani_Number(A0)		 ; $0020
Offset_0x00F220:
		lea		(Miles_Tails_Animate_Data).l, A1		 ; Offset_0x00F256
		bsr.w	Miles_Animate_Sprite		   ; Offset_0x00E96C
		bsr.w	Load_Miles_Tails_Dynamic_PLC		   ; Offset_0x00ED54
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x00F234:
		dc.b	$00, $00, $03, $03, $09, $01, $00, $02
		dc.b	$01, $07, $00, $00, $00, $08, $00, $00
		dc.b	$00, $00, $00, $00, $0A, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Miles_Tails_Animate_Data:					   ; Offset_0x00F256
		dc.w	Offset_0x00F26C-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F26F-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F276-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F27E-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F284-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F28A-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F290-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F296-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F29C-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F2A2-Miles_Tails_Animate_Data
		dc.w	Offset_0x00F2A8-Miles_Tails_Animate_Data
Offset_0x00F26C:
		dc.b	$20, $00, $FF
Offset_0x00F26F:
		dc.b	$07, $09, $0A, $0B, $0C, $0D, $FF
Offset_0x00F276:
		dc.b	$03, $09, $0A, $0B, $0C, $0D, $FD, $01
Offset_0x00F27E:
		dc.b	$FC, $49, $4A, $4B, $4C, $FF
Offset_0x00F284:
		dc.b	$03, $4D, $4E, $4F, $50, $FF
Offset_0x00F28A:
		dc.b	$03, $51, $52, $53, $54, $FF
Offset_0x00F290:
		dc.b	$03, $55, $56, $57, $58, $FF
Offset_0x00F296:
		dc.b	$02, $81, $82, $83, $84, $FF
Offset_0x00F29C:
		dc.b	$02, $87, $88, $89, $8A, $FF
Offset_0x00F2A2:
		dc.b	$09, $87, $88, $89, $8A, $FF
Offset_0x00F2A8:
		dc.b	$09, $81, $82, $83, $84, $FF
;===============================================================================
; Objeto Cauda do Miles
; <<<-
;===============================================================================