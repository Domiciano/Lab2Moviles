import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Clases de Estado y Modelo ---
class Contact {
  final String id;
  final String name;
  final String email;
  final String phone;
  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });
}

class ContactState {
  final List<Contact> contacts;
  ContactState({this.contacts = const []});
}

// --- Cubit ---
class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState());

  void addProfile(Contact contact) {
    emit(ContactState(contacts: [...state.contacts, contact]));
  }

  void removeProfile(String id) {
    emit(ContactState(contacts: [...state.contacts.where((c) => c.id != id)]));
  }
}

class CubitExampleScreen extends StatelessWidget {
  const CubitExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ContactScreen(),
    );
  }
}

// --- Pantalla de Contactos ---
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Contactos con Cubit')),
        body: BlocBuilder<ContactCubit, ContactState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final newContact = Contact(
                        id: DateTime.now().toString(), // ID único
                        name: "Nuevo Contacto",
                        email: "nuevo@example.com",
                        phone: "123456789",
                      );
                      context.read<ContactCubit>().addProfile(newContact);
                    },
                    child: const Text("Agregar Contacto"),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.contacts[index];
                      return ListTile(
                        title: Text(contact.name),
                        subtitle: Text(contact.email),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<ContactCubit>().removeProfile(
                              contact.id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
