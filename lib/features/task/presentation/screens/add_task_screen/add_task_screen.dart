import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';

class AddTaskScreen extends StatelessWidget {
 AddTaskScreen({super.key});
TextEditingController titleController =TextEditingController();
TextEditingController noteController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          AppStrings.addTask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! title
              Text(
                AppStrings.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                
                  //hint
                  hintText: AppStrings.titleHint,
                  hintStyle: Theme.of(context).textTheme.displayMedium,
                  
                ),
              ),
              const SizedBox(height: 24,),
              //! note
              Text(
                AppStrings.note,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                
                  //hint
                  hintText: AppStrings.noteHint,
                  hintStyle: Theme.of(context).textTheme.displayMedium,
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
