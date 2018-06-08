local categories = {}

categories.new = function(request)
  local new = {}

  new.listCategories = function ()
    return request({
      url = '/categories',
      method = 'GET'
    })
  end

  new.category = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end
    return request({
      url = '/categories/' .. tostring(t.id),
      method = 'GET'
    })
  end

  new.categoryPhotos = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end
    setmetatable(t, { __index = {page = 1, per_page = 10}})

    return request({
      url = '/categories/' .. tostring(t.id) .. '/photos',
      method = 'GET',
      query = {
        page = t.page,
        per_page = t.per_page
      }
    })
  end

  return new
end


return categories
