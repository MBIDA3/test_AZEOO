// ============================================================================
// FICHIER : profile_screen.dart
// RÔLE : Écran principal qui affiche le profil utilisateur
// COUCHE : Presentation Layer
// ============================================================================
//
// Ce fichier contient ProfileScreen qui :
// - Écoute le ProfileProvider (Riverpod)
// - Affiche l'UI selon l'état (loading, success, error)
// - Utilise les widgets ProfileAvatar, ProfileInfo, etc.
//
// STRUCTURE :
// - ConsumerWidget (pour utiliser Riverpod)
// - ref.watch(profileNotifierProvider) pour écouter l'état
// - profileState.when() pour gérer les 3 états
//
// INSTRUCTIONS :
// 1. Créer un ConsumerWidget
// 2. Dans build(), écouter le profileNotifierProvider
// 3. Utiliser .when() pour afficher :
//    - data: ProfileAvatar + ProfileInfo
//    - loading: LoadingWidget
//    - error: ErrorWidget
// 4. Appeler loadProfile(userId) dans initState ou didChangeDependencies
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom;

// ============================================================================
// TODO: Définir le ProfileScreen ici
// Exemple de structure :
// class ProfileScreen extends ConsumerStatefulWidget {
//   final String userId;
//   
//   const ProfileScreen({required this.userId, Key? key}) : super(key: key);
//   
//   @override
//   ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends ConsumerState<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Charger le profil au démarrage
//     Future.microtask(() => 
//       ref.read(profileNotifierProvider.notifier).loadProfile(widget.userId)
//     );
//   }
//   
//   @override
//   Widget build(BuildContext context) {
//     final profileState = ref.watch(profileNotifierProvider);
//     
//     return Scaffold(
//       appBar: AppBar(title: Text('Profil Utilisateur')),
//       body: profileState.when(
//         data: (user) {
//           if (user == null) return Center(child: Text('Aucun profil'));
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ProfileAvatar(avatarUrl: user.avatarUrl),
//                 SizedBox(height: 20),
//                 ProfileInfo(firstName: user.firstName, lastName: user.lastName),
//               ],
//             ),
//           );
//         },
//         loading: () => LoadingWidget(),
//         error: (error, _) => custom.ErrorWidget(message: error.toString()),
//       ),
//     );
//   }
// }
// ============================================================================
