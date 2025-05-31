import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; // For RemoteDataSourceImpl
import '../../domain/repositories/login_repository.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_notifier.dart';
import 'login_state.dart';

// Provider for http.Client
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Provider for RemoteDataSource
// Ensure RemoteDataSourceImpl is imported if not already
// import '../../data/datasources/remote_data_source.dart';
final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  // Make sure RemoteDataSourceImpl is accessible here.
  // If it's in the same library or correctly exported, this should work.
  return RemoteDataSourceImpl(client: ref.watch(httpClientProvider));
});

// Provider for LoginRepository
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(remoteDataSource: ref.watch(remoteDataSourceProvider));
});

// Provider for LoginUseCase
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(loginRepositoryProvider));
});

// Provider for LoginNotifier
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.watch(loginUseCaseProvider));
});
