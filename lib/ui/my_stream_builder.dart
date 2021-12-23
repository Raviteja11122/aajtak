import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MyStreamBuilder<T> extends StatelessWidget {

  const MyStreamBuilder({
    Key key,
    @required this.stream,
    @required this.onDataWidget,
    @required this.onRefreshClicked,
    this.retryWidget,
    this.initialData,
    this.loadingChild,
    this.errorWidget,
    this.useSimpleRetry = false
  }) : super(key: key);

  final Stream<T> stream;
  final Widget Function(T data) onDataWidget;
  final VoidCallback onRefreshClicked;
  final Widget loadingChild;
  final Widget errorWidget;
  final Widget retryWidget;
  final bool useSimpleRetry;
  final T initialData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if(errorWidget != null) {
            return errorWidget;
          }
          return useSimpleRetry ? SimpleRetryWidget(onRefreshClicked: onRefreshClicked) : retryWidget ?? RetryWidget(onRefreshClicked: onRefreshClicked);
        }
        if(snapshot.hasData) {
          return onDataWidget(snapshot.data);
        } else {
          return loadingChild ?? const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class RetryWidget extends StatelessWidget {

  const RetryWidget({
    Key key,
    @required this.onRefreshClicked,
    this.hideBackButton = false
  }) : super(key: key);

  final VoidCallback onRefreshClicked;
  final bool hideBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !hideBackButton,
        actions: <Widget>[
          Container()
        ],
        title: Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
      body: SimpleRetryWidget(onRefreshClicked: onRefreshClicked),
    );
  }
}

class SimpleRetryWidget extends StatelessWidget {

  const SimpleRetryWidget({
    Key key,
    @required this.onRefreshClicked,
  }) : super(key: key);

  final VoidCallback onRefreshClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
            borderRadius: BorderRadius.circular(50)
        ),
        child: IconButton(
          icon: const Icon(LineIcons.alternateRedo),
          iconSize: 40,
          onPressed: onRefreshClicked
        ),
      ),
    );
  }
}