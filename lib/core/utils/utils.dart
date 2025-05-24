library;

//* Import all default dart here
import 'dart:async';
import 'dart:io';
import 'dart:math';

//* Import all dependency here
import 'package:cached_network_image/cached_network_image.dart';
import 'package:darq/darq.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart' as df;
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:video_player/video_player.dart';

//* Import all files here
import '../../config/routes/routes.dart';
import '../../config/services/services.dart';
import '../../config/themes/themes.dart';
import '../../src/presentation/blocs/blocs.dart';
import '../constants/constants.dart';
import '../helpers/helpers.dart';

//* Export all animation files
part 'animation/expand_container.dart';
part 'animation/fade_up.dart';
part 'animation/page_transition.dart';
part 'animation/slide_stransition.dart';
//* Export all button files
part 'button/button.dart';
part 'button/gradient_button.dart';
//* Export all decoration files
part 'decoration/gradient_indicator.dart';
//* Export all images files
part 'images/cache_image.dart';
part 'images/cache_images.dart';
part 'images/container_image.dart';
part 'images/image_view_page.dart';
part 'images/network_avatar.dart';
//* Export all input files
part 'input/dropdown.dart';
part 'input/range.dart';
part 'input/select_search_button.dart';
part 'input/text_field.dart';
//* Export all layout files
part 'layouts/landing_layout.dart';
part 'layouts/scaffod_layout.dart';
//* Export all navbar files
part 'navbar/bottom_nav.dart';
part 'navbar/bottom_nav_curve.dart';
part 'navbar/nav_bar_items.dart';
//* Export all overlay files
part 'overlay/about_dialog.dart';
part 'overlay/bottom_sheet.dart';
part 'overlay/data_bottom_sheet.dart';
part 'overlay/dialog.dart';
part 'overlay/message.dart';
part 'overlay/notification_dialog.dart';
part 'overlay/yes_no_dialog.dart';
//* Export all select files
part 'select/check_box.dart';
part 'select/radio_button.dart';
//* Export all sliver files
part 'sliver/sliver_appbar.dart';
part 'sliver/sliver_child.dart';
part 'sliver/sliver_list_child.dart';
//* Export all text files
part 'text/d_text.dart';
part 'text/expandable_html_text.dart';
part 'text/expandable_text.dart';
part 'text/gradient_text.dart';
part 'text/high_light_text.dart';
part 'text/icon_text.dart';
part 'text/title_and_text.dart';
//* Export all timer files
part 'timer/count_down.dart';
part 'timer/stop_watch.dart';
//* Export all ui files
part 'ui/srcreen_size.dart';
part 'ui/unfocused.dart';
//* Export all video files
part 'video/preload_view.dart';
part 'video/video_view.dart';
//* Export all webview files
part 'webview/web_view.dart';
//* Export all wrap files
part 'wrap/app_loading.dart';
part 'wrap/gradient_box_border.dart';
part 'wrap/gradient_typography.dart';
part 'wrap/load_more.dart';
part 'wrap/loading_wrap.dart';
