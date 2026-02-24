;===============================================================================
; Objeto 0x61 - Balão na Balloon Park
; ->>>
;===============================================================================
; Offset_0x02C2C4:
		move.l	#BPz_Balloon_Mappings, Obj_Map(A0) ; Offset_0x02C3DE, $000C
		move.w	#$6300, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.b	#$D7, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02C2F6, (A0)
Offset_0x02C2F6:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.w	Offset_0x02C390
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02C30C
		bsr.s	Offset_0x02C322
Offset_0x02C30C:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02C31A
		bsr.s	Offset_0x02C322
Offset_0x02C31A:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		bra.w	Offset_0x02C390
Offset_0x02C322:
		move.w	Obj_X(A0), D1					 ; $0010
		move.w	Obj_Y(A0), D2					 ; $0014
		sub.w	Obj_X(A1), D1					 ; $0010
		sub.w	Obj_Y(A1), D2					 ; $0014
		jsr		(CalcAngle).l					 ; Offset_0x001DB8
		move.b	D0, D1
		subi.b	#$20, D1
		cmpi.b	#$40, D1
		bcc.s	Offset_0x02C352
		move.w	#$F700, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bra.s	Offset_0x02C372
Offset_0x02C352:
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$FB80, D1
		asr.l	#$08, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		muls.w	#$FB80, D0
		asr.l	#$08, D0
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
Offset_0x02C372:
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$04, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		moveq	#Small_Bumper_Sfx, D0					  ; -$75
		jmp		(Play_Music).l					 ; Offset_0x001176
Offset_0x02C390:
		lea		(BPz_Balloon_Animate_Data).l, A1		 ; Offset_0x02C3B8
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		cmpi.b	#$05, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x02C3B2
		cmpi.b	#$07, Obj_Map_Id(A0)					 ; $0022
		bcc.s	Offset_0x02C3B2
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x02C3B2:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
BPz_Balloon_Animate_Data:					   ; Offset_0x02C3B8
		dc.w	Offset_0x02C3C0-BPz_Balloon_Animate_Data
		dc.w	Offset_0x02C3D0-BPz_Balloon_Animate_Data
		dc.w	Offset_0x02C3D5-BPz_Balloon_Animate_Data
		dc.w	Offset_0x02C3D9-BPz_Balloon_Animate_Data
Offset_0x02C3C0:
		dc.b	$05, $00, $01, $02, $03, $04, $06, $05
		dc.b	$05, $05, $05, $05, $06, $05, $FE, $02
Offset_0x02C3D0:
		dc.b	$02, $07, $08, $FD, $03
Offset_0x02C3D5:
		dc.b	$02, $08, $FD, $03
Offset_0x02C3D9:
		dc.b	$1F, $09, $FD, $00, $00
;-------------------------------------------------------------------------------
BPz_Balloon_Mappings:						   ; Offset_0x02C3DE
		dc.w	Offset_0x02C3F2-BPz_Balloon_Mappings
		dc.w	Offset_0x02C400-BPz_Balloon_Mappings
		dc.w	Offset_0x02C40E-BPz_Balloon_Mappings
		dc.w	Offset_0x02C41C-BPz_Balloon_Mappings
		dc.w	Offset_0x02C42A-BPz_Balloon_Mappings
		dc.w	Offset_0x02C438-BPz_Balloon_Mappings
		dc.w	Offset_0x02C446-BPz_Balloon_Mappings
		dc.w	Offset_0x02C454-BPz_Balloon_Mappings
		dc.w	Offset_0x02C462-BPz_Balloon_Mappings
		dc.w	Offset_0x02C476-BPz_Balloon_Mappings
Offset_0x02C3F2:
		dc.w	$0002
		dc.w	$0800, $0013, $FFFC
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C400:
		dc.w	$0002
		dc.w	$0800, $0014, $FFFC
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C40E:
		dc.w	$0002
		dc.w	$0205, $0015, $FFF8
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C41C:
		dc.w	$0002
		dc.w	$0005, $0019, $FFF8
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C42A:
		dc.w	$0002
		dc.w	$F80A, $001D, $FFF4
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C438:
		dc.w	$0002
		dc.w	$F00F, $0026, $FFF0
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C446:
		dc.w	$0002
		dc.w	$F00F, $0036, $FFF0
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C454:
		dc.w	$0002
		dc.w	$F00F, $0046, $FFF0
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C462:
		dc.w	$0003
		dc.w	$F00B, $0056, $FFE8
		dc.w	$F00B, $0062, $0000
		dc.w	$0D00, $E012, $FFFC
Offset_0x02C476:
		dc.w	$0001
		dc.w	$0D00, $E012, $FFFC
;===============================================================================
; Objeto 0x61 - Balão na Balloon Park
; <<<-
;===============================================================================