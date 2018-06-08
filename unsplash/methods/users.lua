local users = {}

users.new = function (request)
  local new = {}

  new.getUser = function (t)
    if not t then t = {} end
    if not t.username then
      return {body = "ERROR: username not specified on request"}
    end

    return request({
      url = '/users/' .. tostring(t.username),
      method = 'GET',
      query = {
        w = t.width,
        h = t.height
      }
    })
  end


  new.getUserPortfolio = function (username)
    if not username then
      return {body = "ERROR: username not specified on request"}
    end
    return request({
      url = '/users/' .. username .. '/portfolio',
      method = 'GET'
    })
  end


  new.listUserPhotos = function (t)
    if not t then t = {} end
    if not t.username then
      return {body = "ERROR: username not specified on request"}
    end

    setmetatable(t, {
      __index = {
      page = 1,
      per_page = 10,
      order_by = "latest",
      stats = false,
      resolution = "days",
      quantity = 30
    }})

    return request({
      url = '/users/' .. tostring(t.username) .. '/photos',
      method = 'GET',
      query = {
        page = t.page,
        per_page = t.per_page,
        order_by = t.order_by,
        stats = t.stats,
        resolution = t.resolution,
        quantity = t.quantity
      }
    })
  end


  new.listUserLikes = function (t)
    if not t then t = {} end
    if not t.username then
      return {body = "ERROR: username not specified on request"}
    end
    setmetatable(t, {__index = {page = 1, per_page = 10, order_by = "latest"}})

    return request({
      url = '/users/' .. tostring(t.username) .. '/likes',
      method = 'GET',
      query = {
        page = t.page,
        per_page = t.per_page,
        order_by = t.order_by
      }
    })
  end


  new.listUserCollections = function (t)
    if not t then t = {} end
    if not t.username then
      return {body = "ERROR: username not specified on request"}
    end
    setmetatable(t, {__index = {page = 1, per_page = 10, order_by = "latest"}})


    return request({
      url = '/users/' .. tostring(t.username) .. 'collections',
      method = 'GET',
      query = {
        page = t.page,
        per_page = t.per_page
      }
    })
  end


  new.getUserStats = function (t)
    if not t then t = {} end
    if not t.username then
      return {body = "ERROR: username not specified on request"}
    end
    setmetatable(t, {__index = {resolution = "days", quantity = 30}})

    return request({
      url = '/users/' .. tostring(t.username) ..'/statistics',
      method = 'GET',
      query = {
        resolution = t.resolution,
        quantity = t.quantity
      }
    })
  end

  return new
end

return users
