import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImageLayerProvider.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class ImageLayers extends ConsumerWidget {
  List<ConversationImageLayerProvider> _layers;
  ImageLayers(this._layers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Stack(
      children: [
        for (ConversationImageLayerProvider layer in _layers)
          Positioned(
              width: GetScreenSize.screenWidth() *
                  ref.watch(layer.animationProvider).stateDouble['width']!,
              height: GetScreenSize.screenHeight() *
                  ref.watch(layer.animationProvider).stateDouble['height']!,
              left: GetScreenSize.screenWidth() *
                  (ref.watch(layer.animationProvider).stateDouble['posX']! +
                      1 -
                      ref
                          .watch(layer.animationProvider)
                          .stateDouble['width']!) *
                  0.5,
              top: GetScreenSize.screenHeight() *
                  (ref.watch(layer.animationProvider).stateDouble['posY']! +
                      1 -
                      ref
                          .watch(layer.animationProvider)
                          .stateDouble['height']!) *
                  0.5,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(
                      ref.watch(layer.animationProvider).stateDouble['rotX']!)
                  ..rotateY(
                      ref.watch(layer.animationProvider).stateDouble['rotY']!)
                  ..rotateZ(
                      ref.watch(layer.animationProvider).stateDouble['rotZ']!),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: ref
                      .watch(layer.animationProvider)
                      .stateDouble['opacity']!,
                  child: Image(
                    // color: Colors.black.withOpacity(1 -
                    //     ref
                    //         .watch(layer.animationProvider)
                    //         .stateDouble['brightness']!),
                    color: Colors.black.withOpacity(0.1),
                    colorBlendMode: BlendMode.srcATop,
                    image: AssetImage(ref
                        .watch(layer.animationProvider)
                        .stateDynamic['imagePath']),
                  ),
                ),
              ))
      ],
    );
  }
}
