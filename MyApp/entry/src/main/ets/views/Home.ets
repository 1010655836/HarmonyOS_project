import MainViewModel from '../viewmodel/MainViewModel';
import ItemData from '../viewmodel/ItemData';
import ListInfo from '../viewmodel/ResponseData/ListInfo';
import { common } from '@kit.AbilityKit';
import { HttpUtils } from '../common/network/HttpUtils';

@Preview
@Component
export default struct Home {
  @State httpGridItems: Array<ListInfo> = [];
  @State pictureUri: string = '';
  private swiperController: SwiperController = new SwiperController();
  private context = getContext(this) as common.UIAbilityContext;
  private applicationContext = this.context.getApplicationContext()
  private cacheDir = this.applicationContext.filesDir;

  async aboutToAppear(): Promise<void> {
    let httpUtil: HttpUtils = new HttpUtils();
    const list: Array<ListInfo> = await httpUtil.postHttpRequest();
    this.httpGridItems = list;
    httpUtil.getHttpRequest(this.cacheDir).then((value: string) => {
      this.pictureUri = value;
    });
    httpUtil.destroyHttpRequest();
  }

  build() {
    Column() {
      Text('首页')
        .width('100%')
        .margin({
          top: '48vp',
          bottom: '12vp'
        })
        .fontWeight(700)
        .fontSize('26fp')
      Swiper(this.swiperController) {
        ForEach(MainViewModel.getSwiperImages(), (item: Resource) => {
          Image(item)
            .width('100%')
            .borderRadius('16vp')
        }, (img: Resource) => JSON.stringify(img))
      }
      .autoPlay(true)

      Grid() {
        ForEach(MainViewModel.getFirstGridData(), (item: ItemData) => {
          GridItem() {
            Column() {
              Image(item.img)
                .width('40vp')
                .height('40vp')
              Text(item.title)
                .fontSize('12fp')
                .margin({ top: '4vp' })
            }
          }
        }, (item: ItemData) => JSON.stringify(item))
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap('8vp')
      .rowsGap('12vp')
      .backgroundImage($r('app.media.backgroundImage'))
      .backgroundImageSize({
        width: '100%',
        height: '156vp'
      })
      .margin({ top: '12vp' })
      .padding({
        top: '12vp',
        bottom: '12vp'
      })
      .height('156vp')
      .backgroundColor(Color.White)
      .borderRadius('16fp')

      Text('列表')
        .fontSize('18fp')
        .fontWeight(700)
        .width('100%')
        .margin({
          top: '18vp',
          bottom: '8vp'
        })
      List() {
        ForEach(this.httpGridItems, (item: ListInfo) => {
          ListItem() {
            Row() {
              Image(item.indexNavPic)
                .width('130vp')
                .height('80vp')
                .objectFit(ImageFit.TOP_START)
                .borderRadius('8vp')
                .margin({ right: '12vp' })
              Column() {
                Text(item.activityName)
                  .width('190vp')
                  .textOverflow({overflow: TextOverflow.Ellipsis})
                  .maxLines(1)
                  .fontSize('16fp')
                  .fontColor('#99182431')
                  .fontWeight(FontWeight.Medium)
                Text(item.theme)
                  .width('190vp')
                  .textOverflow({overflow: TextOverflow.Ellipsis})
                  .maxLines(2)
                  .margin({top:'4vp'})
                  .fontSize('12fp')
                  .fontColor('#99182431')
                Row(){
                  Image(this.pictureUri)
                    .width('20vp')
                    .opacity(0.5)
                }
                .width('170vp')
                .margin({top:'10.5vp'})
                .justifyContent(FlexAlign.End)
                .alignItems(VerticalAlign.Bottom)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({
              left: '12vp',
              right: '12vp',
              top: '12vp',
              bottom: '12vp'
            })
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .margin({ bottom: '8vp' })
          .borderRadius('16vp')
          .backgroundColor('#ffffff')
          .borderRadius('4vp')
          .align(Alignment.TopStart)
          .width('100%')
        }, (item: ListInfo) => JSON.stringify(item))
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .padding('12vp')
  }
}