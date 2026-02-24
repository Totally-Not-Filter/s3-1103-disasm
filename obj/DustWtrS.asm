;-------------------------------------------------------------------------------
; Poeira do Spindash, Freio e Splash de água
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x00FD62:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x00FD70(PC, D0), D1
		jmp		Offset_0x00FD70(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00FD70:
		dc.w	Offset_0x00FD78-Offset_0x00FD70
		dc.w	Offset_0x00FDCE-Offset_0x00FD70
		dc.w	Offset_0x00FE84-Offset_0x00FD70
		dc.w	Offset_0x00FE88-Offset_0x00FD70
;-------------------------------------------------------------------------------
Offset_0x00FD78:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Dust_Water_Splash_Mappings, Obj_Map(A0) ; Offset_0x00FF98, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$07E0, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#Obj_Player_One, Obj_Player_Last(A0)	  ; $B000, $0042
		move.w	#$FC00, Obj_Control_Var_10(A0)			 ; $0040
		cmpa.w	#Obj_P1_Dust_Water_Splash, A0			 ; $CC54
		beq.s	Offset_0x00FDCE
		move.b	#$01, Obj_Control_Var_08(A0)			 ; $0038
		cmpi.w	#Miles_Alone, (Player_Selected_Flag).w ; $0002, $FFFFFF08
		beq.s	Offset_0x00FDCE
		move.w	#$07F0, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#Obj_Player_Two, Obj_Player_Last(A0)	  ; $B04A, $0042
		move.w	#$FE00, Obj_Control_Var_10(A0)			 ; $0040
;-------------------------------------------------------------------------------
Offset_0x00FDCE:
		move.w	Obj_Player_Last(A0), A2					 ; $0042
		moveq	#$00, D0
		move.b	Obj_Ani_Number(A0), D0					 ; $0020
		add.w	D0, D0
		move.w	Offset_0x00FDE2(PC, D0), D1
		jmp		Offset_0x00FDE2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00FDE2:
		dc.w	Offset_0x00FE66-Offset_0x00FDE2
		dc.w	Offset_0x00FDEA-Offset_0x00FDE2
		dc.w	Offset_0x00FE0A-Offset_0x00FDE2
		dc.w	Offset_0x00FE5E-Offset_0x00FDE2
;-------------------------------------------------------------------------------
Offset_0x00FDEA:
		move.w	(Water_Level_Move).w, Obj_Y(A0)		  ; $FFFFF646, $0014
		tst.b	Obj_Ani_Flag(A0)				 ; $0021
		bne.s	Offset_0x00FE66
		move.w	Obj_X(A2), Obj_X(A0)			  ; $0010, $0010
		move.b	#$00, Obj_Status(A0)					 ; $002A
		andi.w	#$7FFF, Obj_Art_VRAM(A0)				 ; $000A
		bra.s	Offset_0x00FE66
;-------------------------------------------------------------------------------
Offset_0x00FE0A:
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bcs.s	Offset_0x00FE7C
		cmpi.b	#$04, Obj_Routine(A2)					 ; $0005
		bcc.s	Offset_0x00FE7C
		tst.b	Obj_Player_Spdsh_Flag(A2)				 ; $003D
		beq.s	Offset_0x00FE7C
		move.w	Obj_X(A2), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A0)			  ; $0014, $0014
		move.b	Obj_Status(A2), Obj_Status(A0)			  ; $002A, $002A
		andi.b	#$01, Obj_Status(A0)					 ; $002A
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x00FE44
		subi.w	#$0004, Obj_Y(A0)				 ; $0014
Offset_0x00FE44:
		tst.b	Obj_Ani_Flag(A0)				 ; $0021
		bne.s	Offset_0x00FE66
		andi.w	#$7FFF, Obj_Art_VRAM(A0)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x00FE66
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
		bra.s	Offset_0x00FE66
;-------------------------------------------------------------------------------
Offset_0x00FE5E:
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bcs.s	Offset_0x00FE7C
;-------------------------------------------------------------------------------
Offset_0x00FE66:
		lea		(Dust_Water_Splash_Animate_Data).l, A1	 ; Offset_0x00FF72
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		bsr.w	Offset_0x00FF1E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x00FE7C:
		move.b	#$00, Obj_Ani_Number(A0)				 ; $0020
		rts
;-------------------------------------------------------------------------------
Offset_0x00FE84:
		bra.w	DeleteObject				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x00FE88:
		move.w	Obj_Player_Last(A0), A2					 ; $0042
		cmpi.b	#$0D, Obj_Ani_Number(A2)				 ; $0020
		beq.s	Offset_0x00FEA2
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Control_Var_06(A0)			 ; $0036
		rts
Offset_0x00FEA2:
		subq.b	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bpl.s	Offset_0x00FF1A
		move.b	#$03, Obj_Control_Var_06(A0)			 ; $0036
		bsr.w	AllocateObject				 ; Offset_0x011DD8
		bne.s	Offset_0x00FF1A
		move.l	(A0), (A1)
		move.w	Obj_X(A2), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$0010, Obj_Y(A1)				 ; $0014
		tst.b	Obj_Control_Var_08(A0)					 ; $0038
		beq.s	Offset_0x00FED4
		subi.w	#$0004, Obj_Y(A1)				 ; $0014
Offset_0x00FED4:
		move.b	#$00, Obj_Status(A1)					 ; $002A
		move.b	#$03, Obj_Ani_Number(A1)				 ; $0020
		addq.b	#$02, Obj_Routine(A1)					 ; $0005
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
		move.b	#$04, Obj_Width(A1)				 ; $0007
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	Obj_Player_Last(A0), Obj_Player_Last(A1)  ; $0042, $0042
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x00FF1A
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x00FF1A:
		bsr.s	Offset_0x00FF1E
		rts
Offset_0x00FF1E:
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		cmp.b	Obj_Control_Var_04(A0), D0				 ; $0034
		beq.s	Offset_0x00FF70
		move.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		lea		(Dust_Water_Splash_Dyn_Script).l, A2	 ; Offset_0x010066
		add.w	D0, D0
		adda.w	(A2, D0), A2
		move.w	(A2)+, D5
		subq.w	#$01, D5
		bmi.s	Offset_0x00FF70
		move.w	Obj_Control_Var_10(A0), D4				 ; $0040
Offset_0x00FF44:
		moveq	#$00, D1
		move.w	(A2)+, D1
		move.w	D1, D3
		lsr.w	#$08, D3
		andi.w	#$00F0, D3
		addi.w	#$0010, D3
		andi.w	#$0FFF, D1
		lsl.l	#$05, D1
		addi.l	#Art_Dust_Water_Splash, D1			   ; Offset_0x081220
		move.w	D4, D2
		add.w	D3, D4
		add.w	D3, D4
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
		dbra	D5, Offset_0x00FF44
Offset_0x00FF70:
		rts
;-------------------------------------------------------------------------------
Dust_Water_Splash_Animate_Data:				   ; Offset_0x00FF72
		dc.w	Offset_0x00FF7A-Dust_Water_Splash_Animate_Data
		dc.w	Offset_0x00FF7D-Dust_Water_Splash_Animate_Data
		dc.w	Offset_0x00FF89-Dust_Water_Splash_Animate_Data
		dc.w	Offset_0x00FF92-Dust_Water_Splash_Animate_Data
Offset_0x00FF7A:
		dc.b	$1F, $00, $FF
Offset_0x00FF7D:
		dc.b	$03, $01, $02, $03, $04, $05, $06, $07
		dc.b	$08, $09, $FD, $00
Offset_0x00FF89:
		dc.b	$01, $0A, $0B, $0C, $0D, $0E, $0F, $10
		dc.b	$FF
Offset_0x00FF92:
		dc.b	$03, $11, $12, $13, $14, $FC
;-------------------------------------------------------------------------------
Dust_Water_Splash_Mappings:					   ; Offset_0x00FF98
		dc.w	Offset_0x00FFC4-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFC6-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFCE-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFD6-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFDE-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFE6-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFEE-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFF6-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFFE-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010006-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01000E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010016-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01001E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010026-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01002E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010036-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01003E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010046-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01004E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x010056-Dust_Water_Splash_Mappings
		dc.w	Offset_0x01005E-Dust_Water_Splash_Mappings
		dc.w	Offset_0x00FFC4-Dust_Water_Splash_Mappings
Offset_0x00FFC4:
		dc.w	$0000
Offset_0x00FFC6:
		dc.w	$0001
		dc.w	$F209, $0000, $FFF0
Offset_0x00FFCE:
		dc.w	$0001
		dc.w	$E20F, $0000, $FFF0
Offset_0x00FFD6:
		dc.w	$0001
		dc.w	$E20F, $0000, $FFF0
Offset_0x00FFDE:
		dc.w	$0001
		dc.w	$E20F, $0000, $FFF0
Offset_0x00FFE6:
		dc.w	$0001
		dc.w	$E20F, $0000, $FFF0
Offset_0x00FFEE:
		dc.w	$0001
		dc.w	$EA0E, $0000, $FFF0
Offset_0x00FFF6:
		dc.w	$0001
		dc.w	$F20D, $0000, $FFF0
Offset_0x00FFFE:
		dc.w	$0001
		dc.w	$FA0C, $0000, $FFF0
Offset_0x010006:
		dc.w	$0001
		dc.w	$FA0C, $0000, $FFF0
Offset_0x01000E:
		dc.w	$0001
		dc.w	$040D, $0000, $FFE0
Offset_0x010016:
		dc.w	$0001
		dc.w	$040D, $0000, $FFE0
Offset_0x01001E:
		dc.w	$0001
		dc.w	$040D, $0000, $FFE0
Offset_0x010026:
		dc.w	$0001
		dc.w	$FC0E, $0000, $FFE0
Offset_0x01002E:
		dc.w	$0001
		dc.w	$FC0E, $0000, $FFE0
Offset_0x010036:
		dc.w	$0001
		dc.w	$FC0E, $0000, $FFE0
Offset_0x01003E:
		dc.w	$0001
		dc.w	$FC0E, $0000, $FFE0
Offset_0x010046:
		dc.w	$0001
		dc.w	$F805, $0000, $FFF8
Offset_0x01004E:
		dc.w	$0001
		dc.w	$F805, $0004, $FFF8
Offset_0x010056:
		dc.w	$0001
		dc.w	$F805, $0008, $FFF8
Offset_0x01005E:
		dc.w	$0001
		dc.w	$F805, $000C, $FFF8
;-------------------------------------------------------------------------------
Dust_Water_Splash_Dyn_Script:				   ; Offset_0x010066
		dc.w	Offset_0x010092-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x010094-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x010098-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x01009C-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100A0-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100A4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100A8-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100AC-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100B0-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100B4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100B8-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100BC-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100C0-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100C4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100C8-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100CC-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D0-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D4-Dust_Water_Splash_Dyn_Script
		dc.w	Offset_0x0100D6-Dust_Water_Splash_Dyn_Script
Offset_0x010092:
		dc.w	$0000
Offset_0x010094:
		dc.w	$0001
		dc.w	$5000
Offset_0x010098:
		dc.w	$0001
		dc.w	$F006
Offset_0x01009C:
		dc.w	$0001
		dc.w	$F016
Offset_0x0100A0:
		dc.w	$0001
		dc.w	$F026
Offset_0x0100A4:
		dc.w	$0001
		dc.w	$F036
Offset_0x0100A8:
		dc.w	$0001
		dc.w	$B046
Offset_0x0100AC:
		dc.w	$0001
		dc.w	$7052
Offset_0x0100B0:
		dc.w	$0001
		dc.w	$305A
Offset_0x0100B4:
		dc.w	$0001
		dc.w	$305E
Offset_0x0100B8:
		dc.w	$0001
		dc.w	$7062
Offset_0x0100BC:
		dc.w	$0001
		dc.w	$706A
Offset_0x0100C0:
		dc.w	$0001
		dc.w	$7072
Offset_0x0100C4:
		dc.w	$0001
		dc.w	$B07A
Offset_0x0100C8:
		dc.w	$0001
		dc.w	$B086
Offset_0x0100CC:
		dc.w	$0001
		dc.w	$B092
Offset_0x0100D0:
		dc.w	$0001
		dc.w	$B09E
Offset_0x0100D4:
		dc.w	$0000
Offset_0x0100D6:
		dc.w	$0001
		dc.w	$F0AA
;-------------------------------------------------------------------------------
; Poeira do Spindash, Freio e Splash de água
; <<<-
;-------------------------------------------------------------------------------