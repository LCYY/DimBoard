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
@synthesize BankPicker, ToolBar, OKButton;
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
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    CGRect frame = [ToolBar frame];
    frame.size.height-=10;
    [ToolBar setFrame:frame];
    
    [BankPicker setDelegate:self];
    [BankPicker setDataSource:self];
    m_bankTypes = [[BankTypes alloc] init];
    [BankPicker selectRow:m_selectedBankId inComponent:0 animated:YES];
    
    [OKButton setAction:@selector(onSave:)];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

- (void)viewDidUnload
{
    [self setToolBar:nil];
    [self setOKButton:nil];
    [super viewDidUnload];
    [self setBankPicker:nil];
    [self setM_delegate:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(screen.size.height == 480){
    }else if(screen.size.height == 568){
    }
    
    CGRect frame;
    if(UIInterfaceOrientationIsLandscape(orientation)){
        frame = self.view.frame;
        frame.size.width = screen.size.height;
        frame.size.height = screen.size.width;
        [self.view setFrame:frame];
        
        CGRect bankframe = CGRectMake(0, frame.size.height-BankPicker.frame.size.height, frame.size.width, BankPicker.frame.size.height);
        [BankPicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, BankPicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];
    }else{
        frame = self.view.frame;
        frame.size.width = screen.size.width;
        frame.size.height = screen.size.height;
        [self.view setFrame:frame];
        
        CGRect bankframe = CGRectMake(0, frame.size.height-BankPicker.frame.size.height, frame.size.width, BankPicker.frame.size.height);
        [BankPicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, BankPicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];    
    }
}

-(void)setBankId:(NSInteger)bankId{
    m_selectedBankId = bankId;
    [BankPicker selectRow:m_selectedBankId inComponent:0 animated:YES];
}

-(void)onSave:(id)sender{
    //[self.navigationController popViewControllerAnimated: YES];
    [self.view removeFromSuperview];
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
