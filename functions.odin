package reaper

ShowConsoleMsg: proc(cstring)

load_api_functions :: proc() {
    ShowConsoleMsg = cast(type_of(ShowConsoleMsg))plugin_info.GetFunc("ShowConsoleMsg")
}