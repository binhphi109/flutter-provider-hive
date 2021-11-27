import 'package:flutter/material.dart';
import 'package:flutter_sample/stores/errors.dart';
import 'package:flutter_sample/widgets/empty_wrapper.dart';
import 'package:provider/provider.dart';

class ErrorList extends StatefulWidget {
  const ErrorList({
    Key? key,
  }) : super(key: key);

  @override
  _ErrorListState createState() => _ErrorListState();
}

class _ErrorListState extends State<ErrorList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Errors>(
      builder: (_, model, __) {
        return EmptyWrapper(
          title: 'No Errors',
          icon: Icons.web,
          content: 'There are currently no errors found',
          data: model.errors,
          child: ListView.builder(
            itemCount: model.errors.length,
            itemBuilder: (context, index) {
              var error = model.errors[index];

              return Card(
                child: ListTile(
                    title: Text(
                      '${error.text}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      // handleErrorTap(error);
                    }),
              );
            },
          ),
        );
      },
    );
  }
}
