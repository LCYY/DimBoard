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
@synthesize AddButton, MinusButton;
@synthesize m_deletegate;
@synthesize m_timer;

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
        m_timer = nil;
        m_currentValue = [m_value doubleValue];
        m_minValue = 0.0;
        m_maxValue = 0.0;
        m_step = 0.0;
        m_repeatCnt = 0;
        
        if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE)]){//int terms of 10-thousand
            m_minValue = MIN_HOME_VALUE;
            m_maxValue = MAX_HOME_VALUE;
            m_step = STEP_HOME_VALUE;
            m_stepCoeff = COEFF_HOME_VALUE;
        }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE)]){//in terms of %
            m_minValue = MIN_LOANRATE_VALUE;
            m_maxValue = MAX_LOANRATE_VALUE;
            m_step = STEP_LOANRATE_VALUE;
            m_stepCoeff = COEFF_LOANRATE_VALUE;
        }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT)]){// in terms of year
            m_minValue = MIN_LOANPERCENT_VALUE;
            m_maxValue = MAX_LOANPERCENT_VALUE;
            m_step = STEP_LOANPERCENT_VALUE;
            m_stepCoeff = COEFF_LOANPERCENT_VALUE;
        }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR)]){// in terms of %
            m_minValue = MIN_LOANYEAR_VALUE;
            m_maxValue = MAX_LOANYEAR_VALUE;
            m_step = STEP_LOANYEAR_VALUE;
            m_stepCoeff = COEFF_LOANYEAR_VALUE;
        }
    }
    return self;
}

- (void) setName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit{
    m_name = name;
    m_value = value;
    m_unit = unit;
    
    [NameLabel setText:DimBoardLocalizedString(m_name)];
    [ValueInput setText:m_value];
    [UnitLabel setText:m_unit];
    
    NSInteger langid = LocalizationGetLanguage();
    if(langid == 0){
        [NameLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    else{
        [NameLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ValueInput setDelegate:self];
    
    [AddButton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [AddButton setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState:UIControlStateHighlighted];
    [AddButton setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState:UIControlStateReserved];
    [AddButton setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState:UIControlStateSelected];
    [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
    [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus2.png"] forState:UIControlStateHighlighted];
    [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus2.png"] forState:UIControlStateReserved];
    [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus2.png"] forState:UIControlStateSelected];
        
    UILongPressGestureRecognizer* addlongPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onAddLongPressed:)];
    [addlongPressRecognizer setMinimumPressDuration:0.5];
    [AddButton addGestureRecognizer:addlongPressRecognizer];
    
    UILongPressGestureRecognizer* minuslongPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onMinusLongPressed:)];
    [minuslongPressRecognizer setMinimumPressDuration:0.5];
    [MinusButton addGestureRecognizer:minuslongPressRecognizer];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeLanuage:) name:NOTI_CHANGELANGUAGE object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = m_name;
    
    [NameLabel setText:DimBoardLocalizedString(m_name)];
    [ValueInput setText:m_value];
    [UnitLabel setText:m_unit];
    
    NSInteger langid = LocalizationGetLanguage();
    if(langid == 0){
        [NameLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    else{
        [NameLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setValueInput:nil];
    [self setUnitLabel:nil];
    [self setMinusButton:nil];
    [self setAddButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_deletegate:nil];
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)onChangeLanuage:(NSNotification*) noti{
    [self rotateToOrientation:self.interfaceOrientation];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
    NSInteger widthchange = 160;
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(screen.size.height == 480){
    }else if(screen.size.height == 568){
        widthchange = widthchange + (568 - 480);
    }
    
    NSInteger langId = LocalizationGetLanguage();
    if(langId == 0){
        CGRect frame;
        if(UIInterfaceOrientationIsLandscape(orientation)){
            frame = self.view.frame;
            frame.size.width = screen.size.height;
            [self.view setFrame:frame];
            
            frame = NameLabel.frame;
            frame.size.width = 120;
            [NameLabel setFrame:frame];
            
            frame = ValueInput.frame;
            frame.size.width = 20 + widthchange;
            frame.origin.x = 140;
            [ValueInput setFrame:frame];
            
            frame = UnitLabel.frame;
            frame.origin.x = 155 + widthchange;
            [UnitLabel setFrame:frame];
            
            frame = MinusButton.frame;
            frame.origin.x = 225 + widthchange;
            [MinusButton setFrame:frame];
            
            frame = AddButton.frame;
            frame.origin.x = 282 + widthchange;
            [AddButton setFrame:frame];
        }else{
            frame = self.view.frame;
            frame.size.width = screen.size.width;
            [self.view setFrame:frame];
            
            frame = NameLabel.frame;
            frame.size.width = 120;
            [NameLabel setFrame:frame];
            
            frame = ValueInput.frame;
            frame.size.width = 80;
            frame.origin.x = 125;
            [ValueInput setFrame:frame];
            
            frame = UnitLabel.frame;
            frame.origin.x = 197;
            [UnitLabel setFrame:frame];
            
            frame = MinusButton.frame;
            frame.origin.x = 237;
            [MinusButton setFrame:frame];
            
            frame = AddButton.frame;
            frame.origin.x = 282;
            [AddButton setFrame:frame];
        }
    }else{
        CGRect frame;
        if(UIInterfaceOrientationIsLandscape(orientation)){
            frame = self.view.frame;
            frame.size.width = screen.size.height;
            [self.view setFrame:frame];
            
            frame = ValueInput.frame;
            frame.size.width = 50 + widthchange;
            frame.origin.x = 110;
            [ValueInput setFrame:frame];
            
            frame = UnitLabel.frame;
            frame.origin.x = 155 + widthchange;
            [UnitLabel setFrame:frame];
            
            frame = MinusButton.frame;
            frame.origin.x = 215 + widthchange;
            [MinusButton setFrame:frame];
            
            frame = AddButton.frame;
            frame.origin.x = 282 + widthchange;
            [AddButton setFrame:frame];
        }else{
            frame = self.view.frame;
            frame.size.width = screen.size.width;
            [self.view setFrame:frame];
            
            frame = ValueInput.frame;
            frame.size.width = 102;
            frame.origin.x = 95;
            [ValueInput setFrame:frame];
            
            frame = UnitLabel.frame;
            frame.origin.x = 190;
            [UnitLabel setFrame:frame];
            
            frame = MinusButton.frame;
            frame.origin.x = 230;
            [MinusButton setFrame:frame];
            
            frame = AddButton.frame;
            frame.origin.x = 282;
            [AddButton setFrame:frame];
        }
    }
}

- (IBAction)onMinusDown:(id)sender {
    m_currentValue -= m_step;
    [self updateValues];
}

- (IBAction)onAddDown:(id)sender {
    m_currentValue += m_step;
    [self updateValues];
}

-(void)onAddLongPressed:(id)sender{
    [self onLongPressed:sender];
}

-(void)onMinusLongPressed:(id)sender{
    [self onLongPressed:sender];
}

-(void)onLongPressed:(id)sender{
    UILongPressGestureRecognizer* recognizer = (UILongPressGestureRecognizer*)sender;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if(m_timer){
                [m_timer invalidate];
                m_timer = nil;
            }
            if(recognizer.view == MinusButton){
                m_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(minusValueQuickly:) userInfo:nil repeats:YES];
                [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus2.png"] forState:UIControlStateNormal];
            }
            else if(recognizer.view == AddButton){
                m_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addValueQuickly:) userInfo:nil repeats:YES];
                [AddButton setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState:UIControlStateNormal];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if(m_timer){
                [m_timer invalidate];
                m_timer = nil;
                m_repeatCnt = 0;
            }
            if(recognizer.view == MinusButton){
                [MinusButton setBackgroundImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
            }
            else if(recognizer.view == AddButton){
                [AddButton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
}

-(void)addValueQuickly:(id)sender{
    m_repeatCnt ++;
    
    int times = 1+ (int)(m_stepCoeff*m_repeatCnt*m_repeatCnt);
    m_currentValue += times*m_step;
    [self updateValues];
}

-(void)minusValueQuickly:(id)sender{
    m_repeatCnt ++;
    
    int times = 1 + (int)(m_stepCoeff*m_repeatCnt*m_repeatCnt);
    m_currentValue -= times*m_step;
    [self updateValues];
}

-(void)checkValueRange{
    if(m_currentValue > m_maxValue){
        m_currentValue = m_minValue;
    }else if(m_currentValue < m_minValue){
        m_currentValue = m_maxValue;
    }
}

-(void)updateValues{
    [self checkValueRange];
    if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANYEAR)]){
        m_value = [NSString stringWithFormat:@"%d",(int)m_currentValue];
    }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_LOANPERCENT)]){
        m_value = [NSString stringWithFormat:@"%d",(int)m_currentValue];
    }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_INTERESTRATE)]){
        m_value = [NSString stringWithFormat:@"%0.2f",m_currentValue];
    }else if([m_name isEqualToString:DimBoardLocalizedString(KEY_MORTGAGE_HOMEVALUE)]){
        m_value = [NSString stringWithFormat:@"%d",(int)m_currentValue];
    }
    ValueInput.text = m_value;
    [m_deletegate updateRecordKey:m_name withValue:m_value];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    m_value = [ValueInput text];
    m_currentValue = [m_value doubleValue];
    [m_deletegate updateRecordKey:m_name withValue:m_value];
    return YES;
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
