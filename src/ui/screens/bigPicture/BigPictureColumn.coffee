#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './BigPictureColumn.styl'
#--------------------------------------------------------------------------------

BigPictureColumn = React.createClass {

  displayName: 'BigPictureColumn'

  propTypes:
    isReady: PropTypes.func

  render: ->

    props = mergeProps _.omit(@props, 'isReady'), {
      className: 'big-picture-column'
    }

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    div props, children

}

module.exports = BigPictureColumn
