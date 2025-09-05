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
iabbr _face: 😊 
iabbr _smile: 🙂
iabbr _upsidedown: 🙃
iabbr _melting: 🫠
iabbr _wink: 😉
iabbr _happy: 😃
iabbr _grin: 😁
iabbr _lmfao: 🤣
iabbr _lol: 😂
iabbr _sad: 😞
iabbr _plead: 🥺
iabbr _tears: 🥹
iabbr _cryloud: 😭
iabbr _cry: 😢
iabbr _hearteyes: 😍
iabbr _loved: 🥰
iabbr _stareyes: 🤩
iabbr _vomit: 🤮
iabbr _sick: 🤢
iabbr _lick: 😛
iabbr _angry: 😡
iabbr _cool: 😎
iabbr _diagonal: 🫤
iabbr _poker: 😐
iabbr _poker2: 😑
iabbr _smirk: 😏
iabbr _unamused: 😒
iabbr _thinking: 🤔
iabbr _waving: 🤗
iabbr _daemon: 😈
iabbr _angle: 😇
iabbr _clown: 🤡
iabbr _shhh: 🤫
iabbr _khhh: 🤭
iabbr _confused: 😵
iabbr _mindblown: 🤯
iabbr _nerd: 🤓
iabbr _fancy: 🧐
iabbr _scared: 😨
iabbr _panic: 😱
iabbr _bored: 🥱
iabbr _skull: 💀
iabbr _death: ☠
iabbr _virus: 👾
iabbr _alien: 👽
iabbr _ghost: 👻
iabbr _thought: 💭
iabbr _wave: 👋
iabbr _hi: 🤚
iabbr _hi2: 🤚
iabbr _italian: 🤌
iabbr _chefkiss: 👌
iabbr _pinch: 🤏
iabbr _pointu: ☝️
iabbr _pointd: 👇
iabbr _pointl: 👈
iabbr _pointr: 👉
iabbr _fucku: 🖕
iabbr _metal: 🤘
iabbr _nose: 👃
iabbr _eye: 👀
iabbr _power: 💪
iabbr _shrug: 🤷
iabbr _orangutan: 🦧
iabbr _gorilla: 🦍
iabbr _dog: 🐶
iabbr _cat: 🐱
iabbr _pig: 🐷
iabbr _bear: 🐻
iabbr _panda: 🐼
iabbr _chiken: 🐣
iabbr _owl: 🦉
iabbr _turtle: 🐢
iabbr _whale: 🐳
iabbr _rose: 🌹
iabbr _wilted: 🥀
iabbr _eggplant: 🍆
iabbr _peach: 🍑
iabbr _bell: 🔔
iabbr _piano: 🎹
iabbr _guitar: 🎸
iabbr _cellphone: 📱
iabbr _battery: 🔋
iabbr _batterylow: 🪫
iabbr _plug: 🔌
iabbr _laptop: 💻
iabbr _desktop: 
iabbr _floppy: 💾
iabbr _film: 🎥
iabbr _satelite: 📡
iabbr _nazar: 🧿
iabbr _moai: 🗿
iabbr _warning: ⚠
iabbr _male: ♀
iabbr _female: ♂
iabbr _trans: ⚧
iabbr _question: ❓
iabbr _bang: ❗
iabbr _dollar: 💲
iabbr _circle: ⭕
iabbr _tik: ✅
iabbr _cross: ❌
iabbr _plus: ➕
iabbr _minus: ➖
iabbr _copyright: ©
iabbr _tm: ™
iabbr _registered: ®
iabbr _one: 1️⃣
iabbr _two: 2️⃣
iabbr _three: 3️⃣
iabbr _four: 4️⃣
iabbr _five: 5️⃣
iabbr _six: 6️⃣
iabbr _seven: 7️⃣
iabbr _eight: 8️⃣
iabbr _nine: 9️⃣
iabbr _ballr: 🔴
iabbr _bally: 🟡
iabbr _ballg: 🟢
iabbr _ballb: 🔵
iabbr _cuber: 🟥
iabbr _cubey: 🟨
iabbr _cubeg: 🟩
iabbr _diamondo: 🔶
iabbr _diamondb: 🔷
iabbr _sdiamondb: 🔹
iabbr _odiamondo: 🔸
iabbr _triangleu: 🔺
iabbr _triangled: 🔻
iabbr _flag: 🚩
iabbr _soundoff: 🔇
iabbr _speaker: 🔈
iabbr _gem: 💎
iabbr _clubs: ♣
iabbr _diamond: ♦
iabbr _spades: ♠
iabbr _heartcards: ♥
iabbr _star: ⭐
iabbr _fullmoon: 🌑
iabbr _cresentmoon: 🌒
iabbr _sun: ☀
iabbr _100: 💯
iabbr _heart: 
iabbr _blueheart: 💙
iabbr _apple: 🍎
iabbr _time: ⌛
iabbr _bomb: 💣
iabbr _fire: 🔥
iabbr _gnu: 🐃
iabbr _play: ▶
iabbr _music: 🎵
iabbr _book: 📘
iabbr _scroll: 📃
iabbr _parchment: 📜
iabbr _mail: ✉
iabbr _directory: 📁
iabbr _trash: 
iabbr _law: ⚖
iabbr _wrench: 🔧
iabbr _gear: ⚙
iabbr _swords: ⚔
iabbr _sword: 󰓥
iabbr _clock: ⏰
iabbr _lock: 🔒
iabbr _linux: 🐧
iabbr _cow: 🐄
iabbr _wifi: 📶
iabbr _block: 🚫
iabbr _link: 🔗
iabbr _game: 🎮
iabbr _burguer: 🍔
iabbr _globe: 🌎
iabbr _mouse: 🐁
iabbr _check: ✔
iabbr _up: ⬆
iabbr _down: ⬇
iabbr _left: ⬅
iabbr _right: ➡
iabbr _key: 🔑
iabbr _poop: 💩
iabbr _cake: 🎂
iabbr _python: 🐍
iabbr _trophy: 🏆
iabbr _clip: 📎
iabbr _keyb: ⌨
iabbr _rainbow: 🌈
iabbr _docker: 🐳
iabbr _light: 💡
iabbr _folder: 📁
iabbr _beer: 🍺
iabbr _wine: 🍷
iabbr _cocktail: 🍸
iabbr _water: 💧


" load custom abbreviations if the file exists
if filereadable(expand("~/.vim/custom.snippets.vim"))
    execute 'source' expand("~/.vim/custom.snippets.vim")
endif
