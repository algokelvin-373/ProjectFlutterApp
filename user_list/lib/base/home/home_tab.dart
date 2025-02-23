import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_flutter/base/home/resource_bloc.dart';
import 'package:mobile_flutter/service/resource_service.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ResourceBloc(ResourceService())..add(const FetchResources(1)),
        child: Scaffold(
          body: BlocBuilder<ResourceBloc, ResourceState>(
            builder: (context, state) {
              if (state is ResourceLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ResourceLoaded) {
                final resources = state.resources;
                return GridView.builder(
                    itemCount: resources.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final resource = resources[index];
                      return Card(
                        elevation: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(
                                int.parse(resource.color.replaceFirst('#', 'FF'), radix: 16),
                              ),
                              child: Text(
                                resource.name[0], // Display the first letter of the user's name
                                style: const TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              resource.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Year: ${resource.year}',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                );
              } else if (state is ResourceError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('No data available'));
            },
          ),
        ),
    );
  }

}