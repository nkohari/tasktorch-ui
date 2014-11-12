_                    = require 'lodash'
superagent           = require 'superagent'
etag                 = require 'common/util/etag'
Header               = require 'framework/enums/Header'
Request              = require 'framework/Request'
CardBodyChangedEvent = require 'events/CardBodyChangedEvent'

class SetCardBodyRequest extends Request

  constructor: (@card, @body) ->

  execute: (context, eventBus) ->
    superagent.put("#{@card.uri}/body")
    .set(Header.IfMatch, etag.encode(@card.version))
    .set(Header.Socket, eventBus.getSocketId())
    .send {@body}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      eventBus.publish new CardBodyChangedEvent(@card.id, body, version)

module.exports = SetCardBodyRequest
