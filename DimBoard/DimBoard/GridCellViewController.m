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

-(void)setTerm:(NSInteger)term MonthlyPay:(double)monthlypay Principal:(double)principal Interest:(double)interest LeftAmount:(double)amount Row:(NSInteger)row{
    m_term = term;
    m_monthlyPay = monthlypay;
    m_principal = principal;
    m_interest = interest;
    m_leftAmount = amount;
    m_row = row;
    
    [TermLabel setTextAlignment:NSTextAlignmentCenter];
    [PrincipalLabel setTextAlignment:NSTextAlignmentCenter];
    [InterestLabel setTextAlignment:NSTextAlignmentCenter];
    [LeftAmountLabel setTextAlignment:NSTextAlignmentCenter];
    
    [TermLabel setUserInteractionEnabled:NO];
    [PrincipalLabel setUserInteractionEnabled:NO];
    [InterestLabel setUserInteractionEnabled:NO];
    [LeftAmountLabel setUserInteractionEnabled:NO];
    
    [TermLabel setText:[NSString stringWithFormat:@"%d",m_term]];
    [PrincipalLabel setText:[NSString stringWithFormat:@"%0.2f",m_principal]];
    [InterestLabel setText:[NSString stringWithFormat:@"%0.2f",m_interest]];
    [LeftAmountLabel setText:[NSString stringWithFormat:@"%0.2f",m_leftAmount]];
    
    UIColor *color = nil;
    if(m_row%2 == 0){
        color = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.2];
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
