;===============================================================================
; Objeto 0x57 - Plataforma ativada através da roda azul na Marble Garden.
; ->>>
;===============================================================================
Offset_0x02A878:
		dc.b	$40, $1E, $00, $40
		dc.b	$20, $40, $01, $40
		dc.b	$20, $40, $01, $40
;-------------------------------------------------------------------------------
Obj_0x57_MGz_Trigger_Platform:				   ; Offset_0x02A884
		move.b	Obj_Subtype(A0), D1				 ; $002C
		andi.w	#$00F0, D1
		lsr.w	#$02, D1
		lea		Offset_0x02A878(PC, D1), A1
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		moveq	#$00, D0
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_00(A0)				 ; $0030
		lsr.w	#$02, D1
		move.w	D1, Obj_Control_Var_04(A0)				 ; $0034
		move.l	#Trigger_Platform_Mappings, Obj_Map(A0) ; Offset_0x02A9C2, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_06(A0)		  ; $0010, $0036
		tst.w	D1
		beq.s	Offset_0x02A8DA
		move.l	#Offset_0x02A94E, (A0)
		bra.w	Offset_0x02A94E
Offset_0x02A8DA:
		move.l	#Offset_0x02A8E0, (A0)
Offset_0x02A8E0:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x02A926
		moveq	#$02, D0
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A8FE
		neg.w	D0
Offset_0x02A8FE:
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	#$FFFF, (Earthquake_Flag).w			 ; $FFFFEECC
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x02A926
		move.w	#$7F00, Obj_X(A0)				 ; $0010
		move.w	#$7F00, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0000, Obj_Respaw_Ref(A0)				 ; $0048
		move.w	#$0000, (Earthquake_Flag).w			 ; $FFFFEECC
Offset_0x02A926:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
Offset_0x02A94E:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x02A96C
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		bmi.s	Offset_0x02A99E
		move.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
Offset_0x02A96C:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x02A99E
		bmi.s	Offset_0x02A99E
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A982
		neg.w	D0
Offset_0x02A982:
		add.w	D0, Obj_Y(A0)					 ; $0014
		move.w	#$FFFF, (Earthquake_Flag).w			 ; $FFFFEECC
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x02A99E
		move.b	#$FF, Obj_Control_Var_02(A0)			 ; $0032
		move.w	#$0000, (Earthquake_Flag).w			 ; $FFFFEECC
Offset_0x02A99E:
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
Trigger_Platform_Mappings:					   ; Offset_0x02A9C2
		dc.w	Offset_0x02A9C6-Trigger_Platform_Mappings
		dc.w	Offset_0x02AA28-Trigger_Platform_Mappings
Offset_0x02A9C6:
		dc.w	$0010
		dc.w	$DC0D, $0018, $FFC0
		dc.w	$DC0D, $0018, $FFE0
		dc.w	$DC0D, $0018, $0000
		dc.w	$DC0D, $0018, $0020
		dc.w	$EC0D, $0020, $FFC0
		dc.w	$EC0D, $0020, $FFE0
		dc.w	$EC0D, $0020, $0000
		dc.w	$EC0D, $0020, $0020
		dc.w	$FC0D, $0028, $FFC0
		dc.w	$FC0D, $0030, $FFE0
		dc.w	$FC0D, $0030, $0000
		dc.w	$FC0D, $0028, $0020
		dc.w	$0C0D, $0010, $FFC0
		dc.w	$0C0D, $0028, $FFE0
		dc.w	$0C0D, $0028, $0000
		dc.w	$0C0D, $0810, $0020
Offset_0x02AA28:
		dc.w	$0010
		dc.w	$BC0D, $0018, $FFE0
		dc.w	$BC0D, $0018, $0000
		dc.w	$CC0D, $0020, $FFE0
		dc.w	$CC0D, $0020, $0000
		dc.w	$DC0D, $0030, $FFE0
		dc.w	$DC0D, $0030, $0000
		dc.w	$EC0D, $007C, $FFE0
		dc.w	$EC0D, $087C, $0000
		dc.w	$FC0D, $0084, $FFE0
		dc.w	$FC0D, $0884, $0000
		dc.w	$0C0D, $0084, $FFE0
		dc.w	$0C0D, $0884, $0000
		dc.w	$1C0D, $0084, $FFE0
		dc.w	$1C0D, $0884, $0000
		dc.w	$2C0D, $008C, $FFE0
		dc.w	$2C0D, $088C, $0000
;===============================================================================
; Objeto 0x57 - Plataforma ativada através da roda azul na Marble Garden.
; <<<-
;===============================================================================