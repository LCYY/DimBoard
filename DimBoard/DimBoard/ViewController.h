//
//  ViewController.h
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OveralInfoViewController.h"
#import "MortgageRecordViewController.h"
#import "Calculator.h"

@interface ViewController : UIViewController<UITextFieldDelegate>{
    MortgageOutput* m_output;
    MortgageInput* m_input;
    
    NSMutableArray* m_principals;
    
    Calculator* m_calculator;
}
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

//TextField Input
@property (weak, nonatomic) IBOutlet UITextField *HomeValue_input;
@property (weak, nonatomic) IBOutlet UITextField *LoanPercent_input;
@property (weak, nonatomic) IBOutlet UITextField *LoanYear_input;
@property (weak, nonatomic) IBOutlet UITextField *LoanRate_input;

//SlidBar Input
@property (weak, nonatomic) IBOutlet UISlider *HomeValue_slid;
@property (weak, nonatomic) IBOutlet UISlider *LoanPercent_slid;
@property (weak, nonatomic) IBOutlet UISlider *LoanYear_slid;
@property (weak, nonatomic) IBOutlet UISlider *LoanRate_slid;

//Result
@property (weak, nonatomic) IBOutlet UILabel *LoanAmount_output;
@property (weak, nonatomic) IBOutlet UILabel *TotalPay_output;
@property (weak, nonatomic) IBOutlet UILabel *LoanTerms_output;
@property (weak, nonatomic) IBOutlet UILabel *MonthlyPay_output;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *ShowOveralInfo;
- (IBAction)onShowDetails:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ShowDetails;
- (IBAction)onShowOveralInfo:(id)sender;
- (IBAction)onShowMortgageRecord:(id)sender;

@end
