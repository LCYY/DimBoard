//
//  EditNumberViewController.m
//  DimBoard
//
//  Created by conicacui on 18/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "EditNumberViewController.h"

@interface EditNumberViewController ()

@end

@implementation EditNumberViewController
@synthesize NameLabel;
@synthesize EditInput;
@synthesize UnitLabel;
@synthesize SlidBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithName:(NSString *)name Value:(double)value Unit:(NSString *)unit{
    self = [super init];
    if (self) {
        // Custom initialization
        m_name = name;
        m_value = value;
        m_unit = unit;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [NameLabel setText:m_name];
    [EditInput setText:[NSString stringWithFormat:@"%0.2f",m_value]];
    [UnitLabel setText:m_unit];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setEditInput:nil];
    [self setUnitLabel:nil];
    [self setSlidBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
