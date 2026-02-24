;===============================================================================
; Objeto 0x41 - Balão na Carnival Night
; ->>>
;===============================================================================
; Offset_0x027552:
				move.l	#Balloon_Mappings, Obj_Map(A0)	; Offset_0x0276EC, $000C
				move.w	#$0351, Obj_Art_VRAM(A0)						 ; $000A
				ori.b	#$04, Obj_Flags(A0)								 ; $0004
				move.w	#$0280, Obj_Priority(A0)						 ; $0008
				move.b	#$10, Obj_Width(A0)								 ; $0007
				move.b	#$20, Obj_Height(A0)							 ; $0006
				move.b	#$D7, Obj_Col_Flags(A0)							 ; $0028
				move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
				move.b	Obj_Subtype(A0), D0								 ; $002C
				add.b	D0, D0
				andi.b	#$0E, D0
				move.b	D0, Obj_Ani_Number(A0)							 ; $0020
				jsr		(PseudoRandomNumber).l					 ; Offset_0x001AFA
				move.b	D0, Obj_Angle(A0)								 ; $0026
				move.l	#Offset_0x0275A2, (A0)
Offset_0x0275A2:
				tst.b	Obj_Col_Prop(A0)								 ; $0029
				beq.s	Offset_0x0275C4
				lea		(Obj_Player_One).w, A1						 ; $FFFFB000
				bclr	#$00, Obj_Col_Prop(A0)							 ; $0029
				beq.s	Offset_0x0275B6
				bsr.s	Offset_0x0275FC
Offset_0x0275B6:
				lea		(Obj_Player_Two).w, A1						 ; $FFFFB04A
				bclr	#$01, Obj_Col_Prop(A0)							 ; $0029
				beq.s	Offset_0x0275C4
				bsr.s	Offset_0x0275FC
Offset_0x0275C4:
				lea		(Balloon_Animate_Data).l, A1			 ; Offset_0x0276A6
				jsr		(AnimateSprite).l						   ; Offset_0x01115E
				tst.b	5
				beq.s	Offset_0x0275DC
				move.w	#$7F00, Obj_X(A0)								 ; $0010
Offset_0x0275DC:
				moveq	#$00, D0
				move.b	Obj_Angle(A0), D0								 ; $0026
				addq.b	#$01, Obj_Angle(A0)								 ; $0026
				jsr		(CalcSine).l							 ; Offset_0x001B20
				asr.w	#$05, D0
				add.w	Obj_Control_Var_02(A0), D0						 ; $0032
				move.w	D0, Obj_Y(A0)									 ; $0014
				jmp		(MarkObjGone_5).l						   ; Offset_0x011BCC
Offset_0x0275FC:
				move.w	#$F900, Obj_Speed_Y(A1)							 ; $001A
				bset	#$01, Obj_Status(A1)							 ; $002A
				bclr	#$04, Obj_Status(A1)							 ; $002A
				bclr	#$05, Obj_Status(A1)							 ; $002A
				clr.b	Obj_Control_Var_10(A1)							 ; $0040
				move.b	#$00, Obj_Timer(A1)								 ; $002E
				bset	#$00, Obj_Ani_Number(A0)						 ; $0020
				tst.b	Obj_Subtype(A0)									 ; $002C
				bpl.s	Offset_0x027650
				move.w	#$FC80, Obj_Speed_Y(A1)							 ; $001A
				tst.b	Obj_Control_Var_04(A0)							 ; $0034
				bne.s	Offset_0x027650
				lea		(Offset_0x0276A2).l, A2
				bsr.s	Offset_0x027666
				bsr.s	Offset_0x027666
				bsr.s	Offset_0x027666
				bsr.s	Offset_0x027666
				move.w	Obj_X(A0), Obj_X(A1)					  ; $0010, $0010
				move.w	Obj_Y(A0), Obj_Y(A1)					  ; $0014, $0014
Offset_0x027650:
				tst.b	Obj_Control_Var_04(A0)							 ; $0034
				bne.s	Offset_0x027664
				moveq	#Balloon_Pop_Sfx, D0							  ; -$7A
				jsr		(Play_Music).l							 ; Offset_0x001176
				move.b	#$01, Obj_Control_Var_04(A0)					 ; $0034
Offset_0x027664:
				rts
Offset_0x027666:
				jsr		(AllocateObject).l					 ; Offset_0x011DD8
				bne.s	Offset_0x0276A0
				move.l	#Obj_0x54_Oxygen_Bubbles, (A1)		   ; Offset_0x025500
				move.w	Obj_X(A0), Obj_X(A1)					  ; $0010, $0010
				jsr		(PseudoRandomNumber).l					 ; Offset_0x001AFA
				move.w	D0, D1
				andi.w	#$000F, D0
				subq.w	#$08, D0
				add.w	D0, Obj_X(A1)									 ; $0010
				move.w	Obj_Y(A0), Obj_Y(A1)					  ; $0014, $0014
				andi.w	#$000F, D1
				subq.w	#$08, D1
				add.w	D1, Obj_Y(A1)									 ; $0014
				move.b	(A2)+, Obj_Subtype(A1)							 ; $002C
Offset_0x0276A0:
				rts
;-------------------------------------------------------------------------------
Offset_0x0276A2:
				dc.b	$00, $00, $01, $03
;-------------------------------------------------------------------------------
Balloon_Animate_Data:										   ; Offset_0x0276A6
				dc.w	Offset_0x0276BA-Balloon_Animate_Data
				dc.w	Offset_0x0276C0-Balloon_Animate_Data
				dc.w	Offset_0x0276C4-Balloon_Animate_Data
				dc.w	Offset_0x0276CA-Balloon_Animate_Data
				dc.w	Offset_0x0276CE-Balloon_Animate_Data
				dc.w	Offset_0x0276D4-Balloon_Animate_Data
				dc.w	Offset_0x0276D8-Balloon_Animate_Data
				dc.w	Offset_0x0276DE-Balloon_Animate_Data
				dc.w	Offset_0x0276E2-Balloon_Animate_Data
				dc.w	Offset_0x0276E8-Balloon_Animate_Data
Offset_0x0276BA:
				dc.b	$07, $00, $01, $02, $01, $FF
Offset_0x0276C0:
				dc.b	$02, $03, $04, $FB
Offset_0x0276C4:
				dc.b	$07, $05, $06, $07, $06, $FF
Offset_0x0276CA:
				dc.b	$02, $08, $09, $FB
Offset_0x0276CE:
				dc.b	$07, $0A, $0B, $0C, $0B, $FF
Offset_0x0276D4:
				dc.b	$02, $0D, $0E, $FB
Offset_0x0276D8:
				dc.b	$07, $0F, $10, $11, $10, $FF
Offset_0x0276DE:
				dc.b	$02, $12, $13, $FB
Offset_0x0276E2:
				dc.b	$07, $14, $15, $16, $15, $FF
Offset_0x0276E8:
				dc.b	$02, $17, $18, $FB
;-------------------------------------------------------------------------------
Balloon_Mappings:											   ; Offset_0x0276EC
				dc.w	Offset_0x02771E-Balloon_Mappings
				dc.w	Offset_0x027732-Balloon_Mappings
				dc.w	Offset_0x027746-Balloon_Mappings
				dc.w	Offset_0x02775A-Balloon_Mappings
				dc.w	Offset_0x027774-Balloon_Mappings
				dc.w	Offset_0x02778E-Balloon_Mappings
				dc.w	Offset_0x0277A2-Balloon_Mappings
				dc.w	Offset_0x0277B6-Balloon_Mappings
				dc.w	Offset_0x0277CA-Balloon_Mappings
				dc.w	Offset_0x0277E4-Balloon_Mappings
				dc.w	Offset_0x0277FE-Balloon_Mappings
				dc.w	Offset_0x027812-Balloon_Mappings
				dc.w	Offset_0x027826-Balloon_Mappings
				dc.w	Offset_0x02783A-Balloon_Mappings
				dc.w	Offset_0x027854-Balloon_Mappings
				dc.w	Offset_0x02786E-Balloon_Mappings
				dc.w	Offset_0x027882-Balloon_Mappings
				dc.w	Offset_0x027896-Balloon_Mappings
				dc.w	Offset_0x0278AA-Balloon_Mappings
				dc.w	Offset_0x0278C4-Balloon_Mappings
				dc.w	Offset_0x0278DE-Balloon_Mappings
				dc.w	Offset_0x0278F2-Balloon_Mappings
				dc.w	Offset_0x027906-Balloon_Mappings
				dc.w	Offset_0x02791A-Balloon_Mappings
				dc.w	Offset_0x027934-Balloon_Mappings
Offset_0x02771E:
				dc.w	$0003
				dc.w	$F007, $0000, $FFF0
				dc.w	$F007, $0800, $0000
				dc.w	$1003, $400B, $FFFC
Offset_0x027732:
				dc.w	$0003
				dc.w	$F007, $0000, $FFF0
				dc.w	$F007, $0800, $0000
				dc.w	$1003, $400F, $FFFC
Offset_0x027746:
				dc.w	$0003
				dc.w	$F007, $0000, $FFF0
				dc.w	$F007, $0800, $0000
				dc.w	$1003, $480B, $FFFC
Offset_0x02775A:
				dc.w	$0004
				dc.w	$F001, $0008, $FFF1
				dc.w	$F001, $0808, $0007
				dc.w	$0001, $1008, $FFF1
				dc.w	$0001, $1808, $0007
Offset_0x027774:
				dc.w	$0004
				dc.w	$EF00, $000A, $FFF0
				dc.w	$EF00, $080A, $0008
				dc.w	$0900, $100A, $FFF0
				dc.w	$0900, $180A, $0008
Offset_0x02778E:
				dc.w	$0003
				dc.w	$F007, $2000, $FFF0
				dc.w	$F007, $2800, $0000
				dc.w	$1003, $400B, $FFFC
Offset_0x0277A2:
				dc.w	$0003
				dc.w	$F007, $2000, $FFF0
				dc.w	$F007, $2800, $0000
				dc.w	$1003, $400F, $FFFC
Offset_0x0277B6:
				dc.w	$0003
				dc.w	$F007, $2000, $FFF0
				dc.w	$F007, $2800, $0000
				dc.w	$1003, $480B, $FFFC
Offset_0x0277CA:
				dc.w	$0004
				dc.w	$F001, $2008, $FFF1
				dc.w	$F001, $2808, $0007
				dc.w	$0001, $3008, $FFF1
				dc.w	$0001, $3808, $0007
Offset_0x0277E4:
				dc.w	$0004
				dc.w	$EF00, $200A, $FFF0
				dc.w	$EF00, $280A, $0008
				dc.w	$0900, $300A, $FFF0
				dc.w	$0900, $380A, $0008
Offset_0x0277FE:
				dc.w	$0003
				dc.w	$F007, $4000, $FFF0
				dc.w	$F007, $4800, $0000
				dc.w	$1003, $400B, $FFFC
Offset_0x027812:
				dc.w	$0003
				dc.w	$F007, $4000, $FFF0
				dc.w	$F007, $4800, $0000
				dc.w	$1003, $400F, $FFFC
Offset_0x027826:
				dc.w	$0003
				dc.w	$F007, $4000, $FFF0
				dc.w	$F007, $4800, $0000
				dc.w	$1003, $480B, $FFFC
Offset_0x02783A:
				dc.w	$0004
				dc.w	$F001, $4008, $FFF1
				dc.w	$F001, $4808, $0007
				dc.w	$0001, $5008, $FFF1
				dc.w	$0001, $5808, $0007
Offset_0x027854:
				dc.w	$0004
				dc.w	$EF00, $400A, $FFF0
				dc.w	$EF00, $480A, $0008
				dc.w	$0900, $500A, $FFF0
				dc.w	$0900, $580A, $0008
Offset_0x02786E:
				dc.w	$0003
				dc.w	$F007, $6000, $FFF0
				dc.w	$F007, $6800, $0000
				dc.w	$1003, $400B, $FFFC
Offset_0x027882:
				dc.w	$0003
				dc.w	$F007, $6000, $FFF0
				dc.w	$F007, $6800, $0000
				dc.w	$1003, $400F, $FFFC
Offset_0x027896:
				dc.w	$0003
				dc.w	$F007, $6000, $FFF0
				dc.w	$F007, $6800, $0000
				dc.w	$1003, $480B, $FFFC
Offset_0x0278AA:
				dc.w	$0004
				dc.w	$F001, $6008, $FFF1
				dc.w	$F001, $6808, $0007
				dc.w	$0001, $7008, $FFF1
				dc.w	$0001, $7808, $0007
Offset_0x0278C4:
				dc.w	$0004
				dc.w	$EF00, $600A, $FFF0
				dc.w	$EF00, $680A, $0008
				dc.w	$0900, $700A, $FFF0
				dc.w	$0900, $780A, $0008
Offset_0x0278DE:
				dc.w	$0003
				dc.w	$F007, $4223, $FFF0
				dc.w	$F007, $4A23, $0000
				dc.w	$1003, $400B, $FFFC
Offset_0x0278F2:
				dc.w	$0003
				dc.w	$F007, $4223, $FFF0
				dc.w	$F007, $4A23, $0000
				dc.w	$1003, $400F, $FFFC
Offset_0x027906:
				dc.w	$0003
				dc.w	$F007, $4223, $FFF0
				dc.w	$F007, $4A23, $0000
				dc.w	$1003, $480B, $FFFC
Offset_0x02791A:
				dc.w	$0004
				dc.w	$F001, $422B, $FFF1
				dc.w	$F001, $4A2B, $0007
				dc.w	$0001, $522B, $FFF1
				dc.w	$0001, $5A2B, $0007
Offset_0x027934:
				dc.w	$0004
				dc.w	$EF00, $422D, $FFF0
				dc.w	$EF00, $4A2D, $0008
				dc.w	$0900, $522D, $FFF0
				dc.w	$0900, $5A2D, $0008
;===============================================================================
; Objeto 0x41 - Balão na Carnival Night
; <<<-
;===============================================================================