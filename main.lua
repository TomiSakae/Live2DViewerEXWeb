function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 50
    player.y = love.graphics.getHeight() / 2
    player.sprite = love.graphics.newImage('assets/RedWand.png')
    player.width = player.sprite:getWidth()
    player.height = player.sprite:getHeight()

    background = love.graphics.newImage('assets/background.jpg')

    -- Đặt kích thước cửa sổ khởi tạo và tối đa
    love.window.setMode(1280, 720)

    -- Danh sách để chứa các viên đạn
    bullets = {}
end

function love.update(dt)
    -- Cập nhật vị trí của từng viên đạn
    for i, bullet in ipairs(bullets) do
        bullet.x = bullet.x + bullet.speed * dt

        -- Xóa viên đạn nếu nó ra khỏi màn hình
        if bullet.x > love.graphics.getWidth() then
            table.remove(bullets, i)
        end
    end
end

function love.draw()
    -- Lấy kích thước cửa sổ hiện tại
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    -- Lấy kích thước của hình ảnh background
    local bgWidth = background:getWidth()
    local bgHeight = background:getHeight()

    -- Tính toán tỷ lệ để background vừa với cửa sổ
    local scaleX = windowWidth / bgWidth
    local scaleY = windowHeight / bgHeight

    -- Vẽ background với kích thước đã được điều chỉnh
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

    -- Vẽ player
    love.graphics.draw(player.sprite, player.x, player.y, nil, 10)

    -- Vẽ các viên đạn
    love.graphics.setColor(1, 0, 0) -- Đặt màu đỏ cho viên đạn
    for _, bullet in ipairs(bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.size, bullet.size)
    end
    love.graphics.setColor(1, 1, 1) -- Đặt lại màu về mặc định
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        spawnBullet(x, y)
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    spawnBullet(x, y)
end

function spawnBullet(x, y)
    -- Kiểm tra nếu nhấn vào player
    if x >= player.x and x <= player.x + player.width * 10 and
       y >= player.y and y <= player.y + player.height * 10 then
        -- Tạo một viên đạn mới
        local bullet = {}
        bullet.x = player.x + player.width * 10 -- Vị trí ban đầu của viên đạn
        bullet.y = player.y + (player.height * 10) / 2 - 5 -- Căn giữa viên đạn với player
        bullet.size = 10 -- Kích thước viên đạn
        bullet.speed = 500 -- Tốc độ di chuyển của viên đạn
        table.insert(bullets, bullet) -- Thêm viên đạn vào danh sách
    end
end
