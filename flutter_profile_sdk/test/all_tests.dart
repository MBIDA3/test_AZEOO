// ============================================================================
// FICHIER : all_tests.dart
// RÔLE : Point d'entrée pour exécuter tous les tests
// ============================================================================
//
// Exécution :
//   flutter test test/all_tests.dart
//
// Ou exécuter tous les tests :
//   flutter test
//
// ============================================================================

// Domain Layer Tests
import 'domain/entities/user_test.dart' as user_entity_test;
import 'domain/usecases/get_user_profile_test.dart' as get_user_profile_test;

// Data Layer Tests
import 'data/models/user_model_test.dart' as user_model_test;
import 'data/datasources/user_local_datasource_test.dart' as local_datasource_test;
import 'data/repositories/user_repository_impl_test.dart' as repository_impl_test;

// Presentation Layer Tests
import 'presentation/widgets/profile_avatar_test.dart' as profile_avatar_test;
import 'presentation/widgets/profile_info_test.dart' as profile_info_test;
import 'presentation/widgets/loading_widget_test.dart' as loading_widget_test;
import 'presentation/widgets/error_widget_test.dart' as error_widget_test;
import 'presentation/router/app_router_test.dart' as app_router_test;
import 'presentation/screens/home_screen_test.dart' as home_screen_test;
import 'presentation/services/method_channel_service_test.dart' as method_channel_test;

// SDK Tests
import 'profile_sdk_test.dart' as profile_sdk_test;

// Integration Tests
import 'integration/full_flow_test.dart' as full_flow_test;

void main() {
  // Domain Layer
  user_entity_test.main();
  get_user_profile_test.main();
  
  // Data Layer
  user_model_test.main();
  local_datasource_test.main();
  repository_impl_test.main();
  
  // Presentation Layer
  profile_avatar_test.main();
  profile_info_test.main();
  loading_widget_test.main();
  error_widget_test.main();
  app_router_test.main();
  home_screen_test.main();
  method_channel_test.main();
  
  // SDK
  profile_sdk_test.main();
  
  // Integration
  full_flow_test.main();
}



