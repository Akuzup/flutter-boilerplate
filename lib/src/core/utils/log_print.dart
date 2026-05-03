// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file implements debugPrint in terms of print, so avoiding
// calling "print" is sort of a non-starter here...
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:collection';

/// Signature for [debugPrint] implementations.
///
/// If a [wrapWidth] is provided, each line of the [message] is word-wrapped to
/// that width. (Lines may be separated by newline characters, as in '\n'.)
///
/// By default, this function very crudely attempts to throttle the rate at
/// which messages are sent to avoid data loss on Android. This means that
/// interleaving calls to this function (directly or indirectly via, e.g.,
/// [debugDumpRenderTree] or [debugDumpApp]) and to the Dart [print] method can
/// result in out-of-order messages in the logs.
///
/// The implementation of this function can be replaced by setting the
/// [debugPrint] variable to a new implementation that matches the
/// [DebugPrintCallback] signature. For example, flutter_test does this.
///
/// The default value is [debugPrintThrottled]. For a version that acts
/// identically but does not throttle, use [debugPrintSynchronously].
typedef DebugPrintCallback = void Function(String? message, {int? wrapWidth});

/// Prints a message to the console, which you can access using the "flutter"
/// tool's "logs" command ("flutter logs").
///
/// See also:
///
///   * [DebugPrintCallback], for function parameters and usage details.
DebugPrintCallback debugPrint = debugPrintThrottled;

/// Alternative implementation of [debugPrint] that does not throttle.
/// Used by tests.
void debugPrintSynchronously(String? message, {int? wrapWidth}) {
  if (message != null && wrapWidth != null) {
    print(
      message
          .split('\n')
          .expand<String>((String line) => debugWordWrap(line, wrapWidth))
          .join('\n'),
    );
  } else {
    print(message);
  }
}

/// Implementation of [debugPrint] that throttles messages. This avoids dropping
/// messages on platforms that rate-limit their logging (for example, Android).
void debugPrintThrottled(String? message, {int? wrapWidth}) {
  final messageLines = message?.split('\n') ?? <String>['null'];
  if (wrapWidth != null) {
    _debugPrintBuffer.addAll(
      messageLines.expand<String>(
        (String line) => debugWordWrap(line, wrapWidth),
      ),
    );
  } else {
    _debugPrintBuffer.addAll(messageLines);
  }
  if (!_debugPrintScheduled) {
    _debugPrintTask();
  }
}

int _debugPrintedCharacters = 0;
const int _kDebugPrintCapacity = 12 * 1024;
const Duration _kDebugPrintPauseTime = Duration(seconds: 1);
final Queue<String> _debugPrintBuffer = Queue<String>();
final Stopwatch _debugPrintStopwatch = Stopwatch();
Completer<void>? _debugPrintCompleter;
bool _debugPrintScheduled = false;
void _debugPrintTask() {
  _debugPrintScheduled = false;
  if (_debugPrintStopwatch.elapsed > _kDebugPrintPauseTime) {
    _debugPrintStopwatch.stop();
    _debugPrintStopwatch.reset();
    _debugPrintedCharacters = 0;
  }
  while (_debugPrintedCharacters < _kDebugPrintCapacity &&
      _debugPrintBuffer.isNotEmpty) {
    final line = _debugPrintBuffer.removeFirst();
    _debugPrintedCharacters += line.length;
    print(line);
  }
  if (_debugPrintBuffer.isNotEmpty) {
    _debugPrintScheduled = true;
    _debugPrintedCharacters = 0;
    Timer(_kDebugPrintPauseTime, _debugPrintTask);
    _debugPrintCompleter ??= Completer<void>();
  } else {
    _debugPrintStopwatch.start();
    _debugPrintCompleter?.complete();
    _debugPrintCompleter = null;
  }
}

/// A Future that resolves when there is no longer any buffered content being
/// printed by [debugPrintThrottled] (which is the default implementation for
/// [debugPrint], which is used to report errors to the console).
Future<void> get debugPrintDone =>
    _debugPrintCompleter?.future ?? Future<void>.value();

enum _WordWrapParseMode { inSpace, inWord, atBreak }

/// Wraps the given string at the given width.
///
/// Wrapping occurs at space characters (U+0020). Lines that start with an
/// octothorpe ("#", U+0023) are not wrapped (so for example, Dart stack traces
/// won't be wrapped).
///
/// Subsequent lines attempt to duplicate the indentation of the first line, for
/// example if the first line starts with multiple spaces. In addition, if a
/// `wrapIndent` argument is provided, each line after the first is prefixed by
/// that string.
///
/// This is not suitable for use with arbitrary Unicode text. For example, it
/// doesn't understand combining characters or right-to-left text.
List<String> debugWordWrap(
  String message,
  int wrapWidth, {
  String? wrapIndent,
}) {
  // Most of this is copied from package:flutter's foundation.dart debugWordWrap.
  if (message.isEmpty) {
    return <String>[''];
  }
  final lines = <String>[];
  final pattern = RegExp(r'^( *)([-+*] |[0-9]+[.):] )?');

  // Match the indentation and optional list-item marker of the first line.
  final match = pattern.matchAsPrefix(message);
  assert(match != null);
  final indentLength = match![1]!.length;
  final prefix = wrapIndent != null
      ? '$wrapIndent${" " * indentLength}'
      : ' ' * indentLength;
  var start = 0;
  var startForLengthCalculations = 0;
  var addPrefix = false;
  var index = indentLength;

  var mode = _WordWrapParseMode.inSpace;
  var lastWordStart = indentLength;

  while (index < message.length) {
    switch (mode) {
      case _WordWrapParseMode.inSpace:
        // Eat spaces. At each space, decide whether to wrap.
        while (index < message.length && message[index] == ' ') {
          index += 1;
        }
        lastWordStart = index;
        mode = _WordWrapParseMode.inWord;
      case _WordWrapParseMode.inWord:
        // Eat non-spaces. At each non-space, see if we've exceeded the wrap width.
        while (index < message.length && message[index] != ' ') {
          index += 1;
        }
        if (index - startForLengthCalculations > wrapWidth) {
          // We need to wrap. If we're at the start of the line, we have to
          // just eat the word even though it's too long. Otherwise, wrap at
          // the previous word.
          if (lastWordStart > start) {
            // We're not at the start of the line. Wrap at the previous word.
            final line = message.substring(start, lastWordStart).trimRight();
            lines.add(addPrefix ? '$prefix$line' : line);
            start = lastWordStart;
            startForLengthCalculations = start - (prefix.length - indentLength);
            addPrefix = true;
          }
        }
        mode = _WordWrapParseMode.atBreak;
      case _WordWrapParseMode.atBreak:
        // We're at a break point. If we're past the wrap width, wrap here.
        if (index - startForLengthCalculations > wrapWidth &&
            lastWordStart > start) {
          final line = message.substring(start, lastWordStart).trimRight();
          lines.add(addPrefix ? '$prefix$line' : line);
          start = lastWordStart;
          startForLengthCalculations = start - (prefix.length - indentLength);
          addPrefix = true;
        }
        mode = _WordWrapParseMode.inSpace;
    }
  }

  // Handle the last word.
  if (start < message.length) {
    final line = message.substring(start);
    lines.add(addPrefix ? '$prefix$line' : line);
  }

  return lines;
}
