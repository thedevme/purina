//
//  DayView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/4/12.
//
//

#import <UIKit/UIKit.h>

@interface DayView : UIView

@property(nonatomic, strong) UILabel* lblDate;
@property(nonatomic, strong) NSDate *objDate;
@property(nonatomic, strong) UIImageView *background;
@property(nonatomic) BOOL isSelected;

@property(nonatomic, strong) UIView *apptCircle;

- (id)initWithDay:(NSDate *)date;
- (void) setSelected;
- (void) setApptDay:(BOOL)value;

@end
