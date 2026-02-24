;===============================================================================
; Perdendo anéis após sofrer algum dano
; ->>>
;===============================================================================
; Offset_0x010AD6:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x010AE4(PC, D0), D1
		jmp		Offset_0x010AE4(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x010AE4:
		dc.w	Offset_0x010AEE-Offset_0x010AE4
		dc.w	Offset_0x010BD4-Offset_0x010AE4
		dc.w	Offset_0x010C3A-Offset_0x010AE4
		dc.w	Offset_0x010C4E-Offset_0x010AE4
		dc.w	Offset_0x010C5C-Offset_0x010AE4
;-------------------------------------------------------------------------------
Offset_0x010AEE:
		move.l	A0, A1
		moveq	#$00, D5
		move.w	(Ring_count).w, D5			 ; $FFFFFE20
		tst.b	Obj_Player_One_Or_Two(A0)				 ; $003F
		beq.s	Offset_0x010B00
		move.w	(Ring_Count_Address_P2).w, D5		 ; $FFFFFED0
Offset_0x010B00:
		moveq	#$20, D0
		cmp.w	D0, D5
		bcs.s	Offset_0x010B08
		move.w	D0, D5
Offset_0x010B08:
		subq.w	#$01, D5
		move.w	#$0288, D4
		bra.s	Offset_0x010B18
;-------------------------------------------------------------------------------
Offset_0x010B10:
		bsr.w	AllocateObjectAfterCurrent			  ; Offset_0x011DE0
		bne.w	Offset_0x010B9E
Offset_0x010B18:
		move.l	#Rings_Lost, (A1)			   ; Offset_0x010AD6
		addq.b	#$02, Obj_Routine(A1)					 ; $0005
		move.b	#$08, Obj_Height_2(A1)					 ; $001E
		move.b	#$08, Obj_Width_2(A1)					 ; $001F
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#Rings_Mappings, Obj_Map(A1)	; Offset_0x010DE2, $000C
		move.w	#$A6BC, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.w	#$0180, Obj_Priority(A1)				 ; $0008
		move.b	#$47, Obj_Col_Flags(A1)					 ; $0028
		move.b	#$08, Obj_Width(A1)				 ; $0007
		move.b	#$FF, (Object_Frame_Anim_Counter).w			 ; $FFFFFEA6
		tst.w	D4
		bmi.s	Offset_0x010B8E
		move.w	D4, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D4, D2
		lsr.w	#$08, D2
		asl.w	D2, D0
		asl.w	D2, D1
		move.w	D0, D2
		move.w	D1, D3
		addi.b	#$10, D4
		bcc.s	Offset_0x010B8E
		subi.w	#$0080, D4
		bcc.s	Offset_0x010B8E
		move.w	#$0288, D4
Offset_0x010B8E:
		move.w	D2, Obj_Speed_X(A1)				 ; $0018
		move.w	D3, Obj_Speed_Y(A1)				 ; $001A
		neg.w	D2
		neg.w	D4
		dbra	D5, Offset_0x010B10
Offset_0x010B9E:
		move.w	#sfx_RingLoss, D0				; $0034
		jsr		(PlaySound).l					; Offset_0x001176
		tst.b	Obj_Player_One_Or_Two(A0)				 ; $003F
		bne.s	Offset_0x010BC2
		move.w	#$0000, (Ring_count).w		 ; $FFFFFE20
		move.b	#$80, (Update_HUD_rings).w			   ; $FFFFFE1D
		move.b	#$00, (Extra_life_flags).w			 ; $FFFFFE1B
		bra.s	Offset_0x010BD4
Offset_0x010BC2:
		move.w	#$0000, (Ring_Count_Address_P2).w			 ; $FFFFFED0
		move.b	#$80, (HUD_Rings_Refresh_Flag_P2).w			 ; $FFFFFEC9
		move.b	#$00, (Ring_Status_Flag_P2).w		 ; $FFFFFEC7
;-------------------------------------------------------------------------------
Offset_0x010BD4:
		move.b	(Object_Frame_Anim_Frame).w, Obj_Map_Id(A0) ; $FFFFFEA7, $0022
		bsr.w	SpeedToPos					   ; Offset_0x01111E
		addi.w	#$0018, Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x010C14
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		add.b	D7, D0
		andi.b	#$07, D0
		bne.s	Offset_0x010C14
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x010C30
		jsr		(Ring_FindFloor).l				 ; Offset_0x009DE0
		tst.w	D1
		bpl.s	Offset_0x010C14
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		asr.w	#$02, D0
		sub.w	D0, Obj_Speed_Y(A0)				 ; $001A
		neg.w	Obj_Speed_Y(A0)					 ; $001A
Offset_0x010C14:
		tst.b	(Object_Frame_Anim_Counter).w		 ; $FFFFFEA6
		beq.s	Offset_0x010C5C
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$00E0, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x010C5C
		bsr.w	Add_SpriteToCollisionResponseList		  ; Offset_0x00A540
		bra.w	DisplaySprite				   ; Offset_0x011148
Offset_0x010C30:
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		bne.w	Offset_0x010C5C
		bra.s	Offset_0x010C14
;-------------------------------------------------------------------------------
Offset_0x010C3A:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		bsr.w	CollectRing			   ; Offset_0x010A20
;-------------------------------------------------------------------------------
Offset_0x010C4E:
		lea		(Rings_Animate_Data).l, A1		 ; Offset_0x010DDA
		bsr.w	AnimateSprite				   ; Offset_0x01115E
		bra.w	DisplaySprite				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x010C5C:
		bra.w	DeleteObject				   ; Offset_0x011138
;===============================================================================
; Perdendo anéis após sofrer algum dano
; <<<-
;===============================================================================