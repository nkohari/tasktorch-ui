_                = require 'lodash'
React            = require 'react/addons'
PropTypes        = require 'framework/PropTypes'
classSet         = require 'framework/util/classSet'
mergeClasses     = require 'framework/util/mergeClasses'
Caret            = React.createFactory(require 'ui/common/Caret')
Frame            = React.createFactory(require 'ui/common/Frame')
Icon             = React.createFactory(require 'ui/common/Icon')
List             = React.createFactory(require 'ui/common/List')
{button, span}   = React.DOM
{cloneWithProps} = React.addons

MenuButton = React.createClass {

  displayName: 'MenuButton'

  propTypes:
    icon:    PropTypes.string
    text:    PropTypes.string
    isReady: PropTypes.func

  getInitialState: ->
    {expanded: false}

  componentDidUpdate: ->
    @refs.dropdown.getDOMNode().focus() if @state.expanded

  render: ->

    if @state.expanded
      items = _.map @props.children, (element) =>
        cloneWithProps element, {
          key:     element.key
          onClick: @onItemClicked.bind(this, element.props.value)
        }
      menu = List {ref: 'dropdown', className: 'dropdown', tabIndex: -1, @onBlur}, items

    classes = mergeClasses @props.className, classSet [
      'menu-button'
      'expanded' if @state.expanded
    ]

    buttonProps = {
      onClick: @onButtonClicked
      className: 'active' if @state.expanded
    }

    Frame {@isReady, className: classes},
      button buttonProps,
        Icon {name: @props.icon} if @props.icon?
        span {}, @props.text if @props.text?
        Caret {}
      menu

  onBlur: ->
    @setState {expanded: false}

  onButtonClicked: ->
    @setState {expanded: !@state.expanded}

  onItemClicked: (value, event) ->
    event.value = value
    @props.onItemClicked(event) if @props.onItemClicked?
    @setState {expanded: false}

}

module.exports = MenuButton
