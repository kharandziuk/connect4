(($, io)->
    $(document).ready(->
        for i in [0..5]
            $('#board table').append('<tr/>')
            for j in [0..6]
                console.log i, j
                $('#board tr').last().append('<td/>')
                $('#board td').last().addClass('box').attr('data-row', i).attr('data-column', j)

        socket = io.connect('localhost')

        Player(room, pid) ->
            this.room = room
            this.pid = pid

        room = $('input').data('room')
        player = new Player(room, '', '')

        socket.on('connect', ()->
            socket.emit('join', {room: room})
        )

        socket.on('assign', (data)->
            player.color = data.color
            player.pid = data.pid
            if player.pid is 1
                $('.p1-score p').addClass('current')
            else
                $('.p2-score p').addClass('current')
        )
        // an object to hold all gamestates. Key denotes room id
var games = {};

io.sockets.on('connection', function(socket) {
    socket.on('join', function(data) {
        if(data.room in games) {
            if(typeof games[data.room].player2 != "undefined") {
                socket.emit('leave');
                return;
            }
            socket.join(data.room);
            socket.set('room', data.room);
            socket.set('color', '#FB6B5B');
            socket.set('pid', -1);
            games[data.room].player2 = socket
            // Set opponents
            socket.set('opponent', games[data.room].player1);
            games[data.room].player1.set('opponent', games[data.room].player2);

            // Set turn
            socket.set('turn', false);
            socket.get('opponent', function(err, opponent) {
                opponent.set('turn', true);
            });

            socket.emit('assign', {pid: 2});

        }
        else {
            socket.join(data.room);
            socket.set('room', data.room);
            socket.set('color', '#FFC333');
            socket.set('pid', 1);
            socket.set('turn', false);
            games[data.room] = {
                player1: socket,
                board: [[0,0,0,0,0,0,0], [0,0,0,0,0,0,0], [0,0,0,0,0,0,0], [0,0,0,0,0,0,0], [0,0,0,0,0,0,0], [0,0,0,0,0,0,0]],
            };
            socket.emit('assign', {pid: 1});
        }
    })
})
    )
)(jQuery, io)
