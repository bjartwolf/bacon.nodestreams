# Bacon.fromNodeStream converts Node.js ReadableStream into an EventStream
Bacon = require("baconjs")
module.exports = (stream) ->
  Bacon.fromBinder (sink) ->
    listeners = {}
    addListener = (event, listener) ->
      listeners[event] = listener
      stream.on event, listener
    addListener "readable", () -> sink(stream.read()) 
    addListener "end", () -> sink(new Bacon.End())
    addListener "error", (error) -> sink(new Bacon.Error(error))
    -> for event,listener of listeners
         stream.removeListener event,listener
