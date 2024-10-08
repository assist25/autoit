#include <GUIConstants.au3>
; Project Name : MP3 Player 1.0
; Version : 1.0
; Author : ivan_ostric/i542
; Email : ivan_ostric@hotmail.com
TraySetIcon (@ScriptDir & "\mp3player.ico")
Opt("GUIOnEventMode" ,  1 )
TraySetIcon (@ScriptDir & "\mp3player.ico")
TraySetTooltip ("MP3 player 1.0")
Global $song = "no"
Global $fadeout = "no"
opt("TrayMenuMode", 1)
$run = TrayCreateItem ("Run")
$exit = TrayCreateItem ("Exit")
$player = GUICreate("MP3\WAV player", 119, 90, 192, 125, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
$play = GUICtrlCreateButton("Play", 3, 3, 58, 25)
$stop = GUICtrlCreateButton("Stop", 63, 3, 52, 25)
$open = GUICtrlCreateButton("Open", 63, 57, 52, 25)
$setvol = GUICtrlCreateButton("Set volume", 3, 30, 58, 25)
$close = GUICtrlCreateButton("Close", 63, 30, 52, 25)
$noterun = GUICtrlCreateButton("Notes", 3, 57, 58, 25)
$notes = GUICreate("Notes", 248, 264, 192, 125, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
$nedit = GUICtrlCreateEdit("", 3, 3, 241, 223, -1, $WS_EX_CLIENTEDGE)
$nclose = GUICtrlCreateButton("Close", 3, 228, 103, 25)
$setvolume = GUICreate("Set volume", 286, 64, 192, 125, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
$volslider = GUICtrlCreateSlider(3, 6, 280, 25)
GUICtrlSetData($volslider, 100)
GUICtrlCreateLabel("Min", 12, 33, 21, 17)
GUICtrlCreateLabel("Max", 255, 30, 24, 17)
$volclose = GUICtrlCreateButton("Close", 159, 33, 40, 19)
$fade = GUICtrlCreateButton("Fade", 120, 33, 40, 19)
$volapply = GUICtrlCreateButton("Apply", 84, 33, 37, 19)
GUISetState(@SW_HIDE, $setvolume)
GUISetState(@SW_SHOW, $player)
GUISetState(@SW_HIDE, $notes)
GUICtrlSetOnEvent( $exit , "_Exit" )
GUISetOnEvent( $GUI_EVENT_CLOSE , "_ExitHide" )
GUICtrlSetOnEvent( $close , "_ExitHide" )
GUICtrlSetOnEvent( $play , "_Play" )
GUICtrlSetOnEvent( $noterun , "_Note" )
GUICtrlSetOnEvent( $volclose , "_VolClose" )
GUICtrlSetOnEvent( $volapply , "_VolApply" )
GuiCtrlSetOnEvent( $fade, "_Fade" )
GUICtrlSetOnEvent( $stop , "_Soundplay" )
GUICtrlSetOnEvent( $nclose , "_nclose" )
GUICtrlSetOnEvent( $setvol , "_SetVol" )
GUICtrlSetOnEvent( $open , "_Open" )
 
Func _VolApply
	    SoundSetWaveVolume(GUICtrlRead( $volslider ) )
	EndFunc
Func _Fade
	Switch $fadeout
				Case "yes"
					For $i = 0 To 100 Step 1
						SoundSetWaveVolume($i)
						Sleep(30)
					Next
					$fadeout = "no"
				Case "no"
					For $i = 100 To 0 Step -1
						SoundSetWaveVolume($i)
						Sleep(30)
					Next
					$fadeout = "yes"
			EndSwitch
Func  _Open()
    $song = FileOpenDialog("Open",@MyDocumentsDir,"MP3 files (*.mp3)|WAV files (*.wav)")
EndFunc

Func _SetVol()
    GUISetState(@SW_SHOW,$setvolume )
EndFunc

Func _nclose()
    $array=MouseGetPos()
    GuiSetState(@SW_HIDE, $notes )
EndFunc

Func _Soundplay()
    SoundPlay("")
EndFunc

FUnc _ExitHide()
    GuiSetState(@SW_HIDE, $player)
    GUISetState(@SW_HIDE, $setvolume)
    GUISetState(@SW_HIDE, $notes)
EndFunc

Func _VolClose()
    GUISetState(@SW_HIDE,$setvolume)
EndFunc

Func _Note()
    GUISetState(@SW_SHOW, $notes)
EndFunc

Func _Play()
    If $song = "no" Then
        MsgBox(16,"No file to play","No file to play. Select OPEN command.")
    Else
        SoundPlay($song)
    EndIf   
EndFunc

Func _Exit()
    Exit
EndFunc
While 1
    $tmsg = TrayGetMsg()
    Select
        Case $tmsg = $run
            GUISetState(@SW_HIDE, $setvolume)
            GUISetState(@SW_SHOW,$player)
            GUISetState(@SW_HIDE, $notes)
    EndSelect
WEnd
