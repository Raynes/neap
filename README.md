# neap

I've run dry of reasonable names for
[refheap](https://github.com/Raynes/refheap) client libraries. Sue me. :)

## Usage

```
npm install neap
```

Then you can use it like so:

```coffeescript
Refheap = require 'neap'

rh = Refheap('user', 'token')
rh.createPaste '(+ 3 3)', private: true, language: 'Clojure', (r) ->
  # r will be an object (the response from refheap parsed from json)
  console.log r

rh.getPaste 2, (r) ->
  console.log r.contents
```
