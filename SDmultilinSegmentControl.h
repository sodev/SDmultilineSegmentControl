#import <Foundation/Foundation.h>
#import "UIView+position.h"

@interface SDmultilineSegmentControl : UIView

#pragma mark - Properties
@property (nonatomic) NSInteger numberOfLines;
@property (nonatomic, strong) NSArray *items;

@end
