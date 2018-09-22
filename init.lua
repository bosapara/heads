-- if you add new heads, you should change headnumber value accordingly

headnumber = 129

-- register head nodes

for i = 1, headnumber do

	local x = i + 1
	local y = i - 1
	if x > headnumber then x = 1 end
	if y < 1 then y = headnumber end

	minetest.register_node("heads:head_"..i, {
	    description = "Head Number "..i,
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
	    on_rightclick = function(pos, node, clicker)
	        node.name = "heads:head_"..x
	        minetest.env:set_node(pos, node)

	    end,
	    on_punch = function (pos, node, puncher)
	        node.name = "heads:head_"..y
	        minetest.set_node(pos, node)

	    end,
	})
	
end

-- register head craft




minetest.register_craft({
	output = "heads:head_1",
	recipe = {
		{"default:tree","default:leaves","default:tree"},
		{"default:leaves","default:goldblock","default:leaves"},
		{"default:tree","default:leaves","default:tree"},
		
	}
})
