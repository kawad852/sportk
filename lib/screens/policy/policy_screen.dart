import 'package:flutter/material.dart';
import 'package:sportk/model/policy_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class PolicyScreen extends StatefulWidget {
  final int id;

  const PolicyScreen({
    super.key,
    required this.id,
  });

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late Future<PolicyModel> _policyFuture;

  void _initFuture() {
    _policyFuture = ApiService<PolicyModel>().build(
      weCanUrl: '${ApiUrl.policy}/${widget.id}',
      isPublic: true,
      apiType: ApiType.get,
      builder: PolicyModel.fromJson,
    );
  }

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _policyFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initFuture();
        });
      },
      onComplete: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data!.data!.title!),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Text(snapshot.data!.data!.description!),
          ),
        );
      },
    );
  }
}
