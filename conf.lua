function love.conf(t)
    t.title = "Trippy Stars"        -- The title of the window the game is in (string)
    t.author = "Daniël Haazen"        -- The author of the game (string)
    t.url = "www.danielhaazen.com"                 -- The website of the game (string)          -- The name of the save directory (string)
    t.version = "0.8.0"         -- The LÖVE version this game was made for (string)
    t.identity = "Trippy Stars"
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = true           -- Enable release mode (boolean)
    t.screen.width = 1024       -- The window width (number)
    t.screen.height = 768       -- The window height (number)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.modules.joystick = false   -- Enable the joystick module (boolean)
    t.modules.audio = false      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = false      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = false      -- Enable the sound module (boolean)
    t.modules.physics = false    -- Enable the physics module (boolean)
end
    