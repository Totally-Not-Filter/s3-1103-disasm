; ===========================================================================
; Sonic the Hedgehog 3 - November 11, 1993 prototype Z80 sound driver
; Stock Z80 Type 2 DAC driver with many features from Sonic 1/2 missing

; Disassembled using Z80Dasm.exe
; Documented by Alex Field
; Additional help by Naoto and OrionNavettan

; Note that the Z80 syntax used here is slightly non-standard as of result of how AXM68k
; works: * is used to invoke the current program counter rather than $, offset(*) must be
; used to invoke the program counter in macro parameters due to the use of ASM68K's section
; and group functionality, and shadow registers are not indicated  with an apostrophe; e.g.,
; ex af,af' is simply written as ex af,af.

fix_sndbugs	=	FixBugs

z80_SoundDriverStart:
; ---------------------------------------------------------------------------

zTrack STRUCT DOTS
PlaybackControl:	ds.b 1
VoiceControl:		ds.b 1
TempoDivider:		ds.b 1
DataPointerLow:		ds.b 1
DataPointerHigh:	ds.b 1
Transpose:		ds.b 1
Volume:			ds.b 1
ModulationCtrl:		ds.b 1
VoiceIndex:		ds.b 1
StackPointer:		ds.b 1
AMSFMSPan:		ds.b 1
DurationTimeout:	ds.b 1
SavedDuration:		ds.b 1
FreqLow:		ds.b 1
FreqHigh:		ds.b 1
VoiceSongID:		ds.b 1
Detune:			ds.b 1
Unk11h:			ds.b 1
		ds.b 5	; $12-$16 are unused!
VolEnv:			ds.b 1
FMVolEnv:		ds.b 1
SSGEGPointerLow:
FMVolEnvMask:		ds.b 1
SSGEGPointerHigh:
PSGNoise:		ds.b 1
FeedbackAlgo:		ds.b 1
TLPtrLow:		ds.b 1
TLPtrHigh:		ds.b 1
NoteFillTimeout:	ds.b 1
NoteFillMaster:		ds.b 1
ModulationPtrLow:	ds.b 1
ModulationPtrHigh:	ds.b 1
ModEnvSens:
ModulationValLow:	ds.b 1
ModulationValHigh:	ds.b 1
ModulationWait:		ds.b 1
ModEnvIndex:
ModulationSpeed:	ds.b 1
ModulationDelta:	ds.b 1
ModulationSteps:	ds.b 1
LoopCounters:		ds.w 1
VoicesLow:		ds.b 1
VoicesHigh:		ds.b 1
Stack_top:		ds.l 1
zTrack ENDSTRUCT

; ---------------------------------------------------------------------------
z80_stack	=	$2000
z80_stack_end	=	z80_stack-$60
; equates: standard (for Genesis games) addresses in the memory map
zYM2612_A0:		= $4000
zYM2612_D0:		= $4001
zYM2612_A1:		= $4002
zYM2612_D1:		= $4003
zBankRegister:		= $6000
zPSG:			= $7F11
zROMWindow:		= $8000
; ---------------------------------------------------------------------------
; z80 RAM:
zDataStart:		= $1C00

		phase zDataStart
	if fix_sndbugs=0
			ds.b	2	; unused
	endif
zPointerTable:		ds.w	1	; the 68000 SoundDriverLoad routine sets this to 1200h in Z80 memory
zSongBank:		ds.b	1	; bits 15 to 22 of M68K bank address
zCurrentTempo:		ds.b	1
zDACIndex:		ds.b	1	; bit 7 = 1 if playing, 0 if not; remaining 7 bits are index into DAC tables (1-based)
zPlaySegaPCMFlag:	ds.b	1
	if fix_sndbugs
zPalFlag:		ds.b 1
	endif
zPalDblUpdCounter:	ds.b	1	; used to update the sound driver twice every five frames; partially implemented
	if fix_sndbugs
			ds.b	1	; unused
	endif

zTempVariablesStart:
zNextSound:			ds.b	1
; the following three variables are used for 68000 input, although only the first is functional
zMusicNumber:		ds.b	1
zSFXNumber0:		ds.b	1
zSFXNumber1:		ds.b	1

zFadeOutTimeout:	ds.b	1
zFadeDelay:		ds.b	1
zFadeDelayTimeout:	ds.b	1
zPauseFlag:		ds.b	1
zHaltFlag:		ds.b	1
zFM3Settings:		ds.b	1	; set twice, never read (is read in Z80 Type 1 for YM timer-related purposes)
zTempoAccumulator:	ds.b	1
			ds.b	1	; unused
unk_1C15:		ds.b	1	; set twice, unused read
zFadeToPrevFlag:	ds.b	1
unk_1C17:		ds.b	1	; set once, never read
zSoundIndex:		ds.b	1	; effectively unused in the final
zUpdatingSFX:		ds.b	1
zSpecFM3FreqsSFX:	ds.b	8
unk_1C22:		ds.b	8
zSpecFM3Freqs:		ds.b	8
zSFXSaveIndex:		ds.b	1
zSongPosition:		ds.b	2
zTrackInitPos:		ds.b	2
zVoiceTblPtr:		ds.b	2
zSFXVoiceTblPtr:	ds.b	2
zSFXTempoDivider:	ds.b	1
			ds.b	4	; unused

zTracksStart:
zSongFM6_DAC:	zTrack
zSongFM1:		zTrack
zSongFM2:		zTrack
zSongFM3:		zTrack
zSongFM4:		zTrack
zSongFM5:		zTrack
zSongPSG1:		zTrack
zSongPSG2:		zTrack
zSongPSG3:		zTrack
zTracksEnd

zTracksSFXStart:
zSFX_FM3:		zTrack
zSFX_FM4:		zTrack
zSFX_FM5:		zTrack
zSFX_FM6:		zTrack
zSFX_PSG1:		zTrack
zSFX_PSG2:		zTrack
zSFX_PSG3:		zTrack
zTracksSFXEnd

zTempVariablesEnd
	if * > z80_stack_end	; Don't declare more space than the RAM can contain!
		fatal "The RAM variable declarations are too large. It's \{*-z80_stack_end}h bytes past the start of the bottom of the stack, at \{z80_stack_end}h."
	endif
		dephase
		!org	z80_SoundDriverStart

		save
		!org	0	; z80 Align, handled by the build process
		CPU Z80
		listing purecode

; Macro to perform a bank switch... after using this,
; the start of zROMWindow points to the start of the given 68k address,
; rounded down to the nearest $8000 byte boundary
bankswitch macro addr68k
	if fix_sndbugs
	; Because why use a and e when you can use h and l?
	ld	hl,zBankRegister+1	; +1 so that 6000h becomes 6001h, which is still a valid bankswitch port
.cnt	:= 0
	rept 9
		; this is either ld (hl),h or ld (hl),l
		db 74h|(((addr68k)&(1<<(15+.cnt)))<>0)
.cnt		:= .cnt+1
	endm
	else
	ld	hl,zBankRegister
	xor	a	; a = 0
	ld	e,1	; e = 1
.cnt	:= 0
	rept 9
		; this is either ld (hl),a or ld (hl),e
		db 73h|((((addr68k)&(1<<(15+.cnt)))=0)<<2)
.cnt		:= .cnt+1
	endm
	endif
	endm

; Macro to perform a bank switch... after using this,
; the start of zROMWindow points to the start of the given 68k address,
; rounded down to the nearest $8000 byte boundary
; This is only ever used once.
bankswitch2 macro addr68k
	ld	hl,zBankRegister
	ld	d,1	; d = 1
	xor	a	; a = 0
.cnt	:= 0
	rept 9
		; this is either ld (hl),a or ld (hl),d
		db 72h|((((addr68k)&(1<<(15+.cnt)))=0)<<2)|(((addr68k)&(1<<(15+.cnt)))=0)
.cnt		:= .cnt+1
	endm
	endm

bankswitchToMusic macro addr68k
	; hardcoded to only accept 4-bit bank values
	ld	(hl),a
	rept 3
		rra
		ld	(hl),a
	endm
	xor	a
	ld	d,1
.cnt	:= 4
	rept 5
		; this is either ld (hl),a or ld (hl),d
		db 72h|((((addr68k)&(1<<(15+.cnt)))=0)<<2)|(((addr68k)&(1<<(15+.cnt)))=0)
.cnt		:= .cnt+1
	endm
	endm

; macro to make a certain error message clearer should you happen to get it...
rsttarget macro {INTLABEL}
	if ($&7)||($>38h)
		fatal "Function __LABEL__ is at 0\{$}h, but must be at a multiple of 8 bytes <= 38h to be used with the rst instruction."
	endif
	if "__LABEL__"<>""
__LABEL__ label $
	endif
	endm

; function to turn a 68k address into a word the Z80 can use to access it
zmake68kPtr function addr,zROMWindow+(addr&7FFFh)

; function to turn a 68k address into a bank byte
zmake68kBank function addr,(((addr&3F8000h)/zROMWindow))

zmakeSongBank function addr,zmake68kBank(addr)&0Fh ; See bankswitchToMusicS3

zID_PriorityList	= 0
zID_UniVoiceBank	= 2
zID_MusicPointers	= 4
zID_SFXPointers		= 6
zID_ModEnvPointers	= 8
zID_VolEnvPointers	= 0Ah
zID_SongLimit		= 0Ch	; unused

; ===========================================================================
; ---------------------------------------------------------------------------
; Entry Point
; ---------------------------------------------------------------------------

zEntryPoint:
		di					; disable interrupts
		di					; twice
		im	1				; set interrupt mode 1
		jp	zInitAudioDriver
; ===========================================================================
; ---------------------------------------------------------------------------
; Gets the correct pointer to pointer table for the data type in question
; (music, sfx, voices, etc.).
;
; input:  c    ID for data type.
; output: hl   master pointer table for	index
;         af   trashed
;         b    trashed
; ---------------------------------------------------------------------------
	align 8
zGetPointerTable:	rsttarget
	if fix_sndbugs
		ld	hl,z80_SoundDriverPointers		; read pointer table
	else
		ld	hl,(zPointerTable)		; read pointer to pointer table (yes, really)
	endif
		ld	b,0
		add	hl,bc				; add offset into pointer table
		ex	af,af'				; backup AF
		ld	a,(hl)				; read low byte of pointer table
		inc	hl
		ld	h,(hl)				; read high byte of pointer table
		ld	l,a				; combine both bytes together to get our address
		ex	af,af'				; restore AF
		ret
; ===========================================================================
; ---------------------------------------------------------------------------
; Reads	an offset into a pointer table and returns dereferenced pointer.
;
; input:  a    index into pointer table
;	  hl   pointer to pointer table
; output: hl   selected	pointer	in pointer table
;         bc   trashed
; ---------------------------------------------------------------------------
	align 8
zPointerTableOffset:	rsttarget
		ld	c,a				; get index for pointer table
		; then load the pointer in the index
		ld	b,0
		add	hl,bc
		add	hl,bc
	if fix_sndbugs
		jp	zReadPointer	; 10 clock cycles, 3 bytes
	else
		nop			; 12 clock cycles, 3 bytes
		nop
		nop
	endif
; ----------------------------------------------------------------------------
; Dereferences a pointer.
;
; input:  hl	pointer
; output: hl	equal to what that was being pointed to by hl
	align 8
zReadPointer:	rsttarget
		ld	a,(hl)				; read low byte of pointer table
		inc	hl
		ld	h,(hl)				; read high byte of pointer table
		ld	l,a				; combine both bytes together to get our address
		ret
; ----------------------------------------------------------------------------
; Possible to fit two more rsttargets into here
	align 38h
; ===========================================================================
; ---------------------------------------------------------------------------
; This subroutine is called every V-Int. After it is processed, the z80
; returns to the digital audio loop to continue playing DAC samples.
;
; If the SEGA PCM is being played, it disables interrupts -- this means that
; this procedure will NOT be called while the SEGA PCM is playing.
; ---------------------------------------------------------------------------

zVInt:	rsttarget
		di					; disable interrupts
		push	af
		push	iy
		exx
	if fix_sndbugs
.doupdate:
	endif
		call	zDoUpdate
		call	zUpdateEverything
	if fix_sndbugs
		ld	a, (zPalFlag)			; Get PAL flag
		or	a				; Is it set?
		jr	z, .not_pal			; Branch if not (NTSC)
		ld	a, (zPalDblUpdCounter)		; Get PAL double-update timeout counter
		or	a				; Is it zero?
		jr	nz, .pal_timer			; Branch if not
		ld	a, 5				; Set it back to 5...
		ld	(zPalDblUpdCounter), a		; ... and save it
		jp	.doupdate			; Go again

.pal_timer:
		dec	a				; Decrease PAL double-update timeout counter
		ld	(zPalDblUpdCounter), a		; Store it

.not_pal:
	endif
		; DAC bankswitch
		bankswitch DACBank
		exx
		pop	iy
		pop	af
		ld	b,1
		ret
; ---------------------------------------------------------------------------

zInitAudioDriver:
		ld	sp,z80_stack			; set the stack pointer to 0x2000 (end of z80 RAM)
		ld	c,0

.loop:
		ld	b,0
		djnz	$
		dec	c
		jr	z,.loop

		ld	a,zmakeSongBank(Snd_Bank1_Start)	; set the initial music bank to use bank 1
		ld	(zSongBank),a			; store the music bank
		xor	a
		ld	(zDACIndex),a			; clear the DAC index
		ld	(zPlaySegaPCMFlag),a		; clear the Sega sound flag
		call	zStopAllSound			; stop all music
		ld	a,5				; set PAL double-update timer to 5
		ld	(zPalDblUpdCounter),a		; (that is, do not double-update for 5 frames)
	if fix_sndbugs=0
		; duplicate DAC bankswitch
		bankswitch2 DACBank
	endif
		ei							; enable interrupts (only for them to be disabled in zPlayDigitalAudio)
		jp	zPlayDigitalAudio
; ===========================================================================
; ---------------------------------------------------------------------------
; Writes a reg/data pair to part I or II
;
; input:  a    value for register
;         c    value for data
;         ix   pointer to track RAM
; ---------------------------------------------------------------------------

zWriteFMIorII:
		bit	7,(ix+zTrack.VoiceControl)		; is this a PSG track?
		ret	nz				; return if yes
		bit	2,(ix+zTrack.PlaybackControl)		; is SFX overriding this track?
		ret	nz				; return if yes
		add	a,(ix+zTrack.VoiceControl)		; add the channel bits to the register address
		bit	2,(ix+zTrack.VoiceControl)		; is this the DAC channel or FM4 or FM5 or FM6?
		jr	nz,zWriteFMII_reduced		; if yes, branch
; End of function zWriteFMIorII

; ---------------------------------------------------------------------------
; Writes a reg/data pair to part I
;
; input:  a    value for register
;         c    value for data
; ---------------------------------------------------------------------------

zWriteFMI:
		ld	(zYM2612_A0),a			; select YM2612 register
	if fix_sndbugs=0
		nop							; delay
	endif
		ld	a,c						; load data from c into a
		ld	(zYM2612_D0),a			; send data to register
		ret
; End of function zWriteFMI

; ---------------------------------------------------------------------------

zWriteFMII_reduced:
		sub	4				; strip 'bound to Part II regs' bit
		; fall through to next function
; ---------------------------------------------------------------------------
; Writes a reg/data pair to part II
;
; input:  a    value for register
;         c    value for data
; ---------------------------------------------------------------------------

zWriteFMII:
		ld	(zYM2612_A1),a			; select YM2612 register
	if fix_sndbugs=0
		nop							; delay
	endif
		ld	a,c						; load data from c into a
		ld	(zYM2612_D1),a			; send data to register
		ret
; End of function zWriteFMII


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


zUpdateEverything:
		call	zPauseUnpause
		call	zTempoWait
		call	zDoMusicFadeOut
		call	zCycleSoundQueue
		call	zUpdateSFXTracks

;zUpdateMusicTracks:
		ld	hl,zBankRegister
		ld	a,(zSongBank)			; get bank ID for music
		bankswitchToMusic Snd_Bank1_Start
		xor	a
		ld	(zUpdatingSFX),a		; update music
		ld	ix,zSongFM6_DAC
		bit	7,(ix+zTrack.PlaybackControl)		; is this an FM/DAC track?
		call	nz,zUpdateDACTrack		; if yes, branch
		ld	b,(zTracksEnd-zSongFM1)/zTrack.len	; get number of tracks
		ld	ix,zSongFM1
		jr	zTrackUpdLoop			; play all tracks

zUpdateSFXTracks:
		ld	a,1
		ld	(zUpdatingSFX),a		; update SFX
		bankswitch SndBank
		ld	ix,zTracksSFXStart		; get number of tracks
		ld	b,(zTracksSFXEnd-zTracksSFXStart)/zTrack.len

zTrackUpdLoop:
		push	bc
		bit	7,(ix+zTrack.PlaybackControl)		; is a track currently playing?
		call	nz,zUpdateFMorPSGTrack		; if yes, branch
		ld	de,zTrack.len
		add	ix,de				; otherwise, advance to the next track
		pop	bc
		djnz	zTrackUpdLoop			; loop for all tracks
		ret

zUpdateFMorPSGTrack:
		bit	7,(ix+zTrack.VoiceControl)		; is this a PSG channel?
		jp	nz,zUpdatePSGTrack		; if yes, branch

	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)	; Run note timer
	else
		call	zTrackRunTimer			; Run note timer
	endif
		jr	nz,.noteGoing			; if the note has not expired yet, branch
		call	zGetNextNote			; get note for next FM track
		bit	4,(ix+zTrack.PlaybackControl)		; is track resting?
		ret	nz				; if yes, return
		call	zPrepareModulation
		call	zUpdateFreq
		call	zDoModulation
		call	zFMSendFreq
		jp	zFMNoteOn
; ---------------------------------------------------------------------------

.noteGoing:
		bit	4,(ix+zTrack.PlaybackControl)		; is the track resting?
		ret	nz				; if yes, return
		call	zDoFMVolEnv
		ld	a,(ix+zTrack.NoteFillTimeout)
		or	a				; is timeout either not running or expired?
		jr	z,.keepGoing			; if yes, branch
		dec	(ix+zTrack.NoteFillTimeout)
		jp	z,zKeyOffIfActive

.keepGoing:
		call	zUpdateFreq
		bit	6,(ix+zTrack.PlaybackControl)		; is 'sustain frequency' bit set?
		ret	nz				; if yes, return
		call	zDoModulation
; End of function zUpdateFMorPSGTrack

; ===========================================================================
; ---------------------------------------------------------------------------
; Uploads track's frequency to YM2612.
;
; input:   ix    Pointer to track RAM
;          hl    Frequency to upload
;          de    For FM3 in special mode, pointer to extra FM3 frequency data (never correctly set)
; output:  a     Trashed
;          bc    Trashed
;          hl    Trashed
;          de		increased by 8
; ---------------------------------------------------------------------------

zFMSendFreq:
		bit	2,(ix+zTrack.PlaybackControl)		; is SFX overriding this track?
		ret	nz				; if yes, return
		bit	0,(ix+zTrack.PlaybackControl)		; is track in special mode (FM3 only)?
		jp	nz,.specialMode			; if yes, branch

.notFM3:
		ld	a,0A4h				; update frequency MSB
		ld	c,h
		call	zWriteFMIorII
		ld	a,0A0h				; update frequency LSB
		ld	c,l
	if fix_sndbugs
		jp	zWriteFMIorII			; Send it to YM2612 and return to caller
	else
		call	zWriteFMIorII		; Send it to YM2612
		ret							; return to caller
	endif
; ---------------------------------------------------------------------------

.specialMode:
		ld	a,(ix+zTrack.VoiceControl)
		cp	2				; is this FM3?
		jr	nz,.notFM3			; if not, branch
		call	zGetSpecialFM3DataPointer
		ld	b,zSpecialFreqCommands_End-zSpecialFreqCommands
		ld	hl,zSpecialFreqCommands

.loop:
		push	bc
		ld	a,(hl)
		inc	hl
		push	hl
		ex	de,hl
		ld	c,(hl)
		inc	hl
		ld	b,(hl)
		inc	hl
		ex	de,hl
		ld	l,(ix+zTrack.FreqLow)
		ld	h,(ix+zTrack.FreqHigh)
		add	hl,bc
		push	af
		ld	c,h
		call	zWriteFMI
		pop	af
		sub	4
		ld	c,l
		call	zWriteFMI
		pop	hl
		pop	bc
		djnz	.loop
		ret
; End of function zFMSendFreq

; ===========================================================================
; zloc_1A5:
zSpecialFreqCommands:
		db	0ADh
		db	0AEh
		db	0ACh
		db	0A6h
zSpecialFreqCommands_End:

; ===========================================================================

zGetSpecialFM3DataPointer:
		ld	de,zSpecFM3Freqs
		ld	a,(zUpdatingSFX)
		or	a				; is this a SFX track?
		ret	z				; if not, return
		ld	de,zSpecFM3FreqsSFX
		ret	p
		ld	de,unk_1C22
		ret
; End of function zGetSpecialFM3DataPointer


zGetNextNote:
		ld	e,(ix+zTrack.DataPointerLow)
		ld	d,(ix+zTrack.DataPointerHigh)
		res	1,(ix+zTrack.PlaybackControl)
		res	4,(ix+zTrack.PlaybackControl)

zGetNextNote_cont:
		ld	a,(de)
		inc	de
		cp	0E0h
		jp	nc,zHandleFMorPSGCoordFlag
		ex	af,af'
		call	zKeyOffIfActive
		ex	af,af'
		bit	3,(ix+zTrack.PlaybackControl)
		jp	nz,zAltFreqMode
		or	a
		jp	p,zStoreDuration
		sub	81h
		jp	p,.gotNote
		call	zRestTrack
		jr	zGetNoteDuration

.gotNote:
		add	a,(ix+zTrack.Transpose)
		ld	hl,zPSGFrequencies
		push	af
		rst	zPointerTableOffset
		pop	af
		bit	7,(ix+zTrack.VoiceControl)
		jr	nz,zGotNoteFreq
		push	de
		ld	d,8
		ld	e,12					; 12 notes per octave
		ex	af,af'
		xor	a

.loop:
		ex	af,af'
		sub	e
		jr	c,.gotDisplacement
		ex	af,af'
		add	a,d
		jr	.loop
; ---------------------------------------------------------------------------
	if fix_sndbugs=0
		; unused
		ex	af,af'
	endif

.gotDisplacement:
		add	a,e
		ld	hl,zFMFrequencies
		rst	zPointerTableOffset
		ex	af,af'
		or	h
		ld	h,a
		pop	de

zGotNoteFreq:
		ld	(ix+zTrack.FreqLow),l
		ld	(ix+zTrack.FreqHigh),h

zGetNoteDuration:
		ld	a,(de)
		or	a
		jp	p,zGotNoteDuration
	if fix_sndbugs=0
		; zFinishTrackUpdate already does this
		ld	a,(ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout),a
	endif
		jr	zFinishTrackUpdate

	if fix_sndbugs=0
		; unused
		ld	a,(de)
		inc	de
		ld	(ix+zTrack.Unk11h),a
		jr	zGetRawDuration
	endif

zAltFreqMode:
		ld	h,a
		ld	a,(de)
		inc	de
		ld	l,a
		or	h
		jr	z,.gotZero
		ld	a,(ix+zTrack.Transpose)
		ld	b,0
		or	a
		jp	p,.didSignExtend
		dec	b

.didSignExtend:
		ld	c,a
		add	hl,bc

.gotZero:
		ld	(ix+zTrack.FreqLow),l
		ld	(ix+zTrack.FreqHigh),h
		ld	a,(de)
		inc	de
		ld	(ix+zTrack.Unk11h),a

zGetRawDuration:
		ld	a,(de)

zGotNoteDuration:
		inc	de

zStoreDuration:
		call	zComputeNoteDuration
		ld	(ix+zTrack.SavedDuration),a

zFinishTrackUpdate:
		ld	(ix+zTrack.DataPointerLow),e
		ld	(ix+zTrack.DataPointerHigh),d
		ld	a,(ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout),a
		bit	1,(ix+zTrack.PlaybackControl)
		ret	nz
		xor	a
		ld	(ix+zTrack.ModEnvIndex),a
		ld	(ix+zTrack.ModEnvSens),a
		ld	(ix+zTrack.VolEnv),a
		ld	a,(ix+zTrack.NoteFillMaster)
		ld	(ix+zTrack.NoteFillTimeout),a
		ret

zComputeNoteDuration:
		ld	b,(ix+zTrack.TempoDivider)
		dec	b
		ret	z
		ld	c,a

.loop:
		add	a,c
		djnz	.loop
		ret

; =============== S U B	R O U T	I N E =======================================
; Reduces note duration timeout for current track.
;
; Input:   ix   Track data
; Output:  a    New duration
;sub_33A
	if fix_sndbugs=0
zTrackRunTimer:
		; This is absurdly inefficient, since 'dec' can be ran directly on memory.
		ld	a, (ix+zTrack.DurationTimeout)	; Get track duration timeout
		dec	a				; Decrement it...
		ld	(ix+zTrack.DurationTimeout), a	; ... and save new value
		ret
; End of function zTrackRunTimer
	endif

zFMNoteOn:
		ld	a,(ix+zTrack.FreqLow)
		or	(ix+zTrack.FreqHigh)
		ret	z
		ld	a,(ix+zTrack.PlaybackControl)
	if fix_sndbugs
		and	16h				; Is either bit 4 ("track at rest") or 2 ("SFX overriding this track") or bit 1 ("do not attack next note") set?
	else
		and	6				; Is either bit 1 ("do not attack next note") or 2 ("SFX overriding this track") set?
	endif
		ret	nz
		ld	a,(ix+zTrack.VoiceControl)
		or	0F0h
		ld	c,a
		ld	a,28h
	if fix_sndbugs
		jp	zWriteFMI			; Send command to YM2612
	else
		call	zWriteFMI			; Send command to YM2612
		ret
	endif

zKeyOffIfActive:
		ld	a,(ix+zTrack.PlaybackControl)
		and	6
		ret	nz

zKeyOff:
		ld	c,(ix+zTrack.VoiceControl)
		bit	7,c
		ret	nz

zKeyOnOff:
		ld	a,28h
	if fix_sndbugs
		res	6, (ix+zTrack.PlaybackControl)	; From Dyna Brothers 2, but in a better place; clear flag to sustain frequency
		jp	zWriteFMI			; Send it
	else
		call	zWriteFMI			; Send it
		ret
	endif

zDoFMVolEnv:
		ld	a,(ix+zTrack.FMVolEnv)
		or	a
		ret	z
		ret	m
		dec	a
		ld	c,zID_VolEnvPointers
		rst	zGetPointerTable
		rst	zPointerTableOffset
		call	zDoVolEnv
		ld	h,(ix+zTrack.TLPtrHigh)
		ld	l,(ix+zTrack.TLPtrLow)
		ld	de,zFMInstrumentTLTable
		ld	b,zFMInstrumentTLTable_End-zFMInstrumentTLTable
		ld	c,(ix+zTrack.FMVolEnvMask)

.loop:
		push	af
		sra	c
		push	bc
		jr	nc,.skipReg
		add	a,(hl)
	if fix_sndbugs=0
		; This isn't actually needed
		and	7Fh				; Strip sign bit
	endif
		ld	c,a
		ld	a,(de)
		call	zWriteFMIorII

.skipReg:
		pop	bc
		inc	de
		inc	hl
		pop	af
		djnz	.loop
		ret

zPrepareModulation:
		bit	7,(ix+zTrack.ModulationCtrl)
		ret	z
		bit	1,(ix+zTrack.PlaybackControl)
		ret	nz
		ld	e,(ix+zTrack.ModulationPtrLow)
		ld	d,(ix+zTrack.ModulationPtrHigh)
		push	ix
		pop	hl
		ld	b,0
		ld	c,zTrack.ModulationWait
		add	hl,bc
		ex	de,hl
		ldi
		ldi
		ldi
		ld	a,(hl)
		srl	a
		ld	(de),a
		xor	a
		ld	(ix+zTrack.ModulationValLow),a
		ld	(ix+zTrack.ModulationValHigh),a
		ret

zDoModulation:
		ld	a,(ix+zTrack.ModulationCtrl)
		or	a
		ret	z
		cp	80h
		jr	nz,zDoModEnvelope
		dec	(ix+zTrack.ModulationWait)
		ret	nz
		inc	(ix+zTrack.ModulationWait)
		push	hl
		ld	l,(ix+zTrack.ModulationValLow)
		ld	h,(ix+zTrack.ModulationValHigh)
		ld	e,(ix+zTrack.ModulationPtrLow)
		ld	d,(ix+zTrack.ModulationPtrHigh)
		push	de
		pop	iy
		dec	(ix+zTrack.ModulationSpeed)
		jr	nz,.modSustain
		ld	a,(iy+1)
		ld	(ix+zTrack.ModulationSpeed),a
		ld	a,(ix+zTrack.ModulationDelta)
		ld	c,a
	if fix_sndbugs
		rla						; Carry contains sign of delta
		sbc	a, a					; a = 0 or -1 if carry is 0 or 1
	else
		and	80h					; Get only sign bit
		rlca						; Shift it into bit 0
		neg						; Negate (so it is either 0 or -1)
	endif
		ld	b,a
		add	hl,bc
		ld	(ix+zTrack.ModulationValLow),l
		ld	(ix+zTrack.ModulationValHigh),h

.modSustain:
		pop	bc
		add	hl,bc
		dec	(ix+zTrack.ModulationSteps)
		ret	nz
		ld	a,(iy+3)
		ld	(ix+zTrack.ModulationSteps),a
		ld	a,(ix+zTrack.ModulationDelta)
		neg
		ld	(ix+zTrack.ModulationDelta),a
		ret

zDoModEnvelope:
		dec	a
		ex	de,hl
		ld	c,zID_ModEnvPointers
		rst	zGetPointerTable
		rst	zPointerTableOffset
		jr	zDoModEnvelope_cont

zModEnvSetIndex:
		ld	(ix+zTrack.ModEnvIndex),a

zDoModEnvelope_cont:
		push	hl
		ld	c,(ix+zTrack.ModEnvIndex)
		ld	b,0
		add	hl,bc
	if fix_sndbugs
		ld	c, l
		ld	b, h
		ld	a, (bc)					; a = new modulation envelope value
	else
		ld	a, (hl)					; a = new modulation envelope value
	endif
		pop	hl
		bit	7,a
		jp	z,zPositiveModEnvMod
		cp	82h
		jr	z,zChangeModEnvIndex
		cp	80h
		jr	z,zResetModEnvMod
		cp	84h
		jr	z,zModEnvIncMultiplier
		ld	h,-1
		jr	nc,zApplyModEnvMod
		set	6,(ix+zTrack.PlaybackControl)
		pop	hl
		ret

zChangeModEnvIndex:
		inc	bc
		ld	a,(bc)
		jr	zModEnvSetIndex

zResetModEnvMod:
		xor	a
		jr	zModEnvSetIndex

zModEnvIncMultiplier:
		inc	bc
		ld	a,(bc)
		add	a,(ix+zTrack.ModEnvSens)
		ld	(ix+zTrack.ModEnvSens),a
		inc	(ix+zTrack.ModEnvIndex)
		inc	(ix+zTrack.ModEnvIndex)
		jr	zDoModEnvelope_cont

zPositiveModEnvMod:
		ld	h,0

zApplyModEnvMod:
		ld	l,a
		ld	b,(ix+zTrack.ModEnvSens)
		inc	b
		ex	de,hl

.loop:
		add	hl,de
		djnz	.loop
		inc	(ix+zTrack.ModEnvIndex)
		ret

zUpdateFreq:
		ld	h,(ix+zTrack.FreqHigh)
		ld	l,(ix+zTrack.FreqLow)
	if fix_sndbugs
		ld	a, (ix+zTrack.Detune)			; a = detune
		ld	c, a					; bc = sign extension of frequency displacement
		rla						; Carry contains sign of frequency displacement
		sbc	a, a					; a = 0 or -1 if carry is 0 or 1
		ld	b, a					; bc = sign extension of frequency displacement
	else
		ld	b, 0					; b = 0
		ld	a, (ix+zTrack.Detune)			; a = detune
		or	a					; Is a negative?
		jp	p, .did_sign_extend			; Branch if not
		ld	b, 0FFh					; b = -1

.did_sign_extend:
		ld	c, a					; bc = sign extension of frequency displacement
	endif
		add	hl,bc
		ret

zGetFMInstrumentPointer:
		ld	hl,(zVoiceTblPtr)
		ld	a,(zUpdatingSFX)
		or	a
		jr	z,zGetFMInstrumentOffset
		ld	l,(ix+zTrack.VoicesLow)
		ld	h,(ix+zTrack.VoicesHigh)

zGetFMInstrumentOffset:
		xor	a
		or	b
		ret	z
		ld	de,25

.loop:
		add	hl,de
		djnz	.loop
		ret

zFMInstrumentRegTable:
		db	0B0h
zFMInstrumentOperatorTable:
		db	30h
		db	38h
		db	34h
		db	3Ch
zFMInstrumentRSARTable:
		db	50h
		db	58h
		db	54h
		db	5Ch
zFMInstrumentAMD1RTable:
		db	60h
		db	68h
		db	64h
		db	6Ch
zFMInstrumentD2RTable:
		db	70h
		db	78h
		db	74h
		db	7Ch
zFMInstrumentD1LRRTable:
		db	80h
		db	88h
		db	84h
		db	8Ch
zFMInstrumentOperatorTable_End:

zFMInstrumentTLTable:
		db	40h
		db	48h
		db	44h
		db	4Ch
zFMInstrumentTLTable_End:

zFMInstrumentSSGEGTable:
		db	90h
		db	98h
		db	94h
		db	9Ch
zFMInstrumentSSGEGTable_End:


zSendFMInstrument:
		ld	de,zFMInstrumentRegTable
		ld	c,(ix+zTrack.AMSFMSPan)
		ld	a,0B4h
		call	zWriteFMIorII
		call	zSendFMInstrData
		ld	(ix+zTrack.FeedbackAlgo),a
		ld	b,zFMInstrumentOperatorTable_End-zFMInstrumentOperatorTable

.loop:
		call	zSendFMInstrData
		djnz	.loop
		ld	(ix+zTrack.TLPtrLow),l
		ld	(ix+zTrack.TLPtrHigh),h
		jp	zSendTL

zSendFMInstrData:
		ld	a,(de)
		inc	de
		ld	c,(hl)
		inc	hl
	if fix_sndbugs
		jp	zWriteFMIorII
	else
		call	zWriteFMIorII
		ret
	endif
; ===========================================================================
; ---------------------------------------------------------------------------
; Play sound depending on the indexed entry
; ---------------------------------------------------------------------------

zCycleSoundQueue:
		ld	a,(zNextSound)			; get the first (and only) item in the queue

zPlaySoundByIndex:
		cp	cmd_SEGA
		jp	z,zPlaySegaSound
		cp	mus__End
		jp	c,zPlayMusic
		cp	sfx__End
		jp	c,zPlaySound
		cp	cmd__First
		jp	c,zStopAllSound
		cp	0F0h
		jp	nc,zStopAllSound
		sub	cmd__First
		ld	hl,zFadeEffects
		rst	zPointerTableOffset
		xor	a
		ld	(zSoundIndex),a			; set current sound index to 0
		jp	(hl)				; handle fade effect
; ---------------------------------------------------------------------------

zFadeEffects:
		dw	zFadeOutMusic
		dw	zStopAllSound
		dw	zPSGSilenceAll
		dw	zStopSFX
; ---------------------------------------------------------------------------

zStopSFX:
		ld	ix,zTracksSFXStart
		ld	b,(zTracksSFXEnd-zTracksSFXStart)/zTrack.len
		ld	a,1
		ld	(zUpdatingSFX),a

.loop:
		push	bc
		bit	7,(ix+zTrack.PlaybackControl)
		call	nz,zSilenceStopTrack
		ld	de,zTrack.len
		add	ix,de
		pop	bc
		djnz	.loop
	if fix_sndbugs
		jp	zClearNextSound
	else
		call	zClearNextSound
		ret
	endif

zSilenceStopTrack:
		push	hl
		push	hl
		jp	cfSilenceStopTrack

zPlayMusic:
		sub	mus__First
		ret	m					; if negative, return
		push	af
		call	zStopAllSound
		pop	af
		push	af
		ld	hl,z80_MusicBanks
		add	a,l
		ld	l,a
		adc	a,h
		sub	l
		ld	h,a
	if fix_sndbugs
		ld	a,(hl)				; Get bank for the song to play
	else
		ld	(zloc_48B+1),hl

zloc_48B:
		ld	a,(z80_MusicBanks)
	endif
		ld	(zSongBank),a

		; music bankswitch
		ld	hl,zBankRegister
		bankswitchToMusic Snd_Bank1_Start
		ld	a,0B6h
		ld	(zYM2612_A1),a
	if fix_sndbugs=0
		nop
	endif
		ld	a,0C0h
		ld	(zYM2612_D1),a
		pop	af
		ld	c,zID_MusicPointers
		rst	zGetPointerTable
		rst	zPointerTableOffset
		push	hl
		push	hl
		rst	zReadPointer
		ld	(zVoiceTblPtr),hl
		pop	hl
		pop	iy
		ld	a,(iy+5)
		ld	(zTempoAccumulator),a
		ld	(zCurrentTempo),a
		ld	de,6
		add	hl,de
		ld	(zSongPosition),hl
		ld	hl,zFMDACInitBytes
		ld	(zTrackInitPos),hl
		ld	de,zTracksStart
		ld	b,(iy+2)
		ld	a,(iy+4)

.FMDACLoop:
		push	bc
		ld	hl,(zTrackInitPos)
		ldi
		ldi
		ld	(de),a
		inc	de
		ld	(zTrackInitPos),hl
		ld	hl,(zSongPosition)
		ldi
		ldi
		ldi
		ldi
		ld	(zSongPosition),hl
		call	zInitFMDACTrack
		pop	bc
		djnz	.FMDACLoop
		ld	a,(iy+zTrack.DataPointerLow)
		or	a
		jp	z,zClearNextSound
		ld	b,a
		ld	hl,zPSGInitBytes
		ld	(zTrackInitPos),hl
		ld	de,zSongPSG1
		ld	a,(iy+zTrack.DataPointerHigh)

.PSGLoop:
		push	bc
		ld	hl,(zTrackInitPos)
		ldi
		ldi
		ld	(de),a
		inc	de
		ld	(zTrackInitPos),hl
		ld	hl,(zSongPosition)
		ld	bc,6
		ldir
		ld	(zSongPosition),hl
		call	zZeroFillTrackRAM
		pop	bc
		djnz	.PSGLoop

zClearNextSound:
		xor	a
		ld	(zNextSound),a
		ret

zFMDACInitBytes:
		db	80h,6
		db	80h,0
		db	80h,1
		db	80h,2
		db	80h,4
		db	80h,5
		db	80h,6

zPSGInitBytes:
		db	80h,80h
		db	80h,0A0h
		db	80h,0C0h

zPlaySound:
		sub	sfx__First
; Ring SFX patch below provided by ValleyBell.
; Originally used zSpecFM3FreqsSFX to make the rings alternate between speakers, a better method would be to use unused RAM as long as it's a byte in size.
;		or	a ; is it equal to sfx__First?
;		jr	nz,.notequ ; if not, branch
;		ld	a,(zRingSpeaker) ; load zRingSpeaker into a
;		xor	1 ; set a to 1
;		ld	(zRingSpeaker),a ; load a back into zRingSpeaker
;.notequ:
		ex	af,af'

		; sound bankswitch
		bankswitch SndBank

		xor	a
		ld	c,zID_SFXPointers
		ld	(zUpdatingSFX),a
		ex	af,af'
		rst	zGetPointerTable
		rst	zPointerTableOffset
		push	hl
		rst	zReadPointer
		ld	(zSFXVoiceTblPtr),hl
	if fix_sndbugs=0
		xor	a
		ld	(unk_1C15),a
	endif
		pop	hl
		push	hl
		pop	iy
		ld	a,(iy+zTrack.TempoDivider)
		ld	(zSFXTempoDivider),a
		ld	de,4
		add	hl,de
		ld	b,(iy+zTrack.DataPointerLow)

zSFXTrackInitLoop:
		push	bc
		push	hl
		inc	hl
		ld	c,(hl)
		call	zGetSFXChannelPointers
		set	2,(hl)
		push	ix
	if fix_sndbugs=0
		ld	a,(zUpdatingSFX)		; Get flag
		or	a				; Are we updating SFX?
		jr	z,.normalsfx1			; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Effectively dead code.
		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; This code would then ensure that de points to the correct RAM area for
		; the writes below.
		pop	hl			; hl = pointer to SFX track data in RAM
		push	iy				; Save iy (pointer to SFX data)
.normalsfx1:
	endif
		pop	de
		pop	hl
		ldi
		ld	a,(de)
		cp	2
		call	z,zFM3NormalMode
		ldi
		ld	a,(zSFXTempoDivider)
		ld	(de),a
		inc	de
		ldi
		ldi
		ldi
		ldi
		call	zInitFMDACTrack
	if fix_sndbugs=0
		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; The code would then be checking to see if the corresponding SFX track
		; was playing, make sure the tracks refer to the same FM/PSG channel
		; then, if needed, mark the special SFX track as being overridden by the
		; SFX so as to not abruptly end the SFX.
		; With the system unimplemented, iy points to the current SFX track data,
		; meaning that the second branch is never taken, resulting in an attempted
		; write to ROM.
		bit	7,(ix+zTrack.PlaybackControl)	; Is the 'playing' bit set for this track?
		jr	z,.dontoverride		; Branch if not (all SFX define it as 80h, so... never)
		ld	a,(ix+zTrack.VoiceControl)	; Grab the voice control byte
		cp	(iy+zTrack.VoiceControl)	; Is this equal to the one for the corresponding special SFX track?
		jr	nz,.dontoverride		; Branch if not
		set	2,(iy+zTrack.PlaybackControl)	; Set bit 2 of playback control ('SFX is overriding this track')
.dontoverride:
	endif
		push	hl
		ld	hl,(zSFXVoiceTblPtr)
	if fix_sndbugs=0
		ld	a,(zUpdatingSFX)		; Get flag
		or	a				; Are we updating SFX?
		jr	z,.normalsfx2			; Branch if not (hint: it was cleared just below the bank switch above so... always)

		; Analysis of the Battletoads sound driver confirms previous speculation:
		; this code was meant for GHZ-like waterfall effects which were subsequently
		; scrapped in favor of the continuous SFX system.
		; If this system were to be reimplemented, then, after the call to
		; zGetSFXChannelPointers, we would have:
		; * ix = pointer to the overriding SFX track data in RAM;
		; * iy = pointer to the special SFX track data in RAM.
		; * hl = pointer to the overridden music track data in RAM;
		; This code would then make ix point to the correct track data for the
		; function calls below.
		; Without it implemented, iy points to the current SFX track data.
		push	iy				; Save iy
		pop	ix				; ix = pointer to special SFX data
.normalsfx2:
	endif
		ld	(ix+zTrack.VoicesLow),l
		ld	(ix+zTrack.VoicesHigh),h
		call	zKeyOffIfActive
	if fix_sndbugs
		bit	7,(ix+zTrack.VoiceControl)	; Is this an FM track?
		call	z,zFMClearSSGEGOps		; If so, clear SSG-EG operators for track's channels
	else
		call	zFMClearSSGEGOps		; Clear SSG-EG operators for track's channels (even on PSG tracks!!!)
	endif
		pop	hl
		pop	bc
		djnz	zSFXTrackInitLoop
		jp	zClearNextSound

zGetSFXChannelPointers:
		bit	7,c
		jr	nz,.isPSG
		ld	a,c
	if fix_sndbugs=0
		bit	2,a
		jr	z,.getPtrs
		dec	a
	endif
		jr	.getPtrs

.isPSG:
	if fix_sndbugs
		call	zSilencePSGChannel		; Silence channel at ix
		ld	a,c				; a = channel identifier
		; Shift high 3 bits to low bits so that we can convert it to a table index
		rlca
		rlca
		rlca
		and	7
		add	a,3				; Compensate for subtraction below
	else
		ld	a,1Fh				; a = 1Fh (redundant, as this is the first instruction of the function)
		call	zSilencePSGChannel		; Silence channel at ix
		; The next two lines are here because zSilencePSGChannel does not do
		; its job correctly. See the note there.
		ld	a,0FFh				; Command to silence Noise channel
		ld	(zPSG),a			; Silence it
		ld	a,c				; a = channel identifier
		; The next 5 shifts are so that we can convert it to a table index
		srl	a
		srl	a
		srl	a
		srl	a
		srl	a
		add	a,2				; Compensate for subtraction below
	endif

.getPtrs:
		sub	2
		ld	(zSFXSaveIndex),a
		push	af
		ld	hl,zSFXChannelData
		rst	zPointerTableOffset
		push	hl
		pop	ix
		pop	af
		ld	hl,zSFXOverriddenChannel
	if fix_sndbugs
		jp	zPointerTableOffset
	else
		rst	zPointerTableOffset
		ret
	endif

zInitFMDACTrack:
		ex	af,af'
		xor	a
		ld	(de),a
		inc	de
		ld	(de),a
		inc	de
		ex	af,af'

zZeroFillTrackRAM:
		ex	de,hl
		ld	(hl),zTrack.len
		inc	hl
		ld	(hl),0C0h
		inc	hl
		ld	(hl),1
		ld	b,zTrack.len-zTrack.DurationTimeout-1	; Loop counter

.loop:
		inc	hl
		ld	(hl),0
		djnz	.loop
		inc	hl
		ex	de,hl
		ret

zSFXChannelData:
		dw  zSFX_FM3		; FM3
	if fix_sndbugs
		dw  0000h		; Ironically, this filler is smaller than the code made to avoid it
	endif
		dw  zSFX_FM4		; FM4
		dw  zSFX_FM5		; FM5
		dw  zSFX_FM6		; FM6 or DAC
		dw  zSFX_PSG1		; PSG1
		dw  zSFX_PSG2		; PSG2
		dw  zSFX_PSG3		; PSG3
		dw  zSFX_PSG3		; PSG3/Noise

zSFXOverriddenChannel:
		dw  zSongFM3		; FM3
	if fix_sndbugs
		dw  0000h
	endif
		dw  zSongFM4		; FM4
		dw  zSongFM5		; FM5
		dw  zSongFM6_DAC	; FM6 or DAC
		dw  zSongPSG1		; PSG1
		dw  zSongPSG2		; PSG2
		dw  zSongPSG3		; PSG3
		dw  zSongPSG3		; PSG3/Noise

zPauseUnpause:
		ld	hl,zPauseFlag
		ld	a,(hl)
		or	a
		ret	z
		jp	m,.unpause
		pop	de
		dec	a
		ret	nz
		ld	(hl),2
		jp	zPauseAudio

.unpause:
		xor	a
		ld	(hl),a
		ld	a,(zFadeOutTimeout)
		or	a
		jp	nz,zStopAllSound
		ld	ix,zSongFM1
	if fix_sndbugs
		ld	b,(zSongPSG1-zSongFM1)/zTrack.len	; Number of FM tracks
	else
		; DANGER! This treats a PSG channel as if it were an FM channel. This
		; will break AMS/FMS/pan for FM1.
		ld	b,(zSongPSG2-zSongFM1)/zTrack.len	; Number of FM tracks +1
	endif

.FMLoop:
		ld	a,(zHaltFlag)
		or	a
		jr	nz,.setPan
		bit	7,(ix+zTrack.PlaybackControl)
		jr	z,.skipFMTrack

.setPan:
		ld	c,(ix+zTrack.AMSFMSPan)
		ld	a,0B4h
		call	zWriteFMIorII

.skipFMTrack:
		ld	de,zTrack.len
		add	ix,de
		djnz	.FMLoop

	if fix_sndbugs
		ld	ix,zTracksSFXStart		; Start at the start of SFX track data
		ld	b,(zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of tracks
	else
		; DANGER! This code goes past the end of Z80 RAM and into reserved territory!
		; By luck, it only *reads* from these areas...
		ld	ix,zTracksSFXEnd		; Start at the END of SFX track data (?)
		ld	b,7				; But loop for 7 tracks (??)
	endif
.PSGLoop:
		bit	7,(ix+zTrack.PlaybackControl)
		jr	z,.skipPSG
		bit	7,(ix+zTrack.VoiceControl)
		jr	nz,.skipPSG
		ld	c,(ix+zTrack.AMSFMSPan)
		ld	a,0B4h
		call	zWriteFMIorII

.skipPSG:
		ld	de,zTrack.len
		add	ix,de
		djnz	.PSGLoop
		ret

zFadeOutMusic:
		ld	a,28h
		ld	(zFadeOutTimeout),a
		ld	a,6
		ld	(zFadeDelayTimeout),a
		ld	(zFadeDelay),a

zHaltDACPSG:
		xor	a
		ld	(zSongFM6_DAC),a
		ld	(zSongPSG3),a
		ld	(zSongPSG1),a
		ld	(zSongPSG2),a
		jp	zPSGSilenceAll

zDoMusicFadeOut:
		ld	hl,zFadeOutTimeout
		ld	a,(hl)
		or	a
		ret	z
		call	m,zHaltDACPSG
		res	7,(hl)
		ld	a,(zFadeDelayTimeout)
		dec	a
		jr	z,.timerExpired
		ld	(zFadeDelayTimeout),a
		ret

.timerExpired:
		ld	a,(zFadeDelay)
		ld	(zFadeDelayTimeout),a
	if fix_sndbugs
		ld	hl, zFadeOutTimeout		; (hl) = fade timeout
		dec	(hl)				; Decrement it
	else
		ld	a, (zFadeOutTimeout)		; a = fade timeout
		dec	a				; Decrement it
		ld	(zFadeOutTimeout), a		; Then store it back
	endif
		jr	z,zStopAllSound
		ld	a,(zSongBank)

		; music bankswitch
		ld	hl,zBankRegister
		bankswitchToMusic Snd_Bank1_Start
		ld	ix,zTracksStart
		ld	b,(zSongPSG1-zTracksStart)/zTrack.len

.loop:
		inc	(ix+zTrack.Volume)
		jp	p,.chkChangeVolume
		dec	(ix+zTrack.Volume)
		jr	.nextTrack

.chkChangeVolume:
		bit	7,(ix+zTrack.PlaybackControl)
		jr	z,.nextTrack
		bit	2,(ix+zTrack.PlaybackControl)
		jr	nz,.nextTrack
		push	bc
		call	zSendTL
		pop	bc

.nextTrack:
		ld	de,zTrack.len
		add	ix,de
		djnz	.loop
		ret

zStopAllSound:
		ld	hl,zTempVariablesStart
		ld	de,zTempVariablesStart+1
		ld	bc,zTempVariablesEnd-zTempVariablesStart-1
		ld	(hl),0
		ldir
		ld	ix,zFMDACInitBytes
		ld	b,6

.loop:
		push	bc
	if fix_sndbugs
		; Inline it because zKeyOnOff tries to write to ix+0, which we don't want
		call	zSetMaxRelRate
		ld	a, 40h				; Set total level...
		ld	c, 7Fh				; ... to minimum envelope amplitude...
		call	zFMOperatorWriteLoop		; ... for all operators of this track's channel
		ld	a, 28h				; Write to KEY ON/OFF port
		ld	c, (ix+zTrack.VoiceControl)	; Send key off
		call	zWriteFMI			; Send it
	else
		call	zFMSilenceChannel
	endif
		call	zFMClearSSGEGOps
		inc	ix
		inc	ix
		pop	bc
		djnz	.loop
	if fix_sndbugs=0
		ld	b,7
		xor	a
		ld	(zFadeOutTimeout),a
	endif
		call	zPSGSilenceAll
		ld	c,0
		ld	a,2Bh
		call	zWriteFMI

zFM3NormalMode:
	if fix_sndbugs
		ld	c,0
	else
		xor	a
		ld	(zFM3Settings),a
		ld	c,a
	endif
		ld	a,27h
		call	zWriteFMI
		jp	zClearNextSound

zFMClearSSGEGOps:
		ld	a,90h
		ld	c,0
		jp	zFMOperatorWriteLoop

zPauseAudio:
	if fix_sndbugs=0
		call	zPSGSilenceAll			; Redundant, as function falls-through to it anyway
	endif
		push	bc
		push	af
		ld	b,(zSongFM4-zSongFM1)/zTrack.len
		ld	a,0B4h
		ld	c,0

.loop1:
		push	af
		call	zWriteFMI
		pop	af
		inc	a
		djnz	.loop1
		ld	b,(zSongPSG1-zSongFM4)/zTrack.len
		ld	a,0B4h

.loop2:
		push	af
		call	zWriteFMII
		pop	af
		inc	a
		djnz	.loop2
		ld	c,0
		ld	b,(zSongPSG1-zSongFM1)/zTrack.len+1
		ld	a,28h

.loop3:
		push	af
		call	zWriteFMI
		inc	c
		pop	af
		djnz	.loop3
		pop	af
		pop	bc

zPSGSilenceAll:
		push	bc
		ld	b,4
		ld	a,9Fh

.loop:
		ld	(zPSG),a
		add	a,20h
		djnz	.loop
		pop	bc
		jp	zClearNextSound

zTempoWait:
		ld	a,(zCurrentTempo)
		ld	hl,zTempoAccumulator
		add	a,(hl)
		ld	(hl),a
		ret	nc
		ld	hl,zTracksStart+zTrack.DurationTimeout
		ld	de,zTrack.len
		ld	b,(zTracksEnd-zTracksStart)/zTrack.len

.loop:
		inc	(hl)
		add	hl,de
		djnz	.loop
		ret

zDoUpdate:
	if fix_sndbugs=0
		ld	a,r
		ld	(unk_1C17),a
	endif
		ld	de,zMusicNumber
		call	zFillSoundQueue
		call	zFillSoundQueue

zFillSoundQueue:
		ld	a,(de)
		or	a
		ret	z
		sub	mus__First
		ld	c,zID_PriorityList
		rst	zGetPointerTable
		ld	c,a
		ld	b,0
		add	hl,bc
		ld	a,(zSoundIndex)
		cp	(hl)
		jr	z,.skip
		jr	nc,.skip2

.skip:
		ld	a,(de)
		ld	(zNextSound),a
		ld	a,(hl)
		and	7Fh
		ld	(zSoundIndex),a

.skip2:
		xor	a
		ld	(de),a
		inc	de
		ret

zFMSilenceChannel:
		call	zSetMaxRelRate
		ld	a,40h
		ld	c,7Fh
		call	zFMOperatorWriteLoop
		ld	c,(ix+zTrack.VoiceControl)
		jp	zKeyOnOff

zSetMaxRelRate:
		ld	a,80h
		ld	c,0FFh

zFMOperatorWriteLoop:
		ld	b,4

.loop:
		push	af
		call	zWriteFMIorII
		pop	af
		add	a,4
		djnz	.loop
		ret

zPlaySegaSound:
	if fix_sndbugs
		call	zStopAllSound				; Fade music before playing the sound
		xor	a					; a = 0
		ld	(zMusicNumber), a			; Clear M68K input queue...
		ld	(zSFXNumber0), a			; ... including SFX slot 0...
		ld	(zSFXNumber1), a			; ... and SFX slot 1
		inc	a					; a = 1
	else
		ld	a,1					; a = 1
	endif
		ld	(zPlaySegaPCMFlag),a
		pop	hl
		ret

zPSGFrequencies:
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3FFh
		dw	3F7h
		dw	3BEh
		dw	388h
		dw	356h
		dw	326h
		dw	2F9h
		dw	2CEh
		dw	2A5h
		dw	280h
		dw	25Ch
		dw	23Ah
		dw	21Ah
		dw	1FBh
		dw	1DFh
		dw	1C4h
		dw	1ABh
		dw	193h
		dw	17Dh
		dw	167h
		dw	153h
		dw	140h
		dw	12Eh
		dw	11Dh
		dw	10Dh
		dw	0FEh
		dw	0EFh
		dw	0E2h
		dw	0D6h
		dw	0C9h
		dw	0BEh
		dw	0B4h
		dw	0A9h
		dw	0A0h
		dw	97h
		dw	8Fh
		dw	87h
		dw	7Fh
		dw	78h
		dw	71h
		dw	6Bh
		dw	65h
		dw	5Fh
		dw	5Ah
		dw	55h
		dw	50h
		dw	4Bh
		dw	47h
		dw	43h
		dw	40h
		dw	3Ch
		dw	39h
		dw	36h
		dw	33h
		dw	30h
		dw	2Dh
		dw	2Bh
		dw	28h
		dw	26h
		dw	24h
		dw	22h
		dw	20h
		dw	1Fh
		dw	1Dh
		dw	1Bh
		dw	1Ah
		dw	18h
		dw	17h
		dw	16h
		dw	15h
		dw	13h
		dw	12h
		dw	11h
		dw	10h
		dw	0
		dw	0

zFMFrequencies:
		dw	284h
		dw	2ABh
		dw	2D3h
		dw	2FEh
		dw	32Dh
		dw	35Ch
		dw	38Fh
		dw	3C5h
		dw	3FFh
		dw	43Ch
		dw	47Ch
		dw	4C0h

; ---------------------------------------------------------------------------
; ===========================================================================
; MUSIC BANKS
; ===========================================================================

zmakeSongBanks macro
		irp op,ALLARGS
			db zmakeSongBank(op)
		endm
	endm

z80_MusicBanks:
	zmakeSongBanks	Angel_Island_1_Snd_Data
	zmakeSongBanks	Angel_Island_2_Snd_Data
	zmakeSongBanks	Hydrocity_1_Snd_Data
	zmakeSongBanks	Hydrocity_2_Snd_Data
	zmakeSongBanks	Marble_Garden_1_Snd_Data
	zmakeSongBanks	Marble_Garden_2_Snd_Data
	zmakeSongBanks	Carnival_Night_1_Snd_Data
	zmakeSongBanks	Carnival_Night_2_Snd_Data
	zmakeSongBanks	Flying_Battery_1_Snd_Data
	zmakeSongBanks	Flying_Battery_2_Snd_Data
	zmakeSongBanks	Icecap_1_Snd_Data
	zmakeSongBanks	Icecap_2_Snd_Data
	zmakeSongBanks	Launch_Base_1_Snd_Data
	zmakeSongBanks	Launch_Base_2_Snd_Data
	zmakeSongBanks	Mushroom_Valley_1_Snd_Data
	zmakeSongBanks	Mushroom_Valley_2_Snd_Data
	zmakeSongBanks	Sandopolis_1_Snd_Data
	zmakeSongBanks	Sandopolis_2_Snd_Data
	zmakeSongBanks	Lava_Reef_1_Snd_Data
	zmakeSongBanks	Lava_Reef_2_Snd_Data
	zmakeSongBanks	Sky_Sanctuary_Snd_Data
	zmakeSongBanks	Death_Egg_1_Snd_Data
	zmakeSongBanks	Death_Egg_2_Snd_Data
	zmakeSongBanks	Mini_Boss_Snd_Data
	zmakeSongBanks	Boss_Snd_Data
	zmakeSongBanks	The_Doomsday_Snd_Data
	zmakeSongBanks	Glowing_Spheres_Bonus_Stage_Snd_Data
	zmakeSongBanks	Special_Stage_Snd_Data
	zmakeSongBanks	Slot_Machine_Bonus_Stage_Snd_Data
	zmakeSongBanks	Gumball_Machine_Bonus_Stage_Snd_Data
	zmakeSongBanks	Knuckles_Theme_Snd_Data
	zmakeSongBanks	Azure_Lake_Snd_Data
	zmakeSongBanks	Balloon_Park_Snd_Data
	zmakeSongBanks	Desert_Palace_Snd_Data
	zmakeSongBanks	Chrome_Gadget_Snd_Data
	zmakeSongBanks	Endless_Mine_Snd_Data
	zmakeSongBanks	Title_Screen_Snd_Data
	zmakeSongBanks	Credits_Snd_Data
	zmakeSongBanks	Time_Game_Over_Snd_Data
	zmakeSongBanks	Continue_Snd_Data
	zmakeSongBanks	Level_Results_Snd_Data
	zmakeSongBanks	Extra_Life_Snd_Data
	zmakeSongBanks	Got_Emerald_Snd_Data
	zmakeSongBanks	Invincibility_Snd_Data
	zmakeSongBanks	Competition_Menu_Snd_Data
	zmakeSongBanks	Super_Sonic_Theme_Snd_Data
	zmakeSongBanks	Data_Select_Menu_Snd_Data
	zmakeSongBanks	Final_Boss_Snd_Data
	zmakeSongBanks	Panic_Snd_Data

zUpdateDACTrack:
	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)	; Run note timer
	else
		call	zTrackRunTimer			; Run note timer
	endif
		ret	nz
		ld	e,(ix+zTrack.DataPointerLow)
		ld	d,(ix+zTrack.DataPointerHigh)

zUpdateDACTrack_cont:
		ld	a,(de)
		inc	de
		cp	0E0h
		jp	nc,zHandleDACCoordFlag
		or	a
		jp	m,.gotSample
		dec	de
		ld	a,(ix+zTrack.FreqLow)

.gotSample:
		ld	(ix+zTrack.FreqLow),a
		cp	80h
		jp	z,zUpdateDACTrack_GetDuration
		res	7,a
		push	de
		ex	af,af'
		call	zKeyOffIfActive
		call	zFM3NormalMode
		ex	af,af'
		ld	(zDACIndex),a
		pop	de

zUpdateDACTrack_GetDuration:
		ld	a,(de)
		inc	de
		or	a
		jp	p,zStoreDuration
		dec	de
	if fix_sndbugs=0
		; zFinishTrackUpdate already does this
		ld	a,(ix+zTrack.SavedDuration)
		ld	(ix+zTrack.DurationTimeout),a
	endif
		jp	zFinishTrackUpdate

zHandleDACCoordFlag:
		ld	hl,zloc_954
		jp	zHandleCoordFlag

zloc_954:
		inc	de
		jp	zUpdateDACTrack_cont

zHandleFMorPSGCoordFlag:
		ld	hl,zloc_964

zHandleCoordFlag:
		push	hl
		sub	0E0h
		ld	hl,zCoordFlagSwitchTable
		rst	zPointerTableOffset
		ld	a,(de)
		jp	(hl)

zloc_964:
		inc	de
		jp	zGetNextNote_cont

zCoordFlagSwitchTable:
		dw	cfPanningAMSFMS
		dw	cfDetune
		dw	cfFadeInToPrevious
		dw	cfSilenceStopTrack
		dw	cfSetVolume
		dw	cfChangeVolume2
		dw	cfChangeVolume
		dw	cfPreventAttack
		dw	cfNoteFill
		dw	cfSpindashRev
		dw	cfPlayDACSample
		dw	cfConditionalJump
		dw	cfChangePSGVolume
		dw	cfSetKey
		dw	cfSendFMI
		dw	cfSetVoice
		dw	cfModulation
		dw	cfAlterModulation
		dw	cfStopTrack
		dw	cfSetPSGNoise
		dw	cfSetModulation
		dw	cfSetPSGVolEnv
		dw	cfJumpTo
		dw	cfRepeatAtPos
		dw	cfJumpToGosub
		dw	cfJumpReturn
		dw	cfDisableModulation
		dw	cfChangeTransposition
		dw	cfSpecialSFX
		dw	cfToggleAltFreqMode
		dw	cfFM3SpecialMode
		dw	cfMetaCF

zExtraCoordFlagSwitchTable:
		dw	cfSetTempo
		dw	cfPlaySoundByIndex
		dw	cfHaltSound
		dw	cfCopyData
		dw	cfSetTempoDivider
		dw	cfSetSSGEG
		dw	cfFMVolEnv

cfPlayDACSample:
		ld	(zDACIndex),a
		ret

cfPanningAMSFMS:
		ld	c,3Fh

zDoChangePan:
		ld	a,(ix+zTrack.AMSFMSPan)
		and	c
		push	de
		ex	de,hl
		or	(hl)
		ld	(ix+zTrack.AMSFMSPan),a
		ld	c,a
		ld	a,0B4h
		call	zWriteFMIorII
		pop	de
		ret

cfSpindashRev:
		ld	a,(ix+zTrack.ModulationCtrl)
		or	a
		ret	z
		set	7,(ix+zTrack.ModulationCtrl)
		dec	de
		ret

cfDetune:
		ld	(ix+zTrack.Detune),a
		ret

cfFadeInToPrevious:
		ld	(zFadeToPrevFlag),a
		ret

cfSilenceStopTrack:
		call	zFMSilenceChannel
		jp	cfStopTrack

cfSetVolume:
		bit	7,(ix+zTrack.VoiceControl)
		jr	z,.notPSG
		srl	a
		srl	a
		srl	a
		xor	0Fh
		and	0Fh
		jp	zStoreTrackVolume

.notPSG:
		xor	7Fh
		and	7Fh
		ld	(ix+zTrack.Volume),a
		jr	zSendTL

cfChangeVolume2:
		inc	de
		ld	a,(de)

cfChangeVolume:
		bit	7,(ix+zTrack.VoiceControl)
		ret	nz
		add	a,(ix+zTrack.Volume)
		jp	p,.setVol
		jp	pe,.underflow
		xor	a
		jp	.setVol

.underflow:
		ld	a,7Fh

.setVol:
		ld	(ix+zTrack.Volume),a

zSendTL:
		push	de
		ld	de,zFMInstrumentTLTable
		ld	l,(ix+zTrack.TLPtrLow)
		ld	h,(ix+zTrack.TLPtrHigh)
		ld	b,zFMInstrumentTLTable_End-zFMInstrumentTLTable

.loop:
		ld	a,(hl)
		or	a
		jp	p,.skipTrackVol
		add	a,(ix+zTrack.Volume)

.skipTrackVol:
		and	7Fh
		ld	c,a
		ld	a,(de)
		call	zWriteFMIorII
		inc	de
		inc	hl
		djnz	.loop
		pop	de
		ret

cfPreventAttack:
		set	1,(ix+zTrack.PlaybackControl)
		dec	de
		ret

cfNoteFill:
		call	zComputeNoteDuration
		ld	(ix+zTrack.NoteFillTimeout),a
		ld	(ix+zTrack.NoteFillMaster),a
		ret

cfConditionalJump:
		inc	de
		add	a,zTrack.LoopCounters
		ld	c,a
		ld	b,0
		push	ix
		pop	hl
		add	hl,bc
		ld	a,(hl)
		dec	a
		jp	z,.doJump
		inc	de
		ret

.doJump:
		xor	a
		ld	(hl),a
		jp	cfJumpTo

cfChangePSGVolume:
		bit	7,(ix+zTrack.VoiceControl)
		ret	z
		res	4,(ix+zTrack.PlaybackControl)
		dec	(ix+zTrack.VolEnv)
		add	a,(ix+zTrack.Volume)
		cp	0Fh
		jp	c,zStoreTrackVolume
		ld	a,0Fh

zStoreTrackVolume:
		ld	(ix+zTrack.Volume),a
		ret

cfSetKey:
		sub	40h
		ld	(ix+zTrack.Transpose),a
		ret

cfSendFMI:
		call	zGetFMParams
	if fix_sndbugs
		jp	zWriteFMI
	else
		call	zWriteFMI
		ret
	endif

zGetFMParams:
		ex	de,hl
		ld	a,(hl)
		inc	hl
		ld	c,(hl)
		ex	de,hl
		ret

cfSetVoice:
		bit	7,(ix+zTrack.VoiceControl)
		jr	nz,zSetVoicePSG
		call	zSetMaxRelRate
		ld	a,(de)
		ld	(ix+zTrack.VoiceIndex),a
		or	a
		jp	p,zSetVoiceUpload
		inc	de
		ld	a,(de)
		ld	(ix+zTrack.VoiceSongID),a

zSetVoiceUploadAlter:
		push	de
		ld	a,(ix+zTrack.VoiceSongID)
		sub	81h
		ld	c,zID_MusicPointers
		rst	zGetPointerTable
		rst	zPointerTableOffset
		rst	zReadPointer
		ld	a,(ix+zTrack.VoiceIndex)
		and	7Fh
		ld	b,a
		call	zGetFMInstrumentOffset
		jr	zSetVoiceDoUpload

zSetVoiceUpload:
		push	de
		ld	b,a
		call	zGetFMInstrumentPointer

zSetVoiceDoUpload:
		call	zSendFMInstrument
		pop	de
		ret

zSetVoicePSG:
		or	a
		jp	p,cfStoreNewVoice
		inc	de
		jp	cfStoreNewVoice
	if fix_sndbugs=0
		; unused
		ret
	endif

cfModulation:
		ld	(ix+zTrack.ModulationPtrLow),e
		ld	(ix+zTrack.ModulationPtrHigh),d
		ld	(ix+zTrack.ModulationCtrl),80h
		inc	de
		inc	de
		inc	de
		ret

cfAlterModulation:
		inc	de
		bit	7,(ix+zTrack.VoiceControl)
		jr	nz,cfSetModulation
		ld	a,(de)

cfSetModulation:
		inc	a
		ld	(ix+zTrack.ModulationCtrl),a
		ret

cfStopTrack:
		res	7,(ix+zTrack.PlaybackControl)
	if fix_sndbugs=0
		ld	a,1Fh
		ld	(unk_1C15),a
	endif
		call	zKeyOffIfActive
		ld	c,(ix+zTrack.VoiceControl)
		push	ix
		call	zGetSFXChannelPointers
		ld	a,(zUpdatingSFX)
		or	a
		jr	z,zStopCleanExit
		xor	a
		ld	(zSoundIndex),a
		push	hl
		ld	hl,(zVoiceTblPtr)
		pop	ix
		res	2,(ix+zTrack.PlaybackControl)
		bit	7,(ix+zTrack.VoiceControl)
		jr	nz,zStopPSGTrack
		bit	7,(ix+zTrack.PlaybackControl)
		jr	z,zStopCleanExit
		ld	a,2
		cp	(ix+zTrack.VoiceControl)
		jr	nz,.notFM3
		ld	a,4Fh
		bit	0,(ix+zTrack.PlaybackControl)
		jr	nz,.doFM3Settings
		and	0Fh

.doFM3Settings:
		call	zWriteFM3Settings

.notFM3:
		ld	a,(ix+zTrack.VoiceIndex)
		or	a
		jp	p,.switchToMusic
		call	zSetVoiceUploadAlter
		jr	.sendSSGEG

.switchToMusic:
		ld	b,a
		push	hl

		; music bankswitch
		ld	hl,zBankRegister
		ld	a,(zSongBank)
		bankswitchToMusic Snd_Bank1_Start
		pop	hl
		call	zGetFMInstrumentOffset
		call	zSendFMInstrument
	if fix_sndbugs
		bankswitch SndBank
	else
		; there SHOULD be a sound bankswitch here, but it's missing; this is
		; what causes all the sound glitches to happen
	endif
		ld	a,(ix+zTrack.FMVolEnv)
		or	a
		jp	p,zStopCleanExit
		ld	e,(ix+zTrack.SSGEGPointerLow)
		ld	d,(ix+zTrack.SSGEGPointerHigh)

.sendSSGEG:
		call	zSendSSGEGData

zStopCleanExit:
		pop	ix
		pop	hl
		pop	hl
		ret

zStopPSGTrack:
		bit	0,(ix+zTrack.PlaybackControl)
		jr	z,zStopCleanExit
		ld	a,(ix+zTrack.PSGNoise)
		or	a
		jp	p,.skipCommand
		ld	(zPSG),a

.skipCommand:
		jr	zStopCleanExit

cfSetPSGNoise:
	if fix_sndbugs
		bit	7, (ix+zTrack.VoiceControl)	; Is this a PSG track?
		ret	z				; Return if not
		ld	(ix+zTrack.PSGNoise), a		; Store to track RAM
		set	0, (ix+zTrack.PlaybackControl)	; Mark PSG track as being noise
		or	a				; Test noise value
		ld	a, 0DFh				; Command to silence PSG3
		jr	nz, .skip_noise_silence		; If nonzero, branch
		res	0, (ix+zTrack.PlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh				; Command to silence the noise channel

.skip_noise_silence:
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz				; Return if yes
		ld	(zPSG), a			; Execute it
		ld	a, (de)				; Get PSG noise value
		ld	(zPSG), a			; Send command to PSG
	else
		bit	2, (ix+zTrack.VoiceControl)	; Is this a channel bound for part II (FM4, FM5, FM6/DAC)?
		ret	nz				; Return if yes
		ld	a, 0DFh				; Command to silence PSG3
		ld	(zPSG), a			; Execute it
		ld	a, (de)				; Get PSG noise value
		ld	(ix+zTrack.PSGNoise), a		; Store to track RAM
		set	0, (ix+zTrack.PlaybackControl)	; Mark PSG track as being noise
		or	a				; Test noise value
		jr	nz, .skip_noise_silence		; If nonzero, branch
		res	0, (ix+zTrack.PlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh				; Command to silence the noise channel
.skip_noise_silence:
		ld	(zPSG), a			; Send command to PSG
	endif
		ret

cfSetPSGVolEnv:
		bit	7,(ix+zTrack.VoiceControl)
		ret	z

cfStoreNewVoice:
		ld	(ix+zTrack.VoiceIndex),a
		ret

cfJumpTo:
		ex	de,hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		dec	de
		ret

cfRepeatAtPos:
		inc	de
		add	a,zTrack.LoopCounters
		ld	c,a
		ld	b,0
		push	ix
		pop	hl
		add	hl,bc
		ld	a,(hl)
		or	a
		jr	nz,.runCounter
		ld	a,(de)
		ld	(hl),a

.runCounter:
		inc	de
		dec	(hl)
		jp	nz,cfJumpTo
		inc	de
		ret

cfJumpToGosub:
		ld	c,a
		inc	de
		ld	a,(de)
		ld	b,a
		push	bc
		push	ix
		pop	hl
		dec	(ix+zTrack.StackPointer)
		ld	c,(ix+zTrack.StackPointer)
		dec	(ix+zTrack.StackPointer)
		ld	b,0
		add	hl,bc
		ld	(hl),d
		dec	hl
		ld	(hl),e
		pop	de
		dec	de
		ret

cfJumpReturn:
		push	ix
		pop	hl
		ld	c,(ix+zTrack.StackPointer)
		ld	b,0
		add	hl,bc
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	(ix+zTrack.StackPointer)
		inc	(ix+zTrack.StackPointer)
		ret

cfDisableModulation:
		res	7,(ix+zTrack.ModulationCtrl)
		dec	de
		ret

cfChangeTransposition:
		add	a,(ix+zTrack.Transpose)
		ld	(ix+zTrack.Transpose),a
		ret

cfSpecialSFX:
		ret

cfToggleAltFreqMode:
	if fix_sndbugs
		or	a				; Is parameter equal to 0?
		jr	z, .stop_altfreq_mode		; Branch if so
	else
		cp	1				; Is parameter equal to 1?
		jr	nz, .stop_altfreq_mode		; Branch if not
	endif
		set	3,(ix+zTrack.PlaybackControl)
		ret

.stop_altfreq_mode:
		res	3,(ix+zTrack.PlaybackControl)
		ret

cfFM3SpecialMode:
		ld	a,(ix+zTrack.VoiceControl)
		cp	2
		jr	nz,zTrackSkip3bytes
		set	0,(ix+zTrack.PlaybackControl)
		ex	de,hl
		call	zGetSpecialFM3DataPointer
		ld	b,4

.loop:
		push	bc
		ld	a,(hl)
		inc	hl
		push	hl
		ld	hl,zFM3FreqShiftTable
		add	a,a
		ld	c,a
		ld	b,0
		add	hl,bc
		ldi
		ldi
		pop	hl
		pop	bc
		djnz	.loop
		ex	de,hl
		dec	de
		ld	a,4Fh

zWriteFM3Settings:
	if fix_sndbugs=0
		ld	(zFM3Settings),a
	endif
		ld	c,a
		ld	a,27h
	if fix_sndbugs
		jp	zWriteFMI
	else
		call	zWriteFMI
		ret
	endif

zTrackSkip3bytes:
		inc	de
		inc	de
		inc	de
		ret

zFM3FreqShiftTable:
		dw	0
		dw	132h
		dw	18Eh
		dw	1E4h
		dw	234h
		dw	27Eh
		dw	2C2h
		dw	2F0h

cfMetaCF:
		ld	hl,zExtraCoordFlagSwitchTable
		rst	zPointerTableOffset
		inc	de
		ld	a,(de)
		jp	(hl)

cfSetTempo:
		ld	(zCurrentTempo),a
		ret

cfPlaySoundByIndex:
		push	ix
		call	zPlaySoundByIndex
		pop	ix
		ret

cfHaltSound:
		ld	(zHaltFlag),a
		or	a
		jr	z,.resume
		push	ix
		push	de
		ld	ix,zTracksStart
		ld	b,(zTracksEnd-zTracksStart)/zTrack.len
		ld	de,zTrack.len

.loop:
		res	7,(ix+zTrack.PlaybackControl)
		call	zKeyOff
		add	ix,de
		djnz	.loop
		pop	de
		pop	ix
		jp	zPSGSilenceAll

.resume:
		push	ix
		push	de
		ld	ix,zTracksStart
		ld	b,(zTracksEnd-zTracksStart)/zTrack.len
		ld	de,zTrack.len

.loop2:
		set	7,(ix+zTrack.PlaybackControl)
		add	ix,de
		djnz	.loop2
		pop	de
		pop	ix
		ret

cfCopyData:
		ex	de,hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl
		ld	c,(hl)
		ld	b,0
		inc	hl
		ex	de,hl
		ldir
		dec	de
		ret

cfSetTempoDivider:
		ld	b,(zTracksEnd-zTracksStart)/zTrack.len
		ld	hl,zTracksStart+zTrack.TempoDivider

.loop:
		push	bc
		ld	bc,zTrack.len
		ld	(hl),a
		add	hl,bc
		pop	bc
		djnz	.loop
		ret

cfSetSSGEG:
		ld	(ix+zTrack.FMVolEnv),80h
		ld	(ix+zTrack.SSGEGPointerLow),e
		ld	(ix+zTrack.SSGEGPointerHigh),d

zSendSSGEGData:
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; This has the potential effect of weird sound, even in real hardware.
	if fix_sndbugs
		; This fix is even better than what is done in Ristar's sound driver:
		; we preserve rate scaling, whereas that driver sets it to 0.
		ld	l, (ix+zTrack.TLPtrLow)				; l = low byte of pointer to TL data
		ld	h, (ix+zTrack.TLPtrHigh)			; hl = pointer to TL data
		ld	bc, zFMInstrumentRSARTable-zFMInstrumentTLTable	; bc = -10h
		add	hl, bc						; hl = pointer to RS/AR data
		push	hl						; Save hl (**)
	endif
		ld	hl,zFMInstrumentSSGEGTable
		ld	b,zFMInstrumentSSGEGTable_End-zFMInstrumentSSGEGTable

.loop:
		ld	a,(de)
		inc	de
		ld	c,a
		ld	a,(hl)
	if fix_sndbugs
		call	zWriteFMIorII	; Send data to correct channel
		ex	(sp), hl	; Save hl, hl = pointer to RS/AR data (see line marked (**) above)
		ld	a, (hl)		; a = RS/AR value for operator
		inc	hl		; Advance pointer
		ex	(sp), hl	; Save hl, hl = pointer to registers for SSG-EG data
		or	1Fh		; Set AR to maximum, but keep RS intact
		ld	c, a		; c = RS/AR
		ld	a, (hl)		; a = register to send to
		sub	40h		; Convert into command to set RS/AR
	endif
		inc	hl
		call	zWriteFMIorII
		djnz	.loop
	if fix_sndbugs
		pop	hl		; Remove from stack (see line marked (**) above)
	endif
		dec	de
		ret

cfFMVolEnv:
		ld	(ix+zTrack.FMVolEnv),a
		inc	de
		ld	a,(de)
		ld	(ix+zTrack.FMVolEnvMask),a
		ret

zUpdatePSGTrack:
	if fix_sndbugs
		dec	(ix+zTrack.DurationTimeout)	; Run note timer
	else
		call	zTrackRunTimer			; Run note timer
	endif
		jr	nz,.noteGoing
		call	zGetNextNote
		bit	4,(ix+zTrack.PlaybackControl)
		ret	nz
		call	zPrepareModulation
		jr	.skipFill

.noteGoing:
		ld	a,(ix+zTrack.NoteFillTimeout)
		or	a
		jr	z,.skipFill
		dec	(ix+zTrack.NoteFillTimeout)
		jp	z,zRestTrack

.skipFill:
		call	zUpdateFreq
		call	zDoModulation
		bit	2,(ix+zTrack.PlaybackControl)
		ret	nz
		ld	c,(ix+zTrack.VoiceControl)
		ld	a,l
		and	0Fh
		or	c
		ld	(zPSG),a
		ld	a,l
		and	0F0h
		or	h
		rrca
		rrca
		rrca
		rrca
		ld	(zPSG),a
		ld	a,(ix+zTrack.VoiceIndex)
		or	a
		ld	c,0
		jr	z,.noVolEnv
		dec	a
		ld	c,zID_VolEnvPointers
		rst	zGetPointerTable
		rst	zPointerTableOffset
		call	zDoVolEnv
		ld	c,a

.noVolEnv:
		bit	4,(ix+zTrack.PlaybackControl)
		ret	nz
		ld	a,(ix+zTrack.Volume)
		add	a,c
		bit	4,a
		jr	z,.noUnderflow
		ld	a,0Fh

.noUnderflow:
		or	(ix+zTrack.VoiceControl)
		add	a,10h
		bit	0,(ix+zTrack.PlaybackControl)
	if fix_sndbugs
		jr	z, .not_noise			; Branch if not
		add	a, 20h				; Change to noise channel
.not_noise:
		ld	(zPSG), a			; Set noise channel volume
		ret
	else
		jr	nz, .set_noise			; Branch if yes
		ld	(zPSG), a			; Set PSG volume
		ret
; ---------------------------------------------------------------------------
.set_noise:
		add	a, 20h				; Change to noise channel
		ld	(zPSG), a			; Set noise channel volume
		ret
	endif

zDoVolEnvSetValue:
		ld	(ix+zTrack.VolEnv),a

zDoVolEnv:
		push	hl
		ld	c,(ix+zTrack.VolEnv)
		ld	b,0
		add	hl,bc
	if fix_sndbugs
		ld	c, l
		ld	b, h
		ld	a, (bc)				; a = PSG volume envelope
	else
		ld	a, (hl)				; a = PSG flutter value
	endif
		pop	hl
		bit	7,a
		jr	z,zDoVolEnvAdvance
		cp	83h
		jr	z,zDoVolEnvFullRest
		cp	81h
		jr	z,zDoVolEnvRest
		cp	80h
		jr	z,zDoVolEnvReset
		inc	bc
		ld	a,(bc)
		jr	zDoVolEnvSetValue

zDoVolEnvFullRest:
	if fix_sndbugs=0
		; zRestTrack already does this.
		set	4,(ix+zTrack.PlaybackControl)
	endif
		pop	hl
		jp	zRestTrack

zDoVolEnvReset:
		xor	a
		jr	zDoVolEnvSetValue

zDoVolEnvRest:
		pop	hl
		set	4,(ix+zTrack.PlaybackControl)
		ret

zDoVolEnvAdvance:
		inc	(ix+zTrack.VolEnv)
		ret

zRestTrack:
		set	4,(ix+zTrack.PlaybackControl)
		bit	2,(ix+zTrack.PlaybackControl)
		ret	nz

zSilencePSGChannel:
		ld	a,1Fh
		add	a,(ix+zTrack.VoiceControl)
		or	a
		ret	p
		ld	(zPSG),a
	if fix_sndbugs
		cp	0DFh				; Was this PSG3?
		ret	nz				; Return if not
	else
		; This does not work as intended: since this function is called when
		; a new channel is starting, this bit will almost inevitably be 0
		; and the noise channel will not be silenced.
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?
		ret	z				; Return if not
	endif
		ld	a,0FFh
		ld	(zPSG),a
		ret

zPlayDigitalAudio:
		di
		ld	a,2Bh
		ld	c,0
		call	zWriteFMI

.DACIdleLoop:
		ei
		ld	a,(zPlaySegaPCMFlag)
		or	a
		jp	nz,zPlaySEGAPCM
		ld	a,(zDACIndex)
		or	a
		jr	z,.DACIdleLoop
		ld	a,2Bh
		ld	c,80h
		di
		call	zWriteFMI
		ei
		ld	iy,DecTable
		ld	hl,zDACIndex
		ld	a,(hl)
		dec	a
		set	7,(hl)
		ld	hl,zROMWindow
		rst	zPointerTableOffset
		ld	c,80h
		ld	a,(hl)
		ld	(.sample1Rate+1),a
		ld	(.sample2Rate+1),a
		inc	hl
		ld	e,(hl)
		inc	hl
		ld	d,(hl)
		inc	hl
		ld	a,(hl)
		inc	hl
		ld	h,(hl)
		ld	l,a

.DACPlaybackLoop:
.sample1Rate:
		ld	b,0Ah				; 7
		ei						; 4
		djnz	$				; 8

		di						; 4
		ld	a,2Ah				; 7
		ld	(zYM2612_A0),a		; 13
		ld	a,(hl)				; 7+3
		rlca					; 4
		rlca					; 4
		rlca					; 4
		rlca					; 4
		and	0Fh					; 7
		ld	(.sample1Index+2),a	; 13
		ld	a,c					; 4

.sample1Index:
		add	a,(iy+0)			; 19
		ld	(zYM2612_D0),a		; 13
		ld	c,a					; 4

.sample2Rate:
		ld	b,0Ah				; 7
		ei						; 4
		djnz	$				; 8

		di						; 4
		ld	a,2Ah				; 7
		ld	(zYM2612_A0),a		; 13
		ld	a,(hl)				; 7+3
		and	0Fh					; 7
		ld	(.sample2Index+2),a	; 13
		ld	a,c					; 4

.sample2Index:
		add	a,(iy+0)			; 19
		ld	(zYM2612_D0),a		; 13
		ei						; 4
		ld	c,a					; 4
		ld	a,(zDACIndex)		; 13
		or	a					; 4
		jp	p,.DACIdleLoop		; 10

		inc	hl					; 6
		dec	de					; 6
		ld	a,d					; 4
		or	e					; 4
		jp	nz,.DACPlaybackLoop	; 10
								; 303 cycles in total
		xor	a
		ld	(zDACIndex),a
		jp	zPlayDigitalAudio

DecTable:
		db	0
		db	1
		db	2
		db	4
		db	8
		db	10h
		db	20h
		db	40h
		db	80h
		db	-1
		db	-2
		db	-4
		db	-8
		db	-10h
		db	-20h
		db	-40h

zPlaySEGAPCM:
		di
		ld	a,2Bh
		ld	(zYM2612_A0),a
	if fix_sndbugs=0
		nop
	endif
		ld	a,80h
		ld	(zYM2612_D0),a

		; Sega PCM bankswitch
		bankswitch SEGABank
		ld	hl,zmake68kPtr(SEGA_PCM_Data)
		ld	de,SEGA_PCM_Data_End-SEGA_PCM_Data
		ld	a,2Ah
		ld	(zYM2612_A0),a

.loop:
		ld	a,(hl)				; 7+3
		ld	(zYM2612_D0),a		; 13
		ld	b,pcmLoopCounter(16000)	; 7
		djnz	$				; 8
		inc	hl					; 6
		dec	de					; 6
		ld	a,d					; 4
		or	e					; 4
		jp	nz,.loop			; 10
								; 68 cycles in total
		xor	a
		ld	(zPlaySegaPCMFlag),a
	if fix_sndbugs=0
		call	zStopAllSound
	endif
		jp	zPlayDigitalAudio

		binclude	"data\star trek\part9.bin"

	if $ > 1200h
		fatal "Your Z80 code won't fit before its tables. It's \{$-1200h}h bytes past the start of music data \{1200h}h"
	endif

; zloc_1200:
z80_SoundDriverPointers:
		dw	z80_SoundPriority		; in the final, this is a duplicate of z80_MusicPointers
		dw	Z80_Driver_End-Z80_Driver	; in the final, this is used by the Universal Voice Bank
		dw	z80_MusicPointers
		dw	z80_SFXPointers
		dw	z80_ModEnvPointers
		dw	z80_VolEnvPointers
		dw	mus__End				; song limit, not actually used

z80_ModEnvPointers:
		dw	ModEnv_00
		dw	ModEnv_01
		dw	ModEnv_02
		dw	ModEnv_03
		dw	ModEnv_04
		dw	ModEnv_05
		dw	ModEnv_06
		dw	ModEnv_07
		dw	ModEnv_08
		dw	ModEnv_09

ModEnv_00:	db	40h, 60h, 70h, 60h, 50h, 30h, 10h,-10h,-30h,-50h,-70h, 83h
ModEnv_01:	db	0, 2, 4, 6, 8, 0Ah, 0Ch, 0Eh, 10h, 12h, 14h, 18h, 81h
ModEnv_02:	db	0, 0, 1, 3, 1, 0,-1,-3,-1, 0, 82h, 2
ModEnv_03:	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db	0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 0Ah, 0Ch, 0Ah, 8
		db	6, 4, 2, 0,-2,-4,-6,-8,-0Ah,-0Ch,-0Ah,-8,-6,-4,-2, 0
		db	82h, 29h
ModEnv_04:	db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   2,   4,   6,   8
		db  0Ah, 0Ch, 0Ah,   8,   6,   4,   2,   0,-2,-4,-6,-8,-0Ah,-0Ch,-0Ah,-8
		db -6,-4,-2, 82h, 1Bh
ModEnv_05:	db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    0,   0,   3,   6,   3,   0,-3,-6,-6,-3,   0, 82h, 33h
ModEnv_06:	db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    2,   4,   2,   0,-2,-4,-2,   0, 82h, 11h
ModEnv_07:	db -2,-1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
		db    0,   0,   1,   1,   0,   0,-1,-1, 82h, 11h
ModEnv_08:	db    3,   2,   1,   0,   0,   0,   1, 81h
ModEnv_09:	db    0,   0,   0,   0,   1,   1,   1,   1,   2,   2,   1,   1,   1,   0,   0,   0
		db  84h,   1, 82h,   4
z80_VolEnvPointers:
		dw	VolEnv_00
		dw	VolEnv_01
		dw	VolEnv_02
		dw	VolEnv_03
		dw	VolEnv_04
		dw	VolEnv_05
		dw	VolEnv_06
		dw	VolEnv_07
		dw	VolEnv_08
		dw	VolEnv_09
		dw	VolEnv_0A
		dw	VolEnv_0B
		dw	VolEnv_0C
		dw	VolEnv_0D
		dw	VolEnv_0E
		dw	VolEnv_0F
		dw	VolEnv_10
		dw	VolEnv_11
		dw	VolEnv_12
		dw	VolEnv_13
		dw	VolEnv_14
		dw	VolEnv_15
		dw	VolEnv_16
		dw	VolEnv_17
		dw	VolEnv_18
		dw	VolEnv_19
		dw	VolEnv_1A
		dw	VolEnv_1B
		dw	VolEnv_1C
		dw	VolEnv_1D
		dw	VolEnv_1E
		dw	VolEnv_1F
		dw	VolEnv_20
		dw	VolEnv_21
		dw	VolEnv_22
		dw	VolEnv_23
		dw	VolEnv_24

		; DANGER! There is no pointer for VolEnv_25 here, thankfully no song in the prototype uses this.
		; Trying to play VolEnv_25 (sTone_26 in SMPS2ASM) will cause the driver to read this unused Star Trek data,
		; which thankfully doesn't crash the game, just plays a random note.
		; Side note there is also no VolEnv_26 (sTone_27 in SMPS2ASM) in this driver.

		binclude	"data\star trek\part10.bin"

VolEnv_00:	db	2, 83h
VolEnv_01:	db	0, 2, 4, 6, 8, 10h, 83h
VolEnv_02:	db	2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
		db	2, 3, 3, 3, 4, 4, 4, 5, 81h
VolEnv_03:	db	0, 0, 2, 3, 4, 4, 5, 5, 5, 6, 6, 81h
VolEnv_04:	db	3, 0, 1, 1, 1, 2, 3, 4, 4, 5, 81h
VolEnv_05:	db	0, 0, 1, 1, 2, 3, 4, 5, 5, 6, 8, 7, 7, 6, 81h
VolEnv_06:	db	1, 0Ch, 3, 0Fh, 2, 7, 3, 0Fh, 80h
VolEnv_07:	db	0, 0, 0, 2, 3, 3, 4, 5, 6, 7, 8, 9, 0Ah, 0Bh, 0Eh, 0Fh
		db	83h
VolEnv_08:	db	3, 2, 1, 1, 0, 0, 1, 2, 3, 4, 81h
VolEnv_09:	db	1, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4
		db	4, 4, 5, 5, 81h
VolEnv_0A:	db	10h, 20h, 30h, 40h, 30h, 20h, 10h, 0,-10h, 80h
VolEnv_0B:	db	0, 0, 1, 1, 3, 3, 4, 5, 83h
VolEnv_0C:	db	0, 81h
VolEnv_0D:	db	2, 83h
VolEnv_0E:	db	0, 2, 4, 6, 8, 10h, 83h
VolEnv_0F:	db	9, 9, 9, 8, 8, 8, 7, 7, 7, 6, 6, 6, 5, 5, 5, 4
		db	4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0, 81h
VolEnv_10:	db	1, 1, 1, 0, 0, 0, 81h
VolEnv_11:	db	3, 0, 1, 1, 1, 2, 3, 4, 4, 5, 81h
VolEnv_12:	db	0, 0, 1, 1, 2, 3, 4, 5, 5, 6, 8, 7, 7, 6, 81h
VolEnv_13:	db	0Ah, 5, 0, 4, 8, 83h
VolEnv_14:	db	0, 0, 0, 2, 3, 3, 4, 5, 6, 7, 8, 9, 0Ah, 0Bh, 0Eh, 0Fh
		db	83h
VolEnv_15:	db	3, 2, 1, 1, 0, 0, 1, 2, 3, 4, 81h
VolEnv_16:	db	1, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4
		db	4, 4, 5, 5, 81h
VolEnv_17:	db	10h, 20h, 30h, 40h, 30h, 20h, 10h, 0, 10h, 20h, 30h, 40h, 30h, 20h, 10h, 0
		db	10h, 20h, 30h, 40h, 30h, 20h, 10h, 0, 80h
VolEnv_18:	db	0, 0, 1, 1, 3, 3, 4, 5, 83h
VolEnv_19:	db	0, 2, 4, 6, 8, 16h, 83h
VolEnv_1A:	db	0, 0, 1, 1, 3, 3, 4, 5, 83h
VolEnv_1B:	db	4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1
		db	83h
VolEnv_1C:	db	0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3
		db	4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7
		db	8, 8, 8, 8, 9, 9, 9, 9, 0Ah, 0Ah, 0Ah, 0Ah, 81h
VolEnv_1D:	db	0, 0Ah, 83h
VolEnv_1E:	db	0, 2, 4, 81h
VolEnv_1F:	db	30h, 20h, 10h, 0, 0, 0, 0, 0, 8, 10h, 20h, 30h, 81h
VolEnv_20:	db	0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 6, 6, 6, 8, 8
		db	0Ah, 83h
VolEnv_21:	db	0, 2, 3, 4, 6, 7, 81h
VolEnv_22:	db	2, 1, 0, 0, 0, 2, 4, 7, 81h
VolEnv_23:	db	0Fh, 1, 5, 83h
VolEnv_24:	db	8, 6, 2, 3, 4, 5, 6, 7, 8, 9, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh
		db	10h, 83h
VolEnv_25:	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1
		db	1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3
		db	3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4
		db	4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6
		db	6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
		db	8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9
		db	9, 9, 9, 9, 83h

z80_SoundPriority:
		db  80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h	; $01 - $0F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $10 - $1F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $20 - $2F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $30 - $3F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $40 - $4F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $50 - $5F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $60 - $6F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $70 - $7F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $80 - $8F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $90 - $9F
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $A0 - $AF
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $B0 - $BF
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $C0 - $CF
	if fix_sndbugs
		; This table was missing entries $D0 to $FF.
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $D0 - $DF
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $E0 - $EF
		db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh	; $F0 - $FF
	endif

zmake68kPtrs macro
		irp op,ALLARGS
			dw zmake68kPtr(op)
		endm
	endm

z80_MusicPointers:
		zmake68kPtrs Angel_Island_1_Snd_Data	; $01
		zmake68kPtrs Angel_Island_2_Snd_Data	; $02
		zmake68kPtrs Hydrocity_1_Snd_Data	; $03
		zmake68kPtrs Hydrocity_2_Snd_Data	; $04
		zmake68kPtrs Marble_Garden_1_Snd_Data	; $05
		zmake68kPtrs Marble_Garden_2_Snd_Data	; $06
		zmake68kPtrs Carnival_Night_1_Snd_Data	; $07
		zmake68kPtrs Carnival_Night_2_Snd_Data	; $08
		zmake68kPtrs Flying_Battery_1_Snd_Data	; $09
		zmake68kPtrs Flying_Battery_2_Snd_Data	; $0A
		zmake68kPtrs Icecap_1_Snd_Data	; $0B
		zmake68kPtrs Icecap_2_Snd_Data	; $0C
		zmake68kPtrs Launch_Base_1_Snd_Data	; $0D
		zmake68kPtrs Launch_Base_2_Snd_Data	; $0E
		zmake68kPtrs Mushroom_Valley_1_Snd_Data	; $0F
		zmake68kPtrs Mushroom_Valley_2_Snd_Data	; $10
		zmake68kPtrs Sandopolis_1_Snd_Data	; $11
		zmake68kPtrs Sandopolis_2_Snd_Data	; $12
		zmake68kPtrs Lava_Reef_1_Snd_Data	; $13
		zmake68kPtrs Lava_Reef_2_Snd_Data	; $14
		zmake68kPtrs Sky_Sanctuary_Snd_Data	; $15
		zmake68kPtrs Death_Egg_1_Snd_Data	; $16
		zmake68kPtrs Death_Egg_2_Snd_Data	; $17
		zmake68kPtrs Mini_Boss_Snd_Data	; $18
		zmake68kPtrs Boss_Snd_Data	; $19
		zmake68kPtrs The_Doomsday_Snd_Data	; $1A
		zmake68kPtrs Glowing_Spheres_Bonus_Stage_Snd_Data	; $1B
		zmake68kPtrs Special_Stage_Snd_Data	; $1C
		zmake68kPtrs Slot_Machine_Bonus_Stage_Snd_Data	; $1D
		zmake68kPtrs Gumball_Machine_Bonus_Stage_Snd_Data	; $1E
		zmake68kPtrs Knuckles_Theme_Snd_Data	; $1F
		zmake68kPtrs Azure_Lake_Snd_Data	; $20
		zmake68kPtrs Balloon_Park_Snd_Data	; $21
		zmake68kPtrs Desert_Palace_Snd_Data	; $22
		zmake68kPtrs Chrome_Gadget_Snd_Data	; $23
		zmake68kPtrs Endless_Mine_Snd_Data	; $24
		zmake68kPtrs Title_Screen_Snd_Data	; $25
		zmake68kPtrs Credits_Snd_Data	; $26
		zmake68kPtrs Time_Game_Over_Snd_Data	; $27
		zmake68kPtrs Continue_Snd_Data	; $28
		zmake68kPtrs Level_Results_Snd_Data	; $29
		zmake68kPtrs Extra_Life_Snd_Data	; $2A
		zmake68kPtrs Got_Emerald_Snd_Data	; $2B
		zmake68kPtrs Invincibility_Snd_Data	; $2C
		zmake68kPtrs Competition_Menu_Snd_Data	; $2D
		zmake68kPtrs Super_Sonic_Theme_Snd_Data	; $2E
		zmake68kPtrs Data_Select_Menu_Snd_Data	; $2F
		zmake68kPtrs Final_Boss_Snd_Data	; $30
		zmake68kPtrs Panic_Snd_Data	; $31

z80_SFXPointers:
		zmake68kPtrs Ring_Sfx_Data    ; $32
		zmake68kPtrs Ring_Left_Speaker_Sfx_Data    ; $33
		zmake68kPtrs Ring_Lost_Sfx_Data    ; $34
		zmake68kPtrs Hurt_Sfx_Data    ; $35
		zmake68kPtrs Skidding_Sfx_Data    ; $36
		zmake68kPtrs Spike_Hurt_Sfx_Data    ; $37
		zmake68kPtrs Collect_Oxygen_Sfx_Data    ; $38
		zmake68kPtrs Water_Splash_Sfx_Data    ; $39
		zmake68kPtrs Got_Classic_Shield_Sfx_Data    ; $3A
		zmake68kPtrs Drowning_Sfx_Data    ; $3B
		zmake68kPtrs Rolling_Sfx_Data    ; $3C
		zmake68kPtrs Object_Hit_Sfx_Data    ; $3D
		zmake68kPtrs Got_Fire_Shield_Sfx_Data    ; $3E
		zmake68kPtrs Got_Water_Shield_Sfx_Data    ; $3F
		zmake68kPtrs Offset_0x0EC2D1    ; $40
		zmake68kPtrs Got_Lightning_Shield_Sfx_Data    ; $41
		zmake68kPtrs Offset_0x0EC317    ; $42
		zmake68kPtrs Fire_Shield_Sfx_Data    ; $43
		zmake68kPtrs Offset_0x0EC34A    ; $44
		zmake68kPtrs Offset_0x0EC377    ; $45
		zmake68kPtrs Hyper_Form_Change_Sfx_Data    ; $46
		zmake68kPtrs Offset_0x0EC3CC    ; $47
		zmake68kPtrs Offset_0x0EC3EC    ; $48
		zmake68kPtrs Offset_0x0EC414    ; $49
		zmake68kPtrs Grab_Sfx_Data    ; $4A
		zmake68kPtrs Offset_0x0EC438    ; $4B
		zmake68kPtrs Offset_0x0EC460    ; $4C
		zmake68kPtrs Offset_0x0EC483    ; $4D
		zmake68kPtrs Offset_0x0EC498    ; $4E
		zmake68kPtrs Waterfall_Splash_Sfx_Data    ; $4F
		zmake68kPtrs Offset_0x0EC4F1    ; $50
		zmake68kPtrs Projectile_Sfx_Data    ; $51
		zmake68kPtrs Missile_Explosion_Sfx_Data    ; $52
		zmake68kPtrs Flame_Sfx_Data    ; $53
		zmake68kPtrs Flying_Battery_Move_Sfx_Data    ; $54
		zmake68kPtrs Offset_0x0EC5D1    ; $55
		zmake68kPtrs Missile_Throw_Sfx_Data    ; $56
		zmake68kPtrs Robotnik_Buzzer_Sfx_Data    ; $57
		zmake68kPtrs Spike_Move_Sfx_Data    ; $58
		zmake68kPtrs Offset_0x0EC68E    ; $59
		zmake68kPtrs Offset_0x0EC6CE    ; $5A
		zmake68kPtrs Offset_0x0EC711    ; $5B
		zmake68kPtrs Draw_Bridge_Move_Sfx_Data    ; $5C
		zmake68kPtrs Geyser_Sfx_Data    ; $5D
		zmake68kPtrs Fan_Big_Sfx_Data    ; $5E
		zmake68kPtrs Offset_0x0EC794    ; $5F
		zmake68kPtrs Offset_0x0EC7C5    ; $60
		zmake68kPtrs Offset_0x0EC7DD    ; $61
		zmake68kPtrs Smash_Sfx_Data    ; $62
		zmake68kPtrs Offset_0x0EC852    ; $63
		zmake68kPtrs Switch_Blip_Sfx_Data    ; $64
		zmake68kPtrs Offset_0x0EC88C    ; $65
		zmake68kPtrs Offset_0x0EC89B    ; $66
		zmake68kPtrs Offset_0x0EC8C3    ; $67
		zmake68kPtrs Floor_Thump_Sfx_Data    ; $68
		zmake68kPtrs Offset_0x0EC922    ; $69
		zmake68kPtrs Offset_0x0EC94A    ; $6A
		zmake68kPtrs Offset_0x0EC97C    ; $6B
		zmake68kPtrs Crash_Sfx_Data    ; $6C
		zmake68kPtrs Offset_0x0EC9BF    ; $6D
		zmake68kPtrs Offset_0x0ECA00    ; $6E
		zmake68kPtrs Offset_0x0ECA00    ; $6F
		zmake68kPtrs Jump_Sfx_Data    ; $70
		zmake68kPtrs Offset_0x0ECA47    ; $71
		zmake68kPtrs Offset_0x0ECA71    ; $72
		zmake68kPtrs Offset_0x0ECA90    ; $73
		zmake68kPtrs Offset_0x0ECAC2    ; $74
		zmake68kPtrs Level_Projectile_Sfx_Data    ; $75
		zmake68kPtrs Offset_0x0ECB23    ; $76
		zmake68kPtrs Offset_0x0ECB52    ; $77
		zmake68kPtrs Offset_0x0ECB7F    ; $78
		zmake68kPtrs Underwater_Sfx_Data    ; $79
		zmake68kPtrs Offset_0x0ECBC4    ; $7A
		zmake68kPtrs Offset_0x0ECC05    ; $7B
		zmake68kPtrs Boss_Hit_Sfx_Data    ; $7C
		zmake68kPtrs Offset_0x0ECC58    ; $7D
		zmake68kPtrs Offset_0x0ECC8E    ; $7E
		zmake68kPtrs Offset_0x0ECCD8    ; $7F
		zmake68kPtrs Hoverpad_Sfx_Data    ; $80
		zmake68kPtrs Transporter_Sfx_Data    ; $81
		zmake68kPtrs Tunnel_Booster_Sfx_Data    ; $82
		zmake68kPtrs Rising_Platform_Sfx_Data    ; $83
		zmake68kPtrs Wave_Hover_Sfx_Data    ; $84
		zmake68kPtrs Trapdoor_Sfx_Data    ; $85
		zmake68kPtrs Balloon_Pop_Sfx_Data    ; $86
		zmake68kPtrs Cannon_Turn_Sfx_Data    ; $87
		zmake68kPtrs Offset_0x0ECE99    ; $88
		zmake68kPtrs Offset_0x0ECEC6    ; $89
		zmake68kPtrs Offset_0x0ECF11    ; $8A
		zmake68kPtrs Small_Bumper_Sfx_Data    ; $8B
		zmake68kPtrs Offset_0x0ECF75    ; $8C
		zmake68kPtrs Offset_0x0ECFA6    ; $8D
		zmake68kPtrs Offset_0x0ECFD3    ; $8E
		zmake68kPtrs Offset_0x0ECFE4    ; $8F
		zmake68kPtrs Offset_0x0ECFFC    ; $90
		zmake68kPtrs Frost_Puff_Sfx_Data    ; $91
		zmake68kPtrs Ice_Spike_Sfx_Data    ; $92
		zmake68kPtrs Offset_0x0ED07F    ; $93
		zmake68kPtrs Offset_0x0ED0B2    ; $94
		zmake68kPtrs Tube_Launcher_Sfx_Data    ; $95
		zmake68kPtrs Offset_0x0ED12F    ; $96
		zmake68kPtrs Bridge_Collapse_Sfx_Data    ; $97
		zmake68kPtrs Offset_0x0ED199    ; $98
		zmake68kPtrs Offset_0x0ED1D1    ; $99
		zmake68kPtrs Offset_0x0ED1FE    ; $9A
		zmake68kPtrs Buzzer_Sfx_Data    ; $9B
		zmake68kPtrs Offset_0x0ED258    ; $9C
		zmake68kPtrs Offset_0x0ED288    ; $9D
		zmake68kPtrs Offset_0x0ED2AE    ; $9E
		zmake68kPtrs Offset_0x0ED2D4    ; $9F
		zmake68kPtrs Offset_0x0ED30A    ; $A0
		zmake68kPtrs Offset_0x0ED337    ; $A1
		zmake68kPtrs Offset_0x0ED344    ; $A2
		zmake68kPtrs Offset_0x0ED378    ; $A3
		zmake68kPtrs Offset_0x0ED3AE    ; $A4
		zmake68kPtrs Offset_0x0ED3E2    ; $A5
		zmake68kPtrs Offset_0x0ED413    ; $A6
		zmake68kPtrs Offset_0x0ED42D    ; $A7
		zmake68kPtrs Offset_0x0ED45E    ; $A8
		zmake68kPtrs Offset_0x0ED494    ; $A9
		zmake68kPtrs Door_Close_Sfx_Data    ; $AA
		zmake68kPtrs Offset_0x0ED4FC    ; $AB
		zmake68kPtrs Offset_0x0ED530    ; $AC
		zmake68kPtrs Offset_0x0ED57A    ; $AD
		zmake68kPtrs Offset_0x0ED5A9    ; $AE
		zmake68kPtrs Offset_0x0ED5DC    ; $AF
		zmake68kPtrs Slide_Thunk_Sfx_Data    ; $B0
		zmake68kPtrs Offset_0x0ED63F    ; $B1
		zmake68kPtrs Offset_0x0ED652    ; $B2
		zmake68kPtrs Offset_0x0ED688    ; $B3
		zmake68kPtrs Offset_0x0ED6D4    ; $B4
		zmake68kPtrs Offset_0x0ED6EA    ; $B5
		zmake68kPtrs Offset_0x0ED720    ; $B6
		zmake68kPtrs Offset_0x0ED73F    ; $B7
		zmake68kPtrs Offset_0x0ED7A4    ; $B8
		zmake68kPtrs Offset_0x0ED7DB    ; $B9
		zmake68kPtrs Offset_0x0ED80F    ; $BA
		zmake68kPtrs Super_Form_Change_Sfx_Data    ; $BB
		zmake68kPtrs Offset_0x0ED88C    ; $BC
		zmake68kPtrs Offset_0x0ED8BA    ; $BD
		zmake68kPtrs Offset_0x0ED8D2    ; $BE
		zmake68kPtrs Offset_0x0ED8FA    ; $BF
		zmake68kPtrs Offset_0x0ED927    ; $C0
		zmake68kPtrs Offset_0x0ED956    ; $C1
		zmake68kPtrs Offset_0x0ED98E    ; $C2
		zmake68kPtrs Offset_0x0ED9BB    ; $C3
		zmake68kPtrs Offset_0x0ED9E8    ; $C4
		zmake68kPtrs Offset_0x0EDA15    ; $C5
		zmake68kPtrs Offset_0x0EDA42    ; $C6
		zmake68kPtrs Offset_0x0EDA6F    ; $C7
		zmake68kPtrs Offset_0x0EDA87    ; $C8
		zmake68kPtrs Energy_Zap_Sfx_Data    ; $C9
		zmake68kPtrs Offset_0x0EDAE1    ; $CA
		zmake68kPtrs Offset_0x0EDAF7    ; $CB
		zmake68kPtrs Offset_0x0EDB52    ; $CC
		zmake68kPtrs Offset_0x0EDBA3    ; $CD
		zmake68kPtrs Check_Point_Sfx_Data    ; $CE
		zmake68kPtrs Offset_0x0EDC3F    ; $CF
		zmake68kPtrs Special_Stage_Entry_Sfx_Data    ; $D0
		zmake68kPtrs Offset_0x0EDCA1    ; $D1
		zmake68kPtrs Spring_Sfx_Data    ; $D2
		zmake68kPtrs Error_Sfx_Data    ; $D3
		zmake68kPtrs Offset_0x0EDD9D    ; $D4
		zmake68kPtrs Offset_0x0EDE17    ; $D5
		zmake68kPtrs Offset_0x0EDE4B    ; $D6
		zmake68kPtrs Offset_0x0EDE73    ; $D7
		zmake68kPtrs Offset_0x0EDEB4    ; $D8
		zmake68kPtrs Offset_0x0EDEDC    ; $D9

		restore
		padding off
		!org Z80_Driver+Size_of_Snd_driver_guess	; The assembler still thinks we're in Z80 memory, so use an 'org' to switch back to the cartridge