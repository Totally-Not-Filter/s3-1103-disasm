;===============================================================================
; Objeto 0x54 - Gerador de bolhas de oxigênio nas fases com água.
; ->>>
;===============================================================================
; Offset_0x025500:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x02550E(PC, D0), D1
		jmp		Offset_0x02550E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02550E:
		dc.w	Offset_0x02551A-Offset_0x02550E
		dc.w	Offset_0x025578-Offset_0x02550E
		dc.w	Offset_0x025592-Offset_0x02550E
		dc.w	Offset_0x0255F4-Offset_0x02550E
		dc.w	Offset_0x025612-Offset_0x02550E
		dc.w	Offset_0x025618-Offset_0x02550E
;-------------------------------------------------------------------------------
Offset_0x02551A:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Sonic_Underwater_Mappings, Obj_Map(A0) ; Offset_0x025872, $000C
		move.w	#$045C, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$84, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x02555E
		addq.b	#$08, Obj_Routine(A0)					 ; $0005
		andi.w	#$007F, D0
		move.b	D0, Obj_Control_Var_02(A0)				 ; $0032
		move.b	D0, Obj_Control_Var_03(A0)				 ; $0033
		move.b	#$08, Obj_Ani_Number(A0)				 ; $0020
		bra.w	Offset_0x025618
Offset_0x02555E:
		move.b	D0, Obj_Ani_Number(A0)					 ; $0020
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	#$FF78, Obj_Speed_Y(A0)					 ; $001A
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.b	D0, Obj_Angle(A0)				 ; $0026
;-------------------------------------------------------------------------------
Offset_0x025578:
		lea		(Oxygen_Bubbles_Animate_Data).l, A1		 ; Offset_0x02583E
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		cmpi.b	#$06, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x025592
		move.b	#$01, Obj_Timer(A0)				 ; $002E
;-------------------------------------------------------------------------------
Offset_0x025592:
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x0255AA
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		addq.b	#$04, Obj_Ani_Number(A0)				 ; $0020
		bra.w	Offset_0x0255F4
Offset_0x0255AA:
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$01, Obj_Angle(A0)				 ; $0026
		andi.w	#$007F, D0
		lea		(Offset_0x00F546).l, A1
		move.b	$00(A1, D0), D0
		ext.w	D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_X(A0)					 ; $0010
		tst.b	Obj_Timer(A0)					 ; $002E
		beq.s	Offset_0x0255DC
		bsr.w	Offset_0x025770
		cmpi.b	#$06, Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x0255F4
Offset_0x0255DC:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x0255EE
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0255EE:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0255F4:
		lea		(Oxygen_Bubbles_Animate_Data).l, A1		 ; Offset_0x02583E
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02560C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02560C:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x025612:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x025618:
		tst.w	Obj_Control_Var_06(A0)					 ; $0036
		bne.s	Offset_0x02567A
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.w	Offset_0x025724
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x025724
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bpl.w	Offset_0x025718
		move.w	#$0001, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x025640:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	D0, D1
		andi.w	#$0007, D0
		cmpi.w	#$0006, D0
		bcc.s	Offset_0x025640
		move.b	D0, Obj_Control_Var_04(A0)				 ; $0034
		andi.w	#$000C, D1
		lea		(Offset_0x02575E).l, A1
		adda.w	D1, A1
		move.l	A1, Obj_Control_Var_0C(A0)				 ; $003C
		subq.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bpl.s	Offset_0x025678
		move.b	Obj_Control_Var_03(A0), Obj_Control_Var_02(A0) ; $0033, $0032
		bset	#$07, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x025678:
		bra.s	Offset_0x025682
Offset_0x02567A:
		subq.w	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bpl.w	Offset_0x025718
Offset_0x025682:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$001F, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		jsr		(AllocateObject).l			 ; Offset_0x011DD8
		bne.s	Offset_0x0256FC
		move.l	(A0), (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$000F, D0
		subq.w	#$08, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		moveq	#$00, D0
		move.b	Obj_Control_Var_04(A0), D0				 ; $0034
		move.l	Obj_Control_Var_0C(A0), A2				 ; $003C
		move.b	$00(A2, D0), Obj_Subtype(A1)			 ; $002C
		btst	#$07, Obj_Control_Var_06(A0)			 ; $0036
		beq.s	Offset_0x0256FC
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$0003, D0
		bne.s	Offset_0x0256E8
		bset	#$06, Obj_Control_Var_06(A0)			 ; $0036
		bne.s	Offset_0x0256FC
		move.b	#$02, Obj_Subtype(A1)					 ; $002C
Offset_0x0256E8:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x0256FC
		bset	#$06, Obj_Control_Var_06(A0)			 ; $0036
		bne.s	Offset_0x0256FC
		move.b	#$02, Obj_Subtype(A1)					 ; $002C
Offset_0x0256FC:
		subq.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
		bpl.s	Offset_0x025718
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$007F, D0
		addi.w	#$0080, D0
		add.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		clr.w	Obj_Control_Var_06(A0)					 ; $0036
Offset_0x025718:
		lea		(Oxygen_Bubbles_Animate_Data).l, A1		 ; Offset_0x02583E
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
Offset_0x025724:
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x025746
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.w	Offset_0x025758
		rts
Offset_0x025746:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x025752
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x025752:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x025758:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02575E:
		dc.w	$0001, $0000, $0000, $0100, $0000, $0001, $0001, $0000
		dc.w	$0100
;-------------------------------------------------------------------------------
Offset_0x025770:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x02577A
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
Offset_0x02577A:
		tst.b	Obj_Timer(A1)					 ; $002E
		bmi.w	Offset_0x02583C
		move.w	Obj_X(A1), D0					 ; $0010
		move.w	Obj_X(A0), D1					 ; $0010
		subi.w	#$0010, D1
		cmp.w	D0, D1
		bcc.w	Offset_0x02583C
		addi.w	#$0020, D1
		cmp.w	D0, D1
		bcs.w	Offset_0x02583C
		move.w	Obj_Y(A1), D0					 ; $0014
		move.w	Obj_Y(A0), D1					 ; $0014
		cmp.w	D0, D1
		bcc.w	Offset_0x02583C
		addi.w	#$0010, D1
		cmp.w	D0, D1
		bcs.w	Offset_0x02583C
		jsr		(ResumeMusic)				  ; Offset_0x00F89E
		move.w	#Collect_Oxygen_Sfx, D0					 ; $0038
		jsr		(Play_Music).l					 ; Offset_0x001176
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		move.b	#$15, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$0023, Obj_Control_Var_02(A1)			 ; $0032
		move.b	#$00, Obj_Control_Var_10(A1)			 ; $0040
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bclr	#$04, Obj_Status(A1)					 ; $002A
		btst	#$02, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x02582A
		cmpi.l	#Obj_Sonic, (A1)			   ; Offset_0x00AA36
		bne.s	Offset_0x02581A
		bclr	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$13, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		subq.w	#$05, Obj_Y(A1)					 ; $0014
		bra.s	Offset_0x02582A
Offset_0x02581A:
		move.b	#$0F, Obj_Height_2(A1)					 ; $001E
		move.b	#$09, Obj_Width_2(A1)					 ; $001F
		subq.w	#$01, Obj_Y(A1)					 ; $0014
Offset_0x02582A:
		cmpi.b	#$06, Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x02583C
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		addq.b	#$04, Obj_Ani_Number(A0)				 ; $0020
Offset_0x02583C:
		rts
;-------------------------------------------------------------------------------
Oxygen_Bubbles_Animate_Data:				   ; Offset_0x02583E
		dc.w	Offset_0x025850-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025855-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x02585B-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025862-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025866-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025866-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025868-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x025868-Oxygen_Bubbles_Animate_Data
		dc.w	Offset_0x02586C-Oxygen_Bubbles_Animate_Data
Offset_0x025850:
		dc.b	$0E, $00, $01, $02, $FC
Offset_0x025855:
		dc.b	$0E, $01, $02, $03, $04, $FC
Offset_0x02585B:
		dc.b	$0E, $02, $03, $04, $05, $06, $FC
Offset_0x025862:
		dc.b	$02, $05, $06, $FC
Offset_0x025866:
		dc.b	$04, $FC
Offset_0x025868:
		dc.b	$04, $07, $08, $FC
Offset_0x02586C:
		dc.b	$0F, $13, $14, $15, $FF, $00
;===============================================================================
; Objeto 0x54 - Gerador de bolhas de oxigênio nas fases com água.
; <<<-
;===============================================================================