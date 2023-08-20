package reaper

import "core:c"

foreign import wrapper { "wrapper.lib" }

@(default_calling_convention="c")
foreign wrapper {
    // ProjectStateContext_AddLine :: proc(ctx: ^ProjectStateContext, fmt: cstring, #c_vararg args: ..any) ---
    ProjectStateContext_AddLine :: proc(ctx: ^ProjectStateContext, str: cstring) ---
    ProjectStateContext_GetLine :: proc(ctx: ^ProjectStateContext, buf: [^]byte, buflen: c.int) -> c.int ---
}