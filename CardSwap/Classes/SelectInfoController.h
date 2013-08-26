//
//  SelectInfoController.h
//  CardSwap
//
//  Created by mac on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CustomSaveClass;
@interface SelectInfoController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *mTableView;
	NSMutableArray *valueArray;
	NSMutableArray *visibilityArray;
	CustomSaveClass *customSave;
}
@property(nonatomic,retain)NSMutableArray *valueArray;
@property(nonatomic,retain)NSMutableArray *visibilityArray;
-(IBAction)dismiss:(id)sender;
-(BOOL)isUserDetailsAvailable;
@end
