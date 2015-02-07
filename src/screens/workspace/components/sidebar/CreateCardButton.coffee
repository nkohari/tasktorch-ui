React             = require 'react'
Router            = require 'react-router'
ActiveUrl         = require 'mixins/ActiveUrl'
Observe           = require 'mixins/Observe'
CreateCardRequest = require 'requests/CreateCardRequest'
WorkspaceUrl      = require '../../WorkspaceUrl'
Button            = React.createFactory(require 'common/Button')

CreateCardButton = React.createClass {

  displayName: 'CreateCardButton'

  mixins: [
    ActiveUrl(WorkspaceUrl)
    Observe()
    Router.Navigation
  ]

  render: ->
    Button {text: 'Create Card', onClick: @handleClick}

  # TODO: Support different card kinds
  handleClick: ->
    url     = @getActiveUrl()
    request = new CreateCardRequest(url.orgid, '1')
    @execute request, (err, card) =>
      url.addCard(card.id)
      props = url.makeLinkProps()
      @transitionTo(props.to, props.params, props.query)

}

module.exports = CreateCardButton
