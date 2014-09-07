

#import "AppDelegate.h"
#import "ViewController.h"
#import "LocationView.h"
#import "SettingView.h"
#import "ProfileView.h"
#import "ViewController.h"

#define ipadFrame CGRectMake(0, 0, 768, 1024)
#define iphoneFrame CGRectMake(0, 0, 320, 480)
#define iphoneSize CGSizeMake(320, 480)
#define loadiPhone CGRectMake(95, 230, 130, 40)
#define loadiPad CGRectMake(319, 502, 130, 40)

@implementation AppDelegate
@synthesize location,locationManager,userLatitude,userLongitude,strAuthTokan;
@synthesize dictUserInfo,tabBarController,navCnt;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    viewControler = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"]; //or the homeController
    
    navCnt = [[UINavigationController alloc]initWithRootViewController:viewControler];
    self.window.rootViewController=navCnt;
    self.navCnt.navigationBarHidden = TRUE;
    [self.window makeKeyAndVisible];
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];

    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"basic_info",@"email"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
        
        // If there's no cached session, we will show a login button
    }

    return YES;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.userLatitude = newLocation.coordinate.latitude;
    self.userLongitude = newLocation.coordinate.longitude;
}

- (void)startStandardUpdates
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    locationManager.distanceFilter = 200;
    
    [locationManager startUpdatingLocation];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

-(void)tabBarControllerView
{
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ProfileView *fistView = [storyboard instantiateViewControllerWithIdentifier:@"ProfileView"];
  //  fistView.tabBarItem.image = [UIImage imageNamed:@"tab1.png"];
    fistView.title = @"Search";
    
    LocationView *secondView = [storyboard instantiateViewControllerWithIdentifier:@"LocationView"];
 //   secondView.tabBarItem.image = [UIImage imageNamed:@"tab2.png"];
    secondView.title = @"Coupons";
    
    SettingView *thirdView = [storyboard instantiateViewControllerWithIdentifier:@"SettingView"];
  //  thirdView.tabBarItem.image = [UIImage imageNamed:@"tab3.png"];
    thirdView.title = @"My List";
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:fistView, secondView,thirdView, nil];
    
    UINavigationController *objnavifirst=[[UINavigationController alloc] initWithRootViewController:fistView];
    UINavigationController *objnavisecond=[[UINavigationController alloc] initWithRootViewController:secondView];
    UINavigationController *objnavithird=[[UINavigationController alloc] initWithRootViewController:thirdView];
    
    NSMutableArray *MainNavArray =[[NSMutableArray alloc] init];
    objnavifirst.navigationBarHidden=YES;
    objnavisecond.navigationBarHidden=YES;
    objnavithird.navigationBarHidden=YES;
    
    [MainNavArray  addObject:objnavifirst];
    [MainNavArray  addObject:objnavisecond];
    [MainNavArray  addObject:objnavithird];
    
    tabBarController.viewControllers =MainNavArray;
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    imgTab = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320.0,50)];
    tabBarController.tabBar.tag=10;
    imgTab.image=[UIImage imageNamed:@"tabBg.png"];
    [tabBarController.tabBar addSubview:imgTab];
    
    imgQuiz=[[UIImageView alloc]initWithFrame:CGRectMake(80.0,5.0,33.0,33.0)];
    imgQuiz.image=[UIImage imageNamed:@"tab1.png"];
    [imgTab addSubview:imgQuiz];
    
    imghome=[[UIImageView alloc]initWithFrame:CGRectMake(150.0,4.0,33.0,33.0)];
    imghome.image=[UIImage imageNamed:@"tab2.png"];
    [imgTab addSubview:imghome];
    
    imgQuiz=[[UIImageView alloc]initWithFrame:CGRectMake(220.0,5.0,33.0,33.0)];
    imgQuiz.image=[UIImage imageNamed:@"tab3.png"];
    [imgTab addSubview:imgQuiz];
    
    tabBarController.view.hidden = NO;
    tabBarController.selectedIndex = 1;
}


// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (! error) {
                 
                [self tabBarControllerView];
                 NSLog(@"User details =%@",user);
             }
         }];
        
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
     }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
             }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
    }
}


+(AppDelegate *)sharedDalegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)showAlert:(NSString *)title message:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

-(NSString *) applicationCacheDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0]:nil;
	return basePath;
}

#pragma Loading View
-(void) showLoadingViewWithTitle:(NSString*)strTitle {
	
    if (loadView == nil) {
        if (IS_IPHONE_5) {
         	loadView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 568.0)];
        }else{
            loadView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        }
        
        loadView.opaque = NO;
        loadView.backgroundColor = [UIColor clearColor];
        //loadView.alpha = 0.8;
		
        viewBack = [[UIView alloc] initWithFrame:CGRectMake(95, 230, 130, 40)];
        viewBack.backgroundColor = [UIColor blackColor];
        viewBack.alpha = 0.7f;
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.cornerRadius = 8;
        
        spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5.0, 5.0, 30.0, 30.0)];
        [spinningWheel startAnimating];
        [viewBack addSubview:spinningWheel];
        
        lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(23, 6, 110, 25)];
        lblLoading.backgroundColor = [UIColor clearColor];
        lblLoading.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        lblLoading.textAlignment = NSTextAlignmentCenter;
        lblLoading.text = [strTitle isEqualToString:@""] ? @"Loading...":strTitle;
        lblLoading.textColor = [UIColor whiteColor];
        [viewBack addSubview:lblLoading];
        [loadView addSubview:viewBack];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            loadView.frame = iphoneFrame;
            viewBack.frame = loadiPhone;
        }
        else
        {
            loadView.frame = ipadFrame;
            viewBack.frame = loadiPad;
        }
    }
    if(loadView.superview == nil)
        [self.window addSubview:loadView];
}

-(void) hideLoadingView {
	[loadView removeFromSuperview];
    loadView=nil;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
      [FBAppCall handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
