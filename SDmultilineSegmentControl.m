//
//  SDmultineLineSegmentControl.m
//
//  Created by Sean O'Connor on 5/02/2015.
//  Copyright (c) 2015 SODev. All rights reserved.
//

#import "SDmultilineSegmentControl.h"
NSInteger const kDefaultNumberOfLines = 1;

@implementation SDmultilineSegmentControl
@synthesize numberOfLines;
@synthesize items;

#pragma mark - Initialization Methods
// only need to overide initwithframe style as init and initwithframe both call this method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        numberOfLines = kDefaultNumberOfLines;
        [self drawView];
    }
    return self;
}

#pragma mark - View Configuration Methods
- (void)drawView
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // loop thorugh and draw a unique segmented control for each line
    for (int i = 0; i < numberOfLines; i++) {
        int itemsPerLine = ([items count] + numberOfLines - 1) / numberOfLines;
        // the last line will show the remaining items
        // this may often be uneven, therefore we need to calculate the NSRange
        // accordingly or it will overflow the items array
        BOOL lastLine = i == numberOfLines - 1;
        NSRange itemRange;
        if (lastLine) {
            itemRange = NSMakeRange(i * itemsPerLine, [items count] - i * itemsPerLine);
        } else {
            itemRange = NSMakeRange(i * itemsPerLine, itemsPerLine);
        }
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[items subarrayWithRange:itemRange]];
        [segmentedControl addTarget:self action:@selector(controlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        float frameHeight = self.frameHeight / numberOfLines;
        CGRect frame = CGRectMake(0, frameHeight * i, self.frameWidth, frameHeight);
        [segmentedControl setFrame:frame];
        
        [self addSubview:segmentedControl];
    }
}

#pragma mark - Property Setters
- (void)setNumberOfLines:(NSInteger)newNumberOfLines
{
    numberOfLines = newNumberOfLines;
    [self drawView];
}
- (void)setItems:(NSArray *)newItems
{
    items = newItems;
    [self drawView];
}

#pragma mark - Segment Control Actions
- (void)controlValueChanged:(id)sender
{
    // get the selected segemented control and index
    UISegmentedControl *setControl = (UISegmentedControl *)sender;
    NSInteger setIndex = [setControl selectedSegmentIndex];
    
    // set all the segment controls as unselected
    for (UISegmentedControl *control in [self subviews]) {
        [control setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    
    // set the control and index that was initially set
    [setControl setSelectedSegmentIndex:setIndex];
}

@end
