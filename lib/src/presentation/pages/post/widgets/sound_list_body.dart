part of '../post.dart';

class SoundListBody extends StatelessWidget {
  final List<Sound> sounds;
  final bool isFavorite;
  const SoundListBody({super.key, required this.sounds, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16).w,
      itemCount: sounds.length,
      itemBuilder: (context, index) => SoundListItem(sound: sounds[index], isFavorite: isFavorite),
    );
  }
}
