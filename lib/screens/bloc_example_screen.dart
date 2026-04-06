import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Modelo ---
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

// --- Estado ---
class ContactState {
  final List<Contact> contacts;
  ContactState({this.contacts = const []});
}

// --- Eventos ---
abstract class ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;
  AddContactEvent(this.contact);
}

class RemoveContactEvent extends ContactEvent {
  final String id;
  RemoveContactEvent(this.id);
}

// --- Bloc ---
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState()) {
    on<AddContactEvent>((event, emit) {
      emit(ContactState(contacts: [...state.contacts, event.contact]));
    });

    on<RemoveContactEvent>((event, emit) {
      emit(
        ContactState(
          contacts: state.contacts.where((c) => c.id != event.id).toList(),
        ),
      );
    });
  }
}

class BlocExampleScreen extends StatelessWidget {
  const BlocExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
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
      create: (_) => ContactBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Contactos con Bloc')),
        body: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final newContact = Contact(
                        id: DateTime.now().toString(),
                        name: "Nuevo Contacto",
                        email: "nuevo@example.com",
                        phone: "123456789",
                      );
                      // CAMBIO: Se usa .add() en lugar de llamar a una función
                      context.read<ContactBloc>().add(
                        AddContactEvent(newContact),
                      );
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
                            // CAMBIO: Se envía el evento de remover
                            context.read<ContactBloc>().add(
                              RemoveContactEvent(contact.id),
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
