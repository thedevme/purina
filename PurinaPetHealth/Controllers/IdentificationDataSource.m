//
//  IdentificationDataSource.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/26/12.
//
//

#import "IdentificationDataSource.h"
#import <IBAForms/IBAForms.h>
#import "SampleFormDataSource.h"
#import "ShowcaseModel.h"
#import "ShowcaseButtonStyle.h"
#import "ShowcaseFieldStyle.h"
#import "StringToNumberTransformer.h"
#import "EmergencyViewController.h"

@implementation IdentificationDataSource


- (id) initWithModel:(id)aModel
{
    if ((self = [super initWithModel:aModel]))
    {
        IBAFormFieldStyle *style = [[IBAFormFieldStyle alloc] init];
		style.labelTextColor = [UIColor darkGrayColor];
		style.labelFont = [UIFont fontWithName:kHelveticaNeue size:12.0f];
		style.labelTextAlignment = UITextAlignmentLeft;
        style.valueFont = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
        
        style.valueFrame = CGRectMake(IBAFormFieldValueX+40, IBAFormFieldValueY, IBAFormFieldValueWidth-40, IBAFormFieldValueHeight);
        
		style.valueTextColor = [UIColor darkGrayColor];
        style.valueBackgroundColor = [UIColor clearColor];
        style.labelFrame = CGRectMake(IBAFormFieldLabelX, IBAFormFieldLabelY, IBAFormFieldLabelWidth + 100, IBAFormFieldLabelHeight);
        style.labelBackgroundColor = [UIColor clearColor];
        style.activeColor = [UIColor clearColor];
        style.valueTextAlignment = UITextAlignmentRight;
        [self createIdentificationForm:style];
        [self createDate];
    }
    
    return self;
}

- (void) createIdentificationForm:(IBAFormFieldStyle *)style
{
    IBAFormSection *spayedNeuteredSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    spayedNeuteredSection.formFieldStyle = style;
    //[spayedNeuteredSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"spayed" title:@"Spayed/ Neutered"]];
    
    
    
    
    [spayedNeuteredSection addFormField:[[IBABooleanFormField alloc] initWithKeyPath:@"spayed" title:@"Spayed/ Neutered"]];
    
    
    

    
    
    
    
    
    
    IBAFormSection *weightSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    weightSection.formFieldStyle = style;
    
    weightSection.headerView.backgroundColor = [UIColor redColor];
    [weightSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"weight" title:@"Weight"]];
    
    IBAFormSection *colorSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    colorSection.formFieldStyle = style;
    [colorSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"color" title:@"Color"]];
    
    IBAFormSection *eyeColorSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    eyeColorSection.formFieldStyle = style;
    [eyeColorSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"eye-color" title:@"Eye Color"]];
    
    IBAFormSection *coatMarkingsSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    coatMarkingsSection.formFieldStyle = style;
    [coatMarkingsSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"coat" title:@"Coat Markings"]];
    
    IBAFormSection *priceSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    priceSection.formFieldStyle = style;
    
    IBATextFormField* txtField = [[IBATextFormField alloc] initWithKeyPath:@"price" title:@"Price"];
    [priceSection addFormField:txtField];
    txtField.textFormFieldCell.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    IBAFormSection *tagNoSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    tagNoSection.formFieldStyle = style;
    [tagNoSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"tag" title:@"Tag #"]];
    
    IBAFormSection *chipNoSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    chipNoSection.formFieldStyle = style;
    [chipNoSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"chip" title:@"Chip #"]];
    
    IBAFormSection *licenseNoSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    licenseNoSection.formFieldStyle = style;
    [licenseNoSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"license" title:@"License #"]];
    
    IBAFormSection *pedigreeSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    pedigreeSection.formFieldStyle = style;
    [pedigreeSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"pedigree" title:@"Pedigree"]];
}

- (void) displaySampleForm
{
    NSLog(@"display");
}



- (void) createDate
{
    
    IBAFormFieldStyle *style = [[IBAFormFieldStyle alloc] init];
    style.labelTextColor = [UIColor darkGrayColor];
    style.labelFont = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    style.labelTextAlignment = UITextAlignmentLeft;
    style.valueFont = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
    
    style.valueFrame = CGRectMake(IBAFormFieldValueX, IBAFormFieldValueY, IBAFormFieldValueWidth - 50, IBAFormFieldValueHeight);
    
    style.valueTextColor = [UIColor darkGrayColor];
    style.valueBackgroundColor = [UIColor clearColor];
    //style.labelFrame = CGRectMake(IBAFormFieldLabelX, IBAFormFieldLabelY, IBAFormFieldLabelWidth + 100, IBAFormFieldLabelHeight);
    style.labelBackgroundColor = [UIColor clearColor];
    style.activeColor = [UIColor clearColor];
    style.valueTextAlignment = UITextAlignmentRight;
    
    
    IBAFormSection *dateFieldSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    dateFieldSection.formFieldStyle = style;
    NSDateFormatter *dateTimeFormatter = [[NSDateFormatter alloc] init];
    
    [dateTimeFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateTimeFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateTimeFormatter setDateFormat:@"MMM d, yyyy"];
    
    [dateFieldSection addFormField:[[IBADateFormField alloc] initWithKeyPath:@"date"
                                                                       title:@"Date Owned"
                                                                defaultValue:[NSDate date]
                                                                        type:IBADateFormFieldTypeDate
                                                               dateFormatter:dateTimeFormatter]];
}

- (void)formField:(IBAFormField *)formField didSetValue:(id)value
{
    NSLog(@"key path %@", [formField keyPath]);
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath
{
	[super setModelValue:value forKeyPath:keyPath];
//	AppointmentData* objAppointmentData = [[AppointmentData alloc] init];
//
//    objAppointmentData.title = [self.model valueForKeyPath:@"title"];
//    objAppointmentData.type = [[[[self.model valueForKeyPath:@"type"] allObjects] objectAtIndex:0] name];
//    objAppointmentData.saveToCalendar = [[self.model valueForKeyPath:@"saveToCalendar"] intValue];
//    objAppointmentData.petNames = [[self.model valueForKeyPath:@"petNames"] allObjects];
//
//
//    NSString* apptDate = [NSString stringWithFormat:@"%@", [self.model valueForKeyPath:@"dateTime"]];
//    //NSLog(@"type %@", [[[self.model valueForKeyPath:@"type"] allObjects] objectAtIndex:0]);
//    //NSLog(@"%@", [[self.model valueForKeyPath:@"petNames"] allObjects]);
//
//    if (apptDate != NULL)
//    {
//        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        //        [dateFormatter setDateFormat:@"EEE d MMM  h:mm a"];
//        //        NSDate *dateFromString = [[NSDate alloc] init];
//        //        dateFromString = [dateFormatter dateFromString:apptDate];
//        objAppointmentData.startDate = [self.model valueForKeyPath:@"dateTime"];
//    }


    NSLog(@"weight %@", [self.model valueForKeyPath:@"weight"]);

    
    [_delegate updateIdentificationData];
    
}


@end
