_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
KindPanel  = React.createFactory(require 'ui/screens/bigPicture/panels/kind/KindPanel')
TeamPanel  = React.createFactory(require 'ui/screens/bigPicture/panels/team/TeamPanel')

BigPicturePanel = React.createClass {

  displayName: 'BigPicturePanel'

  propTypes:
    type: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'type'), {
      'data-itemid': @props.id
    }

    switch @props.type
      when 'team' then TeamPanel(props)
      when 'kind' then KindPanel(props)

}

module.exports = BigPicturePanel
