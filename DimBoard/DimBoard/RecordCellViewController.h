//
//  RecordCellViewController.h
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"
#import "DimBoardNotifications.h"

@interface RecordCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TermLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressBar;


-(void)setName:(NSString*)name Term:(NSString*)term MonthlyPay:(NSString*)pay Progress:(float)progress;
@end
