;===============================================================================
; Objeto 0x64 - Bolha contendo itens no modo 2 jogadores
; ->>>
;===============================================================================
; Offset_0x02C8A8:
		move.l	#Bubble_Container_Mappings, Obj_Map(A0) ; Offset_0x02CFEA, $000C
		move.w	#$03C6, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$08, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Width_2(A0)					 ; $001F
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		move.b	Obj_Subtype(A0), Obj_Angle(A0)			  ; $002C, $0026
		moveq	#$01, D0
		bclr	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02C8F8
		neg.b	D0
Offset_0x02C8F8:
		move.b	D0, Obj_Flip_Angle(A0)					 ; $0027
		move.b	#$03, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$C7, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02C914, (A0)
Offset_0x02C914:
		bsr.s	Offset_0x02C980
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$03, D1
		move.w	D1, D2
		add.w	D1, D1
		add.w	D1, D2
		add.w	D1, D1
		add.w	D2, D1
		asr.w	#$08, D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		and.w	(Screen_Wrap_X).w, D1				 ; $FFFFEEA8
		addi.w	#$0400, D1
		move.w	D1, Obj_X(A0)					 ; $0010
		asl.w	#$03, D0
		move.w	D0, D2
		add.w	D0, D0
		add.w	D0, D2
		add.w	D0, D0
		add.w	D2, D0
		asr.w	#$08, D0
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		cmpi.w	#$FF00, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		bne.s	Offset_0x02C95C
		and.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
Offset_0x02C95C:
		move.w	D0, Obj_Y(A0)					 ; $0014
		move.b	Obj_Flip_Angle(A0), D0					 ; $0027
		add.b	D0, Obj_Angle(A0)				 ; $0026
		lea		(Bubble_Container_Animate_Data).l, A1	 ; Offset_0x02CF9C
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02C980:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x02C9A6
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02C994
		bsr.s	Offset_0x02C9A8
Offset_0x02C994:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02C9A2
		bsr.s	Offset_0x02C9A8
Offset_0x02C9A2:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x02C9A6:
		rts
Offset_0x02C9A8:
		moveq	#$00, D0
		move.b	Obj_Ani_Number(A0), D0					 ; $0020
		add.w	D0, D0
		move.w	Offset_0x02C9BA(PC, D0), D0
		jsr		Offset_0x02C9BA(PC, D0)
		rts
;-------------------------------------------------------------------------------
Offset_0x02C9BA:
		dc.w	Offset_0x02C9CA-Offset_0x02C9BA
		dc.w	Offset_0x02CA1C-Offset_0x02C9BA
		dc.w	Offset_0x02CA6E-Offset_0x02C9BA
		dc.w	Offset_0x02CB2C-Offset_0x02C9BA
		dc.w	Offset_0x02CB56-Offset_0x02C9BA
		dc.w	Offset_0x02CB96-Offset_0x02C9BA
		dc.w	Offset_0x02CBBA-Offset_0x02C9BA
		dc.w	Offset_0x02CBDE-Offset_0x02C9BA
;-------------------------------------------------------------------------------
Offset_0x02C9CA:
		bset	#$02, Obj_Player_Status(A2)				 ; $002F
		move.b	#$4B, Obj_P_Spd_Shoes_Time(A2)			 ; $0036
		cmpa.w	#Obj_Player_One, A2				 ; $B000
		bne.s	Offset_0x02C9F0
		move.w	#$0C00, (Sonic_Max_Speed).w			 ; $FFFFF760
		move.w	#$0018, (Sonic_Acceleration).w		 ; $FFFFF762
		move.w	#$0080, (Sonic_Deceleration).w		 ; $FFFFF764
		bra.s	Offset_0x02CA02
Offset_0x02C9F0:
		move.w	#$0C00, (Miles_Max_Speed).w			 ; $FFFFFEC0
		move.w	#$0018, (Miles_Acceleration).w		 ; $FFFFFEC2
		move.w	#$0080, (Miles_Deceleration).w		 ; $FFFFFEC4
Offset_0x02CA02:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02CF5E, D1
		moveq	#$09, D2
		bsr.w	Offset_0x02CF7C
		rts
;-------------------------------------------------------------------------------
Offset_0x02CA1C:
		bset	#$02, Obj_Player_Status(A2)				 ; $002F
		move.b	#$4B, Obj_P_Spd_Shoes_Time(A2)			 ; $0036
		cmpa.w	#Obj_Player_One, A2				 ; $B000
		bne.s	Offset_0x02CA42
		move.w	#$0300, (Sonic_Max_Speed).w			 ; $FFFFF760
		move.w	#$0008, (Sonic_Acceleration).w		 ; $FFFFF762
		move.w	#$0020, (Sonic_Deceleration).w		 ; $FFFFF764
		bra.s	Offset_0x02CA54
Offset_0x02CA42:
		move.w	#$0300, (Miles_Max_Speed).w			 ; $FFFFFEC0
		move.w	#$0008, (Miles_Acceleration).w		 ; $FFFFFEC2
		move.w	#$0020, (Miles_Deceleration).w		 ; $FFFFFEC4
Offset_0x02CA54:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02CF5E, D1
		moveq	#$09, D2
		bsr.w	Offset_0x02CF7C
		rts
;-------------------------------------------------------------------------------
Offset_0x02CA6E:
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		lea		(Obj_Player_Two).w, A3				 ; $FFFFB04A
		move.b	Obj_Player_Status(A2), D0				 ; $002F
		move.b	Obj_Player_Status(A3), Obj_Player_Status(A2) ; $002F, $002F
		move.b	D0, Obj_Player_Status(A3)				 ; $002F
		move.b	Obj_P_Spd_Shoes_Time(A2), D0			 ; $0036
		move.b	Obj_P_Spd_Shoes_Time(A3), Obj_P_Spd_Shoes_Time(A2) ; $0036, $0036
		move.b	D0, Obj_P_Spd_Shoes_Time(A3)			 ; $0036
		move.w	(Sonic_Max_Speed).w, D0				 ; $FFFFF760
		move.w	(Sonic_Acceleration).w, D1			 ; $FFFFF762
		move.w	(Sonic_Deceleration).w, D2			 ; $FFFFF764
		move.w	(Miles_Max_Speed).w, D3				 ; $FFFFFEC0
		move.w	(Miles_Acceleration).w, D4			 ; $FFFFFEC2
		move.w	(Miles_Deceleration).w, D5			 ; $FFFFFEC4
		move.w	D0, -(A7)
		lea		(Player_Start_Speed_Array), A1		   ; Offset_0x1F7000
		moveq	#$00, D0
		move.b	Obj_Player_Selected(A2), D0				 ; $0038
		lsl.w	#$03, D0
		lea		(A1, D0), A1
		move.w	(A1)+, (Sonic_Max_Speed).w			 ; $FFFFF760
		move.w	(A1)+, (Sonic_Acceleration).w		 ; $FFFFF762
		move.w	(A1)+, (Sonic_Deceleration).w		 ; $FFFFF764
		lea		(Player_Start_Speed_Array), A1		   ; Offset_0x1F7000
		moveq	#$00, D0
		move.b	Obj_Player_Selected(A3), D0				 ; $0038
		lsl.w	#$03, D0
		lea		(A1, D0), A1
		move.w	(A1)+, (Miles_Max_Speed).w			 ; $FFFFFEC0
		move.w	(A1)+, (Miles_Acceleration).w		 ; $FFFFFEC2
		move.w	(A1)+, (Miles_Deceleration).w		 ; $FFFFFEC4
		move.w	(A7)+, D0
		btst	#$02, Obj_Player_Status(A2)				 ; $002F
		beq.s	Offset_0x02CAFE
		move.w	D3, (Sonic_Max_Speed).w				 ; $FFFFF760
		move.w	D4, (Sonic_Acceleration).w			 ; $FFFFF762
		move.w	D5, (Sonic_Deceleration).w			 ; $FFFFF764
Offset_0x02CAFE:
		btst	#$02, Obj_Player_Status(A3)				 ; $002F
		beq.s	Offset_0x02CB12
		move.w	D0, (Miles_Max_Speed).w				 ; $FFFFFEC0
		move.w	D1, (Miles_Acceleration).w			 ; $FFFFFEC2
		move.w	D2, (Miles_Deceleration).w			 ; $FFFFFEC4
Offset_0x02CB12:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02CF5E, D1
		moveq	#$09, D2
		bsr.w	Offset_0x02CF7C
		rts
;-------------------------------------------------------------------------------
Offset_0x02CB2C:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.l	#Offset_0x02CF5E, D1
		moveq	#$08, D2
		bsr.w	Offset_0x02CF7C
		cmpa.w	#Obj_Player_One, A2				 ; $B000
		bne.s	Offset_0x02CB50
		jmp		(CollectRing_Sonic).l					   ; Offset_0x010A26
Offset_0x02CB50:
		jmp		(CollectRing_Tails).l			; Offset_0x010A7C
;-------------------------------------------------------------------------------
Offset_0x02CB56:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		lea		(Obj_Fixed_RAM).w, A1				 ; $FFFFCB2C
		tst.l	(A1)
		moveq	#$2C, D0
Offset_0x02CB6C:
		move.w	(A0, D0),(A1, D0)
		subq.w	#$02, D0
		bcc.s	Offset_0x02CB6C
		move.l	#Offset_0x02CBE0, (A1)
		move.b	#$04, Obj_Ani_Number(A1)				 ; $0020
		move.w	Obj_Control_Var_16(A2), Obj_Control_Var_16(A1) ; $0046, $0046
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x02CB94
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x02CB94:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CB96:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		move.l	#Offset_0x02CBFA, D1
		moveq	#$05, D2
		bsr.w	Offset_0x02CF7C
		bne.s	Offset_0x02CBB8
		move.w	Obj_Control_Var_16(A2), Obj_Control_Var_16(A1) ; $0046, $0046
Offset_0x02CBB8:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CBBA:
		move.b	#$07, Obj_Ani_Number(A0)				 ; $0020
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		move.l	#Offset_0x02CC02, D1
		moveq	#$06, D2
		bsr.w	Offset_0x02CF7C
		bne.s	Offset_0x02CBDC
		move.w	Obj_Control_Var_16(A2), Obj_Control_Var_16(A1) ; $0046, $0046
Offset_0x02CBDC:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CBDE:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CBE0:
		move.w	#$FC00, Obj_Inertia(A0)					 ; $001C
		move.b	#$00, Obj_Angle(A0)				 ; $0026
		move.b	#$00, Obj_Status(A0)					 ; $002A
		move.l	#Offset_0x02CDEE, D2
		bra.s	Offset_0x02CC08
;-------------------------------------------------------------------------------
Offset_0x02CBFA:
		move.l	#Offset_0x02CD06, D2
		bra.s	Offset_0x02CC08
;-------------------------------------------------------------------------------
Offset_0x02CC02:
		move.l	#Offset_0x02CC50, D2
;-------------------------------------------------------------------------------
Offset_0x02CC08:
		move.l	D2, -(A7)
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		move.l	(A7)+, D2
		tst.w	D1
		bpl.s	Offset_0x02CC28
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.l	D2, (A0)
		move.b	#$C7, Obj_Col_Flags(A0)					 ; $0028
Offset_0x02CC28:
		cmpi.w	#$FF00, (Sonic_Level_Limits_Min_Y).w		 ; $FFFFEE18
		bne.s	Offset_0x02CC38
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x02CC38:
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$0060, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bge.s	Offset_0x02CC4C
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02CC4C:
		bra.w	Offset_0x02CF5E
;-------------------------------------------------------------------------------
Offset_0x02CC50:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x02CC76
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CC64
		bsr.s	Offset_0x02CCA2
Offset_0x02CC64:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CC72
		bsr.s	Offset_0x02CCA2
Offset_0x02CC72:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x02CC76:
		lea		(Bubble_Container_Animate_Data).l, A1	 ; Offset_0x02CF9C
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x02CC8E
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02CC8E:
		cmpi.b	#$09, Obj_Ani_Number(A0)				 ; $0020
		beq.s	Offset_0x02CC9C
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x02CC9C:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02CCA2:
		move.w	Obj_Control_Var_16(A2), D0				 ; $0046
		cmp.w	Obj_Control_Var_16(A0), D0				 ; $0046
		beq.s	Offset_0x02CCAE
		rts
Offset_0x02CCAE:
		move.b	#$0A, Obj_Ani_Number(A0)				 ; $0020
		move.w	#$F600, Obj_Speed_Y(A2)					 ; $001A
		bset	#$01, Obj_Status(A2)					 ; $002A
		bclr	#$04, Obj_Status(A2)					 ; $002A
		bclr	#$05, Obj_Status(A2)					 ; $002A
		clr.b	Obj_Control_Var_10(A2)					 ; $0040
		move.w	#$0001, Obj_Inertia(A2)					 ; $001C
		move.b	#$01, Obj_Flip_Angle(A2)				 ; $0027
		move.b	#$00, Obj_Ani_Number(A2)				 ; $0020
		move.b	#$00, Obj_P_Flips_Remaining(A2)			 ; $0030
		move.b	#$04, Obj_Player_Flip_Speed(A2)			 ; $0031
		btst	#$00, Obj_Status(A2)					 ; $002A
		beq.s	Offset_0x02CCFE
		neg.b	Obj_Flip_Angle(A2)				 ; $0027
		neg.w	Obj_Inertia(A2)					 ; $001C
Offset_0x02CCFE:
		moveq	#Small_Bumper_Sfx, D0					  ; -$75
		jmp		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x02CD06:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x02CD2C
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CD1A
		bsr.s	Offset_0x02CD90
Offset_0x02CD1A:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CD28
		bsr.s	Offset_0x02CD90
Offset_0x02CD28:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x02CD2C:
		lea		(Bubble_Container_Animate_Data).l, A1	 ; Offset_0x02CF9C
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x02CD78
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		subq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		beq.s	Offset_0x02CD6C
		move.w	#$0020, D1
		move.w	Obj_Inertia(A1), D0				 ; $001C
		bpl.s	Offset_0x02CD60
		add.w	D1, Obj_Inertia(A1)				 ; $001C
		bcc.s	Offset_0x02CD84
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		bra.s	Offset_0x02CD6C
Offset_0x02CD60:
		sub.w	D1, Obj_Inertia(A1)				 ; $001C
		bcc.s	Offset_0x02CD84
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
Offset_0x02CD6C:
		move.w	#$0005, Obj_Control_Var_02(A1)			 ; $0032
		andi.b	#$7F, Obj_Player_Status(A1)				 ; $002F
Offset_0x02CD78:
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x02CD84
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02CD84:
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02CD90:
		move.w	Obj_Control_Var_16(A2), D0				 ; $0046
		cmp.w	Obj_Control_Var_16(A0), D0				 ; $0046
		bne.s	Offset_0x02CDEC
		tst.b	Obj_Player_Status(A2)					 ; $002F
		bmi.s	Offset_0x02CDEC
		btst	#$01, Obj_Status(A2)					 ; $002A
		bne.s	Offset_0x02CDEC
		tst.w	Obj_Inertia(A2)					 ; $001C
		beq.s	Offset_0x02CDEC
		move.b	#$09, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Col_Flags(A0)					 ; $0028
		move.w	#$0200, D1
		move.w	Obj_Inertia(A2), D0				 ; $001C
		bpl.s	Offset_0x02CDC8
		neg.w	D0
		neg.w	D1
Offset_0x02CDC8:
		cmpi.w	#$0200, D0
		bcc.s	Offset_0x02CDD2
		add.w	D1, Obj_Inertia(A2)				 ; $001C
Offset_0x02CDD2:
		asl.w	Obj_Inertia(A2)					 ; $001C
		move.b	#$1B, Obj_Ani_Number(A2)				 ; $0020
		ori.b	#$80, Obj_Player_Status(A2)				 ; $002F
		move.w	A2, Obj_Control_Var_0E(A0)				 ; $003E
		move.b	#$3C, Obj_Control_Var_0C(A0)			 ; $003C
Offset_0x02CDEC:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CDEE:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.s	Offset_0x02CE14
		lea		(Obj_Player_One).w, A2				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CE02
		bsr.s	Offset_0x02CE4A
Offset_0x02CE02:
		lea		(Obj_Player_Two).w, A2				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x02CE10
		bsr.s	Offset_0x02CE4A
Offset_0x02CE10:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
Offset_0x02CE14:
		bsr.w	Offset_0x02CE6A
		move.b	Obj_Angle(A0), D0				 ; $0026
		addi.b	#$10, D0
		lsr.b	#$05, D0
		addi.b	#$11, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.w	(Sonic_Level_Limits_Max_Y).w, D0			 ; $FFFFEE1A
		addi.w	#$0060, D0
		cmp.w	Obj_Y(A0), D0					 ; $0014
		bge.s	Offset_0x02CE3E
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02CE3E:
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02CE4A:
		move.w	Obj_Control_Var_16(A2), D0				 ; $0046
		cmp.w	Obj_Control_Var_16(A0), D0				 ; $0046
		beq.s	Offset_0x02CE56
		rts
Offset_0x02CE56:
		move.l	#Offset_0x02CF5E, (A0)
		move.b	#$0B, Obj_Ani_Number(A0)				 ; $0020
		move.l	A2, A1
		jmp		(Hurt_Player_A1).l			   ; Offset_0x01A71C
Offset_0x02CE6A:
		btst	#$01, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x02CED4
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	Obj_Inertia(A0), D1				 ; $001C
		asr.l	#$08, D1
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		muls.w	Obj_Inertia(A0), D0				 ; $001C
		asr.l	#$08, D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
		move.w	(Screen_Wrap_X).w, D0				 ; $FFFFEEA8
		and.w	D0, Obj_X(A0)					 ; $0010
		addi.w	#$0400, Obj_X(A0)				 ; $0010
		jsr		(Player_AnglePos).l			   ; Offset_0x009144
		move.b	Obj_Angle(A0), D0				 ; $0026
		bne.s	Offset_0x02CED2
		jsr		(Offset_0x00A0E8).l
		tst.w	D1
		bpl.s	Offset_0x02CED2
		sub.w	D1, Obj_X(A0)					 ; $0010
		move.l	#Offset_0x02CF5E, (A0)
		move.b	#$0B, Obj_Ani_Number(A0)				 ; $0020
Offset_0x02CED2:
		rts
Offset_0x02CED4:
		subi.w	#$0010, Obj_Speed_X(A0)					 ; $0018
		cmpi.w	#$FC00, Obj_Speed_X(A0)					 ; $0018
		bgt.s	Offset_0x02CEE8
		move.w	#$FC00, Obj_Speed_X(A0)					 ; $0018
Offset_0x02CEE8:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		move.w	(Screen_Wrap_Y).w, D0				 ; $FFFFEEAA
		and.w	D0, Obj_Y(A0)					 ; $0014
		move.w	(Screen_Wrap_X).w, D0				 ; $FFFFEEA8
		and.w	D0, Obj_X(A0)					 ; $0010
		addi.w	#$0400, Obj_X(A0)				 ; $0010
		jsr		(Player_HitFloor)			   ; Offset_0x009CE0
		tst.w	D1
		bpl.s	Offset_0x02CF20
		add.w	D1, Obj_Y(A0)					 ; $0014
		bclr	#$01, Obj_Status(A0)					 ; $002A
		move.b	#$00, Obj_Angle(A0)				 ; $0026
		rts
Offset_0x02CF20:
		move.b	Obj_Angle(A0), D0				 ; $0026
		beq.s	Offset_0x02CF3A
		bpl.s	Offset_0x02CF30
		addq.b	#$02, D0
		bcc.s	Offset_0x02CF36
		moveq	#$00, D0
		bra.s	Offset_0x02CF36
Offset_0x02CF30:
		subq.b	#$02, D0
		bcc.s	Offset_0x02CF36
		moveq	#$00, D0
Offset_0x02CF36:
		move.b	D0, Obj_Angle(A0)				 ; $0026
Offset_0x02CF3A:
		move.b	Obj_Angle(A0), D0				 ; $0026
		bne.s	Offset_0x02CF5C
		jsr		(Offset_0x00A0E8).l
		tst.w	D1
		bpl.s	Offset_0x02CF5C
		sub.w	D1, Obj_X(A0)					 ; $0010
		move.l	#Offset_0x02CF5E, (A0)
		move.b	#$0B, Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x02CF5C:
		rts
;-------------------------------------------------------------------------------
Offset_0x02CF5E:
		lea		(Bubble_Container_Animate_Data).l, A1	 ; Offset_0x02CF9C
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x02CF76
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x02CF76:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x02CF7C:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02CF9A
		moveq	#$2C, D0
Offset_0x02CF88:
		move.w	(A0, D0),(A1, D0)
		subq.w	#$02, D0
		bcc.s	Offset_0x02CF88
		move.l	D1, (A1)
		move.b	D2, Obj_Ani_Number(A1)					 ; $0020
		moveq	#$00, D0
Offset_0x02CF9A:
		rts
;-------------------------------------------------------------------------------
Bubble_Container_Animate_Data:				   ; Offset_0x02CF9C
		dc.w	Offset_0x02CFB4-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFB7-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFBA-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFBD-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFC3-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFC6-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFC9-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFCC-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFCF-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFD5-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFDE-Bubble_Container_Animate_Data
		dc.w	Offset_0x02CFE3-Bubble_Container_Animate_Data
Offset_0x02CFB4:
		dc.b	$1F, $00, $FF
Offset_0x02CFB7:
		dc.b	$1F, $01, $FF
Offset_0x02CFBA:
		dc.b	$1F, $02, $FF
Offset_0x02CFBD:
		dc.b	$07, $03, $04, $05, $19, $FF
Offset_0x02CFC3:
		dc.b	$1F, $11, $FF
Offset_0x02CFC6:
		dc.b	$1F, $06, $FF
Offset_0x02CFC9:
		dc.b	$1F, $07, $FF
Offset_0x02CFCC:
		dc.b	$1F, $1A, $FF
Offset_0x02CFCF:
		dc.b	$05, $09, $0A, $0B, $0C, $FC
Offset_0x02CFD5:
		dc.b	$05, $0D, $0E, $0F, $10, $FC, $1A, $FE
		dc.b	$01
Offset_0x02CFDE:
		dc.b	$0B, $08, $07, $FD, $09
Offset_0x02CFE3:
		dc.b	$05, $1B, $1C, $1D, $1E, $1F, $FC
;-------------------------------------------------------------------------------
Bubble_Container_Mappings:					   ; Offset_0x02CFEA
		dc.w	Offset_0x02D02A-Bubble_Container_Mappings
		dc.w	Offset_0x02D032-Bubble_Container_Mappings
		dc.w	Offset_0x02D03A-Bubble_Container_Mappings
		dc.w	Offset_0x02D042-Bubble_Container_Mappings
		dc.w	Offset_0x02D04A-Bubble_Container_Mappings
		dc.w	Offset_0x02D052-Bubble_Container_Mappings
		dc.w	Offset_0x02D05A-Bubble_Container_Mappings
		dc.w	Offset_0x02D062-Bubble_Container_Mappings
		dc.w	Offset_0x02D06A-Bubble_Container_Mappings
		dc.w	Offset_0x02D072-Bubble_Container_Mappings
		dc.w	Offset_0x02D07A-Bubble_Container_Mappings
		dc.w	Offset_0x02D082-Bubble_Container_Mappings
		dc.w	Offset_0x02D08A-Bubble_Container_Mappings
		dc.w	Offset_0x02D092-Bubble_Container_Mappings
		dc.w	Offset_0x02D09A-Bubble_Container_Mappings
		dc.w	Offset_0x02D0A2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0AA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0B2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0BA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0C2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0CA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0D2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0DA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0E2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0EA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0F2-Bubble_Container_Mappings
		dc.w	Offset_0x02D0FA-Bubble_Container_Mappings
		dc.w	Offset_0x02D0FC-Bubble_Container_Mappings
		dc.w	Offset_0x02D104-Bubble_Container_Mappings
		dc.w	Offset_0x02D10C-Bubble_Container_Mappings
		dc.w	Offset_0x02D114-Bubble_Container_Mappings
		dc.w	Offset_0x02D11C-Bubble_Container_Mappings
Offset_0x02D02A:
		dc.w	$0001
		dc.w	$F805, $0000, $FFF8
Offset_0x02D032:
		dc.w	$0001
		dc.w	$F805, $0004, $FFF8
Offset_0x02D03A:
		dc.w	$0001
		dc.w	$F805, $0008, $FFF8
Offset_0x02D042:
		dc.w	$0001
		dc.w	$F805, $600C, $FFF8
Offset_0x02D04A:
		dc.w	$0001
		dc.w	$F805, $6010, $FFF8
Offset_0x02D052:
		dc.w	$0001
		dc.w	$F801, $6014, $FFFC
Offset_0x02D05A:
		dc.w	$0001
		dc.w	$F805, $0016, $FFF8
Offset_0x02D062:
		dc.w	$0001
		dc.w	$F805, $001A, $FFF8
Offset_0x02D06A:
		dc.w	$0001
		dc.w	$F805, $001E, $FFF8
Offset_0x02D072:
		dc.w	$0001
		dc.w	$F805, $6022, $FFF8
Offset_0x02D07A:
		dc.w	$0001
		dc.w	$F805, $7822, $FFF8
Offset_0x02D082:
		dc.w	$0001
		dc.w	$F805, $6822, $FFF8
Offset_0x02D08A:
		dc.w	$0001
		dc.w	$F805, $7022, $FFF8
Offset_0x02D092:
		dc.w	$0001
		dc.w	$F805, $0026, $FFF8
Offset_0x02D09A:
		dc.w	$0001
		dc.w	$F805, $1826, $FFF8
Offset_0x02D0A2:
		dc.w	$0001
		dc.w	$F805, $0826, $FFF8
Offset_0x02D0AA:
		dc.w	$0001
		dc.w	$F805, $1026, $FFF8
Offset_0x02D0B2:
		dc.w	$0001
		dc.w	$F805, $002A, $FFF8
Offset_0x02D0BA:
		dc.w	$0001
		dc.w	$F805, $0036, $FFF8
Offset_0x02D0C2:
		dc.w	$0001
		dc.w	$F805, $002E, $FFF8
Offset_0x02D0CA:
		dc.w	$0001
		dc.w	$F805, $1032, $FFF8
Offset_0x02D0D2:
		dc.w	$0001
		dc.w	$F805, $182A, $FFF8
Offset_0x02D0DA:
		dc.w	$0001
		dc.w	$F805, $1836, $FFF8
Offset_0x02D0E2:
		dc.w	$0001
		dc.w	$F805, $182E, $FFF8
Offset_0x02D0EA:
		dc.w	$0001
		dc.w	$F805, $0832, $FFF8
Offset_0x02D0F2:
		dc.w	$0001
		dc.w	$F805, $6810, $FFF8
Offset_0x02D0FA:
		dc.w	$0000
Offset_0x02D0FC:
		dc.w	$0001
		dc.w	$F805, $0376, $FFF8
Offset_0x02D104:
		dc.w	$0001
		dc.w	$F805, $037A, $FFF8
Offset_0x02D10C:
		dc.w	$0001
		dc.w	$F805, $037E, $FFF8
Offset_0x02D114:
		dc.w	$0001
		dc.w	$F805, $0382, $FFF8
Offset_0x02D11C:
		dc.w	$0001
		dc.w	$F805, $0386, $FFF8
;===============================================================================
; Objeto 0x64 - Bolha contendo itens no modo 2 jogadores
; <<<-
;===============================================================================