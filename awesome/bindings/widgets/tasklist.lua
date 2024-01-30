local awful = require 'awful'

return {
   buttons = {
      awful.button {
         modifiers = {},
         button    = 1,
         on_press  = function(c)
            c:activate { context = 'tasklist', action = 'toggle_minimization' }
         end,
      },
      awful.button {
         modifiers = {},
         button    = 3,
         on_press  = function()
            awful.menu.client_list {
               -- Defined in theme.init
            }
         end,
      },
      awful.button {
         modifiers = {},
         button    = 4,
         on_press  = function() awful.client.focus.byidx(1) end
      },
      awful.button {
         modifiers = {},
         button    = 5,
         on_press  = function() awful.client.focus.byidx(-1) end
      },
   },
}
