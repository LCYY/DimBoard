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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)onSlidValueChanged:(id)sender{
    UISlider* slider = (UISlider*)sender;
    m_value = [NSString stringWithFormat:@"%0.4f",slider.value];
    ValueInput.text = m_value;
}
@end
