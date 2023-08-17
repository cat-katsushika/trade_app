import 'package:flutter/material.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({Key? key, required this.textEditingController, required this.onFieldSubmitted}) : super(key: key);
  final TextEditingController textEditingController;
  final Function(String string) onFieldSubmitted;

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: SizedBox(
          height: 36,
          child: TextFormField(
            autocorrect: true,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, size: 25, color: Colors.blue,),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 12, 12, 10),
              hintStyle: const TextStyle(color: Colors.orange),
              filled: true,
              fillColor: Colors.orange,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
            onFieldSubmitted: (value) {
              debugPrint('onFieldSubmitted: $value');
              widget.onFieldSubmitted;
            },
          ),
        ),
      ),
    );
  }
}
