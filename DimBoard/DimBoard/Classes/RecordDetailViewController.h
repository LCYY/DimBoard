//
//  RecordDetailViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "AddRecordViewController.h"
#import "Calculator.h"
#import "DimBoardProtocols.h"
#import "PieChartCell.h"
#import "MortgageMonthlyPayViewController.h"

@interface RecordDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ADBannerViewDelegate, UpdateRecordProtocol, PieChartCellExtendDelegate>

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet ADBannerView *m_adBannerView;
@property (retain, nonatomic) MortgageRecord *m_record;
@property (retain, nonatomic) MortgageOutput *m_output;
@property (retain, nonatomic) NSMutableArray* m_sections;
@property (retain, nonatomic) NSMutableArray* m_pieChartSlices;
@property (retain, nonatomic) NSMutableArray* m_pieChartDesps;
@property (retain, nonatomic) NSMutableDictionary* m_pieChartCells; //heights for indexpath
@property (readonly, nonatomic) NSSet* m_pieChartKeys;
@property (weak, nonatomic) id<UpdateRecordProtocol> m_delegate;

//Section 0
//---------
//物業價值
//按揭成數
//按揭年期
//按揭利率 
//---------


//Section 1
//---------
//按揭銀行
//按揭期數
//按揭日期
//每月供款
//已還期數
//已還金額
//待還金額
//Pie Chart
//---------


//Section 2
//---------
//首付樓價金額 
//印花稅額 
//代理佣金 
//首付金額
//Pie Chart
//---------


//Section 3
//---------
//按揭金額
//按揭利息
//還款金額
//Pie Chart
//---------


//Section 4
//---------
//費用總額
//Pie Chart
//---------

//Section 5
//---------
//供款圖表
//---------


-(id)initWithMortgageRecord:(MortgageRecord*)record;
-(NSInteger)getRecordId;
-(NSString*)getName;
-(NSString*)getTermDsp;
-(NSString*)getMonthlyPay;
-(float)getPayProgress;
@end
