//
//  ProgressSpeedIndicator.m
//  FashionTinder
//
//  Created by Balica S on 17/06/2014.
//  Copyright (c) 2014 Balica Stefan. All rights reserved.
//

#import "BSProgressSpeedIndicator.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface BSProgressSpeedIndicator()
{
    CGFloat lineWidth;
    CGFloat lineHeight;
    CGFloat radiusDelta;
}

@property (nonatomic, strong) NSMutableArray *linesViews;
@property  CGFloat radius;

@property (nonatomic, strong) UILabel *progresslbl;

@end

@implementation BSProgressSpeedIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defInit];
    }
    return self;
}

- (void) defInit
{
    self.backgroundColor = [UIColor grayColor];
    
    self.angle = 250;
    self.radius = self.frame.size.width / 2 - 20;
    self.numberOfLines = 86;
    
   
    lineHeight = 12.0f;
    lineWidth = 1.0f;
    radiusDelta = 15;
    
    _linesViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _numberOfLines; i++) {
       
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, lineHeight)];
        line.backgroundColor = [UIColor colorWithRed:0.20392156862745098 green:0.28627450980392155 blue:0.3686274509803922 alpha:1.0];
        [line.layer setAllowsEdgeAntialiasing:YES];
        CGFloat angle = [self lineAngleForIndex:i];
        line.transform = CGAffineTransformMakeRotation(angle);
        [self addSubview:line];
        line.center = [self lineCenterForIndex:i andRadius:_radius - radiusDelta];
        [_linesViews addObject:line];

    }
    
   
    // add label
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat width = self.frame.size.width / 2;
    CGFloat heigth = self.frame.size.height / 3;
    
    _progresslbl = [[UILabel alloc] initWithFrame:CGRectMake(center.x - width/2 , center.y - heigth/2, width, heigth)];
    _progresslbl.backgroundColor = [UIColor clearColor];
    _progresslbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:heigth];
    _progresslbl.textAlignment = NSTextAlignmentCenter;
    _progresslbl.textColor = [UIColor whiteColor];
    _progresslbl.text = [NSString stringWithFormat:@"%.0f", self.progress * 100];
    
    [self addSubview:_progresslbl];
}

- (CGFloat) lineAngleForIndex:(NSUInteger) index
{
    CGFloat angleDelta = _angle / (_numberOfLines - 1);
    CGFloat radians = DEGREES_TO_RADIANS((index * angleDelta) - _angle/2);
    return radians;
}


- (CGPoint) lineCenterForIndex:(NSUInteger) index andRadius:(CGFloat) radius
{
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat lineAngle = [self lineAngleForIndex:index];
    CGFloat x = center.x + radius * sin(lineAngle);
    CGFloat y = center.y - radius * cos(lineAngle);
    
    return CGPointMake(x, y);
}

- (UIColor*) lineColorForIndex:(NSUInteger) index
{

    float hue =  (float)index/_numberOfLines + 0.2f;
    NSLog(@"hue %f",hue);
    //hue = (hue > 0.5)? hue + 0.2f: hue;
    UIColor *color = [UIColor colorWithHue:hue
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
    return color;
}

#pragma mark Class

- (void) showWithProgress:(CGFloat) progress onView:(UIView*) view;
{
    [view addSubview:self];
   
    [_linesViews enumerateObjectsUsingBlock:^(UIImageView *line, NSUInteger idx, BOOL *stop) {
    
        line.alpha = 0.2f;
        [UIView animateWithDuration:1.0f delay:0.3f usingSpringWithDamping:5 initialSpringVelocity:20 options:0 animations:^{
            line.alpha = 1.0f;
            [line setCenter:[self lineCenterForIndex:idx andRadius:_radius]];
            
            
        } completion:nil];
        
    }];
    
    [self setBarProgress:progress animate:YES];
}

- (void) setBarProgress:(CGFloat) progress animate:(BOOL) animate
{
    CGFloat delay = 0;
    if (self.progress < progress) {
        //increase
       for (int i = self.progress * _numberOfLines; i < progress * _numberOfLines; i++) {
           
           if (animate) {
               
               [UIView animateWithDuration:0.1f delay:delay options:0 animations:^{
                   UIImageView *line = [_linesViews objectAtIndex:i];
                   line.backgroundColor = [self lineColorForIndex:i];
               } completion:^(BOOL finished) {
                   
                   _progresslbl.text = [NSString stringWithFormat:@"%.0f", (float)i/_numberOfLines * 100];
               }];
               delay += 0.04;
           }else {
               UIImageView *line = [_linesViews objectAtIndex:i];
               line.backgroundColor = [self lineColorForIndex:i];
           }
           
        }
        
        
    }else {
        //decrease
        for (int i = _progress * _numberOfLines; i > progress * _numberOfLines; i--) {
            
            if (animate) {
                [UIView animateWithDuration:0.1f delay:delay options:0 animations:^{
                    UIImageView *line = [_linesViews objectAtIndex:i];
                    line.backgroundColor = [UIColor colorWithRed:0.20392156862745098 green:0.28627450980392155 blue:0.3686274509803922 alpha:1.0];
                } completion:^(BOOL finished) {
                    _progresslbl.text = [NSString stringWithFormat:@"%.0f", (float)i/_numberOfLines * 100];
                }];
                delay += 0.04;
            }else {
                UIImageView *line = [_linesViews objectAtIndex:i];
                line.backgroundColor = [UIColor darkGrayColor];
            }
            
        }

    }
    
    self.progress = progress;
    _progresslbl.text = [NSString stringWithFormat:@"%.0f", self.progress * 100];
    
}

@end
