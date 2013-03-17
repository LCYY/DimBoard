//
//  LangPickerViewController.h
//  DimBoard
//
//  Created by Lin Yangyang on 13-3-17.
//  Copyright (c) 2013年 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageDataType.h"
#import "DimBoardProtocols.h"
#import "DimBoardNotifications.h"

@interface LangPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    LangTypes* m_langTypes;
    NSInteger m_selectedLangId;
}

@property (weak, nonatomic) IBOutlet UIPickerView *LangPicker;
@property (weak, nonatomic) IBOutlet UIToolbar *ToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *OKButton;
@property (weak, nonatomic) id<UpdateSettingItemProtocol> m_delegate;


-(id)initWithLangId:(NSInteger)langId;
-(void)setLangId:(NSInteger)langId;
@end
