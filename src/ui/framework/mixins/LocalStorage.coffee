LocalStorageSlot = require 'ui/framework/LocalStorageSlot'

LocalStorage = {

  getStorageSlot: (slot) ->
    new LocalStorageSlot(slot)

}

module.exports = LocalStorage
