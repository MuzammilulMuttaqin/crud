import 'package:crud/data/datasource/crud_remote_datasource.dart';
import 'package:crud/data/datasource/dio_client.dart';
import 'package:crud/data/repositories/crud_repositories_impl.dart';
import 'package:crud/presentation/cubit/crud_cubit.dart';
import 'package:crud/presentation/pages/item_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  final dio = DioClient.dio;
  final remoteDataSource = CrudRemoteDataSource(dio);
  final repository = CrudRepository(remoteDataSource);
  runApp( MyApp(repository));
}

class MyApp extends StatelessWidget {
  final CrudRepository repository;

  MyApp(this.repository);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: MaterialApp(
        title: 'Flutter CRUD',
        home: BlocProvider(
          create: (context) => CrudCubit(repository),
          child: ItemListPage(),
        ),
      ),
    );
  }
}
