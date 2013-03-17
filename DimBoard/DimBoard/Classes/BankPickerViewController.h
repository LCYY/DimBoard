//
//  BankPickerViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"
#import "UpdateRecordItemProtocol.h"
#import "DimBoardNotifications.h"

@interface BankPickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    BankTypes* m_bankTypes;
    NSInteger m_selectedBankId;
}
@property (weak, nonatomic) IBOutlet UIToolbar *ToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *OKButton;
@property (weak, nonatomic) IBOutlet UIPickerView *BankPicker;
@property (weak, nonatomic) id<UpdateRecordItemProtocol> m_delegate;

-(id)initWithBankId:(NSInteger)bankId;
-(void)setBankId:(NSInteger)bankId;


@end
