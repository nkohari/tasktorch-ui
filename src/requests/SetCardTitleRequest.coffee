_                     = require 'lodash'
superagent            = require 'superagent'
etag                  = require 'common/util/etag'
Header                = require 'framework/enums/Header'
Request               = require 'framework/Request'
CardTitleChangedEvent = require 'events/CardTitleChangedEvent'

class SetCardTitleRequest extends Request

  constructor: (@card, @title) ->

  execute: (context, eventBus) ->
    superagent.put("#{@card.uri}/title")
    .set(Header.IfMatch, etag.encode(@card.version))
    .set(Header.Socket, eventBus.getSocketId())
    .send {@title}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      eventBus.publish new CardTitleChangedEvent(@card.id, title, version)

module.exports = SetCardTitleRequest
