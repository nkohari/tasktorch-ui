#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
classSet     = require 'common/util/classSet'
mergeProps   = require 'common/util/mergeProps'
PropTypes    = require 'ui/framework/PropTypes'
ShellContext = require 'ui/framework/mixins/ShellContext'
Avatar       = React.createFactory(require 'ui/common/Avatar')
Icon         = React.createFactory(require 'ui/common/Icon')
{div, span}  = React.DOM
#--------------------------------------------------------------------------------
require './EmptyOption.styl'
#--------------------------------------------------------------------------------

EmptyOption = React.createClass {

  displayName: 'EmptyOption'

  propTypes:
    text: PropTypes.string

  getDefaultProps: ->
    {text: 'No matches found'}

  render: ->

    props = mergeProps @props, {
      className: classSet [
        'empty-option'
      ]
    }

    div props,
      span {className: 'text'}, @props.text

}

module.exports = EmptyOption
