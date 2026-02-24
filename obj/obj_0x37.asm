;===============================================================================
; Objeto 0x37 - Jato de água na Hydrocity
; ->>>
;===============================================================================
; Offset_0x025964:
		move.l	#Water_Stream_Mappings, Obj_Map(A0) ; Offset_0x025AB6, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$437A, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$40, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x0259E8
		move.l	#Offset_0x025A72, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0030, Obj_X(A1)				 ; $0010
		move.l	#Water_Stream_Block_Mappings, Obj_Map(A1) ; Offset_0x025C16, $000C
		move.w	#$43D4, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$20, Obj_Height(A1)					 ; $0006
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x0259E8:
		move.b	#$03, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		move.l	#Offset_0x0259F4, (A0)
Offset_0x0259F4:
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.s	Offset_0x025A18
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		move.l	#Offset_0x025A1E, (A0)
		move.b	#$00, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		move.b	#$01, (Palette_Cycle_Counters).w			 ; $FFFFF650
Offset_0x025A18:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x025A1E:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x025A5E
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x025A58
		addi.w	#$0020, Obj_X(A0)				 ; $0010
		cmpi.w	#$0580, Obj_X(A0)				 ; $0010
		bne.s	Offset_0x025A58
		cmpi.w	#$05A0, Obj_Y(A0)				 ; $0014
		bne.s	Offset_0x025A58
		subi.w	#$0020, Obj_X(A0)				 ; $0010
		subi.w	#$0020, Obj_Y(A0)				 ; $0014
Offset_0x025A58:
		andi.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x025A5E:
		cmpi.w	#$0980, Obj_X(A0)				 ; $0010
		bcs.s	Offset_0x025A6C
		move.w	#$7F00, Obj_X(A0)				 ; $0010
Offset_0x025A6C:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x025A72:
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.s	Offset_0x025A92
		move.l	#Offset_0x025A7E, (A0)
Offset_0x025A7E:
		subi.w	#$0010, Obj_Y(A0)				 ; $0014
		cmpi.w	#$0560, Obj_Y(A0)				 ; $0014
		bne.s	Offset_0x025A92
		move.w	#$7F00, Obj_X(A0)				 ; $0010
Offset_0x025A92:
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
Water_Stream_Mappings:						   ; Offset_0x025AB6
		dc.w	Offset_0x025B2E-Water_Stream_Mappings
		dc.w	Offset_0x025BA2-Water_Stream_Mappings
		dc.w	Offset_0x025ABE-Water_Stream_Mappings
		dc.w	Offset_0x025AF0-Water_Stream_Mappings
Offset_0x025ABE:
		dc.w	$0008
		dc.w	$E007, $0020, $FFE0
		dc.w	$E00F, $0018, $FFF0
		dc.w	$E00F, $0018, $0010
		dc.w	$E00F, $0018, $0030
		dc.w	$000F, $0030, $FFE0
		dc.w	$000F, $0030, $0000
		dc.w	$000F, $0030, $0020
		dc.w	$0007, $0030, $0040
Offset_0x025AF0:
		dc.w	$000A
		dc.w	$E007, $0020, $FFE0
		dc.w	$E00F, $0018, $FFF0
		dc.w	$E00F, $0018, $0010
		dc.w	$E00F, $0018, $0030
		dc.w	$000F, $0000, $FFC0
		dc.w	$0007, $0048, $FFE0
		dc.w	$0007, $0038, $FFF0
		dc.w	$000F, $0030, $0000
		dc.w	$000F, $0030, $0020
		dc.w	$0007, $0030, $0040
Offset_0x025B2E:
		dc.w	$0013
		dc.w	$E00F, $0000, $FFC0
		dc.w	$E007, $0010, $FFE0
		dc.w	$E00F, $0018, $FFF0
		dc.w	$E00F, $0018, $0010
		dc.w	$E00F, $0018, $0030
		dc.w	$E00F, $0018, $0050
		dc.w	$E007, $0018, $0070
		dc.w	$000F, $0000, $FFD0
		dc.w	$0007, $0028, $FFF0
		dc.w	$000F, $0030, $0000
		dc.w	$000F, $0030, $0020
		dc.w	$000F, $0030, $0040
		dc.w	$000F, $0030, $0060
		dc.w	$200F, $0000, $FFE0
		dc.w	$2007, $0028, $0000
		dc.w	$200F, $0030, $0010
		dc.w	$200F, $0030, $0030
		dc.w	$200F, $0030, $0050
		dc.w	$2007, $0030, $0070
Offset_0x025BA2:
		dc.w	$0013
		dc.w	$E00F, $0000, $FFD0
		dc.w	$E007, $0040, $FFF0
		dc.w	$E007, $0020, $0000
		dc.w	$E00F, $0018, $0010
		dc.w	$E00F, $0018, $0030
		dc.w	$E00F, $0018, $0050
		dc.w	$E007, $0018, $0070
		dc.w	$000F, $0000, $FFE0
		dc.w	$0007, $0048, $0000
		dc.w	$0007, $0038, $0010
		dc.w	$000F, $0030, $0020
		dc.w	$000F, $0030, $0040
		dc.w	$000F, $0030, $0060
		dc.w	$200F, $0000, $FFF0
		dc.w	$2007, $0048, $0010
		dc.w	$2007, $0038, $0020
		dc.w	$200F, $0030, $0030
		dc.w	$200F, $0030, $0050
		dc.w	$2007, $0030, $0070
;-------------------------------------------------------------------------------
Water_Stream_Block_Mappings:				   ; Offset_0x025C16
		dc.w	Offset_0x025C1A-Water_Stream_Block_Mappings
		dc.w	Offset_0x025C22-Water_Stream_Block_Mappings
Offset_0x025C1A:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x025C22:
		dc.w	$0002
		dc.w	$E00F, $0000, $FFF0
		dc.w	$000F, $0000, $FFF0
;===============================================================================
; Objeto 0x37 - Jato de água na Hydrocity
; <<<-
;===============================================================================