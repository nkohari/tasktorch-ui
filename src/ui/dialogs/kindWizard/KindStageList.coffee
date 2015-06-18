#--------------------------------------------------------------------------------
_                 = require 'lodash'
React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
SortableList      = require 'ui/framework/mixins/SortableList'
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

  mixins: [
    SortableList {
      idAttribute: 'data-itemid'
    }
  ]

  componentDidUpdate: (prevProps) ->
    if prevProps.stages.length < @props.stages.length
      @scrollToBottom()

  render: ->

    items = _.map @props.stages, (stage) =>
      KindStageListItem {key: stage.id, stage, updateStage: @props.updateStage, removeStage: @props.removeStage}

    ul {className: 'kind-stage-list'}, items

  getSortableList: ->
    {id: 'dummy'}

  getSortableListItem: (id) ->
    _.find @props.stages, (stage) -> stage.id == id

  onReorder: (stage, toPosition) ->

  onListOrderChanged: (ids) ->
    stages = _.map ids, (id) => @getSortableListItem(id)
    @props.setStages(stages)

  isDropAllowed: (card, fromStack) ->
    return true

  scrollToBottom: ->
    node = @getDOMNode()
    node.scrollTop = node.scrollHeight

}

module.exports = KindStageList