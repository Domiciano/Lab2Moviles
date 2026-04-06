import 'package:flutter/material.dart';

class SearchModal extends StatelessWidget {
  const SearchModal({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      // Este padding asegura que el teclado no tape el modal al abrirse
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Hace que el modal sea pequeño
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Buscar canción...',
              border: OutlineInputBorder(),
            ),
            autofocus: true, // Abre el teclado automáticamente
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Cerramos el modal pasando el texto de vuelta
              Navigator.pop(context, controller.text);
            },
            child: const Text('Buscar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
