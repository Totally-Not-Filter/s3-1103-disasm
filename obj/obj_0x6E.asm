;===============================================================================
; Objeto 0x6E - Quedas de água na Hydrocity
; ->>>
;===============================================================================
; Offset_0x02E0A8:
		move.l	#Waterfall_Mappings, Obj_Map(A0) ; Offset_0x02E1E8, $000C
		move.w	#$235C, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.b	#$08, Obj_Width_2(A0)					 ; $001F
		move.b	#$07, Obj_Height_2(A0)					 ; $001E
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x02E0E6, (A0)
Offset_0x02E0E6:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x02E122
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$02, D0
		move.w	D0, Obj_Control_Var_00(A0)				 ; $0030
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02E122
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02E122
		moveq	#$2C, D0
Offset_0x02E10A:
		move.w	(A0, D0),(A1, D0)
		subq.w	#$02, D0
		bcc.s	Offset_0x02E10A
		move.l	#Offset_0x02E128, (A1)
		move.b	#$C7, Obj_Col_Flags(A1)					 ; $0028
		moveq	#$00, D0
Offset_0x02E122:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02E128:
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x02E162
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x02E162
		add.w	D1, Obj_Y(A0)					 ; $0014
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0101, Obj_Ani_Number(A0)				 ; $0020
		move.l	#Offset_0x02E162, (A0)
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
Offset_0x02E162:
		lea		(Waterfall_Animate_Data).l, A1			 ; Offset_0x02E1D6
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		cmpi.b	#$04, Obj_Routine(A0)					 ; $0005
		bne.s	Offset_0x02E17C
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02E17C:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x02E1A2
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02E190
		bsr.s	Offset_0x02E1AE
Offset_0x02E190:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02E19E
		bsr.s	Offset_0x02E1AE
Offset_0x02E19E:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x02E1A2:
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02E1AE:
		cmpi.b	#$05, Obj_Ani_Number(A2)				 ; $0020
		bne.s	Offset_0x02E1BC
		move.b	#$00, Obj_Ani_Flag(A2)					 ; $0021
Offset_0x02E1BC:
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		move.l	#Offset_0x02E162, (A0)
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Waterfall_Animate_Data:						   ; Offset_0x02E1D6
		dc.w	Offset_0x02E1DA-Waterfall_Animate_Data
		dc.w	Offset_0x02E1E3-Waterfall_Animate_Data
Offset_0x02E1DA:
		dc.b	$04, $00, $01, $02, $02, $FC, $03, $FE
		dc.b	$01
Offset_0x02E1E3:
		dc.b	$04, $04, $05, $FC, $00
;-------------------------------------------------------------------------------
Waterfall_Mappings:							   ; Offset_0x02E1E8
		dc.w	Offset_0x02E1F6-Waterfall_Mappings
		dc.w	Offset_0x02E1FE-Waterfall_Mappings
		dc.w	Offset_0x02E206-Waterfall_Mappings
		dc.w	Offset_0x02E20E-Waterfall_Mappings
		dc.w	Offset_0x02E216-Waterfall_Mappings
		dc.w	Offset_0x02E21E-Waterfall_Mappings
		dc.w	Offset_0x02E226-Waterfall_Mappings
Offset_0x02E1F6:
		dc.w	$0001
		dc.w	$F804, $0000, $FFF8
Offset_0x02E1FE:
		dc.w	$0001
		dc.w	$F804, $0002, $FFF8
Offset_0x02E206:
		dc.w	$0001
		dc.w	$F801, $0004, $FFFC
Offset_0x02E20E:
		dc.w	$0001
		dc.w	$F801, $0006, $FFFC
Offset_0x02E216:
		dc.w	$0001
		dc.w	$0004, $0008, $FFF8
Offset_0x02E21E:
		dc.w	$0001
		dc.w	$0004, $000A, $FFF8
Offset_0x02E226:
		dc.w	$0001
		dc.w	$FC00, $FCA4, $FFFC
;===============================================================================
; Objeto 0x6E - Quedas de água na Hydrocity
; <<<-
;===============================================================================