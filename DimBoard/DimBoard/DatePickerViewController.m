//
//  DatePickerViewController.m
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
@synthesize DatePicker;
@synthesize m_date;
@synthesize m_delegate;

-(id)init{
    self = [super init];
    if(self){
        m_date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
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

-(id)initWithDate:(NSDate*)date{
    self = [self init];
    if(self){
        m_date = [date copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATEFORMAT];
    [DatePicker setMinimumDate:[formatter dateFromString:@"1980-01-01"]];
    [DatePicker setMaximumDate:[formatter dateFromString:@"3000-12-31"]];
    [DatePicker setDate:m_date animated:YES];
    
    [DatePicker addTarget:self action:@selector(onDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.title = KEY_MORTGAGE_LOANDATE;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonItemStyleDone target:self action:@selector(onSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setDatePicker:nil];
    [self setM_delegate:nil];
    [self setM_date:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)onSave:(id)sender{
    [self.navigationController popViewControllerAnimated: YES];
    [m_delegate updateRecordKey:KEY_MORTGAGE_LOANDATE withValue:m_date];
}

-(void)onDateChanged:(id)sener{
    m_date = [DatePicker date];
}

@end
