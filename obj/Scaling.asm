;-------------------------------------------------------------------------------
; Objeto de escalonamento das esferas
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x01AA34:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x01AA42(PC, D0), D1
		jmp		Offset_0x01AA42(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01AA42:
		dc.w	Offset_0x01AA46-Offset_0x01AA42
		dc.w	Offset_0x01AA8A-Offset_0x01AA42
;-------------------------------------------------------------------------------
Offset_0x01AA46:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_X(A0), Obj_Control_Var_04(A0)		  ; $0010, $0034
		move.w	Obj_Y(A0), Obj_Control_Var_06(A0)		  ; $0014, $0036
		move.l	#Scaling_Mappings, Obj_Map(A0)	; Offset_0x01B1B8, $000C
		move.w	#$6500, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$40, Obj_Width(A0)				 ; $0007
		move.b	#$40, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Control_Var_10(A0)			 ; $0040
		move.l	#M68K_Dev_RAM_Start, Obj_Control_Var_12(A0) ; $FFFE0000,  $0042
;-------------------------------------------------------------------------------
Offset_0x01AA8A:
		tst.w	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x01AA96
		subq.w	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bra.s	Offset_0x01AADA
Offset_0x01AA96:
		tst.b	Obj_Control_Var_00(A0)					 ; $0030
		bne.s	Offset_0x01AAB0
		addq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		cmpi.b	#$80, Obj_Control_Var_10(A0)			 ; $0040
		bne.s	Offset_0x01AADA
		move.b	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bra.s	Offset_0x01AADA
Offset_0x01AAB0:
		subq.b	#$01, Obj_Control_Var_10(A0)			 ; $0040
		bcc.s	Offset_0x01AADA
		move.b	#$00, Obj_Control_Var_10(A0)			 ; $0040
		move.b	#$00, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$003C, Obj_Control_Var_02(A0)			 ; $0032
		move.b	Obj_Ani_Number(A0), D0					 ; $0020
		addq.b	#$01, D0
		cmpi.b	#$05, D0
		bcs.s	Offset_0x01AAD6
		moveq	#$00, D0
Offset_0x01AAD6:
		move.b	D0, Obj_Ani_Number(A0)					 ; $0020
Offset_0x01AADA:
		move.w	Obj_Control_Var_04(A0), D2				 ; $0034
		move.w	Obj_Control_Var_06(A0), D3				 ; $0036
		moveq	#$00, D0
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		addq.w	#$04, D0
		move.l	#$00000100, D4
		divu.w	D0, D4
		sub.w	D4, D2
		sub.w	D4, D3
		move.w	D2, Obj_X(A0)					 ; $0010
		move.w	D3, Obj_Y(A0)					 ; $0014
		clr.w	(Art_Scaling_Data_Buffer).w			 ; $FFFFF740
		tst.w	Obj_Control_Var_02(A0)					 ; $0032
		bne.s	Offset_0x01AB32
		move.l	A0, -(A7)
		bsr.w	Init_Art_Scaling			   ; Offset_0x01AB3C
		move.l	(A7)+, A0
		move.l	A0, -(A7)
		move.w	#$6500, D0
		bsr.w	Perform_Scaling				   ; Offset_0x01ABE2
		move.l	(A7)+, A0
		move.w	(Art_Scaling_Data_Buffer).w, D3		 ; $FFFFF740
		lsl.w	#$04, D3
		move.l	#(M68K_Dev_RAM_Start+$8000), D1		 ; $FFFE8000
		move.w	#$A000, D2
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
Offset_0x01AB32:
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;-------------------------------------------------------------------------------
Init_Art_Scaling:							   ; Offset_0x01AB3C
		moveq	#$00, D1
		move.w	D1, (Art_Scaling_Data_Buffer).w		 ; $FFFFF740
		move.w	D1, A0
		move.w	D1, A1
		move.w	D1, A2
		move.w	D1, A3
		move.w	D1, A4
		move.w	D1, A5
		lea		(M68K_Dev_RAM_Start+$A000), A6		 ; $FFFEA000
		tst.b	(Art_Scaling_Data_Buffer+$02).w		 ; $FFFFF742
		beq.s	Offset_0x01AB60
		lea		(M68K_Dev_RAM_Start+$A000), A6		 ; $FFFEA000
Offset_0x01AB60:
		move.w	#$001F, D1
Offset_0x01AB64:
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A5, -(A6)
		movem.l A0-A3, -(A6)
		dbra	D1, Offset_0x01AB64
		tst.b	(Art_Scaling_Data_Buffer+$02).w		 ; $FFFFF742
		beq.s	Offset_0x01ABA0
		move.w	#$0100, (Art_Scaling_Data_Buffer).w			 ; $FFFFF740
Offset_0x01ABA0:
		rts
;-------------------------------------------------------------------------------
Offset_0x01ABA2:
		dc.w	$0100, $00FC, $0090, $0090, $0040, $0040, $0040, $003C
		dc.w	$003C, $003C, $003C, $003C, $0010, $0010, $0010, $0010
		dc.w	$0010, $0010, $0010, $0010, $0010, $0010, $0010, $0010
		dc.w	$0010, $0010, $0010, $0010, $000C, $000C, $000C, $000C
;-------------------------------------------------------------------------------
Perform_Scaling:							   ; Offset_0x01ABE2
		moveq	#$00, D1
		move.b	Obj_Control_Var_10(A0), D1				 ; $0040
		cmpi.b	#$1C, D1
		bcs.s	Offset_0x01ABF2
		move.b	#$1C, D1
Offset_0x01ABF2:
		move.b	D1, Obj_Map_Id(A0)				 ; $0022
		add.w	D1, D1
		move.w	Offset_0x01ABA2(PC, D1), D1
		move.w	(Art_Scaling_Data_Buffer).w, D2		 ; $FFFFF740
		tst.b	(Art_Scaling_Data_Buffer+$02).w		 ; $FFFFF742
		bne.s	Offset_0x01AC12
		add.w	D1, D2
		cmpi.w	#$0100, D2
		bhi.s	Offset_0x01AC46
		sub.w	D1, D2
		bra.s	Offset_0x01AC1A
Offset_0x01AC12:
		sub.w	D1, D2
		bcs.s	Offset_0x01AC46
		addi.w	#$0100, D0
Offset_0x01AC1A:
		movem.l D1/D5-D7/A0/A2/A4, -(A7)
		lea		(M68K_Dev_RAM_Start+$8000), A2		 ; $FFFE8000
		add.w	D2, D0
		move.w	D0, Obj_Art_VRAM(A0)					 ; $000A
		lsl.w	#$05, D2
		adda.w	D2, A2
		bsr.s	Offset_0x01AC4E
		movem.l (A7)+, D1/D5-D7/A0/A2/A4
		tst.b	(Art_Scaling_Data_Buffer+$02).w		 ; $FFFFF742
		bne.s	Offset_0x01AC40
		add.w	D1, (Art_Scaling_Data_Buffer).w		 ; $FFFFF740
		rts
Offset_0x01AC40:
		sub.w	D1, (Art_Scaling_Data_Buffer).w		 ; $FFFFF740
		rts
Offset_0x01AC46:
		bclr	#$07, Obj_Flags(A0)				 ; $0004
		rts
Offset_0x01AC4E:
		moveq	#$00, D0
		move.b	Obj_Control_Var_10(A0), D0				 ; $0040
		moveq	#$00, D1
		move.b	Obj_Ani_Number(A0), D1					 ; $0020
		move.l	Obj_Control_Var_12(A0), A1				 ; $0042
		ror.w	#$04, D1
		adda.l	D1, A1
		move.l	A1, A0
		adda.w	#$1000, A0
		addi.w	#$0004, D0
		move.w	D0, D4
		lsr.w	#$03, D4
		move.w	D0, D5
		ror.w	#$03, D5
		andi.w	#$E000, D5
		move.w	#$00F0, D6
		swap	D6
		move.w	#$000F, D7
		swap	D7
		tst.w	D4
		beq.w	Offset_0x01AF8A
		cmpi.w	#$0001, D4
		bne.s	Offset_0x01AC9E
		tst.w	D5
		beq.w	Offset_0x01AF0E
		cmpi.w	#$2000, D5
		beq.w	Offset_0x01AE88
Offset_0x01AC9E:
		move.w	D4, D2
		swap	D2
		move.w	D5, D2
		lsr.l	#$08, D2
		move.l	#$00400000, D0
		divu.w	D2, D0
		lsr.w	#$08, D0
		lsr.w	#$03, D0
		subq.w	#$01, D0
		move.w	D0, A5
		moveq	#$00, D2
		moveq	#$00, D3
		lea		Offset_0x01AD10(PC), A6
Offset_0x01ACBE:
		move.w	#$001F, D7
Offset_0x01ACC2:
		swap	D7
		swap	D3
		move.w	#$0000, D2
		move.w	#$0000, D3
		move.l	A2, A4
		move.w	A5, D6
		bmi.s	Offset_0x01ACE4
Offset_0x01ACD4:
		swap	D6
		jsr		(A6)
		swap	D6
		dbra	D6, Offset_0x01ACD4
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x01ACEC
Offset_0x01ACE4:
		swap	D6
		jsr		Offset_0x01AD76(PC)
		swap	D6
Offset_0x01ACEC:
		swap	D3
		add.w	D5, D3
		bcc.s	Offset_0x01ACF6
		adda.w	#$0040, A1
Offset_0x01ACF6:
		move.w	D4, D0
		lsl.w	#$06, D0
		adda.w	D0, A1
		cmpa.l	A0, A1
		bcc.s	Offset_0x01AD0E
		addq.w	#$04, A2
		swap	D7
		dbra	D7, Offset_0x01ACC2
		lea		$0380(A2), A2
		bra.s	Offset_0x01ACBE
Offset_0x01AD0E:
		rts
;-------------------------------------------------------------------------------
Offset_0x01AD10:
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
;-------------------------------------------------------------------------------
Offset_0x01AD76:
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01AD88
		move.b	#$00, D0
Offset_0x01AD88:
		move.b	$00(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01AD9A
		move.b	#$00, D1
Offset_0x01AD9A:
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01ADB4
		move.b	#$00, D0
Offset_0x01ADB4:
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01ADC6
		move.b	#$00, D1
Offset_0x01ADC6:
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01ADE0
		move.b	#$00, D0
Offset_0x01ADE0:
		move.b	(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01ADF2
		move.b	#$00, D1
Offset_0x01ADF2:
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A1, D2), D0
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01AE0C
		move.b	#$00, D0
Offset_0x01AE0C:
		move.b	$00(A1, D2), D1
		add.w	D5, D3
		addx.w	D4, D2
		cmpi.w	#$0040, D2
		bcs.s	Offset_0x01AE1E
		move.b	#$00, D1
Offset_0x01AE1E:
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
;-------------------------------------------------------------------------------
; Offset_0x01AE2C:
		lea		(M68K_Dev_RAM_Start), A1			 ; $FFFE0000
		move.w	#$13FF, D0
Offset_0x01AE36:
		andi.l	#$0F0F0F0F, (A1)+
		dbra	D0, Offset_0x01AE36
		rts
;-------------------------------------------------------------------------------
; Offset_0x01AE42:
		lea		(M68K_Dev_RAM_Start), A2			 ; $FFFE0000
		lea		(M68K_Dev_RAM_Start+$8000), A1		 ; $FFFE8000
		moveq	#$3F, D2
Offset_0x01AE50:
		moveq	#$07, D1
Offset_0x01AE52:
		move.w	#$000F, D0
Offset_0x01AE56:
		move.l	(A2), (A1)+
		adda.w	#$0020, A2
		dbra	D0, Offset_0x01AE56
		suba.w	#$01FC, A2
		dbra	D1, Offset_0x01AE52
		adda.w	#$01E0, A2
		dbra	D2, Offset_0x01AE50
		lea		(M68K_Dev_RAM_Start+$8000), A1		 ; $FFFE8000
		lea		(M68K_RAM_Start), A2				 ; $FFFF0000
		move.w	#$1FFF, D0
Offset_0x01AE80:
		move.l	-(A2), -(A1)
		dbra	D0, Offset_0x01AE80
		rts
Offset_0x01AE88:
		moveq	#$00, D3
		lsl.w	#$06, D4
		lea		Offset_0x01AED6(PC), A6
		move.w	#$0001, D7
Offset_0x01AE94:
		swap	D7
		move.w	#$001F, D6
Offset_0x01AE9A:
		swap	D6
		move.l	A1, A3
		move.l	A2, A4
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		move.b	(A3)+, D0
		and.b	D6, D0
		move.b	D0, (A4)+
		add.w	D5, D3
		bcc.s	Offset_0x01AEBC
		lea		$0040(A1), A1
Offset_0x01AEBC:
		adda.w	D4, A1
		cmpa.l	A0, A1
		bcc.s	Offset_0x01AED4
		addq.w	#$04, A2
		swap	D6
		dbra	D6, Offset_0x01AE9A
		lea		$0380(A2), A2
		swap	D7
		dbra	D7, Offset_0x01AE94
Offset_0x01AED4:
		rts
;-------------------------------------------------------------------------------
Offset_0x01AED6:
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		addq.w	#$01, A3
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
Offset_0x01AF0E:
		moveq	#$00, D3
		lsl.w	#$06, D4
		lea		Offset_0x01AF54(PC), A6
		move.w	#$0001, D7
Offset_0x01AF1A:
		swap	D7
		move.w	#$001F, D6
Offset_0x01AF20:
		swap	D6
		move.l	A1, A3
		move.l	A2, A4
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		add.w	D5, D3
		bcc.s	Offset_0x01AF3E
		lea		$0040(A1), A1
Offset_0x01AF3E:
		adda.w	D4, A1
		addq.w	#$04, A2
		swap	D6
		dbra	D6, Offset_0x01AF20
		lea		$0380(A2), A2
		swap	D7
		dbra	D7, Offset_0x01AF1A
		rts
;-------------------------------------------------------------------------------
Offset_0x01AF54:
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
Offset_0x01AF8A:
		cmpi.w	#$E000, D5
		bne.w	Offset_0x01B00C
		lea		Offset_0x01AFE0(PC), A6
		moveq	#$00, D3
		lsl.w	#$06, D4
		move.w	#$0002, D7
Offset_0x01AF9E:
		swap	D7
		move.w	#$001F, D6
Offset_0x01AFA4:
		swap	D6
		move.l	A1, A3
		move.l	A2, A4
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		move.b	(A3), (A4)
		add.w	D5, D3
		bcc.s	Offset_0x01AFC6
		lea		$0040(A1), A1
Offset_0x01AFC6:
		adda.w	D4, A1
		cmpa.l	A0, A1
		bcc.s	Offset_0x01AFDE
		addq.w	#$04, A2
		swap	D6
		dbra	D6, Offset_0x01AFA4
		lea		$0580(A2), A2
		swap	D7
		dbra	D7, Offset_0x01AF9E
Offset_0x01AFDE:
		rts
;-------------------------------------------------------------------------------
Offset_0x01AFE0:
		move.b	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
Offset_0x01B00C:
		cmpi.w	#$C000, D5
		bne.w	Offset_0x01B096
		moveq	#$00, D3
		lsl.w	#$06, D4
		lea		Offset_0x01B074(PC), A6
		move.w	#$0003, D7
Offset_0x01B020:
		swap	D7
		move.w	#$001F, D6
Offset_0x01B026:
		swap	D6
		move.l	A1, A3
		move.l	A2, A4
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		jsr		(A6)
		move.b	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3), D0
		move.b	D0, (A4)
		add.w	D5, D3
		bcc.s	Offset_0x01B05A
		lea		$0040(A1), A1
Offset_0x01B05A:
		adda.w	D4, A1
		cmpa.l	A0, A1
		bcc.s	Offset_0x01B072
		addq.w	#$04, A2
		swap	D6
		dbra	D6, Offset_0x01B026
		lea		$0580(A2), A2
		swap	D7
		dbra	D7, Offset_0x01B020
Offset_0x01B072:
		rts
;-------------------------------------------------------------------------------
Offset_0x01B074:
		move.b	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		lea		$007C(A4), A4
		rts
Offset_0x01B096:
		cmpi.w	#$A000, D5
		bne.w	Offset_0x01B130
		moveq	#$00, D3
		lsl.w	#$06, D4
		lea		Offset_0x01B11A(PC), A5
		lea		Offset_0x01B102(PC), A6
		move.w	#$0003, D7
Offset_0x01B0AE:
		swap	D7
		move.w	#$001F, D6
Offset_0x01B0B4:
		swap	D6
		move.l	A1, A3
		move.l	A2, A4
		jsr		(A5)
		jsr		(A6)
		jsr		(A5)
		jsr		(A6)
		jsr		(A5)
		jsr		(A6)
		jsr		(A5)
		jsr		(A6)
		jsr		(A5)
		jsr		(A6)
		jsr		(A5)
		jsr		(A6)
		move.w	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		add.w	D5, D3
		bcc.s	Offset_0x01B0E8
		lea		$0040(A1), A1
Offset_0x01B0E8:
		adda.w	D4, A1
		cmpa.l	A0, A1
		bcc.s	Offset_0x01B100
		addq.w	#$04, A2
		swap	D6
		dbra	D6, Offset_0x01B0B4
		lea		$0780(A2), A2
		swap	D7
		dbra	D7, Offset_0x01B0AE
Offset_0x01B100:
		rts
;-------------------------------------------------------------------------------
Offset_0x01B102:
		move.b	(A3)+, (A4)+
		move.b	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, (A4)+
		lea		$007C(A4), A4
		rts
;-------------------------------------------------------------------------------
Offset_0x01B11A:
		move.w	(A3)+, (A4)+
		move.b	(A3)+, D0
		move.b	(A3)+, D1
		and.b	D6, D0
		and.b	D7, D1
		or.b	D1, D0
		move.b	D0, (A4)+
		move.b	(A3)+, (A4)+
		lea		$007C(A4), A4
		rts
Offset_0x01B130:
		moveq	#$00, D3
		lsl.w	#$06, D4
		moveq	#$03, D7
Offset_0x01B136:
		move.w	#$001F, D6
Offset_0x01B13A:
		move.l	A1, A3
		move.l	A2, A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		move.l	(A3)+, (A4)
		lea		$0080(A4), A4
		add.w	D5, D3
		bcc.s	Offset_0x01B1A6
		lea		$0040(A1), A1
Offset_0x01B1A6:
		adda.w	D4, A1
		addq.w	#$04, A2
		dbra	D6, Offset_0x01B13A
		lea		$0780(A2), A2
		dbra	D7, Offset_0x01B136
		rts
;-------------------------------------------------------------------------------
Scaling_Mappings:							   ; Offset_0x01B1B8
		dc.w	Offset_0x01B1F8-Scaling_Mappings
		dc.w	Offset_0x01B25A-Scaling_Mappings
		dc.w	Offset_0x01B2BC-Scaling_Mappings
		dc.w	Offset_0x01B2BC-Scaling_Mappings
		dc.w	Offset_0x01B2F4-Scaling_Mappings
		dc.w	Offset_0x01B2F4-Scaling_Mappings
		dc.w	Offset_0x01B2F4-Scaling_Mappings
		dc.w	Offset_0x01B30E-Scaling_Mappings
		dc.w	Offset_0x01B30E-Scaling_Mappings
		dc.w	Offset_0x01B30E-Scaling_Mappings
		dc.w	Offset_0x01B30E-Scaling_Mappings
		dc.w	Offset_0x01B30E-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B328-Scaling_Mappings
		dc.w	Offset_0x01B330-Scaling_Mappings
		dc.w	Offset_0x01B330-Scaling_Mappings
		dc.w	Offset_0x01B330-Scaling_Mappings
		dc.w	Offset_0x01B330-Scaling_Mappings
Offset_0x01B1F8:
		dc.w	$0010
		dc.w	$000F, $0000, $0000
		dc.w	$000F, $0010, $0020
		dc.w	$000F, $0020, $0040
		dc.w	$000F, $0030, $0060
		dc.w	$200F, $0040, $0000
		dc.w	$200F, $0050, $0020
		dc.w	$200F, $0060, $0040
		dc.w	$200F, $0070, $0060
		dc.w	$400F, $0080, $0000
		dc.w	$400F, $0090, $0020
		dc.w	$400F, $00A0, $0040
		dc.w	$400F, $00B0, $0060
		dc.w	$600F, $00C0, $0000
		dc.w	$600F, $00D0, $0020
		dc.w	$600F, $00E0, $0040
		dc.w	$600F, $00F0, $0060
Offset_0x01B25A:
		dc.w	$0010
		dc.w	$000F, $0000, $0000
		dc.w	$000F, $0010, $0020
		dc.w	$000F, $0020, $0040
		dc.w	$0007, $0030, $0060
		dc.w	$200F, $0040, $0000
		dc.w	$200F, $0050, $0020
		dc.w	$200F, $0060, $0040
		dc.w	$2007, $0070, $0060
		dc.w	$400F, $0080, $0000
		dc.w	$400F, $0090, $0020
		dc.w	$400F, $00A0, $0040
		dc.w	$4007, $00B0, $0060
		dc.w	$600F, $00C0, $0000
		dc.w	$600F, $00D0, $0020
		dc.w	$600F, $00E0, $0040
		dc.w	$6007, $00F0, $0060
Offset_0x01B2BC:
		dc.w	$0009
		dc.w	$000F, $0000, $0000
		dc.w	$000F, $0010, $0020
		dc.w	$000F, $0020, $0040
		dc.w	$200F, $0030, $0000
		dc.w	$200F, $0040, $0020
		dc.w	$200F, $0050, $0040
		dc.w	$400F, $0060, $0000
		dc.w	$400F, $0070, $0020
		dc.w	$400F, $0080, $0040
Offset_0x01B2F4:
		dc.w	$0004
		dc.w	$000F, $0000, $0000
		dc.w	$000F, $0010, $0020
		dc.w	$200F, $0020, $0000
		dc.w	$200F, $0030, $0020
Offset_0x01B30E:
		dc.w	$0004
		dc.w	$000F, $0000, $0000
		dc.w	$0007, $0010, $0020
		dc.w	$200F, $0020, $0000
		dc.w	$2007, $0030, $0020
Offset_0x01B328:
		dc.w	$0001
		dc.w	$000F, $0000, $0000
Offset_0x01B330:
		dc.w	$0001
		dc.w	$0007, $0000, $0000
;-------------------------------------------------------------------------------
; Objeto de escalonamento das esferas
; <<<-
;-------------------------------------------------------------------------------