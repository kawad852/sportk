// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sportk/alerts/errors/error_widgets/server_error_widget.dart';
// import 'package:sportk/widgets/custom_loading_indicator.dart';
//
// class CustomFirestoreQueryBuilder<T> extends StatelessWidget {
//   final Query<T> query;
//   final Function(BuildContext context, FirestoreQueryBuilderSnapshot<T> snapshot) onComplete;
//   final Function()? onLoading;
//
//   const CustomFirestoreQueryBuilder({
//     Key? key,
//     required this.query,
//     required this.onComplete,
//     this.onLoading,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FirestoreQueryBuilder<T>(
//       query: query,
//       pageSize: 3,
//       builder: (context, snapshot, _) {
//         if (snapshot.hasData) {
//           return onComplete(context, snapshot);
//         } else if (snapshot.isFetching) {
//           return onLoading == null ? const CustomLoadingIndicator() : onLoading!();
//         } else {
//           return const ServerErrorWidget();
//         }
//       },
//     );
//   }
// }
