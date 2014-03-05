define [], () ->
  class CharacterRepository
    constructor: () ->

    save: (character) -> localStorage[character.name] = JSON.stringify(character)

    get: (key) ->
      values = JSON.parse(localStorage[key])
      character = new Character(rollD)
      character.loadValues values
      character
  return CharacterRepository
