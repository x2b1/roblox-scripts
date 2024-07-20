--[[
    >rinichi >> did 50% of the work
    >weda >> did 50% of the work

    >fixed by desktop
]]
--[[
if getgenv().azureloaded then
    return
end

getgenv().azureloaded = true]]

local loadtick = tick()

repeat 
    wait()
until game:IsLoaded()

game:GetService("StarterGui"):SetCore("SendNotification",{Title = "azure (temporary notif)",Text = "loading",Duration = 3.6})

local gamerawmetatable = getrawmetatable(game)
setreadonly(gamerawmetatable, false)

old__namecall1 = gamerawmetatable.__namecall;gamerawmetatable.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(args[1]) == "TeleportDetect" then
        return
    elseif tostring(args[1]) == "CHECKER_1" then
        return
    elseif tostring(args[1]) == "CHECKER" then
        return
    elseif tostring(args[1]) == "GUI_CHECK" then
        return
    elseif tostring(args[1]) == "OneMoreTime" then
        return
    elseif tostring(args[1]) == "checkingSPEED" then
        return
    elseif tostring(args[1]) == "BANREMOTE" then
        return
    elseif tostring(args[1]) == "PERMAIDBAN" then
        return
    elseif tostring(args[1]) == "KICKREMOTE" then
        return
    elseif tostring(args[1]) == "BR_KICKPC" then
        return
    elseif tostring(args[1]) == "BR_KICKMOBILE" then
        return
    end
    return old__namecall1(self, ...)
end)

function retlibrary()

-- // Variables
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local hs = game:GetService("HttpService")
local plrs = game:GetService("Players")
local stats = game:GetService("Stats")
-- UI Variables
getgenv().library = {
    drawings = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    changed = {},
    ended = {},
    colors = {},
    folders = {
        main = "azure",
        assets = "azure/assets",
        configs = "azure/configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
--
for i,v in pairs(library.folders) do
    makefolder(v)
end
--
local utility = {}
local pages = {}
local sections = {}
local theme = {
    accent = Color3.fromRGB(168,122,207),
    lightcontrast = Color3.fromRGB(30, 30, 30),
    darkcontrast = Color3.fromRGB(25, 25, 25),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textborder = Color3.fromRGB(0, 0, 0),
    indevcolor = Color3.fromRGB(164, 219, 232),
    font = Drawing.Fonts.Plex,
    textsize = 13
}
-- // Utility Functions
do
    function utility:Size(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = xScale*instance.Size.x+xOffset
            local y = yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:Position(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = instance.Position.x+xScale*instance.Size.x+xOffset
            local y = instance.Position.y+yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:CreateInstance(instanceType, properties)
        local instance = Instance.new(instanceType)
        if type(properties) == "table" then
            for property, value in next, properties do
                instance[property] = value
            end
        end
        return instance
    end
    --
	function utility:Create(instanceType, instanceOffset, instanceProperties, instanceParent)
        local instanceType = instanceType or "Frame"
        local instanceOffset = instanceOffset or {Vector2.new(0,0)}
        local instanceProperties = instanceProperties or {}
        local instanceHidden = false
        local instance = nil
        --
		if instanceType == "Frame" or instanceType == "frame" then
            local frame = Drawing.new("Square")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.Size = Vector2.new(100,100)
            frame.Position = Vector2.new(0,0)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "TextLabel" or instanceType == "textlabel" then
            local text = Drawing.new("Text")
            text.Font = 3
            text.Visible = true
            text.Outline = true
            text.Center = false
            text.Color = Color3.fromRGB(255,255,255)
            text.ZIndex = 1000
            text.Transparency = library.shared.initialized and 1 or 0
            instance = text
        elseif instanceType == "Triangle" or instanceType == "triangle" then
            local frame = Drawing.new("Triangle")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "Image" or instanceType == "image" then
            local image = Drawing.new("Image")
            image.Size = Vector2.new(12,19)
            image.Position = Vector2.new(0,0)
            image.Visible = true
            image.ZIndex = 1000
            image.Transparency = library.shared.initialized and 1 or 0
            instance = image
        elseif instanceType == "Circle" or instanceType == "circle" then
            local circle = Drawing.new("Circle")
            circle.Visible = false
            circle.Color = Color3.fromRGB(255, 0, 0)
            circle.Thickness = 1
            circle.NumSides = 30
            circle.Filled = true
            circle.Transparency = 1
            circle.ZIndex = 1000
            circle.Radius = 50
            circle.Transparency = library.shared.initialized and 1 or 0
            instance = circle
        elseif instanceType == "Quad" or instanceType == "quad" then
            local quad = Drawing.new("Quad")
            quad.Visible = false
            quad.Color = Color3.fromRGB(255, 255, 255)
            quad.Thickness = 1.5
            quad.Transparency = 1
            quad.ZIndex = 1000
            quad.Filled = false
            quad.Transparency = library.shared.initialized and 1 or 0
            instance = quad
        elseif instanceType == "Line" or instanceType == "line" then
            local line = Drawing.new("Line")
            line.Visible = false
            line.Color = Color3.fromRGB(255, 255, 255)
            line.Thickness = 1.5
            line.Transparency = 1
            line.Thickness = 1.5
            line.ZIndex = 1000
            line.Transparency = library.shared.initialized and 1 or 0
            instance = line
        end
        --
        if instance then
            for i, v in pairs(instanceProperties) do
                if (i == "Hidden" or i == "hidden") then
                    instanceHidden = v
                else
                    if library.shared.initialized then
                        instance[i] = v
                    elseif i ~= "Transparency" then
                        instance[i] = v
                    end
                end
                --[[if typeof(v) == "Color3" then
                    local found_theme = utility:Find(theme, v)
                    if found_theme then
                        themes[found_theme] = themes[found_theme] or {}
                        themes[found_theme][i] = themes[found_theme][i]
                        table.insert(themes[found_theme][i], instance)
                    end
                end]]
            end
            --
            if not instanceHidden then
                library.drawings[#library.drawings + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            else
                library.hidden[#library.hidden + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            end
            --
            if instanceParent then
                instanceParent[#instanceParent + 1] = instance
            end
            --
            return instance
        end
	end
    --
    function utility:UpdateOffset(instance, instanceOffset)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[2] = instanceOffset
                return
            end
        end
    end
    --
    function utility:UpdateTransparency(instance, instanceTransparency)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[3] = instanceTransparency
                return
            end
        end
    end
    --
    function utility:Remove(instance, hidden)
        library.colors[instance] = nil
        --
        local ind = 0
        --
        for i,v in pairs(hidden and library.hidden or library.drawings) do
            if v[1] == instance then
                v[1] = nil
                v[2] = nil
                table.remove(hidden and library.hidden or library.drawings, i)
                break
            end
        end
        instance:Remove()
    end
    --
    function utility:GetSubPrefix(str)
        local str = tostring(str):gsub(" ","")
        local var = ""
        --
        if #str == 2 then
            local sec = string.sub(str,#str,#str+1)
            var = sec == "1" and "st" or sec == "2" and "nd" or sec == "3" and "rd" or "th"
        end
        --
        return var
    end
    --
    function utility:Connection(connectionType, connectionCallback)
        local connection = connectionType:Connect(connectionCallback)
        library.connections[#library.connections + 1] = connection
        --
        return connection
    end
    --
    function utility:Disconnect(connection)
        for i,v in pairs(library.connections) do
            if v == connection then
                library.connections[i] = nil
                v:Disconnect()
            end
        end
    end
    --
    function utility:MouseLocation()
        return uis:GetMouseLocation()
    end
    --
    function utility:MouseOverDrawing(values, valuesAdd)
        local valuesAdd = valuesAdd or {}
        local values = {
            (values[1] or 0) + (valuesAdd[1] or 0),
            (values[2] or 0) + (valuesAdd[2] or 0),
            (values[3] or 0) + (valuesAdd[3] or 0),
            (values[4] or 0) + (valuesAdd[4] or 0)
        }
        --
        local mouseLocation = utility:MouseLocation()
	    return (mouseLocation.x >= values[1] and mouseLocation.x <= (values[1] + (values[3] - values[1]))) and (mouseLocation.y >= values[2] and mouseLocation.y <= (values[2] + (values[4] - values[2])))
    end
    --
    function utility:GetTextBounds(text, textSize, font)
        local textbounds = Vector2.new(0, 0)
        --
        local textlabel = utility:Create("TextLabel", {Vector2.new(0, 0)}, {
            Text = text,
            Size = textSize,
            Font = font,
            Hidden = true
        })
        --
        textbounds = textlabel.TextBounds
        utility:Remove(textlabel, true)
        --
        return textbounds
    end
    --
    function utility:GetScreenSize()
        return ws.CurrentCamera.ViewportSize
    end
    --
    function utility:LoadImage(instance, imageName, imageLink)
        local data
        --
        if isfile(library.folders.assets.."/"..imageName..".png") then
            data = readfile(library.folders.assets.."/"..imageName..".png")
        else
            if imageLink then
                data = game:HttpGet(imageLink)
                writefile(library.folders.assets.."/"..imageName..".png", data)
            else
                return
            end
        end
        --
        if data and instance then
            instance.Data = data
        end
    end
    --
    function utility:Lerp(instance, instanceTo, instanceTime)
        local currentTime = 0
        local currentIndex = {}
        local connection
        --
        for i,v in pairs(instanceTo) do
            currentIndex[i] = instance[i]
        end
        --
        local function lerp()
            for i,v in pairs(instanceTo) do
                instance[i] = ((v - currentIndex[i]) * currentTime / instanceTime) + currentIndex[i]
            end
        end
        --
        connection = rs.RenderStepped:Connect(function(delta)
            if currentTime < instanceTime then
                currentTime = currentTime + delta
                lerp()
            else
                connection:Disconnect()
            end
        end)
    end
    --
    function utility:Combine(table1, table2)
        local table3 = {}
        for i,v in pairs(table1) do table3[i] = v end
        local t = #table3
        for z,x in pairs(table2) do table3[z + t] = x end
        return table3
    end
    --
    function utility:WrapText(Text, Size)
        local Max = (Size / 7)
        --
        return Text:sub(0, Max)
    end
end
--// desktop fixed this btw
-- // Library Functions
do
    library.__index = library
	pages.__index = pages
	sections.__index = sections
    --
    function library:New(info)
		local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "UI Title"
        local size = info.size or info.Size or Vector2.new(550,700)
        local accent = info.accent or info.Accent or info.color or info.Color or theme.accent
        --
        theme.accent = accent
        --
        local window = {pages = {}, unloaded = false, isVisible = false, uibind = Enum.KeyCode.RightShift, currentPage = nil, fading = false, dragging = false, drag = Vector2.new(0,0), currentContent = {frame = nil, dropdown = nil, multibox = nil, colorpicker = nil, keybind = nil}}
        --
        local main_frame = utility:Create("Frame", {Vector2.new(0,0)}, {
            Size = utility:Size(0, size.X, 0, size.Y),
            Position = utility:Position(0.5, -(size.X/2) ,0.5, -(size.Y/2)),
            Color = theme.outline
        });window["main_frame"] = main_frame
        --
        library.colors[main_frame] = {
            Color = "outline"
        }
        --
        local frame_inline = utility:Create("Frame", {Vector2.new(1,1), main_frame}, {
            Size = utility:Size(1, -2, 1, -2, main_frame),
            Position = utility:Position(0, 1, 0, 1, main_frame),
            Color = theme.lightcontrast
        })
        --
        library.colors[frame_inline] = {
            Color = "lightcontrast"
        }
        --
        local inner_frame = utility:Create("Frame", {Vector2.new(1,1), frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, frame_inline),
            Position = utility:Position(0, 1, 0, 1, frame_inline),
            Color = theme.lightcontrast
        })
        --
        library.colors[inner_frame] = {
            Color = "lightcontrast"
        }
        --
        local title = utility:Create("TextLabel", {Vector2.new(4,2), inner_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, 2, inner_frame)
        })
        --
        library.colors[title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local inner_frame_inline = utility:Create("Frame", {Vector2.new(4,18), inner_frame}, {
            Size = utility:Size(1, -8, 1, -22, inner_frame),
            Position = utility:Position(0, 4, 0, 18, inner_frame),
            Color = theme.inline
        })
        --
        library.colors[inner_frame_inline] = {
            Color = "inline"
        }
        --
        local inner_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline),
            Color = theme.outline
        })
        --
        library.colors[inner_frame_inline2] = {
            Color = "outline"
        }
        --
        local back_frame = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline2),
            Color = theme.darkcontrast
        });window["back_frame"] = back_frame
        --
        library.colors[back_frame] = {
            Color = "darkcontrast"
        }
        --
        local tab_frame_inline = utility:Create("Frame", {Vector2.new(4,24), back_frame}, {
            Size = utility:Size(1, -8, 1, -28, back_frame),
            Position = utility:Position(0, 4, 0, 24, back_frame),
            Color = theme.outline
        })
        --
        library.colors[tab_frame_inline] = {
            Color = "outline"
        }
        --
        local tab_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline),
            Color = theme.inline
        })
        --
        library.colors[tab_frame_inline2] = {
            Color = "inline"
        }
        --
        local tab_frame = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline2),
            Color = theme.lightcontrast
        });window["tab_frame"] = tab_frame
        --
        library.colors[tab_frame] = {
            Color = "lightcontrast"
        }
        --
        function window:GetConfig()
            local config = {}
            --
            if not pcall(function()
                for i,v in pairs(library.pointers) do
                    if type(v:get()) == "table" and v:get().Transparency then
                        local hue, sat, val = v:get().Color:ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v:get().Transparency}
                    elseif v.keybindname then
                        local key, mode = v:get(), v.mode
                        config[i] = {Key = key, Mode = mode}
                    elseif typeof(v:get()) == "Color3" then
                        local hue, sat, val = v:get():ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v.current[4] or 1}
                    else
                        config[i] = v:get()
                    end
                end
            end) then
            end
            --
            return hs:JSONEncode(config)
        end
        --
        function window:ChangeUIBind(new_uibind)
            window.uibind = new_uibind
        end
        --
        function window:Retitle(new_name)
            title.Text = new_name
            name = new_name
        end
        --
        function window:LoadConfig(config)
            local config = hs:JSONDecode(config)
            --
            for i,v in next, config do
                if library.pointers[i] then
                    library.pointers[i]:set(v)
                end
            end
        end
        --
        function window:Move(vector)
            for i,v in pairs(library.drawings) do
                if v[2][2] then
                    v[1].Position = utility:Position(0, v[2][1].X, 0, v[2][1].Y, v[2][2])
                else
                    v[1].Position = utility:Position(0, vector.X, 0, vector.Y)
                end
            end
        end
        --
        function window:CloseContent()
            if window.currentContent.dropdown and window.currentContent.dropdown.open then
                local dropdown = window.currentContent.dropdown
                dropdown.open = not dropdown.open
                utility:LoadImage(dropdown.dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(dropdown.holder.drawings) do
                    utility:Remove(v)
                end
                --
                dropdown.holder.drawings = {}
                dropdown.holder.buttons = {}
                dropdown.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.dropdown = nil
            elseif window.currentContent.multibox and window.currentContent.multibox.open then
                local multibox = window.currentContent.multibox
                multibox.open = not multibox.open
                utility:LoadImage(multibox.multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(multibox.holder.drawings) do
                    utility:Remove(v)
                end
                --
                multibox.holder.drawings = {}
                multibox.holder.buttons = {}
                multibox.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.multibox = nil
            elseif window.currentContent.colorpicker and window.currentContent.colorpicker.open then
                local colorpicker = window.currentContent.colorpicker
                colorpicker.open = not colorpicker.open
                --
                for i,v in pairs(colorpicker.holder.drawings) do
                    utility:Remove(v)
                end
                --
                colorpicker.holder.drawings = {}
                --
                window.currentContent.frame = nil
                window.currentContent.colorpicker = nil
            elseif window.currentContent.keybind and window.currentContent.keybind.open then
                local modemenu = window.currentContent.keybind.modemenu
                window.currentContent.keybind.open = not window.currentContent.keybind.open
                --
                for i,v in pairs(modemenu.drawings) do
                    utility:Remove(v)
                end
                --
                modemenu.drawings = {}
                modemenu.buttons = {}
                modemenu.frame = nil
                --
                window.currentContent.frame = nil
                window.currentContent.keybind = nil
            end
        end
        --
        function window:IsOverContent()
            local isOver = false
            --
            if window.currentContent.frame and utility:MouseOverDrawing({window.currentContent.frame.Position.X,window.currentContent.frame.Position.Y,window.currentContent.frame.Position.X + window.currentContent.frame.Size.X,window.currentContent.frame.Position.Y + window.currentContent.frame.Size.Y}) then
                isOver = true
            end
            --
            return isOver
        end
        --
        function window:Unload()
            for i,v in pairs(library.connections) do
                v:Disconnect()
                v = nil
            end
            --
            for i,v in next, library.hidden do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove then
                        local instance = v[1]
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.drawings) do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove then
                        local instance = v[1]
                        v[2] = nil
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.began) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            for i,v in pairs(library.ended) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            library.drawings = nil
            library.hidden = nil
            library.connections = nil
            library.began = nil
            library.ended = nil
            library.changed = nil

            window.unloaded = true
        end
        --
        function window:Watermark(info)
            window.watermark = {visible = false}
            --
            local info = info or {}
            local watermark_name = info.name or info.Name or info.title or info.Title or string.format("$$ Splix || uid : %u || ping : %u || fps : %u", 1, 100, 200)
            --
            local text_bounds = utility:GetTextBounds(watermark_name, theme.textsize, theme.font)
            --
            local watermark_outline = utility:Create("Frame", {Vector2.new(100,38/2-10)}, {
                Size = utility:Size(0, text_bounds.X+20, 0, 21),
                Position = utility:Position(0, 100, 0, 38/2-10),
                Hidden = true,
                ZIndex = 60,
                Color = theme.outline,
                Visible = window.watermark.visible
            })window.watermark.outline = watermark_outline
            library.colors[watermark_outline] = {
                Color = "outline",
            }
            --
            local watermark_inline = utility:Create("Frame", {Vector2.new(1,1), watermark_outline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_outline),
                Position = utility:Position(0, 1, 0, 1, watermark_outline),
                Hidden = true,
                ZIndex = 60,
                Color = theme.inline,
                Visible = window.watermark.visible
            })
            library.colors[watermark_inline] = {
                Color = "inline",
            }
            --
            local watermark_frame = utility:Create("Frame", {Vector2.new(1,1), watermark_inline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_inline),
                Position = utility:Position(0, 1, 0, 1, watermark_inline),
                Hidden = true,
                ZIndex = 60,
                Color = theme.lightcontrast,
                Visible = window.watermark.visible
            })
            library.colors[watermark_frame] = {
                Color = "lightcontrast",
            }
            --
            local watermark_accent = utility:Create("Frame", {Vector2.new(0,0), watermark_frame}, {
                Size = utility:Size(1, 0, 0, 1, watermark_frame),
                Position = utility:Position(0, 0, 0, 0, watermark_frame),
                Hidden = true,
                ZIndex = 60,
                Color = theme.accent,
                Visible = window.watermark.visible
            })
            library.colors[watermark_accent] = {
                Color = "accent",
            }
            --
            local watermark_title = utility:Create("TextLabel", {Vector2.new(2 + 6,4), watermark_outline}, {
                Text = string.format("splix - fps : %u - uid : %u", 35, 2),
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Hidden = true,
                ZIndex = 60,
                Position = utility:Position(0, 2 + 6, 0, 4, watermark_outline),
                Visible = window.watermark.visible
            })
            library.colors[watermark_title] = {
                Color = "textcolor",
                OutlineColor = "textborder"
            }
            --
            function window.watermark:UpdateSize()
                watermark_outline.Size = utility:Size(0, watermark_title.TextBounds.X + 4 + (6*2), 0, 21)
                watermark_inline.Size = utility:Size(1, -2, 1, -2, watermark_outline)
                watermark_frame.Size = utility:Size(1, -2, 1, -2, watermark_inline)
                watermark_accent.Size = utility:Size(1, 0, 0, 1, watermark_frame)
            end
            --
            function window.watermark:Visibility()
                watermark_outline.Visible = window.watermark.visible
                watermark_inline.Visible = window.watermark.visible
                watermark_frame.Visible = window.watermark.visible
                watermark_accent.Visible = window.watermark.visible
                watermark_title.Visible = window.watermark.visible
            end
            --
            function window.watermark:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.watermark.visible = updateValue
                    window.watermark:Visibility()
                end
                if updateType == "Title" then
                    watermark_title.Text = updateValue
                end
            end
            --
            utility:Connection(rs.RenderStepped, function(fps)
                library.shared.fps = math.round(1 / fps)
                library.shared.ping = tonumber(string.split(stats.Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. "")
            end)
            --
            return window.watermark
        end
        --
        function window:NotificationList(info)
            window.notificationlist = {notifications = {}}
            --
            local info = info or {}
            --
            function window.notificationlist:AddNotification(info)
                local info = info or {}
                local text = info.text or "label"
                local lifetime = info.lifetime or 5
                --
                local notification = {pressed = false}
                --
                local notify_outline = utility:Create("Frame", {Vector2.new(0, 0)}, {
                    Size = utility:Size(0, 18 + (7 * #text), 0, 29),
                    Position = utility:Position(0, 10, 0, 3 + (#window.notificationlist.notifications * 35)),
                    Color = theme.outline,
                    ZIndex = 1,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_outline"] = notify_outline
                --
                local notify_inline = utility:Create("Frame", {Vector2.new(1, 1), notify_outline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_outline),
                    Position = utility:Position(0, 1, 0, 1, notify_outline),
                    Color = theme.inline,
                    ZIndex = 2,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_inline"] = notify_inline
                --
                local notify_frame = utility:Create("Frame", {Vector2.new(1, 1), notify_inline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_inline),
                    Position = utility:Position(0, 1, 0, 1, notify_inline),
                    Color = theme.light_contrast,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_frame"] = notify_frame
                --
                local notify_accent = utility:Create("Frame", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(0, 5, 0, 25),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Color = theme.accent,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_accent"] = notify_accent
                --
                local notify_title = utility:Create("TextLabel", {Vector2.new(8, 5), notify_frame}, {
                    Size = 13,
                    Position = utility:Position(0, 10, 0, 5, notify_frame),
                    Font = Drawing.Fonts.Plex,
                    Color = theme.accent,
                    Outline = true,
                    ZIndex = 5,
                    Text = text,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_title"] = notify_title
                --
                local notify__gradient = utility:Create("Image", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(1, 0, 1, 0, notify_frame),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Transparency = 0,
                    ZIndex = 4,
                    Hidden = true,
                    Visible = false,
                })notification["notify__gradient"] = notify__gradient
                --
                utility:LoadImage(notify__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
                --
                utility:Lerp(notify_outline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_inline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_frame, {Transparency = 1}, 0.25)
                utility:Lerp(notify_accent, {Transparency = 10}, 0.25)
                utility:Lerp(notify_title, {Transparency = 1}, 0.25)
                utility:Lerp(notify__gradient, {Transparency = 0.5}, 0.25)
                --
                window.notificationlist.notifications[#window.notificationlist.notifications + 1] = notification
                --
                local function began_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and utility:MouseOverDrawingInstance(notify_outline) and not notification.pressed then
                        notification.Remove()
                    end
                end
                --
                library.began[#library.began + 1] = began_function
                --
                local function changed_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement and not notification.pressed then
                        if utility:MouseOverDrawingInstance(notify_outline) then
                            local h, s, v = theme.accent:ToHSV()
                            notify_inline.Color = Color3.fromHSV(h, 0.44, v)
                        else
                            notify_inline.Color = theme.inline
                        end
                    end
                end
                --
                library.changed[#library.changed + 1] = changed_function
                --
                function notification.Remove()
                    if notification.pressed then return end
                    notification.pressed = true
                    --
                    utility:Lerp(notify_outline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_inline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_frame, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_accent, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_title, {Transparency = 0}, 0.25)
                    utility:Lerp(notify__gradient, {Transparency = 0}, 0.25)
                    --
                    task.wait(0.25)
                    --
                    notify_outline:Remove()
                    notify_inline:Remove()
                    notify_frame:Remove()
                    notify_accent:Remove()
                    notify_title:Remove()
                    notify__gradient:Remove()
                    --
                    for index, notify in next, window.notificationlist.notifications do
                        if notify == notification then
                            window.notificationlist.notifications[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.changed do
                        if func == changed_function then
                            library.changed[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.began do
                        if func == began_function then
                            library.began[index] = nil
                        end
                    end
                    --
                    window.notificationlist:SortNotifications()
                end
                --
                delay(lifetime + 0.25, notification.Remove)
            end
            --
            function window.notificationlist:SortNotifications()
                for index, notification in next, window.notificationlist.notifications do
                    notification["notify_outline"].Position = utility:Position(0, 0, 0, -3, notification["notify_outline"])
                    notification["notify_inline"].Position = utility:Position(0, 1, 0, 1, notification["notify_outline"])
                    notification["notify_frame"].Position = utility:Position(0, 1, 0, 1, notification["notify_inline"])
                    notification["notify_accent"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                    notification["notify_title"].Position = utility:Position(0, 8, 0, -5, notification["notify_frame"])
                    notification["notify__gradient"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                end
            end
        end
        --
        function window:KeybindsList(info)
            window.keybindslist = {visible = false, keybinds = {}}
            --
            local info = info or {}
            --
            local keybindslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 180, 0, 22),
                Position = utility:Position(0, 10, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.keybindslist.visible
            })window.keybindslist.outline = keybindslist_outline
            --
            library.colors[keybindslist_outline] = {
                Color = "outline"
            }
            --
            local keybindslist_inline = utility:Create("Frame", {Vector2.new(1,1), keybindslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_outline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_inline] = {
                Color = "inline"
            }
            --
            local keybindslist_frame = utility:Create("Frame", {Vector2.new(1,1), keybindslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_inline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local keybindslist_accent = utility:Create("Frame", {Vector2.new(0,0), keybindslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, keybindslist_frame),
                Position = utility:Position(0, 0, 0, 0, keybindslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_accent] = {
                Color = "accent"
            }
            --
            local keybindslist_title = utility:Create("TextLabel", {Vector2.new(keybindslist_outline.Size.X/2,4), keybindslist_outline}, {
                Text = "Keybinds",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline),
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.keybindslist:Resort()
                local index = 0
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.keybindslist:Add(keybindname, keybindvalue)
                if keybindname and keybindvalue and not window.keybindslist.keybinds[keybindname] then
                    local keybindTable = {}
                    --
                    local keybind_outline = utility:Create("Frame", {Vector2.new(0,keybindslist_outline.Size.Y-1), keybindslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, keybindslist_outline),
                        Position = utility:Position(0, 0, 1, -1, keybindslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_outline] = {
                        Color = "outline"
                    }
                    --
                    local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_outline),
                        Position = utility:Position(0, 1, 0, 1, keybind_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_inline] = {
                        Color = "inline"
                    }
                    --
                    local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_inline),
                        Position = utility:Position(0, 1, 0, 1, keybind_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local keybind_title = utility:Create("TextLabel", {Vector2.new(4,3), keybind_outline}, {
                        Text = keybindname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X - 4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X,3), keybind_outline}, {
                        Text = "["..keybindvalue.."]",
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(1, -4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_value] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function keybindTable:Move(yPos)
                        keybind_outline.Position = utility:Position(0, 0, 1, -1 + yPos, keybindslist_outline)
                        keybind_inline.Position = utility:Position(0, 1, 0, 1, keybind_outline)
                        keybind_frame.Position = utility:Position(0, 1, 0, 1, keybind_inline)
                        keybind_title.Position = utility:Position(0, 4, 0, 3, keybind_outline)
                        keybind_value.Position = utility:Position(1, -4 - keybind_value.TextBounds.X, 0, 3, keybind_outline)
                    end
                    --
                    function keybindTable:Remove()
                        utility:Remove(keybind_outline, true)
                        utility:Remove(keybind_inline, true)
                        utility:Remove(keybind_frame, true)
                        utility:Remove(keybind_title, true)
                        utility:Remove(keybind_value, true)
                        --
                        window.keybindslist.keybinds[keybindname] = nil
                        keybindTable = nil
                    end
                    --
                    function keybindTable:Visibility()
                        keybind_outline.Visible = window.keybindslist.visible
                        keybind_inline.Visible = window.keybindslist.visible
                        keybind_frame.Visible = window.keybindslist.visible
                        keybind_title.Visible = window.keybindslist.visible
                        keybind_value.Visible = window.keybindslist.visible
                    end
                    --
                    window.keybindslist.keybinds[keybindname] = keybindTable
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Remove(keybindname)
                if keybindname and window.keybindslist.keybinds[keybindname] then
                    window.keybindslist.keybinds[keybindname]:Remove()
                    window.keybindslist.keybinds[keybindname] = nil
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Visibility()
                keybindslist_outline.Visible = window.keybindslist.visible
                keybindslist_inline.Visible = window.keybindslist.visible
                keybindslist_frame.Visible = window.keybindslist.visible
                keybindslist_accent.Visible = window.keybindslist.visible
                keybindslist_title.Visible = window.keybindslist.visible
                --
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Visibility()
                end
            end
            --
            function window.keybindslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.keybindslist.visible = updateValue
                    window.keybindslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                keybindslist_outline.Position = utility:Position(0, 10, 0.4, 0)
                keybindslist_inline.Position = utility:Position(0, 1, 0, 1, keybindslist_outline)
                keybindslist_frame.Position = utility:Position(0, 1, 0, 1, keybindslist_inline)
                keybindslist_accent.Position = utility:Position(0, 0, 0, 0, keybindslist_frame)
                keybindslist_title.Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline)
                --
                window.keybindslist:Resort()
            end)
        end
        --
        function window:StatusList(info)
            window.statuslist = {visible = false, statuses = {}}
            --
            local info = info or {}
            --
            local statuslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 150, 0, 22),
                Position = utility:Position(1, -160, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.statuslist.visible
            })window.statuslist.outline = statuslist_outline
            --
            library.colors[statuslist_outline] = {
                Color = "outline"
            }
            --
            local statuslist_inline = utility:Create("Frame", {Vector2.new(1,1), statuslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_outline),
                Position = utility:Position(0, 1, 0, 1, statuslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_inline] = {
                Color = "inline"
            }
            --
            local statuslist_frame = utility:Create("Frame", {Vector2.new(1,1), statuslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_inline),
                Position = utility:Position(0, 1, 0, 1, statuslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local statuslist_accent = utility:Create("Frame", {Vector2.new(0,0), statuslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, statuslist_frame),
                Position = utility:Position(0, 0, 0, 0, statuslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_accent] = {
                Color = "accent"
            }
            --
            local statuslist_title = utility:Create("TextLabel", {Vector2.new(statuslist_outline.Size.X/2,4), statuslist_outline}, {
                Text = "Status",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, statuslist_outline),
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.statuslist:Resort()
                local index = 0
                for i,v in pairs(window.statuslist.statuses) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.statuslist:Add(statusname)
                if statusname and not window.statuslist.statuses[statusname] then
                    local statusTable = {}
                    --
                    local status_outline = utility:Create("Frame", {Vector2.new(0,statuslist_outline.Size.Y-1), statuslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, statuslist_outline),
                        Position = utility:Position(0, 0, 1, -1, statuslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_outline] = {
                        Color = "outline"
                    }
                    --
                    local status_inline = utility:Create("Frame", {Vector2.new(1,1), status_outline}, {
                        Size = utility:Size(1, -2, 1, -2, status_outline),
                        Position = utility:Position(0, 1, 0, 1, status_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_inline] = {
                        Color = "inline"
                    }
                    --
                    local status_frame = utility:Create("Frame", {Vector2.new(1,1), status_inline}, {
                        Size = utility:Size(1, -2, 1, -2, status_inline),
                        Position = utility:Position(0, 1, 0, 1, status_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local status_title = utility:Create("TextLabel", {Vector2.new(4,3), status_outline}, {
                        Text = statusname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, status_outline),
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function statusTable:Move(yPos)
                        status_outline.Position = utility:Position(0, 0, 1, -1 + yPos, statuslist_outline)
                        status_inline.Position = utility:Position(0, 1, 0, 1, status_outline)
                        status_frame.Position = utility:Position(0, 1, 0, 1, status_inline)
                        status_title.Position = utility:Position(0, 4, 0, 3, status_outline)
                    end
                    --
                    function statusTable:Remove()
                        utility:Remove(status_outline, true)
                        utility:Remove(status_inline, true)
                        utility:Remove(status_frame, true)
                        utility:Remove(status_title, true)
                        --
                        window.statuslist.statuses[statusname] = nil
                        statusTable = nil
                    end
                    --
                    function statusTable:Visibility()
                        status_outline.Visible = window.statuslist.visible
                        status_inline.Visible = window.statuslist.visible
                        status_frame.Visible = window.statuslist.visible
                        status_title.Visible = window.statuslist.visible
                    end
                    --
                    window.statuslist.statuses[statusname] = statusTable
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Remove(statusname)
                if statusname and window.statuslist.statuses[statusname] then
                    window.statuslist.statuses[statusname]:Remove()
                    window.statuslist.statuses[statusname] = nil
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Visibility()
                statuslist_outline.Visible = window.statuslist.visible
                statuslist_inline.Visible = window.statuslist.visible
                statuslist_frame.Visible = window.statuslist.visible
                statuslist_accent.Visible = window.statuslist.visible
                statuslist_title.Visible = window.statuslist.visible
                --
                for i,v in pairs(window.statuslist.statuses) do
                    v:Visibility()
                end
            end
            --
            function window.statuslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.statuslist.visible = updateValue
                    window.statuslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                statuslist_outline.Position = utility:Position(1, -160, 0.4, 0)
                statuslist_inline.Position = utility:Position(0, 1, 0, 1, statuslist_outline)
                statuslist_frame.Position = utility:Position(0, 1, 0, 1, statuslist_inline)
                statuslist_accent.Position = utility:Position(0, 0, 0, 0, statuslist_frame)
                statuslist_title.Position = utility:Position(0.5, 0, 0, 5, statuslist_outline)
                --
                window.statuslist:Resort()
            end)
        end
    
        --
        function window:AllowClickThrough()

        end
        --
        function window:PreventClickThrough()
            
        end
        --
        local originalMouseBehavior = uis.MouseBehavior
        --
        function window:Fade()
            window.fading = true
            window.isVisible = not window.isVisible
            --
            spawn(function()
                for i, v in pairs(library.drawings) do
                    utility:Lerp(v[1], {Transparency = window.isVisible and v[3] or 0}, 0.25)
                end
            end)
            --

            if window.isVisible then
                local set_back = false
                library.connections.mouse_unlock = uis:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
                    if uis.MouseBehavior == Enum.MouseBehavior.Default and set_back then
                        set_back = false
                    end

                    if not set_back then
                        originalMouseBehavior = uis.MouseBehavior
                    end

                    if uis.MouseBehavior ~= Enum.MouseBehavior.Default then
                        set_back = true
                        uis.MouseBehavior = Enum.MouseBehavior.Default
                    end
                end)
                uis.MouseBehavior = Enum.MouseBehavior.Default
                window:PreventClickThrough()
            else
                library.connections.mouse_unlock:Disconnect()
                uis.MouseBehavior = originalMouseBehavior
                window:AllowClickThrough()
            end
            --
            window.fading = false
        end
        --
        function window:Initialize()
            window.pages[1]:Show()
            --
            for i,v in pairs(window.pages) do
                v:Update()
            end
            --
            library.shared.initialized = true
            --
            window:Watermark()
            window:KeybindsList()
            window:StatusList()
            window:NotificationList()
            --
            window:Fade()
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.isVisible and utility:MouseOverDrawing({main_frame.Position.X,main_frame.Position.Y,main_frame.Position.X + main_frame.Size.X,main_frame.Position.Y + 20}) then
                local mouseLocation = utility:MouseLocation()
                --
                window.dragging = true
                window.drag = Vector2.new(mouseLocation.X - main_frame.Position.X, mouseLocation.Y - main_frame.Position.Y)
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and window.dragging then
                window.dragging = false
                window.drag = Vector2.new(0, 0)
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if window.dragging and window.isVisible then
                local mouseLocation = utility:MouseLocation()
                if utility:GetScreenSize().Y-main_frame.Size.Y-5 > 5 then
                    local move = Vector2.new(math.clamp(mouseLocation.X - window.drag.X, 5, utility:GetScreenSize().X-main_frame.Size.X-5), math.clamp(mouseLocation.Y - window.drag.Y, 5, utility:GetScreenSize().Y-main_frame.Size.Y-5))
                    window:Move(move)
                else
                    local move = Vector2.new(mouseLocation.X - window.drag.X, mouseLocation.Y - window.drag.Y)
                    window:Move(move)
                end
            end
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.KeyCode == window.uibind then
                window:Fade()
            end
            --[[
            if Input.KeyCode == Enum.KeyCode.P then
                local plrs = game:GetService("Players")
                local plr = plrs.LocalPlayer
                if #plrs:GetPlayers() <= 1 then
                    plr:Kick("\nRejoining...")
                    wait()
                    game:GetService('TeleportService'):Teleport(game.PlaceId, plr)
                else
                    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
                end
            end]]
        end
        --
        utility:Connection(uis.InputBegan,function(Input)
            for _, func in pairs(library.began) do
                if not window.dragging then
                    local e,s = pcall(function()
                        func(Input)
                    end)
                else
                    break
                end
            end
        end)
        --
        utility:Connection(uis.InputChanged,function(Input)
            for _, func in pairs(library.changed) do
                if not window.dragging then
                    local e,s = pcall(function()
                        func(Input)
                    end)
                else
                    break
                end
            end
        end)
        --
        utility:Connection(uis.InputEnded,function(Input)
            for _, func in pairs(library.ended) do
                local e,s = pcall(function()
                    func(Input)
                end)
            end
        end)
        --
        utility:Connection(uis.InputChanged,function()
            for _, func in pairs(library.changed) do
                local e,s = pcall(function()
                    func()
                end)
            end
        end)
        --
        utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
            window:Move(Vector2.new((utility:GetScreenSize().X/2) - (size.X/2), (utility:GetScreenSize().Y/2) - (size.Y/2)))
        end)
        --
		return setmetatable(window, library)
	end
    --
    function library:Page(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Page"
        --
        local window = self
        --
        local page = {open = false, sections = {}, sectionOffset = {left = 0, right = 0}, window = window}
        --
        local position = 4
        --
        for i,v in pairs(window.pages) do
            position = position + (v.page_button.Size.X+2)
        end
        --
        local textbounds = utility:GetTextBounds(name, theme.textsize, theme.font)
        --
        local page_button = utility:Create("Frame", {Vector2.new(position,4), window.back_frame}, {
            Size = utility:Size(0, info.size or textbounds.X+30, 0, 21),
            Position = utility:Position(0, position, 0, 4, window.back_frame),
            Color = theme.outline
        });page["page_button"] = page_button
        --
        library.colors[page_button] = {
            Color = "outline"
        }
        --
        local page_button_inline = utility:Create("Frame", {Vector2.new(1,1), page_button}, {
            Size = utility:Size(1, -2, 1, -1, page_button),
            Position = utility:Position(0, 1, 0, 1, page_button),
            Color = theme.inline
        });page["page_button_inline"] = page_button_inline
        --
        library.colors[page_button_inline] = {
            Color = "inline"
        }
        --
        local page_button_color = utility:Create("Frame", {Vector2.new(1,1), page_button_inline}, {
            Size = utility:Size(1, -2, 1, -1, page_button_inline),
            Position = utility:Position(0, 1, 0, 1, page_button_inline),
            Color = theme.darkcontrast
        });page["page_button_color"] = page_button_color
        --
        library.colors[page_button_color] = {
            Color = "darkcontrast"
        }
        --
        local page_button_title = utility:Create("TextLabel", {Vector2.new(utility:Position(0.5, 0, 0, 2, page_button_color).X - page_button_color.Position.X,2), page_button_color}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            Center = true,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, 0, 0, 2, page_button_color)
        });page["page_button_title"] = page_button_title
        --
        library.colors[page_button_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        window.pages[#window.pages + 1] = page
        --
        function page:Update()
            page.sectionOffset["left"] = 0
            page.sectionOffset["right"] = 0
            --
            for i,v in pairs(page.sections) do
                utility:UpdateOffset(v.section_inline, {Vector2.new(v.side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][v.side]), window.tab_frame})
                page.sectionOffset[v.side] = page.sectionOffset[v.side] + v.section_inline.Size.Y + 5
            end
            --
            window:Move(window.main_frame.Position)
        end
        --
        function page:Show()
            if window.currentPage then
                window.currentPage.page_button_color.Size = utility:Size(1, -2, 1, -1, window.currentPage.page_button_inline)
                window.currentPage.page_button_color.Color = theme.darkcontrast
                window.currentPage.open = false
                window.currentPage.page_button_title.Color = theme.textcolor
                --
                library.colors[window.currentPage.page_button_color] = {
                    Color = "darkcontrast"
                }
                --
                for i,v in pairs(window.currentPage.sections) do
                    for z,x in pairs(v.visibleContent) do
                        x.Visible = false
                    end
                end
                --
                window:CloseContent()
            end
            --
            window.currentPage = page
            page_button_color.Size = utility:Size(1, -2, 1, 0, page_button_inline)
            page_button_color.Color = theme.lightcontrast
            page.open = true
            --
            library.colors[page_button_color] = {
                Color = "lightcontrast"
            }
            --
            for i,v in pairs(page.sections) do
                for z,x in pairs(v.visibleContent) do
                    x.Visible = true
                end
            end
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and utility:MouseOverDrawing({page_button.Position.X,page_button.Position.Y,page_button.Position.X + page_button.Size.X,page_button.Position.Y + page_button.Size.Y}) and window.currentPage ~= page then
                page:Show()
            end
        end
        --
        return setmetatable(page, pages)
    end
    --
    function pages:Section(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Section"
        local side = info.side or info.Side or "left"
        side = side:lower()
        local window = self.window
        local page = self
        local section = {window = window, page = page, visibleContent = {}, currentAxis = 20, side = side}
        --
        local section_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(0.5, -7, 0, 22, window.tab_frame),
            Position = utility:Position(side == "right" and 0.5 or 0, side == "right" and 2 or 5, 0, 5 + page.sectionOffset[side], window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent);section["section_inline"] = section_inline
        --
        library.colors[section_inline] = {
            Color = "inline"
        }
        --
        local section_outline = utility:Create("Frame", {Vector2.new(1,1), section_inline}, {
            Size = utility:Size(1, -2, 1, -2, section_inline),
            Position = utility:Position(0, 1, 0, 1, section_inline),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent);section["section_outline"] = section_outline
        --
        library.colors[section_outline] = {
            Color = "outline"
        }
        --
        local section_frame = utility:Create("Frame", {Vector2.new(1,1), section_outline}, {
            Size = utility:Size(1, -2, 1, -2, section_outline),
            Position = utility:Position(0, 1, 0, 1, section_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent);section["section_frame"] = section_frame
        --
        library.colors[section_frame] = {
            Color = "darkcontrast"
        }
        --
        local section_accent = utility:Create("Frame", {Vector2.new(0,0), section_frame}, {
            Size = utility:Size(1, 0, 0, 1, section_frame),
            Position = utility:Position(0, 0, 0, 0, section_frame),
            Color = theme.accent,
            Visible = page.open
        }, section.visibleContent);section["section_accent"] = section_accent
        --
        library.colors[section_accent] = {
            Color = "accent"
        }
        --
        local section_title = utility:Create("TextLabel", {Vector2.new(3,3), section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, 3, section_frame),
            Visible = page.open
        }, section.visibleContent);section["section_title"] = section_title
        --
        library.colors[section_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        function section:Update()
            section_inline.Size = utility:Size(0.5, -7, 0, section.currentAxis+4, window.tab_frame)
            section_outline.Size = utility:Size(1, -2, 1, -2, section_inline)
            section_frame.Size = utility:Size(1, -2, 1, -2, section_outline)
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = section
        --
        return setmetatable(section, sections)
    end
    --
    function pages:InDevSection(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Section"
        local side = info.side or info.Side or "left"
        side = side:lower()
        local window = self.window
        local page = self
        local section = {window = window, page = page, visibleContent = {}, currentAxis = 20, side = side}
        --
        local section_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(0.5, -7, 0, 22, window.tab_frame),
            Position = utility:Position(side == "right" and 0.5 or 0, side == "right" and 2 or 5, 0, 5 + page.sectionOffset[side], window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent);section["section_inline"] = section_inline
        --
        library.colors[section_inline] = {
            Color = "inline"
        }
        --
        local section_outline = utility:Create("Frame", {Vector2.new(1,1), section_inline}, {
            Size = utility:Size(1, -2, 1, -2, section_inline),
            Position = utility:Position(0, 1, 0, 1, section_inline),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent);section["section_outline"] = section_outline
        --
        library.colors[section_outline] = {
            Color = "outline"
        }
        --
        local section_frame = utility:Create("Frame", {Vector2.new(1,1), section_outline}, {
            Size = utility:Size(1, -2, 1, -2, section_outline),
            Position = utility:Position(0, 1, 0, 1, section_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent);section["section_frame"] = section_frame
        --
        library.colors[section_frame] = {
            Color = "darkcontrast"
        }
        --
        local section_accent = utility:Create("Frame", {Vector2.new(0,0), section_frame}, {
            Size = utility:Size(1, 0, 0, 1, section_frame),
            Position = utility:Position(0, 0, 0, 0, section_frame),
            Color = theme.indevcolor,
            Visible = page.open
        }, section.visibleContent);section["section_accent"] = section_accent
        --
        library.colors[section_accent] = {
            Color = "indevcolor"
        }
        --
        local section_title = utility:Create("TextLabel", {Vector2.new(3,3), section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.indevcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, 3, section_frame),
            Visible = page.open
        }, section.visibleContent);section["section_title"] = section_title
        --
        library.colors[section_title] = {
            OutlineColor = "textborder",
            Color = "indevcolor"
        }
        --
        function section:Update()
            section_inline.Size = utility:Size(0.5, -7, 0, section.currentAxis+4, window.tab_frame)
            section_outline.Size = utility:Size(1, -2, 1, -2, section_inline)
            section_frame.Size = utility:Size(1, -2, 1, -2, section_outline)
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = section
        --
        return setmetatable(section, sections)
    end
    --
    function pages:MultiSection(info)
        local info = info or {}
        local msections = info.sections or info.Sections or {}
        local side = info.side or info.Side or "left"
        local size = info.size or info.Size or 150
        side = side:lower()
        local window = self.window
        local page = self
        local multiSection = {window = window, page = page, sections = {}, backup = {}, visibleContent = {}, currentSection = nil, xAxis = 0, side = side}
        --
        local multiSection_inline = utility:Create("Frame", {Vector2.new(side == "right" and (window.tab_frame.Size.X/2)+2 or 5,5 + page["sectionOffset"][side]), window.tab_frame}, {
            Size = utility:Size(0.5, -7, 0, size, window.tab_frame),
            Position = utility:Position(side == "right" and 0.5 or 0, side == "right" and 2 or 5, 0, 5 + page.sectionOffset[side], window.tab_frame),
            Color = theme.inline,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_inline"] = multiSection_inline
        --
        library.colors[multiSection_inline] = {
            Color = "inline"
        }
        --
        local multiSection_outline = utility:Create("Frame", {Vector2.new(1,1), multiSection_inline}, {
            Size = utility:Size(1, -2, 1, -2, multiSection_inline),
            Position = utility:Position(0, 1, 0, 1, multiSection_inline),
            Color = theme.outline,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_outline"] = multiSection_outline
        --
        library.colors[multiSection_outline] = {
            Color = "outline"
        }
        --
        local multiSection_frame = utility:Create("Frame", {Vector2.new(1,1), multiSection_outline}, {
            Size = utility:Size(1, -2, 1, -2, multiSection_outline),
            Position = utility:Position(0, 1, 0, 1, multiSection_outline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_frame"] = multiSection_frame
        --
        library.colors[multiSection_frame] = {
            Color = "darkcontrast"
        }
        --
        local multiSection_backFrame = utility:Create("Frame", {Vector2.new(0,2), multiSection_frame}, {
            Size = utility:Size(1, 0, 0, 17, multiSection_frame),
            Position = utility:Position(0, 0, 0, 2, multiSection_frame),
            Color = theme.lightcontrast,
            Visible = page.open
        }, multiSection.visibleContent)
        --
        library.colors[multiSection_backFrame] = {
            Color = "lightcontrast"
        }
        --
        local multiSection_bottomFrame = utility:Create("Frame", {Vector2.new(0,multiSection_backFrame.Size.Y - 1), multiSection_backFrame}, {
            Size = utility:Size(1, 0, 0, 1, multiSection_backFrame),
            Position = utility:Position(0, 0, 1, -1, multiSection_backFrame),
            Color = theme.outline,
            Visible = page.open
        }, multiSection.visibleContent)
        --
        library.colors[multiSection_bottomFrame] = {
            Color = "outline"
        }
        --
        local multiSection_accent = utility:Create("Frame", {Vector2.new(0,0), multiSection_frame}, {
            Size = utility:Size(1, 0, 0, 1, multiSection_frame),
            Position = utility:Position(0, 0, 0, 0, multiSection_frame),
            Color = theme.accent,
            Visible = page.open
        }, multiSection.visibleContent);multiSection["section_accent"] = multiSection_accent
        --
        library.colors[multiSection_accent] = {
            Color = "accent"
        }
        --
        for i,v in pairs(msections) do
            local msection = {window = window, page = page, currentAxis = 24, sections = {}, visibleContent = {}, section_inline = multiSection_inline, section_outline = multiSection_outline, section_frame = multiSection_frame, section_accent = multiSection_accent}
            --
            local textBounds = utility:GetTextBounds(v, theme.textsize, theme.font)
            --
            local msection_frame = utility:Create("Frame", {Vector2.new(multiSection.xAxis,0), multiSection_backFrame}, {
                Size = utility:Size(0, textBounds.X + 14, 1, -1, multiSection_backFrame),
                Position = utility:Position(0, multiSection.xAxis, 0, 0, multiSection_backFrame),
                Color = i == 1 and theme.darkcontrast or theme.lightcontrast,
                Visible = page.open
            }, multiSection.visibleContent);msection["msection_frame"] = msection_frame
            --
            library.colors[msection_frame] = {
                Color = i == 1 and "darkcontrast" or "lightcontrast"
            }
            --
            local msection_line = utility:Create("Frame", {Vector2.new(msection_frame.Size.X,0), msection_frame}, {
                Size = utility:Size(0, 1, 1, 0, msection_frame),
                Position = utility:Position(1, 0, 0, 0, msection_frame),
                Color = theme.outline,
                Visible = page.open
            }, multiSection.visibleContent)
            --
            library.colors[msection_line] = {
                Color = "outline"
            }
            --
            local msection_title = utility:Create("TextLabel", {Vector2.new(msection_frame.Size.X * 0.5,1), msection_frame}, {
                Text = v,
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 1, msection_frame),
                Visible = page.open
            }, multiSection.visibleContent)
            --
            library.colors[msection_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            local msection_bottomline = utility:Create("Frame", {Vector2.new(0,msection_frame.Size.Y), msection_frame}, {
                Size = utility:Size(1, 0, 0, 1, msection_frame),
                Position = utility:Position(0, 0, 1, 0, msection_frame),
                Color = i == 1 and theme.darkcontrast or theme.outline,
                Visible = page.open
            }, multiSection.visibleContent);msection["msection_bottomline"] = msection_bottomline
            --
            library.colors[msection_bottomline] = {
                Color = i == 1 and "darkcontrast" or "outline"
            }
            --
            function msection:Update()
                if multiSection.currentSection == msection then
                    multiSection.visibleContent = utility:Combine(multiSection.backup, multiSection.currentSection.visibleContent)
                else
                    for z,x in pairs(msection.visibleContent) do
                        x.Visible = false
                    end
                end
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and page.open and  utility:MouseOverDrawing({msection_frame.Position.X,msection_frame.Position.Y,msection_frame.Position.X + msection_frame.Size.X,msection_frame.Position.Y + msection_frame.Size.Y}) and multiSection.currentSection ~= msection and not window:IsOverContent() then
                    multiSection.currentSection.msection_frame.Color = theme.lightcontrast
                    multiSection.currentSection.msection_bottomline.Color = theme.outline
                    --
                    library.colors[multiSection.currentSection.msection_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    library.colors[multiSection.currentSection.msection_bottomline] = {
                        Color = "outline"
                    }
                    --
                    for i,v in pairs(multiSection.currentSection.visibleContent) do
                        v.Visible = false
                    end
                    --
                    multiSection.currentSection = msection
                    msection_frame.Color = theme.darkcontrast
                    msection_bottomline.Color = theme.darkcontrast
                    --
                    library.colors[msection_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    library.colors[msection_bottomline] = {
                        Color = "darkcontrast"
                    }
                    --
                    for i,v in pairs(multiSection.currentSection.visibleContent) do
                        v.Visible = true
                    end
                    --
                    multiSection.visibleContent = utility:Combine(multiSection.backup, multiSection.currentSection.visibleContent)
                end
            end
            --
            if i == 1 then
                multiSection.currentSection = msection
            end
            --
            multiSection.sections[#multiSection.sections + 1] = setmetatable(msection, sections)
            multiSection.xAxis = multiSection.xAxis + textBounds.X + 15
        end
        --
        for z,x in pairs(multiSection.visibleContent) do
            multiSection.backup[z] = x
        end
        --
        page.sectionOffset[side] = page.sectionOffset[side] + 100 + 5
        page.sections[#page.sections + 1] = multiSection
        --
        return table.unpack(multiSection.sections)
    end
    --
    function sections:Label(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Label"
        local middle = info.middle or info.Middle or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local color = info.textcolor or Color3.fromRGB(255, 255, 255)
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local label = {axis = section.currentAxis}
        --
        local label_title = utility:Create("TextLabel", {Vector2.new(middle and (section.section_frame.Size.X/2) or 4,label.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = info.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Position = utility:Position(middle and 0.5 or 0, middle and 0 or 4, 0, 0, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[label_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        function label:Set(name)
            label_title.Text = name
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = label
        end
        --
        section.currentAxis = section.currentAxis + label_title.TextBounds.Y + 4
        section:Update()
        --
        return label
    end
    --
    function sections:Textbox(info)
        local info = info or {}
        local placeholder = info.placeholder or info.PlaceHolder or ""
        local text = info.text or info.Text or ""
        local middle = info.middle or info.Middle or false
        local resetonfocus = info.reset_on_focus or info.ResetOnFocus or false
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function() end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local textbox = {axis = section.currentAxis, current = text}
        --
        local textbox_outline = utility:Create("Frame", {Vector2.new(4, textbox.axis), section.section_frame}, {
            Size = utility:Size(0, section.section_frame.Size.X - 8, 0, 20),
            Position = utility:Position(0.5, 0, 0, textbox.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_outline] = {
            Color = "outline"
        }
        --
        local textbox_inline = utility:Create("Frame", {Vector2.new(1, 1), textbox_outline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_outline),
            Position = utility:Position(0, 1, 0, 1, textbox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_inline] = {
            Color = "inline"
        }
        --
        local textbox_frame = utility:Create("Frame", {Vector2.new(1, 1), textbox_inline}, {
            Size = utility:Size(1, -2, 1, -2, textbox_inline),
            Position = utility:Position(0, 1, 0, 1, textbox_inline),
            Color = theme.darkcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[textbox_frame] = {
            Color = "darkconstrast"
        }
        --
        local placeholder_text = utility:Create("TextLabel", {Vector2.new(middle and textbox_frame.Size.X / 2 or 4, 0), textbox_frame}, {
            Text = placeholder,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Transparency = text == "" and 0.25 or 0,
            Position = utility:Position(1, 0, 0, 0, textbox_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        local text = utility:Create("TextLabel", {Vector2.new(middle and textbox_frame.Size.X / 2 or 4, 0), textbox_frame}, {
            Text = text,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = middle,
            Transparency = 1,
            Position = utility:Position(1, 0, 0, 0, textbox_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[placeholder_text] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        function textbox:get()
            return self.current
        end
        --
        function textbox:set(value, final)
            if value ~= "" then
                utility:UpdateTransparency(placeholder_text, 0)
                placeholder_text.Transparency = 0
            end

            self.current = value
            if final then
                task.spawn(callback, value)
            end
            text.Text = value
        end
        --
        function textbox:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        library.began[#library.began + 1] = function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and textbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X + 10,
                section.section_frame.Position.Y + textbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X - 10,
                section.section_frame.Position.Y + textbox.axis + 16
            }) then
                local inputcapture = utility:CreateInstance("TextBox", {
                    Parent = game.CoreGui,
                    ClearTextOnFocus = false
                })
                --
                inputcapture.FocusLost:Connect(function()
                    textbox:set(inputcapture.Text, true)
                    if textbox.current == "" then
                        utility:UpdateTransparency(placeholder_text, 0.25)
                        placeholder_text.Transparency = 0.25
                    end
                    inputcapture:Destroy()
                end)
                --
                inputcapture:GetPropertyChangedSignal("Text"):Connect(function()
                    textbox:set(inputcapture.Text, false)
                end)

                utility:UpdateTransparency(placeholder_text, 0)
                placeholder_text.Transparency = 0

                inputcapture.Text = resetonfocus and "" or textbox:get()
                inputcapture:CaptureFocus()
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = textbox
        end
        --
        section.currentAxis += textbox_outline.Size.Y + 4
        section:Update()
        --
        return textbox
    end
    --
    function sections:Toggle(info)
        local info = info or {}
        local name = info.name or info.Name or "New Toggle"
        local def = info.default or info.Default or false
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local toggle = {axis = section.currentAxis, current = def, addedAxis = 0, colorpickers = 0, keybind = nil}
        --
        local toggle_outline = utility:Create("Frame", {Vector2.new(4,toggle.axis), section.section_frame}, {
            Size = utility:Size(0, 15, 0, 15),
            Position = utility:Position(0, 4, 0, toggle.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_outline] = {
            Color = "outline"
        }
        --
        local toggle_inline = utility:Create("Frame", {Vector2.new(1,1), toggle_outline}, {
            Size = utility:Size(1, -2, 1, -2, toggle_outline),
            Position = utility:Position(0, 1, 0, 1, toggle_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_inline] = {
            Color = "inline"
        }
        --
        local toggle_frame = utility:Create("Frame", {Vector2.new(1,1), toggle_inline}, {
            Size = utility:Size(1, -2, 1, -2, toggle_inline),
            Position = utility:Position(0, 1, 0, 1, toggle_inline),
            Color = toggle.current == true and theme.accent or theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_frame] = {
            Color = toggle.current == true and "accent" or "lightcontrast"
        }
        --
        local toggle__gradient = utility:Create("Image", {Vector2.new(0,0), toggle_frame}, {
            Size = utility:Size(1, 0, 1, 0, toggle_frame),
            Position = utility:Position(0, 0, 0 , 0, toggle_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local toggle_title = utility:Create("TextLabel", {Vector2.new(23,toggle.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 23, 0, toggle.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[toggle_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(toggle__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function toggle:get()
            return toggle.current
        end
        --
        function toggle:set(bool)
            if bool or not bool then
                toggle.current = bool
                toggle_frame.Color = toggle.current == true and theme.accent or theme.lightcontrast
                --
                library.colors[toggle_frame] = {
                    Color = toggle.current == true and "accent" or "lightcontrast"
                }
                --
                callback(toggle.current)
            end
        end
        --
        function toggle:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        library.colors[toggle_frame] = {
            Color = toggle.current == true and "accent" or "lightcontrast"
        }
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and toggle_outline.Visible and window.isVisible and page.open and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + toggle.axis, section.section_frame.Position.X + section.section_frame.Size.X - toggle.addedAxis, section.section_frame.Position.Y + toggle.axis + 15}) and not window:IsOverContent() then
                toggle.current = not toggle.current
                toggle_frame.Color = toggle.current == true and theme.accent or theme.lightcontrast
                --
                library.colors[toggle_frame] = {
                    Color = toggle.current == true and "accent" or "lightcontrast"
                }
                --
                callback(toggle.current)
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = toggle
        end
        --
        section.currentAxis = section.currentAxis + 15 + 4
        section:Update()
        --
        function toggle:Colorpicker(info)
            local info = info or {}
            local cpinfo = info.info or info.Info or name
            local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
            local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
            local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
            local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
            --
            local hh, ss, vv = def:ToHSV()
            local colorpicker = {toggle, axis = toggle.axis, index = toggle.colorpickers, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
            --
            function colorpicker:set_callback(c)
                callback = c
                callback(self:get())
            end
            --
            local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(toggle.colorpickers == 0 and (30+4) or (64 + 4)),colorpicker.axis), section.section_frame}, {
                Size = utility:Size(0, 30, 0, 15),
                Position = utility:Position(1, -(toggle.colorpickers == 0 and (30+4) or (64 + 4)), 0, colorpicker.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_outline] = {
                Color = "outline"
            }
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_inline] = {
                Color = "inline"
            }
            --
            local colorpicker__transparency
            if transp then
                colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                    Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                    Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                    Visible = page.open
                }, section.visibleContent)
            end
            --
            local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
                Color = def,
                Transparency = transp and (1 - transp) or 1,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
                Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
                Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            if transp then
                utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            utility:LoadImage(colorpicker__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
            --
            function colorpicker:set(color, transp_val)
                if typeof(color) == "table" then
                    if color.Color and color.Transparency then
                        local h, s, v = table.unpack(color.Color)
                        colorpicker.current = {h, s, v , color.Transparency}
                        colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                        colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                        callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                    else
                        colorpicker.current = color
                        colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                        colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                        callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                    end
                elseif typeof(color) == "Color3" then
                    local h, s, v = color:ToHSV()
                    colorpicker.current = {h, s, v, (transp_val or 0)}
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4]) 
                end
            end
            --
            function colorpicker:set_callback(p_callback)
                callback = p_callback
                callback(self:get())
            end
            --
            function colorpicker:Refresh()
                local mouseLocation = utility:MouseLocation()
                if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                    colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                    --
                    colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                    --
                    colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                    --
                    utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                    colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                    --
                    colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                    colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                    colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                    colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                        colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    end
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                    colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                    --
                    colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                    colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                    colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                    --
                    utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                    utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                end
                --
                colorpicker:set(colorpicker.current)
                return self
            end
            --
            function colorpicker:get()
                return {Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), Transparency = colorpicker.current[4]}
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                    if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                        if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                            colorpicker.holding.picker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                            colorpicker.holding.huepicker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                            colorpicker.holding.transparency = true
                            colorpicker:Refresh()
                        end
                    elseif utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (colorpicker.index == 0 and (30 + 4 + 2) or (64 + 4 + 2))), section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X - (colorpicker.index == 1 and 36 or 0), section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                        if not colorpicker.open then
                            window:CloseContent()
                            colorpicker.open = not colorpicker.open
                            --
                            local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                                Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                                Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                            --
                            library.colors[colorpicker_open_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_frame] = {
                                Color = "darkcontrast"
                            }
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_accent] = {
                                Color = "accent"
                            }
                            --
                            local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                                Text = cpinfo,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_title] = {
                                OutlineColor = "textborder",
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                                Color = Color3.fromHSV(colorpicker.current[1],1,1)
                            }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                            --
                            local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                                Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                                Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                            --
                            local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                                Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                                Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                            --
                            local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                                Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                            --
                            local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                                Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                                Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_inline] = {
                                    Color = "inline"
                                }
                                --
                                local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                    Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                                }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                                --
                                local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                                --
                                local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                    Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                    Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                                --
                                library.colors[colorpicker_open_transparency_cursor_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                library.colors[colorpicker_open_transparency_cursor_inline] = {
                                    Color = "textcolor"
                                }
                                --
                                local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                    Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                                --
                                utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                                --utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/VcMAYjL.png")
                            end
                            --
                            utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                            --
                            window.currentContent.frame = colorpicker_open_inline
                            window.currentContent.colorpicker = colorpicker
                        else
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    else
                        if colorpicker.open then
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    end
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                    colorpicker.open = not colorpicker.open
                    --
                    for i,v in pairs(colorpicker.holder.drawings) do
                        utility:Remove(v)
                    end
                    --
                    colorpicker.holder.drawings = {}
                    colorpicker.holder.inline = nil
                    --
                    window.currentContent.frame = nil
                    window.currentContent.colorpicker = nil
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
            --
            library.changed[#library.changed + 1] = function()
                if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                    if window.isVisible then
                        colorpicker:Refresh()
                    else
                        if colorpicker.holding.picker then
                            colorpicker.holding.picker = not colorpicker.holding.picker
                        end
                        if colorpicker.holding.huepicker then
                            colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                        end
                        if colorpicker.holding.transparency then
                            colorpicker.holding.transparency = not colorpicker.holding.transparency
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = colorpicker
            end
            --
            toggle.addedAxis = toggle.addedAxis + 30 + 4 + 2
            toggle.colorpickers = toggle.colorpickers + 1
            section:Update()
            --
            callback(colorpicker:get())
            return toggle, colorpicker
        end
        --
        function toggle:Keybind(info)
            local info = info or {}
            local def = info.default or info.Default or nil
            local pointer = info.pointer or info.Pointer or nil
            local mode = info.mode or info.Mode or "Always"
            local keybindname = info.keybind_name or info.KeybindName or nil
            local callback = info.callback or info.Callback or function()end
            --
            toggle.addedaxis = toggle.addedAxis + 40 + 4 + 2
            --
            local keybind = {keybindname = keybindname or name, axis = toggle.axis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
            --
            toggle.keybind = keybind
            --
            local allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
            local allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"}
            local shortenedInputs = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "Ins", ["LeftAlt"] = "LAlt", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RAlt", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "Caps"}
            --
            local keybind_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(40+4),keybind.axis), section.section_frame}, {
                Size = utility:Size(0, 40, 0, 17),
                Position = utility:Position(1, -(40+4), 0, keybind.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_outline] = {
                Color = "outline"
            }
            --
            local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
                Size = utility:Size(1, -2, 1, -2, keybind_outline),
                Position = utility:Position(0, 1, 0, 1, keybind_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_inline] = {
                Color = "inline"
            }
            --
            local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
                Size = utility:Size(1, -2, 1, -2, keybind_inline),
                Position = utility:Position(0, 1, 0, 1, keybind_inline),
                Color = theme.lightcontrast,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_frame] = {
                Color = "lightcontrast"
            }
            --
            local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), keybind_frame}, {
                Size = utility:Size(1, 0, 1, 0, keybind_frame),
                Position = utility:Position(0, 0, 0 , 0, keybind_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X/2,1), keybind_outline}, {
                Text = "...",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder, 
                Center = true,
                Position = utility:Position(0.5, 0, 1, 0, keybind_outline),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[keybind_value] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            utility:LoadImage(keybind__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
            --
            function keybind:Shorten(string)
                for i,v in pairs(shortenedInputs) do
                    string = string.gsub(string, i, v)
                end
                return string
            end
            --
            function keybind:Change(input)
                input = input or "..."
                local inputTable = {}
                --
                if input.EnumType then
                    if input.EnumType == Enum.KeyCode or input.EnumType == Enum.UserInputType then
                        if table.find(allowedKeyCodes, input.Name) or table.find(allowedInputTypes, input.Name) then
                            inputTable = {input.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", input.Name}
                            --
                            keybind.current = inputTable
                            keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                            --
                            return true
                        end
                    end
                end
                --
                return false
            end
            --
            function keybind:get()
                return keybind.current
            end
            --
            function keybind:getkeybind()
                return Enum[keybind.current[1]][keybind.current[2]]
            end
            --
            function keybind:set(tbl)
                keybind.current = tbl.Key
                keybind.mode = tbl.Mode or "Always"
                keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."

                keybind.active = keybind.mode == "Always" and true or false
            end
            --
            function keybind:setmode(mode)
                if mode == "Always" or "Hold" or "Toggle" then
                    keybind.mode = mode
                end
            end
            --
            function keybind:set_callback(p_callback)
                callback = p_callback
                callback(self:get())
            end
            --
            function keybind:is_active()
                return keybind.active
            end
            --
            function keybind:Reset()
                for i,v in pairs(keybind.modemenu.buttons) do
                    v.Color = v.Text == keybind.mode and theme.accent or theme.textcolor
                    --
                    library.colors[v] = {
                        Color = v.Text == keybind.mode and "accent" or "textcolor"
                    }
                end
                --
                keybind.active = keybind.mode == "Always" and true or false
                if keybind.current[1] and keybind.current[2] then
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            keybind:Change(def)
            --
            library.began[#library.began + 1] = function(Input)
                if keybind.current[1] and keybind.current[2] then
                    if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                        if keybind.mode == "Hold" then
                            local old = keybind.active
                            keybind.active = toggle:get()
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        elseif keybind.mode == "Toggle" then
                            local old = keybind.active
                            keybind.active = not keybind.active == true and toggle:get() or false
                            if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                            if keybind.active ~= old then callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active) end
                        end
                    end
                end
                --
                if keybind.selecting and window.isVisible then
                    local done = keybind:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or Input.UserInputType)
                    if done then
                        keybind.selecting = false
                        keybind.active = keybind.mode == "Always" and true or false
                        keybind_frame.Color = theme.lightcontrast
                        --
                        library.colors[keybind_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        window.keybindslist:Remove(keybindname or name)
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
                --
                if not window.isVisible and keybind.selecting then
                    keybind.selecting = false
                    keybind_frame.Color = theme.lightcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "lightcontrast"
                    }
                end
                --
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and keybind_outline.Visible then
                    if utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (40+4+2)), section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                        keybind.selecting = true
                        keybind_frame.Color = theme.darkcontrast
                        --
                        library.colors[keybind_frame] = {
                            Color = "darkcontrast"
                        }
                    end
                    if keybind.open and keybind.modemenu.frame then
                        if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y, keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                            local changed = false
                            --
                            for i,v in pairs(keybind.modemenu.buttons) do
                                if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)), keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)) + 15}) then
                                    keybind.mode = v.Text
                                    changed = true
                                end
                            end
                            --
                            if changed then keybind:Reset() end
                        else
                            keybind.open = not keybind.open
                            --
                            for i,v in pairs(keybind.modemenu.drawings) do
                                utility:Remove(v)
                            end
                            --
                            keybind.modemenu.drawings = {}
                            keybind.modemenu.buttons = {}
                            keybind.modemenu.frame = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.keybind = nil
                        end
                    end
                end
                --
                if Input.UserInputType == Enum.UserInputType.MouseButton2 and window.isVisible and keybind_outline.Visible then
                    if utility:MouseOverDrawing({section.section_frame.Position.X  + (section.section_frame.Size.X - (40+4+2)), section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                        window:CloseContent()
                        keybind.open = not keybind.open
                        --
                        local modemenu = utility:Create("Frame", {Vector2.new(keybind_outline.Size.X + 2,0), keybind_outline}, {
                            Size = utility:Size(0, 64, 0, 19),
                            Position = utility:Position(1, 2, 0, 0, keybind_outline),
                            Color = theme.outline,
                            Visible = keybind.open
                        }, keybind.modemenu.drawings);keybind.modemenu.frame = modemenu
                        --
                        library.colors[modemenu] = {
                            Color = "outline"
                        }
                        --
                        local modemenu_inline = utility:Create("Frame", {Vector2.new(1,1), modemenu}, {
                            Size = utility:Size(1, -2, 1, -2, modemenu),
                            Position = utility:Position(0, 1, 0, 1, modemenu),
                            Color = theme.inline,
                            Visible = keybind.open
                        }, keybind.modemenu.drawings)
                        --
                        library.colors[modemenu_inline] = {
                            Color = "inline"
                        }
                        --
                        local modemenu_frame = utility:Create("Frame", {Vector2.new(1,1), modemenu_inline}, {
                            Size = utility:Size(1, -2, 1, -2, modemenu_inline),
                            Position = utility:Position(0, 1, 0, 1, modemenu_inline),
                            Color = theme.lightcontrast,
                            Visible = keybind.open
                        }, keybind.modemenu.drawings)
                        --
                        library.colors[modemenu_frame] = {
                            Color = "lightcontrast"
                        }
                        --
                        local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), modemenu_frame}, {
                            Size = utility:Size(1, 0, 1, 0, modemenu_frame),
                            Position = utility:Position(0, 0, 0 , 0, modemenu_frame),
                            Transparency = 0.5,
                            Visible = keybind.open
                        }, keybind.modemenu.drawings)
                        --
                        utility:LoadImage(keybind__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
                        --
                        for i,v in pairs({"Toggle"}) do
                            local button_title = utility:Create("TextLabel", {Vector2.new(modemenu_frame.Size.X/2,15 * (i-1)), modemenu_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = v == keybind.mode and theme.accent or theme.textcolor,
                                Center = true,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0.5, 0, 0, 15 * (i-1), modemenu_frame),
                                Visible = keybind.open
                            }, keybind.modemenu.drawings);keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = button_title
                            --
                            library.colors[button_title] = {
                                OutlineColor = "textborder",
                                Color = v == keybind.mode and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = modemenu
                        window.currentContent.keybind = keybind
                    end
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if keybind.active and keybind.mode == "Hold" then
                    if keybind.current[1] and keybind.current[2] then
                        if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                            keybind.active = false
                            window.keybindslist:Remove(keybindname or name)
                            callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = keybind
            end
            --
            keybind.active = keybind.mode == "Always" and true or false
            --
            toggle.addedAxis = 40+4+2
            section:Update()
            --
            return keybind
        end
        --
        return toggle
    end
    --
    function sections:Slider(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Slider"
        local def = info.def or info.Def or info.default or info.Default or 10
        local min = info.min or info.Min or info.minimum or info.Minimum or 0
        local max = info.max or info.Max or info.maximum or info.Maximum or 100
        local sub = info.suffix or info.Suffix or info.ending or info.Ending or info.prefix or info.Prefix or info.measurement or info.Measurement or ""
        local decimals = info.decimals or info.Decimals or 1
        decimals = 1 / decimals
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        def = math.clamp(def, min, max)
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local slider = {min = min, max = max, sub = sub, decimals = decimals, axis = section.currentAxis, current = def, holding = false}
        --
        local slider_title = utility:Create("TextLabel", {Vector2.new(4,slider.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, slider.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local slider_outline = utility:Create("Frame", {Vector2.new(4,slider.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 12, section.section_frame),
            Position = utility:Position(0, 4, 0, slider.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_outline] = {
            Color = "outline"
        }
        --
        local slider_inline = utility:Create("Frame", {Vector2.new(1,1), slider_outline}, {
            Size = utility:Size(1, -2, 1, -2, slider_outline),
            Position = utility:Position(0, 1, 0, 1, slider_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_inline] = {
            Color = "inline"
        }
        --
        local slider_frame = utility:Create("Frame", {Vector2.new(1,1), slider_inline}, {
            Size = utility:Size(1, -2, 1, -2, slider_inline),
            Position = utility:Position(0, 1, 0, 1, slider_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_frame] = {
            Color = "lightcontrast"
        }
        --
        local slider_slide = utility:Create("Frame", {Vector2.new(1,1), slider_inline}, {
            Size = utility:Size(0, (slider_frame.Size.X / (slider.max - slider.min) * (slider.current - slider.min)), 1, -2, slider_inline),
            Position = utility:Position(0, 1, 0, 1, slider_inline),
            Color = theme.accent,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_slide] = {
            Color = "accent"
        }
        --
        local slider__gradient = utility:Create("Image", {Vector2.new(0,0), slider_frame}, {
            Size = utility:Size(1, 0, 1, 0, slider_frame),
            Position = utility:Position(0, 0, 0 , 0, slider_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local textBounds = utility:GetTextBounds(name, theme.textsize, theme.font)
        local slider_value = utility:Create("TextLabel", {Vector2.new(slider_outline.Size.X/2,(slider_outline.Size.Y/2) - (textBounds.Y/2)), slider_outline}, {
            Text = slider.current..slider.sub.."/"..slider.max..slider.sub,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            Center = true,
            OutlineColor = theme.textborder,
            Position = utility:Position(0.5, 0, 0, (slider_outline.Size.Y/2) - (textBounds.Y/2), slider_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[slider_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(slider__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function slider:set(value)
            slider.current = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
            local percent = 1 - ((slider.max - slider.current) / (slider.max - slider.min))
            slider_value.Text = slider.current..slider.sub.."/"..slider.max..slider.sub
            slider_slide.Size = utility:Size(0, percent * slider_frame.Size.X, 1, -2, slider_inline)
            callback(slider.current)
        end
        --
        function slider:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function slider:Refresh()
            local mouseLocation = utility:MouseLocation()
            local percent = math.clamp(mouseLocation.X - slider_slide.Position.X, 0, slider_frame.Size.X) / slider_frame.Size.X
            local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
            value = math.clamp(value, slider.min, slider.max)
            slider:set(value)
        end
        --
        function slider:get()
            return slider.current
        end
        --
        slider:set(slider.current)
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and slider_outline.Visible and window.isVisible and page.open and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + slider.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + slider.axis + 27}) and not window:IsOverContent() then
                slider.holding = true
                slider:Refresh()
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and slider.holding and window.isVisible then
                slider.holding = false
            end
        end
        --
        library.changed[#library.changed + 1] = function(Input)
            if slider.holding and window.isVisible then
                slider:Refresh()
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = slider
        end
        --
        section.currentAxis = section.currentAxis + 27 + 4
        section:Update()
        --
        return slider
    end
    --
    function sections:Button(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Button"
        local confirmation = info.confirmation or info.Confirmation or false
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local button = {axis = section.currentAxis, pressed = false}
        --
        local button_outline = utility:Create("Frame", {Vector2.new(4,button.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, button.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_outline] = {
            Color = "outline"
        }
        --
        local button_inline = utility:Create("Frame", {Vector2.new(1,1), button_outline}, {
            Size = utility:Size(1, -2, 1, -2, button_outline),
            Position = utility:Position(0, 1, 0, 1, button_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_inline] = {
            Color = "inline"
        }
        --
        local button_frame = utility:Create("Frame", {Vector2.new(1,1), button_inline}, {
            Size = utility:Size(1, -2, 1, -2, button_inline),
            Position = utility:Position(0, 1, 0, 1, button_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_frame] = {
            Color = "lightcontrast"
        }
        --
        local button_gradient = utility:Create("Image", {Vector2.new(0,0), button_frame}, {
            Size = utility:Size(1, 0, 1, 0, button_frame),
            Position = utility:Position(0, 0, 0 , 0, button_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local button_title = utility:Create("TextLabel", {Vector2.new(button_frame.Size.X/2,1), button_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Center = true,
            Position = utility:Position(0.5, 0, 0, 1, button_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[button_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        function button:get()
            return nil
        end
        --
        function button:set_callback(p_callback)
            callback = p_callback
        end
        --
        utility:LoadImage(button_gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and button_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + button.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + button.axis + 20}) and not window:IsOverContent() then
                if confirmation then
                    if button.confirmable then
                        button.confirmable = false
                        button_title.Text = name
                        button_title.Color = theme.textcolor
                        --
                        callback()
                    else
                        button.confirmable = true
                        button_title.Text = "Confirm? [3]"
                        button_title.Color = theme.accent

                        task.spawn(function()
                            for i = 2, 0, -1 do
                                task.wait(1)
                                --
                                if not button.confirmable then
                                    return
                                end
                                button_title.Text = ("Confirm? [%s]"):format(i)
                            end
                            --
                            button.confirmable = false
                            --
                            button_title.Text = name
                            button_title.Color = theme.textcolor
                        end)
                    end
                else
                    callback()
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = button
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        section:Update()
        --
        return button
    end
    --
    function sections:ButtonHolder(info)
        local info = info or {}
        local buttons = info.buttons or info.Buttons or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local buttonHolder = {buttons = {}}
        --
        for i=1, 2 do
            local button = {axis = section.currentAxis}
            --
            local button_outline = utility:Create("Frame", {Vector2.new(i == 2 and ((section.section_frame.Size.X / 2) + 2) or 4,button.axis), section.section_frame}, {
                Size = utility:Size(0.5, -6, 0, 20, section.section_frame),
                Position = utility:Position(0, i == 2 and 2 or 4, 0, button.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_outline] = {
                Color = "outline"
            }
            --
            local button_inline = utility:Create("Frame", {Vector2.new(1,1), button_outline}, {
                Size = utility:Size(1, -2, 1, -2, button_outline),
                Position = utility:Position(0, 1, 0, 1, button_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_inline] = {
                Color = "inline"
            }
            --
            local button_frame = utility:Create("Frame", {Vector2.new(1,1), button_inline}, {
                Size = utility:Size(1, -2, 1, -2, button_inline),
                Position = utility:Position(0, 1, 0, 1, button_inline),
                Color = theme.lightcontrast,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_frame] = {
                Color = "lightcontrast"
            }
            --
            local button_gradient = utility:Create("Image", {Vector2.new(0,0), button_frame}, {
                Size = utility:Size(1, 0, 1, 0, button_frame),
                Position = utility:Position(0, 0, 0 , 0, button_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            local button_title = utility:Create("TextLabel", {Vector2.new(button_frame.Size.X/2,1), button_frame}, {
                Text = buttons[i][1],
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 1, button_frame),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[button_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            utility:LoadImage(button_gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and button_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X + (i == 2 and (section.section_frame.Size.X/2) or 0), section.section_frame.Position.Y + button.axis, section.section_frame.Position.X + section.section_frame.Size.X - (i == 1 and (section.section_frame.Size.X/2) or 0), section.section_frame.Position.Y + button.axis + 20}) and not window:IsOverContent() then
                    buttons[i][2]()
                end
            end
        end
        --
        section.currentAxis = section.currentAxis + 20 + 4
        section:Update()
    end
    --
    function sections:Dropdown(info)
        local info = info or {}
        local name = info.name or info.Name or "New Dropdown"
        local options = info.options or info.Options or {"1", "2", "3"}
        local def = info.default or info.Default or options[1]
        local pointer = info.pointer or info.Pointer or nil
        local callback = info.callback or info.Callback or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local dropdown = {open = false, current = tostring(def), holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local dropdown_outline = utility:Create("Frame", {Vector2.new(4,dropdown.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, dropdown.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_outline] = {
            Color = "outline"
        }
        --
        local dropdown_inline = utility:Create("Frame", {Vector2.new(1,1), dropdown_outline}, {
            Size = utility:Size(1, -2, 1, -2, dropdown_outline),
            Position = utility:Position(0, 1, 0, 1, dropdown_outline),
            Color = theme.inline,
            Visible = page.open,
        }, section.visibleContent)
        --
        library.colors[dropdown_inline] = {
            Color = "inline"
        }
        --
        local dropdown_frame = utility:Create("Frame", {Vector2.new(1,1), dropdown_inline}, {
            Size = utility:Size(1, -2, 1, -2, dropdown_inline),
            Position = utility:Position(0, 1, 0, 1, dropdown_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_frame] = {
            Color = "lightcontrast"
        }
        --
        local dropdown_title = utility:Create("TextLabel", {Vector2.new(4,dropdown.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, dropdown.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local dropdown__gradient = utility:Create("Image", {Vector2.new(0,0), dropdown_frame}, {
            Size = utility:Size(1, 0, 1, 0, dropdown_frame),
            Position = utility:Position(0, 0, 0 , 0, dropdown_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local dropdown_value = utility:Create("TextLabel", {Vector2.new(3,dropdown_frame.Size.Y/2 - 7), dropdown_frame}, {
            Text = dropdown.current,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, (dropdown_frame.Size.Y/2) - 7, dropdown_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[dropdown_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local dropdown_image = utility:Create("Image", {Vector2.new(dropdown_frame.Size.X - 15,dropdown_frame.Size.Y/2 - 3), dropdown_frame}, {
            Size = utility:Size(0, 9, 0, 6, dropdown_frame),
            Position = utility:Position(1, -15, 0.5, -3, dropdown_frame),
            Visible = page.open
        }, section.visibleContent);dropdown["dropdown_image"] = dropdown_image
        --
        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        utility:LoadImage(dropdown__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function dropdown:Update()
            if dropdown.open and dropdown.holder.inline then
                for i,v in pairs(dropdown.holder.buttons) do
                    v[1].Color = v[1].Text == tostring(dropdown.current) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, v[1].Text == tostring(dropdown.current) and 8 or 6, 0, 2, v[2])
                    library.colors[v[1]] = {
                        Color = v[1].Text == tostring(dropdown.current) and "accent" or "textcolor"
                    }
                    utility:UpdateOffset(v[1], {Vector2.new(v[1].Text == tostring(dropdown.current) and 8 or 6, 2), v[2]})
                end
            end
        end
        --
        function dropdown:set(value)
            if typeof(value) == "string" then
                dropdown.current = value
                dropdown_value.Text = value
                task.spawn(callback, dropdown.current)
            end
        end
        --
        function dropdown:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function dropdown:get()
            return dropdown.current
        end
        --
        function dropdown:Refresh(newOptions)
            options = newOptions
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and dropdown_outline.Visible then
                if dropdown.open and dropdown.holder.inline and utility:MouseOverDrawing({dropdown.holder.inline.Position.X, dropdown.holder.inline.Position.Y, dropdown.holder.inline.Position.X + dropdown.holder.inline.Size.X, dropdown.holder.inline.Position.Y + dropdown.holder.inline.Size.Y}) then
                    for i,v in pairs(dropdown.holder.buttons) do
                        if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= dropdown.current then
                            dropdown.current = v[1].Text
                            dropdown_value.Text = dropdown.current
                            dropdown:Update()
                            task.spawn(callback, dropdown.current)
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + dropdown.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + dropdown.axis + 15 +  20}) and not window:IsOverContent() then
                    if not dropdown.open then
                        window:CloseContent()
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local dropdown_open_outline = utility:Create("Frame", {Vector2.new(0,19), dropdown_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + (#options * 19), dropdown_outline),
                            Position = utility:Position(0, 0, 0, 19, dropdown_outline),
                            Color = theme.outline,
                            Visible = page.open,
                            ZIndex = 1306
                        }, dropdown.holder.drawings);dropdown.holder.outline = dropdown_open_outline
                        --
                        library.colors[dropdown_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local dropdown_open_inline = utility:Create("Frame", {Vector2.new(1,1), dropdown_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, dropdown_open_outline),
                            Position = utility:Position(0, 1, 0, 1, dropdown_open_outline),
                            Color = theme.inline,
                            Visible = page.open,
                            ZIndex = 1307
                        }, dropdown.holder.drawings);dropdown.holder.inline = dropdown_open_inline
                        --
                        library.colors[dropdown_open_inline] = {
                            Color = "inline"
                        }
                        --
                        for i,v in pairs(options) do
                            local dropdown_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (i-1))), dropdown_open_inline}, {
                                Size = utility:Size(1, -2, 0, 18, dropdown_open_inline),
                                Position = utility:Position(0, 1, 0, 1 + (19 * (i-1)), dropdown_open_inline),
                                Color = theme.lightcontrast,
                                Visible = page.open,
                                ZIndex = 1308
                            }, dropdown.holder.drawings)
                            --
                            library.colors[dropdown_value_frame] = {
                                Color = "lightcontrast"
                            }
                            --
                            local dropdown_value = utility:Create("TextLabel", {Vector2.new(v == tostring(dropdown.current) and 8 or 6,2), dropdown_value_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = v == tostring(dropdown.current) and theme.accent or theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, v == tostring(dropdown.current) and 8 or 6, 0, 2, dropdown_value_frame),
                                Visible = page.open,
                                ZIndex = 1309
                            }, dropdown.holder.drawings);dropdown.holder.buttons[#dropdown.holder.buttons + 1] = {dropdown_value, dropdown_value_frame}
                            --
                            library.colors[dropdown_value] = {
                                OutlineColor = "textborder",
                                Color = v == tostring(dropdown.current) and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = dropdown_open_inline
                        window.currentContent.dropdown = dropdown
                    else
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(dropdown.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        dropdown.holder.drawings = {}
                        dropdown.holder.buttons = {}
                        dropdown.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.dropdown = nil
                    end
                else
                    if dropdown.open then
                        dropdown.open = not dropdown.open
                        utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(dropdown.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        dropdown.holder.drawings = {}
                        dropdown.holder.buttons = {}
                        dropdown.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.dropdown = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and dropdown.open then
                dropdown.open = not dropdown.open
                utility:LoadImage(dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(dropdown.holder.drawings) do
                    utility:Remove(v)
                end
                --
                dropdown.holder.drawings = {}
                dropdown.holder.buttons = {}
                dropdown.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.dropdown = nil
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = dropdown
        end
        --
        section.currentAxis = section.currentAxis + 35 + 4
        section:Update()
        --
        return dropdown
    end
    --
    function sections:Multibox(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Multibox"
        local options = info.options or info.Options or {"1", "2", "3"}
        local def = info.def or info.Def or info.default or info.Default or {options[1]}
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        local min = info.min or info.Min or info.minimum or info.Minimum or 0
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local multibox = {open = false, current = def, holder = {buttons = {}, drawings = {}}, axis = section.currentAxis}
        --
        local multibox_outline = utility:Create("Frame", {Vector2.new(4,multibox.axis + 15), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 20, section.section_frame),
            Position = utility:Position(0, 4, 0, multibox.axis + 15, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_outline] = {
            Color = "outline"
        }
        --
        local multibox_inline = utility:Create("Frame", {Vector2.new(1,1), multibox_outline}, {
            Size = utility:Size(1, -2, 1, -2, multibox_outline),
            Position = utility:Position(0, 1, 0, 1, multibox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_inline] = {
            Color = "inline"
        }
        --
        local multibox_frame = utility:Create("Frame", {Vector2.new(1,1), multibox_inline}, {
            Size = utility:Size(1, -2, 1, -2, multibox_inline),
            Position = utility:Position(0, 1, 0, 1, multibox_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_frame] = {
            Color = "lightcontrast"
        }
        --
        local multibox_title = utility:Create("TextLabel", {Vector2.new(4,multibox.axis), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, multibox.axis, section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local multibox__gradient = utility:Create("Image", {Vector2.new(0,0), multibox_frame}, {
            Size = utility:Size(1, 0, 1, 0, multibox_frame),
            Position = utility:Position(0, 0, 0 , 0, multibox_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local multibox_value = utility:Create("TextLabel", {Vector2.new(3,multibox_frame.Size.Y/2 - 7), multibox_frame}, {
            Text = "",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 3, 0, (multibox_frame.Size.Y/2) - 7, multibox_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[multibox_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local multibox_image = utility:Create("Image", {Vector2.new(multibox_frame.Size.X - 15,multibox_frame.Size.Y/2 - 3), multibox_frame}, {
            Size = utility:Size(0, 9, 0, 6, multibox_frame),
            Position = utility:Position(1, -15, 0.5, -3, multibox_frame),
            Visible = page.open
        }, section.visibleContent);multibox["multibox_image"] = multibox_image
        --
        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        utility:LoadImage(multibox__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function multibox:Update()
            if multibox.open and multibox.holder.inline then
                for i,v in pairs(multibox.holder.buttons) do
                    v[1].Color = table.find(multibox.current, v[1].Text) and theme.accent or theme.textcolor
                    v[1].Position = utility:Position(0, table.find(multibox.current, v[1].Text) and 8 or 6, 0, 2, v[2])
                    --
                    library.colors[v[1]] = {
                        Color = table.find(multibox.current, v[1].Text) and "accent" or "textcolor"
                    }
                    --
                    utility:UpdateOffset(v[1], {Vector2.new(table.find(multibox.current, v[1].Text) and 8 or 6, 2), v[2]})
                end
            end
        end
        --
        function multibox:Serialize(tbl)
            local str = ""
            --
            for i,v in pairs(tbl) do
                str = str..v..", "
            end
            --
            return string.sub(str, 0, #str - 2)
        end
        --
        function multibox:Resort(tbl,original)
            local newtbl = {}
            --
            for i,v in pairs(original) do
                if table.find(tbl, v) then
                    newtbl[#newtbl + 1] = v
                end
            end
            --
            return newtbl
        end
        --
        function multibox:set(tbl)
            if typeof(tbl) == "table" then
                multibox.current = tbl
                multibox_value.Text =  utility:WrapText(multibox:Serialize(multibox:Resort(multibox.current, options)), multibox_frame.Size.X - 23)
            end
        end
        --
        function multibox:get()
            return multibox.current
        end
        --
        function multibox:set_callback(p_callback)
            callback = p_callback
            callback(multibox:get())
        end
        --
        multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and multibox_outline.Visible then
                if multibox.open and multibox.holder.inline and utility:MouseOverDrawing({multibox.holder.inline.Position.X, multibox.holder.inline.Position.Y, multibox.holder.inline.Position.X + multibox.holder.inline.Size.X, multibox.holder.inline.Position.Y + multibox.holder.inline.Size.Y}) then
                    for i,v in pairs(multibox.holder.buttons) do
                        if utility:MouseOverDrawing({v[2].Position.X, v[2].Position.Y, v[2].Position.X + v[2].Size.X, v[2].Position.Y + v[2].Size.Y}) and v[1].Text ~= multibox.current then
                            if not table.find(multibox.current, v[1].Text) then
                                multibox.current[#multibox.current + 1] = v[1].Text
                                multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
                                multibox:Update()
                            else
                                if #multibox.current > min then
                                    table.remove(multibox.current, table.find(multibox.current, v[1].Text))
                                    multibox_value.Text = multibox:Serialize(multibox:Resort(multibox.current, options))
                                    multibox:Update()
                                end
                            end
                        end
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + multibox.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + multibox.axis + 15 +  20}) and not window:IsOverContent() then
                    if not multibox.open then
                        window:CloseContent()
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        --
                        local multibox_open_outline = utility:Create("Frame", {Vector2.new(0,19), multibox_outline}, {
                            Size = utility:Size(1, 0, 0, 3 + (#options * 19), multibox_outline),
                            Position = utility:Position(0, 0, 0, 19, multibox_outline),
                            Color = theme.outline,
                            Visible = page.open
                        }, multibox.holder.drawings);multibox.holder.outline = multibox_open_outline
                        --
                        library.colors[multibox_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local multibox_open_inline = utility:Create("Frame", {Vector2.new(1,1), multibox_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, multibox_open_outline),
                            Position = utility:Position(0, 1, 0, 1, multibox_open_outline),
                            Color = theme.inline,
                            Visible = page.open
                        }, multibox.holder.drawings);multibox.holder.inline = multibox_open_inline
                        --
                        library.colors[multibox_open_inline] = {
                            Color = "inline"
                        }
                        --
                        for i,v in pairs(options) do
                            local multibox_value_frame = utility:Create("Frame", {Vector2.new(1,1 + (19 * (i-1))), multibox_open_inline}, {
                                Size = utility:Size(1, -2, 0, 18, multibox_open_inline),
                                Position = utility:Position(0, 1, 0, 1 + (19 * (i-1)), multibox_open_inline),
                                Color = theme.lightcontrast,
                                Visible = page.open
                            }, multibox.holder.drawings)
                            --
                            library.colors[multibox_value_frame] = {
                                Color = "lightcontrast"
                            }
                            --[[
                            local multibox_value_gradient = utility:Create("Image", {Vector2.new(0,0), multibox_value_frame}, {
                                Size = utility:Size(1, 0, 1, 0, multibox_value_frame),
                                Position = utility:Position(0, 0, 0 , 0, multibox_value_frame),
                                Transparency = 0.5,
                                Visible = page.open
                            }, multibox.holder.drawings)
                            --
                            utility:LoadImage(multibox_value_gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")]]
                            --
                            local multibox_value = utility:Create("TextLabel", {Vector2.new(table.find(multibox.current, v) and 8 or 6,2), multibox_value_frame}, {
                                Text = v,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = table.find(multibox.current, v) and theme.accent or theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, table.find(multibox.current, v) and 8 or 6, 0, 2, multibox_value_frame),
                                Visible = page.open
                            }, multibox.holder.drawings);multibox.holder.buttons[#multibox.holder.buttons + 1] = {multibox_value, multibox_value_frame}
                            --
                            library.colors[multibox_value] = {
                                OutlineColor = "textborder",
                                Color = table.find(multibox.current, v) and "accent" or "textcolor"
                            }
                        end
                        --
                        window.currentContent.frame = multibox_open_inline
                        window.currentContent.multibox = multibox
                    else
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(multibox.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        multibox.holder.drawings = {}
                        multibox.holder.buttons = {}
                        multibox.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.multibox = nil
                    end
                else
                    if multibox.open then
                        multibox.open = not multibox.open
                        utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        --
                        for i,v in pairs(multibox.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        multibox.holder.drawings = {}
                        multibox.holder.buttons = {}
                        multibox.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.multibox = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and multibox.open then
                multibox.open = not multibox.open
                utility:LoadImage(multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(multibox.holder.drawings) do
                    utility:Remove(v)
                end
                --
                multibox.holder.drawings = {}
                multibox.holder.buttons = {}
                multibox.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.multibox = nil
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = multibox
        end
        --
        section.currentAxis = section.currentAxis + 35 + 4
        section:Update()
        --
        return multibox
    end
    --
    function sections:Keybind(info)
        local info = info or {}
        local name = info.name or info.Name or "New Keybind"
        local def = info.default or info.Default or nil
        local pointer = info.pointer or info.Pointer or nil
        local mode = info.mode or info.Mode or "Always"
        local keybindname = info.keybind_name or info.KeybindName or nil
        local callback = info.callback or info.Callback or function() end
        local changed = info.changed or info.Changed or function() end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local keybind = {keybindname = keybindname or name, axis = section.currentAxis, current = {}, selecting = false, mode = mode, open = false, modemenu = {buttons = {}, drawings = {}}, active = false}
        --
        local allowedKeyCodes = {"Q","E","R","T","Y","U","I","O","P","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seveen","Eight","Nine","Zero","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock"}
        local allowedInputTypes = {}
        local shortenedInputs = {["MouseButton1"] = "MB1", ["MouseButton2"] = "MB2", ["MouseButton3"] = "MB3", ["Insert"] = "Ins", ["LeftAlt"] = "LAlt", ["LeftControl"] = "LC", ["LeftShift"] = "LS", ["RightAlt"] = "RAlt", ["RightControl"] = "RC", ["RightShift"] = "RS", ["CapsLock"] = "Caps"}
        --
        local keybind_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(40+4),keybind.axis), section.section_frame}, {
            Size = utility:Size(0, 40, 0, 17),
            Position = utility:Position(1, -(40+4), 0, keybind.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_outline] = {
            Color = "outline"
        }
        --
        local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
            Size = utility:Size(1, -2, 1, -2, keybind_outline),
            Position = utility:Position(0, 1, 0, 1, keybind_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_inline] = {
            Color = "inline"
        }
        --
        local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
            Size = utility:Size(1, -2, 1, -2, keybind_inline),
            Position = utility:Position(0, 1, 0, 1, keybind_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_frame] = {
            Color = "lightcontrast"
        }
        --
        local keybind_title = utility:Create("TextLabel", {Vector2.new(4,keybind.axis + (17/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, keybind.axis + (17/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), keybind_frame}, {
            Size = utility:Size(1, 0, 1, 0, keybind_frame),
            Position = utility:Position(0, 0, 0 , 0, keybind_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X/2,1), keybind_outline}, {
            Text = "[None]",
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder, 
            Center = true,
            Position = utility:Position(0.5, 0, 1, 0, keybind_outline),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[keybind_value] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        utility:LoadImage(keybind__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function keybind:Shorten(string)
            for i,v in pairs(shortenedInputs) do
                string = string.gsub(string, i, v)
            end
            return string
        end
        --
        function keybind:Change(input)
            local inputTable = {}
            
            if not input or input.Name == "Backspace" then
                keybind.current = {}
                keybind_value.Text = "None"
                changed(keybind.current)
                return true
            end

            if input.EnumType then
                if input.EnumType == Enum.KeyCode or input.EnumType == Enum.UserInputType then
                    if table.find(allowedKeyCodes, input.Name) or table.find(allowedInputTypes, input.Name) then
                        inputTable = {input.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", input.Name}
                        --
                        keybind.current = inputTable
                        keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                        --
                        changed(keybind.current)
                        return true
                    end
                end
            end
            --
            return false
        end
        --
        function keybind:get()
            return keybind.current
        end
        --
        function keybind:getkeybind()
            return Enum[keybind.current[1]][keybind.current[2]]
        end
        --
        function keybind:set(tbl)
            keybind.current = tbl.Key
            keybind.mode = tbl.Mode or "Always"
            keybind_value.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."

            keybind.active = keybind.mode == "Always" and true or false
        end
        --
        function keybind:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function keybind:setmode(mode)
            if mode == "Always" or "Hold" or "Toggle" then
                keybind.mode = mode
            end
        end
        --
        function keybind:is_active()
            return keybind.active
        end
        --
        function keybind:Reset()
            for i,v in pairs(keybind.modemenu.buttons) do
                v.Color = v.Text == keybind.mode and theme.accent or theme.textcolor
                --
                library.colors[v] = {
                    Color = v.Text == keybind.mode and "accent" or "textcolor"
                }
            end
            --
            keybind.active = keybind.mode == "Always" and true or false
            if keybind.current[1] and keybind.current[2] then
                callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
            end
        end
        --
        keybind:Change(def)
        --
        library.began[#library.began + 1] = function(Input)
            if keybind.current[1] and keybind.current[2] then
                if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                    if keybind.mode == "Hold" then
                        keybind.active = true
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Toggle" then
                        keybind.active = not keybind.active
                        if keybind.active then window.keybindslist:Add(keybindname or name, keybind_value.Text) else window.keybindslist:Remove(keybindname or name) end
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end

            if keybind.selecting and window.isVisible then
                local done = keybind:Change(Input.KeyCode.Name ~= "Unknown" and Input.KeyCode or Input.UserInputType)
                if done then
                    keybind.selecting = false
                    keybind.active = keybind.mode == "Always" and true or false
                    keybind_frame.Color = theme.lightcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    window.keybindslist:Remove(keybindname or name)
                    --
                    callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            --
            if not window.isVisible and keybind.selecting then
                keybind.selecting = false
                keybind_frame.Color = theme.lightcontrast
                --
                library.colors[keybind_frame] = {
                    Color = "lightcontrast"
                }
            end
            --
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and keybind_outline.Visible then
                if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                    keybind.selecting = true
                    keybind_frame.Color = theme.darkcontrast
                    --
                    library.colors[keybind_frame] = {
                        Color = "darkcontrast"
                    }
                end
                if keybind.open and keybind.modemenu.frame then
                    if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y, keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                        local changed = false
                        --
                        for i,v in pairs(keybind.modemenu.buttons) do
                            if utility:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)), keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X, keybind.modemenu.frame.Position.Y + (15 * (i - 1)) + 15}) then
                                keybind.mode = v.Text
                                changed = true
                            end
                        end
                        --
                        if changed then keybind:Reset() end
                    else
                        keybind.open = not keybind.open
                        --
                        for i,v in pairs(keybind.modemenu.drawings) do
                            utility:Remove(v)
                        end
                        --
                        keybind.modemenu.drawings = {}
                        keybind.modemenu.buttons = {}
                        keybind.modemenu.frame = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.keybind = nil
                    end
                end
            end
            --
            if Input.UserInputType == Enum.UserInputType.MouseButton2 and window.isVisible and keybind_outline.Visible then
                if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + keybind.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + keybind.axis + 17}) and not window:IsOverContent() and not keybind.selecting then
                    window:CloseContent()
                    keybind.open = not keybind.open
                    --
                    local modemenu = utility:Create("Frame", {Vector2.new(keybind_outline.Size.X + 2,0), keybind_outline}, {
                        Size = utility:Size(0, 64, 0, 49),
                        Position = utility:Position(1, 2, 0, 0, keybind_outline),
                        Color = theme.outline,
                        Visible = false
                    }, keybind.modemenu.drawings);keybind.modemenu.frame = modemenu
                    --
                    library.colors[modemenu] = {
                        Color = "outline"
                    }
                    --
                    local modemenu_inline = utility:Create("Frame", {Vector2.new(1,1), modemenu}, {
                        Size = utility:Size(1, -2, 1, -2, modemenu),
                        Position = utility:Position(0, 1, 0, 1, modemenu),
                        Color = theme.inline,
                        Visible = false
                    }, keybind.modemenu.drawings)
                    --
                    library.colors[modemenu_inline] = {
                        Color = "inline"
                    }
                    --
                    local modemenu_frame = utility:Create("Frame", {Vector2.new(1,1), modemenu_inline}, {
                        Size = utility:Size(1, -2, 1, -2, modemenu_inline),
                        Position = utility:Position(0, 1, 0, 1, modemenu_inline),
                        Color = theme.lightcontrast,
                        Visible = false
                    }, keybind.modemenu.drawings)
                    --
                    library.colors[modemenu_frame] = {
                        Color = "lightcontrast"
                    }
                    --
                    local keybind__gradient = utility:Create("Image", {Vector2.new(0,0), modemenu_frame}, {
                        Size = utility:Size(1, 0, 1, 0, modemenu_frame),
                        Position = utility:Position(0, 0, 0 , 0, modemenu_frame),
                        Transparency = 0.5,
                        Visible = false
                    }, keybind.modemenu.drawings)
                    --
                    utility:LoadImage(keybind__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
                    --
                    for i,v in pairs({"Always", "Toggle", "Hold"}) do
                        local button_title = utility:Create("TextLabel", {Vector2.new(modemenu_frame.Size.X/2,15 * (i-1)), modemenu_frame}, {
                            Text = v,
                            Size = theme.textsize,
                            Font = theme.font,
                            Color = v == keybind.mode and theme.accent or theme.textcolor,
                            Center = true,
                            OutlineColor = theme.textborder,
                            Position = utility:Position(0.5, 0, 0, 15 * (i-1), modemenu_frame),
                            Visible = false
                        }, keybind.modemenu.drawings);keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = button_title
                        --
                        library.colors[button_title] = {
                            OutlineColor = "textborder",
                            Color = v == keybind.mode and "accent" or "textcolor"
                        }
                    end
                    --
                    window.currentContent.frame = modemenu
                    window.currentContent.keybind = keybind
                end
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if keybind.active and keybind.mode == "Hold" then
                if keybind.current[1] and keybind.current[2] then
                    if Input.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or Input.UserInputType == Enum[keybind.current[1]][keybind.current[2]] then
                        keybind.active = false
                        window.keybindslist:Remove(keybindname or name)
                        callback(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = keybind
        end
        --
        section.currentAxis = section.currentAxis + 17 + 4
        section:Update()
        --
        return keybind
    end
    --
    function sections:Colorpicker(info)
        local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "New Colorpicker"
        local cpinfo = info.info or info.Info or name
        local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
        local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local hh, ss, vv = def:ToHSV()
        local colorpicker = {axis = section.currentAxis, secondColorpicker = false, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
        --
        function colorpicker:set_callback(c)
            callback = c
            callback(self:get())
        end
        --
        local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(30+4),colorpicker.axis), section.section_frame}, {
            Size = utility:Size(0, 30, 0, 15),
            Position = utility:Position(1, -(30+4), 0, colorpicker.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
            Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
            Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[colorpicker_inline] = {
            Color = "inline"
        }
        --
        local colorpicker__transparency
        if transp then
            colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                Visible = page.open
            }, section.visibleContent)
        end
        --
        local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
            Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
            Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
            Color = def,
            Transparency = transp and (1 - transp) or 1,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
            Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
            Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,colorpicker.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2)), section.section_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, colorpicker.axis + (15/2) - (utility:GetTextBounds(name, theme.textsize, theme.font).Y/2), section.section_frame),
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[colorpicker_title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        if transp then
            utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
        end
        utility:LoadImage(colorpicker__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function colorpicker:set(color, transp_val)
            if typeof(color) == "table" then
                if color.Color and color.Transparency then
                    local h, s, v = table.unpack(color.Color)
                    colorpicker.current = {h, s, v, color.Transparency}
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                else
                    colorpicker.current = color
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                end
            elseif typeof(color) == "Color3" then
                local h, s, v = color:ToHSV()
                colorpicker.current = {h, s, v, (transp_val or 0)}
                colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
            end
        end
        --
        function colorpicker:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function colorpicker:Refresh()
            local mouseLocation = utility:MouseLocation()
            if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                --
                colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                --
                colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                --
                utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                --
                if colorpicker.holder.transparencybg then
                    colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                end
            elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                --
                colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                --
                utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                --
                colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                --
                if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                end
                --
                if colorpicker.holder.transparencybg then
                    colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                end
            elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                --
                colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                --
                utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                --
                colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
            end
            --
            colorpicker:set(colorpicker.current)
        end
        --
        function colorpicker:get()
            return Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                    if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                        colorpicker.holding.picker = true
                        colorpicker:Refresh()
                    elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                        colorpicker.holding.huepicker = true
                        colorpicker:Refresh()
                    elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                        colorpicker.holding.transparency = true
                        colorpicker:Refresh()
                    end
                elseif utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X - (colorpicker.secondColorpicker and (30+4) or 0), section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                    if not colorpicker.open then
                        window:CloseContent()
                        colorpicker.open = not colorpicker.open
                        --
                        local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                            Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                            Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                        --
                        library.colors[colorpicker_open_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_inline] = {
                            Color = "inline"
                        }
                        --
                        local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                            Color = theme.darkcontrast
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_frame] = {
                            Color = "darkcontrast"
                        }
                        --
                        local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                            Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                            Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                            Color = theme.accent
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_accent] = {
                            Color = "accent"
                        }
                        --
                        local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                            Text = cpinfo,
                            Size = theme.textsize,
                            Font = theme.font,
                            Color = theme.textcolor,
                            OutlineColor = theme.textborder,
                            Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_title] = {
                            OutlineColor = "textborder",
                            Color = "textcolor"
                        }
                        --
                        local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                            Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                            Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_picker_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_picker_inline] = {
                            Color = "inline"
                        }
                        --
                        local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                            Color = Color3.fromHSV(colorpicker.current[1],1,1)
                        }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                        --
                        local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                            Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                            Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                        }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                        --
                        local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                            Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                            Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                        }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                        --
                        local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                            Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                            Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                            Color = theme.outline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_huepicker_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                            Color = theme.inline
                        }, colorpicker.holder.drawings)
                        --
                        library.colors[colorpicker_open_huepicker_inline] = {
                            Color = "inline"
                        }
                        --
                        local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                            Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                        --
                        local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                            Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                            Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                            Color = theme.outline
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                        --
                        library.colors[colorpicker_open_huepicker_cursor_outline] = {
                            Color = "outline"
                        }
                        --
                        local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                            Color = theme.textcolor
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                        --
                        library.colors[colorpicker_open_huepicker_cursor_inline] = {
                            Color = "textcolor"
                        }
                        --
                        local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                            Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                            Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                            Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                        }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                        --
                        if transp then
                            local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_transparency_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_transparency_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                            }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                            --
                            local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                            --
                            local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                            --
                            library.colors[colorpicker_open_transparency_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                            --
                            library.colors[colorpicker_open_transparency_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                            }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                            --
                            utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                        end
                        --
                        utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                        utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                        utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                        --
                        window.currentContent.frame = colorpicker_open_inline
                        window.currentContent.colorpicker = colorpicker
                    else
                        colorpicker.open = not colorpicker.open
                        --
                        for i,v in pairs(colorpicker.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        colorpicker.holder.drawings = {}
                        colorpicker.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.colorpicker = nil
                    end
                else
                    if colorpicker.open then
                        colorpicker.open = not colorpicker.open
                        --
                        for i,v in pairs(colorpicker.holder.drawings) do
                            utility:Remove(v)
                        end
                        --
                        colorpicker.holder.drawings = {}
                        colorpicker.holder.inline = nil
                        --
                        window.currentContent.frame = nil
                        window.currentContent.colorpicker = nil
                    end
                end
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                colorpicker.open = not colorpicker.open
                --
                for i,v in pairs(colorpicker.holder.drawings) do
                    utility:Remove(v)
                end
                --
                colorpicker.holder.drawings = {}
                colorpicker.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.colorpicker = nil
            end
        end
        --
        library.ended[#library.ended + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                if colorpicker.holding.picker then
                    colorpicker.holding.picker = not colorpicker.holding.picker
                end
                if colorpicker.holding.huepicker then
                    colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                end
                if colorpicker.holding.transparency then
                    colorpicker.holding.transparency = not colorpicker.holding.transparency
                end
            end
        end
        --
        library.changed[#library.changed + 1] = function()
            if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                if window.isVisible then
                    colorpicker:Refresh()
                else
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = colorpicker
        end
        --
        section.currentAxis = section.currentAxis + 15 + 4
        section:Update()
        --
        function colorpicker:Colorpicker(info)
            local info = info or {}
            local cpinfo = info.info or info.Info or name
            local def = info.def or info.Def or info.default or info.Default or Color3.fromRGB(255, 0, 0)
            local transp = info.transparency or info.Transparency or info.transp or info.Transp or info.alpha or info.Alpha or nil
            local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
            local callback = info.callback or info.callBack or info.Callback or info.CallBack or function()end
            --
            colorpicker.secondColorpicker = true
            --
            local hh, ss, vv = def:ToHSV()
            local colorpicker = {axis = colorpicker.axis, current = {hh, ss, vv , (transp or 0)}, holding = {picker = false, huepicker = false, transparency = false}, holder = {inline = nil, picker = nil, picker_cursor = nil, huepicker = nil, huepicker_cursor = {}, transparency = nil, transparencybg = nil, transparency_cursor = {}, drawings = {}}}
            --
            function colorpicker:set_callback(c)
                callback = c
                callback(self:get())
            end
            --
            colorpicker_outline.Position = utility:Position(1, -(60+8), 0, colorpicker.axis, section.section_frame)
            utility:UpdateOffset(colorpicker_outline, {Vector2.new(section.section_frame.Size.X-(60+8),colorpicker.axis), section.section_frame})
            --
            local colorpicker_outline = utility:Create("Frame", {Vector2.new(section.section_frame.Size.X-(30+4),colorpicker.axis), section.section_frame}, {
                Size = utility:Size(0, 30, 0, 15),
                Position = utility:Position(1, -(30+4), 0, colorpicker.axis, section.section_frame),
                Color = theme.outline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_outline] = {
                Color = "outline"
            }
            --
            local colorpicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_outline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_outline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_outline),
                Color = theme.inline,
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[colorpicker_inline] = {
                Color = "inline"
            }
            --
            local colorpicker__transparency
            if transp then
                colorpicker__transparency = utility:Create("Image", {Vector2.new(1,1), colorpicker_inline}, {
                    Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                    Position = utility:Position(0, 1, 0 , 1, colorpicker_inline),
                    Visible = page.open
                }, section.visibleContent)
            end
            --
            local colorpicker_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_inline}, {
                Size = utility:Size(1, -2, 1, -2, colorpicker_inline),
                Position = utility:Position(0, 1, 0, 1, colorpicker_inline),
                Color = def,
                Transparency = transp and (1 - transp) or 1,
                Visible = page.open
            }, section.visibleContent)
            --
            local colorpicker__gradient = utility:Create("Image", {Vector2.new(0,0), colorpicker_frame}, {
                Size = utility:Size(1, 0, 1, 0, colorpicker_frame),
                Position = utility:Position(0, 0, 0 , 0, colorpicker_frame),
                Transparency = 0.5,
                Visible = page.open
            }, section.visibleContent)
            --
            if transp then
                utility:LoadImage(colorpicker__transparency, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            utility:LoadImage(colorpicker__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
            --
            function colorpicker:set(color, transp_val)
                if typeof(color) == "table" then
                    colorpicker.current = color
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4])
                elseif typeof(color) == "Color3" then
                    local h, s, v = color:ToHSV()
                    colorpicker.current = {h, s, v, (transp_val or 0)}
                    colorpicker_frame.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    colorpicker_frame.Transparency = 1 - colorpicker.current[4]
                    callback(Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3]), colorpicker.current[4]) 
                end
            end
            --
            function colorpicker:set_callback(p_callback)
                callback = p_callback
                callback(self:get())
            end
            --
            function colorpicker:Refresh()
                local mouseLocation = utility:MouseLocation()
                if colorpicker.open and colorpicker.holder.picker and colorpicker.holding.picker then
                    colorpicker.current[2] = math.clamp(mouseLocation.X - colorpicker.holder.picker.Position.X, 0, colorpicker.holder.picker.Size.X) / colorpicker.holder.picker.Size.X
                    --
                    colorpicker.current[3] = 1-(math.clamp(mouseLocation.Y - colorpicker.holder.picker.Position.Y, 0, colorpicker.holder.picker.Size.Y) / colorpicker.holder.picker.Size.Y)
                    --
                    colorpicker.holder.picker_cursor.Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker.holder.picker)
                    --
                    utility:UpdateOffset(colorpicker.holder.picker_cursor, {Vector2.new((colorpicker.holder.picker.Size.X*colorpicker.current[2])-3,(colorpicker.holder.picker.Size.Y*(1-colorpicker.current[3]))-3), colorpicker.holder.picker})
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.huepicker and colorpicker.holding.huepicker then
                    colorpicker.current[1] = (math.clamp(mouseLocation.Y - colorpicker.holder.huepicker.Position.Y, 0, colorpicker.holder.huepicker.Size.Y) / colorpicker.holder.huepicker.Size.Y)
                    --
                    colorpicker.holder.huepicker_cursor[1].Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker.holder.huepicker)
                    colorpicker.holder.huepicker_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[1])
                    colorpicker.holder.huepicker_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.huepicker_cursor[2])
                    colorpicker.holder.huepicker_cursor[3].Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    utility:UpdateOffset(colorpicker.holder.huepicker_cursor[1], {Vector2.new(-3,(colorpicker.holder.huepicker.Size.Y*colorpicker.current[1])-3), colorpicker.holder.huepicker})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                    --
                    if colorpicker.holder.transparency_cursor and colorpicker.holder.transparency_cursor[3] then
                        colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    end
                    --
                    if colorpicker.holder.transparencybg then
                        colorpicker.holder.transparencybg.Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                    end
                elseif colorpicker.open and colorpicker.holder.transparency and colorpicker.holding.transparency then
                    colorpicker.current[4] = 1 - (math.clamp(mouseLocation.X - colorpicker.holder.transparency.Position.X, 0, colorpicker.holder.transparency.Size.X) / colorpicker.holder.transparency.Size.X)
                    --
                    colorpicker.holder.transparency_cursor[1].Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker.holder.transparency)
                    colorpicker.holder.transparency_cursor[2].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[1])
                    colorpicker.holder.transparency_cursor[3].Position = utility:Position(0, 1, 0, 1, colorpicker.holder.transparency_cursor[2])
                    colorpicker.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4])
                    colorpicker_frame.Transparency = (1 - colorpicker.current[4])
                    --
                    utility:UpdateTransparency(colorpicker_frame, (1 - colorpicker.current[4]))
                    utility:UpdateOffset(colorpicker.holder.transparency_cursor[1], {Vector2.new((colorpicker.holder.transparency.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker.holder.transparency})
                    --
                    colorpicker.holder.background.Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                end
                --
                colorpicker:set(colorpicker.current)
            end
            --
            function colorpicker:get()
                return Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
            end
            --
            library.began[#library.began + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 and window.isVisible and colorpicker_outline.Visible then
                    if colorpicker.open and colorpicker.holder.inline and utility:MouseOverDrawing({colorpicker.holder.inline.Position.X, colorpicker.holder.inline.Position.Y, colorpicker.holder.inline.Position.X + colorpicker.holder.inline.Size.X, colorpicker.holder.inline.Position.Y + colorpicker.holder.inline.Size.Y}) then
                        if colorpicker.holder.picker and utility:MouseOverDrawing({colorpicker.holder.picker.Position.X - 2, colorpicker.holder.picker.Position.Y - 2, colorpicker.holder.picker.Position.X - 2 + colorpicker.holder.picker.Size.X + 4, colorpicker.holder.picker.Position.Y - 2 + colorpicker.holder.picker.Size.Y + 4}) then
                            colorpicker.holding.picker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.huepicker and utility:MouseOverDrawing({colorpicker.holder.huepicker.Position.X - 2, colorpicker.holder.huepicker.Position.Y - 2, colorpicker.holder.huepicker.Position.X - 2 + colorpicker.holder.huepicker.Size.X + 4, colorpicker.holder.huepicker.Position.Y - 2 + colorpicker.holder.huepicker.Size.Y + 4}) then
                            colorpicker.holding.huepicker = true
                            colorpicker:Refresh()
                        elseif colorpicker.holder.transparency and utility:MouseOverDrawing({colorpicker.holder.transparency.Position.X - 2, colorpicker.holder.transparency.Position.Y - 2, colorpicker.holder.transparency.Position.X - 2 + colorpicker.holder.transparency.Size.X + 4, colorpicker.holder.transparency.Position.Y - 2 + colorpicker.holder.transparency.Size.Y + 4}) then
                            colorpicker.holding.transparency = true
                            colorpicker:Refresh()
                        end
                    elseif utility:MouseOverDrawing({section.section_frame.Position.X + (section.section_frame.Size.X - (30 + 4 + 2)), section.section_frame.Position.Y + colorpicker.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + colorpicker.axis + 15}) and not window:IsOverContent() then
                        if not colorpicker.open then
                            window:CloseContent()
                            colorpicker.open = not colorpicker.open
                            --
                            local colorpicker_open_outline = utility:Create("Frame", {Vector2.new(4,colorpicker.axis + 19), section.section_frame}, {
                                Size = utility:Size(1, -8, 0, transp and 219 or 200, section.section_frame),
                                Position = utility:Position(0, 4, 0, colorpicker.axis + 19, section.section_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.inline = colorpicker_open_outline
                            --
                            library.colors[colorpicker_open_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_frame = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_inline),
                                Color = theme.darkcontrast
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_frame] = {
                                Color = "darkcontrast"
                            }
                            --
                            local colorpicker_open_accent = utility:Create("Frame", {Vector2.new(0,0), colorpicker_open_frame}, {
                                Size = utility:Size(1, 0, 0, 2, colorpicker_open_frame),
                                Position = utility:Position(0, 0, 0, 0, colorpicker_open_frame),
                                Color = theme.accent
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_accent] = {
                                Color = "accent"
                            }
                            --
                            local colorpicker_title = utility:Create("TextLabel", {Vector2.new(4,2), colorpicker_open_frame}, {
                                Text = cpinfo,
                                Size = theme.textsize,
                                Font = theme.font,
                                Color = theme.textcolor,
                                OutlineColor = theme.textborder,
                                Position = utility:Position(0, 4, 0, 2, colorpicker_open_frame),
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_title] = {
                                OutlineColor = "textborder",
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_picker_outline = utility:Create("Frame", {Vector2.new(4,17), colorpicker_open_frame}, {
                                Size = utility:Size(1, -27, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(0, 4, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_picker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_picker_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_picker_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_picker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_picker_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_picker_inline),
                                Color = Color3.fromHSV(colorpicker.current[1],1,1)
                            }, colorpicker.holder.drawings);colorpicker.holder.background = colorpicker_open_picker_bg
                            --
                            local colorpicker_open_picker_image = utility:Create("Image", {Vector2.new(0,0), colorpicker_open_picker_bg}, {
                                Size = utility:Size(1, 0, 1, 0, colorpicker_open_picker_bg),
                                Position = utility:Position(0, 0, 0 , 0, colorpicker_open_picker_bg),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker = colorpicker_open_picker_image
                            --
                            local colorpicker_open_picker_cursor = utility:Create("Image", {Vector2.new((colorpicker_open_picker_image.Size.X*colorpicker.current[2])-3,(colorpicker_open_picker_image.Size.Y*(1-colorpicker.current[3]))-3), colorpicker_open_picker_image}, {
                                Size = utility:Size(0, 6, 0, 6, colorpicker_open_picker_image),
                                Position = utility:Position(colorpicker.current[2], -3, 1-colorpicker.current[3] , -3, colorpicker_open_picker_image),
                            }, colorpicker.holder.drawings);colorpicker.holder.picker_cursor = colorpicker_open_picker_cursor
                            --
                            local colorpicker_open_huepicker_outline = utility:Create("Frame", {Vector2.new(colorpicker_open_frame.Size.X-19,17), colorpicker_open_frame}, {
                                Size = utility:Size(0, 15, 1, transp and -40 or -21, colorpicker_open_frame),
                                Position = utility:Position(1, -19, 0, 17, colorpicker_open_frame),
                                Color = theme.outline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_outline),
                                Color = theme.inline
                            }, colorpicker.holder.drawings)
                            --
                            library.colors[colorpicker_open_huepicker_inline] = {
                                Color = "inline"
                            }
                            --
                            local colorpicker_open_huepicker_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_huepicker_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_inline),
                                Position = utility:Position(0, 1, 0 , 1, colorpicker_open_huepicker_inline),
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker = colorpicker_open_huepicker_image
                            --
                            local colorpicker_open_huepicker_cursor_outline = utility:Create("Frame", {Vector2.new(-3,(colorpicker_open_huepicker_image.Size.Y*colorpicker.current[1])-3), colorpicker_open_huepicker_image}, {
                                Size = utility:Size(1, 6, 0, 6, colorpicker_open_huepicker_image),
                                Position = utility:Position(0, -3, colorpicker.current[1], -3, colorpicker_open_huepicker_image),
                                Color = theme.outline
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[1] = colorpicker_open_huepicker_cursor_outline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_outline] = {
                                Color = "outline"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_outline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_outline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_outline),
                                Color = theme.textcolor
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[2] = colorpicker_open_huepicker_cursor_inline
                            --
                            library.colors[colorpicker_open_huepicker_cursor_inline] = {
                                Color = "textcolor"
                            }
                            --
                            local colorpicker_open_huepicker_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_huepicker_cursor_inline}, {
                                Size = utility:Size(1, -2, 1, -2, colorpicker_open_huepicker_cursor_inline),
                                Position = utility:Position(0, 1, 0, 1, colorpicker_open_huepicker_cursor_inline),
                                Color = Color3.fromHSV(colorpicker.current[1], 1, 1)
                            }, colorpicker.holder.drawings);colorpicker.holder.huepicker_cursor[3] = colorpicker_open_huepicker_cursor_color
                            --
                            if transp then
                                local colorpicker_open_transparency_outline = utility:Create("Frame", {Vector2.new(4,colorpicker_open_frame.Size.X-19), colorpicker_open_frame}, {
                                    Size = utility:Size(1, -27, 0, 15, colorpicker_open_frame),
                                    Position = utility:Position(0, 4, 1, -19, colorpicker_open_frame),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_outline),
                                    Color = theme.inline
                                }, colorpicker.holder.drawings)
                                --
                                library.colors[colorpicker_open_transparency_inline] = {
                                    Color = "inline"
                                }
                                --
                                local colorpicker_open_transparency_bg = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_inline),
                                    Color = Color3.fromHSV(colorpicker.current[1], colorpicker.current[2], colorpicker.current[3])
                                }, colorpicker.holder.drawings);colorpicker.holder.transparencybg = colorpicker_open_transparency_bg
                                --
                                local colorpicker_open_transparency_image = utility:Create("Image", {Vector2.new(1,1), colorpicker_open_transparency_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_inline),
                                    Position = utility:Position(0, 1, 0 , 1, colorpicker_open_transparency_inline),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency = colorpicker_open_transparency_image
                                --
                                local colorpicker_open_transparency_cursor_outline = utility:Create("Frame", {Vector2.new((colorpicker_open_transparency_image.Size.X*(1-colorpicker.current[4]))-3,-3), colorpicker_open_transparency_image}, {
                                    Size = utility:Size(0, 6, 1, 6, colorpicker_open_transparency_image),
                                    Position = utility:Position(1-colorpicker.current[4], -3, 0, -3, colorpicker_open_transparency_image),
                                    Color = theme.outline
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[1] = colorpicker_open_transparency_cursor_outline
                                --
                                library.colors[colorpicker_open_transparency_cursor_outline] = {
                                    Color = "outline"
                                }
                                --
                                local colorpicker_open_transparency_cursor_inline = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_outline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_outline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_outline),
                                    Color = theme.textcolor
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[2] = colorpicker_open_transparency_cursor_inline
                                --
                                library.colors[colorpicker_open_transparency_cursor_inline] = {
                                    Color = "textcolor"
                                }
                                --
                                local colorpicker_open_transparency_cursor_color = utility:Create("Frame", {Vector2.new(1,1), colorpicker_open_transparency_cursor_inline}, {
                                    Size = utility:Size(1, -2, 1, -2, colorpicker_open_transparency_cursor_inline),
                                    Position = utility:Position(0, 1, 0, 1, colorpicker_open_transparency_cursor_inline),
                                    Color = Color3.fromHSV(0, 0, 1 - colorpicker.current[4]),
                                }, colorpicker.holder.drawings);colorpicker.holder.transparency_cursor[3] = colorpicker_open_transparency_cursor_color
                                --
                                utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/ncssKbH.png")
                                --utility:LoadImage(colorpicker_open_transparency_image, "transp", "https://i.imgur.com/VcMAYjL.png")
                            end
                            --
                            utility:LoadImage(colorpicker_open_picker_image, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            utility:LoadImage(colorpicker_open_picker_cursor, "valsat_cursor", "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursor.png")
                            utility:LoadImage(colorpicker_open_huepicker_image, "hue", "https://i.imgur.com/iEOsHFv.png")
                            --
                            window.currentContent.frame = colorpicker_open_inline
                            window.currentContent.colorpicker = colorpicker
                        else
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    else
                        if colorpicker.open then
                            colorpicker.open = not colorpicker.open
                            --
                            for i,v in pairs(colorpicker.holder.drawings) do
                                utility:Remove(v)
                            end
                            --
                            colorpicker.holder.drawings = {}
                            colorpicker.holder.inline = nil
                            --
                            window.currentContent.frame = nil
                            window.currentContent.colorpicker = nil
                        end
                    end
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and colorpicker.open then
                    colorpicker.open = not colorpicker.open
                    --
                    for i,v in pairs(colorpicker.holder.drawings) do
                        utility:Remove(v)
                    end
                    --
                    colorpicker.holder.drawings = {}
                    colorpicker.holder.inline = nil
                    --
                    window.currentContent.frame = nil
                    window.currentContent.colorpicker = nil
                end
            end
            --
            library.ended[#library.ended + 1] = function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if colorpicker.holding.picker then
                        colorpicker.holding.picker = not colorpicker.holding.picker
                    end
                    if colorpicker.holding.huepicker then
                        colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                    end
                    if colorpicker.holding.transparency then
                        colorpicker.holding.transparency = not colorpicker.holding.transparency
                    end
                end
            end
            --
            library.changed[#library.changed + 1] = function()
                if colorpicker.open and colorpicker.holding.picker or colorpicker.holding.huepicker or colorpicker.holding.transparency then
                    if window.isVisible then
                        colorpicker:Refresh()
                    else
                        if colorpicker.holding.picker then
                            colorpicker.holding.picker = not colorpicker.holding.picker
                        end
                        if colorpicker.holding.huepicker then
                            colorpicker.holding.huepicker = not colorpicker.holding.huepicker
                        end
                        if colorpicker.holding.transparency then
                            colorpicker.holding.transparency = not colorpicker.holding.transparency
                        end
                    end
                end
            end
            --
            if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
                library.pointers[tostring(pointer)] = keybind
            end
            --
            return colorpicker
        end
        --
        return colorpicker
    end
    --
    function sections:Listbox(info)
        local info = info or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        --
        local list = info.list or info.List or {}
        local callback = info.callback or info.Callback or function() end
        local pointer = info.pointer or info.Pointer or nil
        local multichoice = info.multichoice or info.MultiChoice or false
        --
        local listbox = {axis = section.currentAxis, current = "", startindex = 1, multichoice = multichoice, buttons = {}}
        --
        local listbox_outline = utility:Create("Frame", {Vector2.new(4,listbox.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 148, section.section_frame),
            Position = utility:Position(0, 4, 0, listbox.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_outline] = {
            Color = "outline"
        }
        --
        local listbox_inline = utility:Create("Frame", {Vector2.new(1,1), listbox_outline}, {
            Size = utility:Size(1, -2, 1, -2, listbox_outline),
            Position = utility:Position(0, 1, 0, 1, listbox_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_inline] = {
            Color = "inline"
        }
        --
        local listbox_frame = utility:Create("Frame", {Vector2.new(1,1), listbox_inline}, {
            Size = utility:Size(1, -2, 1, -2, listbox_inline),
            Position = utility:Position(0, 1, 0, 1, listbox_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_frame] = {
            Color = "lightcontrast"
        }
        --
        local listbox_gradient = utility:Create("Image", {Vector2.new(0,0), listbox_frame}, {
            Size = utility:Size(1, 0, 1, 0, listbox_frame),
            Position = utility:Position(0, 0, 0, 0, listbox_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        local listbox_scroll_outline = utility:Create("Frame", {Vector2.new(listbox_gradient.Size.X - 4, 0), listbox_gradient}, {
            Size = utility:Size(0, 4, 1, 0, listbox_gradient),
            Position = utility:Position(1, -4, 0, 0, listbox_gradient),
            Color = theme.outline,
            Transparency = 1,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_scroll_outline] = {
            Color = "outline",
        }
        --
        local listbox_scroll_frame = utility:Create("Frame", {Vector2.new(1, 1), listbox_scroll_outline}, {
            Size = utility:Size(0, 2, #list == 0 and 1 or 1 / (#list / 8), -2, listbox_scroll_outline),
            Position = utility:Position(0, 1, 0, 1, listbox_scroll_outline),
            Color = theme.accent,
            Transparency = 1,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[listbox_scroll_frame] = {
            Color = "accent"
        }
        --
        utility:LoadImage(listbox_gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function listbox:Refresh()
            for i = 1, #self.buttons do
                local button = self.buttons[i]
                button.Color = theme.textcolor
                --
                library.colors[button].Color = "textcolor"
            end
            --
            if multichoice then
                for _, current in ipairs(self.current) do
                    local button = self.buttons[current[2]]
                    if button then
                        button.Color = theme.accent
                        --
                        library.colors[button].Color = "accent"
                    end
                end
            else
                local button = self.buttons[self.current[1][2]]
                if button then
                    button.Color = theme.accent
                    --
                    library.colors[button].Color = "accent"
                end
            end
            --
        end
        --
        function listbox:RefreshScroll(down)
            for i = self.startindex, 1, -1 do
                local button = listbox.buttons[i]
                --
                utility:UpdateTransparency(button, 0)
                utility:UpdateOffset(button, {Vector2.new(listbox_frame.Size.X / 2, 2 + 18 * (#self.buttons - i)), listbox_frame})
                --
                button.Position = utility:Position(0.5, 0, 0, 2 + 18 * (#self.buttons - i), listbox_frame)
                button.Color = theme.textcolor
                button.Transparency = 0
                button.Visible = false
            end
            --
            for i = self.startindex, 7 + self.startindex do
                local button = self.buttons[i]
                --
                local colortype = "textcolor"
                if multichoice then
                    for _, current in ipairs(self.current) do
                        if current[2] == i then
                            colortype = "accent"
                            break
                        end
                    end
                else
                    colortype = i == self.current[1][2] and "accent" or "textcolor"
                end
                --
                utility:UpdateTransparency(button, window.isVisible and page.open and 1 or 0)
                utility:UpdateOffset(button, {Vector2.new(listbox_frame.Size.X / 2, 2 + 18 * (i - self.startindex)), listbox_frame})
                --
                button.Position = utility:Position(0.5, 0, 0, 2 + 18 * (i - self.startindex), listbox_frame)
                button.Color = theme[colortype]
                button.Transparency = window.isVisible and page.open and 1 or 0
                button.Visible = true
                --
                library.colors[button].Color = colortype
            end
            --
            if not down then
                local button = self.buttons[self.startindex + 8]
                --
                utility:UpdateTransparency(button, 0)
                --
                button.Transparency = 0
                button.Visible = false
            end

            self:RefreshScrollBar()
        end
        --
        function listbox:RefreshScrollBar()
            local scale = (self.startindex - 1) / (#self.buttons > 0 and #self.buttons or 1)
            utility:UpdateOffset(listbox_scroll_frame, {Vector2.new(1, 1 + scale * listbox_scroll_outline.Size.Y), listbox_scroll_outline})
            listbox_scroll_frame.Position = utility:Position(0, 1, scale, 1, listbox_scroll_outline)
            listbox_scroll_frame.Size = utility:Size(0, 2, math.clamp(#self.buttons == 0 and 1 or 1 / (#self.buttons / 8), 0, 1), -2, listbox_scroll_outline)
        end
        --
        function listbox:get()
            return self.current
        end
        --
        function listbox:set(value, internal)
            for _, toset in ipairs(value) do
                print(toset[2])
                if not self.buttons[toset[2]] or self.buttons[toset[2]].Text ~= toset[1] then
                    if not self.buttons[1] then
                        return
                    end

                    toset[1] = self.buttons[1]
                    toset[2] = 1
                end
            end
            self.current = value
            self:Refresh()
            if not internal then
                task.spawn(callback, value)
            end
        end
        --
        function listbox:set_callback(p_callback)
            callback = p_callback
            callback(self:get())
        end
        --
        function listbox:UpdateList(list, dontset, keepscroll)
            local list = list or {}

            for i, button in next, self.buttons do
                self.buttons[i] = nil
                for i2, content in next, section.visibleContent do
                    if content == button then
                        table.remove(section.visibleContent, i2)
                        break
                    end
                end
                --
                utility:Remove(button, false)
                utility:Remove(button, true)
            end
            --
            for i, name in ipairs(list) do
                local button_title = utility:Create("TextLabel", {Vector2.new(listbox_frame.Size.X / 2, 2 + (18 * #listbox.buttons)), listbox_frame}, {
                    Text = name,
                    Size = theme.textsize,
                    Font = theme.font,
                    Color = i == 1 and theme.accent or theme.textcolor,
                    OutlineColor = theme.textborder,
                    Center = true,
                    Transparency = #self.buttons + 1 > 8 and 0 or 1,
                    Position = utility:Position(0.5, 0, 0, 2 + (18 * #self.buttons), listbox_frame),
                    Visible = window.isVisible and page.open and #self.buttons + 1 <= 8
                }, section.visibleContent)
                --
                library.colors[button_title] = {
                    OutlineColor = "textborder",
                    Color = i == 1 and "accent" or "textcolor"
                }
                --
                self.buttons[#self.buttons + 1] = button_title
            end
            --

            if keepscroll then
                for index = 1, math.clamp(self.startindex - 1, 1, #self.buttons - 8 <= 0 and 1 or #self.buttons - 8) do
                    self.startindex = index
                    if self.buttons[index + 8] then
                        self:RefreshScroll(true)
                    end
                end
            else
                self.startindex = 1
            end

            self:RefreshScrollBar()

            if not dontset then
                if multichoice then
                    local toset = {}
                    for idx, val in ipairs(list) do
                        if self:get()[idx] then
                            toset[#toset + 1] = self:get()[idx]
                        end
                    end
                    self:set(toset)
                else
                    if list[1] then
                        self:set({{list[1], table.find(list, list[1])}})
                    end
                end
            end
        end
        --
        library.began[#library.began + 1] = function(input)
            -- startIndex: 2
            -- buttons: 10
            -- maxShownButtons: 8
            
            -- we know that there can be 1 new shown if we are at startIndex 2
            -- shownMin: startIndex
            -- showmMax: 7 + startIndex

            -- startIndex: 1
            -- buttons: 4
            -- maxShownButtons: 8
            
            -- now there cannot be more than 4 shown

            local shownMax = #listbox.buttons <= 8 and #listbox.buttons or 7 + listbox.startindex
            for i = listbox.startindex, shownMax do
                local button = listbox.buttons[i]
                --
                utility:UpdateTransparency(button, window.isVisible and page.open and 1 or 0)
                --
                button.Transparency = window.isVisible and page.open and 1 or 0
            end

            if input.UserInputType == Enum.UserInputType.MouseButton1 and listbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X,
                section.section_frame.Position.Y + listbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X,
                section.section_frame.Position.Y + listbox.axis + 148
            }) and not window:IsOverContent() then
                local shownMax = #listbox.buttons <= 8 and #listbox.buttons or 7 + listbox.startindex
                for i = listbox.startindex, shownMax do
                    if utility:MouseOverDrawing({
                        section.section_frame.Position.X,
                        section.section_frame.Position.Y + listbox.axis + 2 + (18 * (i - listbox.startindex)),
                        section.section_frame.Position.X + section.section_frame.Size.X,
                        section.section_frame.Position.Y + listbox.axis + 2 + (18 * (i - listbox.startindex)) + 18
                    }) then
                        if multichoice then
                            local newlist = {{listbox.buttons[i].Text, i}}
                            --
                            for idx, val in ipairs(listbox:get()) do
                                if listbox.buttons[i] ~= listbox.buttons[val[2]] then
                                    newlist[#newlist + 1] = val
                                else
                                    table.remove(newlist, 1)
                                end
                            end
                            --
                            listbox:set(newlist)
                        elseif listbox:get()[1][2] ~= i then
                            listbox:set({{listbox.buttons[i].Text, i}})
                        end
                        --
                        return
                    end
                end
            end
        end
        --
        library.changed[#library.changed + 1] = function(input)
            if input.UserInputType == Enum.UserInputType.MouseWheel and listbox_outline.Visible and window.isVisible and utility:MouseOverDrawing({
                section.section_frame.Position.X,
                section.section_frame.Position.Y + listbox.axis,
                section.section_frame.Position.X + section.section_frame.Size.X,
                section.section_frame.Position.Y + listbox.axis + 148
            }) then
                local down = input.Position.Z < 0 and true or false
                if down then
                    local indexesleft = #listbox.buttons - 8 - listbox.startindex
                    if indexesleft >= 0 then
                        listbox.startindex += 1
                        listbox:RefreshScroll(down)
                    end
                else
                    local indexesleft = #listbox.buttons - 8 + listbox.startindex
                    if indexesleft >= #listbox.buttons - 6 then
                        listbox.startindex -= 1
                        listbox:RefreshScroll(down)
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = listbox
        end
        --
        listbox:UpdateList(list)
        --
        section.currentAxis = section.currentAxis + 148 + 4
        section:Update()
        --
        return listbox
    end
    --
    function sections:ConfigBox(info)
        local info = info or {}
        --
        local window = self.window
        local page = self.page
        local section = self
        local pointer = info.pointer or info.Pointer or info.flag or info.Flag or nil
        --
        local configLoader = {axis = section.currentAxis, current = 1, buttons = {}}
        --
        local configLoader_outline = utility:Create("Frame", {Vector2.new(4,configLoader.axis), section.section_frame}, {
            Size = utility:Size(1, -8, 0, 148, section.section_frame),
            Position = utility:Position(0, 4, 0, configLoader.axis, section.section_frame),
            Color = theme.outline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_outline] = {
            Color = "outline"
        }
        --
        local configLoader_inline = utility:Create("Frame", {Vector2.new(1,1), configLoader_outline}, {
            Size = utility:Size(1, -2, 1, -2, configLoader_outline),
            Position = utility:Position(0, 1, 0, 1, configLoader_outline),
            Color = theme.inline,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_inline] = {
            Color = "inline"
        } -- im being abused, help me please - taskmanager
        --
        local configLoader_frame = utility:Create("Frame", {Vector2.new(1,1), configLoader_inline}, {
            Size = utility:Size(1, -2, 1, -2, configLoader_inline),
            Position = utility:Position(0, 1, 0, 1, configLoader_inline),
            Color = theme.lightcontrast,
            Visible = page.open
        }, section.visibleContent)
        --
        library.colors[configLoader_frame] = {
            Color = "lightcontrast"
        }
        --
        local configLoader_gradient = utility:Create("Image", {Vector2.new(0,0), configLoader_frame}, {
            Size = utility:Size(1, 0, 1, 0, configLoader_frame),
            Position = utility:Position(0, 0, 0 , 0, configLoader_frame),
            Transparency = 0.5,
            Visible = page.open
        }, section.visibleContent)
        --
        for i=1, 8 do
            local config_title = utility:Create("TextLabel", {Vector2.new(configLoader_frame.Size.X/2,2 + (18 * (i-1))), configLoader_frame}, {
                Text = "Config-Slot: "..tostring(i),
                Size = theme.textsize,
                Font = theme.font,
                Color = i == 1 and theme.accent or theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Position = utility:Position(0.5, 0, 0, 2 + (18 * (i-1)), configLoader_frame),
                Visible = page.open
            }, section.visibleContent)
            --
            library.colors[config_title] = {
                OutlineColor = "textborder",
                Color = i == 1 and "accent" or "textcolor"
            }
            --
            configLoader.buttons[i] = config_title
        end
        --
        utility:LoadImage(configLoader_gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
        --
        function configLoader:Refresh()
            for i,v in pairs(configLoader.buttons) do
                v.Color = i == configLoader.current and theme.accent or theme.textcolor
                --
                library.colors[v] = {
                    Color = i == configLoader.current and "accent" or "textcolor"
                }
            end
        end
        --
        function configLoader:get()
            return configLoader.current
        end
        --
        function configLoader:set(current)
            configLoader.current = current
            configLoader:Refresh()
        end
        --
        library.began[#library.began + 1] = function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and configLoader_outline.Visible and window.isVisible and utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + configLoader.axis, section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + configLoader.axis + 148}) and not window:IsOverContent() then
                for i=1, 8 do
                    if utility:MouseOverDrawing({section.section_frame.Position.X, section.section_frame.Position.Y + configLoader.axis + 2 + (18 * (i-1)), section.section_frame.Position.X + section.section_frame.Size.X, section.section_frame.Position.Y + configLoader.axis + 2 + (18 * (i-1)) + 18}) then
                        configLoader.current = i
                        configLoader:Refresh()
                    end
                end
            end
        end
        --
        if pointer and tostring(pointer) ~= "" and tostring(pointer) ~= " " and not library.pointers[tostring(pointer)] then
            library.pointers[tostring(pointer)] = configLoader
        end
        --
        section.currentAxis = section.currentAxis + 148 + 4
        section:Update()
        --
        return configLoader
    end
end

function library:UpdateColor(ColorType, ColorValue)
    local ColorType = ColorType:lower()
    --
    theme[ColorType] = ColorValue
    --
    for Index, Value in pairs(library.colors) do
        for Index2, Value2 in pairs(Value) do
            if Value2 == ColorType then
                Index[Index2] = theme[Value2]
            end
        end
    end
end



local m_thread = task do
    setreadonly(m_thread, false)

    function m_thread.spawn_loop(p_time, p_callback)
        m_thread.spawn(function()
            while true do
                p_callback()
                m_thread.wait(p_time)
            end
        end)
    end

    setreadonly(m_thread, true)
end

return library, library.pointers, theme
end

local library = retlibrary():New({ 
    Name = "Azure - Beta",
    Size = Vector2.new(550,601)
})

getgenv().azureConnections = {}
do
    function azureConnections:DisconnectAll()
        for _, connection in next, azureConnections do
            if connection then connection:Disconnect() end
        end
        if draw.currDrawings then
            for _, drawing in next, draw.currDrawings do
                drawing:Remove()
            end
        end
    end
end

local LPH_JIT_ULTRA = LPH_JIT_ULTRA or function(...) return ... end

getgenv().serv = {}

function serv:get(serv)
    local suc, res = pcall(function()
        return game:GetService(serv)
    end)
    if suc then
        return game:GetService(serv)
    elseif suc == false then
        print("invalid service")
        return print(res)
    end
end

getgenv().event = {
    names = {}
}

function event:new(eventName): listener
    local listener = {}
    function listener:bindConnection(connection, identifier, callback): bind_connection
        local connection = connection:Connect(callback)
        azureConnections[identifier] = connection
        table.insert(azureConnections, connection)
        return connection
    end
    function listener:unbindConnection(identifier): unbind_connection
        if azureConnections[identifier] then
            local function unBind(connection)
                return connection:Disconnect()
            end
            unBind(azureConnections[identifier])
        end
    end
    return listener
end

local players = serv:get("Players")
local runservice = serv:get("RunService")
local workspace = serv:get("Workspace")
local userinputservice = serv:get("UserInputService")
local lighting = serv:get("Lighting")
local stats = serv:get("Stats")

local camera = workspace.CurrentCamera
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()
local cameraupdate = event.new("cameraUpdate")
cameraupdate:bindConnection(runservice.Heartbeat, "asdionionj", LPH_JIT_ULTRA(function()
    camera = workspace.CurrentCamera
end))

getgenv().aimbot = {}

function aimbot.isAlive(plr): alive
    if plr then
        return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
    end
end

function aimbot.aimat(target, targetPos, smoothingX, smoothingY, aimType): aim_at
    if aimbot.isAlive(target) and character.isAlive() then 
        if aimType == "Camera" then
            local targetPosCFRAME = CFrame.lookAt(camera.CFrame.Position, Vector3.new(targetPos.X, targetPos.Y, targetPos.Z))
            camera.CFrame = camera.CFrame:Lerp(targetPosCFRAME, smoothingX)
        elseif aimType == "Mouse" then
            local targetPos2D = camera:WorldToScreenPoint(targetPos)
            local function calcthread1(multiplier)
                return (targetPos2D.X - mouse.X) * multiplier
            end
            local function calcthread2(multiplier)
                return (targetPos2D.Y - mouse.Y) * multiplier
            end
            mousemoverel(calcthread1(smoothingX), calcthread2(smoothingY))
        end
    end
end 

function aimbot.getPlayer(radius, aimpart, wallcheck): aim_getplayer
    local array, dist = {}, math.huge
    for _, player in next, players:GetPlayers() do
        if player ~= localplayer then  
            if aimbot.isAlive(player) then
                local pos, onscreen = camera:WorldToScreenPoint(player.Character[aimpart].Position or player.Character["Head" or "HumanoidRootPart"].Position)
                local pos2D = camera:WorldToViewportPoint(player.Character[aimpart].Position or player.Character["Head" or "HumanoidRootPart"].Position)
                local magnitude = ( Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos2D.X, pos2D.Y) ).Magnitude
                local characterKOED = player.Character.BodyEffects ~= nil and player.Character.BodyEffects["K.O"].Value
                if wallcheck then
                    if onscreen and workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p, player.Character["Head" or "HumanoidRootPart"].Position - camera.CFrame.p), { workspace.Ignored, camera, localplayer.Character, player.Character }) == nil and characterKOED == false then
                        if magnitude < dist and magnitude < radius + 18 then
                            array = {
                                player = player
                            }; dist = magnitude
                        end
                    end
                else
                    if onscreen then
                        if magnitude < dist and magnitude < radius + 18 then
                            array = {
                                player = player
                            }; dist = magnitude
                        end
                    end
                end
            end
        end
    end
    return array
end

function aimbot.getclosestpart(character)
    local closestpart, distance, filteredparts = nil, math.huge, {}

    for _, part1 in next, character:GetChildren() do
        if part1 ~= nil then
            if part1:IsA("BasePart") or part1:IsA("MeshPart") then
                local _, onscreen = camera:WorldToScreenPoint(part1.Position)
                if onscreen then
                    table.insert(filteredparts, part1)
                    for _, part2 in next, filteredparts do                
                        local part2D = camera:WorldToViewportPoint(part2.Position)
                        local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(part2D.X, part2D.Y)).Magnitude
                        if magnitude < distance + 18 then
                            closestpart = part2
                            distance = magnitude
                        end
                    end
                end
            end
        end
    end
    return closestpart
end

getgenv().character = {}

function character.isAlive(): alive
    local character = localplayer.Character
    if not character then return false end
    local humanoid = character.Humanoid
    return humanoid.Health > 0
end

function character.getPosition(): vec
    if character.isAlive() then
        local character = localplayer.Character
        local characterposition = character.PrimaryPart.Position
        return Vector3.new(characterposition.X, characterposition.Y, characterposition.Z)
    end
end

function character.getHealth(): health
    if character.isAlive() then
        local character = localplayer.Character
        local characterHealth = character.Humanoid.Health
        return characterHealth
    else
        return 0
    end
end

function character.getMaxHealth(): max_health
    if character.isAlive() then
        local character = localplayer.Character
        local characterMaxHealth = character.Humanoid.MaxHealth
        return characterMaxHealth
    end
end

function character.setBaseWalkSpeed(speed)
    if character.isAlive() then
        local character = localplayer.Character
        local humanoid = character.Humanoid
        humanoid.WalkSpeed = speed
    end
end

getgenv().config = {}

function config:getFolder()
    local array = {}

    for i, v in next, listfiles("azure/configs") do
        local filename = v
        local result = string.gsub(filename,"azure/configs.*\\","")
        table.insert(array, result)
    end
    return array
end

getgenv().draw = {
    currDrawings = {}
}

function draw.new(object, properties): new_drawing
    local object = Drawing.new(object)
    for i, v in next, properties do
        object[i] = v
    end
    table.insert(draw.currDrawings, object)
    return object
end

getgenv().theme = {}

function theme:set(theme): theme_set
    if theme == "Default" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(168,122,207))
        library.pointers["uilight"]:set(Color3.fromRGB(30,30,30))
        library.pointers["uidark"]:set(Color3.fromRGB(25,25,25))
        library.pointers["uioutline"]:set(Color3.fromRGB(0,0,0))
        library.pointers["uiinline"]:set(Color3.fromRGB(50,50,50))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(0,0,0))
    elseif theme == "Snowy" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(204,255,255))
        library.pointers["uilight"]:set(Color3.fromRGB(45,45,45))
        library.pointers["uidark"]:set(Color3.fromRGB(35,35,35))
        library.pointers["uioutline"]:set(Color3.fromRGB(0,0,0))
        library.pointers["uiinline"]:set(Color3.fromRGB(40,40,40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(0,0,0))
    elseif theme == "Salmon" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(250,128,144))
        library.pointers["uilight"]:set(Color3.fromRGB(29,29,29))
        library.pointers["uidark"]:set(Color3.fromRGB(25,25,25))
        library.pointers["uioutline"]:set(Color3.fromRGB(0,0,0))
        library.pointers["uiinline"]:set(Color3.fromRGB(40,40,40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Bitch Bot" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(126, 72, 163))
        library.pointers["uilight"]:set(Color3.fromRGB(30, 30, 30))
        library.pointers["uidark"]:set(Color3.fromRGB(35, 35, 35))
        library.pointers["uioutline"]:set(Color3.fromRGB(20, 20, 20))
        library.pointers["uiinline"]:set(Color3.fromRGB(40,40,40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Kiriot Hub" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(255, 170, 0))
        library.pointers["uilight"]:set(Color3.fromRGB(48, 51, 59))
        library.pointers["uidark"]:set(Color3.fromRGB(26, 28, 32))
        library.pointers["uioutline"]:set(Color3.fromRGB(20, 20, 20))
        library.pointers["uiinline"]:set(Color3.fromRGB(40,40,40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Fatality" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(197, 7, 84))
        library.pointers["uilight"]:set(Color3.fromRGB(30, 24, 66))
        library.pointers["uidark"]:set(Color3.fromRGB(25, 19, 53))
        library.pointers["uioutline"]:set(Color3.fromRGB(60, 53, 93))
        library.pointers["uiinline"]:set(Color3.fromRGB(40,40,40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Red" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(255,51,51))
        library.pointers["uilight"]:set(Color3.fromRGB(19,19,19))
        library.pointers["uidark"]:set(Color3.fromRGB(18,18,18))
        library.pointers["uioutline"]:set(Color3.fromRGB(0,0,0))
        library.pointers["uiinline"]:set(Color3.fromRGB(40, 40, 40))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Tokyo Night" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(103,89,179))
        library.pointers["uilight"]:set(Color3.fromRGB(24,24,37))
        library.pointers["uidark"]:set(Color3.fromRGB(22,22,31))
        library.pointers["uioutline"]:set(Color3.fromRGB(50,50,50))
        library.pointers["uiinline"]:set(Color3.fromRGB(0,0,0))
        library.pointers["uitextcolor"]:set(Color3.fromRGB(255,255,255))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Old Abyss" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromHex("#8c87b4"))
        library.pointers["uilight"]:set(Color3.fromHex("#1e1e1e"))
        library.pointers["uidark"]:set(Color3.fromHex("#141414"))
        library.pointers["uioutline"]:set(Color3.fromHex("#0a0a0a"))
        library.pointers["uiinline"]:set(Color3.fromHex("#322850"))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#ffffff"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Onetap" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromHex("#dda85d"))
        library.pointers["uilight"]:set(Color3.fromHex("#2c3037"))
        library.pointers["uidark"]:set(Color3.fromHex("#1f2125"))
        library.pointers["uioutline"]:set(Color3.fromHex("#000000"))
        library.pointers["uiinline"]:set(Color3.fromHex("#4e5158"))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "NeverLose" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromHex("#00b4f0"))
        library.pointers["uilight"]:set(Color3.fromHex("#000f1e"))
        library.pointers["uidark"]:set(Color3.fromHex("#050514"))
        library.pointers["uioutline"]:set(Color3.fromHex("#000005"))
        library.pointers["uiinline"]:set(Color3.fromHex("#0a1e28"))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#ffffff"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Gamesense" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromHex("#a7d94d"))
        library.pointers["uilight"]:set(Color3.fromHex("#171717"))
        library.pointers["uidark"]:set(Color3.fromHex("#0c0c0c"))
        library.pointers["uioutline"]:set(Color3.fromHex("#000000"))
        library.pointers["uiinline"]:set(Color3.fromRGB(32,32,32))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#ffffff"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Vape" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromHex("#26866a"))
        library.pointers["uilight"]:set(Color3.fromHex("#1f1f1f"))
        library.pointers["uidark"]:set(Color3.fromHex("#1a1a1a"))
        library.pointers["uioutline"]:set(Color3.fromHex("#0a0a0a"))
        library.pointers["uiinline"]:set(Color3.fromHex("#363636"))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Spotify" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(103, 212, 91))
        library.pointers["uilight"]:set(Color3.fromRGB(30, 30, 30))
        library.pointers["uidark"]:set(Color3.fromRGB(25, 25, 25))
        library.pointers["uioutline"]:set(Color3.fromRGB(0, 0, 0))
        library.pointers["uiinline"]:set(Color3.fromRGB(46, 46, 46))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Zeebot v2" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(117,96,175))
        library.pointers["uilight"]:set(Color3.fromRGB(51,51,51))
        library.pointers["uidark"]:set(Color3.fromRGB(41,41,41))
        library.pointers["uioutline"]:set(Color3.fromRGB(37, 37, 37))
        library.pointers["uiinline"]:set(Color3.fromRGB(39, 39, 39))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "LegitSneeze" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(135,206,250))
        library.pointers["uilight"]:set(Color3.fromRGB(43,41,48))
        library.pointers["uidark"]:set(Color3.fromRGB(44,41,48))
        library.pointers["uioutline"]:set(Color3.fromRGB(37, 37, 37))
        library.pointers["uiinline"]:set(Color3.fromRGB(32,32,32))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    elseif theme == "Abyss V2" then
        library.pointers["uiindev"]:set(Color3.fromRGB(164,219,232))
        library.pointers["uiaccentcolor"]:set(Color3.fromRGB(161, 144, 219))
        library.pointers["uilight"]:set(Color3.fromRGB(27, 27, 27))
        library.pointers["uidark"]:set(Color3.fromRGB(18, 18, 18))
        library.pointers["uioutline"]:set(Color3.fromRGB(0, 0, 0))
        library.pointers["uiinline"]:set(Color3.fromRGB(50, 50, 50))
        library.pointers["uitextcolor"]:set(Color3.fromHex("#d6d9e0"))
        library.pointers["uitextborder"]:set(Color3.fromRGB(10,10,10))
    end
end

getgenv().esp = {
    players = {},

    enabled = false,

    fading = false,
    espfadespeed = 5,

    box = false,
    boxcolor = Color3.fromRGB(255,255,255),
    boxoutline = Color3.fromRGB(0,0,0),
    boxtransparency = 0,
    boxoutlinetransparency = 0,
    
    health = false,
    healthcolor = Color3.fromRGB(0,255,0),
    healthoutline = Color3.fromRGB(0,0,0),
    healthtransparency = 0,
    healthoutlinetransparency = 0,

    chams = false,
    chamscolor = Color3.fromRGB(255,255,255),
    chamsoutline = Color3.fromRGB(0,0,0),
    chamstransparencyinline = 0.5,
    chamstransparencyoutline = 0.5,

    name = false,
    namecolor = Color3.fromRGB(255,255,255),
    nameoutline = Color3.fromRGB(0,0,0),
    nametransparency = 0,

    healthbartext = false,
    healthbartextcolor = Color3.fromRGB(255,255,255),
    healthbartextoutline = Color3.fromRGB(0,0,0),
    healthbartexttransparency = 0,

    renderdistance = 10000
}

spawn(LPH_JIT_ULTRA(function()
    while task.wait() do
        for i, v in next, players:GetPlayers() do
            if v ~= localplayer and aimbot.isAlive(v) then
                local drawingInstances = esp.players[v]
                if not drawingInstances then continue end
    
                if esp.enabled then
                    local character = v.Character
                    local _, onscreen = camera:WorldToScreenPoint(character.HumanoidRootPart.Position)
                    local distfromchar = (camera.CFrame.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if esp.renderdistance < distfromchar then 
                        drawingInstances.Box.Visible = false
                        drawingInstances.BoxOutline.Visible = false
                        drawingInstances.Health.Visible = false
                        drawingInstances.HealthOutline.Visible = false
                        drawingInstances.Cham.Parent = nil
                        drawingInstances.Name.Visible = false
                        drawingInstances.HealthText.Visible = false
                    else
                        if onscreen then
                            local charhum2D = camera:WorldToViewportPoint(character.HumanoidRootPart.Position)
                            local charSize = (camera:WorldToViewportPoint(character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)).Y - camera:WorldToViewportPoint(character.HumanoidRootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                            local boxSize = Vector2.new(math.floor(charSize * 1.1), math.floor(charSize * 1.9))
                            local boxPosition = Vector2.new(math.floor(charhum2D.X - charSize * 1.1 / 2), math.floor(charhum2D.Y - charSize * 1.6 / 2))
            
                            if esp.box then
                                drawingInstances.Box.Size = boxSize
                                drawingInstances.Box.Position = boxPosition
                                drawingInstances.Box.Visible = true
                                drawingInstances.Box.Color = esp.boxcolor
                                drawingInstances.BoxOutline.Size = boxSize
                                drawingInstances.BoxOutline.Position = boxPosition
                                drawingInstances.BoxOutline.Visible = true
                                drawingInstances.BoxOutline.Color = esp.boxoutline
                                if esp.fading then
                                    drawingInstances.Box.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                    drawingInstances.BoxOutline.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                else
                                    drawingInstances.Box.Transparency = 1 - esp.boxtransparency
                                    drawingInstances.BoxOutline.Transparency = 1 - esp.boxoutlinetransparency
                                end
                            else
                                drawingInstances.Box.Visible = false
                                drawingInstances.BoxOutline.Visible = false
                            end
                            if esp.health then
                                drawingInstances.Health.From = Vector2.new((boxPosition.X - 5), boxPosition.Y + boxSize.Y)
                                drawingInstances.Health.To = Vector2.new(drawingInstances.Health.From.X, drawingInstances.Health.From.Y - (character.Humanoid.Health / character.Humanoid.MaxHealth) * boxSize.Y)
                                drawingInstances.Health.Color = esp.healthcolor
                                drawingInstances.Health.Visible = true
                
                                drawingInstances.HealthOutline.From = Vector2.new(drawingInstances.Health.From.X, boxPosition.Y + boxSize.Y + 1)
                                drawingInstances.HealthOutline.To = Vector2.new(drawingInstances.Health.From.X, (drawingInstances.Health.From.Y - 1 * boxSize.Y) -1)
                                drawingInstances.HealthOutline.Color = esp.healthoutline
                                drawingInstances.HealthOutline.Visible = true
            
                                if esp.fading then
                                    drawingInstances.Health.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                    drawingInstances.HealthOutline.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                else
                                    drawingInstances.Health.Transparency = 1 - esp.healthtransparency
                                    drawingInstances.HealthOutline.Transparency = 1 - esp.healthoutlinetransparency
                                end
                                if esp.healthbartext then
                                    drawingInstances.HealthText.Visible = true
                                    drawingInstances.HealthText.Text = string.format("%s", math.round(character.Humanoid.Health) .. "%")
                                    drawingInstances.HealthText.Position = Vector2.new(drawingInstances.Health.From.X - 15, drawingInstances.Health.From.Y - (character.Humanoid.Health / character.Humanoid.MaxHealth) * boxSize.Y)
                                    drawingInstances.HealthText.Color = esp.healthbartextcolor
                                    drawingInstances.HealthText.OutlineColor = esp.healthbartextoutline
                                    drawingInstances.HealthText.Font = Drawing.Fonts.Plex
                                    if esp.fading then
                                        drawingInstances.HealthText.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                    else
                                        drawingInstances.HealthText.Transparency = 1 - esp.healthbartexttransparency
                                    end
                                else
                                    drawingInstances.HealthText.Visible = false
                                end
                            else
                                drawingInstances.Health.Visible = false
                                drawingInstances.HealthOutline.Visible = false
                                drawingInstances.HealthText.Visible = false
                            end
                            if esp.chams then
                                drawingInstances.Cham.Parent = character
                                drawingInstances.Cham.FillColor = esp.chamscolor
                                drawingInstances.Cham.OutlineColor = esp.chamsoutline
                                if esp.fading then
                                    drawingInstances.Cham.FillTransparency = (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                    drawingInstances.Cham.OutlineTransparency = (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                else
                                    drawingInstances.Cham.FillTransparency = esp.chamstransparencyinline
                                    drawingInstances.Cham.OutlineTransparency = esp.chamstransparencyoutline
                                end
                            else
                                drawingInstances.Cham.Parent = nil
                            end
                            if esp.name then
                                drawingInstances.Name.Visible = true
                                drawingInstances.Name.Text = string.format("<%s>", character.Humanoid.DisplayName)
                                drawingInstances.Name.Position = Vector2.new(boxSize.X / 2 + boxPosition.X, boxPosition.Y - 16)
                                drawingInstances.Name.Color = esp.namecolor
                                drawingInstances.Name.OutlineColor = esp.nameoutline
                                drawingInstances.Name.Font = Drawing.Fonts.Plex
                                if esp.fading then
                                    drawingInstances.Name.Transparency = 1 - (math.sin(tick() * esp.espfadespeed) + 1) / 2
                                else
                                    drawingInstances.Name.Transparency = 1 - esp.nametransparency
                                end
                            else
                                drawingInstances.Name.Visible = false
                            end
                        else
                            drawingInstances.Box.Visible = false
                            drawingInstances.BoxOutline.Visible = false
                            drawingInstances.Health.Visible = false
                            drawingInstances.HealthOutline.Visible = false
                            drawingInstances.Cham.Parent = nil
                            drawingInstances.Name.Visible = false
                            drawingInstances.HealthText.Visible = false
                        end
                    end
                else
                    drawingInstances.Box.Visible = false
                    drawingInstances.BoxOutline.Visible = false
                    drawingInstances.Health.Visible = false
                    drawingInstances.HealthOutline.Visible = false
                    drawingInstances.Cham.Parent = nil
                    drawingInstances.Name.Visible = false
                    drawingInstances.HealthText.Visible = false
                end
            end
        end
    end
end))

players.PlayerAdded:Connect(LPH_JIT_ULTRA(function(player)
    esp.players[player] = {
        Box = draw.new("Square", {Visible = false, Filled = false, ZIndex = 999, Thickness = 1, Transparency = 1}),
        BoxOutline = draw.new("Square", {Visible = false, Filled = false, ZIndex = 1, Color = Color3.fromRGB(0,0,0), Thickness = 3, Transparency = 1}),
        Health = draw.new("Line", {Visible = false, ZIndex = 999, Thickness = 1, Color = Color3.fromRGB(0,255,0), Transparency = 1}),
        HealthOutline = draw.new("Line", {Visible = false, ZIndex = 0, Thickness = 3, Color = Color3.fromRGB(0,0,0), Transparency = 1}),
        Cham = Instance.new("Highlight"),
        Name = draw.new("Text", {Visible = false, Size = 13, Center = true, Outline = true, Font = Drawing.Fonts.Plex, Color = Color3.fromRGB(255,255,255),Transparency = 1}),
        HealthText = draw.new("Text", {Visible = false, Size = 13, Center = true, Outline = true, Font = Drawing.Fonts.Plex, Color = Color3.fromRGB(255,255,255), Transparency = 1})
    }
end))

players.PlayerRemoving:Connect(LPH_JIT_ULTRA(function(player)
    if esp.players[player] then
        for i, v in pairs(esp.players[player]) do
            if v then
                if v == "Cham" then
                    v.Parent = nil
                else
                    v:Remove()
                end
            end
        end
        esp.players[player] = nil
    end
end))

for i, v in next, players:GetPlayers() do
    if v ~= localplayer then
        esp.players[v] = {
            Box = draw.new("Square", {Visible = false, Filled = false, ZIndex = 999, Thickness = 1}),
            BoxOutline = draw.new("Square", {Visible = false, Filled = false, ZIndex = 1, Color = Color3.fromRGB(0,0,0), Thickness = 3}),
            Health = draw.new("Line", {Visible = false, ZIndex = 999, Thickness = 1, Color = Color3.fromRGB(0,255,0)}),
            HealthOutline = draw.new("Line", {Visible = false, ZIndex = 0, Thickness = 3, Color = Color3.fromRGB(0,0,0)}),
            Cham = Instance.new("Highlight"),
            Name = draw.new("Text", {Visible = false, Size = 13, Center = true, Outline = true, Font = Drawing.Fonts.Plex, Color = Color3.fromRGB(255,255,255)}),
            HealthText = draw.new("Text", {Visible = false, Size = 13, Center = true, Outline = true, Font = Drawing.Fonts.Plex, Color = Color3.fromRGB(255,255,255)})
        }
    end
end

function get__players1()
    local array = {}
    for i, v in next, players:GetPlayers() do
        if v ~= localplayer then
            if aimbot.isAlive(v) then
                table.insert(array, string.format("%s", v.Name))
            end
        end
    end
    return array
end

local pageCombat = library:Page({ Name = "Combat" })
local aimassistCombat = pageCombat:Section({ Name = "Aim Assist" })

local aimassist__drawing = {
    ["inner"] = draw.new("Circle", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        ZIndex = 10001
    }),
    ["outer"] = draw.new("Circle", {
        Visible = false,
        Thickness = 3,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        Color = Color3.fromRGB(0,0,0),
        ZIndex = 10000
    })
}

local silentaim__drawing = {
    ["inner"] = draw.new("Circle", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        ZIndex = 10001
    }),
    ["outer"] = draw.new("Circle", {
        Visible = false,
        Thickness = 3,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        Color = Color3.fromRGB(0,0,0),
        ZIndex = 10000
    }),
    ["line"] = draw.new("Line", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Color = Color3.fromRGB(0,0,0)
    })
}

local targetaim__drawing = {
    ["inner"] = draw.new("Circle", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        ZIndex = 10001
    }),
    ["outer"] = draw.new("Circle", {
        Visible = false,
        Thickness = 3,
        Transparency = 1,
        Radius = 500,
        NumSides = 64,
        Color = Color3.fromRGB(0,0,0),
        ZIndex = 10000
    }),
    ["line"] = draw.new("Line", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Color = Color3.fromRGB(0,0,0)
    }),
    ["highlight"] = Instance.new("Highlight"),
    ["indicator"] = draw.new("Text", {
        Visible = false, 
        Size = 13, 
        Center = true, 
        Outline = true, 
        Font = Drawing.Fonts.Plex,
        Color = Color3.fromRGB(255,255,255),Transparency = 1
    })
}

local spectator__drawing = {
    ["line"] = draw.new("Line", {
        Visible = false,
        Thickness = 1,
        Transparency = 1,
        Color = Color3.fromRGB(0,0,0)
    })
}

local crosshair__drawing = {
    top = draw.new("Line", {Color = Color3.fromRGB(255,255,255),Thickness = 1,Visible = false, ZIndex = 10000}),
    bottom = draw.new("Line", {Color = Color3.fromRGB(255,255,255),Thickness = 1,Visible = false, ZIndex = 10000}),
    left = draw.new("Line", {Color = Color3.fromRGB(255,255,255),Thickness = 1,Visible = false, ZIndex = 10000}),
    right = draw.new("Line", {Color = Color3.fromRGB(255,255,255),Thickness = 1,Visible = false, ZIndex = 10000}),
    topoutline = draw.new("Line", {Color = Color3.fromRGB(0, 0, 0),Thickness = 3,Visible = false, ZIndex = 9999}),
    bottomoutline = draw.new("Line", {Color = Color3.fromRGB(0, 0, 0),Thickness = 3,Visible = false, ZIndex = 9999}),
    leftoutline = draw.new("Line", {Color = Color3.fromRGB(0, 0, 0),Thickness = 3,Visible = false, ZIndex = 9999}),
    rightoutline = draw.new("Line", {Color = Color3.fromRGB(0, 0, 0),Thickness = 3,Visible = false, ZIndex = 9999}),
}

local Baseplate = Instance.new("Part", workspace)

local function applyProperty(part, props)
    if part == nil then return end
    for property, value in next, props do
        part[property] = value
    end
end

applyProperty(Baseplate, {
    Anchored = true,
    CastShadow = true,
    Transparency = 0,
    Color = Color3.fromRGB(99, 95, 98),
    Material = Enum.Material.Plastic,
    Size = Vector3.new(100000000, 20, 100000000),
    Position = Vector3.new(1000, 0, 1000),
    TopSurface = "Studs"
})

aimassistCombat:Toggle({ Name = "Enabled", Pointer = "%enabled" }):Keybind({ Default = Enum.KeyCode.Q, Pointer = "%keybind", Mode = "Toggle" })
aimassistCombat:Slider({ Name = "FOV", min = 10, max = 500, def = 500, pointer = "%radius"})
aimassistCombat:Slider({ Name = "Prediction", min = 1, max = 10, def = 5, decimals = 0.1, pointer = "%prediction"})
aimassistCombat:Toggle({ Name = "Sticky Aim", Default = true, Pointer = "%locktarget" })
aimassistCombat:Toggle({ Name = "Wall Check", Default = false, Pointer = "%wallcheck" })
aimassistCombat:Dropdown({ Name = "Hit Point", Options = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso" }, Default = "HumanoidRootPart", Pointer = "%aimpart" })
aimassistCombat:Dropdown({ Name = "Movement Type", Options = { "Camera", "Mouse" }, Default = "Camera", Pointer = "%movementtype" })
aimassistCombat:Slider({ Name = "Smoothing X", min = 0.0001, max = 1, def = 1, decimals = 0.0001, pointer = "%smoothingX"})
aimassistCombat:Slider({ Name = "Smoothing Y", min = 0.0001, max = 1, def = 1, decimals = 0.0001, pointer = "%smoothingY"})
aimassistCombat:Label({ Name = "if your using KRNL, don't use Mouse"})

local silentaimCombat = pageCombat:InDevSection({ Name = "Silent Aim", Side = "Right" })
silentaimCombat:Toggle({ Name = "Enabled", Pointer = "!enabled" })
silentaimCombat:Slider({ Name = "FOV", min = 10, max = 500, def = 500, pointer = "!radius"})
silentaimCombat:Dropdown({ Name = "Hit Point", Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso" }, Default = "HumanoidRootPart", Pointer = "!aimpart" })
silentaimCombat:Toggle({ Name = "Closest Part", Default = false, Pointer = "!closestpart" })
silentaimCombat:Toggle({ Name = "Anti-Ground Shot", Default = false, Pointer = "!antigroundshot" })
silentaimCombat:Toggle({ Name = "Anti-Curve", Default = false, Pointer = "!anticurve" })
silentaimCombat:Toggle({ Name = "Wall Check", Default = false, Pointer = "!wallcheck" })
--silentaimCombat:Toggle({ Name = "Auto Resolver", Default = false, Pointer = "!autoresolver" })
silentaimCombat:Label({ Name = "Prediction" })
silentaimCombat:Textbox({Text = "0.15", PlaceHolder = "Prediction", Pointer = "!prediction", Middle = false, ResetOnFocus = false})

local targetaim__prediction = 0
local targetaim__autoprediction = 0
local targetaimCombat = pageCombat:InDevSection({ Name = "Target Aim", Side = "Right" })
targetaimCombat:Toggle({ Name = "Enabled", Pointer = "#enabled" }):Keybind({ Default = Enum.KeyCode.E, Pointer = "#keybind", Mode = "Toggle" })
targetaimCombat:Slider({ Name = "FOV", min = 10, max = 500, def = 500, pointer = "#radius"})
targetaimCombat:Dropdown({ Name = "Hit Point", Options = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso" }, Default = "HumanoidRootPart", Pointer = "#aimpart" })
targetaimCombat:Toggle({ Name = "Wall Check", Default = false, Pointer = "#wallcheck" })
targetaimCombat:Toggle({ Name = "Auto Prediction (beta)", Default = false, Pointer = "#autoprediction" })
targetaimCombat:Toggle({ Name = "Look At", Pointer = "#lookat" })
targetaimCombat:Toggle({ Name = "Jump Offset", Pointer = "#jumpoffset" })
targetaimCombat:Slider({ Name = "Offset", min = -3, max = 1, def = 0, decimals = 0.01, pointer = "#jumpoffsetamt"})
targetaimCombat:Label({ Name = "Prediction" })
targetaimCombat:Textbox({Text = "0.15", PlaceHolder = "Prediction", Pointer = "#prediction", Middle = false, ResetOnFocus = false})

local pageVisuals = library:Page({ Name = "Visuals" })
local espVisuals = pageVisuals:Section({ Name = "ESP" })
local esp__events = event.new("esp__events")

espVisuals:Toggle({ Name = "Enabled", Default = false, Pointer = "^enabled", callback = function(state)
    esp.enabled = state
end})

local espBox = espVisuals:Toggle({ Name = "Box", Default = false, Pointer = "^box", callback = function(state)
    esp.box = state
end})
espBox:Colorpicker({Name = "Inline", Alpha = 0, Info = "Inline", Default = Color3.fromRGB(255,255,255), Pointer = "^boxinline"})
espBox:Colorpicker({Name = "Outline", Alpha = 0, Info = "Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "^boxoutline"})

esp__events:bindConnection(runservice.Heartbeat, "box&&", LPH_JIT_ULTRA(function()
    esp.boxcolor = library.pointers["^boxinline"]:get().Color; esp.boxoutline = library.pointers["^boxoutline"]:get().Color
    esp.boxtransparency = library.pointers["^boxinline"]:get().Transparency; esp.boxoutlinetransparency = library.pointers["^boxoutline"]:get().Transparency
end))

local espHealth = espVisuals:Toggle({ Name = "Health", Default = false, Pointer = "^health", callback = function(state)
    esp.health = state
end})
espHealth:Colorpicker({Name = "Inline", Alpha = 0, Info = "Inline", Default = Color3.fromRGB(0,255,0), Pointer = "^healthinline"})
espHealth:Colorpicker({Name = "Outline", Alpha = 0, Info = "Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "^healthoutline"})

esp__events:bindConnection(runservice.Heartbeat, "health&&", LPH_JIT_ULTRA(function()
    esp.healthcolor = library.pointers["^healthinline"]:get().Color; esp.healthoutline = library.pointers["^healthoutline"]:get().Color
    esp.healthtransparency = library.pointers["^healthinline"]:get().Transparency; esp.healthoutlinetransparency = library.pointers["^healthoutline"]:get().Transparency
end))

local espHealthBarText = espVisuals:Toggle({ Name = "Health Bar Text", Default = false, Pointer = "^healthbartext", callback = function(state)
    esp.healthbartext = state
end})
espHealthBarText:Colorpicker({Name = "Inline", Info = "Inline", Alpha = 0, Default = Color3.fromRGB(255,255,255), Pointer = "^healthbartextinline"})
espHealthBarText:Colorpicker({Name = "Outline", Info = "Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "^healthbartextoutline"})

esp__events:bindConnection(runservice.Heartbeat, "healthbartext&&", LPH_JIT_ULTRA(function()
    esp.healthbartextcolor = library.pointers["^healthbartextinline"]:get().Color; esp.healthbartextoutline = library.pointers["^healthbartextoutline"]:get().Color
    esp.healthbartexttransparency = library.pointers["^healthbartextinline"]:get().Transparency
end))

local espChams = espVisuals:Toggle({ Name = "Chams", Default = false, Pointer = "^chams", callback = function(state)
    esp.chams = state
end})
espChams:Colorpicker({Name = "Inline", Alpha = 0.5,Info = "Inline", Default = Color3.fromRGB(153,0.3,255), Pointer = "^chamsinline"})
espChams:Colorpicker({Name = "Outline", Alpha = 0.5,Info = "Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "^chamsoutline"})

esp__events:bindConnection(runservice.Heartbeat, "chams&&", LPH_JIT_ULTRA(function()
    esp.chamscolor = library.pointers["^chamsinline"]:get().Color; esp.chamsoutline = library.pointers["^chamsoutline"]:get().Color
    esp.chamstransparencyinline = library.pointers["^chamsinline"]:get().Transparency; esp.chamstransparencyoutline = library.pointers["^chamsoutline"]:get().Transparency
end))

local espName = espVisuals:Toggle({ Name = "Name", Default = false, Pointer = "^name", callback = function(state)
    esp.name = state
end})
espName:Colorpicker({Name = "Inline", Alpha = 0, Info = "Inline", Default = Color3.fromRGB(255,255,255), Pointer = "^nameinline"})
espName:Colorpicker({Name = "Outline", Info = "Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "^nameoutline"})

esp__events:bindConnection(runservice.Heartbeat, "name&&", LPH_JIT_ULTRA(function()
    esp.namecolor = library.pointers["^nameinline"]:get().Color; esp.nameoutline = library.pointers["^nameoutline"]:get().Color
    esp.nametransparency = library.pointers["^nameinline"]:get().Transparency
end))

espVisuals:Slider({Name = "Render Distance", min = 1, max = 1000, def = 1000, suffix = "m", decimals = 1, pointer = "^renderdistance", callback = function(value)
    esp.renderdistance = value
end})

espVisuals:Toggle({ Name = "ESP Fade", Default = false, Pointer = "^fade", callback = function(state)
    esp.fading = state
end})

espVisuals:Slider({Name = "ESP Fade Speed", min = 1, max = 10, def = 5, suffix = "*", decimals = 0.1, pointer = "^espfadespeed", callback = function(value)
    esp.espfadespeed = value
end})

local miscVisuals, crosshairVisuals = pageVisuals:MultiSection({ Sections = {"Misc", "Crosshair"}, Side = "Right", Size = 160 })

local fieldofviewEvent = event.new("fieldofviewEvent_")
miscVisuals:Toggle({Name = "Field Of View", Default = false, Pointer = "fieldofviewActive", callback = function(bool)
    if bool then
        old__fieldofview = camera.FieldOfView
        fieldofviewEvent:bindConnection(runservice.Heartbeat, "xzbnciyuasbyid", LPH_JIT_ULTRA(function()
            camera.FieldOfView = library.pointers["fieldofviewValue"]:get()
        end))
    else
        if azureConnections["xzbnciyuasbyid"] then fieldofviewEvent:unbindConnection("xzbnciyuasbyid") end
        camera.FieldOfView = old__fieldofview
    end
end})
miscVisuals:Slider({Name = "Field Of View Amount",min = 70, max = 120, def = 70, suffix = "°", decimals = 0.1, pointer = "fieldofviewValue" })

local crosshairToggle = crosshairVisuals:Toggle({ Name = "Enabled", Pointer = "crosshairEnabled", callback = function(state)
    for _, drawing in next, crosshair__drawing do
        if drawing then drawing.Visible = state end
    end
end})
crosshairToggle:Colorpicker({Name = "Inline", Info = "Inline", Default = Color3.fromRGB(255,255,255), Pointer = "crosshairColor"})
crosshairToggle:Colorpicker({Name = "Outline", Info = "Outline", Default = Color3.fromRGB(0,0,0), Pointer = "crosshairOutline"})
crosshairVisuals:Slider({Name = "Size",min = 1, max = 25, def = 25, suffix = "", decimals = 0.1, pointer = "crosshairSize" })
crosshairVisuals:Slider({Name = "Seperation",min = 1, max = 3, def = 3, suffix = "", decimals = 0.1, pointer = "crosshairSeperation" })
crosshairVisuals:Toggle({ Name = "Spin", Pointer = "crosshairSpin"})
crosshairVisuals:Slider({Name = "Speed",min = 1, max = 5, def = 1, suffix = "", decimals = 0.1, pointer = "crosshairSpinSpeed" })

local crosshair = {
    time = 0,
    vsize = 3,
    time2 = 0
}

local crosshairEvent = event.new("crosshairEvent")
crosshairEvent:bindConnection(runservice.RenderStepped, "crosshairEvent", LPH_JIT_ULTRA(function(dt)
    local mousePosition = userinputservice:GetMouseLocation()
    local size = library.pointers.crosshairSize:get()+(math.sin(crosshair.time))    
    crosshair.time = crosshair.time + dt
    crosshair.time2 = (crosshair.time*library.pointers.crosshairSpinSpeed:get())%360
    crosshair.vsize = crosshair.vsize + (3 - crosshair.vsize) * (dt*10)
    for _, drawing in next, crosshair__drawing do
        if drawing then
            if not _:find("outline") then
                drawing.Color = library.pointers["crosshairColor"]:get().Color
            else
                drawing.Color = library.pointers["crosshairOutline"]:get().Color
            end
        end
    end

    local vec2positions = {
        ["normal"] = {
            Vector2.new(1, 0),
            Vector2.new(0, -1),
            Vector2.new(0, 1),
            Vector2.new(-1, 0)
        },
        ["spin"] = {
            Vector2.new(math.sin(crosshair.time2), math.cos(crosshair.time2)),
            Vector2.new(math.sin(crosshair.time2+66), math.cos(crosshair.time2+66)),
            Vector2.new(math.sin(crosshair.time2+33), math.cos(crosshair.time2+33)),
            Vector2.new(math.sin(crosshair.time2+99), math.cos(crosshair.time2+99))
        }
    }
    
    if library.pointers.crosshairSpin:get() then

        local size__0 = size*crosshair.vsize
        local size__1 = size*(crosshair.vsize-library.pointers.crosshairSeperation:get()) 

        local function setvec2position(vec2)
            local from = mousePosition + vec2positions.spin[vec2]*size__1
            local to = mousePosition + vec2positions.spin[vec2]*size__0
            return {from, to}
        end
        
        local left = setvec2position(1);crosshair__drawing.left.From = left[1];crosshair__drawing.left.To = left[2];crosshair__drawing.leftoutline.From = left[1];crosshair__drawing.leftoutline.To = left[2]
        local right = setvec2position(2);crosshair__drawing.right.From = right[1];crosshair__drawing.right.To = right[2];crosshair__drawing.rightoutline.From = right[1];crosshair__drawing.rightoutline.To = right[2]
        local top = setvec2position(3);crosshair__drawing.top.From = top[1];crosshair__drawing.top.To = top[2];crosshair__drawing.topoutline.From = top[1];crosshair__drawing.topoutline.To = top[2]
        local bottom = setvec2position(4);crosshair__drawing.bottom.From = bottom[1];crosshair__drawing.bottom.To = bottom[2];crosshair__drawing.bottomoutline.From = bottom[1];crosshair__drawing.bottomoutline.To = bottom[2]
    else
        local size__0 = size*crosshair.vsize
        local size__1 = size*(crosshair.vsize-library.pointers.crosshairSeperation:get()) 
        local function setvec2position(vec2)
            local from = mousePosition + vec2positions.normal[vec2]*size__1
            local to = mousePosition + vec2positions.normal[vec2]*size__0
            return {from, to}
        end
        
        local left = setvec2position(1);crosshair__drawing.left.From = left[1];crosshair__drawing.left.To = left[2];crosshair__drawing.leftoutline.From = left[1];crosshair__drawing.leftoutline.To = left[2]
        local right = setvec2position(2);crosshair__drawing.right.From = right[1];crosshair__drawing.right.To = right[2];crosshair__drawing.rightoutline.From = right[1];crosshair__drawing.rightoutline.To = right[2]
        local top = setvec2position(3);crosshair__drawing.top.From = top[1];crosshair__drawing.top.To = top[2];crosshair__drawing.topoutline.From = top[1];crosshair__drawing.topoutline.To = top[2]
        local bottom = setvec2position(4);crosshair__drawing.bottom.From = bottom[1];crosshair__drawing.bottom.To = bottom[2];crosshair__drawing.bottomoutline.From = bottom[1];crosshair__drawing.bottomoutline.To = bottom[2]
    end
end))

local old__camera
miscVisuals:Toggle({Name = "No Recoil", Default = false, Pointer = "norecoilActive", callback = function(bool)
    if bool then
        local oldcamCF = camera.CFrame
        old__camera = camera
        camera.Parent = nil

        new__camera = Instance.new("Camera", workspace)
        applyProperty(new__camera, {
            CameraSubject = localplayer.Character.Humanoid ~= nil and localplayer.Character.Humanoid,
            CFrame = oldcamCF,
            CameraType = "Custom"
        })
    else
        if new__camera then
            new__camera:Destroy()
        end
        old__camera.Parent = workspace
    end
end})

local worldVisuals, combatVisuals, atmosphereVisuals = pageVisuals:MultiSection({ Sections = {"World", "Combat", "Atmosphere"}, Side = "Right", Size = 350 })
local timeofdayEvent = event.new("timeofdayEvent")
old__clocktime = lighting.ClockTime
worldVisuals:Toggle({ Name = "Time of Day", Pointer = ")timeofday", callback = function(state)
    if state then
        timeofdayEvent:bindConnection(runservice.Heartbeat, "timeofdayConn", LPH_JIT_ULTRA(function()
            lighting.ClockTime = library.pointers[")timeofday)"]:get()
        end))
    else
        if azureConnections["timeofdayConn"] then timeofdayEvent:unbindConnection("timeofdayConn") end
        if old__clocktime then
            lighting.ClockTime = old__clocktime
        end
    end
end})
worldVisuals:Slider({ Name = "Time of Day (hr)", min = 1, max = 24, def = 12, suffix = "hr", pointer = ")timeofday)" })
combatVisuals:Label({ Name = "< Aim Assist >" })

local aimassistShowFOV = combatVisuals:Toggle({ Name = "Show FOV", Pointer = "%showfov", callback = function(state)
    aimassist__drawing["inner"].Visible = state
    aimassist__drawing["outer"].Visible = state
end})
aimassistShowFOV:Colorpicker({ Info = "Aim Assist FOV", Default = Color3.fromRGB(255,0,0), Pointer = "%showfovcolor"})
aimassistShowFOV:Colorpicker({ Info = "Aim Assist FOV Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "%showfovcoloroutline"})
combatVisuals:Label({ Name = "< Silent Aim >" })
local silentaimShowFOV = combatVisuals:Toggle({ Name = "Show FOV", Pointer = "!showfov", callback = function(state)
    silentaim__drawing["inner"].Visible = state
    silentaim__drawing["outer"].Visible = state
end})
silentaimShowFOV:Colorpicker({ Info = "Silent Aim FOV", Default = Color3.fromRGB(255,255,255), Pointer = "!showfovcolor"})
silentaimShowFOV:Colorpicker({ Info = "Silent Aim FOV Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "!showfovcoloroutline"})
local silentaimLine = combatVisuals:Toggle({ Name = "Line", Pointer = "!line" })
silentaimLine:Colorpicker({ Info = "Color", Default = Color3.fromRGB(255,255,255), Pointer = "!linecolor"})
combatVisuals:Label({ Name = "< Target Aim >" }) 
local targetaimShowFOV = combatVisuals:Toggle({ Name = "Show FOV", Pointer = "#showfov", callback = function(state)
    targetaim__drawing["inner"].Visible = state
    targetaim__drawing["outer"].Visible = state
end})
targetaimShowFOV:Colorpicker({ Info = "Target Aim FOV", Default = Color3.fromRGB(255,255,255), Pointer = "#showfovcolor"})
targetaimShowFOV:Colorpicker({ Info = "Target Aim FOV Outline", Default = Color3.fromRGB(0, 0, 0), Pointer = "#showfovcoloroutline"})
local targetaimLine = combatVisuals:Toggle({ Name = "Line", Pointer = "#line" })
targetaimLine:Colorpicker({ Info = "Color", Default = Color3.fromRGB(255,255,255), Pointer = "#linecolor"})
local targetaimHitCham = combatVisuals:Toggle({ Name = "Hit Indicator", Pointer = "#hitindicator" })
targetaimHitCham:Colorpicker({ Info = "Color", Default = Color3.fromRGB(255,255,255), Pointer = "#hitindicatorcolor"})
local targetaimHighlight = combatVisuals:Toggle({ Name = "Highlight", Pointer = "#highlight" })
targetaimHighlight:Colorpicker({ Info = "Inline", Default = Color3.fromRGB(153,0.3,255), Pointer = "#highlightColor"})
targetaimHighlight:Colorpicker({ Info = "Outline", Default = Color3.fromRGB(0,0,0), Pointer = "#highlightOutline"})
local targetaimIndicators = combatVisuals:Toggle({ Name = "Indicators", Pointer = "#indicators" })
targetaimIndicators:Colorpicker({ Info = "Color", Default = Color3.fromRGB(153,0.3,255), Pointer = "#indicatorcolor"})
combatVisuals:Multibox({Name = "Indicators Misc:", Minimum = 1, Options = {"Visible", "Velocity"}, Default = {"Visible", "Velocity"}, Pointer = "#indicatorsmisc"})

local atmoshphereconns = event.new("asdoljn")
old__ambient = lighting.Ambient
local ambientToggle = atmosphereVisuals:Toggle({ Name = "Ambient", Pointer = "ambient", callback = function(state)
    if state then
        ambientconnection = atmoshphereconns:bindConnection(runservice.Heartbeat, "aihjb", LPH_JIT_ULTRA(function()
            lighting.Ambient = library.pointers.ambientColor:get().Color
        end))
    else
        if ambientconnection then ambientconnection:Disconnect() end
        lighting.Ambient = old__ambient
    end
end})
ambientToggle:Colorpicker({ Info = "Color", Default = old__ambient, Pointer = "ambientColor"})

old__fogcolor = lighting.FogColor
old__fogstart = lighting.FogStart
old__fogend = lighting.FogEnd
local fogToggle = atmosphereVisuals:Toggle({ Name = "Fog", Pointer = "fog", callback = function(state)
    if state then
        fogconnection = atmoshphereconns:bindConnection(runservice.Heartbeat, "aihzxjb", LPH_JIT_ULTRA(function()
            lighting.FogColor = library.pointers.fogcolor:get().Color
            lighting.FogStart = library.pointers.fogStart:get()
            lighting.FogEnd = library.pointers.fogEnd:get()
        end))
    else
        if fogconnection then fogconnection:Disconnect() end
        lighting.FogColor = old__fogcolor
        lighting.FogStart = old__fogstart
        lighting.FogEnd = old__fogend
    end
end})
fogToggle:Colorpicker({ Info = "Color", Default = old__fogcolor, Pointer = "fogcolor"})
atmosphereVisuals:Slider({Name = "Start",min = 1, max = 1000, def = 1000, suffix = "", decimals = 1, pointer = "fogStart" })
atmosphereVisuals:Slider({Name = "End",min = 1, max = 1000, def = 1000, suffix = "", decimals = 1, pointer = "fogEnd" })

old__cstop = lighting.ColorShift_Top
old__csbottom = lighting.ColorShift_Bottom
local colorshift_toggle = atmosphereVisuals:Toggle({ Name = "Color Shift", Pointer = "colorshift", callback = function(state)
    if state then
        colorshiftconnection = atmoshphereconns:bindConnection(runservice.Heartbeat, "aihcjb", LPH_JIT_ULTRA(function()
            lighting.ColorShift_Top = library.pointers.colorshiftTop:get().Color
            lighting.ColorShift_Bottom = library.pointers.colorshiftBottom:get().Color
        end))
    else
        if colorshiftconnection then colorshiftconnection:Disconnect() end
        lighting.ColorShift_Top = old__cstop
        lighting.ColorShift_Bottom = old__csbottom
    end
end})
colorshift_toggle:Colorpicker({ Info = "Top", Default = old__cstop, Pointer = "colorshiftTop"})
colorshift_toggle:Colorpicker({ Info = "Bottom", Default = old__csbottom, Pointer = "colorshiftBottom"})
atmosphereVisuals:Toggle({ Name = "Global Shadows", Pointer = "globalshadows", default = true, callback = function(state)
    lighting.GlobalShadows = state
end})

old__brightness = lighting.Brightness
atmosphereVisuals:Toggle({ Name = "Brightness", Pointer = "brightnessx", callback = function(state)
    if state then
        brightnesscon = atmoshphereconns:bindConnection(runservice.Heartbeat, "aihcjxxxxb", LPH_JIT_ULTRA(function()
            lighting.Brightness = library.pointers.brightnessamt:get()
        end))
    else
        if brightnesscon then brightnesscon:Disconnect() end
        lighting.Brightness = old__brightness
    end
end})
atmosphereVisuals:Slider({Name = "Brightness Amount",min = 1, max = 10, def = old__brightness, suffix = "", decimals = 1, pointer = "brightnessamt" })

local characterVisuals, spectatorVisuals = pageVisuals:MultiSection({ Sections = {"Character", "Spectator"}, Side = "Left" })

local charactervisualEvent = event.new("cvEvent")
local oldchar__color = {}
local charchams_toggle = characterVisuals:Toggle({ Name = "Material", Pointer = "charactermaterialActive", callback = function(state)
    if state then
        for i, v in next, localplayer.Character:GetDescendants() do
            if v:IsA("BasePart") then
                table.insert(oldchar__color, {v, v.Color})
            end
            if v:IsA("MeshPart") then
                table.insert(oldchar__color, {v, v.Color})
            end
        end

        characterconnection = charactervisualEvent:bindConnection(runservice.Heartbeat, "characterconnection", LPH_JIT_ULTRA(function()
            for i, v in next, localplayer.Character:GetDescendants() do
                if v:IsA("BasePart") then
                    if v.Material == library.pointers["charactermaterial"]:get() and v.Color == library.pointers.charactercolor:get().Color then else
                        v.Material = library.pointers["charactermaterial"]:get()
                        v.Color = library.pointers.charactercolor:get().Color
                    end
                end
            end
        end))
    else
        if characterconnection then charactervisualEvent:unbindConnection("characterconnection") end
        for i, v in next, localplayer.Character:GetDescendants() do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
            end
            if v:IsA("MeshPart") then
                v.Material = Enum.Material.Plastic
            end
        end
        for i, v in next, oldchar__color do
            for i2, v2 in next, localplayer.Character:GetDescendants() do
                if v2 == v[1] then
                    v2.Color = v[2]
                end
            end
        end
    end
end})
charchams_toggle:Colorpicker({Name = "Material Color", Info = "Color", Default = Color3.fromRGB(153,0.3,255), Pointer = "charactercolor"})
characterVisuals:Dropdown({ Name = "Material", Options = {"Plastic", "SmoothPlastic", "ForceField"}, Default = "Plastic", Pointer = "charactermaterial" })

local spectatorvisualEvent = event.new("svEvent")

spectatorVisuals:Toggle({ Name = "Spectate", Pointer = "spectatorenabled", callback = function(state)
    if state then
        spectatorloop = spectatorvisualEvent:bindConnection(runservice.Heartbeat, "spectatorconnection", LPH_JIT_ULTRA(function()
            if library.pointers["spectatorPlayer"] then
                library.pointers["spectatorPlayer"]:Refresh(get__players1())
                if library.pointers["spectatorPlayer"]:get() ~= "" then
                    if aimbot.isAlive(players[library.pointers["spectatorPlayer"]:get()]) and players[library.pointers["spectatorPlayer"]:get()] then
                        local character = players[library.pointers["spectatorPlayer"]:get()].Character
                        camera.CameraSubject = character.Humanoid
                        if library.pointers.spectatorvisualize:get() then
                            local _, onscreen1 = camera:WorldToScreenPoint(players[library.pointers["spectatorPlayer"]:get()].Character["Head" or "HumanoidRootPart"].Position)
                            local _, onscreen2 = camera:WorldToScreenPoint(localplayer.Character["Head" or "HumanoidRootPart"].Position)
                            spectator__drawing.line.Visible = onscreen1 and onscreen2 or false
                            spectator__drawing.line.Color = library.pointers.spectatorvisualColor:get().Color

                            local spec2Dpos__1 = camera:WorldToViewportPoint(players[library.pointers["spectatorPlayer"]:get()].Character.Head.Position)
                            local spec2Dpos__2 = camera:WorldToViewportPoint(localplayer.Character.Head.Position)
                            spectator__drawing.line.From = Vector2.new(spec2Dpos__2.X, spec2Dpos__2.Y)
                            spectator__drawing.line.To = Vector2.new(spec2Dpos__1.X, spec2Dpos__1.Y)
                        else
                            spectator__drawing.line.Visible = false
                        end
                    else
                        spectator__drawing.line.Visible = false
                    end
                else
                    spectator__drawing.line.Visible = false
                end
            else
                spectator__drawing.line.Visible = false
            end
        end))
    else
        if spectatorloop then spectatorloop:Disconnect() end
        camera.CameraSubject = character.isAlive() and localplayer.Character.Humanoid
        spectator__drawing.line.Visible = false
    end
end})
local visualizepos__ = spectatorVisuals:Toggle({ Name = "Visualize Positions", Pointer = "spectatorvisualize"})
visualizepos__:Colorpicker({ Info = "Color", Default = Color3.fromRGB(153,0.3,255), Pointer = "spectatorvisualColor"})
spectatorVisuals:Dropdown({ Name = "Players", Options = get__players1(), Default = "", Pointer = "spectatorPlayer" })
spectatorVisuals:Label({ Name = "Player Options will appear/update\nwhen Spectator is Enabled" })

local pageMisc = library:Page({ Name = "Misc" })
local movementMisc, chatMisc = pageMisc:MultiSection({ Sections = {"Movement", "Chat"}, Side = "Left", Size = 280 })
local flytoggle = movementMisc:Toggle({Name = "Fly", Default = false, Pointer = "flyenabled"})
flytoggle:Keybind({Default = nil,Pointer = "flykeybind", Mode = "Toggle"})
movementMisc:Dropdown({Name = "Fly Mode", Options = {"Always", "Keybind"}, Default = "Always", Pointer = "flymode"})
movementMisc:Slider({Name = "Fly Multiplier", Minimum = 0.1, Maximum = 5, Default = 0.1, Decimals = 0.1, Suffix = "*", Pointer = "flymultiplier"})
movementMisc:Toggle({Name = "Auto Jump", Default = false, Pointer = "autojumpenabled"})

local speedtoggle = movementMisc:Toggle({Name = "Speed", Default = false, Pointer = "speedenabled"})
speedtoggle:Keybind({Default = nil,Pointer = "speedkeybind", Mode = "Toggle"})
movementMisc:Dropdown({Name = "Speed Mode", Options = {"Always", "Keybind"}, Default = "Always", Pointer = "speedmode"})
movementMisc:Slider({Name = "Speed Multiplier", Minimum = 0.1, Maximum = 5, Default = 0.1, Decimals = 0.1, Suffix = "*", Pointer = "speedmultiplier"})

movementMisc:Toggle({Name = "Bunny Hop", Default = false, Pointer = "bhopenabled", callback = function(enabled)
    if enabled then
        local bhopevent = event.new("bhop")
        bhopevent:bindConnection(runservice.Heartbeat, "bhopConn1", LPH_JIT_ULTRA(function()
            if character.isAlive() then
                if userinputservice:IsKeyDown(Enum.KeyCode.Space) then
                    localplayer.Character.Humanoid.Jump = true
                    local dir = camera.CFrame.LookVector * Vector3.new(1,0,1)
                    local move = Vector3.new()
                    move = userinputservice:IsKeyDown(Enum.KeyCode.W) and move + dir or move
                    move = userinputservice:IsKeyDown(Enum.KeyCode.S) and move - dir or move
                    move = userinputservice:IsKeyDown(Enum.KeyCode.D) and move + Vector3.new(-dir.Z,0,dir.X) or move
                    move = userinputservice:IsKeyDown(Enum.KeyCode.A) and move + Vector3.new(dir.Z,0,-dir.X) or move
                    if move.Unit.X == move.Unit.X then
                        move = move.Unit
                        localplayer.Character.HumanoidRootPart.Velocity = Vector3.new(move.X * library.pointers.bhop_speed:get(), localplayer.Character.HumanoidRootPart.Velocity.Y, move.Z * library.pointers.bhop_speed:get())
                    end
                end
            end
        end))
    else
        if bhopconn then bhopconn:Disconnect() end
    end
end})
movementMisc:Slider({Name = "Bunny Hop Speed", Minimum = 25, Maximum = 150, Default = 25, Decimals = 0.1, Suffix = "", Pointer = "bhop_speed"})

local exploitsMisc = pageMisc:MultiSection({ Sections = {"Exploits"}, Side = "Right" })
--exploitsMisc:Toggle({Name = "Anti-Aimviewer", Default = false, Pointer = "antiaimviewerenabled"})
exploitsMisc:Toggle({Name = "No Jump Cooldown", Default = false, Pointer = "nojumpcooldownenabled"})
exploitsMisc:Toggle({Name = "No Slowdown", Default = false, Pointer = "noslowdownenabled"})

--[[
local shoot__assetid__audio = "3124331820"
soundsMisc:Toggle({Name = "Custom Shoot Sound", Default = false, Pointer = "customshootsound", callback = function(enabled)
    if enabled then
        local customaxcnon = event.new("customshootsoundevent")
        customshootsoundconn = customaxcnon:bindConnection(runservice.Heartbeat, "oajxncoax", LPH_JIT_ULTRA(function()
            for i, v in next, localplayer.Backpack:GetDescendants() do
                if v:IsA("Tool") then
                    if v:FindFirstChild("ShootSound") then
                        v.SoundId = "rbxassetid://" .. shoot__assetid__audio
                    end
                end
            end
            for i, v in next, localplayer.Character:GetDescendants() do
                if v:IsA("Tool") then
                    if v:FindFirstChild("ShootSound") then
                        v.SoundId = "rbxassetid://" .. shoot__assetid__audio
                    end
                end
            end
        end))
    else
        if customshootsoundconn then customshootsoundconn:Disconnect() end
        for i, v in next, localplayer.Backpack:GetDescendants() do
            if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                v.Handle.ShootSound.SoundId = "rbxassetid://1583819337"
            end
        end
        for i, v in next, localplayer.Character:GetDescendants() do
            if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                v.Handle.ShootSound.SoundId = "rbxassetid://1583819337"
            end
        end
    end
end})

--// desktop fixed this btw
soundsMisc:Dropdown({Name = "Shoot Sound", Options = {'Bameware', 'Bell', 'Bubble', 'Pick', 'Pop', 'Rust', 'Skeet', 'Neverlose', 'Minecraft'}, Default = "Bameware", Pointer = "customshootsoundsound", callback = function(chosen)
    if chosen == "Bameware" then
        shoot__assetid__audio = 3124331820
    elseif chosen == "Bell" then
        shoot__assetid__audio = 6534947240
    elseif chosen == "Bubble" then
        shoot__assetid__audio = 6534947588
    elseif chosen == "Pick" then
        shoot__assetid__audio = 1347140027    
    elseif chosen == "Pop" then
        shoot__assetid__audio = 198598793
    elseif chosen == "Rust" then
        shoot__assetid__audio = 1255040462 
    elseif chosen == "Skeet" then
        shoot__assetid__audio = 5633695679
    elseif chosen == "Neverlose" then
        shoot__assetid__audio = 6534948092
    elseif chosen == "Minecraft" then
        shoot__assetid__audio = 4018616850
    end
end})
]]
local worldMisc, autobuyMisc = pageMisc:MultiSection({ Sections = {"World", "Autobuy"}, Side = "right", size = 260 });
worldMisc:Dropdown({Name = "World", Options = {"Baseplate"}, Default = "Baseplate", Pointer = "worldType"})
worldMisc:Button({Name = "Teleport", callback = function()
    if library.pointers.worldType:get() == "Baseplate" then
        if character.isAlive() then
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(Baseplate.CFrame.X, Baseplate.CFrame.Y + 50, Baseplate.CFrame.Z)
        end
    end
end})

local autobuyBoolean
local function autobuyFunction(name)
   local shopItem = workspace.Ignored.Shop:FindFirstChild(name)
   for _, part in next, localplayer.Character:GetChildren() do
      if part:IsA("BasePart") then
         part.CanCollide = false
      end
   end
   autobuyBoolean = true
   localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(shopItem.Head.CFrame.X, shopItem.Head.CFrame.Y, shopItem.Head.CFrame.Z)
   wait(.5)
   fireclickdetector(shopItem.ClickDetector)
   for _, part in next, localplayer.Character:GetChildren() do
      if part:IsA("BasePart") then
         part.CanCollide = true
      end
   end
   localplayer.Character.HumanoidRootPart.CFrame = shared.currentPosition
   autobuyBoolean = false
end

autobuyMisc:Toggle({Name = "Auto Buy", Default = false, Pointer = "autobuyActive", callback = function(bool)
    if bool and character.isAlive() then
        shared.currentPosition = localplayer.Character.HumanoidRootPart.CFrame
        if character.isAlive() then
            -- 1
            if library.pointers.autobuyType:get() == "Gun" then
                if library.pointers.autobuyGun:get() == "Revolver" then
                    autobuyFunction("[Revolver] - $1339")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "Double Barrel" then
                    autobuyFunction("[Double-Barrel SG] - $1391")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "Silencer" then
                    autobuyFunction("[Silencer] - $412")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "AUG" then
                    autobuyFunction("[AUG] - $2421")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "Glock" then
                    autobuyFunction("[Glock] - $309")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "Shotgun" then
                    autobuyFunction("[Shotgun] - $1288")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "RPG" then
                    autobuyFunction("[RPG] - $6180")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "AR" then
                    autobuyFunction("[AR] - $1030")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "DrumGun" then
                    autobuyFunction("[DrumGun] - $3090")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "AK47" then
                    autobuyFunction("[AK47] - $2318")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "Tactical Shotgun" then
                    autobuyFunction("[TacticalShotgun] - $1803")
                    library.pointers.autobuyActive:set(false)
                elseif library.pointers.autobuyGun:get() == "LMG" then
                    autobuyFunction("[LMG] - $3863")
                    library.pointers.autobuyActive:set(false)
                end
            end

            -- 2
            if library.pointers.autobuyType:get() == "Food" then
                if library.pointers.autobuyFood:get() == "Pizza" then
                    autobuyFunction("[Pizza] - $10")
                    library.pointers.autobuyActive:set(false)
                end
            end

            -- 3
            if library.pointers.autobuyType:get() == "Ammo" then
                if library.pointers.autobuyAmmo:get() == "Revolver" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("12 [Revolver Ammo] - $52")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "Double Barrel" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("18 [Double-Barrel SG Ammo] - $52")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "Silencer" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("25 [Silencer Ammo] - $52")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "AUG" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("90 [AUG Ammo] - $82")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "Glock" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("30 [Glock Ammo] - $62")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "Shotgun" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("20 [Shotgun Ammo] - $62")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "RPG" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("5 [RPG Ammo] - $1030")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "AR" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("100 [AR Ammo] - $77")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "DrumGun" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("100 [DrumGun Ammo] - $206")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "AK47" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("90 [AK47 Ammo] - $82")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "Tactical Shotgun" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("20 [TacticalShotgun Ammo] - $62")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                elseif library.pointers.autobuyAmmo:get() == "LMG" then
                    for _ = 1, library.pointers.autobuyammoamount:get() do
                        wait(.5)
                        autobuyFunction("200 [LMG Ammo] - $309")
                        if not library.pointers.autobuyType:get() == "Ammo" then
                            break
                        end
                        if library.pointers.autobuyActive:get() == false or bool == false then
                            break
                        end
                    end
                end
            end
        end
    else
        if character.isAlive() and shared.currentPosition ~= nil then localplayer.Character.HumanoidRootPart.CFrame = shared.currentPosition end
    end
end})
autobuyMisc:Dropdown({Name = "Auto Buy Type", Options = {"Gun", "Ammo", "Food"}, Default = "Gun", Pointer = "autobuyType"})
autobuyMisc:Dropdown({Name = "Gun", Options = {"Revolver", "Double Barrel", "Silencer", "AUG", "Glock", "Shotgun", "RPG", "AR", "DrumGun", "AK47", "Tactical Shotgun", "LMG"}, Default = "Revolver", Pointer = "autobuyGun"})
autobuyMisc:Dropdown({Name = "Food", Options = {"Pizza"}, Default = "Pizza", Pointer = "autobuyFood"})
autobuyMisc:Dropdown({Name = "Ammo", Options = {"Revolver", "Double Barrel", "Silencer", "AUG", "Glock", "Shotgun", "RPG", "AR", "DrumGun", "AK47", "Tactical Shotgun", "LMG"}, Default = "Revolver", Pointer = "autobuyAmmo"})
autobuyMisc:Slider({Name = "Auto Buy Ammo Amount", Minimum = 1, Maximum = 50, Default = 1, Decimals = 0.1, Suffix = "", Pointer = "autobuyammoamount"})

local pageSettings = library:Page({ Name = "Settings" })
local settingsMenu = pageSettings:Section({ Name = "Menu", Side = "Left" })

settingsMenu:Keybind({ Name = "Toggle",Default = Enum.KeyCode.RightShift, Pointer = "uikeybind", Mode = "Toggle", callback = function(chosen)
    library:ChangeUIBind(chosen)
end})
settingsMenu:Label({ Name = "Custom Menu Name" })
settingsMenu:Textbox({Text = "Azure", PlaceHolder = "Custom Menu Name", Pointer = "custommenuname", Middle = false, ResetOnFocus = false, callback = function(name)
    library:Retitle(name)
end})
settingsMenu:Toggle({Name = "Watermark", Default = false, Pointer = "watermark", callback = function(boolean)
    library.watermark:Update("Visible", boolean)
end})
settingsMenu:Textbox({Text = "Azure | {fps} | {ping} | {time} | {date}", PlaceHolder = "Watermark Data",Pointer = "watermarkData", Middle = false, ResetOnFocus = false})

local settingsTheme = pageSettings:Section({ Name = "Theme", Side = "Right" })
settingsTheme:Dropdown({Name = "Themes", Pointer = "themedropdown", Options = {"Default","Snowy","Salmon","Bitch Bot","Kiriot Hub","Fatality","Red","Tokyo Night","Old Abyss","Onetap","NeverLose","Gamesense","Vape","Spotify","Zeebot v2","LegitSneeze","Abyss V2"}, Default = "Default", callback = function(selected)
    theme:set(selected, library)
end})
settingsTheme:Colorpicker({Name = "In Development", Info = "UI Accent", Default = Color3.fromRGB(164,219,232), Pointer = "uiindev", callback = function(color) library:UpdateColor("indevcolor", color) end})
settingsTheme:Colorpicker({Name = "Accent", Info = "UI Accent", Default = Color3.fromRGB(168,122,207), Pointer = "uiaccentcolor", callback = function(color) library:UpdateColor("accent", color) end})
settingsTheme:Colorpicker({Name = "Light Contrast", Info = "Light Contrast", Default = Color3.fromRGB(30,30,30), Pointer = "uilight", callback = function(color) library:UpdateColor("lightcontrast", color) end})
settingsTheme:Colorpicker({Name = "Dark Contrast", Info = "Dark Contrast", Default = Color3.fromRGB(25,25,25), Pointer = "uidark", callback = function(color) library:UpdateColor("darkcontrast", color) end})
settingsTheme:Colorpicker({Name = "Outline", Info = "Outline", Default = Color3.fromRGB(0,0,0), Pointer = "uioutline", callback = function(color) library:UpdateColor("outline", color) end})
settingsTheme:Colorpicker({Name = "Inline", Info = "Inline", Default = Color3.fromRGB(50,50,50), Pointer = "uiinline", callback = function(color) library:UpdateColor("inline", color) end})
settingsTheme:Colorpicker({Name = "Text Color", Info = "Text Color", Default = Color3.fromRGB(255,255,255), Pointer = "uitextcolor", callback = function(color) library:UpdateColor("textcolor", color) end})
settingsTheme:Colorpicker({Name = "Text Border", Info = "Text Border", Default = Color3.fromRGB(0,0,0), Pointer = "uitextborder", callback = function(color) library:UpdateColor("textborder", color) end})
local settingsConfig = pageSettings:Section({ Name = "Config", Side = "Right" })

local savedconfigsDropdown = settingsConfig:Dropdown({Name = "Saved Configs", Options = config:getFolder(), Default = "", callback = function(string) shared.SelectedCFG = string end})
settingsConfig:Label({Name = "Config Name"})
settingsConfig:Textbox({Text = "", PlaceHolder = "Config Name", Middle = true, ResetOnFocus = false,callback = function(string) 
    shared.ConfigName = string
end})
settingsConfig:Button({Name = "Save",confirmation = true, Callback = function()
    writefile("azure/configs/" .. shared.ConfigName, library:GetConfig())
    savedconfigsDropdown:Refresh(config:getFolder())
end})
settingsConfig:Button({Name = "Load",confirmation = true, Callback = function() 
    library:LoadConfig(readfile("azure/configs/" .. shared.SelectedCFG))
end})
settingsConfig:Button({Name = "Delete",confirmation = true, Callback = function() 
    if isfile("azure/configs/" .. shared.SelectedCFG) then
        delfile("azure/configs/" .. shared.SelectedCFG)
        savedconfigsDropdown:Refresh(config:getFolder())
        savedconfigsDropdown:set("")
    end
end})

local fpsEvent = event:new("FPSEvent")
fpsEvent:bindConnection(runservice.RenderStepped, "FPSEvent1", LPH_JIT_ULTRA(function(fps)
    if library.pointers.watermark:get() then
        local watermarkText_ = library.pointers.watermarkData:get()
        if watermarkText_:find("{fps}") then
            watermarkText_ = watermarkText_:gsub("{fps}", string.format("%sfps", math.round( 1/fps )))
        end
        if watermarkText_:find("{ping}") then
            watermarkText_ = watermarkText_:gsub("{ping}", string.format("%sms", tonumber(stats.Network.ServerStatsItem["Data Ping"]:GetValueString():split(".")[1])) )
        end
        if watermarkText_:find("{time}") then
            watermarkText_ = watermarkText_:gsub("{time}", string.format("%s", os.date("%X")))
        end
        if watermarkText_:find("{date}") then
            watermarkText_ = watermarkText_:gsub("{date}", string.format("%s", os.date("%x")))
        end
        library.watermark:Update("Title", watermarkText_)
        library.watermark:UpdateSize()
    end
end))

local movementEvent = event:new("movementEvent")
movementEvent:bindConnection(runservice.Heartbeat, "movementConnection", LPH_JIT_ULTRA(function()
    if library.pointers.speedenabled:get() then
        if library.pointers.speedmode:get() == "Always" then
            if character.isAlive() then
                if localplayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    localplayer.Character.HumanoidRootPart.CFrame = localplayer.Character.HumanoidRootPart.CFrame + localplayer.Character.Humanoid.MoveDirection * library.pointers.speedmultiplier:get()
                end
            end
        elseif library.pointers.speedmode:get() == "Keybind" then
            if library.pointers.speedkeybind:is_active() then
                if character.isAlive() then
                    if localplayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        localplayer.Character.HumanoidRootPart.CFrame = localplayer.Character.HumanoidRootPart.CFrame + localplayer.Character.Humanoid.MoveDirection * library.pointers.speedmultiplier:get()
                    end
                end
            end
        end
    end
    if library.pointers.flyenabled:get() then
        if library.pointers.flymode:get() == "Always" then
            local velVector3 = Vector3.new(0, 1, 0)
            if userinputservice:IsKeyDown(Enum.KeyCode.W) then
                velVector3 = velVector3 + (camera.CoordinateFrame.lookVector * library.pointers.flymultiplier:get() * 50)
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.A) then
                velVector3 = velVector3 + (camera.CoordinateFrame.rightVector * -library.pointers.flymultiplier:get() * 50)
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.S) then
                velVector3 = velVector3 + (camera.CoordinateFrame.lookVector * -library.pointers.flymultiplier:get() * 50)
            end
            if userinputservice:IsKeyDown(Enum.KeyCode.D) then
                velVector3 = velVector3 + (camera.CoordinateFrame.rightVector * library.pointers.flymultiplier:get() * 50)
            end
            
            if character.isAlive() then
                localplayer.Character.HumanoidRootPart.Velocity = velVector3
                if localplayer.Character.Humanoid:GetState() == "Landing" then
                    localplayer.Character.Humanoid:ChangeState("Landing")
                elseif localplayer.Character.Humanoid:GetState() == "Freefall" then
                    localplayer.Character.Humanoid:ChangeState("Freefall")
                end
            end
        elseif library.pointers.flymode:get() == "Keybind" then
            if library.pointers.flykeybind:is_active() then
                local velVector3 = Vector3.new(0, 1, 0)
                if userinputservice:IsKeyDown(Enum.KeyCode.W) then
                    velVector3 = velVector3 + (camera.CoordinateFrame.lookVector * library.pointers.flymultiplier:get() * 50)
                end
                if userinputservice:IsKeyDown(Enum.KeyCode.A) then
                    velVector3 = velVector3 + (camera.CoordinateFrame.rightVector * -library.pointers.flymultiplier:get() * 50)
                end
                if userinputservice:IsKeyDown(Enum.KeyCode.S) then
                    velVector3 = velVector3 + (camera.CoordinateFrame.lookVector * -library.pointers.flymultiplier:get() * 50)
                end
                if userinputservice:IsKeyDown(Enum.KeyCode.D) then
                    velVector3 = velVector3 + (camera.CoordinateFrame.rightVector * library.pointers.flymultiplier:get() * 50)
                end

                if character.isAlive() then
                    localplayer.Character.HumanoidRootPart.Velocity = velVector3
                    if localplayer.Character.Humanoid:GetState() == "Landing" then
                        localplayer.Character.Humanoid:ChangeState("Landing")
                    elseif localplayer.Character.Humanoid:GetState() == "Freefall" then
                        localplayer.Character.Humanoid:ChangeState("Freefall")
                    end
                end
            end
        end
    else
        if character.isAlive() then localplayer.Character.Humanoid:ChangeState("Landing") end
    end
    if character.isAlive() and library.pointers.autojumpenabled:get() and localplayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and localplayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
        localplayer.Character.Humanoid:ChangeState("Jumping")
    end
    if library.pointers.nojumpcooldownenabled:get() then
        if character.isAlive() then
            localplayer.Character.Humanoid.UseJumpPower = false
        end
    else
        if character.isAlive() then
            localplayer.Character.Humanoid.UseJumpPower = true
        end
    end
    if library.pointers.noslowdownenabled:get() then
        if character.isAlive() then
            local slowdownEffects = {
                "NoWalkSpeed",
                "NoJumping",
                "ReduceWalk"
            }
            --// desktop fixed this ;)
            for _, effect in next, slowdownEffects do
                if localplayer.Character.BodyEffects.Movement:FindFirstChild(effect) then
                    localplayer.Character.BodyEffects.Movement:FindFirstChild(effect):Destroy()
                end
            end
            if localplayer.Character.BodyEffects.Reload.Value == true then
                localplayer.Character.BodyEffects.Reload.Value = false
            end
        end
    end
end))

local aimassistEvent = event:new("aimassistEvent")
local aimassistPlayer
local aimassistBool
aimassistEvent:bindConnection(runservice.RenderStepped, "%aimassistConnection1", LPH_JIT_ULTRA(function()
    if library.pointers["%enabled"]:get() then
        if not library.pointers["%locktarget"]:get() then
            if aimassistPlayer ~= nil and aimassistPlayer.player ~= nil and aimassistPlayer.player.Character ~= nil and aimbot.isAlive(aimassistPlayer.player) then
                local aimassistKOBool = aimassistPlayer.player.Character.BodyEffects["K.O"].Value ~= nil and aimassistPlayer.player.Character.BodyEffects["K.O"].Value
                if aimassistKOBool == false then
                    aimbot.aimat(
                        aimassistPlayer.player, 
                        aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Position + Vector3.new(aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Velocity.X, -0, aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Velocity.Z) / library.pointers["%prediction"]:get(), 
                        library.pointers["%smoothingX"]:get(), 
                        library.pointers["%smoothingY"]:get(), 
                        library.pointers["%movementtype"]:get()
                    )
                end
            end
        end
    end
end))

task.spawn(function()
    while wait() do
        if library.pointers["%enabled"]:get() then
            if not library.pointers["%locktarget"]:get() then
                aimassistPlayer = aimbot.getPlayer(library.pointers["%radius"]:get(), library.pointers["%aimpart"]:get(), library.pointers["%wallcheck"]:get())
            end
        end
    end
end)

aimassistEvent:bindConnection(userinputservice.InputBegan, "%aimassistConnection2", LPH_JIT_ULTRA(function(input, isrbx)
    if not isrbx then
        if library.pointers["%enabled"]:get() and library.pointers["%locktarget"]:get() then
            if input.KeyCode == library.pointers["%keybind"]:getkeybind() or input.UserInputType == library.pointers["%keybind"]:getkeybind() then
                aimassistBool = not aimassistBool
                aimassistPlayer = aimbot.getPlayer(library.pointers["%radius"]:get(), library.pointers["%aimpart"]:get(), library.pointers["%wallcheck"]:get())
                if aimassistBool then
                    aimassistEvent:bindConnection(runservice.RenderStepped, "%aimassistConnection0172391", LPH_JIT_ULTRA(function()
                        if library.pointers["%enabled"]:get() and aimassistBool then
                            if library.pointers["%locktarget"]:get() then
                                if aimassistPlayer ~= nil and aimassistPlayer.player ~= nil and aimassistPlayer.player.Character ~= nil and aimbot.isAlive(aimassistPlayer.player) then
                                    local aimassistKOBool = aimassistPlayer.player.Character.BodyEffects["K.O"].Value ~= nil and aimassistPlayer.player.Character.BodyEffects["K.O"].Value
                                    if aimassistKOBool == false then
                                        aimbot.aimat(
                                            aimassistPlayer.player, 
                                            aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Position + Vector3.new(aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Velocity.X, -0, aimassistPlayer.player.Character[library.pointers["%aimpart"]:get()].Velocity.Z) / library.pointers["%prediction"]:get(), 
                                            library.pointers["%smoothingX"]:get(), 
                                            library.pointers["%smoothingY"]:get(), 
                                            library.pointers["%movementtype"]:get()
                                        )
                                    end
                                end
                            end
                        end
                    end))
                elseif aimassistBool == false then
                    if azureConnections["aimassistConnection0172391"] then aimassistEvent:unbindConnection("aimassistConnection0172391") end
                end
            end
        end
    end
end))
    
aimassistEvent:bindConnection(mouse.Move, "%aimassistConnection3", LPH_JIT_ULTRA(function()
    local mousePosition = userinputservice:GetMouseLocation()
    aimassist__drawing["inner"].Position = mousePosition
    aimassist__drawing["outer"].Position = mousePosition

    aimassist__drawing["inner"].Radius = library.pointers["%radius"]:get()
    aimassist__drawing["outer"].Radius = library.pointers["%radius"]:get()

    aimassist__drawing["inner"].Color = library.pointers["%showfovcolor"]:get().Color
    aimassist__drawing["outer"].Color = library.pointers["%showfovcoloroutline"]:get().Color
end))

local silentaimEvent = event:new("silentaimEvent")
silentaimEvent:bindConnection(mouse.Move, "!silentaimConnection2", LPH_JIT_ULTRA(function()
    local mousePosition = userinputservice:GetMouseLocation()
    silentaim__drawing["inner"].Position = mousePosition
    silentaim__drawing["outer"].Position = mousePosition

    silentaim__drawing["inner"].Radius = library.pointers["!radius"]:get()
    silentaim__drawing["outer"].Radius = library.pointers["!radius"]:get()

    silentaim__drawing["inner"].Color = library.pointers["!showfovcolor"]:get().Color
    silentaim__drawing["outer"].Color = library.pointers["!showfovcoloroutline"]:get().Color
end))

local anticurveBoolean
silentaimEvent:bindConnection(runservice.Heartbeat, "!silentaimConnection3", LPH_JIT_ULTRA(function()
    if library.pointers["!enabled"]:get() and library.pointers["!anticurve"]:get() then
        if silentaimPlayer ~= nil and silentaimPlayer.player ~= nil and silentaimPlayer.player.Character ~= nil and aimbot.isAlive(silentaimPlayer.player) and character.isAlive() then
            anticurveBoolean = true
            shared.anticurve__currentpos = localplayer.Character.HumanoidRootPart.CFrame
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(localplayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(silentaimPlayer.player.Character.HumanoidRootPart.CFrame.X, localplayer.Character.HumanoidRootPart.CFrame.Position.Y, silentaimPlayer.player.Character.HumanoidRootPart.CFrame.Z))
            runservice.RenderStepped:Wait()
            localplayer.Character.HumanoidRootPart.CFrame = shared.anticurve__currentpos
            anticurveBoolean = false
        end
    end
end))

local anticurveBoolean
silentaimEvent:bindConnection(runservice.Heartbeat, "!silentaimConnection4", LPH_JIT_ULTRA(function()
    if library.pointers["!enabled"]:get() and library.pointers["!line"]:get() then
        if silentaimPlayer ~= nil and silentaimPlayer.player ~= nil and silentaimPlayer.player.Character ~= nil and aimbot.isAlive(silentaimPlayer.player) and character.isAlive() then
            local pos
            if library.pointers["!closestpart"]:get() then
                pos = library.pointers["!antigroundshot"]:get() and shared.ClosestPart + Vector3.new(silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.X, -0, silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.Z) * library.pointers["!prediction"]:get() or shared.ClosestPart + silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity * library.pointers["!prediction"]:get()
            else
                pos = library.pointers["!antigroundshot"]:get() and silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Position + Vector3.new(silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.X, -0, silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.Z) * library.pointers["!prediction"]:get() or silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Position + silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity * library.pointers["!prediction"]:get()
            end
            local _, onscreen = camera:WorldToScreenPoint(pos)
            silentaim__drawing.line.Visible = onscreen
            silentaim__drawing.line.Color = library.pointers["!linecolor"]:get().Color

            local targetaim__plr2D = camera:WorldToViewportPoint(pos)
            silentaim__drawing.line.From = userinputservice:GetMouseLocation()
            silentaim__drawing.line.To = Vector2.new(targetaim__plr2D.X, targetaim__plr2D.Y)
        else
            silentaim__drawing.line.Visible = false
        end
    else
        silentaim__drawing.line.Visible = false
    end
    --[[
    if library.pointers["!enabled"]:get() and library.pointers["!autoresolver"]:get() then
        if silentaimPlayer ~= nil and silentaimPlayer.player ~= nil and silentaimPlayer.player.Character ~= nil and aimbot.isAlive(silentaimPlayer.player) then
            if silentaimPlayer.player.Character["HumanoidRootPart" or "Head"].Velocity.Magnitude > 19 then 
                function getVel()
                    local lastPosition = silentaimPlayer.player.Character.HumanoidRootPart.Position 
                    wait(1)
                    local currentPosition = silentaimPlayer.player.Character.HumanoidRootPart.Position
                    local newVelocity = (currentPosition - lastPosition) / 1
                    return newVelocity
                end
                silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity = getVel()
            end
        end
    end
    ]]
end))

local targetaimEvent = event:new("targetaimEvent")
targetaimEvent:bindConnection(mouse.Move, "#targetaimfovupdate", LPH_JIT_ULTRA(function()
    local mousePosition = userinputservice:GetMouseLocation()
    targetaim__drawing["inner"].Position = mousePosition
    targetaim__drawing["outer"].Position = mousePosition

    targetaim__drawing["inner"].Radius = library.pointers["#radius"]:get()
    targetaim__drawing["outer"].Radius = library.pointers["#radius"]:get()

    targetaim__drawing["inner"].Color = library.pointers["#showfovcolor"]:get().Color
    targetaim__drawing["outer"].Color = library.pointers["#showfovcoloroutline"]:get().Color
end))

local targetaim__enabled
local targetaim__player
local targetaim__indicators = {}
targetaimEvent:bindConnection(userinputservice.InputBegan, "#targetaimConnection", LPH_JIT_ULTRA(function(input, isrbx)
    if not isrbx then
        if input.KeyCode == library.pointers["#keybind"]:getkeybind() or input.UserInputType == library.pointers["#keybind"]:getkeybind() then
            targetaim__enabled = not targetaim__enabled
            targetaim__player = aimbot.getPlayer(library.pointers["#radius"]:get(), library.pointers["#aimpart"]:get(), library.pointers["#wallcheck"]:get())
            if targetaim__enabled then
                indicatorsconn = targetaimEvent:bindConnection(runservice.Heartbeat, "czx", LPH_JIT_ULTRA(function()
                    if library.pointers["#enabled"]:get() and library.pointers["#indicators"]:get() then
                        if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil and aimbot.isAlive(targetaim__player.player) then
                            local _, onscreen = camera:WorldToScreenPoint(targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position)
                            targetaim__drawing.indicator.Visible = onscreen

                            local player2D = camera:WorldToViewportPoint(targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position)
                            targetaim__drawing.indicator.Position = Vector2.new(player2D.X, player2D.Y)
                            targetaim__drawing.indicator.Color = library.pointers["#indicatorcolor"]:get().Color

                            local targetaim__indicator__text = ""
                            if table.find(library.pointers["#indicatorsmisc"]:get(), "Visible") then
                                local visible = workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p, targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position - camera.CFrame.p), { workspace.Ignored, camera, localplayer.Character, targetaim__player.player.Character }) == nil and "VISIBLE" or "NOT VISIBLE"
                                targetaim__indicator__text = targetaim__indicator__text .. string.format("%s\n", visible)
                            end
                            if table.find(library.pointers["#indicatorsmisc"]:get(), "Velocity") then
                                targetaim__indicator__text = targetaim__indicator__text .. string.format("X:%s, Y:%s, Z:%s\n", math.round(targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity.X),math.round(targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity.Y),math.round(targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity.Z))
                            end
                            targetaim__drawing.indicator.Text = targetaim__indicator__text
                        else
                            targetaim__drawing.indicator.Visible = false
                        end
                    else
                        targetaim__drawing.indicator.Visible = false
                    end
                end))
                lookatconn = targetaimEvent:bindConnection(runservice.Heartbeat, "xonon", LPH_JIT_ULTRA(function()
                    if library.pointers["#enabled"]:get() and library.pointers["#lookat"]:get() then
                        localplayer.Character.Humanoid.AutoRotate = false
                        if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil and aimbot.isAlive(targetaim__player.player) then
                            localplayer.Character.Humanoid.AutoRotate = false
                            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(localplayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(targetaim__player.player.Character.HumanoidRootPart.CFrame.X, localplayer.Character.HumanoidRootPart.CFrame.Position.Y, targetaim__player.player.Character.HumanoidRootPart.CFrame.Z))
                        end
                    end
                end))
                local targetaim__player__health = aimbot.isAlive(targetaim__player.player) and targetaim__player.player.Character.Humanoid.Health
                hitindicatorconnction_ix = aimbot.isAlive(targetaim__player.player) and targetaim__player.player.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if library.pointers["#hitindicator"]:get() and localplayer.Character.BodyEffects.GunFiring.Value == true then
                        if aimbot.isAlive(targetaim__player.player) then
                            if targetaim__player.player.Character.Humanoid.Health < targetaim__player__health then
                                local newindicator = Instance.new("Part", workspace)
                                table.insert(targetaim__indicators, newindicator)
                                applyProperty(newindicator, {
                                    Anchored = true,
                                    CastShadow = false,
                                    Transparency = 0,
                                    Color = library.pointers["#hitindicatorcolor"]:get().Color,
                                    Material = Enum.Material.ForceField,
                                    Size = Vector3.new(1,1,1)
                                })
                                newindicator.Position = shared.shootpos
                                wait(1.2)
                                newindicator.Position = Vector3.new()
                            end
                        end
                        targetaim__player__health = aimbot.isAlive(targetaim__player.player) and targetaim__player.player.Character.Humanoid.Health
                    end
                end)
                targetaim__connection = targetaimEvent:bindConnection(runservice.Heartbeat, "#allah", LPH_JIT_ULTRA(function()
                    if library.pointers["#enabled"]:get() then
                        if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil and aimbot.isAlive(targetaim__player.player) then
                            if library.pointers["#line"]:get() then
                                local pos = library.pointers["#jumpoffset"]:get() and targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position + Vector3.new(0, shared.JumpOffset, 0) + targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity * targetaim__prediction or targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position + targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity * targetaim__prediction
                                local _, onscreen = camera:WorldToScreenPoint(pos)
                                targetaim__drawing.line.Visible = onscreen
                                targetaim__drawing.line.Color = library.pointers["#linecolor"]:get().Color

                                local targetaim__plr2D = camera:WorldToViewportPoint(pos)
                                targetaim__drawing.line.From = userinputservice:GetMouseLocation()
                                targetaim__drawing.line.To = Vector2.new(targetaim__plr2D.X, targetaim__plr2D.Y)
                            else
                                targetaim__drawing.line.Visible = false
                            end
                        else
                            targetaim__drawing.line.Visible = false
                        end
                    else
                        targetaim__drawing.line.Visible = false
                    end
                end))
                targetaim__connection2 = targetaimEvent:bindConnection(runservice.Heartbeat, "#allah2", LPH_JIT_ULTRA(function()
                    if library.pointers["#enabled"]:get() then
                        if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil and aimbot.isAlive(targetaim__player.player) then
                            if library.pointers["#highlight"]:get() then
                                targetaim__drawing.highlight.Enabled = true
                                targetaim__drawing.highlight.FillColor = library.pointers["#highlightColor"]:get().Color
                                targetaim__drawing.highlight.OutlineColor = library.pointers["#highlightOutline"]:get().Color
                                targetaim__drawing.highlight.Parent = targetaim__player.player.Character
                            else
                                targetaim__drawing.highlight.Enabled = false
                            end
                        else
                            targetaim__drawing.highlight.Enabled = false
                        end
                    else
                        targetaim__drawing.highlight.Enabled = false
                    end
                end))
            elseif targetaim__enabled == false then
                if targetaim__connection then targetaimEvent:unbindConnection("#allah") end
                if hitindicatorconnction_ix then hitindicatorconnction_ix:Disconnect() end
                if targetaim__connection2 then targetaim__connection2:Disconnect() end
                if lookatconn then lookatconn:Disconnect() end
                if indicatorsconn then indicatorsconn:Disconnect() end
                targetaim__drawing.line.Visible = false
                targetaim__drawing.highlight.Parent = nil
                localplayer.Character.Humanoid.AutoRotate = true
                for i, v in next, targetaim__indicators do
                    if v then v.Position = Vector3.new() end 
                end
                targetaim__drawing.indicator.Visible = false
            end
        end
    end
end))

targetaimEvent:bindConnection(runservice.Heartbeat, "#targetaimConnection_x", LPH_JIT_ULTRA(function()
    if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil then
        if aimbot.isAlive(targetaim__player.player) then
            if library.pointers["#jumpoffset"]:get() and targetaim__player.player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                shared.JumpOffset = library.pointers["#jumpoffsetamt"]:get()
            else
                shared.JumpOffset = 0
            end
        end
    end
    if library.pointers["#autoprediction"]:get() then
        targetaim__prediction = targetaim__autoprediction
    else
        targetaim__prediction = library.pointers["#prediction"]:get()
    end
    --ELEGANT WORK ON THIS, DONT DO ANYTHING ELSE!
    if library.pointers["#autoprediction"]:get() then
        local ping = tonumber(stats.Network.ServerStatsItem["Data Ping"]:GetValueString():split(".")[1])
        if ping < 100 then
            targetaim__autoprediction = 0.141987
        elseif ping < 80 then
            targetaim__autoprediction = 0.139340
        elseif ping < 70 then
              targetaim__autoprediction = 0.12533
              elseif ping < 65 then
              targetaim__autoprediction = 0.1264236
        elseif ping < 50 then
              targetaim__autoprediction = 0.13544
        elseif ping < 30 then
     targetaim__autoprediction = 0.11252476
        end
    end
end))

task.spawn(function()
    while wait() do
        if library.pointers["!enabled"]:get() then
            silentaimPlayer = aimbot.getPlayer(library.pointers["!radius"]:get(), library.pointers["!aimpart"]:get(), library.pointers["!wallcheck"]:get())
        end
        if library.pointers["!enabled"]:get() and library.pointers["!closestpart"]:get() then
            if silentaimPlayer ~= nil and silentaimPlayer.player ~= nil and silentaimPlayer.player.Character ~= nil then
                shared.ClosestPart = silentaimPlayer.player.Character[tostring(aimbot.getclosestpart(silentaimPlayer.player.Character))].Position
            end
        end
    end
end)

old__namecall2 = gamerawmetatable.__namecall;gamerawmetatable.__namecall = newcclosure(function(...)
    local arguments = {...}
    if getnamecallmethod() == "FireServer" and arguments[2] == "UpdateMousePos"
    then
        if silentaimPlayer ~= nil and silentaimPlayer.player ~= nil and silentaimPlayer.player.Character ~= nil and library.pointers["!enabled"]:get() then
            if library.pointers["!closestpart"]:get() then
                if shared.ClosestPart ~= nil then
                    local pos = library.pointers["!antigroundshot"]:get() and shared.ClosestPart + Vector3.new(silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.X, -0, silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.Z) * library.pointers["!prediction"]:get() or shared.ClosestPart + silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity * library.pointers["!prediction"]:get()
                    arguments[3] = pos
                    return old__namecall2(table.unpack(arguments))
                end
            else
                local pos = library.pointers["!antigroundshot"]:get() and silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Position + Vector3.new(silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.X, -0, silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity.Z) * library.pointers["!prediction"]:get() or silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Position + silentaimPlayer.player.Character[library.pointers["!aimpart"]:get()].Velocity * library.pointers["!prediction"]:get()
                arguments[3] = pos
                return old__namecall2(table.unpack(arguments))
            end
        end
    end
    return old__namecall2(...)
end)

old__namecall3 = gamerawmetatable.__namecall;gamerawmetatable.__namecall = newcclosure(function(...)
    local arguments = {...}
    if getnamecallmethod() == "FireServer" and arguments[2] == "UpdateMousePos"
    then
        if targetaim__player ~= nil and targetaim__player.player ~= nil and targetaim__player.player.Character ~= nil and library.pointers["#enabled"]:get() and targetaim__enabled then
            local pos = library.pointers["#jumpoffset"]:get() and targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position + Vector3.new(0, shared.JumpOffset, 0) + targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity * targetaim__prediction or targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Position + targetaim__player.player.Character[library.pointers["#aimpart"]:get()].Velocity * targetaim__prediction
            arguments[3] = pos
            shared.shootpos = arguments[3]
            return old__namecall3(table.unpack(arguments))
        end
    end
    return old__namecall3(...)
end)

old__index = gamerawmetatable.__index;gamerawmetatable.__index = newcclosure(function(self, property)
    if anticurveBoolean and library.pointers["!anticurve"]:get() then
        if not checkcaller() then
            if property == "CFrame" and library.pointers["!anticurve"]:get() and anticurveBoolean and character.isAlive() then
                if self == localplayer.Character.HumanoidRootPart then
                    return shared.anticurve__currentpos or 
                    CFrame.new()
                elseif self == localplayer.Character.Head then
                    return shared.anticurve__currentpos and shared.currentPosition + Vector3.new(0, localplayer.Character.HumanoidRootPart.Size / 2 + 0.5, 0) or 
                    CFrame.new()
                end
            end
        end
    end
    return old__index(self, property)
end)

old__index2 = gamerawmetatable.__index;gamerawmetatable.__index = newcclosure(function(self, property)
    if autobuyBoolean then
        if not checkcaller() then
            if property == "CFrame" and autobuyBoolean and character.isAlive() then
                if self == localplayer.Character.HumanoidRootPart then
                    return shared.currentPosition or 
                    CFrame.new()
                elseif self == localplayer.Character.Head then
                    return shared.currentPosition and shared.currentPosition + Vector3.new(0, localplayer.Character.HumanoidRootPart.Size / 2 + 0.5, 0) or 
                    CFrame.new()
                end
            end
        end
    end
    return old__index2(self, property)
end)

--// desktop fixed this btw
if library:Initialize() then library:Initialize() end

game:GetService("StarterGui"):SetCore("SendNotification",{Title = "azure (temporary notif)",Text = string.format("Took %ss", math.round((tick() - loadtick)) * 1000 / 1000),Duration = 3.6})