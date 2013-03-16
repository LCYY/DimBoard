//
//  InputCellViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateRecordItemProtocol.h"
#import "DimBoardNotifications.h"

@interface InputCellViewController : UIViewController<UITextFieldDelegate>{
    NSString* m_name;
    NSString* m_value;
}
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ValueInput;
@property(nonatomic, weak) id<UpdateRecordItemProtocol> m_delegate;

- (id)initWithName:(NSString *)name Value:(NSString*)value;
- (void)setName:(NSString *)name Value:(NSString *)value;
- (NSString*)getValue;
@end
