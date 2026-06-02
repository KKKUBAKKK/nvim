# Debugging (DAP)

Interactive debugging via [nvim-dap](https://github.com/mfussenegger/nvim-dap) with a visual UI ([nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)) and inline variable values. Set up for **C/C++** using the `cppdbg` adapter (Microsoft's `OpenDebugAD7`, auto-installed by Mason).

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle a **b**reakpoint on the current line |
| `<leader>dc` | **C**ontinue — start debugging, or run to the next breakpoint |
| `<leader>do` | Step **o**ver (execute the line, don't descend into calls) |
| `<leader>di` | Step **i**nto (descend into the function call) |
| `<leader>dr` | Open the debug **R**EPL |
| `<leader>du` | Toggle the debug **U**I panels |
| `<leader>de` | **E**valuate the expression under the cursor / selection (normal & visual) |
| `<leader>dt` | **T**erminate the debug session |

## How to debug a C/C++ program

1. **Build with debug symbols.** Compile with `-g` (and ideally `-O0`). If you use CMake, set `-DCMAKE_BUILD_TYPE=Debug`.
2. **Set breakpoints.** Put the cursor on a line and press `<leader>db`. A breakpoint sign appears in the gutter. Repeat for as many lines as you want.
3. **Start.** Press `<leader>dc`. You'll be prompted: `Path to executable:` — type/complete the path to your compiled binary (e.g. `build/my_app`) and press `<CR>`.
4. **The UI opens automatically** with these panels:
   - **Scopes** — local/global variables and their live values.
   - **Stacks** — the call stack; click a frame to inspect it.
   - **Breakpoints** — all your breakpoints.
   - **Watches** — expressions you're tracking.
   - **REPL / Console** — program output and an interactive prompt.
   Variable values also appear **inline** next to your code (dap-virtual-text).
5. **Step through:** `<leader>do` (over), `<leader>di` (into), `<leader>dc` (continue to next breakpoint).
6. **Inspect:** hover a variable with `<leader>de`, or watch it in the REPL (`<leader>dr`).
7. **Finish:** `<leader>dt` to terminate. The UI closes automatically when the session ends.

> The program is launched with `stopAtEntry = true`, so execution pauses at `main` first — press `<leader>dc` to run to your first breakpoint.

## Debugging through CMake (recommended for CMake projects)

If your project uses CMake, you don't need to type the executable path manually. Use `<leader>Cd` (**CMake debug**) — cmake-tools picks the selected build target and launches it under this same `cppdbg` adapter. Select the target first with `<leader>Ct`. See [07-cpp-cmake.md](07-cpp-cmake.md).

## Notes for CUDA

The `cppdbg` adapter debugs **host** (CPU) code. For debugging GPU **kernels**, you'd use NVIDIA's `cuda-gdb` / Nsight tooling, which isn't wired into this config — host-side debugging of your CUDA application still works normally.

## Configuration

Everything lives in `plugins/dap.lua`. The `cpp` launch configuration is reused for `c` and `objcpp`. To add a configuration that skips the path prompt, add an entry to `dap.configurations.cpp` with a fixed `program` path.
