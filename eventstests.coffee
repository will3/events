Events = require './events.coffee'
expect = require('chai').expect

describe 'Events', () ->
	events = null

	beforeEach () ->
		events = new Events()

	it 'should emit events to listeners', (done) ->
		events.on 'event', (arg1, arg2) ->
			expect(arg1).to.equal 'arg1'
			expect(arg2).to.equal 'arg2'
			done()

		events.emit 'event', 'arg1', 'arg2'

	it 'should emit events to once listeners', (done) ->
		events.once 'event', (arg1, arg2) ->
			expect(arg1).to.equal 'arg1'
			expect(arg2).to.equal 'arg2'
			done()

		events.emit 'event', 'arg1', 'arg2'		

	it 'can get listeners', () ->
		listener = () ->
		events.on 'event', listener
		listeners = events.listeners 'event'
		expect(listeners).to.have.length 1

	it 'can remove listener', () ->
		listener = () ->
		events.on 'event', listener
		events.removeListener 'event', listener
		listeners = events.listeners 'event'
		expect(listeners).to.have.length 0

	it 'can remove all listeners', () ->
		listener1 = () ->
		listener2 = () ->
		events.on 'event', listener1
		events.on 'event', listener2
		events.removeAllListeners 'event'
		listeners = events.listeners 'event'
		expect(listeners).to.have.length 0			

	it 'remove listeners once event is emitted', () ->
		listener = () ->
		events.once 'event', listener
		events.emit 'event'
		listeners = events.listeners 'event'
		expect(listeners).to.have.length 0