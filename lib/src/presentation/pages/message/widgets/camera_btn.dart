part of '../message.dart';

class CameraBtn extends StatelessWidget {
  final Function(int) callBackCameraBtn;

  const CameraBtn({super.key, required this.callBackCameraBtn});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(15)), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTilesCustom(
                onTap: (btnIndex) {
                  DNavigator.back();
                  callBackCameraBtn(btnIndex);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListTilesCustom extends StatelessWidget {
  final Function(int) onTap;

  const ListTilesCustom({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => onTap(index),
          child: Column(
            children: [
              if (index != 0) Divider(color: Colors.grey.op(0.5), indent: 15, endIndent: 15),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  index == 0
                      ? "Chụp ảnh"
                      : index == 1
                          ? "Hình ảnh"
                          : index == 2
                              ? "Video"
                              : "Đóng",
                  style: AppStyle.text16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
