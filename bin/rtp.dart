import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final ip = InternetAddress.anyIPv4;
  final server = await ServerSocket.bind(ip, 3000);
  List<Socket> clients = [];

  server.listen((Socket client) {
    print(
        'Sever: Connection from ${client.remoteAddress.address}:${client.remotePort}');

    client.listen((Uint8List data) async {
      final message = String.fromCharCodes(data);

      for (final c in clients) {
        c.write('Server: $message has entered the room');
      }

      clients.add(client);
      client.write('Server: You are logged in as: $message');
    });
  });

  print('Server is up and running on ${ip.address}:3000');
}
