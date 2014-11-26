request = require 'request'

module.exports =
class Refheap
  constructor: (@user, @token, @url='https://www.refheap.com/api') ->

  req: (method, path, params, cb) ->
    params ?= {}
    if @user and @token
      params['username'] = @user
      params['token'] = @token
    options =
      uri: @url + path
      method: method
    if method == 'POST'
      options['form'] = params
    else
      options['qs'] = params
    request options, (_, response, body) ->
      cb? body and JSON.parse(body), response.statusCode

  getPaste: (id, cb) ->
    @req 'GET', '/paste/' + id, {}, cb

  # createPaste(contents, options, cb)
  # createPaste(contents, options)
  # createPaste(contents, cb)
  createPaste: (contents, options, cb) ->
    if options? instanceof Function
      cb ?= options
      options = {}
    options ?= {}
    options['contents'] = contents
    @req 'POST', '/paste', options, cb

  editPaste: (id, options, cb) ->
    @req 'POST', "/paste/#{id}", options, cb

  deletePaste: (id, cb) ->
    @req 'DELETE', "/paste/#{id}", {}, cb

  forkPaste: (id, cb) ->
    @req 'POST', "/paste/#{id}/fork", {}, cb

  getHighlightedHTML: (id, cb) ->
    @req 'GET', "/paste/#{id}/highlight", {}, cb
