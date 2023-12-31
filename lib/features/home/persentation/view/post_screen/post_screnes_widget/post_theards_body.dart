import 'package:firee/features/home/persentation/view/post_screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manager/post_screen_cubit/post_screen_cubit.dart';

class PostTheardBody extends StatefulWidget {
  const PostTheardBody({super.key});

  @override
  State<PostTheardBody> createState() => _PostTheardBodyState();
}

class _PostTheardBodyState extends State<PostTheardBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLines: null,
          onChanged: (textt) {
            text = textt;
            BlocProvider.of<PostCubit>(context).text = textt;
            setState(() {});
          },
          decoration: const InputDecoration(
              hintText: 'Start a theards', border: InputBorder.none),
        ),
        BlocProvider.of<PostCubit>(context).imageFile == null
            ? IconButton(
                onPressed: () {
                  BlocProvider.of<PostCubit>(context).pickImage();
                },
                icon: const Icon(Icons.attach_file))
            : Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 300,
                        child: Image.file(
                            BlocProvider.of<PostCubit>(context).imageFile!),
                      )),
                  IconButton(
                      onPressed: () async {
                        BlocProvider.of<PostCubit>(context).pickImage();
                      },
                      icon: const Icon(Icons.attachment_outlined))
                ],
              ),
      ],
    );
  }
}
