import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'features/task_management/data/datasources/task_remote_datasource.dart';
import 'features/task_management/data/repositories/task_repository_impl.dart';
import 'features/task_management/domain/repositories/task_repository.dart';
import 'features/task_management/presentation/cubit/task_list_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<fb_auth.FirebaseAuth>(
    () => fb_auth.FirebaseAuth.instance,
  );

  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSource(
      sl<FirebaseFirestore>(),
      sl<fb_auth.FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl<TaskRemoteDataSource>()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<fb_auth.FirebaseAuth>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<SignIn>(() => SignIn(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUp>(() => SignUp(sl<AuthRepository>()));
  sl.registerLazySingleton<SignOut>(() => SignOut(sl<AuthRepository>()));

  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(sl<fb_auth.FirebaseAuth>()),
  );
  sl.registerFactory<TaskListCubit>(() => TaskListCubit(sl<TaskRepository>()));
}
