--
-- SERIALIZATION FUNCTIONS
-- Turns position vector in string format, eg "10,25,-12" (x = 10, y = 25, z = -12)
--
function tech_reborn.deserializepos(posString)
  local x = posString:sub(1, posString:find(",", 1, true) - 1)
  local y = posString:sub(x:len() + 2, posString:find(",", x:len() + 2) - 1, true)
  local z = posString:sub(y:len() + 1 + x:len() + 2, posString:find(",", x:len() + 1 + y:len() + 2), true)
  return vector.new(tonumber(x), tonumber(y), tonumber(z))
end

function tech_reborn.serializepos(pos)
  return pos.x..","..pos.y..","..pos.z
end

--
-- GET ADJACENT
-- Return adjacent nodes
--
function tech_reborn.getAdjacent(pos)
	return {
		vector.new(pos.x, pos.y + 1, pos.z),
		vector.new(pos.x, pos.y - 1, pos.z),
		vector.new(pos.x + 1, pos.y, pos.z),
		vector.new(pos.x - 1, pos.y, pos.z),
		vector.new(pos.x, pos.y, pos.z + 1),
		vector.new(pos.x, pos.y, pos.z - 1)
	}
end