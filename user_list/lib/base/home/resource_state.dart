part of 'resource_bloc.dart';

abstract class ResourceState extends Equatable {
  const ResourceState();
}

class ResourceInitial extends ResourceState {
  @override
  List<Object> get props => [];
}

class ResourceLoading extends ResourceState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResourceLoaded extends ResourceState {
  final List<Resource> resources;

  const ResourceLoaded(this.resources);

  @override
  List<Object> get props => [resources];
}

class ResourceError extends ResourceState {
  final String message;

  const ResourceError(this.message);

  @override
  List<Object> get props => [message];
}