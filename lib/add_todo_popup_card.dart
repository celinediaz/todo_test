import 'dart:ui';
import 'package:flutter/material.dart';

class AddTodoPopupCard extends StatelessWidget {
  final TextEditingController textCtrl;
  final void Function(String) onSave;

  AddTodoPopupCard({
    required this.textCtrl,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(26.0),
        child: Hero(
          tag: 'add-todo-hero',
          child: Material(
            elevation:2,
            color: Colors.purple.shade100,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: Colors.purple.shade200,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Take out the trash',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple.shade200,
                              width: 1,
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple.shade500,
                                width: 1,
                              )
                          ),
                        ),
                        controller: textCtrl,
                      )
                    ),
                    ElevatedButton(
                      onPressed: () => onSave(textCtrl.text),
                      child: const Text(
                        'Save',
                      )
                    )
                  ],
                )
              )
            )
          )
        )
      )
    );
  }

}