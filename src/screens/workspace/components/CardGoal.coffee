React        = require 'react'
Router       = require 'react-router'
ActiveUrl    = require 'mixins/ActiveUrl'
WorkspaceUrl = require '../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Link         = React.createFactory(Router.Link)
{div, a}     = React.DOM

CardGoal = React.createClass {

  displayName: 'CardGoal'

  mixins: [ActiveUrl(WorkspaceUrl)]

  render: ->
    div {className: 'goal aspect'}, [
      div {key: 'name', className: 'name'}, ['Goal']
      div {key: 'value', className: 'value'}, [
        Link @makeLinkProps(), [
          Icon {key: 'icon', name: 'goal'}
          @props.goal.name
        ]
      ]
    ]

  # TODO: Should link to the specific goal
  makeLinkProps: ->
    url = @getActiveUrl()
    params = {organizationId: url.organizationId}
    {key: 'icon', to: 'planning', params}

}

module.exports = CardGoal
