;===============================================================================
; Objeto de controle do Sonic / Miles / Knuckles embaixo da água
; ->>>
;===============================================================================
; Offset_0x00F38C:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x00F39A(PC, D0), D1
		jmp		Offset_0x00F39A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00F39A:
		dc.w	Offset_0x00F3AC-Offset_0x00F39A
		dc.w	Offset_0x00F404-Offset_0x00F39A
		dc.w	Offset_0x00F410-Offset_0x00F39A
		dc.w	Offset_0x00F47C-Offset_0x00F39A
		dc.w	Offset_0x00F490-Offset_0x00F39A
		dc.w	Offset_0x00F68E-Offset_0x00F39A
		dc.w	Offset_0x00F496-Offset_0x00F39A
		dc.w	Offset_0x00F4D6-Offset_0x00F39A
		dc.w	Offset_0x00F490-Offset_0x00F39A
;-------------------------------------------------------------------------------
Offset_0x00F3AC:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Sonic_Underwater_Mappings, Obj_Map(A0) ; Offset_0x025872, $000C
		tst.b	Obj_Player_One_Or_Two_2(A0)				 ; $0043
		beq.s	Offset_0x00F3C6
		move.l	#Miles_Underwater_Mappings, Obj_Map(A0) ; Offset_0x0258A0, $000C
Offset_0x00F3C6:
		move.w	#$045C, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$84, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x00F3F4
		addq.b	#$08, Obj_Routine(A0)					 ; $0005
		andi.w	#$007F, D0
		move.b	D0, Obj_Player_Hit_Flag(A0)				 ; $0037
		bra.w	Offset_0x00F68E
Offset_0x00F3F4:
		move.b	D0, Obj_Ani_Number(A0)					 ; $0020
		move.w	Obj_X(A0), Obj_P_Invunerblt_Time(A0)	  ; $0010, $0034
		move.w	#$FF00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x00F404:
		lea		(Bubbles_Animate_Data).l, A1			 ; Offset_0x00F8E0
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
Offset_0x00F410:
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x00F436
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		addq.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		cmpi.b	#$0D, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x00F47C
		bcs.s	Offset_0x00F47C
		move.b	#$0D, Obj_Ani_Number(A0)				 ; $0020
		bra.s	Offset_0x00F47C
Offset_0x00F436:
		tst.w	(Sonic_Wind_Flag).w					 ; $FFFFF7C8
		beq.s	Offset_0x00F440
		addq.w	#$04, Obj_P_Invunerblt_Time(A0)			 ; $0034
Offset_0x00F440:
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$01, Obj_Angle(A0)				 ; $0026
		andi.w	#$007F, D0
		lea		(Offset_0x00F546).l, A1
		move.b	(A1, D0), D0
		ext.w	D0
		add.w	Obj_P_Invunerblt_Time(A0), D0			 ; $0034
		move.w	D0, Obj_X(A0)					 ; $0010
		bsr.w	Offset_0x00F4FA
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x00F476
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x00F476:
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x00F47C:
		bsr.s	Offset_0x00F4FA
		lea		(Bubbles_Animate_Data).l, A1			 ; Offset_0x00F8E0
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x00F490:
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x00F496:
		move.l	Obj_Player_Jump(A0), A2					 ; $0040
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bhi.s	Offset_0x00F4D0
		subq.w	#$01, Obj_Player_St_Convex(A0)			 ; $003C
		bne.s	Offset_0x00F4B4
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		addq.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		bra.s	Offset_0x00F47C
Offset_0x00F4B4:
		lea		(Bubbles_Animate_Data).l, A1			 ; Offset_0x00F8E0
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
		bsr.w	Offset_0x00F646
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x00F4D0
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x00F4D0:
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x00F4D6:
		move.l	Obj_Player_Jump(A0), A2					 ; $0040
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bhi.s	Offset_0x00F490
		bsr.s	Offset_0x00F4FA
		lea		(Bubbles_Animate_Data).l, A1			 ; Offset_0x00F8E0
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
		bsr.w	Offset_0x00F646
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x00F4FA:
		tst.w	Obj_Player_St_Convex(A0)				 ; $003C
		beq.s	Offset_0x00F544
		subq.w	#$01, Obj_Player_St_Convex(A0)			 ; $003C
		bne.s	Offset_0x00F544
		cmpi.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		bcc.s	Offset_0x00F544
		move.w	#$000F, Obj_Player_St_Convex(A0)		 ; $003C
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		move.b	#$80, Obj_Flags(A0)				 ; $0004
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$0080, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		addi.w	#$0080, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
Offset_0x00F544:
		rts
;-------------------------------------------------------------------------------
Offset_0x00F546:
		dc.b	$00, $00, $00, $00, $00, $00, $01, $01
		dc.b	$01, $01, $01, $02, $02, $02, $02, $02
		dc.b	$02, $02, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $02
		dc.b	$02, $02, $02, $02, $02, $02, $01, $01
		dc.b	$01, $01, $01, $00, $00, $00, $00, $00
		dc.b	$00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
		dc.b	$FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
		dc.b	$FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
		dc.b	$FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
		dc.b	$FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $01, $01
		dc.b	$01, $01, $01, $02, $02, $02, $02, $02
		dc.b	$02, $02, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $03
		dc.b	$03, $03, $03, $03, $03, $03, $03, $02
		dc.b	$02, $02, $02, $02, $02, $02, $01, $01
		dc.b	$01, $01, $01, $00, $00, $00, $00, $00
		dc.b	$00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
		dc.b	$FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
		dc.b	$FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
		dc.b	$FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
		dc.b	$FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF
;-------------------------------------------------------------------------------
Offset_0x00F646:
		moveq	#$00, D1
		move.b	Obj_Map_Id(A0), D1				 ; $0022
		cmpi.b	#$09, D1
		bcs.s	Offset_0x00F68C
		cmpi.b	#$13, D1
		bcc.s	Offset_0x00F68C
		cmp.b	Obj_P_Horiz_Ctrl_Lock(A0), D1			 ; $0032
		beq.s	Offset_0x00F68C
		move.b	D1, Obj_P_Horiz_Ctrl_Lock(A0)			 ; $0032
		subi.w	#$0009, D1
		move.w	D1, D0
		add.w	D1, D1
		add.w	D0, D1
		lsl.w	#$06, D1
		addi.l	#Art_Oxygen_Numbers, D1		   ; Offset_0x0A8640
		move.w	#$FC00, D2
		tst.b	Obj_Player_One_Or_Two_2(A0)				 ; $0043
		beq.s	Offset_0x00F682
		move.w	#$FE00, D2
Offset_0x00F682:
		move.w	#$0060, D3
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
Offset_0x00F68C:
		rts
;-------------------------------------------------------------------------------
Offset_0x00F68E:
		move.l	Obj_Player_Jump(A0), A2					 ; $0040
		tst.w	Obj_P_Flips_Remaining(A0)				 ; $0030
		bne.w	Offset_0x00F78C
		cmpi.b	#$06, Obj_Routine(A2)					 ; $0005
		bcc.w	Offset_0x00F89C
		btst	#$06, Obj_Status(A2)					 ; $002A
		beq.w	Offset_0x00F89C
		subq.w	#$01, Obj_Player_St_Convex(A0)			 ; $003C
		bpl.w	Offset_0x00F7B0
		move.w	#$003B, Obj_Player_St_Convex(A0)		 ; $003C
		move.w	#$0001, Obj_Player_Next_Tilt(A0)		 ; $003A
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$0001, D0
		move.b	D0, Obj_Player_Selected(A0)				 ; $0038
		moveq	#$00, D0
		move.b	Obj_Subtype(A2), D0				 ; $002C
		cmpi.w	#$0019, D0
		beq.s	Offset_0x00F712
		cmpi.w	#$0014, D0
		beq.s	Offset_0x00F712
		cmpi.w	#$000F, D0
		beq.s	Offset_0x00F712
		cmpi.w	#$000C, D0
		bhi.s	Offset_0x00F720
		bne.s	Offset_0x00F6FE
		tst.b	Obj_Player_One_Or_Two_2(A0)				 ; $0043
		bne.s	Offset_0x00F6FE
		moveq	#Panic_Snd, D0					   ; $31
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x00F6FE:
		subq.b	#$01, Obj_P_Spd_Shoes_Time(A0)			 ; $0036
		bpl.s	Offset_0x00F720
		move.b	Obj_Player_Hit_Flag(A0), Obj_P_Spd_Shoes_Time(A0) ; $0036, $0037
		bset	#$07, Obj_Player_Next_Tilt(A0)			 ; $003A
		bra.s	Offset_0x00F720
Offset_0x00F712:
		tst.b	Obj_Player_One_Or_Two_2(A0)				 ; $0043
		bne.s	Offset_0x00F720
		moveq	#Underwater_Sfx, D0				   ; $79
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x00F720:
		subq.b	#$01, Obj_Subtype(A2)					 ; $002C
		bcc.w	Offset_0x00F7AE
		move.b	#$81, Obj_Player_Control(A2)			 ; $002E
		move.w	#Drowning_Sfx, D0				 ; $003B
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$0A, Obj_Player_Selected(A0)			 ; $0038
		move.w	#$0001, Obj_Player_Next_Tilt(A0)		 ; $003A
		move.w	#$0078, Obj_P_Flips_Remaining(A0)		 ; $0030
		move.l	A2, A1
		bsr.w	ResumeMusic					  ; Offset_0x00F89E
		move.l	A0, -(A7)
		move.l	A2, A0
		bsr.w	Sonic_ResetOnFloor			   ; Offset_0x00BF76
		move.b	#$17, Obj_Ani_Number(A0)				 ; $0020
		bset	#$01, Obj_Status(A0)					 ; $002A
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0000, Obj_Inertia(A0)					 ; $001C
		move.l	(A7)+, A0
		cmpa.w	#Obj_Player_One, A2				 ; $B000
		bne.s	Offset_0x00F78A
		move.b	#$01, (Rasters_Flag).w				 ; $FFFFEE30
Offset_0x00F78A:
		rts
Offset_0x00F78C:
		subq.w	#$01, Obj_P_Flips_Remaining(A0)			 ; $0030
		bne.s	Offset_0x00F79A
		move.b	#$06, Obj_Routine(A2)					 ; $0005
		rts
Offset_0x00F79A:
		move.l	A0, -(A7)
		move.l	A2, A0
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0010, Obj_Speed_Y(A0)					 ; $001A
		move.l	(A7)+, A0
		bra.s	Offset_0x00F7B0
Offset_0x00F7AE:
		bra.s	Offset_0x00F7C0
Offset_0x00F7B0:
		tst.w	Obj_Player_Next_Tilt(A0)				 ; $003A
		beq.w	Offset_0x00F89C
		subq.w	#$01, Obj_Player_Spdsh_Cnt(A0)			 ; $003E
		bpl.w	Offset_0x00F89C
Offset_0x00F7C0:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$000F, D0
		addq.w	#$08, D0
		move.w	D0, Obj_Player_Spdsh_Cnt(A0)			 ; $003E
		jsr		(AllocateObject).l			   ; Offset_0x011DD8
		bne.w	Offset_0x00F89C
		move.l	(A0), (A1)
		move.w	Obj_X(A2), Obj_X(A1)			  ; $0010, $0010
		moveq	#$06, D0
		btst	#$00, Obj_Status(A2)					 ; $002A
		beq.s	Offset_0x00F7F4
		neg.w	D0
		move.b	#$40, Obj_Angle(A1)				 ; $0026
Offset_0x00F7F4:
		add.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A2), Obj_Y(A1)			  ; $0014, $0014
		move.l	Obj_Player_Jump(A0), Obj_Player_Jump(A1)  ; $0040, $0040
		move.b	#$06, Obj_Subtype(A1)					 ; $002C
		tst.w	Obj_P_Flips_Remaining(A0)				 ; $0030
		beq.w	Offset_0x00F846
		andi.w	#$0007, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		addi.w	#$0000, Obj_Player_Spdsh_Cnt(A0)		 ; $003E
		move.w	Obj_Y(A2), D0					 ; $0014
		subi.w	#$000C, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.b	D0, Obj_Angle(A1)				 ; $0026
		move.w	(Level_Frame_Count).w, D0			 ; $FFFFFE04
		andi.b	#$03, D0
		bne.s	Offset_0x00F892
		move.b	#$0E, Obj_Subtype(A1)					 ; $002C
		bra.s	Offset_0x00F892
Offset_0x00F846:
		btst	#$07, Obj_Player_Next_Tilt(A0)			 ; $003A
		beq.s	Offset_0x00F892
		moveq	#$00, D2
		move.b	Obj_Subtype(A2), D2				 ; $002C
		cmpi.b	#$0C, D2
		bcc.s	Offset_0x00F892
		lsr.w	#$01, D2
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$0003, D0
		bne.s	Offset_0x00F87A
		bset	#$06, Obj_Player_Next_Tilt(A0)			 ; $003A
		bne.s	Offset_0x00F892
		move.b	D2, Obj_Subtype(A1)				 ; $002C
		move.w	#$001C, Obj_Player_St_Convex(A1)		 ; $003C
Offset_0x00F87A:
		tst.b	Obj_Player_Selected(A0)					 ; $0038
		bne.s	Offset_0x00F892
		bset	#$06, Obj_Player_Next_Tilt(A0)			 ; $003A
		bne.s	Offset_0x00F892
		move.b	D2, Obj_Subtype(A1)				 ; $002C
		move.w	#$001C, Obj_Player_St_Convex(A1)		 ; $003C
Offset_0x00F892:
		subq.b	#$01, Obj_Player_Selected(A0)			 ; $0038
		bpl.s	Offset_0x00F89C
		clr.w	Obj_Player_Next_Tilt(A0)				 ; $003A
Offset_0x00F89C:
		rts
;===============================================================================
; Objeto de controle do Sonic / Miles / Knuckles embaixo da água
; <<<-
;===============================================================================