//
//  MortgageRecordViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordDetailViewController.h"
#import "AddRecordViewController.h"
#import "MortgageRecordIO.h"

@interface MortgageRecordViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray* m_controllerList;
@property (strong,nonatomic) MortgageRecordIO* m_recordIO;

- (void)onAddNewMortgageRecord:(id)sender;
- (void)onBack:(id)sender;
@end
