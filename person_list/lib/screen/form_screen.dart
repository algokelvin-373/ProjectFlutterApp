import 'package:flutter/material.dart';
import 'package:person_list/model/profile.dart';
import 'package:person_list/provider/local_db_provider.dart';
import 'package:person_list/static/action_page_enum.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  final ActionPageEnum actionPageEnum;
  final Profile? profile;

  const FormScreen({
    super.key,
    required this.actionPageEnum,
    this.profile,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _phoneNumberController =
  TextEditingController();
  bool _isMarried = false;

  // todo-03-action-08: setup the profile value before UI is build
  @override
  void initState() {
    super.initState();

    if (widget.actionPageEnum.isEdit) {
      _nameController.text = widget.profile?.name ?? "";
      _emailController.text = widget.profile?.email ?? "";
      _phoneNumberController.text = widget.profile?.phoneNumber ?? "";
      setState(() {
        _isMarried = widget.profile?.maritalStatus ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Form Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Input your name",
                  label: Text("Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox.square(dimension: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Input your email",
                  label: Text("Email"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox.square(dimension: 16),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "81-xxx-xxx-xxx",
                  label: Text("Phone Number"),
                  prefixText: "+62",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox.square(dimension: 16),
              SwitchListTile.adaptive(
                title: const Text("Are you married?"),
                value: _isMarried,
                onChanged: (value) {
                  setState(() {
                    _isMarried = value;
                  });
                },
              ),
              const SizedBox.square(dimension: 32),
              FilledButton.icon(
                // todo-03-action-09: make the icon and name more flexible based on parameter
                icon: Icon(
                    widget.actionPageEnum.isEdit ? Icons.edit : Icons.save),
                label: Text(widget.actionPageEnum.isEdit ? "Edit" : "Save"),
                onPressed: () async {
                  // todo-03-action-10: do the edit or save the profile data
                  final localDatabaseProvider =
                  context.read<LocalDatabaseProvider>();
                  final profile = Profile(
                    name: _nameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneNumberController.text,
                    maritalStatus: _isMarried,
                  );

                  if (widget.actionPageEnum.isEdit) {
                    await localDatabaseProvider.updateProfileValueById(
                      widget.profile!.id!,
                      profile,
                    );
                  } else {
                    await localDatabaseProvider.saveProfileValue(profile);
                  }
                  await localDatabaseProvider.loadAllProfileValue();

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}