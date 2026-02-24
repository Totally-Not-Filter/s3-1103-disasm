;===============================================================================
; Objeto 0x5D - Molas triangulares na Chrome Gadget
; ->>>
;===============================================================================
; Offset_0x029004:
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$40, Obj_Height(A0)					 ; $0006
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$04, D0
		andi.b	#$07, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		beq.s	Offset_0x029026
		move.b	#$80, Obj_Height(A0)					 ; $0006
Offset_0x029026:
		move.l	#Offset_0x02902C, (A0)
Offset_0x02902C:
		move.w	#$0010, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		movem.l D1-D4, -(A7)
		jsr		(Solid_Object_2_A1).l			   ; Offset_0x0135CC
		cmpi.b	#$01, D4
		bne.s	Offset_0x029076
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029076
		move.b	Obj_Status(A0), D1				 ; $002A
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x02906E
		eori.b	#$01, D1
Offset_0x02906E:
		andi.b	#$01, D1
		bne.s	Offset_0x029076
		bsr.s	Offset_0x0290B0
Offset_0x029076:
		movem.l (A7)+, D1-D4
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		jsr		(Solid_Object_2_A1).l			   ; Offset_0x0135CC
		cmpi.b	#$01, D4
		bne.s	Offset_0x0290AE
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x0290AE
		move.b	Obj_Status(A0), D1				 ; $002A
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x0290A6
		eori.b	#$01, D1
Offset_0x0290A6:
		andi.b	#$01, D1
		bne.s	Offset_0x0290AE
		bsr.s	Offset_0x0290B0
Offset_0x0290AE:
		rts
Offset_0x0290B0:
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcs.s	Offset_0x0290BA
		rts
Offset_0x0290BA:
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0400, Obj_Speed_Y(A1)					 ; $001A
		bset	#$00, Obj_Status(A1)					 ; $002A
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x0290DE
		bclr	#$00, Obj_Status(A1)					 ; $002A
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x0290DE:
		move.w	#$000F, Obj_P_Horiz_Ctrl_Lock(A1)		 ; $0032
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		btst	#$02, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x0290F8
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
Offset_0x0290F8:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x029104
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
Offset_0x029104:
		btst	#$00, D0
		beq.s	Offset_0x029144
		move.w	#$0001, Obj_Inertia(A1)					 ; $001C
		move.b	#$01, Obj_Flip_Angle(A1)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, Obj_P_Flips_Remaining(A1)			 ; $0030
		move.b	#$08, Obj_Player_Flip_Speed(A1)			 ; $0031
		btst	#$01, D0
		bne.s	Offset_0x029134
		move.b	#$03, Obj_P_Flips_Remaining(A1)			 ; $0030
Offset_0x029134:
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x029144
		neg.b	Obj_Flip_Angle(A1)				 ; $0027
		neg.w	Obj_Inertia(A1)					 ; $001C
Offset_0x029144:
		andi.b	#$0C, D0
		cmpi.b	#$04, D0
		bne.s	Offset_0x02915A
		move.b	#$0C, Obj_Player_Top_Solid(A1)			 ; $0046
		move.b	#$0D, Obj_Player_LRB_Solid(A1)			 ; $0047
Offset_0x02915A:
		cmpi.b	#$08, D0
		bne.s	Offset_0x02916C
		move.b	#$0E, Obj_Player_Top_Solid(A1)			 ; $0046
		move.b	#$0F, Obj_Player_LRB_Solid(A1)			 ; $0047
Offset_0x02916C:
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.w	#Small_Bumper_Sfx, D0					 ; $FF8B
		jmp		(Play_Music).l					 ; Offset_0x001176
;===============================================================================
; Objeto 0x5D - Molas triangulares na Chrome Gadget
; <<<-
;===============================================================================