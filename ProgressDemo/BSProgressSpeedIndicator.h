//
//  ProgressSpeedIndicator.h
//  FashionTinder
//
//  Created by Balica S on 17/06/2014.
//  Copyright (c) 2014 Balica Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSProgressSpeedIndicator : UIView


@property  NSUInteger numberOfLines;

// available angle for distributions of lines, default 240 degrees
@property  CGFloat angle;



@property  CGFloat progress;

// progress from 0 to 1.0
- (void) showWithProgress:(CGFloat) progress onView:(UIView*) view;

- (void) setBarProgress:(CGFloat) progress animate:(BOOL) animate;
@end
