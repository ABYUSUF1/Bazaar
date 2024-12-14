import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: ListTile(
              title: Text('Item $index'),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              onTap: () {
                // Handle item tap
              },
            ),
          );
        },
      ),
    );
  }
}
