--!strict

local RUN_SERVICE = game:GetService("RunService")
local TWEEN_SERVICE = game:GetService("TweenService")
local TWEEN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0)
local CONFIG = require(script.config)

local class = {}
local CLASS_METATABLE = {__index = class}
local GUI = script:WaitForChild("Notification") :: CanvasGroup

local instance: Notificator = nil

type self = {screen_gui: ScreenGui, notifications: {[number]: {instance: CanvasGroup, expire_at: number, is_playing: boolean, is_destroying: boolean}}, curr_y: number}
export type Notificator = typeof(setmetatable({} :: self, CLASS_METATABLE))

local function calc_text_size(text_label: TextLabel)
  while text_label.TextBounds.Y == 0 do
    task.wait()
  end
  return text_label.TextBounds.Y
end

local function calc_scaled_text(obj: CanvasGroup, base_size: number)
  local screen_resolution = game:GetService("Workspace").CurrentCamera.ViewportSize
  local scale_factor = screen_resolution.X / 1920
  local new_text_size = base_size * scale_factor
  return new_text_size
end

function class:notify(type, description: string, lifetime: number)
  local notification = GUI:Clone()
  local title = notification:WaitForChild("Title") :: TextLabel
  title.Text = string.upper(type)
  title.TextSize = calc_scaled_text(notification, 28)
  local color = notification:WaitForChild("Color") :: Frame
  color.BackgroundColor3 = CONFIG[type].color
  local icon = notification:WaitForChild("Icon") :: ImageLabel
  icon.Image = CONFIG[type].icon
  local desc = notification:WaitForChild("Description") :: TextLabel
  desc.TextSize = calc_scaled_text(notification, 20)
  desc.Text = description
  
  notification.Parent = instance.screen_gui

  local text_size = calc_text_size(desc) 
	notification.Size = UDim2.fromOffset(notification.AbsoluteSize.X, notification.AbsoluteSize.Y + text_size)
  notification.Position = UDim2.new(1, 300, 0, instance.curr_y)
  
  local title_text_size = calc_text_size(title)
  desc.Position = UDim2.new(title.Position.X.Scale, 0, title.Position.Y.Scale, title_text_size - 2)
  
  table.insert(instance.notifications, {instance = notification, expire_at = tick() + lifetime, is_playing = false, is_destroying = false})
  instance:_update_positions()
end

function class:_update_positions()
  if #instance.notifications == 1 then
    local notification = instance.notifications[1].instance
    if instance.notifications[1].is_playing then return end
    instance.notifications[1].is_playing = true
    local tween = TWEEN_SERVICE:Create(notification, TWEEN_INFO, {Position = UDim2.new(1, -15, 0, instance.curr_y)})
    tween:Play()
    tween.Completed:Once(function()
      if instance.notifications[1] ~= nil and instance.notifications[1].is_playing ~= nil then
        instance.notifications[1].is_playing = false
      end
    end)
  else
    for _, notification in instance.notifications do
      if notification.is_playing then return end
      notification.is_playing = true
      local tween = TWEEN_SERVICE:Create(notification.instance, TWEEN_INFO, {Position = UDim2.new(1, -15, 0, instance.curr_y)})
      tween:Play()
      tween.Completed:Once(function()
        notification.is_playing = false
      end)
      instance.curr_y = instance.curr_y + notification.instance.AbsoluteSize.Y + 15
    end
  end
end

function class:_update_notifications()
  local curr_time = tick()
  local to_remove = {}
  for i, notification in instance.notifications do
    if notification and notification.expire_at and notification.expire_at <= curr_time then
      table.insert(to_remove, i)
    end
  end
  for _, index in to_remove do
    local notification = instance.notifications[index]
    if notification then
      if not notification.is_destroying then
        notification.is_destroying = true
        local tween = TWEEN_SERVICE:Create(notification.instance, TWEEN_INFO, {Position = UDim2.new(1, 300, 0, notification.instance.Position.Y.Offset), GroupTransparency = 1})
        tween:Play()
        tween.Completed:Once(function()
          notification.instance:Destroy()
          notification.is_destroying = false
        end)
      end
      table.remove(instance.notifications, index)
    end
  end
  instance.curr_y = 15
  instance:_update_positions()
end

local function Notificator(player_gui: PlayerGui?): Notificator
  if instance then return instance end

  local screen_gui: ScreenGui = Instance.new("ScreenGui")
  screen_gui.Name = "Notifications"
  screen_gui.IgnoreGuiInset = true
  screen_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  instance = setmetatable({
    notifications = {},
    curr_y = 15,
    screen_gui = screen_gui,
  }, CLASS_METATABLE)

  RUN_SERVICE.Heartbeat:Connect(function(delta: number)
    instance:_update_notifications()
  end)

  screen_gui.Parent = player_gui
  
  return instance
end

return Notificator
