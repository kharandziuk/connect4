express = require('express')
async = require('async')
app = express()
io = require('socket.io').listen(app.listen(8000))

generateRoom = (length)->
    haystack = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    room = ''

    for i in [0...length]
        room += haystack.charAt(Math.floor(Math.random() * haystack.length))

    return room

app.use('/static', express.static(__dirname + '/static'))

app.get('/', (req, res)->
    share = generateRoom(6)
    res.render('index.jade', {shareURL: req.protocol + '://' + req.get('host') + req.path + share, share: share})
)

app.get('/:room([A-Za-z0-9]{6})', (req, res)->
    share = req.params.room
    res.render('index.jade', {shareURL: req.protocol + '://' + req.get('host') + '/' + share, share: share})
)

app.get('/landingPage', (req, res)->
    res.render('landing.jade')
)

console.log('Listening on port 8000')
