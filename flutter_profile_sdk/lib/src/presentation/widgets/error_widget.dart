// ============================================================================
// FICHIER : error_widget.dart
// RÔLE : Widget qui affiche un message d'erreur
// COUCHE : Presentation Layer
// ============================================================================

import 'package:flutter/material.dart' hide ErrorWidget;

class ErrorWidget extends StatelessWidget {
  final String message;
  
  const ErrorWidget({required this.message, Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red, size: 60),
          SizedBox(height: 20),
          Text(
            'Erreur',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(message),
        ],
      ),
    );
  }
}
