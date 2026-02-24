;===============================================================================
; Objeto 0x16 - Lança chamas na Launch Base
; ->>>
;===============================================================================
Offset_0x01D2EA:
		move.l	#Flame_Thrower_Mappings, Obj_Map(A1) ; Offset_0x01D3C6, $000C
		move.w	#$43AC, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		ori.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		rts
;-------------------------------------------------------------------------------
Obj_0x16_LBz_Flame_Thrower:					   ; Offset_0x01D312
		move.l	A0, A1
		bsr.s	Offset_0x01D2EA
		move.l	#Offset_0x01D31C, (A0)
Offset_0x01D31C:
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		add.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$7F, D0
		bne.s	Offset_0x01D376
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01D376
		move.l	#Offset_0x01D39A, (A1)
		bsr.s	Offset_0x01D2EA
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	Obj_Status(A0), Obj_Status(A1)			  ; $002A, $002A
		move.b	#$9D, Obj_Col_Flags(A1)					 ; $0028
		addi.w	#$0040, Obj_X(A1)				 ; $0010
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01D368
		subi.w	#$0080, Obj_X(A1)				 ; $0010
Offset_0x01D368:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01D376
		moveq	#Fire_Shield_Sfx, D0					   ; $43
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01D376:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01D39A:
		lea		(Flame_Thrower_Animate_Data).l, A1		 ; Offset_0x01D3B8
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x01D3B2
		move.w	#$7FFF, Obj_X(A0)				 ; $0010
Offset_0x01D3B2:
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
Flame_Thrower_Animate_Data:					   ; Offset_0x01D3B8
		dc.w	Offset_0x01D3BA-Flame_Thrower_Animate_Data
Offset_0x01D3BA:
		dc.b	$03, $01, $02, $03, $04, $05, $03, $04
		dc.b	$06, $07, $08, $FC
;-------------------------------------------------------------------------------
Flame_Thrower_Mappings:						   ; Offset_0x01D3C6
		dc.w	Offset_0x01D3D8-Flame_Thrower_Mappings
		dc.w	Offset_0x01D3E0-Flame_Thrower_Mappings
		dc.w	Offset_0x01D3EE-Flame_Thrower_Mappings
		dc.w	Offset_0x01D408-Flame_Thrower_Mappings
		dc.w	Offset_0x01D42E-Flame_Thrower_Mappings
		dc.w	Offset_0x01D454-Flame_Thrower_Mappings
		dc.w	Offset_0x01D47A-Flame_Thrower_Mappings
		dc.w	Offset_0x01D4A0-Flame_Thrower_Mappings
		dc.w	Offset_0x01D4BA-Flame_Thrower_Mappings
Offset_0x01D3D8:
		dc.w	$0001
		dc.w	$F00F, $083B, $FFF0
Offset_0x01D3E0:
		dc.w	$0002
		dc.w	$FC04, $004B, $FFD0
		dc.w	$FC04, $004D, $FFE0
Offset_0x01D3EE:
		dc.w	$0004
		dc.w	$FC04, $004D, $FFD0
		dc.w	$FC04, $004F, $FFE0
		dc.w	$FC04, $0051, $FFF0
		dc.w	$F805, $0057, $0000
Offset_0x01D408:
		dc.w	$0006
		dc.w	$FC04, $004B, $FFD0
		dc.w	$FC04, $004D, $FFE0
		dc.w	$FC04, $004F, $FFF0
		dc.w	$FC04, $0051, $0000
		dc.w	$F805, $0053, $0010
		dc.w	$F805, $0057, $0020
Offset_0x01D42E:
		dc.w	$0006
		dc.w	$FC04, $104B, $FFD0
		dc.w	$FC04, $104D, $FFE0
		dc.w	$FC04, $104F, $FFF0
		dc.w	$FC04, $1051, $0000
		dc.w	$F805, $1053, $0010
		dc.w	$F805, $1057, $0020
Offset_0x01D454:
		dc.w	$0006
		dc.w	$FC04, $004D, $FFD0
		dc.w	$FC04, $004F, $FFE0
		dc.w	$FC04, $0051, $FFF0
		dc.w	$F805, $0053, $0000
		dc.w	$F805, $1853, $0010
		dc.w	$F805, $005B, $0020
Offset_0x01D47A:
		dc.w	$0006
		dc.w	$FC04, $104D, $FFD0
		dc.w	$FC04, $104F, $FFE0
		dc.w	$FC04, $1051, $FFF0
		dc.w	$F805, $1053, $0000
		dc.w	$F805, $0853, $0010
		dc.w	$F805, $105B, $0020
Offset_0x01D4A0:
		dc.w	$0004
		dc.w	$FC04, $004B, $FFF0
		dc.w	$FC04, $004D, $0000
		dc.w	$FC04, $004F, $0010
		dc.w	$F805, $005B, $0020
Offset_0x01D4BA:
		dc.w	$0002
		dc.w	$FC04, $004B, $0010
		dc.w	$FC04, $005F, $0020
;===============================================================================
; Objeto 0x16 - Lança chamas na Launch Base
; <<<-
;===============================================================================