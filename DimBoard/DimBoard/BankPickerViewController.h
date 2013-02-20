//
//  BankPickerViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"

@interface BankPickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    BankTypes* m_bankTypes;
    NSInteger m_selectedBankId;
}
@property (weak, nonatomic) IBOutlet UIPickerView *BankPicker;

@end
