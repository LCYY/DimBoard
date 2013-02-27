//
//  InputCellViewController.m
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "InputCellViewController.h"

@interface InputCellViewController ()

@end

@implementation InputCellViewController
@synthesize NameLabel;
@synthesize ValueInput;
@synthesize m_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithName:(NSString *)name Value:(NSString*)value{
    self = [super init];
    if (self) {
        // Custom initialization
        m_name = name;
        m_value = value;
    }
    return self;
}

- (void) setName:(NSString *)name Value:(NSString *)value{
    m_name = name;
    m_value = value;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = m_name;
    [NameLabel setText:m_name];
    [ValueInput setText:m_value];
    [ValueInput setDelegate:self];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setValueInput:nil];
    [self setM_delegate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString *)getValue{
    return [ValueInput text];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    m_value = [ValueInput text];
    [m_delegate updateRecordKey:m_name withValue:m_value];
}

@end
