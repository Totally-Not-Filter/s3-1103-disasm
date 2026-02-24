;===============================================================================
; Objeto 0xA9 - Chefe na Angel Island
; ->>>
;===============================================================================
; Offset_0x0371FA:
		move.w	#$4880, D0
		cmp.w	(Camera_X).w, D0					 ; $FFFFEE78
		bls.s	Offset_0x037206
		rts
Offset_0x037206:
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037252, Obj_Child(A0)			 ; $0034
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$01, (Boss_Flag).w					 ; $FFFFF7AA
		moveq	#$6B, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		lea		(Art_Flame_Mobile).l, A1		   ; Offset_0x1114FC
		move.w	#$3000, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		lea		Pal_Flame_Mobile(PC), A1			   ; Offset_0x037E0C
		jmp		(Pal_Load_Line_1)			   ; Offset_0x04314C
;-------------------------------------------------------------------------------
Offset_0x037252:
		move.l	#Offset_0x037262, (A0)
		moveq	#Boss_Snd, D0					   ; $19
		jsr		(PlaySound).l					; Offset_0x001176
		rts
;-------------------------------------------------------------------------------
Offset_0x037262:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x037280(PC, D0), D1
		jsr		Offset_0x037280(PC, D1)
		btst	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x03738A
		jmp		(Add_To_Response_List_And_Display)	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x037280:
		dc.w	Offset_0x037290-Offset_0x037280
		dc.w	Offset_0x037306-Offset_0x037280
		dc.w	Offset_0x037350-Offset_0x037280
		dc.w	Offset_0x03738C-Offset_0x037280
		dc.w	Offset_0x037406-Offset_0x037280
		dc.w	Offset_0x037306-Offset_0x037280
		dc.w	Offset_0x03746C-Offset_0x037280
		dc.w	Offset_0x03748C-Offset_0x037280
;-------------------------------------------------------------------------------
Offset_0x037290:
		lea		Flame_Mobile_Setup_Data(PC), A1		   ; Offset_0x037C60
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.b	#$08, Obj_Boss_Hit(A0)					 ; $0029
		bset	#$00, Obj_Flags(A0)				 ; $0004
		lea		(AIz_Robotnik_Ship_Data).l, A2			 ; Offset_0x036576
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		bne.s	Offset_0x0372BA
		move.b	#$08, Obj_Subtype(A1)					 ; $002C
Offset_0x0372BA:
		lea		Offset_0x037CA4(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x0372C4:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		moveq	#Waterfall_Splash_Sfx, D0				   ; $4F
		jsr		(PlaySound).l					; Offset_0x001176
		ori.b	#$48, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x037326, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		bsr.w	Offset_0x037C20
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		cmpi.w	#$0008, Obj_Angle(A0)					 ; $0026
		bcc.s	Offset_0x0372FC
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x0372FC:
		lea		Offset_0x037CBA(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x037306:
		lea		Offset_0x037D24(PC), A1
		jsr		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		cmpi.b	#$2B, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x037324
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x037324:
		rts
;-------------------------------------------------------------------------------
Offset_0x037326:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.b	#$16, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x03735E, Obj_Child(A0)			 ; $0034
		lea		Offset_0x037CC2(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x037350:
		lea		Offset_0x037D3F(PC), A1
		jsr		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
		bra.w	Offset_0x037B4C
;-------------------------------------------------------------------------------
Offset_0x03735E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0373A2, Obj_Child(A0)			 ; $0034
		move.w	#$00C0, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0010, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03738A:
		rts
;-------------------------------------------------------------------------------
Offset_0x03738C:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		bra.w	Offset_0x037B4C
;-------------------------------------------------------------------------------
Offset_0x0373A2:
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		btst	#$07, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x0373C6
		move.w	#$0004, Obj_Angle(A0)					 ; $0026
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0373F2, Obj_Child(A0)			 ; $0034
		rts
Offset_0x0373C6:
		move.w	#$00BF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0373D6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0373D6:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037410, Obj_Child(A0)			 ; $0034
		andi.b	#$F5, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0373F2:
		st		(Boss_Attack_Started).w				 ; $FFFFFAA2
		move.w	#$008F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0373D6, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037406:
		bsr.w	Offset_0x037B4C
		jmp		(Run_Object_Wait_Timer_A0)			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x037410:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		moveq	#Waterfall_Splash_Sfx, D0				   ; $4F
		jsr		(PlaySound).l					; Offset_0x001176
		move.l	#Offset_0x037440, Obj_Child(A0)			 ; $0034
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		bsr.w	Offset_0x037C20
		lea		Offset_0x037CBA(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
		move.b	#$02, Obj_Subtype(A1)					 ; $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x037440:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		bset	#$07, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x037454
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
Offset_0x037454:
		move.l	#Offset_0x037498, Obj_Child(A0)			 ; $0034
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bra.w	Offset_0x0379D8
;-------------------------------------------------------------------------------
Offset_0x03746C:
		move.w	(Sonic_Level_Limits_Max_X).w, D0			 ; $FFFFEE16
		addq.w	#$02, D0
		cmpi.w	#$49A0, D0
		bcc.s	Offset_0x03747C
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
Offset_0x03747C:
		move.w	(Sonic_Level_Limits_Min_X).w, D0			 ; $FFFFEE14
		addq.w	#$02, D0
		cmpi.w	#$48E0, D0
		bcc.s	Offset_0x03748C
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
;-------------------------------------------------------------------------------
Offset_0x03748C:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x037498:
		clr.w	Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		bra.w	Offset_0x0372C4
;-------------------------------------------------------------------------------
Offset_0x0374A4:
		move.l	#Flame_Mobile_Defeated, Obj_Child(A0) ; Offset_0x0374D4, $0034
		st		(Boss_Defeated_Flag).w				 ; $FFFFFAA3
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		moveq	#Volume_Down, D0				  ; -$20
		jsr		(PlaySound).l					; Offset_0x001176
		lea		Offset_0x037CF2(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Flame_Mobile_Defeated:						   ; Offset_0x0374D4
		move.l	#Offset_0x037504, (A0)
Drill_Mobile_Defeated:						   ; Offset_0x0374DA
		st		(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		clr.b	(Boss_Flag).w				 ; $FFFFF7AA
		jsr		(Restore_LevelMusic).l			 ; Offset_0x0432CA
		lea		AIz_MGz_Boss_Load_Egg_Prison(PC), A2   ; Offset_0x037D18
		jsr		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
		bset	#$01, Obj_Flags(A1)				 ; $0004
		lea		(PLC_AIz_MGz_Boss_Defeated).l, A1		 ; Offset_0x041BA6
		jmp		(LoadPLC_Direct).l					 ; Offset_0x001502
;-------------------------------------------------------------------------------
Offset_0x037504:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x037512
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.w	Offset_0x03738A
Offset_0x037512:
		move.l	#Offset_0x037538, (A0)
		clr.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		jsr		(Restore_PlayerControl).l		  ; Offset_0x0432EE
		st		(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		move.w	#$4A38, (Target_Camera_Max_X).w		 ; $FFFFFA92
		lea		(Level_Resize_Max_X).l, A2			   ; Offset_0x04261C
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x037538:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmpi.w	#$4AD8, Obj_X(A1)				 ; $0010
		bcc.s	Offset_0x03754C
		move.w	#$0808, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		rts
Offset_0x03754C:
		move.l	#Offset_0x03757A, (A0)
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		lea		Offset_0x037D1E(PC), A2
		jsr		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
		move.b	#$04, Obj_Subtype(A1)					 ; $002C
		lea		(PLC_Flame_Mobile_Explosion).l, A1		 ; Offset_0x041BC2
		jmp		(LoadPLC_Direct).l					 ; Offset_0x001502
;-------------------------------------------------------------------------------
Offset_0x03757A:
		tst.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		beq.s	Offset_0x037588
		move.w	#$0101, (Control_Ports_Logical_Data).w		 ; $FFFFF602
		rts
Offset_0x037588:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03759E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03759E:
		move.w	#Hz_Act_1, (Current_ZoneAndAct).w		; $0100, $FFFFFE10
		move.w	#Hz_Act_1, (Apparent_ZoneAndAct).w			   ; $0100, $FFFFEE54
		move.w	#$0001, (Restart_Level_Flag).w		 ; $FFFFFE02
		clr.b	(Saved_Level_Flag).w				 ; $FFFFFE30
		clr.b	(Saved_Level_Flag_P2).w				 ; $FFFFFEE0
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0375BE:
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		bsr.w	Boss_Test_And_Set_Layer_Flag		   ; Offset_0x037A98
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0375EA(PC, D0), D1
		jsr		Offset_0x0375EA(PC, D1)
		btst	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x03738A
		bsr.w	Offset_0x037C30
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0375EA:
		dc.w	Offset_0x0375F6-Offset_0x0375EA
		dc.w	Offset_0x03761E-Offset_0x0375EA
		dc.w	Offset_0x037650-Offset_0x0375EA
		dc.w	Offset_0x037666-Offset_0x0375EA
		dc.w	Offset_0x03767E-Offset_0x0375EA
		dc.w	Offset_0x0376A0-Offset_0x0375EA
;-------------------------------------------------------------------------------
Offset_0x0375F6:
		lea		Offset_0x037C6C(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		moveq	#$00, D0
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x037614
		move.b	#$2A, Obj_Map_Id(A0)					 ; $0022
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
Offset_0x037614:
		lea		Offset_0x037CB2(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03761E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03762C
		rts
Offset_0x03762C:
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x037648
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0004, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037656, Obj_Child(A0)			 ; $0034
		rts
Offset_0x037648:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x037650:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x037656:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x037676, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037666:
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x037D4A(PC), A1
		jmp		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
;-------------------------------------------------------------------------------
Offset_0x037676:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x03767E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03768C
		rts
Offset_0x03768C:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.w	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x0376A0:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0376AE
		rts
Offset_0x0376AE:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0376BC:
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		moveq	#$0C, D0
		jmp		(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x0376D4:
		bsr.w	Boss_Test_And_Set_Layer_Flag		   ; Offset_0x037A98
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0376FC(PC, D0), D1
		jsr		Offset_0x0376FC(PC, D1)
		jsr		(Refresh_Child_Position_Adjusted).l	   ; Offset_0x04203C
		btst	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x03738A
		jmp		(Child_Display_Or_Delete).l			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0376FC:
		dc.w	Offset_0x037704-Offset_0x0376FC
		dc.w	Offset_0x037710-Offset_0x0376FC
		dc.w	Offset_0x037750-Offset_0x0376FC
		dc.w	Offset_0x03779C-Offset_0x0376FC
;-------------------------------------------------------------------------------
Offset_0x037704:
		lea		Offset_0x037C72(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		rts
;-------------------------------------------------------------------------------
Offset_0x037710:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03771E
		rts
Offset_0x03771E:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x03776E, Obj_Child(A0)			 ; $0034
		move.w	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		clr.w	Obj_Timer(A0)					 ; $002E
		tst.b	Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x03774E
		move.w	#$004F, Obj_Timer(A0)					 ; $002E
Offset_0x03774E:
		rts
;-------------------------------------------------------------------------------
Offset_0x037750:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x03776C
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		bsr.w	Offset_0x037A42
		subq.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		bpl.s	Offset_0x03776C
		move.l	Obj_Child(A0), A1				 ; $0034
		jsr		(A1)
Offset_0x03776C:
		rts
;-------------------------------------------------------------------------------
Offset_0x03776E:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0377A2, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x037AC8
;-------------------------------------------------------------------------------
Offset_0x037790:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Control_Var_09(A0)					 ; $0039
		rts
;-------------------------------------------------------------------------------
Offset_0x03779C:
		jmp		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0377A2:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		clr.w	Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x037790, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0377C2:
		lea		Offset_0x037C78(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Offset_0x037816, (A0)
		move.l	#Offset_0x037834, Obj_Child(A0)			 ; $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A2					 ; $0046
		move.w	Obj_Child_Ref(A2), A2					 ; $0046
		move.w	A2, Obj_Height_3(A0)					 ; $0044
		move.w	Obj_Angle(A1), D0				 ; $0026
		move.w	D0, Obj_Angle(A0)				 ; $0026
		move.l	Offset_0x037806(PC, D0), Obj_Child_Data(A0)		 ; $0030
		cmpi.w	#$0008, D0
		bcc.s	Offset_0x037804
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x037804:
		rts
;-------------------------------------------------------------------------------
Offset_0x037806:
		dc.l	Offset_0x037D55
		dc.l	Offset_0x037D7F
		dc.l	Offset_0x037D7F
		dc.l	Offset_0x037D55
;-------------------------------------------------------------------------------
Offset_0x037816:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03783E
		jsr		(Refresh_Child_Position).l			   ; Offset_0x042016
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x037834:
		lea		Offset_0x037CE2(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03783E:
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		jmp		(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x03784A:
		lea		Offset_0x037C7E(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		moveq	#Projectile_Sfx, D0				   ; $51
		jsr		(PlaySound).l					; Offset_0x001176
		move.b	#$0C, Obj_Height_2(A0)					 ; $001E
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03787A, (A0)
		move.l	#Offset_0x0378B8, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x037AE4
;-------------------------------------------------------------------------------
Offset_0x03787A:
		tst.w	Obj_Speed_X(A0)					 ; $0018
		beq.s	Offset_0x037886
		jsr		(Run_Object_Hit_Floor_A0).l			   ; Offset_0x0423E0
Offset_0x037886:
		jsr		(AnimateRaw).l				  ; Offset_0x04208E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x0378B2
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		andi.b	#$03, D0
		bne.s	Offset_0x0378AC
		lea		Offset_0x037CEA(PC), A2
		jsr		(SetupChildObject).l		   ; Offset_0x041D9A
Offset_0x0378AC:
		jmp		(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
Offset_0x0378B2:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x0378B8:
		move.l	#Offset_0x037886, (A0)
		move.l	#Offset_0x037DB5, Obj_Child_Data(A0)			 ; $0030
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0378CC:
		lea		Offset_0x037C84(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Offset_0x0378FC, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.l	#Offset_0x037DBB, Obj_Child_Data(A0)			 ; $0030
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bne.s	Offset_0x0378FA
		move.l	#Offset_0x037DC4, Obj_Child_Data(A0)			 ; $0030
Offset_0x0378FA:
		rts
;-------------------------------------------------------------------------------
Offset_0x0378FC:
		jsr		(Animate_Raw_Multi_Delay).l			   ; Offset_0x04215C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x037908:
		lea		Offset_0x037C92(PC), A1
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x037922, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037922:
		lea		Offset_0x037DCD(PC), A1
		jsr		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x037932:
		lea		Offset_0x037C8A(PC), A1
		jsr		(SetupObjectAttributes2).l			; Offset_0x041D76
		move.l	#Offset_0x03795C, (A0)
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x037952
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
Offset_0x037952:
		move.l	#Offset_0x037976, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03795C:
		lea		Offset_0x037DD6(PC), A1
		jsr		(Animate_Raw_Multi_Delay_Flip_X_A1).l	   ; Offset_0x0421D2
		cmpi.b	#$2B, Obj_Map_Id(A0)					 ; $0022
		beq.w	Offset_0x03738A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x037976:
		move.l	#Offset_0x03798C, (A0)
		move.w	#$0800, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03798C:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		lea		Offset_0x037DF1(PC), A1
		jsr		(Animate_Raw_Multi_Delay_Flip_X_A1).l	   ; Offset_0x0421D2
		cmpi.b	#$2B, Obj_Map_Id(A0)					 ; $0022
		beq.w	Offset_0x03738A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0379AC:
		lea		Offset_0x037C9E(PC), A1
		jsr		(SetupObjectAttributes3).l			; Offset_0x041D7A
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.b	#$01, D0
		addi.b	#$32, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$00, D0
		jsr		(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0379D8:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$000C, D0
		move.w	Obj_Angle(A0), D1				 ; $0026
		move.w	D0, Obj_Angle(A0)				 ; $0026
		cmp.w	D1, D0
		beq.s	Offset_0x0379D8
		lea		Offset_0x037A32(PC, D0), A1
		moveq	#$00, D2
		move.w	(A1)+, D2
		swap	D2
		sub.l	Obj_X(A0), D2					 ; $0010
		add.l	D2, D2
		swap	D2
		move.w	D2, Obj_Speed_X(A0)				 ; $0018
		moveq	#$00, D3
		move.w	(A1)+, D3
		swap	D3
		sub.l	Obj_Y(A0), D3					 ; $0014
		add.l	D3, D3
		swap	D3
		move.w	D3, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		tst.w	D2
		beq.s	Offset_0x037A30
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D2
		bmi.s	Offset_0x037A30
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x037A30:
		rts
;-------------------------------------------------------------------------------
Offset_0x037A32:
		dc.w	$4938, $01D0, $4980, $01A0, $4A40, $01A0, $4A88, $01D0
;-------------------------------------------------------------------------------
Offset_0x037A42:
		move.w	Obj_Angle(A0), D0				 ; $0026
		moveq	#$00, D1
		eori.w	#$000C, D0
		beq.s	Offset_0x037A58
		cmpi.w	#$000C, D0
		beq.s	Offset_0x037A58
		addi.w	#$0010, D1
Offset_0x037A58:
		moveq	#$00, D2
		move.b	Obj_Control_Var_09(A0), D2				 ; $0039
		add.w	D2, D1
		lea		Offset_0x037A78(PC, D1), A1
		move.b	(A1)+, Obj_Control_Var_12(A0)			 ; $0042
		move.b	(A1)+, Obj_Control_Var_13(A0)			 ; $0043
		move.b	(A1)+, Obj_Map_Id(A0)					 ; $0022
		addq.b	#$04, D2
		move.b	D2, Obj_Control_Var_09(A0)				 ; $0039
		rts
;-------------------------------------------------------------------------------
Offset_0x037A78:
		dc.b	$E8, $08, $05, $00, $E8, $08, $05, $00
		dc.b	$E4, $00, $04, $00, $E4, $00, $04, $00
		dc.b	$E8, $08, $05, $00, $F0, $10, $06, $00
		dc.b	$E8, $08, $05, $00, $E4, $00, $04, $00
;-------------------------------------------------------------------------------
Boss_Test_And_Set_Layer_Flag:				   ; Offset_0x037A98
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$06, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x037AC0
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		btst	#$07, Obj_Art_VRAM(A1)					 ; $000A
		bne.s	Offset_0x037ABE
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x037ABE:
		rts
Offset_0x037AC0:
		bset	#$06, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x037AC8:
		move.w	Obj_Angle(A0), D0				 ; $0026
		lsr.w	#$01, D0
		move.w	Offset_0x037ADC(PC, D0), D0
		lea		Offset_0x037ADC(PC, D0), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x037ADC:
		dc.w	Offset_0x037CCA-Offset_0x037ADC
		dc.w	Offset_0x037CD2-Offset_0x037ADC
		dc.w	Offset_0x037CD2-Offset_0x037ADC
		dc.w	Offset_0x037CDA-Offset_0x037ADC
;-------------------------------------------------------------------------------
Offset_0x037AE4:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		cmpi.w	#$0008, D0
		bcc.s	Offset_0x037AF8
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x037AF8:
		move.l	Offset_0x037B1C(PC, D0), Obj_Child_Data(A0)		 ; $0030
		lea		Offset_0x037B2C(PC, D0), A1
		move.w	(A1)+, D1
		add.w	D1, Obj_X(A0)					 ; $0010
		move.w	(A1)+, D1
		add.w	D1, Obj_Y(A0)					 ; $0014
		lea		Offset_0x037B3C(PC, D0), A1
		move.w	(A1)+, Obj_Speed_X(A0)					 ; $0018
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x037B1C:
		dc.l	Offset_0x037DA9
		dc.l	Offset_0x037DAF
		dc.l	Offset_0x037DAF
		dc.l	Offset_0x037DA9
;-------------------------------------------------------------------------------
Offset_0x037B2C:
		dc.w	$0014, $0014, $0000, $0018, $0000, $0018, $FFEC, $0014
;-------------------------------------------------------------------------------
Offset_0x037B3C:
		dc.w	$0300, $0300, $0000, $0400, $0000, $0400, $FD00, $0300
;-------------------------------------------------------------------------------
Offset_0x037B4C:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x037B9E
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x037BA0
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x037B6C
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x037B6C:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x037B80
		addi.w	#$000E, D0
Offset_0x037B80:
		bsr.w	Offset_0x037BD0
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x037B9E
		bclr	#$06, Obj_Status(A0)					 ; $002A
		cmpi.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x037B9E
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x037B9E:
		rts
Offset_0x037BA0:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		bclr	#$06, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0374A4, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x037BD0:
		lea		Offset_0x037BF6(PC), A1
		lea		Offset_0x037C04(PC, D0), A2
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		rts
;-------------------------------------------------------------------------------
Offset_0x037BF6:
		dc.w	(Palette_Row_1_Offset+$08)				 ; $ED28
		dc.w	(Palette_Row_1_Offset+$0E)				 ; $ED2E
		dc.w	(Palette_Row_1_Offset+$12)				 ; $ED32
		dc.w	(Palette_Row_1_Offset+$14)				 ; $ED34
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1A)				 ; $ED3A
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x037C04:
		dc.w	$0222, $0008, $004C, $0006, $0020, $0A24, $0622, $0AAA
		dc.w	$0AAA, $0AAA, $0CCC, $0EEE, $0666, $0888
;-------------------------------------------------------------------------------
Offset_0x037C20:
		moveq	#$00, D0
		bsr.s	Offset_0x037BD0
		bclr	#$06, Obj_Status(A0)					 ; $002A
		clr.b	Obj_Ani_Number(A0)				 ; $0020
		rts
;-------------------------------------------------------------------------------
Offset_0x037C30:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x037C3E
		rts
Offset_0x037C3E:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0376BC, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Flame_Mobile_Setup_Data:					   ; Offset_0x037C60
		dc.l	Flame_Mobile_Mappings		   ; Offset_0x10EF8E
		dc.w	$A180, $0280
		dc.b	$28, $20, $00, $10
;-------------------------------------------------------------------------------
Offset_0x037C6C:
		dc.w	$0200
		dc.b	$24, $14, $01, $00
;-------------------------------------------------------------------------------
Offset_0x037C72:
		dc.w	$0180
		dc.b	$0C, $0C, $04, $00
;-------------------------------------------------------------------------------
Offset_0x037C78:
		dc.w	$0100
		dc.b	$08, $04, $0B, $97
;-------------------------------------------------------------------------------
Offset_0x037C7E:
		dc.w	$0100
		dc.b	$14, $18, $0F, $9A
;-------------------------------------------------------------------------------
Offset_0x037C84:
		dc.w	$0100
		dc.b	$08, $08, $18, $00
;-------------------------------------------------------------------------------
Offset_0x037C8A:
		dc.w	$8180, $0100
		dc.b	$30, $30, $24, $00
;-------------------------------------------------------------------------------
Offset_0x037C92:
		dc.l	Flame_Mobile_Mappings		   ; Offset_0x10EF8E
		dc.w	$8180, $0100
		dc.b	$18, $10, $21, $00
;-------------------------------------------------------------------------------
Offset_0x037C9E:
		dc.w	$0180
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Offset_0x037CA4:
		dc.w	$0001
		dc.l	Offset_0x0375BE
		dc.b	$14, $FC
		dc.l	Offset_0x0375BE
		dc.b	$EC, $FC
;-------------------------------------------------------------------------------
Offset_0x037CB2:
		dc.w	$0000
		dc.l	Offset_0x0376D4
		dc.b	$E4, $00
;-------------------------------------------------------------------------------
Offset_0x037CBA:
		dc.w	$0000
		dc.l	Offset_0x037932
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x037CC2:
		dc.w	$0000
		dc.l	Offset_0x037908
		dc.b	$00, $D0
;-------------------------------------------------------------------------------
Offset_0x037CCA:
		dc.w	$0000
		dc.l	Offset_0x0377C2
		dc.b	$03, $05
;-------------------------------------------------------------------------------
Offset_0x037CD2:
		dc.w	$0000
		dc.l	Offset_0x0377C2
		dc.b	$00, $07
;-------------------------------------------------------------------------------
Offset_0x037CDA:
		dc.w	$0000
		dc.l	Offset_0x0377C2
		dc.b	$FD, $05
;-------------------------------------------------------------------------------
Offset_0x037CE2:
		dc.w	$0000
		dc.l	Offset_0x03784A
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x037CEA:
		dc.w	$0000
		dc.l	Offset_0x0378CC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x037CF2:
		dc.w	$0005
		dc.l	Offset_0x0379AC
		dc.b	$F0, $F0
		dc.l	Offset_0x0379AC
		dc.b	$10, $F0
		dc.l	Offset_0x0379AC
		dc.b	$F0, $08
		dc.l	Offset_0x0379AC
		dc.b	$10, $08
		dc.l	Offset_0x0379AC
		dc.b	$F4, $18
		dc.l	Offset_0x0379AC
		dc.b	$0C, $18
;-------------------------------------------------------------------------------
AIz_MGz_Boss_Load_Egg_Prison:				   ; Offset_0x037D18
		dc.w	$0000
		dc.l	Obj_0xC6_Egg_Prison			   ; Offset_0x043490
;-------------------------------------------------------------------------------
Offset_0x037D1E:
		dc.w	$0000
		dc.l	ObjC7_CutsceneKnuckles				; Offset_0x034BAA
;-------------------------------------------------------------------------------
Offset_0x037D24:
		dc.b	$2B, $00, $2B, $00, $2B, $00, $00, $00
		dc.b	$2B, $00, $2B, $00, $00, $00, $2B, $00
		dc.b	$2B, $00, $00, $00, $2B, $00, $2B, $00
		dc.b	$00, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x037D3F:
		dc.b	$1B, $00, $1B, $04, $1C, $05, $1D, $06
		dc.b	$00, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x037D4A:
		dc.b	$1E, $00, $1E, $04, $1F, $05, $20, $06
		dc.b	$01, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x037D55:
		dc.b	$00, $07, $2B, $07, $2B, $08, $2B, $08
		dc.b	$2B, $09, $2B, $09, $2B, $0A, $2B, $0A
		dc.b	$2B, $0A, $2B, $0A, $2B, $0A, $2B, $0A
		dc.b	$2B, $0A, $2B, $0A, $2B, $0A, $2B, $0A
		dc.b	$2B, $0A, $2B, $0A, $2B, $0A, $2B, $0A
		dc.b	$2B, $F4
;-------------------------------------------------------------------------------
Offset_0x037D7F:
		dc.b	$00, $0B, $2B, $0B, $2B, $0C, $2B, $0C
		dc.b	$2B, $0D, $2B, $0D, $2B, $0E, $2B, $0E
		dc.b	$2B, $0E, $2B, $0E, $2B, $0E, $2B, $0E
		dc.b	$2B, $0E, $2B, $0E, $2B, $0E, $2B, $0E
		dc.b	$2B, $0E, $2B, $0E, $2B, $0E, $2B, $0E
		dc.b	$2B, $F4
;-------------------------------------------------------------------------------
Offset_0x037DA9:
		dc.b	$01, $26, $27, $28, $29, $FC
;-------------------------------------------------------------------------------
Offset_0x037DAF:
		dc.b	$01, $16, $17, $2F, $30, $FC
;-------------------------------------------------------------------------------
Offset_0x037DB5:
		dc.b	$01, $10, $11, $2D, $2E, $FC
;-------------------------------------------------------------------------------
Offset_0x037DBB:
		dc.b	$12, $00, $12, $09, $13, $02, $14, $02
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x037DC4:
		dc.b	$18, $00, $18, $09, $19, $02, $1A, $02
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x037DCD:
		dc.b	$21, $00, $21, $04, $22, $05, $23, $06
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x037DD6:
		dc.b	$2B, $00, $24, $00, $64, $00, $6B, $00
		dc.b	$2C, $00, $6C, $00, $6B, $00, $24, $00
		dc.b	$64, $00, $6B, $00, $2C, $00, $6C, $00
		dc.b	$6B, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x037DF1:
		dc.b	$2B, $00, $24, $00, $64, $00, $6B, $00
		dc.b	$2C, $00, $6C, $00, $6B, $00, $31, $00
		dc.b	$71, $00, $6B, $00, $31, $00, $71, $00
		dc.b	$6B, $00, $F4
;-------------------------------------------------------------------------------
Pal_Flame_Mobile:							   ; Offset_0x037E0C
		dc.w	$0000, $0EEE, $0CAA, $0E26, $0222, $00EE, $0000, $0008
		dc.w	$02AE, $004C, $0006, $0020, $0C68, $0A24, $0622, $0000
;===============================================================================
; Objeto 0xA9 - Chefe na Angel Island
; <<<-
;===============================================================================