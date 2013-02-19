//
//  BankPickerViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankPickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray* m_banks;
    NSInteger m_selectedBankId;
}
@property (weak, nonatomic) IBOutlet UIPickerView *BankPicker;

@end
