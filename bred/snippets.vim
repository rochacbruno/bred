" Abbreviation completion
" TIP: Use <C-x><C-u> in insert mode to trigger the completion
" Example: Type 'teh' and press <C-x><C-u> to get 'the'
" To cancel abbreviation press C-v before typing the space
" e.g: teh<C-v><Space> will result in 'teh ' instead of 'the '

function! GetAbbrevDict()
    let l:abbrev_dict = {}
    redir => l:iab_output
    silent iab
    redir END
    " Parse each line of iab output - format: "i  abbreviation  expansion"
    for line in split(l:iab_output, '\n')
        " Match lines that contain abbreviation and expansion
        let parts = matchlist(line, '^\s*i\s\+\(\k\+\)\s\+\(.\+\)')
        if len(parts) >= 3
            let l:abbrev_dict[parts[1]] = parts[2]
        endif
    endfor
    return l:abbrev_dict
endfunction

set completefunc=CompleteAbbrev
set completeopt=menu,menuone,noinsert,noselect
function! CompleteAbbrev(findstart, base)
    if a:findstart
        " Find the start of the word to complete
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\k'
            let start -= 1
        endwhile
        return start
    else
        let l:abbrev_dict = GetAbbrevDict()
        let l:completions = []
        for [abbrev, expansion] in items(l:abbrev_dict)
            if abbrev =~ '^' . a:base
                call add(l:completions, {
                    \ 'word': abbrev,
                    \ 'menu': '→ ' . expansion
                    \ })
            endif
        endfor
        " Sort completions alphabetically by abbreviation
        return sort(l:completions, {a, b -> a.word == b.word ? 0 : a.word > b.word ? 1 : -1})
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
iabbr EfaceE 😊 
iabbr EsmileE 🙂
iabbr EupsidedownE 🙃
iabbr EmeltingE 🫠
iabbr EwinkE 😉
iabbr EhappyE 😃
iabbr EgrinE 😁
iabbr ElmfaoE 🤣
iabbr ElolE 😂
iabbr EsadE 😞
iabbr EpleadE 🥺
iabbr EtearsE 🥹
iabbr EcryloudE 😭
iabbr EcryE 😢
iabbr EhearteyesE 😍
iabbr ElovedE 🥰
iabbr EstareyesE 🤩
iabbr EvomitE 🤮
iabbr EsickE 🤢
iabbr ElickE 😛
iabbr EangryE 😡
iabbr EcoolE 😎
iabbr EdiagonalE 🫤
iabbr EpokerE 😐
iabbr Epoker2E 😑
iabbr EsmirkE 😏
iabbr EunamusedE 😒
iabbr EthinkingE 🤔
iabbr EwavingE 🤗
iabbr EdaemonE 😈
iabbr EangleE 😇
iabbr EclownE 🤡
iabbr EshhhE 🤫
iabbr EkhhhE 🤭
iabbr EconfusedE 😵
iabbr EmindblownE 🤯
iabbr EnerdE 🤓
iabbr EfancyE 🧐
iabbr EscaredE 😨
iabbr EpanicE 😱
iabbr EboredE 🥱
iabbr EskullE 💀
iabbr EdeathE ☠
iabbr EvirusE 👾
iabbr EalienE 👽
iabbr EghostE 👻
iabbr EthoughtE 💭
iabbr EwaveE 👋
iabbr EhiE 🤚
iabbr Ehi2E 🤚
iabbr EitalianE 🤌
iabbr EchefkissE 👌
iabbr EpinchE 🤏
iabbr EpointuE ☝️
iabbr EpointdE 👇
iabbr EpointlE 👈
iabbr EpointrE 👉
iabbr EfuckuE 🖕
iabbr EmetalE 🤘
iabbr EnoseE 👃
iabbr EeyeE 👀
iabbr EpowerE 💪
iabbr EshrugE 🤷
iabbr EorangutanE 🦧
iabbr EgorillaE 🦍
iabbr EdogE 🐶
iabbr EcatE 🐱
iabbr EpigE 🐷
iabbr EbearE 🐻
iabbr EpandaE 🐼
iabbr EchikenE 🐣
iabbr EowlE 🦉
iabbr EturtleE 🐢
iabbr EwhaleE 🐳
iabbr EroseE 🌹
iabbr EwiltedE 🥀
iabbr EeggplantE 🍆
iabbr EpeachE 🍑
iabbr EbellE 🔔
iabbr EpianoE 🎹
iabbr EguitarE 🎸
iabbr EcellphoneE 📱
iabbr EbatteryE 🔋
iabbr EbatterylowE 🪫
iabbr EplugE 🔌
iabbr ElaptopE 💻
iabbr EdesktopE 
iabbr EfloppyE 💾
iabbr EfilmE 🎥
iabbr EsateliteE 📡
iabbr EnazarE 🧿
iabbr EmoaiE 🗿
iabbr EwarningE ⚠
iabbr EmaleE ♀
iabbr EfemaleE ♂
iabbr EtransE ⚧
iabbr EquestionE ❓
iabbr EbangE ❗
iabbr EdollarE 💲
iabbr EcircleE ⭕
iabbr EtikE ✅
iabbr EcrossE ❌
iabbr EplusE ➕
iabbr EminusE ➖
iabbr EcopyrightE ©
iabbr EtmE ™
iabbr EregisteredE ®
iabbr EoneE 1️⃣
iabbr EtwoE 2️⃣
iabbr EthreeE 3️⃣
iabbr EfourE 4️⃣
iabbr EfiveE 5️⃣
iabbr EsixE 6️⃣
iabbr EsevenE 7️⃣
iabbr EeightE 8️⃣
iabbr EnineE 9️⃣
iabbr EballrE 🔴
iabbr EballyE 🟡
iabbr EballgE 🟢
iabbr EballbE 🔵
iabbr EcuberE 🟥
iabbr EcubeyE 🟨
iabbr EcubegE 🟩
iabbr EdiamondoE 🔶
iabbr EdiamondbE 🔷
iabbr EsdiamondbE 🔹
iabbr EodiamondoE 🔸
iabbr EtriangleuE 🔺
iabbr EtriangledE 🔻
iabbr EflagE 🚩
iabbr EsoundoffE 🔇
iabbr EspeakerE 🔈
iabbr EgemE 💎
iabbr EclubsE ♣
iabbr EdiamondE ♦
iabbr EspadesE ♠
iabbr EheartcardsE ♥
iabbr EstarE ⭐
iabbr EfullmoonE 🌑
iabbr EcresentmoonE 🌒
iabbr EsunE ☀
iabbr E100E 💯
iabbr EheartE 
iabbr EblueheartE 💙
iabbr EappleE 🍎
iabbr EtimeE ⌛
iabbr EbombE 💣
iabbr EfireE 🔥
iabbr EgnuE 🐃
iabbr EplayE ▶
iabbr EmusicE 🎵
iabbr EbookE 📘
iabbr EscrollE 📃
iabbr EparchmentE 📜
iabbr EmailE ✉
iabbr EdirectoryE 📁
iabbr EtrashE 
iabbr ElawE ⚖
iabbr EwrenchE 🔧
iabbr EgearE ⚙
iabbr EswordsE ⚔
iabbr EswordE 󰓥
iabbr EclockE ⏰
iabbr ElockE 🔒
iabbr ElinuxE 🐧
iabbr EcowE 🐄
iabbr EwifiE 📶
iabbr EblockE 🚫
iabbr ElinkE 🔗
iabbr EgameE 🎮
iabbr EburguerE 🍔
iabbr EglobeE 🌎
iabbr EmouseE 🐁
iabbr EcheckE ✔
iabbr EupE ⬆
iabbr EdownE ⬇
iabbr EleftE ⬅
iabbr ErightE ➡
iabbr EkeyE 🔑
iabbr EpoopE 💩
iabbr EcakeE 🎂
iabbr EpythonE 🐍
iabbr EtrophyE 🏆
iabbr EclipE 📎
iabbr EkeybE ⌨
iabbr ErainbowE 🌈
iabbr EdockerE 🐳
iabbr ElightE 💡
iabbr EfolderE 📁
iabbr EbeerE 🍺
iabbr EwineE 🍷
iabbr EcocktailE 🍸
iabbr EwaterE 💧


" load custom abbreviations if the file exists
if filereadable(expand("~/.vim/custom.snippets.vim"))
    execute 'source' expand("~/.vim/custom.snippets.vim")
endif
