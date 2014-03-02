describe 'Dice', ->
  describe 'when rolling D6', ->
    result = null

    before ->
      result = rollD(6)

    it 'should be above zero', ->
      result.should.be.above(0)
    it 'should be less or equal to 6', ->
      result.should.be.below 7
  describe 'when rolling D0', ->
    it 'should return 0', ->
      rollD(0).should.equal 0
