part of '../message.dart';

class Setting extends StatelessWidget {
  final Conversation conversation;
  const Setting({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    List<SettingModule> listSetting = [
      SettingModule("Tắt tiếng thông báo"),
      SettingModule("Ghim lên đầu"),
      SettingModule("Chặn"),
    ];

    return SubLayout(
        title: "Chi tiết",
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            children: List.generate(listSetting.length, (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(listSetting[index].title, style: AppStyle.text16,),
                  BlocBuilder<MessageCubit, MessageState>(
                    builder: (context, state) {
                      bool? value;
                      switch (index) {
                        case 0: value = state.turnOffNotification;
                        case 1: value = state.isPin;
                        case 2: value = state.isBlock;

                        default: value = false;
                      }

                      return Switch(
                        value: value,
                        activeColor: Colors.white,
                        activeTrackColor: AppCustomColor.orangeF1,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        trackOutlineWidth: WidgetStateProperty.all(0),
                        onChanged: (bool value) {
                          if(index == 0) {
                            context.read<MessageCubit>()
                                .handleNotification(!state.turnOffNotification);
                          }

                          if(index == 1) {
                            context.read<MessageCubit>()
                                .pinToUser(!state.isPin);
                          }

                          if(index == 2) {
                            context.read<MessageCubit>()
                                .blockOrUnblock(isBlock: !state.isBlock);
                          }
                        },
                      );
                    }
                  ),
                ],
              );
            }),
          ),
        )
    );
  }
}

class SettingModule {
  final String title;
  bool value;

  SettingModule(this.title,{this.value = false});
}
