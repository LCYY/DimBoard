//
//  GridCellViewController.h
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GridCellViewController : UIViewController{
    NSInteger m_term;
    double m_monthlyPay;
    double m_principal;
    double m_interest;
    double m_leftAmount;
}

@property (weak, nonatomic) IBOutlet UITextField *TermLabel;
@property (weak, nonatomic) IBOutlet UITextField *PrincipalLabel;
@property (weak, nonatomic) IBOutlet UITextField *InterestLabel;
@property (weak, nonatomic) IBOutlet UITextField *LeftAmountLabel;

-(void)setTerm:(NSInteger)term MonthlyPay:(double)monthlypay Principal:(double)principal Interest:(double)interest LeftAmount:(double)amount;
@end
