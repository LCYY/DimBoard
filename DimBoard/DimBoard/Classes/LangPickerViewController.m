//
//  LangPickerViewController.m
//  DimBoard
//
//  Created by Lin Yangyang on 13-3-17.
//  Copyright (c) 2013年 LCYY. All rights reserved.
//

#import "LangPickerViewController.h"

@interface LangPickerViewController ()

@end

@implementation LangPickerViewController
@synthesize LangPicker, ToolBar, OKButton;
@synthesize m_delegate;

-(id)init{
    self = [super init];
    if(self){
        m_selectedLangId = 0;
    }
    return self;
}

-(id)initWithLangId:(NSInteger)langId{
    self = [self init];
    if(self){
        m_selectedLangId = langId;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    CGRect frame = [ToolBar frame];
    frame.size.height-=10;
    [ToolBar setFrame:frame];
    
    [LangPicker setDelegate:self];
    [LangPicker setDataSource:self];
    m_langTypes = [[LangTypes alloc] init];
    [LangPicker selectRow:m_selectedLangId inComponent:0 animated:YES];
    
    [OKButton setAction:@selector(onSave:)];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLangPicker:nil];
    [self setToolBar:nil];
    [self setOKButton:nil];
    [super viewDidUnload];
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
        
        CGRect bankframe = CGRectMake(0, frame.size.height-LangPicker.frame.size.height, frame.size.width, LangPicker.frame.size.height);
        [LangPicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, LangPicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];
    }else{
        frame = self.view.frame;
        frame.size.width = screen.size.width;
        frame.size.height = screen.size.height;
        [self.view setFrame:frame];
        
        CGRect bankframe = CGRectMake(0, frame.size.height-LangPicker.frame.size.height, frame.size.width, LangPicker.frame.size.height);
        [LangPicker setFrame:bankframe];
        
        CGRect toolbarframe = CGRectMake(0, LangPicker.frame.origin.y - ToolBar.frame.size.height, frame.size.width, ToolBar.frame.size.height);
        [ToolBar setFrame:toolbarframe];
    }
}

-(void)setLangId:(NSInteger)langId{
    m_selectedLangId = langId;
    [LangPicker selectRow:m_selectedLangId inComponent:0 animated:YES];
}

-(void)onSave:(id)sender{
    //[self.navigationController popViewControllerAnimated: YES];
    [self.view removeFromSuperview];
    if(m_selectedLangId > -1 && m_selectedLangId < [m_langTypes getLangCount]){
        [m_delegate updateSettingKey:KEY_SETTING_LANG withValue:[m_langTypes getLangNameById:m_selectedLangId]];
    }
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    m_selectedLangId = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [m_langTypes getLangCount];
}

#pragma mark - UIPickerViewSourceDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [m_langTypes getLangNameById:row];
}
@end
