; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Sonic
; ---------------------------------------------------------------------------
		lea	(Sonic_Max_Speed).w,a4
		lea	(Distance_From_Top).w,a5
		lea	(Obj_P1_Dust_Water_Splash).w,a6
		tst.w	(Debug_placement_mode).w		; is debug mode being used?
		beq.s	Sonic_Normal				; if not, branch
		jmp	(Debug_Mode).l
; ---------------------------------------------------------------------------
; Offset_0x00AA4E:
Sonic_Normal:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	Sonic_Index(pc,d0.w),d1
		jmp	Sonic_Index(pc,d1.w)
; ===========================================================================
; Offset_0x00AA5C:
Sonic_Index:	dc.w Sonic_Init-Sonic_Index
		dc.w Sonic_Control-Sonic_Index
		dc.w Sonic_Hurt-Sonic_Index
		dc.w Sonic_Death-Sonic_Index
		dc.w Sonic_ResetLevel-Sonic_Index
		dc.w Sonic_Animate-Sonic_Index
; ===========================================================================
; Offset_0x00AA68: Sonic_Main:
Sonic_Init:
		addq.b	#2,Obj_Routine(a0)
		move.b	#$13,Obj_Height_2(a0)
		move.b	#9,Obj_Width_2(a0)
		move.b	#$13,Obj_Height_3(a0)
		move.b	#9,Obj_Width_3(a0)
		move.l	#Sonic_Mappings,Obj_Map(a0)
		move.w	#$100,Obj_Priority(a0)
		move.b	#$18,Obj_Width(a0)
		move.b	#$18,Obj_Height(a0)
		move.b	#4,Obj_Flags(a0)
		move.b	#0,Obj_Player_Selected(a0)
		move.w	#$600,(a4)
		move.w	#$C,Acceleration(a4)
		move.w	#$80,Deceleration(a4)
		tst.b	(Saved_Level_Flag).w
		bne.s	Sonic_Init_Continued
		move.w	#$680,Obj_Art_VRAM(a0)
		move.b	#$C,Obj_Player_Top_Solid(a0)
		move.b	#$D,Obj_Player_LRB_Solid(a0)
		move.w	Obj_X(a0),(Saved_Obj_X_P1).w
		move.w	Obj_Y(a0),(Saved_Obj_Y_P1).w
		move.w	Obj_Art_VRAM(a0),(Saved_Obj_Art_VRAM_P1).w
		move.w	Obj_Player_Top_Solid(a0),(Saved_Top_Solid_P1).w
; Offset_0x00AAEA:
Sonic_Init_Continued:
		move.b	#0,Obj_P_Flips_Remaining(a0)
		move.b	#4,Obj_Player_Flip_Speed(a0)
		move.b	#0,(Super_Sonic_flag).w
		move.b	#$1E,Obj_Subtype(a0)
		subi.w	#$20,Obj_X(a0)
		addi.w	#4,Obj_Y(a0)
		bsr.w	ResetPlayerPositionArray
		addi.w	#$20,Obj_X(a0)
		subi.w	#4,Obj_Y(a0)
		move.w	#0,(Dropdash_flag).w

; ---------------------------------------------------------------------------
; Normal state for Sonic
; ---------------------------------------------------------------------------
; Offset_0x00AB24:
Sonic_Control:
		tst.w	(Debug_Mode_Active).w			; is debug cheat enabled?
		beq.s	Offset_0x00AB3E				; if not, branch
		btst	#4,(Control_Ports_Buffer_Data+1).w	; is button B pressed?
		beq.s	Offset_0x00AB3E				; if not, branch
		move.w	#1,(Debug_placement_mode).w		; change Sonic into a ring/item
		clr.b	(Control_Locked_Flag_P1).w		; unlock controls
		rts
; ---------------------------------------------------------------------------

Offset_0x00AB3E:
		tst.b	(Control_Locked_Flag_P1).w		; are controls locked?
		bne.s	Offset_0x00AB4A				; if yes, branch
		move.w	(Control_Ports_Buffer_Data).w,(Control_Ports_Logical_Data).w	; copy new held buttons to enable joypad control

Offset_0x00AB4A:
		btst	#0,Obj_Player_Control(a0)
		bne.s	Offset_0x00AB6C
		movem.l	a4-a6,-(sp)
		moveq	#0,d0
		move.b	Obj_Status(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)
		movem.l	(sp)+,a4-a6

Offset_0x00AB6C:
		cmpi.w	#-$100,(Sonic_Level_Limits_Min_Y).w	; is vertical wrapping enabled?
		bne.s	Offset_0x00AB7C				; if not, branch
		move.w	(Screen_Wrap_Y).w,d0
		and.w	d0,Obj_Y(a0)				; perform wrapping of Sonic's y-position

Offset_0x00AB7C:
		bsr.s	Sonic_Display
		bsr.w	Sonic_Super
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	(Primary_Angle).w,Obj_Player_Next_Tilt(a0)
		move.b	(Secondary_Angle).w,Obj_Player_Tilt(a0)
		tst.b	(Sonic_Wind_Flag).w
		beq.s	Offset_0x00ABA8
		tst.b	Obj_Ani_Number(a0)
		bne.s	Offset_0x00ABA8
		move.b	Obj_Ani_Flag(a0),Obj_Ani_Number(a0)

Offset_0x00ABA8:
		btst	#1,Obj_Player_Control(a0)
		bne.s	Offset_0x00ABB8
		bsr.w	Sonic_Animate1P
		bsr.w	LoadSonicDynamicPLC

Offset_0x00ABB8:
		move.b	Obj_Player_Control(a0),d0
		andi.b	#$A0,d0
		bne.s	Offset_0x00ABC8
		jsr	(Touch_Response).l

Offset_0x00ABC8:
		rts
; ===========================================================================
; Offset_0x00ABCA:
Sonic_Modes:
		dc.w	Sonic_MdNormal_Checks-Sonic_Modes
		dc.w	Sonic_MdAir-Sonic_Modes
		dc.w	Sonic_MdRoll-Sonic_Modes
		dc.w	Sonic_MdJump-Sonic_Modes
; ===========================================================================
; Offset_0x00ABD2:
Sonic_Display:
		move.b	Obj_P_Invunerblt_Time(a0),d0
		beq.s	Offset_0x00ABE0
		subq.b	#1,Obj_P_Invunerblt_Time(a0)
		lsr.b	#3,d0
		bcc.s	Sonic_ChkInvin

Offset_0x00ABE0:
		jsr	(DisplaySprite).l
; Offset_0x00ABE6:
Sonic_ChkInvin:
		btst	#1,Obj_Player_Status(a0)		; does Sonic have invincibility?
		beq.s	Sonic_ChkShoes				; if not, branch
		tst.b	Obj_P_Invcbility_Time(a0)		; has the invincibility run out?
		beq.s	Sonic_ChkShoes				; if yes, branch
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0					; countdown invincibility timer every eighth frame (used to save a byte of Sonic's SST)
		bne.s	Sonic_ChkShoes
		subq.b	#1,Obj_P_Invcbility_Time(a0)
		bne.s	Sonic_ChkShoes
		tst.b	(Boss_Flag).w
		bne.s	Sonic_RmvInvin
		cmpi.b	#$C,Obj_Subtype(a0)
		bcs.s	Sonic_RmvInvin
		move.w	(Level_Music_Buffer).w,d0
		jsr	(PlaySound).l
; Offset_0x00AC1C:
Sonic_RmvInvin:
		bclr	#1,Obj_Player_Status(a0)		; remove invincibility
; Offset_0x00AC22:
Sonic_ChkShoes:
		btst	#2,Obj_Player_Status(a0)		; does Sonic have speed shoes?
		beq.s	Sonic_ExitChk				; if not, branch
		tst.b	Obj_P_Spd_Shoes_Time(a0)		; has the speed shoes run out?
		beq.s	Sonic_ExitChk				; if yes, branch
		move.b	(Level_frame_counter+1).w,d0
		andi.b	#7,d0					; again, countdown speed shoes timer every eighth frame
		bne.s	Sonic_ExitChk
		subq.b	#1,Obj_P_Spd_Shoes_Time(a0)
		bne.s	Sonic_ExitChk
		tst.w	(Two_Player_Flag).w			; is this two competition mode?
		bne.s	Sonic_ChkShoesCompetition		; if yes, branch
		; reset Sonic's speed values
		move.w	#$600,(a4)
		move.w	#$C,Acceleration(a4)
		move.w	#$80,Deceleration(a4)
		tst.b	(Super_Sonic_flag).w
		beq.s	Sonic_RmvSpeed
		move.w	#$A00,(a4)
		move.w	#$30,Acceleration(a4)
		move.w	#$100,Deceleration(a4)
; Offset_0x00AC6C:
Sonic_RmvSpeed:
		bclr	#2,Obj_Player_Status(a0)		; remove speed shoes
		move.w	#cmd_S2SlowDown,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------
; Offset_0x00AC7C:
Sonic_ExitChk:
		rts
; ---------------------------------------------------------------------------
; Offset_0x00AC7E:
Sonic_ChkShoesCompetition:
		lea	(Player_Start_Speed_Array).l,a1
		moveq	#0,d0
		move.b	Obj_Player_Selected(a0),d0
		lsl.w	#3,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,(a4)
		move.w	(a1)+,Acceleration(a4)
		move.w	(a1)+,Deceleration(a4)
		bclr	#2,Obj_Player_Status(a0)
		rts
; End of subroutine Sonic_Display

; ---------------------------------------------------------------------------
; Subroutine to record Sonic's previous positions for invincibility stars
; and input/status flags for Tails' AI to follow
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00ACA2: CopySonicMovesForMiles:
Sonic_RecordPos:
		cmpa.w	#Obj_Player_One,a0
		bne.s	Offset_0x00ACD2
		move.w	(Position_Table_Index).w,d0
		lea	(Position_Table_Data).w,a1
		lea	(a1,d0.w),a1
		move.w	Obj_X(a0),(a1)+
		move.w	Obj_Y(a0),(a1)+
		addq.b	#4,(Position_Table_Index+1).w
		lea	(Status_Table_Data).w,a1
		lea	(a1,d0.w),a1
		move.w	(Control_Ports_Logical_Data).w,(a1)+
		move.w	Obj_Status(a0),(a1)+
		rts
; End of subroutine Sonic_RecordPos

Offset_0x00ACD2:
		move.w	(Position_Table_Index_2P).w,d0				; $FFFFEE2A
		lea	(Position_Table_Data_P2).w,a1				; $FFFFE600
		lea	(A1,d0.w),a1
		move.w	Obj_X(A0),(A1)+				 ; $0010
		move.w	Obj_Y(A0),(A1)+				 ; $0014
		addq.b	#4,(Position_Table_Index_2P+$01).w		  ; $FFFFEE2B
		rts

; ---------------------------------------------------------------------------
; Subroutine to refresh the player's old position values to their current ones
;
; This is a hackish work around to stop the camera from jerking around from
; being delayed (try spindashing against a wall in Sonic 2 to see this)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00ACEC: Reset_Player_Position_Array:
ResetPlayerPositionArray:
		cmpa.w	#Obj_Player_One,a0		; is this player one?
		bne.s	Reset_Player_Position_Array_P2	; if not, branch
		lea	(Position_Table_Data).w,a1
		lea	(Status_Table_Data).w,a2
		move.w	#bytesToLcnt($100),d0

Offset_0x00ACFE:
		move.w	Obj_X(a0),(a1)+
		move.w	Obj_Y(a0),(a1)+
		move.l	#0,(a2)+		; set all position data to 0
		dbf	d0,Offset_0x00ACFE
		move.w	#0,(Position_Table_Index).w
		rts

; Offset_0x00AD18:
Reset_Player_Position_Array_P2:
		lea	(Position_Table_Data_P2).w,a1
		move.w	#bytesToLcnt($100),d0

Offset_0x00AD20:
		move.w	Obj_X(a0),(a1)+
		move.w	Obj_Y(a0),(a1)+
		dbf	d0,Offset_0x00AD20
		move.w	#0,(Position_Table_Index_2P).w
		rts
; End of function ResetPlayerPositionArray

; ---------------------------------------------------------------------------
; Subroutine for Sonic when he's underwater
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00AD34:
Sonic_Water:
		tst.b	(Water_Level_Flag).w
		bne.s	Sonic_InWater

Offset_0x00AD3A:
		rts
; ---------------------------------------------------------------------------
; Offset_0x00AD3C: Sonic_InLevelWithWater:
Sonic_InWater:
		move.w	(Water_Level_Move).w,d0
		cmp.w	Obj_Y(a0),d0				; is Sonic above the water?
		bge.s	Sonic_OutWater				; if yes, branch

		bset	#6,Obj_Status(a0)			; set underwater flag
		bne.s	Offset_0x00AD3A				; if already underwater, branch

		addq.b	#1,(Water_Entered_Counter).w
		movea.l	a0,a1
		bsr.w	ResumeMusic
		move.l	#Obj_Player_Underwater,(Obj_P1_Underwater_Control).w	; load Sonic's breathing bubbles
		move.b	#$81,(Obj_P1_Underwater_Control+Obj_Subtype).w
		move.l	a0,(Obj_P1_Underwater_Control+$0040).w
		move.w	#$300,(a4)
		move.w	#6,Acceleration(a4)
		move.w	#$40,Deceleration(a4)
		tst.b	(Super_Sonic_flag).w
		beq.s	Offset_0x00AD90
		move.w	#$500,(a4)
		move.w	#$18,Acceleration(a4)
		move.w	#$80,Deceleration(a4)

Offset_0x00AD90:
		asr.w	Obj_Speed_X(a0)
		asr.w	Obj_Speed_Y(a0)				; memory operands can only be shifted one bit at a time
		asr.w	Obj_Speed_Y(a0)
		beq.s	Offset_0x00AD3A
		move.w	#$100,Obj_Ani_Number(a6)		; splash animation
		move.w	#sfx_Splash,d0			; splash sound
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------
; Offset_0x00ADAE: Sonic_NotInWater:
Sonic_OutWater:
		bclr	#6,Obj_Status(a0)			; unset underwater flag
		beq.s	Offset_0x00AD3A				; if already above water, branch
		addq.b	#1,(Water_Entered_Counter).w

		move.l	a0,a1
		bsr.w	ResumeMusic
		move.w	#$600,(a4)
		move.w	#$C,Acceleration(a4)
		move.w	#$80,Deceleration(a4)
		tst.b	(Super_Sonic_flag).w
		beq.s	Offset_0x00ADE6				; if Super, set different values
		move.w	#$A00,(a4)
		move.w	#$30,Acceleration(a4)
		move.w	#$100,Deceleration(a4)

Offset_0x00ADE6:
		cmpi.b	#4,Obj_Routine(a0)			; is Sonic falling back from getting hurt?
		beq.s	Offset_0x00ADFC				; if yes, branch
		move.w	Obj_Speed_Y(a0),d0
		cmpi.w	#-$400,d0
		blt.s	Offset_0x00ADFC
		asl.w	Obj_Speed_Y(a0)

Offset_0x00ADFC:
		cmpi.b	#$1C,Obj_Ani_Number(a0)			; is Sonic in his 'blank' animation?
		beq.w	Offset_0x00AD3A				; if yes, branch
		tst.w	Obj_Speed_Y(a0)
		beq.w	Offset_0x00AD3A
		move.w	#$100,Obj_Ani_Number(a6)		; splash animation
		movea.l	a0,a1
		bsr.w	ResumeMusic
		cmpi.w	#-$1000,Obj_Speed_Y(a0)
		bgt.s	Offset_0x00AE28
		move.w	#-$1000,Obj_Speed_Y(a0)			; limit upward y velocity exiting the water

Offset_0x00AE28:
		move.w	#sfx_Splash,d0
		jmp	(PlaySound).l
; End of subroutine Sonic_Water

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------
; Offset_0x00AE32:
Sonic_MdNormal_Checks:
		; If Sonic has been waiting for a while,and is tapping his foot
		; impatiently, then make him blink once the player starts moving
		; again. Likewise, if he's been waiting for so long that he's laying
		; down, then make him play an animation of standing up.
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask,d0
		bne.s	Sonic_MdNormal
		cmpi.b	#$A,Obj_Ani_Number(a0)
		beq.s	Offset_0x00AEB6
		cmpi.b	#$B,Obj_Ani_Number(a0)
		beq.s	Offset_0x00AEB6
		cmpi.b	#5,Obj_Ani_Number(a0)
		bne.s	Sonic_MdNormal
		cmpi.b	#$1E,Obj_Ani_Frame(a0)
		bcs.s	Sonic_MdNormal
		bsr.w	Sonic_SlopeResist
		move.b	(Control_Ports_Logical_Data).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask+button_up_mask+button_down_mask+button_left_mask+button_right_mask,d0
		beq.s	Offset_0x00AE9E
		move.b	#$A,Obj_Ani_Number(a0)
		cmpi.b	#$AC,Obj_Ani_Frame(a0)
		bcs.s	Offset_0x00AE9E
		move.b	#$B,Obj_Ani_Number(a0)
		bra.s	Offset_0x00AE9E
; ---------------------------------------------------------------------------
; Offset_0x00AE80:
Sonic_MdNormal:
		bsr.w	Sonic_CheckSpindash
		bsr.w	Sonic_Jump
		bsr.w	Sonic_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Sonic_LevelBoundaries
		jsr	(SpeedToPos).l

Offset_0x00AE9E:
		bsr.w	Player_AnglePos
		bsr.w	Sonic_SlopeRepel
		tst.b	(Background_Collision_Flag).w
		beq.s	Offset_0x00AEB6
		bsr.w	Offset_0x009C92
		tst.w	d1
		bmi.w	Kill_Player

Offset_0x00AEB6:
		rts
; End of subroutine Sonic_MdNormal_Checks

; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)
; ---------------------------------------------------------------------------
; Offset_0x00AEB8: Sonic_MdJump:
Sonic_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBoundaries
		jsr	(ObjectFall).l
		btst	#6,Obj_Status(a0)			; is Sonic underwater?
		beq.s	Offset_0x00AED8				; if not, branch
		subi.w	#$28,Obj_Speed_Y(a0)			; reduce gravity by $28 ($38-$28=$10)

Offset_0x00AED8:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_Floor
		rts
; End of subroutine Sonic_MdAir

; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)
; ---------------------------------------------------------------------------
; Offset_0x00AEE2:
Sonic_MdRoll:
		tst.b	Obj_Player_Spdsh_Flag(A0)
		bne.s	Offset_0x00AEEC
		bsr.w	Sonic_Jump

Offset_0x00AEEC:
		bsr.w	Sonic_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Sonic_LevelBoundaries
		jsr	(SpeedToPos).l
		bsr.w	Player_AnglePos
		bsr.w	Sonic_SlopeRepel
		tst.b	(Background_Collision_Flag).w
		beq.s	Offset_0x00AF16
		bsr.w	Offset_0x009C92
		tst.w	d1
		bmi.w	Kill_Player

Offset_0x00AF16:
		rts
; End of subroutine Sonic_MdRoll

; ---------------------------------------------------------------------------
; Start of subroutine Sonic_MdJump
; Called if Sonic is in a ball and airborne (he could be jumping but not necessarily)
; ---------------------------------------------------------------------------
; Offset_0x00AF18: Sonic_MdJump2:
Sonic_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBoundaries
		jsr	(ObjectFall).l
		btst	#6,Obj_Status(a0)			; is Sonic underwater?
		beq.s	Offset_0x00AF38				; if not, branch
		subi.w	#$28,Obj_Speed_Y(a0)			; reduce gravity by $28 ($38-$28=$10)

Offset_0x00AF38:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_Floor
		rts
; End of subroutine Sonic_MdJump

; ---------------------------------------------------------------------------
; Subroutine to make Sonic walk/run
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00AF42:
Sonic_Move:
		move.w	(a4),d6
		move.w	Acceleration(a4),d5
		move.w	Deceleration(a4),d4
		tst.b	Obj_Player_Status(a0)
		bmi.w	Sonic_Traction
		tst.w	Obj_P_Horiz_Ctrl_Lock(a0)
		bne.w	Sonic_ResetScr
		btst	#button_left,(Control_Ports_Logical_Data).w	; is left being pressed?
		beq.s	Sonic_NotLeft				; if not, branch
		bsr.w	Offset_0x00B2A6
; Offset_0x00AF68:
Sonic_NotLeft:
		btst	#button_right,(Control_Ports_Logical_Data).w	; is right being pressed?
		beq.s	Sonic_NotRight				; if not, branch
		bsr.w	Offset_0x00B32C
; Offset_0x00AF74:
Sonic_NotRight:
		move.b	Obj_Angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0					; is Sonic on a slope?
		bne.w	Sonic_ResetScr				; if yes, branch
		tst.w	Obj_Inertia(a0)				; is Sonic moving?
		bne.w	Sonic_ResetScr				; if yes, branch
		bclr	#5,Obj_Status(a0)
		move.b	#5,Obj_Ani_Number(a0)			; use "standing" animation
		btst	#3,Obj_Status(a0)
		beq.w	Sonic_Balance
		move.w	Obj_Player_Last(a0),a1
		tst.b	Obj_Status(a1)
		bmi.w	Sonic_Lookup
		moveq	#0,d1
		move.b	Obj_Width(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#2,d2
		add.w	Obj_X(a0),d1
		sub.w	Obj_X(a1),d1
		tst.b	(Super_Sonic_flag).w
		bne.w	SuperSonic_Balance
		cmpi.w	#2,d1
		blt.s	Sonic_BalanceOnObjLeft
		cmp.w	d2,d1
		bge.s	Sonic_BalanceOnObjRight
		bra.w	Sonic_Lookup
; ---------------------------------------------------------------------------
; Offset_0x00AFD8:
SuperSonic_Balance:
		cmpi.w	#2,d1
		blt.w	SuperSonic_BalanceOnObjLeft
		cmp.w	d2,d1
		bge.w	SuperSonic_BalanceOnObjRight
		bra.w	Sonic_Lookup
; ---------------------------------------------------------------------------
; Balancing checks for when you're on the right edge of an object
; Offset_0x00AFEA:
Sonic_BalanceOnObjRight:
		btst	#0,Obj_Status(a0)			; is Sonic facing right?
		bne.s	.facingRight				; if yes, branch
		move.b	#6,Obj_Ani_Number(a0)			; use "balancing" animation 1
		addq.w	#6,d2
		cmp.w	d2,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$C,Obj_Ani_Number(a0)			; use "balancing" animation 2
		bra.w	Sonic_ResetScr
; Offset_0x00B00A:
.facingRight:
		; this code is still in final, but redundant since both animation sets are the same
		move.b	#$1D,Obj_Ani_Number(a0)			; use "balancing" animation 3
		addq.w	#6,d2
		cmp.w	d2,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$1E,Obj_Ani_Number(a0)			; use "balancing" animation 4
		bclr	#0,Obj_Status(a0)
		bra.w	Sonic_ResetScr
; ---------------------------------------------------------------------------
; Balancing checks for when you're on the left edge of an object
; Offset_0x00B028:
Sonic_BalanceOnObjLeft:
		btst	#0,Obj_Status(a0)			; is Sonic facing left?
		beq.s	.facingLeft				; if yes, branch
		move.b	#6,Obj_Ani_Number(a0)			; use "balancing" animation 1
		cmpi.w	#-4,d1					; is Sonic REALLY close to the edge?
		bge.w	Sonic_ResetScr				; if yes, branch
		move.b	#$C,Obj_Ani_Number(a0)			; use "balancing" animation 2
		bra.w	Sonic_ResetScr
; Offset_0x00B048:
.facingLeft:
		; same as above
		move.b	#$1D,Obj_Ani_Number(a0)			; use "balancing" animation 3
		cmpi.w	#-4,d1					; is Sonic REALLY close to the edge?
		bge.w	Sonic_ResetScr				; if yes, branch
		move.b	#$1E,Obj_Ani_Number(a0)			; use "balancing" animation 4
		bset	#0,Obj_Status(a0)
		bra.w	Sonic_ResetScr
; ---------------------------------------------------------------------------
; Balancing checks for when you're on the edge of part of the level
; Offset_0x00B066:
Sonic_Balance:
		jsr	(Player_HitFloor).l
		cmpi.w	#$C,d1
		blt.w	Sonic_Lookup
		tst.b	(Super_Sonic_flag).w			; is Sonic super?
		bne.w	SuperSonic_Balance2			; if yes, branch
		cmpi.b	#3,Obj_Player_Next_Tilt(a0)
		bne.s	Sonic_BalanceLeft
		btst	#0,Obj_Status(a0)			; is Sonic facing right?
		bne.s	.facingRight				; if yes, branch
		move.b	#6,Obj_Ani_Number(a0)			; use "balancing" animation 1
		move.w	Obj_X(a0),d3
		subq.w	#6,d3
		jsr	(Player_HitFloor_D3).l
		cmpi.w	#$C,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$C,Obj_Ani_Number(a0)			; use "balancing" animation 2
		bra.w	Sonic_ResetScr
; Offset_0x00B0B0:
.facingRight:
		; same as above as above
		move.b	#$1D,Obj_Ani_Number(a0)			; use "balancing" animation 3
		move.w	Obj_X(a0),d3
		subq.w	#6,d3
		jsr	(Player_HitFloor_D3).l
		cmpi.w	#$C,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$1E,Obj_Ani_Number(a0)			; use "balancing" animation 4
		bclr	#0,Obj_Status(a0)
		bra.w	Sonic_ResetScr
; ---------------------------------------------------------------------------
; Offset_0x00B0DA:
Sonic_BalanceLeft:
		cmpi.b	#3,Obj_Player_Tilt(a0)
		bne.s	Sonic_Lookup
		btst	#0,Obj_Status(a0)			; is Sonic facing left?
		beq.s	.facingLeft				; if yes, branch
		move.b	#6,Obj_Ani_Number(a0)			; use "balancing" animation 1
		move.w	Obj_X(a0),d3
		addq.w	#6,d3
		jsr	(Player_HitFloor_D3).l
		cmpi.w	#$C,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$C,Obj_Ani_Number(a0)			; use "balancing" animation 2
		bra.w	Sonic_ResetScr
; Offset_0x00B10E:
.facingLeft:
		; you get the point, right?
		move.b	#$1D,Obj_Ani_Number(a0)			; use "balancing" animation 3
		move.w	Obj_X(a0),d3
		addq.w	#6,d3
		jsr	(Player_HitFloor_D3).l
		cmpi.w	#$C,d1					; is Sonic REALLY close to the edge?
		blt.w	Sonic_ResetScr				; if yes, branch
		move.b	#$1E,Obj_Ani_Number(a0)			; use "balancing" animation 4
		bset	#0,Obj_Status(a0)
		bra.w	Sonic_ResetScr
; ---------------------------------------------------------------------------
; Offset_0x00B138:
SuperSonic_Balance2:
		cmpi.b	#3,Obj_Player_Next_Tilt(a0)
		bne.s	SuperSonic_Balance3
; Offset_0x00B140:
SuperSonic_BalanceOnObjRight:
		bclr	#0,Obj_Status(a0)
		bra.s	SuperSonic_SetBalanceAnim
; ---------------------------------------------------------------------------
; Offset_0x00B148:
SuperSonic_Balance3:
		cmpi.b	#3,Obj_Player_Tilt(a0)
		bne.s	Sonic_Lookup
; Offset_0x00B150:
SuperSonic_BalanceOnObjLeft:
		bset	#0,Obj_Status(A0)
; Offset_0x00B156:
SuperSonic_SetBalanceAnim:
		move.b	#6,Obj_Ani_Number(a0)
		bra.s	Sonic_ResetScr
; ===========================================================================
; Offset_0x00B15E:
Sonic_Lookup:
		btst	#button_up,(Control_Ports_Logical_Data).w	; is up being pressed?
		beq.s	Offset_0x00B188				; if not, branch
		move.b	#7,Obj_Ani_Number(a0)			; use "looking up" animation
		addq.b	#1,Obj_Look_Up_Down_Time(a0)
		cmpi.b	#$78,Obj_Look_Up_Down_Time(a0)
		bcs.s	Sonic_ResetScr_Part2
		move.b	#$78,Obj_Look_Up_Down_Time(a0)
		cmpi.w	#$C8,(a5)
		beq.s	Sonic_UpdateSpeedOnGround
		addq.w	#2,(a5)
		bra.s	Sonic_UpdateSpeedOnGround
; ---------------------------------------------------------------------------

Offset_0x00B188:
		btst	#button_down,(Control_Ports_Logical_Data).w	; is down being pressed?
		beq.s	Sonic_ResetScr				; if not, branch
		move.b	#8,Obj_Ani_Number(a0)			; use "ducking" animation
		addq.b	#1,Obj_Look_Up_Down_Time(a0)
		cmpi.b	#$78,Obj_Look_Up_Down_Time(a0)
		bcs.s	Sonic_ResetScr_Part2
		move.b	#$78,Obj_Look_Up_Down_Time(a0)
		cmpi.w	#8,(a5)
		beq.s	Sonic_UpdateSpeedOnGround
		subq.w	#2,(a5)
		bra.s	Sonic_UpdateSpeedOnGround
; ===========================================================================
; moves the screen back to its normal position after looking up or down
; Offset_0x00B1B2:
Sonic_ResetScr:
		move.b	#0,Obj_Look_Up_Down_Time(a0)
; Offset_0x00B1B8:
Sonic_ResetScr_Part2:
		cmpi.w	#$60,(a5)				; is screen in its default position?
		beq.s	Sonic_UpdateSpeedOnGround		; if yes, branch
		bcc.s	Offset_0x00B1C2				; depending on the sign of the difference,
		addq.w	#4,(a5)					; either add 2

Offset_0x00B1C2:
		subq.w	#2,(a5)					; or subtract 2

; ---------------------------------------------------------------------------
; Updates Sonic's speed on the ground
; ---------------------------------------------------------------------------
; Offset_0x00B1C4:
Sonic_UpdateSpeedOnGround:
		tst.b	(Super_Sonic_flag).w
		beq.w	Offset_0x00B1D0
		move.w	#$C,d5

Offset_0x00B1D0:
		move.b	(Control_Ports_Logical_Data).w,d0
		andi.b	#button_left_mask+button_right_mask,d0					; is left/right pressed?
		bne.s	Sonic_Traction				; if yes, branch
		move.w	Obj_Inertia(a0),d0
		beq.s	Sonic_Traction
		bmi.s	Sonic_SettleLeft

; Slow down when facing right and not pressing a direction
; Sonic_SettleRight:
		sub.w	d5,d0
		bcc.s	Offset_0x00B1EA
		move.w	#0,d0

Offset_0x00B1EA:
		move.w	d0,Obj_Inertia(a0)
		bra.s	Sonic_Traction
; ---------------------------------------------------------------------------
; Slow down when facing left and not pressing a direction
; Offset_0x00B1F0:
Sonic_SettleLeft:
		add.w	d5,d0
		bcc.s	Offset_0x00B1F8
		move.w	#0,d0

Offset_0x00B1F8:
		move.w	d0,Obj_Inertia(a0)

; Increase or decrease speed on the ground
; Offset_0x00B1FC:
Sonic_Traction:
		move.b	Obj_Angle(a0),d0
		jsr	(CalcSine).l
		muls.w	Obj_Inertia(a0),d1
		asr.l	#8,d1
		move.w	d1,Obj_Speed_X(a0)
		muls.w	Obj_Inertia(a0),d0
		asr.l	#8,d0
		move.w	d0,Obj_Speed_Y(a0)

; Stops Sonic from running through walls that meet the ground
; Offset_0x00B21A:
Sonic_CheckWallsOnGround:
		btst	#6,Obj_Player_Control(a0)
		bne.w	Offset_0x00B2A4
		move.b	Obj_Angle(a0),d0
		addi.b	#$40,d0
		bmi.s	Offset_0x00B2A4
		move.b	#$40,d1					; rotate 90 degrees clockwise
		tst.w	Obj_Inertia(a0)				; is Sonic moving?
		beq.s	Offset_0x00B2A4				; if not, branch
		bmi.s	Offset_0x00B23C				; if Sonic is moving backwards, branch
		neg.w	d1					; otherwise, rotate counter clockwise

Offset_0x00B23C:
		move.b	Obj_Angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	Player_WalkSpeed
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	Offset_0x00B2A4
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	Offset_0x00B2A0
		cmpi.b	#$40,d0
		beq.s	Offset_0x00B286
		cmpi.b	#$80,d0
		beq.s	Offset_0x00B280
		add.w	d1,Obj_Speed_X(a0)
		move.w	#0,Obj_Inertia(a0)
		btst	#0,Obj_Status(a0)
		bne.s	Offset_0x00B27E
		bset	#5,Obj_Status(a0)

Offset_0x00B27E:
		rts
; ---------------------------------------------------------------------------

Offset_0x00B280:
		sub.w	d1,Obj_Speed_Y(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x00B286:
		sub.w	d1,Obj_Speed_X(a0)
		move.w	#0,Obj_Inertia(a0)
		btst	#0,Obj_Status(a0)
		beq.s	Offset_0x00B27E
		bset	#5,Obj_Status(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x00B2A0:
		add.w	d1,Obj_Speed_Y(a0)

Offset_0x00B2A4:
		rts
; End of subroutine Sonic_Move

Offset_0x00B2A6:
		move.w	Obj_Inertia(A0),d0					  ; $001C
		beq.s	Offset_0x00B2AE
		bpl.s	Offset_0x00B2E0
Offset_0x00B2AE:
		bset	#0,Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x00B2C2
		bclr	#5,Obj_Status(A0)					 ; $002A
		move.b	#1,Obj_Ani_Flag(A0)				   ; $0021
Offset_0x00B2C2:
		sub.w	D5,d0
		move.w	D6,d1
		neg.w	D1
		cmp.w	D1,d0
		bgt.s	Offset_0x00B2D4
		add.w	D5,d0
		cmp.w	D1,d0
		ble.s	Offset_0x00B2D4
		move.w	D1,d0
Offset_0x00B2D4:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
		move.b	#0,Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x00B2E0:
		sub.w	D4,d0
		bcc.s	Offset_0x00B2E8
		move.w	#-$80,d0
Offset_0x00B2E8:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
	if FixBugs
		move.b	Obj_Angle(A0),d1				; $0026
		addi.b	#$20,d1
		andi.b	#$C0,d1
	else
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$20,d0
		andi.b	#$C0,d0
	endif
		bne.s	Offset_0x00B32A
		cmpi.w	#$400,d0
		blt.s	Offset_0x00B32A
		move.b	#$D,Obj_Ani_Number(A0)				 ; $0020
		bclr	#0,Obj_Status(A0)					 ; $002A
		move.w	#sfx_Skid,d0				; $0036
		jsr	(PlaySound).l				   ; Offset_0x001176
		cmpi.b	#$C,Obj_Subtype(A0)					; $002C
		bcs.s	Offset_0x00B32A
		move.b	#6,Obj_Routine(A6)					; $0005
		move.b	#$15,Obj_Map_Id(A6)					 ; $0022
Offset_0x00B32A:
		rts
Offset_0x00B32C:
		move.w	Obj_Inertia(A0),d0					  ; $001C
		bmi.s	Offset_0x00B360
		bclr	#0,Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00B346
		bclr	#5,Obj_Status(A0)					 ; $002A
		move.b	#1,Obj_Ani_Flag(A0)				   ; $0021
Offset_0x00B346:
		add.w	D5,d0
		cmp.w	D6,d0
		blt.s	Offset_0x00B354
		sub.w	D5,d0
		cmp.w	D6,d0
		bge.s	Offset_0x00B354
		move.w	D6,d0
Offset_0x00B354:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
		move.b	#0,Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x00B360:
		add.w	D4,d0
		bcc.s	Offset_0x00B368
		move.w	#$80,d0
Offset_0x00B368:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
	if FixBugs
		move.b	Obj_Angle(A0),d1				; $0026
		addi.b	#$20,d1
		andi.b	#$C0,d1
	else
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$20,d0
		andi.b	#$C0,d0
	endif
		bne.s	Offset_0x00B3AA
		cmpi.w	#-$400,d0
		bgt.s	Offset_0x00B3AA
		move.b	#$D,Obj_Ani_Number(A0)				 ; $0020
		bset	#0,Obj_Status(A0)					 ; $002A
		move.w	#sfx_Skid,d0				; $0036
		jsr	(PlaySound).l				   ; Offset_0x001176
		cmpi.b	#$C,Obj_Subtype(A0)					; $002C
		bcs.s	Offset_0x00B3AA
		move.b	#6,Obj_Routine(A6)					; $0005
		move.b	#$15,Obj_Map_Id(A6)					 ; $0022
Offset_0x00B3AA:
		rts
; ---------------------------------------------------------------------------
Sonic_RollSpeed:							   ; Offset_0x00B3AC
		move.w	(A4),d6
		asl.w	#1,d6
		move.w	Acceleration(A4),d5					 ; $0002
		asr.w	#1,d5
		move.w	#$20,d4
		tst.b	Obj_Player_Status(A0)					; $002F
		bmi.w	Offset_0x00B448
		tst.w	Obj_P_Horiz_Ctrl_Lock(A0)				; $0032
		bne.s	Offset_0x00B3E0
		btst	#button_left,(Control_Ports_Logical_Data).w			; $FFFFF602
		beq.s	Offset_0x00B3D4
		bsr.w	Offset_0x00B48A
Offset_0x00B3D4:
		btst	#button_right,(Control_Ports_Logical_Data).w		 ; $FFFFF602
		beq.s	Offset_0x00B3E0
		bsr.w	Offset_0x00B4AE
Offset_0x00B3E0:
		move.w	Obj_Inertia(A0),d0					  ; $001C
		beq.s	Offset_0x00B402
		bmi.s	Offset_0x00B3F6
		sub.w	D5,d0
		bcc.s	Offset_0x00B3F0
		move.w	#0,d0
Offset_0x00B3F0:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
		bra.s	Offset_0x00B402
Offset_0x00B3F6:
		add.w	D5,d0
		bcc.s	Offset_0x00B3FE
		move.w	#0,d0
Offset_0x00B3FE:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
Offset_0x00B402:
		tst.w	Obj_Inertia(A0)				  ; $001C
		bne.s	Offset_0x00B448
		tst.b	Obj_Player_Spdsh_Flag(A0)				; $003D
		bne.s	Offset_0x00B436
		bclr	#2,Obj_Status(A0)					 ; $002A
		move.b	Obj_Height_2(A0),d0					 ; $001E
		move.b	Obj_Height_3(A0),Obj_Height_2(A0)		 ; $001E, $0044
		move.b	Obj_Width_3(A0),Obj_Width_2(A0)			 ; $001F, $0045
		move.b	#5,Obj_Ani_Number(A0)				 ; $0020
		sub.b	Obj_Height_3(A0),d0					 ; $0044
		ext.w	D0
		add.w	D0,Obj_Y(A0)					; $0014
		bra.s	Offset_0x00B448
Offset_0x00B436:
		move.w	#$400,Obj_Inertia(A0)				  ; $001C
		btst	#0,Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x00B448
		neg.w	Obj_Inertia(A0)				  ; $001C
Offset_0x00B448:
		cmpi.w	#$60,(A5)
		beq.s	Offset_0x00B454
		bcc.s	Offset_0x00B452
		addq.w	#4,(A5)
Offset_0x00B452:
		subq.w	#2,(A5)
Offset_0x00B454:
		move.b	Obj_Angle(A0),d0				; $0026
		jsr	(CalcSine).l					 ; Offset_0x001B20
		muls.w	Obj_Inertia(A0),d0					  ; $001C
		asr.l	#8,d0
		move.w	D0,Obj_Speed_Y(A0)					  ; $001A
		muls.w	Obj_Inertia(A0),d1					  ; $001C
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	Offset_0x00B478
		move.w	#$1000,d1
Offset_0x00B478:
		cmpi.w	#-$1000,d1
		bge.s	Offset_0x00B482
		move.w	#-$1000,d1
Offset_0x00B482:
		move.w	D1,Obj_Speed_X(A0)					  ; $0018
		bra.w	Sonic_CheckWallsOnGround
Offset_0x00B48A:
		move.w	Obj_Inertia(A0),d0					  ; $001C
		beq.s	Offset_0x00B492
		bpl.s	Offset_0x00B4A0
Offset_0x00B492:
		bset	#0,Obj_Status(A0)					 ; $002A
		move.b	#2,Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x00B4A0:
		sub.w	D4,d0
		bcc.s	Offset_0x00B4A8
		move.w	#-$80,d0
Offset_0x00B4A8:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
		rts
Offset_0x00B4AE:
		move.w	Obj_Inertia(A0),d0					  ; $001C
		bmi.s	Offset_0x00B4C2
		bclr	#0,Obj_Status(A0)					 ; $002A
		move.b	#2,Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x00B4C2:
		add.w	D4,d0
		bcc.s	Offset_0x00B4CA
		move.w	#$80,d0
Offset_0x00B4CA:
		move.w	D0,Obj_Inertia(A0)					  ; $001C
		rts

; ---------------------------------------------------------------------------
; Subroutine for moving Sonic left or right when he's in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B4D0:
Sonic_ChgJumpDir:
		move.w	(a4),d6
		move.w	Acceleration(a4),d5
		asl.w	#1,d5
		btst	#4,Obj_Status(a0)			; did Sonic jump from rolling?
		bne.s	Sonic_Jump_ResetScr			; if yes, branch to skip bidair control
		move.w	Obj_Speed_X(a0),d0
		btst	#button_left,(Control_Ports_Logical_Data).w	; is left being held?
		beq.s	.jumpRight				; if not, branch

		bset	#0,Obj_Status(a0)
		sub.w	d5,d0					; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0					; compare new speed with top speed
		bgt.s	.jumpRight				; if new speed is less than the maximum, branch
		add.w	d5,d0					; remove this frame's acceleration change
		cmp.w	d1,d0					; compare speed with top speed
		ble.s	.jumpRight				; if speed was already greater than the maximum, branch
		move.w	d1,d0					; limit speed in air going left, even if Sonic was already going faster (speed limit/cap)
; Offset_0x00B504:
.jumpRight:
		btst	#button_right,(Control_Ports_Logical_Data).w	; is right being held?
		beq.s	Sonic_JumpMove				; if not, branch
		bclr	#0,Obj_Status(a0)
		add.w	d5,d0					; add acceleration to the right
		cmp.w	d6,d0					; compare new speed with top speed
		blt.s	Sonic_JumpMove				; if new speed is less than the maximum, branch
		sub.w	d5,d0					; remove this frame's acceleration change
		cmp.w	d6,d0					; compare speed with top speed
		bge.s	Sonic_JumpMove				; if speed was already greater than the maximum, branch
		move.w	d6,d0					; limit speed in air going right, even if Sonic was already going faster (speed limit/cap)
; Offset_0x00B520:
Sonic_JumpMove:
		move.w	d0,Obj_Speed_X(a0)
; Offset_0x00B524:
Sonic_Jump_ResetScr:
		cmpi.w	#$60,(a5)				; is screen in its default position?
		beq.s	Sonic_JumpPeakDecelerate		; if yes, branch
		bcc.s	Offset_0x00B52E				; depending on the sign of the difference,
		addq.w	#4,(a5)					; either add 2

Offset_0x00B52E:
		subq.w	#2,(a5)					; or subtract 2
; Offset_0x00B530:
Sonic_JumpPeakDecelerate:
		cmpi.w	#-$400,Obj_Speed_Y(a0)			; is Sonic moving faster than -$400 upwards?
		bcs.s	Offset_0x00B55E				; if yes, branch
		move.w	Obj_Speed_X(a0),d0
		move.w	d0,d1
		asr.w	#5,d1					; d1 = x_velocity / 32
		beq.s	Offset_0x00B55E				; return if d1 is 0
		bmi.s	Sonic_JumpPeakDecelerateLeft		; branch if moving left

; Sonic_JumpPeakDecelerateRight:
		sub.w	d1,d0					; reduce x velocity by d1
		bcc.s	Offset_0x00B54C
		move.w	#0,d0

Offset_0x00B54C:
		move.w	d0,Obj_Speed_X(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B552:
Sonic_JumpPeakDecelerateLeft:
		sub.w	d1,d0					; reduce x velocity by d1
		bcs.s	Offset_0x00B55A
		move.w	#0,d0

Offset_0x00B55A:
		move.w	d0,Obj_Speed_X(a0)

Offset_0x00B55E:
		rts
; End of subroutine Sonic_ChgJumpDir

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to prevent Sonic from leaving the boundaries of a level
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B562:
Sonic_LevelBoundaries:
		move.l	Obj_X(a0),d1
		move.w	Obj_Speed_X(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Sonic_Level_Limits_Min_X).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0					; has Sonic touched the left boundary?
		bhi.s	Sonic_Boundary_Sides			; if yes, branch
		move.w	(Sonic_Level_Limits_Max_X).w,d0
		addi.w	#$128,d0				; screen width - Sonic's width_pixels
		cmp.w	d1,d0					; has Sonic touched the right boundary?
		bls.s	Sonic_Boundary_Sides			; if yes, branch
; Offset_0x00B588:
Sonic_Boundary_CheckBottom:
		move.w	(Sonic_Level_Limits_Max_Y).w,d0
		addi.w	#224,d0
		cmp.w	Obj_Y(a0),d0				; has Sonic touched the bottom boundary?
		blt.s	Sonic_Boundary_Bottom			; if yes, branch
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B598:
Sonic_Boundary_Bottom:
		jmp	(Kill_Player).l
; ===========================================================================
; Offset_0x00B59E:
Sonic_Boundary_Sides:
		move.w	d0,Obj_X(a0)
		move.w	#0,Obj_Sub_X(a0)
		move.w	#0,Obj_Speed_X(a0)
		move.w	#0,Obj_Inertia(a0)
		bra.s	Sonic_Boundary_CheckBottom
; End of function Sonic_LevelBoundaries

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to start rolling when he's moving
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B5B6:
Sonic_Roll:
		tst.b	Obj_Player_Status(a0)
		bmi.s	Sonic_NoRoll
		move.w	Obj_Inertia(a0),d0
		bpl.s	Offset_0x00B5C4
		neg.w	d0

Offset_0x00B5C4:
		cmpi.w	#$80,d0					; is Sonic moving at $80 speed or faster?
		bcs.s	Sonic_NoRoll				; if not, branch
		move.b	(Control_Ports_Logical_Data).w,d0
		andi.b	#button_left_mask+button_right_mask,d0	; is left/right being pressed?
		bne.s	Sonic_NoRoll				; if yes, branch
		btst	#button_down,(Control_Ports_Logical_Data).w	; is down being pressed?
		bne.s	Sonic_ChkRoll				; if yes, branch
; Offset_0x00B5DC:
Sonic_NoRoll:
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B5DE:
Sonic_ChkRoll:
		btst	#2,Obj_Status(a0)			; is Sonic already rolling?
		beq.s	Sonic_DoRoll				; if not, branch
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B5E8:
Sonic_DoRoll:
		bset	#2,Obj_Status(a0)
		move.b	#$E,Obj_Height_2(a0)
		move.b	#7,Obj_Width_2(a0)
		move.b	#2,Obj_Ani_Number(a0)			; use "rolling" animation
		addq.w	#5,Obj_Y(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l				; play rolling sound
		tst.w	Obj_Inertia(a0)
		bne.s	Offset_0x00B61A
		move.w	#$200,Obj_Inertia(a0)

Offset_0x00B61A:
		rts
; End of function Sonic_Roll

; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B61C:
Sonic_Jump:
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask,d0	; is A/B/C pressed?
		beq.w	Offset_0x00B6F0				; if not, branch
		move.b	(Control_Ports_Logical_Data).w,d0
		andi.b	#button_up_mask+button_left_mask+button_right_mask,d0	; is up, left, or right being pressed?
		cmpi.b	#button_up_mask,d0	; invalidate the previous check minus up
		bne.s	Offset_0x00B63C	; if not, branch
		move.w	#-1,(Dropdash_flag).w

Offset_0x00B63C:
		moveq	#0,d0
		move.b	Obj_Angle(a0),d0
		addi.b	#$80,d0
		movem.l	a4-a6,-(sp)
		bsr.w	CalcRoomOverHead
		movem.l	(sp)+,a4-a6
		cmpi.w	#6,d1					; does Sonic have room to jump?
		blt.w	Offset_0x00B6F0				; if not, branch
		move.w	#$680,d2
		tst.b	(Super_Sonic_flag).w
		beq.s	Offset_0x00B668
		move.w	#$800,d2				; set higher jump speed if super

Offset_0x00B668:
		btst	#6,Obj_Status(a0)
		beq.s	Offset_0x00B674
		move.w	#$380,d2				; set lower jump speed if under

Offset_0x00B674:
		moveq	#0,d0
		move.b	Obj_Angle(a0),d0
		subi.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,Obj_Speed_X(a0)			; make Sonic jump (in X... this adds nothing on level ground)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,Obj_Speed_Y(a0)			; make Sonic jump (in Y)
		bset	#1,Obj_Status(a0)
		bclr	#5,Obj_Status(a0)
		addq.l	#4,sp
		move.b	#1,Obj_Player_Jump(a0)
		clr.b	Obj_Player_St_Convex(a0)
		move.w	#sfx_Jump,d0
		jsr	(PlaySound).l				; play jumping sound
		move.b	Obj_Height_3(a0),Obj_Height_2(a0)
		move.b	Obj_Width_3(a0),Obj_Width_2(a0)
		btst	#2,Obj_Status(a0)
		bne.s	Sonic_RollJump
		move.b	#$E,Obj_Height_2(a0)
		move.b	#7,Obj_Width_2(a0)
		move.b	#2,Obj_Ani_Number(a0)			; use "jumping" animation
		bset	#2,Obj_Status(a0)
		move.b	Obj_Height_2(a0),d0
		sub.b	Obj_Height_3(a0),d0
		ext.w	d0
		sub.w	d0,Obj_Y(a0)

Offset_0x00B6F0:
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B6F2:
Sonic_RollJump:
		bset	#4,Obj_Status(a0)			; set the rolling+jumping flag
		rts
; End of function Sonic_Jump

; ---------------------------------------------------------------------------
; Subroutine letting Sonic control the height of the jump
; when the jump button is released
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B6FA:
Sonic_JumpHeight:
		tst.b	Obj_Player_Jump(A0)			; is Sonic jumping?
		beq.s	Sonic_UpVelCap				; if not, branch

		move.w	#-$400,d1
		btst	#6,Obj_Status(a0)			; is Sonic underwater?
		beq.s	Offset_0x00B710				; if not, branch
		move.w	#-$200,d1

Offset_0x00B710:
		cmp.w	Obj_Speed_Y(a0),d1			; if Sonic is not going up faster than d1, branch
		ble.w	Sonic_ThrowRings			; this is altered from Sonic 2 to prevent the Super Sonic transformation, change the branch to Sonic_CheckGoSuper to re-enable him

		move.b	(Control_Ports_Logical_Data).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask,d0	; is A/B/C pressed?
		bne.s	Offset_0x00B726				; if yes, branch
		move.w	d1,Obj_Speed_Y(a0)			; immediately reduce Sonic's upward speed to d1

Offset_0x00B726:
		tst.b	Obj_Speed_Y(a0)				; is Sonic exactly at the height of his jump?
		beq.s	Sonic_CheckGoSuper			; if yes, test for turning into Super Sonic
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B72E:
Sonic_UpVelCap:
		tst.b	Obj_Player_Spdsh_Flag(a0)		; is Sonic charging a spindash or in a rolling-only area?
		bne.s	Offset_0x00B742				; if yes, branch
		cmpi.w	#-$FC0,Obj_Speed_Y(a0)			; is Sonic moving up really fast?
		bge.s	Offset_0x00B742				; if not, branch
		move.w	#-$FC0,Obj_Speed_Y(a0)			; cap upward speed

Offset_0x00B742:
		rts
; End of subroutine Sonic_JumpHeight

; ---------------------------------------------------------------------------
; Subroutine that transforms Sonic into Super Sonic if he has enough rings and emeralds
; Effectively unused due to a change in code above
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00B744:
Sonic_CheckGoSuper:
		tst.b	(Super_Sonic_flag).w
		bne.s	Offset_0x00B7B6
		cmpi.b	#7,(Emeralds_Count).w
		bne.s	Offset_0x00B7B6
		cmpi.w	#50,(Ring_count).w
		bcs.s	Offset_0x00B7B6
		tst.b	(Update_HUD_timer).w
		beq.s	Offset_0x00B7B6
		move.b	#1,(Super_Sonic_Palette_Status).w
		move.b	#$F,(Super_Sonic_Palette_Timer).w
		move.b	#1,(Super_Sonic_flag).w
		move.b	#$81,Obj_Player_Control(a0)
		move.b	#$1F,Obj_Ani_Number(a0)
		move.l	#Obj_Super_Sonic_Stars,(Obj_Super_Sonic_Stars_RAM).w
		move.w	#$A00,(a4)
		move.w	#$30,Acceleration(a4)
		move.w	#$100,Deceleration(a4)
		move.b	#0,Obj_P_Invcbility_Time(a0)
		bset	#1,Obj_Player_Status(a0)
		move.w	#signextendB(sfx_SuperTransform),d0
		jsr	(PlaySound).l
		move.w	#mus_SuperSonicUnk,d0
		jmp	(PlaySound).l

Offset_0x00B7B6:
		rts
; End of function Sonic_CheckGoSuper

; ===========================================================================
; ---------------------------------------------------------------------------
; An unused ability that lets Sonic shoot rings while jumping; the rings were
; likely meant to be a placeholder until proper graphics were added, which they
; never were as this was completely scrapped in the final.
;
; Judging from Sonic Origins' concept art of the many shield types, this might've
; been the "attack" ability the Flame Shield (NOT "Fire"!) was intended to have.
;
; However, given that Mecha Sonic throws rings in Knuckles' final boss, maybe it
; really was an actual ring throw ability... yeah, it's complicated.
; Offset_0x00B7B8:
Sonic_ThrowRings:
		bra.w	Offset_0x00B8B6				; immediately skip over all the code
; ---------------------------------------------------------------------------
		btst	#2,Obj_Status(a0)			; is Sonic rolling?
		beq.w	Offset_0x00B8B6				; if not, branch
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_C_mask,d0		; has C been pressed?
		beq.s	.notRolling				; if not, branch
		move.w	Obj_Speed_X(a0),d2
		bsr.w	AllocateObject
		bne.w	.skip
		bsr.w	Obj_ThrownRing				; load a ring firing right
		move.w	#$800,Obj_Speed_X(a1)
		move.w	#0,Obj_Speed_Y(a1)
		add.w	d2,Obj_Speed_X(a1)
		bsr.w	AllocateObject
		bne.w	.skip
		bsr.w	Obj_ThrownRing				; load a ring firing left
		move.w	#-$800,Obj_Speed_X(a1)
		move.w	#0,Obj_Speed_Y(a1)
		add.w	d2,Obj_Speed_X(a1)
; Offset_0x00B80C:
.skip:
		btst	#2,Obj_Status(a0)			; is Sonic rolling?
		beq.s	.notRolling				; if not, branch
		bclr	#2,Obj_Status(a0)			; clear Sonic's roll status
		; and reset Sonic's size and animation
		move.b	Obj_Height_2(a0),d0
		move.b	Obj_Height_3(a0),Obj_Height_2(a0)
		move.b	Obj_Width_3(a0),Obj_Width_2(a0)
		move.b	#0,Obj_Ani_Number(a0)
		sub.b	Obj_Height_3(a0),d0
		ext.w	d0
		add.w	d0,Obj_Y(a0)
; Offset_0x00B83A:
.notRolling:
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_B_mask,d0			; has B been pressed?
		beq.s	Offset_0x00B8B6				; if not, branch
		move.w	Obj_Speed_X(a0),d2
		bsr.w	AllocateObject
		bne.w	Offset_0x00B870
		bsr.w	Obj_ThrownRing				; load only one ring facing Sonic's direction
		move.w	#$800,Obj_Speed_X(a1)
		btst	#0,Obj_Status(a0)
		beq.s	Offset_0x00B866
		neg.w	Obj_Speed_X(a1)

Offset_0x00B866:
		move.w	#0,Obj_Speed_Y(a1)
		add.w	d2,Obj_Speed_X(a1)

Offset_0x00B870:
		btst	#2,Obj_Status(a0)			; is Sonic rolling?
		beq.s	.notRolling2				; if not, branch
		bclr	#2,Obj_Status(a0)			; clear Sonic's roll status
		; and reset Sonic's size and animation
		move.b	Obj_Height_2(a0),d0
		move.b	Obj_Height_3(a0),Obj_Height_2(a0)
		move.b	Obj_Width_3(a0),Obj_Width_2(a0)
		move.b	#0,Obj_Ani_Number(a0)
		sub.b	Obj_Height_3(a0),d0
		ext.w	d0
		add.w	d0,Obj_Y(a0)
; Offset_0x00B89E:
.notRolling2:
		; strangely, only the single ring fire clears Sonic's vertical momentum
		move.w	#0,Obj_Speed_Y(a0)
		move.w	#$200,d0
		btst	#0,Obj_Status(a0)
		bne.s	Offset_0x00B8B2
		neg.w	d0

Offset_0x00B8B2:
		add.w	d0,Obj_Speed_X(A0)

Offset_0x00B8B6:
		rts
; End of subroutine Sonic_ThrowRings

; ---------------------------------------------------------------------------
; An early version of what ultimately became Sonic's Hyper Dash ability in
; Sonic 3 & Knuckles; judging from Origins' concept art again, this was the
; original double jump ability of the Lightning Shield.
; Offset_0x00B8B8:
Sonic_HyperDash:
		tst.w	(Dropdash_flag).w
		bne.w	Offset_0x00B952
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_A_mask,d0
		beq.w	Offset_0x00B952
		move.b	(Control_Ports_Logical_Data).w,d0
		andi.w	#button_up_mask+button_down_mask+button_left_mask+button_right_mask,d0
		beq.s	.noInput
		lsl.w	#2,d0
		lea	Sonic_HyperDash_Velocities(pc,d0.w),a1
		move.w	(a1)+,d0
		move.w	d0,Obj_Speed_X(a0)
		move.w	d0,Obj_Inertia(a0)
		move.w	(a1)+,d0
		move.w	d0,Obj_Speed_Y(a0)
		lea	(Camera_X_Scroll_Delay).w,a1
		cmpa.w	#Obj_Player_One,a0
		beq.s	.notPlayerTwo
		lea	(Camera_X_Scroll_Delay_2P).w,a1
; Offset_0x00B8FA:
.notPlayerTwo:
		move.w	d0,(a1)
		bsr.w	ResetPlayerPositionArray
		move.w	#1,(Dropdash_flag).w
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B912:
.noInput:
		; if there's no directional input, we just dash forward
		move.w	#$800,d0
		btst	#0,Obj_Status(a0)
		beq.s	.applySpeeds
		neg.w	d0
; Offset_0x00B920:
.applySpeeds:
		move.w	d0,Obj_Speed_X(a0)
		move.w	d0,Obj_Inertia(a0)
		move.w	#0,Obj_Speed_Y(a0)
		lea	(Camera_X_Scroll_Delay).w,a1
		cmpa.w	#Obj_Player_One,a0
		beq.s	.notPlayerTwoAgain
		lea	(Camera_X_Scroll_Delay_2P).w,a1
; Offset_0x00B93C:
.notPlayerTwoAgain:
		move.w	d0,(a1)
		bsr.w	ResetPlayerPositionArray
		move.w	#1,(Dropdash_flag).w
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l

Offset_0x00B952:
		rts
; ===========================================================================
; Offset_0x00B954:
Sonic_HyperDash_Velocities:
		dc.w	$0000, $0000, $0000, $F800, $0000, $0800, $0000, $0000
		dc.w	$F800, $0000, $F800, $F800, $F800, $0800, $0000, $0000
		dc.w	$0800, $0000, $0800, $F800, $0800, $0800, $0000, $0000
		dc.w	$0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Thrown Ring
; ---------------------------------------------------------------------------
; Offset_0x00B994:
Obj_ThrownRing:
		move.l	#ThrownRing_LoadIndex,(a1)
		move.w	Obj_X(a0),Obj_X(a1)
		move.w	Obj_Y(a0),Obj_Y(a1)
		move.l	#Rings_Mappings,Obj_Map(a1)
		move.w	#$26BC,Obj_Art_VRAM(a1)
		move.b	#$84,Obj_Flags(a1)
		move.w	#$180,Obj_Priority(a1)
		move.b	#8,Obj_Width(a1)
		rts
; ---------------------------------------------------------------------------
; Offset_0x00B9C8:
ThrownRing_LoadIndex:
		moveq	#0,d0
		move.b	Obj_Routine(a0),d0
		move.w	ThrownRing_Index(pc,d0.w),d1
		jmp	ThrownRing_Index(pc,d1.w)
; ===========================================================================
; Offset_0x00B9D6:
ThrownRing_Index:
		dc.w ThrownRing_Init-ThrownRing_Index
		dc.w ThrownRing_Main-ThrownRing_Index
; ===========================================================================
; Offset_0x00B9DA:
ThrownRing_Init:
		addq.b	#2,Obj_Routine(a0)
		move.b	#2,Obj_Ani_Number(a0)
		move.b	#8,Obj_Height_2(a0)
		move.b	#8,Obj_Width_2(a0)
		bset	#1,Obj_Player_Status(a0)
; ---------------------------------------------------------------------------
; Offset_0x00B9F6:
ThrownRing_Main:
		movea.l	a0,a2
		jsr	(Touch_Response).l
		cmpi.b	#2,Obj_Routine(a0)
		beq.s	Offset_0x00BA10
	if 0
		; unknown removed code
	else
		nop
		nop
		nop
		nop
		nop
	endif

Offset_0x00BA10:
		cmpi.b	#2,Obj_Ani_Number(a0)
		beq.s	Offset_0x00BA22
	if 0
		; unknown removed code
	else
		nop
		nop
		nop
		nop
		nop
	endif

Offset_0x00BA22:
		move.b	(Vint_runcount+3).w,d0
		andi.w	#3,d0
		bne.s	Offset_0x00BA36
		addq.b	#1,Obj_Map_Id(a0)
		andi.b	#3,Obj_Map_Id(a0)

Offset_0x00BA36:
		bsr.w	SpeedToPos
		tst.b	Obj_Flags(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite
; ===========================================================================
; Continue with Sonic's code...
; ---------------------------------------------------------------------------
; Subroutine doing the extra logic for Super Sonic
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00BA46:
Sonic_Super:
		tst.b	(Super_Sonic_flag).w
		beq.w	Offset_0x00BAD8
		tst.b	(Update_HUD_timer).w
		beq.s	Sonic_RevertToNormal
		subq.w	#1,(Super_Sonic_Frame_Count).w
		bpl.w	Offset_0x00BAD8		; this should be a 'bhi' as it actually counts 61 frames instead of 60
		move.w	#60,(Super_Sonic_Frame_Count).w	; alternatively, this could also have a -1 if you don't want to use a bhi
		tst.w	(Ring_count).w
		beq.s	Sonic_RevertToNormal
		ori.b	#1,(Update_HUD_rings).w
		cmpi.w	#1,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#10,(Ring_count).w
		beq.s	.resetHUD
		cmpi.w	#100,(Ring_count).w
		bne.s	.updateHUD
; Offset_0x00BA86:
.resetHUD:
		ori.b	#$80,(Update_HUD_rings).w
; Offset_0x00BA8C:
.updateHUD:
		subq.w	#1,(Ring_count).w
		bne.s	Offset_0x00BAD8
; Offset_0x00BA92:
Sonic_RevertToNormal:
		move.b	#2,(Super_Sonic_Palette_Status).w
		move.w	#$28,(Super_Sonic_Palette_Frame).w
		move.b	#0,(Super_Sonic_flag).w
		move.b	#1,Obj_Ani_Flag(a0)
		move.b	#1,Obj_P_Invcbility_Time(a0)
		move.w	#$600,(a4)
		move.w	#$C,Acceleration(a4)
		move.w	#$80,Deceleration(a4)
		btst	#6,Obj_Status(a0)
		beq.s	Offset_0x00BAD8
		move.w	#$300,(a4)
		move.w	#6,Acceleration(a4)
		move.w	#$40,Deceleration(a4)

Offset_0x00BAD8:
		rts
; End of subroutine Sonic_Super

; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00BADA: Sonic_Spindash:
Sonic_CheckSpindash:
		tst.b	Obj_Player_Spdsh_Flag(a0)
		bne.s	Sonic_UpdateSpindash
		cmpi.b	#8,Obj_Ani_Number(a0)
		bne.s	Offset_0x00BB28
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask,d0
		beq.w	Offset_0x00BB28
		move.b	#9,Obj_Ani_Number(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l
		addq.l	#4,sp
		move.b	#1,Obj_Player_Spdsh_Flag(a0)
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)
		cmpi.b	#$C,Obj_Subtype(a0)			; if he's drowning, branch to not make dust
		bcs.s	Offset_0x00BB20
		move.b	#2,Obj_Ani_Number(a6)

Offset_0x00BB20:
		bsr.w	Sonic_LevelBoundaries
		bsr.w	Player_AnglePos

Offset_0x00BB28:
		rts
; End of subroutine Sonic_CheckSpindash

; ---------------------------------------------------------------------------
; Subrouting to update an already-charging spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00BB2A:
Sonic_UpdateSpindash:
		move.b	(Control_Ports_Logical_Data).w,d0
		btst	#button_down,d0
		bne.w	Sonic_ChargingSpindash
		move.b	#$E,Obj_Height_2(a0)
		move.b	#7,Obj_Width_2(a0)
		move.b	#2,Obj_Ani_Number(a0)
		addq.w	#5,Obj_Y(a0)
		move.b	#0,Obj_Player_Spdsh_Flag(a0)
		moveq	#0,d0
		move.b	Obj_Player_Spdsh_Cnt(a0),d0
		add.w	d0,d0
		move.w	Sonic_Spindash_Speed(pc,d0.w),Obj_Inertia(a0)
		tst.b	(Super_Sonic_flag).w
		beq.s	Offset_0x00BB6C
		move.w	Super_Sonic_Spindash_Speed(pc,d0.w),Obj_Inertia(a0)

Offset_0x00BB6C:
		move.w	Obj_Inertia(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0			; this is basically useless as the unused bits are never written to anyway
		neg.w	d0
		addi.w	#$2000,d0
		lea	(Camera_X_Scroll_Delay).w,a1
		cmpa.w	#Obj_Player_One,a0
		beq.s	Offset_0x00BB8E
		lea	(Camera_X_Scroll_Delay_2P).w,a1

Offset_0x00BB8E:
		move.w	d0,(a1)
		btst	#0,Obj_Status(a0)
		beq.s	Offset_0x00BB9C
		neg.w	Obj_Inertia(a0)

Offset_0x00BB9C:
		bset	#2,Obj_Status(a0)
		move.b	#0,Obj_Ani_Number(a6)
		moveq	#sfx_Roll,d0
		jsr	(PlaySound).l
		bra.s	Offset_0x00BC1E
; ===========================================================================
; Offset_0x00BBB2:
Sonic_Spindash_Speed:
		dc.w	$800, $880, $900, $980, $A00, $A80, $B00, $B80
		dc.w	$C00

; Offset_0x00BBC4:
Super_Sonic_Spindash_Speed:
		dc.w	$B00, $B80, $C00, $C80, $D00, $D80, $E00, $E80
		dc.w	$F00
; ===========================================================================
; Offset_0x00BBD6:
Sonic_ChargingSpindash:
		tst.w	Obj_Player_Spdsh_Cnt(a0)
		beq.s	Offset_0x00BBEE
		move.w	Obj_Player_Spdsh_Cnt(a0),d0
		lsr.w	#5,d0
		sub.w	d0,Obj_Player_Spdsh_Cnt(a0)
		bcc.s	Offset_0x00BBEE
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)

Offset_0x00BBEE:
		move.b	(Control_Ports_Logical_Data+1).w,d0
		andi.b	#button_A_mask+button_B_mask+button_C_mask,d0
		beq.w	Offset_0x00BC1E
		move.w	#$900,Obj_Ani_Number(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l
		addi.w	#$200,Obj_Player_Spdsh_Cnt(a0)
		cmpi.w	#$800,Obj_Player_Spdsh_Cnt(a0)
		bcs.s	Offset_0x00BC1E
		move.w	#$800,Obj_Player_Spdsh_Cnt(a0)

Offset_0x00BC1E:
		addq.l	#4,sp
		cmpi.w	#$60,(a5)
		beq.s	Offset_0x00BC2C
		bcc.s	Offset_0x00BC2A
		addq.w	#4,(a5)

Offset_0x00BC2A:
		subq.w	#2,(a5)

Offset_0x00BC2C:
		bsr.w	Sonic_LevelBoundaries
		bsr.w	Player_AnglePos
		rts
; End of function Sonic_UpdateSpindash

; ---------------------------------------------------------------------------
Sonic_SlopeResist:							 ; Offset_0x00BC36
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	Offset_0x00BC6A
		move.b	Obj_Angle(A0),d0				; $0026
		jsr	(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	Obj_Inertia(A0)				  ; $001C
		beq.s	Offset_0x00BC6C
		bmi.s	Offset_0x00BC66
		tst.w	D0
		beq.s	Offset_0x00BC64
		add.w	D0,Obj_Inertia(A0)					  ; $001C
Offset_0x00BC64:
		rts
Offset_0x00BC66:
		add.w	D0,Obj_Inertia(A0)					  ; $001C
Offset_0x00BC6A:
		rts
Offset_0x00BC6C:
		move.w	D0,d1
		bpl.s	Offset_0x00BC72
		neg.w	D1
Offset_0x00BC72:
		cmpi.w	#$D,d1
		bcs.s	Offset_0x00BC6A
		add.w	D0,Obj_Inertia(A0)					  ; $001C
		rts
; ---------------------------------------------------------------------------
Sonic_RollRepel:							   ; Offset_0x00BC7E
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	Offset_0x00BCB8
		move.b	Obj_Angle(A0),d0				; $0026
		jsr	(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	Obj_Inertia(A0)				  ; $001C
		bmi.s	Offset_0x00BCAE
		tst.w	D0
		bpl.s	Offset_0x00BCA8
		asr.l	#2,d0
Offset_0x00BCA8:
		add.w	D0,Obj_Inertia(A0)					  ; $001C
		rts
Offset_0x00BCAE:
		tst.w	D0
		bmi.s	Offset_0x00BCB4
		asr.l	#2,d0
Offset_0x00BCB4:
		add.w	D0,Obj_Inertia(A0)					  ; $001C
Offset_0x00BCB8:
		rts
; ---------------------------------------------------------------------------
Sonic_SlopeRepel:							  ; Offset_0x00BCBA
		nop
		tst.b	Obj_Player_St_Convex(A0)				 ; $003C
		bne.s	Offset_0x00BCFE
		tst.w	Obj_P_Horiz_Ctrl_Lock(A0)				; $0032
		bne.s	Offset_0x00BD16
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$18,d0
		cmpi.b	#$30,d0
		bcs.s	Offset_0x00BCFE
		move.w	Obj_Inertia(A0),d0					  ; $001C
		bpl.s	Offset_0x00BCDE
		neg.w	D0
Offset_0x00BCDE:
		cmpi.w	#$280,d0
		bcc.s	Offset_0x00BCFE
		move.w	#$1E,Obj_P_Horiz_Ctrl_Lock(A0)		; $0032
		move.b	Obj_Angle(A0),d0				; $0026
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		bcs.s	Offset_0x00BD00
		bset	#1,Obj_Status(A0)					 ; $002A
Offset_0x00BCFE:
		rts
Offset_0x00BD00:
		cmpi.b	#$30,d0
		bcs.s	Offset_0x00BD0E
		addi.w	#$80,Obj_Inertia(A0)				  ; $001C
		rts
Offset_0x00BD0E:
		subi.w	#$80,Obj_Inertia(A0)				  ; $001C
		rts
Offset_0x00BD16:
		subq.w	#1,Obj_P_Horiz_Ctrl_Lock(A0)		  ; $0032
		rts
; ---------------------------------------------------------------------------
Sonic_JumpAngle:							   ; Offset_0x00BD1C
		move.b	Obj_Angle(A0),d0				; $0026
		beq.s	Offset_0x00BD36
		bpl.s	Offset_0x00BD2C
		addq.b	#2,d0
		bcc.s	Offset_0x00BD2A
		moveq	#0,d0
Offset_0x00BD2A:
		bra.s	Offset_0x00BD32
Offset_0x00BD2C:
		subq.b	#2,d0
		bcc.s	Offset_0x00BD32
		moveq	#0,d0
Offset_0x00BD32:
		move.b	D0,Obj_Angle(A0)				; $0026
Offset_0x00BD36:
		move.b	Obj_Flip_Angle(A0),d0				   ; $0027
		beq.s	Offset_0x00BD7A
		tst.w	Obj_Inertia(A0)				  ; $001C
		bmi.s	Offset_0x00BD5A
Offset_0x00BD42:
		move.b	Obj_Player_Flip_Speed(A0),d1			; $0031
		add.b	D1,d0
		bcc.s	Offset_0x00BD58
		subq.b	#1,Obj_P_Flips_Remaining(A0)		  ; $0030
		bcc.s	Offset_0x00BD58
		move.b	#0,Obj_P_Flips_Remaining(A0)		  ; $0030
		moveq	#0,d0
Offset_0x00BD58:
		bra.s	Offset_0x00BD76
Offset_0x00BD5A:
		tst.b	Obj_Player_Flip_Flag(A0)				 ; $002D
		bne.s	Offset_0x00BD42
		move.b	Obj_Player_Flip_Speed(A0),d1			; $0031
		sub.b	D1,d0
		bcc.s	Offset_0x00BD76
		subq.b	#1,Obj_P_Flips_Remaining(A0)		  ; $0030
		bcc.s	Offset_0x00BD76
		move.b	#0,Obj_P_Flips_Remaining(A0)		  ; $0030
		moveq	#0,d0
Offset_0x00BD76:
		move.b	D0,Obj_Flip_Angle(A0)				   ; $0027
Offset_0x00BD7A:
		rts
; ---------------------------------------------------------------------------
Sonic_Floor:						   ; Offset_0x00BD7C
		move.l	(Primary_Collision_Ptr).w,(Current_Collision_Ptr).w ; $FFFFF7B4, $FFFFF796
		cmpi.b	#$C,Obj_Player_Top_Solid(A0)		   ; $0046
		beq.s	Offset_0x00BD90
		move.l	(Secondary_Collision_Ptr).w,(Current_Collision_Ptr).w ; $FFFFF7B8, $FFFFF796
Offset_0x00BD90:
		move.b	Obj_Player_LRB_Solid(A0),d5			 ; $0047
		move.w	Obj_Speed_X(A0),d1					  ; $0018
		move.w	Obj_Speed_Y(A0),d2					  ; $001A
		jsr	(CalcAngle).l					; Offset_0x001DB8
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Offset_0x00BE5A
		cmpi.b	#$80,d0
		beq.w	Offset_0x00BEB4
		cmpi.b	#$C0,d0
		beq.w	Offset_0x00BF10
		bsr.w	Player_HitWall				 ; Offset_0x00A0BC
		tst.w	D1
		bpl.s	Offset_0x00BDD4
		sub.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
Offset_0x00BDD4:
		bsr.w	Offset_0x009EC6
		tst.w	D1
		bpl.s	Offset_0x00BDE6
		add.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
Offset_0x00BDE6:
		bsr.w	Player_Check_Floor			 ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x00BE58
		move.b	Obj_Speed_Y(A0),d2					  ; $001A
		addq.b	#8,d2
		neg.b	D2
		cmp.b	D2,d1
		bge.s	Offset_0x00BDFE
		cmp.b	D2,d0
		blt.s	Offset_0x00BE58
Offset_0x00BDFE:
		add.w	D1,Obj_Y(A0)					; $0014
		move.b	D3,Obj_Angle(A0)				; $0026
		bsr.w	Offset_0x00BF6A
		move.b	D3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	Offset_0x00BE36
		move.b	D3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	Offset_0x00BE28
		asr.w	Obj_Speed_Y(A0)				  ; $001A
		bra.s	Offset_0x00BE4A
Offset_0x00BE28:
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
		move.w	Obj_Speed_X(A0),Obj_Inertia(A0)			 ; $0018, $001C
		rts
Offset_0x00BE36:
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
		cmpi.w	#$FC0,Obj_Speed_Y(A0)				  ; $001A
		ble.s	Offset_0x00BE4A
		move.w	#$FC0,Obj_Speed_Y(A0)				  ; $001A
Offset_0x00BE4A:
		move.w	Obj_Speed_Y(A0),Obj_Inertia(A0)			 ; $001A, $001C
		tst.b	D3
		bpl.s	Offset_0x00BE58
		neg.w	Obj_Inertia(A0)				  ; $001C
Offset_0x00BE58:
		rts
Offset_0x00BE5A:
		bsr.w	Player_HitWall				 ; Offset_0x00A0BC
		tst.w	D1
		bpl.s	Offset_0x00BE72
		sub.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
		move.w	Obj_Speed_Y(A0),Obj_Inertia(A0)			 ; $001A, $001C
Offset_0x00BE72:
		bsr.w	Player_DontRunOnWalls		  ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x00BE8C
		sub.w	D1,Obj_Y(A0)					; $0014
		tst.w	Obj_Speed_Y(A0)				  ; $001A
		bpl.s	Offset_0x00BE8A
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
Offset_0x00BE8A:
		rts
Offset_0x00BE8C:
		tst.w	Obj_Speed_Y(A0)				  ; $001A
		bmi.s	Offset_0x00BEB2
		bsr.w	Player_Check_Floor			 ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x00BEB2
		add.w	D1,Obj_Y(A0)					; $0014
		move.b	D3,Obj_Angle(A0)				; $0026
		bsr.w	Offset_0x00BF6A
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
		move.w	Obj_Speed_X(A0),Obj_Inertia(A0)			 ; $0018, $001C
Offset_0x00BEB2:
		rts
Offset_0x00BEB4:
		bsr.w	Player_HitWall				 ; Offset_0x00A0BC
		tst.w	D1
		bpl.s	Offset_0x00BEC6
		sub.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
Offset_0x00BEC6:
		bsr.w	Offset_0x009EC6
		tst.w	D1
		bpl.s	Offset_0x00BED8
		add.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
Offset_0x00BED8:
		bsr.w	Player_DontRunOnWalls		  ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x00BF0E
		sub.w	D1,Obj_Y(A0)					; $0014
		move.b	D3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	Offset_0x00BEF8
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
		rts
Offset_0x00BEF8:
		move.b	D3,Obj_Angle(A0)				; $0026
		bsr.w	Offset_0x00BF6A
		move.w	Obj_Speed_Y(A0),Obj_Inertia(A0)			 ; $001A, $001C
		tst.b	D3
		bpl.s	Offset_0x00BF0E
		neg.w	Obj_Inertia(A0)				  ; $001C
Offset_0x00BF0E:
		rts
Offset_0x00BF10:
		bsr.w	Offset_0x009EC6
		tst.w	D1
		bpl.s	Offset_0x00BF28
		add.w	D1,Obj_X(A0)					; $0010
		move.w	#0,Obj_Speed_X(A0)				  ; $0018
		move.w	Obj_Speed_Y(A0),Obj_Inertia(A0)			 ; $001A, $001C
Offset_0x00BF28:
		bsr.w	Player_DontRunOnWalls		  ; Offset_0x009F1C
		tst.w	D1
		bpl.s	Offset_0x00BF42
		sub.w	D1,Obj_Y(A0)					; $0014
		tst.w	Obj_Speed_Y(A0)				  ; $001A
		bpl.s	Offset_0x00BF40
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
Offset_0x00BF40:
		rts
Offset_0x00BF42:
		tst.w	Obj_Speed_Y(A0)				  ; $001A
		bmi.s	Offset_0x00BF68
		bsr.w	Player_Check_Floor			 ; Offset_0x009BD4
		tst.w	D1
		bpl.s	Offset_0x00BF68
		add.w	D1,Obj_Y(A0)					; $0014
		move.b	D3,Obj_Angle(A0)				; $0026
		bsr.w	Offset_0x00BF6A
		move.w	#0,Obj_Speed_Y(A0)				  ; $001A
		move.w	Obj_Speed_X(A0),Obj_Inertia(A0)			 ; $0018, $001C
Offset_0x00BF68:
		rts
Offset_0x00BF6A:
		tst.b	Obj_Player_Spdsh_Flag(A0)				; $003D
		bne.s	Sonic_ResetOnFloor_Part2
		move.b	#0,Obj_Ani_Number(A0)				 ; $0020

; ---------------------------------------------------------------------------
; Subroutine to reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00BF76:
Sonic_ResetOnFloor:
		cmpi.l	#Obj_Miles,(a0)
		beq.w	Miles_ResetOnFloor

		move.b	Obj_Height_2(a0),d0
		move.b	Obj_Height_3(a0),Obj_Height_2(a0)
		move.b	Obj_Width_3(a0),Obj_Width_2(a0)
		btst	#2,Obj_Status(a0)
		beq.s	Sonic_ResetOnFloor_Part2
		bclr	#2,Obj_Status(a0)
		move.b	#0,Obj_Ani_Number(a0)
		sub.b	Obj_Height_3(a0),d0
		ext.w	d0
		add.w	d0,Obj_Y(a0)
; Offset_0x00BFAE:
Sonic_ResetOnFloor_Part2:
		bclr	#1,Obj_Status(a0)
		bclr	#5,Obj_Status(a0)
		bclr	#4,Obj_Status(a0)
		move.b	#0,Obj_Player_Jump(a0)
		move.w	#0,(Enemy_Hit_Chain_Count).w
		move.b	#0,Obj_Flip_Angle(a0)
		move.b	#0,Obj_Player_Flip_Flag(a0)
		move.b	#0,Obj_P_Flips_Remaining(a0)
		move.b	#0,Obj_Look_Up_Down_Time(a0)
		cmpi.b	#$14,Obj_Ani_Number(a0)
		bne.s	Sonic_ResetOnFloor_Part3
		move.b	#0,Obj_Ani_Number(a0)
; Offset_0x00BFF2:
Sonic_ResetOnFloor_Part3:
		tst.w	(Dropdash_flag).w
		beq.s	Offset_0x00C00E
		bmi.s	Sonic_Dropdash
		asr.w	Obj_Inertia(a0)
		asr.w	Obj_Speed_X(a0)
		move.w	#0,Obj_Speed_Y(a0)
		move.w	#0,(Dropdash_flag).w
Offset_0x00C00E:
		rts
; End of function Sonic_ResetOnFloor

; ---------------------------------------------------------------------------
; Subroutine for Sonic to do a dropdash-like ability (removed in final)
; ---------------------------------------------------------------------------
; Offset_0x00C010:
Sonic_Dropdash:
		move.w	#0,Obj_Speed_Y(a0)
		move.w	#0,(Dropdash_flag).w
		bsr.w	ResetPlayerPositionArray
		move.b	#9,Obj_Ani_Number(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound).l
		move.b	#1,Obj_Player_Spdsh_Flag(a0)
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)
		rts
; End of subroutine Sonic_DropDash

; ===========================================================================
; Offset_0x00C03E:
Sonic_Hurt:
		tst.w	(Debug_Mode_Active).w
		beq.s	Sonic_Hurt_Normal
		btst	#4,(Control_Ports_Buffer_Data+1).w
		beq.s	Sonic_Hurt_Normal
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Control_Locked_Flag_P1).w
		rts
; ---------------------------------------------------------------------------
; Offset_0x00C058:
Sonic_Hurt_Normal:
		jsr	(SpeedToPos).l
		addi.w	#$30,Obj_Speed_Y(a0)
		btst	#6,Obj_Status(a0)
		beq.s	Offset_0x00C072
		subi.w	#$20,Obj_Speed_Y(a0)

Offset_0x00C072:
		cmpi.w	#-$100,(Sonic_Level_Limits_Min_Y).w
		bne.s	Offset_0x00C082
		move.w	(Screen_Wrap_Y).w,d0
		and.w	d0,Obj_Y(a0)

Offset_0x00C082:
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBoundaries
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate_Check2P
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------
; Offset_0x00C098:
Sonic_HurtStop:
		move.w	(Sonic_Level_Limits_Max_Y).w,d0
		addi.w	#224,d0
		cmp.w	Obj_Y(a0),d0
		blt.w	KillSonic
		movem.l	a4-a6,-(sp)
		bsr.w	Sonic_Floor
		movem.l	(sp)+,a4-a6
		btst	#1,Obj_Status(a0)
		bne.s	Offset_0x00C0EC
		moveq	#0,d0
		move.w	d0,Obj_Speed_Y(a0)
		move.w	d0,Obj_Speed_X(a0)
		move.w	d0,Obj_Inertia(a0)
		move.b	d0,Obj_Player_Control(a0)
		move.b	#0,Obj_Ani_Number(a0)
		move.w	#$100,Obj_Priority(a0)
		move.b	#2,Obj_Routine(a0)
		move.b	#$78,Obj_P_Invunerblt_Time(a0)
		move.b	#0,Obj_Player_Spdsh_Flag(a0)

Offset_0x00C0EC:
		rts
; ---------------------------------------------------------------------------
; Offset_0x00C0EE:
KillSonic:
		jmp	(Kill_Player).l
; ===========================================================================
; Offset_0x00CF4:
Sonic_Death:
		tst.w	(Debug_Mode_Active).w
		beq.s	Offset_0x00C10E
		btst	#4,(Control_Ports_Buffer_Data+1).w
		beq.s	Offset_0x00C10E
		move.w	#1,(Debug_placement_mode).w
		clr.b	(Control_Locked_Flag_P1).w
		rts
; ---------------------------------------------------------------------------

Offset_0x00C10E:
		bsr.w	Player_GameOver
		jsr	(ObjectFall).l
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate_Check2P
		jmp	(DisplaySprite).l
; ===========================================================================
; Offset_0x00C126:
Player_GameOver:
		cmpa.w	#Obj_Player_One,a0
		bne.s	Offset_0x00C138
		move.w	(Camera_Y).w,d0
		move.b	#1,(Sonic_Scroll_Lock_Flag).w
		bra.s	Offset_0x00C142
; ---------------------------------------------------------------------------

Offset_0x00C138:
		move.w	(Camera_Y_P2).w,d0
		move.b	#1,(Miles_Scroll_Lock_Flag).w

Offset_0x00C142:
		move.b	#0,Obj_Player_Spdsh_Flag(a0)
		addi.w	#$100,d0
		tst.w	(Two_Player_Flag).w
		beq.s	Offset_0x00C156
		subi.w	#$70,d0

Offset_0x00C156:
		cmp.w	Obj_Y(a0),d0
		bge.w	Offset_0x00C20E
		tst.w	(Two_Player_Flag).w
		bne.w	Player_Respawning
		cmpi.b	#1,Obj_Player_Selected(a0)
		bne.s	Sonic_GameOver
		cmpi.w	#2,(Player_Selected_Flag).w
		beq.s	Sonic_GameOver
		move.b	#2,Obj_Routine(a0)
		bra.w	Miles_CPU_Despawn
; ---------------------------------------------------------------------------
; Offset_0x00C180:
Sonic_GameOver:
		move.b	#8,Obj_Routine(a0)
		move.w	#$3C,Obj_Player_Spdsh_Cnt(a0)
		addq.b	#1,(Update_HUD_lives).w
		subq.b	#1,(Life_count).w
		bne.s	Sonic_TimeOver
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)
		move.l	#Obj_Time_Over_Game_Over,(Obj_02_Mem_Address).w
		move.l	#Obj_Time_Over_Game_Over,(Obj_Dynamic_RAM).w
		move.b	#0,(Obj_02_Mem_Address+Obj_Map_Id).w
		move.b	#1,(Obj_Dynamic_RAM+Obj_Map_Id).w
		move.w	a0,(Obj_02_Mem_Address+Obj_Parent_Ref).w
		clr.b	(Time_Over_flag).w
; Offset_0x00C1C0:
Sonic_Finished:
		clr.b	(Update_HUD_timer).w
		clr.b	(HUD_Timer_Refresh_Flag_P2).w
		move.b	#8,Obj_Routine(a0)
		move.w	#mus_GameOver,d0
		jsr	(PlaySound).l
		moveq	#id_PLC_GameOver,d0
		jmp	(LoadPLC).l
; ===========================================================================
; Offset_0x00C1E0:
Sonic_TimeOver:
		tst.b	(Time_Over_flag).w
		beq.s	Offset_0x00C20E
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)
		move.l	#Obj_Time_Over_Game_Over,(Obj_02_Mem_Address).w
		move.l	#Obj_Time_Over_Game_Over,(Obj_Dynamic_RAM).w
		move.b	#2,(Obj_02_Mem_Address+Obj_Map_Id).w
		move.b	#3,(Obj_Dynamic_RAM+Obj_Map_Id).w
		move.w	a0,(Obj_02_Mem_Address+Obj_Parent_Ref).w
		bra.s	Sonic_Finished

Offset_0x00C20E:
		rts
; ===========================================================================
; Offset_0x00C210:
Player_Respawning:
		move.b	#2,Obj_Routine(a0)
		cmpa.w	#Obj_Player_One,a0
		bne.s	Tails_Respawning

; Sonic_Respawning:
		move.b	#0,(Sonic_Scroll_Lock_Flag).w
		move.w	(Saved_Obj_X_P1).w,Obj_X(a0)
		move.w	(Saved_Obj_Y_P1).w,Obj_Y(a0)
		move.w	(Saved_Obj_Art_VRAM_P1).w,Obj_Art_VRAM(a0)
		move.w	(Saved_Top_Solid_P1).w,Obj_Player_Top_Solid(a0)
		clr.w	(Ring_count).w
		clr.b	(Extra_life_flags).w
		bra.s	Offset_0x00C26A
; ---------------------------------------------------------------------------
; Offset_0x00C244:
Tails_Respawning:
		move.b	#0,(Miles_Scroll_Lock_Flag).w
		move.w	(Saved_Obj_X_P2).w,Obj_X(a0)
		move.w	(Saved_Obj_Y_P2).w,Obj_Y(a0)
		move.w	(Saved_Obj_Art_VRAM_P2).w,Obj_Art_VRAM(a0)
		move.w	(Saved_Top_Solid_P2).w,Obj_Player_Top_Solid(a0)
		clr.w	(Ring_Count_Address_P2).w
		clr.b	(Ring_Status_Flag_P2).w

Offset_0x00C26A:
		move.b	#0,Obj_Player_Control(a0)
		move.b	#5,Obj_Ani_Number(a0)
		move.w	#0,Obj_Speed_X(a0)
		move.w	#0,Obj_Speed_Y(a0)
		move.w	#0,Obj_Inertia(a0)
		move.b	#2,Obj_Status(a0)
		move.w	#0,Obj_P_Horiz_Ctrl_Lock(a0)
		move.w	#0,Obj_Player_Spdsh_Cnt(a0)
		rts
; ===========================================================================
; Offset_0x00C29C:
Sonic_ResetLevel:
		tst.w	Obj_Player_Spdsh_Cnt(a0)
		beq.s	Offset_0x00C2AE
		subq.w	#1,Obj_Player_Spdsh_Cnt(a0)
		bne.s	Offset_0x00C2AE
		move.w	#1,(Level_inactive_flag).w

Offset_0x00C2AE:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to animate Sonic's sprites
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x00C2B0:
Sonic_Animate:
		tst.w	(Camera_RAM).w
		bne.s	Offset_0x00C2C2
		tst.w	(Vertical_Scrolling).w
		bne.s	Offset_0x00C2C2
		move.b	#2,Obj_Routine(a0)

Offset_0x00C2C2:
		bsr.w	Sonic_Animate_Check2P
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------
; Offset_0x00C2CC:
Sonic_Animate_Check2P:
		tst.w	(Two_Player_Flag).w
		bne.s	Offset_0x00C2D8
		bsr.s	Sonic_Animate1P
		bra.w	LoadSonicDynamicPLC

Offset_0x00C2D8:
		bsr.w	Sonic_Or_Knuckles_Animate_Sprite_2P
		bra.w	LoadSonicDynamicPLC_2P
; ---------------------------------------------------------------------------
; Offset_0x00C2E0: Sonic_Animate_2:
Sonic_Animate1P:
		lea	(Sonic_Animate_Data).l,a1
		tst.b	(Super_Sonic_flag).w
		beq.s	Sonic_Animate_Sprite
		lea	(Super_Sonic_Animate_Data).l,a1
; Offset_0x00C2F2:
Sonic_Animate_Sprite:
		moveq	#0,d0
		move.b	Obj_Ani_Number(a0),d0
		cmp.b	Obj_Ani_Flag(a0),d0	; has the animation changed?
		beq.s	SAnim_Do		; if not, branch
		move.b	d0,Obj_Ani_Flag(a0)	; set previous animation
		move.b	#0,Obj_Ani_Frame(a0)	; reset animation frame
		move.b	#0,Obj_Ani_Time(a0)	; reset frame duration
		bclr	#5,Obj_Status(a0)
; Offset_0x00C314:
SAnim_Do:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1		; calculate address of appropriate animation script
		move.b	(a1),d0
		bmi.s	SAnim_WalkRun		; if animation is walk/run/roll/jump, branch
		move.b	Obj_Status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,Obj_Flags(a0)
		or.b	d1,Obj_Flags(a0)
		subq.b	#1,Obj_Ani_Time(a0)	; subtract 1 from frame duration
		bpl.s	Offset_0x00C352		; if time remains, branch
		move.b	d0,Obj_Ani_Time(a0)	; load frame duration

Offset_0x00C33A:
		moveq	#0,d1
		move.b	Obj_Ani_Frame(a0),d1	; load current frame
		move.b	1(a1,d1.w),d0		; read sprite number from script
		cmpi.b	#$FC,d0
		bcc.s	Offset_0x00C354		; if animation is complete, branch

Offset_0x00C34A:
		move.b	d0,Obj_Map_Id(a0)	; load sprite number
		addq.b	#1,Obj_Ani_Frame(a0)	; go to next frame

Offset_0x00C352:
		rts

Offset_0x00C354:
		addq.b	#1,d0
		bne.s	Offset_0x00C364
		move.b	#0,Obj_Ani_Frame(A0)				  ; $0023
		move.b	1(A1),d0
		bra.s	Offset_0x00C34A
Offset_0x00C364:
		addq.b	#1,d0
		bne.s	Offset_0x00C378
		move.b	2(A1,d1.w),d0
		sub.b	D0,Obj_Ani_Frame(A0)					; $0023
		sub.b	D0,d1
		move.b	1(A1,d1.w),d0
		bra.s	Offset_0x00C34A
Offset_0x00C378:
		addq.b	#1,d0
		bne.s	Offset_0x00C382
		move.b	2(A1,d1.w),Obj_Ani_Number(A0)		  ; $0020
Offset_0x00C382:
		rts
; ===========================================================================
; Offset_0x00C384:
SAnim_WalkRun:
		addq.b	#1,d0
		bne.w	Offset_0x00C516
		moveq	#0,d0
		move.b	Obj_Flip_Angle(A0),d0
		bne.w	Offset_0x00C4B0
		moveq	#0,d1
		move.b	Obj_Angle(A0),d0
		bmi.s	Offset_0x00C3A0
		beq.s	Offset_0x00C3A0
		subq.b	#1,d0

Offset_0x00C3A0:
		move.b	Obj_Status(A0),d2
		andi.b	#1,d2
		bne.s	Offset_0x00C3AC
		not.b	D0

Offset_0x00C3AC:
		addi.b	#$10,d0
		bpl.s	Offset_0x00C3B4
		moveq	#3,d1

Offset_0x00C3B4:
		andi.b	#$FC,Obj_Flags(A0)
		eor.b	D1,d2
		or.b	D2,Obj_Flags(A0)
		btst	#5,Obj_Status(A0)
		bne.w	Offset_0x00C55E
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	Obj_Inertia(A0),d2
		bpl.s	Offset_0x00C3D8
		neg.w	D2

Offset_0x00C3D8:
		tst.b	Obj_Player_Status(A0)
		bpl.w	Offset_0x00C3E2
		add.w	D2,d2

Offset_0x00C3E2:
		tst.b	(Super_Sonic_flag).w
		bne.s	Offset_0x00C43E
		lea	(Offset_0x00C5F6).l,a1
		cmpi.w	#$600,d2
		bcc.s	Offset_0x00C3FC
		lea	(Offset_0x00C5EC).l,a1
		add.b	D0,d0

Offset_0x00C3FC:
		add.b	D0,d0
		move.b	D0,d3
		moveq	#0,d1
		move.b	Obj_Ani_Frame(A0),d1
		move.b	1(A1,d1.w),d0
		cmpi.b	#$FF,d0
		bne.s	Offset_0x00C41A
		move.b	#0,Obj_Ani_Frame(A0)
		move.b	1(A1),d0

Offset_0x00C41A:
		move.b	D0,Obj_Map_Id(A0)
		add.b	D3,Obj_Map_Id(A0)
		subq.b	#1,Obj_Ani_Time(A0)
		bpl.s	Offset_0x00C43C
		neg.w	D2
		addi.w	#$800,d2
		bpl.s	Offset_0x00C432
		moveq	#0,d2

Offset_0x00C432:
		lsr.w	#8,d2
		move.b	D2,Obj_Ani_Time(A0)
		addq.b	#1,Obj_Ani_Frame(A0)

Offset_0x00C43C:
		rts
; ===========================================================================

Offset_0x00C43E:
		lea	(Offset_0x00C7B2).l,a1
		cmpi.w	#$800,d2
		bcc.s	Offset_0x00C456
		lea	(Offset_0x00C7A8).l,a1
		add.b	D0,d0
		add.b	D0,d0
		bra.s	Offset_0x00C458
Offset_0x00C456:
		lsr.b	#1,d0
Offset_0x00C458:
		move.b	D0,d3
		moveq	#0,d1
		move.b	Obj_Ani_Frame(A0),d1					; $0023
		move.b	1(A1,d1.w),d0
		cmpi.b	#$FF,d0
		bne.s	Offset_0x00C474
		move.b	#0,Obj_Ani_Frame(A0)				  ; $0023
		move.b	1(A1),d0
Offset_0x00C474:
		move.b	D0,Obj_Map_Id(A0)					   ; $0022
		add.b	D3,Obj_Map_Id(A0)					   ; $0022
		move.b	(Level_frame_counter+1).w,d1		; $FFFFFE05
		andi.b	#3,d1
		bne.s	Offset_0x00C494
		cmpi.b	#$B5,Obj_Map_Id(A0)					 ; $0022
		bcc.s	Offset_0x00C494
		addi.b	#$20,Obj_Map_Id(A0)					 ; $0022
Offset_0x00C494:
		subq.b	#1,Obj_Ani_Time(A0)				   ; $0024
		bpl.s	Offset_0x00C4AE
		neg.w	D2
		addi.w	#$800,d2
		bpl.s	Offset_0x00C4A4
		moveq	#0,d2
Offset_0x00C4A4:
		lsr.w	#8,d2
		move.b	D2,Obj_Ani_Time(A0)					 ; $0024
		addq.b	#1,Obj_Ani_Frame(A0)				  ; $0023
Offset_0x00C4AE:
		rts
Offset_0x00C4B0:
		move.b	Obj_Flip_Angle(A0),d0				   ; $0027
		moveq	#0,d1
		move.b	Obj_Status(A0),d2					   ; $002A
		andi.b	#1,d2
		bne.s	Offset_0x00C4DE
		andi.b	#$FC,Obj_Flags(A0)					  ; $0004
		addi.b	#$B,d0
		divu.w	#$16,d0
		addi.b	#$5F,d0
		move.b	D0,Obj_Map_Id(A0)					   ; $0022
		move.b	#0,Obj_Ani_Time(A0)				   ; $0024
		rts
Offset_0x00C4DE:
		andi.b	#$FC,Obj_Flags(A0)					  ; $0004
		tst.b	Obj_Player_Flip_Flag(A0)				 ; $002D
		beq.s	Offset_0x00C4F6
		ori.b	#1,Obj_Flags(A0)					  ; $0004
		addi.b	#$B,d0
		bra.s	Offset_0x00C502
Offset_0x00C4F6:
		ori.b	#3,Obj_Flags(A0)					  ; $0004
		neg.b	D0
		addi.b	#$8F,d0
Offset_0x00C502:
		divu.w	#$16,d0
		addi.b	#$5F,d0
		move.b	D0,Obj_Map_Id(A0)					   ; $0022
		move.b	#0,Obj_Ani_Time(A0)				   ; $0024
		rts
Offset_0x00C516:
		subq.b	#1,Obj_Ani_Time(A0)				   ; $0024
		bpl.w	Offset_0x00C352
		move.w	Obj_Inertia(A0),d2					  ; $001C
		bpl.s	Offset_0x00C526
		neg.w	D2
Offset_0x00C526:
		lea	(Offset_0x00C60A).l,a1
		cmpi.w	#$0600,d2
		bcc.s	Offset_0x00C538
		lea	(Offset_0x00C600).l,a1
Offset_0x00C538:
		neg.w	D2
		addi.w	#$400,d2
		bpl.s	Offset_0x00C542
		moveq	#0,d2
Offset_0x00C542:
		lsr.w	#8,d2
		move.b	D2,Obj_Ani_Time(A0)					 ; $0024
		move.b	Obj_Status(A0),d1					   ; $002A
		andi.b	#1,d1
		andi.b	#$FC,Obj_Flags(A0)					  ; $0004
		or.b	D1,Obj_Flags(A0)				; $0004
		bra.w	Offset_0x00C33A
Offset_0x00C55E:
		subq.b	#1,Obj_Ani_Time(A0)				   ; $0024
		bpl.w	Offset_0x00C352
		move.w	Obj_Inertia(A0),d2					  ; $001C
		bmi.s	Offset_0x00C56E
		neg.w	D2
Offset_0x00C56E:
		addi.w	#$800,d2
		bpl.s	Offset_0x00C576
		moveq	#0,d2
Offset_0x00C576:
		lsr.w	#6,d2
		move.b	D2,Obj_Ani_Time(A0)					 ; $0024
		lea	(Offset_0x00C614).l,a1
		tst.b	(Super_Sonic_flag).w				 ; $FFFFFE19
		beq.s	Offset_0x00C58E
		lea	(Offset_0x00C7BC).l,a1
Offset_0x00C58E:
		move.b	Obj_Status(A0),d1					   ; $002A
		andi.b	#1,d1
		andi.b	#$FC,Obj_Flags(A0)					  ; $0004
		or.b	D1,Obj_Flags(A0)				; $0004
		bra.w	Offset_0x00C33A