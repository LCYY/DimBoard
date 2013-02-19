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
    m_banks = [[NSArray alloc] initWithObjects:
                      @"渣打銀行",
                      @"匯豐銀行",
                      @"中國建設銀行",
                      @"中國銀行",
                      @"東亞銀行",
                      @"恆生銀行",
                      @"大新銀行",
                      @"中國工商銀行",
                      @"花旗銀行",
                      @"中信銀行",
                      @"星展銀行",
                      @"富邦銀行",
                      @"創興銀行",
                      @"豐明銀行",
                      @"南洋商業銀行",
                      @"大眾銀行",
                      @"上海商業銀行",
                      @"標準銀行銀行",
                      @"大生銀行",
                      @"大有銀行",
                      @"永亨銀行",
                      @"永隆銀行",
                      nil];
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
    if(m_selectedBankId > -1 && m_selectedBankId < [m_banks count]){
        NSString* selectedBack = [m_banks objectAtIndex:m_selectedBankId];
    }
}

#pragma marks
#pragma marks - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m_selectedBankId = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [m_banks count];
}

#pragma marks - UIPickerViewSourceDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [m_banks objectAtIndex:row];
}

@end
