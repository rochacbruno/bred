" Abbreviation completion
" TIP: Use <C-x><C-u> in insert mode to trigger the completion
" Example: Type 'teh' and press <C-x><C-u> to get 'the'
" To cancel abbreviation press C-v before typing the space
" e.g: teh<C-v><Space> will result in 'teh ' instead of 'the '

function! GetAbbrevList()
    let l:abbrev_list = []
    redir => l:iab_output
    silent iab
    redir END
    " Parse each line of iab output - format: "i  abbreviation  expansion"
    for line in split(l:iab_output, '\n')
        " Match lines that start with i followed by abbreviation name
        let match = matchstr(line, '^\s*i\s\+\zs\k\+')
        if !empty(match)
            call add(l:abbrev_list, match)
        endif
    endfor
    return l:abbrev_list
endfunction

set completefunc=CompleteAbbrev
function! CompleteAbbrev(findstart, base)
    if a:findstart
        return searchpos('\<\k', 'bcnW', line('.'))[1] - 1
    else
        let s:abbrev_list = GetAbbrevList()
        return filter(copy(s:abbrev_list), 'v:val =~ "^" . a:base')
    endif
endfunction


" Global abbreviations
iab teh the
iab adress address
iab recieve receive
iab definately definitely
iab occured occurred
iab seperately separately
iab lenght length
iab Lenght Length
iab widht width
iab Widht Width
iab heigth height
iab Heigth Height
iab enviroment environment
iab Enviroment Environment
iab dont don't
iab Dont Don't
iab doesnt doesn't
iab Doesnt Doesn't
iab isnt isn't
iab Isnt Isn't
iab wasnt wasn't
iab Wasnt Wasn't
iab couldnt couldn't
iab Couldnt Couldn't
iab shouldnt shouldn't
iab Shouldnt Shouldn't
iab wouldnt wouldn't
iab Wouldnt Wouldn't
iab wont won't
iab Wont Won't
iab cant can't
iab Cant Can't
iab sicne since
iab descriptoin description
iab rochabruno rochacbruno

" pt 
iab neh né
iab soh só
iab ja já

" Emoji
iabbr :face: 😊 
iabbr :smile: 🙂
iabbr :upsidedown: 🙃
iabbr :melting: 🫠
iabbr :wink: 😉
iabbr :happy: 😃
iabbr :grin: 😁
iabbr :lmfao: 🤣
iabbr :lol: 😂
iabbr :sad: 😞
iabbr :longf: ☹️
iabbr :plead: 🥺
iabbr :tears: 🥹
iabbr :cryloud: 😭
iabbr :cry: 😢
iabbr :hearteyes: 😍
iabbr :loved: 🥰
iabbr :stareyes: 🤩
iabbr :vomit: 🤮
iabbr :sick: 🤢
iabbr :lick: 😛
iabbr :angry: 😡
iabbr :cool: 😎
iabbr :diagonal: 🫤
iabbr :poker: 😐
iabbr :poker2: 😑
iabbr :smirk: 😏
iabbr :unamused: 😒
iabbr :thinking: 🤔
iabbr :waving: 🤗
iabbr :daemon: 😈
iabbr :angle: 😇
iabbr :clown: 🤡
iabbr :shhh: 🤫
iabbr :khhh: 🤭
iabbr :confused: 😵
iabbr :mindblown: 🤯
iabbr :nerd: 🤓
iabbr :fancy: 🧐
iabbr :scared: 😨
iabbr :panic: 😱
iabbr :bored: 🥱
iabbr :skull: 💀
iabbr :death: ☠
iabbr :virus: 👾
iabbr :alien: 👽
iabbr :ghost: 👻
iabbr :thought: 💭
iabbr :wave: 👋
iabbr :hi: 🤚
iabbr :hi2: 🤚
iabbr :italian: 🤌
iabbr :chefkiss: 👌
iabbr :pinch: 🤏
iabbr :pointu: ☝️
iabbr :pointd: 👇
iabbr :pointl: 👈
iabbr :pointr: 👉
iabbr :fucku: 🖕
iabbr :metal: 🤘
iabbr :nose: 👃
iabbr :eye: 👀
iabbr :power: 💪
iabbr :shrug: 🤷
iabbr :orangutan: 🦧
iabbr :gorilla: 🦍
iabbr :dog: 🐶
iabbr :cat: 🐱
iabbr :pig: 🐷
iabbr :bear: 🐻
iabbr :panda: 🐼
iabbr :chiken: 🐣
iabbr :owl: 🦉
iabbr :turtle: 🐢
iabbr :whale: 🐳
iabbr :rose: 🌹
iabbr :wilted: 🥀
iabbr :eggplant: 🍆
iabbr :peach: 🍑
iabbr :bell: 🔔
iabbr :piano: 🎹
iabbr :guitar: 🎸
iabbr :cellphone: 📱
iabbr :battery: 🔋
iabbr :batterylow: 🪫
iabbr :plug: 🔌
iabbr :laptop: 💻
iabbr :desktop: 🖥
iabbr :floppy: 💾
iabbr :film: 🎥
iabbr :satelite: 📡
iabbr :nazar: 🧿
iabbr :moai: 🗿
iabbr :warning: ⚠
iabbr :male: ♀
iabbr :female: ♂
iabbr :trans: ⚧
iabbr :question: ❓
iabbr :bang: ❗
iabbr :dollar: 💲
iabbr :circle: ⭕
iabbr :tik: ✅
iabbr :cross: ❌
iabbr :plus: ➕
iabbr :minus: ➖
iabbr :copyright: ©
iabbr :tm: ™
iabbr :registered: ®
iabbr :one: 1️⃣
iabbr :two: 2️⃣
iabbr :three: 3️⃣
iabbr :four: 4️⃣
iabbr :five: 5️⃣
iabbr :six: 6️⃣
iabbr :seven: 7️⃣
iabbr :eight: 8️⃣
iabbr :nine: 9️⃣
iabbr :ballr: 🔴
iabbr :bally: 🟡
iabbr :ballg: 🟢
iabbr :ballb: 🔵
iabbr :cuber: 🟥
iabbr :cubey: 🟨
iabbr :cubeg: 🟩
iabbr :diamondo: 🔶
iabbr :diamondb: 🔷
iabbr :sdiamondb: 🔹
iabbr :odiamondo: 🔸
iabbr :triangleu: 🔺
iabbr :triangled: 🔻
iabbr :flag: 🚩
iabbr :soundoff: 🔇
iabbr :speaker: 🔈
iabbr :gem: 💎
iabbr :clubs: ♣
iabbr :diamond: ♦
iabbr :spades: ♠
iabbr :heartcards: ♥
iabbr :star: ⭐
iabbr :fullmoon: 🌑
iabbr :cresentmoon: 🌒
iabbr :sun: ☀
iabbr :100: 💯
iabbr :heart: ❤️
iabbr :blueheart: 💙
iabbr :apple: 🍎
iabbr :time: ⌛
iabbr :bomb: 💣
iabbr :fire: 🔥
iabbr :gnu: 🐃
iabbr :play: ▶️
iabbr :music: 🎵
iabbr :book: 📘
iabbr :scroll: 📃
iabbr :parchment: 📜
iabbr :mail: ✉
iabbr :directory: 📁
iabbr :trash: 🗑
iabbr :law: ⚖
iabbr :wrench: 🔧
iabbr :gear: ⚙
iabbr :swords: ⚔
iabbr :sword: 🗡
iabbr :clock: ⏰
iabbr :lock: 🔒
iabbr :linux: 🐧
iabbr :cow: 🐄
iabbr :wifi: 📶
iabbr :block: 🚫
iabbr :link: 🔗
iabbr :game: 🎮
iabbr :burguer: 🍔
iabbr :globe: 🌎
iabbr :mouse: 🐁
iabbr :check: ✔️
iabbr :up: ⬆️
iabbr :down: ⬇️
iabbr :left: ⬅️
iabbr :right: ➡️
iabbr :key: 🔑
iabbr :poop: 💩
iabbr :cake: 🎂
iabbr :python: 🐍
iabbr :trophy: 🏆
iabbr :clip: 📎
iabbr :keyb: ⌨️
iabbr :rainbow: 🌈
iabbr :docker: 🐳
iabbr :light: 💡
iabbr :folder: 📁
iabbr :beer: 🍺
iabbr :wine: 🍷
iabbr :cocktail: 🍸
iabbr :water: 💧


" load custom abbreviations if the file exists
if filereadable(expand("~/.vim/custom.snippets.vim"))
    execute 'source' expand("~/.vim/custom.snippets.vim")
endif
