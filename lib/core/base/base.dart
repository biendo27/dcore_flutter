library;

//* Import all default dart libraries here
import 'dart:async';
import 'dart:isolate';

//* Import all dependencies here
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//* Import all local files here
import '../helpers/helpers.dart';

//* Import all base files here
part 'base.freezed.dart';
part 'base.g.dart';
part 'bloc/bloc_action.dart';
part 'bloc/cubit_action.dart';
part 'error/failure.dart';
part 'network/data_state.dart';
part 'network/network_request.dart';
part 'responses/base_page_break.dart';
part 'responses/base_response.dart';
part 'responses/base_socket_response.dart';
part 'use_case/use_case.dart';
