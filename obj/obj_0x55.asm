;===============================================================================
; Objeto 0x55 - Cabeça atiradora de flechas na Marble Garden após ser tocada.
; ->>>
;===============================================================================
; Offset_0x02A5BC:
		move.l	#Head_Trigger_Mappings, Obj_Map(A0) ; Offset_0x02A822, $000C
		move.w	#$A3FF, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$38, Obj_Height(A0)					 ; $0006
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		move.b	#$17, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$03, Obj_Col_Prop(A0)					 ; $0029
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0006, (A2)+
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02A61E
		move.w	#$00C0, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x02A61E:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x02A642
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
Offset_0x02A642:
		move.l	#Offset_0x02A648, (A0)
Offset_0x02A648:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.w	Offset_0x02A7CC
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		cmpi.w	#$00C0, D0
		bcc.s	Offset_0x02A680
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		sub.w	Obj_Y(A0), D0					 ; $0014
		addi.w	#$0080, D0
		cmpi.w	#$00C0, D0
		bcc.s	Offset_0x02A680
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x02A680
		move.w	#$0100, Obj_Ani_Number(A0)				 ; $0020
Offset_0x02A680:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.w	Offset_0x02A736
		tst.w	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x02A6A0
		subq.w	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bne.w	Offset_0x02A736
		move.b	#$17, Obj_Col_Flags(A0)					 ; $0028
		bra.w	Offset_0x02A736
Offset_0x02A6A0:
		move.w	#$003C, Obj_Control_Var_02(A0)			 ; $0032
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02A72E
		move.l	#Offset_0x02A7F0, (A1)
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		bne.s	Offset_0x02A6EC
		move.l	#Obj_Explosion, (A1)			  ; Offset_0x013D7C
		move.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		move.b	#$01,(A3, D0)
Offset_0x02A6EC:
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		andi.b	#$BF, Obj_Flags(A1)				 ; $0004
		move.b	Obj_Status(A0), Obj_Status(A1)			  ; $002A, $002A
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.b	#$08, Obj_Width(A1)				 ; $0007
		move.b	#$08, Obj_Height(A1)					 ; $0006
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
Offset_0x02A72E:
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02A736:
		lea		(Head_Trigger_Animate_Data).l, A1		 ; Offset_0x02A802
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.w	Offset_0x02A7CC
		clr.b	Obj_Routine(A0)					 ; $0005
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02A7CC
		move.l	#Offset_0x02A7D2, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0010, Obj_X(A1)				 ; $0010
		addi.w	#$0020, Obj_Y(A1)				 ; $0014
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		andi.b	#$BF, Obj_Flags(A1)				 ; $0004
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		move.w	#$0300, Obj_Priority(A1)				 ; $0008
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$04, Obj_Height(A1)					 ; $0006
		move.b	#$9B, Obj_Col_Flags(A1)					 ; $0028
		move.w	#$FC00, Obj_Speed_X(A1)					 ; $0018
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02A7C4
		neg.w	Obj_Speed_X(A1)					 ; $0018
		subi.w	#$0020, Obj_X(A1)				 ; $0010
Offset_0x02A7C4:
		moveq	#Level_Projectile_Sfx, D0				   ; $75
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x02A7CC:
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
Offset_0x02A7D2:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02A7EA
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02A7EA:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x02A7F0:
		lea		(Head_Trigger_Animate_Data).l, A1		 ; Offset_0x02A802
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Head_Trigger_Animate_Data:					   ; Offset_0x02A802
		dc.w	Offset_0x02A808-Head_Trigger_Animate_Data
		dc.w	Offset_0x02A80B-Head_Trigger_Animate_Data
		dc.w	Offset_0x02A819-Head_Trigger_Animate_Data
Offset_0x02A808:
		dc.b	$7F, $02, $FF
Offset_0x02A80B:
		dc.b	$07, $03, $04, $03, $02, $02, $02, $01
		dc.b	$FC, $01, $01, $01, $FD, $00
Offset_0x02A819:
		dc.b	$01, $05, $07, $05, $07, $05, $07, $FB
		dc.b	$00
;-------------------------------------------------------------------------------
Head_Trigger_Mappings:						   ; Offset_0x02A822
		dc.w	Offset_0x02A832-Head_Trigger_Mappings
		dc.w	Offset_0x02A83A-Head_Trigger_Mappings
		dc.w	Offset_0x02A842-Head_Trigger_Mappings
		dc.w	Offset_0x02A84A-Head_Trigger_Mappings
		dc.w	Offset_0x02A852-Head_Trigger_Mappings
		dc.w	Offset_0x02A85A-Head_Trigger_Mappings
		dc.w	Offset_0x02A862-Head_Trigger_Mappings
		dc.w	Offset_0x02A876-Head_Trigger_Mappings
Offset_0x02A832:
		dc.w	$0001
		dc.w	$FC0C, $E04E, $FFF0
Offset_0x02A83A:
		dc.w	$0001
		dc.w	$F801, $0044, $FFF8
Offset_0x02A842:
		dc.w	$0001
		dc.w	$F801, $0046, $FFF8
Offset_0x02A84A:
		dc.w	$0001
		dc.w	$F801, $0048, $FFF8
Offset_0x02A852:
		dc.w	$0001
		dc.w	$F801, $004A, $FFF8
Offset_0x02A85A:
		dc.w	$0001
		dc.w	$F801, $004C, $FFF8
Offset_0x02A862:
		dc.w	$0003
		dc.w	$E809, $2026, $FFF8
		dc.w	$F80B, $002C, $FFF8
		dc.w	$180B, $0038, $FFF8
Offset_0x02A876:
		dc.w	$0000
;===============================================================================
; Objeto 0x55 - Cabeça atiradora de flechas na Marble Garden após ser tocada.
; <<<-
;===============================================================================