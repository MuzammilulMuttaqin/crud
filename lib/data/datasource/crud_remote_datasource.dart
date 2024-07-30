import 'package:crud/data/models/DetailDataModel.dart';
import 'package:crud/data/models/add_data_model.dart';
import 'package:crud/data/models/delete_data_model.dart';
import 'package:crud/data/models/list_data_model.dart';
import 'package:crud/data/models/update_data_model.dart';
import 'package:dio/dio.dart';

class CrudRemoteDataSource {
  final Dio dio;

  CrudRemoteDataSource(this.dio);

  Future<List<ListDataModel>> getItems() async {
    try {
      final response = await dio.get('');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => ListDataModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  Future<DetailDataModel> getItem(String id) async {
    try {
      final response = await dio.get('/$id');
      if (response.statusCode == 200) {
        return DetailDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load item');
      }
    } catch (e) {
      throw Exception('Failed to load item: $e');
    }
  }

  Future<void> postItem(AddDataModel item) async {
    try {
      final response = await dio.post(
        '/your-endpoint',
        data: {
          'name': item.name,
          'data': {
            'year': item.data?.year,
            'price': item.data?.price,
            'CPU model': item.data?.cpuModel,
            'Hard disk size': item.data?.hardDiskSize,
          }
        },
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create item');
      }
    } catch (e) {
      throw Exception('Failed to create item: $e');
    }
  }

  Future<UpdateDataModel> updateItem(String id, UpdateDataModel item) async {
    try {
      final response = await dio.put('/$id', data: item.toJson());
      if (response.statusCode == 200) {
        return UpdateDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  Future<DeleteDataModel> deleteItem(String id) async {
    try {
      final response = await dio.delete('/${id}}');
      if (response.statusCode == 200) {
        return DeleteDataModel.fromJson(response.data);
      } else {
        print('Failed to delete item: ${response.statusCode}');
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete item: $e');
    }
  }
}