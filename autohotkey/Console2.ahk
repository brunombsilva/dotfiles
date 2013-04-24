GroupAdd, TargetWindow, ahk_class Console_2_Main

#Esc::
    IfWinExist ahk_group TargetWindow
    {
        IfWinNotActive ahk_group TargetWindow
        {
            WinHide ahk_group TargetWindow
        }
    }
    return
    
#Space::
    DetectHiddenWindows, on
    IfWinExist ahk_group TargetWindow
    {
        IfWinActive ahk_group TargetWindow
        {
            MouseGetPos,,, MouseWin, MouseControl
            WinHide ahk_group TargetWindow
            WinActivate ahk_id %MouseWin%
            ;ControlFocus %MouseControl%
            ;WinActivate ahk_group Shell_TrayWnd
        }
        else
        {
            DetectHiddenWindows, on
            WinSet, Style, -0x800000, ahk_group TargetWindow  ; hide thin-line border
            WinSet, Style, -0x400000, ahk_group TargetWindow  ; hide dialog frame
            WinSet, Style, -0x40000, ahk_group TargetWindow  ; hide thickframe/sizebox
            CoordMode, Mouse, Screen
            MouseGetPos, MouseX, MouseY
            CoordMode, Mouse, Relative
            SysGet, mCount, MonitorCount
            Loop %mCount% {
              SysGet, mBounding, Monitor, %A_Index%
              if (MouseX > mBoundingLeft and MouseX < mBoundingRight and MouseY > mBoundingTop && MouseY < mBoundingBottom) {
                Choosen = %A_Index%
                WinMove, ahk_group TargetWindow, , (mBoundingRight-mBoundingLeft)/2 - 1000/2, mBoundingTop, 1000, 300
                Break
              }
            }
            WinShow ahk_group TargetWindow
            WinSet, AlwaysOnTop, On, ahk_group TargetWindow
            WinActivate ahk_group TargetWindow
        }
    }
    else
    {	
      Run C:\Dropbox\Programs\Console2\Console.exe, C:\Dropbox\Programs\Console2\
    }
    DetectHiddenWindows, off
    return

; hide Console on "esc".
#IfWinActive ahk_group TargetWindow
esc::
{
   	WinHide ahk_group TargetWindow
       ;WinActivate ahk_group Shell_TrayWnd
    MouseGetPos,,, MouseWin, MouseControl
    WinActivate ahk_id %MouseWin%
}
return
