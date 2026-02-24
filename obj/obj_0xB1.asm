;===============================================================================
; Objeto 0xB1 - Chefe na Marble Garden
; ->>>
;===============================================================================
; Offset_0x039F9E:
		moveq	#0,d0
		move.b	Obj_Routine(A0),D0				 ; $0005
		move.w	Offset_0x039FB6(PC,D0.w),D1
		jsr	Offset_0x039FB6(PC,D1.w)
		bsr.w	Offset_0x03AC88
		jmp	(Add_To_Response_List_And_Display).l	   ; Offset_0x042450
;-------------------------------------------------------------------------------
Offset_0x039FB6:
		dc.w	Offset_0x039CB8-Offset_0x039FB6
		dc.w	Offset_0x039FC8-Offset_0x039FB6
		dc.w	Offset_0x03A002-Offset_0x039FB6
		dc.w	Offset_0x03A01E-Offset_0x039FB6
		dc.w	Offset_0x03A082-Offset_0x039FB6
		dc.w	Offset_0x03A060-Offset_0x039FB6
		dc.w	Offset_0x03A082-Offset_0x039FB6
		dc.w	Offset_0x03A060-Offset_0x039FB6
		dc.w	Offset_0x03A082-Offset_0x039FB6
;-------------------------------------------------------------------------------
Offset_0x039FC8:
		jsr	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		move.w	#$3A50, D0
		cmp.w	(Camera_X).w, D0					 ; $FFFFEE78
		bls.s	Offset_0x039FDA
		rts
Offset_0x039FDA:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	(Sonic_Level_Limits_Max_X).w, (Target_Camera_Max_X).w ; $FFFFEE16, $FFFFFA92
		move.w	D0, (Sonic_Level_Limits_Min_X).w			 ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w			 ; $FFFFEE16
		move.w	#$00B4, Obj_Child_Data(A0)				 ; $0030
		move.b	#$02, Obj_Subtype(A0)					 ; $002C
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03A002:
		jsr	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		subq.w	#$01, Obj_Child_Data(A0)				 ; $0030
		bmi.s	Offset_0x03A010
		rts
Offset_0x03A010:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03A01E:
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03A028
		rts
Offset_0x03A028:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A044, Obj_Child(A0)			 ; $0034
		move.b	#$00, Obj_Subtype(A0)					 ; $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x03A044:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A06C, Obj_Child(A0)			 ; $0034
		lea	(Boss_Data_Buffer+$02).w, A1		 ; $FFFFFA82
		bra.w	Offset_0x03AC0E
;-------------------------------------------------------------------------------
Offset_0x03A060:
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03A06C:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A088, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03A082:
		jmp	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x03A088:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		move.w	#$009F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A0AA, Obj_Child(A0)			 ; $0034
		move.b	#$02, Obj_Subtype(A0)					 ; $002C
		lea	(Boss_Data_Buffer+$0A).w, A1		 ; $FFFFFA8A
		bra.w	Offset_0x03AC0E
;-------------------------------------------------------------------------------
Offset_0x03A0AA:
		move.b	#$10, Obj_Routine(A0)					 ; $0005
		move.w	#$3AF0, Obj_X(A0)				 ; $0010
		move.w	#$04C0, Obj_Y(A0)				 ; $0014
		move.w	#$0077, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A010, Obj_Child(A0)			 ; $0034
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03A0D2:
		move.l	#Run_Object_Wait_Timer_A0, (A0)		   ; Offset_0x0423D2
		bset	#$04, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#Volume_Down, D0				  ; -$20
		jsr	(Play_Music).l					 ; Offset_0x001176
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A102, Obj_Child(A0)			 ; $0034
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		lea	Offset_0x03AEA8(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03A102:
		move.l	#Offset_0x03A10E, (A0)
		jmp	(Drill_Mobile_Defeated).l		   ; Offset_0x0374DA
;-------------------------------------------------------------------------------
Offset_0x03A10E:
		tst.b	(Control_Ports_Buffer_Data+$03).w			 ; $FFFFF607
		bne.s	Offset_0x03A11C
		tst.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		bne.w	Offset_0x039966
Offset_0x03A11C:
		clr.b	(Player_Control_Lock_Flag).w		 ; $FFFFFAA8
		jsr	(Restore_PlayerControl)		  ; Offset_0x0432EE
		jmp	(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03A12C:
		lea	Drill_Mobile_Setup_Data_3(PC), A1	   ; Offset_0x03AE08
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.l	#Obj_0xB0_MGz_Drill_Mobile, (A1)	   ; Offset_0x039C7E
		bne.s	Offset_0x03A146
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x03A146:
		move.l	#Offset_0x03A154, (A0)
		lea	Offset_0x03AE60(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03A154:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A1B2
		cmpi.b	#$02, Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x03A196
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03A190
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x03A196
		lea	Offset_0x03AE88(PC), A2
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03A188
		lea	Offset_0x03AE90(PC), A2
Offset_0x03A188:
		jsr	SetupChildObject_Repeat(PC)		   ; Offset_0x041E4E
		bra.w	Offset_0x03A196
Offset_0x03A190:
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x03A196:
		lea	Offset_0x03A946(PC), A2
		bsr.w	Offset_0x03A924
		lea	Offset_0x03A980(PC), A2
		bsr.w	Offset_0x03A966
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		jmp	(Child_Display_Or_Flicker_Move_2).l	   ; Offset_0x04250E
Offset_0x03A1B2:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03A1B8:
		lea	Drill_Mobile_Setup_Data_4(PC), A1	   ; Offset_0x03AE0E
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03A1D2, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x03A1D2:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A1B2
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A202
		lea	Offset_0x03A956(PC), A2
		bsr.w	Offset_0x03A924
Offset_0x03A1EE:
		lea	Offset_0x03A990(PC), A2
		bsr.w	Offset_0x03A966
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
Offset_0x03A202:
		move.l	#Offset_0x03A214, (A0)
		bsr.w	Offset_0x03A9F6
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03A214:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03A1B2
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03A238
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A252
		jsr	Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		bra.s	Offset_0x03A1EE
Offset_0x03A238:
		move.l	#Offset_0x03A2C4, (A0)
		move.l	#Offset_0x03A2CC, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x03AAA4
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
Offset_0x03A252:
		cmpi.b	#$02, Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x03A288
		move.l	#Offset_0x03A2E6, (A0)
		move.w	#$0027, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A2FE, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x03AA30
		bclr	#$05, Obj_Control_Var_08(A0)			 ; $0038
		lea	Offset_0x03AE80(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
Offset_0x03A288:
		move.l	#Offset_0x03A2E6, (A0)
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A36C, Obj_Child(A0)			 ; $0034
		bclr	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bsr.w	Offset_0x03AB2A
		lea	Offset_0x03AE98(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x03A2AE:
		bclr	#$05, Obj_Control_Var_08(A0)			 ; $0038
		lea	Offset_0x03AE80(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03A2C4:
		jsr	Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		bra.w	Offset_0x03A1EE
;-------------------------------------------------------------------------------
Offset_0x03A2CC:
		move.l	#Offset_0x03A1D2, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.l	#Offset_0x03A2FE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03A2E6:
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jsr	Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03A2FE:
		move.l	#Offset_0x03A31E, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bset	#$03, Obj_Control_Var_08(A1)			 ; $0038
		move.w	#$0000, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A330, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03A31E:
		jsr	Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03A330:
		move.l	#Offset_0x03A2E6, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$03, Obj_Control_Var_08(A1)			 ; $0038
		neg.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$0027, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A354, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03A354:
		move.l	#Offset_0x03A214, (A0)
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03A36C:
		move.l	#Offset_0x03A388, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A39A, Obj_Child(A0)			 ; $0034
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x03A388:
		jsr	Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr	(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move_2).l ; Offset_0x042538
;-------------------------------------------------------------------------------
Offset_0x03A39A:
		move.l	#Offset_0x03A2E6, (A0)
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A3C8, Obj_Child(A0)			 ; $0034
		bsr.w	Offset_0x03ABD0
		lea	Offset_0x03AE98(PC), A2
		jsr	SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.s	Offset_0x03A3C2
		move.b	#$02, Obj_Subtype(A1)					 ; $002C
Offset_0x03A3C2:
		bra.w	Offset_0x03A2AE
;-------------------------------------------------------------------------------
; Offset_0x03A3C6:
		moveq	#$00, D0
;-------------------------------------------------------------------------------
Offset_0x03A3C8:
		move.l	#Offset_0x03A3EC, (A0)
		ori.b	#$24, Obj_Control_Var_08(A0)			 ; $0038
		move.w	Obj_Height_3(A0), A1					 ; $0044
		bset	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		subi.w	#$0080, Obj_Y(A0)				 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x03A3EC:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A3FE
		move.l	#Offset_0x03A214, (A0)
Offset_0x03A3FE:
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move).l  ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x03A406:
		lea	Drill_Mobile_Setup_Data_2(PC), A1	   ; Offset_0x03AE02
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03A416, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x03A416:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03A1B2
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp	(Child_Display_Or_Delete_2).l			   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03A42E:
		lea	Drill_Mobile_Setup_Data_4(PC), A1	   ; Offset_0x03AE0E
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x03A474, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		move.w	Offset_0x03A45C(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		lsr.w	#$01, D0
		move.b	Offset_0x03A46C(PC, D0), Obj_Map_Id(A0)			 ; $0022
		jmp	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
;-------------------------------------------------------------------------------
Offset_0x03A45C:
		dc.b	$0C, $00, $03, $F9, $00, $F0, $FD, $F9
		dc.b	$F4, $00, $FD, $07, $00, $10, $0C, $00
;-------------------------------------------------------------------------------
Offset_0x03A46C:
		dc.b	$1C, $15, $2C, $2A, $2D, $2B, $29, $1C
;-------------------------------------------------------------------------------
Offset_0x03A474:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A492
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A492
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03A492:
		jmp	(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x03A498:
		move.l	#Offset_0x03A4BE, (A0)
		move.l	#Offset_0x03A4DC, Obj_Child(A0)			 ; $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		move.b	Obj_Flags(A1), Obj_Flags(A0)			  ; $0004, $0004
		move.w	#$0004, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03A4BE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A4D6
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A4D6
		jmp	Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x03A4D6:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03A4DC:
		move.w	#$0004, Obj_Timer(A0)					 ; $002E
		lea	Offset_0x03AEA0(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03A4EA:
		lea	Drill_Mobile_Setup_Data_5(PC), A1	   ; Offset_0x03AE14
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03A526, (A0)
		move.w	#$002F, Obj_Timer(A0)					 ; $002E
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A2					 ; $0046
		move.w	A2, Obj_Height_3(A0)					 ; $0044
		move.w	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		move.w	Obj_Subtype(A1), Obj_Subtype(A0)		  ; $002C, $002C
		bsr.w	Offset_0x03AA30
		bra.w	Offset_0x03AD22
;-------------------------------------------------------------------------------
Offset_0x03A526:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A540
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jsr	Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		bra.w	Offset_0x03AD22
Offset_0x03A540:
		move.l	#Offset_0x03A554, (A0)
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		bra.w	Offset_0x03AD22
;-------------------------------------------------------------------------------
Offset_0x03A554:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A1), A2					 ; $0046
		move.w	Obj_Y(A1), D0					 ; $0014
		move.b	Obj_Subtype(A2), D1				 ; $002C
		cmp.b	Obj_Subtype(A0), D1				 ; $002C
		bne.s	Offset_0x03A59C
		tst.b	D1
		bne.s	Offset_0x03A588
		moveq	#$10, D1
		btst	#$01, (Boss_Data_Buffer+$03).w		 ; $FFFFFA83
		bne.s	Offset_0x03A57A
		moveq	#$18, D1
Offset_0x03A57A:
		add.w	D1, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bcs.s	Offset_0x03A59C
Offset_0x03A582:
		jmp	(Go_Delete_Object_A0)		   ; Offset_0x042D3E
Offset_0x03A588:
		moveq	#$14, D1
		btst	#$01, (Boss_Data_Buffer+$0B).w		 ; $FFFFFA8B
		bne.s	Offset_0x03A594
		moveq	#$1C, D1
Offset_0x03A594:
		sub.w	D1, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bls.s	Offset_0x03A582
Offset_0x03A59C:
		bra.w	Offset_0x03AD22
;-------------------------------------------------------------------------------
Offset_0x03A5A0:
		lea	Drill_Mobile_Setup_Data_5(PC), A1	   ; Offset_0x03AE14
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03A5BA, (A0)
		bsr.w	Offset_0x03AA6A
		move.l	#Offset_0x03A5D4, Obj_Child(A0)			 ; $0034
Offset_0x03A5BA:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03A5D4
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		beq.w	Offset_0x039966
		jmp	(Go_Delete_Object_A0).l		   ; Offset_0x042D3E
Offset_0x03A5D4:
		move.l	#Offset_0x03A5EC, (A0)
		move.b	#$17, Obj_Map_Id(A0)					 ; $0022
		clr.w	Obj_Timer(A0)					 ; $002E
		moveq	#$00, D0
		jmp	(Child_Display_Touch_Or_Flicker_Move).l  ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x03A5EC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A60C
		move.b	#$16, Obj_Map_Id(A0)					 ; $0022
		addq.w	#$01, Obj_Timer(A0)				 ; $002E
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
Offset_0x03A60C:
		move.l	#Offset_0x03A618, (A0)
		moveq	#$00, D0
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x03A618:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x03A628
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
Offset_0x03A628:
		move.l	#Offset_0x03A638, (A0)
		neg.w	Obj_Speed_X(A0)					 ; $0018
		moveq	#$00, D0
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x03A638:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x03A648
		jsr	(SpeedToPos).l				   ; Offset_0x01111E
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
Offset_0x03A648:
		move.b	#$17, Obj_Map_Id(A0)					 ; $0022
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		moveq	#$00, D0
		jmp	Child_Display_Touch_Or_Flicker_Move(PC) ; Offset_0x042520
;-------------------------------------------------------------------------------
Offset_0x03A65A:
		lea	Drill_Mobile_Setup_Data_6(PC), A1	   ; Offset_0x03AE1A
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x03A696, (A0)
		move.b	Obj_Subtype(A0), D0				 ; $002C
		subi.b	#$04, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
		beq.s	Offset_0x03A68E
		move.w	#$0380, Obj_Priority(A0)				 ; $0008
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.l	#Obj_0xB0_MGz_Drill_Mobile, (A1)	   ; Offset_0x039C7E
		bne.s	Offset_0x03A68E
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x03A68E:
		lea	Offset_0x03AE68(PC), A2
		jmp	SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x03A696:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x03A6B4
		lea	Offset_0x03A9CE(PC), A2
		bsr.w	Offset_0x03A9A0
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$14, D0
		jmp	Child_Display_Or_Flicker_Move_2(PC)	   ; Offset_0x04250E
Offset_0x03A6B4:
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#DeleteObject, (A0)			   ; Offset_0x011138
		rts
;-------------------------------------------------------------------------------
Offset_0x03A6C2:
		lea	Drill_Mobile_Setup_Data_7(PC), A1	   ; Offset_0x03AE20
		jsr	SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x03A6FC, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		tst.b	Obj_Subtype(A1)					 ; $002C
		beq.s	Offset_0x03A6E6
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
Offset_0x03A6E6:
		bclr	#$07, Obj_Art_VRAM(A0)					 ; $000A
		btst	#$07, Obj_Art_VRAM(A1)					 ; $000A
		beq.s	Offset_0x03A6FA
		bset	#$07, Obj_Art_VRAM(A0)					 ; $000A
Offset_0x03A6FA:
		rts
;-------------------------------------------------------------------------------
Offset_0x03A6FC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03A1B2
		lea	Offset_0x03A9E2(PC), A2
		bsr.w	Offset_0x03A9A0
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03A730
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		bne.w	Offset_0x039966
		jmp	Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
Offset_0x03A730:
		jmp	(Go_Delete_Object_A0_2).l		   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Offset_0x03A736:
		lea	Drill_Mobile_Setup_Data_8(PC), A1	   ; Offset_0x03AE28
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03A748, (A0)
		bra.w	Offset_0x03AADE
;-------------------------------------------------------------------------------
Offset_0x03A748:
		jsr	(Move_Light_Gravity).l		   ; Offset_0x0426C2
		jmp	(Delete_Sprite_Check_X_Y).l			   ; Offset_0x042AD0
;-------------------------------------------------------------------------------
; Offset_0x03A754:
		lea	Drill_Mobile_Setup_Data_9(PC), A1	   ; Offset_0x03AE34
		jsr	SetupObjectAttributes3(PC)
		move.l	#Offset_0x03A76E, (A0)
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), Obj_Height_3(A0)		  ; $0046, $0044
		rts
;-------------------------------------------------------------------------------
Offset_0x03A76E:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03A7A0
		btst	#$06, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03A794
		lea	Offset_0x03AFF6(PC), A1
		jsr	Animate_Raw_A1(PC)			   ; Offset_0x042092
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03A794:
		move.b	#$02, Obj_Map_Id(A0)					 ; $0022
		jmp	(DisplaySprite).l				   ; Offset_0x011148
Offset_0x03A7A0:
		move.l	#Offset_0x03A7B2, (A0)
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		jmp	(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x03A7B2:
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		jmp	Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x03A7BA:
		lea	Drill_Mobile_Setup_Data_3(PC), A1	   ; Offset_0x03AE08
		jsr	SetupObjectAttributes3(PC)			; Offset_0x041D7A
		jsr	Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		move.l	#Obj_Flicker_Move, (A0)		   ; Offset_0x042AFE
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x03A7DA
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
Offset_0x03A7DA:
		lsr.w	#$01, D0
		addi.b	#$2E, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		moveq	#$28, D0
		jmp	(Set_Indexed_Velocity).l		   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x03A7EC:
		lea	Drill_Mobile_Setup_Data_A(PC), A1	   ; Offset_0x03AE3A
		jsr	SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x03A856, (A0)
		move.w	#$7F40, Obj_Control_Var_0A(A0)			 ; $003A
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$0140, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	D0, Obj_Child_Data(A0)					 ; $0030
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		addi.w	#$0050, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.w	D0, Obj_Child(A0)				 ; $0034
		move.w	#$FC00, Obj_Speed_X(A0)					 ; $0018
		move.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		move.l	#Art_Drill_Mobile_Scaling, Obj_Control_Var_12(A0) ; Offset_0x1187B6, $0042
		move.b	#$01, Obj_Control_Var_0E(A0)			 ; $003E
		bsr.w	Offset_0x03AD44
		moveq	#$06, D0
		move.w	Obj_Inertia(A0), D1				 ; $001C
		beq.s	Offset_0x03A84E
		cmpi.w	#$000C, D1
		beq.s	Offset_0x03A84E
		moveq	#$10, D0
Offset_0x03A84E:
		move.w	D0, Obj_Timer(A0)				 ; $002E
		bra.w	Offset_0x03A8E2
;-------------------------------------------------------------------------------
Offset_0x03A856:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x03A91E
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		add.w	Obj_Timer(A0), D0				 ; $002E
		cmpi.w	#$FF00, D0
		bgt.s	Offset_0x03A876
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
Offset_0x03A876:
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		move.w	Obj_Control_Var_0C(A0), D1				 ; $003C
		bmi.s	Offset_0x03A88C
		add.w	D1, D0
		cmpi.w	#$0400, D0
		ble.s	Offset_0x03A894
		bra.w	Offset_0x03A898
Offset_0x03A88C:
		add.w	D1, D0
		cmpi.w	#$FC00, D0
		blt.s	Offset_0x03A898
Offset_0x03A894:
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
Offset_0x03A898:
		bsr.w	Offset_0x03AD88
		move.w	Obj_Child_Data(A0), D2					 ; $0030
		move.w	Obj_Child(A0), D3				 ; $0034
		moveq	#$00, D0
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		addq.w	#$04, D0
		move.l	#$00000100, D4
		divu.w	D0, D4
		sub.w	D4, D2
		sub.w	D4, D3
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D3, Obj_Y(A0)					 ; $0014
		move.b	(Vint_runcount+$03).w, D0		  ; $FFFFFE0F
		andi.b	#$03, D0
		bne.s	Offset_0x03A914
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		add.b	Obj_Control_Var_0E(A0), D0				 ; $003E
		andi.b	#$7F, D0
		cmpi.b	#$04, D0
		bcs.w	Offset_0x03A8E2
		move.b	D0, Obj_Control_Var_10(A0)				 ; $0040
Offset_0x03A8E2:
		clr.w	(Art_Scaling_Data_Buffer).w			 ; $FFFFF740
		move.l	A0, -(sp)
		jsr	(Init_Art_Scaling).l			   ; Offset_0x01AB3C
		move.l	(sp)+, A0
		move.l	A0, -(sp)
		move.w	Obj_Art_VRAM(A0), D0					 ; $000A
		jsr	(Perform_Scaling).l			   ; Offset_0x01ABE2
		move.l	(sp)+, A0
		move.w	(Art_Scaling_Data_Buffer).w, D3		 ; $FFFFF740
		lsl.w	#$04, D3
		move.l	#(M68K_Dev_RAM_Start+$8000), D1		 ; $FFFE8000
		move.w	Obj_Control_Var_0A(A0), D2				 ; $003A
		jsr	(QueueDMATransfer).l				; Offset_0x0012FC
Offset_0x03A914:
		move.w	Obj_Child_Data(A0), D0					 ; $0030
		jmp	(MarkObjGone_2).l				   ; Offset_0x011B1A
Offset_0x03A91E:
		jmp	(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x03A924:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		move.w	D0, Obj_Angle(A0)				 ; $0026
		lea	(A2, D0.w), A3
		move.b	(A3)+, Obj_Map_Id(A0)					 ; $0022
		moveq	#$00, D0
		move.b	(A3)+, D0
		beq.s	Offset_0x03A944
		lsl.w	#$04, D0
		move.w	D0, Obj_Priority(A0)					 ; $0008
Offset_0x03A944:
		rts
;-------------------------------------------------------------------------------
Offset_0x03A946:
		dc.b	$02, $30, $03, $30, $1E, $30, $1F, $30
		dc.b	$05, $30, $03, $30, $04, $30, $02, $30
;-------------------------------------------------------------------------------
Offset_0x03A956:
		dc.b	$09, $28, $0C, $28, $20, $28, $14, $30
		dc.b	$13, $30, $12, $30, $0F, $28, $09, $28
;-------------------------------------------------------------------------------
Offset_0x03A966:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		move.w	D0, Obj_Angle(A0)				 ; $0026
		lea	(A2, D0.w), A3
		move.b	(A3)+, Obj_Control_Var_12(A0)			 ; $0042
		move.b	(A3)+, Obj_Control_Var_13(A0)			 ; $0043
		rts
;-------------------------------------------------------------------------------
Offset_0x03A980:
		dc.b	$E4, $10, $F6, $18, $0C, $1C, $18, $14
		dc.b	$2C, $08, $20, $F4, $14, $EC, $E4, $10
;-------------------------------------------------------------------------------
Offset_0x03A990:
		dc.b	$E9, $00, $EF, $16, $00, $20, $10, $0F
		dc.b	$11, $00, $10, $F0, $00, $E0, $E9, $00
;-------------------------------------------------------------------------------
Offset_0x03A9A0:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Control_Var_0A(A1), D0				 ; $003A
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		add.w	D0, D0
		lea	(A2, D0.w), A3
		move.b	(A3)+, Obj_Control_Var_12(A0)			 ; $0042
		move.b	(A3)+, Obj_Control_Var_13(A0)			 ; $0043
		move.b	(A3)+, Obj_Map_Id(A0)					 ; $0022
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x03A9CC
		subi.b	#$14, Obj_Control_Var_12(A0)			 ; $0042
Offset_0x03A9CC:
		rts
;-------------------------------------------------------------------------------
Offset_0x03A9CE:
		dc.b	$08, $18, $06, $00, $F8, $14, $07, $00
		dc.b	$18, $14, $08, $00, $18, $08, $18, $00
		dc.b	$18, $FC, $23, $00
;-------------------------------------------------------------------------------
Offset_0x03A9E2:
		dc.b	$00, $10, $19, $00, $F8, $08, $1A, $00
		dc.b	$08, $08, $24, $00, $10, $00, $1B, $00
		dc.b	$09, $F9, $25, $00
;-------------------------------------------------------------------------------
Offset_0x03A9F6:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Angle(A1), D0				 ; $0026
		add.w	D0, D0
		move.l	Offset_0x03AA10(PC, D0.w), Obj_Child_Data(A0)		 ; $0030
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		rts
;-------------------------------------------------------------------------------
Offset_0x03AA10:
		dc.l	Offset_0x03AECD
		dc.l	Offset_0x03AEF4
		dc.l	Offset_0x03AF1B
		dc.l	Offset_0x03AF42
		dc.l	Offset_0x03AF47
		dc.l	Offset_0x03AF4C
		dc.l	Offset_0x03AF53
		dc.l	Offset_0x03AECD
;-------------------------------------------------------------------------------
Offset_0x03AA30:
		move.w	Obj_Angle(A0), D0				 ; $0026
		add.w	D0, D0
		move.l	Offset_0x03AA4A(PC, D0.w), Obj_Speed_X(A0)		 ; $0018
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x03AA48
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03AA48:
		rts
;-------------------------------------------------------------------------------
Offset_0x03AA4A:
		dc.w	$FC00, $0000, $FC00, $0400, $0000, $0400, $0400, $0400
		dc.w	$0400, $0000, $0400, $FC00, $0000, $FC00, $FC00, $0000
;-------------------------------------------------------------------------------
Offset_0x03AA6A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Angle(A1), D0				 ; $0026
		add.w	D0, D0
		move.l	Offset_0x03AA4A(PC, D0.w), Obj_Speed_X(A0)		 ; $0018
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x03AA86
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03AA86:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03AA94(PC, D0.w), Obj_Timer(A0)			 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x03AA94:
		dc.w	$0004, $0009, $000E, $0013, $0018, $001D, $0022, $0027
;-------------------------------------------------------------------------------
Offset_0x03AAA4:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Angle(A1), D0				 ; $0026
		add.w	D0, D0
		move.l	Offset_0x03AABE(PC, D0.w), Obj_Child_Data(A0)		 ; $0030
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		rts
;-------------------------------------------------------------------------------
Offset_0x03AABE:
		dc.l	Offset_0x03AF7A
		dc.l	Offset_0x03AF99
		dc.l	Offset_0x03AFB8
		dc.l	Offset_0x03AF42
		dc.l	Offset_0x03AF47
		dc.l	Offset_0x03AF4C
		dc.l	Offset_0x03AFD7
		dc.l	Offset_0x03AF7A
;-------------------------------------------------------------------------------
Offset_0x03AADE:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	D0, D1
		lsr.w	#$01, D0
		move.b	Offset_0x03AAF8(PC, D0.w), Obj_Map_Id(A0)			 ; $0022
		add.w	D1, D1
		move.l	Offset_0x03AB02(PC, D1.w), Obj_Speed_X(A0)		 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x03AAF8:
		dc.b	$00, $01, $02, $00, $00, $01, $00, $02
		dc.b	$00, $01
;-------------------------------------------------------------------------------
Offset_0x03AB02:
		dc.w	$FC00, $FC00, $0400, $FC00, $FF80, $FC00, $0080, $FC00
		dc.w	$FD00, $FE00, $0300, $FE00, $FE00, $FD00, $0200, $FD00
		dc.w	$FF80, $FE00, $0080, $FE00
;-------------------------------------------------------------------------------
Offset_0x03AB2A:
		jsr	(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$00FF, D0
		move.w	D0, D1
		andi.w	#$0001, D1
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		subi.w	#$0080, D0
		bcc.s	Offset_0x03AB4E
		addq.w	#$02, D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03AB4E:
		move.w	#$0550, D3
		lea	(Boss_Data_Buffer+$02).w, A2		 ; $FFFFFA82
Offset_0x03AB56:
		move.w	#$3AF0, D2
		add.w	D0, D2
		add.w	D1, D1
		move.w	Offset_0x03ABA0(PC, D1.w), D4
		move.w	D4, Obj_Angle(A0)				 ; $0026
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D3, Obj_Y(A0)					 ; $0014
		move.w	D1, (A2)+
		move.w	D4, (A2)+
		move.w	D2, (A2)+
		move.w	D3, (A2)+
		add.w	D1, D1
		move.l	Offset_0x03ABB0(PC, D1.w), Obj_Child_Data(A0)		 ; $0030
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		add.w	D4, D4
		lea	Offset_0x03AA4A(PC), A3
		move.l	(A3, D4.w), Obj_Speed_X(A0)			 ; $0018
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03AB9E
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03AB9E:
		rts
;-------------------------------------------------------------------------------
Offset_0x03ABA0:
		dc.w	$0004, $0002, $0004, $0002, $000C, $000A, $000C, $000A
;-------------------------------------------------------------------------------
Offset_0x03ABB0:
		dc.l	Offset_0x03AF3B
		dc.l	Offset_0x03AF14
		dc.l	Offset_0x03AF3B
		dc.l	Offset_0x03AF14
		dc.l	Offset_0x03AF73
		dc.l	Offset_0x03AF4C
		dc.l	Offset_0x03AF73
		dc.l	Offset_0x03AF4C
;-------------------------------------------------------------------------------
Offset_0x03ABD0:
		jsr	(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$007F, D0
		move.w	D0, D1
		andi.w	#$0001, D1
		addq.w	#$04, D1
		move.w	(Boss_Data_Buffer+$02).w, D2		 ; $FFFFFA82
		lsr.w	#$01, D2
		bset	#$00, Obj_Flags(A0)				 ; $0004
		move.b	Offset_0x03AC0A(PC, D2.w), D3
		beq.s	Offset_0x03ABFC
		neg.w	D0
		bclr	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x03ABFC:
		add.b	D3, D1
		move.w	#$0610, D3
		lea	(Boss_Data_Buffer+$0A).w, A2		 ; $FFFFFA8A
		bra.w	Offset_0x03AB56
;-------------------------------------------------------------------------------
Offset_0x03AC0A:
		dc.b	$02, $00, $00, $02
;-------------------------------------------------------------------------------
Offset_0x03AC0E:
		move.w	(A1)+, D0
		move.w	(A1)+, D1
		move.w	D1, Obj_Angle(A0)				 ; $0026
		move.w	(A1)+, D2
		move.w	(A1)+, D3
		lea	Offset_0x03AC6C(PC, D0.w), A2
		move.b	(A2)+, D4
		ext.w	D4
		add.w	D4, D2
		move.w	D2, Obj_X(A0)					 ; $0010
		move.b	(A2)+, D4
		ext.w	D4
		add.w	D4, D3
		move.w	D3, Obj_Y(A0)					 ; $0014
		lsr.w	#$01, D0
		move.b	Offset_0x03AC7C(PC, D0.w), Obj_Control_Var_0A(A0)	 ; $003A
		lsr.w	#$01, D0
		move.b	Offset_0x03AC84(PC, D0.w), D2
		andi.b	#$FC, Obj_Flags(A0)				 ; $0004
		or.b	D2, Obj_Flags(A0)				 ; $0004
		add.w	D1, D1
		lea	Offset_0x03AA4A(PC), A2
		move.l	(A2, D1.w), Obj_Speed_X(A0)			 ; $0018
		asr.w	Obj_Speed_X(A0)					 ; $0018
		asr.w	Obj_Speed_Y(A0)					 ; $001A
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x03AC6A
		neg.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x03AC6A:
		rts
;-------------------------------------------------------------------------------
Offset_0x03AC6C:
		dc.b	$F4, $D4, $1A, $D8, $0C, $D4, $E6, $D8
		dc.b	$14, $24, $30, $1C, $EC, $24, $D0, $1C
;-------------------------------------------------------------------------------
Offset_0x03AC7C:
		dc.b	$00, $08, $00, $08, $00, $02, $00, $02
;-------------------------------------------------------------------------------
Offset_0x03AC84:
		dc.b	$00, $01, $01, $00
;-------------------------------------------------------------------------------
Offset_0x03AC88:
		tst.b	Obj_Col_Flags(A0)				 ; $0028
		bne.s	Offset_0x03ACDA
		tst.b	Obj_Boss_Hit(A0)				 ; $0029
		beq.s	Offset_0x03ACDC
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03ACA8
		move.b	#$20, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Boss_Hit_Sfx, D0				   ; $7C
		jsr	(Play_Music).l					 ; Offset_0x001176
Offset_0x03ACA8:
		bset	#$06, Obj_Status(A0)					 ; $002A
		moveq	#$00, D0
		btst	#$00, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03ACBC
		addi.w	#2*3, D0
Offset_0x03ACBC:
		bsr.w	Offset_0x03ACFA
		subq.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x03ACDA
		bclr	#$06, Obj_Status(A0)					 ; $002A
		cmpi.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x03ACDA
		move.b	Obj_Ani_Time_2(A0), Obj_Col_Flags(A0)	  ; $0025, $0028
Offset_0x03ACDA:
		rts
Offset_0x03ACDC:
		move.l	#Display_Sprite_Wait, (A0)			   ; Offset_0x042F8E
		clr.b	(Update_HUD_timer).w		   ; $FFFFFE1E
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x03A0D2, Obj_Child(A0)				   ; $0034
		rts
Offset_0x03ACFA:
		lea	Offset_0x03AD10(PC), A1
		lea	Offset_0x03AD16(PC, D0.w), A2
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		move.w	(A1)+, A3
		move.w	(A2)+, (A3)+
		rts
;-------------------------------------------------------------------------------
Offset_0x03AD10:
		dc.w	(Palette_Row_1_Offset+$16)				 ; $ED36
		dc.w	(Palette_Row_1_Offset+$1A)				 ; $ED3A
		dc.w	(Palette_Row_1_Offset+$1C)				 ; $ED3C
;-------------------------------------------------------------------------------
Offset_0x03AD16:
		dc.w	$0020, $0866, $0644, $0EEE, $0888, $0AAA
;-------------------------------------------------------------------------------
Offset_0x03AD22:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		btst	#$07, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x03AD36
		jmp	Add_To_Response_List_And_Display(PC)   ; Offset_0x042450
Offset_0x03AD36:
		jsr	(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.w	#$003C, D0
		jmp	Run_Flicker_Move(PC)		   ; Offset_0x0424F4
Offset_0x03AD44:
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Control_Var_09(A2), D0				 ; $0039
		addq.b	#$01, Obj_Control_Var_09(A2)			 ; $0039
		andi.b	#$07, D0
		move.b	Offset_0x03AD80(PC, D0), D0
		move.w	D0, Obj_Inertia(A0)				 ; $001C
		move.w	D0, Obj_Control_Var_0C(A2)				 ; $003C
		lea	Offset_0x03AD70(PC, D0.w), A1
		move.w	(A1)+, Obj_Speed_Y(A0)					 ; $001A
		move.w	(A1)+, Obj_Control_Var_0C(A0)			 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x03AD70:
		dc.w	$FE00, $0008, $FA00, $0040, $0600, $FFC0, $FE00, $0008
;-------------------------------------------------------------------------------
Offset_0x03AD80:
		dc.b	$00, $08, $04, $00, $00, $04, $00, $08
;-------------------------------------------------------------------------------
Offset_0x03AD88:
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Child_Data(A0)					 ; $0030
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Child(A0)				 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x03ADA2:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		lea	Offset_0x03ADCE(PC, D0.w), A2
		move.w	(A2)+, D1
		add.w	(Camera_X).w, D1					 ; $FFFFEE78
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	(A2)+, D1
		add.w	(Camera_Y).w, D1					 ; $FFFFEE7C
		move.w	D1, Obj_Y(A0)					 ; $0014
		move.l	Offset_0x03ADDE(PC, D0.w), Obj_Speed_X(A0)		 ; $0018
		lsr.w	#$01, D0
		move.w	Offset_0x03ADEE(PC, D0.w), Obj_Angle(A0)			 ; $0026
		rts
;-------------------------------------------------------------------------------
Offset_0x03ADCE:
		dc.w	$FFC0, $0070, $00A0, $0120, $00A0, $FFB0, $FFC0, $0070
;-------------------------------------------------------------------------------
Offset_0x03ADDE:
		dc.w	$0200, $0000, $0080, $FE00, $0080, $0200, $0200, $0000
;-------------------------------------------------------------------------------
Offset_0x03ADEE:
		dc.w	$0000, $000C, $0004, $0000
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data:					   ; Offset_0x03ADF6
		dc.l	Drill_Mobile_Mappings		   ; Offset_0x10F5C0
		dc.w	$22D0, $0300
		dc.b	$24, $20, $00, $0F
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_2:					   ; Offset_0x03AE02
		dc.w	$0380
		dc.b	$10, $10, $01, $00
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_3:					   ; Offset_0x03AE08
		dc.w	$0300
		dc.b	$18, $18, $02, $00
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_4:					   ; Offset_0x03AE0E
		dc.w	$0280
		dc.b	$0C, $0C, $09, $8B
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_5:					   ; Offset_0x03AE14
		dc.w	$0200
		dc.b	$04, $04, $16, $98
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_6:					   ; Offset_0x03AE1A
		dc.w	$0180
		dc.b	$0C, $0C, $06, $00
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_7:					   ; Offset_0x03AE20
		dc.w	$02D0, $0180
		dc.b	$0C, $0C, $19, $9A
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_8:					   ; Offset_0x03AE28
		dc.l	Drill_Mobile_Debris_Mappings		   ; Offset_0x11074E
		dc.w	$C3EF, $0100
		dc.b	$10, $10, $00, $00
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_9:					   ; Offset_0x03AE34
		dc.w	$0200
		dc.b	$10, $04, $00, $00
;-------------------------------------------------------------------------------
Drill_Mobile_Setup_Data_A:					   ; Offset_0x03AE3A
		dc.l	Scaling_Mappings			   ; Offset_0x01B1B8
		dc.w	$23FA, $0300
		dc.b	$20, $20, $00, $00
;-------------------------------------------------------------------------------
Offset_0x03AE46:
		dc.w	$0003
		dc.l	Offset_0x03A406
		dc.b	$EC, $0F
		dc.l	Offset_0x03A12C
		dc.b	$E4, $10
		dc.l	Offset_0x03A65A
		dc.b	$08, $18
		dc.l	Offset_0x03A65A
		dc.b	$F4, $18
;-------------------------------------------------------------------------------
Offset_0x03AE60:
		dc.w	$0000
		dc.l	Offset_0x03A1B8
		dc.b	$E9, $00
;-------------------------------------------------------------------------------
Offset_0x03AE68:
		dc.w	$0000
		dc.l	Offset_0x03A6C2
		dc.b	$00, $10
;-------------------------------------------------------------------------------
Offset_0x03AE70:
		dc.w	$0009
		dc.l	Offset_0x03A736
		dc.b	$18, $C0
;-------------------------------------------------------------------------------
Offset_0x03AE78:
		dc.w	$0009
		dc.l	Offset_0x03A736
		dc.b	$E8, $C0
;-------------------------------------------------------------------------------
Offset_0x03AE80:
		dc.w	$0000
		dc.l	Offset_0x03A42E
		dc.b	$0C, $00
;-------------------------------------------------------------------------------
Offset_0x03AE88:
		dc.w	$0007
		dc.l	Offset_0x03A5A0
		dc.b	$F0, $00
;-------------------------------------------------------------------------------
Offset_0x03AE90:
		dc.w	$0007
		dc.l	Offset_0x03A5A0
		dc.b	$10, $00
;-------------------------------------------------------------------------------
Offset_0x03AE98:
		dc.w	$0000
		dc.l	Offset_0x03A498
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03AEA0:
		dc.w	$0000
		dc.l	Offset_0x03A4EA
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x03AEA8:
		dc.w	$0002
		dc.l	Offset_0x03A7BA
		dc.b	$0C, $EC
		dc.l	Offset_0x03A7BA
		dc.b	$F0, $08
		dc.l	Offset_0x03A7BA
		dc.b	$14, $08
;-------------------------------------------------------------------------------
Offset_0x03AEBC:
		dc.w	$0000
		dc.l	Offset_0x03A7EC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
; Offset_0x03AEC4:
		dc.b	$00, $05, $01, $05, $02, $05, $03, $05, $FC
;-------------------------------------------------------------------------------
Offset_0x03AECD:
		dc.b	$09, $07, $0A, $07, $0B, $07, $09, $06
		dc.b	$0A, $06, $0B, $06, $09, $05, $0A, $05
		dc.b	$0B, $05, $09, $04, $0A, $04, $0B, $04
		dc.b	$09, $03, $0A, $03, $0B, $03, $F8, $20
		dc.b	$09, $02, $0A, $02, $0B, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03AEF4:
		dc.b	$0C, $07, $0D, $07, $0E, $07, $0C, $06
		dc.b	$0D, $06, $0E, $06, $0C, $05, $0D, $05
		dc.b	$0E, $05, $0C, $04, $0D, $04, $0E, $04
		dc.b	$0C, $03, $0D, $03, $0E, $03, $F8, $20
;-------------------------------------------------------------------------------
Offset_0x03AF14:
		dc.b	$0C, $02, $0D, $02, $0E, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF1B:
		dc.b	$20, $07, $21, $07, $22, $07, $20, $06
		dc.b	$21, $06, $22, $06, $20, $05, $21, $05
		dc.b	$22, $05, $20, $04, $21, $04, $22, $04
		dc.b	$20, $03, $21, $03, $22, $03, $F8, $20
;-------------------------------------------------------------------------------
Offset_0x03AF3B:
		dc.b	$20, $02, $21, $02, $22, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF42:
		dc.b	$14, $7F, $14, $7F, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF47:
		dc.b	$13, $7F, $13, $7F, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF4C:
		dc.b	$26, $02, $27, $02, $28, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF53:
		dc.b	$0F, $07, $10, $07, $11, $07, $0F, $06
		dc.b	$10, $06, $11, $06, $0F, $05, $10, $05
		dc.b	$11, $05, $0F, $04, $10, $04, $11, $04
		dc.b	$0F, $03, $10, $03, $11, $03, $F8, $20
;-------------------------------------------------------------------------------
Offset_0x03AF73:
		dc.b	$0F, $02, $10, $02, $11, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x03AF7A:
		dc.b	$09, $03, $0A, $03, $0B, $03, $09, $04
		dc.b	$0A, $04, $0B, $04, $09, $05, $0A, $05
		dc.b	$0B, $05, $09, $06, $0A, $06, $0B, $06
		dc.b	$09, $07, $0A, $07, $0B, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x03AF99:
		dc.b	$0C, $03, $0D, $03, $0E, $03, $0C, $04
		dc.b	$0D, $04, $0E, $04, $0C, $05, $0D, $05
		dc.b	$0E, $05, $0C, $06, $0D, $06, $0E, $06
		dc.b	$0C, $07, $0D, $07, $0E, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x03AFB8:
		dc.b	$20, $03, $21, $03, $22, $03, $20, $04
		dc.b	$21, $04, $22, $04, $20, $05, $21, $05
		dc.b	$22, $05, $20, $06, $21, $06, $22, $06
		dc.b	$20, $07, $21, $07, $22, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x03AFD7:
		dc.b	$0F, $03, $10, $03, $11, $03, $0F, $04
		dc.b	$10, $04, $11, $04, $0F, $05, $10, $05
		dc.b	$11, $05, $0F, $06, $10, $06, $11, $06
		dc.b	$0F, $07, $10, $07, $11, $07, $F4
;-------------------------------------------------------------------------------
Offset_0x03AFF6:
		dc.b	$05, $00, $01, $FC
;-------------------------------------------------------------------------------
Pal_MGz_Boss:						   ; Offset_0x03AFFA
		dc.w	$0EE0, $0EEE, $008E, $004A, $0206, $00EE, $0088, $0A88
		dc.w	$06AC, $006A, $0000, $0020, $0CAA, $0866, $0644, $0000
;===============================================================================
; Objeto 0xB1 - Chefe na Marble Garden
; <<<-
;===============================================================================