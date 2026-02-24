;===============================================================================
; Objeto 0x44 - Porta armadilha na Carnival Night
; ->>>
;===============================================================================
; Offset_0x027F0E:
		move.l	#Trapdoor_Mappings, Obj_Map(A0) ; Offset_0x027FAA, $000C
		move.w	#$43F0, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x027F3A, (A0)
Offset_0x027F3A:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x027F6A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x027F6A
		move.w	#$0020, D1
		move.w	#$0009, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		lea		(Trapdoor_Animate_Data).l, A1			 ; Offset_0x027F9E
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x027F6A:
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		addi.w	#$0020, D0
		cmpi.w	#$0040, D0
		bcc.s	Offset_0x027F9C
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	Obj_Y(A1), D0					 ; $0014
		addi.w	#$0020, D0
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x027F9C
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Trapdoor_Sfx, D0				  ; -$7B
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x027F9C:
		rts
;-------------------------------------------------------------------------------
Trapdoor_Animate_Data:						   ; Offset_0x027F9E
		dc.w	Offset_0x027FA2-Trapdoor_Animate_Data
		dc.w	Offset_0x027FA5-Trapdoor_Animate_Data
Offset_0x027FA2:
		dc.b	$7F, $00, $FF
Offset_0x027FA5:
		dc.b	$05, $01, $02, $FD, $00
;-------------------------------------------------------------------------------
Trapdoor_Mappings:							   ; Offset_0x027FAA
		dc.w	Offset_0x027FB0-Trapdoor_Mappings
		dc.w	Offset_0x027FBE-Trapdoor_Mappings
		dc.w	Offset_0x027FCC-Trapdoor_Mappings
Offset_0x027FB0:
		dc.w	$0002
		dc.w	$F60C, $0000, $FFE0
		dc.w	$F60C, $0800, $0000
Offset_0x027FBE:
		dc.w	$0002
		dc.w	$EE0D, $0004, $FFE0
		dc.w	$EE0D, $0804, $0000
Offset_0x027FCC:
		dc.w	$0002
		dc.w	$EE0D, $000C, $FFE0
		dc.w	$EE0D, $080C, $0000
;===============================================================================
; Objeto 0x44 - Porta armadilha na Carnival Night
; <<<-
;===============================================================================