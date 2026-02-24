;===============================================================================
; Objeto 0x63 - Botão usado na Desert Palace
; ->>>
;===============================================================================
; Offset_0x02C7E6:
		move.l	#DPz_Button_Mappings, Obj_Map(A0) ; Offset_0x02C894, $000C
		move.w	#$4280, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x02C812, (A0)
Offset_0x02C812:
		move.w	#$000C, D1
		move.w	#$0002, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		lea		(Palette_Row_2_Offset+$1C).w, A2			 ; $FFFFED5C
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		moveq	#$00, D3
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x02C854
		bclr	D3, (A3)
		move.l	#$002E000A, (A2)
		bra.s	Offset_0x02C88E
Offset_0x02C854:
		tst.b	(A3)
		bne.s	Offset_0x02C866
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.b	#$00, Obj_Ani_Time(A0)					 ; $0024
Offset_0x02C866:
		bset	D3, (A3)
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x02C88E
		move.b	#$03, Obj_Ani_Time(A0)					 ; $0024
		move.w	(A2), D0
		move.l	#$002E000A, (A2)
		cmpi.w	#$002E, D0
		bne.s	Offset_0x02C88E
		move.l	#$0C2E0A0E, (A2)
Offset_0x02C88E:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
DPz_Button_Mappings:						   ; Offset_0x02C894
		dc.w	Offset_0x02C898-DPz_Button_Mappings
		dc.w	Offset_0x02C8A0-DPz_Button_Mappings
Offset_0x02C898:
		dc.w	$0001
		dc.w	$FC08, $009C, $FFF4
Offset_0x02C8A0:
		dc.w	$0001
		dc.w	$FC08, $009F, $FFF4
;===============================================================================
; Objeto 0x63 - Botão usado na Desert Palace
; <<<-
;===============================================================================