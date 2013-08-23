//
//  MortgageRecordViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "RecordDetailViewController.h"
#import "AddRecordViewController.h"
#import "MortgageRecordIO.h"
#import "DimBoardProtocols.h"
#import "RecordCell.h"

@interface MortgageRecordViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate, UpdateRecordProtocol>

@property (weak, nonatomic) IBOutlet ADBannerView *m_adBannerView;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (strong,nonatomic) NSMutableArray* m_controllerList;
@property (strong,nonatomic) MortgageRecordIO* m_recordIO;

- (void)onAddNewMortgageRecord:(id)sender;
@end
