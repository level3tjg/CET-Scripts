Noclip = {
  enabled = false,
  yaw = 0
}

registerForEvent("onUpdate", function()
  if (ImGui.IsKeyPressed(string.byte('L'), false)) then
    Noclip.enabled = not Noclip.enabled
    Noclip.yaw = 0
  end
  if (Noclip.enabled) then
    local player = Game.GetPlayer()
    local position = player:GetWorldPosition()
    local speed = 1
    if (ImGui.IsKeyDown(16)) then
      speed = speed * 2
    elseif (ImGui.IsKeyDown(string.byte('Z'))) then
      speed = speed / 2
    end
    local x = position['x']
    local y = position['y']
    local z = position['z']
    if (ImGui.IsKeyDown(string.byte('A'))) then
      Noclip.yaw = Noclip.yaw + speed * 2
    end
    if (ImGui.IsKeyDown(string.byte('D'))) then
      Noclip.yaw = Noclip.yaw - speed * 2
    end
    local yaw = Noclip.yaw % 360
    local a1 = speed * math.tan(yaw % 90 / 100)
    local a2 = speed * math.tan((90 - yaw % 90) / 100)
    local quad = math.floor(yaw / 90) + 1
    if (ImGui.IsKeyDown(string.byte('W'))) then
      if (quad == 1) then
        y = y + a2
        x = x - a1
      elseif (quad == 2) then
        y = y - a1
        x = x - a2
      elseif (quad == 3) then
        y = y - a2
        x = x + a1
      elseif (quad == 4) then
        y = y + a1
        x = x + a2
      end
    end
    if (ImGui.IsKeyDown(string.byte('S'))) then
      if (quad == 1) then
        y = y - a2
        x = x + a1
      elseif (quad == 2) then
        y = y + a1
        x = x + a2
      elseif (quad == 3) then
        y = y + a2
        x = x - a1
      elseif (quad == 4) then
        y = y - a1
        x = x - a2
      end
    end
    if (ImGui.IsKeyDown(17)) then
      z = z - speed
    end
    if (ImGui.IsKeyDown(32)) then
      z = z + speed
    end
    local tf = Game.GetTeleportationFacility() 
    tf:Teleport(player, Vector4.new(x, y, z, 1), EulerAngles.new(0, 0, yaw))
  end
end)