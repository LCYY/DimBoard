//
//  RecordDetailViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRecordViewController.h"
#import "Calculator.h"

@interface RecordDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) NSDictionary *m_mortgageItems;
@property (retain, nonatomic) NSDictionary *m_expenceItems;
@property (retain, nonatomic) MortgageRecord *m_record;
@property (retain, nonatomic) MortgageOutput *m_output;

-(id)initWithMortgageRecord:(MortgageRecord*)record;
@end
