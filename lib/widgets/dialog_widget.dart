import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final String text;
  final Widget Function() otherPage;
  final Widget Function() function;

  const DialogWidget({
    required this.text,
    required this.otherPage,
    required this.function,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              function;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => otherPage(),
              ));
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}


//  Future<void> _confirmDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure want add this item?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Yes'),
//               onPressed: onClicked
//             ),
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
