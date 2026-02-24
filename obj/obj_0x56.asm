;===============================================================================
; Objeto 0x56 - Plataforma móvel com espinhos nas laterais na Marble Garden.
; ->>>
;===============================================================================
; Offset_0x02AA8A:
		move.l	#Moving_Spike_Platform_Mappings, Obj_Map(A0) ; Offset_0x02ABA8, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$30, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02AACA
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x02AACA:
		move.l	#Offset_0x02AAD0, (A0)
Offset_0x02AAD0:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x02AAF4
		addq.w	#$01, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		addi.w	#$0050, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bne.s	Offset_0x02AB0C
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x02AB0C
Offset_0x02AAF4:
		subq.w	#$01, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		subi.w	#$0050, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bne.s	Offset_0x02AB0C
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x02AB0C:
		moveq	#$00, D0
		move.b	(Oscillate_Data_Buffer+$12).w, D0			 ; $FFFFFE70
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A0)					 ; $0014
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	(A7)+, D4
		jsr		(Solid_Object).l				   ; Offset_0x013556
		swap	D6
		andi.w	#$0003, D6
		beq.s	Offset_0x02AB88
		move.b	D6, D0
		andi.b	#$01, D0
		beq.s	Offset_0x02AB64
		bclr	#$05, Obj_Status(A0)					 ; $002A
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0028, D0
		bmi.s	Offset_0x02AB64
		jsr		(Hurt_Player_A1).l			   ; Offset_0x01A71C
Offset_0x02AB64:
		andi.b	#$02, D6
		beq.s	Offset_0x02AB88
		bclr	#$06, Obj_Status(A0)					 ; $002A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Y(A1), D0					 ; $0014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0028, D0
		bmi.s	Offset_0x02AB88
		jsr		(Hurt_Player_A1).l			   ; Offset_0x01A71C
Offset_0x02AB88:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x02AB9E
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x02AB9E:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Moving_Spike_Platform_Mappings:				   ; Offset_0x02ABA8
		dc.w	Offset_0x02ABB0-Moving_Spike_Platform_Mappings
		dc.w	Offset_0x02ABFA-Moving_Spike_Platform_Mappings
		dc.w	Offset_0x02AC44-Moving_Spike_Platform_Mappings
		dc.w	Offset_0x02AC8E-Moving_Spike_Platform_Mappings
Offset_0x02ABB0:
		dc.w	$000C
		dc.w	$CC09, $0076, $FFE8
		dc.w	$CC09, $0876, $0000
		dc.w	$DC0D, $0404, $FFE0
		dc.w	$DC0D, $0C04, $0000
		dc.w	$EC0D, $040C, $FFE0
		dc.w	$EC0D, $0414, $0000
		dc.w	$FC0D, $041C, $FFE0
		dc.w	$FC0D, $0C1C, $0000
		dc.w	$0C0D, $0C14, $FFE0
		dc.w	$0C0D, $0C0C, $0000
		dc.w	$1C0D, $0404, $FFE0
		dc.w	$1C0D, $0C04, $0000
Offset_0x02ABFA:
		dc.w	$000C
		dc.w	$CC09, $0076, $FFE8
		dc.w	$CC09, $0876, $0000
		dc.w	$DC0D, $040C, $FFE0
		dc.w	$DC0D, $0414, $0000
		dc.w	$EC0D, $041C, $FFE0
		dc.w	$EC0D, $0C1C, $0000
		dc.w	$FC0D, $0C14, $FFE0
		dc.w	$FC0D, $0C0C, $0000
		dc.w	$0C0D, $0404, $FFE0
		dc.w	$0C0D, $0C04, $0000
		dc.w	$1C0D, $040C, $FFE0
		dc.w	$1C0D, $0414, $0000
Offset_0x02AC44:
		dc.w	$000C
		dc.w	$CC09, $0076, $FFE8
		dc.w	$CC09, $0876, $0000
		dc.w	$DC0D, $041C, $FFE0
		dc.w	$DC0D, $0C1C, $0000
		dc.w	$EC0D, $0C14, $FFE0
		dc.w	$EC0D, $0C0C, $0000
		dc.w	$FC0D, $0404, $FFE0
		dc.w	$FC0D, $0C04, $0000
		dc.w	$0C0D, $040C, $FFE0
		dc.w	$0C0D, $0414, $0000
		dc.w	$1C0D, $041C, $FFE0
		dc.w	$1C0D, $0C1C, $0000
Offset_0x02AC8E:
		dc.w	$000C
		dc.w	$CC09, $0076, $FFE8
		dc.w	$CC09, $0876, $0000
		dc.w	$DC0D, $0C14, $FFE0
		dc.w	$DC0D, $0C0C, $0000
		dc.w	$EC0D, $0404, $FFE0
		dc.w	$EC0D, $0C04, $0000
		dc.w	$FC0D, $040C, $FFE0
		dc.w	$FC0D, $0414, $0000
		dc.w	$0C0D, $041C, $FFE0
		dc.w	$0C0D, $0C1C, $0000
		dc.w	$1C0D, $0C14, $FFE0
		dc.w	$1C0D, $0C0C, $0000
;===============================================================================
; Objeto 0x56 - Plataforma móvel com espinhos nas laterais na Marble Garden.
; <<<-
;===============================================================================