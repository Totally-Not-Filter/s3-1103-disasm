;===============================================================================
; Objeto 0x33 - Interruptor usado para abrir certas portas nas fases
; ->>>
;===============================================================================
; Offset_0x023662:
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		bne.w	Obj_0x33_Switch_2P			   ; Offset_0x0237AA
		move.l	#Switch_Mappings, Obj_Map(A0)	; Offset_0x023832, $000C
		move.w	#$0456, Obj_Art_VRAM(A0)				 ; $000A
		cmpi.b	#Hz_Id, (Current_Zone).w			; $01, $FFFFFE10
		bne.s	Offset_0x02368E
		move.l	#Hz_Switch_Mappings, Obj_Map(A0) ; Offset_0x02385C, $000C
		move.w	#$2426, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x02368E:
		cmpi.b	#CNz_Id, (Current_Zone).w			; $03, $FFFFFE10
		bne.s	Offset_0x0236A4
		move.l	#CNz_Switch_Mappings, Obj_Map(A0) ; Offset_0x02388C, $000C
		move.w	#$441A, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x0236A4:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		btst	#$05, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0236CC
		move.l	#Offset_0x023740, (A0)
		bra.w	Offset_0x023740
;-------------------------------------------------------------------------------
Offset_0x0236CC:
		move.l	#Offset_0x0236D2, (A0)
Offset_0x0236D2:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02373A
		move.w	#$001B, D1
		move.w	#$0004, D2
		move.w	#$0005, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		moveq	#$00, D3
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x023710
		moveq	#$07, D3
Offset_0x023710:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x023726
		btst	#$04, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x02373A
		bclr	D3, (A3)
		bra.s	Offset_0x02373A
Offset_0x023726:
		tst.b	(A3)
		bne.s	Offset_0x023732
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x023732:
		bset	D3, (A3)
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x02373A:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x023740:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x0237A4
		move.w	#$0010, D1
		move.w	#$0006, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		moveq	#$00, D3
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02377A
		moveq	#$07, D3
Offset_0x02377A:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x023790
		btst	#$04, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0237A4
		bclr	D3, (A3)
		bra.s	Offset_0x0237A4
Offset_0x023790:
		tst.b	(A3)
		bne.s	Offset_0x02379C
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x02379C:
		bset	D3, (A3)
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x0237A4:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_0x33_Switch_2P:							   ; Offset_0x0237AA
		move.l	#Switch_Mappings_2P, Obj_Map(A0) ; Offset_0x0238BC, $000C
		move.w	#$03AD, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$0C, Obj_Width(A0)				 ; $0007
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		move.l	#Offset_0x0237D4, (A0)
Offset_0x0237D4:
		move.w	#$0013, D1
		move.w	#$0004, D2
		move.w	#$0005, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		moveq	#$00, D3
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x023818
		btst	#$04, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x02382C
		bclr	D3, (A3)
		bra.s	Offset_0x02382C
Offset_0x023818:
		tst.b	(A3)
		bne.s	Offset_0x023824
		moveq	#Switch_Blip_Sfx, D0					   ; $64
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x023824:
		bset	D3, (A3)
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x02382C:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Switch_Mappings:							   ; Offset_0x023832
		dc.w	Offset_0x023838-Switch_Mappings
		dc.w	Offset_0x023846-Switch_Mappings
		dc.w	Offset_0x02384E-Switch_Mappings
Offset_0x023838:
		dc.w	$0002
		dc.w	$F40C, $0000, $FFF0
		dc.w	$FC04, $0004, $FFF8
Offset_0x023846:
		dc.w	$0001
		dc.w	$FC0C, $0000, $FFF0
Offset_0x02384E:
		dc.w	$0002
		dc.w	$F80C, $0000, $FFF0
		dc.w	$0004, $0004, $FFF8
;-------------------------------------------------------------------------------
Hz_Switch_Mappings:							   ; Offset_0x02385C
		dc.w	Offset_0x023862-Hz_Switch_Mappings
		dc.w	Offset_0x023870-Hz_Switch_Mappings
		dc.w	Offset_0x02387E-Hz_Switch_Mappings
Offset_0x023862:
		dc.w	$0002
		dc.w	$F805, $0000, $FFF0
		dc.w	$F805, $0800, $0000
Offset_0x023870:
		dc.w	$0002
		dc.w	$F805, $0004, $FFF0
		dc.w	$F805, $0804, $0000
Offset_0x02387E:
		dc.w	$0002
		dc.w	$FC05, $0000, $FFF0
		dc.w	$FC05, $0800, $0000
;-------------------------------------------------------------------------------
CNz_Switch_Mappings:						   ; Offset_0x02388C
		dc.w	Offset_0x023892-CNz_Switch_Mappings
		dc.w	Offset_0x0238A0-CNz_Switch_Mappings
		dc.w	Offset_0x0238AE-CNz_Switch_Mappings
Offset_0x023892:
		dc.w	$0002
		dc.w	$F405, $0000, $FFF0
		dc.w	$F405, $0800, $0000
Offset_0x0238A0:
		dc.w	$0002
		dc.w	$FC04, $0004, $FFF0
		dc.w	$FC04, $0804, $0000
Offset_0x0238AE:
		dc.w	$0002
		dc.w	$F805, $0000, $FFF0
		dc.w	$F805, $0800, $0000
;-------------------------------------------------------------------------------
Switch_Mappings_2P:							   ; Offset_0x0238BC
		dc.w	Offset_0x0238C2-Switch_Mappings_2P
		dc.w	Offset_0x0238CA-Switch_Mappings_2P
		dc.w	Offset_0x0238D2-Switch_Mappings_2P
Offset_0x0238C2:
		dc.w	$0001
		dc.w	$F808, $000D, $FFF4
Offset_0x0238CA:
		dc.w	$0001
		dc.w	$F808, $0010, $FFF4
Offset_0x0238D2:
		dc.w	$0001
		dc.w	$FC08, $000D, $FFF4
;===============================================================================
; Objeto 0x33 - Interruptor usado para abrir certas portas nas fases
; <<<-
;===============================================================================