//
//  MorgageMonthlyPayViewController.m
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MorgageMonthlyPayViewController.h"

@interface MorgageMonthlyPayViewController ()

@end

@implementation MorgageMonthlyPayViewController
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
}

-(void)viewDidUnload{
    [super viewDidUnload];
    [self setTableView:nil];
    [self setM_principals:nil];
}

-(void)setPricipals:(NSArray *)pricipals LeftAmount:(NSArray*)leftAmounts MonthlyPay:(double)monthlypay{
    m_principals = [pricipals copy];
    m_leftLoanAmounts = [leftAmounts copy];
    m_monthlyPay = monthlypay;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_principals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GridCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger term = indexPath.row + 1;
    double pricipal = [[m_principals objectAtIndex:indexPath.row] doubleValue];
    double interest = m_monthlyPay - pricipal;
    double leftAmount = [[m_leftLoanAmounts objectAtIndex:indexPath.row] doubleValue];
    
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

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 4;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 4;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    return view;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    return view;
//}

@end

