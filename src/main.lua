-- Consts
WINDOW_W = 800
WINDOW_H = 600



-- first, we create a matrix multiplication function
-- even if we will multiply 2x1 and 2x2 matrices
-- after all, it’s a didactic project, isn’t it ?

function matProd(pM1, pM2)
  -- you can multiply matrices only if
  -- the number of columns of the first matrix
  -- equal the number of lines of the second one
  -- print('Dans matProd')
   -- print(pM1, pM2)
    if #pM1[1] ~= #pM2 then      
        return nil      
    end 

    local result = {}
    
    for l1 = 1, #pM1 do
        result[l1] = {}
        for c2 = 1, #pM2[1] do
            result[l1][c2] = 0
            for l2 = 1, #pM2 do
                result[l1][c2] = result[l1][c2] + pM1[l1][l2] * pM2[l2][c2]
            end
        end
    end

    return result
end


-- identity function (no transform)
function id(pCoord)
 -- useless function but shows that
 -- x_transf = x * 1 + y * O = x
 -- y_transf = x * 0 + y * 1 = y
  local identity = {{1, 0},
                    {0, 1}}

  return matProd({pCoord}, identity)[1]

end


function horizontalFlip(pCoord)
  -- x_transf = x * -1 + y * 0 = -x
  -- y_transf = x * 0 + y * 1 = y

  local hFlip = {{-1, 0},
                 {0, 1}}
  
  return matProd({pCoord}, hFlip)[1]

end


function verticalFlip(pCoord)
  -- x_transf = x * 1 + y * 0 = x
  -- y_transf = x * 0 + y * -1 = -y

  local vFlip = {{1, 0},
                 {0, -1}}

  return matProd({pCoord}, vFlip)[1]

end


function scale(pCoord, pSx, pSy)
  -- scaling matrix
  -- x_transf = x * Sx + y * 0 = x * Sx
  -- y_transf = x * 0 + y * Sy = y * sY
  local scaling = {{pSx, 0},
                   {0, pSy}}

  return matProd(pCoord, scaling)[1] 

end


function rotate(pCoord, pAngle)
  -- rotation matrix, clockwise
  -- x_transf = x * cos(angle) + y * sin(angle)
  -- y_transf = -sin(angle) * x + y * cos(angle) 

  local radAngle = math.rad(pAngle)
  local rotation = {{math.cos(radAngle), math.sin(radAngle)},
              {-math.sin(radAngle), math.cos(radAngle)}}

  return matProd({pCoord}, rotation)[1]

end


function rotate_counter(pCoord, pAngle)
  -- rotation matrix, counter-clockwise
  -- x_transf = x * cos(angle) - sin(angle) * y
  -- y_transf = x * sin(angle) + cos(angle) + y
  
  local radAngle = math.rad(pAngle)
  local rotation_counter = {{math.cos(radAngle), -math.sin(radAngle)},
                            {math.sin(radAngle), math.cos(radAngle)}}

  return matProd({pCoord}, rotation_counter)[1]

end
-- print('TRANSF declaration')
-- TRANSF = {
--   ID = id(),
--   SCALE = scale(),
--   ROTATE = rotate(),
--   C_ROTATE = rotate_counter()
-- }
-- print('fin de declaration TRANSF')

function love.load()
  --print('dans load()')

  love.window.setMode(WINDOW_W, WINDOW_H)
  love.window.setTitle('2x2 matrices 2D transformations demo')

  showHelp = false
  -- transformation = 'ID'
  auth = false
  pointsLst = {{100, 100},
               {140, 100},
               {140, 180},
               {100, 180},
               {100, 160},
               {120, 140},
               {100, 120},
               {100, 100}
          }

end


function love.update(dt)

  -- print(auth)
  -- print(transformation)

  if auth == true then

    
   --print('dans update()')
    for i, point in ipairs(pointsLst) do
     -- print(point[1], point[2])
      if transformation == 'ID' then
        -- point = TRANSF.transformation(point)
        pointsLst[i] = id(point)
      end
      if transformation == 'ROT' then
        pointsLst[i] = rotate(point, 10)
      end
      if transformation == 'CROT' then
        pointsLst[i] = rotate_counter(point, 10)
      end
      if transformation == 'VFLIP' then
        pointsLst[i] = verticalFlip(point)
      end
      if transformation == 'HFLIP' then
        pointsLst[i] = horizontalFlip(point)
      end
    end
    auth = false
    --for i, point in ipairs(pointsLst) do
    --  print(point[1], point[2])
    --end

  end     

  
end


function love.draw()
  -- print('dans draw()')

  local originX = WINDOW_W/2
  local originY = WINDOW_H/2

  -- draw axes
  love.graphics.setColor(1,0,0)
  love.graphics.line(0, originY, WINDOW_W, originY)
  love.graphics.line(originX, 0, originX, WINDOW_H)
  love.graphics.setColor(1, 1, 1)

  for idx=1, #pointsLst-1 do
    love.graphics.line(
                        pointsLst[idx][1] + originX, 
                        pointsLst[idx][2] + originY, 
                        pointsLst[idx+1][1] + originX, 
                        pointsLst[idx+1][2] + originY
                        ) 
  end


  if showHelp == true then
    love.graphics.print('‘i’ for identity', 10, 20)
    love.graphics.print('’h’ for horizontal flip', 10, 40)
    love.graphics.print('’v’ for vertical flip', 10, 60)
    love.graphics.print('’r’ for rotation, 10° pace', 10, 80)
    love.graphics.print('’c’ for counter-rotation, 10° pace', 10, 100)
    love.graphics.print('’x/y and +/-’ for scaling x or y, ±10%', 10, 120)
    love.graphics.print('’up/down’ for y shear, ±10%', 10, 140)
    love.graphics.print('’left/right’ for x shear, ±10%', 10, 160)
  end

end


function love.keypressed(key)

  -- print('dans keypressed()')

  if key == 'escape' then
    love.event.quit()
  end

  if key == 'r' then
    transformation = 'ROT'
    auth = true
  end

  if key == 'i' then
    transformation = 'ID'
    auth = true
  end

  if key == 'h' then
    transformation = 'HFLIP'
    auth = true
  end

  if key == 'v' then
    transformation = 'VFLIP'
    auth = true
  end

  if key == 'c' then
    transformation = 'CROT'
    auth = true
  end

  if key == 'space' then
    showHelp = not showHelp
  end

end
