// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GenerateImageToShare extends StatelessWidget {
  const GenerateImageToShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // background image
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/share_bg_img/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Text(
                    'verse',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                margin: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download, color: Colors.white,),
                      onPressed: () {
                        // download image
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white,),
                      onPressed: () {
                        // share image
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.white,),
                      onPressed: () {
                        // change background image
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.color_lens, color: Colors.white,),
                      onPressed: () {
                        // change text color
                      },
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class EditOption extends StatelessWidget {
  const EditOption({
    super.key,
    required this.icon,
    this.onPressed,
  });
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
