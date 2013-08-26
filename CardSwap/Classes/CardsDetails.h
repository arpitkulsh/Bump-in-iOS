//
//  CardsDetails.h
//  CardSwap
//
//  Created by mac on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface CardsDetails :  NSManagedObject  
{
}

@property (nonatomic, retain) id allDataDict;
@property (nonatomic, retain) NSString * name;
@property (nonatomic ,retain) NSString * company;
@end



