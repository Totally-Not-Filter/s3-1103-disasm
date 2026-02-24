;-------------------------------------------------------------------------------
; Sonic surfando durante a introdução da Angel Island
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x0185D6:
		move.l	#Intro_Surfboard_Mappings, Obj_Map(A0) ; Offset_0x0188FC, $000C
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0680, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$FF, (Sonic_Previous_Frame).w		 ; $FFFFF766
		move.l	#Intro_Surfboard_Main, (A0)			   ; Offset_0x018654
		move.w	(Obj_Player_One+Obj_X).w, Obj_X(A0)	  ; $FFFFB010, $0010
		move.w	(Obj_Player_One+Obj_Y).w, Obj_Y(A0)	  ; $FFFFB014, $0014
		subi.w	#$0020, Obj_X(A0)				 ; $0010
		subi.w	#$0010, Obj_Y(A0)				 ; $0014
		move.w	#$0000, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		clr.w	(Level_Events_Buffer_1).w			 ; $FFFFEEB6
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x018640
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.b	#$00, Obj_Map_Id(A1)					 ; $0022
		move.b	#$03, Obj_Player_Control(A1)			 ; $002E
Offset_0x018640:
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.w	Intro_Surfboard_Main		   ; Offset_0x018654
		move.l	#Intro_Surfboard_Splash, (A1)		   ; Offset_0x018AC4
		move.w	A0, Obj_P_Flips_Remaining(A1)			 ; $0030
;-------------------------------------------------------------------------------
Intro_Surfboard_Main:						   ; Offset_0x018654
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0186C4
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		addi.w	#$0008, Obj_X(A1)				 ; $0010
		addi.w	#$0008, Obj_X(A0)				 ; $0010
		cmpi.w	#$0900, Obj_X(A1)				 ; $0010
		bcs.s	Offset_0x0186C4
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.w	Offset_0x018698
		move.l	#Surfboard, (A1)			   ; Offset_0x018D7A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$000C, Obj_Y(A1)				 ; $0014
		move.w	A0, Obj_P_Flips_Remaining(A1)			 ; $0030
Offset_0x018698:
		move.w	#$0800, Obj_Speed_X(A0)					 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Intro_Surfboard_Jump, (A0)			   ; Offset_0x0186CE
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		subi.w	#$0005, Obj_X(A0)				 ; $0010
		move.b	#$07, Obj_Map_Id(A0)					 ; $0022
		jsr		(Intro_Surfboard_Load_PLC).l			 ; Offset_0x0188A8
		bra.s	Offset_0x0186C8
Offset_0x0186C4:
		bsr.w	Intro_Surfboard_Move		   ; Offset_0x018806
Offset_0x0186C8:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Intro_Surfboard_Jump:						   ; Offset_0x0186CE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		addi.w	#$0008, Obj_X(A1)				 ; $0010
		jsr		(SpeedToPos).l					 ; Offset_0x01111E
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		moveq	#$01, D2
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		beq.s	Offset_0x0186F8
		blt.s	Offset_0x0186F4
		neg.w	D2
Offset_0x0186F4:
		add.w	D2, Obj_X(A0)					 ; $0010
Offset_0x0186F8:
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x01873C
		cmpi.w	#$0440, Obj_Y(A0)				 ; $0014
		bcs.s	Offset_0x01873C
		move.w	#$0440, Obj_Y(A0)				 ; $0014
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		move.w	#$0800, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.l	#Intro_Surfboard_Run, (A0)		; Offset_0x01875C
Offset_0x01873C:
		lea		(Intro_Surfboard_Jump_Animate_Data).l, A1 ; Offset_0x018754
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
		jsr		(Intro_Surfboard_Load_PLC).l			 ; Offset_0x0188A8
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Intro_Surfboard_Jump_Animate_Data:					   ; Offset_0x018754
		dc.w	Offset_0x018756-Intro_Surfboard_Jump_Animate_Data
Offset_0x018756:
		dc.b	$06, $07, $08, $09, $FE, $01
;-------------------------------------------------------------------------------
Intro_Surfboard_Run:						   ; Offset_0x01875C
		move.l	A0, A3
		lea		(Obj_Player_One).w, A0				 ; $FFFFB000
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		cmpi.w	#$1170, Obj_X(A0)				 ; $0010
		bcs.s	Offset_0x01877E
		cmpi.w	#$1270, Obj_X(A0)				 ; $0010
		bcc.s	Offset_0x01877E
		move.w	#$FEC8, Obj_Speed_Y(A0)					 ; $001A
Offset_0x01877E:
		jsr		(SpeedToPos).l					 ; Offset_0x01111E
		cmpi.w	#$13C0, Obj_X(A0)				 ; $0010
		bcs.s	Offset_0x0187AA
		move.b	#$00, Obj_Player_Control(A0)			 ; $002E
		move.l	#Intro_Surfboard_Stop, (A3)			   ; Offset_0x0187CC
		move.b	#$01, (Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		move.w	#$0400, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		move.w	#$000E, Obj_Player_Control(A3)			 ; $002E
Offset_0x0187AA:
		jsr		(Sonic_Animate1P).l				 ; Offset_0x00C2E0
		move.l	A3, -(A7)
		jsr		(LoadSonicDynamicPLC).l		  ; Offset_0x00C7EA
		move.l	(A7)+, A0
		addi.w	#$0008, Obj_X(A0)				 ; $0010
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Intro_Surfboard_Stop:						   ; Offset_0x0187CC
		subq.w	#$01, Obj_Player_Control(A0)			 ; $002E
		bpl.s	Offset_0x0187FA
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$00, (Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		move.w	#$0000, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		move.l	#Offset_0x018800, (A0)
Offset_0x0187FA:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x018800:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Intro_Surfboard_Move:						   ; Offset_0x018806
		move.w	#$0002, D1
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcc.s	Offset_0x018816
		neg.w	D1
Offset_0x018816:
		add.w	D1, Obj_Speed_X(A0)				 ; $0018
		moveq	#$00, D2
		lea		(Offset_0x018894).l, A1
		move.w	#$0003, D1
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcc.s	Offset_0x01883E
		moveq	#$01, D2
		lea		(Offset_0x01889E).l, A1
		move.w	#$0004, D1
		neg.w	D1
Offset_0x01883E:
		add.w	D1, Obj_Speed_Y(A0)				 ; $001A
		jsr		(SpeedToPos).l					 ; Offset_0x01111E
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		tst.w	D2
		bne.s	Offset_0x018852
		neg.w	D0
Offset_0x018852:
		addi.w	#$0080, D0
		cmpi.w	#$0100, D0
		bcs.s	Offset_0x018860
		move.w	#$0100, D0
Offset_0x018860:
		lsr.w	#$05, D0
		move.b	$00(A1, D0), D0
		addq.b	#$01, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		jsr		(Intro_Surfboard_Load_PLC).l			 ; Offset_0x0188A8
		subq.w	#$01, Obj_Player_Control(A0)			 ; $002E
		bpl.s	Offset_0x018892
		move.w	#$0005, Obj_Player_Control(A0)			 ; $002E
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.w	Offset_0x018892
		move.l	#Surfboard_Waves, (A1)		   ; Offset_0x018A3C
		move.w	A0, Obj_P_Flips_Remaining(A1)			 ; $0030
Offset_0x018892:
		rts
;-------------------------------------------------------------------------------
Offset_0x018894:
		dc.b	$02, $01, $01, $00, $00, $00, $00, $01
		dc.b	$02, $02
;-------------------------------------------------------------------------------
Offset_0x01889E:
		dc.b	$03, $04, $04, $04, $05, $05, $05, $04
		dc.b	$03, $03
;-------------------------------------------------------------------------------
Intro_Surfboard_Load_PLC:					   ; Offset_0x0188A8
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		cmp.b	(Sonic_Previous_Frame).w, D0		 ; $FFFFF766
		beq.s	Offset_0x0188FA
		move.b	D0, (Sonic_Previous_Frame).w		 ; $FFFFF766
		lea		(Intro_Surfboard_Dyn_Script).l, A2		 ; Offset_0x0189D8
		add.w	D0, D0
		adda.w	(A2, D0), A2
		move.w	(A2)+, D5
		subq.w	#$01, D5
		bmi.s	Offset_0x0188FA
		move.w	#$D000, D4
Offset_0x0188CE:
		moveq	#$00, D1
		move.w	(A2)+, D1
		move.w	D1, D3
		lsr.w	#$08, D3
		andi.w	#$00F0, D3
		addi.w	#$0010, D3
		andi.w	#$0FFF, D1
		lsl.l	#$05, D1
		addi.l	#Art_Sonic_Surfboard, D1			   ; Offset_0x075200
		move.w	D4, D2
		add.w	D3, D4
		add.w	D3, D4
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
		dbra	D5, Offset_0x0188CE
Offset_0x0188FA:
		rts
;-------------------------------------------------------------------------------
Intro_Surfboard_Mappings:					   ; Offset_0x0188FC
		dc.w	Offset_0x018910-Intro_Surfboard_Mappings
		dc.w	Offset_0x018912-Intro_Surfboard_Mappings
		dc.w	Offset_0x018926-Intro_Surfboard_Mappings
		dc.w	Offset_0x01893A-Intro_Surfboard_Mappings
		dc.w	Offset_0x018954-Intro_Surfboard_Mappings
		dc.w	Offset_0x018968-Intro_Surfboard_Mappings
		dc.w	Offset_0x01897C-Intro_Surfboard_Mappings
		dc.w	Offset_0x018996-Intro_Surfboard_Mappings
		dc.w	Offset_0x0189B0-Intro_Surfboard_Mappings
		dc.w	Offset_0x0189C4-Intro_Surfboard_Mappings
Offset_0x018910:
		dc.w	$0000
Offset_0x018912:
		dc.w	$0003
		dc.w	$E80F, $0000, $FFE8
		dc.w	$080D, $0010, $FFE0
		dc.w	$080D, $0018, $0000
Offset_0x018926:
		dc.w	$0003
		dc.w	$E80F, $0000, $FFE8
		dc.w	$080D, $0010, $FFE0
		dc.w	$080D, $0018, $0000
Offset_0x01893A:
		dc.w	$0004
		dc.w	$E80F, $0000, $FFE8
		dc.w	$F809, $0010, $0008
		dc.w	$080D, $0016, $FFE0
		dc.w	$080D, $001E, $0000
Offset_0x018954:
		dc.w	$0003
		dc.w	$E80E, $0000, $FFE8
		dc.w	$000E, $000C, $FFE0
		dc.w	$000E, $0018, $0000
Offset_0x018968:
		dc.w	$0003
		dc.w	$E80E, $0000, $FFE8
		dc.w	$000E, $000C, $FFE0
		dc.w	$000E, $0018, $0000
Offset_0x01897C:
		dc.w	$0004
		dc.w	$E80F, $0000, $FFE8
		dc.w	$F809, $0010, $0008
		dc.w	$080D, $0016, $FFE0
		dc.w	$080D, $001E, $0000
Offset_0x018996:
		dc.w	$0004
		dc.w	$E804, $0000, $FFF4
		dc.w	$F00F, $0002, $FFEC
		dc.w	$0000, $0012, $000C
		dc.w	$1008, $0013, $FFEC
Offset_0x0189B0:
		dc.w	$0003
		dc.w	$E809, $0000, $FFF4
		dc.w	$F80F, $0006, $FFEC
		dc.w	$F801, $0016, $000C
Offset_0x0189C4:
		dc.w	$0003
		dc.w	$E809, $0000, $FFF4
		dc.w	$F80F, $0006, $FFEC
		dc.w	$F802, $0016, $000C
;-------------------------------------------------------------------------------
Intro_Surfboard_Dyn_Script:					   ; Offset_0x0189D8
		dc.w	Offset_0x0189EC-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x0189EE-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x0189F6-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x0189FE-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A08-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A10-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A18-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A22-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A2C-Intro_Surfboard_Dyn_Script
		dc.w	Offset_0x018A34-Intro_Surfboard_Dyn_Script
Offset_0x0189EC:
		dc.w	$0000
Offset_0x0189EE:
		dc.w	$0003
		dc.w	$F000, $7010, $7018
Offset_0x0189F6:
		dc.w	$0003
		dc.w	$F020, $7030, $7038
Offset_0x0189FE:
		dc.w	$0004
		dc.w	$F040, $5050, $7056, $705E
Offset_0x018A08:
		dc.w	$0003
		dc.w	$B066, $B072, $B07E
Offset_0x018A10:
		dc.w	$0003
		dc.w	$B08A, $B096, $B0A2
Offset_0x018A18:
		dc.w	$0004
		dc.w	$F0AE, $50BE, $70C4, $70CC
Offset_0x018A22:
		dc.w	$0004
		dc.w	$10D4, $F0D6, $00E6, $20E7
Offset_0x018A2C:
		dc.w	$0003
		dc.w	$50EA, $F0F0, $1100
Offset_0x018A34:
		dc.w	$0003
		dc.w	$5102, $F108, $2118
;-------------------------------------------------------------------------------
Surfboard_Waves:							   ; Offset_0x018A3C
		move.l	#Surfboard_Waves_Mappings, Obj_Map(A0) ; Offset_0x018C62, $000C
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$00, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$03D1, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Offset_0x018A96, (A0)
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
		bset	#$00, Obj_Status(A0)					 ; $002A
		move.w	Obj_P_Flips_Remaining(A0), A1			 ; $0030
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		addi.w	#$FFD8, Obj_X(A0)				 ; $0010
		addi.w	#$0018, Obj_Y(A0)				 ; $0014
Offset_0x018A96:
		lea		(Surfboard_Waves_Animate_Data).l, A1	 ; Offset_0x018AB4
		jsr		(AnimateSprite_2).l				 ; Offset_0x0111FE
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x018AAE
		move.w	#$7FFF, Obj_X(A0)				 ; $0010
Offset_0x018AAE:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Surfboard_Waves_Animate_Data:				   ; Offset_0x018AB4
		dc.w	Offset_0x018AB6-Surfboard_Waves_Animate_Data
Offset_0x018AB6:
		dc.b	$00, $01, $01, $02, $02, $03, $03, $03
		dc.b	$04, $02, $05, $02, $FC, $00
;-------------------------------------------------------------------------------
Intro_Surfboard_Splash:						   ; Offset_0x018AC4
		move.l	A0, A1
		bsr.s	Offset_0x018AF4
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.w	Offset_0x018AF2
		bsr.s	Offset_0x018B0C
		move.l	#Offset_0x018BA8, (A1)
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
		move.w	#$FFEC, Obj_P_Horiz_Ctrl_Lock(A1)		 ; $0032
		move.w	#$0010, Obj_P_Invunerblt_Time(A1)		 ; $0034
		move.w	Obj_P_Flips_Remaining(A0), Obj_P_Flips_Remaining(A1) ; $0030, $0030
Offset_0x018AF2:
		bra.s	Offset_0x018B34
Offset_0x018AF4:
		move.l	#Offset_0x018B34, (A1)
		move.w	#$0180, Obj_Priority(A1)				 ; $0008
		move.w	#$0008, Obj_P_Horiz_Ctrl_Lock(A1)		 ; $0032
		move.w	#$0018, Obj_P_Invunerblt_Time(A1)		 ; $0034
Offset_0x018B0C:
		move.l	#Intro_Surfboard_Splash_Mappings, Obj_Map(A1) ; Offset_0x018D0A,  $000C
		move.b	#$1C, Obj_Width(A1)				 ; $0007
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0529, Obj_Art_VRAM(A1)				 ; $000A
		move.w	#$0001, Obj_Ani_Number(A1)				 ; $0020
		bset	#$00, Obj_Status(A1)					 ; $002A
		rts
Offset_0x018B34:
		move.w	Obj_P_Flips_Remaining(A0), A1			 ; $0030
		lea		(Offset_0x018B9A).l, A2
		bsr.w	Offset_0x018C1A
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		move.w	Obj_P_Horiz_Ctrl_Lock(A0), D0			 ; $0032
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_P_Invunerblt_Time(A0), D0			 ; $0034
		add.w	D0, Obj_Y(A0)					 ; $0014
		cmpi.b	#$07, Obj_Map_Id(A1)					 ; $0022
		bcs.s	Offset_0x018B6C
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x018B6C:
		cmpi.b	#$05, Obj_Map_Id(A1)					 ; $0022
		bcs.s	Offset_0x018B82
		tst.w	Obj_P_Spd_Shoes_Time(A0)				 ; $0036
		beq.s	Offset_0x018B80
		subq.w	#$01, Obj_P_Spd_Shoes_Time(A0)			 ; $0036
		bra.s	Offset_0x018B88
Offset_0x018B80:
		rts
Offset_0x018B82:
		move.w	#$0003, Obj_P_Spd_Shoes_Time(A0)		 ; $0036
Offset_0x018B88:
		lea		(Intro_Surfboard_Splash_Animate_Data).l, A1 ; Offset_0x018C50
		jsr		(AnimateSprite_2).l				 ; Offset_0x0111FE
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x018B9A:
		dc.b	$00, $18, $00, $11, $00, $15, $F8, $15
		dc.b	$F8, $13, $F8, $13, $F8, $13
;-------------------------------------------------------------------------------
Offset_0x018BA8:
		move.w	Obj_P_Flips_Remaining(A0), A1			 ; $0030
		lea		(Offset_0x018C0C).l, A2
		bsr.s	Offset_0x018C1A
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		move.w	Obj_P_Horiz_Ctrl_Lock(A0), D0			 ; $0032
		add.w	D0, Obj_X(A0)					 ; $0010
		move.w	Obj_P_Invunerblt_Time(A0), D0			 ; $0034
		add.w	D0, Obj_Y(A0)					 ; $0014
		cmpi.b	#$07, Obj_Map_Id(A1)					 ; $0022
		bcs.s	Offset_0x018BDE
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x018BDE:
		cmpi.b	#$05, Obj_Map_Id(A1)					 ; $0022
		bcc.s	Offset_0x018BF4
		tst.w	Obj_P_Spd_Shoes_Time(A0)				 ; $0036
		beq.s	Offset_0x018BF2
		subq.w	#$01, Obj_P_Spd_Shoes_Time(A0)			 ; $0036
		bra.s	Offset_0x018BFA
Offset_0x018BF2:
		rts
Offset_0x018BF4:
		move.w	#$0003, Obj_P_Spd_Shoes_Time(A0)		 ; $0036
Offset_0x018BFA:
		lea		(Intro_Surfboard_Splash_Animate_Data).l, A1 ; Offset_0x018C50
		jsr		(AnimateSprite_2).l				 ; Offset_0x0111FE
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x018C0C:
		dc.b	$F8, $12, $F8, $12, $F8, $12, $F8, $12
		dc.b	$F8, $12, $F1, $12, $ED, $17
;-------------------------------------------------------------------------------
Offset_0x018C1A:
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		add.w	D0, D0
		move.b	(A2, D0), D1
		ext.w	D1
		moveq	#$01, D2
		cmp.w	Obj_Control_Var_02(A0), D1				 ; $0032
		beq.s	Offset_0x018C38
		bgt.s	Offset_0x018C34
		neg.w	D2
Offset_0x018C34:
		add.w	D2, Obj_Control_Var_02(A0)				 ; $0032
Offset_0x018C38:
		move.b	$01(A2, D0), D1
		ext.w	D1
		moveq	#$01, D2
		cmp.w	Obj_Control_Var_04(A0), D1				 ; $0034
		beq.s	Offset_0x018C4E
		bgt.s	Offset_0x018C4A
		neg.w	D2
Offset_0x018C4A:
		add.w	D2, Obj_Control_Var_04(A0)				 ; $0034
Offset_0x018C4E:
		rts
;-------------------------------------------------------------------------------
Intro_Surfboard_Splash_Animate_Data:				   ; Offset_0x018C50
		dc.w	Offset_0x018C52-Intro_Surfboard_Splash_Animate_Data
Offset_0x018C52:
		dc.b	$00, $01, $01, $01, $02, $01, $03, $01
		dc.b	$04, $01, $05, $01, $06, $01, $FF, $00
;-------------------------------------------------------------------------------
Surfboard_Waves_Mappings:					   ; Offset_0x018C62
		dc.w	Offset_0x018C6E-Surfboard_Waves_Mappings
		dc.w	Offset_0x018C7C-Surfboard_Waves_Mappings
		dc.w	Offset_0x018C9C-Surfboard_Waves_Mappings
		dc.w	Offset_0x018CBC-Surfboard_Waves_Mappings
		dc.w	Offset_0x018CDC-Surfboard_Waves_Mappings
		dc.w	Offset_0x018CF6-Surfboard_Waves_Mappings
Offset_0x018C6E:
		dc.w	$0002
		dc.w	$C00B, $0000, $0008
		dc.w	$E00F, $000C, $0000
Offset_0x018C7C:
		dc.w	$0005
		dc.w	$A00F, $001C, $0013
		dc.w	$C00B, $002C, $0008
		dc.w	$C00B, $0038, $0020
		dc.w	$E00F, $0044, $0000
		dc.w	$E00F, $0054, $0020
Offset_0x018C9C:
		dc.w	$0005
		dc.w	$A00F, $0064, $0018
		dc.w	$C00F, $0074, $0008
		dc.w	$C00B, $0084, $0028
		dc.w	$E00F, $0090, $0000
		dc.w	$E00F, $00A0, $0020
Offset_0x018CBC:
		dc.w	$0005
		dc.w	$B00D, $00B0, $0018
		dc.w	$C00F, $00B8, $0008
		dc.w	$C00B, $00C8, $0028
		dc.w	$E00F, $00D4, $0000
		dc.w	$E00F, $00E4, $0020
Offset_0x018CDC:
		dc.w	$0004
		dc.w	$C00F, $00F4, $0000
		dc.w	$C00B, $0104, $0020
		dc.w	$E00F, $0110, $0000
		dc.w	$E00F, $0120, $0020
Offset_0x018CF6:
		dc.w	$0003
		dc.w	$D00D, $0130, $0010
		dc.w	$E00F, $0138, $0000
		dc.w	$E00F, $0148, $0020
;-------------------------------------------------------------------------------
Intro_Surfboard_Splash_Mappings:					   ; Offset_0x018D0A
		dc.w	Offset_0x018D18-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D26-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D34-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D42-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D50-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D5E-Intro_Surfboard_Splash_Mappings
		dc.w	Offset_0x018D6C-Intro_Surfboard_Splash_Mappings
Offset_0x018D18:
		dc.w	$0002
		dc.w	$F009, $0000, $0000
		dc.w	$F80C, $0006, $0018
Offset_0x018D26:
		dc.w	$0002
		dc.w	$F00D, $000A, $0000
		dc.w	$F009, $0012, $0020
Offset_0x018D34:
		dc.w	$0002
		dc.w	$F00D, $0018, $0000
		dc.w	$E80A, $0020, $0020
Offset_0x018D42:
		dc.w	$0002
		dc.w	$F00D, $0029, $0000
		dc.w	$E80A, $0031, $0020
Offset_0x018D50:
		dc.w	$0002
		dc.w	$F00D, $003A, $0000
		dc.w	$E80A, $0042, $0020
Offset_0x018D5E:
		dc.w	$0002
		dc.w	$F80C, $004B, $0000
		dc.w	$F009, $004F, $0020
Offset_0x018D6C:
		dc.w	$0002
		dc.w	$F80C, $0055, $0000
		dc.w	$F808, $0059, $0020
;-------------------------------------------------------------------------------
Surfboard:							   ; Offset_0x018D7A
		move.l	#Surfboard_Mappings, Obj_Map(A0) ; Offset_0x018E26, $000C
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0585, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Offset_0x018DB2, (A0)
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		move.w	#$0800, Obj_Speed_X(A0)					 ; $0018
		move.w	#$FD00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x018DB2:
		cmpi.b	#$03, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x018DC6
		tst.w	Obj_Speed_X(A0)					 ; $0018
		beq.s	Offset_0x018DC6
		subi.w	#$0010, Obj_Speed_X(A0)					 ; $0018
Offset_0x018DC6:
		jsr		(SpeedToPos).l					 ; Offset_0x01111E
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		lea		(Surfboard_Animate_Data).l, A1			 ; Offset_0x018E0A
		jsr		(AnimateSprite_2).l				 ; Offset_0x0111FE
		move.b	#$00, Obj_Status(A0)					 ; $002A
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		andi.b	#$07, D0
		cmpi.b	#$04, D0
		bcs.s	Offset_0x018DF8
		move.b	#$03, Obj_Status(A0)					 ; $002A
Offset_0x018DF8:
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x018E04
		move.w	#$7FFF, Obj_X(A0)				 ; $0010
Offset_0x018E04:
		jmp		(MarkObjGone).l					 ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Surfboard_Animate_Data:						   ; Offset_0x018E0A
		dc.w	Offset_0x018E0C-Surfboard_Animate_Data
Offset_0x018E0C:
		dc.b	$01, $01, $02, $11, $03, $05, $04, $03
		dc.b	$01, $01, $02, $01, $03, $01, $04, $01
		dc.b	$01, $01, $02, $01, $03, $01, $04, $01
		dc.b	$FE, $08
;-------------------------------------------------------------------------------
Surfboard_Mappings:							   ; Offset_0x018E26
		dc.w	Offset_0x018E30-Surfboard_Mappings
		dc.w	Offset_0x018E32-Surfboard_Mappings
		dc.w	Offset_0x018E46-Surfboard_Mappings
		dc.w	Offset_0x018E66-Surfboard_Mappings
		dc.w	Offset_0x018E80-Surfboard_Mappings
Offset_0x018E30:
		dc.w	$0000
Offset_0x018E32:
		dc.w	$0003
		dc.w	$FC0D, $0000, $FFE0
		dc.w	$FC09, $0008, $0000
		dc.w	$F401, $000E, $0018
Offset_0x018E46:
		dc.w	$0005
		dc.w	$E402, $0010, $000C
		dc.w	$EC02, $0013, $0004
		dc.w	$F402, $0016, $FFFC
		dc.w	$FC01, $0019, $FFF4
		dc.w	$0C05, $001B, $FFEC
Offset_0x018E66:
		dc.w	$0004
		dc.w	$E007, $001F, $FFF4
		dc.w	$0004, $0027, $FFF4
		dc.w	$0800, $0029, $FFFC
		dc.w	$1005, $002A, $FFFC
Offset_0x018E80:
		dc.w	$0005
		dc.w	$EC08, $002E, $FFE4
		dc.w	$F408, $0031, $FFEC
		dc.w	$FC0C, $0034, $FFF4
		dc.w	$040C, $0038, $FFFC
		dc.w	$0C04, $003C, $000C
;-------------------------------------------------------------------------------
; Sonic surfando durante a introdução da Angel Island
; <<<-
;-------------------------------------------------------------------------------