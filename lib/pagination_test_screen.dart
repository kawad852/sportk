import 'package:flutter/material.dart';
import 'package:sportk/model/test_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class PaginationTestScreen extends StatefulWidget {
  const PaginationTestScreen({super.key});

  @override
  State<PaginationTestScreen> createState() => _PaginationTestScreenState();
}

class _PaginationTestScreenState extends State<PaginationTestScreen> {
  Future<TestModel> _fetch(int pageKey) {
    return ApiService<TestModel>().build(
      link: 'https://ta2weel.com/public/api/v1/recent-dreams?page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: TestModel.fromJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      query: (pageKey) async => _fetch(pageKey),
      onFetching: (snapshot) async => snapshot.data!,
      pageSize: 10,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
              return const VexLoader();
            }

            final data = snapshot.docs[index] as Datum;
            return ListTile(
              leading: Text(data.id.toString()),
              title: Text(data.name.toString()),
            );
          },
        );
      },
    );
  }
}
