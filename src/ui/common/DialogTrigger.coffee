React              = require 'react/addons'
Keymaster          = require 'keymaster'
PropTypes          = require 'framework/PropTypes'
Link               = React.createFactory(require 'ui/common/Link')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

DialogTrigger = React.createClass {

  displayName: 'DialogTrigger'

  propTypes:
    isReady: PropTypes.func
    dialog:  PropTypes.element

  getInitialState: ->
    {open: false}

  componentDidMount: ->
    @_container = document.createElement('div')
    document.body.appendChild(@_container)
    React.render(@_renderDialog(), @_container)
    Keymaster('esc', @onEscapePressed)

  componentDidUpdate: ->
    React.render(@_renderDialog(), @_container)

  componentWillUnmount: ->
    React.unmountComponentAtNote(@_container)
    document.body.removeChild(@_container)
    Keymaster.unbind('esc', @onEscapePressed)

  render: ->
    Link {@isReady, @onClick}, @props.children

  onClick: ->
    @setState {open: true}

  onEscapePressed: ->
    @setState {open: false}

  _renderDialog: ->
    if @state.open
      @props.dialog
    else
      div {}

}

module.exports = DialogTrigger
