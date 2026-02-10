# Go Debugging in Bred

Debug Go programs directly in Vim using [vim-go](https://github.com/fatih/vim-go) and [Delve](https://github.com/go-delve/delve).

## Prerequisites

- Go installed and in `PATH`
- Delve debugger
- vim-go plugin with binaries

```bash
# Install Delve
go install github.com/go-delve/delve/cmd/dlv@latest

# Install vim-go and its binaries (run inside Vim)
:PlugInstall
:GoInstallBinaries
```

## Architecture

The Go debug setup spans three files in the Bred configuration:

| File | Purpose |
|------|---------|
| `custom.plugins.vim` | vim-go plugin declaration, LSP/fmt disabled (handled by gopls + ALE), syntax highlighting, debug window layout |
| `ftplugin/go.vim` | Go-specific keybindings registered with MapDocs (visible via `<Space>` menu) |
| `bred/lsp.vim` | gopls language server config (completion, diagnostics, go-to-definition) |

vim-go's built-in LSP, formatting, and completion features are intentionally disabled to avoid conflicts with the existing gopls and ALE setup. vim-go is used exclusively for its debugger, build/test commands, and syntax highlighting.

## Debug Window Layout

When the debugger starts, vim-go opens helper windows:

```
+----------------+----------------------------+
|                |                            |
|   Variables    |       Source Code           |
|   (30 cols)    |       (cursor here)        |
|                |                            |
+----------------+----------------------------+
|   Call Stack (20 lines)                     |
+---------------------------------------------+
|   Goroutines (10 lines)                     |
+---------------------------------------------+
|   Output (5 lines)                          |
+---------------------------------------------+
```

This layout is configured via `g:go_debug_windows` in `custom.plugins.vim`.

## Keybindings

Local leader is `,` -- all debug mappings use `,d` prefix, build/test use `,g` prefix.

### Debugger Session

| Mapping | Command | Description |
|---------|---------|-------------|
| `,ds` | `:GoDebugStart` | Start debugging the current package |
| `,dt` | `:GoDebugTestFunc` | Debug the test function under cursor |
| `,dx` | `:GoDebugStop` | Stop the debugger |
| `,dr` | `:GoDebugRestart` | Restart the current debug session |

### Debugger Navigation

| Mapping | Command | Description |
|---------|---------|-------------|
| `,dc` | `:GoDebugContinue` | Continue execution until next breakpoint |
| `,dn` | `:GoDebugNext` | Step over -- execute current line, stop at next |
| `,di` | `:GoDebugStep` | Step into -- enter the function call on current line |
| `,do` | `:GoDebugStepOut` | Step out -- run until current function returns |

### Breakpoints

| Mapping | Command | Description |
|---------|---------|-------------|
| `,db` | `:GoDebugBreakpoint` | Toggle breakpoint on current line |

### Inspection

| Mapping | Command | Description |
|---------|---------|-------------|
| `,dp` | `:GoDebugPrint` | Print the value of the variable under cursor |
| `,dv` | `:GoDebugSet` | Set a debug variable (prompts for name=value) |

### Build and Test

| Mapping | Command | Description |
|---------|---------|-------------|
| `,gb` | `:GoBuild` | Build the current package |
| `,gt` | `:GoTest` | Run all tests in current package |
| `,gT` | `:GoTestFunc` | Run only the test function under cursor |
| `,gc` | `:GoCoverageToggle` | Toggle test coverage highlighting in source |
| `,ga` | `:GoAddTags` | Add/remove struct field tags (json, xml, etc.) |

## Usage Walkthrough

### Debugging a Program

1. Open a Go file in the package you want to debug
2. Set breakpoints with `,db` on the lines you want to inspect
3. Start the debugger with `,ds`
4. The debug windows open (variables, stack, goroutines, output)
5. Use `,dc` to continue to the first breakpoint
6. Inspect variables in the Variables window or with `,dp`
7. Step through code with `,dn` (over), `,di` (into), `,do` (out)
8. Stop the session with `,dx`

### Debugging a Test

1. Place your cursor inside a test function (`func TestXxx`)
2. Set breakpoints with `,db`
3. Start with `,dt` to debug just that test function
4. Navigate and inspect as above

### Passing Arguments

To debug with custom arguments, use the command form directly:

```vim
:GoDebugStart . -- --flag=value arg1 arg2
```

### Conditional Breakpoints

Delve supports conditional breakpoints via the command line. After starting a debug session:

```vim
:GoDebugBreakpoint    " Set a regular breakpoint first
```

Then use Delve commands in the output window to make it conditional.

## LSP Integration

The Go language server (gopls) is configured separately in `bred/lsp.vim` and provides:

- Code completion
- Diagnostics (errors, warnings)
- Go to definition (`gd`)
- Find references (`gr`)
- Code actions (`<Space>ac`)
- Hover info (`<Space>k`)
- Semantic highlighting
- Inlay hints (variable types, parameter names, etc.)

These features work independently of the debugger and are always active in Go files.

## ALE Integration

ALE handles formatting with `gofmt` (configured in `bred/plugins.vim`). Fix the current file with `<Space>af`.

## Troubleshooting

**"dlv not found"**: Ensure `$GOPATH/bin` (usually `~/go/bin`) is in your `PATH`.

**Debugger won't start**: Run `:GoDebugStart` and check the output window for errors. Common causes:
- Package doesn't compile -- fix build errors first (`,gb`)
- Missing `main` package -- `:GoDebugStart` needs an executable package, use `:GoDebugTestFunc` for library packages

**Breakpoints not hit**: Make sure the code path actually executes the line. Use `,dc` to continue rather than `,dn` if you're stepping past the breakpoint.

**Variables window empty**: Variables only populate when execution is paused at a breakpoint or after a step.

**Debug windows in wrong position**: Customize `g:go_debug_windows` in `custom.plugins.vim`. Set a value to `''` to disable a specific window.
