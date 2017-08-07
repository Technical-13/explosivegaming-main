--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/XSsBV6b

The credit below may be used by another script do not remove.
]]
local credits = {{
	name='Science List',
	owner='Explosive Gaming',
	dev='Cooldude2606',
	description='Shows a list with the amount of science packs made',
	factorio_version='0.15.23',
	show=true
	}}
local function credit_loop(reg) for _,cred in pairs(reg) do table.insert(credits,cred) end end
--Please Only Edit Below This Line-----------------------------------------------------------
local science_packs = {
	{'science-pack-1','Red',0,0},
	{'science-pack-2','Green',0,0},
	{'science-pack-3','Blue',0,0},
	{'military-science-pack','Military',0,0},
	{'production-science-pack','Production',0,0},
	{'high-tech-science-pack','High Tech',0,0},
	{'space-science-pack','Space',0,0}
}

local function get_per_minute(ammount_made,pack)
	local to_return = (ammount_made-pack[3])/((game.tick-pack[4])/(3600*game.speed))
	to_return = to_return or 0
	pack[3] = ammount_made
	pack[4] = game.tick
	return to_return
end

ExpGui.add_frame.left('science_list','item/lab','Open a list with the amount of science done','Guest',false,function(player,frame)
	frame.caption = 'Science'
	frame.add{name='total_title',type='label',caption='Total Packs:',style="caption_label_style"}
	frame.add{name='total_flow',type='flow',direction='vertical'}
	frame.add{name='minute_title',type='label',caption='Packs Per Minute:',style="caption_label_style"}
	frame.add{name='minute_flow',type='flow',direction='vertical'}
	for n,pack in pairs(global.science_packs) do
		local ammount_made = player.force.item_production_statistics.get_input_count(pack[1])
		frame.total_flow.add{name=pack[1],type='label',caption=pack[2]..': '..ammount_made}
		if tick_to_min(game.tick) < 1 then frame.minute_flow.add{name=pack[1],type='label',caption=pack[2]..': N/A'}
		else frame.minute_flow.add{name=pack[1],type='label',caption=pack[2]..': '..string.format('%.2f',get_per_minute(ammount_made,pack))} end
	end
end)

Event.register(Event.gui_update,function(event) for _,player in pairs(game.connected_players) do ExpGui.draw_frame.left(player,'science_list',true) end end)
Event.register(defines.events.on_research_finished, function(event) for _,player in pairs(game.connected_players) do ExpGui.draw_frame.left(player,'science_list',true) end end)
Event.register(-1,function() global.science_packs = science_packs end)
--Please Only Edit Above This Line-----------------------------------------------------------
return credits