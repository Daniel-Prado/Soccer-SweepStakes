//
//  SimpleFormViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleFormViewController.h"


@implementation SimpleFormViewController

@synthesize txt;
@synthesize delegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	txt.delegate = self;
}

-(IBAction)cancelForm {
	[self dismissModalViewControllerAnimated:NO];
}

-(IBAction)saveForm
{	
	[txt resignFirstResponder];
  										 
	[self.delegate saveFormData:txt.text];
	[self dismissModalViewControllerAnimated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	self.saveForm;
	return YES; 
}

- (void)viewWillAppear:(BOOL)animated {
	// Make the keyboard appear when the form shows.
	[super viewWillAppear:animated];
	[txt becomeFirstResponder];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
