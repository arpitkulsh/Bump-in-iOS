//
//  CustomCellView.m
//  CardSwap
//
//  Created by mac on 3/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCellView.h"


@implementation CustomCellView
@synthesize lblName,lblCompany;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
        lblName= [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 280.0f, 20)] ;
        lblName.backgroundColor = [UIColor clearColor];
        lblName.font = [UIFont fontWithName:@"Georgia-Bold" size:14.0f];
        lblName.textAlignment = UITextAlignmentLeft;
        lblName.textColor = [UIColor darkTextColor];
		lblName.text =@"Name";  //NSLocalizedString(@"DigiDraw", @"hello");
		[self addSubview:lblName];
		
		
        lblCompany= [[UILabel alloc] initWithFrame:CGRectMake(20, 24, 280.0f, 15)] ;
        lblCompany.backgroundColor = [UIColor clearColor];
        lblCompany.font = [UIFont fontWithName:@"Georgia" size:15.0f];
        lblCompany.textAlignment = UITextAlignmentLeft;
        lblCompany.textColor = [UIColor darkTextColor];
		lblCompany.text =@"Company";  //NSLocalizedString(@"DigiDraw", @"hello");
		[self addSubview:lblCompany];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[lblName release];
	[lblName release];
    [super dealloc];
}


@end
