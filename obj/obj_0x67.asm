;===============================================================================
; Objeto 0x67 - Plataformas na Hidrocity
; ->>>
;===============================================================================
; Offset_0x01C532:
		move.l	#Hz_Floating_Platform_Mappings, Obj_Map(A0) ; Offset_0x01C518, $000C
		move.w	#$0028, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_04(A0)		  ; $0014, $0034
		move.b	Obj_Status(A0), Obj_Timer(A0)			  ; $002A, $002E
		moveq	#$01, D0
		move.b	Obj_Subtype(A0), D1				 ; $002C
		bpl.s	Offset_0x01C57A
		neg.w	D0
Offset_0x01C57A:
		move.b	D0, Obj_Control_Var_10(A0)				 ; $0040
		andi.b	#$7F, D1
		move.b	D1, Obj_Angle(A0)				 ; $0026
		move.w	#$0280, Obj_Control_Var_12(A0)			 ; $0042
		move.w	Obj_X(A0), Obj_Height_3(A0)		  ; $0010, $0044
		move.l	#Offset_0x01C598, (A0)
Offset_0x01C598:
		bsr.s	Offset_0x01C5E4
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.w	Obj_Height_3(A0), D0					 ; $0044
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmp.w	Obj_Control_Var_12(A0), D0				 ; $0042
		bhi.w	Offset_0x01C5D2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01C5D2:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01C5DE
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01C5DE:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x01C5E4:
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		bpl.s	Offset_0x01C60E
		add.b	D0, Obj_Angle(A0)				 ; $0026
		bcs.s	Offset_0x01C5FA
		subq.b	#$01, Obj_Timer(A0)				 ; $002E
		andi.b	#$03, Obj_Timer(A0)				 ; $002E
Offset_0x01C5FA:
		move.w	#$0040, D2
		move.b	Obj_Angle(A0), D0				 ; $0026
		cmpi.b	#$80, D0
		bcc.s	Offset_0x01C630
		move.b	#$80, D0
		bra.s	Offset_0x01C630
;-------------------------------------------------------------------------------
Offset_0x01C60E:
		add.b	D0, Obj_Angle(A0)				 ; $0026
		bne.s	Offset_0x01C61E
		addq.b	#$01, Obj_Timer(A0)				 ; $002E
		andi.b	#$03, Obj_Timer(A0)				 ; $002E
Offset_0x01C61E:
		move.w	#$0040, D2
		move.b	Obj_Angle(A0), D0				 ; $0026
		cmpi.b	#$80, D0
		bcc.s	Offset_0x01C630
		move.b	#$80, D0
Offset_0x01C630:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D1
		move.b	Obj_Timer(A0), D3				 ; $002E
		andi.b	#$03, D3
		bne.s	Offset_0x01C656
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		neg.w	D2
		add.w	Obj_Control_Var_04(A0), D2				 ; $0034
		move.w	D2, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x01C656:
		subq.b	#$01, D3
		bne.s	Offset_0x01C66C
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		add.w	Obj_Control_Var_00(A0), D2				 ; $0030
		move.w	D2, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Offset_0x01C66C:
		subq.b	#$01, D3
		bne.s	Offset_0x01C684
		neg.w	D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		add.w	Obj_Control_Var_04(A0), D2				 ; $0034
		move.w	D2, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x01C684:
		neg.w	D1
		add.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	D1, Obj_Y(A0)					 ; $0014
		neg.w	D2
		add.w	Obj_Control_Var_00(A0), D2				 ; $0030
		move.w	D2, Obj_X(A0)					 ; $0010
		rts
;===============================================================================
; Objeto 0x67 - Plataformas na Hidrocity
; <<<-
;===============================================================================