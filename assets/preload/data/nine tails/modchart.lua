function update (elapsed)
	if curStep >= 1340 and curStep < 1600 then
		local currentBeat = (songPos / 1000)*(bpm/180)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 30 * math.sin((currentBeat + i*0.20) * math.pi), i)
		end
	else
        	for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'],i)
        	end
    	end
end