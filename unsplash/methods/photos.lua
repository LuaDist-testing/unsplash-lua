local photos = {}

photos.new = function (request)
  local new = {}


  new.listPhotos = function (t)
    setmetatable(t, {__index = {page = 1, per_page = 10, order_by = "latest", curated = false}})

    local path
    if not t.curated then
      path = "/photos"
    else
      path = "/photos/curated"
    end

    return request({
      url = path,
      method = 'GET',
      query = {
        page = t.page,
        per_page = t.per_page,
        order_by = t.order_by
      }
    })
  end

  new.getPhoto = function (t)
    if not t then t = {} end
    if not t.id then
      return {body = "ERROR: ID not specified on request"}
    end

    return request({
      url = '/photos/' .. tostring(t.id),
      method = 'GET',
      query = {
        width = t.width,
        height = t.height,
        rectangle = t.rectangle
      }
    })
  end

  new.getRandomPhoto = function (t)
    if not t then t = {} end
    return request({
      url = '/photos/random',
      method = 'GET',
      query = {
        count = t.count,
        height = t.height,
        query = t.query,
        width = t.width,
        username = t.username,
        featured = t.featured,
        collections = t.collections
      }
    })
  end

  new.getPhotoStats = function (id)
    if not id then
      return {body = "ERROR: ID not specified on request"}
    end
    return request({
      url = '/photos/' .. tostring(id) .. '/stats',
      method = 'GET'
    })
  end


  new.getPhotoDownloadLink = function (id)
    if not id then
      return {body = "ERROR: ID not specified on request"}
    end
    return request({
      url = '/photos/' .. tostring(id) .. '/download',
      method = 'GET'
    })
  end

  return new
end

return photos
