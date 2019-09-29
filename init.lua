-- if you add new heads, you should change headnumber value accordingly

headnumber = 129

for i = 1, headnumber do

	minetest.register_node("heads:head_"..i, {
	    description = "Head Number "..i,
		wield_scale = {x=1.5, y=1.5, z=1.5},
	    drawtype = "nodebox",
	    tiles = {
			"[combine:16x16:-4,4=character_"..i..".png",--top
		    "[combine:16x16:-12,4=character_"..i..".png^[transformR180]",--bottom
			"[combine:16x16:-12,0=character_"..i..".png",--left
		  	"[combine:16x16:4,0=character_"..i..".png", --right 
		  	"[combine:16x16:-20,0=character_"..i..".png",--back
			"[combine:16x16:-4,0=character_"..i..".png", --face
			
	    },	    
	    paramtype = "light",
	    paramtype2 = "facedir",
	    node_box = {
	        type = "fixed",
	        fixed = {       
	            { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25, },   			
	        },
	    },
	    sunlight_propagates = true,
	    walkable = true,
	    selection_box = {
	        type = "fixed",
	        fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25, },
	    },
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	    drop = "",
		stack_max = 1,
		after_place_node = function(pos, placer, itemstack)

			local item = placer:get_wielded_item():to_string()		
			local meta = ItemStack(item):get_meta()
			local some_meta = meta:get_string("description")			

			local meta2 = minetest.get_meta(pos)
			meta2:set_string("description", some_meta)
			meta2:set_string("infotext", some_meta)

		end,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)

			if not digger then return end

			local meta = minetest.get_meta(pos)
			meta:from_table(oldmetadata)
			local description = meta:get_string("description")
			
			local stack = ItemStack(oldnode.name)
			local meta2 = stack:get_meta()
			meta2:set_string("description", description)
		
			if digger:get_inventory():room_for_item("main", stack) then
				digger:get_inventory():add_item('main', stack)
			else			
				minetest.add_item({x = pos.x, y = pos.y + 1, z = pos.z}, stack)				
			end
			
		end,	
		
	})
	
end


minetest.register_on_punchplayer(function(player, hitter, _, _, _, damage)
	if not (hitter and hitter:is_player()) then
		return 
	end

	local hp = player:get_hp()
	if hp - damage > 0 or hp <= 0 then
		return 
	end

	local hitter_name = hitter:get_player_name()
	local player_name = player:get_player_name()

	local item = hitter:get_wielded_item():to_string()

	local name = player_name

	local pos = vector.round(player:getpos())
	local skin_num = string.match(skins.skins[name],"%d+")

	local stack = ItemStack("heads:head_"..skin_num)
	local meta = stack:get_meta()
	
	local rand
	
	rand = math.random(1,100)
	
	if string.match(item, "sword") and rand < 20 then
		--minetest.chat_send_all("*** Server: "..hitter_name.." killed " .. player_name ..""..item)
	   	   
		meta:set_string("description", "Head of "..name)
		minetest.sound_play("head_drop", {pos, gain = 1.0, })	
		minetest.add_item({x = pos.x, y = pos.y + 1, z = pos.z}, stack)   
   
	end
 
    
end)