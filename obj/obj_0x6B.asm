;-------------------------------------------------------------------------------
; Objeto 0x6B - Espinhos na vertical na Hydrocity
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x014CE8:
		move.l	#Invisible_Block_Mappings, Obj_Map(A0) ; Offset_0x014352, $000C
		move.w	#$86BC, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.w	#$00F0, D0
		addi.w	#$0010, D0
		lsr.w	#$01, D0
		move.b	D0, Obj_Width(A0)				 ; $0007
		andi.w	#$000F, D1
		addq.w	#$01, D1
		lsl.w	#$03, D1
		move.b	D1, Obj_Height(A0)				 ; $0006
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x014D32
		move.l	#Offset_0x014DAE, (A0)
		rts
Offset_0x014D32:
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x014D42
		move.l	#Offset_0x014E12, (A0)
		rts
Offset_0x014D42:
		move.l	#Offset_0x014D48, (A0)
;-------------------------------------------------------------------------------
Offset_0x014D48:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Solid_Object_2				   ; Offset_0x0135B6
		move.b	Obj_Status(A0), D6				 ; $002A
		andi.b	#$18, D6
		beq.s	Offset_0x014D8C
		move.b	D6, D0
		andi.b	#$08, D0
		beq.s	Offset_0x014D7E
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x014E76
Offset_0x014D7E:
		andi.b	#$10, D6
		beq.s	Offset_0x014D8C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x014E76
Offset_0x014D8C:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014DAC
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014DAC:
		rts
;-------------------------------------------------------------------------------
Offset_0x014DAE:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Solid_Object_2				   ; Offset_0x0135B6
		swap	D6
		andi.w	#$0003, D6
		beq.s	Offset_0x014DF0
		move.b	D6, D0
		andi.b	#$01, D0
		beq.s	Offset_0x014DE2
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x014E76
Offset_0x014DE2:
		andi.b	#$02, D6
		beq.s	Offset_0x014DF0
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x014E76
Offset_0x014DF0:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014E10
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014E10:
		rts
;-------------------------------------------------------------------------------
Offset_0x014E12:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		bsr.w	Solid_Object_2				   ; Offset_0x0135B6
		swap	D6
		andi.w	#$000C, D6
		beq.s	Offset_0x014E54
		move.b	D6, D0
		andi.b	#$04, D0
		beq.s	Offset_0x014E46
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x014E76
Offset_0x014E46:
		andi.b	#$08, D6
		beq.s	Offset_0x014E54
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Offset_0x014E76
Offset_0x014E54:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014E74
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014E74:
		rts
Offset_0x014E76:
		move.w	D6, -(A7)
		move.l	A0, -(A7)
		move.l	A1, A0
		jsr		(Kill_Player).l				   ; Offset_0x00A4A4
		move.l	(A7)+, A0
		move.w	(A7)+, D6
		rts
;-------------------------------------------------------------------------------
; Objeto 0x6B - Espinhos na vertical na Hydrocity
; <<<-
;-------------------------------------------------------------------------------