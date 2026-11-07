hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve( "overshoot",     { type = "bezier", points = { {0.5, 0.9}, {0.1, 1.1} } } )

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.curve("rubber",         { type = "spring", mass = 1, stiffness = 70,       dampening = 10 } )

hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 3,    spring = "easy",             style = "popin" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2,    bezier = "linear",           style = "popin" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 1.5,  bezier = "almostLinear" })

hl.animation({ leaf = "layersIn",      enabled = true,  speed = 1,    spring = "easy",             style = "slide" })
hl.animation({ leaf = "layersOut",     enabled = false, speed = 3,    bezier = "overshoot",        style = "popin" })

hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1,    bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1,    bezier = "almostLinear" })

hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.5,  spring = "easy",             style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1,    bezier = "easeInOutCubic",   style = "fade" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })
