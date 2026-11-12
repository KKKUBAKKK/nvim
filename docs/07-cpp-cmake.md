# C / C++ / CUDA workflow

This config is tuned for C/C++/CUDA. The pieces: **clangd** (code intelligence), **cmake-tools** (configure/build/run/debug), **clang-format** (formatting), and **cppdbg** (debugging).

## The one thing that makes everything work: `compile_commands.json`

clangd needs to know how each file is compiled (include paths, defines, standard, etc.). It reads this from a `compile_commands.json` file. **cmake-tools generates it for you** and symlinks it to your project root, so clangd indexes the project correctly and stops complaining about missing headers.

If you ever see clangd errors about missing includes, the fix is almost always: regenerate `compile_commands.json` (`<leader>Cg`).

## CMake commands

All under `<leader>C` (capital C — chosen so it doesn't clash with Copilot's `<leader>c`). These work in `c`, `cpp`, `cuda`, and `cmake` files.

| Key | Action |
|-----|--------|
| `<leader>Cg` | **G**enerate / configure (runs `cmake`, produces `compile_commands.json`) |
| `<leader>Cb` | **B**uild the selected target |
| `<leader>Cr` | **R**un the selected target |
| `<leader>Cd` | **D**ebug the selected target (launches the DAP debugger — see [06](06-debugging.md)) |
| `<leader>Ct` | Select build **t**arget |
| `<leader>Ck` | Select **k**it (compiler toolchain) |
| `<leader>Cc` | **C**lean the build directory |
| `<leader>Cx` | Stop the running program (stop runner) |

## Typical workflow

1. Open your project (`cd` into it, then `nvim`).
2. `<leader>Ck` — pick a kit (compiler) the first time.
3. `<leader>Cg` — configure. This creates `build/` and the `compile_commands.json` clangd needs.
4. `<leader>Ct` — choose which target to build/run (if you have several).
5. `<leader>Cb` — build. Errors show up as diagnostics.
6. `<leader>Cr` to run, or `<leader>Cd` to debug.

Builds go into `build/`. clangd picks up the compile commands automatically thanks to `--background-index` and the symlinked `compile_commands.json`.

## clangd features you get

clangd is launched with C/C++/CUDA-friendly flags, giving you:

- **Background indexing** — cross-file navigation across the whole project.
- **clang-tidy** diagnostics inline (no separate linter needed).
- **Include-what-you-use** header insertion — auto-adds `#include`s as you complete symbols.
- **CUDA support** — understands `.cu`/`.cuh` via `--query-driver` pointing at `nvcc` and host compilers.
- Detailed completion with function-argument placeholders.

All the usual LSP keymaps apply in C/C++ files — `gd` (definition), `gR` (references), `K` (hover), `<leader>ca` (code action, e.g. "add include"), `<leader>rn` (rename). See [04-lsp-and-diagnostics.md](04-lsp-and-diagnostics.md).

> If your toolchain lives in non-standard paths, edit the `--query-driver` argument in `plugins/lsp/lspconfig.lua` to match (e.g. point it at your CUDA install's `nvcc`).

## Formatting C/C++/CUDA

- **On save**, files are auto-formatted with `clang-format`.
- `<leader>mp` formats manually (or a visual selection).
- Drop a `.clang-format` file in your project root to control the style — clang-format (and therefore this config) will respect it.

## Treesitter

Parsers for `c`, `cpp`, `cuda`, `cmake`, and `make` are pre-installed, giving accurate highlighting and `<C-space>` incremental selection (see [03-editing.md](03-editing.md)).

## OpenCL C (`.cl`)

Neovim on its own types a `.cl` file as Lisp unless one of its first 4 lines has a `/*` comment. This config always treats `*.cl` as `opencl` (`core/filetypes.lua`). OpenCL files get:

- **Highlighting**: the tree-sitter `c` parser, plus a Vim regex overlay (`after/syntax/opencl.vim`) for what C doesn't know: `__kernel`/`__global`/`__local`/... qualifiers, vector types (`float4`, `uint8`, ...), image/sampler types, builtins (`get_global_id`, `barrier`, `vload4`, `convert_*`, atomics, sub-groups) and `CLK_*` constants.
- **clangd**: it parses `.cl` as OpenCL C, so you get diagnostics, completion, go-to-definition and semantic highlighting (types and builtins get colored correctly).
- **clang-format** on save, the same as C/C++.
- **`#ifdef` branches stay in color.** clangd normally greys out code under a macro it thinks is undefined. For `.cl` files that guess is useless, because the `-D` options come from `clBuildProgram` at runtime. So the greying is turned off for OpenCL only (C/C++ keep it). If you also want clangd to *analyze* a branch, i.e. diagnostics and go-to-definition inside it, tell it the macro: add a `.clangd` file in the project root with

  ```yaml
  If:
    PathMatch: .*\.cl
  CompileFlags:
    Add: [-DUSE_FP64, -cl-std=CL3.0]
  ```
