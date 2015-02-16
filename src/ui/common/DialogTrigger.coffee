React              = require 'react/addons'
Keymaster          = require 'keymaster'
PropTypes          = require 'framework/PropTypes'
mergeProps         = require 'framework/util/mergeProps'
Link               = React.createFactory(require 'ui/common/Link')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
{cloneWithProps}   = React.addons

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
    React.render(@renderDialog(), @_container)
    Keymaster('esc', @onEscapePressed)

  componentDidUpdate: ->
    React.render(@renderDialog(), @_container)

  componentWillUnmount: ->
    React.unmountComponentAtNote(@_container)
    document.body.removeChild(@_container)
    Keymaster.unbind('esc', @onEscapePressed)

  render: ->

    props = mergeProps @props, {
      className: 'trigger'
      @isReady
      @onClick
    }

    Link props, @props.children

  renderDialog: ->
    
    if @state.open
      content = cloneWithProps @props.dialog, {@close}

    CSSTransitionGroup {component: 'div', transitionName: 'fade'},
      content

  open: ->
    @setState {open: true}

  close: ->
    @setState {open: false}

  onClick: ->
    @open()

  onEscapePressed: ->
    @close()

}

module.exports = DialogTrigger
