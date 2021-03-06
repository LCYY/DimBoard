//
//  AddRecordViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "SliderCell.h"
#import "InputCell.h"
#import "MortgageDataType.h"
#import "DatePickerViewController.h"
#import "BankPickerViewController.h"
#import "DimBoardProtocols.h"

#define ADDRECORDSECTIONCOUNT 4

#define ADDMODE 0
#define EDITMODE 1

@interface AddRecordViewController : UIViewController<UpdateRecordItemProtocol, UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate>{
    NSInteger m_mode;
}

@property (weak, nonatomic) IBOutlet ADBannerView *m_adBannerView;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) id<UpdateRecordProtocol> m_delegate;
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

@property (strong) BankPickerViewController* m_bankViewController;
@property (strong) DatePickerViewController* m_dataPickerViewController;

- (id)initWithMortgageRecord:(MortgageRecord*)record Mode:(NSInteger)mode;
@end
