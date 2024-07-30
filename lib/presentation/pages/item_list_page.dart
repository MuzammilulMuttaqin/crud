import 'package:crud/presentation/cubit/crud_cubit.dart';
import 'package:crud/presentation/pages/item_add_page.dart';
import 'package:crud/presentation/pages/item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CrudCubit>().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<CrudCubit>().getItems();
            },
          ),
        ],
      ),
      body: BlocBuilder<CrudCubit, CrudState>(
        builder: (context, state) {
          if (state is CrudLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CrudLoaded) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name ?? 'No Name'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(id: item.id!),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is CrudError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No items found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemAddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


