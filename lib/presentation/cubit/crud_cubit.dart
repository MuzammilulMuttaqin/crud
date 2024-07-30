import 'package:bloc/bloc.dart';
import 'package:crud/data/models/DetailDataModel.dart';
import 'package:crud/data/models/add_data_model.dart';
import 'package:crud/data/models/list_data_model.dart';
import 'package:crud/data/models/update_data_model.dart';
import 'package:crud/data/models/update_data_model.dart';
import 'package:crud/data/repositories/crud_repositories_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'crud_state.dart';

class CrudCubit extends Cubit<CrudState> {
  final CrudRepository repository;

  CrudCubit(this.repository) : super(CrudInitial());

  Future<void> getItems() async {
    emit(CrudLoading());
    try {
      final items = await repository.getItems();
      emit(CrudLoaded(items));
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }

  Future<void> getItem(String id) async {
    emit(CrudLoading());
    try {
      final item = await repository.getItem(id);
      emit(CrudLoadedItem(item));
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }

  Future<void> postItem(AddDataModel item) async {
    emit(CrudLoading());
    try {
      await repository.postItem(item);
      await getItems();
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }

  Future<void> updateItem(String id, UpdateDataModel item) async {
    emit(CrudLoading());
    try {
      await repository.updateItem(id, item);
      await getItems(); // Refresh the list after updating
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }

  Future<void> deleteItem(String id) async {
    emit(CrudLoading());
    try {
      await repository.deleteItem(id);
      await getItems();
    } catch (e) {
      emit(CrudError(e.toString()));
    }
  }
}

