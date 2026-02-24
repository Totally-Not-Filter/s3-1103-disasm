;===============================================================================
; Objeto 0x1B - Pilar quebr�vel na Launch Base
; ->>>
;===============================================================================
; Offset_0x01E2C6:
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.l	#LBz_Pipe_Plug_Mappings, Obj_Map(A0) ; Offset_0x01E61C, $000C
		move.w	#$42E6, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x01E59C, Obj_Control_Var_0C(A0)			   ; $003C
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$07, Obj_Map_Id(A0)					 ; $0022
		move.l	#Offset_0x01E306, (A0)
Offset_0x01E306:
		move.w	(Obj_Player_One+Obj_Speed_X).w, Obj_Control_Var_00(A0) ; $FFFFB018, $0030
		move.w	(Obj_Player_Two+Obj_Speed_X).w, Obj_Control_Var_02(A0) ; $FFFFB062, $0032
		move.w	#$001B, D1
		move.w	#$0020, D2
		move.w	#$0021, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$60, D0
		bne.s	Offset_0x01E338
Offset_0x01E332:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01E338:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Control_Var_00(A0), D1				 ; $0030
		btst	#$05, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01E384
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x01E384
		move.w	D1, D0
		bpl.s	Offset_0x01E356
		neg.w	D0
Offset_0x01E356:
		cmpi.w	#$0480, D0
		bcs.s	Offset_0x01E384
		bclr	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01E3B8
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$05, Obj_Status(A2)					 ; $002A
		cmpi.b	#$02, Obj_Ani_Number(A2)				 ; $0020
		bne.s	Offset_0x01E3B8
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A2)	  ; $0032, $0018
		move.w	Obj_Speed_X(A2), Obj_Inertia(A2)		  ; $0018, $001C
		bra.s	Offset_0x01E3B8
Offset_0x01E384:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Control_Var_02(A0), D1				 ; $0032
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01E332
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x01E332
		move.w	D1, D0
		bpl.s	Offset_0x01E3A2
		neg.w	D0
Offset_0x01E3A2:
		cmpi.w	#$0480, D0
		bcs.w	Offset_0x01E332
		bclr	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01E3B8
		bclr	#$05, (Obj_Player_Two+Obj_Status).w			 ; $FFFFB074
Offset_0x01E3B8:
		bclr	#$05, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01E3C6
		bclr	#$05, (Obj_Player_One+Obj_Status).w			 ; $FFFFB02A
Offset_0x01E3C6:
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		addq.w	#$04, Obj_X(A1)					 ; $0010
		lea		(Offset_0x01E59C).l, A4
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x01E3EA
		subi.w	#$0008, Obj_X(A1)				 ; $0010
		lea		(Offset_0x01E5DC).l, A4
Offset_0x01E3EA:
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		move.b	Obj_Subtype(A0), D1				 ; $002C
		beq.s	Offset_0x01E44E
		cmpi.b	#$1F, D1
		beq.s	Offset_0x01E422
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01E44E
		move.l	#Obj_Automatic_Tunnel_Delayed, (A1)	   ; Offset_0x0201B8
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	#$07, Obj_Ani_Time(A1)					 ; $0024
		move.b	D1, Obj_Subtype(A1)				 ; $002C
Offset_0x01E422:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01E44E
		move.l	#Obj_Tunnel_Exhaust_Control, (A1)	   ; Offset_0x02044E
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0020, Obj_Y(A1)				 ; $0014
		move.w	#$0001, Obj_Speed_Y(A1)					 ; $001A
		move.b	D1, Obj_Subtype(A1)				 ; $002C
Offset_0x01E44E:
		move.l	#Offset_0x01E456, (A0)
		bsr.s	Offset_0x01E4B6
Offset_0x01E456:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x01E470
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01E470:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x01E476:
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), Obj_Map_Id(A0)		  ; $0023, $0022
		addq.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		cmpi.b	#$06, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x01E490
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
Offset_0x01E490:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x01E470
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x01E4AA:
		dc.b	$00, $01, $02, $03, $05, $00
		dc.b	$00, $01, $02, $03, $05, $00
;-------------------------------------------------------------------------------
Offset_0x01E4B6:
		lea		(Offset_0x01E4AA).l, A5
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		add.w	D0, D0
		move.l	Obj_Map(A0), A3					 ; $000C
		lea		Obj_Speed_Y(A3), A2				 ; $001A
		adda.w	(A3, D0), A2
		move.l	#Offset_0x01E476, D4
		move.b	Obj_Flags(A0), D5				 ; $0004
		moveq	#$0B, D1
Offset_0x01E4DC:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01E594
		move.l	D4, (A1)
		move.l	A3, Obj_Map(A1)					 ; $000C
		move.b	D5, Obj_Flags(A1)				 ; $0004
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		move.b	Obj_Width(A0), Obj_Width(A1)			  ; $0007, $0007
		move.w	(A4)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A4)+, Obj_Speed_Y(A1)					 ; $001A
		move.b	(A5)+, Obj_Map_Id(A1)					 ; $0022
		move.b	Obj_Map_Id(A1), Obj_Ani_Frame(A1)		  ; $0022, $0023
		move.b	(A2), D0
		addq.w	#$04, A2
		ext.w	D0
		add.w	Obj_Y(A0), D0					 ; $0014
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	(A2)+, D0
		add.w	Obj_X(A0), D0					 ; $0010
		move.w	D0, Obj_X(A1)					 ; $0010
		dbra	D1, Offset_0x01E4DC
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		add.w	D0, D0
		move.l	Obj_Map(A0), A3					 ; $000C
		adda.w	(A3, D0), A3
		move.w	(A3)+, D1
		subq.w	#$01, D1
		moveq	#$03, D1
		bset	#$05, Obj_Flags(A0)				 ; $0004
		move.l	(A0), D4
		move.b	Obj_Flags(A0), D5				 ; $0004
		move.l	A0, A1
		bra.s	Offset_0x01E560
;-------------------------------------------------------------------------------
Offset_0x01E556:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x01E594
		addq.w	#$06, A3
Offset_0x01E560:
		move.l	D4, (A1)
		move.l	A3, Obj_Map(A1)					 ; $000C
		move.b	D5, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.b	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		move.b	Obj_Width(A0), Obj_Width(A1)			  ; $0007, $0007
		move.w	(A4)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A4)+, Obj_Speed_Y(A1)					 ; $001A
		dbra	D1, Offset_0x01E556
Offset_0x01E594:
		moveq	#Smash_Sfx, D0					   ; $62
		jmp		(PlaySound).l					; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x01E59C:
		dc.w	$FC80, $FDC0, $FD00, $FDB0, $FD80, $FDA0, $FE00, $FDA0
		dc.w	$FE80, $FDB0, $FF00, $FDC0, $FC80, $FF40, $FD00, $FF30
		dc.w	$FD80, $FF20, $FE00, $FF20, $FE80, $FF30, $FF00, $FF40
		dc.w	$FC00, $FD40, $FF00, $FD40, $FC00, $FF80, $FF00, $FF80
;-------------------------------------------------------------------------------
Offset_0x01E5DC:
		dc.w	$0100, $FDC0, $0180, $FDB0, $0200, $FDA0, $0280, $FDA0
		dc.w	$0300, $FDB0, $0380, $FDC0, $0100, $FF40, $0180, $FF30
		dc.w	$0200, $FF20, $0280, $FF20, $0300, $FF30, $0380, $FF40
		dc.w	$0100, $FD40, $0400, $FD40, $0100, $FF80, $0400, $FF80
;-------------------------------------------------------------------------------
LBz_Pipe_Plug_Mappings:						   ; Offset_0x01E61C
		dc.w	Offset_0x01E68E-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E696-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E69E-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E6A6-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E6AE-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E6B6-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E6BE-LBz_Pipe_Plug_Mappings
		dc.w	Offset_0x01E62C-LBz_Pipe_Plug_Mappings
Offset_0x01E62C:
		dc.w	$0010
		dc.w	$E005, $0004, $FFF0
		dc.w	$E005, $0804, $0000
		dc.w	$1005, $1004, $FFF0
		dc.w	$1005, $1804, $0000
		dc.w	$F001, $0008, $FFF1
		dc.w	$F001, $000A, $FFF4
		dc.w	$F001, $000C, $FFF9
		dc.w	$F001, $000E, $FFFF
		dc.w	$F001, $080A, $0004
		dc.w	$F001, $0808, $0007
		dc.w	$0001, $0008, $FFF1
		dc.w	$0001, $000A, $FFF4
		dc.w	$0001, $000C, $FFF9
		dc.w	$0001, $000E, $FFFF
		dc.w	$0001, $080A, $0004
		dc.w	$0001, $0808, $0007
Offset_0x01E68E:
		dc.w	$0001
		dc.w	$0001, $0008, $0000
Offset_0x01E696:
		dc.w	$0001
		dc.w	$0001, $000A, $0000
Offset_0x01E69E:
		dc.w	$0001
		dc.w	$0001, $000C, $0000
Offset_0x01E6A6:
		dc.w	$0001
		dc.w	$0001, $000E, $0000
Offset_0x01E6AE:
		dc.w	$0001
		dc.w	$0001, $080C, $0000
Offset_0x01E6B6:
		dc.w	$0001
		dc.w	$0001, $080A, $0000
Offset_0x01E6BE:
		dc.w	$0001
		dc.w	$0001, $0808, $0000
;===============================================================================
; Objeto 0x1B - Pilar quebr�vel na Launch Base
; <<<-
;===============================================================================