//
//  ViewController.h
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{

    double m_homeValue; // in terms of 10-thoudsands
    double m_loanPercent; // in terms of %
    NSInteger m_loanYear; // integer
    double m_loanRate; // in terms of %, loan rate per year
    
    double m_loanAmount; // in terms of 10-thousands
    double m_monthlyPay; // in terms of 1
    NSInteger m_loanTerms;
    double m_totoalPay; // in terms of 10-thousands
    
    NSMutableArray* m_principals;   
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
