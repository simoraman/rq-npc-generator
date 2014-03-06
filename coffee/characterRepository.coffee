define ['dice', 'character'], (dice, Character) ->
  class CharacterRepository
    constructor: () ->

    getStore: () ->
      if localStorage['characterStore'] == undefined
        {}
      else
        JSON.parse(localStorage['characterStore'])

    setStore: (content) -> localStorage['characterStore'] = content

    save: (character) ->
      characterList = @getStore()
      characterList[character.name] = character
      @setStore JSON.stringify(characterList)

    get: (key) ->
      values = @getStore()[key]
      character = new Character(dice)
      character.loadValues values
      character

    getCharacters: () ->
      chars = @getStore()# JSON.parse(localStorage['characterStore'])
      array = []

      for key,val of chars
        character = new Character(dice)
        character.loadValues val
        array.push character
      array
  return CharacterRepository
