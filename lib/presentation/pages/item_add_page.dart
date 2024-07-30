import 'package:crud/data/models/add_data_model.dart';
import 'package:crud/presentation/cubit/crud_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/crud_repositories_impl.dart';

class ItemAddPage extends StatefulWidget {
  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpuModelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final crudRepository = RepositoryProvider.of<CrudRepository>(context);

    return BlocProvider(
      create: (context) => CrudCubit(crudRepository),
      child: BlocListener<CrudCubit, CrudState>(
        listener: (context, state) {
          if (state is CrudLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is CrudLoaded) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context, true);
          } else if (state is CrudError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Add New Item')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a CPU model';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newItem = AddDataModel(
                          name: _nameController.text,
                          data: DataAdd(
                            cpuModel: _cpuModelController.text,
                            price: double.parse(_priceController.text),
                          ),
                        );
                        context.read<CrudCubit>().postItem(newItem);
                      }
                    },
                    child: Text('Add Item'),
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
    _nameController.dispose();
    _cpuModelController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}




