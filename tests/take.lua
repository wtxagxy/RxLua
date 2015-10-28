describe('take', function()
  it('produces an error if its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:take(1).subscribe).to.fail()
  end)

  it('produces nothing if the count is zero', function()
    local observable = Rx.Observable.fromValue(3):take(0)
    expect(observable).to.produce.nothing()
  end)

  it('produces nothing if the count is less than zero', function()
    local observable = Rx.Observable.fromValue(3):take(-3)
    expect(observable).to.produce.nothing()
  end)

  it('takes one element if no count is specified', function()
    local observable = Rx.Observable.fromTable({2, 3, 4}, ipairs):take()
    expect(observable).to.produce(2)
  end)

  it('produces all values if it takes all of the values of the original', function()
    local observable = Rx.Observable.fromTable({1, 2}, ipairs):take(2)
    expect(observable).to.produce(1, 2)
  end)

  it('completes and does not fail if it takes more values than were produced', function()
    local observable = Rx.Observable.fromValue(3):take(5)
    local onNext, onError, onCompleted = observableSpy(observable)
    expect(onNext).to.equal({{3}})
    expect(#onError).to.equal(0)
    expect(#onCompleted).to.equal(1)
  end)
end)
