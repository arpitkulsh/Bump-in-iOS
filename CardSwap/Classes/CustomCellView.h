//
//  CustomCellView.h
//  CardSwap
//
//  Created by mac on 3/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCellView : UITableViewCell {

	UILabel *lblName;
	UILabel *lblCompany;
}
@property(nonatomic,retain)UILabel *lblName;
@property(nonatomic,retain)UILabel *lblCompany;
@end
