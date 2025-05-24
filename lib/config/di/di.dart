library;

//* Import all default dart libraries here
import 'dart:async';

//* Import all dependencies here
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

//* Import all files here
import '../../core/constants/constants.dart';
import '../../core/helpers/helpers.dart';
import '../services/services.dart';
import '../share/share.dart';
import 'di.config.dart';

//* Import all route observer files here

//* Export all di files here
part 'app_di_config.dart';
part 'network_di.dart';
part 'route_observer_di.dart';
part 'tracking_di.dart';
