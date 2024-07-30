import 'package:crud/data/repositories/crud_repositories_impl.dart';
import 'package:crud/presentation/cubit/crud_cubit.dart';
import 'package:flutter/material.dart';
import 'package:crud/data/models/update_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemUpdatePage extends StatefulWidget {
  final String id;

  ItemUpdatePage({required this.id});

  @override
  State<ItemUpdatePage> createState() => _ItemUpdatePageState();
}

class _ItemUpdatePageState extends State<ItemUpdatePage> {
  late CrudCubit _crudCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cpuModelController;
  late TextEditingController _priceController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _crudCubit = CrudCubit(RepositoryProvider.of<CrudRepository>(context));
    _crudCubit.getItem(widget.id);

    _nameController = TextEditingController();
    _cpuModelController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _crudCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Update Item')),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CrudCubit, CrudState>(
              listener: (context, state) {
                if (state is CrudLoading) {
                  setState(() {
                    isLoading = true;
                  });
                } else if (state is CrudError) {
                  setState(() {
                    isLoading = false;
                  });
                  print('Error: ${state.message}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                } else if (state is CrudLoadedItem) {
                  setState(() {
                    isLoading = false;
                    _nameController.text = state.item.name ?? '';
                    _cpuModelController.text = state.item.data?.cpuModel ?? '';
                    _priceController.text = state.item.data?.price?.toString() ?? '';
                  });
                } else if (state is CrudUpdated) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item updated successfully')),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoading) Center(child: CircularProgressIndicator()),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cpuModelController,
                    decoration: InputDecoration(labelText: 'CPU Model'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final updatedItem = UpdateDataModel(
                          id: widget.id,
                          name: _nameController.text,
                          data: Data(
                            cpuModel: _cpuModelController.text,
                            price: double.tryParse(_priceController.text),
                          ),
                          updatedAt: DateTime.now(),
                        );
                        context.read<CrudCubit>().updateItem(widget.id, updatedItem);
                      }
                    },
                    child: Text('Update Item'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _crudCubit.close();
    _nameController.dispose();
    _cpuModelController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
