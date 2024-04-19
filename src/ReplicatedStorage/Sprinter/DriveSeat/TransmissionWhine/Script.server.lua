while true do
wait()
if script.Parent.Parent.Velocity.Magnitude >= 3 then
script.Parent.Volume = .5
else
script.Parent.Volume = 0
end
if script.Parent.Playing == false then
script.Parent.Playing = true	
end

end