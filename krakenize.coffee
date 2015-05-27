class $kdb
	constructor: (@url, @username, @password) ->

	helper: (how,data,next)->
		xmlHttp = new XMLHttpRequest()
		xmlHttp.open(how, @url, false)
		xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded")
		xmlHttp.setRequestHeader("Authorization", "Basic " + btoa("#{@username}:#{@password}"))
		xmlHttp.send(data)
		next(JSON.parse(xmlHttp.responseText))

	_helper: (how,data,next)->
		xmlHttp = new XMLHttpRequest()
		xmlHttp.open(how, @url, false)
		xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded")
		xmlHttp.setRequestHeader("Authorization", "Basic " + btoa("#{@username}:#{@password}"))
		xmlHttp.send(data)
		JSON.parse(xmlHttp.responseText)

	get: (next)->
		@helper("GET", null, next)

	post: (data,next)->
		keys = Object.keys data
		_data = "" 
		for i in keys
			_data += encodeURIComponent(i)+"="+encodeURIComponent(data[i])
		data = _data.slice(0,-1)
		@helper("POST", data, next)

	update: (next)->
		@helper("UPDATE", null, next)

	remove: (next)->
		@helper("DELETE", null, next)

	_get: ()->
		@_helper("GET", null)

	_post: (data)->
		keys = Object.keys data
		_data = "" 
		for i in keys
			_data += encodeURIComponent(i)+"="+encodeURIComponent(data[i])
		data = _data.slice(0,-1)
		@_helper("POST", data)

	_update: ()->
		@_helper("UPDATE", null)

	_remove: ()->
		@_helper("DELETE", null)
