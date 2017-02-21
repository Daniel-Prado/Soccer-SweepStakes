//
//  ParticipanteViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 05/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ParticipanteViewController.h"


@implementation ParticipanteViewController 
@synthesize nombreParticipante, resLocal, resVisitante, delegate;
@synthesize equipoLocal, equipoVisitante;
@synthesize personaEditada;
@synthesize btnEliminar;

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
	[self.btnEliminar setHidden:TRUE];
	nombreParticipante.delegate = self;
	arrayMarcador = [[NSMutableArray alloc] initWithObjects :@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
	
	if(self.personaEditada != nil)
	{
		self.title = @"Edita Apuesta";
		[self.btnEliminar setHidden:FALSE];
		
		self.nombreParticipante.text = personaEditada.nombre;
		
		NSString *list = personaEditada.resultado;
		NSArray *aux = [list componentsSeparatedByString:@"-"];
		NSInteger row = [[aux objectAtIndex:0] intValue];
		[self.resLocal selectRow:row inComponent:0 animated:NO];
		row = [[aux objectAtIndex:1] intValue];
		[self.resVisitante selectRow:row inComponent:0 animated:NO];
	}
}


- (IBAction)cancelParticipante {

	[self dismissModalViewControllerAnimated:YES];
	
}
- (IBAction)saveParticipante {
	
	//PersonaCD *participante;
	
	if([self.nombreParticipante.text isEqualToString:@""]) {
		UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"El nombre no puede estar vacío" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
		[myAlertView show];
		[myAlertView release];
	}
	else {
		NSInteger rowL;
		NSInteger rowV;
		
		rowL = [resLocal selectedRowInComponent:0];
		rowV = [resVisitante selectedRowInComponent:0];
		
		NSString *res = [NSString stringWithFormat:@"%@-%@",[arrayMarcador objectAtIndex:rowL],[arrayMarcador objectAtIndex:rowV]];
		
		if(self.personaEditada != nil) {
			self.personaEditada.nombre = self.nombreParticipante.text;
			self.personaEditada.resultado = res;
		}
		else{
			[self.delegate saveParticipanteNombre:self.nombreParticipante.text Resultado:res];
		}
		
		[self.delegate ModalDidEnd:self];
	}
	
}

-(IBAction) eliminarParticipante {
	[self.delegate eliminarParticipante:personaEditada];
	[self.delegate ModalDidEnd:self];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES; 
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
	[arrayMarcador release];
	[nombreParticipante release];
	[resLocal release];
	[resVisitante release];
	[equipoLocal release];
	[equipoVisitante release];
	[personaEditada release];
	[btnEliminar release];

    [super dealloc];
}


@end
