newSource = love.audio.newSource

export resources = {
    bgm_menu: newSource "res/music/Cellular_Annoyance_1_intro.ogg", "stream"
    bgm_sandbox: newSource "res/music/Cellular_Annoyance_2_intense.ogg", "stream"
}

resources.bgm_menu\setLooping true
resources.bgm_sandbox\setLooping true
