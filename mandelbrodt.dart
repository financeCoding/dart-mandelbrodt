// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * A mandelbrodt visualization.
 */

#library("mandelbrodt");
#import("mandelbrodt-calc.dart");
#import("dart:html");

/**
 * The entry point to the application.
 */
void main() {
  Mandelbrodt.init();
  var ui = new UI(query("#display"), query("#graph"));

  ui.init();
}

double fpsAverage;

final int BODY_PADDING = 10;
final int CANVAS_BORDER = 1;

/**
 * Display the animation's FPS in a div.
 */
void showFps(num fps) {
  if (fpsAverage == null) {
    fpsAverage = fps;
  }

  fpsAverage = fps * 0.05 + fpsAverage * 0.95;

  query("#notes").text = "${fpsAverage.round().toInt()} fps";
}

/**
 * A representation of the solar system.
 *
 * This class maintains a list of planetary bodies, knows how to draw its
 * background and the planets, and requests that it be redraw at appropriate
 * intervals using the [Window.requestAnimationFrame] method.
 */
class UI {
  CanvasElement graph;
  CanvasElement display;
  
  num _width;
  num _height;

  num renderTime;
  
  num drawCount;

  UI(this.display, this.graph) {
    drawCount = 0;
  }

  num get width() => _width;

  num get height() => _height;

  init() {
    int availWidth = window.innerWidth - BODY_PADDING * 2 - CANVAS_BORDER * 2;
    int availHeight = window.innerHeight - BODY_PADDING * 2 - CANVAS_BORDER * 4;
    graph.width = availWidth;
    display.width = availWidth;
    graph.height = (availHeight * 0.25).toInt();
    display.height = (availHeight * 0.75).toInt();
    
    requestRedraw();
    Mandelbrodt.render(display, [-2.0, 2.0, 2.0, -2.0]);
  }
  
  bool draw(int time) {
    drawCount++;
    if (time == null) {
      // time can be null for some implementations of requestAnimationFrame
      time = new Date.now().millisecondsSinceEpoch;
    }

    if (renderTime != null) {
      //showFps((1000 / (time - renderTime)).round());
    }

    renderTime = time;


    drawGraph();
    requestRedraw();
  }
  
  void drawGraph() {
    
  }

  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }
}
