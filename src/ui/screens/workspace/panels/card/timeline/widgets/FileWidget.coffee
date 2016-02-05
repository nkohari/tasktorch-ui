#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{em}      = React.DOM
#--------------------------------------------------------------------------------

FileWidget = React.createClass {

  displayName: 'FileWidget'

  propTypes:
    file: PropTypes.File

  render: ->
    em {className: 'file-widget'},
      @props.file?.name or 'a deleted file'

}

module.exports = FileWidget
