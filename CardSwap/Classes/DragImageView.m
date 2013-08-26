//
//  DragImageView.m
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DragImageView.h"


@implementation DragImageView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches began");
	// Retrieve the touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	startLocation = pt;
	
	[[self superview] bringSubviewToFront:self];
	CGRect f1=[self frame];
	
	//Top Line
	line1=[[UIView alloc] initWithFrame:CGRectMake(-500, f1.origin.y, 1300, 1)];
	line1.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1.0f alpha:.30f];
	[[self superview] addSubview:line1];
	
	//Bottom Line
	line2=[[UIView alloc] initWithFrame:CGRectMake(-500, f1.origin.y+f1.size.height, 1300, 1)];
	line2.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1.0f alpha:.30f];
	[[self superview] addSubview:line2];
	
	
	//front Line
	line3=[[UIView alloc] initWithFrame:CGRectMake(f1.origin.x, -500, 1,1300)];
	line3.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1.0f alpha:.30f];
	[[self superview] addSubview:line3];
	
	//Rear Line
	line4=[[UIView alloc] initWithFrame:CGRectMake(f1.origin.x+f1.size.width,-500, 1, 1300)];
	line4.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1.0f alpha:.30f];
	[[self superview] addSubview:line4];
	
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches moved");
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	
	CGRect frameLine = [line1 frame];
	frameLine.origin.x += pt.x - startLocation.x;
	frameLine.origin.y += pt.y - startLocation.y;
	[line1 setFrame:frameLine];
	
	frameLine = [line2 frame];
	frameLine.origin.x += pt.x - startLocation.x;
	frameLine.origin.y += pt.y - startLocation.y;
	[line2 setFrame:frameLine];
	
	frameLine = [line3 frame];
	frameLine.origin.x += pt.x - startLocation.x;
	frameLine.origin.y += pt.y - startLocation.y;
	[line3 setFrame:frameLine];
	
	frameLine = [line4 frame];
	frameLine.origin.x += pt.x - startLocation.x;
	frameLine.origin.y += pt.y - startLocation.y;
	[line4 setFrame:frameLine];
	
	
	[self setFrame:frame];
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	
	[line1 removeFromSuperview];
	[line1 release];
	
	[line2 removeFromSuperview];
	[line2 release];
	
	[line3 removeFromSuperview];
	[line3 release];
	
	[line4 removeFromSuperview];
	[line4 release];
	
	/*
	 UITouch *touch = [touches anyObject];
	 NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	 NSData *savetoData=[NSKeyedArchiver archivedDataWithRootObject:[NSValue valueWithCGRect:[touch.view frame]]];
	 switch (touch.view.tag) {
	 case 0:
	 
	 [defaults setObject:savetoData forKey:@"Frame 0"];
	 break;
	 case 1:
	 
	 [defaults setObject:savetoData forKey:@"Frame 1"];
	 break;
	 case 2:
	 
	 [defaults setObject:savetoData forKey:@"Frame 2"];
	 break;
	 case 3:
	 
	 [defaults setObject:savetoData forKey:@"Frame 3"];
	 break;
	 case 4:
	 
	 [defaults setObject:savetoData forKey:@"Frame 4"];
	 break;
	 
	 default:
	 break;
	 }
	 */
	
}

- (void)dealloc {
    [super dealloc];
}
@end