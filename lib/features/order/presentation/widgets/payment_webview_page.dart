import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentWebViewPage extends StatefulWidget {
  const PaymentWebViewPage({super.key, required this.initialUrl});
  final String initialUrl;

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  InAppWebViewController? _controller;
  double _progress = 0;

  bool _handledResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پرداخت'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
      body: Column(
        children: [
          if (_progress < 1) LinearProgressIndicator(value: _progress),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                domStorageEnabled: true,
                thirdPartyCookiesEnabled: true,
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                clearCache: false,
                transparentBackground: false,
                supportZoom: false,
              ),
              onWebViewCreated: (controller) => _controller = controller,
              onProgressChanged: (controller, progress) {
                setState(() => _progress = progress / 100);
              },
              shouldOverrideUrlLoading: (controller, action) async {
                final uri = action.request.url?.uriValue;
                if (uri == null) return NavigationActionPolicy.ALLOW;

                if (uri.scheme == 'sairon' && uri.host == 'payment-result') {
                  log('✅ Payment deeplink intercepted inside WebView: $uri');

                  if (!_handledResult) {
                    _handledResult = true;
                    Navigator.pop(context, uri);
                  }
                  return NavigationActionPolicy.CANCEL;
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadError: (controller, url, code, message) {
                log('❌ WebView load error: $code $message url=$url');
              },
            ),
          ),
        ],
      ),
    );
  }
}
