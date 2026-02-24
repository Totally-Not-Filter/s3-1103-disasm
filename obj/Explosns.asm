;-------------------------------------------------------------------------------
; Objeto de controle de derrota do chefe
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x041BCA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x041BD8(PC, D0), D1
		jmp		Offset_0x041BD8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x041BD8:
		dc.w	Boss_Explosion_Control-Offset_0x041BD8 ; Offset_0x041BDE
		dc.w	Offset_0x041C08-Offset_0x041BD8
		dc.w	Offset_0x041C0C-Offset_0x041BD8
;-------------------------------------------------------------------------------
Boss_Explosion_Control:						   ; Offset_0x041BDE
		lea		Offset_0x041D3E(PC), A1
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Obj_Normal_Explode, Obj_Control_Var_04(A0) ; Offset_0x041C30, $0034
		cmpi.b	#$08, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x041BFE
		move.l	#Offset_0x041C7A, Obj_Control_Var_04(A0)		 ; $0034
Offset_0x041BFE:
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		bra.w	Offset_0x041C9A
;-------------------------------------------------------------------------------
Offset_0x041C08:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x041C0C:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x041C76
		tst.l	(A1)
		beq.w	Offset_0x041C76
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Obj_Normal_Explode:							   ; Offset_0x041C30
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x041C76
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		moveq	#Level_Projectile_Sfx, D0				   ; $75
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x041D5A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.w	Offset_0x041D0E
Offset_0x041C50:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		moveq	#$00, D1
		move.b	Obj_Control_Var_0A(A0), D1				 ; $003A
		move.w	D1, D2
		add.w	D2, D2
		subq.w	#$01, D2
		and.w	D2, D0
		sub.w	D1, D0
		add.w	D0, Obj_X(A1)					 ; $0010
		swap	D0
		and.w	D2, D0
		sub.w	D1, D0
		add.w	D0, Obj_Y(A1)					 ; $0014
		rts
Offset_0x041C76:
		jmp		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
;-------------------------------------------------------------------------------
Offset_0x041C7A:
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x041C76
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		lea		Offset_0x041D6A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		bne.w	Offset_0x041D0E
		move.b	#$02, Obj_Routine(A1)					 ; $0005
		bra.s	Offset_0x041C50
Offset_0x041C9A:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lea		Offset_0x041CB6(PC), A1
		adda.w	(A1, D0), A1
		move.b	(A1)+, Obj_Control_Var_09(A0)			 ; $0039
		move.b	(A1)+, Obj_Control_Var_0A(A0)			 ; $003A
		move.b	(A1)+, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x041CB6:
		dc.w	Offset_0x041CC2-Offset_0x041CB6
		dc.w	Offset_0x041CC5-Offset_0x041CB6
		dc.w	Offset_0x041CC8-Offset_0x041CB6
		dc.w	Offset_0x041CCB-Offset_0x041CB6
		dc.w	Offset_0x041CCE-Offset_0x041CB6
		dc.w	Offset_0x041CD1-Offset_0x041CB6
Offset_0x041CC2:
		dc.b	$14, $20, $02
Offset_0x041CC5:
		dc.b	$28, $80, $02
Offset_0x041CC8:
		dc.b	$80, $20, $04
Offset_0x041CCB:
		dc.b	$04, $08, $02
Offset_0x041CCE:
		dc.b	$08, $20, $02
Offset_0x041CD1:
		dc.b	$20, $20, $02
;-------------------------------------------------------------------------------
Offset_0x041CD4:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x041CE2(PC, D0), D1
		jmp		Offset_0x041CE2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x041CE2:
		dc.w	Offset_0x041CE6-Offset_0x041CE2
		dc.w	Offset_0x041C08-Offset_0x041CE2
;-------------------------------------------------------------------------------
Offset_0x041CE6:
		move.b	#$02, Obj_Subtype(A0)					 ; $002C
		bsr.w	Boss_Explosion_Control		   ; Offset_0x041BDE
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		move.w	(Camera_X).w, D0					 ; $FFFFEE78
		addi.w	#$00A0, D0
		move.w	D0, Obj_X(A0)					 ; $0010
		move.w	(Camera_Y).w, D0					 ; $FFFFEE7C
		addi.w	#$0070, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
;-------------------------------------------------------------------------------
Offset_0x041D0E:
		rts
;-------------------------------------------------------------------------------
Offset_0x041D10:
		lea		Offset_0x041D3E(PC), A1
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x041D34, (A0)
		move.l	#Offset_0x041D4A, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x041D34:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x041D3E:
		dc.l	Boss_Explosion_Mappings		   ; Offset_0x10E5C0
		dc.w	$84A9, $0000
		dc.b	$0C, $0C, $00, $00
;-------------------------------------------------------------------------------
Offset_0x041D4A:
		dc.b	$00, $00, $00, $00, $01, $01, $02, $02
		dc.b	$03, $03, $04, $04, $05, $04, $F4, $00
;-------------------------------------------------------------------------------
Offset_0x041D5A:
		dc.w	$0000
		dc.l	Offset_0x041D10
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x041D62:
		dc.w	$0000
		dc.l	Obj_Explosions				   ; Offset_0x041BCA
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x041D6A:
		dc.w	$0000
		dc.l	Obj_Explosion					  ; Offset_0x013D7C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
; Objeto de controle de derrota do chefe
; <<<-
;-------------------------------------------------------------------------------