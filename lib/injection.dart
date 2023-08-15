import 'package:advicer_app/application/pages/advice/bloc/advice_bloc.dart';
import 'package:advicer_app/data/datasource/remote_datasource.dart';
import 'package:advicer_app/data/repository/advice_repo_impl.dart';
import 'package:advicer_app/domain/repository/advice_repository.dart';
import 'package:advicer_app/domain/usecases/advice_usescases.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.I;

Future<void> init() async {
  // ! application layer
  serviceLocator
      .registerFactory(() => AdviceBloc(adviceUseCases: serviceLocator()));

  // ! domain layer
  serviceLocator
      .registerFactory(() => AdviceUseCases(adviceRepo: serviceLocator()));

  // ! data layer
  serviceLocator.registerFactory<AdviceRepository>(
      () => AdviceRepositoryImpl(remoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: serviceLocator()));

  // ! externs
  serviceLocator.registerFactory(() => http.Client());
}
