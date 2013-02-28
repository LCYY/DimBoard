//
//  GridCellViewController.m
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "GridCellViewController.h"

@interface GridCellViewController ()

@end

@implementation GridCellViewController
@synthesize TermLabel, PrincipalLabel, InterestLabel, LeftAmountLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTerm:(NSInteger)term MonthlyPay:(double)monthlypay Principal:(double)principal Interest:(double)interest LeftAmount:(double)amount{
    m_term = term;
    m_monthlyPay = monthlypay;
    m_principal = principal;
    m_interest = interest;
    m_leftAmount = amount;
    
    TermLabel.layer.borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor;
    PrincipalLabel.layer.borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor;
    InterestLabel.layer.borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor;
    LeftAmountLabel.layer.borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.9].CGColor;
    TermLabel.layer.borderWidth = 1;
    PrincipalLabel.layer.borderWidth = 1;
    InterestLabel.layer.borderWidth = 1;
    LeftAmountLabel.layer.borderWidth = 1;

    [TermLabel setTextAlignment:NSTextAlignmentCenter];
    [PrincipalLabel setTextAlignment:NSTextAlignmentCenter];
    [InterestLabel setTextAlignment:NSTextAlignmentCenter];
    [LeftAmountLabel setTextAlignment:NSTextAlignmentCenter];
    
    [TermLabel setUserInteractionEnabled:NO];
    [PrincipalLabel setUserInteractionEnabled:NO];
    [InterestLabel setUserInteractionEnabled:NO];
    [LeftAmountLabel setUserInteractionEnabled:NO];
    
    [TermLabel setText:[NSString stringWithFormat:@"%d",m_term]];
    [PrincipalLabel setText:[NSString stringWithFormat:@"%0.0f",m_principal]];
    [InterestLabel setText:[NSString stringWithFormat:@"%0.0f",m_interest]];
    [LeftAmountLabel setText:[NSString stringWithFormat:@"%0.0f",m_leftAmount]];
    
    UIColor *color = nil;
    if(m_term%2 == 0){
        color = [UIColor colorWithRed:162/255.0 green:181/255.0 blue:205/255.0 alpha:0.1];
    }else{
        color = [UIColor whiteColor];
    }
    [TermLabel setBackgroundColor:color];
    [PrincipalLabel setBackgroundColor:color];
    [InterestLabel setBackgroundColor:color];
    [LeftAmountLabel setBackgroundColor:color];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTermLabel:nil];
    [self setPrincipalLabel:nil];
    [self setInterestLabel:nil];
    [self setLeftAmountLabel:nil];
    [super viewDidUnload];
}
@end
