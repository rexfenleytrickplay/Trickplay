--local source = {}

local adapter = {
	name = "Google Images Search",
	logoUrl = "adapter/Google/logo.png",
	logoscale = {0.3,0.3},
	hasImages = true,
	{
		name = "public",
		caption = function(data)
			if (type(data.responseData) == "table" and data.responseData.results[1] ~= nil) then
				return "Url: "..data.responseData.results[1].visibleUrl.."\nInfo: "..data.responseData.results[1].titleNoFormatting 
			else
				return ""
			end
		end,
		required_inputs = {
			format = "QUERY",
			query = "space",
		},
		albums = function() end,
		photos = function(search,current_pic) return "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="..search.."&rsz=1&start="..current_pic.."&imgsz=xxlarge" end,
		site = function(data) 
			if (type(data.responseData) == "table" and data.responseData.results[1] ~= nil) then
				return data.responseData.results[1].unescapedUrl
			else
				return "" 
			end
		end
		
	}
}

function adapter:getCaption()
	-- some caption of the album
	return "hello"
end

function adapter:getAlbums()
	return {}
end

function adapter:getPhotos(album,start,num_images)

end

function adapter:loadCovers(slot,search, start_index)

	local request = URLRequest {
	url = "http://ajax.googleapis.com/ajax/services/search/images?"..
              "v=1.0&q="..search.."&rsz=1&start="..start_index..
              "&imgsz=xxlarge",
	on_complete = function (request, response)
		local data = json:parse(response.body)
		if (type(data.responseData) == "table" and data.responseData.results[1] ~= nil) then
			local site = data.responseData.results[1].unescapedUrl or ""
         --if (not dontswap) then
			   Load_Image(adapter,site,search,slot)
			--end
		else
			Load_Image(adapter,"assets/none.png",search,slot)
			print(i)
			self.hasImages = false
		end
	end
	}
	request:send()
end

return adapter
