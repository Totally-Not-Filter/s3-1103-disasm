;===============================================================================
; Objeto 0x43 - Plataforma na Carnival Night
; ->>>
;===============================================================================
; Offset_0x027DBA:
		move.l	#CNz_Platform_Mappings, Obj_Map(A0) ; Offset_0x027EBA, $000C
		move.w	#$43BE, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$30, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.b	#$06, Obj_Height_2(A0)					 ; $001E
		move.l	#Offset_0x027DEC, (A0)
Offset_0x027DEC:
		bsr.s	Offset_0x027E26
Offset_0x027DEE:
		move.w	#$0030, D1
		move.w	#$0011, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		lea		(CNz_Platform_Animate_Data).l, A1		 ; Offset_0x027E12
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
CNz_Platform_Animate_Data:					   ; Offset_0x027E12
		dc.w	Offset_0x027E18-CNz_Platform_Animate_Data
		dc.w	Offset_0x027E1B-CNz_Platform_Animate_Data
		dc.w	Offset_0x027E20-CNz_Platform_Animate_Data
Offset_0x027E18:
		dc.b	$7F, $00, $FF
Offset_0x027E1B:
		dc.b	$07, $01, $02, $FE, $01
Offset_0x027E20:
		dc.b	$03, $02, $01, $00, $FE, $01
;-------------------------------------------------------------------------------
Offset_0x027E26:
		move.b	Obj_Control_Var_00(A0), D0				 ; $0030
		bne.s	Offset_0x027E68
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x027E42
		move.b	#$01, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$0100, Obj_Ani_Number(A0)				 ; $0020
Offset_0x027E42:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		beq.s	Offset_0x027E66
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x027E66
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0200, Obj_Ani_Number(A0)				 ; $0020
Offset_0x027E66:
		rts
Offset_0x027E68:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x027EA2
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		cmpi.w	#$0200, Obj_Speed_Y(A0)					 ; $001A
		bge.s	Offset_0x027E86
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
Offset_0x027E86:
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x027EA0
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.l	#Offset_0x027DEE, (A0)
		move.w	#$0200, Obj_Ani_Number(A0)				 ; $0020
Offset_0x027EA0:
		rts
Offset_0x027EA2:
		neg.w	Obj_Speed_Y(A0)					 ; $001A
		subi.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		move.b	#$00, Obj_Control_Var_00(A0)			 ; $0030
		moveq	#Rising_Platform_Sfx, D0				  ; -$7D
		jmp		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
CNz_Platform_Mappings:						   ; Offset_0x027EBA
		dc.w	Offset_0x027EC0-CNz_Platform_Mappings
		dc.w	Offset_0x027EDA-CNz_Platform_Mappings
		dc.w	Offset_0x027EF4-CNz_Platform_Mappings
Offset_0x027EC0:
		dc.w	$0004
		dc.w	$F006, $0000, $FFD0
		dc.w	$F00E, $0006, $FFE0
		dc.w	$F00E, $0006, $0000
		dc.w	$F006, $0800, $0020
Offset_0x027EDA:
		dc.w	$0004
		dc.w	$F007, $0012, $FFD0
		dc.w	$F00F, $001A, $FFE0
		dc.w	$F00F, $001A, $0000
		dc.w	$F007, $0812, $0020
Offset_0x027EF4:
		dc.w	$0004
		dc.w	$F007, $0012, $FFD0
		dc.w	$F00F, $081A, $FFE0
		dc.w	$F00F, $081A, $0000
		dc.w	$F007, $0812, $0020
;===============================================================================
; Objeto 0x43 - Plataforma na Carnival Night
; <<<-
;===============================================================================