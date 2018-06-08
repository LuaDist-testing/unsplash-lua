local collections = {}

collections.new = function (request)
  local new = {}

  new.listCollections = function (t)
    setmetatable(t, {__index = {page = 1, per_page = 10, type = "regular"}})

    local path
    if t.type == "featured" then
      path = "/collections/featured"
    elseif t.type == "curated" then
      path = "/collections/curated"
    else
      path = "/collections"
    end

    return request ({
      url = path,
      method = "GET",
      query = {
        page = t.page,
        per_page = t.per_page
      }
    })
  end

  new.getCollection = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end

    setmetatable(t, {__index = {type = "regular"}})

    local path
    if t.curated == "curated" then
      path = "/collections/curated/" .. tostring(t.id)
    else
      path = "/collections/" .. tostring(t.id)
    end

    return request ({
      url = path,
      method = "GET"
    })
  end

  new.getCollectionPhotos = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end

    setmetatable(t, { __index = {type = "regular", page = 1, per_page = 10}})

    local path
    if t.type == "curated" then
      path = "/collections/curated/" .. tostring(t.id) .. "/photos"
    else
      path = "/collections/" .. tostring(t.id) .. "/photos"
    end

    return request ({
      url = path,
      method = "GET",
      query = {
        page = t.page,
        per_page = t.per_page
      }
    })
  end

  new.listRelatedCollection = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end
    return request ({
      url = "/collections/" .. tostring(t.id) .. "/related",
      method = "GET"
    })
  end


  return new
end
return collections
