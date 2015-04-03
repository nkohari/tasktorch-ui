_                  = require 'lodash'
React              = require 'react/addons'
classSet           = require 'common/util/classSet'
PropTypes          = require 'ui/framework/PropTypes'
Button             = React.createFactory(require 'ui/common/Button')
Icon               = React.createFactory(require 'ui/common/Icon')
WizardBreadcrumbs  = React.createFactory(require 'ui/common/WizardBreadcrumbs')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

Wizard = React.createClass {

  displayName: 'Wizard'

  propTypes:
    closeDialog: PropTypes.func
    icon:        PropTypes.string
    title:       PropTypes.string
    width:       PropTypes.number
    height:      PropTypes.number

  getDefaultProps: ->
    {width: 600, height: 'auto'}

  getInitialState: ->
    {currentPage: 0}

  componentDidMount: ->
    node = @refs.dialog.getDOMNode()
    node.style.marginTop = "#{@getMarginAdjustment()}px"

  render: ->

    pages       = _.flatten [@props.children]
    currentPage = pages[@state.currentPage]

    if @state.currentPage > 0
      backButton = Button {text: 'Back', onClick: @onBackClicked}

    if @state.currentPage < pages.length - 1
      forwardButton = Button {text: 'Next', onClick: @onNextClicked}
    else
      forwardButton = @props.completeButton

    if @props.title?
      header = div {className: 'dialog-header'},
        Icon {name: @props.icon} if @props.icon?
        @props.title

    style = {width: @props.width, height: @props.height}

    div {className: 'dialog-backdrop', onClick: @onContainerClicked},
      div {ref: 'dialog', className: 'wizard dialog', style},
        header
        WizardBreadcrumbs {pages, currentPage: @state.currentPage, @setPage}
        div {className: 'dialog-content'},
          currentPage
          div {className: 'dialog-buttons'},
            div {className: 'left-buttons'},
              backButton
            div {className: 'right-buttons'},
              forwardButton
              Button {text: 'Cancel', onClick: @props.closeDialog}

  getMarginAdjustment: ->
    node = @refs.dialog.getDOMNode()
    return -(node.clientHeight / 2)

  onContainerClicked: (event) ->
    if event.target == @getDOMNode()
      @props.closeDialog()

  setPage: (index) ->
    @setState {currentPage: index}

  onBackClicked: (event) ->
    @setState {currentPage: @state.currentPage - 1}

  onNextClicked: (event) ->
    @setState {currentPage: @state.currentPage + 1}

}

module.exports = Wizard
