// ============================================================================
// FICHIER : profile_info.dart
// RÔLE : Widget qui affiche les informations (nom, prénom)
// COUCHE : Presentation Layer
// ============================================================================

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  
  const ProfileInfo({
    required this.firstName,
    required this.lastName,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$firstName $lastName',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
