import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';
import 'package:miro/views/widgets/kira_custom/kira_toast.dart';

class KiraGravatar extends StatelessWidget {
  final String address;

  const KiraGravatar({required this.address, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FlutterClipboard.copy(address);
        KiraToast.show('Address copied');
      },
      borderRadius: BorderRadius.circular(500),
      child: Container(
        width: 75,
        height: 75,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.string(
              Jdenticon.toSvg(address),
              fit: BoxFit.contain,
              height: 70,
              width: 70,
            ),
          ),
        ),
      ),
    );
  }
}
