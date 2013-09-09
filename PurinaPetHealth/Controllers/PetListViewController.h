//
//  PetListViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/18/12.
//
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "PetItemView.h"

@interface PetListViewController : UIViewController <PetListDelegate>

@property (nonatomic, retain) NSMutableArray* arrPets;
@property (nonatomic, retain) NSMutableArray* arrSelectedPets;

@end
