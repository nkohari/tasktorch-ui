#--------------------------------------------------------------------------------
React                         = require 'react/addons'
classSet                      = require 'common/util/classSet'
UserCompletedWalkthroughEvent = require 'events/ui/UserCompletedWalkthroughEvent'
UserStartedWalkthroughEvent   = require 'events/ui/UserStartedWalkthroughEvent'
StackType                     = require 'data/enums/StackType'
PropTypes                     = require 'ui/framework/PropTypes'
Actor                         = require 'ui/framework/mixins/Actor'
CachedState                   = require 'ui/framework/mixins/CachedState'
Navigator                     = require 'ui/framework/mixins/Navigator'
StackPanelState               = require 'ui/screens/workspace/panels/stack/StackPanelState'
CardPanelState                = require 'ui/screens/workspace/panels/card/CardPanelState'
Icon                          = React.createFactory(require 'ui/common/Icon')
WalkthroughIntro              = React.createFactory(require 'ui/walkthrough/WalkthroughIntro')
WalkthroughOutro              = React.createFactory(require 'ui/walkthrough/WalkthroughOutro')
WalkthroughProgress           = React.createFactory(require 'ui/walkthrough/WalkthroughProgress')
ComposeButtonCallout          = React.createFactory(require 'ui/walkthrough/callouts/ComposeButtonCallout')
CompleteButtonCallout         = React.createFactory(require 'ui/walkthrough/callouts/CompleteButtonCallout')
CardCallout                   = React.createFactory(require 'ui/walkthrough/callouts/CardCallout')
QueueCallout                  = React.createFactory(require 'ui/walkthrough/callouts/QueueCallout')
ExpandedCardCallout           = React.createFactory(require 'ui/walkthrough/callouts/ExpandedCardCallout')
CardKindCallout               = React.createFactory(require 'ui/walkthrough/callouts/CardKindCallout')
ActionCallout                 = React.createFactory(require 'ui/walkthrough/callouts/ActionCallout')
ActionStatusCallout           = React.createFactory(require 'ui/walkthrough/callouts/ActionStatusCallout')
PassingCallout                = React.createFactory(require 'ui/walkthrough/callouts/PassingCallout')
InboxCallout                  = React.createFactory(require 'ui/walkthrough/callouts/InboxCallout')
BigPictureCallout             = React.createFactory(require 'ui/walkthrough/callouts/BigPictureCallout')
OrgMenuCallout                = React.createFactory(require 'ui/walkthrough/callouts/OrgMenuCallout')
CSSTransitionGroup            = React.createFactory(React.addons.CSSTransitionGroup)
{a, div, img}                 = React.DOM
{cloneWithProps}              = React.addons
#--------------------------------------------------------------------------------
require './Walkthrough.styl'
#--------------------------------------------------------------------------------

SLIDES = [
  CardCallout {}
  QueueCallout {}
  ExpandedCardCallout {}
  CardKindCallout {}
  ActionCallout {}
  ActionStatusCallout {}
  PassingCallout {}
  InboxCallout {}
  CompleteButtonCallout {}
  ComposeButtonCallout {}
  BigPictureCallout {}
  OrgMenuCallout {}
]

Walkthrough = React.createClass {

  displayName: 'Walkthrough'

  mixins: [Actor, CachedState, Navigator]

  getInitialState: ->
    {slide: -1, panelsReady: false}

  getCachedState: (cache) ->
    stacks = cache('myStacks').get()
    if stacks?
      queue = _.find stacks, (s) -> s.type == StackType.Queue
      cards = cache('cardsByStack').get(queue.id)
      card  = _.first(cards) if cards?
    {queue, card}

  componentDidUpdate: ->
    unless @state.panelsReady
      @arrangePanels()
      @publish new UserStartedWalkthroughEvent()
      @setState {panelsReady: true}

  render: ->

    isStart = @state.slide < 0
    isEnd   = @state.slide == SLIDES.length

    unless isStart or isEnd
      slide = cloneWithProps SLIDES[@state.slide], {key: @state.slide}

    div {className: 'walkthrough'},
      div {className: 'walkthrough-underlay'},
        img {className: 'flicker-fixed', src: require('img/flicker-excited.svg')} unless isStart or isEnd
      div {className: 'walkthrough-overlay'},
        WalkthroughIntro {} if isStart
        WalkthroughOutro {complete: @moveForward} if isEnd
        WalkthroughProgress {advance: @moveForward, currentStep: @state.slide + 1, totalSteps: SLIDES.length + 1}
      CSSTransitionGroup {component: 'div', className: 'walkthrough-slide-container', transitionName: 'fade', transitionAppear: true},
        slide

  moveForward: ->
    if @state.slide == SLIDES.length
      @publish new UserCompletedWalkthroughEvent()
    else
      @setState {slide: @state.slide + 1}

  arrangePanels: ->
    screen = @getScreen('workspace')
    screen.showDrawer()
    screen.addPanel(new CardPanelState(@state.card.id))
    screen.addPanel(new StackPanelState(@state.queue.id))


}

module.exports = Walkthrough
