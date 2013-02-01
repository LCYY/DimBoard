//
//  ViewController.h
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    double m_homeValue; // in terms of 10-thoudsands
    CGFloat m_loanPercent;
    NSInteger m_loanYear;
    CGFloat m_loanRate;
    
    double m_loanAmount;
    double m_monthlyPay;
    NSInteger m_loanTerms;
    double m_totoalPay;
    
}

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
- (IBAction)OnShowDetails:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ShowDetails;
- (IBAction)OnShowOveralInfo:(id)sender;
@end
