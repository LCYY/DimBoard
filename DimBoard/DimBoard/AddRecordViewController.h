//
//  AddRecordViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderCell.h"
#import "InputCell.h"
#import "MortgageDataType.h"
#import "DatePickerViewController.h"
#import "BankPickerViewController.h"
#import "UpdateRecordItemProtocol.h"

#define ADDRECORDSECTIONCOUNT 4

#define ADDMODE 0
#define EDITMODE 1

@interface AddRecordViewController : UITableViewController<UpdateRecordItemProtocol>{
    NSInteger m_mode;
}

@property (retain, nonatomic) id<UpdateRecordProtocol> m_delegate;
//Section 0
//---------
//貸款名稱 inputcell
//---------
@property (retain, nonatomic) NSString *m_section0;

//Section 1
//---------
//按揭銀行 normal cell
//---------
@property (retain, nonatomic) NSString *m_section1;

//Section 2
//---------
//物業價值 slidercell
//按揭成數 slidercell
//按揭年期 slidercell
//按揭利率 slidercell
//---------
@property (retain, nonatomic) NSArray *m_section2;

//Section 3
//---------
//按揭時間 date picker
//---------
@property (retain, nonatomic) NSString *m_section3;
@property (retain, nonatomic) MortgageRecord* m_record;

- (id)initWithMortgageRecord:(MortgageRecord*)record Mode:(NSInteger)mode;
@end
