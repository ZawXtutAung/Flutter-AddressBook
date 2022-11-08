import 'package:address_book/database/db_model.dart';
import 'package:address_book/screen/add.dart';
import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Add();
          }));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('AddressBook'),
      ),
      body: FutureBuilder<List<BookDatabase>>(
        future: databaseHelper.getData(),
        builder: (BuildContext context, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.data!.isEmpty
                  ? const Center(
                      child: Text('NO-Data'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListCard(snapshot.data![index]);
                      },
                    );
        },
      ),
    );
  }

  Widget ListCard(BookDatabase book) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.amber,
                ),
                const SizedBox(width: 5),
                Text(book.name!),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.phone,
                  size: 35,
                  color: Colors.green,
                ),
                const SizedBox(width: 5),
                Text(book.phone!),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email, size: 35, color: Colors.red),
                const SizedBox(width: 5),
                Text(book.email!),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.place,
                  size: 35,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text(book.address!),
              ],
            ),
            const SizedBox(height: 7)
          ],
        ),
      ),
    );
  }
}
