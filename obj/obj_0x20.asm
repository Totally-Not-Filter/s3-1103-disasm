;===============================================================================
; Objeto 0x20 - Pilar esmagador na Marble Garden / Espinho esmagador na
; Objeto 0x52	Launch Base
; ->>>
;===============================================================================
; Offset_0x01FDB6:
		move.l	#Smashing_Spike_Mappins, Obj_Map(A0) ; Offset_0x01FED8, $000C
		move.w	#$4455, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		cmpi.b	#MGz_Id, (Current_Zone).w			; $02, $FFFFFE10
		bne.s	Offset_0x01FDFE
		move.l	#Smashing_Pillar_Mappings, Obj_Map(A0) ; Offset_0x01FEE8, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$28, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
Offset_0x01FDFE:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.l	#Offset_0x01FE1C, (A0)
Offset_0x01FE1C:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		bne.s	Offset_0x01FE68
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		addi.w	#$0080, Obj_Speed_Y(A0)					 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
		cmp.w	Obj_Control_Var_08(A0), D2				 ; $0038
		bcs.s	Offset_0x01FE7C
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_Control_Var_08(A0), Obj_Control_Var_04(A0) ; $0038, $0034
		move.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01FE7C
		moveq	#Crash_Sfx, D0					   ; $6C
		cmpi.b	#MGz_Id, (Current_Zone).w			; $02, $FFFFFE10
		beq.s	Offset_0x01FE60
		moveq	#Slide_Thunk_Sfx, D0					  ; -$50
Offset_0x01FE60:
		jsr		(PlaySound).l					; Offset_0x001176
		bra.s	Offset_0x01FE7C
Offset_0x01FE68:
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
		beq.s	Offset_0x01FE76
		subq.w	#$01, D2
		move.w	D2, Obj_Control_Var_04(A0)				 ; $0034
		bra.s	Offset_0x01FE7C
Offset_0x01FE76:
		move.b	#$00, Obj_Control_Var_02(A0)			 ; $0032
Offset_0x01FE7C:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		move.w	D0, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		swap	D6
		andi.w	#$000C, D6
		bne.s	Offset_0x01FEB4
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01FEB4:
		move.b	D6, D0
		andi.b	#$04, D0
		beq.s	Offset_0x01FEC4
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x01FEC4:
		andi.b	#$08, D6
		beq.s	Offset_0x01FED2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x01FED2:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Smashing_Spike_Mappins:						   ; Offset_0x01FED8
		dc.w	Offset_0x01FEDA-Smashing_Spike_Mappins
Offset_0x01FEDA:
		dc.w	$0002
		dc.w	$F007, $002F, $FFFC
		dc.w	$F003, $002F, $FFF4
;-------------------------------------------------------------------------------
Smashing_Pillar_Mappings:					   ; Offset_0x01FEE8
		dc.w	Offset_0x01FEEA-Smashing_Pillar_Mappings
Offset_0x01FEEA:
		dc.w	$000A
		dc.w	$D80E, $2038, $FFE0
		dc.w	$D80E, $2838, $0000
		dc.w	$F00C, $0044, $FFE0
		dc.w	$F00C, $0844, $0000
		dc.w	$F80E, $2038, $FFE0
		dc.w	$F80E, $2838, $0000
		dc.w	$100C, $0044, $FFE0
		dc.w	$100C, $0844, $0000
		dc.w	$1809, $C048, $FFE8
		dc.w	$1809, $C848, $0000
;===============================================================================
; Objeto 0x20 - Pilar esmagador na Marble Garden / Espinho esmagador na
; Objeto 0x52	Launch Base
; <<<-
;===============================================================================