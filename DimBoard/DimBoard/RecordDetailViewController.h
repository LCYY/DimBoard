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
#import "UpdateRecordItemProtocol.h"
#import "PieChartCell.h"

@interface RecordDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UpdateRecordProtocol>
@property (retain, nonatomic) MortgageRecord *m_record;
@property (retain, nonatomic) MortgageOutput *m_output;
@property (retain, nonatomic) NSMutableArray* m_sections;
@property (retain, nonatomic) id<UpdateRecordProtocol> m_delegate;

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
//已還金額
//待還金額
//---------


//Section 2
//---------
//首付樓價金額 
//印花稅額 
//代理佣金 
//首付金額
//---------


//Section 3
//---------
//按揭金額
//按揭利息
//還款金額
//---------


//Section 4
//---------
//費用總額
//---------


-(id)initWithMortgageRecord:(MortgageRecord*)record;
-(NSInteger)getRecordId;
@end
