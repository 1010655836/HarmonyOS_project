import { Font } from '@ohos.arkui.UIContext'
import { promptAction } from '@kit.ArkUI';

@Extend(TextInput)
function inputStype(){
  .placeholderColor('#99182431')
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('100%')
  .margin({top: 12})
}

@Extend(Line)
function lineStyle(){
  .width('100%')
  .height('1vp')
  .backgroundColor('#33182431')
}

@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}

@Entry
@Component
struct LoginPage {

  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  pathStack: NavPathStack = new NavPathStack();

  @Builder
  imageButton(src:Resource) {
    Button({type: ButtonType.Circle, stateEffect: true}){
      Image(src)
    }
    .height('48vp')
    .width('48vp')
    .backgroundColor('#F1F3F5')
  }

  login(result:boolean):void {
    if (!this.account || !this.password) {
      promptAction.showToast({
        message: '账号密码不能为空！'
      })
    } else {
      this.isShowProgress = true;
      if (this.timeOutId === -1) {
        this.timeOutId = setTimeout(() => {
          this.isShowProgress = false;
          this.timeOutId = -1;
          this.pathStack.pushPathByName('MainPage', null);
        }, 2000);
      }
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Navigation(this.pathStack) {
      Column() {
        Image($r('app.media.logo'))
          .width('78vp')
          .height('78vp')
          .margin({ top: '150vp', bottom: '8vp' })
        Text('登录界面')
          .fontWeight(FontWeight.Medium)
          .fontSize('24fp')
          .fontColor('#182431')
        Text('登录账号获取更多服务')
          .fontSize('16fp')
          .fontColor('#99182431')
          .margin({ bottom: '30vp', top: '8vp' })
        TextInput({ placeholder: '请输入账号' })
          .type(InputType.Number)
          .maxLength(11)
          .inputStype()
          .onChange((value:string)=> {
            this.account = value;
          })
        Line()
          .lineStyle()
        TextInput({ placeholder: '请输入密码' })
          .type(InputType.Password)
          .maxLength(8)
          .inputStype()
          .onChange((value:string)=> {
            this.password = value;
          })
        Line()
          .lineStyle()
        Row() {
          Text('短信验证码登录')
            .blueTextStyle()
          Text('忘记密码')
            .blueTextStyle()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: '8vp' })

        Button('登录')
          .width('90%')
          .height('40vp')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#007DFF')
          .margin({ top: '48vp', bottom: '12vp' })
          .onClick(()=> {
            this.login(true);
          })
        Text('注册账号')
          .fontColor('#007DFF')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
        if (this.isShowProgress) {
          LoadingProgress()
            .color('#182431')
            .width('30vp')
            .height('30vp')
            .margin({ top: '20vp' })
        }
        Text('其他登录方式')
          .fontColor('#838D97')
          .fontSize('12fp')
          .fontWeight(FontWeight.Medium)
          .margin({ top: '50vp', bottom: '12vp' })
        Row({ space: 44 }) {
          this.imageButton($r('app.media.login_method1'))
          this.imageButton($r('app.media.login_method2'))
          this.imageButton($r('app.media.login_method3'))
        }
        .margin({ bottom: '16vp' })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#f1f3f5')
      .padding({
        left: '12vp',
        right: '12vp',
        bottom: '24vp'
      })
    }
    .backgroundColor('#F1F3F5')
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}