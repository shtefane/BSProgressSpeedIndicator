BSProgressSpeedIndicator
========================

![demo](https://raw.github.com/shtefane/BSProgressSpeedIndicator/master/Screen/demo.png)

iOS
Circular progress view like car speedometers

Inspired from this: https://www.behance.net/gallery/16955945/Speedometer

HOW to USE

- add BSProgressSpeedIndicator.h and BSProgressSpeedIndicator.m to your project
- import BSProgressSpeedIndicator.h to your class
```objective-c
  _progrView = [[BSProgressSpeedIndicator alloc] initWithFrame:CGRectMake(10, 160, 300, 300)];
  [_progrView showWithProgress:0.75f onView:self.view];
```

- change progress
```objective-c
[_progrView setBarProgress:0.85f animate:YES];
```
