React             = require 'react'
Router            = require 'react-router'
Observe           = require 'framework/mixins/Observe'
PropTypes         = require 'framework/PropTypes'
CreateCardRequest = require 'requests/CreateCardRequest'
Url               = require 'framework/Url'
Button            = React.createFactory(require 'ui/common/Button')

ComposeButton = React.createClass {

  displayName: 'ComposeButton'

  mixins: [
    Observe()
    Router.State
    Router.Navigation
  ]

  propTypes:
    currentOrg: PropTypes.Org

  render: ->
    Button {text: 'Compose', onClick: @handleClick}

  # TODO: Support different card kinds
  handleClick: ->
    url     = new Url(this)
    request = new CreateCardRequest(url.orgid, '1')
    @execute request, (err, card) =>
      url.addCard(card.id)
      props = url.makeLinkProps()
      @transitionTo(props.to, props.params, props.query)

}

module.exports = ComposeButton
