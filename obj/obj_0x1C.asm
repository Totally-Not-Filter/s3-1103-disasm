;===============================================================================
; Objeto 0x1C - Objeto desconhecido na Launch Base
; ->>>
;===============================================================================
; Offset_0x01E6C6:
		move.l	#LBz_Unknow_Mappings, Obj_Map(A0) ; Offset_0x01E7C2, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.l	#Offset_0x01E6F8, (A0)
Offset_0x01E6F8:
		tst.b	Obj_Timer(A0)					 ; $002E
		beq.s	Offset_0x01E72E
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		addq.w	#$02, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x01E72E
		move.w	Obj_Control_Var_00(A0), Obj_Y(A0)		  ; $0030, $0014
		clr.w	Obj_Sub_Y(A0)					 ; $0016
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		clr.b	Obj_Timer(A0)					 ; $002E
Offset_0x01E72E:
		move.w	#$001B, D1
		move.w	#$0010, D2
		move.w	#$0011, D3
		move.w	Obj_X(A0), D4					 ; $0010
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		movem.l D1-D4, -(A7)
		jsr		(Solid_Object_2_A1).l			   ; Offset_0x0135CC
		cmpi.w	#$FFFE, D4
		bne.s	Offset_0x01E756
		bsr.s	Offset_0x01E7A8
Offset_0x01E756:
		movem.l (A7)+, D1-D4
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		jsr		(Solid_Object_2_A1).l			   ; Offset_0x0135CC
		cmpi.w	#$FFFE, D4
		bne.s	Offset_0x01E76E
		bsr.s	Offset_0x01E7A8
Offset_0x01E76E:
		move.b	Obj_Status(A0), D6				 ; $002A
		andi.b	#$18, D6
		beq.s	Offset_0x01E796
		move.b	D6, D0
		andi.b	#$08, D0
		beq.s	Offset_0x01E788
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x01E788:
		andi.b	#$10, D6
		beq.s	Offset_0x01E796
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x01E796:
		lea		(LBz_Unknow_Animate_Data).l, A1			 ; Offset_0x01E7B6
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01E7A8:
		move.w	#$FFC0, Obj_Speed_Y(A0)					 ; $001A
		move.b	#$01, Obj_Timer(A0)				 ; $002E
		rts
;-------------------------------------------------------------------------------
LBz_Unknow_Animate_Data:					   ; Offset_0x01E7B6
		dc.w	Offset_0x01E7B8-LBz_Unknow_Animate_Data
Offset_0x01E7B8:
		dc.b	$0B, $00, $01, $02, $01, $00, $03, $04
		dc.b	$03, $FF
;-------------------------------------------------------------------------------
LBz_Unknow_Mappings:						   ; Offset_0x01E7C2
		dc.w	Offset_0x01E7CC-LBz_Unknow_Mappings
		dc.w	Offset_0x01E7E6-LBz_Unknow_Mappings
		dc.w	Offset_0x01E800-LBz_Unknow_Mappings
		dc.w	Offset_0x01E820-LBz_Unknow_Mappings
		dc.w	Offset_0x01E83A-LBz_Unknow_Mappings
Offset_0x01E7CC:
		dc.w	$0004
		dc.w	$E807, $0010, $FFF0
		dc.w	$E807, $0810, $0000
		dc.w	$0804, $0018, $FFF0
		dc.w	$0804, $0818, $0000
Offset_0x01E7E6:
		dc.w	$0004
		dc.w	$F006, $001A, $FFF0
		dc.w	$E807, $0020, $0000
		dc.w	$0804, $0018, $FFF0
		dc.w	$0804, $0818, $0000
Offset_0x01E800:
		dc.w	$0005
		dc.w	$E804, $0028, $0008
		dc.w	$F006, $002A, $FFF0
		dc.w	$0804, $0018, $FFF0
		dc.w	$F007, $0030, $0000
		dc.w	$F000, $0038, $0010
Offset_0x01E820:
		dc.w	$0004
		dc.w	$F006, $081A, $0000
		dc.w	$E807, $0820, $FFF0
		dc.w	$0804, $0818, $0000
		dc.w	$0804, $0018, $FFF0
Offset_0x01E83A:
		dc.w	$0005
		dc.w	$E804, $0828, $FFE8
		dc.w	$F006, $082A, $0000
		dc.w	$0804, $0818, $0000
		dc.w	$F007, $0830, $FFF0
		dc.w	$F000, $0838, $FFE8
;===============================================================================
; Objeto 0x1C - Objeto desconhecido na Launch Base
; <<<-
;===============================================================================