" ==================================================================
" Markdown
" ==================================================================

" Prevent hiding of certain markdown syntax elements
setlocal conceallevel=0
setlocal concealcursor=

autocmd FileType markdown hi markdownError ctermbg=NONE guibg=NONE


iabbrev <buffer> ppause <!-- pause -->
iabbrev <buffer> peos <!-- end_slide -->
iabbrev <buffer> pcolayout <!-- column_layout: [3, 2] -->
iabbrev <buffer> pcolumn <!-- column: 0 -->
iabbrev <buffer> presetlayout <!-- reset_layout -->
iabbrev <buffer> pfont <!-- font_size: 2 -->
iabbrev <buffer> pjump <!-- jump_to_middle -->
iabbrev <buffer> pnewlines <!-- new_lines: 10 -->
iabbrev <buffer> pnewline <!-- new_line -->
iabbrev <buffer> pinc <!-- incremental_lists: true -->
iabbrev <buffer> pincoff <!-- incremental_lists: false -->
iabbrev <buffer> plistnl <!-- list_item_newlines: 2 -->
iabbrev <buffer> pincfile <!-- include: file.md -->
iabbrev <buffer> pnof <!-- no_footer -->
iabbrev <buffer> pskip <!-- skip_slide -->
iabbrev <buffer> palignl <!-- alignment: left -->
iabbrev <buffer> palignc <!-- alignment: center -->
iabbrev <buffer> palignr <!-- alignment: right -->
iabbrev <buffer> psnippetout <!-- snippet_output: identifier -->

iabbrev <buffer> pimg ![image:width:50%](image.png)
iabbrev <buffer> pcodefile ```rust file:src/main.rs
iabbrev <buffer> pcodefilerange ```rust file:src/main.rs:10:20
iabbrev <buffer> pcolor <span style="color: #ff0000; background-color: transparent">colored text</span>
iabbrev <buffer> pcolortheme <span style="color: palette:primary; background-color: palette:background">themed text</span>

" Multi-line abbreviations
iabbrev <buffer> ptitle ---<CR>title: ""<CR>sub_title: ""<CR>author: <CR>options: <CR>  implicit_slide_ends: true<CR>end_slide_shorthand: true<CR>incremental_lists: true<CR><BS>---
iabbrev <buffer> pslide Slide Title<CR>===========
iabbrev <buffer> pcode ```rust<CR>// Your code here<CR>
iabbrev <buffer> pcodeln ```rust +line_numbers<CR>// Your code here<CR>
iabbrev <buffer> pcodehl ```rust {1,3,5-7}<CR>// Your code here<CR>
iabbrev <buffer> pcodeprog ```rust {1-3\|5-7\|all}<CR>// Your code here<CR>
iabbrev <buffer> pexec ```bash +exec<CR>echo "Hello, World!"<CR>
iabbrev <buffer> pexecreplace ```bash +exec_replace<CR>date<CR>
iabbrev <buffer> pmermaid ```mermaid +render<CR>graph TD<CR>    A[Start] --> B[End]<CR>
iabbrev <buffer> pmermaidw ```mermaid +render +width:50%<CR>graph TD<CR>    A[Start] --> B[End]<CR>
iabbrev <buffer> platex ```latex +render<CR>\begin{equation}<CR>E = mc^2<CR>\end{equation}<CR>
iabbrev <buffer> ptypst ```typst +render<CR>$ sum_(i=0)^n i = (n(n+1))/2 $<CR>
iabbrev <buffer> pcodenobg ```rust +no_background<CR>// Your code here<CR>
iabbrev <buffer> pvalidate ```bash +validate<CR>echo "This will be validated"<CR>
iabbrev <buffer> pexpectfail ```bash +exec +expect:failure<CR>exit 1<CR>
iabbrev <buffer> pacquireterm ```bash +exec +acquire_terminal<CR>vim<CR>
iabbrev <buffer> phidelines ```rust<CR>fn main() {<CR># // This line is hidden<CR>    println!("Visible");<CR># // This line is also hidden<CR>}<CR>
