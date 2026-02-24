s3p35_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     s3p35_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $25

	smpsHeaderDAC       s3p35_DAC
	smpsHeaderFM        s3p35_FM1,	$0C, $10
	smpsHeaderFM        s3p35_FM2,	$00, $10
	smpsHeaderFM        s3p35_FM3,	$18, $0F
	smpsHeaderFM        s3p35_FM4,	$0C, $05
	smpsHeaderFM        s3p35_FM5,	$0C, $0F
	smpsHeaderPSG       s3p35_PSG1,	$F4, $03, $00, sTone_0C
	smpsHeaderPSG       s3p35_PSG2,	$F4, $04, $00, sTone_0C
	smpsHeaderPSG       s3p35_PSG3,	$00, $02, $00, sTone_0C

; Unreachable
	smpsStop
	smpsStop

; DAC Data
s3p35_DAC:
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06
	dc.b	dKickS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $18
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $18
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06
	dc.b	dKickS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, $06, dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, $06
	dc.b	dSnareS3, $12, dKickS3, $0C, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $0C, dKickS3, $06, dKickS3, $0C, dKickS3, $0C, dKickS3, $06, dSnareS3, $18
	dc.b	dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dSnareS3, $12, dKickS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06
	dc.b	dKickS3, $0C, dSnareS3, $0C, dKickS3, $06, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06, dKickS3, $0C, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dSnareS3, $12
	dc.b	dKickS3, $0C, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C
	dc.b	dKickS3, $06, dKickS3, $0C, dKickS3, $0C, dKickS3, $06, dSnareS3, $18, dKickS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dSnareS3, $06, dKickS3, $0C, dSnareS3, $0C
	dc.b	dKickS3, $06, dSnareS3, $12, dSnareS3, $06, dKickS3, $06, dSnareS3, $0C, dSnareS3, $06
	dc.b	dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $02
	dc.b	dSnareS3, $04, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06
	dc.b	dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06
	dc.b	dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06
	dc.b	dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18
	dc.b	dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06
	dc.b	dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06
	dc.b	dKickS3, $06, dKickS3, $06, dSnareS3, $06, dSnareS3, $06, dKickS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $06
	dc.b	dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18, dKickS3, $12
	dc.b	dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06
	dc.b	dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06, dKickS3, $18
	dc.b	dKickS3, $06, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06, dSnareS3, $06
	dc.b	dKickS3, $06, dKickS3, $12, dSnareS3, $06, dKickS3, $06, dKickS3, $06, dSnareS3, $0C
	dc.b	dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $06, dKickS3, $06
	dc.b	dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18, dKickS3, $12, dKickS3, $06
	dc.b	dSnareS3, $06, dKickS3, $06, dKickS3, $18, dKickS3, $06, dKickS3, $06, dSnareS3, $18
	dc.b	dSnareS3, $12, dKickS3, $06, dSnareS3, $0C, dKickS3, $06, dKickS3, $06, dSnareS3, $12
	dc.b	dKickS3, $06, dSnareS3, $18, dSnareS3, $0C, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	dc.b	dSnareS3, $06, dSnareS3, $06, dSnareS3, $06, dKickS3, $12, dKickS3, $06, dSnareS3, $02
	dc.b	dSnareS3, $04, dSnareS3, $06, dSnareS3, $06, dSnareS3, $06
	smpsJump            s3p35_DAC

; Unreachable
	smpsStop

; FM1 Data
s3p35_FM1:
	smpsPan             panRight, $00
	smpsSetvoice        $0A
	smpsDetune          $02
	smpsModSet          $0A, $01, $03, $06

s3p35_Jump03:
	dc.b	nE3, $04, nRst, $14, nD3, $10, nRst, $02, nE3, $02, nRst, $0A
	dc.b	nC3, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $1A
	dc.b	nG2, $10, nRst, $02, nG2, $04, nRst, $0E, nG2, $22, nRst, $02
	dc.b	nG3, $16, nRst, $02, nF3, $3A, nRst, $02, nF3, $04, nRst, $14
	dc.b	nD3, $22, nRst, $02, nD4, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $02, nD4, $04, nRst, $1A, nF3, $16, nRst, $02
	dc.b	nE3, $04, nRst, $14, nD3, $10, nRst, $02, nE3, $02, nRst, $0A
	dc.b	nC3, $04, nRst, $02, nC4, $04, nRst, $02, nC4, $04, nRst, $1A
	dc.b	nG2, $10, nRst, $02, nG2, $04, nRst, $0E, nG2, $22, nRst, $02
	dc.b	nG3, $16, nRst, $02, nF3, $3A, nRst, $02, nF3, $04, nRst, $14
	dc.b	nD3, $22, nRst, $02, nD4, $04, nRst, $02, nD4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $02, nD4, $04, nRst, $1A, nF3, $16, nRst, $0E
	dc.b	nG2, $04, nRst, $02, nBb2, $0A, nRst, $02, nG2, $04, nRst, $02
	dc.b	nBb2, $22, nRst, $02, nF3, $16, nRst, $02, nF3, $10, nRst, $02
	dc.b	nEb3, $04, nRst, $0E, nEb3, $0A, nRst, $02, nC3, $10, nRst, $02
	dc.b	nEb3, $10, nRst, $02, nF3, $0A, nRst, $0E, nAb2, $04, nRst, $02
	dc.b	nC3, $0A, nRst, $02, nAb2, $04, nRst, $02, nC3, $24, nEb3, $16
	dc.b	nRst, $02, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nC3, $2E
	dc.b	nRst, $1A, nG2, $04, nRst, $02, nBb2, $0A, nRst, $02, nG2, $04
	dc.b	nRst, $02, nBb2, $22, nRst, $02, nF3, $16, nRst, $02, nF3, $10
	dc.b	nRst, $02, nEb3, $04, nRst, $0E, nEb3, $0A, nRst, $02, nC3, $10
	dc.b	nRst, $02, nEb3, $10, nRst, $02, nF3, $0A, nRst, $0E, nC3, $04
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nC3, $04, nRst, $02, nG3, $04
	dc.b	nRst, $02, nG3, $28, nRst, $02, nEb3, $04, nRst, $02, nCs3, $04
	dc.b	nRst, $08, nCs3, $04, nRst, $08, nF3, $04, nRst, $02, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $02, nF3, $04, nRst, $1A, nEb3, $16
	dc.b	nRst, $02, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $10
	dc.b	nRst, $02, nBb2, $10, nRst, $02, nC3, $04, nRst, $08, nEb3, $04
	dc.b	nRst, $08, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $10
	dc.b	nRst, $02, nF3, $04, nRst, $08, nEb3, $04, nRst, $02, nF3, $0A
	dc.b	nRst, $02, nEb3, $0A, nRst, $02, nD3, $10, nRst, $02, nD3, $04
	dc.b	nRst, $08, nD3, $04, nRst, $08, nD3, $34, nRst, $08, nD3, $04
	dc.b	nRst, $02, nF3, $04, nRst, $02, nBb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nF3, $04, nRst, $02, nBb3, $04, nRst, $02, nD4, $04
	dc.b	nRst, $08, nF4, $04, nRst, $0E, nF4, $04, nRst, $08, nF4, $04
	dc.b	nRst, $08, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $10
	dc.b	nRst, $02, nBb2, $10, nRst, $02, nC3, $04, nRst, $08, nEb3, $04
	dc.b	nRst, $08, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $10
	dc.b	nRst, $02, nF3, $04, nRst, $08, nEb3, $04, nRst, $02, nF3, $0A
	dc.b	nRst, $02, nEb3, $0A, nRst, $02, nD3, $10, nRst, $02, nD3, $04
	dc.b	nRst, $08, nD3, $04, nRst, $02, nBb3, $04, nRst, $02, nF3, $10
	dc.b	nRst, $2C, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nF3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nD4, $04, nRst, $08, nF4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $08, nBb3, $16, nRst, $02, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $0E, nF3, $10, nRst, $02, nBb2, $10, nRst, $02, nC3, $04
	dc.b	nRst, $08, nEb3, $04, nRst, $08, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $08, nEb3, $04
	dc.b	nRst, $02, nF3, $0A, nRst, $02, nEb3, $0A, nRst, $02, nD3, $10
	dc.b	nRst, $02, nD3, $04, nRst, $08, nD3, $04, nRst, $08, nD3, $34
	dc.b	nRst, $08, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nF3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nD4, $04, nRst, $08, nF4, $04, nRst, $0E, nF4, $04
	dc.b	nRst, $08, nF4, $04, nRst, $08, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $0A
	dc.b	nRst, $02, nF3, $0A, nRst, $02, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $0E, nF3, $0A
	dc.b	nRst, $02, nF3, $0A, nRst, $02, nF3, $5E, nRst, $02, nE3, $2E
	dc.b	nRst, $08, nE3, $04, nRst, $08, nC3, $04, nRst, $08, nE3, $04
	dc.b	nRst, $02, nE3, $0A, nRst, $02
	smpsJump            s3p35_Jump03

; Unreachable
	smpsStop

; FM2 Data
s3p35_FM2:
	smpsPan             panLeft, $00
	smpsSetvoice        $0A
	smpsDetune          $FE
	smpsModSet          $0A, $01, $03, $06

s3p35_Jump02:
	dc.b	nG3, $04, nRst, $14, nG3, $10, nRst, $02, nG3, $02, nRst, $0A
	dc.b	nE3, $04, nRst, $02, nE4, $04, nRst, $02, nE4, $04, nRst, $1A
	dc.b	nB2, $10, nRst, $02, nB2, $04, nRst, $0E, nC3, $22, nRst, $02
	dc.b	nB3, $16, nRst, $02, nBb3, $3A, nRst, $02, nBb3, $04, nRst, $14
	dc.b	nF3, $22, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nF4, $04, nRst, $1A, nAb3, $16, nRst, $02
	dc.b	nG3, $04, nRst, $14, nG3, $10, nRst, $02, nG3, $02, nRst, $0A
	dc.b	nE3, $04, nRst, $02, nE4, $04, nRst, $02, nE4, $04, nRst, $1A
	dc.b	nB2, $10, nRst, $02, nB2, $04, nRst, $0E, nC3, $22, nRst, $02
	dc.b	nB3, $16, nRst, $02, nBb3, $3A, nRst, $02, nBb3, $04, nRst, $14
	dc.b	nF3, $22, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nF4, $04, nRst, $1A, nAb3, $16, nRst, $0E
	dc.b	nE3, $04, nRst, $02, nF3, $0A, nRst, $02, nE3, $04, nRst, $02
	dc.b	nF3, $22, nRst, $02, nBb3, $16, nRst, $02, nC4, $10, nRst, $02
	dc.b	nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nC3, $04, nRst, $02
	dc.b	nEb3, $0A, nRst, $02, nC3, $04, nRst, $02, nEb3, $24, nAb3, $16
	dc.b	nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nF3, $2E
	dc.b	nRst, $1A, nE3, $04, nRst, $02, nF3, $0A, nRst, $02, nE3, $04
	dc.b	nRst, $02, nF3, $22, nRst, $02, nBb3, $16, nRst, $02, nC4, $10
	dc.b	nRst, $02, nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10
	dc.b	nRst, $02, nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nEb3, $04
	dc.b	nRst, $02, nBb3, $0A, nRst, $02, nEb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $02, nBb3, $28, nRst, $02, nG3, $04, nRst, $02, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $08, nBb3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $08, nBb3, $04, nRst, $02, nC4, $04, nRst, $1A, nA3, $16
	dc.b	nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nEb3, $10, nRst, $02, nF3, $04, nRst, $08, nG3, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nA3, $04, nRst, $08, nG3, $04, nRst, $02, nA3, $0A
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $08, nBb3, $34, nRst, $08, nF3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04
	dc.b	nRst, $08, nBb4, $04, nRst, $0E, nA4, $04, nRst, $08, nBb4, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nEb3, $10, nRst, $02, nF3, $04, nRst, $08, nG3, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nA3, $04, nRst, $08, nG3, $04, nRst, $02, nA3, $0A
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $02, nD4, $04, nRst, $02, nBb3, $10
	dc.b	nRst, $02, nF4, $04, nRst, $02, nG4, $04, nRst, $02, nF4, $0A
	dc.b	nRst, $02, nEb4, $04, nRst, $02, nD4, $0A, nRst, $02, nF3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04
	dc.b	nRst, $08, nA4, $04, nRst, $02, nF4, $04, nRst, $08, nD4, $16
	dc.b	nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nEb3, $10, nRst, $02, nF3, $04, nRst, $08, nG3, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nA3, $04, nRst, $08, nG3, $04, nRst, $02, nA3, $0A
	dc.b	nRst, $02, nG3, $0A, nRst, $02, nF3, $10, nRst, $02, nF3, $04
	dc.b	nRst, $08, nF3, $04, nRst, $08, nBb3, $34, nRst, $08, nF3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04
	dc.b	nRst, $08, nBb4, $04, nRst, $0E, nA4, $04, nRst, $08, nBb4, $04
	dc.b	nRst, $08, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nC4, $04, nRst, $0E, nC4, $0A, nRst, $02, nC4, $0A
	dc.b	nRst, $02, nC4, $10, nRst, $02, nC4, $04, nRst, $0E, nC4, $10
	dc.b	nRst, $02, nC4, $04, nRst, $0E, nC4, $0A, nRst, $02, nC4, $0A
	dc.b	nRst, $02, nC4, $5E, nRst, $02, nC4, $2E, nRst, $08, nG3, $04
	dc.b	nRst, $08, nE3, $04, nRst, $08, nG3, $04, nRst, $02, nG3, $0A
	dc.b	nRst, $02
	smpsJump            s3p35_Jump02

; Unreachable
	smpsStop

; FM3 Data
s3p35_FM3:
	smpsSetvoice        $14
	smpsDetune          $00
	smpsModSet          $02, $01, $01, $02

s3p35_Jump01:
	dc.b	nA0, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $04, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA0, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $04, nRst, $02, nE1, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $04, nRst, $02, nE1, $04, nRst, $02, nA0, $0A, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA1, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nA0, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $04, nRst, $02
	dc.b	nE1, $04, nRst, $02, nA0, $0A, nRst, $02, nE1, $04, nRst, $02
	dc.b	nA1, $0A, nRst, $02, nE1, $04, nRst, $02, nA1, $0A, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb0, $0A, nRst, $02, nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nAb0, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $04, nRst, $02, nEb1, $04, nRst, $02, nAb0, $0A, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nAb1, $0A, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nAb1, $0A, nRst, $02, nD1, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $10, nRst, $02
	dc.b	nD2, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $0A, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $10, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nC1, $04, nRst, $02, nC1, $0A, nRst, $02
	dc.b	nC1, $04, nRst, $02, nC1, $10, nRst, $02, nC2, $0A, nRst, $02
	dc.b	nC1, $04, nRst, $02, nC1, $0A, nRst, $02, nC1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $10, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nD1, $0A, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $10, nRst, $02, nD2, $0A, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $0A, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $10, nRst, $02, nCs1, $0A, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $0A, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nC1, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $0A, nRst, $02, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nEb2, $04, nRst, $02, nCs2, $04, nRst, $02
	dc.b	nC2, $04, nRst, $02, nBb1, $04, nRst, $02, nAb1, $04, nRst, $02
	dc.b	nG1, $04, nRst, $02, nFs1, $04, nRst, $08, nFs1, $04, nRst, $08
	dc.b	nFs1, $04, nRst, $02, nFs1, $04, nRst, $08, nFs1, $04, nRst, $02
	dc.b	nAb1, $04, nRst, $1A, nF1, $16, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02, nD2, $04, nRst, $02
	dc.b	nEb2, $10, nRst, $08, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nBb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $08
	dc.b	nEb2, $0A, nRst, $02, nD2, $04, nRst, $02, nEb2, $10, nRst, $08
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $08, nD2, $0A, nRst, $02
	dc.b	nC2, $04, nRst, $02, nD2, $10, nRst, $08, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD2, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $08, nD2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nD2, $10, nRst, $08, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD2, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $08
	dc.b	nEb2, $0A, nRst, $02, nD2, $04, nRst, $02, nEb2, $10, nRst, $08
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02
	dc.b	nD2, $04, nRst, $02, nEb2, $10, nRst, $08, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nBb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $08, nD2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nD2, $10, nRst, $08, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD2, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $08
	dc.b	nD2, $0A, nRst, $02, nC2, $04, nRst, $02, nD2, $10, nRst, $08
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02
	dc.b	nD2, $04, nRst, $02, nEb2, $10, nRst, $08, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nBb1, $04, nRst, $02, nBb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $08, nEb2, $0A, nRst, $02, nD2, $04, nRst, $02
	dc.b	nEb2, $10, nRst, $08, nEb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nBb1, $04, nRst, $02, nBb1, $04, nRst, $02, nEb1, $04, nRst, $02
	dc.b	nEb1, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $08
	dc.b	nD2, $0A, nRst, $02, nC2, $04, nRst, $02, nD2, $10, nRst, $08
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD2, $04, nRst, $02, nD1, $04, nRst, $02, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $08, nD2, $0A, nRst, $02
	dc.b	nC2, $04, nRst, $02, nD2, $10, nRst, $08, nD1, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD2, $04, nRst, $02, nD2, $04, nRst, $02
	dc.b	nD1, $04, nRst, $02, nD1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $08, nCs2, $0A, nRst, $02, nC2, $04, nRst, $02
	dc.b	nCs2, $10, nRst, $08, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs2, $04, nRst, $02, nCs2, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $08
	dc.b	nCs2, $0A, nRst, $02, nC2, $04, nRst, $02, nCs2, $10, nRst, $08
	dc.b	nCs1, $04, nRst, $02, nCs1, $04, nRst, $02, nCs2, $04, nRst, $02
	dc.b	nCs2, $04, nRst, $02, nCs1, $04, nRst, $02, nCs1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $02
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC2, $04, nRst, $08
	dc.b	nC1, $04, nRst, $08, nC1, $04, nRst, $02, nC1, $04, nRst, $02
	dc.b	nC1, $04, nRst, $02, nG1, $04, nRst, $02, nC2, $04, nRst, $02
	smpsJump            s3p35_Jump01

; Unreachable
	smpsStop

; FM4 Data
s3p35_FM4:
	smpsSetvoice        $0C
	smpsDetune          $02
	smpsModSet          $0F, $01, $07, $07

s3p35_Jump00:
	dc.b	nC4, $04, nRst, $14, nB3, $10, nRst, $02, nC4, $04, nRst, $0E
	dc.b	nA3, $16, nRst, $02, nB3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $22, nRst, $02, nC4, $04, nRst, $02, nB3, $04, nRst, $02
	dc.b	nA3, $16, nRst, $02, nG3, $04, nRst, $02, nA3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $34, nRst, $08
	dc.b	nD4, $04, nRst, $14, nBb3, $34, nRst, $0E, nC3, $04, nRst, $02
	dc.b	nD3, $04, nRst, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $04, nRst, $14, nB3, $10, nRst, $02, nC4, $04, nRst, $0E
	dc.b	nA3, $16, nRst, $02, nB3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $22, nRst, $02, nC4, $04, nRst, $02, nB3, $04, nRst, $02
	dc.b	nA3, $16, nRst, $02, nG3, $04, nRst, $02, nA3, $04, nRst, $02
	dc.b	nB3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $34, nRst, $08
	dc.b	nD4, $04, nRst, $14, nBb3, $34, nRst, $0E, nC3, $04, nRst, $02
	dc.b	nD3, $04, nRst, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $52, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nAb3, $10, nRst, $02, nG3, $04, nRst, $0E, nG3, $0A, nRst, $02
	dc.b	nF3, $10, nRst, $02, nG3, $10, nRst, $02, nAb3, $0A, nRst, $02
	dc.b	nAb3, $22, nRst, $02, nEb3, $2E, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $22, nRst, $02, nAb3, $16, nRst, $0E
	dc.b	nG3, $0A, nRst, $02, nAb3, $04, nRst, $02, nBb3, $04, nRst, $02
	dc.b	nC4, $52, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst, $02
	dc.b	nAb3, $10, nRst, $02, nG3, $04, nRst, $0E, nG3, $0A, nRst, $02
	dc.b	nF3, $10, nRst, $02, nG3, $10, nRst, $02, nAb3, $0A, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nBb3, $04, nRst, $02, nEb4, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $28, nRst, $02
	dc.b	nG3, $04, nRst, $02, nBb3, $04, nRst, $08, nBb3, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nCs4, $04, nRst, $08, nCs4, $04, nRst, $02
	dc.b	nC4, $04, nRst, $02, nBb3, $02, nAb3, $02, nFs3, $02, nF3, $02
	dc.b	nEb3, $02, nCs3, $02, nC3, $02, nBb2, $02, nAb2, $02, nFs2, $02
	dc.b	nF2, $02, nEb2, $02, nEb3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nG3, $04, nRst, $02, nA3, $04, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nC4, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02
	dc.b	nBb3, $28, nRst, $02, nF3, $34, nRst, $38, nBb4, $04, nRst, $0E
	dc.b	nA4, $04, nRst, $08, nBb4, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $04, nRst, $08, nBb3, $04, nRst, $02
	dc.b	nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02, nBb3, $1C, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nF4, $04, nRst, $02, nD4, $10, nRst, $02
	dc.b	nD4, $04, nRst, $02, nEb4, $04, nRst, $02, nD4, $0A, nRst, $02
	dc.b	nC4, $04, nRst, $02, nBb3, $34, nRst, $08, nC4, $04, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nF3, $16, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nG3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $08, nBb3, $04, nRst, $08, nBb3, $10, nRst, $02
	dc.b	nA3, $04, nRst, $0E, nBb3, $10, nRst, $02, nC4, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nC4, $0A, nRst, $02, nBb3, $0A, nRst, $02
	dc.b	nBb3, $28, nRst, $02, nF3, $34, nRst, $38, nBb4, $04, nRst, $0E
	dc.b	nA4, $04, nRst, $08, nBb4, $04, nRst, $08, nBb3, $0A, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nAb3, $04, nRst, $08, nAb3, $04, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nBb3, $04, nRst, $0E, nEb3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nG3, $04, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nBb3, $0A, nRst, $02, nBb3, $04, nRst, $02, nAb3, $04, nRst, $08
	dc.b	nAb3, $04, nRst, $02, nBb3, $10, nRst, $02, nBb3, $04, nRst, $08
	dc.b	nF3, $04, nRst, $02, nG3, $04, nRst, $02, nAb3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nC4, $04, nRst, $02, nG3, $60, $2E, nRst
	dc.b	$08, nBb3, $04, nRst, $08, nG3, $04, nRst, $08, nBb3, $04, nRst
	dc.b	$02, nC4, $0A, nRst, $02
	smpsJump            s3p35_Jump00

; Unreachable
	smpsStop

; FM5 Data
s3p35_FM5:
	dc.b	nRst, $08
	smpsSetvoice        $0C
	smpsDetune          $FE
	smpsModSet          $0F, $01, $07, $07
s3p35_Jump07:
	smpsJump            s3p35_Jump00

; Unreachable
	smpsJump            s3p35_Jump07
	smpsStop

; PSG1 Data
s3p35_PSG1:
	smpsPSGvoice        sTone_04
	smpsDetune          $FF

s3p35_Jump06:
	dc.b	nRst, $60, nRst, nRst, $24, nBb3, $04, nRst, $02, nC4, $04, nRst
	dc.b	$02, nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst
	dc.b	$60, nRst, nRst, $2C, nBb3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst, $14
	dc.b	nE4, $04, nRst, $02, nF4, $0A, nRst, $02, nE4, $04, nRst, $02
	dc.b	nF4, $10, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nC4, $10, nRst, $02, nBb3, $04, nRst, $0E
	dc.b	nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02, nAb4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nAb4, $10, nRst, $02, nEb4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $14, nE4, $04, nRst, $02, nF4, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02
	dc.b	nBb4, $0A, nRst, $02, nEb4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $04, nRst, $20
	dc.b	nBb3, $04, nRst, $08, nCs4, $04, nRst, $02, nCs4, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nC4, $04, nRst, $32
	smpsPSGvoice        sTone_0A
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF4, $04, nRst, $02, nF5, $04, nRst, $02
	dc.b	nF4, $04, nRst, $08, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $26
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF5, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $08, nF4, $04, nRst, $02
	dc.b	nF5, $04, nRst, $02, nF4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nF4, $04, nRst, $02, nF5, $04, nRst, $02, nE4, $04, nRst, $08
	dc.b	nE5, $04, nRst, $02, nE4, $04, nRst, $08, nE5, $04, nRst, $02
	dc.b	nE5, $04, nRst, $02, nE4, $04, nRst, $32
	if FixMusicAndSFXDataBugs
	smpsPSGvoice        sTone_04
	endif
	smpsJump            s3p35_Jump06

; Unreachable
	smpsStop

; PSG2 Data
s3p35_PSG2:
	smpsPSGvoice        sTone_04

s3p35_Jump05:
	dc.b	nRst, $60, nRst, nRst, $24, nBb3, $04, nRst, $02, nC4, $04, nRst
	dc.b	$02, nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst
	dc.b	$60, nRst, nRst, $2C, nBb3, $04, nRst, $02, nC4, $04, nRst, $02
	dc.b	nD4, $34, nRst, $08, nD4, $04, nRst, $14, nBb3, $34, nRst, $14
	dc.b	nE4, $04, nRst, $02, nF4, $0A, nRst, $02, nE4, $04, nRst, $02
	dc.b	nF4, $10, nRst, $02, nF3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $1A, nC4, $10, nRst, $02, nBb3, $04, nRst, $0E
	dc.b	nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02, nBb3, $10, nRst, $02
	dc.b	nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02, nAb4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nAb4, $10, nRst, $02, nEb4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nC4, $04, nRst, $0E, nF3, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $02, nF3, $04, nRst, $08, nF3, $04, nRst, $02
	dc.b	nF4, $04, nRst, $14, nE4, $04, nRst, $02, nF4, $0A, nRst, $02
	dc.b	nE4, $04, nRst, $02, nF4, $10, nRst, $02, nF3, $04, nRst, $02
	dc.b	nF3, $04, nRst, $02, nF3, $04, nRst, $1A, nC4, $10, nRst, $02
	dc.b	nBb3, $04, nRst, $0E, nBb3, $0A, nRst, $02, nAb3, $10, nRst, $02
	dc.b	nBb3, $10, nRst, $02, nC4, $0A, nRst, $0E, nEb4, $04, nRst, $02
	dc.b	nBb4, $0A, nRst, $02, nEb4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nEb4, $04, nRst, $02, nEb4, $04, nRst, $20
	dc.b	nBb3, $04, nRst, $08, nCs4, $04, nRst, $02, nCs4, $04, nRst, $08
	dc.b	nCs4, $04, nRst, $02, nC4, $04, nRst, $32
	smpsPSGvoice        sTone_0A
	dc.b	nBb3, $04, nRst, $08, nBb3, $04, nRst, $02, nA3, $04, nRst, $08
	dc.b	nA3, $04, nRst, $02, nBb3, $04, nRst, $38, nBb3, $04, nRst, $08
	dc.b	nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $38, nD4, $04, nRst, $08, nC4, $04, nRst, $02
	dc.b	nD4, $04, nRst, $08, nC4, $04, nRst, $08, nD4, $04, nRst, $08
	dc.b	nD4, $04, nRst, $02, nEb4, $04, nRst, $08, nF4, $04, nRst, $08
	dc.b	nBb4, $04, nRst, $02, nF4, $04, nRst, $60, nRst, $02, nBb3, $04
	dc.b	nRst, $08, nBb3, $04, nRst, $02, nA3, $04, nRst, $08, nA3, $04
	dc.b	nRst, $02, nBb3, $04, nRst, $38, nBb3, $04, nRst, $08, nBb3, $04
	dc.b	nRst, $02, nA3, $04, nRst, $08, nA3, $04, nRst, $02, nBb3, $04
	dc.b	nRst, $38, nD4, $04, nRst, $08, nC4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $08, nBb3, $04, nRst, $02, nF4, $04, nRst, $02, nD4, $04
	dc.b	nRst, $60, nRst, $1A, nD3, $04, nRst, $02, nF3, $04, nRst, $02
	dc.b	nBb3, $04, nRst, $02, nC4, $04, nRst, $02, nD4, $0A, nRst, $02
	dc.b	nEb4, $04, nRst, $02, nF4, $04, nRst, $0E, nF4, $10, nRst, $02
	dc.b	nG4, $10, nRst, $02, nA4, $04, nRst, $08, nBb4, $04, nRst, $08
	dc.b	nC5, $0A, nRst, $02, nC5, $04, nRst, $02, nA4, $04, nRst, $08
	dc.b	nA4, $04, nRst, $02, nBb4, $10, nRst, $02, nC5, $04, nRst, $08
	dc.b	nBb4, $04, nRst, $02, nA4, $0A, nRst, $02, nG4, $0A, nRst, $02
	dc.b	nF4, $04, nRst, $08, nD4, $04, nRst, $02, nF4, $04, nRst, $08
	dc.b	nD4, $0A, nRst, $02, nF4, $04, nRst, $08, nD4, $04, nRst, $02
	dc.b	nEb4, $04, nRst, $08, nF4, $04, nRst, $08, nBb4, $04, nRst, $02
	dc.b	nF4, $04, nRst, $38, nBb4, $10, nRst, $02, nC5, $0A, nRst, $02
	dc.b	nD5, $0A, nRst, $02, nEb5, $0A, nRst, $02, nC5, $04, nRst, $02
	dc.b	nAb4, $0A, nRst, $02, nF4, $04, nRst, $02, nBb4, $10, nRst, $02
	dc.b	nBb4, $04, nRst, $0E, nC5, $0A, nRst, $02, nEb5, $0A, nRst, $02
	dc.b	nF5, nG5, $08, nRst, $02, nEb5, $04, nRst, $02, nC5, $0A, nRst
	dc.b	$02, nAb4, $04, nRst, $02, nF4, $10, nRst, $02, nF4, $04, nRst
	dc.b	$1A, nBb3, $04, nRst, $02, nF3, $04, nRst, $02, nC3, $04, nRst
	dc.b	$02, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nD3, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nF3, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nD4, $04, nRst, $02, nG3, $04, nRst
	dc.b	$02, nC4, $04, nRst, $02, nD4, $04, nRst, $02, nF4, $04, nRst
	dc.b	$02, nC3, $04, nRst, $02, nD3, $04, nRst, $02, nE3, $04, nRst
	dc.b	$02, nG3, $04, nRst, $02, nD3, $04, nRst, $02, nE3, $04, nRst
	dc.b	$02, nG3, $04, nRst, $02, nC4, $04, nRst, $32
	if FixMusicAndSFXDataBugs
	smpsPSGvoice        sTone_04
	endif
	smpsJump            s3p35_Jump05

; Unreachable
	smpsStop

; PSG3 Data
s3p35_PSG3:
	smpsPSGvoice        sTone_02
	smpsPSGform         $E7

s3p35_Jump04:
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $60, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $1E
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_08
	dc.b	nMaxPSG1, $06
	smpsPSGvoice        sTone_01
	dc.b	nMaxPSG1, $36
	smpsJump            s3p35_Jump04

; Unreachable
	smpsStop

s3p35_Voices:
	include	"..\unibank.asm"