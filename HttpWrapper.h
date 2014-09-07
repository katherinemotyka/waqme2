


@class ASIFormDataRequest;

@protocol HttpWrapperDelegate

@optional
- (void) fetchDataSuccess:(NSString *)response;
- (void) fetchDataFail:(NSError *)error;
- (void) fetchImageSuccess:(NSString *)response;
- (void) fetchImageFail:(NSError *)error;

@end


@interface HttpWrapper : NSObject {
    NSObject<HttpWrapperDelegate> __unsafe_unretained *delegate;
    
    //BOOL isImage;
    
    SEL fetchSuccess;
	SEL fetchFail;
}

@property SEL fetchSuccess;
@property SEL fetchFail;

@property (nonatomic, assign) NSObject<HttpWrapperDelegate> *delegate;

-(id)initWithDelegate:(id)del;

-(void) requestWithMethod:(NSString*)method url:(NSString*)strUrl param:(NSMutableDictionary*)dictParam selSuc:(SEL)forSuc selFail:(SEL)forFail;
-(void) requestWithImageUrl:(NSString*)strUrl;

-(void) requestWithImageUrl:(NSString*)strUrl toFolder:(NSString*)folderName venueName:(NSString*)vn;

@end
