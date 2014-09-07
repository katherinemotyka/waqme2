


#import <UIKit/UIKit.h>
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CustomTabBarController : UITabBarController
{
    
}
@end

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate>

{
    UIView *loadView;
    UIView *viewBack;
    UIActivityIndicatorView *spinningWheel;
    UILabel *lblLoading;
    NSString *strAuthTokan;
    
    float userLongitude;
    float userLatitude;
    CLLocation *location ;
    CLLocationManager *locationManager ;
    NSMutableDictionary *dictUserInfo;
    CustomTabBarController *tabBarController;
  UIImageView *imgTab ,*imghome ,*imgQuiz;
    ViewController *viewControler;
    UINavigationController *navCnt;
}
@property (nonatomic,retain) CustomTabBarController *tabBarController;
@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSString *strAuthTokan;
@property(strong, nonatomic) CLLocation *location ;
@property(strong, nonatomic) CLLocationManager *locationManager ;
@property (nonatomic) float userLongitude;
@property (nonatomic) float userLatitude;
@property (strong, nonatomic) FBSession *session;
@property (nonatomic,retain)  NSMutableDictionary *dictUserInfo;
@property (nonatomic,retain)  UINavigationController *navCnt;

-(void)tabBarControllerView;
+(AppDelegate *)sharedDalegate;
-(void)showAlert:(NSString *)title message:(NSString *)msg;
-(void) showLoadingViewWithTitle:(NSString*)strTitle;
-(void) hideLoadingView;
-(NSString *) applicationCacheDirectory;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

@end
