_     = require 'lodash'
React = require 'react'

CLASSES =
  ActionTextChanged:  require './ActionTextChangedNote'
  CardCreated:        require './CardCreatedNote'
  CardSummaryChanged: require './CardSummaryChangedNote'
  CardTitleChanged:   require './CardTitleChangedNote'
  Comment:            require './CommentNote'

NoteFactory = _.memoize (type) ->

  unless CLASSES[type]?
    console.warn("Don't know how to render a note of type #{type}")
    return React.DOM.noscript

  return React.createFactory(CLASSES[type])

module.exports = NoteFactory
