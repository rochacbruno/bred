# Vim Keybinding Documentation

Leader key: `<spc>`  
<!-- Open in Browser: `<space>mp` or `:ComposerStart` -->

## Normal Mode

### Buffers

| Key          | Description                          |
|--------------|--------------------------------------|
| `<spc>b`     | list                                 |
| `<spc><Tab>` | alternate                            |
| `<spc>ba`    | close all                            |
| `<spc>bc`    | Close buffer (save first)            |
| `<spc>bx`    | Force close buffer (no save)         |
| `[b`         | previous                             |
| `[q`         | previous                             |
| `]b`         | next                                 |
| `]q`         | next                                 |
| `<spc>1`     | switch to 1-9                        |
| `<spc>bh`    | close all hidden                     |
| `<spc>bl`    | list and jump to one                 |
| `gs`         | Open scratch buffer in insert mode   |

### Config

| Key         | Description    |
|-------------|----------------|
| `<spc>,`    | open config    |
| `<spc><cr>` | reload vimrc   |

### Edit

| Key          | Description                                |
|--------------|--------------------------------------------|
| `<C-/>`      | comment                                    |
| `<spc>cb`    | changes on buffers                         |
| `<spc>j`     | jumplist                                   |
| `<spc>u`     | Toggle UndoTree                            |
| `<C-a>`      | Increment number/date under cursor         |
| `<C-R><C-A>` | pull Word under cursor into command line   |
| `<C-R><C-L>` | pull line under cursor into command line   |
| `<C-R><C-W>` | pull word under cursor into command line   |
| `<C-x>`      | Decrement number/date under cursor         |
| `<C-z>`      | Undo                                       |
| `<spc>dt`    | insert date                                |
| `<spc>id`    | insert uuid                                |
| `<spc>tw`    | remove / trim trailing whitespace          |
| `a`          | append after cursor                        |
| `A`          | insert at end of line                      |
| `gcu`        | uncomment adjacent commented lines         |
| `gU$`        | uppercase to end of line                   |
| `gUU`        | uppercase line                             |
| `guu`        | lowercase line                             |
| `I`          | insert before cursor                       |
| `N<<`        | outdent N lines                            |
| `N==`        | restore Indentation N Lines                |
| `N>>`        | indent N lines                             |
| `Ncc`        | delete N lines and start insert            |
| `O`          | new line above current line                |
| `o`          | new line below current line                |
| `viwu`       | lowercase word                             |
| `viwU`       | uppercase word                             |
| `x`          | Cut (delete to register)                   |
| `X`          | Cut to end of line                         |
| `xx`         | Cut entire line                            |

### Edit Color

| Key     | Description         |
|---------|---------------------|
| `<M-w>` | Open color picker   |

### Edit Cursor

| Key                | Description                                      |
|--------------------|--------------------------------------------------|
| `<C-d>`            | Select word under cursor / Add next occurrence   |
| `<C-LeftMouse>`    | Add cursor with Ctrl+Click                       |
| `<C-RightMouse>`   | Select word with Ctrl+Right                      |
| `<M-C-RightMouse>` | Column selection                                 |

### Edit Markdown

| Key       | Description                        |
|-----------|------------------------------------|
| `<spc>mo` | Open markdown preview in browser   |
| `<spc>mp` | Start markdown preview             |

### Edit Marks

| Key      | Description                          |
|----------|--------------------------------------|
| `<spc>m` | Open flagmarks menu (window-aware)   |
| `<spc>M` | Open flagmarks menu (same window)    |
| `ma`     | Add flag mark at current position    |
| `mC`     | Clear all marks globally             |
| `mc`     | Clear all marks in current file      |
| `md`     | Delete flag mark at current line     |
| `Mga`    | Jump to mark a-z (same window)       |
| `mga`    | Jump to mark a-z (window aware)      |
| `ml`     | List all flag marks                  |
| `Mm`     | Jump to last mark (same window)      |
| `mm`     | Jump to last mark (window-aware)     |
| `Mn`     | Jump to next mark (same window)      |
| `mn`     | Jump to next mark (window-aware)     |
| `Mp`     | Jump to prev mark (same window)      |
| `mp`     | Jump to prev mark (window-aware)     |
| `mq`     | Quick jump to mark (prompt)          |
| `mt`     | Toggle between last two flag marks   |

### Edit Paste

| Key     | Description                       |
|---------|-----------------------------------|
| `<c-n>` | Previous yank after paste         |
| `<c-p>` | Next yank after paste             |
| `[y`    | Previous item in yank history     |
| `]y`    | Next item in yank history         |
| `gp`    | Paste and move cursor             |
| `gP`    | Paste before and move cursor      |
| `p`     | Paste with yoink history          |
| `P`     | Paste before with yoink history   |
| `y`     | Yank without moving cursor        |

### Edit Replace

| Key            | Description                                        |
|----------------|----------------------------------------------------|
| `<spc><spc>s`  | Smart case substitute motion                       |
| `<spc><spc>ss` | Smart case substitute word across buffer           |
| `<spc>s`       | Substitute motion with prompted text               |
| `<spc>ss`      | Substitute word across buffer with prompted text   |
| `s`            | Substitute motion with yanked text                 |
| `S`            | Substitute to end of line with yanked text         |
| `ss`           | Substitute current line with yanked text           |

### Edit Surround

| Key    | Description                              |
|--------|------------------------------------------|
| `cs`   | Change surrounding (cs + old + new)      |
| `ds`   | Delete surrounding (ds + delimiter)      |
| `ysiw` | Surround inner word (ysiw + delimiter)   |
| `yss`  | Surround entire line (yss + delimiter)   |

### Edit Table

| Key       | Description         |
|-----------|---------------------|
| `<spc>tm` | Toggle table mode   |

### Files

| Key           | Description                                    |
|---------------|------------------------------------------------|
| `<spc>f`      | find                                           |
| `<spc>fd`     | in current dir                                 |
| `<spc>rf`     | recent                                         |
| `<spc>e`      | Open explorer on left                          |
| `<C-s>`       | save                                           |
| `<spc>.`      | set local working directory to current file    |
| `<spc><spc>x` | make executable                                |
| `<spc>E`      | Open explorer in vertical split                |
| `<spc>fp`     | copy current file path                         |
| `<spc>o`      | open file explorer at current file path        |
| `<spc>q`      | quit                                           |
| `<spc>w`      | save                                           |
| `<spc>x`      | save and quit                                  |
| `gof`         | Open file manager in current files directory   |
| `got`         | Open terminal in current files directory       |

### Git

| Key       | Description                   |
|-----------|-------------------------------|
| `<spc>g`  | tracked files                 |
| `<spc>gc` | commits                       |
| `<spc>gs` | status                        |
| `<spc>gb` | Open current line on GitHub   |
| `<spc>gm` | Show git commit info          |

### Help

| Key      | Description                              |
|----------|------------------------------------------|
| `<spc>h` | open mapping documentation on a buffer   |
| `K`      | help for word under cursor               |

### LSP

| Key       | Description              |
|-----------|--------------------------|
| `<spc>ac` | Show code actions        |
| `<spc>k`  | Show hover information   |
| `gd`      | Go to definition         |
| `gr`      | Go to references         |

### Lines

| Key        | Description   |
|------------|---------------|
| `<M-Down>` | move down     |
| `<M-j>`    | move down     |
| `<M-k>`    | move up       |
| `<M-Up>`   | move up       |

### Linter

| Key       | Description          |
|-----------|----------------------|
| `<spc>af` | Fix current file     |
| `<spc>at` | Toggle ALE linting   |

### Navigation

| Key     | Description                               |
|---------|-------------------------------------------|
| `$`     | go to end of line                         |
| `%`     | go to matching bracket                    |
| `0`     | go to beginning of line                   |
| `<C-I>` | previous jump in jumplist                 |
| `<C-O>` | next jump in jumplist                     |
| `^`     | go to first non-blank character of line   |
| `G`     | go to last line of file                   |
| `gF`    | open or create file under cursor          |
| `gf`    | go to file under cursor                   |
| `gg`    | go to first line of file                  |
| `H`     | cursor to the top of the screen           |
| `L`     | cursor to the bottom of the screen        |
| `M`     | cursor to the middle of the screen        |
| `Ngg`   | go to line N                              |

### REST

| Key     | Description                         |
|---------|-------------------------------------|
| `<C-j>` | Execute HTTP request under cursor   |

### Search

| Key               | Description                              |
|-------------------|------------------------------------------|
| `<silent><spc>r`  | text with ripgrep                        |
| `<silent><spc>rL` | text with line under cursor              |
| `<silent><spc>rw` | text with word under cursor              |
| `<spc>l`          | lines in current buffer                  |
| `<spc>lL`         | lines in buffer with line under cursor   |
| `<spc>lw`         | lines in buffer with word under cursor   |
| `<spc>re`         | replace word under cursor                |
| `<spc>rl`         | replace word under cursor in line        |

### Tabs

| Key       | Description       |
|-----------|-------------------|
| `<spc>tc` | close current     |
| `<spc>th` | go to previous    |
| `<spc>tl` | go to next        |
| `<spc>tn` | create new        |
| `<spc>to` | close all other   |

### Terminal

| Key      | Description      |
|----------|------------------|
| `<spc>c` | open at bottom   |

### View

| Key     | Description     |
|---------|-----------------|
| `<C-L>` | redraw screen   |

### Windows

| Key             | Description                              |
|-----------------|------------------------------------------|
| `-`             | Open window chooser                      |
| `--`            | Jump Windows                             |
| `--s<ID>`       | Swap Window                              |
| `--ss`          | Swap with previous window                |
| `<C-w>ARROWS`   | go to another                            |
| `<C-w>c`        | close current                            |
| `<C-w>m`        | Toggle window zoom (maximize/restore)    |
| `<C-w>o`        | close all other                          |
| `<C-w>Q`        | force quit all with confirmation         |
| `<C-w>r`        | rotate down                              |
| `<C-w>s`        | split horizontally                       |
| `<C-w>v`        | split vertically                         |
| `<silent><C-\>` | close quick action and clear highlight   |
| `<C-w>=`        | equalize sizes                           |
| `<C-w>]`        | split and jump to symbol                 |
| `<C-w>f`        | split and go to file under cursor        |
| `<C-w>g`        | Toggle Goyo mode                         |
| `<C-w>gr`       | Resize window to selection               |
| `<C-w>gsa`      | Split above with selection               |
| `<C-w>gsb`      | Split below with selection               |
| `<C-w>gss`      | Split right with selection               |
| `<C-w>H`        | move current to left                     |
| `<C-w>h`        | move focus left                          |
| `<C-w>J`        | move current to bottom                   |
| `<C-w>j`        | move focus down                          |
| `<C-w>K`        | move current to top                      |
| `<C-w>k`        | move focus up                            |
| `<C-w>L`        | move current to right                    |
| `<C-w>l`        | move focus right                         |
| `<C-w>N`        | go to Nth                                |
| `<C-w>n`        | new empty                                |
| `<C-w>p`        | go to previous                           |
| `<C-w>q`        | quit current                             |
| `<C-w>R`        | rotate up                                |
| `<C-w>T`        | move current to new tab                  |
| `<C-w>W`        | go to last                               |
| `<C-w>x`        | exchanges                                |
| `<spc>-`        | decrease height                          |
| `<spc><`        | decrease width                           |
| `<spc>=`        | increase height                          |
| `<spc>>`        | increase width                           |
| `<spc>cc`       | close quickfix list                      |
| `<spc>co`       | open quickfix list                       |
| `<spc>rs`       | resize mode                              |

## Visual Mode

### Edit

| Key   | Description                           |
|-------|---------------------------------------|
| `p`   | paste without yanking replaced text   |

### REST

| Key     | Description                     |
|---------|---------------------------------|
| `<C-j>` | Execute selected HTTP request   |

### Search

| Key       | Description                              |
|-----------|------------------------------------------|
| `<spc>re` | replace word under cursor in selection   |

## Visual Mode (Line)

### Buffers

| Key   | Description                          |
|-------|--------------------------------------|
| `gs`  | Open scratch buffer with selection   |

### Edit

| Key     | Description                            |
|---------|----------------------------------------|
| `<`     | indent left and stay in visual mode    |
| `<C-/>` | comment                                |
| `<C-z>` | Undo                                   |
| `>`     | indent right and stay in visual mode   |
| `p`     | paste without yanking replaced text    |
| `x`     | Cut in visual mode                     |

### Edit Cursor

| Key     | Description           |
|---------|-----------------------|
| `<C-d>` | Add next occurrence   |

### Edit Paste

| Key   | Description                            |
|-------|----------------------------------------|
| `y`   | Yank selection without moving cursor   |

### Edit Replace

| Key           | Description                            |
|---------------|----------------------------------------|
| `<spc><spc>s` | Smart case substitute motion           |
| `<spc>s`      | Substitute motion with prompted text   |

### Edit Surround

| Key   | Description                          |
|-------|--------------------------------------|
| `S`   | Surround selection (S + delimiter)   |

### Files

| Key     | Description   |
|---------|---------------|
| `<C-s>` | save          |

### Git

| Key       | Description                   |
|-----------|-------------------------------|
| `<spc>gc` | commits affecting selection   |

### Lines

| Key        | Description           |
|------------|-----------------------|
| `<M-Down>` | move selection down   |
| `<M-j>`    | move selection down   |
| `<M-k>`    | move selection up     |
| `<M-Up>`   | move selection up     |

### Windows

| Key        | Description                  |
|------------|------------------------------|
| `<C-w>gr`  | Resize window to selection   |
| `<C-w>gsa` | Split above with selection   |
| `<C-w>gsb` | Split below with selection   |
| `<C-w>gss` | Split right with selection   |

## Insert Mode

### Copilot

| Key           | Description                 |
|---------------|-----------------------------|
| `<M-\>`       | Request suggestion          |
| `<M-\[>`      | Cycle previous suggestion   |
| `<M-\]>`      | Cycle next suggestion       |
| `<M-C-Right>` | Accept next line            |
| `<M-Right>`   | Accept next word            |
| `<Tab>`       | Accept suggestion           |

### Edit

| Key          | Description                                 |
|--------------|---------------------------------------------|
| `<C-/>`      | comment                                     |
| `<C-A>`      | repeat last Insert                          |
| `<C-D>`      | outdent                                     |
| `<C-E>`      | cancel completion                           |
| `<C-N>`      | word completion                             |
| `<C-o>`      | execute a command                           |
| `<C-P>`      | word completion                             |
| `<C-R>=`     | calculator                                  |
| `<C-T>`      | indent                                      |
| `<C-U>`      | delete to last insert in the current line   |
| `<C-W>`      | delete word backward                        |
| `<C-X><C-F>` | file name completion                        |
| `<C-X><C-L>` | line completion                             |
| `<C-X><C-U>` | snippets                                    |
| `<C-Y>`      | insert char above cursor                    |
| `<C-z>`      | Undo                                        |

### Edit Color

| Key     | Description         |
|---------|---------------------|
| `<M-c>` | Open color picker   |

### Edit Pairs

| Key     | Description                |
|---------|----------------------------|
| `<M-b>` | Back insert pair           |
| `<M-n>` | Jump to next closed pair   |
| `<M-p>` | Toggle auto pairs on/off   |

### Files

| Key     | Description   |
|---------|---------------|
| `<C-s>` | save          |

### Lines

| Key        | Description   |
|------------|---------------|
| `<M-Down>` | move down     |
| `<M-j>`    | move down     |
| `<M-k>`    | move up       |
| `<M-Up>`   | move up       |

### REST

| Key     | Description                         |
|---------|-------------------------------------|
| `<C-j>` | Execute HTTP request under cursor   |

### Windows

| Key      | Description        |
|----------|--------------------|
| `<C-w>g` | Toggle Goyo mode   |

## Command Mode

### Edit

| Key       | Description        |
|-----------|--------------------|
| `:e!<cr>` | undo all changes   |

### Emacs

| Key             | Description         |
|-----------------|---------------------|
| `<C-a>`         | move to beginning   |
| `<C-b>`         | move backward       |
| `<C-d>`         | delete character    |
| `<C-e>`         | move to end         |
| `<C-f>`         | move forward        |
| `<C-k>`         | kill to beginning   |
| `<M-Backspace>` | delete word         |

## Operator-pending Mode

### Edit

| Key     | Description   |
|---------|---------------|
| `<C-/>` | comment       |

### Text Objects

| Key   | Description                                        |
|-------|----------------------------------------------------|
| `a)`  | Around next parentheses                            |
| `aI`  | Around indentation level (including blank lines)   |
| `ai`  | Around indentation level                           |
| `i'`  | Inside next single quotes                          |
| `i,`  | Inside next comma-separated value                  |
| `ie`  | Inner entire buffer                                |
| `ii`  | Inside indentation level                           |
| `iI`  | Inside indentation level (including blank lines)   |
| `iv`  | Current viewable text                              |

