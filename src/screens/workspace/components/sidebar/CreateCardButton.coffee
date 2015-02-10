React             = require 'react'
Router            = require 'react-router'
Observe           = require 'mixins/Observe'
CreateCardRequest = require 'requests/CreateCardRequest'
WorkspaceUrl      = require 'framework/urls/WorkspaceUrl'
Button            = React.createFactory(require 'common/Button')

CreateCardButton = React.createClass {

  displayName: 'CreateCardButton'

  mixins: [
    Observe()
    Router.State
    Router.Navigation
  ]

  render: ->
    Button {text: 'Create Card', onClick: @handleClick}

  # TODO: Support different card kinds
  handleClick: ->
    url     = new WorkspaceUrl(this)
    request = new CreateCardRequest(url.orgid, '1')
    @execute request, (err, card) =>
      url.addCard(card.id)
      props = url.makeLinkProps()
      @transitionTo(props.to, props.params, props.query)

}

module.exports = CreateCardButton
