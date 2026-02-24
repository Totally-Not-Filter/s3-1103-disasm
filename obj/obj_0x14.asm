;===============================================================================
; Objeto 0x14 - Ponte que muda de posição baseado no objeto 0x13 na Launch Base
; ->>>
;===============================================================================
Offset_0x01CB62:
		dc.b	$48, $00, $08, $40, $00, $00, $0A, $08
		dc.b	$00, $48, $40, $08, $00, $08, $0A, $10
		dc.b	$B8, $00, $08, $40, $00, $00, $0A, $08
		dc.b	$00, $48, $40, $08, $00, $10, $0A, $18
		dc.b	$00, $48, $40, $08, $06, $08, $04, $10
		dc.b	$48, $00, $08, $40, $06, $00, $04, $08
		dc.b	$00, $48, $40, $08, $06, $10, $04, $18
		dc.b	$B8, $00, $08, $40, $06, $00, $04, $08
;-------------------------------------------------------------------------------
Obj_0x14_LBz_Trigger_Bridge:				   ; Offset_0x01CBA2
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.w	#$000F, D1
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x01CBBE
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x01CBBE
		addq.w	#$04, D0
Offset_0x01CBBE:
		lsr.b	#$01, D0
		andi.w	#$0038, D0
		lea		Offset_0x01CB62(PC, D0), A1
		move.l	#Trigger_Bridge_Mappings, Obj_Map(A0) ; Offset_0x01CD64, $000C
		move.w	#$43C3, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	(A1)+, D0
		ext.w	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		move.b	(A1)+, D0
		ext.w	D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.b	(A1)+, Obj_Width(A0)					 ; $0007
		move.b	(A1)+, Obj_Height(A0)					 ; $0006
		moveq	#$00, D0
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x01CC30
		move.b	(A1)+, D0
		move.w	D0, Obj_Control_Var_06(A0)				 ; $0036
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x01CC30:
		move.l	#Offset_0x01CC36, (A0)
Offset_0x01CC36:
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	Offset_0x01CC70(PC, D0), D1
		jsr		Offset_0x01CC70(PC, D1)
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01CC66
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object_2).l			   ; Offset_0x0135B6
Offset_0x01CC66:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Offset_0x01CC70:
		dc.w	Offset_0x01CC7C-Offset_0x01CC70
		dc.w	Offset_0x01CCD6-Offset_0x01CC70
		dc.w	Offset_0x01CCE8-Offset_0x01CC70
		dc.w	Offset_0x01CD0A-Offset_0x01CC70
		dc.w	Offset_0x01CCD6-Offset_0x01CC70
		dc.w	Offset_0x01CCF8-Offset_0x01CC70
;-------------------------------------------------------------------------------
Offset_0x01CC7C:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		beq.s	Offset_0x01CCD4
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0007, Obj_Control_Var_08(A0)			 ; $0038
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01CCD4
		move.l	#Obj_0x14_LBz_Trigger_Bridge, (A1)	   ; Offset_0x01CBA2
		move.w	Obj_Control_Var_00(A0), Obj_X(A1)		  ; $0030, $0010
		move.w	Obj_Control_Var_02(A0), Obj_Y(A1)		  ; $0032, $0014
		move.b	Obj_Subtype(A0), D0				 ; $002C
		addi.b	#$40, D0
		andi.b	#$7F, D0
		move.b	D0, Obj_Subtype(A1)				 ; $002C
		move.w	#$0008, Obj_Control_Var_08(A1)			 ; $0038
		move.b	#$01, Obj_Control_Var_04(A1)			 ; $0034
Offset_0x01CCD4:
		rts
;-------------------------------------------------------------------------------
Offset_0x01CCD6:
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x01CCE6
		move.w	#$7FFF, Obj_X(A0)				 ; $0010
Offset_0x01CCE6:
		rts
;-------------------------------------------------------------------------------
Offset_0x01CCE8:
		subq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x01CCF6
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01CCF6:
		rts
;-------------------------------------------------------------------------------
Offset_0x01CCF8:
		subq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x01CD08
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01CD08:
		rts
;-------------------------------------------------------------------------------
Offset_0x01CD0A:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		tst.b	(A3, D0)
		bne.s	Offset_0x01CD62
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0007, Obj_Control_Var_08(A0)			 ; $0038
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01CD62
		move.l	#Obj_0x14_LBz_Trigger_Bridge, (A1)	   ; Offset_0x01CBA2
		move.w	Obj_Control_Var_00(A0), Obj_X(A1)		  ; $0030, $0010
		move.w	Obj_Control_Var_02(A0), Obj_Y(A1)		  ; $0032, $0014
		move.b	Obj_Subtype(A0), D0				 ; $002C
		addi.b	#$40, D0
		andi.b	#$7F, D0
		move.b	D0, Obj_Subtype(A1)				 ; $002C
		move.w	#$0008, Obj_Control_Var_08(A1)			 ; $0038
		move.b	#$01, Obj_Control_Var_04(A1)			 ; $0034
Offset_0x01CD62:
		rts
;-------------------------------------------------------------------------------
Trigger_Bridge_Mappings:					   ; Offset_0x01CD64
		dc.w	Offset_0x01CD94-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CDC6-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CDF2-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE18-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE38-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE52-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE66-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE74-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CE7C-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CEAE-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CEDA-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF00-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF20-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF3A-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF4E-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF5C-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF64-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CF96-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CFC2-Trigger_Bridge_Mappings
		dc.w	Offset_0x01CFE8-Trigger_Bridge_Mappings
		dc.w	Offset_0x01D008-Trigger_Bridge_Mappings
		dc.w	Offset_0x01D022-Trigger_Bridge_Mappings
		dc.w	Offset_0x01D036-Trigger_Bridge_Mappings
		dc.w	Offset_0x01D044-Trigger_Bridge_Mappings
Offset_0x01CD94:
		dc.w	$0008
		dc.w	$C005, $0010, $FFF8
		dc.w	$D005, $0010, $FFF8
		dc.w	$E005, $0010, $FFF8
		dc.w	$F005, $0010, $FFF8
		dc.w	$0005, $0010, $FFF8
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CDC6:
		dc.w	$0007
		dc.w	$D005, $0010, $FFF8
		dc.w	$E005, $0010, $FFF8
		dc.w	$F005, $0010, $FFF8
		dc.w	$0005, $0010, $FFF8
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CDF2:
		dc.w	$0006
		dc.w	$E005, $0010, $FFF8
		dc.w	$F005, $0010, $FFF8
		dc.w	$0005, $0010, $FFF8
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE18:
		dc.w	$0005
		dc.w	$F005, $0010, $FFF8
		dc.w	$0005, $0010, $FFF8
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE38:
		dc.w	$0004
		dc.w	$0005, $0010, $FFF8
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE52:
		dc.w	$0003
		dc.w	$1005, $0010, $FFF8
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE66:
		dc.w	$0002
		dc.w	$2005, $0010, $FFF8
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE74:
		dc.w	$0001
		dc.w	$3005, $0010, $FFF8
Offset_0x01CE7C:
		dc.w	$0008
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CEAE:
		dc.w	$0007
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CEDA:
		dc.w	$0006
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF00:
		dc.w	$0005
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF20:
		dc.w	$0004
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF3A:
		dc.w	$0003
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF4E:
		dc.w	$0002
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF5C:
		dc.w	$0001
		dc.w	$F805, $0010, $0030
Offset_0x01CF64:
		dc.w	$0008
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
		dc.w	$F805, $0010, $0030
Offset_0x01CF96:
		dc.w	$0007
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
		dc.w	$F805, $0010, $0020
Offset_0x01CFC2:
		dc.w	$0006
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
		dc.w	$F805, $0010, $0010
Offset_0x01CFE8:
		dc.w	$0005
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
		dc.w	$F805, $0010, $0000
Offset_0x01D008:
		dc.w	$0004
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
		dc.w	$F805, $0010, $FFF0
Offset_0x01D022:
		dc.w	$0003
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
		dc.w	$F805, $0010, $FFE0
Offset_0x01D036:
		dc.w	$0002
		dc.w	$F805, $0010, $FFC0
		dc.w	$F805, $0010, $FFD0
Offset_0x01D044:
		dc.w	$0001
		dc.w	$F805, $0010, $FFC0
;===============================================================================
; Objeto 0x14 - Ponte que muda de posição baseado no objeto 0x13 na Launch Base
; <<<-
;===============================================================================