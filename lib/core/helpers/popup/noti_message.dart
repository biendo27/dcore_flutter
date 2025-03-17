part of '../helpers.dart';

mixin DNotiMessage {
  static void featureInDevelopment() {
    DMessage.showMessage(
      message: AppConfig.context!.text.featureInDevelopment,
      type: MessageType.info,
    );
  }
}
