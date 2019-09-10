-- if you add new heads, you should change headnumber value accordingly

headnumber = 129

for i = 1, headnumber do

	local x = i + 1
	local y = i - 1
	if x > headnumber then x = 1 end
	if y < 1 then y = headnumber end

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
	    drop = "heads:head_"..i,
		
		after_place_node = function(pos, placer, itemstack)

			local item = placer:get_wielded_item():to_string()		
			local meta = ItemStack(item):get_meta()
			local some_meta = meta:get_string("description")			

			local meta2 = minetest.get_meta(pos)
			meta2:set_string("description", some_meta)
			meta2:set_string("infotext", some_meta)

		end,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)

			local meta = minetest.get_meta(pos)
			local description = meta:get_string("description")
			
			local stack = ItemStack(oldnode.name)
			local meta2 = stack:get_meta()
			meta2:set_string("description", description)

			minetest.add_item({x = pos.x, y = pos.y + 1, z = pos.z}, stack)

		end,	
		
	})
	
end


minetest.register_on_dieplayer(function(player)
	
	local name = player:get_player_name()
	local pos = vector.round(player:getpos())
	local skin_num = string.match(skins.skins[name],"%d+")

	local stack = ItemStack("heads:head_"..skin_num)
	local meta = stack:get_meta()
	meta:set_string("description", "Head of "..name)

	minetest.sound_play("head_drop", {pos, gain = 1.0, })	
	minetest.add_item({x = pos.x, y = pos.y + 1, z = pos.z}, stack)

end)
