//
//  DatePickerViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"
#import "UpdateRecordItemProtocol.h"
#import "DimBoardNotifications.h"

@interface DatePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIToolbar *ToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *OKButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (retain, nonatomic) NSDate* m_date;
@property (retain, nonatomic) id<UpdateRecordItemProtocol> m_delegate;

-(id)initWithDate:(NSDate*)date;
@end
