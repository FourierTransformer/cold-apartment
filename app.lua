-- load up the lapis!
local lapis = require("lapis")
local app = lapis.Application()

-- cache to keep everything going smoothly
local cache = require("lapis.cache")
local cached = cache.cached

-- load up my config.
local config = require("lapis.config").get()

-- enable etlua and set the base template
app:enable("etlua")
app.layout = require("views.baseLayout")

-- absolute zero is cold, right?
local temp = -273.15 

app:get("/", cached(function()
    return { render = "index" }
end))

app:get("/api/v1/status", cached(function()
    return { json = {
        temperature = {
            temp = temp
        }   
    }
  }
end))

-- basic auth? maybe one of these days!
app:post('/api/v1/' .. config.my_secret .. '/:temp', function(self)
    -- set the new temp
    temp = self.params.temp

    -- delete the cache
    cache.delete_path("/api/v1/status")

    -- maybe return something better than this? eh... soon.
    return 'hi'
end)

return app
