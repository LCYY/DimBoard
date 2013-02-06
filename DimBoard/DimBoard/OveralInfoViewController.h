//
//  OveralInfoViewController.h
//  DimBoard
//
//  Created by conicacui on 1/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"
#import "XYPieChart/XYPieChart.h"

@interface OveralInfoViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>
{
    MortgageInput* m_input;
    MortgageOutput* m_output;
    NSArray *m_sliceColors;
    NSMutableArray *m_slices;
    
    CGRect m_viewRect;
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
@property (weak, nonatomic) IBOutlet XYPieChart *PieChart;
@property (retain, nonatomic) NSArray *m_sliceColors;
@property (retain, nonatomic) NSMutableArray *m_slices;

- (IBAction)onBack:(id)sender;
- (id)initWithInput:(MortgageInput*)input Output:(MortgageOutput*)output;

@end
