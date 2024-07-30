part of 'crud_cubit.dart';

abstract class CrudState extends Equatable {
  @override
  List<Object> get props => [];
}

class CrudInitial extends CrudState {}

class CrudLoading extends CrudState {}

class CrudLoaded extends CrudState {
  final List<ListDataModel> items;

  CrudLoaded(this.items);
}
class CrudSuccess extends CrudState {
  final AddDataModel data;
  CrudSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class CrudLoadedItem extends CrudState {
  final DetailDataModel item;

  CrudLoadedItem(this.item);
  @override
  List<Object> get props => [item];
}

class CrudError extends CrudState {
  final String message;

  CrudError(this.message);

  @override
  List<Object> get props => [message];
}

class CrudDeleteSuccess extends CrudState {

}
class CrudUpdated extends CrudState {
  final UpdateDataModel updateDataModel;

  CrudUpdated(this.updateDataModel);
  @override
  List<Object> get props => [updateDataModel];
}