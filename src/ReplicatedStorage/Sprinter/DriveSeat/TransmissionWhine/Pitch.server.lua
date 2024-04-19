local last = 0
local ticc = tick()
while wait() do
seat = script.Parent.Parent
speed = math.floor(seat.Velocity.Magnitude) or 0
if speed>last then ticc = tick() end
if tick()-ticc < .75 and tick()-ticc > 0.1 then
    script.Parent.FlangeSoundEffect.Depth = .7
else
    script.Parent.FlangeSoundEffect.Depth = 0.01
end
seat.TransmissionWhine.Pitch = (speed/150)+0.100
last = speed
end