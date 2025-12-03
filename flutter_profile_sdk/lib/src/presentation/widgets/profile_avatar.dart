// ============================================================================
// FICHIER : profile_avatar.dart
// RÔLE : Widget qui affiche l'avatar de l'utilisateur
// COUCHE : Presentation Layer
// ============================================================================

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatarUrl;
  
  const ProfileAvatar({required this.avatarUrl, Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: CachedNetworkImageProvider(avatarUrl),
    );
  }
}
