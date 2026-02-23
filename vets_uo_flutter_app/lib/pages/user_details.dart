import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/src/user.dart';

class UserDetails extends StatefulWidget {
  final User user;
  const UserDetails({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => StateUserDetails();
}

class StateUserDetails extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;
    return Scaffold(
      appBar: AppBar(title: const Text("Detalles usuario")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFields("Nombre: ", user.name),
            _buildFields("Apellidos: ", user.surname),
            _buildFields("Email: ", user.email),
            _buildFields("Teléfono: ", user.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildFields(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
