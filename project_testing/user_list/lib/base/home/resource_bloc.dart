import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_flutter/model/resource.dart';
import 'package:mobile_flutter/service/resource_service.dart';

part 'resource_event.dart';
part 'resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final ResourceService resourceService;

  ResourceBloc(this.resourceService) : super(ResourceInitial()) {
    on<ResourceEvent>((event, emit) async {
      emit(ResourceLoading());
      try {
        final response = await resourceService.fetchResources(event.page);
        emit(ResourceLoaded(response.resources));
      } catch (e) {
        emit(ResourceError(e.toString()));
      }
    });
  }
}
