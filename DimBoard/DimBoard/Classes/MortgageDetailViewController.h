//
//  MortgageDetailViewController.h
//  DimBoard
//
//  Created by conicacui on 26/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRecordViewController.h"
#import "Calculator.h"
#import "UpdateRecordItemProtocol.h"
#import "PieChartCell.h"
#import "MortgageMonthlyPayViewController.h"

@interface MortgageDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate, PieChartCellExtendDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) id m_recordViewController;
@property (retain, nonatomic) MortgageRecord *m_record;
@property (retain, nonatomic) MortgageOutput *m_output;
@property (retain, nonatomic) NSMutableArray* m_sections;
@property (retain, nonatomic) NSMutableArray* m_pieChartSlices;
@property (retain, nonatomic) NSMutableArray* m_pieChartDesps;
@property (readonly, nonatomic) NSSet* m_pieChartKeys;
@property (retain, nonatomic) NSMutableDictionary* m_pieChartCells; //heights for indexpath

//Section 0
//---------
//物業價值
//按揭成數
//按揭年期
//按揭利率
//---------


//Section 1
//---------
//按揭期數
//每月供款
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
-(void)setRecordViewController:(id)recordViewController;
@end
