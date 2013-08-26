//
//  DragView.h
//  HelloWorld
//
//  Created by mac on 3/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DragLabel : UILabel
{
	CGPoint startLocation;
	UIView * line1;
	UIView * line2;
	UIView * line3;
	UIView * line4;
}
@end
