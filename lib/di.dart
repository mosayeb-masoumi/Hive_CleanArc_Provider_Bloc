
import 'package:get_it/get_it.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/data/contact_repository_impl.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/repository/contact_repository.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/usecase/contact_usecase.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/presentation/bloc/contact_cubit.dart';
import 'package:hive_clean_provider_bloc/core/db/app_database.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/data/note_repository_impl.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/domain/repository/note_repository.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/domain/usecase/note_usecase.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/presentation/note_view_model.dart';

final sl = GetIt.instance;
void setUpDI(){


  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // provider state_management
  sl.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(sl()));
  sl.registerLazySingleton<NoteUseCase>(() => NoteUseCase(sl()));
  sl.registerLazySingleton<NoteViewModel>(() => NoteViewModel(sl()));

  // bloc-cubit state_management
  sl.registerLazySingleton<ContactRepository>(() => ContactRepositoryImpl(sl()));
  sl.registerLazySingleton<ContactUseCase>(() => ContactUseCase(sl()));
  sl.registerLazySingleton<ContactCubit>(() => ContactCubit(sl()));
}