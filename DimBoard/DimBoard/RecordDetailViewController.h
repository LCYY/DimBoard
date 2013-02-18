//
//  RecordDetailViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNumberViewController.h"

@interface RecordDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) NSArray *m_mortgageItems;
@property (retain, nonatomic) NSArray *m_expenceItems;
@end
