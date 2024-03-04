--- STEAMODDED HEADER
--- MOD_NAME: Quick Load
--- MOD_ID: QuickLoad
--- MOD_AUTHOR: [Asobi]
--- MOD_DESCRIPTION: Quick Load options!

----------------------------------------------
------------MOD CODE -------------------------

local key_hold_update_ref = G.CONTROLLER.key_hold_update
function G.CONTROLLER:key_hold_update(key, dt)
    local key_hold_update_new = key_hold_update_ref(self, key, dt)
    if ((self.locked) and not G.SETTINGS.paused) or (self.locks.frame) or (self.frame_buttonpress) then return end
    --self.frame_buttonpress = true
    if self.held_key_times[key] then
        if key == 'f' then
            if self.held_key_times[key] > 0.7 then
                self.held_key_times[key] = nil
                G.SETTINGS.current_setup = 'Continue'

                if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end

                G.SAVED_GAME = get_compressed(G.SETTINGS.profile..'/'..'save.jkr')
                    if G.SAVED_GAME ~= nil then G.SAVED_GAME = STR_UNPACK(G.SAVED_GAME) end

                G.FUNCS.start_run(nil, {savetext = G.SAVED_GAME})
            else
                self.held_key_times[key] = self.held_key_times[key] + dt
            end
        end
    end
    return key_hold_update_new
end

----------------------------------------------
------------MOD CODE END----------------------