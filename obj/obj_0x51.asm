;===============================================================================
; Objeto 0x51 - Plataformas flutuantes
; ->>>
;===============================================================================
Offset_0x01C3BA:
		dc.b	$20, $20, $00, $00, $18, $0C, $00, $00
;-------------------------------------------------------------------------------
Obj_0x51_Floating_Platform:					   ; Offset_0x01C3C2
		cmpi.b	#Hz_Id, (Current_Zone).w			; $01, $FFFFFE10
		bne.s	Offset_0x01C3D8
		move.l	#Hz_Floating_Platform_Mappings, Obj_Map(A0) ; Offset_0x01C518, $000C
		move.w	#$441D, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x01C3D8:
		cmpi.b	#MGz_Id, (Current_Zone).w			; $02, $FFFFFE10
		bne.s	Offset_0x01C3EE
		move.l	#MGz_Floating_Platform_Mappings, Obj_Map(A0) ; Offset_0x01C4E4, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x01C3EE:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$02, D0
		andi.w	#$001C, D0
		lea		Offset_0x01C3BA(PC, D0), A2
		move.b	(A2)+, Obj_Width(A0)					 ; $0007
		move.b	(A2)+, Obj_Height(A0)					 ; $0006
		move.b	(A2)+, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_X(A0), Obj_Control_Var_02(A0)		  ; $0010, $0032
		move.w	Obj_Y(A0), Obj_Control_Var_04(A0)		  ; $0014, $0034
		move.b	Obj_Status(A0), Obj_Timer(A0)			  ; $002A, $002E
		move.w	#$0280, Obj_Control_Var_12(A0)			 ; $0042
		move.w	Obj_X(A0), Obj_Height_3(A0)		  ; $0010, $0044
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		subq.w	#$08, D0
		bcs.s	Offset_0x01C470
		cmpi.w	#$0004, D0
		bcc.s	Offset_0x01C464
		lsl.w	#$02, D0
		lea		(Oscillate_Data_Buffer+$2C).w, A2			 ; $FFFFFE8A
		lea		(A2, D0), A2
		tst.w	(A2)
		bpl.s	Offset_0x01C470
		bchg	#00, Obj_Timer(A0)				 ; $002E
		bra.s	Offset_0x01C470
Offset_0x01C464:
		move.w	#$0380, Obj_Control_Var_12(A0)			 ; $0042
		addi.w	#$0100, Obj_Height_3(A0)				 ; $0044
Offset_0x01C470:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.b	#$0F, D0
		add.b	D0, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
		move.l	#Offset_0x01C484, (A0)
Offset_0x01C484:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lea		(Offset_0x01BE36).l, A1
		move.w	(A1, D0), D1
		jsr		(A1, D1)
		move.w	(A7)+, D4
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01C4B8
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		moveq	#$00, D3
		move.b	Obj_Height(A0), D3				 ; $0006
		addq.w	#$01, D3
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
Offset_0x01C4B8:
		move.w	Obj_Height_3(A0), D0					 ; $0044
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmp.w	Obj_Control_Var_12(A0), D0				 ; $0042
		bhi.w	Offset_0x01C4D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01C4D2:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01C4DE
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01C4DE:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
MGz_Floating_Platform_Mappings:				   ; Offset_0x01C4E4
		dc.w	Offset_0x01C4E6-MGz_Floating_Platform_Mappings
Offset_0x01C4E6:
		dc.w	$0008
		dc.w	$DC0D, $0000, $FFE0
		dc.w	$DC0D, $0000, $0000
		dc.w	$EC0D, $0008, $FFE0
		dc.w	$EC0D, $0808, $0000
		dc.w	$FC0D, $0008, $FFE0
		dc.w	$FC0D, $0808, $0000
		dc.w	$0C0D, $0010, $FFE0
		dc.w	$0C0D, $0810, $0000
;-------------------------------------------------------------------------------
Hz_Floating_Platform_Mappings:				   ; Offset_0x01C518
		dc.w	Offset_0x01C51C-Hz_Floating_Platform_Mappings
		dc.w	Offset_0x01C52A-Hz_Floating_Platform_Mappings
Offset_0x01C51C:
		dc.w	$0002
		dc.w	$F40A, $0000, $FFE8
		dc.w	$F40A, $0800, $0000
Offset_0x01C52A:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
;===============================================================================
; Objeto 0x51 - Plataformas flutuantes
; <<<-
;===============================================================================