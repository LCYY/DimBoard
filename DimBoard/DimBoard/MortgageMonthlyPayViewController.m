//
//  MortgageMonthlyPayViewController.m
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageMonthlyPayViewController.h"

@interface MortgageMonthlyPayViewController ()

@end

@implementation MortgageMonthlyPayViewController
@synthesize PrincipalLabel,InterestLabel,TermLabel,LeftAmountLabel;
@synthesize TableView;
@synthesize m_principals, m_leftLoanAmounts;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //TableView.layer.borderWidth = 2;
    //TableView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.5].CGColor;
    [TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    
    [TermLabel setTextColor:[UIColor whiteColor]];
    [PrincipalLabel setTextColor:[UIColor whiteColor]];
    [InterestLabel setTextColor:[UIColor whiteColor]];
    [LeftAmountLabel setTextColor:[UIColor whiteColor]];
    
    [TermLabel setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    [PrincipalLabel setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    [InterestLabel setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
    [LeftAmountLabel setBackgroundColor:[UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:1]];
            
    [TermLabel setTextAlignment:NSTextAlignmentCenter];
    [PrincipalLabel setTextAlignment:NSTextAlignmentCenter];
    [InterestLabel setTextAlignment:NSTextAlignmentCenter];
    [LeftAmountLabel setTextAlignment:NSTextAlignmentCenter];
    
    [TermLabel setUserInteractionEnabled:NO];
    [PrincipalLabel setUserInteractionEnabled:NO];
    [InterestLabel setUserInteractionEnabled:NO];
    [LeftAmountLabel setUserInteractionEnabled:NO];
    
    [TermLabel setText:@"期數"];
    [PrincipalLabel setText:@"本金"];
    [InterestLabel setText:@"利息"];
    [LeftAmountLabel setText:@"剩餘金額"];
    
    self.title = KEY_MORTGAGE_TABLE;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

-(void)viewDidUnload{
    [self setPrincipalLabel:nil];
    [self setInterestLabel:nil];
    [self setTermLabel:nil];
    [self setLeftAmountLabel:nil];
    [self setTableView:nil];
    [self setM_principals:nil];
    [self setM_leftLoanAmounts:nil];
    [super viewDidUnload];
}

-(void)setPricipals:(NSArray *)pricipals LeftAmount:(NSArray*)leftAmounts MonthlyPay:(double)monthlypay{
    m_principals = [pricipals copy];
    m_leftLoanAmounts = [leftAmounts copy];
    m_monthlyPay = monthlypay;
}

-(void)onViewRotation:(NSNotification*)noti{

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_principals count]/12; // one year one section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *CellIdentifier = @"GridCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger term = section*12 + row + 1;
    double pricipal = [[m_principals objectAtIndex:term - 1] doubleValue];
    double interest = m_monthlyPay - pricipal;
    double leftAmount = [[m_leftLoanAmounts objectAtIndex:term - 1] doubleValue];
    
    [(GridCell*)cell setTerm:term MonthlyPay:m_monthlyPay Principal:pricipal Interest:interest LeftAmount:leftAmount];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 18;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 18)];
    view.backgroundColor = [UIColor colorWithRed:39/255.0 green:64/255.0 blue:139/255.0 alpha:0.8];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"第 %d 年",section+1];
    label.font = [UIFont fontWithName:label.font.fontName size:13];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [view addSubview:label];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray* indexs = [[NSMutableArray alloc] init];
    for(int i = 0; i < [m_principals count]/12; i++){
        [indexs addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    return indexs;
}


@end

