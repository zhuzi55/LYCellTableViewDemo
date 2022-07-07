//
//  TestTableViewCell.h
//  Demo20210123OC
//
//  Created by liyz on 2022/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TestTableViewCellDelegate <NSObject>

-(void)cellTableViewScroll:(UIScrollView *)scrollView;
//
-(void)cellTableViewDidEnedScroll:(UIScrollView *)scrollView;

@end

@interface TestTableViewCell : UITableViewCell

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, weak) id<TestTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
