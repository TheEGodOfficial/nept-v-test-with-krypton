--[[
	Free Version:
	https://www.roblox.com/catalog/4645404679/International-Fedora-Thailand
	https://www.roblox.com/catalog/3662265036/International-Fedora-Indonesia
	https://www.roblox.com/catalog/4622081834/International-Fedora-China
	https://www.roblox.com/catalog/3992084515/International-Fedora-Vietnam
	https://www.roblox.com/catalog/4819740796/Robox

	Accurate Version:
	https://www.roblox.com/catalog/14255560646/Extra-Left-Tan-Arm
	https://www.roblox.com/catalog/14255562939/Extra-Right-Tan-Arm
	https://www.roblox.com/catalog/17374846953/Extra-Right-Black-Arm
	https://www.roblox.com/catalog/17374851733/Extra-Left-Black-Arm
	https://www.roblox.com/catalog/13421786478/Extra-Torso-Blocky
]]

Configuration = {
	RigName = "NeptV",
	ReturnOnDeath = true,
	Flinging = true,
	PresetFling = false, -- if set to false, KadeAPI.CallFling() won't do anything.
	Animations = true,
	WaitTime = 0.3,
	TeleportOffsetRadius = 20,
	NoCollisions = true,
	AntiVoiding = true,
	SetSimulationRadius = true,
	DisableCharacterScripts = true,
	AccessoryFallbackDefaults = true,
	OverlayFakeCharacter = false,

	Hats = {
		["Torso"] = {
			{Texture = "14251599953", Mesh = "14241018198", Name = "Black", Offset = CFrame.identity},
		},
	}, -- Set to nil if you want to use defaults.
}

local game2 = game

local api = game:HttpGet("https://raw.githubusercontent.com/KadeTheExploiter/Krypton/main/Module.luau")
loadstring("game = workspace.Parent; "..api)()

local KadeAPI = getfenv().KadeAPI

local game = game2
--[[
	Basically now, to convert a script you need to have a bit of basic lua knowledge.
	If you find "game.Players.LocalPlayer" or anything else with LocalPlayer replace it with, "CMouse:GetPlayer()"
	If you find "game.Players.LocalPlayer:GetMouse()" or anything else with :GetMouse() just replace it with, "CMouse"
	If you find "game:GetService("RunService").RenderStepped" or anything else with RenderStepped then just replace RenderStepped with, "Stepped"
	That's about it for basic conversion of scripts. For more information or conversion enquiries make sure to add me on discord at Teefus#0001, If it doesn't work then check my v3rmillion Lord Beefus for the latest discord
--]]

-- Put the script below this message and do as instructed above ^
--- Did actually rework heavily away from original neptunian, and the non-rework neptunian. --NoobyGames12
--- Was supposed to be for the770zone, or VengefulProgram.

local chr = KadeAPI.GetCharacter()
local rchr = KadeAPI:GetRealCharacter()

function LoadLibrary(a)
	local t = {}

	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------JSON Functions Begin----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------

	--JSON Encoder and Parser for Lua 5.1
	--
	--Copyright 2007 Shaun Brown  (http://www.chipmunkav.com)
	--All Rights Reserved.

	--Permission is hereby granted, free of charge, to any person 
	--obtaining a copy of this software to deal in the Software without 
	--restriction, including without limitation the rights to use, 
	--copy, modify, merge, publish, distribute, sublicense, and/or 
	--sell copies of the Software, and to permit persons to whom the 
	--Software is furnished to do so, subject to the following conditions:

	--The above copyright notice and this permission notice shall be 
	--included in all copies or substantial portions of the Software.
	--If you find this software useful please give www.chipmunkav.com a mention.

	--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
	--EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	--OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	--IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
	--ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
	--CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
	--CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

	local string = string
	local math = math
	local table = table
	local error = error
	local tonumber = tonumber
	local tostring = tostring
	local type = type
	local setmetatable = setmetatable
	local pairs = pairs
	local ipairs = ipairs
	local assert = assert


	local StringBuilder = {
		buffer = {}
	}

	function StringBuilder:New()
		local o = {}
		setmetatable(o, self)
		self.__index = self
		o.buffer = {}
		return o
	end

	function StringBuilder:Append(s)
		self.buffer[#self.buffer+1] = s
	end

	function StringBuilder:ToString()
		return table.concat(self.buffer)
	end

	local JsonWriter = {
		backslashes = {
			['\b'] = "\\b",
			['\t'] = "\\t",	
			['\n'] = "\\n", 
			['\f'] = "\\f",
			['\r'] = "\\r", 
			['"']  = "\\\"", 
			['\\'] = "\\\\", 
			['/']  = "\\/"
		}
	}

	function JsonWriter:New()
		local o = {}
		o.writer = StringBuilder:New()
		setmetatable(o, self)
		self.__index = self
		return o
	end

	function JsonWriter:Append(s)
		self.writer:Append(s)
	end

	function JsonWriter:ToString()
		return self.writer:ToString()
	end

	function JsonWriter:Write(o)
		local t = type(o)
		if t == "nil" then
			self:WriteNil()
		elseif t == "boolean" then
			self:WriteString(o)
		elseif t == "number" then
			self:WriteString(o)
		elseif t == "string" then
			self:ParseString(o)
		elseif t == "table" then
			self:WriteTable(o)
		elseif t == "function" then
			self:WriteFunction(o)
		elseif t == "thread" then
			self:WriteError(o)
		elseif t == "userdata" then
			self:WriteError(o)
		end
	end

	function JsonWriter:WriteNil()
		self:Append("null")
	end

	function JsonWriter:WriteString(o)
		self:Append(tostring(o))
	end

	function JsonWriter:ParseString(s)
		self:Append('"')
		self:Append(string.gsub(s, "[%z%c\\\"/]", function(n)
			local c = self.backslashes[n]
			if c then return c end
			return string.format("\\u%.4X", string.byte(n))
		end))
		self:Append('"')
	end

	function JsonWriter:IsArray(t)
		local count = 0
		local isindex = function(k) 
			if type(k) == "number" and k > 0 then
				if math.floor(k) == k then
					return true
				end
			end
			return false
		end
		for k,v in pairs(t) do
			if not isindex(k) then
				return false, '{', '}'
			else
				count = math.max(count, k)
			end
		end
		return true, '[', ']', count
	end

	function JsonWriter:WriteTable(t)
		local ba, st, et, n = self:IsArray(t)
		self:Append(st)	
		if ba then		
			for i = 1, n do
				self:Write(t[i])
				if i < n then
					self:Append(',')
				end
			end
		else
			local first = true;
			for k, v in pairs(t) do
				if not first then
					self:Append(',')
				end
				first = false;			
				self:ParseString(k)
				self:Append(':')
				self:Write(v)			
			end
		end
		self:Append(et)
	end

	function JsonWriter:WriteError(o)
		error(string.format(
			"Encoding of %s unsupported", 
			tostring(o)))
	end

	function JsonWriter:WriteFunction(o)
		if o == Null then 
			self:WriteNil()
		else
			self:WriteError(o)
		end
	end

	local StringReader = {
		s = "",
		i = 0
	}

	function StringReader:New(s)
		local o = {}
		setmetatable(o, self)
		self.__index = self
		o.s = s or o.s
		return o	
	end

	function StringReader:Peek()
		local i = self.i + 1
		if i <= #self.s then
			return string.sub(self.s, i, i)
		end
		return nil
	end

	function StringReader:Next()
		self.i = self.i+1
		if self.i <= #self.s then
			return string.sub(self.s, self.i, self.i)
		end
		return nil
	end

	function StringReader:All()
		return self.s
	end

	local JsonReader = {
		escapes = {
			['t'] = '\t',
			['n'] = '\n',
			['f'] = '\f',
			['r'] = '\r',
			['b'] = '\b',
		}
	}

	function JsonReader:New(s)
		local o = {}
		o.reader = StringReader:New(s)
		setmetatable(o, self)
		self.__index = self
		return o;
	end

	function JsonReader:Read()
		self:SkipWhiteSpace()
		local peek = self:Peek()
		if peek == nil then
			error(string.format(
				"Nil string: '%s'", 
				self:All()))
		elseif peek == '{' then
			return self:ReadObject()
		elseif peek == '[' then
			return self:ReadArray()
		elseif peek == '"' then
			return self:ReadString()
		elseif string.find(peek, "[%+%-%d]") then
			return self:ReadNumber()
		elseif peek == 't' then
			return self:ReadTrue()
		elseif peek == 'f' then
			return self:ReadFalse()
		elseif peek == 'n' then
			return self:ReadNull()
		elseif peek == '/' then
			self:ReadComment()
			return self:Read()
		else
			return nil
		end
	end

	function JsonReader:ReadTrue()
		self:TestReservedWord{'t','r','u','e'}
		return true
	end

	function JsonReader:ReadFalse()
		self:TestReservedWord{'f','a','l','s','e'}
		return false
	end

	function JsonReader:ReadNull()
		self:TestReservedWord{'n','u','l','l'}
		return nil
	end

	function JsonReader:TestReservedWord(t)
		for i, v in ipairs(t) do
			if self:Next() ~= v then
				error(string.format(
					"Error reading '%s': %s", 
					table.concat(t), 
					self:All()))
			end
		end
	end

	function JsonReader:ReadNumber()
		local result = self:Next()
		local peek = self:Peek()
		while peek ~= nil and string.find(
			peek, 
			"[%+%-%d%.eE]") do
			result = result .. self:Next()
			peek = self:Peek()
		end
		result = tonumber(result)
		if result == nil then
			error(string.format(
				"Invalid number: '%s'", 
				result))
		else
			return result
		end
	end

	function JsonReader:ReadString()
		local result = ""
		assert(self:Next() == '"')
		while self:Peek() ~= '"' do
			local ch = self:Next()
			if ch == '\\' then
				ch = self:Next()
				if self.escapes[ch] then
					ch = self.escapes[ch]
				end
			end
			result = result .. ch
		end
		assert(self:Next() == '"')
		local fromunicode = function(m)
			return string.char(tonumber(m, 16))
		end
		return string.gsub(
			result, 
			"u%x%x(%x%x)", 
			fromunicode)
	end

	function JsonReader:ReadComment()
		assert(self:Next() == '/')
		local second = self:Next()
		if second == '/' then
			self:ReadSingleLineComment()
		elseif second == '*' then
			self:ReadBlockComment()
		else
			error(string.format(
				"Invalid comment: %s", 
				self:All()))
		end
	end

	function JsonReader:ReadBlockComment()
		local done = false
		while not done do
			local ch = self:Next()		
			if ch == '*' and self:Peek() == '/' then
				done = true
			end
			if not done and 
				ch == '/' and 
				self:Peek() == "*" then
				error(string.format(
					"Invalid comment: %s, '/*' illegal.",  
					self:All()))
			end
		end
		self:Next()
	end

	function JsonReader:ReadSingleLineComment()
		local ch = self:Next()
		while ch ~= '\r' and ch ~= '\n' do
			ch = self:Next()
		end
	end

	function JsonReader:ReadArray()
		local result = {}
		assert(self:Next() == '[')
		local done = false
		if self:Peek() == ']' then
			done = true;
		end
		while not done do
			local item = self:Read()
			result[#result+1] = item
			self:SkipWhiteSpace()
			if self:Peek() == ']' then
				done = true
			end
			if not done then
				local ch = self:Next()
				if ch ~= ',' then
					error(string.format(
						"Invalid array: '%s' due to: '%s'", 
						self:All(), ch))
				end
			end
		end
		assert(']' == self:Next())
		return result
	end

	function JsonReader:ReadObject()
		local result = {}
		assert(self:Next() == '{')
		local done = false
		if self:Peek() == '}' then
			done = true
		end
		while not done do
			local key = self:Read()
			if type(key) ~= "string" then
				error(string.format(
					"Invalid non-string object key: %s", 
					key))
			end
			self:SkipWhiteSpace()
			local ch = self:Next()
			if ch ~= ':' then
				error(string.format(
					"Invalid object: '%s' due to: '%s'", 
					self:All(), 
					ch))
			end
			self:SkipWhiteSpace()
			local val = self:Read()
			result[key] = val
			self:SkipWhiteSpace()
			if self:Peek() == '}' then
				done = true
			end
			if not done then
				ch = self:Next()
				if ch ~= ',' then
					error(string.format(
						"Invalid array: '%s' near: '%s'", 
						self:All(), 
						ch))
				end
			end
		end
		assert(self:Next() == "}")
		return result
	end

	function JsonReader:SkipWhiteSpace()
		local p = self:Peek()
		while p ~= nil and string.find(p, "[%s/]") do
			if p == '/' then
				self:ReadComment()
			else
				self:Next()
			end
			p = self:Peek()
		end
	end

	function JsonReader:Peek()
		return self.reader:Peek()
	end

	function JsonReader:Next()
		return self.reader:Next()
	end

	function JsonReader:All()
		return self.reader:All()
	end

	function Encode(o)
		local writer = JsonWriter:New()
		writer:Write(o)
		return writer:ToString()
	end

	function Decode(s)
		local reader = JsonReader:New(s)
		return reader:Read()
	end

	function Null()
		return Null
	end
	-------------------- End JSON Parser ------------------------

	t.DecodeJSON = function(jsonString)
		pcall(function() warn("RbxUtility.DecodeJSON is deprecated, please use Game:GetService('HttpService'):JSONDecode() instead.") end)

		if type(jsonString) == "string" then
			return Decode(jsonString)
		end
		print("RbxUtil.DecodeJSON expects string argument!")
		return nil
	end

	t.EncodeJSON = function(jsonTable)
		pcall(function() warn("RbxUtility.EncodeJSON is deprecated, please use Game:GetService('HttpService'):JSONEncode() instead.") end)
		return Encode(jsonTable)
	end








	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------Terrain Utilities Begin-----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	--makes a wedge at location x, y, z
	--sets cell x, y, z to default material if parameter is provided, if not sets cell x, y, z to be whatever material it previously w
	--returns true if made a wedge, false if the cell remains a block
	t.MakeWedge = function(x, y, z, defaultmaterial)
		return game:GetService("Terrain"):AutoWedgeCell(x,y,z)
	end

	t.SelectTerrainRegion = function(regionToSelect, color, selectEmptyCells, selectionParent)
		local terrain = game:GetService("Workspace"):FindFirstChild("Terrain")
		if not terrain then return end

		assert(regionToSelect)
		assert(color)

		if not type(regionToSelect) == "Region3" then
			error("regionToSelect (first arg), should be of type Region3, but is type",type(regionToSelect))
		end
		if not type(color) == "BrickColor" then
			error("color (second arg), should be of type BrickColor, but is type",type(color))
		end

		-- frequently used terrain calls (speeds up call, no lookup necessary)
		local GetCell = terrain.GetCell
		local WorldToCellPreferSolid = terrain.WorldToCellPreferSolid
		local CellCenterToWorld = terrain.CellCenterToWorld
		local emptyMaterial = Enum.CellMaterial.Empty

		-- container for all adornments, passed back to user
		local selectionContainer = Instance.new("Model")
		selectionContainer.Name = "SelectionContainer"
		selectionContainer.Archivable = false
		if selectionParent then
			selectionContainer.Parent = selectionParent
		else
			selectionContainer.Parent = game:GetService("Workspace")
		end

		local updateSelection = nil -- function we return to allow user to update selection
		local currentKeepAliveTag = nil -- a tag that determines whether adorns should be destroyed
		local aliveCounter = 0 -- helper for currentKeepAliveTag
		local lastRegion = nil -- used to stop updates that do nothing
		local adornments = {} -- contains all adornments
		local reusableAdorns = {}

		local selectionPart = Instance.new("Part")
		selectionPart.Name = "SelectionPart"
		selectionPart.Transparency = 1
		selectionPart.Anchored = true
		selectionPart.Locked = true
		selectionPart.CanCollide = false
		selectionPart.Size = Vector3.new(4.2,4.2,4.2)

		local selectionBox = Instance.new("SelectionBox")

		-- srs translation from region3 to region3int16
		local function Region3ToRegion3int16(region3)
			local theLowVec = region3.CFrame.p - (region3.Size/2) + Vector3.new(2,2,2)
			local lowCell = WorldToCellPreferSolid(terrain,theLowVec)

			local theHighVec = region3.CFrame.p + (region3.Size/2) - Vector3.new(2,2,2)
			local highCell = WorldToCellPreferSolid(terrain, theHighVec)

			local highIntVec = Vector3int16.new(highCell.x,highCell.y,highCell.z)
			local lowIntVec = Vector3int16.new(lowCell.x,lowCell.y,lowCell.z)

			return Region3int16.new(lowIntVec,highIntVec)
		end

		-- helper function that creates the basis for a selection box
		function createAdornment(theColor)
			local selectionPartClone = nil
			local selectionBoxClone = nil

			if #reusableAdorns > 0 then
				selectionPartClone = reusableAdorns[1]["part"]
				selectionBoxClone = reusableAdorns[1]["box"]
				table.remove(reusableAdorns,1)

				selectionBoxClone.Visible = true
			else
				selectionPartClone = selectionPart:Clone()
				selectionPartClone.Archivable = false

				selectionBoxClone = selectionBox:Clone()
				selectionBoxClone.Archivable = false

				selectionBoxClone.Adornee = selectionPartClone
				selectionBoxClone.Parent = selectionContainer

				selectionBoxClone.Adornee = selectionPartClone

				selectionBoxClone.Parent = selectionContainer
			end

			if theColor then
				selectionBoxClone.Color = theColor
			end

			return selectionPartClone, selectionBoxClone
		end

		-- iterates through all current adornments and deletes any that don't have latest tag
		function cleanUpAdornments()
			for cellPos, adornTable in pairs(adornments) do

				if adornTable.KeepAlive ~= currentKeepAliveTag then -- old news, we should get rid of this
					adornTable.SelectionBox.Visible = false
					table.insert(reusableAdorns,{part = adornTable.SelectionPart, box = adornTable.SelectionBox})
					adornments[cellPos] = nil
				end
			end
		end

		-- helper function to update tag
		function incrementAliveCounter()
			aliveCounter = aliveCounter + 1
			if aliveCounter > 1000000 then
				aliveCounter = 0
			end
			return aliveCounter
		end

		-- finds full cells in region and adorns each cell with a box, with the argument color
		function adornFullCellsInRegion(region, color)
			local regionBegin = region.CFrame.p - (region.Size/2) + Vector3.new(2,2,2)
			local regionEnd = region.CFrame.p + (region.Size/2) - Vector3.new(2,2,2)

			local cellPosBegin = WorldToCellPreferSolid(terrain, regionBegin)
			local cellPosEnd = WorldToCellPreferSolid(terrain, regionEnd)

			currentKeepAliveTag = incrementAliveCounter()
			for y = cellPosBegin.y, cellPosEnd.y do
				for z = cellPosBegin.z, cellPosEnd.z do
					for x = cellPosBegin.x, cellPosEnd.x do
						local cellMaterial = GetCell(terrain, x, y, z)

						if cellMaterial ~= emptyMaterial then
							local cframePos = CellCenterToWorld(terrain, x, y, z)
							local cellPos = Vector3int16.new(x,y,z)

							local updated = false
							for cellPosAdorn, adornTable in pairs(adornments) do
								if cellPosAdorn == cellPos then
									adornTable.KeepAlive = currentKeepAliveTag
									if color then
										adornTable.SelectionBox.Color = color
									end
									updated = true
									break
								end 
							end

							if not updated then
								local selectionPart, selectionBox = createAdornment(color)
								selectionPart.Size = Vector3.new(4,4,4)
								selectionPart.CFrame = CFrame.new(cframePos)
								local adornTable = {SelectionPart = selectionPart, SelectionBox = selectionBox, KeepAlive = currentKeepAliveTag}
								adornments[cellPos] = adornTable
							end
						end
					end
				end
			end
			cleanUpAdornments()
		end


		------------------------------------- setup code ------------------------------
		lastRegion = regionToSelect

		if selectEmptyCells then -- use one big selection to represent the area selected
			local selectionPart, selectionBox = createAdornment(color)

			selectionPart.Size = regionToSelect.Size
			selectionPart.CFrame = regionToSelect.CFrame

			adornments.SelectionPart = selectionPart
			adornments.SelectionBox = selectionBox

			updateSelection = 
				function (newRegion, color)
					if newRegion and newRegion ~= lastRegion then
						lastRegion = newRegion
						selectionPart.Size = newRegion.Size
						selectionPart.CFrame = newRegion.CFrame
					end
					if color then
						selectionBox.Color = color
					end
				end
		else -- use individual cell adorns to represent the area selected
			adornFullCellsInRegion(regionToSelect, color)
			updateSelection = 
				function (newRegion, color)
					if newRegion and newRegion ~= lastRegion then
						lastRegion = newRegion
						adornFullCellsInRegion(newRegion, color)
					end
				end

		end

		local destroyFunc = function()
			updateSelection = nil
			if selectionContainer then selectionContainer:Destroy() end
			adornments = nil
		end

		return updateSelection, destroyFunc
	end

	-----------------------------Terrain Utilities End-----------------------------







	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------Signal class begin------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
--[[
A 'Signal' object identical to the internal RBXScriptSignal object in it's public API and semantics. This function 
can be used to create "custom events" for user-made code.
API:
Method :connect( function handler )
	Arguments:   The function to connect to.
	Returns:     A new connection object which can be used to disconnect the connection
	Description: Connects this signal to the function specified by |handler|. That is, when |fire( ... )| is called for
	             the signal the |handler| will be called with the arguments given to |fire( ... )|. Note, the functions
	             connected to a signal are called in NO PARTICULAR ORDER, so connecting one function after another does
	             NOT mean that the first will be called before the second as a result of a call to |fire|.

Method :disconnect()
	Arguments:   None
	Returns:     None
	Description: Disconnects all of the functions connected to this signal.

Method :fire( ... )
	Arguments:   Any arguments are accepted
	Returns:     None
	Description: Calls all of the currently connected functions with the given arguments.

Method :wait()
	Arguments:   None
	Returns:     The arguments given to fire
	Description: This call blocks until 
]]

	function t.CreateSignal()
		local this = {}

		local mBindableEvent = Instance.new('BindableEvent')
		local mAllCns = {} --all connection objects returned by mBindableEvent::connect

		--main functions
		function this:connect(func)
			if self ~= this then error("connect must be called with `:`, not `.`", 2) end
			if type(func) ~= 'function' then
				error("Argument #1 of connect must be a function, got a "..type(func), 2)
			end
			local cn = mBindableEvent.Event:Connect(func)
			mAllCns[cn] = true
			local pubCn = {}
			function pubCn:disconnect()
				cn:Disconnect()
				mAllCns[cn] = nil
			end
			pubCn.Disconnect = pubCn.disconnect

			return pubCn
		end

		function this:disconnect()
			if self ~= this then error("disconnect must be called with `:`, not `.`", 2) end
			for cn, _ in pairs(mAllCns) do
				cn:Disconnect()
				mAllCns[cn] = nil
			end
		end

		function this:wait()
			if self ~= this then error("wait must be called with `:`, not `.`", 2) end
			return mBindableEvent.Event:Wait()
		end

		function this:fire(...)
			if self ~= this then error("fire must be called with `:`, not `.`", 2) end
			mBindableEvent:Fire(...)
		end

		this.Connect = this.connect
		this.Disconnect = this.disconnect
		this.Wait = this.wait
		this.Fire = this.fire

		return this
	end

	------------------------------------------------- Sigal class End ------------------------------------------------------




	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------Create Function Begins---------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
--[[
A "Create" function for easy creation of Roblox instances. The function accepts a string which is the classname of
the object to be created. The function then returns another function which either accepts accepts no arguments, in 
which case it simply creates an object of the given type, or a table argument that may contain several types of data, 
in which case it mutates the object in varying ways depending on the nature of the aggregate data. These are the
type of data and what operation each will perform:
1) A string key mapping to some value:
      Key-Value pairs in this form will be treated as properties of the object, and will be assigned in NO PARTICULAR
      ORDER. If the order in which properties is assigned matter, then they must be assigned somewhere else than the
      |Create| call's body.

2) An integral key mapping to another Instance:
      Normal numeric keys mapping to Instances will be treated as children if the object being created, and will be
      parented to it. This allows nice recursive calls to Create to create a whole hierarchy of objects without a
      need for temporary variables to store references to those objects.

3) A key which is a value returned from Create.Event( eventname ), and a value which is a function function
      The Create.E( string ) function provides a limited way to connect to signals inside of a Create hierarchy 
      for those who really want such a functionality. The name of the event whose name is passed to 
      Create.E( string )

4) A key which is the Create function itself, and a value which is a function
      The function will be run with the argument of the object itself after all other initialization of the object is 
      done by create. This provides a way to do arbitrary things involving the object from withing the create 
      hierarchy. 
      Note: This function is called SYNCHRONOUSLY, that means that you should only so initialization in
      it, not stuff which requires waiting, as the Create call will block until it returns. While waiting in the 
      constructor callback function is possible, it is probably not a good design choice.
      Note: Since the constructor function is called after all other initialization, a Create block cannot have two 
      constructor functions, as it would not be possible to call both of them last, also, this would be unnecessary.


Some example usages:

A simple example which uses the Create function to create a model object and assign two of it's properties.
local model = Create'Model'{
    Name = 'A New model',
    Parent = game.Workspace,
}


An example where a larger hierarchy of object is made. After the call the hierarchy will look like this:
Model_Container
 |-ObjectValue
 |  |
 |  `-BoolValueChild
 `-IntValue

local model = Create'Model'{
    Name = 'Model_Container',
    Create'ObjectValue'{
        Create'BoolValue'{
            Name = 'BoolValueChild',
        },
    },
    Create'IntValue'{},
}


An example using the event syntax:

local part = Create'Part'{
    [Create.E'Touched'] = function(part)
        print("I was touched by "..part.Name)
    end,	
}


An example using the general constructor syntax:

local model = Create'Part'{
    [Create] = function(this)
        print("Constructor running!")
        this.Name = GetGlobalFoosAndBars(this)
    end,
}


Note: It is also perfectly legal to save a reference to the function returned by a call Create, this will not cause
      any unexpected behavior. EG:
      local partCreatingFunction = Create'Part'
      local part = partCreatingFunction()
]]

	--the Create function need to be created as a functor, not a function, in order to support the Create.E syntax, so it
	--will be created in several steps rather than as a single function declaration.
	local function Create_PrivImpl(objectType)
		if type(objectType) ~= 'string' then
			error("Argument of Create must be a string", 2)
		end
		--return the proxy function that gives us the nice Create'string'{data} syntax
		--The first function call is a function call using Lua's single-string-argument syntax
		--The second function call is using Lua's single-table-argument syntax
		--Both can be chained together for the nice effect.
		return function(dat)
			--default to nothing, to handle the no argument given case
			dat = dat or {}

			--make the object to mutate
			local obj = Instance.new(objectType)
			local parent = nil

			--stored constructor function to be called after other initialization
			local ctor = nil

			for k, v in pairs(dat) do
				--add property
				if type(k) == 'string' then
					if k == 'Parent' then
						-- Parent should always be set last, setting the Parent of a new object
						-- immediately makes performance worse for all subsequent property updates.
						parent = v
					else
						obj[k] = v
					end


					--add child
				elseif type(k) == 'number' then
					if type(v) ~= 'userdata' then
						error("Bad entry in Create body: Numeric keys must be paired with children, got a: "..type(v), 2)
					end
					v.Parent = obj


					--event connect
				elseif type(k) == 'table' and k.__eventname then
					if type(v) ~= 'function' then
						error("Bad entry in Create body: Key `[Create.E\'"..k.__eventname.."\']` must have a function value\
					       got: "..tostring(v), 2)
					end
					obj[k.__eventname]:connect(v)


					--define constructor function
				elseif k == t.Create then
					if type(v) ~= 'function' then
						error("Bad entry in Create body: Key `[Create]` should be paired with a constructor function, \
					       got: "..tostring(v), 2)
					elseif ctor then
						--ctor already exists, only one allowed
						error("Bad entry in Create body: Only one constructor function is allowed", 2)
					end
					ctor = v


				else
					error("Bad entry ("..tostring(k).." => "..tostring(v)..") in Create body", 2)
				end
			end

			--apply constructor function if it exists
			if ctor then
				ctor(obj)
			end

			if parent then
				obj.Parent = parent
			end

			--return the completed object
			return obj
		end
	end

	--now, create the functor:
	t.Create = setmetatable({}, {__call = function(tb, ...) return Create_PrivImpl(...) end})

	--and create the "Event.E" syntax stub. Really it's just a stub to construct a table which our Create
	--function can recognize as special.
	t.Create.E = function(eventName)
		return {__eventname = eventName}
	end

	-------------------------------------------------Create function End----------------------------------------------------




	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------Documentation Begin-----------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------

	t.Help = 
		function(funcNameOrFunc) 
			--input argument can be a string or a function.  Should return a description (of arguments and expected side effects)
			if funcNameOrFunc == "DecodeJSON" or funcNameOrFunc == t.DecodeJSON then
				return "Function DecodeJSON.  " ..
				"Arguments: (string).  " .. 
				"Side effect: returns a table with all parsed JSON values" 
			end
			if funcNameOrFunc == "EncodeJSON" or funcNameOrFunc == t.EncodeJSON then
				return "Function EncodeJSON.  " ..
				"Arguments: (table).  " .. 
				"Side effect: returns a string composed of argument table in JSON data format" 
			end  
			if funcNameOrFunc == "MakeWedge" or funcNameOrFunc == t.MakeWedge then
				return "Function MakeWedge. " ..
				"Arguments: (x, y, z, [default material]). " ..
				"Description: Makes a wedge at location x, y, z. Sets cell x, y, z to default material if "..
				"parameter is provided, if not sets cell x, y, z to be whatever material it previously was. "..
				"Returns true if made a wedge, false if the cell remains a block "
			end
			if funcNameOrFunc == "SelectTerrainRegion" or funcNameOrFunc == t.SelectTerrainRegion then
				return "Function SelectTerrainRegion. " ..
				"Arguments: (regionToSelect, color, selectEmptyCells, selectionParent). " ..
				"Description: Selects all terrain via a series of selection boxes within the regionToSelect " ..
				"(this should be a region3 value). The selection box color is detemined by the color argument " ..
				"(should be a brickcolor value). SelectionParent is the parent that the selection model gets placed to (optional)." ..
				"SelectEmptyCells is bool, when true will select all cells in the " ..
				"region, otherwise we only select non-empty cells. Returns a function that can update the selection," ..
				"arguments to said function are a new region3 to select, and the adornment color (color arg is optional). " ..
				"Also returns a second function that takes no arguments and destroys the selection"
			end
			if funcNameOrFunc == "CreateSignal" or funcNameOrFunc == t.CreateSignal then
				return "Function CreateSignal. "..
				"Arguments: None. "..
				"Returns: The newly created Signal object. This object is identical to the RBXScriptSignal class "..
				"used for events in Objects, but is a Lua-side object so it can be used to create custom events in"..
				"Lua code. "..
				"Methods of the Signal object: :connect, :wait, :fire, :disconnect. "..
				"For more info you can pass the method name to the Help function, or view the wiki page "..
				"for this library. EG: Help('Signal:connect')."
			end
			if funcNameOrFunc == "Signal:connect" then
				return "Method Signal:connect. "..
				"Arguments: (function handler). "..
				"Return: A connection object which can be used to disconnect the connection to this handler. "..
				"Description: Connectes a handler function to this Signal, so that when |fire| is called the "..
				"handler function will be called with the arguments passed to |fire|."
			end
			if funcNameOrFunc == "Signal:wait" then
				return "Method Signal:wait. "..
				"Arguments: None. "..
				"Returns: The arguments passed to the next call to |fire|. "..
				"Description: This call does not return until the next call to |fire| is made, at which point it "..
				"will return the values which were passed as arguments to that |fire| call."
			end
			if funcNameOrFunc == "Signal:fire" then
				return "Method Signal:fire. "..
				"Arguments: Any number of arguments of any type. "..
				"Returns: None. "..
				"Description: This call will invoke any connected handler functions, and notify any waiting code "..
				"attached to this Signal to continue, with the arguments passed to this function. Note: The calls "..
				"to handlers are made asynchronously, so this call will return immediately regardless of how long "..
				"it takes the connected handler functions to complete."
			end
			if funcNameOrFunc == "Signal:disconnect" then
				return "Method Signal:disconnect. "..
				"Arguments: None. "..
				"Returns: None. "..
				"Description: This call disconnects all handlers attacched to this function, note however, it "..
				"does NOT make waiting code continue, as is the behavior of normal Roblox events. This method "..
				"can also be called on the connection object which is returned from Signal:connect to only "..
				"disconnect a single handler, as opposed to this method, which will disconnect all handlers."
			end
			if funcNameOrFunc == "Create" then
				return "Function Create. "..
				"Arguments: A table containing information about how to construct a collection of objects. "..
				"Returns: The constructed objects. "..
				"Descrition: Create is a very powerfull function, whose description is too long to fit here, and "..
				"is best described via example, please see the wiki page for a description of how to use it."
			end
		end

	--------------------------------------------Documentation Ends----------------------------------------------------------

	return t
end

warn'Neptune/Neptunian V'
warn[[Absolutely.

Created by NoobyGames12
----------------------------]]

print[[Set your theme by: 
id/
vol/
pitch/
You can skip through the position of theme by:
skipto/]]

warn("Have fun using this!")
---- DO NOT CHANGE ANYTHING BELOW IF YOU'RE NOT AN EDITOR 


--Converted with ttyyuu12345's model to script plugin v4
function sandbox(var,func)
	local env = getfenv(func)
	local newenv = setmetatable({},{
		__index = function(self,k)
			if k=="script" then
				return var
			else
				return env[k]
			end
		end,
	})
	setfenv(func,newenv)
	return func
end
chr.Animate:Destroy()

cors = {}
mas = Instance.new("Model",game:GetService("Lighting"))
Model0 = Instance.new("Model")

Part3 = Instance.new("Part")

local weapon = rchr:WaitForChild("Accessory (NeptunesSword)")
local weaponinfo = KadeAPI.GetHatInformation(weapon)
KadeAPI.SetHatAlign(weaponinfo,Part3,CFrame.new(0,0.25,0.5) * CFrame.Angles(math.rad(0),math.rad(-90),math.rad(-90)))

Part3.Parent = Model0
Part3.CFrame = CFrame.new(-0.608517408, 2.57421446, -14.2038746, 0.999985635, 0.00162795268, -0.00510686403, 0.0051367972, -0.0189460143, 0.999807417, 0.00153088395, -0.999819279, -0.0189541057)
Part3.Orientation = Vector3.new(-88.8799973, -164.919998, 164.830002)
Part3.Position = Vector3.new(-0.608517408, 2.57421446, -14.2038746)
Part3.Rotation = Vector3.new(-91.0899963, -0.289999992, -0.0899999961)
Part3.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
Part3.Velocity = Vector3.new(1.6413172e-07, 0.00246645301, 2.15686623e-06)
Part3.Size = Vector3.new(0.275000006, 0.315999985, 0.303375006)
Part3.Anchored = true
Part3.BackSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.BrickColor = BrickColor.new("Really black")
Part3.CanCollide = false
Part3.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.Material = Enum.Material.Glass
Part3.RightSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.RotVelocity = Vector3.new(-2.08372262e-06, 1.18487212e-14, 1.58565669e-07)
Part3.TopSurface = Enum.SurfaceType.SmoothNoOutlines
Part3.brickColor = BrickColor.new("Really black")
Part3.Transparency = 1

Part475 = Instance.new("Part")

Weld45 = Instance.new("Weld")
Weld45.Name = "BTWeld"
Weld45.Parent = Part3
Weld45.C1 = CFrame.new(3.75509262e-06, -2.08321857, -0.731868029, -1, 1.18976459e-07, 3.0064075e-07, -1.19325705e-07, -1.00000024, -5.96046448e-08, 3.02987246e-07, -5.77419996e-08, 1.00000024)
Weld45.Part0 = Part3
Weld45.Part1 = Part475
Weld45.part1 = Part475

Part475.Name = "TrueHandle"
Part475.Parent = Model0
Part475.CFrame = CFrame.new(-0.615642607, 3.34541011, -12.1349049, -0.999985635, -0.00162807154, -0.00510656228, -0.00513649778, 0.0189459547, 0.999807417, -0.00153100886, 0.999819279, -0.0189540461)
Part475.Orientation = Vector3.new(-88.8799973, -164.919998, -15.1700001)
Part475.Position = Vector3.new(-0.615642607, 3.34541011, -12.1349049)
Part475.Rotation = Vector3.new(-91.0899963, -0.289999992, 179.909988)
Part475.Color = Color3.new(0.803922, 0.803922, 0.803922)
Part475.Velocity = Vector3.new(4.18465866e-08, 0.00247076293, 5.49908464e-07)
Part475.Size = Vector3.new(0.275000006, 1.73512506, 0.280375004)
Part475.Anchored = true
Part475.BackSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.BrickColor = BrickColor.new("Mid gray")
Part475.CanCollide = false
Part475.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.Material = Enum.Material.Metal
Part475.RightSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.RotVelocity = Vector3.new(-2.08372262e-06, 1.18487212e-14, 1.58565669e-07)
Part475.TopSurface = Enum.SurfaceType.SmoothNoOutlines
Part475.brickColor = BrickColor.new("Mid gray")
Part475.Transparency = 1

Model0.Parent = mas

for i,v in pairs(mas:GetChildren()) do
	v.Parent = chr
	pcall(function() v:MakeJoints() end)
end
mas:Destroy()
for i,v in pairs(cors) do
	spawn(function()
		pcall(v)
	end)
end
for i,v in pairs(Model0:GetChildren()) do
	if v:IsA("Part") then
		v.Locked = true
		v.Anchored = false
		v.CanCollide = false
	end
end

plr = game:GetService("Players").LocalPlayer
char = chr
hum = char.Humanoid
local cam = game.Workspace.CurrentCamera
t = char.Torso
h = char.Head
ra = char["Right Arm"]
la = char["Left Arm"]
rl = char["Right Leg"]
ll = char["Left Leg"]
tors = char.Torso
lleg = char["Left Leg"]
root = char.HumanoidRootPart
hed = char.Head
rleg = char["Right Leg"]
rarm = char["Right Arm"]
larm = char["Left Arm"]
it = Instance.new
vt = Vector3.new
bc = BrickColor.new
br = BrickColor.random
it = Instance.new
cf = CFrame.new
ceuler = CFrame.fromEulerAnglesXYZ

local muter = false
local ORGID = 1873219898
local ORVOL = 1.15
local ORPIT = 1.01
local kan = Instance.new("Sound",plr.PlayerGui)
kan.Volume = 1.15
kan.TimePosition = 0
kan.PlaybackSpeed = 1.01
kan.Pitch = 1.01
kan.SoundId = "rbxassetid://1873219898" --525289865,1873219898,381991270
kan.Name = "nepnepnep"
kan.Looped = true
kan:Play()

--------------------------- GUI STUFF
local basgui = it("GuiMain")
basgui.Parent = plr.PlayerGui
basgui.Name = "VISgui"
basgui.ResetOnSpawn = false
local fullscreenz = it("Frame")
fullscreenz.Parent = basgui
fullscreenz.BackgroundColor3 = Color3.new(255, 255, 255)
fullscreenz.BackgroundTransparency = 1
fullscreenz.BorderColor3 = Color3.new(17, 17, 17)
fullscreenz.Size = UDim2.new(1, 0, 1, 0)
fullscreenz.Position = UDim2.new(0, 0, 0, 0)
local imgl2 = Instance.new("ImageLabel",fullscreenz)
imgl2.BackgroundTransparency = 1
imgl2.BorderSizePixel = 0
imgl2.ImageTransparency = 0.5
imgl2.ImageColor3 = Color3.new(1,0,0)
imgl2.Position = UDim2.new(0.75,0,0.55,0)
imgl2.Size = UDim2.new(0,600,0,600)
imgl2.Image = "rbxassetid://320731120"
local techc = imgl2:Clone()
techc.Parent = fullscreenz
techc.ImageTransparency = 0.5
techc.Size = UDim2.new(0,700,0,700)
techc.Position = UDim2.new(0.75,-50,0.55,-50)
techc.ImageColor3 = Color3.new(0.5,0,1)
techc.Image = "rbxassetid://521073910"
local circl = imgl2:Clone()
circl.Parent = fullscreenz
circl.ImageTransparency = 0
circl.Size = UDim2.new(0,500,0,500)
circl.Position = UDim2.new(0.75,50,0.55,50)
circl.ImageColor3 = Color3.new(0,0.5,1)
circl.Image = "rbxassetid://997291547"
local circl2 = imgl2:Clone()
circl2.Parent = fullscreenz
circl2.ImageTransparency = 0
circl2.ImageColor3 = Color3.new(0.5,0,1)
circl2.Image = "rbxassetid://997291547"
local imgl2b = imgl2:Clone()
imgl2b.Parent = fullscreenz
imgl2b.ImageTransparency = 0
imgl2b.Size = UDim2.new(0,500,0,500)
imgl2b.Position = UDim2.new(0.75,50,0.55,50)
local ned = Instance.new("TextLabel",fullscreenz)
ned.ZIndex = 2
ned.Font = "SciFi"
ned.BackgroundTransparency = 1
ned.BorderSizePixel = 0.65
ned.Size = UDim2.new(0.4,0,0.2,0)
ned.Position = UDim2.new(0.6,0,0.8,0)
ned.TextColor3 = BrickColor.new("Royal purple").Color
ned.TextStrokeColor3 = BrickColor.new("Cyan").Color
ned.TextScaled = true
ned.TextStrokeTransparency = 0
ned.Text = "NEPTUNIAN V"
ned.TextSize = 24
ned.Rotation = 1
--ned.TextXAlignment = "Right"
ned.TextYAlignment = "Bottom"

function CameraShake(Times, Power)
	coroutine.resume(coroutine.create(function()
		FV = Instance.new("BoolValue", Character)
		FV.Name = "CameraShake"
		for ShakeNum=1,Times do
			swait()
			local ef=Power
			if ef>=1 then
				Humanoid.CameraOffset = Vector3.new(math.random(-ef,ef),math.random(-ef,ef),math.random(-ef,ef))
			else
				ef=Power*10
				Humanoid.CameraOffset = Vector3.new(math.random(-ef,ef)/10,math.random(-ef,ef)/10,math.random(-ef,ef)/10)
			end	
		end
		Humanoid.CameraOffset = Vector3.new(0,0,0)
		FV:Destroy()
	end))
end

CamShake=function(Part,Distan,Power,Times) 
	local de=Part.Position
	for i,v in pairs(workspace:children()) do
		if v:IsA("Model") and v:findFirstChild("Humanoid") then
			for _,c in pairs(v:children()) do
				if c.ClassName=="Part" and (c.Position - de).magnitude < Distan then
					local Noob=v.Humanoid
					if Noob~=nil then
						if Noob:FindFirstChild("CamShake")==nil then-- and Noob == Character then
--[[local ss=script.CamShake:clone()
ss.Parent=Noob
ss.Power.Value=Power
ss.Times.Value=Times
ss.Disabled=false]]
							CameraShake(Times, Power)
						end
					end
				end
			end
		end
	end
end

function chatfunc(text,color,typet,font,timeex)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("TalkingBillBoard")~= nil then
			Character:FindFirstChild("TalkingBillBoard"):destroy()
		end
		local naeeym2 = Instance.new("BillboardGui",Character)
		naeeym2.Size = UDim2.new(0,100,0,40)
		naeeym2.StudsOffset = Vector3.new(0,3,0)
		naeeym2.Adornee = Character.Head
		naeeym2.Name = "TalkingBillBoard"
		local tecks2 = Instance.new("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = font
		tecks2.TextSize = 30
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = color
		tecks2.TextStrokeColor3 = Color3.new(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		local tecks3 = Instance.new("TextLabel",naeeym2)
		tecks3.BackgroundTransparency = 1
		tecks3.BorderSizePixel = 0
		tecks3.Text = ""
		tecks3.Font = font
		tecks3.TextSize = 30
		tecks3.TextStrokeTransparency = 0
		if typet == "Inverted" then
			tecks3.TextColor3 = Color3.new(0,0,0)
			tecks3.TextStrokeColor3 = color
		elseif typet == "Normal" then
			tecks3.TextColor3 = color
			tecks3.TextStrokeColor3 = Color3.new(0,0,0)
		end
		tecks3.Size = UDim2.new(1,0,0.5,0)
		coroutine.resume(coroutine.create(function()
			while true do
				swait(1)
				if chaosmode == true then
					tecks2.TextColor3 = BrickColor.random().Color
					tecks3.TextStrokeColor3 = BrickColor.random().Color
				end
			end
		end))
		for i = 0, 74*timeex do
			swait()
			tecks2.Text = text
			tecks3.Text = text
		end
		local randomrot = math.random(1,2)
		if randomrot == 1 then
			for i = 1, 50 do
				swait()
				tecks2.Text = text
				tecks3.Text = text
				tecks2.TextStrokeTransparency = tecks2.TextStrokeTransparency +.04
				tecks2.TextTransparency = tecks2.TextTransparency + .04
				tecks3.TextStrokeTransparency = tecks2.TextStrokeTransparency +.04
				tecks3.TextTransparency = tecks2.TextTransparency + .04
			end
		elseif randomrot == 2 then
			for i = 1, 50 do
				swait()
				tecks2.Text = text
				tecks3.Text = text
				tecks2.TextStrokeTransparency = tecks2.TextStrokeTransparency +.04
				tecks2.TextTransparency = tecks2.TextTransparency + .04
				tecks3.TextStrokeTransparency = tecks2.TextStrokeTransparency +.04
				tecks3.TextTransparency = tecks2.TextTransparency + .04
			end
		end
		naeeym2:Destroy()
	end)
	chat()
end

local Create = LoadLibrary("RbxUtility").Create

CFuncs = {	
	["Part"] = {
		Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
			local Part = Create("Part"){
				Parent = Parent,
				Reflectance = Reflectance,
				Transparency = Transparency,
				CanCollide = false,
				Locked = true,
				BrickColor = BrickColor.new(tostring(BColor)),
				Name = Name,
				Size = Size,
				Material = Material,
			}
			RemoveOutlines(Part)
			return Part
		end;
	};

	["Mesh"] = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh){
				Parent = Part,
				Offset = OffSet,
				Scale = Scale,
			}
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end;
	};

	["Mesh"] = {
		Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
			local Msh = Create(Mesh){
				Parent = Part,
				Offset = OffSet,
				Scale = Scale,
			}
			if Mesh == "SpecialMesh" then
				Msh.MeshType = MeshType
				Msh.MeshId = MeshId
			end
			return Msh
		end;
	};

	["Weld"] = {
		Create = function(Parent, Part0, Part1, C0, C1)
			local Weld = Create("Weld"){
				Parent = Parent,
				Part0 = Part0,
				Part1 = Part1,
				C0 = C0,
				C1 = C1,
			}
			return Weld
		end;
	};

	["Sound"] = {
		Create = function(id, par, vol, pit) 
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound"){
					Volume = vol,
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace,
				}
				wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 10)
			end))
		end;
	};

	["LongSound"] = {
		Create = function(id, par, vol, pit) 
			coroutine.resume(coroutine.create(function()
				local S = Create("Sound"){
					Volume = vol,
					Pitch = pit or 1,
					SoundId = id,
					Parent = par or workspace,
				}
				wait() 
				S:play() 
				game:GetService("Debris"):AddItem(S, 30)
			end))
		end;
	};

	["ParticleEmitter"] = {
		Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
			local fp = Create("ParticleEmitter"){
				Parent = Parent,
				Color = ColorSequence.new(Color1, Color2),
				LightEmission = LightEmission,
				Size = Size,
				Texture = Texture,
				Transparency = Transparency,
				ZOffset = ZOffset,
				Acceleration = Accel,
				Drag = Drag,
				LockedToPart = LockedToPart,
				VelocityInheritance = VelocityInheritance,
				EmissionDirection = EmissionDirection,
				Enabled = Enabled,
				Lifetime = LifeTime,
				Rate = Rate,
				Rotation = Rotation,
				RotSpeed = RotSpeed,
				Speed = Speed,
				VelocitySpread = VelocitySpread,
			}
			return fp
		end;
	};

	CreateTemplate = {

	};
}



New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
		Object[Index] = Value
	end
	Object.Parent = Parent
	Object.Name = Name
	return Object
end
local m = Instance.new("Model",char)

function CreateParta(parent,transparency,reflectance,material,brickcolor)
	local p = Instance.new("Part")
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = parent
	p.Size = Vector3.new(0.05,0.05,0.05)
	p.Transparency = transparency
	p.Reflectance = reflectance
	p.CanCollide = false
	p.Locked = true
	p.BrickColor = brickcolor
	p.Material = material
	return p
end

function CreateMesh(parent,meshtype,x1,y1,z1)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.MeshType = meshtype
	mesh.Scale = Vector3.new(x1*20,y1*20,z1*20)
	return mesh
end

function CreateSpecialMesh(parent,meshid,x1,y1,z1)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.MeshType = "FileMesh"
	mesh.MeshId = meshid
	mesh.Scale = Vector3.new(x1,y1,z1)
	return mesh
end


function CreateSpecialGlowMesh(parent,meshid,x1,y1,z1)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.MeshType = "FileMesh"
	mesh.MeshId = meshid
	mesh.TextureId = "http://www.roblox.com/asset/?id=269748808"
	mesh.Scale = Vector3.new(x1,y1,z1)
	mesh.VertexColor = Vector3.new(parent.BrickColor.r, parent.BrickColor.g, parent.BrickColor.b)
	return mesh
end

function CreateWeld(parent,part0,part1,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za)
	local weld = Instance.new("Weld")
	weld.Parent = parent
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C1 = CFrame.new(C1X,C1Y,C1Z)*CFrame.Angles(C1Xa,C1Ya,C1Za)
	weld.C0 = CFrame.new(C0X,C0Y,C0Z)*CFrame.Angles(C0Xa,C0Ya,C0Za)
	return weld
end

---- WEAPON OR STUFF
local rarmor = CreateParta(m,1,0,"SmoothPlastic",BrickColor.Random())
local weaponweld = CreateWeld(rarmor,tors,rarmor,-3,0,-0.5,math.rad(0),math.rad(0),math.rad(-40),0,0,0,math.rad(0),math.rad(0),math.rad(0))
local MainWeldS = CreateWeld(Part475,rarmor,Part475,0,0,0,math.rad(90),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
local A0 = Instance.new("Attachment",rarmor)
A0.Position = Vector3.new(-2.5,0.25,0)
local A1 = Instance.new("Attachment",rarmor)
A1.Position = Vector3.new(-7.5,0.4,0)
tl1 = Instance.new('Trail',rarmor)
tl1.Attachment0 = A0
tl1.Attachment1 = A1
tl1.Texture = "http://www.roblox.com/asset/?id=1978704853"
tl1.LightEmission = 1
tl1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
tl1.Color = ColorSequence.new(BrickColor.new('Royal purple').Color)
tl1.Lifetime = 0.6
tl1.Enabled = false




--------------- WINGS
local mainpart = CreateParta(m,1,0,"SmoothPlastic",BrickColor.Random())
local mwingweld = CreateWeld(mainpart,tors,mainpart,0,-0.5,-0.75,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

local wng1a = CreateParta(m,1,0,"Neon",BrickColor.new("Alder"))
CreateMesh(wng1a,"Wedge",0.1,4,4)
CreateWeld(wng1a,mainpart,wng1a,0,-2,-2.5,math.rad(0),math.rad(70),math.rad(5),0,0,0,math.rad(0),math.rad(0),math.rad(0))
local wng2a = CreateParta(m,1,0,"Neon",BrickColor.new("Alder"))
CreateMesh(wng2a,"Wedge",0.1,4,4)
CreateWeld(wng2a,mainpart,wng2a,0,-2,-2.5,math.rad(0),math.rad(-70),math.rad(-5),0,0,0,math.rad(0),math.rad(0),math.rad(0))
local wng1b = CreateParta(m,1,0,"Neon",BrickColor.new("Alder"))
CreateMesh(wng1b,"Wedge",0.1,1.5,3)
CreateWeld(wng1b,mainpart,wng1b,0,-1,-2.25,math.rad(180),math.rad(-110),math.rad(-5),0,0,0,math.rad(0),math.rad(0),math.rad(0))
local wng2b = CreateParta(m,1,0,"Neon",BrickColor.new("Alder"))
CreateMesh(wng2b,"Wedge",0.1,1.5,3)
CreateWeld(wng2b,mainpart,wng2b,0,-1,-2.25,math.rad(180),math.rad(110),math.rad(5),0,0,0,math.rad(0),math.rad(0),math.rad(0))
------


function lerp(object, newCFrame, alpha)
	return object:lerp(newCFrame, alpha)
end

function RemoveOutlines(part)
	part.TopSurface, part.BottomSurface, part.LeftSurface, part.RightSurface, part.FrontSurface, part.BackSurface = 10, 10, 10, 10, 10, 10
end
function CreatePart(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
	local Part = Create("Part")({
		Parent = Parent,
		Reflectance = Reflectance,
		Transparency = Transparency,
		CanCollide = false,
		Locked = true,
		BrickColor = BrickColor.new(tostring(BColor)),
		Name = Name,
		Size = Size,
		Material = Material
	})
	Part.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0.001, 0.001, 0.001, 0.001)
	RemoveOutlines(Part)
	return Part
end
function CreateMesh(Mesh, Part, MeshType, MeshId, OffSet, Scale)
	local Msh = Create(Mesh)({
		Parent = Part,
		Offset = OffSet,
		Scale = Scale
	})
	if Mesh == "SpecialMesh" then
		Msh.MeshType = MeshType
		Msh.MeshId = MeshId
	end
	return Msh
end
function CreateWeld(Parent, Part0, Part1, C0, C1)
	local Weld = Create("Weld")({
		Parent = Parent,
		Part0 = Part0,
		Part1 = Part1,
		C0 = C0,
		C1 = C1
	})
	return Weld
end

Player=game:GetService("Players").LocalPlayer
Character=chr
PlayerGui=Player.PlayerGui 
Backpack=Player.Backpack 
Torso=Character.Torso 
Head=Character.Head 
Humanoid=Character.Humanoid
m=Instance.new('Model',Character)
LeftArm=Character["Left Arm"] 
LeftLeg=Character["Left Leg"] 
RightArm=Character["Right Arm"] 
RightLeg=Character["Right Leg"] 
LS=Torso["Left Shoulder"] 
LH=Torso["Left Hip"] 
RS=Torso["Right Shoulder"] 
RH=Torso["Right Hip"] 
Neck=Torso.Neck
it=Instance.new
attacktype=1
vt=Vector3.new
cf=CFrame.new
euler=CFrame.fromEulerAnglesXYZ
angles=CFrame.Angles
cloaked=false
necko=cf(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
necko2=cf(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
LHC0=cf(-1,-1,0,-0,-0,-1,0,1,0,1,0,0)
LHC1=cf(-0.5,1,0,-0,-0,-1,0,1,0,1,0,0)
RHC0=cf(1,-1,0,0,0,1,0,1,0,-1,-0,-0)
RHC1=cf(0.5,1,0,0,0,1,0,1,0,-1,-0,-0)
RootPart=Character.HumanoidRootPart
RootJoint=RootPart.RootJoint
RootCF=euler(-1.57,0,3.14)
attack = false 
attackdebounce = false 
deb=false
equipped=true
hand=false
MMouse=nil
combo=0
mana=0
trispeed=.2
attackmode='none'
local idle=0
local Anim="Idle"
local Effects={}
local gun=false
local shoot=false
local sine = 0
local change = 1
player=nil 

mouse=Player:GetMouse()
--save shoulders 
RSH, LSH=nil, nil 
--welds 
RW, LW=Instance.new("Weld"), Instance.new("Weld") 
RW.Name="Right Shoulder" LW.Name="Left Shoulder"
LH=Torso["Left Hip"]
RH=Torso["Right Hip"]
TorsoColor=Torso.BrickColor
function NoOutline(Part)
	Part.TopSurface,Part.BottomSurface,Part.LeftSurface,Part.RightSurface,Part.FrontSurface,Part.BackSurface = 10,10,10,10,10,10
end
player=Player 
ch=Character
RSH=ch.Torso["Right Shoulder"] 
LSH=ch.Torso["Left Shoulder"] 
-- 
RSH.Parent=nil 
LSH.Parent=nil 
-- 
RW.Name="Right Shoulder"
RW.Part0=ch.Torso 
RW.C0=cf(1.5, 0.5, 0) --* CFrame.fromEulerAnglesXYZ(1.3, 0, -0.5) 
RW.C1=cf(0, 0.5, 0) 
RW.Part1=ch["Right Arm"] 
RW.Parent=ch.Torso 
-- 
LW.Name="Left Shoulder"
LW.Part0=ch.Torso 
LW.C0=cf(-1.5, 0.5, 0) --* CFrame.fromEulerAnglesXYZ(1.7, 0, 0.8) 
LW.C1=cf(0, 0.5, 0) 
LW.Part1=ch["Left Arm"] 
LW.Parent=ch.Torso 

local Stats=Instance.new("BoolValue")
Stats.Name="Stats"
Stats.Parent=Character
local Atk=Instance.new("NumberValue")
Atk.Name="Damage"
Atk.Parent=Stats
Atk.Value=1
local Def=Instance.new("NumberValue")
Def.Name="Defense"
Def.Parent=Stats
Def.Value=1
local Speed=Instance.new("NumberValue")
Speed.Name="Speed"
Speed.Parent=Stats
Speed.Value=1
local Mvmt=Instance.new("NumberValue")
Mvmt.Name="Movement"
Mvmt.Parent=Stats
Mvmt.Value=1

local donum=0


function part(formfactor,parent,reflectance,transparency,brickcolor,name,size)
	local fp=it("Part")
	fp.formFactor=formfactor 
	fp.Parent=parent
	fp.Reflectance=reflectance
	fp.Transparency=transparency
	fp.CanCollide=false 
	fp.Locked=true
	fp.BrickColor=brickcolor
	fp.Name=name
	fp.Size=size
	fp.Position=Torso.Position 
	NoOutline(fp)
	fp.Material="SmoothPlastic"
	fp:BreakJoints()
	return fp 
end 

function mesh(Mesh,part,meshtype,meshid,offset,scale)
	local mesh=it(Mesh) 
	mesh.Parent=part
	if Mesh=="SpecialMesh" then
		mesh.MeshType=meshtype
		if meshid~="nil" then
			mesh.MeshId="http://www.roblox.com/asset/?id="..meshid
		end
	end
	mesh.Offset=offset
	mesh.Scale=scale
	return mesh
end

function weld(parent,part0,part1,c0)
	local weld=it("Weld") 
	weld.Parent=parent
	weld.Part0=part0 
	weld.Part1=part1 
	weld.C0=c0
	return weld
end

local Color1=Torso.BrickColor

local bodvel=Instance.new("BodyVelocity")
local bg=Instance.new("BodyGyro")

function swait(num)
	if num==0 or num==nil then
		game:service'RunService'.Stepped:wait(0)
	else
		for i=0,num do
			game:service'RunService'.Stepped:wait(0)
		end
	end
end


so = function(id,par,vol,pit) 
	coroutine.resume(coroutine.create(function()
		local sou = Instance.new("Sound",par or workspace)
		sou.Volume=vol
		sou.Pitch=pit or 1
		sou.SoundId=id
		swait() 
		sou:play() 
		game:GetService("Debris"):AddItem(sou,6)
	end))
end

function clerp(a,b,t) 
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)} 
	local ax, ay, az = a.x, a.y, a.z 
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1-t
	return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
end 

function QuaternionFromCFrame(cf) 
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
	local trace = m00 + m11 + m22 
	if trace > 0 then 
		local s = math.sqrt(1 + trace) 
		local recip = 0.5/s 
		return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
	else 
		local i = 0 
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then 
			i = 2 
		end 
		if i == 0 then 
			local s = math.sqrt(m00-m11-m22+1) 
			local recip = 0.5/s 
			return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
		elseif i == 1 then 
			local s = math.sqrt(m11-m22-m00+1) 
			local recip = 0.5/s 
			return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
		elseif i == 2 then 
			local s = math.sqrt(m22-m00-m11+1) 
			local recip = 0.5/s return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
		end 
	end 
end

function QuaternionToCFrame(px, py, pz, x, y, z, w) 
	local xs, ys, zs = x + x, y + y, z + z 
	local wx, wy, wz = w*xs, w*ys, w*zs 
	local xx = x*xs 
	local xy = x*ys 
	local xz = x*zs 
	local yy = y*ys 
	local yz = y*zs 
	local zz = z*zs 
	return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
end

function QuaternionSlerp(a, b, t) 
	local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
	local startInterp, finishInterp; 
	if cosTheta >= 0.0001 then 
		if (1 - cosTheta) > 0.0001 then 
			local theta = math.acos(cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((1-t)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta  
		else 
			startInterp = 1-t 
			finishInterp = t 
		end 
	else 
		if (1+cosTheta) > 0.0001 then 
			local theta = math.acos(-cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((t-1)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta 
		else 
			startInterp = t-1 
			finishInterp = t 
		end 
	end 
	return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
end

local function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CFrame.new(at.x, at.y, at.z,
		right.x, top.x, back.x,
		right.y, top.y, back.y,
		right.z, top.z, back.z)
end

function Triangle(a, b, c)
	local edg1 = (c-a):Dot((b-a).unit)
	local edg2 = (a-b):Dot((c-b).unit)
	local edg3 = (b-c):Dot((a-c).unit)
	if edg1 <= (b-a).magnitude and edg1 >= 0 then
		a, b, c = a, b, c
	elseif edg2 <= (c-b).magnitude and edg2 >= 0 then
		a, b, c = b, c, a
	elseif edg3 <= (a-c).magnitude and edg3 >= 0 then
		a, b, c = c, a, b
	else
		assert(false, "unreachable")
	end

	local len1 = (c-a):Dot((b-a).unit)
	local len2 = (b-a).magnitude - len1
	local width = (a + (b-a).unit*len1 - c).magnitude

	local maincf = CFrameFromTopBack(a, (b-a):Cross(c-b).unit, -(b-a).unit)

	local list = {}

	if len1 > 0.01 then
		local w1 = Instance.new('WedgePart', m)
		game:GetService("Debris"):AddItem(w1,5)
		w1.Material = "SmoothPlastic"
		w1.FormFactor = 'Custom'
		w1.BrickColor = BrickColor.new("Really red")
		w1.Transparency = 0
		w1.Reflectance = 0
		w1.Material = "SmoothPlastic"
		w1.CanCollide = false
		local l1 = Instance.new("PointLight",w1)
		l1.Color = Color3.new(170,0,0)
		NoOutline(w1)
		local sz = Vector3.new(0.2, width, len1)
		w1.Size = sz
		local sp = Instance.new("SpecialMesh",w1)
		sp.MeshType = "Wedge"
		sp.Scale = Vector3.new(0,1,1) * sz/w1.Size
		w1:BreakJoints()
		w1.Anchored = true
		w1.Parent = workspace
		w1.Transparency = 0.7
		table.insert(Effects,{w1,"Disappear",.01})
		w1.CFrame = maincf*CFrame.Angles(math.pi,0,math.pi/2)*CFrame.new(0,width/2,len1/2)
		table.insert(list,w1)
	end

	if len2 > 0.01 then
		local w2 = Instance.new('WedgePart', m)
		game:GetService("Debris"):AddItem(w2,5)
		w2.Material = "SmoothPlastic"
		w2.FormFactor = 'Custom'
		w2.BrickColor = BrickColor.new("Really red")
		w2.Transparency = 0
		w2.Reflectance = 0
		w2.Material = "SmoothPlastic"
		w2.CanCollide = false
		local l2 = Instance.new("PointLight",w2)
		l2.Color = Color3.new(170,0,0)
		NoOutline(w2)
		local sz = Vector3.new(0.2, width, len2)
		w2.Size = sz
		local sp = Instance.new("SpecialMesh",w2)
		sp.MeshType = "Wedge"
		sp.Scale = Vector3.new(0,1,1) * sz/w2.Size
		w2:BreakJoints()
		w2.Anchored = true
		w2.Parent = workspace
		w2.Transparency = 0.7
		table.insert(Effects,{w2,"Disappear",.01})
		w2.CFrame = maincf*CFrame.Angles(math.pi,math.pi,-math.pi/2)*CFrame.new(0,width/2,-len1 - len2/2)
		table.insert(list,w2)
	end
	return unpack(list)
end


function Damagefunc(hit)
	local model = hit.Parent
	if model:IsA("Model") then
		KadeAPI.CallFling(model)
	end
end
function ShowDamage(Pos, Text, Time, Color)
	local Rate = 0.1
	local Pos = Pos or Vector3.new(0, 0, 0)
	local Text = Text or ""
	local Time = Time or 2
	local Color = Color or Color3.new(1, 0, 1)
	local EffectPart = CreatePart(workspace, "SmoothPlastic", 0, 1, BrickColor.new(Color), "Effect", Vector3.new(0, 0, 0))
	EffectPart.Anchored = true
	local BillboardGui = Create("BillboardGui")({
		Size = UDim2.new(3, 0, 3, 0),
		Adornee = EffectPart,
		Parent = EffectPart
	})
	local TextLabel = Create("TextLabel")({
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = Text,
		TextColor3 = Color3.new(1,1,1),
		TextStrokeColor3 = Color3.new(0,0,0),
		TextStrokeTransparency = 0.25,
		TextScaled = true,
		Font = Enum.Font.Fantasy,
		TextSize = 24,
		Parent = BillboardGui
	})
	game.Debris:AddItem(EffectPart, Time + 0.1)
	EffectPart.Parent = game:GetService("Workspace")
	delay(0, function()
		local Frames = Time / Rate
		for Frame = 1, Frames do
			swait(Rate)
			local Percent = Frame / Frames
			TextLabel.Text = Text
			EffectPart.CFrame = CFrame.new(Pos) + Vector3.new(0, Percent*2, 0)
		end
		for Frame = 1, Frames do
			swait(Rate)
			local Percent = Frame / Frames
			TextLabel.Text = Text
		end
		for Frame = 1, Frames do
			swait(Rate)
			local Percent = Frame / Frames
			TextLabel.TextTransparency = Percent
			TextLabel.Text = Text
			TextLabel.TextStrokeTransparency = Percent
		end
		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end)
end
function MagniDamage(Part, magni, mindam, maxdam, knock, Type,Sound)
	for _, c in pairs(workspace:children()) do
		local hum = c:findFirstChildOfClass("Humanoid")
		if hum ~= nil then
			local head = c:findFirstChild("Torso")
			if head ~= nil then
				local targ = head.Position - Part.Position
				local mag = targ.magnitude
				if magni >= mag and c.Name ~= Player.Name then
					Damagefunc(head)
				end
			end
			local head = c:findFirstChild("UpperTorso")
			if head ~= nil then
				local targ = head.Position - Part.Position
				local mag = targ.magnitude
				if magni >= mag and c.Name ~= Player.Name then
					Damagefunc(head)
				end
			end
		end
	end
end


function rayCast(Pos, Dir, Max, Ignore)  -- Origin Position , Direction, MaxDistance , IgnoreDescendants
	return game:service("Workspace"):FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore) 
end 
----

function dmg(dude)
	if dude.Name ~= Character then
		local bgf = Instance.new("BodyGyro",dude.Head)
		bgf.CFrame = bgf.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(-90),0,0)
--[[local val = Instance.new("BoolValue",dude)
val.Name = "IsHit"]]--
		local ds = coroutine.wrap(function()
			dude:WaitForChild("Head"):BreakJoints()
			for i, v in pairs(dude:GetChildren()) do
				if v:IsA("Part") or v:IsA("MeshPart") then
					v.Name = "DEMINISHED"
					CFuncs["Sound"].Create("rbxassetid://763718160", v, 0.75, 1.1)
					CFuncs["Sound"].Create("rbxassetid://782353443", v, 1, 1)
					for i = 0, 1 do
						sphere2(1,"Add",v.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(1,1,1),-0.01,10,-0.01,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
					end
				end
			end
			wait(0.5)
			targetted = nil
			CFuncs["Sound"].Create("rbxassetid://62339698", char, 0.25, 0.285)
			coroutine.resume(coroutine.create(function()
				for i, v in pairs(dude:GetChildren()) do
					if v:IsA("Accessory") then
						v:Destroy()
					end
					if v:IsA("Humanoid") then
						v:Destroy()
					end
					if v:IsA("CharacterMesh") then
						v:Destroy()
					end
					if v:IsA("Model") then
						v:Destroy()
					end
					if v:IsA("Part") or v:IsA("MeshPart") then
						for x, o in pairs(v:GetChildren()) do
							if o:IsA("Decal") then
								o:Destroy()
							end
						end
						coroutine.resume(coroutine.create(function()
							v.Material = "Neon"
							v.CanCollide = false
							v.Anchored = false
							local bld = Instance.new("ParticleEmitter",v)
							bld.LightEmission = 1
							bld.Texture = "rbxassetid://363275192" ---284205403
							bld.Color = ColorSequence.new(BrickColor.new("Royal purple").Color)
							bld.Rate = 500
							bld.Lifetime = NumberRange.new(1)
							bld.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,2,0),NumberSequenceKeypoint.new(0.8,2.25,0),NumberSequenceKeypoint.new(1,0,0)})
							bld.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.5,0),NumberSequenceKeypoint.new(0.8,0.75,0),NumberSequenceKeypoint.new(1,1,0)})
							bld.Speed = NumberRange.new(2,5)
							bld.VelocitySpread = 50000
							bld.Rotation = NumberRange.new(-500,500)
							bld.RotSpeed = NumberRange.new(-500,500)
							local sbs = Instance.new("BodyPosition", v)
							sbs.P = 3000
							sbs.D = 1000
							sbs.maxForce = Vector3.new(50000000000, 50000000000, 50000000000)
							sbs.position = v.Position + Vector3.new(math.random(-2,2),10 + math.random(-2,2),math.random(-2,2))
							v.Color = BrickColor.new("Royal purple").Color
							coroutine.resume(coroutine.create(function()
								for i = 0, 49 do
									swait(1)
									v:BreakJoints()
									v.Transparency = v.Transparency + 0.02
								end
								v:BreakJoints()
								for i = 0, 4 do
									slash(math.random(10,50)/10,3,true,"Round","Add","Out",v.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.01,0.0025,0.01),math.random(10,100)/2500,BrickColor.new("White"))
								end
								block(1,"Add",v.CFrame,vt(0,0,0),0.1,0.1,0.1,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
								CFuncs["Sound"].Create("rbxassetid://782353117", v, 0.25, 1.2)
								CFuncs["Sound"].Create("rbxassetid://1192402877", v, 0.5, 0.75)
								bld.Speed = NumberRange.new(10,25)
								bld.Drag = 5
								bld.Acceleration = vt(0,2,0)
								wait(0.5)
								bld.Enabled = false
								wait(4)
								coroutine.resume(coroutine.create(function()
									for i = 0, 99 do
										swait()
										v:Destroy()
										dude:Destroy()
									end
								end))
							end))
						end))
					end
				end
			end))
		end)
		ds()
	end
end

function sphere(bonuspeed,type,pos,scale,value,color)
	local type = type
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = scale
	if rainbowmode == true then
		rng.Color = Color3.new(r/255,g/255,b/255)
	end
	local scaler2 = 1
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if rainbowmode == true then
				rng.Color = Color3.new(r/255,g/255,b/255)
			end
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			if chaosmode == true then
				rng.BrickColor = BrickColor.random()
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function sphere2(bonuspeed,type,pos,scale,value,value2,value3,color,color3)
	local type = type
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.Color = color3
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	local scaler2c = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
		scaler2c = 1*value3
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
		scaler2c = 1/value3
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
				scaler2c = scaler2c - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
				scaler2c = scaler2c - 0.01/value*bonuspeed
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2c*bonuspeed)
		end
		rng:Destroy()
	end))
end

function block(bonuspeed,type,pos,scale,value,value2,value3,color,color3)
	local type = type
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.Color = color3
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	local scaler2c = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
		scaler2c = 1*value3
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
		scaler2c = 1/value3
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
				scaler2c = scaler2c - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
				scaler2c = scaler2c - 0.01/value*bonuspeed
			end
			rng.CFrame = rng.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2c*bonuspeed)
		end
		rng:Destroy()
	end))
end

function sphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,color3,outerpos)
	local type = type
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.Color = color3
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = vt(x1,y1,z1)
	if rainbowmode == true then
		rng.Color = Color3.new(r/255,g/255,b/255)
	end
	local scaler2 = 1
	local speeder = FastSpeed
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if rainbowmode == true then
				rng.Color = Color3.new(r/255,g/255,b/255)
			end
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			if chaosmode == true then
				rng.BrickColor = BrickColor.random()
			end
			speeder = speeder - 0.01*FastSpeed*bonuspeed
			rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
		end
		rng:Destroy()
	end))
end

function waveEff(bonuspeed,type,typeoftrans,pos,scale,value,value2,color)
	local type = type
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	rngm.MeshId = "rbxassetid://20329976"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
	end
	local randomrot = math.random(1,2)
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
			end
			if randomrot == 1 then
				rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(5*bonuspeed/2),0)
			elseif randomrot == 2 then
				rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-5*bonuspeed/2),0)
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function slash(bonuspeed,rotspeed,rotatingop,typeofshape,type,typeoftrans,pos,scale,value,color)
	local type = type
	local rotenable = rotatingop
	local rng = Instance.new("Part", char)
	rng.Anchored = true
	rng.BrickColor = color
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	if typeofshape == "Normal" then
		rngm.MeshId = "rbxassetid://662586858"
	elseif typeofshape == "Round" then
		rngm.MeshId = "rbxassetid://662585058"
	end
	rngm.Scale = scale
	local scaler2 = 1/10
	if type == "Add" then
		scaler2 = 1*value/10
	elseif type == "Divide" then
		scaler2 = 1/value/10
	end
	local randomrot = math.random(1,2)
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed/10
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed/10
			end
			if rotenable == true then
				if randomrot == 1 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(rotspeed*bonuspeed/2),0)
				elseif randomrot == 2 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-rotspeed*bonuspeed/2),0)
				end
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed/10, 0, scaler2*bonuspeed/10)
		end
		rng:Destroy()
	end))
end

function FindNearestTorso(Position, Distance, SinglePlayer)
	if SinglePlayer then
		return (SinglePlayer.Torso.CFrame.p - Position).magnitude < Distance
	end
	local List = {}
	for i, v in pairs(workspace:GetChildren()) do
		if v:IsA("Model") then
			if v:findFirstChild("Torso") or v:findFirstChild("UpperTorso") then
				if v ~= Character then
					if (v.Head.Position - Position).magnitude <= Distance then
						table.insert(List, v)
					end 
				end 
			end 
		end 
	end
	return List
end


local dashing = false
local floatmode = false
local OWS = hum.WalkSpeed
local equipped = false
Humanoid.Name = "NEPTUNIA"
Humanoid.MaxHealth = math.huge
Humanoid.Health = math.huge
Instance.new("ForceField",char).Visible = false
Humanoid.Animator.Parent = nil
------------------
function equip()
	attack = true
	equipped = true
	hum.WalkSpeed = 0
	tl1.Enabled = true
	for i = 0, 9 do
		slash(math.random(10,50)/10,3,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
	end
	CFuncs["Sound"].Create("rbxassetid://1368637781", rarmor, 2.5, 1.25)
	CFuncs["Sound"].Create("rbxassetid://200633077", rarmor, 1, 1)
	CFuncs["Sound"].Create("rbxassetid://169380495", rarmor, 0.5, 1.1)
	sphere2(5,"Add",root.CFrame,vt(5,5,5),0.25,0.25,0.25,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	sphere2(6,"Add",root.CFrame,vt(5,5,5),0.25,0.25,0.25,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
	for i = 0, 2, 0.1 do
		swait()
		hum.CameraOffset = vt(math.random(-5,5)/50,math.random(-5,5)/50,math.random(-5,5)/50)
		sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		waveEff(5,"Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),vt(5,0.25,5),0.05,0.015,BrickColor.new("Cyan"))
		waveEff(5,"Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),vt(10,0.25,10),0.05,0.015,BrickColor.new("Royal purple"))
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(10),math.rad(0)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-10)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(-20)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(-20),math.rad(-30),math.rad(130)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(-13),math.rad(10),math.rad(-10)),.3)
	end
	hum.CameraOffset = vt(0,0,0)
	weaponweld.Part0 = rarm
	for i = 0, 2, 0.1 do
		swait()
		sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-40),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(1),math.rad(5)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.1,0.1,0)*angles(math.rad(0),math.rad(0),math.rad(40)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(-40)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.25,0.5,-0.65)*angles(math.rad(100),math.rad(0),math.rad(-23)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(110),math.rad(0),math.rad(-85)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
	end
	local hitb = CreateParta(m,1,1,"SmoothPlastic",BrickColor.Random())
	hitb.Anchored = true
	hitb.CFrame = root.CFrame + root.CFrame.lookVector*4
	MagniDamage(hitb, 4, 40,73, 0, "Normal",153092213)
	slash(5,5,true,"Round","Add","Out",hitb.CFrame*CFrame.Angles(0,math.rad(math.random(-360,360)),0),vt(0.05,0.01,0.05),0.01,BrickColor.new("White"))
	CFuncs["Sound"].Create("rbxassetid://200633196", rarmor, 1, 1.05)
	CFuncs["Sound"].Create("rbxassetid://200633108", rarmor, 1.5, 1.025)
	CFuncs["Sound"].Create("rbxassetid://234365549", rarmor, 1, 1)
	for i = 0, 2, 0.1 do
		swait()
		sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-20)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(50),math.rad(0)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(-0.1,-0.25,0)*angles(math.rad(10),math.rad(0),math.rad(-50)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(50)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(80),math.rad(0),math.rad(70)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(100),math.rad(0),math.rad(-50)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
	end
	hitb:Destroy()
	hum.WalkSpeed = 24
	OWS = hum.WalkSpeed
	attack = false
end

function unequip()
	attack = true
	equipped = false
	hum.WalkSpeed = 0
	hum.WalkSpeed = 16
	OWS = hum.WalkSpeed
	tl1.Enabled = false
	CFuncs["Sound"].Create("rbxassetid://200633029", rarmor, 1, 1)
	weaponweld.C1=clerp(weaponweld.C1,cf(-3,0,-0.5)*angles(math.rad(0),math.rad(0),math.rad(-40)),.5)
	weaponweld.Part0 = tors
	attack = false
end

------------------
function attackone()
	attack = true
	hum.WalkSpeed = 4
	for i = 0, 2, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-40),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(1),math.rad(5)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.1,0.1,0)*angles(math.rad(0),math.rad(0),math.rad(40)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(-40)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.25,0.5,-0.65)*angles(math.rad(100),math.rad(0),math.rad(-23)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(110),math.rad(0),math.rad(-85)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
	end
	local hitb = CreateParta(m,1,1,"SmoothPlastic",BrickColor.Random())
	hitb.Anchored = true
	hitb.CFrame = root.CFrame + root.CFrame.lookVector*4
	MagniDamage(hitb, 4, 24,30, 0, "Normal",153092213)
	CFuncs["Sound"].Create("rbxassetid://200633196", rarmor, 1, 1.05)
	CFuncs["Sound"].Create("rbxassetid://200633108", rarmor, 1.5, 1.025)
	CFuncs["Sound"].Create("rbxassetid://234365549", rarmor, 1, 1)
	for i = 0, 1, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-20)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(50),math.rad(0)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(-0.1,-0.25,0)*angles(math.rad(10),math.rad(0),math.rad(-50)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(50)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(80),math.rad(0),math.rad(70)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(100),math.rad(0),math.rad(-50)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
	end
	hitb:Destroy()
	attack = false
	hum.WalkSpeed = 24
end
function attacktwo()
	attack = true
	hum.WalkSpeed = 4
	for i = 0, 1, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(20),math.rad(5)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(-0.1,0.1,0)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(40)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.25,0.5,-0.65)*angles(math.rad(100),math.rad(0),math.rad(-23)),.3)
		LW.C0=clerp(LW.C0,cf(-0.5,0.5,-0.25)*angles(math.rad(90),math.rad(0),math.rad(40)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
	end
	local hitb = CreateParta(m,1,1,"SmoothPlastic",BrickColor.Random())
	hitb.Anchored = true
	hitb.CFrame = root.CFrame + root.CFrame.lookVector*4
	MagniDamage(hitb, 4, 24,30, 0, "Normal",153092213)
	CFuncs["Sound"].Create("rbxassetid://200633281", rarmor, 1, 1.05)
	CFuncs["Sound"].Create("rbxassetid://161006195", rarmor, 1.5, 1.025)
	for i = 0, 1, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-30),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(20)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.2,-0.25,0)*angles(math.rad(10),math.rad(0),math.rad(90)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(-90)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(80),math.rad(0),math.rad(20)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(100),math.rad(0),math.rad(-50)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(180),math.rad(70)),.3)
	end
	attack = false
	hum.WalkSpeed = 24
end
function attackthree()
	attack = true
	hum.WalkSpeed = 4
	for i = 0, 1, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-30),math.rad(0)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(5)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(-0.1,0.1,0)*angles(math.rad(0),math.rad(0),math.rad(-60)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0),math.rad(60)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.5,0.5,0)*angles(math.rad(-30),math.rad(0),math.rad(53)),.3)
		LW.C0=clerp(LW.C0,cf(-1.5,0.5,0)*angles(math.rad(10),math.rad(0),math.rad(-10)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(90),math.rad(-20)),.3)
	end
	for x = 0, 2 do
		CFuncs["Sound"].Create("rbxassetid://200633108", rarmor, 1, 1.05)
		CFuncs["Sound"].Create("rbxassetid://234365573", rarmor, 1.5, 1.025)
		local hitb = CreateParta(m,1,1,"SmoothPlastic",BrickColor.Random())
		hitb.Anchored = true
		hitb.CFrame = root.CFrame + root.CFrame.lookVector*4
		MagniDamage(hitb, 4, 12,15, 0, "Normal",153092213)
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(40),math.rad(20)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.2,-0.25,0)*angles(math.rad(-2),math.rad(0),math.rad(80)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-80)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-20)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(0),math.rad(30),math.rad(90)),.3)
		end
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(40),math.rad(20)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.2,-0.25,0)*angles(math.rad(-2),math.rad(0),math.rad(80)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-80)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-20)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(180)),.3)
		end
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(40),math.rad(20)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.2,-0.25,0)*angles(math.rad(-2),math.rad(0),math.rad(80)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-80)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-20)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(0),math.rad(-30),math.rad(270)),.3)
		end
		for i = 0, 1, 0.6 do
			swait()
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(40),math.rad(20)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.2,-0.25,0)*angles(math.rad(-2),math.rad(0),math.rad(80)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-80)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-20)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
		end
	end
	attack = false
	hum.WalkSpeed = 24
end
------------------
function spinnyblade()
	attack = true
	hum.WalkSpeed = 1
	hum.JumpPower = 0
	CFuncs["Sound"].Create("rbxassetid://1368583274", root, 4.5, 1)
	local bgui = Instance.new("BillboardGui",root)
	bgui.Size = UDim2.new(25, 0, 25, 0)
	local imgc = Instance.new("ImageLabel",bgui)
	imgc.BackgroundTransparency = 1
	imgc.ImageTransparency = 1
	imgc.Size = UDim2.new(1,0,1,0)
	imgc.Image = "rbxassetid://997291547"
	imgc.ImageColor3 = Color3.new(0,0.5,1)
	local imgc2 = imgc:Clone()
	imgc2.Parent = bgui
	imgc2.Position = UDim2.new(-0.5,0,-0.5,0)
	imgc2.Size = UDim2.new(2,0,2,0)
	imgc2.ImageColor3 = Color3.new(0.5,0,1)
	for i = 0, 10, 0.1 do
		swait()
		imgc.ImageTransparency = imgc.ImageTransparency - 0.01
		imgc.Rotation = imgc.Rotation + 1
		imgc2.ImageTransparency = imgc2.ImageTransparency - 0.01
		imgc2.Rotation = imgc2.Rotation - 1
		bgui.Size = bgui.Size - UDim2.new(0.25, 0, 0.25, 0)
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),vt(0.1,0.01,0.1),math.random(25,50)/250,BrickColor.new("White"))
		sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		hum.CameraOffset = vt(math.random(-10,10)/50,math.random(-10,10)/50,math.random(-10,10)/50)
		sphereMK(5,math.random(4,25)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),0.75,0.75,20,-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
		sphereMK(5,math.random(1,15)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-25,25)),math.rad(math.random(-25,25)),math.rad(math.random(-25,25))),0.75,0.75,20,-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
		waveEff(5,"Add","In",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),vt(15,0.25,15),-0.075,0.05,BrickColor.new("White"))
		RH.C0=clerp(RH.C0,cf(1,-0.5,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-40),math.rad(10)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(1),math.rad(20)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.1,0.2,-0.3)*angles(math.rad(10),math.rad(0),math.rad(50)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(5),math.rad(0),math.rad(-50)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.25,0.5,-0.65)*angles(math.rad(100),math.rad(0),math.rad(-23)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(110),math.rad(0),math.rad(-85)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
	end
	imgc.ImageTransparency = 1
	hum.CameraOffset = vt(0,0,0)
	waveEff(2,"Add","Out",root.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(6,10,6),0.5,0.8,BrickColor.new("White"))
	waveEff(3,"Add","Out",root.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(6,10,6),0.5,0.4,BrickColor.new("White"))
	waveEff(4,"Add","Out",root.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(6,10,6),0.5,0.2,BrickColor.new("White"))
	waveEff(5,"Add","Out",root.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(6,10,6),0.5,0.1,BrickColor.new("White"))
	waveEff(6,"Add","Out",root.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(6,10,6),0.5,0.05,BrickColor.new("White"))
	for i = 0, 9 do
		slash(math.random(10,25)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,0,math.random(-30,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),vt(0.1,0.01,0.1),math.random(75,250)/250,BrickColor.new("White"))
	end
	CFuncs["Sound"].Create("rbxassetid://430315987", root, 1.5, 1)
	CFuncs["Sound"].Create("rbxassetid://1295446488", root, 3, 1)
	for x = 0, 14 do
		CFuncs["Sound"].Create("rbxassetid://200633281", rarmor, 1, 1.05)
		CFuncs["Sound"].Create("rbxassetid://161006195", rarmor, 1.5, 1.025)
		MagniDamage(tors, 10, 60,85, 0, "Normal",153092213)
		CFuncs["Sound"].Create("rbxassetid://200632992", rarmor, 1.25, 1)
		slash(5,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(2,-1,"Add",root.CFrame*CFrame.new(math.random(-8,8),math.random(-8,8),math.random(-3,8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.5,0.5,math.random(5,25),-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			root.CFrame = root.CFrame + root.CFrame.lookVector*2
			root.Velocity = vt(0,0,0)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,3)*angles(math.rad(0),math.rad(0),math.rad(90)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(90)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CFuncs["Sound"].Create("rbxassetid://200632992", rarmor, 1.25, 1)
		MagniDamage(tors, 10, 60,85, 0, "Normal",153092213)
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(2,-1,"Add",root.CFrame*CFrame.new(math.random(-8,8),math.random(-8,8),math.random(-3,8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.5,0.5,math.random(5,25),-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			root.CFrame = root.CFrame + root.CFrame.lookVector*3
			root.Velocity = vt(0,0,0)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,3)*angles(math.rad(90),math.rad(0),math.rad(90)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(90)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CFuncs["Sound"].Create("rbxassetid://200632992", rarmor, 1.25, 1)
		MagniDamage(tors, 10, 60,85, 0, "Normal",153092213)
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(2,-1,"Add",root.CFrame*CFrame.new(math.random(-8,8),math.random(-8,8),math.random(-3,8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.5,0.5,math.random(5,25),-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			root.CFrame = root.CFrame + root.CFrame.lookVector*3
			root.Velocity = vt(0,0,0)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,3)*angles(math.rad(180),math.rad(0),math.rad(90)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(90)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CFuncs["Sound"].Create("rbxassetid://200632992", rarmor, 1.25, 1)
		MagniDamage(tors, 10, 60,85, 0, "Normal",153092213)
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(2,-1,"Add",root.CFrame*CFrame.new(math.random(-8,8),math.random(-8,8),math.random(-3,8))*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),0.5,0.5,math.random(5,25),-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			root.CFrame = root.CFrame + root.CFrame.lookVector*3
			root.Velocity = vt(0,0,0)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,3)*angles(math.rad(270),math.rad(0),math.rad(90)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(90)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
	end
	hum.WalkSpeed = 0
	for i = 0, 5, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-20)),.2)
		LH.C0=clerp(LH.C0,cf(-1,-0.6,-0.5)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(20),math.rad(-12)),.2)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0.1,0.2,-0.35)*angles(math.rad(10),math.rad(0),math.rad(-40)),.2)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(5),math.rad(0),math.rad(40)),.2)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0)*angles(math.rad(90),math.rad(0),math.rad(110)),.2)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0)*angles(math.rad(45),math.rad(0),math.rad(-20)),.2)
		weaponweld.C1=clerp(weaponweld.C1,cf(2,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.2)
	end
	bgui:Destroy()
	attack = false
	hum.WalkSpeed = 24
	hum.JumpPower = 50
end

function eightbitmegablade()
	attack = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	CFuncs["Sound"].Create("rbxassetid://1368583274", larm, 4.5, 1.2)
	local OverCut = false
	cam.CameraSubject = Humanoid
	cam.CameraType = "Scriptable"
	coroutine.resume(coroutine.create(function()
		while true do
			swait()
			if OverCut == false then
				cam.CFrame = lerp(cam.CFrame, root.CFrame * cf(1, 1.5, -6) * ceuler(math.rad(10), math.rad(170), math.rad(-20)), 0.1)
			else
				break
			end
		end
	end))
	for i = 0, 10, 0.1 do
		swait()
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
		sphere2(5,"Add",larm.CFrame*CFrame.new(0,-1.5,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(1,1,1),-0.01,0.1,-0.01,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		slash(math.random(20,40)/10,5,true,"Round","Add","Out",larm.CFrame*CFrame.new(0,-1.5,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.025,0.001,0.025),-0.025,BrickColor.new("White"))
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-6),math.rad(0),math.rad(-6)),.3)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(3)),.3)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-50)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(-15),math.rad(5),math.rad(50)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(-13),math.rad(-40),math.rad(20)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(170),math.rad(10),math.rad(0)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
	end
	OverCut = true
	local orb = Instance.new("Part", char)
	orb.Anchored = true
	orb.BrickColor = BrickColor.new("Toothpaste")
	orb.CanCollide = false
	orb.FormFactor = 3
	orb.Name = "Ring"
	orb.Material = "Neon"
	orb.Size = Vector3.new(1, 1, 1)
	orb.Transparency = 0.5
	orb.TopSurface = 0
	orb.BottomSurface = 0
	local orbm = Instance.new("SpecialMesh", orb)
	orbm.MeshType = "FileMesh"
	orbm.MeshId = "rbxassetid://361629844"
	orbm.Scale = vt(30,60,60)
	orb.CFrame = root.CFrame*CFrame.new(0,50,0)
	for i = 0, 24 do
		slash(math.random(10,30)/10,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.001,0.1),math.random(50,400)/420,BrickColor.new("White"))
	end
	sphere2(2,"Add",orb.CFrame,vt(10,10,10),0.5,0.5,0.5,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	sphere2(3,"Add",orb.CFrame,vt(10,10,10),0.75,0.75,0.75,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	sphere2(4,"Add",orb.CFrame,vt(10,10,10),1,1,1,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	CFuncs["Sound"].Create("rbxassetid://1368637781", orb, 7.5, 1)
	local a = Instance.new("Part",workspace)
	a.Name = "Direction"	
	a.Anchored = true
	a.Transparency = 1
	a.CanCollide = false
	local ray = Ray.new(
		orb.CFrame.p,                           -- origin
		(mouse.Hit.p - orb.CFrame.p).unit * 500 -- direction
	) 
	local ignore = orb
	local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
	a.BottomSurface = 10
	a.TopSurface = 10
	local distance = (orb.CFrame.p - position).magnitude
	a.Size = Vector3.new(0.1, 0.1, 0.1)
	a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, 0)
	orb.CFrame = a.CFrame
	for i = 0, 8, 0.1 do
		swait()
		sphere2(5,"Add",orb.CFrame*CFrame.new(math.random(-20,20),math.random(-20,20),math.random(-20,20)),vt(1,1,1),0.01,0.01,0.01,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
		ray = Ray.new(
			orb.CFrame.p,                           -- origin
			(mouse.Hit.p - orb.CFrame.p).unit * 500 -- direction
		) 
		hit, position, normal = workspace:FindPartOnRay(ray, ignore)
		distance = (orb.CFrame.p - position).magnitude
		a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, 0)
		orb.CFrame = a.CFrame
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
		cam.CFrame = lerp(cam.CFrame, root.CFrame * cf(20, 65, 55) * ceuler(math.rad(-20), math.rad(0), math.rad(10)), 0.2)
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-6),math.rad(0),math.rad(-6)),.3)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(40),math.rad(3)),.3)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0)*angles(math.rad(0),math.rad(0),math.rad(-90)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(5),math.rad(0),math.rad(90)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(-13),math.rad(-20),math.rad(20)),.3)
		LW.C0=clerp(LW.C0,cf(-1.25,0.5,-0.5)*angles(math.rad(100),math.rad(0),math.rad(60)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
	end
	cam.CameraType = "Custom"
	orb.Anchored = false
	a:Destroy()
	local bv = Instance.new("BodyVelocity")
	bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.velocity = orb.CFrame.lookVector*250
	bv.Parent = orb
	local hitted = false
	CFuncs["Sound"].Create("rbxassetid://466493476", orb, 7.5, 0.7)
	waveEff(2,"Add","Out",orb.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(5,1,5),0.5,0.1,BrickColor.new("Cyan"))
	waveEff(4,"Add","Out",orb.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(5,1,5),0.5,0.05,BrickColor.new("Royal purple"))
	coroutine.resume(coroutine.create(function()
		while true do
			swait(2)
			if hitted == false and orb.Parent ~= nil then
				slash(3,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(0.075,0.005,0.075),-0.05,BrickColor.new("White"))
			elseif hitted == true and orb.Parent == nil then
				break
			end
		end
	end))
	orb.Touched:connect(function(hit) 
		if hitted == false and hit.Parent ~= char then
			hitted = true
			MagniDamage(orb, 30, 72,95, 0, "Normal",153092213)
			CFuncs["Sound"].Create("rbxassetid://763717897", orb, 10, 1)
			CFuncs["Sound"].Create("rbxassetid://1295446488", orb, 9, 0.75)
			for i = 0, 24 do
				slash(math.random(15,30)/10,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.01,0.001,0.01),math.random(125,250)/400,BrickColor.new("White"))
			end
			slash(1,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(0.01,0.015,0.01),1.5,BrickColor.new("White"))
			slash(1,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),vt(0.01,0.01,0.01),2,BrickColor.new("White"))
			sphere2(1,"Add",orb.CFrame,vt(10,10,10),1,1,1,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
			sphere2(1.5,"Add",orb.CFrame,vt(10,10,10),1.1,1.1,1.1,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
			sphere2(2,"Add",orb.CFrame,vt(10,10,10),1.2,1.2,1.2,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
			orb.Anchored = true
			orb.Transparency = 1
			coroutine.resume(coroutine.create(function()
				for i = 0, 4, 0.1 do
					swait()
					slash(math.random(10,50)/10,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(90 + math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.01,0.015,0.01),1.5,BrickColor.new("Royal purple"))
					hum.CameraOffset = vt(math.random(-10,10)/25,math.random(-10,10)/25,math.random(-10,10)/25)
				end
				hum.CameraOffset = vt(0,0,0)
			end))
			wait(10)
			orb:Destroy()
		end
	end)
	game:GetService("Debris"):AddItem(orb, 10)
	for i = 0, 2, 0.1 do
		swait()
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-6),math.rad(0),math.rad(-6)),.3)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(3)),.3)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.4,0)*angles(math.rad(0),math.rad(0),math.rad(-70)),.3)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(5),math.rad(0),math.rad(70)),.3)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(-13),math.rad(-40),math.rad(20)),.3)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-80)),.3)
		weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
	end
	attack = false
	hum.WalkSpeed = 24
	hum.JumpPower = 50
end

function bladespinagain()
	attack = true
	hum.WalkSpeed = 4
	hum.JumpPower = 0
	CFuncs["Sound"].Create("rbxassetid://1368598393", rarmor, 2, 1)
	CFuncs["Sound"].Create("rbxassetid://1368583274", rarmor, 2.5, 1)
	for x = 0, 9 do
		slash(5,5,true,"Round","Add","Out",rarmor.CFrame*CFrame.new(0,0,0)*CFrame.Angles(0,0,0),vt(0.05,0.01,0.05),0.05,BrickColor.new("White"))
		CFuncs["Sound"].Create("rbxassetid://200633108", rarmor, 2, 1.05)
		CFuncs["Sound"].Create("rbxassetid://234365573", rarmor, 2.5, 1.025)
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(5,math.random(4,25)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),0.75,0.75,20,-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			sphereMK(5,math.random(1,15)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-25,25)),math.rad(math.random(-25,25)),math.rad(math.random(-25,25))),0.75,0.75,20,-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
			sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
			hum.CameraOffset = vt(math.random(-10,10)/100,math.random(-10,10)/100,math.random(-10,10)/100)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0.25,0)*angles(math.rad(0),math.rad(0),math.rad(-60)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-60)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(0),math.rad(0)),.3)
		end
		slash(5,5,true,"Round","Add","Out",rarmor.CFrame*CFrame.new(0,0,0)*CFrame.Angles(0,0,0),vt(0.05,0.01,0.05),0.05,BrickColor.new("White"))
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(5,math.random(4,25)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),0.75,0.75,20,-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			sphereMK(5,math.random(1,15)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-25,25)),math.rad(math.random(-25,25)),math.rad(math.random(-25,25))),0.75,0.75,20,-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
			sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
			hum.CameraOffset = vt(math.random(-10,10)/100,math.random(-10,10)/100,math.random(-10,10)/100)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0.25,0)*angles(math.rad(0),math.rad(0),math.rad(-60)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-60)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(90),math.rad(0)),.3)
		end
		slash(5,5,true,"Round","Add","Out",rarmor.CFrame*CFrame.new(0,0,0)*CFrame.Angles(0,0,0),vt(0.05,0.01,0.05),0.05,BrickColor.new("White"))
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(5,math.random(4,25)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),0.75,0.75,20,-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			sphereMK(5,math.random(1,15)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-25,25)),math.rad(math.random(-25,25)),math.rad(math.random(-25,25))),0.75,0.75,20,-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
			sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
			hum.CameraOffset = vt(math.random(-10,10)/100,math.random(-10,10)/100,math.random(-10,10)/100)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0.25,0)*angles(math.rad(0),math.rad(0),math.rad(-60)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-60)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(180),math.rad(0)),.3)
		end
		slash(5,5,true,"Round","Add","Out",rarmor.CFrame*CFrame.new(0,0,0)*CFrame.Angles(0,0,0),vt(0.05,0.01,0.05),0.05,BrickColor.new("White"))
		for i = 0, 1, 0.6 do
			swait()
			sphereMK(5,math.random(4,25)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),0.75,0.75,20,-0.0075,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color,0)
			sphereMK(5,math.random(1,15)/45,"Add",root.CFrame*CFrame.new(math.random(-15,15),-20,math.random(-15,15))*CFrame.Angles(math.rad(90 + math.random(-25,25)),math.rad(math.random(-25,25)),math.rad(math.random(-25,25))),0.75,0.75,20,-0.0075,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color,0)
			slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
			sphere2(5,"Add",rarmor.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),vt(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
			hum.CameraOffset = vt(math.random(-10,10)/100,math.random(-10,10)/100,math.random(-10,10)/100)
			RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-10)),.2)
			LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(30),math.rad(0)),.2)
			RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0.25,0)*angles(math.rad(0),math.rad(0),math.rad(-60)),.3)
			pcall(function()
				Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(60)),.3)
			end)
			RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(80)),.3)
			LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(-60)),.3)
			weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(270),math.rad(0)),.3)
		end
	end
	local hitb = CreateParta(m,1,1,"SmoothPlastic",BrickColor.Random())
	hitb.Anchored = true
	hitb.CFrame = root.CFrame + root.CFrame.lookVector*8
	hitb.CFrame = hitb.CFrame*CFrame.new(0,1,0)
	MagniDamage(hitb, 8, 92,158, 0, "Normal",153092213)
	sphere2(5,"Add",hitb.CFrame,vt(2.1,2.1,2),-0.02,-0.02,5,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
	sphere2(5,"Add",hitb.CFrame,vt(2,2,2),-0.02,-0.02,4,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	for i = 0, 24 do
		slash(math.random(20,100)/10,5,true,"Round","Add","Out",hitb.CFrame*CFrame.new(0,0,math.random(-60,60))*CFrame.Angles(math.rad(90),0,0),vt(0.01,0.01,0.01),math.random(10,100)/1000,BrickColor.new("White"))
	end
	CFuncs["Sound"].Create("rbxassetid://313205954", root, 4,1)
	CFuncs["Sound"].Create("rbxassetid://1368637781", rarmor, 4,1)
	CFuncs["Sound"].Create("rbxassetid://763718160", rarmor, 5, 1.1)
	CFuncs["Sound"].Create("rbxassetid://782353443", rarmor, 6, 1)
	--CFuncs["Sound"].Create("rbxassetid://1548538202", rarmor, 4,1)
	for i = 0, 2, 0.1 do
		swait()
		MagniDamage(hitb, 8, 92,158, 0, "Normal",153092213)
		hum.CameraOffset = vt(math.random(-10,10)/25,math.random(-10,10)/25,math.random(-10,10)/25)
		RH.C0=clerp(RH.C0,cf(1,-1,0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(-20),math.rad(-10)),.9)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(0)),.9)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.5,0)*angles(math.rad(0),math.rad(0),math.rad(80)),.9)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(-80)),.9)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(90),math.rad(0),math.rad(70)),.9)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-60)),.9)
		weaponweld.C1=clerp(weaponweld.C1,cf(2,0,0)*angles(math.rad(90),math.rad(0),math.rad(-90)),.9)
	end
	hum.CameraOffset = vt(0,0,0)
	hitb:Destroy()
	attack = false
	hum.WalkSpeed = 24
	hum.JumpPower = 50
end

function superjump()
	attack = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0
	wng1a.Transparency = wng1a.Transparency - 1
	wng1b.Transparency = wng1b.Transparency - 1
	wng2a.Transparency = wng2a.Transparency - 1
	wng2b.Transparency = wng2b.Transparency - 1
	sphere2(5,"Add",root.CFrame,vt(1,1,1),1.5,1.5,1.5,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
	sphere2(5,"Add",root.CFrame,vt(1,1,1),1,1,1,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	CFuncs["Sound"].Create("rbxassetid://1368637781", root, 7.5, 1)
	for i = 0, 2, 0.1 do
		swait()
		hum.CameraOffset = vt(math.random(-10,10)/100,math.random(-10,10)/100,math.random(-10,10)/100)
		root.Velocity = vt(0,0,0)
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-360,360)),math.rad(math.random(-5,5))),vt(0.05,0.01,0.05),math.random(25,250)/250,BrickColor.new("White"))
		RH.C0=clerp(RH.C0,cf(1,-0.45,-0.45)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(20)),.4)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(40)),.4)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.5,-1)*angles(math.rad(20),math.rad(0),math.rad(0)),.4)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(4),math.rad(0),math.rad(0)),.4)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(40)),.4)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(10),math.rad(0),math.rad(-40)),.4)
	end
	CFuncs["Sound"].Create("rbxassetid://477843807", root, 7, 1.05)
	local lat1 = Instance.new("Attachment",larm)
	lat1.Position = Vector3.new(1,-1,0.5)
	local lat2 = Instance.new("Attachment",larm)
	lat2.Position = Vector3.new(-1,-1,-0.5)
	local rat1 = Instance.new("Attachment",rarm)
	rat1.Position = Vector3.new(1,-1,-0.5)
	local rat2 = Instance.new("Attachment",rarm)
	rat2.Position = Vector3.new(-1,-1,0.5)
	local tl1 = Instance.new('Trail',larm)
	tl1.Attachment0 = lat1
	tl1.Attachment1 = lat2
	tl1.Texture = "http://www.roblox.com/asset/?id=1049219073"
	tl1.LightEmission = 1
	tl1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(0.05, 0),NumberSequenceKeypoint.new(1, 1)})
	tl1.Color = ColorSequence.new(BrickColor.new('Royal purple').Color,BrickColor.new('Cyan').Color)
	tl1.Lifetime = 5
	local tl2 = tl1:Clone()
	tl2.Attachment0 = rat1
	tl2.Attachment1 = rat2
	tl2.Parent = rarm
	hum.JumpPower = 50
	hum.Jump = true
	swait()
	hum.JumpPower = 0
	root.Velocity = vt(0,250,0) + root.CFrame.lookVector*250
	sphere2(5,"Add",root.CFrame*CFrame.Angles(math.rad(-45),0,0),vt(25,1,25),0.3,5,0.3,BrickColor.new("Royal purple"),BrickColor.new("Royal purple").Color)
	sphere2(5,"Add",root.CFrame*CFrame.Angles(math.rad(-45),0,0),vt(25,1,25),0.2,4,0.2,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
	for i = 0, 49 do
		waveEff(math.random(10,100)/10,"Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),vt(15,0.25,15),math.random(25,250)/250,0.25,BrickColor.new("White"))
		slash(math.random(10,100)/10,3,true,"Round","Add","Out",root.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),vt(0.01,0.01,0.01),math.random(50,500)/250,BrickColor.new("White"))
	end
	coroutine.resume(coroutine.create(function()
		for i = 0, 2, 0.1 do
			swait()
			hum.CameraOffset = vt(math.random(-10,10)/50,math.random(-10,10)/50,math.random(-10,10)/50)
		end
		hum.CameraOffset = vt(0,0,0)
		wait(3)
		tl1.Enabled = false
		tl2.Enabled = false
		game:GetService("Debris"):AddItem(tl1, 5)
		game:GetService("Debris"):AddItem(tl2, 5)
		game:GetService("Debris"):AddItem(rat1, 5)
		game:GetService("Debris"):AddItem(rat2, 5)
		game:GetService("Debris"):AddItem(lat1, 5)
		game:GetService("Debris"):AddItem(lat2, 5)
	end))
	CFuncs["Sound"].Create("rbxassetid://1295446488", root, 10, 1)
	for i = 0, 3, 0.1 do
		swait()
		RH.C0=clerp(RH.C0,cf(1,-0.45,-0.45)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(-20)),.4)
		LH.C0=clerp(LH.C0,cf(-1,-1,0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3),math.rad(0),math.rad(30)),.4)
		RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.75,0)*angles(math.rad(40),math.rad(0),math.rad(0)),.4)
		pcall(function()
			Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(-20),math.rad(0),math.rad(0)),.4)
		end)
		RW.C0=clerp(RW.C0,cf(1.45,0.5,0.1)*angles(math.rad(-30),math.rad(0),math.rad(20)),.4)
		LW.C0=clerp(LW.C0,cf(-1.45,0.5,0.1)*angles(math.rad(-30),math.rad(0),math.rad(-20)),.4)
	end
	coroutine.resume(coroutine.create(function()
		for i = 0, 99 do
			swait()
			wng1a.Transparency = wng1a.Transparency + 0.01
			wng1b.Transparency = wng1b.Transparency + 0.01
			wng2a.Transparency = wng2a.Transparency + 0.01
			wng2b.Transparency = wng2b.Transparency + 0.01
		end
	end))
	attack = false
	if equipped == false then
		hum.WalkSpeed = 16
	else
		hum.WalkSpeed = 24
	end
	hum.JumpPower = 50
end
------------------


local attacktype = 1
mouse.Button1Down:connect(function()
	if equipped == true then
		if attack == false and attacktype == 1 then
			attacktype = 2
			attackone()
		elseif attack == false and attacktype == 2 then
			attacktype = 3
			attacktwo()
		elseif attack == false and attacktype == 3 then
			attacktype = 1
			attackthree()
  --[[elseif attack == false and attacktype == 4 then
    attacktype = 1
    --attackfour()]]--
		end
	end
end)
mouse.KeyDown:connect(function(k)
	if k == "f" and attack == false and equipped == false then
		equip()
	elseif k == "f" and attack == false and equipped == true then
		unequip()
	end
	if k == "r" and attack == false then
		superjump()
	end
	if equipped == true then
		if k == "z" and attack == false then
			spinnyblade()
		end
		if k == "x" and attack == false then
			eightbitmegablade()
		end
		if k == "c" and attack == false then
			bladespinagain()
		end
	end
	if k == "l" and muter == false then
		muter = true
		kan.Volume = 0
	elseif k == "l" and muter == true then
		muter = false
		kan.Volume = 1.25
	end
end)
plr.Chatted:connect(function(message)
	if message:sub(1,3) == "id/" then
		ORGID = message:sub(4)
		kan.TimePosition = 0
		kan:Play()
	elseif message:sub(1,6) == "pitch/" then
		ORPIT = message:sub(7)
	elseif message:sub(1,4) == "vol/" then
		ORVOL = message:sub(5)
	elseif message:sub(1,7) == "skipto/" then
		kan.TimePosition = message:sub(8)
	end
end)

idleanim=.4
while true do
	swait()
	if muter == false then
		kan.Volume = ORVOL
	else
		kan.Volume = 0
	end
	kan.PlaybackSpeed = ORPIT
	kan.Pitch = ORPIT
	kan.SoundId = "rbxassetid://" ..ORGID
	kan.Looped = true
	kan:Resume()
	techc.Rotation = techc.Rotation + 0.1
	imgl2.Rotation = imgl2.Rotation - kan.PlaybackLoudness/50
	imgl2.ImageColor3 = Color3.new(0.15 + kan.PlaybackLoudness/2500,0,0.6 + kan.PlaybackLoudness/1000)
	imgl2b.Rotation = imgl2b.Rotation + kan.PlaybackLoudness/25
	imgl2b.ImageColor3 = Color3.new(0,0.3 + kan.PlaybackLoudness/1500,0.6 + kan.PlaybackLoudness/1000)
	ned.Rotation = 0 - 2 * math.cos(sine / 24)
	ned.Position = UDim2.new(0.6,0 - 10 * math.cos(sine / 32),0.8,0 - 10 * math.cos(sine / 45))
	sine = sine + change
	local torvel=(RootPart.Velocity*Vector3.new(1,0,1)).magnitude 
	local velderp=RootPart.Velocity.y
	hitfloor,posfloor=rayCast(RootPart.Position,(CFrame.new(RootPart.Position,RootPart.Position - Vector3.new(0,1,0))).lookVector,4,Character)
	if equipped==true or equipped==false then
		if attack==false then
			idle=idle+1
		else
			idle=0
		end
		if idle>=500 then
			if attack==false then
				--Sheath()
			end
		end
		if RootPart.Velocity.y > 1 and hitfloor==nil then 
			Anim="Jump"
			if attack==false then
				RH.C0=clerp(RH.C0,cf(1,-0.35 - 0.05 * math.cos(sine / 25),-0.75)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-5),math.rad(0),math.rad(-20)),.1)
				LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-5),math.rad(0),math.rad(20)),.1)
				RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0 + 0.05 * math.cos(sine / 25))*angles(math.rad(-tors.Velocity.Y/6),math.rad(0),math.rad(0)),.1)
				pcall(function()
					Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(-2.5),math.rad(0),math.rad(0)),.1)
				end)
				RW.C0=clerp(RW.C0,cf(1.45,0.5 + 0.1 * math.cos(sine / 25),0)*angles(math.rad(-5),math.rad(0),math.rad(25)),.1)
				LW.C0=clerp(LW.C0,cf(-1.45,0.5 + 0.1 * math.cos(sine / 25),0)*angles(math.rad(-5),math.rad(0),math.rad(-25)),.1)
				if equipped == false then
					weaponweld.C1=clerp(weaponweld.C1,cf(-3,0,-0.5)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
				else
					weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
				end
			end
		elseif RootPart.Velocity.y < -1 and hitfloor==nil then 
			Anim="Fall"
			if attack==false then
				RH.C0=clerp(RH.C0,cf(1,-0.35 - 0.05 * math.cos(sine / 25),-0.75)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-5),math.rad(0),math.rad(-20)),.1)
				LH.C0=clerp(LH.C0,cf(-1,-1 - 0.05 * math.cos(sine / 25),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-5),math.rad(0),math.rad(20)),.1)
				RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,0,0 + 0.05 * math.cos(sine / 25))*angles(math.rad(-tors.Velocity.Y/6),math.rad(0),math.rad(0)),.1)
				pcall(function()
					Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2.5),math.rad(0),math.rad(0)),.1)
				end)
				RW.C0=clerp(RW.C0,cf(1.45,0.5 + 0.1 * math.cos(sine / 25),0)*angles(math.rad(-15),math.rad(0),math.rad(55)),.1)
				LW.C0=clerp(LW.C0,cf(-1.45,0.5 + 0.1 * math.cos(sine / 25),0)*angles(math.rad(-15),math.rad(0),math.rad(-55)),.1)
				if equipped == false then
					weaponweld.C1=clerp(weaponweld.C1,cf(-3,0,-0.5)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
				else
					weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
				end
			end
		elseif torvel<1 and hitfloor~=nil then
			Anim="Idle"
			if attack==false then
				pcall(function()
					if equipped == false then
						RH.C0=clerp(RH.C0,cf(1,-1 + 0.05 * math.cos(sine / 20)  - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3 + 2 * math.cos(sine / 40)),math.rad(-15),math.rad(0 + 2 * math.cos(sine / 20))),.1)
						LH.C0=clerp(LH.C0,cf(-1,-1 + 0.05 * math.cos(sine / 20) - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3 - 2 * math.cos(sine / 40)),math.rad(1),math.rad(0 - 2 * math.cos(sine / 20))),.1)
						RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0 + 0.02 * math.cos(sine / 40),0 - 0.02 * math.cos(sine / 40),-0.05 - 0.05 * math.cos(sine / 20))*angles(math.rad(0 + 2 * math.cos(sine / 20)),math.rad(0 + 2 * math.cos(sine / 40)),math.rad(30 + 3 * math.cos(sine / 40))),.1)
						Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(2),math.rad(0 - 7 * math.cos(sine / 40)),math.rad(-30 - 3 * math.cos(sine / 40))),.1)
						RW.C0=clerp(RW.C0,cf(1.45,0.5 + 0.05 * math.cos(sine / 28),0.1)*angles(math.rad(-6 + 5 * math.cos(sine / 26)),math.rad(-10 - 6 * math.cos(sine / 24)),math.rad(13 - 5 * math.cos(sine / 34))),.1)
						LW.C0=clerp(LW.C0,cf(-1.4,0.5 + 0.05 * math.cos(sine / 28),0.1)*angles(math.rad(-13 - 1 * math.cos(sine / 25)),math.rad(10 + 2 * math.cos(sine / 24)),math.rad(10 + 2 * math.cos(sine / 34))),.1)
						weaponweld.C1=clerp(weaponweld.C1,cf(-3,0,-0.5)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
					else
						RH.C0=clerp(RH.C0,cf(1,-1 + 0.05 * math.cos(sine / 20)  - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(-3 + 2 * math.cos(sine / 40)),math.rad(0 - 6 * math.cos(sine / 40)),math.rad(-6 + 2 * math.cos(sine / 20) - 6 * math.cos(sine / 40))),.1)
						LH.C0=clerp(LH.C0,cf(-1,-1 + 0.05 * math.cos(sine / 20) - 0.02 * math.cos(sine / 40),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(-3 - 2 * math.cos(sine / 40)),math.rad(10 - 6 * math.cos(sine / 40)),math.rad(3 - 2 * math.cos(sine / 20) - 3 * math.cos(sine / 40))),.1)
						RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0 + 0.02 * math.cos(sine / 40),0 - 0.06 * math.cos(sine / 40),-0.05 - 0.05 * math.cos(sine / 20))*angles(math.rad(0 + 2 * math.cos(sine / 20)),math.rad(0 + 2 * math.cos(sine / 40)),math.rad(-20 + 6 * math.cos(sine / 40))),.1)
						Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(6),math.rad(0 - 2 * math.cos(sine / 42)),math.rad(20 - 6 * math.cos(sine / 40))),.1)
						RW.C0=clerp(RW.C0,cf(1.45,0.5 + 0.05 * math.cos(sine / 28),0.1)*angles(math.rad(-13 + 3 * math.cos(sine / 26)),math.rad(-20 - 3 * math.cos(sine / 24)),math.rad(20 - 5 * math.cos(sine / 34))),.1)
						LW.C0=clerp(LW.C0,cf(-1.45,0.5 + 0.05 * math.cos(sine / 28),0.1)*angles(math.rad(-13 - 3 * math.cos(sine / 25)),math.rad(10 + 3 * math.cos(sine / 24)),math.rad(-10 + 5 * math.cos(sine / 34))),.1)
						weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(130),math.rad(0)),.3)
					end
				end)
			end
		elseif torvel>2 and torvel<42 and hitfloor~=nil then
			Anim="Walk"
			if attack==false then
				pcall(function()
					if equipped == false then
						RH.C0=clerp(RH.C0,cf(1,-1 + 0.05 * math.cos(sine / 4),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(sine / 8)),math.rad(0 + 45 * math.cos(sine / 8))),.1)
						LH.C0=clerp(LH.C0,cf(-1,-1 + 0.05 * math.cos(sine / 4),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(sine / 8)),math.rad(0 + 45 * math.cos(sine / 8))),.1)
						RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.05,-0.05 + 0.05 * math.cos(sine / 4))*angles(math.rad(5 + 3 * math.cos(sine / 4)),math.rad(0 + root.RotVelocity.Y/1.5),math.rad(0 - root.RotVelocity.Y - 10 * math.cos(sine / 8))),.1)
						Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(-5 - 5 * math.cos(sine / 4)),math.rad(0 + root.RotVelocity.Y/1.5),math.rad(0 - hed.RotVelocity.Y*1.5 + 10 * math.cos(sine / 8))),.1)
						RW.C0=clerp(RW.C0,cf(1.5,0.5,0 + 0.25 * math.cos(sine / 8))*angles(math.rad(0 - 50 * math.cos(sine / 8)),math.rad(0),math.rad(5 - 10 * math.cos(sine / 4))),.1)
						LW.C0=clerp(LW.C0,cf(-1.5,0.5,0 - 0.25 * math.cos(sine / 8))*angles(math.rad(0 + 50 * math.cos(sine / 8)),math.rad(0),math.rad(-5 + 10 * math.cos(sine / 4))),.1)
						weaponweld.C1=clerp(weaponweld.C1,cf(-3,0,-0.5)*angles(math.rad(0),math.rad(0),math.rad(-40)),.3)
					else
						RH.C0=clerp(RH.C0,cf(1,-1 + 0.05 * math.cos(sine / 4),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(sine / 8)),math.rad(0 + 60 * math.cos(sine / 8))),.1)
						LH.C0=clerp(LH.C0,cf(-1,-1 + 0.05 * math.cos(sine / 4),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(0),math.rad(0 + 5 * math.cos(sine / 8)),math.rad(0 + 60 * math.cos(sine / 8))),.1)
						RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.05,0 + 0.15 * math.cos(sine / 4))*angles(math.rad(10 - 3 * math.cos(sine / 4)),math.rad(0 + root.RotVelocity.Y/1.5),math.rad(-10 - root.RotVelocity.Y - 5 * math.cos(sine / 8))),.1)
						Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(5 + 3 * math.cos(sine / 4)),math.rad(0 + root.RotVelocity.Y/1.5 + 3 * math.cos(sine / 57)),math.rad(10 - hed.RotVelocity.Y*1.5 + 5 * math.cos(sine / 8))),.1)
						RW.C0=clerp(RW.C0,cf(1.5,0.5,0 + 0.25 * math.cos(sine / 8))*angles(math.rad(-10),math.rad(0),math.rad(15 - 2 * math.cos(sine / 34))),.1)
						LW.C0=clerp(LW.C0,cf(-1.5,0.5,0 - 0.25 * math.cos(sine / 8))*angles(math.rad(0 + 50 * math.cos(sine / 8)),math.rad(0),math.rad(-5 + 10 * math.cos(sine / 4))),.1)
						weaponweld.C1=clerp(weaponweld.C1,cf(0,1,0)*angles(math.rad(0),math.rad(120 + 5 * math.cos(sine / 35)),math.rad(0)),.3)
					end
				end)
			end
		elseif torvel>=42 and hitfloor~=nil then
			Anim="Run"
			if attack==false then
				pcall(function()
					RH.C0=clerp(RH.C0,cf(1,-1 - 0.15 * math.cos(sine / 3),0)*angles(math.rad(0),math.rad(90),math.rad(0))*angles(math.rad(0),math.rad(0),math.rad(0 + 85 * math.cos(sine / 6))),.1)
					LH.C0=clerp(LH.C0,cf(-1,-1 - 0.15 * math.cos(sine / 3),0)*angles(math.rad(0),math.rad(-90),math.rad(0))*angles(math.rad(0),math.rad(0),math.rad(0 + 85 * math.cos(sine / 6))),.1)
					RootJoint.C0=clerp(RootJoint.C0,RootCF*cf(0,-0.3,-0.05 + 0.15 * math.cos(sine / 3))*angles(math.rad(15 - 4 * math.cos(sine / 3)),math.rad(0 + root.RotVelocity.Y*1.5),math.rad(0 - root.RotVelocity.Y - 10 * math.cos(sine / 6))),.1)
					Torso.Neck.C0=clerp(Torso.Neck.C0,necko*angles(math.rad(-2.5 + 4 * math.cos(sine / 3)),math.rad(0 + root.RotVelocity.Y*1.5),math.rad(0 - hed.RotVelocity.Y*1.5 + 10 * math.cos(sine / 6))),.1)
					RW.C0=clerp(RW.C0,cf(1.5,0.5,0 + 0.5 * math.cos(sine / 6))*angles(math.rad(0 - 140 * math.cos(sine / 6)),math.rad(0),math.rad(5 - 20 * math.cos(sine / 3))),.1)
					LW.C0=clerp(LW.C0,cf(-1.5,0.5,0 - 0.5 * math.cos(sine / 6))*angles(math.rad(0 + 140 * math.cos(sine / 6)),math.rad(0),math.rad(-5 + 20 * math.cos(sine / 3))),.1)
				end)
			end
		end
	end
end
