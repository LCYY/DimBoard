//
//  MortgageQuickCalViewController.h
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"
#import "Calculator.h"
#import "MortgageRecordViewController.h"
#import "MortgageDetailViewController.h"
#import "MortgageRecordViewController.h"
#import "SliderCell.h"

@interface MortgageQuickCalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UpdateRecordItemProtocol>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UITableView *TableView;

//Section 0
//---------
//物業價值 slidercell
//按揭成數 slidercell
//按揭年期 slidercell
//按揭利率 slidercell
//---------
@property (retain, nonatomic) NSArray *m_section0;

//Section 1
//---------
//按揭金額
//按揭期數
//每月供款
//還款總額
//---------
@property (retain, nonatomic) NSArray *m_section1;
@property (retain, nonatomic) MortgageRecordViewController* m_recordViewController;
@property (retain, nonatomic) MortgageInput *m_input;
@property (retain, nonatomic) MortgageOutput *m_output;
@property (retain, nonatomic) Calculator* m_calculator;
@property (weak, nonatomic) IBOutlet UIButton *ShowMyRecordButton;
@property (weak, nonatomic) IBOutlet UIButton *ShowDetailsButton;
@property (weak, nonatomic) IBOutlet UIButton *ShowMonthlyPayButton;
- (IBAction)onShowMyRecord:(id)sender;
- (IBAction)onShowDetails:(id)sender;
- (IBAction)onShowMonthlyPay:(id)sender;
@end
