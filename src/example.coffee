# Example code

fs = require('fs')
Bacon = require('baconjs')
toCharStream = (str) -> Bacon.fromArray(str.split(""))
Bacon.fromNodeStream = require('./Bacon.fromNodeStream.js')
Bacon.fromNodeStream(fs.createReadStream "../README.md", { encoding: "utf8" })
  .flatMap(toCharStream)
  .bufferWithCount(80)
  .map(".join", "")
  .log()
