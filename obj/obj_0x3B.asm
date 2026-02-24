;===============================================================================
; Objeto 0x3B - Parede de onde sai um jato de água quebrando-a na Hydrocity
; ->>>
;===============================================================================
; Offset_0x025C30:
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x025C3E
		move.l	#Offset_0x025FCE, (A0)
		rts
Offset_0x025C3E:
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		cmpi.w	#$0500, D0
		bcc.s	Offset_0x025C4E
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x025C4E:
		lea		(Art_Hz_Geyser_Horizontal).l, A1		   ; Offset_0x12FCF0
		move.w	#$A000, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		move.l	#Offset_0x025C64, (A0)
Offset_0x025C64:
		tst.b	(Kos_modules_left).w			; $FFFFFF60
		beq.s	Offset_0x025C6C
		rts
Offset_0x025C6C:
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.l	#Water_Wall_Mappings, Obj_Map(A0) ; Offset_0x0262BA, $000C
		move.w	#$4500, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0020, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x025CB6, (A0)
Offset_0x025CB6:
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		subi.w	#$0060, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcs.w	Offset_0x025D40
		move.l	#Offset_0x025D76, (A0)
		moveq	#Geyser_Sfx, D0					   ; $5D
		jsr		(PlaySound).l					; Offset_0x001176
		lea		(Offset_0x025D46).l, A3
		move.w	Obj_X(A0), D2					 ; $0010
		addi.w	#$0060, D2
		move.w	Obj_Y(A0), D3					 ; $0014
		moveq	#$07, D1
Offset_0x025CE8:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x025D40
		move.l	#Offset_0x025E54, (A1)
		move.l	#Water_Wall_Debris_Mappings, Obj_Map(A1) ; Offset_0x0263B8, $000C
		move.w	#$4558, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.b	(A3)+, D0
		ext.w	D0
		add.w	D2, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.b	(A3)+, D0
		ext.w	D0
		add.w	D3, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		move.w	(A3)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A3)+, Obj_Speed_Y(A1)					 ; $001A
		move.b	D1, Obj_Map_Id(A1)				 ; $0022
		dbra	D1, Offset_0x025CE8
Offset_0x025D40:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x025D46:
		dc.b	$00, $E8
		dc.w	$0400, $FF80
		dc.b	$00, $F8
		dc.w	$0600, $FFC0
		dc.b	$00, $08
		dc.w	$0600, $0040
		dc.b	$00, $18
		dc.w	$0400, $0080
		dc.b	$00, $E8
		dc.w	$0300, $FC80
		dc.b	$00, $F8
		dc.w	$0400, $FCC0
		dc.b	$00, $08
		dc.w	$0300, $0100
		dc.b	$00, $18
		dc.w	$0500, $FF00
;-------------------------------------------------------------------------------
Offset_0x025D76:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x025D84
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		addq.w	#$08, Obj_X(A0)					 ; $0010
Offset_0x025D84:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x025E02
		move.l	#Offset_0x025F18, (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	(Level_Frame_Count).w, D0			 ; $FFFFFE04
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	D0, D1
		andi.w	#$000F, D0
		lsl.w	#$03, D0
		subi.w	#$0050, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		addi.w	#$0018, Obj_Y(A1)				 ; $0014
		move.w	#$4530, Obj_Art_VRAM(A1)				 ; $000A
		lsr.w	#$04, D1
		andi.w	#$0003, D1
		bne.s	Offset_0x025DE0
		move.w	#$045C, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x025DE0:
		move.b	D1, Obj_Ani_Number(A1)					 ; $0020
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		move.w	#$0400, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
Offset_0x025E02:
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x025E3A
		clr.b	(Palette_Cycle_Counters).w			 ; $FFFFF650
		move.w	#PSG_Mute, D0					 ; $FFE2
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#Stop_SFx, D0					 ; $FFE3
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#$0096, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x025E40, (A0)
		rts
Offset_0x025E3A:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x025E40:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bmi.s	Offset_0x025E48
		rts
Offset_0x025E48:
		jsr		(Level_Load_Enemies_Art).l			   ; Offset_0x024F46
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x025E54:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x025E6A
		move.b	#$02, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$07, Obj_Map_Id(A0)					 ; $0022
Offset_0x025E6A:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0038, Obj_Speed_Y(A0)					 ; $001A
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x025EDC
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		asr.w	Obj_Speed_X(A0)					 ; $0018
		asr.w	Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x025EE2, (A0)
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x025EDC
		move.l	#Offset_0x025F78, (A1)
		move.l	#Water_Wall_Mappings, Obj_Map(A1) ; Offset_0x0262BA, $000C
		move.w	#$2530, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	(Water_Level_Move).w, Obj_Y(A1)		  ; $FFFFF646, $0014
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		move.b	#$08, Obj_Ani_Number(A1)				 ; $0020
Offset_0x025EDC:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x025EE2:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x025EF8
		move.b	#$09, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$07, Obj_Map_Id(A0)					 ; $0022
Offset_0x025EF8:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0008, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x025F12
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x025F12:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x025F18:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0028, Obj_Speed_Y(A0)					 ; $001A
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x025F3C
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.l	#Offset_0x025F56, (A0)
		addq.b	#$04, Obj_Ani_Number(A0)				 ; $0020
Offset_0x025F3C:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x025F12
		lea		(Water_Wall_Animate_Data).l, A1			 ; Offset_0x025F9A
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x025F56:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x025F12
		lea		(Water_Wall_Animate_Data).l, A1			 ; Offset_0x025F9A
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Routine(A0)					 ; $0005
		bne.w	Offset_0x025F12
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x025F78:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x025F12
		lea		(Water_Wall_Animate_Data).l, A1			 ; Offset_0x025F9A
		jsr		(AnimateSprite_2).l			   ; Offset_0x0111FE
		tst.b	Obj_Routine(A0)					 ; $0005
		bne.w	Offset_0x025F12
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Water_Wall_Animate_Data:					   ; Offset_0x025F9A
		dc.w	Offset_0x025FAC-Water_Wall_Animate_Data
		dc.w	Offset_0x025FAF-Water_Wall_Animate_Data
		dc.w	Offset_0x025FB4-Water_Wall_Animate_Data
		dc.w	Offset_0x025FB4-Water_Wall_Animate_Data
		dc.w	Offset_0x025FB8-Water_Wall_Animate_Data
		dc.w	Offset_0x025FBA-Water_Wall_Animate_Data
		dc.w	Offset_0x025FBA-Water_Wall_Animate_Data
		dc.w	Offset_0x025FBA-Water_Wall_Animate_Data
		dc.w	Offset_0x025FBD-Water_Wall_Animate_Data
Offset_0x025FAC:
		dc.b	$77, $02, $FF
Offset_0x025FAF:
		dc.b	$01, $03, $04, $05, $FF
Offset_0x025FB4:
		dc.b	$00, $06, $07, $FF
Offset_0x025FB8:
		dc.b	$09, $FC
Offset_0x025FBA:
		dc.b	$09, $08, $FC
Offset_0x025FBD:
		dc.b	$08, $01, $09, $01, $0A, $00, $09, $01
		dc.b	$0A, $01, $09, $00, $0A, $04, $08, $02
		dc.b	$FC
;-------------------------------------------------------------------------------
Offset_0x025FCE:
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		addi.w	#$0030, D0
		sub.w	Obj_X(A0), D0					 ; $0010
		cmpi.w	#$0060, D0
		bcc.s	Offset_0x025FF2
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		addi.w	#$0040, D0
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmpi.w	#$0010, D0
		bcs.s	Offset_0x025FF8
Offset_0x025FF2:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x025FF8:
		lea		(Art_Hz_Geyser_Vertical).l, A1		   ; Offset_0x130482
		move.w	#$A000, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.b	#$81, (Obj_Player_One+Obj_Timer).w			 ; $FFFFB02E
		move.b	#$81, (Obj_Player_Two+Obj_Player_Control).w	 ; $FFFFB078
		move.l	#Offset_0x026020, (A0)
Offset_0x026020:
		tst.b	(Kos_modules_left).w			; $FFFFFF60
		beq.s	Offset_0x026034
		subi.w	#$0008, (Obj_Player_One+Obj_Y).w			 ; $FFFFB014
		subi.w	#$0008, (Obj_Player_Two+Obj_Y).w			 ; $FFFFB05E
		rts
Offset_0x026034:
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.l	#Water_Wall_Mappings, Obj_Map(A0) ; Offset_0x0262BA, $000C
		move.w	#$4500, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$60, Obj_Height(A0)					 ; $0006
		move.w	#$0060, Obj_Control_Var_00(A0)			 ; $0030
		move.b	#$1C, (Obj_Player_One+Obj_Ani_Number).w		 ; $FFFFB020
		move.b	#$1C, (Obj_Player_Two+Obj_Ani_Number).w		 ; $FFFFB06A
		move.l	#Offset_0x026072, (A0)
Offset_0x026072:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x026080
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		subq.w	#$08, Obj_Y(A0)					 ; $0014
Offset_0x026080:
		subi.w	#$0008, (Obj_Player_One+Obj_Y).w			 ; $FFFFB014
		subi.w	#$0008, (Obj_Player_Two+Obj_Y).w			 ; $FFFFB05E
		cmpi.w	#$0028, Obj_Control_Var_00(A0)			 ; $0030
		bhi.w	Offset_0x026122
		move.b	#$1A, (Obj_Player_One+Obj_Ani_Number).w		 ; $FFFFB020
		move.b	#$1A, (Obj_Player_Two+Obj_Ani_Number).w		 ; $FFFFB06A
		move.l	#Offset_0x026154, (A0)
		moveq	#Geyser_Sfx, D0					   ; $5D
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$01, (Palette_Cycle_Counters).w			 ; $FFFFF650
		lea		(Offset_0x026124).l, A3
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		subi.w	#$0080, D3
		moveq	#$07, D1
Offset_0x0260CA:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x026122
		move.l	#Offset_0x025E54, (A1)
		move.l	#Water_Wall_Debris_Mappings, Obj_Map(A1) ; Offset_0x0263B8, $000C
		move.w	#$4558, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.b	(A3)+, D0
		ext.w	D0
		add.w	D2, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.b	(A3)+, D0
		ext.w	D0
		add.w	D3, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		move.w	(A3)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A3)+, Obj_Speed_Y(A1)					 ; $001A
		move.b	D1, Obj_Map_Id(A1)				 ; $0022
		dbra	D1, Offset_0x0260CA
Offset_0x026122:
		rts
;-------------------------------------------------------------------------------
Offset_0x026124:
		dc.w	$E800, $FE00, $F500, $F800, $FF00, $F400, $E800, $FC00
		dc.w	$F800, $F800, $FD00, $F600, $0800, $0300, $F400, $1800
		dc.w	$0400, $F500, $0800, $0100, $F600, $1800, $0200, $F800
;-------------------------------------------------------------------------------
Offset_0x026154:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x0261AA
		move.w	#$F600, Obj_Speed_Y(A0)					 ; $001A
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x0261AA
		move.l	#Offset_0x026264, (A0)
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$F400, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$F400, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		move.w	#$F800, Obj_Speed_Y(A0)					 ; $001A
Offset_0x0261AA:
		subi.w	#$000A, (Obj_Player_One+Obj_Y).w			 ; $FFFFB014
		subi.w	#$000A, (Obj_Player_Two+Obj_Y).w			 ; $FFFFB05E
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		addi.w	#$0048, Obj_Speed_Y(A0)					 ; $001A
		jsr		(AllocateObjectAfterCurrent)		  ; Offset_0x011DE0
		bne.w	Offset_0x02620E
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	D0, D1
		move.w	D0, D2
		bsr.s	Offset_0x026214
		addi.w	#$0010, Obj_X(A1)				 ; $0010
		andi.w	#$000F, D1
		lsl.w	#$06, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	#$F900, Obj_Speed_Y(A1)					 ; $001A
		move.w	D0, D2
		jsr		(AllocateObjectAfterCurrent)		  ; Offset_0x011DE0
		bne.w	Offset_0x02620E
		bsr.s	Offset_0x026214
		subi.w	#$0010, Obj_X(A1)				 ; $0010
		neg.w	D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	#$F900, Obj_Speed_Y(A1)					 ; $001A
Offset_0x02620E:
		jmp		(MarkObjGone)				   ; Offset_0x011AF2
Offset_0x026214:
		move.l	#Offset_0x025F18, (A1)
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0050, Obj_Y(A1)				 ; $0014
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.b	#$18, Obj_Width(A1)				 ; $0007
		move.b	#$18, Obj_Height(A1)					 ; $0006
		move.w	#$4530, Obj_Art_VRAM(A1)				 ; $000A
		lsr.w	#$04, D2
		andi.w	#$0003, D2
		bne.s	Offset_0x02625E
		move.w	#$045C, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x02625E:
		move.b	D2, Obj_Ani_Number(A1)					 ; $0020
		rts
;-------------------------------------------------------------------------------
Offset_0x026264:
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x0262A8
		move.w	#Stop_SFx, D0					 ; $FFE3
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#PSG_Mute, D0					 ; $FFE2
		jsr		(PlaySound).l					; Offset_0x001176
		move.w	#Stop_SFx, D0					 ; $FFE3
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$00, (Palette_Cycle_Counters).w			 ; $FFFFF650
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x02629A
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x02629A:
		move.w	#$001E, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x025E40, (A0)
		rts
Offset_0x0262A8:
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		addi.w	#$0048, Obj_Speed_Y(A0)					 ; $001A
		jmp		(MarkObjGone)				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Water_Wall_Mappings:						   ; Offset_0x0262BA
		dc.w	Offset_0x0262D0-Water_Wall_Mappings
		dc.w	Offset_0x026326-Water_Wall_Mappings
		dc.w	Offset_0x026370-Water_Wall_Mappings
		dc.w	Offset_0x026378-Water_Wall_Mappings
		dc.w	Offset_0x026380-Water_Wall_Mappings
		dc.w	Offset_0x026388-Water_Wall_Mappings
		dc.w	Offset_0x026390-Water_Wall_Mappings
		dc.w	Offset_0x026398-Water_Wall_Mappings
		dc.w	Offset_0x0263A0-Water_Wall_Mappings
		dc.w	Offset_0x0263A8-Water_Wall_Mappings
		dc.w	Offset_0x0263B0-Water_Wall_Mappings
Offset_0x0262D0:
		dc.w	$000E
		dc.w	$E00F, $0000, $FF80
		dc.w	$E00F, $0000, $FFA0
		dc.w	$E00F, $0000, $FFC0
		dc.w	$E00F, $0000, $FFE0
		dc.w	$E00F, $0000, $0000
		dc.w	$E00F, $0010, $0020
		dc.w	$E00F, $0020, $0040
		dc.w	$000F, $1000, $FF80
		dc.w	$000F, $1000, $FFA0
		dc.w	$000F, $1000, $FFC0
		dc.w	$000F, $1000, $FFE0
		dc.w	$000F, $1000, $0000
		dc.w	$000F, $1010, $0020
		dc.w	$000F, $1020, $0040
Offset_0x026326:
		dc.w	$000C
		dc.w	$A00F, $0000, $FFE0
		dc.w	$A00F, $0800, $0000
		dc.w	$C00F, $0010, $FFE0
		dc.w	$C00F, $0810, $0000
		dc.w	$E00F, $0020, $FFE0
		dc.w	$E00F, $0820, $0000
		dc.w	$000F, $0020, $FFE0
		dc.w	$000F, $0820, $0000
		dc.w	$200F, $0020, $FFE0
		dc.w	$200F, $0820, $0000
		dc.w	$400F, $0020, $FFE0
		dc.w	$400F, $0820, $0000
Offset_0x026370:
		dc.w	$0001
		dc.w	$FC00, $0000, $FFFC
Offset_0x026378:
		dc.w	$0001
		dc.w	$F805, $001A, $FFF8
Offset_0x026380:
		dc.w	$0001
		dc.w	$F805, $001E, $FFF8
Offset_0x026388:
		dc.w	$0001
		dc.w	$F805, $0022, $FFF8
Offset_0x026390:
		dc.w	$0001
		dc.w	$FC00, $0026, $FFFC
Offset_0x026398:
		dc.w	$0001
		dc.w	$FC00, $0027, $FFFC
Offset_0x0263A0:
		dc.w	$0001
		dc.w	$FA04, $0000, $FFF8
Offset_0x0263A8:
		dc.w	$0001
		dc.w	$EA0E, $0002, $FFF0
Offset_0x0263B0:
		dc.w	$0001
		dc.w	$EA0E, $000E, $FFF0
;-------------------------------------------------------------------------------
Water_Wall_Debris_Mappings:					   ; Offset_0x0263B8
		dc.w	Offset_0x0263C8-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263D0-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263D8-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263E0-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263E8-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263F0-Water_Wall_Debris_Mappings
		dc.w	Offset_0x0263F8-Water_Wall_Debris_Mappings
		dc.w	Offset_0x026400-Water_Wall_Debris_Mappings
Offset_0x0263C8:
		dc.w	$0001
		dc.w	$F80E, $0000, $FFF0
Offset_0x0263D0:
		dc.w	$0001
		dc.w	$F00F, $000C, $FFF0
Offset_0x0263D8:
		dc.w	$0001
		dc.w	$F00B, $001C, $FFF0
Offset_0x0263E0:
		dc.w	$0001
		dc.w	$F00F, $080C, $FFF0
Offset_0x0263E8:
		dc.w	$0001
		dc.w	$F00E, $1000, $FFF0
Offset_0x0263F0:
		dc.w	$0001
		dc.w	$F00F, $180C, $FFF0
Offset_0x0263F8:
		dc.w	$0001
		dc.w	$F00B, $081C, $FFF8
Offset_0x026400:
		dc.w	$0001
		dc.w	$F00F, $100C, $FFF0
;===============================================================================
; Objeto 0x3B - Parede de onde sai um jato de água quebrando-a na Hydrocity
; <<<-
;===============================================================================