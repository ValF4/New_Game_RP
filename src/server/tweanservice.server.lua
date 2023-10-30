local TweenService = game:GetService("TweenService")
local bloco =  workspace.bloco


local animation = TweenInfo.new(
    10,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out,
    0,
    false,
    3
)


local execucao = TweenService:Create(bloco, animation,{Transparency = 1})
execucao:Play()