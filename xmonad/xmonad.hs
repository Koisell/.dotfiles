import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import Data.Monoid
import System.Exit
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Actions.GridSelect
import XMonad.Layout.Tabbed
import XMonad.Layout.Named
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.TwoPane
import Control.Monad (liftM2)

--for xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe, safeSpawn)
import System.IO


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------


-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1-Term","2-Code","3-Web1","4-Code2","5-Steam","6","7","8","9","0-Com"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
-- xbindkeys -k to find a particular key's keycode
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_space     ), spawn "rofi -show drun")
    
    -- control keyboard
    , ((modm .|. shiftMask, xK_u), spawn "setxkbmap us")
    , ((modm .|. shiftMask, xK_f), spawn "setxkbmap fr")
    , ((modm .|. shiftMask, xK_n), spawn "setxkbmap us_qwerty-fr")

    -- screenshot
    , ((0, xK_Print ), spawn "gnome-screenshot" )

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_p ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_p ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp  )

    , ((modm,               xK_k     ), windows W.focusUp  )


    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Expand the master area
    , ((modm,               xK_h     ), sendMessage Expand)

    -- Shrink the master area
    , ((modm .|. shiftMask, xK_h     ), sendMessage Shrink)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    -- QWERTY
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
        -- AZERTY
        --, ((modm              , xK_semicolon), sendMessage (IncMasterN (-1)))

    , ((modm              , xK_f     ),  sendMessage ToggleLayout)
    , ((modm              , xK_g     ),  goToSelected def)
    , ((modm              , xK_b     ),  sendMessage ToggleStruts)
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    , ((0   , xF86XK_Sleep     ), spawn "xscreensaver-command --lock")
    , ((modm              , xK_l     ), spawn "xscreensaver-command --lock")
    , ((modm .|. shiftMask, xK_l     ), spawn "pyxtrlock")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
    -- QWERTY
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0]),
    -- AZERTY
       -- | (i, k) <- zip (workspaces conf) [0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0],
         (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    -- QWERTY
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,1,2]
    -- AZERTY fix
        -- | (key, sc) <- zip [xK_z, xK_e, xK_r] [1,0,2]

        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

-- smartBorders enleve les bord en plein écran
--myLayout = avoidStruts $ noBorders tabbed ||| Grid
myLayout =  (toggleLayouts $ noBorders Full) $ -- toggle fullscreen
    avoidStruts $ smartBorders $ tiled ||| Mirror tiled ||| noBorders tabbed 
--myLayout = avoidStruts ( smartBorders $ tiled ||| Mirror tiled ) ||| noBorders Full -- "true full"
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    tabbed  = named "Tabbed" $ simpleTabbed

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
--myManageHook = manageDocks <+> composeAll
myManageHook = manageDocks <+> composeAll
--myManageHook = fullscreenManageHook <+> composeAll
    [ className =? "Gimp"           --> doFloat
    --, className =? "jetbrains-idea-ce" --> doShift "1"
    --, className =? "jetbrains-idea-ce" --> viewShift "1"
    , className =? "Google-chrome"  --> viewShift "3-Web"
    , className =? "Google Play Music Desktop Player"  --> viewShift "8-Music"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
        where viewShift = doF . liftM2 (.) W.greedyView W.shift

------------------------------------------------------------------------
-- Event handling

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
--myStartupHook = return ()

myStartupHook = do
                  setWMName "LG3D"
                  spawn "feh --bg-scale ~/Pictures/wallpaper.png"
                  spawn "dropbox start"
                  spawn "redshift -l 49:2 -t 6500:2700"
                  spawn "xscreensaver -no-splash"
                  spawn "xbindkeys"
                  -- spawn "xrandr --output DVI-I-1 --left-of HDMI-A-0 --primary"
                  spawn "ibus-daemon"
                  return ()

myLogHook xmproc = dynamicLogWithPP xmobarPP {
                                                        ppOutput = hPutStrLn xmproc,
                                ppTitle = xmobarColor "green" "" . shorten 50
                                } >> updatePointer (0.5, 0.5) (0, 0)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
        xmproc <- spawnPipe "xmobar"
        xmonad $ ewmh . docks $ def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook xmproc,
        startupHook        = myStartupHook
    }

