;-------------------------------------------------------------------------------
; Objeto 0x6A - Espinhos na horizontal na Hydrocity
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x014B5A:
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
		beq.s	Offset_0x014BA4
		move.l	#Offset_0x014C20, (A0)
		rts
Offset_0x014BA4:
		btst	#$01, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x014BB4
		move.l	#Offset_0x014C84, (A0)
		rts
Offset_0x014BB4:
		move.l	#Offset_0x014BBA, (A0)
;-------------------------------------------------------------------------------
Offset_0x014BBA:
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
		beq.s	Offset_0x014BFE
		move.b	D6, D0
		andi.b	#$08, D0
		beq.s	Offset_0x014BF0
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014BF0:
		andi.b	#$10, D6
		beq.s	Offset_0x014BFE
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014BFE:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014C1E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014C1E:
		rts
;-------------------------------------------------------------------------------
Offset_0x014C20:
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
		beq.s	Offset_0x014C62
		move.b	D6, D0
		andi.b	#$01, D0
		beq.s	Offset_0x014C54
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014C54:
		andi.b	#$02, D6
		beq.s	Offset_0x014C62
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014C62:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014C82
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014C82:
		rts
;-------------------------------------------------------------------------------
Offset_0x014C84:
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
		beq.s	Offset_0x014CC6
		move.b	D6, D0
		andi.b	#$04, D0
		beq.s	Offset_0x014CB8
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014CB8:
		andi.b	#$08, D6
		beq.s	Offset_0x014CC6
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.w	Hurt_Player_A1				   ; Offset_0x01A71C
Offset_0x014CC6:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x014266
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		beq.s	Offset_0x014CE6
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x014CE6:
		rts
;-------------------------------------------------------------------------------
; Objeto 0x6A - Espinhos na horizontal na Hydrocity
; <<<-
;-------------------------------------------------------------------------------