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

-(void)setName:(NSString *)name Term:(NSString *)term MonthlyPay:(NSString *)pay Progress:(float)progress{
    [NameLabel setText:name];
    [TermLabel setText:term];
    [DateLabel setText:pay];
    [ProgressBar setProgress:progress];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
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

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
    NSInteger widthchange = 160;
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(screen.size.height == 480){
    }else if(screen.size.height == 568){
        widthchange = widthchange + (568 - 480);
    }
    CGRect frame;
    if(UIInterfaceOrientationIsLandscape(orientation)){
        frame = self.view.frame;
        frame.size.width = screen.size.height;
        [self.view setFrame:frame];
        
        frame = ProgressBar.frame;
        frame.size.width = screen.size.height - 150;
        [ProgressBar setFrame:frame];
        
    }else{
        frame = self.view.frame;
        frame.size.width = screen.size.width;
        [self.view setFrame:frame];
        
        frame = ProgressBar.frame;
        frame.size.width = screen.size.width - 150;
        [ProgressBar setFrame:frame];
    }
}


@end
