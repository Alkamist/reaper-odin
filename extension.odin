package reaper

import "core:c"
import "core:runtime"

// This is how to export a Reaper extension:
//
// @export
// ReaperPluginEntry :: proc "c" (hInst: rawptr, rec: ^reaper.plugin_info_t) -> c.int {
//     context = runtime.default_context()
//     if rec != nil {
//         reaper.plugin_info = rec
//         reaper.load_api_functions()
//         reaper.register_actions()
//
//         USER CODE HERE
//
//         return 1
//     }
//     return 0
// }

plugin_info: ^plugin_info_t

window_handle :: proc() -> rawptr {
    return plugin_info.hwnd_main
}

add_action :: proc(name, id: cstring, action: proc()) {
    command_id := plugin_info.Register("command_id", cast(rawptr)id)
    accel_register: gaccel_register_t

    accel_register.desc = name
    accel_register.accel.cmd = u16(command_id)

    plugin_info.Register("gaccel", &accel_register)
    _actions[command_id] = action
}

add_timer :: proc(timer: proc()) {
    plugin_info.Register("timer", cast(rawptr)timer)
}

register_actions :: proc() {
    plugin_info.Register("hookcommand", cast(rawptr)_hook_command)
}



_actions: map[c.int]proc()

_hook_command :: proc "c" (command, flag: c.int) -> bool {
    context = runtime.default_context()
    if command == 0 {
        return false
    }
    if action, ok := _actions[command]; ok {
        action()
        return true
    }
    return false
}