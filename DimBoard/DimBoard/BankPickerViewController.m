//
//  BankPickerViewController.m
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "BankPickerViewController.h"

@interface BankPickerViewController ()

@end

@implementation BankPickerViewController
@synthesize BankPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_selectedBankId = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [BankPicker setDelegate:self];
    [BankPicker setDataSource:self];
    m_bankTypes = [[BankTypes alloc] init];
}

- (void)viewDidUnload
{
    [self setBankPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)onSave:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    if(m_selectedBankId > -1 && m_selectedBankId < [m_bankTypes getBankCount]){
        NSString* selectedBack = [m_bankTypes getBankNameById:m_selectedBankId];
    }
}

#pragma marks
#pragma marks - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m_selectedBankId = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [m_bankTypes getBankCount];
}

#pragma marks - UIPickerViewSourceDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [m_bankTypes getBankNameById:row];
}

@end
