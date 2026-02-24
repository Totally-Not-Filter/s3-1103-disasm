;-------------------------------------------------------------------------------
; Nave do Robotnik seguindo a Flying Battery na Angel Island
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x0311BC:
		move.l	#Obj_AIz_FBz_Battleship_Main, (A0)	   ; Offset_0x031208
		move.l	#AIz_FBz_Bomb_Script, Obj_Timer(A0) ; Offset_0x031A6C, $002E
		move.w	#$01A4, Obj_Control_Var_02(A0)			 ; $0032
		move.w	#$3FBC, D1
		moveq	#$01, D2
Offset_0x0311D6:
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.s	Offset_0x0311F0
		move.l	#Obj_AIz_Battleship_Propeller, (A1)	   ; Offset_0x031288
		move.w	D1, Obj_Timer(A1)				 ; $002E
		move.w	#$3DCC, D1
		dbra	D2, Offset_0x0311D6
Offset_0x0311F0:
		lea		(Palette_Row_1_Offset).w, A1		 ; $FFFFED20
		lea		Pal_AIz_Battleship(PC), A5			   ; Offset_0x031A20
		moveq	#$07, D0
Offset_0x0311FA:
		move.l	(A5)+, (A1)+
		dbra	D0, Offset_0x0311FA
		moveq	#sfx_LargeShip, D0				 ; $54
		jsr		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
Obj_AIz_FBz_Battleship_Main:				   ; Offset_0x031208
		subi.l	#$00008800, (AIz_Flying_Battery_X).w		 ; $FFFFEE98
		move.w	(AIz_Flying_Battery_X).w, D0		 ; $FFFFEE98
		cmpi.w	#$3CDC, D0
		bpl.s	Offset_0x031234
		move.l	#Obj_AIz_Boss_Small, (A0)			   ; Offset_0x03151A
		st		(Foreground_Events_Y_Counter).w		 ; $FFFFEEC4
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.s	Offset_0x031232
		move.l	#Obj_AIz_Make_Tree, (A1)			   ; Offset_0x031470
Offset_0x031232:
		rts
Offset_0x031234:
		move.w	D0, D1
		subi.w	#$3D5C, D0
		bpl.s	Offset_0x03124A
		neg.w	D0
		asr.w	#$01, D0
		add.w	(AIz_Flying_Battery_Rounded_Y).w, D0		 ; $FFFFEEA2
		move.w	D0, (AIz_Flying_Battery_Y).w		 ; $FFFFEE9C
		bra.s	Offset_0x031260
Offset_0x03124A:
		asr.w	#$02, D1
		andi.w	#$000F, D1
		lea		AIz_Battleship_Bobbing_Motion(PC), A1  ; Offset_0x031A5C
		move.b	(A1, D1), D1
		add.w	(AIz_Flying_Battery_Rounded_Y).w, D1		 ; $FFFFEEA2
		move.w	D1, (AIz_Flying_Battery_Y).w		 ; $FFFFEE9C
Offset_0x031260:
		subq.w	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bcc.s	Offset_0x031286
		move.l	Obj_Timer(A0), A2				 ; $002E
		move.w	(A2)+, Obj_Control_Var_02(A0)			 ; $0032
		bmi.s	Offset_0x031286
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.s	Offset_0x031286
		move.l	#Obj_AIz_FBz_Ship_Bomb, (A1)		   ; Offset_0x0312DC
		move.w	(A2)+, Obj_Timer(A1)					 ; $002E
		move.l	A2, Obj_Timer(A0)				 ; $002E
Offset_0x031286:
		rts
;-------------------------------------------------------------------------------
Obj_AIz_Battleship_Propeller:				   ; Offset_0x031288
		move.l	#Obj_AIz_Battleship_Propeller_Main, (A0) ; Offset_0x0312BA
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	#$0500, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#AIz_Battleship_Propeller_Mappings, Obj_Map(A0) ; Offset_0x031B48, $000C
		move.w	#$0A71, Obj_Control_Var_00(A0)			 ; $0030
;-------------------------------------------------------------------------------
Obj_AIz_Battleship_Propeller_Main:					   ; Offset_0x0312BA
		cmpi.w	#$000C, (Level_Events_Routine).w			 ; $FFFFEEC0
		bne.s	Offset_0x0312C8
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x0312C8:
		lea		AIz_Battleship_Propeller_Animate_Data(PC), A1 ; Offset_0x031B70
		jsr		(AnimateSprite).l				 ; Offset_0x01115E
		jsr		Offset_0x0313D8(PC)
		jmp		(DisplaySprite).l				 ; Offset_0x011148
;-------------------------------------------------------------------------------
Obj_AIz_FBz_Ship_Bomb:						   ; Offset_0x0312DC
		move.l	#Obj_AIz_FBz_Ship_Bomb_Main, (A0)	   ; Offset_0x031314
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	#$0500, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#AIz_FBz_Ship_Bomb_Main_Mappings, Obj_Map(A0) ; Offset_0x031B78, $000C
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.w	#$0A60, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$0006, Obj_Control_Var_02(A0)			 ; $0032
;-------------------------------------------------------------------------------
Obj_AIz_FBz_Ship_Bomb_Main;					   ; Offset_0x031314
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		jmp		Offset_0x03131E(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x03131E:
		bra.w	AIz_FBz_Ship_Bomb_Ready_Drop		   ; Offset_0x03132A
		bra.w	AIz_FBz_Ship_Bomb_Delay		   ; Offset_0x03133C
		bra.w	AIz_FBz_Ship_Bomb_Drop		   ; Offset_0x031358
;-------------------------------------------------------------------------------
AIz_FBz_Ship_Bomb_Ready_Drop:				   ; Offset_0x03132A
		addq.w	#$02, Obj_Control_Var_00(A0)			 ; $0030
		cmpi.w	#$0A80, Obj_Control_Var_00(A0)			 ; $0030
		bcs.s	Offset_0x03134E
		addq.b	#$04, Obj_Routine(A0)					 ; $0005
		bra.s	Offset_0x03134E
;-------------------------------------------------------------------------------
AIz_FBz_Ship_Bomb_Delay:					   ; Offset_0x03133C
		subq.w	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bne.s	Offset_0x03134E
		addq.b	#$04, Obj_Routine(A0)					 ; $0005
		moveq	#sfx_MissileThrow, D0					  ; $56
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x03134E:
		jsr		Offset_0x0313D8(PC)
		jmp		(DisplaySprite).l				 ; Offset_0x011148
;-------------------------------------------------------------------------------
AIz_FBz_Ship_Bomb_Drop:						   ; Offset_0x031358
		move.l	Obj_Y(A0), D0					 ; $0014
		add.l	Obj_Speed_Y(A0), D0				 ; $001A
		move.l	D0, Obj_Y(A0)					 ; $0014
		addi.l	#$00002000, Obj_Speed_Y(A0)				 ; $001A
		swap	D0
		jsr		Offset_0x0313E4(PC)
		jsr		(DisplaySprite).l				 ; Offset_0x011148
		jsr		(ObjHitFloor).l					 ; Offset_0x009D84
		cmpi.w	#$FFF8, D1
		bgt.s	Offset_0x0313D6
		move.w	#$0010, (Earthquake_Flag).w			 ; $FFFFEECC
		moveq	#sfx_MissileExplode, D0					; $52
		jsr		(Play_Music).l					 ; Offset_0x001176
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x0313D0
		lea		AIz_FBz_Bomb_Explosion_Data(PC), A2	   ; Offset_0x031AC2
		moveq	#$07, D1
Offset_0x0313A0:
		move.l	#Obj_AIz_FBz_Bomb_Explosion, (A1)	   ; Offset_0x031402
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	(A2)+, D2
		add.w	D2, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D2
		add.w	D2, Obj_Y(A1)					 ; $0014
		move.w	(A2)+, Obj_Ani_Number(A1)				 ; $0020
		move.w	(A2)+, Obj_Timer(A1)					 ; $002E
		jsr		(AllocateObject_Immediate).l			   ; Offset_0x011DC8
		dbne	D1, Offset_0x0313A0
Offset_0x0313D0:
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
Offset_0x0313D6:
		rts
;-------------------------------------------------------------------------------
Offset_0x0313D8:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		sub.w	(AIz_Flying_Battery_Y).w, D0		 ; $FFFFEE9C
		add.w	(Screen_Pos_Buffer_Y).w, D0			 ; $FFFFEE84
Offset_0x0313E4:
		sub.w	(Earthquake_Last_Offset).w, D0		 ; $FFFFEED0
		add.w	(Earthquake_Offset).w, D0			 ; $FFFFEECE
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	Obj_Timer(A0), D0				 ; $002E
		sub.w	(AIz_Flying_Battery_X).w, D0		 ; $FFFFEE98
		add.w	(Screen_Pos_Buffer_X).w, D0			 ; $FFFFEE80
		move.w	D0, Obj_X(A0)					 ; $0010
		rts
;-------------------------------------------------------------------------------
Obj_AIz_FBz_Bomb_Explosion:					   ; Offset_0x031402
		move.w	(Level_Repeat_Offset).w, D0			 ; $FFFFEEBC
		sub.w	D0, Obj_X(A0)					 ; $0010
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x031412
		rts
Offset_0x031412:
		move.l	#Offset_0x03143A, (A0)
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.w	#$0500, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#AIz_FBz_Ship_Bomb_Main_Mappings, Obj_Map(A0) ; Offset_0x031B78, $000C
		move.b	#$8B, Obj_Col_Flags(A0)					 ; $0028
		bra.s	Offset_0x031442
;-------------------------------------------------------------------------------
Offset_0x03143A:
		move.w	(Level_Repeat_Offset).w, D0			 ; $FFFFEEBC
		sub.w	D0, Obj_X(A0)					 ; $0010
Offset_0x031442:
		lea		AIz_FBz_Bomb_Explosion_Animate_Data(PC), A1 ; Offset_0x031BF0
		jsr		(AnimateSprite_2).l				 ; Offset_0x0111FE
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x031458
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x031458:
		moveq	#$04, D0
		add.b	Obj_Ani_Number(A0), D0					 ; $0020
		cmp.b	Obj_Map_Id(A0), D0				 ; $0022
		bls.s	Offset_0x03146A
		jsr		(Add_SpriteToCollisionResponseList).l		; Offset_0x00A540
Offset_0x03146A:
		jmp		(DisplaySprite).l				 ; Offset_0x011148
;-------------------------------------------------------------------------------
Obj_AIz_Make_Tree:							   ; Offset_0x031470
		cmpi.w	#$44D0, (Screen_Pos_Buffer_X).w		 ; $FFFFEE80
		bcc.s	Offset_0x03147A
		rts
Offset_0x03147A:
		move.l	#Offset_0x03148E, (A0)
		move.w	(Level_Events_Buffer_1).w, Obj_Timer(A0) ; $FFFFEEB6, $002E
		move.l	#AIz_Make_Tree_Script, Obj_Control_Var_00(A0) ; Offset_0x031B02, $0030
Offset_0x03148E:
		move.l	Obj_Control_Var_00(A0), A2				 ; $0030
		tst.w	(A2)
		bpl.s	Offset_0x03149C
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x03149C:
		move.w	(Level_Events_Buffer_1).w, D0		 ; $FFFFEEB6
		sub.w	Obj_Timer(A0), D0				 ; $002E
		cmp.w	(A2)+, D0
		bcs.s	Offset_0x0314BE
		jsr		(AllocateObjectAfterCurrent).l			; Offset_0x011DE0
		bne.s	Offset_0x0314BE
		move.l	#Obj_AIz_Background_Tree, (A1)		   ; Offset_0x0314C0
		move.w	(A2)+, Obj_Priority(A1)					 ; $0008
		move.l	A2, Obj_Control_Var_00(A0)				 ; $0030
Offset_0x0314BE:
		rts
;-------------------------------------------------------------------------------
Obj_AIz_Background_Tree:					   ; Offset_0x0314C0
		move.l	#Obj_AIz_Background_Tree_Move, (A0)	   ; Offset_0x0314E6
		move.w	#$043F, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#AIz_Background_Tree_Mappings, Obj_Map(A0) ; Offset_0x031C0E, $000C
		move.w	#$00E9, Obj_Y(A0)				 ; $0014
		move.w	#$01C0, Obj_Timer(A0)					 ; $002E
		move.w	(Level_Events_Buffer_1).w, Obj_Control_Var_00(A0) ; $FFFFEEB6, $0030
;-------------------------------------------------------------------------------
Obj_AIz_Background_Tree_Move:				   ; Offset_0x0314E6
		cmpi.w	#$4880, (Screen_Pos_Buffer_X).w		 ; $FFFFEE80
		bcs.s	Offset_0x0314F4
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x0314F4:
		move.w	(Level_Events_Buffer_1).w, D0		 ; $FFFFEEB6
		sub.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, D1
		asr.w	#$02, D0
		sub.w	D0, D1
		move.w	Obj_Timer(A0), D0				 ; $002E
		sub.w	D1, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		cmpi.w	#$01C0, D0
		bcc.s	Offset_0x031518
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x031518:
		rts
;-------------------------------------------------------------------------------
Obj_AIz_Boss_Small:							   ; Offset_0x03151A
		move.l	#Obj_AIz_Boss_Small_Main, (A0)		   ; Offset_0x03155A
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.w	#$0500, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#AIz_Boss_Small_Mappings, Obj_Map(A0) ; Offset_0x031C2A, $000C
		move.w	#$0030, Obj_X(A0)				 ; $0010
		move.w	#$00D8, Obj_Y(A0)				 ; $0014
		move.w	#$0005, Obj_Speed_X(A0)					 ; $0018
		clr.w	Obj_Timer(A0)					 ; $002E
		lea		(Palette_Row_1_Offset+$02).w, A1			 ; $FFFFED22
		lea		Pal_AIz_Boss_Small(PC), A5			   ; Offset_0x031A40
		moveq	#$06, D0
Offset_0x031554:
		move.l	(A5)+, (A1)+
		dbra	D0, Offset_0x031554
;-------------------------------------------------------------------------------
Obj_AIz_Boss_Small_Main:					   ; Offset_0x03155A
		tst.b	Obj_Timer(A0)					 ; $002E
		bne.s	Offset_0x031574
		cmpi.w	#$4670, (Screen_Pos_Buffer_X).w		 ; $FFFFEE80
		bcs.s	Offset_0x0315CA
		st		Obj_Timer(A0)					 ; $002E
		moveq	#Robotnik_Buzzer_Sfx, D0				   ; $57
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x031574:
		cmpi.w	#$0240, Obj_X(A0)				 ; $0010
		bcs.s	Offset_0x031594
		clr.b	(Sonic_Scroll_Lock_Flag).w			 ; $FFFFEE0A
		clr.w	(Level_Repeat_Routine).w			 ; $FFFFEEB2
		clr.w	(Level_Repeat_Offset).w				 ; $FFFFEEBC
		move.w	#$6000, (Sonic_Level_Limits_Max_X).w		 ; $FFFFEE16
		jmp		(DeleteObject).l				 ; Offset_0x011138
Offset_0x031594:
		move.l	Obj_X(A0), D0					 ; $0010
		move.l	Obj_Speed_X(A0), D1				 ; $0018
		add.l	D1, D0
		move.l	D0, Obj_X(A0)					 ; $0010
		tst.b	$002F(A0)
		bne.s	Offset_0x0315BA
		subi.l	#$00000E80, D1
		cmpi.l	#$FFFF0000, D1
		sle		$002F(A0)
		bra.s	Offset_0x0315C0
Offset_0x0315BA:
		addi.l	#$00000E80, D1
Offset_0x0315C0:
		move.l	D1, Obj_Speed_X(A0)				 ; $0018
		jmp		(DisplaySprite).l				 ; Offset_0x011148
Offset_0x0315CA:
		rts
;-------------------------------------------------------------------------------
; Nave do Robotnik seguindo a Flying Battery na Angel Island
; <<<-
;-------------------------------------------------------------------------------