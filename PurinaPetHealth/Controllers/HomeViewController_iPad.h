//
//  HomeViewController_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/27/12.
//
//

#import <UIKit/UIKit.h>
#import "POVView.h"
#import "HomeModView.h"
#import "OHAttributedLabel.h"
#import "Flurry.h"

@class PetModel;

@interface HomeViewController_iPad : UIViewController <UITableViewDataSource, UITableViewDelegate, HomeModDelegate>

@property (nonatomic, retain) NSArray* arrSlides;
@property (nonatomic, retain) POVView* povView;
@property (nonatomic, retain) HomeModView* homeModView;
@property (retain, nonatomic) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray* arrBlogData;

@property(nonatomic, strong) OHAttributedLabel* lblMessage;
@property(nonatomic, strong) PetModel *objPetModel;
@end

