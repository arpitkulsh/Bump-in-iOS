//
//  SetInfoPropertiesController.h
//  CardSwap
//
//  Created by mac on 4/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSaveClass;

@interface SetInfoPropertiesController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *mTableView;
	NSMutableArray *valueArray;
	CustomSaveClass *customSave;
}
@property(nonatomic,retain)NSMutableArray *valueArray;
-(IBAction)dismissView:(id)sender;
-(BOOL)isUserDetailsAvailable;
@end
