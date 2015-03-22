//
//  RootViewController.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "RootViewController.h"
#import "GameViewController.h"
#import "Player.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *players;
@property GameViewController *gameViewController;
@property (weak, nonatomic) IBOutlet UITextField *addNewPlayerTextField;

@end

@implementation RootViewController

#pragma mark -UIView Life Cycles

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadInitialsPlayers];

    // only enabled if a player is selected
    self.navigationItem.rightBarButtonItem.enabled = false;

    [self.addNewPlayerTextField setDelegate:self];

}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem.enabled = false;
}

#pragma mark -UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = [self.players objectAtIndex:indexPath.row];

    cell.textLabel.text = player.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld points", (long)player.score];
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

#pragma mark -UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.rightBarButtonItem.enabled = true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Player *player = [self.players objectAtIndex:indexPath.row];
        [self.players removeObjectAtIndex:indexPath.row];
        player = nil;
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.navigationItem.rightBarButtonItem.enabled = false;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark -TextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (![self.addNewPlayerTextField.text isEqualToString:@""])
    {
        Player *newPlayer = [[Player alloc] init];
        newPlayer.name = self.addNewPlayerTextField.text;
        newPlayer.score = 0;

        // also add it to the array
        [self.players addObject:newPlayer];
        [self.addNewPlayerTextField resignFirstResponder];
        self.addNewPlayerTextField.text = @"";

        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = false;
        [textField resignFirstResponder];
    }

    return YES;
}

#pragma mark -Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowGameSegue"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        Player *player = [self.players objectAtIndex:index.row];
        self.gameViewController = segue.destinationViewController;
        self.gameViewController.player = player;
    }
}

#pragma mark -Helper Methods

-(void)loadInitialsPlayers
{
    self.players = [NSMutableArray new];

    [self.players addObject:[[Player alloc] initWithName:@"Leandro Pessini" AndScore:0]];
    [self.players addObject:[[Player alloc] initWithName:@"Matt Larkin" AndScore:0]];
    [self.players addObject:[[Player alloc] initWithName:@"Sherrie Jones" AndScore:0]];
    [self.players addObject:[[Player alloc] initWithName:@"Gabe Morales" AndScore:0]];
    [self.players addObject:[[Player alloc] initWithName:@"Joanna Dickerson" AndScore:0]];
}

@end
