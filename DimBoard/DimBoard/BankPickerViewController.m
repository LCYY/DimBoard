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
@synthesize m_delegate;

-(id)init{
    self = [super init];
    if(self){
        m_selectedBankId = -1;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithBankId:(NSInteger)bankId{
    self = [self init];
    if(self){
        m_selectedBankId = bankId;
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
    [BankPicker selectRow:m_selectedBankId inComponent:0 animated:YES];
    
    self.title = KEY_MORTGAGE_BANKID;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:self action:@selector(onSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setBankPicker:nil];
    [self setM_delegate:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)onSave:(id)sender{
    [self.navigationController popViewControllerAnimated: YES];
    if(m_selectedBankId > -1 && m_selectedBankId < [m_bankTypes getBankCount]){
        [m_delegate updateRecordKey:KEY_MORTGAGE_BANKID withValue:[NSNumber numberWithInteger:m_selectedBankId]];
    }
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m_selectedBankId = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [m_bankTypes getBankCount];
}

#pragma mark - UIPickerViewSourceDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [m_bankTypes getBankNameById:row];
}

@end
