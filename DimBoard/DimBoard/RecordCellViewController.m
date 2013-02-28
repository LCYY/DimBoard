//
//  RecordCellViewController.m
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "RecordCellViewController.h"

@interface RecordCellViewController ()

@end

@implementation RecordCellViewController
@synthesize ProgressBar,NameLabel,TermLabel,DateLabel,ImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setName:(NSString *)name Term:(NSString *)term Date:(NSString *)date Progress:(float)progress{
    [NameLabel setText:name];
    [TermLabel setText:term];
    [DateLabel setText:date];
    [ProgressBar setProgress:progress];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setNameLabel:nil];
    [self setTermLabel:nil];
    [self setDateLabel:nil];
    [self setProgressBar:nil];
    [super viewDidUnload];
}
@end
