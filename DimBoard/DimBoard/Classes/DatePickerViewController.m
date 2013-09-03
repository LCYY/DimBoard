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
@synthesize DatePicker, ToolBar, OKButton;
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
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    CGRect frame = [ToolBar frame];
    frame.size.height-=10;
    [ToolBar setFrame:frame];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATEFORMAT];
    [DatePicker setMinimumDate:[formatter dateFromString:@"1980-01-01"]];
    [DatePicker setMaximumDate:[formatter dateFromString:@"2100-12-31"]];
    [DatePicker setDate:m_date animated:YES];
    
    [DatePicker addTarget:self action:@selector(onDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [OKButton setAction:@selector(onSave:)];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

- (void)viewDidUnload
{
    [self setToolBar:nil];
    [self setOKButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setDatePicker:nil];
    [self setM_delegate:nil];
    [self setM_date:nil];
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
        
        CGRect bankframe = CGRectMake(0, frame.size.height-DatePicker.frame.size.height, frame.size.width, DatePicker.frame.size.height);
        [DatePicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, DatePicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];
    }else{
        frame = self.view.frame;
        frame.size.width = screen.size.width;
        frame.size.height = screen.size.height;
        [self.view setFrame:frame];
        
        CGRect bankframe = CGRectMake(0, frame.size.height-DatePicker.frame.size.height, frame.size.width, DatePicker.frame.size.height);
        [DatePicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, DatePicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];
    }
}

-(void)onSave:(id)sender{
    [self.view removeFromSuperview];
    [m_delegate updateRecordKey:DimBoardLocalizedString(KEY_MORTGAGE_LOANDATE) withValue:m_date];
}

-(void)onDateChanged:(id)sener{
    m_date = [DatePicker date];
}

@end
