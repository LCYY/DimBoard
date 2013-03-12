//
//  MortgageCalViewController.h
//  DimBoard
//
//  Created by conicacui on 1/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderCell.h"
#import "MortgageDataType.h"
#import "Calculator.h"
#import "UpdateRecordItemProtocol.h"
#import "MortgageDetailViewController.h"
#import "MortgageMonthlyPayViewController.h"
#import "DimBoardNotifications.h"

@interface MortgageCalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UpdateRecordItemProtocol>

@property (weak, nonatomic) IBOutlet UILabel *InterLabel;
@property (weak, nonatomic) IBOutlet UILabel *InterLabelBG;
@property (weak, nonatomic) IBOutlet UITableView *InputTableView;
@property (weak, nonatomic) IBOutlet UITableView *ResultTableView;
//Section 0
//---------
//物業價值 slidercell
//按揭成數 slidercell
//按揭年期 slidercell
//按揭利率 slidercell
//---------
@property (retain, nonatomic) NSArray *m_outputRows;

//Section 1
//---------
//按揭金額
//按揭期數
//每月供款
//還款總額
//---------
@property (retain, nonatomic) NSArray *m_inputRows;
@property (retain, nonatomic) MortgageInput *m_input;
@property (retain, nonatomic) MortgageOutput *m_output;
@property (retain, nonatomic) Calculator* m_calculator;
@property (retain, nonatomic) id m_recordViewController;

-(void)setRecordViewController:(id)controller;
@end
