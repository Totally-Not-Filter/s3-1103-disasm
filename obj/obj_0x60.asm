;===============================================================================
; Objeto 0x60 - Bloco em forma de elefante na Balloon Park
; ->>>
;===============================================================================
; Offset_0x02C13C:
		move.l	#Elephant_Block_Mappings, Obj_Map(A0) ; Offset_0x02C29E, $000C
		move.w	#$0300, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$30, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0000, (A2)+
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$08, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		bset	#$07, Obj_Status(A0)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02C1B0
		move.w	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
		move.l	#Offset_0x02C20E, (A0)
		bra.w	Offset_0x02C20E
Offset_0x02C1B0:
		move.l	#Offset_0x02C1B6, (A0)
Offset_0x02C1B6:
		bsr.w	Offset_0x02C266
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.b	Obj_Control_Var_04(A0), D1				 ; $0034
		ext.w	D1
		sub.w	D1, D0
		move.w	D0, (A2)
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		asr.w	#$01, D1
		sub.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		addq.w	#$08, D1
		move.b	D1, Obj_Width(A0)				 ; $0007
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		cmpi.w	#$0020, D1
		bcs.s	Offset_0x02C1F0
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x02C1F0:
		addi.w	#$0007, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02C20E:
		bsr.w	Offset_0x02C266
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.b	Obj_Control_Var_04(A0), D1				 ; $0034
		ext.w	D1
		add.w	D1, D0
		move.w	D0, (A2)
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		asr.w	#$01, D1
		add.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		addq.w	#$08, D1
		move.b	D1, Obj_Width(A0)				 ; $0007
		move.w	#$0000, Obj_Flags(A2)					 ; $0004
		cmpi.w	#$0020, D1
		bcs.s	Offset_0x02C248
		move.w	#$0001, Obj_Flags(A2)					 ; $0004
Offset_0x02C248:
		addi.w	#$0007, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02C266:
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		bne.s	Offset_0x02C288
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		addi.w	#$0080, Obj_Control_Var_04(A0)			 ; $0034
		cmp.w	Obj_Control_Var_04(A0), D0				 ; $0034
		bhi.s	Offset_0x02C286
		move.w	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x02C286:
		bra.s	Offset_0x02C29C
Offset_0x02C288:
		subi.w	#$0080, Obj_Control_Var_04(A0)			 ; $0034
		bhi.s	Offset_0x02C29C
		move.w	#$0000, Obj_Control_Var_04(A0)			 ; $0034
		move.b	#$00, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x02C29C:
		rts
;-------------------------------------------------------------------------------
Elephant_Block_Mappings:					   ; Offset_0x02C29E
		dc.w	Offset_0x02C2A2-Elephant_Block_Mappings
		dc.w	Offset_0x02C2B0-Elephant_Block_Mappings
Offset_0x02C2A2:
		dc.w	$0002
		dc.w	$F00F, $006E, $FFF8
		dc.w	$F00F, $007E, $0018
Offset_0x02C2B0:
		dc.w	$0003
		dc.w	$F00F, $006E, $FFF8
		dc.w	$F00F, $007E, $0018
		dc.w	$F00F, $007E, $0038
;===============================================================================
; Objeto 0x60 - Bloco em forma de elefante na Balloon Park
; <<<-
;===============================================================================