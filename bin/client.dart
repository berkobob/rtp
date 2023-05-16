import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final socket = await Socket.connect("0.0.0.0", 3000);
  print('Connected to ${socket.remoteAddress}:${socket.remotePort}');

  String? username;

  do {
    print('Client: Please enter your username');
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);
  socket.write(username);

  socket.listen((Uint8List data) {
    final serverResponse = String.fromCharCodes(data);
    print('Client $serverResponse');
  }, onError: (error) {
    print('Client error: $error');
    socket.destroy();
  }, onDone: () {
    print('Client: Server down');
    socket.destroy();
  });
}
