;===============================================================================
; Objeto Game Over / Time Over
; ->>>
;===============================================================================
; Offset_0x02444C:
		tst.l	(PLC_Data_Buffer).w					 ; $FFFFF680
		beq.s	Offset_0x024454
		rts
Offset_0x024454:
		move.w	#$0050, Obj_X(A0)				 ; $0010
		btst	#$00, Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x024468
		move.w	#$01F0, Obj_X(A0)				 ; $0010
Offset_0x024468:
		move.w	#$00F0, Obj_Y(A0)				 ; $0014
		move.l	#Time_Over_Game_Over_Mappings, Obj_Map(A0) ; Offset_0x024FD2, $000C
		move.w	#$879C, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$0000, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x024488, (A0)
Offset_0x024488:
		moveq	#$10, D1
		cmpi.w	#$0120, Obj_X(A0)				 ; $0010
		beq.s	Offset_0x0244A0
		bcs.s	Offset_0x024496
		neg.w	D1
Offset_0x024496:
		add.w	D1, Obj_X(A0)					 ; $0010
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0244A0:
		move.w	#$02D0, Obj_Ani_Time(A0)				 ; $0024
		move.l	#Offset_0x0244AE, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x0244AE:
		btst	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.w	Offset_0x024540
		move.b	(Control_Ports_Buffer_Data+$01).w, D0		 ; $FFFFF605
		or.b	(Control_Ports_Buffer_Data+$03).w, D0		 ; $FFFFF607
		andi.b	#$70, D0
		bne.s	Offset_0x0244D6
		tst.w	Obj_Ani_Time(A0)				 ; $0024
		beq.s	Offset_0x0244D6
		subq.w	#$01, Obj_Ani_Time(A0)					 ; $0024
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0244D6:
		tst.b	(Time_Over_flag).w					 ; $FFFFFE1A
		bne.s	Offset_0x0244F6
		tst.b	(Time_Over_Flag_P2).w				 ; $FFFFFECC
		bne.s	Offset_0x0244F6
		move.b	#gm_Continue, (Game_Mode).w		; $14, $FFFFF600
		tst.b	(Continue_count).w					 ; $FFFFFE18
		bne.s	Offset_0x024500
		move.b	#gm_SEGALogo, (Game_Mode).w		; $00, $FFFFF600
		bra.s	Offset_0x024500
Offset_0x0244F6:
		clr.l	(Saved_Time).w				 ; $FFFFFE38
		move.w	#$0001, (Restart_Level_Flag).w		 ; $FFFFFE02
Offset_0x024500:
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		beq.s	Offset_0x024540
		move.w	#$0000, (Restart_Level_Flag).w		 ; $FFFFFE02
		move.b	#$18, (Game_Mode).w					 ; $FFFFF600
		move.w	#$0000, (Results_Screen_2P).w		 ; $FFFFFF02
		tst.b	(Time_Over_flag).w					 ; $FFFFFE1A
		bne.s	Offset_0x024540
		tst.b	(Time_Over_Flag_P2).w				 ; $FFFFFECC
		bne.s	Offset_0x024540
		move.w	#$0001, (Game_Over_2P_Flag).w		 ; $FFFFFF98
		move.w	#$0001, (Results_Screen_2P).w		 ; $FFFFFF02
		move.w	#$FFFF, (A4)
		tst.b	Obj_Player_One_Or_Two(A0)				 ; $003F
		beq.s	Offset_0x02453C
		addq.w	#$01, A4
Offset_0x02453C:
		move.b	#$FE, (A4)
Offset_0x024540:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;===============================================================================
; Objeto Game Over / Time Over
; <<<-
;===============================================================================