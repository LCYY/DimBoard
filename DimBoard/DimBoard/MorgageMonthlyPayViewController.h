//
//  MorgageMonthlyPayViewController.h
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MorgageMonthlyPayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    double m_monthlyPay;
}
@property (weak, nonatomic) IBOutlet UITableView *TableView;
@property (retain, nonatomic) NSArray* m_principals;
@property (retain, nonatomic) NSArray* m_leftLoanAmounts;

-(void)setPricipals:(NSArray*)pricipals LeftAmount:(NSArray*)leftAmounts MonthlyPay:(double)monthlyPay;
@end
