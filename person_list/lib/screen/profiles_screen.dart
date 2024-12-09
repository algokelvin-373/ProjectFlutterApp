import 'package:flutter/material.dart';
import 'package:person_list/model/profile.dart';
import 'package:person_list/provider/local_db_provider.dart';
import 'package:person_list/static/action_page_enum.dart';
import 'package:person_list/widgets/profile_card_widget.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({
    super.key,
  });

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  // todo-03-action-02: load all profile data into list
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllProfileValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileCardWidget(
                profile: Profile(
                  name: "Ilham",
                  email: "ilham@dicoding.com",
                  phoneNumber: "81234567890",
                  maritalStatus: true,
                ),
              ),
              Consumer<LocalDatabaseProvider>(
                builder: (context, value, child) {
                  if (value.profileList == null) {
                    return const SizedBox();
                  }

                  final profileList = value.profileList!;
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: profileList.length,
                    itemBuilder: (context, index) {
                      final profile = profileList[index];
                      return ProfileCardWidget(
                        profile: profile,
                        onTapRemove: () async {
                          if (profile.id != null) {
                            final localDatabaseProvider =
                            context.read<LocalDatabaseProvider>();
                            await localDatabaseProvider
                                .removeProfileValueById(profile.id!);
                            await localDatabaseProvider.loadAllProfileValue();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("This item cannot be deleted")),
                            );
                          }
                        },
                        onTapEdit: () {
                          if (profile.id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormScreen(
                                    actionPageEnum: ActionPageEnum.edit,
                                    profile: profile,
                                  )),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("This item cannot be deleted")),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FormScreen(
                  actionPageEnum: ActionPageEnum.add,
                )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}