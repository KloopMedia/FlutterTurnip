// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gigaturnip/extensions/buildcontext/loc.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../utilities/dialogs/delete_account_dialog.dart';
//
// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);
//
//   static Page page() => const MaterialPage<void>(child: SettingsPage());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.loc.settings),
//         centerTitle: true,
//         leading: BackButton(
//           onPressed: () {
//             context.pop();
//           },
//         ),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(8),
//         child: SettingsView(),
//       ),
//     );
//   }
// }
//
// class SettingsView extends StatelessWidget {
//   const SettingsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
//             onPressed: () async {
//               final bloc = context.read<AppBloc>();
//               final confirmation = await deleteAccountDialog(context);
//               if (confirmation != null) {
//                 bloc.add(DeleteAccountRequested(confirmation));
//               }
//             },
//             child: Text(
//               context.loc.delete_account_button,
//               style: const TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
