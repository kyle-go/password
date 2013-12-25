
#import <UIKit/UIKit.h>

@interface KVoiceHUD : UIView

@property (nonatomic, strong) NSString *recordFilePath;
@property (nonatomic, assign) CGFloat recordTime;

- (id)initWithParentView:(UIView *)view;
- (void)startRecording;
- (void)endRecording;

@end

