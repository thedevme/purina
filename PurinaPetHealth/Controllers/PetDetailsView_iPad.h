//
//  PetDetailsView_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//

#import <UIKit/UIKit.h>
#import "IdentificationFormViewController.h"
#import "Pet.h"
#import "MedicalView_iPad.h"
#import "MedicalItemsView_iPad.h"

@class IdentificationView_iPad;
@class PetData;
@class MedicalView_iPad;
@class MedicalItemsView_iPad;
@class OHAttributedLabel;
@class DDPageControl;
@class PetModel;


@protocol PetDetailsDelegate <NSObject>

- (void)showModal:(NSString *)type withData:(PetData *)pet;
- (void)createNewMedWithType:(NSString *)type andContentType:(NSString *)contentType;
- (void)updateTextWithType:(NSString *)type withContentType:(NSString *)contentType andData:(NSString *)data;

@end


@interface PetDetailsView_iPad : UIView <PetDetailsDelegate, UITableViewDelegate, UITableViewDataSource,
        MedicalCategoryDelegate, MedicalItemsDelegate, UIScrollViewDelegate>


@property(nonatomic, strong) IBOutlet UIButton * btnIdentification;
@property(nonatomic, strong) IBOutlet UIButton * btnMedical;
@property (nonatomic, assign) id<PetDetailsDelegate> delegate;

@property(nonatomic, strong) IdentificationView_iPad *identificationView;
@property(nonatomic, strong) MedicalView_iPad *medicalView;

@property(nonatomic, strong) PetData* objPetData;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

@property(nonatomic, strong) NSMutableArray *sections;

@property(nonatomic, strong) UIPopoverController *popoverController;
@property (weak, nonatomic) IBOutlet OHAttributedLabel *lblApptMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblApptTitle;
@property(nonatomic, strong) MedicalItemsView_iPad *medicalDetailsView;
@property(nonatomic, strong) NSMutableArray *arrAppointments;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) DDPageControl *pageControls;
@property (assign) BOOL pageControlBeingUsed;
@property (assign) int numCurrentPage;
@property (assign) int numWidth;
@property (assign) int numHeight;

@property(nonatomic, strong) PetModel *petModel;

- (IBAction)onEditTapped:(id)sender;
- (IBAction) onNavigationTapped:(id)sender;
- (void) initializeData:(PetData *)pet;
- (void) updateIdentification:(PetData *)data;
- (void) updateMedical:(PetData *)data;
- (void) updatePet:(PetData *)pet;
- (void)getPetAppointments;
- (void) resetAppointments;

@end
