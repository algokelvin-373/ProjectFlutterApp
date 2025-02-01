part of 'resource_bloc.dart';

abstract class ResourceEvent extends Equatable {
  const ResourceEvent();

  @override
  List<Object> get props => [];

  int get page => 1;
}

class FetchResources extends ResourceEvent {
  final int page;

  const FetchResources(this.page);

  @override
  List<Object> get props => [page];
}