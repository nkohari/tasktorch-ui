Token               = require 'data/models/Token'
ModelStore          = require 'data/framework/ModelStore'
LoadTokenRequest    = require 'data/requests/LoadTokenRequest'
CreateTokensRequest = require 'data/requests/CreateTokensRequest'

class TokenStore extends ModelStore

  displayName: 'TokenStore'
  name:        'tokens'
  modelType:   Token

  listensFor: [
    'TokensLoaded'
    'UserCreatedTokens'
  ]

  load: (id) ->
    @execute new LoadTokenRequest(id)

  onTokensLoaded: (event) ->
    @add(event.tokens)

  onUserCreatedTokens: (event) ->
    @execute new CreateTokensRequest(event.tokens)

module.exports = TokenStore
