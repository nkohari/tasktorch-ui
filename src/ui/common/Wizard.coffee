_                  = require 'lodash'
React              = require 'react/addons'
classSet           = require 'common/util/classSet'
mergeClasses       = require 'common/util/mergeClasses'
PropTypes          = require 'ui/framework/PropTypes'
Button             = React.createFactory(require 'ui/common/Button')
Icon               = React.createFactory(require 'ui/common/Icon')
WizardBreadcrumbs  = React.createFactory(require 'ui/common/WizardBreadcrumbs')
WizardPage         = React.createFactory(require 'ui/common/WizardPage')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
{cloneWithProps}   = React.addons

Wizard = React.createClass {

  displayName: 'Wizard'

  propTypes:
    closeDialog: PropTypes.func
    icon:        PropTypes.string
    title:       PropTypes.string
    width:       PropTypes.number
    height:      PropTypes.any

  getDefaultProps: ->
    {width: 600, height: 'auto'}

  getInitialState: ->
    {currentIndex: 0, canProceed: false}

  componentWillMount: ->
    @pages = @createPages(@props.children)

  componentWillReceiveProps: (newProps) ->
    @pages = @createPages(newProps.children)

  render: ->

    if @state.currentIndex > 0
      backButton = Button {text: 'Back', onClick: @onBackClicked}

    if @state.currentIndex < @pages.length - 1
      pageRef = @refs["page-#{@state.currentIndex}"]
      forwardButton = Button {text: 'Next', disabled: !@state.canProceed, onClick: @onNextClicked}
    else
      forwardButton = @props.completeButton

    if @props.title?
      header = div {className: 'dialog-header'},
        Icon {name: @props.icon} if @props.icon?
        @props.title

    classes = mergeClasses('wizard dialog', @props.className)
    style   = {width: @props.width, height: @props.height}

    div {className: 'dialog-backdrop', onClick: @onContainerClicked},
      div {ref: 'dialog', className: classes, style},
        header
        WizardBreadcrumbs {@pages, currentIndex: @state.currentIndex, @setPage}
        div {className: 'dialog-content'},
          @pages[@state.currentIndex]
        div {className: 'dialog-buttons'},
          div {className: 'left-buttons'},
            backButton
          div {className: 'right-buttons'},
            forwardButton
            Button {text: 'Cancel', onClick: @props.closeDialog}

  createPages: (children) ->
    _.map _.flatten([children]), (page, index) =>
      cloneWithProps(page, {key: "page-#{index}", @setCanProceed})

  onContainerClicked: (event) ->
    if event.target == @getDOMNode()
      @props.closeDialog()

  setPage: (index) ->
    @setState {currentIndex: index}

  setCanProceed: (canProceed) ->
    @setState {canProceed} if canProceed != @state.canProceed

  onBackClicked: (event) ->
    @setState {currentIndex: @state.currentIndex - 1}

  onNextClicked: (event) ->
    @setState {currentIndex: @state.currentIndex + 1}

}

module.exports = Wizard
