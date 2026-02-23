import 'package:flutter/material.dart';
import 'package:vets_uo_flutter_app/pages/user_edit_form.dart';
import 'package:vets_uo_flutter_app/src/user.dart';
import 'package:vets_uo_flutter_app/pages/user_signup_form.dart';
import 'package:vets_uo_flutter_app/pages/custom_alert_dialog.dart';
import 'package:vets_uo_flutter_app/pages/user_details.dart';

class HomePage extends StatefulWidget {
  //final String _title;
  const HomePage({super.key}); // recibimos el titulo en el constructor
  @override
  State<StatefulWidget> createState() => StateHomePage();
}

class StateHomePage extends State<HomePage> {
  List<User> users = [
    User("Pedro", "Alvarez", "pedro.alvarez.com", "034-999-999-977"),
    User("María", "Alvarez", "maria.alvarez.com", "034-999-999-978"),
    User("Teresa", "Almonte", "teresa.almonte.com", "034-999-999-979"),
    User("Juan", "Almonte", "juan.almonte.com", "034-999-999-988"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado de clientes")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              User currentUser = users[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetails(user: currentUser),
                ),
              );
            },
            onLongPress: () {
              deleteUser(context, users[index], index);
            },
            title: Text("${users[index].name} ${users[index].surname}"),
            subtitle: Text("${'Teléfono:'}${users[index].phone}"),
            leading: CircleAvatar(
              child: Text(users[index].name.substring(0, 1)),
            ),
            trailing: const Icon(Icons.call, color: Colors.black),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserSignUpForm()),
          ).then(
            (newUser) => {
              if (newUser != null)
                {
                  setState(() {
                    users.add(newUser);
                    String message =
                        "El usuario ${newUser.name} ha sido registrado";
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog.create(
                        context,
                        'Información',
                        message,
                      ),
                    );
                  }),
                },
            },
          ),
        },

        tooltip: "Registrar usuario",
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteUser(BuildContext context, User user, int index) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // Usamos dialogContext para claridad
        title: const Text("Borrar usuario"),
        content: Text("¿Está seguro de borrar a ${user.name}?"),
        actions: [
          // BOTÓN BORRAR
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index); // Más seguro borrar por índice
              });
              Navigator.pop(dialogContext);
            },
            child: const Text("Borrar", style: TextStyle(color: Colors.red)),
          ),

          // BOTÓN EDITAR
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // CERRAMOS el diálogo primero

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserEditForm(user: user),
                ),
              ).then((modifiedUser) {
                if (modifiedUser != null && mounted) {
                  // Verificamos mounted
                  setState(() {
                    users[index] = modifiedUser; // Reemplazo directo más limpio
                  });

                  // Mostrar confirmación
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog.create(
                      context,
                      'Información',
                      "Usuario ${modifiedUser.name} actualizado.",
                    ),
                  );
                }
              });
            },
            child: const Text("Editar", style: TextStyle(color: Colors.grey)),
          ),

          // BOTÓN CANCELAR
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
