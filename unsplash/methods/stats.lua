local stats = {}

stats.new = function (request)
  new = {}

  new.total = function ()
    return request({
      url = '/stats/total',
      method = 'GET'
    })
  end

  return new
end

return stats
