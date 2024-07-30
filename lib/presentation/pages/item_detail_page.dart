import 'package:crud/data/repositories/crud_repositories_impl.dart';
import 'package:crud/presentation/cubit/crud_cubit.dart';
import 'package:crud/presentation/pages/item_list_page.dart';
import 'package:crud/presentation/pages/item_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailPage extends StatefulWidget {
  final String id;

  ItemDetailPage({required this.id});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late CrudCubit _crudCubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _crudCubit = CrudCubit(RepositoryProvider.of<CrudRepository>(context));
    _crudCubit.getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _crudCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Item Details')),
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
                  // Print the error to the console
                  print('Error: ${state.message}');
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                } else if (state is CrudLoadedItem) {
                  setState(() {
                    isLoading = false;
                  });
                } else if (state is CrudDeleteSuccess) {
                  // Navigate back to ItemListPage after successful deletion
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ItemListPage()),
                        (Route<dynamic> route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item deleted successfully')),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<CrudCubit, CrudState>(
            builder: (context, state) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CrudLoadedItem) {
                final item = state.item;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${item.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Name: ${item.name}'),
                      Text('CPU Model: ${item.data?.cpuModel}'),
                      Text('Price: ${item.data?.price}'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemUpdatePage(id: widget.id),
                            ),
                          );
                        },
                        child: const Text('Update Item'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CrudCubit>().deleteItem(widget.id);
                        },
                        child: const Text('Delete Item'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No Details'));
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _crudCubit.close();
    super.dispose();
  }
}


