package reaper

import "core:c"

plugin_info_t :: struct {
    caller_version: c.int,
    hwnd_main: rawptr,
    Register: proc(name: cstring, infostruct: rawptr) -> c.int,
    GetFunc: proc(name: cstring) -> rawptr,
}

ACCEL :: struct {
    fVirt: u8,
    key: u16,
    cmd: u16,
}

gaccel_register_t :: struct {
    accel: ACCEL,
    desc: cstring,
}