moment = require 'moment'

exports.format = (value, format) ->
  date = moment(value)
  if format.indexOf('YYYY?')
    replacement = if date.isSame(moment(), 'year') then '' else 'YYYY'
    format = format.replace('YYYY?', replacement)
  return date.format(format)
