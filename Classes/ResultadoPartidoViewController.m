    //
//  ResultadoPartidoViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 06/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultadoPartidoViewController.h"


@implementation ResultadoPartidoViewController
@synthesize porra, resLocal, resVisitante, delegate;
@synthesize equipoLocal, equipoVisitante;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	arrayMarcador = [[NSMutableArray alloc] initWithObjects :@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
	
	self.equipoLocal.text = porra.local;
	self.equipoVisitante.text = porra.visitante;
	
	if(porra.resultado!=nil)
	{
		NSString *list = porra.resultado;
		NSArray *aux = [list componentsSeparatedByString:@"-"];
		NSInteger row = [[aux objectAtIndex:0] intValue];
		[self.resLocal selectRow:row inComponent:0 animated:NO];
		row = [[aux objectAtIndex:1] intValue];
		[self.resVisitante selectRow:row inComponent:0 animated:NO];
	}
}

- (IBAction)cancelPartido {
	
	[self dismissModalViewControllerAnimated:YES];
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		NSInteger rowL;
		NSInteger rowV;
		
		rowL = [resLocal selectedRowInComponent:0];
		rowV = [resVisitante selectedRowInComponent:0];
		
		NSString *res = [NSString stringWithFormat:@"%@-%@",[arrayMarcador objectAtIndex:rowL],[arrayMarcador objectAtIndex:rowV]];
		
		porra.resultado = res;
		
		[self.delegate ModalDidEnd:self];
	}
	
}

- (IBAction)savePartido {
	
	UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Si acepta la porra quedará cerrada para edición" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Aceptar", nil];
	[myAlertView show];
	[myAlertView release];
	
}

#pragma mark -
#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [arrayMarcador count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [arrayMarcador objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory Management

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
