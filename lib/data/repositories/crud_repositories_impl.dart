import 'package:crud/data/datasource/crud_remote_datasource.dart';
import 'package:crud/data/models/DetailDataModel.dart';
import 'package:crud/data/models/add_data_model.dart';
import 'package:crud/data/models/delete_data_model.dart';
import 'package:crud/data/models/list_data_model.dart';
import 'package:crud/data/models/update_data_model.dart';

class CrudRepository {
  final CrudRemoteDataSource remoteDataSource;

  CrudRepository(this.remoteDataSource);

  Future<List<ListDataModel>> getItems() async {
    return await remoteDataSource.getItems();
  }

  Future<DetailDataModel> getItem(String id) async {
    return await remoteDataSource.getItem(id);
  }

  Future<void> postItem(AddDataModel item) async {
    await remoteDataSource.postItem(item);
  }

  Future<UpdateDataModel> updateItem(String id, UpdateDataModel item) async {
    return await remoteDataSource.updateItem(id, item);
  }

  Future<DeleteDataModel> deleteItem(String id) async {
    return await remoteDataSource.deleteItem(id);
  }
}