#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
SortableMixin     = require 'sortablejs/react-sortable-mixin'
compare           = require 'common/util/compare'
PropTypes         = require 'ui/framework/PropTypes'
KindStageListItem = React.createFactory(require 'ui/dialogs/kindWizard/KindStageListItem')
{div, li, ul}     = React.DOM
#--------------------------------------------------------------------------------

KindStageList = React.createClass {

  displayName: 'KindStageList'

  propTypes:
    stages:      PropTypes.arrayOf(PropTypes.string)
    setStages:   PropTypes.func
    updateStage: PropTypes.func
    removeStage: PropTypes.func

  mixins: [SortableMixin]

  sortableOptions:
    group: 'kind-stages'
    model: 'stages'

  getInitialState: ->
    {stages: @props.stages}

  componentWillReceiveProps: (newProps) ->
    @setState {stages: newProps.stages}

  componentDidUpdate: (prevProps) ->
    if prevProps.stages.length < @props.stages.length
      @scrollToBottom()

  render: ->

    items = _.map _.compact(@state.stages), (stage) =>
      KindStageListItem {key: stage.id, stage, updateStage: @props.updateStage, removeStage: @props.removeStage}

    ul {className: 'kind-stage-list'}, items

  handleUpdate: (event) ->
    @props.setStages(@state.stages)

  scrollToBottom: ->
    node = @getDOMNode()
    node.scrollTop = node.scrollHeight

}

module.exports = KindStageList