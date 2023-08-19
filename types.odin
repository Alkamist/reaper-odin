package reaper

import "core:c"

INT_PTR :: uintptr
UINT_PTR :: uintptr
LONG_PTR :: int

LPVOID :: rawptr
HANDLE :: LPVOID
HINSTANCE :: HANDLE
HMENU :: HANDLE
HWND :: HANDLE
HICON :: HANDLE
HCURSOR :: HANDLE
HBRUSH :: HANDLE
HDC :: HANDLE
HGLRC :: HANDLE
HMODULE :: HINSTANCE
HFONT :: HANDLE

BOOL :: c.int
UINT :: c.uint
LONG :: c.long
SHORT :: c.short
WORD :: c.ushort
DWORD :: c.ulong
BYTE :: u8
CHAR :: c.char

LPARAM :: LONG_PTR
WPARAM :: UINT_PTR
LRESULT :: LONG_PTR

POINT :: struct {
    x: LONG,
    y: LONG,
}

RECT :: struct {
    left: LONG,
    top: LONG,
    right: LONG,
    bottom: LONG,
}

MSG :: struct {
    hwnd: HWND,
    message: UINT,
    wParam: WPARAM,
    lParam: LPARAM,
    time: DWORD,
    pt: POINT,
}

ACCEL :: struct {
    fVirt: u8,
    key: u16,
    cmd: u16,
}

GUID :: struct {
    Data1: c.ulong,
    Data2: c.ushort,
    Data3: c.ushort,
    Data4: [8]u8,
}

//========================================================
// Things that I don't know how or don't care to bind.
//========================================================
MIDI_eventlist :: struct {}
PCM_source_peaktransfer_t :: struct {}
IReaperControlSurface :: struct {}
midi_Input :: struct {}
midi_Output :: struct {}
LICE_IBitmap :: struct {}
LICE_IFont :: struct {}
WDL_VirtualWnd_BGCfg :: struct {}
preview_register_t :: struct {}
REAPER_Resample_Interface :: struct {}
IReaperPitchShift :: struct {}
REAPER_PeakGet_Interface :: struct {}
REAPER_PeakBuild_Interface :: struct {}
ISimpleMediaDecoder :: struct {}
PCM_source :: struct {}
PCM_sink :: struct {}
ProjectStateContext :: struct {}
//========================================================

ReaProject :: struct {}
MediaTrack :: struct {}
MediaItem :: struct {}
MediaItem_Take :: struct {}
TrackEnvelope :: struct {}
AudioAccessor :: struct {}
joystick_device :: struct {}

ReaSample :: f64
LICE_pixel :: c.uint
LICE_pixel_chan :: c.uchar

screensetNewCallbackFunc :: #type proc "c" (action: c.int, id: cstring, param: rawptr, actionParm: rawptr, actionParmSize: c.int) -> LRESULT

plugin_info_t :: struct {
    caller_version: c.int,
    hwnd_main: rawptr,
    Register: proc "c" (name: cstring, infostruct: rawptr) -> c.int,
    GetFunc: proc "c" (name: cstring) -> rawptr,
}

gaccel_register_t :: struct {
    accel: ACCEL,
    desc: cstring,
}

KbdCmd :: struct {
    cmd: DWORD,
    text: cstring,
}

KbdKeyBindingInfo :: struct {
    key: c.int,
    cmd: c.int,
    flags: c.int,
}

KbdSectionInfo :: struct {
    uniqueID: c.int,
    name: cstring,
    action_list: ^KbdCmd,
    action_list_cnt: c.int,
    def_keys: ^KbdKeyBindingInfo,
    def_keys_cnt: c.int,
    onAction: proc "c" (cmd, val, valhw, relmode: c.int, hwnd: HWND) -> bool,
    accels: rawptr,
    recent_cmds: rawptr,
    extended_data: [32]rawptr,
}

MIDI_event_t :: struct {
    frame_offset: c.int,
    size: c.int,
    midi_message: [4]u8,
}

audio_hook_register_t :: struct {
    OnAudioBuffer: proc "c" (isPost: bool, len: int, srate: f64, reg: ^audio_hook_register_t),
    userdata1: rawptr,
    userdata2: rawptr,
    input_nch: int,
    output_nch: int,
    GetBuffer: proc "c" (isOutput: bool, idx: int) -> ^ReaSample,
}

PCM_source_transfer_t :: struct {
    time_s: f64,
    samplerate: f64,
    nch: int,
    length: int,
    samples: ^ReaSample,
    samples_out: int,
    midi_events: ^MIDI_eventlist,
    approximate_playback_latency: f64 ,
    absolute_time_s: f64 ,
    force_bpm: f64 ,
}

project_config_extension_t :: struct {
    ProcessExtensionLine: proc "c" (line: cstring, ctx: ^ProjectStateContext, isUndo: bool, reg: ^project_config_extension_t) -> bool,
    SaveExtensionConfig: proc "c" (ctx: ^ProjectStateContext, isUndo: bool, reg: ^project_config_extension_t),
    BeginLoadProjectState: proc "c" (isUndo: bool, reg: ^project_config_extension_t),
    userData: rawptr,
}