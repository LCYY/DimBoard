//
//  OveralInfoViewController.h
//  DimBoard
//
//  Created by conicacui on 1/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OveralInfoViewController : UIViewController
{
    NSMutableDictionary* m_dict;
}

@property (weak, nonatomic) IBOutlet UILabel *HomeValue_ouput;
@property (weak, nonatomic) IBOutlet UILabel *LoanPercent_output;
@property (weak, nonatomic) IBOutlet UILabel *LoanYear_output;
@property (weak, nonatomic) IBOutlet UILabel *LoanRate_output;
@property (weak, nonatomic) IBOutlet UILabel *LoanAmount_output;
@property (weak, nonatomic) IBOutlet UILabel *LoanTerms_output;
@property (weak, nonatomic) IBOutlet UILabel *MonthlyPay_output;
@property (weak, nonatomic) IBOutlet UILabel *FirstPay_output;
@property (weak, nonatomic) IBOutlet UILabel *Commision_output;
@property (weak, nonatomic) IBOutlet UILabel *Tax_output;
@property (weak, nonatomic) IBOutlet UILabel *FirstExpence_output;
@property (weak, nonatomic) IBOutlet UILabel *OveralExpence_output;

@property (retain, nonatomic) NSMutableDictionary* m_dict;

- (IBAction)onBack:(id)sender;
- (id)initWithValues:(NSMutableDictionary*)dict;

@end
