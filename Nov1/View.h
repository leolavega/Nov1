//
//  View.h
//  Japan
//
//  Created by NYU User on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

int hour, minute, second;

@interface View: UIView

//this method will draw the contents of the provided parameters on the screen
- (void)drawLineWithCGContextRef:(CGContextRef)c CGMutPathRef:(CGMutablePathRef)p lineWidth:(CGFloat)l;

//This method will set the hour,minute,second int values to the current time provided by the device
- (void)currentTime;

@end
