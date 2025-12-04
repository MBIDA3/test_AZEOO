// ============================================================================
// FICHIER : loading_widget.dart
// RÔLE : Widget qui affiche un indicateur de chargement
// COUCHE : Presentation Layer
// ============================================================================

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
