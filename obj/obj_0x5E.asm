;===============================================================================
; Objeto 0x5E - Plataforma com hélices embaixo na Chrome Gadget
; ->>>
;===============================================================================
; Offset_0x02BFBE:
		move.l	#Blade_Platform_Mappings, Obj_Map(A0) ; Offset_0x02C100, $000C
		move.w	#$6300, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		bset	#$07, Obj_Status(A0)					 ; $002A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02C054
		move.l	#Offset_0x02C0D4, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0010, Obj_X(A1)				 ; $0010
		addi.w	#$000C, Obj_Y(A1)				 ; $0014
		move.b	#$A6, Obj_Col_Flags(A1)					 ; $0028
		move.w	A0, Obj_Control_Var_0E(A1)				 ; $003E
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02C054
		move.l	#Offset_0x02C0EA, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0010, Obj_X(A1)				 ; $0010
		addi.w	#$0014, Obj_Y(A1)				 ; $0014
		move.b	#$A6, Obj_Col_Flags(A1)					 ; $0028
		move.w	A0, Obj_Control_Var_0E(A1)				 ; $003E
Offset_0x02C054:
		move.l	#Offset_0x02C05A, (A0)
Offset_0x02C05A:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x02C086
		move.w	#$0080, D1
		cmpi.b	#$18, D0
		bne.s	Offset_0x02C072
		move.w	#$0100, D1
Offset_0x02C072:
		add.w	D1, Obj_Control_Var_06(A0)				 ; $0036
		cmpi.w	#$8000, Obj_Control_Var_06(A0)			 ; $0036
		bcs.s	Offset_0x02C084
		move.w	#$8000, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x02C084:
		bra.s	Offset_0x02C09A
Offset_0x02C086:
		tst.w	Obj_Control_Var_06(A0)					 ; $0036
		beq.s	Offset_0x02C09A
		subi.w	#$0100, Obj_Control_Var_06(A0)			 ; $0036
		bcc.s	Offset_0x02C09A
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x02C09A:
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		add.b	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	D0, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$0007, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02C0D4:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		addi.w	#$0008, Obj_Y(A0)				 ; $0014
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
;-------------------------------------------------------------------------------
Offset_0x02C0EA:
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		addi.w	#$0010, Obj_Y(A0)				 ; $0014
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
;-------------------------------------------------------------------------------
Blade_Platform_Mappings:					   ; Offset_0x02C100
		dc.w	Offset_0x02C108-Blade_Platform_Mappings
		dc.w	Offset_0x02C116-Blade_Platform_Mappings
		dc.w	Offset_0x02C108-Blade_Platform_Mappings
		dc.w	Offset_0x02C116-Blade_Platform_Mappings
Offset_0x02C108:
		dc.w	$0002
		dc.w	$F70E, $000C, $FFE0
		dc.w	$F70F, $0018, $0000
Offset_0x02C116:
		dc.w	$0006
		dc.w	$FF04, $E028, $FFE0
		dc.w	$070C, $E02A, $FFE0
		dc.w	$0704, $E02E, $0000
		dc.w	$0F0C, $E030, $0000
		dc.w	$F70E, $000C, $FFE0
		dc.w	$F70F, $0018, $0000
;===============================================================================
; Objeto 0x5E - Plataforma com hélices embaixo na Chrome Gadget
; <<<-
;===============================================================================