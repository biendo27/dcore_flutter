part of '../utils.dart';

class TextFieldRange extends StatefulWidget {
  final TextEditingController controller;
  final double? size;
  const TextFieldRange({super.key, required this.controller, this.size});

  @override
  State<TextFieldRange> createState() => _TextFieldRangeState();
}

class _TextFieldRangeState extends State<TextFieldRange> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (int.parse(widget.controller.text) < 1) return;
            widget.controller.text = '${int.parse(widget.controller.text) - 1}';
          },
          child: const Icon(Icons.remove_rounded),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: widget.size ?? 50,
          height: widget.size ?? 50,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: widget.controller,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.all(widget.size != null ? (widget.size! / 2) : 20),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            widget.controller.text = '${int.parse(widget.controller.text) + 1}';
          },
          child: Icon(Icons.add_rounded),
        ),
      ],
    );
  }
}
