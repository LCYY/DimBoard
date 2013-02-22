//
//  SliderCellViewController.m
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "SliderCellViewController.h"

@interface SliderCellViewController ()

@end

@implementation SliderCellViewController
@synthesize NameLabel;
@synthesize ValueInput;
@synthesize UnitLabel;
@synthesize SlideBar;
@synthesize m_deletegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit{
    self = [super init];
    if (self) {
        // Custom initialization
        m_name = name;
        m_value = value;
        m_unit = unit;
    }
    return self;
}

- (void) setName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit{
    m_name = name;
    m_value = value;
    m_unit = unit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = m_name;
    [NameLabel setText:m_name];
    [ValueInput setText:m_value];
    [UnitLabel setText:m_unit];
    
    [SlideBar addTarget:self action:@selector(onSlidValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    double minvalue = 0;
    double maxvalue = 0;
    if([m_name isEqualToString:KEY_MORTGAGE_HOMEVALUE]){//int terms of 10-thousand
        minvalue = MIN_HOME_VALUE;
        maxvalue = MAX_HOME_VALUE;
    }else if([m_name isEqualToString:KEY_MORTGAGE_LOANRATE]){//in terms of %
        minvalue = MIN_LOANRATE_VALUE;
        maxvalue = MAX_LOANRATE_VALUE;
    }else if([m_name isEqualToString:KEY_MORTGAGE_LOANPERCENT]){// in terms of year
        minvalue = MIN_LOANPERCENT_VALUE;
        maxvalue = MAX_LOANPERCENT_VALUE;
    }else if([m_name isEqualToString:KEY_MORTGAGE_LOANYEAR]){// in terms of %
        minvalue = MIN_LOANYEAR_VALUE;
        maxvalue = MAX_LOANYEAR_VALUE;
    }
    [SlideBar setMinimumValue:minvalue];
    [SlideBar setMaximumValue:maxvalue];
    [SlideBar setValue:[m_value doubleValue]];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setValueInput:nil];
    [self setSlideBar:nil];
    [self setUnitLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_deletegate:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)onSlidValueChanged:(id)sender{
    UISlider* slider = (UISlider*)sender;
    
    if([m_name isEqualToString:KEY_MORTGAGE_LOANYEAR]){
        m_value = [NSString stringWithFormat:@"%d",(int)slider.value];
    }else if([m_name isEqualToString:KEY_MORTGAGE_LOANPERCENT]){
        m_value = [NSString stringWithFormat:@"%d",(int)slider.value];
    }else if([m_name isEqualToString:KEY_MORTGAGE_LOANRATE]){
        m_value = [NSString stringWithFormat:@"%0.2f",slider.value];
    }else if([m_name isEqualToString:KEY_MORTGAGE_HOMEVALUE]){
        m_value = [NSString stringWithFormat:@"%d",(int)slider.value];
    }
    ValueInput.text = m_value;
    [m_deletegate updateRecordKey:m_name withValue:m_value];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    m_value = [ValueInput text];
    [SlideBar setValue:[m_value doubleValue]];
    [m_deletegate updateRecordKey:m_name withValue:m_value];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if(string.length == 0)
        return YES;
    //can only input number and one dot
    NSRange hasDot = [textField.text rangeOfString:@"."];
    NSCharacterSet* filterSet;
    NSString* afterFilter;
    if(hasDot.location < textField.text.length || hasDot.location == 0 ){
        filterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        afterFilter = [string stringByTrimmingCharactersInSet:filterSet];
    }else{
        filterSet = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789"] invertedSet];
        afterFilter = [string stringByTrimmingCharactersInSet:filterSet];
    }
    if(afterFilter.length > 0){
        return YES;
    }else{
        return NO;
    }
    //? need range handling???
}
@end
