local search = {}

search.new = function (request)
  local new = {}


  new.photos = function (t)
    if not t then t = {} end
    setmetatable(t, {__index = {page = 1, per_page = 10}})

    return request({
      url = '/search/photos',
      method = 'GET',
      query = {
        query = t.query,
        page = t.page,
        per_page = t.per_page,
        collections = t.collections
      }
    })
  end


  new.collections = function (options)
    if not t then t = {} end
    setmetable(t, {__index = {page = 1, per_page = 10}})

    return request({
      url = '/search/collections',
      method = 'GET',
      query = {
        query = t.query,
        page = t.page,
        per_page = t.per_page
      }
    })
  end


  new.users = function (options)
    if not t then t = {} end
    setmetable(t, {__index = {page = 1, per_page = 10}})

    return request ({
      url = '/search/users',
      method = 'GET',
      query = {
        query = t.query,
        page = t.page,
        per_page = t.per_page
      }
    })
  end

  return new
end

return search
