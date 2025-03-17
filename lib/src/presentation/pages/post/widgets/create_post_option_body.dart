part of '../post.dart';

class CreatePostOptionBody extends StatelessWidget {
  const CreatePostOptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildToggleOption(
              context,
              context.text.allowComments,
              state.allowComments,
              (value) => context.read<CreatePostCubit>().toggleAllowComments(),
            ),
            _buildToggleOption(
              context,
              context.text.selectVideoLanguage,
              false,
              null,
              trailing: _buildLanguageDropdown(context),
            ),
            _buildToggleOption(
              context,
              context.text.allowVideoDownload,
              state.allowDownload,
              (value) => context.read<CreatePostCubit>().toggleAllowDownload(),
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (!state.user.isAffiliate) return const SizedBox.shrink();
                return _buildAffiliateProductDropdown(context);
              },
            ),
            24.verticalSpace,
            _buildPostButton(context),
          ],
        );
      },
    );
  }

  Widget _buildToggleOption(BuildContext context, String title, bool value, Function(bool)? onChanged, {Widget? trailing}) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? Switch(value: value, onChanged: onChanged),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: state.selectedLanguage.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<CreatePostCubit>().updateSelectedLanguage(LocaleType.fromString(newValue));
            }
          },
          items: LocaleType.values.map<DropdownMenuItem<String>>((LocaleType value) {
            return DropdownMenuItem<String>(
              value: value.value,
              child: Text(value.label),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPostButton(BuildContext context) {
    return DButton(
      text: context.text.post,
      onPressed: () => context.read<CreatePostCubit>().createPost(),
    );
  }

  Widget _buildAffiliateProductDropdown(BuildContext context) {
    return BlocBuilder<CreatePostCubit, CreatePostState>(
      builder: (context, state) {
        return SelectSearchButton(
          onChanged: (value) => context.read<CreatePostCubit>().selectProduct(value),
          items: state.products.map((e) => DropdownItem(value: e, label: e.name)).toList(),
          selectedValue: state.selectedProduct,
          hint: context.text.affiliateProduct,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        );
      },
    );
  }
}
