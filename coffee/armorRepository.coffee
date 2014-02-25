define [], () ->
  class ArmorRepository
    constructor: (@armors) ->
    getArmor: () ->
      index = Math.floor(Math.random() * @armors.length)
      @armors[index]
  return ArmorRepository
