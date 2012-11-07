//
//  View.m
//  Japan
//
//  Created by NYU User on 10/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View


- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
		CGFloat w = self.bounds.size.width;
		CGFloat h = self.bounds.size.height;
		self.bounds = CGRectMake(-w/2, -h/2, w, h);
		
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
    // Drawing code
    // Drawing code
	
	CGFloat radius = .4 * self.bounds.size.width;	//in pixels
    
    /*
     Create the invisible square that will surround the circle.
     Place the upper left corner of the square at the upper left corner of
     the View.  bounds.origin.x and bounds.origin.y are the coordinates of
     the upper left corner of the View.
     */
    CGRect r = CGRectMake(
        -radius,
        -radius,
        2 * radius,
        2 * radius
    );
    
    //circle
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(c, 1, -1);
    CGContextBeginPath(c); //unnecessary here: the path is already empty.
    CGContextAddEllipseInRect(c, r);
    CGContextSetRGBStrokeColor(c, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(c, 5.0);
	CGContextStrokePath(c);
	
	//12
	CGMutablePathRef p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 0, radius);
	CGPathAddLineToPoint(p, NULL, 0, radius -20);
	CGPathCloseSubpath(p);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:5.0];
	
	//3
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, radius, 0);
	CGPathAddLineToPoint(p, NULL, radius -20, 0);
	CGPathCloseSubpath(p);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:5.0];
	
	//6
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 0, -radius);
	CGPathAddLineToPoint(p, NULL, 0, 20 - radius);
	CGPathCloseSubpath(p);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:5.0];
	
	//9
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, -radius, 0);
	CGPathAddLineToPoint(p, NULL, 20 - radius, 0);
	CGPathCloseSubpath(p);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:5.0];
	
	
	[self currentTime];
	
	//hour
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 0, 0);
	CGPathAddLineToPoint(p, NULL, 0, radius - 80);
	CGContextBeginPath(c);
    CGPathCloseSubpath(p);
	CGContextRotateCTM(c, -M_PI/6*hour);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:6.0];
	//rotates the CTM back to its original state
	CGContextRotateCTM(c, M_PI/6*hour);
	
	//minute
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 0, 0);
	CGPathAddLineToPoint(p, NULL, 0, radius - 40);
	CGContextBeginPath(c);
    CGPathCloseSubpath(p);
	CGContextRotateCTM(c, -M_PI/30*minute);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:6.0];
	//rotates the CTM back to its original state
	CGContextRotateCTM(c, M_PI/30*minute);
	
	//second
	p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 0, 0);
	CGPathAddLineToPoint(p, NULL, 0, radius - 40);
	CGContextBeginPath(c);
    CGPathCloseSubpath(p);
	CGContextRotateCTM(c, -M_PI/30*second);
	[self drawLineWithCGContextRef: c CGMutPathRef: p lineWidth:3.0];
	//rotates the CTM back to its original state
	CGContextRotateCTM(c, M_PI/30*second);
	
	//the drawRect function will be called once every second
	[self performSelector: @selector(setNeedsDisplay) withObject: nil afterDelay: 1.0];
	

}


- (void)drawLineWithCGContextRef:(CGContextRef)c CGMutPathRef:(CGMutablePathRef)p lineWidth:(CGFloat)l{
	
	CGContextBeginPath(c);
	CGContextAddPath(c, p);
	CGContextSetLineWidth(c, l);
	CGContextSetRGBStrokeColor(c, 0.0, 0.0, 0.0, 1.0);
	CGContextStrokePath(c);
	CGPathRelease(p);
}

-(void)currentTime{
    
	NSDate *now = [NSDate date];
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"HH:mm:ss"];
	NSString *newDateString = [outputFormatter stringFromDate:now];
	NSArray *timeArray = [newDateString componentsSeparatedByString:@":"];
	hour = [[timeArray objectAtIndex:0] intValue];
	minute = [[timeArray objectAtIndex:1] intValue];
	second = [[timeArray objectAtIndex:2] intValue];
	
}


@end
