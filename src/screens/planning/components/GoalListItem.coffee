_           = require 'lodash'
React       = require 'react/addons'
Router      = require 'react-router'
ActiveUrl   = require 'mixins/ActiveUrl'
PlanningUrl = require '../PlanningUrl'
Icon        = React.createFactory(require 'common/Icon')
Link        = React.createFactory(Router.Link)
{li, span}  = React.DOM

GoalListItem = React.createClass {

  displayName: 'GoalListItem'

  mixins: [ActiveUrl(PlanningUrl)]

  render: ->
    linkProps = _.extend @makeLinkProps(), {key: 'link'}
    li {}, [
      Link linkProps, [
        Icon {key: 'icon', name: 'goal'}
        span {key: 'name', className: 'goal-name'}, [@props.goal.name]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.setGoal(@props.goal.id)
    return url.makeLinkProps()

}

module.exports = GoalListItem
