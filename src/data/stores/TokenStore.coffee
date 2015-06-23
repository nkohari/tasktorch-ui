Token            = require 'data/models/Token'
ModelStore       = require 'data/framework/ModelStore'
LoadTokenRequest = require 'data/requests/LoadTokenRequest'

class TokenStore extends ModelStore

  displayName: 'TokenStore'
  name:        'tokens'
  modelType:   Token

  listensFor: [
    'TokensLoaded'
  ]

  load: (id) ->
    @execute new LoadTokenRequest(id)

  onTokensLoaded: (event) ->
    @add(event.tokens)

module.exports = TokenStore
