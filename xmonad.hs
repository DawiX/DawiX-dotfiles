{- xmonad.hs
 - Little insignificant changes made by:
 - DawiX (dawid DOT pech AT gmail DOT com)
 - Original author: Øyvind 'Mr.Elendig' Heggstad <mrelendig AT har-ikkje DOT net>
 -}

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import XMonad.Prompt
import XMonad.Prompt.Shell
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import XMonad.Config.Kde
import Graphics.X11.Xlib
import IO (Handle, hPutStrLn) 

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Hooks.FadeInactive

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.IM
import Data.Ratio ((%))

-------------------------------------------------------------------------------
-- Main --
main = do
       din <- spawnPipe sBarCmd
       conkytop <- spawnPipe myTopBar
       xmonad $ defaultConfig 
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , layoutHook = layoutHook'
              , manageHook = manageHook'
	      , logHook = dynamicLogWithPP $ myDzenPP
                                          { ppOutput = hPutStrLn din }
              }

myBitmapsDir = "/home/david/.dzen"
sBarCmd = "dzen2 -bg '#222222' -fg '#daff30' -e '' -ta l -w 400 -fn 'Snap:size=8'"
myTopBar = "conky | dzen2 -x '400' -y '0' -h '12' -w '1280' -ta 'r' -fg '#daff30' -bg '#222222' -fn 'Snap:size=8'"

--myDzenPP
myDzenPP = defaultPP { ppCurrent  = dzenColor "#b23308" "#222222" . pad
                     , ppVisible  = dzenColor "#daff30" "#222222" . pad
                     , ppHidden   = dzenColor "#daff30" "#222222" . pad
                     , ppHiddenNoWindows = const ""
                     , ppUrgent   = dzenColor "red" "yellow"
                     , ppWsSep    = ""
                     , ppSep      = "|"
                     , ppLayout   = dzenColor "#daff30" "#222222" .
                                    (\ x -> case x of
                                              "TilePrime Horizontal" -> " TTT "
                                              "TilePrime Vertical"   -> " []= "
                                              "Hinted Full"          -> " [ ] "
                                              _                      -> pad x
                                    )
                     , ppTitle    = ("^bg(#222222) " ++) . dzenEscape
                     }


--prompt style
myXPConfig = defaultXPConfig { font = "-*-snap-*-*-*-*-*-*-*-*-*-*-*-*"
                             , fgColor = "#789e2d"
                             , bgColor = "#1d1d1d"
                             , bgHLight = "#1d1d1d"
                             , fgHLight = "#b23308"
                             , position = Bottom
                             }
 

------------------------------------------------------------------------------
-- Hooks --
manageHook' :: ManageHook
manageHook' = manageHook kde4Config <+> myManageHook 

layoutHook' = customLayout

-------------------------------------------------------------------------------
-- Looks --
-- bar xmobar no longer used so this part is depreciated
--customPP :: PP
--customPP = defaultPP { ppCurrent = xmobarColor "#408f00" "" . wrap "[" "]"
--                     , ppTitle =  shorten 80
--                     , ppSep =  "<fc=#6c9401> | </fc>"
--                     , ppHiddenNoWindows = xmobarColor "#AFAF87" ""
--                     , ppUrgent = xmobarColor "#FFFFAF" "" . wrap "<" ">"
--                     }

-- borders
borderWidth' :: Dimension
borderWidth' = 1

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#222222"
focusedBorderColor' = "#daff30"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- layouts
customLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled)  ||| noBorders Full ||| withIM (1%7) (ClassName "gajim.py") Grid
  where
    tiled = ResizableTall 1 (2/100) (1/2) []

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "urxvt"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,               xK_Return), spawn $ XMonad.terminal conf) 
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") 
    , ((modMask .|. shiftMask, xK_p     ), shellPrompt myXPConfig)
    , ((modMask .|. controlMask, xK_Return), spawn "urxvt -pe tabbed")
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask .|. shiftMask, xK_m     ), spawn "urxvt -e mutt")
    , ((modMask .|. shiftMask, xK_a     ), spawn "uzbl-tabbed")
    , ((modMask .|. shiftMask, xK_i     ), spawn "urxvt -e irssi -n DawiX")
    , ((modMask .|. shiftMask, xK_f     ), spawn "firefox")
    , ((modMask .|. shiftMask, xK_g     ), spawn "gajim")
    , ((modMask .|. shiftMask, xK_s     ), spawn "skype")
    , ((modMask .|. shiftMask, xK_n     ), spawn "urxvt -e ncmpcpp")
--    , ((modMask, 	       xK_a     ), spawn "9menu -popup -teleport -file /home/david/.config/9menu/9menurc -bg #1d1d1d -fg #789e2d -font Snap:size=8")
    , ((modMask, 	       xK_a     ), spawn "sh /home/david/.bin/dz9menu.sh /home/david/.config/9menu/9menurc")
    , ((modMask .|. shiftMask, xK_v     ), spawn "xterm -e vim")
    , ((modMask .|. shiftMask, xK_x     ), spawn "xournal")
    , ((modMask, 	       xK_w     ), spawn "sh /home/david/.bin/dzenMPC.sh")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- mpd controls
    , ((modMask .|. controlMask,  xK_v     ), spawn "mpc prev")
    , ((modMask .|. controlMask,  xK_n     ), spawn "mpc pause")
    , ((modMask .|. controlMask,  xK_b     ), spawn "mpc play")
    , ((modMask .|. controlMask,  xK_m     ), spawn "mpc next")
    , ((modMask .|. controlMask,  xK_x     ), spawn "mpc seek -2%")
    , ((modMask .|. controlMask,  xK_comma ), spawn "mpc volume -4")
    , ((modMask .|. controlMask,  xK_period), spawn "mpc volume +4")
    , ((modMask .|. controlMask,  xK_c     ), spawn "mpc seek +2%")

    -- show reminder via dzen2
    , ((modMask .|. controlMask,  xK_r     ), spawn "sh /home/david/.scripts/reminder.sh")

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------

-- floats and apps rules
myManageHook = composeAll
    [ className =? "Smlayer"		--> doCenterFloat
    , className =? "Gimp"		--> doFloat
    , className =? "Xpdf"		--> doCenterFloat
    , className =? "pcmanfm"		--> doFloat
    , className =? "Gajim.py"		--> doFloat
    , className =? "Skype"		--> doFloat
    , className =? "vlc"		--> doFloat
    , className =? "Evince"		--> doFloat
    , className =? "Sonata"		--> doFloat
    , className =? "Mirage"		--> doCenterFloat
    , className =? "Abiword"		--> doCenterFloat
    , className =? "Gnumeric"		--> doCenterFloat
    , className =? "Wicd-client.py"	--> doCenterFloat
    , className =? "feh"		--> doCenterFloat ]

