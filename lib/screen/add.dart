import 'package:address_book/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/database_helper.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressDontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  label: Text('Name'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              controller: phoneController,
              decoration: const InputDecoration(
                  label: Text('Phone'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressDontroller,
              decoration: const InputDecoration(
                  label: Text('Address'), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () async {
                  BookDatabase bookDatabase = BookDatabase(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      address: addressDontroller.text);
                  int result = await databaseHelper.save(bookDatabase);
                  if (result > 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const SizedBox(height: 30),
                                const Center(
                                  child: Text(
                                    'Success',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Center(
                                      child: Text('OK'),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Center(
                  child: Text('Save'),
                ))
          ],
        ),
      ),
    );
  }
}
