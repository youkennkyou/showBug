这是一个mac应用，用于快速定位从友盟导出的错误日志出行的问题行。
例如如下

文件路径：
/ Users / xxx / Library / Developer / Xcode / Archives / 2019-11-08 / xxx 2019-11-8，10.55 PM.xcarchive / dSYMs / xxx.app.dSYM / Contents / Resources / DWARF / xxx
文件路径可以使用finder打开文件所在目录，之后将固定目录文件拖入文件路径选择框。

错误日志文本：
[&lt;TripListCell 0x104062a00&gt; valueForUndefinedKey:]: this class is not key value coding-compliant for the key _swipeToDeleteConfirmationView.
(null)
((
	0   CoreFoundation                      0x00000001a86cfac4 046F17DF-03A8-3D03-99F5-BD4CFF8123C4 + 1256132
	1   libobjc.A.dylib                     0x00000001a83e9028 objc_exception_throw + 60
	2   CoreFoundation                      0x00000001a85ceb20 046F17DF-03A8-3D03-99F5-BD4CFF8123C4 + 203552
	3   Foundation                          0x00000001a8a19274 D2B43A39-F0D5-30D3-9776-956A0F143802 + 619124
	4   Foundation                          0x00000001a8a75af0 _NSGetUsingKeyValueGetter + 128
	5   Foundation                          0x00000001a898d460 D2B43A39-F0D5-30D3-9776-956A0F143802 + 46176
	6   xxx                               0x00000001029a98fc xxx + 1530108
	7   libdispatch.dylib                   0x00000001a8375fd8 D174E751-B542-3A69-A593-7AA69CF30F23 + 12248
	8   libdispatch.dylib                   0x00000001a8378758 D174E751-B542-3A69-A593-7AA69CF30F23 + 22360
	9   libdispatch.dylib                   0x00000001a8388f18 D174E751-B542-3A69-A593-7AA69CF30F23 + 89880
	10  libdispatch.dylib                   0x00000001a83888c4 D174E751-B542-3A69-A593-7AA69CF30F23 + 88260
	11  libdispatch.dylib                   0x00000001a8381bb8 _dispatch_main_queue_callback_4CF + 696
	12  CoreFoundation                      0x00000001a864ae0c 046F17DF-03A8-3D03-99F5-BD4CFF8123C4 + 712204
	13  CoreFoundation                      0x00000001a8645b68 046F17DF-03A8-3D03-99F5-BD4CFF8123C4 + 691048
	14  CoreFoundation                      0x00000001a8645084 CFRunLoopRunSpecific + 480
	15  GraphicsServices                    0x00000001b2893534 GSEventRunModal + 108
	16  UIKitCore                           0x00000001ac7b5698 UIApplicationMain + 1940
	17  xxx                               0x0000000102a9a42c xxx + 2516012
	18  libdyld.dylib                       0x00000001a84c4e18 2DE87B30-2CB1-30C2-9C0E-4BB9022D71E8 + 3608
)

dSYM UUID: EDB61A9F-78AD-3861-A17A-261C9000D023
CPU Type: arm64
Slide Address: 0x0000000100000000
Binary Image: xxx
Base Address: 0x0000000102834000

运行结果如下：
  __56-[UITableViewCell(JZExtension) __willTransitionToState:]_block_invoke (in ) (UITableViewCell+JZExtension.m:0)
main (in xxx) (main.m:14)

