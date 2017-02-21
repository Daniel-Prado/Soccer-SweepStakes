//
//  SimpleFormViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimpleFormViewControllerDelegate;

@interface SimpleFormViewController : UIViewController <UITextFieldDelegate> {

	id <SimpleFormViewControllerDelegate> delegate;
	
	UITextField *txt;
	
}

-(IBAction)cancelForm;
-(IBAction)saveForm;


@property(nonatomic,retain) id <SimpleFormViewControllerDelegate> delegate;
@property(nonatomic,retain) IBOutlet UITextField *txt;


@end

@protocol SimpleFormViewControllerDelegate

-(void) saveFormData:(NSString*) formData;

@end
