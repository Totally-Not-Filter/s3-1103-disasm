;===============================================================================
; Objeto 0x65 - Indicador de fim de fase no modo 2 jogadores
; ->>>
;===============================================================================
; Offset_0x02D124:
		move.l	#Goal_Marker_Mappings, Obj_Map(A0) ; Offset_0x02D468, $000C
		move.w	#$06BC, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	#$14, Obj_Subtype(A0)					 ; $002C
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$03, D0
		subi.w	#$0014, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.b	#$05, (Competition_Laps_To_Win).w			 ; $FFFFFEFA
		clr.w	(Competition_Lap_Count_P1).w		 ; $FFFFFEFC
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		clr.l	(Timer).w				; $FFFFFE22
		clr.b	(HUD_Timer_Refresh_Flag_P2).w		 ; $FFFFFECA
		clr.l	(Time_Count_Address_P2).w			 ; $FFFFFED2
		clr.w	(Ring_count).w				 ; $FFFFFE20
		clr.w	(Ring_Count_Address_P2).w			 ; $FFFFFED0
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Offset_0x02DCD6, (A1)
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Offset_0x02DCD6, (A1)
		move.b	#$01, Obj_Subtype(A1)					 ; $002C
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Obj_Lap_Number, (A1)		   ; Offset_0x02D4A8
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Obj_Lap_Number, (A1)		   ; Offset_0x02D4A8
		move.b	#$01, Obj_Subtype(A1)					 ; $002C
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Obj_Neon_Display, (A1)		   ; Offset_0x02D588
		move.w	#$0120, Obj_X(A1)				 ; $0010
		move.w	#$00B8, Obj_Y(A1)				 ; $0014
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Obj_Timer_P1, (A1)			   ; Offset_0x02DAE6
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Obj_Timer_P2, (A1)			   ; Offset_0x02DB48
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Offset_0x02DDF4, (A1)
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D23C
		move.l	#Offset_0x02DDF4, (A1)
		move.b	#$01, Obj_Subtype(A1)					 ; $002C
Offset_0x02D23C:
		move.l	#Offset_0x02D242, (A0)
Offset_0x02D242:
		move.w	Obj_X(A0), D1					 ; $0010
		lea		Obj_Control_Var_04(A0), A2				 ; $0034
		lea		(Competition_Lap_Count_P1).w, A3			 ; $FFFFFEFC
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x02D324
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		(Competition_Lap_Count_P2).w, A3			 ; $FFFFFEFD
		bsr.w	Offset_0x02D324
		lea		(Goal_Marker_Animate_Data).l, A1		 ; Offset_0x02D460
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02D274:
		subq.w	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bne.w	Offset_0x02D312
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	(Saved_Obj_X_P1).w, Obj_X(A1)		  ; $FFFFFE32, $0010
		move.w	(Saved_Obj_Y_P1).w, Obj_Y(A1)		  ; $FFFFFE34, $0014
		move.w	(Saved_Obj_Art_VRAM_P1).w, Obj_Art_VRAM(A1) ; $FFFFFE3C, $000A
		move.w	(Saved_Top_Solid_P1).w, Obj_Control_Var_16(A1) ; $FFFFFE3E, $0046
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$02, Obj_Status(A1)					 ; $002A
		move.w	#$0000, Obj_Control_Var_02(A1)			 ; $0032
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	(Saved_Obj_X_P2).w, Obj_X(A1)		  ; $FFFFFEE2, $0010
		move.w	(Saved_Obj_Y_P2).w, Obj_Y(A1)		  ; $FFFFFEE4, $0014
		move.w	(Saved_Obj_Art_VRAM_P2).w, Obj_Art_VRAM(A1) ; $FFFFFEEC, $000A
		move.w	(Saved_Top_Solid_P2).w, Obj_Control_Var_16(A1) ; $FFFFFEEE, $0046
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$02, Obj_Status(A1)					 ; $002A
		move.w	#$0000, Obj_Control_Var_02(A1)			 ; $0032
		clr.w	(Competition_Lap_Count_P1).w		 ; $FFFFFEFC
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		clr.l	(Timer).w				; $FFFFFE22
		clr.b	(HUD_Timer_Refresh_Flag_P2).w		 ; $FFFFFECA
		clr.l	(Time_Count_Address_P2).w			 ; $FFFFFED2
		clr.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		clr.b	(Control_Locked_Flag_P2).w			 ; $FFFFF7CF
		move.l	#Offset_0x02D242, (A0)
Offset_0x02D312:
		lea		(Goal_Marker_Animate_Data).l, A1		 ; Offset_0x02D460
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02D324:
		tst.b	(A2)+
		bne.w	Offset_0x02D3D0
		cmp.w	Obj_X(A1), D1					 ; $0010
		bhi.w	Offset_0x02D41C
		move.b	#$01, -1(A2)
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		sub.w	Obj_Control_Var_08(A0), D2				 ; $0038
		addi.w	#$0014, D3
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		blt.w	Offset_0x02D41C
		cmp.w	D3, D4
		bge.w	Offset_0x02D41C
		move.w	Obj_X(A1), D2					 ; $0010
		sub.w	D1, D2
		bcc.s	Offset_0x02D360
		neg.w	D2
Offset_0x02D360:
		cmpi.w	#$0020, D2
		bcc.w	Offset_0x02D41C
		cmpi.b	#$0C, Obj_Control_Var_16(A1)			 ; $0046
		bne.s	Offset_0x02D39C
		sub.w	Obj_Y(A0), D4					 ; $0014
		neg.w	D4
		cmpi.w	#$0014, D4
		bge.s	Offset_0x02D39A
		move.b	(A3), D0
		beq.s	Offset_0x02D39E
		cmp.b	$0001(A2), D0
		bls.s	Offset_0x02D39A
		move.b	(A3), $0001(A2)
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		andi.w	#$000F, D0
		bsr.w	Find_Object_2P				   ; Offset_0x02D41E
		addq.w	#$02, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x02D39A:
		addq.b	#$01, (A3)
Offset_0x02D39C:
		rts
Offset_0x02D39E:
		tst.b	$0001(A2)
		bne.s	Offset_0x02D39A
		tst.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bne.s	Offset_0x02D39A
		move.b	#$01, (Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		move.b	#$01, (Control_Locked_Flag_P2).w			 ; $FFFFF7CF
		move.w	#$0000, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		move.w	#$0000, (Control_Ports_Logical_Data_2).w	 ; $FFFFF66A
		move.l	#Offset_0x02D274, (A0)
		move.w	#$003C, Obj_Control_Var_0C(A0)			 ; $003C
		rts
Offset_0x02D3D0:
		cmp.w	Obj_X(A1), D1					 ; $0010
		bls.w	Offset_0x02D41C
		move.b	#$00, -1(A2)
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	D2, D3
		sub.w	Obj_Control_Var_08(A0), D2				 ; $0038
		addi.w	#$0014, D3
		move.w	Obj_Y(A1), D4					 ; $0014
		cmp.w	D2, D4
		blt.w	Offset_0x02D41C
		cmp.w	D3, D4
		bge.w	Offset_0x02D41C
		move.w	Obj_X(A1), D2					 ; $0010
		sub.w	D1, D2
		bcc.s	Offset_0x02D406
		neg.w	D2
Offset_0x02D406:
		cmpi.w	#$0020, D2
		bcc.s	Offset_0x02D41C
		cmpi.b	#$0C, Obj_Control_Var_16(A1)			 ; $0046
		bne.s	Offset_0x02D41C
		subq.b	#$01, (A3)
		bcc.s	Offset_0x02D41C
		move.b	#$00, (A3)
Offset_0x02D41C:
		rts
;-------------------------------------------------------------------------------
Find_Object_2P:						   ; Offset_0x02D41E
		lea		(Sprite_Table_2P).l, A4			 ; Offset_0x02D448
		adda.w	D0, A4
		lea		(Obj_Dynamic_RAM).w, A1				 ; $FFFFB0DE
		moveq	#$59, D0
Offset_0x02D42C:
		lea		Obj_Size(A1), A1				 ; $004A
		cmpi.l	#Offset_0x02C914, (A1)
		bne.s	Offset_0x02D442
		move.b	(A4)+, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$C7, Obj_Col_Flags(A1)					 ; $0028
Offset_0x02D442:
		dbra	D0, Offset_0x02D42C
		rts
;-------------------------------------------------------------------------------
Sprite_Table_2P:							   ; Offset_0x02D448
		dc.b	$00, $01, $02, $03, $04, $05, $06, $00
		dc.b	$01, $02, $03, $04, $05, $06, $02, $03
		dc.b	$00, $01, $02, $03, $04, $05, $06, $00
;-------------------------------------------------------------------------------
Goal_Marker_Animate_Data:					   ; Offset_0x02D460
		dc.w	Offset_0x02D462-Goal_Marker_Animate_Data
Offset_0x02D462:
		dc.b	$05, $00, $01, $02, $03, $FF
;-------------------------------------------------------------------------------
Goal_Marker_Mappings:						   ; Offset_0x02D468
		dc.w	Offset_0x02D470-Goal_Marker_Mappings
		dc.w	Offset_0x02D47E-Goal_Marker_Mappings
		dc.w	Offset_0x02D48C-Goal_Marker_Mappings
		dc.w	Offset_0x02D49A-Goal_Marker_Mappings
Offset_0x02D470:
		dc.w	$0002
		dc.w	$EC02, $0000, $FFFC
		dc.w	$0401, $0003, $FFFC
Offset_0x02D47E:
		dc.w	$0002
		dc.w	$EC02, $0005, $FFFC
		dc.w	$0401, $0003, $FFFC
Offset_0x02D48C:
		dc.w	$0002
		dc.w	$EC02, $0008, $FFFC
		dc.w	$0401, $0003, $FFFC
Offset_0x02D49A:
		dc.w	$0002
		dc.w	$EC02, $000B, $FFFC
		dc.w	$0401, $0003, $FFFC
;-------------------------------------------------------------------------------
Obj_Lap_Number:						   ; Offset_0x02D4A8
		move.l	#Lap_Number_Mappings, Obj_Map(A0) ; Offset_0x02D524, $000C
		move.w	#$8700, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$0C, Obj_Height(A0)					 ; $0006
		move.w	#$0190, Obj_X(A0)				 ; $0010
		move.w	#$0098, Obj_Y(A0)				 ; $0014
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02D4E8
		bset	#$04, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x02D50C, (A0)
		bra.s	Offset_0x02D50C
Offset_0x02D4E8:
		bset	#$03, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x02D4F4, (A0)
Offset_0x02D4F4:
		move.b	(Competition_Lap_Count_P1).w, D0			 ; $FFFFFEFC
Offset_0x02D4F8:
		subi.b	#$0A, D0
		bcc.s	Offset_0x02D4F8
		addi.b	#$0A, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02D50C:
		move.b	(Competition_Lap_Count_P2).w, D0			 ; $FFFFFEFD
Offset_0x02D510:
		subi.b	#$0A, D0
		bcc.s	Offset_0x02D510
		addi.b	#$0A, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Lap_Number_Mappings:						   ; Offset_0x02D524
		dc.w	Offset_0x02D538-Lap_Number_Mappings
		dc.w	Offset_0x02D540-Lap_Number_Mappings
		dc.w	Offset_0x02D548-Lap_Number_Mappings
		dc.w	Offset_0x02D550-Lap_Number_Mappings
		dc.w	Offset_0x02D558-Lap_Number_Mappings
		dc.w	Offset_0x02D560-Lap_Number_Mappings
		dc.w	Offset_0x02D568-Lap_Number_Mappings
		dc.w	Offset_0x02D570-Lap_Number_Mappings
		dc.w	Offset_0x02D578-Lap_Number_Mappings
		dc.w	Offset_0x02D580-Lap_Number_Mappings
Offset_0x02D538:
		dc.w	$0001
		dc.w	$F406, $0000, $FFF8
Offset_0x02D540:
		dc.w	$0001
		dc.w	$F406, $0006, $FFF8
Offset_0x02D548:
		dc.w	$0001
		dc.w	$F406, $000C, $FFF8
Offset_0x02D550:
		dc.w	$0001
		dc.w	$F406, $0012, $FFF8
Offset_0x02D558:
		dc.w	$0001
		dc.w	$F406, $0018, $FFF8
Offset_0x02D560:
		dc.w	$0001
		dc.w	$F406, $001E, $FFF8
Offset_0x02D568:
		dc.w	$0001
		dc.w	$F406, $0024, $FFF8
Offset_0x02D570:
		dc.w	$0001
		dc.w	$F406, $002A, $FFF8
Offset_0x02D578:
		dc.w	$0001
		dc.w	$F406, $0030, $FFF8
Offset_0x02D580:
		dc.w	$0001
		dc.w	$F406, $0036, $FFF8
;-------------------------------------------------------------------------------
Obj_Neon_Display:							   ; Offset_0x02D588
		move.l	#Neon_Display_Mappings, Obj_Map(A0) ; Offset_0x02D72A,$000C
		move.w	#$8756, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$28, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x02D5AE, (A0)
Offset_0x02D5AE:
		lea		(Neon_Display_Animate_Data).l, A1		 ; Offset_0x02D6CE
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		bsr.s	Offset_0x02D5C2
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02D5C2:
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		bne.s	Offset_0x02D5F8
		tst.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		beq.s	Offset_0x02D5DC
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$0A, Obj_Map_Id(A0)					 ; $0022
		rts
Offset_0x02D5DC:
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x02D5F6
		move.b	#$01, (Update_HUD_timer).w			   ; $FFFFFE1E
		move.b	#$01, (HUD_Timer_Refresh_Flag_P2).w			 ; $FFFFFECA
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x02D5F6:
		rts
Offset_0x02D5F8:
		subq.b	#$01, D0
		bne.s	Offset_0x02D65C
		move.b	(Competition_Laps_To_Win).w, D0		 ; $FFFFFEFA
		cmp.b	(Competition_Lap_Count_P1).w, D0			 ; $FFFFFEFC
		bcc.s	Offset_0x02D638
		move.b	#$03, Obj_Ani_Number(A0)				 ; $0020
		bset	#$03, Obj_Flags(A0)				 ; $0004
		move.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
		move.b	#$80, (Update_HUD_timer).w			   ; $FFFFFE1E
		cmp.b	(Competition_Lap_Count_P2).w, D0			 ; $FFFFFEFD
		bcc.s	Offset_0x02D632
		bclr	#$03, Obj_Flags(A0)				 ; $0004
		move.b	#$80, (HUD_Timer_Refresh_Flag_P2).w			 ; $FFFFFECA
		rts
Offset_0x02D632:
		bsr.w	Offset_0x02D6A4
		rts
Offset_0x02D638:
		cmp.b	(Competition_Lap_Count_P2).w, D0			 ; $FFFFFEFD
		bcc.s	Offset_0x02D65A
		move.b	#$03, Obj_Ani_Number(A0)				 ; $0020
		bset	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$02, Obj_Control_Var_0A(A0)			 ; $003A
		move.b	#$80, (HUD_Timer_Refresh_Flag_P2).w			 ; $FFFFFECA
		bsr.w	Offset_0x02D6A4
Offset_0x02D65A:
		rts
Offset_0x02D65C:
		subq.b	#$01, D0
		bne.s	Offset_0x02D662
		rts
Offset_0x02D662:
		move.b	(Competition_Laps_To_Win).w, D0		 ; $FFFFFEFA
		cmp.b	(Competition_Lap_Count_P1).w, D0			 ; $FFFFFEFC
		bcc.s	Offset_0x02D684
		tst.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bmi.s	Offset_0x02D684
		move.b	#$03, Obj_Ani_Number(A0)				 ; $0020
		bset	#$03, Obj_Flags(A0)				 ; $0004
		move.b	#$80, (Update_HUD_timer).w			   ; $FFFFFE1E
Offset_0x02D684:
		cmp.b	(Competition_Lap_Count_P2).w, D0			 ; $FFFFFEFD
		bcc.s	Offset_0x02D6A2
		tst.b	(HUD_Timer_Refresh_Flag_P2).w		 ; $FFFFFECA
		bmi.s	Offset_0x02D6A2
		move.b	#$03, Obj_Ani_Number(A0)				 ; $0020
		bset	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$80, (HUD_Timer_Refresh_Flag_P2).w			 ; $FFFFFECA
Offset_0x02D6A2:
		rts
Offset_0x02D6A4:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02D6CC
		move.l	#Obj_Neon_Display, (A1)		   ; Offset_0x02D588
		move.w	#$0120, Obj_X(A1)				 ; $0010
		move.w	#$00B8, Obj_Y(A1)				 ; $0014
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$03, Obj_Control_Var_0A(A1)			 ; $003A
Offset_0x02D6CC:
		rts
;-------------------------------------------------------------------------------
Neon_Display_Animate_Data:					   ; Offset_0x02D6CE
		dc.w	Offset_0x02D6D6-Neon_Display_Animate_Data
		dc.w	Offset_0x02D6DA-Neon_Display_Animate_Data
		dc.w	Offset_0x02D705-Neon_Display_Animate_Data
		dc.w	Offset_0x02D708-Neon_Display_Animate_Data
Offset_0x02D6D6:
		dc.b	$3B, $0A, $FD, $01
Offset_0x02D6DA:
		dc.b	$05, $00, $05, $00, $05, $00, $05, $00
		dc.b	$05, $00, $05, $01, $06, $01, $06, $01
		dc.b	$06, $01, $06, $01, $06, $02, $07, $02
		dc.b	$07, $02, $07, $02, $07, $02, $07, $03
		dc.b	$08, $03, $08, $03, $08, $03, $08, $03
		dc.b	$08, $FD, $02
Offset_0x02D705:
		dc.b	$3B, $0A, $FF
Offset_0x02D708:
		dc.b	$05, $04, $09, $04, $09, $04, $09, $04
		dc.b	$09, $04, $09, $04, $09, $04, $09, $04
		dc.b	$09, $04, $09, $04, $09, $04, $09, $04
		dc.b	$09, $04, $09, $04, $09, $04, $09, $FD
		dc.b	$02, $FF
;-------------------------------------------------------------------------------
Neon_Display_Mappings:						   ; Offset_0x02D72A
		dc.w	Offset_0x02D740-Neon_Display_Mappings
		dc.w	Offset_0x02D77E-Neon_Display_Mappings
		dc.w	Offset_0x02D7B6-Neon_Display_Mappings
		dc.w	Offset_0x02D7D0-Neon_Display_Mappings
		dc.w	Offset_0x02D880-Neon_Display_Mappings
		dc.w	Offset_0x02D912-Neon_Display_Mappings
		dc.w	Offset_0x02D950-Neon_Display_Mappings
		dc.w	Offset_0x02D988-Neon_Display_Mappings
		dc.w	Offset_0x02D9A2-Neon_Display_Mappings
		dc.w	Offset_0x02DA52-Neon_Display_Mappings
		dc.w	Offset_0x02DAE4-Neon_Display_Mappings
Offset_0x02D740:
		dc.w	$000A
		dc.w	$DC08, $0000, $FFEC
		dc.w	$DC04, $0000, $0004
		dc.w	$E401, $0000, $FFE4
		dc.w	$E402, $0000, $0014
		dc.w	$FC08, $0000, $FFEC
		dc.w	$FC04, $0000, $0004
		dc.w	$0C01, $0000, $FFE4
		dc.w	$0402, $0000, $0014
		dc.w	$1C08, $0000, $FFEC
		dc.w	$1C04, $0000, $0004
Offset_0x02D77E:
		dc.w	$0009
		dc.w	$DC08, $0000, $FFEC
		dc.w	$DC04, $0000, $0004
		dc.w	$E401, $0000, $FFE4
		dc.w	$E402, $0000, $0014
		dc.w	$FC08, $0000, $FFEC
		dc.w	$FC04, $0000, $0004
		dc.w	$0402, $0000, $FFE4
		dc.w	$1C0C, $0000, $FFE4
		dc.w	$1C08, $0000, $0004
Offset_0x02D7B6:
		dc.w	$0004
		dc.w	$DC03, $0000, $FFFC
		dc.w	$E400, $0000, $FFF4
		dc.w	$FC03, $0000, $FFFC
		dc.w	$1C00, $0000, $FFFC
Offset_0x02D7D0:
		dc.w	$001D
		dc.w	$E008, $0000, $FF94
		dc.w	$E801, $0000, $FF8C
		dc.w	$E800, $0000, $FFAC
		dc.w	$F808, $0000, $FF94
		dc.w	$0801, $0000, $FF8C
		dc.w	$0002, $0000, $FFAC
		dc.w	$1808, $0000, $FF94
		dc.w	$E008, $0000, $FFBC
		dc.w	$E004, $0000, $FFD4
		dc.w	$E803, $0000, $FFCC
		dc.w	$0802, $0000, $FFCC
		dc.w	$E000, $0000, $FFFC
		dc.w	$E801, $0000, $FFF4
		dc.w	$E801, $0000, $0004
		dc.w	$F803, $0000, $FFEC
		dc.w	$1800, $0000, $FFEC
		dc.w	$0808, $0000, $FFF4
		dc.w	$F803, $0000, $000C
		dc.w	$1800, $0000, $000C
		dc.w	$E00C, $0000, $001C
		dc.w	$E803, $0000, $001C
		dc.w	$0802, $0000, $001C
		dc.w	$F808, $0000, $0024
		dc.w	$E801, $0000, $003C
		dc.w	$0003, $0000, $003C
		dc.w	$E008, $0000, $004C
		dc.w	$E004, $0000, $0064
		dc.w	$E803, $0000, $005C
		dc.w	$0802, $0000, $005C
Offset_0x02D880:
		dc.w	$0018
		dc.w	$E008, $0000, $FFAC
		dc.w	$E803, $0000, $FFA4
		dc.w	$0801, $0000, $FFA4
		dc.w	$E801, $0000, $FFC4
		dc.w	$0008, $0000, $FFB4
		dc.w	$0801, $0000, $FFC4
		dc.w	$1808, $0000, $FFAC
		dc.w	$E008, $0000, $FFDC
		dc.w	$E803, $0000, $FFD4
		dc.w	$0801, $0000, $FFD4
		dc.w	$E803, $0000, $FFF4
		dc.w	$0801, $0000, $FFF4
		dc.w	$1808, $0000, $FFDC
		dc.w	$E000, $0000, $0014
		dc.w	$E801, $0000, $000C
		dc.w	$E801, $0000, $001C
		dc.w	$F803, $0000, $0004
		dc.w	$1800, $0000, $0004
		dc.w	$0808, $0000, $000C
		dc.w	$F803, $0000, $0024
		dc.w	$1800, $0000, $0024
		dc.w	$E003, $0000, $0034
		dc.w	$0003, $0000, $0034
		dc.w	$180C, $0000, $003C
Offset_0x02D912:
		dc.w	$000A
		dc.w	$DC08, $0004, $FFEC
		dc.w	$DC04, $0004, $0004
		dc.w	$E401, $0004, $FFE4
		dc.w	$E402, $0004, $0014
		dc.w	$FC08, $0004, $FFEC
		dc.w	$FC04, $0004, $0004
		dc.w	$0C01, $0004, $FFE4
		dc.w	$0402, $0004, $0014
		dc.w	$1C08, $0004, $FFEC
		dc.w	$1C04, $0004, $0004
Offset_0x02D950:
		dc.w	$0009
		dc.w	$DC08, $0004, $FFEC
		dc.w	$DC04, $0004, $0004
		dc.w	$E401, $0004, $FFE4
		dc.w	$E402, $0004, $0014
		dc.w	$FC08, $0004, $FFEC
		dc.w	$FC04, $0004, $0004
		dc.w	$0402, $0004, $FFE4
		dc.w	$1C0C, $0004, $FFE4
		dc.w	$1C08, $0004, $0004
Offset_0x02D988:
		dc.w	$0004
		dc.w	$DC03, $0004, $FFFC
		dc.w	$E400, $0004, $FFF4
		dc.w	$FC03, $0004, $FFFC
		dc.w	$1C00, $0004, $FFFC
Offset_0x02D9A2:
		dc.w	$001D
		dc.w	$E008, $0004, $FF94
		dc.w	$E801, $0004, $FF8C
		dc.w	$E800, $0004, $FFAC
		dc.w	$F808, $0004, $FF94
		dc.w	$0801, $0004, $FF8C
		dc.w	$0002, $0004, $FFAC
		dc.w	$1808, $0004, $FF94
		dc.w	$E008, $0004, $FFBC
		dc.w	$E004, $0004, $FFD4
		dc.w	$E803, $0004, $FFCC
		dc.w	$0802, $0004, $FFCC
		dc.w	$E000, $0004, $FFFC
		dc.w	$E801, $0004, $FFF4
		dc.w	$E801, $0004, $0004
		dc.w	$F803, $0004, $FFEC
		dc.w	$1800, $0004, $FFEC
		dc.w	$0808, $0004, $FFF4
		dc.w	$F803, $0004, $000C
		dc.w	$1800, $0004, $000C
		dc.w	$E00C, $0004, $001C
		dc.w	$E803, $0004, $001C
		dc.w	$0802, $0004, $001C
		dc.w	$F808, $0004, $0024
		dc.w	$E801, $0004, $003C
		dc.w	$0003, $0004, $003C
		dc.w	$E008, $0004, $004C
		dc.w	$E004, $0004, $0064
		dc.w	$E803, $0004, $005C
		dc.w	$0802, $0004, $005C
Offset_0x02DA52:
		dc.w	$0018
		dc.w	$E008, $0004, $FFAC
		dc.w	$E803, $0004, $FFA4
		dc.w	$0801, $0004, $FFA4
		dc.w	$E801, $0004, $FFC4
		dc.w	$0008, $0004, $FFB4
		dc.w	$0801, $0004, $FFC4
		dc.w	$1808, $0004, $FFAC
		dc.w	$E008, $0004, $FFDC
		dc.w	$E803, $0004, $FFD4
		dc.w	$0801, $0004, $FFD4
		dc.w	$E803, $0004, $FFF4
		dc.w	$0801, $0004, $FFF4
		dc.w	$1808, $0004, $FFDC
		dc.w	$E000, $0004, $0014
		dc.w	$E801, $0004, $000C
		dc.w	$E801, $0004, $001C
		dc.w	$F803, $0004, $0004
		dc.w	$1800, $0004, $0004
		dc.w	$0808, $0004, $000C
		dc.w	$F803, $0004, $0024
		dc.w	$1800, $0004, $0024
		dc.w	$E003, $0004, $0034
		dc.w	$0003, $0004, $0034
		dc.w	$180C, $0004, $003C
Offset_0x02DAE4:
		dc.w	$0000
;-------------------------------------------------------------------------------
Obj_Timer_P1:						   ; Offset_0x02DAE6
		move.l	#((M68K_RAM_Start+$7000)&$00FFFFFF), Obj_Map(A0) ; $00FF7000, $000C
		move.w	#$8600, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$40, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$00C8, Obj_X(A0)				 ; $0010
		move.w	#$0090, Obj_Y(A0)				 ; $0014
		bset	#$03, Obj_Flags(A0)				 ; $0004
		lea		(Timer_Mappings), A1		   ; Offset_0x02DC9C
		lea		((M68K_RAM_Start+$7000)&$00FFFFFF), A2		 ; $00FF7000
		move.w	#$001C, D0
Offset_0x02DB28:
		move.w	(A1)+, (A2)+
		dbra	D0, Offset_0x02DB28
		move.l	#Offset_0x02DB34, (A0)
Offset_0x02DB34:
		lea		(Timer).w, A1			; $FFFFFE22
		lea		((M68K_RAM_Start+$700A)&$00FFFFFF), A2		 ; $00FF700A
		lea		(Timer_minute).w, A3		   ; $FFFFFE23
		lea		(Update_HUD_timer).w, A4			   ; $FFFFFE1E
		bra.s	Show_Timer					   ; Offset_0x02DBA8
;-------------------------------------------------------------------------------
Obj_Timer_P2:						   ; Offset_0x02DB48
		move.l	#((M68K_RAM_Start+$7080)&$00FFFFFF), Obj_Map(A0) ; $00FF7080, $000C
		move.w	#$8600, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$40, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$00C8, Obj_X(A0)				 ; $0010
		move.w	#$0090, Obj_Y(A0)				 ; $0014
		bset	#$04, Obj_Flags(A0)				 ; $0004
		lea		(Timer_Mappings), A1		   ; Offset_0x02DC9C
		lea		((M68K_RAM_Start+$7080)&$00FFFFFF), A2		 ; $00FF7080
		move.w	#$001C, D0
Offset_0x02DB8A:
		move.w	(A1)+, (A2)+
		dbra	D0, Offset_0x02DB8A
		move.l	#Offset_0x02DB96, (A0)
Offset_0x02DB96:
		lea		(Time_Count_Address_P2).w, A1		 ; $FFFFFED2
		lea		((M68K_RAM_Start+$708A)&$00FFFFFF), A2		 ; $00FF708A
		lea		(Timer_Minute_Count_Address_P2).w, A3		 ; $FFFFFED3
		lea		(HUD_Timer_Refresh_Flag_P2).w, A4			 ; $FFFFFECA
;-------------------------------------------------------------------------------
Show_Timer:							   ; Offset_0x02DBA8
		tst.b	(A4)
		beq.s	Offset_0x02DBDC
		bmi.s	Offset_0x02DBDC
		cmpi.l	#$00093B3B, (A1)+
		beq.w	Offset_0x02DBDC
		addq.b	#$01, -(A1)
		cmpi.b	#$3C, (A1)
		bcs.s	Offset_0x02DBDC
		move.b	#$00, (A1)
		addq.b	#$01, -(A1)
		cmpi.b	#$3C, (A1)
		bcs.s	Offset_0x02DBDC
		move.b	#$00, (A1)
		addq.b	#$01, -(A1)
		cmpi.b	#$09, (A1)
		bcs.s	Offset_0x02DBDC
		move.b	#$09, (A1)
Offset_0x02DBDC:
		lea		Timer_Number_Mappings(PC), A1		   ; Offset_0x02DC38
		moveq	#$00, D0
		move.b	(A3)+, D0
		lsl.w	#$02, D0
		move.l	(A1, D0), (A2)+
		addq.w	#$08, A2
		moveq	#$00, D0
		move.b	(A3)+, D0
		moveq	#$00, D2
Offset_0x02DBF2:
		subi.w	#$000A, D0
		bcs.s	Offset_0x02DBFC
		addq.w	#$04, D2
		bra.s	Offset_0x02DBF2
Offset_0x02DBFC:
		addi.w	#$000A, D0
		move.l	(A1, D2), (A2)+
		addq.w	#$02, A2
		lsl.w	#$02, D0
		move.l	(A1, D0), (A2)+
		addq.w	#$08, A2
		moveq	#$00, D0
		move.b	(A3)+, D0
		move.b	CentiSecond_Table(PC, D0), D0		   ; Offset_0x02DC60
		moveq	#$00, D2
Offset_0x02DC18:
		subi.w	#$000A, D0
		bcs.s	Offset_0x02DC22
		addq.w	#$04, D2
		bra.s	Offset_0x02DC18
Offset_0x02DC22:
		addi.w	#$000A, D0
		move.l	(A1, D2), (A2)+
		addq.w	#$02, A2
		lsl.w	#$02, D0
		move.l	(A1, D0), (A2)+
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Timer_Number_Mappings:						   ; Offset_0x02DC38
		dc.w	$F805, $0008
		dc.w	$F801, $000C
		dc.w	$F805, $000E
		dc.w	$F805, $0012
		dc.w	$F805, $0016
		dc.w	$F805, $001A
		dc.w	$F805, $001E
		dc.w	$F805, $0022
		dc.w	$F805, $0026
		dc.w	$F805, $002A
;-------------------------------------------------------------------------------
CentiSecond_Table:							   ; Offset_0x02DC60
		dc.b	$00, $01, $03, $05, $06, $08
		dc.b	$0A, $0B, $0D, $0F, $10, $12
		dc.b	$14, $15, $17, $19, $1A, $1C
		dc.b	$1E, $1F, $21, $23, $24, $26
		dc.b	$28, $29, $2B, $2D, $2E, $30
		dc.b	$32, $33, $35, $37, $38, $3A
		dc.b	$3C, $3D, $3F, $41, $42, $44
		dc.b	$46, $47, $49, $4B, $4C, $4E
		dc.b	$50, $51, $53, $55, $56, $58
		dc.b	$5A, $5B, $5D, $5F, $60, $62
;-------------------------------------------------------------------------------
Timer_Mappings:						   ; Offset_0x02DC9C
		dc.w	Offset_0x02DC9E-Timer_Mappings
Offset_0x02DC9E:
		dc.w	$0009
		dc.w	$F80D, $0000, $FFC0
		dc.w	$F805, $0008, $FFE8
		dc.w	$F801, $0030, $FFF4
		dc.w	$F805, $0008, $FFFC
		dc.w	$F805, $0008, $0008
		dc.w	$F000, $002E, $0014
		dc.w	$F805, $0008, $001C
		dc.w	$F805, $0008, $0028
		dc.w	$F000, $002F, $0034
;-------------------------------------------------------------------------------
Offset_0x02DCD6:
		move.l	#Offset_0x02DD72, Obj_Map(A0)			 ; $000C
		move.w	#$8750, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0120, Obj_X(A0)				 ; $0010
		move.w	#$00E0, Obj_Y(A0)				 ; $0014
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02DD16
		bset	#$04, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x02DD4A, (A0)
		bra.s	Offset_0x02DD4A
Offset_0x02DD16:
		bset	#$03, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x02DD22, (A0)
Offset_0x02DD22:
		moveq	#$00, D0
		tst.w	(Ring_count).w				 ; $FFFFFE20
		beq.s	Offset_0x02DD2C
		moveq	#$03, D0
Offset_0x02DD2C:
		btst	#$02, (Obj_Player_One+Obj_Player_Status).w	 ; $FFFFB02F
		beq.s	Offset_0x02DD40
		moveq	#$01, D0
		cmpi.w	#$0C00, (Sonic_Max_Speed).w			 ; $FFFFF760
		beq.s	Offset_0x02DD40
		moveq	#$02, D0
Offset_0x02DD40:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02DD4A:
		moveq	#$00, D0
		tst.w	(Ring_Count_Address_P2).w			 ; $FFFFFED0
		beq.s	Offset_0x02DD54
		moveq	#$03, D0
Offset_0x02DD54:
		btst	#$02, (Obj_Player_Two+Obj_Player_Status).w	 ; $FFFFB079
		beq.s	Offset_0x02DD68
		moveq	#$01, D0
		cmpi.w	#$0C00, (Miles_Max_Speed).w			 ; $FFFFFEC0
		beq.s	Offset_0x02DD68
		moveq	#$02, D0
Offset_0x02DD68:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02DD72:
		dc.w	Offset_0x02DD7A-Offset_0x02DD72
		dc.w	Offset_0x02DD94-Offset_0x02DD72
		dc.w	Offset_0x02DDB4-Offset_0x02DD72
		dc.w	Offset_0x02DDD4-Offset_0x02DD72
Offset_0x02DD7A:
		dc.w	$0004
		dc.w	$F00C, $0000, $FFF0
		dc.w	$F801, $0004, $FFF0
		dc.w	$F801, $0804, $0008
		dc.w	$080C, $1000, $FFF0
Offset_0x02DD94:
		dc.w	$0005
		dc.w	$F00C, $0000, $FFF0
		dc.w	$F801, $0004, $FFF0
		dc.w	$F801, $0804, $0008
		dc.w	$080C, $1000, $FFF0
		dc.w	$F805, $FC76, $FFF8
Offset_0x02DDB4:
		dc.w	$0005
		dc.w	$F00C, $0000, $FFF0
		dc.w	$F801, $0004, $FFF0
		dc.w	$F801, $0804, $0008
		dc.w	$080C, $1000, $FFF0
		dc.w	$F805, $FC7A, $FFF8
Offset_0x02DDD4:
		dc.w	$0005
		dc.w	$F00C, $0000, $FFF0
		dc.w	$F801, $0004, $FFF0
		dc.w	$F801, $0804, $0008
		dc.w	$080C, $1000, $FFF0
		dc.w	$F805, $5C82, $FFF8
;-------------------------------------------------------------------------------
Offset_0x02DDF4:
		move.l	#Offset_0x02DEF4, Obj_Map(A0)			 ; $000C
		move.w	#$875E, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.b	#$04, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Height(A0)					 ; $0006
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02DE40
		move.w	#$0090, Obj_X(A0)				 ; $0010
		move.w	#$0084, Obj_Y(A0)				 ; $0014
		move.w	(Obj_Player_Two+Obj_X).w, Obj_Control_Var_00(A0) ; $FFFFB05A, $0030
		bset	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		move.l	#Offset_0x02DEAA, (A0)
		bra.s	Offset_0x02DEAA
Offset_0x02DE40:
		move.w	#$0090, Obj_X(A0)				 ; $0010
		move.w	#$00E8, Obj_Y(A0)				 ; $0014
		move.w	(Obj_Player_One+Obj_X).w, Obj_Control_Var_00(A0) ; $FFFFB010, $0030
		bset	#$03, Obj_Flags(A0)				 ; $0004
		move.l	#Offset_0x02DE5E, (A0)
Offset_0x02DE5E:
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
Offset_0x02DE62:
		move.w	D0, D1
		sub.w	Obj_Control_Var_00(A0), D0				 ; $0030
		beq.s	Offset_0x02DE8A
		bcc.s	Offset_0x02DE78
		cmpi.w	#$FE00, D0
		bge.s	Offset_0x02DE82
		addi.w	#$0400, D0
		bra.s	Offset_0x02DE82
Offset_0x02DE78:
		cmpi.w	#$0200, D0
		blt.s	Offset_0x02DE82
		subi.w	#$0400, D0
Offset_0x02DE82:
		add.w	D0, Obj_Control_Var_04(A0)				 ; $0034
		move.w	D1, Obj_Control_Var_00(A0)				 ; $0030
Offset_0x02DE8A:
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		asr.w	#$06, D0
		addi.w	#$0090, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		lea		(Offset_0x02DEB0).l, A1
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02DEAA:
		move.w	(Obj_Player_Two+Obj_X).w, D0		 ; $FFFFB05A
		bra.s	Offset_0x02DE62
;-------------------------------------------------------------------------------
Offset_0x02DEB0:
		dc.w	Offset_0x02DEB4-Offset_0x02DEB0
		dc.w	Offset_0x02DED4-Offset_0x02DEB0
Offset_0x02DEB4:
		dc.b	$3B, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $FF
Offset_0x02DED4:
		dc.b	$3B, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $02, $02, $02, $02, $02
		dc.b	$02, $02, $02, $02, $02, $04, $04, $04
		dc.b	$04, $04, $04, $04, $04, $04, $04, $FF
;-------------------------------------------------------------------------------
Offset_0x02DEF4:
		dc.w	Offset_0x02DEFE-Offset_0x02DEF4
		dc.w	Offset_0x02DF06-Offset_0x02DEF4
		dc.w	Offset_0x02DF0E-Offset_0x02DEF4
		dc.w	Offset_0x02DF16-Offset_0x02DEF4
		dc.w	Offset_0x02DF1E-Offset_0x02DEF4
Offset_0x02DEFE:
		dc.w	$0001
		dc.w	$FC00, $0000, $FFFC
Offset_0x02DF06:
		dc.w	$0001
		dc.w	$FC00, $0001, $FFFC
Offset_0x02DF0E:
		dc.w	$0001
		dc.w	$FC00, $0002, $FFFC
Offset_0x02DF16:
		dc.w	$0001
		dc.w	$FC00, $0003, $FFFC
Offset_0x02DF1E:
		dc.w	$0001
		dc.w	$FC00, $0004, $FFFC
;===============================================================================
; Objeto 0x65 - Indicador de fim de fase no modo 2 jogadores
; <<<-
;===============================================================================