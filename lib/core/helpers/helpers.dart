library;

//* Import all default dart libraries here
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

//* Import all dependencies here
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';


//* Import all local files here
import '../../config/di/di.dart';
import '../../config/l10n/app_localizations.dart';
import '../../config/services/services.dart';
import '../../config/share/share.dart';
import '../../config/themes/themes.dart';
import '../../src/presentation/blocs/blocs.dart';
import '../constants/constants.dart';
import '../utils/utils.dart';

part 'provider/app_providers.dart';
//* Import all helper here
part 'extension/data.dart';
part 'log/logger.dart';
part 'popup/message.dart';
part 'navigation/navigator.dart';
part 'popup/noti_message.dart';
part 'extension/object.dart';
part 'popup/overlay.dart';
part 'annotation/parser_anotation.dart';
